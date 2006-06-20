Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWFTWp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWFTWp2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWFTWp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:45:28 -0400
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:9155 "EHLO
	liaag2ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751361AbWFTWp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:45:26 -0400
Date: Tue, 20 Jun 2006 18:40:06 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFC, patch] i386: vgetcpu()
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606201842_MC3-1-C2FD-FB7E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200606202257.16033.ak@suse.de>

On Tue, 20 Jun 2006 22:57:16 +0200, Andi Kleen wrote:

> On Tuesday 20 June 2006 22:25, Chuck Ebbert wrote:
> > Use the limit field of a GDT entry to store the current CPU
> > number for fast userspace access.  This still leaves 12 bits
> > free for other information.
> 
> Nice trick. Maybe I'll even add that to the x86-64 implementation
> if it's fast enough. Do you have numbers?
> 

I got ~13 clocks on x86_64 and 21 on PII.  Test program below.

> But it needs to be encapsulated in a wrapper I think. Just exposing
> it to user space is the wrong way to do this.

Well there's no real way to hide it, but something more is definitely
needed.  A new vdso entry point is easy but how do you tell userspace
it's there?  Does glibc look at the kernel version in the note?


/* test how fast lsl, test for success + mask result runs
 * leave DO_TEST undefined to measure overhead
 */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>

#define rdtscll(t)	asm volatile ("rdtsc" : "=A" (t))

#ifndef ITERS
#define ITERS	1000000
#endif

int main(int argc, char * const argv[])
{
	unsigned long long tsc1, tsc2;
	int count, cpu, junk;

	rdtscll(tsc1);
	asm (
		"	pushl %%ds		\n"
		"	popl %2			\n"
		"1:				\n"
#ifdef DO_TEST
		"	lsl %2,%0		\n"
		"	jnz 2f			\n"
		"	and $0xff,%0		\n"
#endif
		"	dec %1			\n"
		"	jnz 1b			\n"
		"2:				\n"
		: "=&r" (cpu), "=&r" (count), "=&r" (junk)
		: "1" (ITERS), "0" (-1)
	);
	rdtscll(tsc2);

	if (count == 0)
		printf("loops: %d, avg: %llu clocks\n",
			ITERS, (tsc2 - tsc1) / ITERS);
	return 0;
}
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
