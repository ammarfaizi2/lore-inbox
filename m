Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311282AbSCLQnI>; Tue, 12 Mar 2002 11:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289484AbSCLQmv>; Tue, 12 Mar 2002 11:42:51 -0500
Received: from [195.63.194.11] ([195.63.194.11]:57610 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S311282AbSCLQmg>; Tue, 12 Mar 2002 11:42:36 -0500
Message-ID: <3C8E2FB9.2090905@evision-ventures.com>
Date: Tue, 12 Mar 2002 17:41:29 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <E16kYXz-0001z3-00@the-village.bc.nu> <Pine.LNX.4.33.0203111431340.15427-100000@penguin.transmeta.com> <20020311234553.A3490@ucw.cz> <3C8DDFC8.5080501@evision-ventures.com> <20020312165937.A4987@ucw.cz> <3C8E28A1.1070902@evision-ventures.com> <20020312172134.A5026@ucw.cz> <3C8E2C2C.2080202@evision-ventures.com> <20020312173301.C5026@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Tue, Mar 12, 2002 at 05:26:20PM +0100, Martin Dalecki wrote:
> 
>>Vojtech Pavlik wrote:
>>
>>
>>
>>>Well, as much as I'd like to use safe pre-computed register values for
>>>the chips, that ain't possible - even when we assumed the system bus
>>>(PCI, VLB, whatever) was always 33 MHz, still the drives have various
>>>ideas about what DMA and PIO modes should look like, see the tDMA and
>>>tPIO entries in hdparm -t.  
>>>
>>Yes yes yes of course some of the drivers are confused. And I don't
>>argue that precomputation is adequate right now. It just wasn't for
>>the CMD640 those times... I only wanted to reffer to history and
>>why my timings where different then the computed.
>>
> 
> We may want to compare your original timings to what ide-timing.[ch]
> will compute ...
> 
> 
>>>So, arithmetics has to stay. Hopefully just one instance in
>>>ide-timing.c.
>>>
>>>
>>>
>>>>>I plan to focus on the most important drivers first, to fix and clean
>>>>>them, working with the authors where possible.
>>>>>
>>>>>
>>>>PIIX na VIA comes to mind first ;-)...
>>>>
>>>>
>>>VIA is already OK, well, it has my name in it. :) AMD is now also (well,
>>>
>>Oh of course I was reffering to VIA as important.
>>
>>
>>>that one wasn't broken, just ugly), SiS is being revamped by Lionel
>>>Bouton (whom I'm trying to help as much as I can), so yes, PIIX would be
>>>next.
>>>
>>I swallowed his SiS stuff already, since my home main machine is
>>a SiS735 based board. (Awfoul cheap that thing and quite good price/performance
>>ratio ;-).
>>
> 
> As you can guess, I have mostly VIA machines around here. One SiS, too,
> but that's an embedded board.
> 
> 
>>>PIIX and ICH are pretty crazy hardware from the design perspective, very
>>>legacy-bound back to the first Intel PIIX chip. And the driver for these
>>>
>>Yes I "love" the bound together DMA areas as well ;-).
>>
> 
> And the SIDETIM register is just a kyooot idea. :)
> 
> 
>>>in the kernel has similarly evolved following the hardware. However, it
>>>doesn't seem to be wrong at the first glance. Nevertheless, I'll take a
>>>look at it. Unfortunately, I don't have any Intel hardware at hand to
>>>test it with.
>>>
>>Just another hint: dmaproc is silly nomenclature is should be
>>dma_strategy <- this would better reflect it's purpose.
>>
> 
> Dmaproc? Well that's a do-everything-possible-with-default-fallbacks
> function. Quite an interesting approach, though I'd be much happier
> without it.

Yeep. As an added bonus it's error prone, if some implementation of this
method forgets to cut and paste the fallback code.
You noticed the way I made at least the file_operations dispatcher
looking "opaque" recently? Most visible was the vanishment of
dome

if (ban->bang == NULL)
     bang = default1
if (ban->bang == NULL)
     bang = default1
if (ban->bang == NULL)
     bang = default1
if (ban->bang == NULL)
     bang = default1
if (ban->bang == NULL)
     bang = default1
if (ban->bang == NULL)
     bang = default1
....

orgy upon "disk" initialization...

> Btw, do you know that the chipset and drives are tuned twice each boot?
> First they're configured to PIO and half a second later to DMA (or PIO)
> again ...

Yes I know ;-). I have just removed some other twice callers for
other stuff. Do you know for example that I'm about 90% sure that
cleanup hooks for the device category drivers can be called twice.
Or that adding just a single drive reiterates every one on the system?

First I will try to change the way disks get iterated. This is
becouse disks are the main object in the whole driver and not
the host chip channels... Look for the plenty loops with
MAX_HWIFS as upper bound to see what I mean.

"Tune" is a silly name as well BTW. It has nothing to do with
attaching of carbon fiber to cars. It's host chip initialization, which
is going on.


