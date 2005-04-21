Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVDUDmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVDUDmW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 23:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVDUDmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 23:42:21 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:53697 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261198AbVDUDkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 23:40:33 -0400
Subject: Re: [PATCH] Bad rounding in timeval_to_jiffies [was: Re: Odd Timer
	behavior in 2.6 vs 2.4  (1 extra tick)]
From: Steven Rostedt <rostedt@goodmis.org>
To: jdavis@accessline.com
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1114052315.5058.13.camel@localhost.localdomain>
References: <E29E71BB437ED411B12A0008C7CF755B2BC9BE@mail.accessline.com>
	 <1114052315.5058.13.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-zHpcEWRaWxCCTN8zs9ZT"
Organization: Kihon Technologies
Date: Wed, 20 Apr 2005 23:40:16 -0400
Message-Id: <1114054816.5996.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zHpcEWRaWxCCTN8zs9ZT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-04-20 at 22:58 -0400, Steven Rostedt wrote:
> I looked into the problem that jdavis had and found that the conversion
> of the timeval_to_jiffies was off by one. 
> 
> To convert tv.tv_sec = 0, tv.tv_usec = 10000 to jiffies, you come up
> with an answer of 11 (assuming 1000 HZ).  
> 

OK, this bothered me that this patch seems to work, since the comments
around the USEC_ROUND seem to make sense. So I looked more closely into
this.

Is 11 jiffies correct for 10ms?  Since the the USEC_CONVERSION contains
a TICK_NSEC which is suppose to (I believe) convert the number of CPU
ticks to nanoseconds.  Since ticks don't map nicely to nanoseconds there
can be a discrepancy for the actual time.  But this doesn't explain why
the patch changes everything into the desired result, assuming that
 10 ms == 10 jiffies.  

Maybe there's too much rounding going on.  I'll have to take a deeper
look into this, but feel free to look yourselves! I'm going to bed.

I've attached my userland program if you want to play around with the
numbers.

> Here's the patch:
> 
> --- ./include/linux/jiffies.h.orig	2005-04-20 22:30:34.000000000 -0400
> +++ ./include/linux/jiffies.h	2005-04-20 22:39:42.000000000 -0400
> @@ -231,7 +231,7 @@
>   * in jiffies (albit scaled), it is nothing but the bits we will shift
>   * off.
>   */
> -#define USEC_ROUND (u64)(((u64)1 << USEC_JIFFIE_SC) - 1)
> +#define USEC_ROUND (u64)(((u64)1 << (USEC_JIFFIE_SC - 1)))
>  /*
>   * The maximum jiffie value is (MAX_INT >> 1).  Here we translate that
>   * into seconds.  The 64-bit case will overflow if we are not careful,

-- Steve


--=-zHpcEWRaWxCCTN8zs9ZT
Content-Disposition: attachment; filename=jiffies.c
Content-Type: text/x-csrc; name=jiffies.c; charset=us-ascii
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef unsigned long long u64;

#define HZ 1000

#ifndef div_long_long_rem
#define div_long_long_rem(dividend,divisor,remainder) \
({							\
	u64 result = dividend;				\
	*remainder = do_div(result,divisor);		\
	result;						\
})
#endif

#  define CLOCK_TICK_RATE 1193182 /* Underlying HZ */
#define NSEC_PER_SEC (1000000000L)
#define NSEC_PER_USEC (1000L)

/*
 * The following defines establish the engineering parameters of the PLL
 * model. The HZ variable establishes the timer interrupt frequency, 100 Hz
 * for the SunOS kernel, 256 Hz for the Ultrix kernel and 1024 Hz for the
 * OSF/1 kernel. The SHIFT_HZ define expresses the same value as the
 * nearest power of two in order to avoid hardware multiply operations.
 */
