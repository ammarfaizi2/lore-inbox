Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSHVRTg>; Thu, 22 Aug 2002 13:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315178AbSHVRTg>; Thu, 22 Aug 2002 13:19:36 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:55536 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S314546AbSHVRTE>;
	Thu, 22 Aug 2002 13:19:04 -0400
Message-ID: <3D651DE0.935BA0B0@mvista.com>
Date: Thu, 22 Aug 2002 10:22:40 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Yoann Vandoorselaere <yoann@prelude-ids.org>
CC: Gabriel Paubert <paubert@iram.es>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       cpufreq@lists.arm.linux.org.uk, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: fix 32bits integer overflow in loops_per_jiffycalculation
References: <3D64D51C.9040603@iram.es> <20020822143115.15323@192.168.4.1> 
		<3D65020D.5070201@iram.es> <1030031960.15427.237.camel@alph>
Content-Type: multipart/mixed;
 boundary="------------DA138B36D48AC05C53B7AF72"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------DA138B36D48AC05C53B7AF72
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

You might find the attached header of some interest.  It is
part of the high-res-timers patch and is for i386, but I
expect we will do the same for most archs before we are
done.  The notion is to use a power of two scale and to make
it easy to access by keeping the asm out of your face (and
in a neat little header file :)  In the patch we use it to
avoid div in all the places that it matters, i.e. we do a
div to set up the conversion constants (e.g. TSC to
nanosecond or TSC to microsecond) once and then use the "sc"
mpy functions to do the conversions.

Enjoy
-g


Yoann Vandoorselaere wrote:
> 
> On Thu, 2002-08-22 at 17:23, Gabriel Paubert wrote:
> > Benjamin Herrenschmidt wrote:
> > >>Well, first on sane archs which have an easily accessible, fixed
> > >>frequency time counter, loops_per_jiffy should never have existed :-)
> > >>
> > >>Second, putting this code there means that one day somebody will
> > >>inevitably try to use it outside of its domain of operation (like it
> > >>happened for div64 a few months ago when I pointed out that it would not
> > >>work for divisors above 65535 or so).
> > >
> > >
> > > Well... it's clearly located inside kernel/cpufreq.c, so there is
> > > little risk, though it may be worth a big bold comment
> >
> > Hmm, in my experience people hardly ever read detailed comments even
> > when they are well-written. Perhaps if you called the function
> > imprecise_scale or coarse_scale, it might ring a bell.
> >
> > Besides that functions should do one thing and do that *well*[1]. Well,
> > I'm usually not too dogmatic, but this function breaks the second rule
> > beyond what I find acceptable.
> 
> At least it report *correct* result (when the old one was returning BS
> because of the 32 bits integer overflow). Doing it well require per
> architecture support.
> 
> 
> > >>In this case a generic scaling function, while not a standard libgcc/C
> > >>library feature has potentially more applications than this simple
> > >>cpufreq approximation. But I don't see very much the need for scaling a
> > >>long (64 bit on 64 bit archs) value, 32 bit would be sufficient.
> > >
> > >
> > > Well... if you can write one, go on then ;) In my case, I'm happy
> > > with Yoann implementation for cpufreq right now. Though I agree that
> > > could ultimately be moved to arch code.
> 
> [...]
> 
> > [1] Documentation/CodingStyle, which also claims that functions should
> > be short and *sweet*. Well, I found the patch far too bitter ;-).
> 
> No wonder why you're loosing contributor with such comportment.
> 
> --
> Yoann Vandoorselaere, http://www.prelude-ids.org
> 
> "Programming is a race between programmers, who try and make more and
>  more idiot-proof software, and universe, which produces more and more
>  remarkable idiots. Until now, universe leads the race"  -- R. Cook
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
--------------DA138B36D48AC05C53B7AF72
Content-Type: text/plain; charset=us-ascii;
 name="sc_math.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sc_math.h"

#ifndef SC_MATH
#define SC_MATH
#define MATH_STR(X) #X
#define MATH_NAME(X) X

/*
 * Pre scaling defines
 */
