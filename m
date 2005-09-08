Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbVIHRvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbVIHRvw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 13:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbVIHRvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 13:51:52 -0400
Received: from S01060013104bd78e.vc.shawcable.net ([24.85.145.160]:11995 "EHLO
	r3000.fsmlabs.com") by vger.kernel.org with ESMTP id S964912AbVIHRvv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 13:51:51 -0400
Date: Thu, 8 Sep 2005 10:51:27 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Jan Beulich <JBeulich@novell.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move i386's enabling of fxsr and xmmxcpt
In-Reply-To: <4320724C020000780002447D@emea1-mh.id2.novell.com>
Message-ID: <Pine.LNX.4.63.0509081038460.8052@r3000.fsmlabs.com>
References: <4320724C020000780002447D@emea1-mh.id2.novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2005, Jan Beulich wrote:

> (Note: Patch also attached because the inline version is certain to get
> line wrapped.)
> 
> Move some code unrelated to any dealing with hardware bugs from i386's
> bugs.h to a more logical place.
> 
> Signed-off-by: Jan Beulich <jbeulich@novell.com>
>
> diff -Npru 2.6.13/arch/i386/kernel/traps.c
> 2.6.13-i386-fxsr/arch/i386/kernel/traps.c
> --- 2.6.13/arch/i386/kernel/traps.c	2005-08-29 01:41:01.000000000
> +0200
> +++ 2.6.13-i386-fxsr/arch/i386/kernel/traps.c	2005-09-07
> 11:46:35.000000000 +0200
> @@ -1098,6 +1098,24 @@ void __init trap_init(void)
>  #endif
>  	set_trap_gate(19,&simd_coprocessor_error);
>  
> +	if (cpu_has_fxsr) {
> +		/*
> +		 * Verify that the FXSAVE/FXRSTOR data will be 16-byte
> aligned.
> +		 */
> +		struct fxsrAlignAssert {
> +			int _:!(offsetof(struct task_struct,
> thread.i387.fxsave) & 15);
> +		};
> +
> +		printk(KERN_INFO "Enabling fast FPU save and restore...
> ");
> +		set_in_cr4(X86_CR4_OSFXSR);
> +		printk("done.\n");
> +	}
> +	if (cpu_has_xmm) {
> +		printk(KERN_INFO "Enabling unmasked SIMD FPU exception
> support... ");
> +		set_in_cr4(X86_CR4_OSXMMEXCPT);
> +		printk("done.\n");
> +	}
> +
>  	set_system_gate(SYSCALL_VECTOR,&system_call);

Hmm doesn't this really belong in identify_cpu()?
