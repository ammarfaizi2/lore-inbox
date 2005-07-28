Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVG1Ln6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVG1Ln6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 07:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVG1Ln6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 07:43:58 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:3037 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261225AbVG1Ln4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 07:43:56 -0400
Subject: [PATCH] speed up on find_first_bit for i386 (let compiler do the
	work)
From: Steven Rostedt <rostedt@goodmis.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
In-Reply-To: <42E8564B.9070407@yahoo.com.au>
References: <1122473595.29823.60.camel@localhost.localdomain>
	 <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1122513928.29823.150.camel@localhost.localdomain>
	 <1122519999.29823.165.camel@localhost.localdomain>
	 <1122521538.29823.177.camel@localhost.localdomain>
	 <1122522328.29823.186.camel@localhost.localdomain>
	 <42E8564B.9070407@yahoo.com.au>
Content-Type: multipart/mixed; boundary="=-hXlk81j2oYmwRv59IiDG"
Organization: Kihon Technologies
Date: Thu, 28 Jul 2005 07:43:34 -0400
Message-Id: <1122551014.29823.205.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hXlk81j2oYmwRv59IiDG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

In the thread "[RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO
configurable" I discovered that a C version of find_first_bit is faster
than the asm version now when compiled against gcc 3.3.6 and gcc 4.0.1
(both from versions of Debian unstable).  I wrote a benchmark (attached)
that runs the code 1,000,000 times. First I do it with no bits set,
followed by the last bit set, a middle bit set and then the first bit
set.  Only when no bits are set is the asm version of find_first_bit
faster and that is only when I ran it with gcc 4.0.1 (is gcc at fault
here?). I haven't spent any time actually looking at what gcc produces.
I only looked at the measurements.

I compiled this with "gcc -O2 -o ffb ffb.c".  And here's the output.

On an AMD 2.2GHz SMP machine (SMP shouldn't affect the result here).
This is running gcc 4.0.1

/* comments embedded */

/* ticks match speed */
clock speed = 00000000:7f31d02a 2133970986 ticks per second

/* generic ffb (or just ffb) is the code that is currently in the system
 * my ffb (or just my) is my new version that I'm submitting.
 * my ffb 2 (or just my2) is my version playing with unlikely around an
 *   condition.
 */
no bit set
ffb=320  my=320 my2=320
generic ffb: 00000000:02e33f90
time: 0.022702922us
my ffb: 00000000:02ee66e7
time: 0.023045461us
my ffb 2: 00000000:032d63b9
time: 0.024979860us
/*
 * The above shows that the original beats my version when no bit is
 * set.
 */

last bit set
ffb=319  my=319 my2=319
generic ffb: 00000000:0382a116
time: 0.027597643us
my ffb: 00000000:0204c4a9
time: 0.015870375us
my ffb 2: 00000000:03244a1b
time: 0.024700391us
/*
 * Here we see that there's quite an improvement over normal ffb when
 * the last bit is set.
 */

middle bit set
ffb=159  my=159 my2=159
generic ffb: 00000000:02ce2b78
time: 0.022055584us
my ffb: 00000000:01241c5b
time: 0.008970962us
my ffb 2: 00000000:016171ff
time: 0.010854596us
/*
 * Again, there's quite an improvement when a middle bit is set.
 */

first bit set
ffb=0  my=0 my2=0
generic ffb: 00000000:0232456a
time: 0.017267808us
my ffb: 00000000:003dd354
time: 0.001898712us
my ffb 2: 00000000:009d1f74
time: 0.004825372us
/*
 * When the first bit is set, there's ever a greater improvement. 
 */


Now for the results on my laptop with a Pentium 4 HT 3.3GZ. Running 
gcc 3.3.6

clock speed = 00000000:c5de80ef 3319693551 ticks per second

no bit set
ffb=320  my=320 my2=320
generic ffb: 00000000:0aba64db
time: 0.054218162us
my ffb: 00000000:055f6c73
time: 0.027153036us
my ffb 2: 00000000:052e753e
time: 0.026186379us
/*
 * Now we see even when no bits are set, my version beats the asm one.
 */

last bit set
ffb=319  my=319 my2=319
generic ffb: 00000000:0b69c638
time: 0.057680447us
my ffb: 00000000:050a27fb
time: 0.025469722us
my ffb 2: 00000000:04d32d78
time: 0.024384359us

middle bit set
ffb=159  my=159 my2=159
generic ffb: 00000000:0a1bc81f
time: 0.051086903us
my ffb: 00000000:020f3d7d
time: 0.010408554us
my ffb 2: 00000000:0324112a
time: 0.015873555us

first bit set
ffb=0  my=0 my2=0
generic ffb: 00000000:095a794d
time: 0.047270700us
my ffb: 00000000:005af2d0
time: 0.001795467us
my ffb 2: 00000000:005a0537
time: 0.001777144us


With this evidence, I present my patch against the 2.6.12.2 kernel.

Signed-off-by:  Steven Rostedt <rostedt@goodmis.org>

Index: vanilla_kernel/include/asm-i386/bitops.h
===================================================================
--- vanilla_kernel/include/asm-i386/bitops.h	(revision 263)
+++ vanilla_kernel/include/asm-i386/bitops.h	(working copy)
@@ -311,6 +311,20 @@
 int find_next_zero_bit(const unsigned long *addr, int size, int offset);
 
 /**
+ * __ffs - find first bit in word.
+ * @word: The word to search
+ *
+ * Undefined if no bit exists, so code should check against 0 first.
+ */
+static inline unsigned long __ffs(unsigned long word)
+{
+	__asm__("bsfl %1,%0"
+		:"=r" (word)
+		:"rm" (word));
+	return word;
+}
+
+/**
  * find_first_bit - find the first set bit in a memory region
  * @addr: The address to start the search at
  * @size: The maximum size to search
@@ -320,22 +334,16 @@
  */
 static inline int find_first_bit(const unsigned long *addr, unsigned size)
 {
-	int d0, d1;
-	int res;
-
-	/* This looks at memory. Mark it volatile to tell gcc not to move it around */
-	__asm__ __volatile__(
-		"xorl %%eax,%%eax\n\t"
-		"repe; scasl\n\t"
-		"jz 1f\n\t"
-		"leal -4(%%edi),%%edi\n\t"
-		"bsfl (%%edi),%%eax\n"
-		"1:\tsubl %%ebx,%%edi\n\t"
-		"shll $3,%%edi\n\t"
-		"addl %%edi,%%eax"
-		:"=a" (res), "=&c" (d0), "=&D" (d1)
-		:"1" ((size + 31) >> 5), "2" (addr), "b" (addr) : "memory");
-	return res;
+	int x = 0;
+	do {
+		if (*addr)
+			return __ffs(*addr) + x;
+		addr++;
+		if (x >= size)
+			break;
+		x += 32;
+	} while (1);
+	return x;
 }
 
 /**
@@ -360,20 +368,6 @@
 	return word;
 }
 
-/**
- * __ffs - find first bit in word.
- * @word: The word to search
- *
- * Undefined if no bit exists, so code should check against 0 first.
- */
-static inline unsigned long __ffs(unsigned long word)
-{
-	__asm__("bsfl %1,%0"
-		:"=r" (word)
-		:"rm" (word));
-	return word;
-}
-
 /*
  * fls: find last bit set.
  */


--=-hXlk81j2oYmwRv59IiDG
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

static inline int my_find_first_bit(const unsigned long *b, unsigned size)
{
	int x = 0;
	do {
		if (*b)
			return __ffs(*b) + x;
		b++;
		if (x >= size)
			break;
		x += 32;
	} while (1);
	return x;
}

static inline int my_find_first_bit2(const unsigned long *b, unsigned size)
{
	int x = 0;
	do {
		if (unlikely(*b))
			return __ffs(*b) + x;
		b++;
		if (x >= size)
			break;
		x += 32;
	} while (1);
	return x;
}
#define rdtscll(val) \
	     __asm__ __volatile__("rdtsc" : "=A" (val))

#define rdtsc(low,high) \
	     __asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high))

