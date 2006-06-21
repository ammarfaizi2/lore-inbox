Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWFUROw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWFUROw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 13:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWFUROw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 13:14:52 -0400
Received: from cantor.suse.de ([195.135.220.2]:49561 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932271AbWFUROv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 13:14:51 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFC, patch] i386: vgetcpu(), take 2
Date: Wed, 21 Jun 2006 19:14:37 +0200
User-Agent: KMail/1.9.3
Cc: Ingo Molnar <mingo@elte.hu>, Jakub Jelinek <jakub@redhat.com>,
       Roland McGrath <roland@redhat.com>, Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200606210828_MC3-1-C30B-9D83@compuserve.com>
In-Reply-To: <200606210828_MC3-1-C30B-9D83@compuserve.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606211914.37137.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 June 2006 14:24, Chuck Ebbert wrote:
> In-Reply-To: <20060621081539.GA14227@elte.hu>
> 
> On Wed, 21 Jun 2006 10:15:39 +0200, Ingo Molnar wrote:
> 
> > * Chuck Ebbert <76306.1226@compuserve.com> wrote:
> > 
> > > Use a GDT entry's limit field to store per-cpu data for fast access 
> > > from userspace, and provide a vsyscall to access the current CPU 
> > > number stored there.
> > 
> > very nice idea! I thought of doing sys_get_cpu() too, but my idea was to 
> > use the scheduler to keep a writable [and permanently pinned, 
> > per-thread] VDSO data page uptodate with the current CPU# [and other 
> > interesting data]. Btw., do we know how fast LSL is on modern CPUs?
> 
> Now that the GDT is a full page for each CPU there's plenty of space
> for all kinds of per-cpu data, even if we waste 75% of it.  LSL seems
> pretty fast; I got 13 clocks for the whole lsl/jnz/and sequence on K8

My measurements show different - i get 60+ cycles on K8 and 150+ cycles
on P4. That is with a full vsyscall around it. However it is still
far better than CPUID, however slower than RDTSCP on those CPUs that support it.

I changed the CPUID fallback path to use LSL on x86-64

> and 21 clocks on PII.  Myabe you can test P4?
> 
> /* test how fast lsl/jnz/and runs.
>  */
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdlib.h>
> 
> #define rdtscll(t)	asm volatile ("rdtsc" : "=A" (t))
> 
> #ifndef ITERS
> #define ITERS	1000000
> #endif
> 
> int main(int argc, char * const argv[])
> {
> 	unsigned long long tsc1, tsc2;
> 	int count, cpu, junk;
> 
> 	rdtscll(tsc1);
> 	asm (
> 		"	pushl %%ds		\n"
> 		"	popl %2			\n"
> 		"1:				\n"
> #ifdef DO_TEST
> 		"	lsl %2,%0		\n"
> 		"	jnz 2f			\n"
> 		"	and $0xff,%0		\n"
> #endif
> 		"	dec %1			\n"
> 		"	jnz 1b			\n"
> 		"2:				\n"
> 		: "=&r" (cpu), "=&r" (count), "=&r" (junk)
> 		: "1" (ITERS), "0" (-1)
> 	);
> 	rdtscll(tsc2);

Measuring this way is a bad idea because you get far too much 
noise from the RDTSCs. Usually you need to put a a few thousands entry 
loop inside the RDTSCP and devide the result by the loop count

-Andi

> 
