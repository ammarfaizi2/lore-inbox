Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262890AbTCKKKX>; Tue, 11 Mar 2003 05:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262888AbTCKKKX>; Tue, 11 Mar 2003 05:10:23 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:22774 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262892AbTCKKKF>;
	Tue, 11 Mar 2003 05:10:05 -0500
Message-ID: <3E6DB852.5060603@mvista.com>
Date: Tue, 11 Mar 2003 02:20:02 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>, akpm@digeo.com,
       cobra@compuserve.com, linux-kernel@vger.kernel.org
Subject: Re: Runaway cron task on 2.5.63/4 bk?
References: <Pine.LNX.4.44.0303101529040.20597-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0303101529040.20597-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------050802030900080703070500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------050802030900080703070500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ok, here is what I have.  I changed nano sleep to use a local 64-bit 
value for the target expire time in jiffies.  As much as MAX-INT/2-1 
will be put in the timer at any one time. It loops till the target 
time is met or exceeded.  The changes affect (clock)nanosleep only and 
not timers (they still error out for large values).

Issues:  The conversion of timespec to jiffies_64 is most easily done 
by the asm mpy instruction, which results in the required 64 bit 
result, but C doesn't want to do this sort of thing.  I included a 
header file, originally written for the high-res code, that makes 
several of these functions available, both in an i386 asm version and 
a generic version.  These functions were done mostly to do scaled math 
(hence the name sc_math.h) so I also included a "txt" file for the 
Documentation directory that talks about scaled math and, to some 
extent, about the routines in sc_math.h.

What do you think?

Oh, the code passes the tests I have, but I have not tried to test for 
very large sleep times.  I can think of a couple of test that should 
be done.... tomorrow.

-g


Linus Torvalds wrote:
> On Tue, 11 Mar 2003, Felipe Alfaro Solana wrote:
> 
>> 
>>why not sleep(0)? 
> 
> 
> I think a much more likely (and correct) usage for big sleep values is 
> more something like this:
> 
> 	do_with_timeout(xxx, int timeout)
> 	{
> 		struct timespec ts;
> 
> 		... set up some async event ..
> 		ts.tv_nsec = 0;
> 		ts.tv_sec = timeout;
> 		while (nanosleep(&ts, &ts)) {
> 			if (async event happened)
> 				return happy;
> 		}
> 		.. tear down the async event if it didn't happen ..
> 	}
> 
> and here the natural thing to do in user space is to just make the "no 
> timeout" case be a huge value.
> 
> At which point it is a _bug_ in the kernel if we return early with some 
> random error code.
> 
> 		Linus
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

--------------050802030900080703070500
Content-Type: text/plain;
 name="posix-longsleep-2.5.64-1.0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="posix-longsleep-2.5.64-1.0.patch"

diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.64-kb/Documentation/scaled_math.txt linux/Documentation/scaled_math.txt
--- linux-2.5.64-kb/Documentation/scaled_math.txt	1969-12-31 16:00:00.000000000 -0800
+++ linux/Documentation/scaled_math.txt	2003-03-10 16:41:52.000000000 -0800
@@ -0,0 +1,169 @@
+This file gives a bit of information on scaling integers, the math
+involved, and the considerations needed to decide if and how to use
+scaled math. 
+
+What is it anyway?
+
+Scaled math is a method of doing integer math which allows you to:
+
+A.) Work with fractions in integer math.
+B.) Use MPY instead of DIV (much faster).
+C.) To reduce round off (or digitizing) errors.
+
+Basically, in scaled math you would replace an equation of this sort:
+
+r = foo / bar                or r = foo * top / bar
+
+with this:
+
+r = (foo * SC) / (bar * SC)  or r = (foo * top *SC) / (bar * SC)
+
+Regrouping these:
+
+r = foo * (SC / bar) / SC    or r = foo * ((top *  SC) / bar) / SC
+
+SC is the scale factor.  We choose SC carefully to retain the most bits
+in the calculation and to make the math easy.  We make the math easy by
+making SC be a power of 2 so the * SC and / SC operations are just
+shifts.
+
+
+How does it accomplish all this?
+
+The best way to show the benefits of scaled math is to go through an
+example.  Here is a common problem: During boot up of an 800MHZ machine
+we measure the speed of the machine against the time base.  In the case
+of the i386 machine with a TSC this means we program the PIT for a fixed
+time interval and measure the difference in TSC values over this
+interval.  Suppose we measure this over 0.010 seconds (10 ms).  With
+this particular machine we would get something like 8,000,000 (call this
+TSC-M).  We want to use this number to convert TSC counts to micro
+seconds.  So the math is:
+
+usec = tsccount * 0.01 * 1000000 / TSC-M   or
+usec = tsccount * 10000 / TSC-M
+
+Now the first thing to notice here is that (10000 / TSC-M) is less than
+one and, if we precalculated it we would loose big time.  We might try
+precalculating (TSC-M / 100000) but this also has problems.  First it
+would require a "div" each time we wanted to convert a "tsccount" to
+micro seconds.  The second problem is that the result of this
+precalculation would be on the order of 80, or only 6 to 7 bits so we
+would loose a lot of precision.
+
+The scaled way to do this is to precalculate ((10000 * SC) / TSC-M).  In
+fact this is what is done in the i386 time code.  In this case SC is
+(2**32).  This allows micro seconds to be calculated as:
+
+usec = tsccount * ((10000 * SC) / TSC-M) / SC
+
+where ((10000 * SC) / TSC-M) is a precalculated constant and "/ SC"
+becomes a right shift of 32 bits.  The easy way to do this is to do a
+simple "mul" instruction and take the high order bits as the result.
+I.e. the right shift doesn't even need to be done in this case.
+
+What have we gained here?
+
+The precision is much higher.  The constant will be on the order of
+5,368,709 so we have about 1 bit in 5 million of precision, not bad.
+
+We now do a multiply to do the conversion which is much faster than the
+divide.  Note, also, if we happen to want nano seconds instead of micro
+seconds we could just change the constant term to:
+
+(10000000 * SC) / TSC-M
+
+which has even more precision.  Note here that we are really trying to
+multiply the TSC count by something like 1.25 (or divide it by 0.8) both
+of which are fractions that would loose most of there precision with out
+scaling. 
+
+How to choose SC:
+
+SC has to be chosen carefully to avoid both underflow and overflow.
+
+With the routines provided in the sc_math.h file, the calculations expand
+for a brief moment to 64-bits and then are reduced back to 32-bits.  For
+example, the calculation of ((10000 * SC) / TSC-M) will shift "10000"
+left 32 bits to form a 64-bit numerator for the divide by TSC-M.  SC
+must be chosen so that the result of the divide is no more than 32-bits
+(i.e. does not overflow).  In our example, this defines the slowest
+machine we can handle (10,000 tsc counts in 0.01 sec or 1MHZ).
+
+Like wise, if SC is too small, the result will be too small and
+precision will be lost.
+
+Notes on the sc_math.h functions:
+
+What the sc_math.h functions do is to provide routines that allow usage
+of the ability of the hardware to multiply two integers and return a
+result that is twice the length of the original integers.  At the same
+time it provides access to the divide instruction which can divide a
+64-bit numerator by a 32-bit denominator and return a 32-bit quotient and
+remainder. 
+
+In addition, to help with the scaling, routines are provide that combine
+the common scaling shift operation with the multiply or divide.
+
+Since (2**32) is a common scaling, functions to deal with it most
+efficiently are provided.
+
+Functions that allow easy calculation of conversion constants at compile
+time are also provided.
+
+Details:
+
+All the functions work with unsigned long or unsigned long long.  We
+leave it for another day to do the signed versions.  Also, we have
+provided a generic sc_math.h file.  This begs for each 32-bit arch to
+supply an asm version which will be much more efficient.
+
+SC_32(x) given an integer (or long) returns  (unsigned long long)x<<32 
+SC_n(n,x) given an integer (or long) returns  (unsigned long long)x<<n
+
+These may be used to form constants at compile time, e.g.:
+
+unsigned long sc_constant = SC_n(24, (constant expression)) / constant;
+
+mpy_sc32(unsigned long a, unsigned long b); returns (a * b) >> 32
+
+mpy_sc24(unsigned long a, unsigned long b); returns (a * b) >> 24
+
+mpy_sc_n(const N, unsigned long a, unsigned long b); returns (a * b) >> N
+
+Note: N must be a constant here.
+
+div_sc32(unsigned long a, unsigned long b); returns (a << 32) / b
+
+div_sc24(unsigned long a, unsigned long b); returns (a << 24) / b
+
+div_sc_n(const N, unsigned long a, unsigned long b); returns (a << N) / b
+
+Note: N must be a constant here.
+
+In addition, the following functions provide access to the mpy and div
+instructions:
+
+mpy_l_X_l_ll(unsigned long mpy1, unsigned long mpy2); 
+returns (unsigned long long)(mpy1 * mpy2)
+
+mpy_l_X_l_h(unsigned long mpy1, unsigned long mpy2, unsigned long *hi);
+returns (unsigned long)(mpy1 * mpy2) & 0xffffffff  and 
+        (unsigned long)(mpy1 * mpy2) >> 32 in hi
+
+mpy_ll_X_l_ll(unsigned long long  mpy1, unsigned long mpy2);
+returns (unsigned long long)(mpy1 * mpy2)
+
+Note: The long long mpy1, this routine allows a string of mpys where it
+is undetermined where the result becomes long long.
+
+div_ll_X_l_rem(unsigned long long divs, unsigned long div, unsigned long *rem);
+returns (unsigned long)(divs/div) 
+with the remainder in rem
+
+div_long_long_rem() is an alias for the above.
+
+div_h_or_l_X_l_rem(unsigned long divh, unsigned long divl, 
+		   unsigned long div, unsigned long *rem)
+returns (unsigned long)((divh << 32) | divl) / div 
+with the remainder in rem
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.64-kb/include/asm-generic/sc_math.h linux/include/asm-generic/sc_math.h
--- linux-2.5.64-kb/include/asm-generic/sc_math.h	1969-12-31 16:00:00.000000000 -0800
+++ linux/include/asm-generic/sc_math.h	2003-03-10 16:41:52.000000000 -0800
@@ -0,0 +1,311 @@
+#ifndef SC_MATH_GENERIC
+#define SC_MATH_GENERIC
+/*
+ * These are the generic scaling functions for machines which
+ * do not yet have the arch asm versions (or for the 64-bit
+ * long systems)
+ */
+/*
+ * Pre scaling defines
+ */
+#define SC_32(x) ((unsigned long long)(x) << 32)
+#define SC_n(n,x) (((unsigned long long)(x)) << (n))
+
+#if (BITS_PER_LONG < 64)
+
+#define SCC_SHIFT 16
+#define SCC_MASK ((1 << SCC_SHIFT) -1)
+/*
+ * mpy a long by a long and return a long long
+ */
+
+extern inline long long mpy_l_X_l_ll(unsigned long mpy1,unsigned long mpy2)
+{
+	unsigned long low1 = (unsigned) (mpy1 & SCC_MASK);
+	unsigned long high1 =  (mpy1 >> SCC_SHIFT);
+	unsigned long low2 = (unsigned) (mpy2 & SCC_MASK);
+	unsigned long high2 =  (mpy2 >> SCC_SHIFT);
+
+	unsigned long long cross = (low1 * high2) + (high1 * low2);
+
+        return 	(((long long)(high1 * high2)) << (SCC_SHIFT + SCC_SHIFT)) + 
+		(cross << SCC_SHIFT) +
+	        (low1 * low2);
+
+}
+/*
+ * mpy a long long by a long and return a long long
+ */
+
+extern inline long long mpy_ll_X_l_ll(unsigned long long mpy1,
+				      unsigned long mpy2)
+{
+	long long result = mpy_l_X_l_ll((unsigned long)mpy1, mpy2);
+	result +=  (mpy_l_X_l_ll((long)(mpy1 >> 32), mpy2) << 32);
+	return result;
+}
+/*
+ * mpy a long by a long and return the low part and a seperate hi part
+ */
+
+
+extern inline unsigned long  mpy_l_X_l_h(unsigned long mpy1,
+				unsigned long mpy2,
+				unsigned long *hi)
+{
+	unsigned long long it = mpy_l_X_l_ll(mpy1, mpy2);
+	*hi = (unsigned long)(it >> 32);
+        return (unsigned long)it;
+
+}
+/*
+ * This routine preforms the following calculation:
+ *
+ * X = (a*b)>>32
+ * we could, (but don't) also get the part shifted out.
+ */
+extern inline unsigned long mpy_sc32(unsigned long a,unsigned long b)
+{
+        return (unsigned long)(mpy_l_X_l_ll(a, b) >> 32);
+}
+/*
+ * X = (a/b)<<32 or more precisely x = (a<<32)/b
+ */
+#include <asm/div64.h>
+#if 0  // maybe one day we will do signed numbers...
+/*
+ * do_div doesn't handle signed numbers, so:
+ */
+#define do_div_signed(result, div)					\
+({									\
+        long rem, flip = 0;						\
+	if (result < 0){						\
+		result = -result;					\
+		flip = 2;                 /* flip rem & result sign*/	\
+		if (div < 0){						\
+			div = -div;					\
+			flip--;          /* oops, just flip rem */	\
+		}							\
+	}								\
+	rem = do_div(result,div);					\
+	rem = flip ? -rem : rem;					\
+	if ( flip == 2)							\
+		result = -result;					\
+	rem;								\
+})
+#endif
+
+extern inline unsigned long div_sc32(unsigned long a, unsigned long b)
+{
+	unsigned long long result = SC_32(a);
+	do_div(result, b);
+        return (unsigned long)result;
+}
+/*
+ * X = (a*b)>>24
+ * we could, (but don't) also get the part shifted out.
+ */
+
+#define mpy_sc24(a,b) mpy_sc_n(24,(a),(b))
+/*
+ * X = (a/b)<<24 or more precisely x = (a<<24)/b
+ */
+#define div_sc24(a,b) div_sc_n(24,(a),(b))
+
+/*
+ * The routines allow you to do x = ((a<< N)/b) and
+ * x=(a*b)>>N for values of N from 1 to 32.
+ *
+ * These are handy to have to do scaled math.
+ * Scaled math has two nice features:
+ * A.) A great deal more precision can be maintained by
+ *     keeping more signifigant bits.
+ * B.) Often an in line div can be replaced with a mpy
+ *     which is a LOT faster.
+ */
+
+/* x = (aa * bb) >> N */
+
+
+#define mpy_sc_n(N,aa,bb) ({(unsigned long)(mpy_l_X_l_ll((aa), (bb)) >> (N));})
+
+/* x = (aa << N / bb)  */
+#define div_sc_n(N,aa,bb) ({unsigned long long result = SC_n((N), (aa)); \
+                            do_div(result, (bb)); \
+                            (long)result;})  
+
+  
+/*
+ * (long)X = ((long long)divs) / (long)div
+ * (long)rem = ((long long)divs) % (long)div
+ *
+ * Warning, this will do an exception if X overflows.
+ * Well, it would if done in asm, this code just truncates..
+ */
+#define div_long_long_rem(a,b,c) div_ll_X_l_rem((a),(b),(c))
+
+/* x = divs / div; *rem = divs % div; */
+extern inline unsigned long div_ll_X_l_rem(unsigned long long divs, 
+					   unsigned long div, 
+					   unsigned long * rem)
+{
+	unsigned long long it = divs;
+	*rem = do_div(it, div);
+	return (unsigned long)it;
+}
+/*
+ * same as above, but no remainder
+ */
+extern inline unsigned long div_ll_X_l(unsigned long long divs, 
+				       unsigned long div)
+{
+	unsigned long long it = divs;
+        do_div(it, div);
+        return (unsigned long)it;
+}
+/*
+ * (long)X = (((long)divh<<32) | (long)divl) / (long)div
+ * (long)rem = (((long)divh<<32) % (long)divl) / (long)div
+ *
+ * Warning, this will do an exception if X overflows.
+ * Well, it would if done in asm, this code just truncates..
+ */
+extern inline unsigned long div_h_or_l_X_l_rem(unsigned long divh,
+					       unsigned long divl, 
+					       unsigned long div,
+					       unsigned long* rem)
+{
+	unsigned long long result = SC_32(divh) + (divl);
+
+        return div_ll_X_l_rem(result, (div), (rem));
+
+}
+#else
+/* The 64-bit long version */
+
+/* 
+ * The 64-bit long machine can do most of these in native C.  We assume that 
+ * the "long long" of 32-bit machines is typedefed away so the we need only
+ * deal with longs.  This code should be tight enought that asm code is not
+ * needed.
+ */
+
+/*
+ * mpy a long by a long and return a long
+ */
+
+extern inline unsigned long mpy_l_X_l_ll(unsigned long mpy1, unsigned long mpy2)
+{
+
+        return (mpy1) * (mpy2);
+
+}
+/*
+ * mpy a long by a long and return the low part and a separate hi part
+ * This code always returns 32 values... may not be what you want...
+ */
+
+
+extern inline unsigned long  mpy_l_X_l_h(unsigned long mpy1,
+					 unsigned long mpy2,
+					 unsigned long *hi)
+{
+	unsigned long it = mpy1 * mpy2;
+	*hi = (it >> 32);
+        return it & 0xffffffff;
+
+}
+/*
+ * This routine preforms the following calculation:
+ *
+ * X = (a*b)>>32
+ * we could, (but don't) also get the part shifted out.
+ */
+extern inline unsigned long mpy_sc32(unsigned long a, unsigned long b)
+{
+        return (mpy1 * mpy2) >> 32);
+}
+/*
+ * X = (a/b)<<32 or more precisely x = (a<<32)/b
+ */
+
+extern inline long div_sc32(long a, long b)
+{
+	return  SC_32(a) / (b);
+}
+/*
+ * X = (a*b)>>24
+ * we could, (but don't) also get the part shifted out.
+ */
+
+#define mpy_sc24(a,b) mpy_sc_n(24,a,b)
+/*
+ * X = (a/b)<<24 or more precisely x = (a<<24)/b
+ */
+#define div_sc24(a,b) div_sc_n(24,a,b)
+
+/*
+ * The routines allow you to do x = ((a<< N)/b) and
+ * x=(a*b)>>N for values of N from 1 to 32.
+ *
+ * These are handy to have to do scaled math.
+ * Scaled math has two nice features:
+ * A.) A great deal more precision can be maintained by
+ *     keeping more signifigant bits.
+ * B.) Often an in line div can be replaced with a mpy
+ *     which is a LOT faster.
+ */
+
+/* x = (aa * bb) >> N */
+
+
+#define mpy_sc_n(N,aa,bb) ((aa) * (bb)) >> N)
+
+/* x = (aa << N / bb)  */
+#define div_sc_n(N,aa,bb) (SC_n((N), (aa)) / (bb))
+
+  
+/*
+ * (long)X = ((long long)divs) / (long)div
+ * (long)rem = ((long long)divs) % (long)div
+ *
+ * Warning, this will do an exception if X overflows.
+ * Well, it would if done in asm, this code just truncates..
+ */
+#define div_long_long_rem(a,b,c) div_ll_X_l_rem(a, b, c)
+
+/* x = divs / div; *rem = divs % div; */
+extern inline unsigned long div_ll_X_l_rem(unsigned long divs, 
+					   unsigned long div, 
+					   unsigned long * rem)
+{
+	*rem = divs % div;
+	return divs / div;
+}
+/*
+ * same as above, but no remainder
+ */
+extern inline unsigned long div_ll_X_l(unsigned long divs, 
+				       unsigned long div)
+{
+        return divs / div;
+}
+/*
+ * (long)X = (((long)divh<<32) | (long)divl) / (long)div
+ * (long)rem = (((long)divh<<32) % (long)divl) / (long)div
+ *
+ * Warning, this will do an exception if X overflows.
+ * Well, it would if done in asm, this code just truncates..
+ */
+extern inline unsigned long div_h_or_l_X_l_rem(unsigned long divh,
+					       unsigned long divl, 
+					       unsigned long div,
+					       unsigned long* rem)
+{
+	long result = SC_32(divh) + divl;
+
+        return div_ll_X_l_rem(result, div, rem);
+
+}
+#endif  // else(BITS_PER_LONG < 64)
+#endif
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.64-kb/include/asm-i386/sc_math.h linux/include/asm-i386/sc_math.h
--- linux-2.5.64-kb/include/asm-i386/sc_math.h	1969-12-31 16:00:00.000000000 -0800
+++ linux/include/asm-i386/sc_math.h	2003-03-10 16:41:52.000000000 -0800
@@ -0,0 +1,152 @@
+#ifndef SC_MATH
+#define SC_MATH
+
+#define MATH_STR(X) #X
+#define MATH_NAME(X) X
+
+
+/*
+ * Pre scaling defines
+ */
+#define SC_32(x) ((unsigned long long)x<<32)
+#define SC_n(n,x) (((unsigned long long)x)<<n)
+/*
+ * This routine preforms the following calculation:
+ *
+ * X = (a*b)>>32
+ * we could, (but don't) also get the part shifted out.
+ */
+extern inline unsigned long
+mpy_sc32(unsigned long a, unsigned long b)
+{
+	long edx;
+      __asm__("mull %2":"=a"(a), "=d"(edx)
+      :	"rm"(b), "0"(a));
+	return edx;
+}
+/*
+ * X = (a/b)<<32 or more precisely x = (a<<32)/b
+ */
+
+extern inline unsigned long
+div_sc32(unsigned long a, unsigned long b)
+{
+	unsigned long dum;
+      __asm__("divl %2":"=a"(b), "=d"(dum)
+      :	"r"(b), "0"(0), "1"(a));
+
+	return b;
+}
+/*
+ * X = (a*b)>>24
+ * we could, (but don't) also get the part shifted out.
+ */
+
+#define mpy_sc24(a,b) mpy_sc_n(24,a,b)
+/*
+ * X = (a/b)<<24 or more precisely x = (a<<24)/b
+ */
+#define div_sc24(a,b) div_sc_n(24,a,b)
+
+/*
+ * The routines allow you to do x = (a/b) << N and
+ * x=(a*b)>>N for values of N from 1 to 32.
+ *
+ * These are handy to have to do scaled math.
+ * Scaled math has two nice features:
+ * A.) A great deal more precision can be maintained by
+ *     keeping more signifigant bits.
+ * B.) Often an in line div can be repaced with a mpy
+ *     which is a LOT faster.
+ */
+
+#define mpy_sc_n(N,aa,bb) ({unsigned long edx, a=aa, b=bb; \
+	__asm__("mull %2\n\t" \
+                "shldl $(32-"MATH_STR(N)"), %0, %1"    \
+		:"=a" (a), "=d" (edx)\
+		:"rm" (b),            \
+		 "0" (a)); edx;})
+
+#define div_sc_n(N,aa,bb) ({unsigned long dum=aa, dum2, b=bb; \
+        __asm__("shrdl $(32-"MATH_STR(N)"), %4, %3\n\t"  \
+                "sarl $(32-"MATH_STR(N)"), %4\n\t"      \
+                "divl %2"              \
+                :"=a" (dum2), "=d" (dum)      \
+                :"rm" (b), "0" (0), "1" (dum)); dum2;})
+
+/*
+ * (long)X = ((long long)divs) / (long)div
+ * (long)rem = ((long long)divs) % (long)div
+ *
+ * Warning, this will do an exception if X overflows.
+ */
+#define div_long_long_rem(a, b, c) div_ll_X_l_rem(a, b, c)
+
+extern inline unsigned long
+div_ll_X_l_rem(unsigned long long divs, unsigned long div, unsigned long *rem)
+{
+	unsigned long dum2;
+      __asm__("divl %2":"=a"(dum2), "=d"(*rem)
+      :	"rm"(div), "A"(divs));
+
+	return dum2;
+
+}
+/*
+ * same as above, but no remainder
+ */
+extern inline unsigned long
+div_ll_X_l(unsigned long long divs, unsigned long div)
+{
+	unsigned long dum;
+	return div_ll_X_l_rem(divs, div, &dum);
+}
+/*
+ * (long)X = (((long)divh<<32) | (long)divl) / (long)div
+ * (long)rem = (((long)divh<<32) % (long)divl) / (long)div
+ *
+ * Warning, this will do an exception if X overflows.
+ */
+extern inline unsigned long
+div_h_or_l_X_l_rem(unsigned long divh, unsigned long divl, 
+		   unsigned long div, unsigned long *rem)
+{
+	unsigned long dum2;
+      __asm__("idivl %2":"=a"(dum2), "=d"(*rem)
+      :	"rm"(div), "0"(divl), "1"(divh));
+
+	return dum2;
+
+}
+extern inline unsigned long long
+mpy_l_X_l_ll(unsigned long mpy1, unsigned long mpy2)
+{
+	unsigned long long eax;
+      __asm__("mull %1\n\t":"=A"(eax)
+      :	"rm"(mpy2), "a"(mpy1));
+
+	return eax;
+
+}
+extern inline unsigned long
+mpy_l_X_l_h(unsigned long mpy1, unsigned long mpy2, unsigned long *hi)
+{
+	long eax;
+      __asm__("mull %2\n\t":"=a"(eax), "=d"(*hi)
+      :	"rm"(mpy2), "0"(mpy1));
+
+	return eax;
+
+}
+/*
+ * mpy a unsigned long long by a unsigned long and return a unsigned long long 
+ */
+extern inline unsigned long long 
+mpy_ll_X_l_ll(unsigned long long  mpy1, unsigned long mpy2)
+{
+	unsigned long long result = mpy_l_X_l_ll((unsigned long)mpy1, mpy2);
+	result +=  (mpy_l_X_l_ll((long)(mpy1 >> 32), mpy2) << 32);
+	return result;
+}
+
+#endif
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.64-kb/include/linux/thread_info.h linux/include/linux/thread_info.h
--- linux-2.5.64-kb/include/linux/thread_info.h	2002-12-11 06:25:32.000000000 -0800
+++ linux/include/linux/thread_info.h	2003-03-10 16:39:52.000000000 -0800
@@ -12,7 +12,7 @@
  */
 struct restart_block {
 	long (*fn)(struct restart_block *);
-	unsigned long arg0, arg1, arg2;
+	unsigned long arg0, arg1, arg2, arg3;
 };
 
 extern long do_no_restart_syscall(struct restart_block *parm);
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.64-kb/kernel/posix-timers.c linux/kernel/posix-timers.c
--- linux-2.5.64-kb/kernel/posix-timers.c	2003-03-05 15:10:40.000000000 -0800
+++ linux/kernel/posix-timers.c	2003-03-11 00:38:41.000000000 -0800
@@ -23,6 +23,7 @@
 #include <linux/compiler.h>
 #include <linux/idr.h>
 #include <linux/posix-timers.h>
