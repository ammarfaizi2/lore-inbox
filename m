Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292682AbSBUR7H>; Thu, 21 Feb 2002 12:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292681AbSBUR6r>; Thu, 21 Feb 2002 12:58:47 -0500
Received: from [195.63.194.11] ([195.63.194.11]:55560 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292682AbSBUR6g>; Thu, 21 Feb 2002 12:58:36 -0500
Message-ID: <3C75351D.4030200@evision-ventures.com>
Date: Thu, 21 Feb 2002 18:57:49 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5 IDE cleanup 11
In-Reply-To: <E16dxO4-0007f6-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>If I hadn't tought about it I wouldn't be that advantegrous.
>>And my testing of it did consist of the following:
>>
>>1. 2 x IDE drives of one IDE port.
>>2. 1 x CD-RW on a second port - modularized.
>>3. 1 x CarBus to CF adapter.
>>
> 
> So you didnt test or consider the upcoming things like hotplug. 

I did plugging and unplugging a CardBus IDE contoller in and out on
a hot system.

> I'm sure the cleanup works now, but imagine if I was to "clean up" Jens
> new block code by removing all the stuff he has there ready for next
> features.

Well the hotplug/suspension problem is certinaly to be targetted by 
using the struct device_driver infrastructure and not by reduplicating 
it's fuctionality inside ide.c. Agreed? Before one could even thing
about  this the splitting between ide_driver_t and ide_module_t *had* to
be removed.

Just have a look at the massive code duplication between init_module
and driver_reinit functions inside the subdrivers to see why this is.

Before this can happen one has to untagle the flow of the current
driver. Like for exampel double calls to module initialization 
functions. The device detection part *has* to be pulled
out from the corresponding module initialization routines - yes I'm 
aware of this. But I would rathter like them to find they home
inside the following:

struct device_driver {
         int     (*probe)        (struct device *dev);
         int     (*remove)       (struct device *dev);

         int     (*suspend)      (struct device *dev, u32 state, u32 level);
         int     (*resume)       (struct device *dev, u32 level);
}

instead of ide_driver_t ide_hwif_t or whatever the ide-typdef of the day
is.

Finally: Before something can go in - well something has to go out.
In esp. if it is in the way and the removal doesn't cause any loss
modulo current functionality.

This is the reaons of the FIXME notes I have itroduced here and there
inside the patch as well.

But currently one has to fight far too frequently
with functions which are exported without any justification or
different functions which basically just do the same, games on
ifdef's inside headers and so on...

