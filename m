Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWGGU0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWGGU0E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 16:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWGGU0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 16:26:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7910 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751238AbWGGU0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 16:26:02 -0400
Date: Fri, 7 Jul 2006 13:25:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Krzysztof Halasa <khc@pm.waw.pl>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <Pine.LNX.4.61.0607071535020.13007@chaos.analogic.com>
Message-ID: <Pine.LNX.4.64.0607071318570.3869@g5.osdl.org>
References: <20060705114630.GA3134@elte.hu><20060705101059.66a762bf.akpm@osdl.org><20060705193551.GA13070@elte.hu><20060705131824.52fa20ec.akpm@osdl.org><Pine.LNX.4.64.0607051332430.12404@g5.osdl.org><20060705204727.GA16615@elte.hu><Pine.LNX.4.64.0607051411460.12404@g5.osdl.org><20060705214502.GA27597@elte.hu><Pine.LNX.4.64.0607051458200.12404@g5.osdl.org><Pine.LNX.4.64.0607051555140.12404@g5.osdl.org><20060706081639.GA24179@elte.hu><Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com><Pine.LNX.4.64.0607060856080.12404@g5.osdl.org><Pine.LNX.4.64.0607060911530.12404@g5.osdl.org><Pine.LNX.4.61.0607061333450.11071@chaos.analogic.com>
 <m34pxt8emn.fsf@defiant.localdomain> <Pine.LNX.4.61.0607071535020.13007@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Jul 2006, linux-os (Dick Johnson) wrote:
> 
> Now Linus declares that instead of declaring an object volatile
> so that it is actually accessed every time it is referenced, he wants
> to use a GNU-ism with assembly that tells the compiler to re-read
> __every__ variable existing im memory, instead of just one. Go figure!

Actually, it's not just me.

Read things like the Intel CPU documentation.

IT IS ACTIVELY WRONG to busy-loop on a variable. It will make the CPU 
potentially over-heat, causing degreaded performance, and you're simply 
not supposed to do it.

> Reference:
> /usr/src/linux-2.6.16.4/include/linux/compiler-gcc.h:
> #define barrier() __asm__ __volatile__("": : :"memory")

Actually, for your kind of stupid loop, you should use

 - include/asm-i386/processor.h:
	#define cpu_relax()        rep_nop()

where rep_nop() is

	/* REP NOP (PAUSE) is a a good thing to insert into busy-wait loops. */
	static inline void rep_nop(void)
	{
		__asm__ __volatile__("rep;nop": : :"memory");
	}

on x86, and can be other things on other CPU's. On ppc64 it is

	#define cpu_relax()     do { HMT_low(); HMT_medium(); barrier(); } while (0)

where those HMT macros adjust thread priority.

In other words, you just don't know what you're talking about. "volatile" 
is simply not useful, and the fact that you cannot seem to grasp that is 
_your_ problem.

Repeat after me (or just shut up about things that you not only don't know 
about, but are apparently not willing to even learn):

	"'volatile' is useless. The things it did 30 years ago are much 
	 more complex these days, and need to be tied to much more 
	 detailed rules that depend on the actual particular problem, 
	 rather than one keyword to the compiler that doesn't actually 
	 give enough information for the compiler to do anything useful"

Comprende?

		Linus
