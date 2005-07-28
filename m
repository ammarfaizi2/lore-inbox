Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVG1DHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVG1DHF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 23:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVG1DHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 23:07:05 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:46023 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261241AbVG1DHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 23:07:02 -0400
Subject: Re: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1122513928.29823.150.camel@localhost.localdomain>
References: <1122473595.29823.60.camel@localhost.localdomain>
	 <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1122513928.29823.150.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-67mX6QehzuNVKebN9ErJ"
Organization: Kihon Technologies
Date: Wed, 27 Jul 2005 23:06:39 -0400
Message-Id: <1122519999.29823.165.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-67mX6QehzuNVKebN9ErJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-07-27 at 21:25 -0400, Steven Rostedt wrote:
> On Wed, 2005-07-27 at 18:00 -0700, Daniel Walker wrote:
> > Don't you break sched_find_first_bit() , seems it's dependent on a 
> > 140-bit bitmap .
> 
> Oops! I forgot about that. With my custom kernels I had to change this
> to use the generic find_first_bit routine. It's been a while since I
> made these changes.  So when we really need to have custom settings, we
> would have to change this.  I should have remembered this, since it did
> cause me couple of days of debugging.  Anyway, I never did the
> measurements, but does anyone know what the performance difference is
> between find_first_bit and sched_find_first_bit? I guess I'll do it and
> report back later.  This should also be in a comment around changing
> these settings.

OK, here's the benchmark. Attached is the program that I used, and
compiled it this way:

gcc -O2 -o ffb ffb.c

and here's the results:

clock speed = 00000000:7f30c931 2133903665 ticks per second
last bit set
generic ffb: 00000000:02755284
time: 0.019327615us
sched ffb: 00000000:001e8f2b
time: 0.000938529us

first bit set
generic ffb: 00000000:01ea41f0
time: 0.015056688us
sched ffb: 00000000:001e8eff
time: 0.000938509us


/proc/cpuinfo shows that I have a SMP Authentic AMD running at 
2133.635 MHz.  The SMP doesn't matter for this test, but the Hz goes
right in line to the above BS tick measure.  I ran both the generic ffb
and the sched_find_first_bit 1,000,000 times each and took the
measurements of both.  The sched_find_first_bit ran 20 times faster!!!
So that is quite an improvement.  Even when I set the first bit, it is
15 times faster. The time between the two for the sched_ffb is pretty
much constant, where as the ffb is quicker the closer the bit is (as
expected).  But we are talking 19ns to do this, and a colleague of mine
said that this is just eliminating a fart in the wind storm.  But I
still think that the ffb should be better for something like the
scheduler.  Well, I guess I can spend some more time playing with
algorithms that can improve the ffb :-)

-- Steve


--=-67mX6QehzuNVKebN9ErJ
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

#define rdtscll(val) \
	     __asm__ __volatile__("rdtsc" : "=A" (val))

#define rdtsc(low,high) \
	     __asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high))

static unsigned long array[5];

#define ITER 1000000 /* 1,000,000 times */

void testit(unsigned long *array, unsigned long long clock)
{
	unsigned long long s1;
	unsigned long long e1;
	unsigned long long s2;
	unsigned long long e2;
	unsigned long long t1;
	unsigned long long t2;
	double f1;
	double f2;
	int i;
	int x;
	
	rdtscll(s1);
	for (i=0; i < ITER; i++) 
		x = find_first_bit(array,140);
	rdtscll(e1);

	rdtscll(s2);
	for (i=0; i < ITER; i++) 
		x = sched_find_first_bit(array);
	rdtscll(e2);
	
	t1 = e1 - s1;
	t2 = e2 - s2;
	f1 = (float)t1 / (float)clock;
	f2 = (float)t2 / (float)clock;

	/*
	 * Since ITER is 1,000,000 the times will be in us.
	 */
	printf("generic ffb: %08lx:%08lx\n",
			(unsigned long)(t1>>32),(unsigned long)t1);
	printf("time: %.09fus\n",f1);
			
	printf("sched ffb: %08lx:%08lx\n",
			(unsigned long)(t2>>32),(unsigned long)t2);
	printf("time: %.09fus\n",f2);
}

int main(int argc, char **argv)
{
	unsigned long long s;
	unsigned long long e;
	unsigned long long t;
	unsigned long long clock;

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
	printf("last bit set\n");
	testit(array,clock);

	array[0] = 0x00000001;
	printf("\nfirst bit set\n");
	testit(array,clock);
	
	exit(0);
}

--=-67mX6QehzuNVKebN9ErJ--

