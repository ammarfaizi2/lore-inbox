Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132547AbREEOSQ>; Sat, 5 May 2001 10:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132557AbREEOR5>; Sat, 5 May 2001 10:17:57 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:20486 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S132547AbREEORx>; Sat, 5 May 2001 10:17:53 -0400
Date: Sat, 5 May 2001 18:17:18 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.4 alpha semaphores optimization
Message-ID: <20010505181718.B2302@jurassic.park.msu.ru>
In-Reply-To: <20010503194747.A552@jurassic.park.msu.ru> <20010504141318.B11122@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010504141318.B11122@twiddle.net>; from rth@twiddle.net on Fri, May 04, 2001 at 02:13:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2001 at 02:13:18PM -0700, Richard Henderson wrote:
> Eh?  Would you give me an example that isn't working properly?

Sure.

bar.c:
-----------------
extern void rarely_executed_code(void);

static inline void foo_no_be(void)
{
	int ret;
	__asm__ __volatile__("nop\n": "=r" (ret));
	if (ret < 0)
		rarely_executed_code();
}

static inline void foo(void)
{
	int ret;
	__asm__ __volatile__("unop\n": "=r" (ret));
	if (__builtin_expect(ret < 0, 0))
		rarely_executed_code();
}

#define foo_macro()	({	\
	int ret;	\
	 __asm__ __volatile__("fnop\n": "=r" (ret));	\
	if (__builtin_expect(ret < 0, 0))	\
		rearly_executed_code();		\
})

void bar(void)
{
	foo_no_be();
	foo();
	foo_macro();
}
---------------
bar.s, compiled with 'gcc -O2 -S bar.c':
--------------
[...]
$bar..ng:
	lda $30,-16($30)
	stq $26,0($30)
	.prologue 1
	nop

	.align 3 #realign
	addl $1,$31,$1
	blt $1,$L12	# (ret < 0) predicted to be "false", and gcc
			# put the code out of line quite nicely.
$L8:
	unop

	.align 3 #realign
	srl $1,31,$1
	blbc $1,$L10	# Oops. The slow path code is in line...
	jsr $26,rarely_executed_code
	ldgp $29,0($26)
$L10:
	fnop

	.align 3 #realign
	srl $1,31,$1
	blbs $1,$L13	# This works.
$L11:
	ldq $26,0($30)
	nop
	lda $30,16($30)
	ret $31,($26),1
	.align 4
$L13:
	jsr $26,rearly_executed_code
	ldgp $29,0($26)
	br $31,$L11
	.align 4
$L12:
	jsr $26,rarely_executed_code
	ldgp $29,0($26)
	br $31,$L8
	.end bar
	.ident	"GCC: (GNU) 3.0 20010430 (prerelease)"
---------------
So one of the questions: can one rely on current branch predictions
algorithms (val < 0, val = 0 false etc.) in the long term?

Ivan.
