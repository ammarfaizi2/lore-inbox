Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314131AbSDQPXi>; Wed, 17 Apr 2002 11:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314132AbSDQPXi>; Wed, 17 Apr 2002 11:23:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41477 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S314131AbSDQPXg>; Wed, 17 Apr 2002 11:23:36 -0400
Date: Wed, 17 Apr 2002 17:23:37 +0200
From: Jan Hubicka <jh@suse.cz>
To: Jan Hubicka <jh@suse.cz>
Cc: bugtraq@securityfocus.com, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@atrey.karlin.mff.cuni.cz>, jakub@redhat.com,
        aj@suse.de, ak@suse.de
Subject: Re: SSE related security hole
Message-ID: <20020417152337.GG29952@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020417145130.GA29952@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
Jakub asked me to cleanup the source and post assembly file.  Here it comes.

#include <stdlib.h>
#include <stdio.h>

int
m ()
{
  int i, n = 7;	
  float comp, sum = 0;
  sin(1);
  for (i = 1; i <= n; ++i)
    sum += i;
  printf ("sum of %d ints: %g\n", n, sum);
  return 0;
}

main ()
{
  m ();
}

--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bad3.s"

	.file	"bad3.c"
	.section	.rodata
.LC1:
	.string	"sum of %d ints: %g\n"
	.text
	.align 2
	.p2align 4,,15
.globl m
	.type	m,@function
m:
	pushl	%ebp
	movl	%esp, %ebp
	pxor	%xmm1, %xmm1
	subl	$24, %esp
	movss	%xmm1, -4(%ebp)
	movl	$0, (%esp)
	movl	$1072693248, 4(%esp)
	call	sin
	fstp	%st(0)
	movl	$1, %eax
	.p2align 4,,15
.L6:
	cvtsi2ss	%eax, %xmm1
	incl	%eax
	cmpl	$7, %eax
	addss	-4(%ebp), %xmm1
	movss	%xmm1, -4(%ebp)
	jle	.L6
	flds	-4(%ebp)
	movl	$.LC1, (%esp)
	movl	$7, 4(%esp)
	fstpl	8(%esp)
	call	printf
	leave
	xorl	%eax, %eax
	ret
.Lfe1:
	.size	m,.Lfe1-m
	.align 2
	.p2align 4,,15
.globl main
	.type	main,@function
main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	andl	$-16, %esp
	call	m
	movl	%ebp, %esp
	popl	%ebp
	ret
.Lfe2:
	.size	main,.Lfe2-main
	.ident	"GCC: (GNU) 3.2 20020415 (experimental)"

--aVD9QWMuhilNxW9f--
