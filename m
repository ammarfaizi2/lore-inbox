Return-Path: <linux-kernel-owner+willy=40w.ods.org-S275649AbUKBBve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275649AbUKBBve (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 20:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S289969AbUKAX2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:28:18 -0500
Received: from alog0023.analogic.com ([208.224.220.38]:5504 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S270034AbUKAWSe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 17:18:34 -0500
Date: Mon, 1 Nov 2004 17:16:37 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Linus Torvalds <torvalds@osdl.org>
cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Andreas Steinmetz <ast@domdv.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <Pine.LNX.4.58.0411011327400.28839@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0411011651580.26464@chaos.analogic.com>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> 
 <417550FB.8020404@drdos.com>  <1098218286.8675.82.camel@mentorng.gurulabs.com>
  <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com> 
 <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net>
 <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com>
 <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com>
 <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org> <41826A7E.6020801@domdv.de>
 <Pine.LNX.4.61.0410291255400.17270@chaos.analogic.com>
 <Pine.LNX.4.58.0410291103000.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0410291424180.4870@chaos.analogic.com>
 <Pine.LNX.4.58.0410291209170.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0410312024150.19538@chaos.analogic.com>
 <Pine.LNX.4.61.0411011219200.8483@twinlark.arctic.org>
 <Pine.LNX.4.61.0411011542430.24533@chaos.analogic.com>
 <Pine.LNX.4.58.0411011327400.28839@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2004, Linus Torvalds wrote:

>
>
> On Mon, 1 Nov 2004, linux-os wrote:
>>
>> Wrong.
>>
>> (1)  The '486 didn't have the rdtsc instruction.
>> (2)  There are no 'serializing' or other black-magic aspects of
>> using the internal cycle-counter. That's exactly how you you
>> can benchmark the execution time of accessible code sequences.
>
> Sorry, but you shouldn't argue with people who know more than you do. I
> know Dean, and he analyzes things for work, and does know what he is
> doing.
>
> "rdtsc" _does_ partly serialize things, and it's not even architecturally
> defined, so you'll find that it serializes things in different ways on
> different CPU's. You can't just do
>
> 	rdtsc
> 	...
> 	rdtsc
>
> and expect the stuff in between the rdtsc's to be timed exactly: some of
> it will overlap with the rdtsc's, some of it won't.
>
> On Intel, if I recall correctly, rdtsc is totally serializing, so you're
> testing not just the instructions between the rdtsc's, but the length of
> the pipeline, and the time it takes for stuff around it to calm down.
> Which is why two rdtsc's in sequence will show quite a lot of overhead on
> a P4 (something like 80 cycles).
>
> So you really want to do more operations in between the rdtsc's.
>
> Try the appended program. On a P4, the two sequnces are the same for me
> (92 cycles, 80 cycles overhead), while on a Pentium M, the sequence of two
> popl's (57 cycles) is faster than the sequence of "lea+popl" (59 cycles)
> and the overhead is 47 cycles.
>
> So can you _please_ just admit that you were wrong? On a P4, the pop/pop
> is the same cost as lea/pop, and on a Pentium M the pop/pop is faster,
> according to this test. Your contention that "pop" has to be slower than
> "lea" is WRONG.
>
> 		Linus
>
> ----
> #define PUSHEBX "pushl %%ebx\n\t"
> #define PUSHECX "pushl %%ecx\n\t"
> #define POPECX "popl %%ecx\n\t"
> #define POPEBX "popl %%ebx\n\t"
>
> #ifdef TEST_LEA
>
> #undef POPECX
> #define POPECX "leal 4(%%esp),%%esp\n\t"
>
> #endif
>
> #ifdef TEST_OVERHEAD
>
> #undef PUSHEBX
> #undef PUSHECX
> #undef POPEBX
> #undef POPECX
>
> #define PUSHEBX
> #define PUSHECX
> #define POPEBX
> #define POPECX
>
> #endif
>
> int main(void)
> {
> 	unsigned long start;
> 	unsigned long long end;
>
> 	asm volatile(
> 		PUSHEBX
> 		PUSHECX
> 		PUSHEBX
> 		PUSHECX
> 		PUSHEBX
> 		PUSHECX
> 		PUSHEBX
> 		PUSHECX
> 		PUSHEBX
> 		PUSHECX
> 		PUSHEBX
> 		PUSHECX
> 		PUSHEBX
> 		PUSHECX
> 		PUSHEBX
> 		PUSHECX
> 		"rdtsc\n\t"
> 		POPECX
> 		POPEBX
> 		POPECX
> 		POPEBX
> 		POPECX
> 		POPEBX
> 		POPECX
> 		POPEBX
> 		POPECX
> 		POPEBX
> 		POPECX
> 		POPEBX
> 		POPECX
> 		POPEBX
> 		POPECX
> 		POPEBX
> 		"movl %%eax,%%esi\n\t"
> 		"rdtsc"
> 		:"=A" (end), "=S" (start));
> 	printf("%ld cycles\n", (long) end-start);
> }
>

You just don't get it. I, too, can make a so-called bench-mark
that will "prove" something that's so incredibly invalid that
it shouldn't even deserve an answer. However, because you
are supposed to know what you are doing, I will give you
an answer.

It is totally impossible to perform useful work with memory,
i.e., poping the value of something from memory into a register,
without incurring the cost of that memory access. It doesn't
matter if the memory is in cache or if it needs to be read
using the memory controller. Time is time and it never runs
backwards. I spend most of my days with hardware logic analyzers
looking at the memory accesses so I damn-well know what I
am taking about. That memory-access takes a time-slot that
something else can't use. You never get it back. It is gone
forever. This is very important to understand. If you don't
understand this, you can fall into the "black-magic" trap.

Modern CPUs make it easy for so-called software engineers to
perceive so-called facts that are not, in fact, true. Because
it is possible for the CPU to perform memory-access independent
of instruction sequence (so-called parallel operations), it is
possible to make bench-marks that prove nothing, but seem to
show that a read from memory is free. It can never be free. It
will eventually show up. It was just deferred. Of course, if
your computer is just going to run that single bench-mark, then
return to a prompt, you can readily become victum of a very
common error because there is now plenty of time available to
just spin (or wait for an interrupt).

So, if you really want to make things fast, you keep your
memory accesses to the absolute minimum. Poping something
from the stack is the antithesis of what you want to do.

It's really amusing. Software development has devolved
into some black magic where logic, mathematics, and
physical testing no longer thrive.

Instead, we must listen to those who profess to know
about this magic because of some innate enlightenment
imparted to those favored few who are able to perceive
the trueness of their intellectual perception without
regard for contrary physical observations.

It's wonderful to not be bothered by tests, measurements,
documentation, or other facts.

Wake up and don't be dragged into the black-magic trap.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
