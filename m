Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbUEWK6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbUEWK6w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 06:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbUEWK6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 06:58:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:24760 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262451AbUEWK44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 06:56:56 -0400
Date: Sun, 23 May 2004 12:56:46 +0200
From: Jens Axboe <axboe@suse.de>
To: Kurt Garloff <garloff@suse.de>,
       Lorenzo Allegrucci <l_allegrucci@despammed.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: 2.6.6-mm5 oops mounting ext3 or reiserfs with -o barrier
Message-ID: <20040523105646.GK1952@suse.de>
References: <200405222107.55505.l_allegrucci@despammed.com> <20040523082728.GH1952@suse.de> <20040523103717.GA5253@tpkurt.garloff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040523103717.GA5253@tpkurt.garloff.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23 2004, Kurt Garloff wrote:
> Hi Jens,
> 
> On Sun, May 23, 2004 at 10:27:28AM +0200, Jens Axboe wrote:
> > @@ -1729,8 +1723,29 @@ static void idedisk_setup (ide_drive_t *
> >  
> >  	write_cache(drive, 1);
> >  
> > -	blk_queue_ordered(drive->queue, 1);
> > -	blk_queue_issue_flush_fn(drive->queue, idedisk_issue_flush);
> > +	/*
> > +	 * decide if we can sanely support flushes and barriers on
> > +	 * this drive
> > +	 */
> > +	if (drive->addressing == 1) {
> > +		/*
> > +		 * if capacity is over 2^28 sectors, drive must support
> > +		 * FLUSH_CACHE_EXT
> > +		 */
> > +		if (ide_id_has_flush_cache_ext(id))
> > +			barrier = 1;
> > +		else if (capacity <= (1ULL << 28))
> > +			barrier = 1;
> > +		else
> > +			printk("%s: drive is buggy, no support for FLUSH_CACHE_EXT with lba48\n", drive->name);
> 
> So, for drives with LBA48, you enable barriers either if report to
> support it or if their capacity is _smaller_ than 2^28. If neither
> is the case, it's left disabled and the kernel complains.
> Is it safe to enable for 
> (addressing == 1 && !ide_id_has_flush_cache_ext() && capacity <= 1<<28)
> ?

Yes that's safe.

> Shouldn't we check ide_has_flush_cache() then, as for the non-
> LBA48 drives?

Yep.

Yeah that was buggy, see later posting (which had a barrier = 1 hanging
from update, argh). Here's a better version imho. I have one drive here
that does support FLUSH_CACHE, but doesn't flag cfs_enable_2 as such. So
I think our logic should be:

        /*
         * decide if we can sanely support flushes and barriers on
         * this drive. unfortunately not all drives advertise
         * FLUSH_CACHE
         * support even if they support it. So assume FLUSH_CACHE is
         * there
         * if write back caching is enabled. LBA48 drives are newer, so
         * expect it to flag support properly. We can safely support
         * FLUSH_CACHE on lba48, if capacity doesn't exceed lba28
         */
        barrier = drive->wcache;
        if (drive->addressing == 1) {
                barrier = ide_id_has_flush_cache(id);
                if (capacity > (1ULL << 28) && !ide_id_has_flush_cache_ext(id))
                        barrier = 0;
        }

-- 
Jens Axboe

