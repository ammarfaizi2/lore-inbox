Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285030AbRLKNmo>; Tue, 11 Dec 2001 08:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285045AbRLKNmf>; Tue, 11 Dec 2001 08:42:35 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:24897 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S285031AbRLKNmV>; Tue, 11 Dec 2001 08:42:21 -0500
Date: Tue, 11 Dec 2001 14:42:23 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
Message-ID: <20011211144223.E4801@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0112101705281.25362-100000@freak.distro.conectiva> <3C151F7B.44125B1@zip.com.au>, <3C151F7B.44125B1@zip.com.au>; <20011211011158.A4801@athlon.random> <3C15B0B3.1399043B@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C15B0B3.1399043B@zip.com.au>; from akpm@zip.com.au on Mon, Dec 10, 2001 at 11:07:31PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2001 at 11:07:31PM -0800, Andrew Morton wrote:
> Why does this code exist at the end of refill_inactive()?
> 
>         if (entry != &active_list) {
>                 list_del(&active_list);
>                 list_add(&active_list, entry);
>         }

so that we restart next time at the point where we stopped browsing the
active list.

> This test on a 64 megabyte machine, on ext2:
> 
> 	time (tar xfz /nfsserver/linux-2.4.16.tar.gz ; sync)
> 
> On 2.4.17-pre7 it takes 21 seconds.  On -aa it is much slower: 36 seconds.
> 
> This is probably due to the write scheduling changes in fs/buffer.c.

yes, I also lowered the percentage of dirty memory in the system by
default, so that a write flood should less probably stall the system.

Plus I made the elevator more latency oriented, rather than throughput
oriented. Did you also tested how much the system was responsive during
the test?

Do you remeber the thread about a 'tar xzf' hanging the machine? It
doesn't hang with -aa, but of course you'll run slower if it has to do
seeks.

> This chunk especially will, under some conditions, cause bdflush
> to madly spin in a loop unplugging all the disk queues:
> 
> @@ -2787,7 +2795,7 @@
>  
>                 spin_lock(&lru_list_lock);
>                 if (!write_some_buffers(NODEV) || balance_dirty_state() < 0) {
> -                       wait_for_some_buffers(NODEV);
> +                       run_task_queue(&tq_disk);
>                         interruptible_sleep_on(&bdflush_wait);
>                 }
>         }
> 
> Why did you make this change?

to make bdflush to less badly spin in a loop unplugging all the disk
queues.

We need to unplug only once, to submit the I/O, but we don't need to
wait on every single buffer that we previously wrote. Note that
run_task_queue() has nothing to do with wait_on_buffer, the above should
be much better in terms of "spinning in a loop unplugging all the disk
queues". It will do it only once at least.

Infact all the wait_for_some_buffers are broken (particularly the one in
balance_dirty()), they're not necessary, they can only slowdown the
machine.

The only reason would be to refile the buffers into the clean list, but
nothing else. That's a total waste of I/O pipelining. And yes, that's
something to fix too.

