Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbSJDXFo>; Fri, 4 Oct 2002 19:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261947AbSJDXFn>; Fri, 4 Oct 2002 19:05:43 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:35969 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261934AbSJDXFk>;
	Fri, 4 Oct 2002 19:05:40 -0400
Message-ID: <3D9E1695.1080305@colorfullife.com>
Date: Sat, 05 Oct 2002 00:30:45 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: [PATCH] patch-slab-split-03-tail
References: <Pine.LNX.4.33L2.0210041321370.20655-100000@dragon.pdx.osdl.net> 	<3D9E0760.8040507@colorfullife.com> <1033767839.1247.107.camel@phantasy>
Content-Type: multipart/mixed;
 boundary="------------040703060806010501050609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040703060806010501050609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Robert Love wrote:
> On Fri, 2002-10-04 at 17:25, Manfred Spraul wrote:
> 
> 
>>Which cpus have slow local_irq_disable() implementations? At least
>>for  my Duron, this doesn't seem to be the case [~ 4 cpu cycles
>>for cli]
> 
> 
> I believe there are pipeline effects to disabling interrupts, e.g. it
> has to be flushed?
> 
At least my Duron [700 MHz] obviously doesn't flush the pipeline. If the 
Pentium 4 flushes his pipeline, it could mean 20+ cycles - test app is 
attached.

--
	Manfred

--------------040703060806010501050609
Content-Type: text/plain;
 name="cli.cpp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cli.cpp"

/*
 * cli.cpp: RDTSC based performance tester.
 *
 * Copyright (C) 1999, 2001, 2002 by Manfred Spraul.
 *	All rights reserved except the rights granted by the GPL.
 *
 * Redistribution of this file is permitted under the terms of the GNU 
 * General Public License (GPL) version 2 or later.
 * $Header: /pub/home/manfred/cvs-tree/timetest/cli.cpp,v 1.4 2002/10/04 21:22:09 manfred Exp $
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <getopt.h>

// define a cache flushing function
#undef CACHE_FLUSH

// Intel recommends that a serializing instruction
// should be called before and after rdtsc.
// CPUID is a serializing instruction.
// ".align 128:" P 4 L2 cache line size
#define read_rdtsc_before(time)		\
	__asm__ __volatile__(		\
		".align 128\n\t"	\
		"xor %%eax,%%eax\n\t"	\
		"cpuid\n\t"		\
		"rdtsc\n\t"		\
		"mov %%eax,(%0)\n\t"	\
		"mov %%edx,4(%0)\n\t"	\
		"xor %%eax,%%eax\n\t"	\
		"cpuid\n\t"		\
		: /* no output */	\
		: "S"(&time)		\
		: "eax", "ebx", "ecx", "edx", "memory")

#define read_rdtsc_after(time)		\
	__asm__ __volatile__(		\
		"xor %%eax,%%eax\n\t"	\
		"cpuid\n\t"		\
		"rdtsc\n\t"		\
		"mov %%eax,(%0)\n\t"	\
		"mov %%edx,4(%0)\n\t"	\
		"xor %%eax,%%eax\n\t"	\
		"cpuid\n\t"		\
		"sti\n\t"		\
		: /* no output */	\
		: "S"(&time)		\
		: "eax", "ebx", "ecx", "edx", "memory")

#define BUILD_TESTFNC(name, text, instructions) \
void name##_dummy(void)				\
{						\
	__asm__ __volatile__(			\
		".align 4096\n\t"		\
		"xor %%eax, %%eax\n\t"		\
		: : : "eax");			\
}						\
static unsigned long name##_best = 1024*1024*1024; \
\
static void name(void) \
{ \
	unsigned long long time; \
	unsigned long long time2; \
 \
	read_rdtsc_before(time); \
	instructions; \
	read_rdtsc_after(time2); \
	if(time2-time < name##_best) { \
		printf( text ":\t%10Ld ticks; \n", \
			time2-time-zerotest_best); \
		name##_best = time2-time; \
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

#define DO_10(x) \
	do { x; x; x; x; x; x; x; x; x; x;} while(0)

#define DO_50(x) \
	do { DO_10(x); DO_10(x);DO_10(x); DO_10(x);DO_10(x);} while(0)


#define DO_T(y) do { \
	DO_3(filler()); \
	y; \
	DO_3(filler());} while(0)

#ifdef CACHE_FLUSH
#define DRAIN_SZ	(4*1024*1024)
int other[3*DRAIN_SZ] __attribute ((aligned (4096)));
static inline void drain_cache(void)
{
	int i;
	for(i=0;i<DRAIN_SZ;i++) other[DRAIN_SZ+i]=0;
	for(i=0;i<DRAIN_SZ;i++) if(other[DRAIN_SZ+i]!=0) break;
}
#else
static inline void drain_cache(void)
{
}
#endif

#define DO_TEST(x) \
	do { \
		int i; \
		for(i=0;i<500000;i++) \
			x; \
	} while(0)

//////////////////////////////////////////////////////////////////////////////

static inline void nothing()
{
	__asm__ __volatile__("nop": : : "memory");
}

BUILD_TESTFNC(zerotest,"zerotest", DO_T(nothing()));

//////////////////////////////////////////////////////////////////////////////

static inline void test0()
{
	__asm__ __volatile__("cli": : : "memory");
}

BUILD_TESTFNC(test_0, "cli", DO_T(test0()))

//////////////////////////////////////////////////////////////////////////////
extern "C" int iopl __P ((int __level));

int main()
{
	printf("CLI bench\n");
	iopl(3);

	for(;;) {
		DO_TEST(zerotest());
		DO_TEST(test_0());
	}
	return 0;
}

--------------040703060806010501050609--


