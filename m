Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269121AbUJFIwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269121AbUJFIwb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 04:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269132AbUJFIwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 04:52:31 -0400
Received: from gprs214-1.eurotel.cz ([160.218.214.1]:42368 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269121AbUJFIw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 04:52:27 -0400
Date: Wed, 6 Oct 2004 10:52:11 +0200
From: Pavel Machek <pavel@suse.cz>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: akpm@osdl.org, len.brown@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] S3 suspend/resume with noexec
Message-ID: <20041006085211.GB1255@elf.ucw.cz>
References: <20041005172757.A31514@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041005172757.A31514@unix-os.sc.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch is required for S3 suspend-resume to work on noexec capable systems.
> On these systems, we need to save and restore MSR_EFER during
> suspend-resume.

Hmm, I'm afraid similar patch will be needed for x86-64...

> --- linux-2.6.9-rc2/arch/i386/power/cpu.c.org	2004-09-01 19:05:41.997927104 -0700
> +++ linux-2.6.9-rc2/arch/i386/power/cpu.c	2004-09-02 19:12:54.318407912 -0700
> @@ -62,6 +62,10 @@ void __save_processor_state(struct saved
>  	asm volatile ("movl %%cr0, %0" : "=r" (ctxt->cr0));
>  	asm volatile ("movl %%cr2, %0" : "=r" (ctxt->cr2));
>  	asm volatile ("movl %%cr3, %0" : "=r" (ctxt->cr3));
> +#ifdef CONFIG_X86_PAE
> +	if (cpu_has_pae && cpu_has_nx)
> +		rdmsr(MSR_EFER, ctxt->efer_lo, ctxt->efer_hi);
> +#endif
>  	asm volatile ("movl %%cr4, %0" : "=r" (ctxt->cr4));
>  }

Are those #ifdefs good idea?

> --- linux-2.6.9-rc2/arch/i386/kernel/acpi/wakeup.S.org	2004-09-01 21:02:14.639883944 -0700
> +++ linux-2.6.9-rc2/arch/i386/kernel/acpi/wakeup.S	2004-09-02 21:35:02.791882872 -0700
> @@ -59,6 +59,20 @@ wakeup_code:
>  	movl	$swapper_pg_dir-__PAGE_OFFSET, %eax
>  	movl	%eax, %cr3
>  
> +	testl	$1, real_efer_save_restore - wakeup_code
> +	jz	4f
> +	# restore efer setting
> +	pushl    %eax
> +	pushl    %ecx
> +	pushl    %edx
> +	movl	real_save_efer_edx - wakeup_code, %edx
> +	movl	real_save_efer_eax - wakeup_code, %eax
> +	mov     $0xc0000080, %ecx
> +	wrmsr
> +	popl    %edx
> +	popl    %ecx
> +	popl    %eax
> +4:
>  	# make sure %cr4 is set correctly (features, etc)
>  	movl	real_save_cr4 - wakeup_code, %eax
>  	movl	%eax, %cr4

Please analyse surrounding code a bit more. You certainly do not need
to push %eax, because it is scratch register.

Is it neccessary to restore efer this soon, btw? We should be running
from swapper_pg_dir. Does that use nx?

> @@ -223,6 +240,26 @@ ENTRY(acpi_copy_wakeup_routine)
>  	sldt	saved_ldt
>  	str	saved_tss
>  
> +	movl	efer_save_restore, %edx
> +	movl	%edx, real_efer_save_restore - wakeup_start (%eax)
> +	testl	$1, real_efer_save_restore - wakeup_start (%eax)
> +	jz	2f
> +	# save efer setting
> +	pushl	%eax
> +	pushl	%ebx
> +	pushl	%ecx
> +	pushl	%edx
> +	movl	%eax, %ebx
> +	mov     $0xc0000080, %ecx
> +	rdmsr
> +	movl	%edx, real_save_efer_edx - wakeup_start (%ebx)
> +	movl	%eax, real_save_efer_eax - wakeup_start (%ebx)
> +	popl	%edx
> +	popl	%ecx
> +	popl    %ebx
> +	popl	%eax
> +2:
> +
>  	movl    %cr3, %edx
>  	movl    %edx, real_save_cr3 - wakeup_start (%eax)
>  	movl    %cr4, %edx

Again, no need to push %edx, it is used as a scratch register.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
