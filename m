Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265044AbUHCFxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbUHCFxz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 01:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265048AbUHCFxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 01:53:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:53737 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265044AbUHCFxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 01:53:52 -0400
Date: Tue, 3 Aug 2004 07:53:40 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Zinx Verituse <zinx@epicsol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd problems
Message-ID: <20040803055337.GA23504@suse.de>
References: <20040730193651.GA25616@bliss> <20040731153609.GG23697@suse.de> <20040731182741.GA21845@bliss> <20040731200036.GM23697@suse.de> <1091490870.1649.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091490870.1649.23.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03 2004, Alan Cox wrote:
> On Sad, 2004-07-31 at 21:00, Jens Axboe wrote:
> > If you want it to work that way, you have the have a pass-through filter
> > in the kernel knowing what commands are out there (including vendor
> > specific ones). That's just too ugly and not really doable or
> > maintainable, sorry.
> 
> I disagree providing you turn it the other way around. The majority of
> scsi commands have to be protected because you can destroy the drive
> with some of them or bypass the I/O layers. (Eg using SG_IO to do writes
> to raw disk to bypass auditing layers)
> 
> So you need CAP_SYS_RAWIO for most commands. You can easily build a list
> of sane commands for a given media type that are harmless and it fits
> the kernel role of a gatekeeper to do that.

So that's where we vehemently disagree - it fits the kernel role, if you
allow it to control policy all of a sudden. And it's not easy, unless
you do it per specific device (not just type, make and model).

> Providing the 'allowed' function is driver level and we also honour
> read/write properly for that case (so it doesnt bypass block I/O
> restrictions and fail the least suprise test) then it seems quite
> doable.
> 
> For such I/O you'd then do
> 
> 	if(capable(CAP_SYS_RAWIO) || driver->allowed(driver, blah, cmdblock))
> 
> If the allowed function filters positively "unknown is not allowed" and
> the default allowed function is simply "no" it works.

Until there's a new valid command for some device, in which case you
have to update your kernel?

> We'd end up with a list of allowed commands for all sorts of operations
> that don't threaten the machine while blocking vendor specific wonders
> and also cases where users can do stuff like firmware erase.

Sorry, I think this model is totally bogus and I'd absolutely refuse to
merge any such beast into the block layer sg code.

-- 
Jens Axboe

