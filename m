Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317018AbSEWVoN>; Thu, 23 May 2002 17:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317019AbSEWVoM>; Thu, 23 May 2002 17:44:12 -0400
Received: from [195.63.194.11] ([195.63.194.11]:42756 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317018AbSEWVoL>; Thu, 23 May 2002 17:44:11 -0400
Message-ID: <3CED53CA.2000307@evision-ventures.com>
Date: Thu, 23 May 2002 22:40:42 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        enginer@intel.com
Subject: Re: Q: backport of the free_pgtables tlb fixes to 2.4
In-Reply-To: <20020523195757.GW21164@dualathlon.random> <Pine.LNX.4.33.0205231300530.4338-100000@penguin.transmeta.com> <20020523204101.GY21164@dualathlon.random> <3CED48C8.80406@evision-ventures.com> <20020523211537.GA21164@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Andrea Arcangeli napisa?:
> On Thu, May 23, 2002 at 09:53:44PM +0200, Martin Dalecki wrote:
>
>>I for one would be really really surprised if the execution of an
>>interrupt isn't treating the BTB specially. If one reads
> 
> 
> me too of course. If an irq isn't making UP-transparent the speculative
> actions of the BTB, then 2.5 is still buggy in allowing the fast mode in
> UP machines (beause the irq can allocate the pagetable and scribble over
> it so then the tlb will be filled with global garbage). To make things
> more clear this is what will happen right now in 2.5 if the irq isn't
> serializing the BTB speculative tlb fills:
> 
>         CPU1
> 
>         munmap
>         .. speculation starts ..
>         .. TLB reads pmd entry, so it now knows the phys address of the pte ..
> 
>         clear pmd entry
>         free pte
> 	(doesn't matter if we clear the pmd entry or if we free the pte first)
> 
> 	irq fired, BTB speculative actions aren't stopped they runs speculative in parallel to the irq
>         alloc page - get old pte
>         scribble on pte
> 
>         .. TLB reads the contents of the pte at the phys address now invalid ..
>         .. tlb fill ends and we filled the tlb with random pte contents marked global ...
> 
> If instead the irq is serializing the BTB actions as expected (the
> invariant is that an UP machine will never see any speculative action
> internally, speculations is a problem only with SMP on shared memory
> or while talking with hardware devices outside the local cpu), then it
> means the above cannot happen, so 2.5 isn't buggy in allowing the
> fastmode with 1 cpu systems, but then it also means 2.5 is overkill in
> the leave_mm hack and so we can drop it.

Wait a moment please. The explanation above is very nice but I have
unfortunately some speculation to add to the game. Let's take the
whole "hyper threading" stuff in to account. The HT variant of the
P4 was realeased just few weeks or months after the normal one.
Let's take the following  in to account:

1. CPU validation takes years those times,

2. it is the most expensive part in terms of time and perhaps money
    of the cpu design game,

3. HT only takes just several percent (around 5) of the slicon die to
    implement, which is liekely comparatively cheap in regard of point 2.

4. HT validation does something between double and quadrupling this whole
    effort.

Then it very well may be that the fscking P4 contains the
hyper threading silicon even on the UP marketed version.
It's likely just an "early stepping" and they disabled HT
there by making some Zener diode kaputt.

So it could very well be that the guys there just didn't do
full checks in this "corner" UP case behaviour or didn't notice that
something changed. Or didn't care after looking around at OS soruce code.
And the P4 has to be dealt precisely the same way with the hyper threaded
variant behaves.

...

The longer I think about it the more I tend toward the above
hypothesis... But unfortunatly I can't give you definitive
answers of course. Well the level of "tend toward it" is on the
range of: "If I had to bet my life on it I certainly wouldn't"
- and I consider myself quite courageous.

Multiply this by the number of Linux users, interrupts and the deepth
of the P4 pipelins and well it turns out that
well... 2.5 is most likely broken on P4.

Boy, I would love to trully know about this!
Intel - do you listen to this small humble prayer?