#define SC_32(x) ((long long)x<<32)
#define SC_n(n,x) (((long long)x)<<n)
/*
 * This routine preforms the following calculation:
 *
 * X = (a*b)>>32
 * we could, (but don't) also get the part shifted out.
 */
extern inline long mpy_ex32(long a,long b)
{
        long edx;
	__asm__("imull %2"
		:"=a" (a), "=d" (edx)
		:"rm" (b),
		 "0" (a));
        return edx;
}
/*
 * X = (a/b)<<32 or more precisely x = (a<<32)/b
 */

extern inline long div_ex32(long a, long b)
{
        long dum;
        __asm__("divl %2"
                :"=a" (b), "=d" (dum)
                :"r" (b), "0" (0), "1" (a));
        
        return b;
}
/*
 * X = (a*b)>>24
 * we could, (but don't) also get the part shifted out.
 */

#define mpy_ex24(a,b) mpy_sc_n(24,a,b)
/*
 * X = (a/b)<<24 or more precisely x = (a<<24)/b
 */
#define div_ex24(a,b) div_sc_n(24,a,b)

/*
 * The routines allow you to do x = (a/b) << N and
 * x=(a*b)>>N for values of N from 1 to 32.
 *
 * These are handy to have to do scaled math.
 * Scaled math has two nice features:
 * A.) A great deal more precision can be maintained by
 *     keeping more signifigant bits.
 * B.) Often an in line div can be repaced with a mpy
 *     which is a LOT faster.
 */

#define mpy_sc_n(N,aa,bb) ({long edx,a=aa,b=bb; \
	__asm__("imull %2\n\t" \
                "shldl $(32-"MATH_STR(N)"),%0,%1"    \
		:"=a" (a), "=d" (edx)\
		:"rm" (b),            \
		 "0" (a)); edx;})


#define div_sc_n(N,aa,bb) ({long dum=aa,dum2,b=bb; \
        __asm__("shrdl $(32-"MATH_STR(N)"),%4,%3\n\t"  \
                "sarl $(32-"MATH_STR(N)"),%4\n\t"      \
                "divl %2"              \
                :"=a" (dum2), "=d" (dum)      \
                :"rm" (b), "0" (0), "1" (dum)); dum2;})  

  
/*
 * (long)X = ((long long)divs) / (long)div
 * (long)rem = ((long long)divs) % (long)div
 *
 * Warning, this will do an exception if X overflows.
 */
#define div_long_long_rem(a,b,c) div_ll_X_l_rem(a,b,c)

extern inline long div_ll_X_l_rem(long long divs, long div,long * rem)
{
        long dum2;
        __asm__( "divl %2"
                :"=a" (dum2), "=d" (*rem)
                :"rm" (div), "A" (divs));
        
        return dum2;

}
/*
 * same as above, but no remainder
 */
extern inline long div_ll_X_l(long long divs, long div)
{
        long dum;
        return div_ll_X_l_rem(divs,div,&dum);
}
/*
 * (long)X = (((long)divh<<32) | (long)divl) / (long)div
 * (long)rem = (((long)divh<<32) % (long)divl) / (long)div
 *
 * Warning, this will do an exception if X overflows.
 */
extern inline long div_h_or_l_X_l_rem(long divh,long divl, long div,long* rem)
{
        long dum2;
        __asm__( "divl %2"
                :"=a" (dum2), "=d" (*rem)
                :"rm" (div), "0" (divl),"1" (divh));
        
        return dum2;

}
extern inline long long mpy_l_X_l_ll(long mpy1,long mpy2)
{
        long long eax;
	__asm__("imull %1\n\t"
		:"=A" (eax)
		:"rm" (mpy2),
		 "a" (mpy1));
        
        return eax;

}
extern inline long  mpy_1_X_1_h(long mpy1,long mpy2,long *hi)
{
        long eax;
	__asm__("imull %2\n\t"
		:"=a" (eax),"=d" (*hi)
		:"rm" (mpy2),
		 "0" (mpy1));
        
        return eax;

}

#endif

--------------DA138B36D48AC05C53B7AF72--

