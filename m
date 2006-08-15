Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965283AbWHOIGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965283AbWHOIGT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 04:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965286AbWHOIGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 04:06:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7874 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965283AbWHOIGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 04:06:17 -0400
Date: Tue, 15 Aug 2006 01:06:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow
 writeback.
Message-Id: <20060815010611.7dc08fb1.akpm@osdl.org>
In-Reply-To: <17633.2524.95912.960672@cse.unsw.edu.au>
References: <17633.2524.95912.960672@cse.unsw.edu.au>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 09:40:12 +1000
Neil Brown <neilb@suse.de> wrote:

> 
> I have a question about the write throttling in
> balance_dirty_pages in the face of slow writeback.

btw, we have problem in there at present when you're using a combination of
slow devices and fast devices.  That worked OK in 2.5.x, iirc, but seems to
have gotten broken since.

> Suppose we have a filesystem where writeback is relatively slow -
> e.g. NFS or EXTx over nbd over a slow link.
> 
> Suppose for the sake of simplicity that writeback is very slow and
> doesn't progress at all for the first part of our experiment.
> 
> We write to a large file. 
> Balance_dirty_pages gets called periodically.  Until the number of
> Dirty pages reached 40% of memory it does nothing.
> 
> Once we hit 40%, balance_dirty_pages starts calling writeback_inodes
> and these Dirty pages get converted to Writeback pages.  This happens
> at 1.5 times the speed that dirty pages are created (due to
> sync_writeback_pages()).  So for every 100K that we dirty, 150K gets
> converted to writeback.  But balance_dirty_pages doesn't wait for anything.
> 
> This will result in the number of dirty pages going down steadily, and
> the number of writeback pages increasing quickly (3 times the speed of
> the drop in Dirty).  The total of Dirty+Writeback will keep growing.
> 
> When Dirty hits 0 (and Writeback is theoretically 80% of RAM)
> balance_dirty_pages will no longer be able to flush the full
> 'write_chunk' (1.5 times number of recent dirtied pages) and so will
> spin in a loop calling blk_congestion_wait(WRITE, HZ/10), so it isn't
> a busy loop, but it won't progress.

This assumes that the queues are unbounded.  They're not - they're limited
to 128 requests, which is 60MB or so.

Per queue.  The scenario you identify can happen if it's spread across
multiple disks simultaneously.

CFQ used to have 1024 requests and we did have problems with excessive
numbers of writeback pages.  I fixed that in 2.6.early, but that seems to
have got lost as well.

> Now our very slow writeback gets it's act together and starts making
> some progress and the Writeback number steadily drops down to 40%.
> At this point balance_dirty_pages will exit, more pages will get
> dirtied, and balance_dirty_pages will quickly flush them out again.
> 
> The steady state will be with Dirty at or close to 0, and Writeback at
> or close to 40%.
> 
> Now obviously this is somewhat idealised, and even slow writeback will
> make some progress early on, but you can still expect to get a very
> large Writeback with a very small Dirty before stabilising.
> 
> I don't think we want this, but I'm not sure what we do want, so I'm
> asking for opinions.
> 
> I don't think that pushing Dirty down to zero is the best thing to
> do.  If writeback is slow, we should be simply waiting for writeback
> to progress rather than putting more work into the writeback queue.
> This also allows pages to stay 'dirty' for longer which is generally
> considered to be a good thing.
> 
> I think we need to have 2 numbers.  One that is the limit of dirty
> pages, and one that is the limit of the combined dirty+writeback.
> Alternately it could simply be a limit on writeback.
> Probably the later because having a very large writeback number makes
> the 'inactive_list' of pages very large and so it takes a long time
> to scan.
> So suppose dirty were capped at vm_dirty_ratio, and writeback were
> capped at that too, though independently. 
> 
> Then in our experiment, Dirty would grow up to 40%, then
> balance_dirty_pages would start flushing and Writeback would grow to
> 40% while Dirty stayed at 40%.  Then balance_dirty_pages would not 
> flush anything but would just wait for Writeback to drop below 40%.
> You would get a very obvious steady stage of 40% dirty and
> 40% Writeback.
> 
> Is this too much memory?  80% tied up in what are essentially dirty
> blocks is more than you would expect when setting vm.dirty_ratio to
> 40.
> 
> Maybe 40% should limit Dirty+Writeback and when we cross the
> threshold:
>   if Dirty > Writeback - flush and wait
>   if Dirty < Writeback - just wait
> 
> bdflush should get some writeback underway before we hit the 40%, so
> balance_dirty_pages shouldn't find itself waiting for the pages it
> just flushed.
> 
> Suggestions? Opinions?
> 
> The following patch demonstrates the last suggestion.
> 
> Thanks,
> NeilBrown
> 
> Signed-off-by: Neil Brown <neilb@suse.de>
> 
> ### Diffstat output
>  ./mm/page-writeback.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff .prev/mm/page-writeback.c ./mm/page-writeback.c
> --- .prev/mm/page-writeback.c	2006-08-15 09:36:23.000000000 +1000
> +++ ./mm/page-writeback.c	2006-08-15 09:39:17.000000000 +1000
> @@ -207,7 +207,7 @@ static void balance_dirty_pages(struct a
>  		 * written to the server's write cache, but has not yet
>  		 * been flushed to permanent storage.
>  		 */
> -		if (nr_reclaimable) {
> +		if (nr_reclaimable > global_page_state(NR_WRITEBACK)) {
>  			writeback_inodes(&wbc);
>  			get_dirty_limits(&background_thresh,
>  					 	&dirty_thresh, mapping);
> @@ -218,8 +218,6 @@ static void balance_dirty_pages(struct a
>  					<= dirty_thresh)
>  						break;
>  			pages_written += write_chunk - wbc.nr_to_write;
> -			if (pages_written >= write_chunk)
> -				break;		/* We've done our duty */
>  		}
>  		blk_congestion_wait(WRITE, HZ/10);
>  	}

Something like that - it'll be relatively simple.
