Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266047AbTLIPZa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 10:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266048AbTLIPZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 10:25:30 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1152 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266047AbTLIPZ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 10:25:26 -0500
Date: Tue, 9 Dec 2003 10:25:02 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Stephen Satchell <list@satchell.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Swap performance statistics in 2.6 -- which /proc file has it?
In-Reply-To: <1070981185.6243.58.camel@ssatchell1.pyramid.net>
Message-ID: <Pine.LNX.4.53.0312091014250.525@chaos>
References: <BF1FE1855350A0479097B3A0D2A80EE00184D619@hdsmsx402.hd.intel.com>
  <1070911748.2408.39.camel@dhcppc4>  <3FD546D5.2000003@nishanet.com> 
 <1070975964.5966.5.camel@ssatchell1.pyramid.net>  <Pine.LNX.4.53.0312090854080.8425@chaos>
 <1070981185.6243.58.camel@ssatchell1.pyramid.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Dec 2003, Stephen Satchell wrote:

> On Tue, 2003-12-09 at 05:56, Richard B. Johnson wrote:
> > On Tue, 9 Dec 2003, Stephen Satchell wrote:
> >
> > > I also grepped the proc filesystem source (linux/fs/proc) for "swap" and
> > > "Swap" and didn't find anything that had to do with swap request accounting,
> > > only with swap memory allocation (which I do use, but which for me is only
> > > half the story).
>
> > /proc/meminfo may give you the information you need, just not
> > as directly as you propose.
>
> I appreciate your answer.  From the sprintf statement in
> fs/proc/proc_misc.c that builds the return for mem_info:
>
>                 K(i.totalram),
>                 K(i.freeram),
>                 K(i.bufferram),
>
> K(get_page_cache_size()-total_swapcache_pages-i.bufferram),
>                 K(total_swapcache_pages),
>                 K(active),
>                 K(inactive),
>                 K(i.totalhigh),
>                 K(i.freehigh),
>                 K(i.totalram-i.totalhigh),
>                 K(i.freeram-i.freehigh),
>                 K(i.totalswap),
>                 K(i.freeswap),
>                 K(ps.nr_dirty),
>                 K(ps.nr_writeback),
>                 K(ps.nr_mapped),
>                 K(ps.nr_slab),
>                 K(committed),
>                 K(ps.nr_page_table_pages),
>                 vmtot,
>                 vmi.used,
>                 vmi.largest_chunk
>
> Tracing around a bit, I find /mm/swapfile.c defines the routine void
> si_swapinfo(struct sysinfo *) which, in part, does this:
>
>         for (i = 0; i < nr_swapfiles; i++) {
>                 if (!(swap_info[i].flags & SWP_USED) ||
>                      (swap_info[i].flags & SWP_WRITEOK))
>                         continue;
>                 nr_to_be_unused += swap_info[i].inuse_pages;
>         }
>         val->freeswap = nr_swap_pages + nr_to_be_unused;
>         val->totalswap = total_swap_pages + nr_to_be_unused;
>
> So it collect allocation information, but doesn't collect any
> performance information (assuming that performance information is saved
> for each swap file in the swapfile list) to return to the meminfo
> handler, or to anyone else for that matter.
>
> Is there performance information to collect?  I'm beginning to think
> not, based on looking at include/linux/swap.h:
>
> struct swap_info_struct {
>         unsigned int flags;
>         spinlock_t sdev_lock;
>         struct file *swap_file;
>         struct block_device *bdev;
>         struct list_head extent_list;
>         int nr_extents;
>         struct swap_extent *curr_swap_extent;
>         unsigned old_block_size;
>         unsigned short * swap_map;
>         unsigned int lowest_bit;
>         unsigned int highest_bit;
>         unsigned int cluster_next;
>         unsigned int cluster_nr;
>         int prio;                       /* swap priority */
>         int pages;
>         unsigned long max;
>         unsigned long inuse_pages;
>         int next;                       /* next entry on swap list */
> };

>
> If I were performance-collecting code, where would I live?  Of course!
> In the routines that actually perform the input-output to the swap
> file(s).  So I went hunting again, and my feeble brain found some
> likely-looking code in mm/page_io.c that appears to start and wait for
> I/O operations involving swap. But where is the accounting in that
> code?  I don't see any.  Now, I did try to trace through some of the
> subroutines, but shuffling the accounting to routines that clearly had a
> different intent didn't make sense.
>
> How about higher level functions?  Well, I ran out of time in this
> sitting, as I have to get ready for work.
>
> I'm not trying to get on your case, Dick, for trying to provide an
> answer, and I do appreciate your response. It's just that I don't see
> how I can measure the amount of swap activity given the information
> available.  I can *guess*, but then the whole idea of performance
> *measurement* is to avoid guessing.
>
> Anyone:  what have I missed?
>
> Respectfully pondered,
> Stephen Satchell

If you need statistics v.s. time, you need to write an application
that samples things at some fixed interval. In a previous life,
I requested that "nr_free_pages()" be accessible from user-space,
probably via /proc. That's all you need. Maybe that could be
added now?  In any event, samping free pages at some fixed-time
interval should give you all the information you need.

FYI, the kernel doesn't usually perform any statistics. It
just provides snap-shots of what's happening at the instant
it's sampled. That way, CPU cycles are not wasted gathering
data that's never used. There are some "total" counters in
the network drivers, but that's about all the history that's
saved. If you want history, your application needs to do it.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


