Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVG1Dcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVG1Dcq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 23:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVG1Dcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 23:32:45 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:56009 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261276AbVG1Dck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 23:32:40 -0400
Subject: Re: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1122519999.29823.165.camel@localhost.localdomain>
References: <1122473595.29823.60.camel@localhost.localdomain>
	 <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1122513928.29823.150.camel@localhost.localdomain>
	 <1122519999.29823.165.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-xyFqllRk9Mb6zoEgY95z"
Organization: Kihon Technologies
Date: Wed, 27 Jul 2005 23:32:18 -0400
Message-Id: <1122521538.29823.177.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xyFqllRk9Mb6zoEgY95z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

New benchmarks with my own formula.

I added my own find_first_bit algorithm, that still doesn't quite beat
Ingo's sched_find_first_bit, but it does a number on the generic
find_first_bit.  I guess the compiler has finally beat what we do in
asm.  Here's my generic algorithm.

static inline int my_find_first_bit(const unsigned long *b, unsigned size)
{
        int x = 0;
        size += 31;
        do {
                if (unlikely(*b))
                        return __ffs(*b) + x;
                b++;
                x += 32;
        } while (x < size);
        return x-32;
}


And here's the new results of my benchmark: Comments added.

/*
 * I put in what is returned to see what really is returned is
 * correct.  Funny that sched_find_first_bit is wrong if there
 * isn't a bit set. But this shouldn't be called if there isn't
 * one set.
 */
sched=128  ffb=160  my=160
clock speed = 00000000:7f2f2cbb 2133798075 ticks per second
/* Here I set the last bit of 5 32bit words. */
sched=159  ffb=159  my=159
last bit set
generic ffb: 00000000:026a1cea
time: 0.018984294us
sched ffb: 00000000:001ee719
time: 0.000949125us
/*
 * My time is 8ns, 8 times longer than Ingo's if the last
 * bit is set (most likely case), but still more than twice 
 * as fast as ffb.
 */
my ffb: 00000000:0106a3dd
time: 0.008066546us
sched=0  ffb=0  my=0

first bit set
generic ffb: 00000000:01ee8e2b
time: 0.015189432us
sched ffb: 00000000:001eea92
time: 0.000949542us
/*
 * With the first bit set, I'm still slower than Ingo's
 * but only by 2, and I still beat the pants off of ffb.
 */
my ffb: 00000000:004d5de6
time: 0.002376190us


Conclusion:  it looks like it might be time to change the i386 generic
ffb to something else.

Oh, and if you are wondering...


$ gcc -v
Using built-in specs.
Target: i486-linux-gnu
Configured with: ../src/configure -v --enable-languages=c,c
++,java,f95,objc,ada,treelang --prefix=/usr --enable-shared
--with-system-zlib --libexecdir=/usr/lib --enable-nls
--without-included-gettext --enable-threads=posix --program-suffix=-4.0
--enable-__cxa_atexit --enable-libstdcxx-allocator=mt
--enable-clocale=gnu --enable-libstdcxx-debug --enable-java-gc=boehm
--enable-java-awt=gtk
--with-java-home=/usr/lib/jvm/java-1.4.2-gcj-4.0-1.4.2.0/jre
--enable-mpfr --disable-werror --enable-checking=release i486-linux-gnu
Thread model: posix
gcc version 4.0.1 (Debian 4.0.1-2)

-- Steve

Attached is new version of ffb.c

--=-xyFqllRk9Mb6zoEgY95z
Content-Disposition: attachment; filename=ffb.c
Content-Type: text/x-csrc; name=ffb.c; charset=us-ascii
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define unlikely(x)	__builtin_expect(!!(x), 0)

static inline int find_first_bit(const unsigned long *addr, unsigned size)
{
	int d0, d1;
	int res;

	/* This looks at memory. Mark it volatile to tell gcc not to move it around */
	__asm__ __volatile__(
		"xorl %%eax,%%eax\n\t"
		"repe; scasl\n\t"
		"jz 1f\n\t"
		"leal -4(%%edi),%%edi\n\t"
		"bsfl (%%edi),%%eax\n"
		"1:\tsubl %%ebx,%%edi\n\t"
		"shll $3,%%edi\n\t"
		"addl %%edi,%%eax"
		:"=a" (res), "=&c" (d0), "=&D" (d1)
		:"1" ((size + 31) >> 5), "2" (addr), "b" (addr) : "memory");
	return res;
}