#if HZ >= 12 && HZ < 24
# define SHIFT_HZ	4
#elif HZ >= 24 && HZ < 48
# define SHIFT_HZ	5
#elif HZ >= 48 && HZ < 96
# define SHIFT_HZ	6
#elif HZ >= 96 && HZ < 192
# define SHIFT_HZ	7
#elif HZ >= 192 && HZ < 384
# define SHIFT_HZ	8
#elif HZ >= 384 && HZ < 768
# define SHIFT_HZ	9
#elif HZ >= 768 && HZ < 1536
# define SHIFT_HZ	10
#else
# error You lose.
#endif

/* LATCH is used in the interval timer and ftape setup. */
#define LATCH  ((CLOCK_TICK_RATE + HZ/2) / HZ)	/* For divider */

/* Suppose we want to devide two numbers NOM and DEN: NOM/DEN, the we can
 * improve accuracy by shifting LSH bits, hence calculating:
 *     (NOM << LSH) / DEN
 * This however means trouble for large NOM, because (NOM << LSH) may no
 * longer fit in 32 bits. The following way of calculating this gives us
 * some slack, under the following conditions:
 *   - (NOM / DEN) fits in (32 - LSH) bits.
 *   - (NOM % DEN) fits in (32 - LSH) bits.
 */
#define SH_DIV(NOM,DEN,LSH) (   ((NOM / DEN) << LSH)                    \
                             + (((NOM % DEN) << LSH) + DEN / 2) / DEN)

/* HZ is the requested value. ACTHZ is actual HZ ("<< 8" is for accuracy) */
#define ACTHZ (SH_DIV (CLOCK_TICK_RATE, LATCH, 8))

/* TICK_NSEC is the time between ticks in nsec assuming real ACTHZ */
#define TICK_NSEC (SH_DIV (1000000UL * 1000, ACTHZ, 8))

/* TICK_USEC is the time between ticks in usec assuming fake USER_HZ */
#define TICK_USEC ((1000000UL + USER_HZ/2) / USER_HZ)

/* TICK_USEC_TO_NSEC is the time between ticks in nsec assuming real ACTHZ and	*/
/* a value TUSEC for TICK_USEC (can be set bij adjtimex)		*/
#define TICK_USEC_TO_NSEC(TUSEC) (SH_DIV (TUSEC * USER_HZ * 1000, ACTHZ, 8))

/* some arch's have a small-data section that can be accessed register-relative
 * but that can only take up to, say, 4-byte variables. jiffies being part of
 * an 8-byte variable may not be correctly accessed unless we force the issue
 */
#define __jiffy_data  __attribute__((section(".data")))

/*
 * The 64-bit value is not volatile - you MUST NOT read it
 * without sampling the sequence number in xtime_lock.
 * get_jiffies_64() will do this for you as appropriate.
 */
extern u64 __jiffy_data jiffies_64;
extern unsigned long volatile __jiffy_data jiffies;

#if (BITS_PER_LONG < 64)
u64 get_jiffies_64(void);
#else
static inline u64 get_jiffies_64(void)
{
	return (u64)jiffies;
}
#endif

/*
 *	These inlines deal with timer wrapping correctly. You are 
 *	strongly encouraged to use them
 *	1. Because people otherwise forget
 *	2. Because if the timer wrap changes in future you won't have to
 *	   alter your driver code.
 *
 * time_after(a,b) returns true if the time a is after time b.
 *
 * Do this with "<0" and ">=0" to only test the sign of the result. A
 * good compiler would generate better code (and a really good compiler
 * wouldn't care). Gcc is currently neither.
 */
#define time_after(a,b)		\
	(typecheck(unsigned long, a) && \
	 typecheck(unsigned long, b) && \
	 ((long)(b) - (long)(a) < 0))
#define time_before(a,b)	time_after(b,a)

#define time_after_eq(a,b)	\
	(typecheck(unsigned long, a) && \
	 typecheck(unsigned long, b) && \
	 ((long)(a) - (long)(b) >= 0))
#define time_before_eq(a,b)	time_after_eq(b,a)

