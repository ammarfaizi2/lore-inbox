Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271179AbUKBDL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271179AbUKBDL1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 22:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S379895AbUKAW7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:59:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:27062 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S321612AbUKAVk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 16:40:26 -0500
Date: Mon, 1 Nov 2004 13:40:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: linux-os@analogic.com
cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Andreas Steinmetz <ast@domdv.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <Pine.LNX.4.61.0411011542430.24533@chaos.analogic.com>
Message-ID: <Pine.LNX.4.58.0411011327400.28839@ppc970.osdl.org>
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
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Nov 2004, linux-os wrote:
> 
> Wrong.
> 
> (1)  The '486 didn't have the rdtsc instruction.
> (2)  There are no 'serializing' or other black-magic aspects of
> using the internal cycle-counter. That's exactly how you you
> can benchmark the execution time of accessible code sequences.

Sorry, but you shouldn't argue with people who know more than you do. I 
know Dean, and he analyzes things for work, and does know what he is 
doing. 

"rdtsc" _does_ partly serialize things, and it's not even architecturally 
defined, so you'll find that it serializes things in different ways on 
different CPU's. You can't just do

	rdtsc
	...
	rdtsc

and expect the stuff in between the rdtsc's to be timed exactly: some of 
it will overlap with the rdtsc's, some of it won't.

On Intel, if I recall correctly, rdtsc is totally serializing, so you're
testing not just the instructions between the rdtsc's, but the length of
the pipeline, and the time it takes for stuff around it to calm down.  
Which is why two rdtsc's in sequence will show quite a lot of overhead on
a P4 (something like 80 cycles).

So you really want to do more operations in between the rdtsc's.

Try the appended program. On a P4, the two sequnces are the same for me 
(92 cycles, 80 cycles overhead), while on a Pentium M, the sequence of two 
popl's (57 cycles) is faster than the sequence of "lea+popl" (59 cycles) 
and the overhead is 47 cycles.

So can you _please_ just admit that you were wrong? On a P4, the pop/pop 
is the same cost as lea/pop, and on a Pentium M the pop/pop is faster, 
according to this test. Your contention that "pop" has to be slower than 
"lea" is WRONG. 

		Linus

----
#define PUSHEBX "pushl %%ebx\n\t"
#define PUSHECX "pushl %%ecx\n\t"
#define POPECX "popl %%ecx\n\t"
#define POPEBX "popl %%ebx\n\t"

#ifdef TEST_LEA

#undef POPECX
#define POPECX "leal 4(%%esp),%%esp\n\t"

#endif

#ifdef TEST_OVERHEAD

#undef PUSHEBX
#undef PUSHECX
#undef POPEBX
#undef POPECX

#define PUSHEBX
#define PUSHECX
#define POPEBX
#define POPECX

#endif

int main(void)
{
	unsigned long start;
	unsigned long long end;

	asm volatile(
		PUSHEBX
		PUSHECX
		PUSHEBX
		PUSHECX
		PUSHEBX
		PUSHECX
		PUSHEBX
		PUSHECX
		PUSHEBX
		PUSHECX
		PUSHEBX
		PUSHECX
		PUSHEBX
		PUSHECX
		PUSHEBX
		PUSHECX
		"rdtsc\n\t"
		POPECX
		POPEBX
		POPECX
		POPEBX
		POPECX
		POPEBX
		POPECX
		POPEBX
		POPECX
		POPEBX
		POPECX
		POPEBX
		POPECX
		POPEBX
		POPECX
		POPEBX
		"movl %%eax,%%esi\n\t"
		"rdtsc"
		:"=A" (end), "=S" (start));
	printf("%ld cycles\n", (long) end-start);
}