static inline unsigned long __ffs(unsigned long word)
{
	__asm__("bsfl %1,%0"
		:"=r" (word)
		:"rm" (word));
	return word;
}

static inline int sched_find_first_bit(const unsigned long *b)
{
	if (unlikely(b[0]))
		return __ffs(b[0]);
	if (unlikely(b[1]))
		return __ffs(b[1]) + 32;
	if (unlikely(b[2]))
		return __ffs(b[2]) + 64;
	if (b[3])
		return __ffs(b[3]) + 96;
	return __ffs(b[4]) + 128;
}

static inline int my_find_first_bit(const unsigned long *b, unsigned size)
{
	int x = 0;
	size += 31;
	do {
		if (unlikely(*b))
			return __ffs(*b) + x;
		b++;
		x += 32;
	} while (x < size);
	return x-32;
}

#define rdtscll(val) \
	     __asm__ __volatile__("rdtsc" : "=A" (val))

#define rdtsc(low,high) \
	     __asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high))

static unsigned long array[5];

#define ITER 1000000 /* 1,000,000 times */

void testit(unsigned long *array, unsigned long long clock)
{
	unsigned long long s;
	unsigned long long e;
	unsigned long long t;
	double f;
	int i;
	int x;
	
	/*
	 * Since ITER is 1,000,000 the times will be in us.
	 */

	rdtscll(s);
	for (i=0; i < ITER; i++) 
		x = find_first_bit(array,140);
	rdtscll(e);
	t = e - s;
	f = (float)t / (float)clock;
	printf("generic ffb: %08lx:%08lx\n",
			(unsigned long)(t>>32),(unsigned long)t);
	printf("time: %.09fus\n",f);

	rdtscll(s);
	for (i=0; i < ITER; i++) 
		x = sched_find_first_bit(array);
	rdtscll(e);
	t = e - s;
	f = (float)t / (float)clock;
	printf("sched ffb: %08lx:%08lx\n",
			(unsigned long)(t>>32),(unsigned long)t);
	printf("time: %.09fus\n",f);

	rdtscll(s);
	for (i=0; i < ITER; i++) 
		x = my_find_first_bit(array,140);
	rdtscll(e);
	t = e - s;
	f = (float)t / (float)clock;
	printf("my ffb: %08lx:%08lx\n",
			(unsigned long)(t>>32),(unsigned long)t);
	printf("time: %.09fus\n",f);

}

int main(int argc, char **argv)
{
	unsigned long long s;
	unsigned long long e;
	unsigned long long t;
	unsigned long long clock;

	printf("sched=%d  ffb=%d  my=%d\n",
			sched_find_first_bit(array),
			find_first_bit(array,140),
			my_find_first_bit(array,140));
	/*
	 * Calculate BS time, just to get an 
	 * idea of the tsc speed.
	 */
	rdtscll(s);
	sleep(8);
	rdtscll(e);
	
	t = e - s;
	t >>= 3;
	printf("clock speed = %08lx:%08lx %llu ticks per second\n",
			(unsigned long)(t>>32),(unsigned long)t,
			t);
	clock = t;

	array[4] = 0x80000000;
	printf("sched=%d  ffb=%d  my=%d\n",
			sched_find_first_bit(array),
			find_first_bit(array,140),
			my_find_first_bit(array,140));
	printf("last bit set\n");
	testit(array,clock);

	array[0] = 0x00000001;
	printf("sched=%d  ffb=%d  my=%d\n",
			sched_find_first_bit(array),
			find_first_bit(array,140),
			my_find_first_bit(array,140));
	printf("\nfirst bit set\n");
	testit(array,clock);
	
	exit(0);
}

--=-xyFqllRk9Mb6zoEgY95z--

