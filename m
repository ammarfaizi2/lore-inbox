Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129870AbRBHRY3>; Thu, 8 Feb 2001 12:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130472AbRBHRYT>; Thu, 8 Feb 2001 12:24:19 -0500
Received: from colorfullife.com ([216.156.138.34]:53004 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129870AbRBHRYP>;
	Thu, 8 Feb 2001 12:24:15 -0500
Message-ID: <3A82D325.9068BC07@colorfullife.com>
Date: Thu, 08 Feb 2001 18:11:01 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sse for fast_clear_page()?
Content-Type: multipart/mixed;
 boundary="------------9AFC00B258E227EE5AB843EA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9AFC00B258E227EE5AB843EA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

fast_clear_page() uses mmx instructions for clearing a page, what about
using sse instructions?
sse instructions can store 128 bit in one instruction, mmx only 64 bit.

On a Pentium III it isn't faster, but it should be faster on a Pentium
4.

I've written a user space test app - could someone with a Pentium 4 run
it?

Just compile the attached program and run it for ~ 1 minute.
Then write down the lowest numbers for 'zerotest', 'zeropg_1',
"zeropg_sse_1' and 'zeropg_mmx_1' and post them to linux-kernel.

Thanks,
	Manfred
P.S: you need a recent binutils version to compile the app, I've
uploaded a precompiled binary to

http://colorfullife.com/~manfred/zero
--------------9AFC00B258E227EE5AB843EA
Content-Type: text/plain; charset=us-ascii;
 name="zero.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="zero.c"

/*
 * zeropg.cpp: test normal, mmx & sse clear_page()
 *
 * Copyright (C) 1999, 2001 by Manfred Spraul.
 * 
 * Redistribution of this file is permitted under the terms of the GNU 
 * Public License (GPL)
 * $Header: /pub/cvs/ms/movetest/zeropg.cpp,v 1.2 2001/02/08 16:02:08 manfred Exp $
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>


// Intel recommends that a serializing instruction
// should be called before and after rdtsc.
// CPUID is a serializing instruction.
// ".align 64:" the atlon has a 64 byte cache line size.
#define read_rdtsc_before(time)		\
	__asm__ __volatile__(		\
		".align 64\n\t"		\
		"cpuid\n\t"		\
		"rdtsc\n\t"		\
		"mov %%eax,(%0)\n\t"	\
		"mov %%edx,4(%0)\n\t"	\
		"cpuid\n\t"		\
		: /* no output */	\
		: "S"(&time)		\
		: "eax", "ebx", "ecx", "edx", "memory")

#define read_rdtsc_after(time)		\
	__asm__ __volatile__(		\
		"cpuid\n\t"		\
		"rdtsc\n\t"		\
		"mov %%eax,(%0)\n\t"	\
		"mov %%edx,4(%0)\n\t"	\
		"cpuid\n\t"		\
		: /* no output */	\
		: "S"(&time)		\
		: "eax", "ebx", "ecx", "edx", "memory")

#define BUILD_TESTFNC(name, text, instructions) \
static void name(void) \
{ \
	unsigned long long time; \
	unsigned long long time2; \
static unsigned long best = 1024*1024*1024; \
 \
	read_rdtsc_before(time); \
	instructions; \
	read_rdtsc_after(time2); \
	if(time2-time < best) { \
		printf( text ": %Ld ticks; \n", \
			time2-time); \
		best = time2-time; \
	} \
}

void filler(void)
{
static int i = 3;
static int j;
	j = i*i;
}

#define DO_3(x) \
	do { x; x; x; } while(0)

#define DO_T(y) do { \
	DO_3(filler()); \
	y; \
	DO_3(filler());} while(0)

#define DRAIN_SZ	(4*1024*1024)
int other[3*DRAIN_SZ];
static void drain_cache(void)
{
	int i;
	for(i=0;i<DRAIN_SZ;i++) other[DRAIN_SZ+i]=0;
	for(i=0;i<DRAIN_SZ;i++) if(other[DRAIN_SZ+i]!=0) break;
}
//////////////////////////////////////////////////////////////////////////////

