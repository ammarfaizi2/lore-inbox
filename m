Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbWFUMcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbWFUMcs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 08:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWFUMcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 08:32:48 -0400
Received: from liaag2ab.mx.compuserve.com ([149.174.40.153]:50563 "EHLO
	liaag2ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751538AbWFUMcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 08:32:47 -0400
Date: Wed, 21 Jun 2006 08:24:30 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFC, patch] i386: vgetcpu(), take 2
To: Ingo Molnar <mingo@elte.hu>
Cc: Jakub Jelinek <jakub@redhat.com>, Roland McGrath <roland@redhat.com>,
       Ulrich Drepper <drepper@redhat.com>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606210828_MC3-1-C30B-9D83@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060621081539.GA14227@elte.hu>

On Wed, 21 Jun 2006 10:15:39 +0200, Ingo Molnar wrote:

> * Chuck Ebbert <76306.1226@compuserve.com> wrote:
> 
> > Use a GDT entry's limit field to store per-cpu data for fast access 
> > from userspace, and provide a vsyscall to access the current CPU 
> > number stored there.
> 
> very nice idea! I thought of doing sys_get_cpu() too, but my idea was to 
> use the scheduler to keep a writable [and permanently pinned, 
> per-thread] VDSO data page uptodate with the current CPU# [and other 
> interesting data]. Btw., do we know how fast LSL is on modern CPUs?

Now that the GDT is a full page for each CPU there's plenty of space
for all kinds of per-cpu data, even if we waste 75% of it.  LSL seems
pretty fast; I got 13 clocks for the whole lsl/jnz/and sequence on K8
and 21 clocks on PII.  Myabe you can test P4?

/* test how fast lsl/jnz/and runs.
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


> > +__vgetcpu:
> > +.LSTART_vgetcpu:
> > +   movl $-EFAULT,%eax
> > +   movl $((27<<3)|3),%edx
> > +   lsll %edx,%eax
> > +   jnz 1f
> > +   andl $0xff,%eax
> > +1:
> > +   ret
> 
> this needs unwinder annotations as well to make this a proper DSO, so 
> that for example a breakpoint here does not confuse gdb.

I can't write those.

> also, would be nice to do something like this in 64-bit mode too.

Andi has x86_64 patches in his tree and is considering this method for
ia32 support.

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
