Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267878AbUHEThS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267878AbUHEThS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 15:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267864AbUHEThR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 15:37:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:65508 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267878AbUHETfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 15:35:31 -0400
Date: Thu, 5 Aug 2004 21:35:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Zinx Verituse <zinx@epicsol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd problems
Message-ID: <20040805193520.GA7571@suse.de>
References: <20040803055337.GA23504@suse.de> <41128070.5050109@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41128070.5050109@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05 2004, Bill Davidsen wrote:
> Jens Axboe wrote:
> >On Tue, Aug 03 2004, Alan Cox wrote:
> >
> >>On Sad, 2004-07-31 at 21:00, Jens Axboe wrote:
> >>
> >>>If you want it to work that way, you have the have a pass-through filter
> >>>in the kernel knowing what commands are out there (including vendor
> >>>specific ones). That's just too ugly and not really doable or
> >>>maintainable, sorry.
> >>
> >>I disagree providing you turn it the other way around. The majority of
> >>scsi commands have to be protected because you can destroy the drive
> >>with some of them or bypass the I/O layers. (Eg using SG_IO to do writes
> >>to raw disk to bypass auditing layers)
> >>
> >>So you need CAP_SYS_RAWIO for most commands. You can easily build a list
> >>of sane commands for a given media type that are harmless and it fits
> >>the kernel role of a gatekeeper to do that.
> >
> >
> >So that's where we vehemently disagree - it fits the kernel role, if you
> >allow it to control policy all of a sudden. And it's not easy, unless
> >you do it per specific device (not just type, make and model).
> >
> >
> >>Providing the 'allowed' function is driver level and we also honour
> >>read/write properly for that case (so it doesnt bypass block I/O
> >>restrictions and fail the least suprise test) then it seems quite
> >>doable.
> >>
> >>For such I/O you'd then do
> >>
> >>	if(capable(CAP_SYS_RAWIO) || driver->allowed(driver, blah, cmdblock))
> >>
> >>If the allowed function filters positively "unknown is not allowed" and
> >>the default allowed function is simply "no" it works.
> >
> >
> >Until there's a new valid command for some device, in which case you
> >have to update your kernel?
> 
> As opposed to now when a new command comes along and the driver doesn't 
> generate it until you update your kernel? Reading a CD doesn't take 

Weak example. Lots of commands aren't issued directly by the device
driver, in fact very few are. The driver does not have to be updated to
handle new commands. If you add policy filtering, it does.

> exotic commands, and given the choice of having users able to send 
> arbitrary commands to the device and not access it at all, I would say 
> "not at all" would be good.

Then don't make your cdrom device accesable.

> >>We'd end up with a list of allowed commands for all sorts of operations
> >>that don't threaten the machine while blocking vendor specific wonders
> >>and also cases where users can do stuff like firmware erase.
> 
> There was a note on another list titled "Why did this work?" (from 
> memory) where someone accidentally run a firmware update as a normal 
> user and it worked. While this was a benign event, it points out that 
> there is a hole here far beyond my earlier worry that someone would 
> update a CD-RW.
>
> >
> >
> >Sorry, I think this model is totally bogus and I'd absolutely refuse to
> >merge any such beast into the block layer sg code.
> >
> So what is your solution? Or do you believe that allowing users to have 
> unmonitored access to devices is acceptable?

If differentiating use of a cdrom implies filtering commands, then
that's not acceptable to me. So they either have access to the device or
they don't.

> Is this problem only in ide-cd, or does it affect other devices like 
> ZIP, USB, etc, which do or may look like SCSI?

Affects all devices that accept SG_IO.

-- 
Jens Axboe