+#include <asm/sc_math.h>
 
 #ifndef div_long_long_rem
 #include <asm/div64.h>
@@ -183,7 +184,7 @@
 __initcall(init_posix_timers);
 
 static inline int
-tstojiffie(struct timespec *tp, int res, unsigned long *jiff)
+tstojiffie(struct timespec *tp, int res, u64 *jiff)
 {
 	unsigned long sec = tp->tv_sec;
 	long nsec = tp->tv_nsec + res - 1;
@@ -203,7 +204,7 @@
 	 * below.  Here it is enough to just discard the high order
 	 * bits.  
 	 */
-	*jiff = HZ * sec;
+	*jiff = mpy_l_X_l_ll(HZ, sec);
 	/*
 	 * Do the res thing. (Don't forget the add in the declaration of nsec) 
 	 */
@@ -221,9 +222,12 @@
 static void
 tstotimer(struct itimerspec *time, struct k_itimer *timer)
 {
+	u64 result;
 	int res = posix_clocks[timer->it_clock].res;
-	tstojiffie(&time->it_value, res, &timer->it_timer.expires);
-	tstojiffie(&time->it_interval, res, &timer->it_incr);
+	tstojiffie(&time->it_value, res, &result);
+	timer->it_timer.expires = (unsigned long)result;
+	tstojiffie(&time->it_interval, res, &result);
+	timer->it_incr = (unsigned long)result;
 }
 
 static void
@@ -1020,6 +1024,9 @@
  * Note also that the while loop assures that the sub_jiff_offset
  * will be less than a jiffie, thus no need to normalize the result.
  * Well, not really, if called with ints off :(
+
+ * HELP, this code should make an attempt at resolution beyond the 
+ * jiffie.  Trouble is this is "arch" dependent...
  */
 
 int
@@ -1208,6 +1215,7 @@
 	struct timespec t;
 	struct timer_list new_timer;
 	struct abs_struct abs_struct = { .list = { .next = 0 } };
+	u64 rq_time = 0;
 	int abs;
 	int rtn = 0;
 	int active;
@@ -1226,11 +1234,12 @@
 		 * time and continue.
 		 */
 		restart_block->fn = do_no_restart_syscall;
-		if (!restart_block->arg2)
-			return -EINTR;
 
-		new_timer.expires = restart_block->arg2;
-		if (time_before(new_timer.expires, jiffies))
+		rq_time = restart_block->arg3;
+		rq_time = (rq_time << 32) + restart_block->arg2;
+		if (!rq_time)
+			return -EINTR;
+		if (rq_time <= get_jiffies_64())
 			return 0;
 	}
 
@@ -1243,37 +1252,37 @@
 	}
 	do {
 		t = *tsave;
-		if ((abs || !new_timer.expires) &&
-		    !(rtn = adjust_abs_time(&posix_clocks[which_clock],
-					    &t, abs))) {
-			/*
-			 * On error, we don't set up the timer so
-			 * we don't arm the timer so
-			 * del_timer_sync() will return 0, thus
-			 * active is zero... and so it goes.
-			 */
+		if (abs || !rq_time){
+			adjust_abs_time(&posix_clocks[which_clock], &t, abs);
 
-			tstojiffie(&t,
-				   posix_clocks[which_clock].res,
-				   &new_timer.expires);
+			tstojiffie(&t, posix_clocks[which_clock].res, &rq_time);
 		}
-		if (new_timer.expires) {
-			current->state = TASK_INTERRUPTIBLE;
-			add_timer(&new_timer);
-
-			schedule();
+#if (BITS_PER_LONG < 64)
+		if ((rq_time - get_jiffies_64()) > MAX_JIFFY_OFFSET){
+			new_timer.expires = MAX_JIFFY_OFFSET;
+		}else
+#endif
+		{
+			new_timer.expires = (long)rq_time;
 		}
+		current->state = TASK_INTERRUPTIBLE;
+		add_timer(&new_timer);
+
+		schedule();
 	}
-	while ((active = del_timer_sync(&new_timer)) &&
+	while ((active = del_timer_sync(&new_timer) || 
+		rq_time > get_jiffies_64()) &&
 	       !test_thread_flag(TIF_SIGPENDING));
 
+
 	if (abs_struct.list.next) {
 		spin_lock_irq(&nanosleep_abs_list_lock);
 		list_del(&abs_struct.list);
 		spin_unlock_irq(&nanosleep_abs_list_lock);
 	}
 	if (active) {
-		unsigned long jiffies_f = jiffies;
+		s64 left;
+		unsigned long rmd;
 
 		/*
 		 * Always restart abs calls from scratch to pick up any
@@ -1282,20 +1291,19 @@
 		if (abs)
 			return -ERESTARTNOHAND;
 
-		jiffies_to_timespec(new_timer.expires - jiffies_f, tsave);
+		left = rq_time - get_jiffies_64();
+		if (left < 0)
+			return 0;
+
+		tsave->tv_sec = div_long_long_rem(left, HZ, &rmd);
+		tsave->tv_nsec = rmd * (NSEC_PER_SEC / HZ);
 
-		while (tsave->tv_nsec < 0) {
-			tsave->tv_nsec += NSEC_PER_SEC;
-			tsave->tv_sec--;
-		}
-		if (tsave->tv_sec < 0) {
-			tsave->tv_sec = 0;
-			tsave->tv_nsec = 1;
-		}
 		restart_block->fn = clock_nanosleep_restart;
 		restart_block->arg0 = which_clock;
 		restart_block->arg1 = (unsigned long)tsave;
-		restart_block->arg2 = new_timer.expires;
+		restart_block->arg2 = rq_time & 0xffffffffLL;
+		restart_block->arg3 = rq_time >> 32;
+
 		return -ERESTART_RESTARTBLOCK;
 	}
 
Binary files linux-2.5.64-kb/lib/gen_crc32table and linux/lib/gen_crc32table differ
Binary files linux-2.5.64-kb/scripts/docproc and linux/scripts/docproc differ
Binary files linux-2.5.64-kb/scripts/fixdep and linux/scripts/fixdep differ
Binary files linux-2.5.64-kb/scripts/kallsyms and linux/scripts/kallsyms differ
Binary files linux-2.5.64-kb/scripts/mk_elfconfig and linux/scripts/mk_elfconfig differ
Binary files linux-2.5.64-kb/scripts/modpost and linux/scripts/modpost differ
Binary files linux-2.5.64-kb/usr/gen_init_cpio and linux/usr/gen_init_cpio differ
Binary files linux-2.5.64-kb/usr/initramfs_data.cpio.gz and linux/usr/initramfs_data.cpio.gz differ

--------------050802030900080703070500--

