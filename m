Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316878AbSHONJH>; Thu, 15 Aug 2002 09:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316886AbSHONJH>; Thu, 15 Aug 2002 09:09:07 -0400
Received: from mail1.centrum.cz ([195.47.108.141]:28050 "EHLO mail1.centrum.cz")
	by vger.kernel.org with ESMTP id <S316878AbSHONJF>;
	Thu, 15 Aug 2002 09:09:05 -0400
Date: Thu, 15 Aug 2002 15:12:36 +0200
From: <miho@centrum.cz>
To: <linux-kernel@vger.kernel.org>
X-Mailer: Centrum Mail 1.0
MIME-Version: 1.0
X-Priority: 3
Subject: Slab pool should by added to "Buffers"
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
Message-Id: <20020815131248Z684126-5457+128@mail.centrum.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Slab pool will be reclaimed when the system needs it so I think 
that reporting this memory as "Used" without adding it 
to "Buffers" in /proc/meminfo could lead to a confusion and 
memory leak reports (After 'locate -u -c', 'free' says that i 
have 200MB free memory less than before...). I tested our server 
under various workloads and I needed to know exact ammount of 
free physical memory to fine-tune some programs but I found
no program that uses information from both meminfo and slabinfo. 
So I created a tiny utility 'rfree'
http://sourceforge.net/projects/rfree/
(output looks like 'free' but i replaced unused "Shared" 
with "Slab").

This solved the problem (partly), but then I had to use vmstat 
and it "pops up" again. I think better place to solve this is 
kernel so that all programs that use meminfo will show correct 
information without reprogramming.
I've tried that:

Add to mm/slab.c :

int slab_size(void)
{
 kmem_cache_t *cachep;
 struct list_head *q;
 struct list_head *p;
 slab_t  *slabp;
 unsigned long num_slabs=0;

 down(&cache_chain_sem);
 list_for_each(p,&cache_chain) {
  cachep = list_entry(p, kmem_cache_t, next);

  spin_lock_irq(&cachep->spinlock);
  list_for_each(q,&cachep->slabs_full) {
   slabp = list_entry(q, slab_t, list);  //
   if (slabp->inuse != cachep->num)      //remove?
    BUG();                               //
   num_slabs++;
  }
  list_for_each(q,&cachep->slabs_partial) {
   slabp = list_entry(q, slab_t, list);              //
   if (slabp->inuse == cachep->num || !slabp->inuse) //remove?
    BUG();                                           //
   num_slabs++;
  }
  list_for_each(q,&cachep->slabs_free) {
   slabp = list_entry(q, slab_t, list);  //
   if (slabp->inuse)                     //remove?
    BUG();                               //
   num_slabs++;
  }
  spin_unlock_irq(&cachep->spinlock);
 }
 up(&cache_chain_sem);

 return num_slabs;
}

Add to include/linux/slab.h :

extern int slab_size(void);


Replace in fs/proc/proc_misc.c :

static int meminfo_read_proc(char *page, char **start, off_t off,
     int count, int *eof, void *data)
{
 struct sysinfo i;
 int len;
 int pg_size ;
 int committed;
 int slab;

 /* FIXME: needs to be in headers */
 extern atomic_t vm_committed_space;

/*
 * display in kilobytes.
 */
#define K(x) ((x) << (PAGE_SHIFT - 10))
#define B(x) ((unsigned long long)(x) << PAGE_SHIFT)
 si_meminfo(&i);
 si_swapinfo(&i);
 slab=slab_size();

 pg_size = atomic_read(&page_cache_size) - i.bufferram ;
 committed = atomic_read(&vm_committed_space);

 len = sprintf(page, "        total:    used:    free:  shared: 
buffers:
cached:\n"
  "Mem:  %8Lu %8Lu %8Lu %8Lu %8Lu %8Lu\n"
  "Swap: %8Lu %8Lu %8Lu\n",
  B(i.totalram), B(i.totalram-i.freeram), B(i.freeram),
  B(i.sharedram), B(i.bufferram+slab),
  B(pg_size), B(i.totalswap),
  B(i.totalswap-i.freeswap), B(i.freeswap));
 /*
  * Tagged format, for easy grepping and expansion.
  * The above will go away eventually, once the tools
  * have been updated.
  */
 len += sprintf(page+len,
  "MemTotal:     %8lu kB\n"
  "MemFree:      %8lu kB\n"
  "MemShared:    %8lu kB\n"
  "Buffers:      %8lu kB\n"
  "Cached:       %8lu kB\n"
  "SwapCached:   %8lu kB\n"
  "Active:       %8u kB\n"
  "Inact_dirty:  %8u kB\n"
  "Inact_clean:  %8u kB\n"
  "Inact_target: %8u kB\n"
  "HighTotal:    %8lu kB\n"
  "HighFree:     %8lu kB\n"
  "LowTotal:     %8lu kB\n"
  "LowFree:      %8lu kB\n"
  "SwapTotal:    %8lu kB\n"
  "SwapFree:     %8lu kB\n"
  "Committed_AS: %8u kB\n"
  "SlabPool:     %8u kB\n",
  K(i.totalram),
  K(i.freeram),
  K(i.sharedram),
  K(i.bufferram+slab),
  K(pg_size - swapper_space.nrpages),
  K(swapper_space.nrpages),
  K(nr_active_pages),
  K(nr_inactive_dirty_pages),
  K(nr_inactive_clean_pages),
  K(inactive_target()),
  K(i.totalhigh),
  K(i.freehigh),
  K(i.totalram-i.totalhigh),
  K(i.freeram-i.freehigh),
  K(i.totalswap),
  K(i.freeswap),
  K(committed),
  K(slab));

 return proc_calc_metrics(page, start, off, count, eof, len);
#undef B
#undef K
}


It works well for me but I am a newbie so I would like to know if 
it is correct (SMP-safe and so on) and wethear there will be any 
program in "userland" broken (except rfree of course ;-) after 
that change.

I know that it is hard to compute exactly "ammount of free 
memory" in VM OS but IMHO "free+cache+buffers+slab" is better 
shot than just "free+cache+buffers". And I also know that adding 
Slab to Buffers isn't clean, but Slab actualy behawes very 
similar to Buffers in memory pressure situations and it won't
break tons of utilities applets and so on unlike adding an 
additional value to meminfo.

Regards
Michal



--------------------
®ena v centru pozornosti na http://zena.centrum.cz 



