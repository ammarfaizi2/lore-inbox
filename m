Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265043AbSKAPF0>; Fri, 1 Nov 2002 10:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265042AbSKAPF0>; Fri, 1 Nov 2002 10:05:26 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:54532 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S265050AbSKAPFZ>; Fri, 1 Nov 2002 10:05:25 -0500
Message-Id: <200211011433.gA1EXBp20882@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Arjan van de Ven <arjanv@redhat.com>, Andi Kleen <ak@suse.de>
Subject: Need help with FPU/MMX/SSE state save/restore
Date: Fri, 1 Nov 2002 17:25:15 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need to use MMX and/or SSE registers in my code.

Have looked at arch/i386/lib/mmx.c,
	kernel_fpu_begin();
	muck_with_MMX_regs();
	kernel_fpu_end();
seems to be the way to go.

My code is in .S, so I did the equivalent
(see <------), but routine crashed and burned
as soon as it tripped over kernel_fpu_begin.
Commenting KERNEL_FPU_BEGIN made code work
(I was able to boot with root=/dev/fd0)
but it won't be usable (will trash userspace
FP/MMX/SSE registers).

Does it have anything to do with the fact I'm
using this code from csum_partial[_copy_generic] ?
--
vda

...
#define	KERNEL_FPU_BEGIN \
	call	kernel_fpu_begin
#define	KERNEL_FPU_END(r) \
	movl	%cr0, r	;\
	orl	$8, r	;\
	movl	r, %cr0
...
# "big chunks" loop
	PREFETCH((%esi))	# Prefetch _each_ cacheline
	PREFETCH(32(%esi))
	PREFETCH(64(%esi))
	PREFETCH(64+32(%esi))
	PREFETCH(128(%esi))
	PREFETCH(128+32(%esi))
	PREFETCH(192(%esi))
	PREFETCH(192+32(%esi))
	KERNEL_FPU_BEGIN	<--------------
	clc
#define ROUND(x,r) \
SRC(	movq	x(%esi), r	);	\
	adcl	x(%esi), %eax	;	\
	adcl	x+4(%esi), %eax	;	\
DST(	movntq	r, x(%edi)	);
10:
	PREFETCH(256(%esi))
	ROUND(%mm0)
	ROUND(8,%mm0)
	ROUND(16,%mm0)
	ROUND(24,%mm0)
	lea	ITER_SZ(%esi), %esi
	lea	ITER_SZ(%edi), %edi
	loop	10b

	adcl	$0, %eax
	sfence
	KERNEL_FPU_END(%ebx)	<------------

