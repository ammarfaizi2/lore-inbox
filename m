Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292666AbSDUCK2>; Sat, 20 Apr 2002 22:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292870AbSDUCK1>; Sat, 20 Apr 2002 22:10:27 -0400
Received: from [195.223.140.120] ([195.223.140.120]:30482 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S292666AbSDUCK0>; Sat, 20 Apr 2002 22:10:26 -0400
Date: Sun, 21 Apr 2002 04:08:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@suse.de>, Brian Gerst <bgerst@didntduck.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        jh@suse.cz
Subject: Re: [PATCH] Re: SSE related security hole
Message-ID: <20020421040810.P1291@dualathlon.random>
In-Reply-To: <20020420232818.N1291@dualathlon.random> <Pine.LNX.4.44.0204201619170.3643-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2002 at 04:23:50PM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 20 Apr 2002, Andrea Arcangeli wrote:
> >
> > pxor+xorps is definitely faster than fxrestor on athlon-mp.
> 
> Andrea, that's not the _comparison_.
> 
> The "fxrestor" replaces the "fninit" too, so you have to take that into
> account.

Note that I just took it into account:

	rdtscl(before);

	__asm__("fninit");
	^^^^^^^^^^^^^^^^^

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

> 
> > fxrestor on athlon-mp 1600, on cold cache (the "default fpu state" will
> > be cold most of the time, it's only ever used at the first math fault of
> > a task):
> 
> Except it's _never_ cold-cache the way it's coded now. In fact it's always
> hot-cache - which are exactly the numbers I posted.

In the common case fork/clone are executed at a frequency that makes it
a cold cache.

Anyways since you are apparently constantly forking off a new task every
10 milliseconds on your machine, on the PIII with the hot cache it's 97
cycles for fxrestor, and 90 cycles of pxor/xorps/fninit so it's still
faster, but not much faster anymore. With the athlon-mp it's 120 cycles
the xorps/pxor/fninit and 85 cycles fxrestor, but that's only because
the fninit is very slow on the athlon-mp, probably not the case for
x86-64 (while the xorps/pxor is just much faster on the athlon-mp
compared to the PIII). The pxor/xorps alone on the athlon-mp takes only
17 cycles! the fninit alone instead takes 99 cycles.  512bytes of ram on
x86-64 (around half on x86) cannot be optimized away by a new cpu, the
bus will get the hit regardless, while fninit has the potential to be
much faster on the new cpu (just like it's much faster on the PIII and
infact it's a win).  I guess the P4 will give hot cache results similar
to the PIII with the hot-cache, and anyways there's no doubt on the huge
speedup with the _common_ case cold-cache, even more obviously on x86-64
that will really have to read the _whole_ 512bytes, not (yet) the case
for x86. I'm astonished you prefer to take the hit on the ram bus.

here the hot cache benchmark that I used so you can test yourself:

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

#define LOOPS 200

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

#if 1
	for (i = 0; i < LOOPS; i++) {
		rdtscl(before);

 		__asm__("fninit");

#if 1
		asm volatile("pxor %mm0, %mm0	\n"
			     "pxor %mm1, %mm1	\n"
			     "pxor %mm2, %mm2	\n"
			     "pxor %mm3, %mm3	\n"
			     "pxor %mm4, %mm4	\n"
			     "pxor %mm5, %mm5	\n"
			     "pxor %mm6, %mm6	\n"
			     "pxor %mm7, %mm7	\n"
			     "xorps %xmm0, %xmm0	\n"
			     "xorps %xmm1, %xmm1	\n"
			     "xorps %xmm2, %xmm2	\n"
			     "xorps %xmm3, %xmm3	\n"
			     "xorps %xmm4, %xmm4	\n"
			     "xorps %xmm5, %xmm5	\n"
			     "xorps %xmm6, %xmm6	\n"
			     "xorps %xmm7, %xmm7	\n"
			     "emms			\n");
		load_mxcsr(0x1f80);
#endif
		rdtscl(after);
	}
#else
	asm volatile("fxsave %0" : : "m" (i387));

	for (i = 0; i < LOOPS; i++) {
		rdtscl(before);

		asm volatile("fxrstor %0" : "=m" (i387));

		rdtscl(after);
	}
#endif

	printf("cycles %lu\n", after-before);
}

> It may have high precision, but since it's testing something that has
> nothing to do with the problem at hand, it's basically 100% useless.

Andrea
