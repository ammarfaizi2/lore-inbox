Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbULCKc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbULCKc0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 05:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbULCKc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 05:32:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27629 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262144AbULCKcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 05:32:21 -0500
Date: Fri, 3 Dec 2004 11:31:30 +0100
From: Jens Axboe <axboe@suse.de>
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       nickpiggin@yahoo.com.au
Subject: Re: Time sliced CFQ io scheduler
Message-ID: <20041203103130.GH10492@suse.de>
References: <20041202134801.GE10458@suse.de> <20041202114836.6b2e8d3f.akpm@osdl.org> <20041202195232.GA26695@suse.de> <20041202121938.12a9e5e0.akpm@osdl.org> <41AF94B8.8030202@gmx.de> <20041203070108.GA10492@suse.de> <41B02DFD.9090503@gmx.de> <20041203012645.21377669.akpm@osdl.org> <20041203093903.GE10492@suse.de> <41B03722.5090001@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B03722.5090001@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03 2004, Prakash K. Cheemplavam wrote:
> Jens Axboe schrieb:
> >On Fri, Dec 03 2004, Andrew Morton wrote:
> >
> >>"Prakash K. Cheemplavam" <prakashkc@gmx.de> wrote:
> >>
> >>Is this a parallel IDE system?  SATA?  SCSI?  If the latter, what driver
> >>and what is the TCQ depth?
> >
> >
> >Yeah, that would be interesting to know. Or of the device is on dm or
> >raid. And what filesystem is being used?
> 
> It is ext3. (The writing-makes-reading-starve problem happen on reiserfs 
> as well. ext2 is not so bad and xfs behaves best, ie my email client 
> doesn't get unuasable with my earlier tests, but "only" very slow. But 
> then I only wrote down 2gb and nothing continuesly.)

It's impossible to give really good results on ext3/reiser in my
experience, because reads often need to generate a write as well. What
could work is if a reader got PF_SYNCWRITE set while that happens.

Or even better would be to kill that horrible PF_SYNCWRITE hack (Andrew,
how could you!) and really have the fs use the proper WRITE_SYNC
instead.

> >So Prakash, please try the same test with those settings:
> >
> ># cd /sys/block/<dev>/queue/iosched
> ># echo 6 > idle
> ># echo 150 > slice
> >
> >These are the first I tried, there may be better settings. If you have
> >your filesystem on dm/raid, you probably want to do the above for each
> >device the dm/raid is composed of.
> 
> Yeas, I have linux raid (testing md1). Have appield both settings on 
> both drives and got a interesting new pattern: Now it alternates. My 
> email client is still not usale while writing though...

Funky. It looks like another case of the io scheduler being at the wrong
place - if raid sends dependent reads to different drives, it screws up
the io scheduling. The right way to fix that would be to io scheduler
before raid (reverse of what we do now), but that is a lot of work. A
hack would be to try and tie processes to one md component for periods
of time, sort of like cfq slicing.

-- 
Jens Axboe

