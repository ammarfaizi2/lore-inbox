Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbTIOPW2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 11:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbTIOPW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 11:22:28 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:38562 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261463AbTIOPW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 11:22:27 -0400
Date: Mon, 15 Sep 2003 17:22:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Daniel Pittman <daniel@rimspace.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE-CD issue: total capacity set to 0 incorrectly on some DVD-R discs.
Message-ID: <20030915152224.GB2928@suse.de>
References: <873cey6u6e.fsf@enki.rimspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873cey6u6e.fsf@enki.rimspace.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15 2003, Daniel Pittman wrote:
> Jens, I mentioned a little while ago on the linux-kernel list that I had
> an issue with my DVD drive (Pioneer DVD-ROM ATAPIModel DVD-106S 012)
> incorrectly determining a zero blocks size for some DVD-R discs.
> 
> After a lot of working to track down what the failure was, I found that
> the following code in ide-cd.c, and cdrom.c, was the source of the
> issue.
> 
> When checking the TOC of a disc the first time through, the following
> code at line 2376 in ide-cd.c is executed:
> 
> 	stat = cdrom_get_last_written(cdi, (long *) &toc->capacity);
> 	if (stat)
> 		stat = cdrom_read_capacity(drive, &toc->capacity, sense);
> 	if (stat)
> 		toc->capacity = 0x1fffff;
> 
> 	set_capacity(drive->disk, toc->capacity * SECTORS_PER_FRAME);
> 
> On the problematic disc/drive combination, cdrom_get_last_written
> returns 0, and sets toc->capacity to 0.
> 
> At the time, the cdrom_get_last_written code went through, checked the
> 'ti.lra_v' field, which the comment suggests is "last recorded sector",
> then did the "make it up" path.
> 
> The values of ti.track_start, ti.track_size and ti.free_blocks were all
> zero as well, suggesting that the structure returned by
> cdrom_get_track_info was not very well populated at all.
> 
> Obviously, though, from testing the function cdrom_read_capacity does
> get the correct size for the track, but something (the recording
> software, perhaps) is not setting up the "last written" stuff correctly.
> 
> For me, the following trivial patch to ide-cd.c corrects the issue, and
> all my software works just fine afterwards.
> 
> I am happy to continue to work on the issue if you don't think that this
> is the right fix, but I would need some guidance in how to continue --
> or just a patch to test. ;)

Thanks for doing the follow up work, I definitely agree with your
solution. I'll make sure it gets in, thanks.

-- 
Jens Axboe

