Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267050AbTBDAd4>; Mon, 3 Feb 2003 19:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267065AbTBDAdz>; Mon, 3 Feb 2003 19:33:55 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:28105 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S267050AbTBDAdw>;
	Mon, 3 Feb 2003 19:33:52 -0500
Date: Tue, 4 Feb 2003 01:43:21 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: root@chaos.analogic.com
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: gcc 2.95 vs 3.21 performance
Message-ID: <20030204004321.GA12038@werewolf.able.es>
References: <Pine.LNX.3.95.1030203182417.7651A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.3.95.1030203182417.7651A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Tue, Feb 04, 2003 at 00:31:56 +0100
X-Mailer: Balsa 2.0.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003.02.04 Richard B. Johnson wrote:
> On Mon, 3 Feb 2003, Martin J. Bligh wrote:
> 
> > People keep extolling the virtues of gcc 3.2 to me, which I'm
> > reluctant to switch to, since it compiles so much slower. But
> > it supposedly generates better code, so I thought I'd compile
> > the kernel with both and compare the results. This is gcc 2.95
> > and 3.2.1 from debian unstable on a 16-way NUMA-Q. The kernbench
> > tests still use 2.95 for the compile-time stuff.
> >
> [SNIPPED tests...]
> 
> Don't let this get out, but egcs-2.91.66 compiled FFT code
> works about 50 percent of the speed of whatever M$ uses for
> Visual C++ Version 6.0  I was awfully disheartened when I
> found that identical code executed twice as fast on M$ than
> it does on Linux. I tried to isolate what was causing the
> difference. So I replaced 'hypot()' with some 'C' code that
> does sqrt(x^2 + y^2) just to see if it was the 'C' library.
> It didn't help. When I find out what type (section) of code
> is running slower, I'll report. In the meantime, it's fast
> enough, but I don't like being beat by M$.
> 

I face a simliar problem. As everybody says that SSE is so marvelous,
we are trying to put some SSE code in our render engine, to speed up this.
But look at the results of the code below (box is a P4@1.8, Xeon with ht):
annwn:~/sse> ss-g
Proc std:
      5020 kticks
Proc std inline:
      4320 kticks
Proc sse:
      4290 kticks
Proc sse inline:
      3890 kticks

So what ? Just around 500 ticks for updating to sse ? As Computer Architecture
people at the school says, it is something called 'spill code' (did I wrote it
ok?). In short, too much sse but too less registers, so Intel ia32 turns into
crap when you need some indexes, out of registers and copy to and from the stack.

#include <stdlib.h>
#include <time.h>
#include <stdio.h>
#if defined(__INTEL_COMPILER)
#include <xmmintrin.h>
#endif

#define LOOPS	1000
#define SZ		100000

#if defined(__GNUC__) && defined(__SSE__)
typedef void __ve_reg __attribute__((__mode__(V4SF)));
#endif

typedef struct point point;
struct point { 
	float v[4];
};

void mulp_std(const point* a,const point* b,point* r)
{
	int i;
	for (i=0; i<4; i++)
		r->v[i] = a->v[i] * b->v[i];
}

inline void mulpi_std(const point* a,const point* b,point* r)
{
	int i;
	for (i=0; i<4; i++)
		r->v[i] = a->v[i] * b->v[i];
}

void mulp_sse(const point* a,const point* b,point* r)
{
#if defined(__GNUC__) && defined(__SSE__)
	__ve_reg xmm0,xmm1,xmm2;
	xmm0 = __builtin_ia32_loadups((float*)a->v);
	xmm1 = __builtin_ia32_loadups((float*)b->v);
	xmm2 = __builtin_ia32_mulps(xmm0,xmm1);
	__builtin_ia32_storeups(r->v,xmm2);
#endif
#if defined(__INTEL_COMPILER)
	__m128 xmm0,xmm1,xmm2;
	xmm0 = _mm_loadu_ps((float*)a->v);
	xmm1 = _mm_loadu_ps((float*)b->v);
	xmm2 = _mm_mul_ps(xmm0,xmm1);
	_mm_storeu_ps(r->v,xmm2);
#endif
}

inline void mulpi_sse(const point* a,const point* b,point* r)
{
#if defined(__GNUC__) && defined(__SSE__)
	__ve_reg xmm0,xmm1,xmm2;
	xmm0 = __builtin_ia32_loadups((float*)a->v);
	xmm1 = __builtin_ia32_loadups((float*)b->v);
	xmm2 = __builtin_ia32_mulps(xmm0,xmm1);
	__builtin_ia32_storeups(r->v,xmm2);
#endif
#if defined(__INTEL_COMPILER)
#if defined(__INTEL_COMPILER)
	__m128 xmm0,xmm1,xmm2;
	xmm0 = _mm_loadu_ps((float*)a->v);
	xmm1 = _mm_loadu_ps((float*)b->v);
	xmm2 = _mm_mul_ps(xmm0,xmm1);
	_mm_storeu_ps(r->v,xmm2);
#endif
#endif
}

int main(int argc, char** argv)
{
	point *a;
	point *b;
	point *c;
	int i,j;
	unsigned long t0,t1;

	a = malloc(SZ*sizeof(point));
	b = malloc(SZ*sizeof(point));
	c = malloc(SZ*sizeof(point));

	printf("Proc std:\n");
	t0 = clock();
	for (i=0; i<LOOPS; i++)
	{
		for (j=0; j<SZ; j++)
			mulp_std(&a[j],&b[j],&c[j]);
		for (j=0; j<SZ; j++)
			mulp_std(&b[j],&b[j],&a[j]);
	}
	t1 = clock();
	printf("%10d kticks\n",(t1-t0)/1000);

	printf("Proc std inline:\n");
	t0 = clock();
	for (i=0; i<LOOPS; i++)
	{
		for (j=0; j<SZ; j++)
			mulpi_std(&a[j],&b[j],&c[j]);
		for (j=0; j<SZ; j++)
			mulpi_std(&b[j],&b[j],&a[j]);
	}
	t1 = clock();
	printf("%10d kticks\n",(t1-t0)/1000);

	printf("Proc sse:\n");
	t0 = clock();
	for (i=0; i<LOOPS; i++)
	{
		for (j=0; j<SZ; j++)
			mulp_sse(&a[j],&b[j],&c[j]);
		for (j=0; j<SZ; j++)
			mulp_sse(&b[j],&b[j],&a[j]);
	}
	t1 = clock();
	printf("%10d kticks\n",(t1-t0)/1000);

	printf("Proc sse inline:\n");
	t0 = clock();
	for (i=0; i<LOOPS; i++)
	{
		for (j=0; j<SZ; j++)
			mulpi_sse(&a[j],&b[j],&c[j]);
		for (j=0; j<SZ; j++)
			mulpi_sse(&b[j],&b[j],&a[j]);
	}
	t1 = clock();
	printf("%10d kticks\n",(t1-t0)/1000);

	free(c);
	free(b);
	free(a);

	return 0;
}


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre4-jam1 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-5mdk))