#define BITSIZE 310
static unsigned long array[((BITSIZE)>>5)+1];

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

	/*
	 * Make sure that the output is correct.
	 */
	printf("ffb=%d  my=%d my2=%d\n",
			find_first_bit(array,BITSIZE),
			my_find_first_bit(array,BITSIZE),
			my_find_first_bit2(array,BITSIZE));

	rdtscll(s);
	for (i=0; i < ITER; i++) 
		x = find_first_bit(array,BITSIZE);
	rdtscll(e);
	t = e - s;
	f = (float)t / (float)clock;
	printf("generic ffb: %08lx:%08lx\n",
			(unsigned long)(t>>32),(unsigned long)t);
	printf("time: %.09fus\n",f);

	rdtscll(s);
	for (i=0; i < ITER; i++) 
		x = my_find_first_bit(array,BITSIZE);
	rdtscll(e);
	t = e - s;
	f = (float)t / (float)clock;
	printf("my ffb: %08lx:%08lx\n",
			(unsigned long)(t>>32),(unsigned long)t);
	printf("time: %.09fus\n",f);

	rdtscll(s);
	for (i=0; i < ITER; i++) 
		x = my_find_first_bit2(array,BITSIZE);
	rdtscll(e);
	t = e - s;
	f = (float)t / (float)clock;
	printf("my ffb 2: %08lx:%08lx\n",
			(unsigned long)(t>>32),(unsigned long)t);
	printf("time: %.09fus\n",f);
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

	printf("\nno bit set\n");
	testit(array,clock);

	array[BITSIZE>>5] = 0x80000000;
	printf("\nlast bit set\n");
	testit(array,clock);

	array[4] = 0x80000000;
	printf("\nmiddle bit set\n");
	testit(array,clock);

	array[0] = 0x00000001;
	printf("\nfirst bit set\n");
	testit(array,clock);
	
	exit(0);
}

--=-hXlk81j2oYmwRv59IiDG--

