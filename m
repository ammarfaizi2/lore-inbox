Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293509AbSBZElZ>; Mon, 25 Feb 2002 23:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293511AbSBZElP>; Mon, 25 Feb 2002 23:41:15 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:60861 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S293509AbSBZEky>; Mon, 25 Feb 2002 23:40:54 -0500
Date: Mon, 25 Feb 2002 22:40:50 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Aviv Shavit <avivshavit@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020225224050.D26077@asooo.flowerfire.com>
In-Reply-To: <20020225115143.2504.qmail@web13203.mail.yahoo.com> <20020225180934.B26077@asooo.flowerfire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020225180934.B26077@asooo.flowerfire.com>; from brownfld@irridia.com on Mon, Feb 25, 2002 at 06:09:34PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been playing with 2.4.18 with the following primary patches with
very good results:

	O(1)-K3
	Andrew Morton's low-latency and read-latency2
	Martin's vmscan patch

In the past, I've been applying low-latency without enabling the CONFIG
option, silly me.  Why haven't Andrew's low latency patches gone into
2.4 or 2.5?  Let's pretty please with sugar on top and a cherry get
those into 2.4.19 even if -aa doesn't make it -- it's making a world of
difference in the stuff I'm throwing at the kernel, and I'm thinking -aa
and -rmap are giving improvements partially because they incorporate
some of these changes.

I think adding 10_vm would put the finishing touch on bridging the gap until
2.5, IMHO.  O(1) would just be the proverbial icing on the cake at a later
stage, since there still seems to be some work left to do on it (per-CPU
stuff?).

Now if TUX2 would only stop going into 99% CPU mode. ;)
-- 
Ken.
brownfld@irridia.com

On Mon, Feb 25, 2002 at 06:09:34PM -0600, Ken Brownfield wrote:
| On Mon, Feb 25, 2002 at 03:51:43AM -0800, Aviv Shavit wrote:
| | Ken Brownfield's A) and B) hit me
| | regularly(http://www.uwsg.indiana.edu/hypermail/linux/kernel/0201.0/0740.html)
| | (Thanks Ken for starting this enlightening thread and
| | to all those that contributed)
| 
| No problem.  You might be coming in late, but nothing's changed. :-/
| Although the APIC thing might be MPS1.4 related, I'm finding.  I don't
| remember if that thread had my workaround to the APIC issue, so I'll
| attach that if you're feeling adventurous.  Works flawlessly for me in
| production, for the last few months.
| 
| | Running software I developed:
| | - running on 2.4.17
| | - accessing a large number of files
| | - 2GB memory
| | - large multiple partitions - ext2
| | 
| | I saw references to patches by Martin and
| | M.H.vanLeeuwen on this thread. Where can I get those
| | (hopefully with a bit of info) ?
| 
| I've attached his patch; hopefully he doesn't mind.  His patch is
| actually similar to code that's in rmap currently.
| 
| It does seem to temper the effects of [id]cache bloat for some of my
| more common load patterns.  But even with that patch, under VM load the
| mainline kernel collapses.  For instance, I have a large parallel task
| that takes 5 minutes under -rmap or -aa, but I get bored and kill it
| after 4 *hours* on mainline.  It dips into swap, but only by about 50MB.
| 
| Also, -aa doesn't seem to make as large an impact on shrinking the
| [id]caches.  I imagine that without returning values,
| shrink_[id]cache_memory() behavior is difficult to tune appropriately.
| 
| In any case, rmap-12f has been running fine for me.  I'm going to create
| three kernels to distribute in production -- 2.4.18 more or less
| vanilla, 2.4.18 with random debugging (thanks Andreas) to try to resolve
| the /dev/random death issue, and 2.4.18+O(1)K3+rmap12f.
| 
| rmap is a tremendous improvement over mainline -- really the only data I
| still need is stability, both of O(1) and rmap.  Porting Andrea's 10_vm
| was a pain the last time I did it, and it didn't have all of the
| positives of rmap.
| 
| Clearly I'm not in the majority, though.  While I get bitten on a weekly
| basis by the 2.4 VM, very few other people mention it.  Maybe they just
| assume that it's normal behavior?  Scary.
| 
| Anyway, short of the long is that I would suggest rmap if you're having
| problems.  Rmap actually obviates three other patches I typically apply.
| But be aware that rmap is still a bit of a work in progress, at least in
| terms of tuning.
| 
| Cheers,
| -- 
| Ken.
| brownfld@irridia.com
| 
| 
| | I also saw references to 'rmap' on the 2.4.18
| | changelog. Is that related ?
| | 
| | pls. cc' me on your posts back.
| | 
| | Thanks
| | Aviv
| | 
| | "And all this science I don't understand,
| |       It's just my job five days a week"
| | Rocket Man, E.J.
| 
| 
| --- linux.virgin/mm/vmscan.c	Mon Dec 31 12:46:25 2001
| +++ linux/mm/vmscan.c	Fri Jan 11 18:03:05 2002
| @@ -394,9 +394,9 @@
|  		if (PageDirty(page) && is_page_cache_freeable(page) && page->mapping) {
|  			/*
|  			 * It is not critical here to write it only if
| -			 * the page is unmapped beause any direct writer
| +			 * the page is unmapped because any direct writer
|  			 * like O_DIRECT would set the PG_dirty bitflag
| -			 * on the phisical page after having successfully
| +			 * on the physical page after having successfully
|  			 * pinned it and after the I/O to the page is finished,
|  			 * so the direct writes to the page cannot get lost.
|  			 */
| @@ -480,11 +480,14 @@
|  
|  			/*
|  			 * Alert! We've found too many mapped pages on the
| -			 * inactive list, so we start swapping out now!
| +			 * inactive list.
| +			 * Move referenced pages to the active list.
|  			 */
| -			spin_unlock(&pagemap_lru_lock);
| -			swap_out(priority, gfp_mask, classzone);
| -			return nr_pages;
| +			if (PageReferenced(page) && !PageLocked(page)) {
| +				del_page_from_inactive_list(page);
| +				add_page_to_active_list(page);
| +			}
| +			continue;
|  		}
|  
|  		/*
| @@ -521,6 +524,9 @@
|  	}
|  	spin_unlock(&pagemap_lru_lock);
|  
| +	if (max_mapped <= 0 && (nr_pages > 0 || priority < DEF_PRIORITY))
| +		swap_out(priority, gfp_mask, classzone);
| +
|  	return nr_pages;
|  }
|  
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