/*
 * Have the 32 bit jiffies value wrap 5 minutes after boot
 * so jiffies wrap bugs show up earlier.
 */
#define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))

/*
 * Change timeval to jiffies, trying to avoid the
 * most obvious overflows..
 *
 * And some not so obvious.
 *
 * Note that we don't want to return MAX_LONG, because
 * for various timeout reasons we often end up having
 * to wait "jiffies+1" in order to guarantee that we wait
 * at _least_ "jiffies" - so "jiffies+1" had better still
 * be positive.
 */
#define MAX_JIFFY_OFFSET ((~0UL >> 1)-1)

/*
 * We want to do realistic conversions of time so we need to use the same
 * values the update wall clock code uses as the jiffies size.  This value
 * is: TICK_NSEC (which is defined in timex.h).  This
 * is a constant and is in nanoseconds.  We will used scaled math
 * with a set of scales defined here as SEC_JIFFIE_SC,  USEC_JIFFIE_SC and
 * NSEC_JIFFIE_SC.  Note that these defines contain nothing but
 * constants and so are computed at compile time.  SHIFT_HZ (computed in
 * timex.h) adjusts the scaling for different HZ values.

 * Scaled math???  What is that?
 *
 * Scaled math is a way to do integer math on values that would,
 * otherwise, either overflow, underflow, or cause undesired div
 * instructions to appear in the execution path.  In short, we "scale"
 * up the operands so they take more bits (more precision, less
 * underflow), do the desired operation and then "scale" the result back
 * by the same amount.  If we do the scaling by shifting we avoid the
 * costly mpy and the dastardly div instructions.

 * Suppose, for example, we want to convert from seconds to jiffies
 * where jiffies is defined in nanoseconds as NSEC_PER_JIFFIE.  The
 * simple math is: jiff = (sec * NSEC_PER_SEC) / NSEC_PER_JIFFIE; We
 * observe that (NSEC_PER_SEC / NSEC_PER_JIFFIE) is a constant which we
 * might calculate at compile time, however, the result will only have
 * about 3-4 bits of precision (less for smaller values of HZ).
 *
 * So, we scale as follows:
 * jiff = (sec) * (NSEC_PER_SEC / NSEC_PER_JIFFIE);
 * jiff = ((sec) * ((NSEC_PER_SEC * SCALE)/ NSEC_PER_JIFFIE)) / SCALE;
 * Then we make SCALE a power of two so:
 * jiff = ((sec) * ((NSEC_PER_SEC << SCALE)/ NSEC_PER_JIFFIE)) >> SCALE;
 * Now we define:
 * #define SEC_CONV = ((NSEC_PER_SEC << SCALE)/ NSEC_PER_JIFFIE))
 * jiff = (sec * SEC_CONV) >> SCALE;
 *
 * Often the math we use will expand beyond 32-bits so we tell C how to
 * do this and pass the 64-bit result of the mpy through the ">> SCALE"
 * which should take the result back to 32-bits.  We want this expansion
 * to capture as much precision as possible.  At the same time we don't
 * want to overflow so we pick the SCALE to avoid this.  In this file,
 * that means using a different scale for each range of HZ values (as
 * defined in timex.h).
 *
 * For those who want to know, gcc will give a 64-bit result from a "*"
 * operator if the result is a long long AND at least one of the
 * operands is cast to long long (usually just prior to the "*" so as
 * not to confuse it into thinking it really has a 64-bit operand,
 * which, buy the way, it can do, but it take more code and at least 2
 * mpys).

 * We also need to be aware that one second in nanoseconds is only a
 * couple of bits away from overflowing a 32-bit word, so we MUST use
 * 64-bits to get the full range time in nanoseconds.

 */

