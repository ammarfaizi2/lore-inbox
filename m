Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263605AbUJ3BiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263605AbUJ3BiO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 21:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbUJ2ThL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:37:11 -0400
Received: from alog0152.analogic.com ([208.224.220.167]:7040 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261168AbUJ2Smu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:42:50 -0400
Date: Fri, 29 Oct 2004 14:39:06 -0400 (EDT)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Andreas Steinmetz <ast@domdv.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <Pine.LNX.4.58.0410291103000.28839@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0410291424180.4870@chaos.analogic.com>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> 
 <417550FB.8020404@drdos.com>  <1098218286.8675.82.camel@mentorng.gurulabs.com>
  <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com> 
 <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net>
 <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com>
 <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com>
 <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org> <41826A7E.6020801@domdv.de>
 <Pine.LNX.4.61.0410291255400.17270@chaos.analogic.com>
 <Pine.LNX.4.58.0410291103000.28839@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2004, Linus Torvalds wrote:

>
>
> On Fri, 29 Oct 2004, linux-os wrote:
>>> with the following:
>>>
>>> leal 4(%esp),%esp
>>
>> Probably so because I'm pretty certain that the 'pop' (a memory
>> access) is not going to be faster than a simple register operation.
>
> Bzzt, wrong answer.
>
> It's not "simple register operation". It's really about the fact that
> modern CPU's are smarter - yet dumber - then you think. They do things
> like speculate the value of %esp in order to avoid having to calculate it,
> and it's entirely possible that "pop" is much faster, simply because I
> guarantee you that a CPU will speculate %esp correctly across a "pop", but
> the same is not necessarily true for "lea %esp".
>
> Somebody should check what the Pentium M does. It might just notice that
> "lea 4(%esp),%esp" is the same as "add 4 to esp", but it's entirely
> possible that lea will confuse its stack engine logic and cause
> stack-related address generation stalls..
>
> 		Linus


Linus, there is no way in hell that you are going to move
a value from memory into a register (pop ecx) faster than
you are going to do anything to the stack-pointer or
any other register. The register operations operate
at the internal CPU clock-rate (GHz). The memory operations
operate at the front-side bus rate (MHz), and the data-
movement must actually occur before anything else can.
In other words, with stack operations, modern CPUs will
stall until the operation has completed.

Using the rdtsc, on this computer, both of the stack-pointer
additions (leal or add) take 6 +/- 2 clocks. The pop ecx
takes 12 +/- 3 clocks.

Things that should take only one clock, according to the
documentation, take 4 or 5 even when subtracting-out
the time necessary to do the rdtsc, because this machine
(and probably others) is very noisy, so all I can state
with certainty is that the pop from the stack takes longer.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
