Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265382AbSL1CQ6>; Fri, 27 Dec 2002 21:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbSL1CQ6>; Fri, 27 Dec 2002 21:16:58 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:25552 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S265382AbSL1CQ5>; Fri, 27 Dec 2002 21:16:57 -0500
Date: Fri, 27 Dec 2002 18:28:54 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFT][PATCH] generic device DMA implementation
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3E0D0C66.8050705@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200212272147.gBRLlU103775@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>>- DMA mapping calls still return no errors; so BUG() out instead? 
> 
> 
> That's actually an open question.  The line of least resistance (which is what 
> I followed) is to do what the pci_ API does (i.e. BUG()).

That might have been appropriate for PCI-mostly APIs, since those tend to
be resource-rich.  Maybe.  (It always seemed like an API bug to me.)

I can't buy that logic in the "generic" case though.  Heck, haven't all
the address space allocation calls in Linux always exposed ENOMEM type
faults ... except PCI?  This one is _really_ easy to fix now.  Resources
are never infinite.


> It's not clear to me that adding error returns rather than BUGging would buy 
> us anything (because now all the drivers have to know about the errors and 
> process them).

For me, designing any "generic" API to handle common cases (like allocation
failures) reasonably (no BUGging!) is a fundamental design requirement.

Robust drivers are aware of things like allocation faults, and handle them.
If they do so poorly, that can be fixed like any other driver bug.


>>   Consider systems where DMA-able memory is limited (like SA-1111,
>>   to 1 MByte); clearly it should be possible for these calls to
>>   fail, when they can't allocate a bounce buffer.  Or (see below)
>>   when an invalid argument is provided to a dma mapping call. 
> 
> 
> That's pretty much an edge case.  I'm not opposed to putting edge cases in the 
> api (I did it for dma_alloc_noncoherent() to help parisc), but I don't think 
> the main line should be affected unless there's a good case for it.

Absolutely *any* system can have situations where the relevant address space
(or memory) was all in use, or wasn't available to a non-blocking request
without blocking, etc.  Happens more often on some systems than others; I
just chose SA-1111 since your approach would seem to make that unusable.

If that isn't a "good case", why not?  And what could ever be a "good case"?


> Perhaps there is a compromise where the driver flags in the struct 
> device_driver that it wants error returns otherwise it takes the default 
> behaviour (i.e. no error return checking and BUG if there's a problem).

IMO that's the worst of all possible worlds.  The error paths would get
even less testing than they do today.  If there's a fault path defined,
use it in all cases:  don't just BUG() in some modes, and some drivers.

- Dave