> Execution time for `make -j12 bzImage' on a 64meg RAM/512 meg swap
> dual x86:
> 
> -aa:					4 minutes 20 seconds
> 2.4.7-pre8				4 minutes 8 seconds
> 2.4.7-pre8 plus the below patch:	3 minutes 55 seconds
> 
> Now it could be that this performance regression is due to the
> write merging mistake in fs/buffer.c.  But with so much unrelated
> material in the same patch it's hard to pinpoint the source.
> 
> 
> 
> --- linux-2.4.17-pre8/mm/vmscan.c	Thu Nov 22 23:02:59 2001
> +++ linux-akpm/mm/vmscan.c	Mon Dec 10 22:34:18 2001
> @@ -537,7 +537,7 @@ static void refill_inactive(int nr_pages
>  
>  	spin_lock(&pagemap_lru_lock);
>  	entry = active_list.prev;
> -	while (nr_pages-- && entry != &active_list) {
> +	while (nr_pages && entry != &active_list) {
>  		struct page * page;
>  
>  		page = list_entry(entry, struct page, lru);
> @@ -551,6 +551,7 @@ static void refill_inactive(int nr_pages
>  		del_page_from_active_list(page);
>  		add_page_to_inactive_list(page);
>  		SetPageReferenced(page);
> +		nr_pages--;
>  	}
>  	spin_unlock(&pagemap_lru_lock);
>  }
> @@ -561,6 +562,12 @@ static int shrink_caches(zone_t * classz
>  	int chunk_size = nr_pages;
>  	unsigned long ratio;
>  
> +	shrink_dcache_memory(priority, gfp_mask);
> +	shrink_icache_memory(priority, gfp_mask);
> +#ifdef CONFIG_QUOTA
> +	shrink_dqcache_memory(DEF_PRIORITY, gfp_mask);
> +#endif
> +
>  	nr_pages -= kmem_cache_reap(gfp_mask);
>  	if (nr_pages <= 0)
>  		return 0;
> @@ -568,17 +575,13 @@ static int shrink_caches(zone_t * classz
>  	nr_pages = chunk_size;
>  	/* try to keep the active list 2/3 of the size of the cache */
>  	ratio = (unsigned long) nr_pages * nr_active_pages / ((nr_inactive_pages + 1) * 2);
> +	if (ratio == 0)
> +		ratio = nr_pages;
>  	refill_inactive(ratio);
>  
>  	nr_pages = shrink_cache(nr_pages, classzone, gfp_mask, priority);
>  	if (nr_pages <= 0)
>  		return 0;
> -
> -	shrink_dcache_memory(priority, gfp_mask);
> -	shrink_icache_memory(priority, gfp_mask);
> -#ifdef CONFIG_QUOTA
> -	shrink_dqcache_memory(DEF_PRIORITY, gfp_mask);
> -#endif
>  
>  	return nr_pages;
>  }

it should be simple, mainline swapouts more, so it's less likely to
trash away some useful cache.

just try -aa after a:

	echo 10 >/proc/sys/vm/vm_mapped_ratio

it should swapout more and better preserve the cache.

> > > In my swapless testing, I burnt HUGE amounts of CPU in flush_tlb_others().
> > > So we're madly trying to swap pages out and finding that there's no swap
> > > space.  I beleive that when we find there's no swap left we should move
> > > the page onto the active list so we don't keep rescanning it pointlessly.
> > 
> > yes, however I think the swap-flood with no swap isn't a very
> > interesting case to optimize.
> 
> Running swapless is a valid configuration, and the kernel is doing

I'm not saying it's not valid or non interesting.

It's the mix "I'm running out of memory and I'm swapless" that is the
case not interesting to optimize.

If you're swapless it means you've enough memory and that you're not
running out of swap. Otherwise _you_ (not the kernel) are wrong not
having swap.

> great amounts of pointless work.  I would expect a diskless workstation
> to suffer from this.  The problem remains in latest -aa.  It would be
> useful to find a fix.

It can be optimized by making the other cases slower. I believe if
swap_out is recalled heavily in a swapless configuration either some
other part of the kernel or the user are wrong, not swap_out. So it's at
least not obvious to me that it would be useful to fix it inside
swap_out.

> > I don't have any pending bug report. AFIK those bugs are only in
> > mainline. If you can reproduce with -aa please send me a bug report.
> > thanks,
> 
> Bugs which are only fixed in -aa aren't much use to anyone.

Then there are no other bugs, that's fine, this is why I said I'm
finished (except for the minor performance work, like the buffer
flushing in buffer.c that certainly cannot affect stability, or the
swap-triggering etc.. all minor things that doesn't affect stability and
where there's not the perfect solution anyways).

> The VM code lacks comments, and nobody except yourself understands
> what it is supposed to be doing.  That's a bug, don't you think?

Lack of documentation is not a bug, period. Also it's not true that I'm
the only one who understands it. For istance Linus understand it
completly, I am 100% sure.

Anyways I wrote a dozen of slides on the VM with some graph showing the
design of the VM if anybody can better learn from a slide than from the
code.

I believe the slides are useful to understand the design, but if you
want to change one line of code slides or not you've to read the code.
Everybody is complaining about documentation. This is a red-herring.
There's no documentation that allows you to hack the previous VM code.
I'd ask how many of the people happy with the previous documentation
were effectively VM developers. Except for some possible misleading
comment in the current code that we may have not updated yet, I don't
think there's been a regression in documentation.

Andrea
