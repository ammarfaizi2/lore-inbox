Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311641AbSDTV2o>; Sat, 20 Apr 2002 17:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312031AbSDTV2n>; Sat, 20 Apr 2002 17:28:43 -0400
Received: from [195.223.140.120] ([195.223.140.120]:24694 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S311641AbSDTV2m>; Sat, 20 Apr 2002 17:28:42 -0400
Date: Sat, 20 Apr 2002 23:28:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Brian Gerst <bgerst@didntduck.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] Re: SSE related security hole
Message-ID: <20020420232818.N1291@dualathlon.random>
In-Reply-To: <20020420201205.M1291@dualathlon.random> <Pine.LNX.4.33.0204201221120.11732-100000@penguin.transmeta.com> <20020420214114.A11894@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2002 at 09:41:14PM +0200, Andi Kleen wrote:
> > Besides, I seriously doubt it is any faster than what is there already.
> > 
> > Time it, and notice how:
> > 
> >  - fninit takes about 200 cycles
> >  - fxrstor takes about 215 cycles
> 
> On what CPU? 
> 
> I checked the Athlon4 optimization manual and fxrstor is listed as 68/108
> cycles (i guess depending on whether there is XMM state or not so 68 cycles
> probably apply here) and fninit as 91 cycles. It doesn't list the SSE1 
> timings, but i guess the instructions don't take more than 3 cycles
> (MMX instructions take that long). So Andrea's way should be 
> 91+16*3=139+some cycles for emms (or 107 if sse ops take only a single cycle) 
> vs 68 or 108.  So the fxrstor wins well. 
> 
> On x86-64 the difference is even bigger because it has 16 XMM registers instead
> of 8.
> 
> 
> > In short, your "fast" code isn't actually any faster than doing it right.
> 
> At least on Athlon it should be slower. 

pxor+xorps is definitely faster than fxrestor on athlon-mp.

fxrestor on athlon-mp 1600, on cold cache (the "default fpu state" will
be cold most of the time, it's only ever used at the first math fault of
a task):

dualathlon:/home/andrea # for i in 1 2 3 4 5 6 7 8 9 10 ; do ./a.out ;
done
cycles 3507
cycles 3293
cycles 3179
cycles 3267
cycles 3374
cycles 3213
cycles 2575
cycles 3306
cycles 2915
cycles 3078

pxor + xorps on the same hardware cold cache:

dualathlon:/home/andrea # for i in 1 2 3 4 5 6 7 8 9 10 ; do ./a.out ;
done
cycles 2444
cycles 1619
cycles 2396
cycles 2644
cycles 2322
cycles 2404
cycles 2266
cycles 1657
cycles 2182
cycles 2077

And here it is again on PIII 800mhz for confirmation on true Intel CPU:

fxrestor:

for i in 1 2 3 4 5 6 7 8 9 10 ; do ./a.out ; done
cycles 3461
cycles 3294
cycles 3339
cycles 3276
cycles 3620
cycles 3443
cycles 3401
cycles 3455
cycles 3515
cycles 3327

xor+xorps:

for i in 1 2 3 4 5 6 7 8 9 10 ; do ./a.out ; done
cycles 2288
cycles 2181
cycles 2430
cycles 2486
cycles 2360
cycles 2534
cycles 2243
cycles 2199
cycles 2153
cycles 2396

As said in an earlier email it is a matter of memory bandwith, 59 bytes
of icache and zero data, against 7 bytes of icache and 512bytes of data.
the 512bytes of data are visibly slower, period. Saving mem bandwith is
much more important than reducing the number of instructions, even more
on SMP!

On the x86-64 it will be exactly the same, the mem bandwith is much
higher, but it's still a major bottleneck compared to a few more
instructions to execute (also consider the current ia32 isn't probably
reading the xmm8-15 slots, so on x86-64 fxrestor will be potentially
even slower compared to the in-core xorps that never do any I/O to
memory).

Go ahead and try yourself setting the #if to 0 or 1. The benchmark is
very accurate.

#include <sys/mman.h>
#include <asm/msr.h>

struct i387_fxsave_struct {
	unsigned short	cwd;
	unsigned short	swd;
	unsigned short	twd;
	unsigned short	fop;
	long	fip;
	long	fcs;
	long	foo;
	long	fos;
	long	mxcsr;
	long	reserved;
	long	st_space[32];	/* 8*16 bytes for each FP-reg = 128 bytes */
	long	xmm_space[32];	/* 8*16 bytes for each XMM-reg = 128 bytes */
	long	padding[56];
} __attribute__ ((aligned (16)));

#define LOOPS 1

#define load_mxcsr( val ) do { \
	unsigned long __mxcsr = ((unsigned long)(val) & 0xffbf); \
	asm volatile( "ldmxcsr %0" : : "m" (__mxcsr) ); \
} while (0)

struct i387_fxsave_struct i387;
char buf[1024*1024*40];

static void cold_dcache(void)
{
	memset(buf, 0, 1024*1024*40);
}

main()
{
	unsigned long before, after;
	int i;

	iopl(3);
	mlockall(MCL_FUTURE);

#if 1
	cold_dcache();
	asm("cli");

	rdtscl(before);

	__asm__("fninit");

	asm volatile(
		     "pxor %mm0, %mm0	\n"
		     "xorps %xmm0, %xmm0	\n"
		     "pxor %mm1, %mm1	\n"
		     "xorps %xmm1, %xmm1	\n"
		     "pxor %mm2, %mm2	\n"
		     "xorps %xmm2, %xmm2	\n"
		     "pxor %mm3, %mm3	\n"
		     "xorps %xmm3, %xmm3	\n"
		     "pxor %mm4, %mm4	\n"
		     "xorps %xmm4, %xmm4	\n"
		     "pxor %mm5, %mm5	\n"
		     "xorps %xmm5, %xmm5	\n"
		     "pxor %mm6, %mm6	\n"
		     "xorps %xmm6, %xmm6	\n"
		     "pxor %mm7, %mm7	\n"
		     "xorps %xmm7, %xmm7	\n"
		     "emms			\n");
	load_mxcsr(0x1f80);
	rdtscl(after);
#else
	asm volatile("fxsave %0" : : "m" (i387));

	cold_dcache();
	asm("cli");
	rdtscl(before);

	asm volatile("fxrstor %0" : "=m" (i387));

	rdtscl(after);
#endif

	printf("cycles %lu\n", after-before);
}

As said for SSE3 a kernel modification will be required anyways if xorps
isn't enough to initialize the new fpu, so the current 2.4 kernel cannot
cope with it anyways regardless of fxrestor or not.

So I don't buy that fxrestor is better, nor more generic.

Andrea
