Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262525AbTCRQcP>; Tue, 18 Mar 2003 11:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262526AbTCRQcP>; Tue, 18 Mar 2003 11:32:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13828 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262525AbTCRQbq>; Tue, 18 Mar 2003 11:31:46 -0500
Date: Tue, 18 Mar 2003 08:41:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kevin Pedretti <ktpedre@sandia.gov>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4
 due to wrmsr (performance)
In-Reply-To: <3E773A39.2090403@sandia.gov>
Message-ID: <Pine.LNX.4.44.0303180809190.11381-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Mar 2003, Kevin Pedretti wrote:
>
>     I wasn't aware of what you state below but it makes sense.  What I 
> haven't been able to figure out, and nobody seems to know, is why the 
> rodata section of an executable is placed in the text section and is not 
> page aligned.  This seems to be a mixing of code and data on the same 
> page.  Maybe it doesn't matter since it is read only?

It's a bad idea to share even read-only data, but the impact of read-only 
data is much less that read-write. In particular, you should avoid sharing 
_any_ code and data in the same physical L1 cache-line, since that will be 
a big problem for any CPU with exclusion between the I$ and D$.

HOWEVER, modern x86 CPU's tend to have the I$ be part of the cache 
coherency protocol, so instead of having exclusion they allow sharing as 
long as the D$ isn't actually dirty. In that case it's fine to share 
read-only data and code, although the cache utilization goes down if you 
do a lot of it.

Anyway, as long as they are in separate cache-lines, you should be ok even 
on something with cache exclusion.

When it comes to actually _writing_ to the data, at least on the P4 you
don't want to have read-write data anywhere _near_ the I$ (somebody
reported half-page granularity). This is true on crusoe too, btw (at a
128-byte granularity).

Anyway, I think gcc should make sure that even the ro-data section is at
least cacheline-aligned so that it stays away from cachelines used for I$.  
That makes sense even on CPU's that don't have exclusion, since it
actually gives slightly better L1 cache utilization.

You can run this (stupid) test-program to try. On my P4 I get

	empty overhead=320 cycles
	load overhead=0 cycles
	I$ load overhead=0 cycles
	I$ load overhead=0 cycles
	I$ store overhead=264 cycles

and on my PIII I get

	empty overhead=74 cycles
	load overhead=8 cycles
	I$ load overhead=8 cycles
	I$ load overhead=8 cycles
	I$ store overhead=103 cycles

and (just for fun) on an old crusoe I get

	empty overhead=67 cycles
	load overhead=-9 cycles
	I$ load overhead=-14 cycles
	I$ load overhead=-14 cycles
	I$ store overhead=12 cycles

where that "negative overhead" just shows that we do some strnge things to
scheduling, and the loop actually ends up faster if it has a load in it
than without the load..

But you can see that storing to code is a really bad idea. Especially on a 
P4, where the overhead for a store was 264 cycles! (You can also see the 
cost of doing just the empty synchronization and rdtsc - 320 cycles for a 
rdtsc and two locked memory accesses on a P4).

I don't have access to an old Pentium - I think that was the one that had 
the strict exclusion between the L1 I$ and D$, and then you should see the 
I$ load overhead go up.

			Linus

----
#include <sys/types.h>
#include <time.h>
#include <sys/time.h>
#include <sys/fcntl.h>
#include <asm/unistd.h>
#include <sys/stat.h>
#include <stdio.h>

#include <sys/mman.h>

#define PAGE_SIZE (4096UL)
#define PAGE_MASK (~(PAGE_SIZE-1))

#define serialize() asm volatile("lock ; addl $0,(%esp)")

#define rdtsc() ({ unsigned long a, d; asm volatile("rdtsc":"=a" (a), "=d" (d)); a; })

static int unused = 0;

#define NR (100000)

int main()
{
	int i;
	unsigned long overhead = ~0UL, empty = 0;
	void * address = (void *)(PAGE_MASK & (unsigned long)main);

	mprotect(address, PAGE_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC);

	overhead = ~0UL;
	for (i = 0; i < NR; i++) {
		unsigned long cycles = rdtsc();
		serialize();
		serialize();
		cycles = rdtsc() - cycles;
		if (cycles < overhead)
			overhead = cycles;
	}
	printf("empty overhead=%ld cycles\n", overhead);
	empty = overhead;

	overhead = ~0UL;
	for (i = 0; i < NR; i++) {
		unsigned long dummy;
		unsigned long cycles = rdtsc();
		serialize();
		asm volatile("movl %1,%0":"=r" (dummy):"m" (unused));
		serialize();
		cycles = rdtsc() - cycles;
		if (cycles < overhead)
			overhead = cycles;
	}
	printf("load overhead=%ld cycles\n", overhead-empty);

	overhead = ~0UL;
	for (i = 0; i < NR; i++) {
		unsigned long dummy;
		unsigned long cycles = rdtsc();
		serialize();
		asm volatile("1:\tmovl 1b,%0":"=r" (dummy));
		serialize();
		cycles = rdtsc() - cycles;
		if (cycles < overhead)
			overhead = cycles;
	}
	printf("I$ load overhead=%ld cycles\n", overhead-empty);

	asm volatile("jmp 1f\n.align 128\n99:\t.long 0\n1:");
	overhead = ~0UL;
	for (i = 0; i < NR; i++) {
		unsigned long dummy;
		unsigned long cycles;
		cycles = rdtsc();
		serialize();
		asm volatile("movl 99b,%0":"=r" (dummy));
		serialize();
		cycles = rdtsc() - cycles;
		if (cycles < overhead)
			overhead = cycles;
	}
	printf("I$ load overhead=%ld cycles\n", overhead-empty);

	asm volatile("jmp 1f\n99:\t.long 0\n1:");
	overhead = ~0UL;
	for (i = 0; i < NR; i++) {
		unsigned long dummy;
		unsigned long cycles;
		cycles = rdtsc();
		serialize();
		asm volatile("1:\tmovl %0,99b":"=r" (dummy));
		serialize();
		cycles = rdtsc() - cycles;
		if (cycles < overhead)
			overhead = cycles;
	}
	printf("I$ store overhead=%ld cycles\n", overhead-empty);
	return 0;
}

