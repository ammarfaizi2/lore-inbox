Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265825AbUFIUE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265825AbUFIUE0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 16:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265902AbUFIUE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 16:04:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11676 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265825AbUFIUEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 16:04:10 -0400
Date: Wed, 9 Jun 2004 13:04:06 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: [PATCH] Add FUTEX_CMP_REQUEUE futex op
Message-Id: <20040609130406.7942507c@lembas.zaitcev.lan>
In-Reply-To: <mailman.1086629984.12568.linux-kernel2news@redhat.com>
References: <mailman.1086629984.12568.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2004 18:03:49 +0200
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> --- linux-2.6/arch/s390/kernel/compat_wrapper.S	Mon Jun  7 16:07:24 2004
> +++ linux-2.6-s390/arch/s390/kernel/compat_wrapper.S	Mon Jun  7 16:07:53 2004
> @@ -1097,6 +1097,8 @@
>  	lgfr	%r4,%r4			# int
>  	llgtr	%r5,%r5			# struct compat_timespec *
>  	llgtr	%r6,%r6			# u32 *
> +	lgf	%r0,164(%r15)		# int
> +	stg	%r0,160(%r15)
>  	jg	compat_sys_futex	# branch to system call
>  
>  	.globl	sys32_setxattr_wrapper

Is it just me, or this could he above stand a use of STACK_FRAME_OVERHEAD
instead of 160? I envision a time when Ulrich Weigand comes out with
a gcc -fkernel, and at that time we'll need all such references
configurable.

> diff -urN linux-2.6/include/asm-s390/ptrace.h linux-2.6-s390/include/asm-s390/ptrace.h
> --- linux-2.6/include/asm-s390/ptrace.h	Mon May 10 04:32:54 2004
> +++ linux-2.6-s390/include/asm-s390/ptrace.h	Mon Jun  7 16:07:53 2004
> @@ -303,6 +303,7 @@
>   */
>  struct pt_regs 
>  {
> +	unsigned long args[1];
>  	psw_t psw;

This worries me, together with
   (__u32*)((addr_t) &__KSTK_PTREGS(child)->psw

Why not to place the necessary word outside of the struct?
It just logically doesn't belong. Might be just as easy to
do that mvc to other place.

I think I'll try to scope such an implemenation.

-- Pete