/*
 * Here are the scales we will use.  One for seconds, nanoseconds and
 * microseconds.
 *
 * Within the limits of cpp we do a rough cut at the SEC_JIFFIE_SC and
 * check if the sign bit is set.  If not, we bump the shift count by 1.
 * (Gets an extra bit of precision where we can use it.)
 * We know it is set for HZ = 1024 and HZ = 100 not for 1000.
 * Haven't tested others.

 * Limits of cpp (for #if expressions) only long (no long long), but
 * then we only need the most signicant bit.
 */

#define SEC_JIFFIE_SC (31 - SHIFT_HZ)
#if !((((NSEC_PER_SEC << 2) / TICK_NSEC) << (SEC_JIFFIE_SC - 2)) & 0x80000000)
#undef SEC_JIFFIE_SC
#define SEC_JIFFIE_SC (32 - SHIFT_HZ)
#endif
#define NSEC_JIFFIE_SC (SEC_JIFFIE_SC + 29)
#define USEC_JIFFIE_SC (SEC_JIFFIE_SC + 19)
#define SEC_CONVERSION ((unsigned long)((((u64)NSEC_PER_SEC << SEC_JIFFIE_SC) +\
                                TICK_NSEC -1) / (u64)TICK_NSEC))

#define NSEC_CONVERSION ((unsigned long)((((u64)1 << NSEC_JIFFIE_SC) +\
                                        TICK_NSEC -1) / (u64)TICK_NSEC))
#define USEC_CONVERSION  \
                    ((unsigned long)((((u64)NSEC_PER_USEC << USEC_JIFFIE_SC) +\
                                        TICK_NSEC -1) / (u64)TICK_NSEC))
/*
 * USEC_ROUND is used in the timeval to jiffie conversion.  See there
 * for more details.  It is the scaled resolution rounding value.  Note
 * that it is a 64-bit value.  Since, when it is applied, we are already
 * in jiffies (albit scaled), it is nothing but the bits we will shift
 * off.
 */
#define USEC_ROUND (u64)(((u64)1 << USEC_JIFFIE_SC) - 1)
#define USEC_ROUND2 (u64)(((u64)1 << (USEC_JIFFIE_SC - 1)))
/*
 * The maximum jiffie value is (MAX_INT >> 1).  Here we translate that
 * into seconds.  The 64-bit case will overflow if we are not careful,
 * so use the messy SH_DIV macro to do it.  Still all constants.
 */
#if BITS_PER_LONG < 64
# define MAX_SEC_IN_JIFFIES \
	(long)((u64)((u64)MAX_JIFFY_OFFSET * TICK_NSEC) / NSEC_PER_SEC)
#else	/* take care of overflow on 64 bits machines */
# define MAX_SEC_IN_JIFFIES \
	(SH_DIV((MAX_JIFFY_OFFSET >> SEC_JIFFIE_SC) * TICK_NSEC, NSEC_PER_SEC, 1) - 1)

#endif

/*
 * Convert jiffies to milliseconds and back.
 *
 * Avoid unnecessary multiplications/divisions in the
 * two most common HZ cases:
 */
static inline unsigned int jiffies_to_msecs(const unsigned long j)
{
#if HZ <= 1000 && !(1000 % HZ)
	return (1000 / HZ) * j;
#elif HZ > 1000 && !(HZ % 1000)
	return (j + (HZ / 1000) - 1)/(HZ / 1000);
#else
	return (j * 1000) / HZ;
#endif
}

static inline unsigned int jiffies_to_usecs(const unsigned long j)
{
#if HZ <= 1000 && !(1000 % HZ)
	return (1000000 / HZ) * j;
#elif HZ > 1000 && !(HZ % 1000)
	return (j*1000 + (HZ - 1000))/(HZ / 1000);
#else
	return (j * 1000000) / HZ;
#endif
}

