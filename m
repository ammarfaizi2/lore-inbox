Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbTEZUoO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 16:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbTEZUoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 16:44:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59370 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262234AbTEZUoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 16:44:11 -0400
Date: Mon, 26 May 2003 22:57:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] add ata scsi driver
Message-ID: <20030526205725.GT845@suse.de>
References: <20030526203800.GP845@suse.de> <Pine.LNX.4.44.0305261345460.13489-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305261345460.13489-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26 2003, Linus Torvalds wrote:
> 
> On Mon, 26 May 2003, Jens Axboe wrote:
> > 
> > I know this is a pet peeve of yours (must be, I remember you bringing it
> > up at least 3 time before :), but I don't think that's necessarily true.
> > It shouldn't matter _one_ bit whether you leave the request there or
> > not, it's unmergeable.
> 
> It's not the merging that I worry about. It's latency and starvation.
> 
> Think of it this way: if you keep feeding a disk requests, and the disk 
> always tries to do the closest one (which is a likely algorithm), you can 
> easily have a situation where the disk _never_ actually schedules a 
> request that is at one "end" of the platter. 

Then you have a bad disk, period. If the disks always tries to
approximate SPTF internally, then it's a bad design. Apparently that
Other OS times read/write requests out after 3 seconds, we we at least
know we are getting service in that time frame. Not saying that is good
enough, just a data point.

But the situation you describe above can easily be fixed, you described
the solution yourself in the previous mail. The silly tag depth is a
problem in itself, it should not be done. Keeping a sane number of tags
just to keep the disk busy, and we can use the "don't queue more
requests before X finishes, because X has been waiting for Y ms" tactic.

In fact, considering folks want to make error handling for command
timeouts a block property (that I agree with, we are already going there
with the SG_IO stuff), we can soft timeout a command if need be and
handle the case from there. What do you think?

> Think of all the fairness issues we've had in the elevator code, and 
> realize that the low-level disk probably implements _none_ of those 
> fairness algorithms.

I think it does, to some extent at least.

> > As long as the io scheduler keeps track of this (and it does!) we are
> > golden.
> 
> Hmm.. Where does it keep track of request latency for requests that have 
> been removed from the queue?

Well, it doesn't...

-- 
Jens Axboe

