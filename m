Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293339AbSCSAYe>; Mon, 18 Mar 2002 19:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293347AbSCSAYT>; Mon, 18 Mar 2002 19:24:19 -0500
Received: from pizda.ninka.net ([216.101.162.242]:62653 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293339AbSCSAX6>;
	Mon, 18 Mar 2002 19:23:58 -0500
Date: Mon, 18 Mar 2002 16:20:31 -0800 (PST)
Message-Id: <20020318.162031.98995076.davem@redhat.com>
To: torvalds@transmeta.com
Cc: Dieter.Nuetzel@hamburg.de, linux-kernel@vger.kernel.org
Subject: Re: 7.52 second kernel compile
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0203181434440.10517-100000@penguin.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Mon, 18 Mar 2002 14:46:04 -0800 (PST)
   
   Or maybe the program is just flawed, and the interesting 1/8 pattern comes 
   from something else altogether.

I think the weird Athlon behavior has to do with the fact that
you've made your little test program as much of a cache tester
as a TLB tester :-)

I've made some modifications to the program:

1) Killed 4096 PAGE_SIZE assumption
2) Size of BUFFER_SIZE made it a cache miss measurement rather
   than a TLB miss measurement tool in certain cases (non-set
   assosciative L2 caches). I've decreased it to 16MB.  But
   see below for more discussion on this.
3) Made tick measurements take into account the cost of
   the tick reads themselves (which typically do flush the
   pipeline on either side of the tick read).  This is computed
   portably before the tests run and the result is used in
   the rdtsc() macro. 
4) Sparc64 rdtsc()

Actually, with non-set assosciative caches, it is often the case that
the TLB can hold entires for more than the size of the L2 cache
_IFF_ we access the first word of each page in the access() loops.

A great fix for this is to offset each access by some cache line
size, I've used 128 for this in my changes.  In this way we are much
less likely to make this turn into a cache miss tester.

I've choosen 16MB for BUFFER_SIZE becuase this amounts to a:

	(16MB / PAGE_SIZE)

such that for the largest normal page size (8192) it gives the
largest number of TLB entries I know any D-TLB has.  This is
1024 entries for UltraSPARC-III's data TLB (it's actually 512
entry, 2 way set assosciative).  I am potentially way off in this
estimate, so if there is some chip Linux runs on which has more
D-TLB entries, please fix up the code and let me know :-)

I have a program called lat_tlb which I wrote a long time ago, it is
very Sparc64 specific and I used it to measure the best case TLB miss
overhead our software TLB refill could get.  Oh, this program also
used jumps into a special assembly file full of "return" instructions
to measure instruction TLB misses as well which I thought was neat.
I can send the lat_tlb sources to anyone who is interested.

On UltraSPARC-III this "best case" data TLB miss cost is ~80 cycles,
on UltraSPARC-I/II/IIi/IIe it is ~50 cycles.

The result of "linus_lattlb" on UltraSPARC-III is:

pagesize: 8192 pageshift: 13 cachelines: 64
tick read overhead is 7
  14.39: 79
  69.48: 93
   8.00: 94
   2.32: 95
   2.26: 105

on all the older UltraSPARCs it is:

pagesize: 8192 pageshift: 13 cachelines: 64
tick read overhead is 5
   5.43: 41
  87.12: 43
   6.37: 48

On my Athlon 1800+ XP I get:

pagesize: 4096 pageshift: 12 cachelines: 32
tick read overhead is 11
  92.95: 16
   1.54: 18
   1.10: 21
   1.10: 28

(Just to make sure, on the Athlon I increased BUFFER_SIZE over and
 over again until it was 128MB, Linus's original value, this
 did not change the results at all)

Below are my changes to "linus_lattlb.c" :-)

To compile on UltraSPARC please add the "-Wa,-Av9a" option to gcc
so that it allows the TICK register read instructions.

Also be sure to compile with -O2 as this can change the results
slightly as well.

--- linus_lattlb.c.~1~	Mon Mar 18 14:13:58 2002
+++ linus_lattlb.c	Mon Mar 18 16:06:38 2002
@@ -1,28 +1,84 @@
 #include <stdlib.h>
 
+#if defined(__i386__)
 #define rdtsc(low) \
-   __asm__ __volatile__("rdtsc" : "=a" (low) : : "edx")
+do {	__asm__ __volatile__("rdtsc" : "=a" (low) : : "edx"); \
+	low -= overhead; \
+} while (0)
+#elif defined(__sparc__)
+#define rdtsc(low) \
+do {    __asm__ __volatile__("rd %%tick, %0" : "=r" (low)); \
+	low -= overhead; \
+} while (0)
+#endif
 
 #define MAXTIMES 1000
-#define BUFSIZE (128*1024*1024)
+#define BUFSIZE (16*1024*1024)
 #define access(x) (*(volatile unsigned int *)&(x))
+#define CACHE_LINE_SIZE	128
+
+#define COMPUTE_INDEX(idx, i)	\
+do {	(idx) = (i) + ((((i)>>pageshift) & (cachelines - 1)) * CACHE_LINE_SIZE); \
+} while (0)
 
 int main()
 {
+	unsigned long overhead, overhead_test, pagesize, pageshift, cachelines;
 	unsigned int i, j;
 	static int times[MAXTIMES];
 	char *buffer = malloc(BUFSIZE);
 
-	for (i = 0; i < BUFSIZE; i += 4096)
-		access(buffer[i]);
+	pagesize = getpagesize();
+	cachelines = (pagesize / CACHE_LINE_SIZE);
+
+	for (i = 0; i < 32; i++)
+		if ((1 << i) == pagesize)
+			break;
+
+	if (i == 32)
+		exit(1);
+
+	pageshift = i;
+	printf("pagesize: %lu pageshift: %lu cachelines: %lu\n",
+	       pagesize, pageshift, cachelines);
+
+	/* Remember, overhead is subtracted from the tick values read
+	 * so we have to calibrate it with a variable of a different
+	 * name.
+	 */
+	overhead = 0UL;
+	overhead_test = ~0UL;
+
+	for (i = 0; i < 8; i++) {
+		unsigned long start, end;
+		rdtsc(start);
+		rdtsc(end);
+		end -= start;
+		if (end < overhead_test)
+			overhead_test = end;
+	}
+	overhead = overhead_test;
+	printf("tick read overhead is %lu\n", overhead);
+
+	for (i = 0; i < BUFSIZE; i += pagesize) {
+		int idx;
+
+		COMPUTE_INDEX(idx, i);
+		access(buffer[idx]);
+	}
+
 	for (i = 0; i < MAXTIMES; i++)
 		times[i] = 0;
+
 	for (j = 0; j < 100; j++) {
-		for (i = 0; i < BUFSIZE ; i+= 4096) {
+		for (i = 0; i < BUFSIZE ; i+= pagesize) {
 			unsigned long start, end;
+			int idx;
+
+			COMPUTE_INDEX(idx, i);
 
 			rdtsc(start);
-			access(buffer[i]);
+			access(buffer[idx]);
 			rdtsc(end);
 			end -= start;
 			if (end >= MAXTIMES)
@@ -32,7 +88,7 @@
 	}
 	for (i = 0; i < MAXTIMES; i++) {
 		int count = times[i];
-		double percent = (double)count / (BUFSIZE/4096);
+		double percent = (double)count / (BUFSIZE/pagesize);
 		if (percent < 1)
 			continue;
 		printf("%7.2f: %d\n", percent, i);