static inline unsigned long msecs_to_jiffies(const unsigned int m)
{
	if (m > jiffies_to_msecs(MAX_JIFFY_OFFSET))
		return MAX_JIFFY_OFFSET;
#if HZ <= 1000 && !(1000 % HZ)
	return (m + (1000 / HZ) - 1) / (1000 / HZ);
#elif HZ > 1000 && !(HZ % 1000)
	return m * (HZ / 1000);
#else
	return (m * HZ + 999) / 1000;
#endif
}

static inline unsigned long usecs_to_jiffies(const unsigned int u)
{
	if (u > jiffies_to_usecs(MAX_JIFFY_OFFSET))
		return MAX_JIFFY_OFFSET;
#if HZ <= 1000 && !(1000 % HZ)
	return (u + (1000000 / HZ) - 1000) / (1000000 / HZ);
#elif HZ > 1000 && !(HZ % 1000)
	return u * (HZ / 1000000);
#else
	return (u * HZ + 999999) / 1000000;
#endif
}

/*
 * The TICK_NSEC - 1 rounds up the value to the next resolution.  Note
 * that a remainder subtract here would not do the right thing as the
 * resolution values don't fall on second boundries.  I.e. the line:
 * nsec -= nsec % TICK_NSEC; is NOT a correct resolution rounding.
 *
 * Rather, we just shift the bits off the right.
 *
 * The >> (NSEC_JIFFIE_SC - SEC_JIFFIE_SC) converts the scaled nsec
 * value to a scaled second value.
 */


/* Same for "timeval"
 *
 * Well, almost.  The problem here is that the real system resolution is
 * in nanoseconds and the value being converted is in micro seconds.
 * Also for some machines (those that use HZ = 1024, in-particular),
 * there is a LARGE error in the tick size in microseconds.

 * The solution we use is to do the rounding AFTER we convert the
 * microsecond part.  Thus the USEC_ROUND, the bits to be shifted off.
 * Instruction wise, this should cost only an additional add with carry
 * instruction above the way it was done above.
 */
static __inline__ unsigned long
timeval_to_jiffies(const struct timeval *value)
{
	unsigned long sec = value->tv_sec;
	long usec = value->tv_usec;

	if (sec >= MAX_SEC_IN_JIFFIES){
		sec = MAX_SEC_IN_JIFFIES;
		usec = 0;
	}
#if 0
	printf("usec * USEC_CONVERSION = %llx\n",
			(u64)usec * USEC_CONVERSION);
	printf("usec * USEC_CONVERSION + USEC_ROUND = %llx  >> %llx\n",
			(u64)usec * USEC_CONVERSION + USEC_ROUND,
			((u64)usec * USEC_CONVERSION + USEC_ROUND) >> USEC_JIFFIE_SC
			);
	printf("usec * USEC_CONVERSION + USEC_ROUND2 = %llx  "
			">> %llx  = %ld jiffies\n",
			(u64)usec * USEC_CONVERSION + USEC_ROUND2,
			((u64)usec * USEC_CONVERSION + USEC_ROUND2) >> USEC_JIFFIE_SC,
		(((u64)sec * SEC_CONVERSION) +
			(((u64)usec * USEC_CONVERSION + USEC_ROUND2) >>
			 (USEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC
			);
#endif

#define USE_PATCH 0
#if USE_PATCH
	return (((u64)sec * SEC_CONVERSION) +
		(((u64)usec * USEC_CONVERSION + USEC_ROUND2) >>
		 (USEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
#else
	return (((u64)sec * SEC_CONVERSION) +
		(((u64)usec * USEC_CONVERSION + USEC_ROUND) >>
		 (USEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
#endif
}
int main(int argc, char **argv)
{
	unsigned long jiffies;
	struct timeval tv;
	int i;

	tv.tv_sec = 0;
	for (i=0; i <= 100; i++) {
		tv.tv_usec = 10000 + i*10;

		jiffies = timeval_to_jiffies(&tv);
		printf("usec=%ld  jiffies = %lu\n",tv.tv_usec,jiffies);
	}
	return 0;
}

--=-zHpcEWRaWxCCTN8zs9ZT--

