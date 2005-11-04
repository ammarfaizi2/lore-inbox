Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbVKDQkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVKDQkp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbVKDQkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:40:45 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:31443 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750703AbVKDQkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 11:40:41 -0500
Date: Fri, 4 Nov 2005 17:40:20 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andy Nelson <andy@thermo.lanl.gov>, akpm@osdl.org, arjan@infradead.org,
       arjanv@infradead.org, haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@mbligh.org, mel@csn.ul.ie,
       nickpiggin@yahoo.com.au, pj@sgi.com
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <20051104164020.GA9028@elte.hu>
References: <20051104153903.E5D561845FF@thermo.lanl.gov> <Pine.LNX.4.64.0511040801450.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511040801450.27915@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> Time it on a real machine some day. On a modern x86, you will fill a 
> TLB entry in anything from 1-8 cycles if it's in L1, and add a couple 
> of dozen cycles for L2.

below is my (x86-only) testcode that accurately measures TLB miss costs 
in cycles. (Has to be run as root, because it uses 'cli' as the 
serializing instruction.)

here's the output from the default 128MB (32768 4K pages) random access 
pattern workload, on a 2 GHz P4 (which has 64 dTLBs):

  0 24 24 24 12 12 0 0 16 0 24 24 24 12 0 12 0 12

  32768 randomly accessed pages, 13 cycles avg, 73.751831% TLB misses.

i.e. really cheap TLB misses even in this very bad and TLB-trashing 
scenario: there are only 64 dTLBs and we have 32768 pages - so they are 
outnumbered by a factor of 1:512! Still the CPU gets it right.

setting LINEAR to 1 gives an embarrasing:

 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 

 32768 linearly accessed pages, 0 cycles avg, 0.259399% TLB misses.

showing that the pagetable got fully cached (probably in L1) and that 
has _zero_ overhead. Truly remarkable.

lowering the size to 16 MB (still 1:64 TLB-to-working-set-size ratio!) 
gives:

 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 

 4096 randomly accessed pages, 0 cycles avg, 5.859375% TLB misses.

so near-zero TLB overhead.

increasing BYTES to half a gigabyte gives:

 2 0 12 12 24 12 24 264 24 12 24 24 0 0 24 12 24 24 24 24 24 24 24 24 12 
 12 24 24 24 36 24 24 0 24 24 0 24 24 288 24 24 0 228 24 24 0 0 

 131072 randomly accessed pages, 75 cycles avg, 94.162750% TLB misses.

so an occasional ~220 cycles (~== 100 nsec - DRAM latency) cachemiss, 
but still the average is 75 cycles, or 37 nsecs - which is still only 
~37% of the DRAM latency.

(NOTE: the test eliminates most data cachemisses, by using zero-mapped 
anonymous memory, so only a single data page exists. So the costs seen 
here are mostly TLB misses.)

	Ingo

---------------
/*
 * TLB miss measurement on PII CPUs.
 *
 * Copyright (C) 1999, Ingo Molnar <mingo@redhat.com>
 */
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/wait.h>
#include <sys/mman.h>

#define BYTES (128*1024*1024)
#define PAGES (BYTES/4096)

/* This define turns on the linear mode.. */
#define LINEAR 0

#if 1
# define BARRIER "cli"
#else
# define BARRIER "lock ; addl $0,0(%%esp)"
#endif

int do_test (char * addr)
{
	unsigned long start, end;
	/*
	 * 'cli' is used as a serializing instruction to
	 * isolate the benchmarked instruction from rdtsc.
	 */
	__asm__ (
		"jmp 1f; 1: .align 128;\
"BARRIER";				\
		rdtsc;			\
		movl %0, %1;		\
"BARRIER";				\
		movl (%%esi), %%eax;	\
"BARRIER";				\
		rdtsc;			\
"BARRIER";				\
		"

		:"=a" (end), "=c" (start)
		:"S" (addr)
		:"dx","memory");
	return end - start;
}

extern int iopl(int);

int main (void)
{
	unsigned long overhead, sum;
	int j, k, c, hit;
	int matrix [PAGES];
	int delta [PAGES];
	char *buffer = mmap(NULL, BYTES, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

	iopl(3);
	/*
	 * first generate a random access pattern.
	 */
	for (j = 0; j < PAGES; j++) {
		unsigned long val;
#if LINEAR
		val = ((j*8) % PAGES) * 4096;
		val = j*2048;
#else
		val = (random() % PAGES) * 4096;
#endif
		matrix[j] = val;
	}

	/*
	 * Calculate the overhead
	 */
	overhead = ~0UL;
	for (j = 0; j < 100; j++) {
		unsigned int diff = do_test(buffer);
		if (diff < overhead)
			overhead = diff;
	}
	printf("Overhead = %ld cycles\n", overhead);

	/*
	 * 10 warmup loops, the last one is printed.
	 */
	for (k = 0; k < 10; k++) {
		c = 0;
		for (j = 0; j < PAGES; j++) {
			char * addr;
			addr = buffer + matrix[j];
			delta[c++] = do_test(addr);
		}
	}
	hit = 0;
	sum = 0;
	for (j = 0; j < PAGES; j++) {
		unsigned long d = delta[j] - overhead;
		printf("%ld ", d);
		if (d <= 1)
			hit++;
		sum += d;
	}
	printf("\n");
	printf("%d %s accessed pages, %d cycles avg, %f%% TLB misses.\n",
		PAGES,
#if LINEAR
		"linearly",
#else
		"randomly",
#endif
		sum/PAGES,
		100.0*((double)PAGES-(double)hit)/(double)PAGES);

	return 0;
}