char dest[16384*1024] __attribute ((aligned (128)));
char source[16384*1024] __attribute ((aligned (128)));

/* from linux-2.2.18/include/asm-i386/uaccess.h */
#define zeropg(mem,pg)				\
do {						\
	int d1, d2;				\
	__asm__ __volatile__(			\
		"xor %%eax,%%eax\n\t"		\
		"rep; stosl\n\t"		\
		: "=&c" (d1), "=&D" (d2)	\
		: "0" (pg*1024), "1" (mem)	\
		: "eax", "memory");		\
} while (0)

/* MMX versions, from linux 2.4.1, without prefetch (P III) */

#define zeropg_mmx(mem,pg)			\
do {						\
	int d1, d2;				\
	__asm__ __volatile__(			\
		"  pxor %%mm0, %%mm0\n"		\
		"1:  movntq %%mm0, (%1)\n"	\
		"  movntq %%mm0, 8(%1)\n"	\
		"  movntq %%mm0, 16(%1)\n"	\
		"  movntq %%mm0, 24(%1)\n"	\
		"  movntq %%mm0, 32(%1)\n"	\
		"  movntq %%mm0, 40(%1)\n"	\
		"  movntq %%mm0, 48(%1)\n"	\
		"  movntq %%mm0, 56(%1)\n"	\
		"  add $64, %1\n"		\
		"  dec %0\n"			\
		"  jge 1b\n"			\
		"  sfence\n"			\
		: "=&r" (d1), "=&D" (d2)	\
		: "0" (pg*64), "1" (mem)	\
		: "eax", "memory");		\
} while (0)

#define zeropg_sse(mem,pg)			\
do {						\
	int d1, d2;				\
	__asm__ __volatile__(			\
		"  xorps %%xmm0, %%xmm0\n"	\
		"1:  movntps %%xmm0, (%1)\n"	\
		"  movntps %%xmm0, 16(%1)\n"	\
		"  movntps %%xmm0, 32(%1)\n"	\
		"  movntps %%xmm0, 48(%1)\n"	\
		"  movntps %%xmm0, 64(%1)\n"	\
		"  movntps %%xmm0, 80(%1)\n"	\
		"  movntps %%xmm0, 96(%1)\n"	\
		"  movntps %%xmm0, 112(%1)\n"	\
		"  add $128, %1\n"		\
		"  dec %0\n"			\
		"  jge 1b\n"			\
		"  sfence\n"			\
		: "=&r" (d1), "=&D" (d2)	\
		: "0" (pg*32), "1" (mem)	\
		: "eax", "memory");		\
} while (0)

BUILD_TESTFNC(zerotest,"zerotest", DO_T((void)0));

BUILD_TESTFNC(test_1, "zeropg_1", DO_T(zeropg(&dest,1)));
BUILD_TESTFNC(test_2, "zeropg_mmx_1", DO_T(zeropg_mmx(&dest,1)));
BUILD_TESTFNC(test_3, "zeropg_sse_1", DO_T(zeropg_sse(&dest,1)));


int main()
{
	if(geteuid() == 0) {
		int res = nice(-20);
		if(res < 0) {
			perror("nice(-20)");
			return 1;
		}
		printf("MOVETEST, reniced to (-20).\n");	
	} else
	{
		printf("MOVETEST called by non-superuser, running with normal priority.\n");
	}
	asm("cld\n\t": : :"cc");
	for(;;) {
		drain_cache();
		zerotest();
		drain_cache();
		zerotest();

		drain_cache();
		test_1();
		drain_cache();
		test_1();

		drain_cache();
		test_2();
		drain_cache();
		test_2();

		drain_cache();
		test_3();
		drain_cache();
		test_3();
	}
	return 0;
}

--------------9AFC00B258E227EE5AB843EA--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
