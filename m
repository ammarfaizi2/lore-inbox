Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262220AbVAUKFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbVAUKFR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 05:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbVAUKFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 05:05:17 -0500
Received: from gprs215-198.eurotel.cz ([160.218.215.198]:44233 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262220AbVAUKFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 05:05:03 -0500
Date: Fri, 21 Jan 2005 11:04:22 +0100
From: Pavel Machek <pavel@suse.cz>
To: hugang@soulinfo.com
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] swsusp: speed up image restoring on x86-64
Message-ID: <20050121100422.GC18373@elf.ucw.cz>
References: <200501202032.31481.rjw@sisk.pl> <20050120205950.GF468@openzaurus.ucw.cz> <200501202246.38506.rjw@sisk.pl> <20050121022348.GA18166@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121022348.GA18166@hugang.soulinfo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Sure, but I think it's there for a reason.
> > 
> > > Anyway, this is likely to clash with hugang's work; I'd prefer this not to be applied.
> > 
> > I am aware of that, but you are not going to merge the hugang's patches soon, are you?
> > If necessary, I can change the patch to work with his code (hugang, what do you think?).
> > 
> I like this patch, And I change my code with this, Please have a look,
> It pass in qemu X86_64. :)
> 
> Full patch still can get from
>  http://soulinfo.com/~hugang/swsusp/2005-1-21/
> 
> here is only x86_64 part.

Okay, why not, if you are changing it anyway...


> --- 2.6.11-rc1-mm1/arch/x86_64/kernel/suspend_asm.S	2004-12-30 14:56:35.000000000 +0800
> +++ 2.6.11-rc1-mm1-swsusp-x86_64/arch/x86_64/kernel/suspend_asm.S	2005-01-21 10:13:15.000000000 +0800
> @@ -35,6 +35,7 @@ ENTRY(swsusp_arch_suspend)
>  	call swsusp_save
>  	ret
>  
> +	.section    .data.nosave
>  ENTRY(swsusp_arch_resume)
>  	/* set up cr3 */	
>  	leaq	init_level4_pgt(%rip),%rax

But why does it go into data section?

> @@ -49,43 +50,32 @@ ENTRY(swsusp_arch_resume)
>  	movq	%rcx, %cr3;
>  	movq	%rax, %cr4;  # turn PGE back on
>  
> -	movl	nr_copy_pages(%rip), %eax
> -	xorl	%ecx, %ecx
> -	movq	$0, %r10
> -	testl	%eax, %eax
> -	jz	done
> -.L105:
> -	xorl	%esi, %esi
> -	movq	$0, %r11
> -	jmp	.L104
> -	.p2align 4,,7
> -copy_one_page:
> -	movq	%r10, %rcx
> -.L104:
> -	movq	pagedir_nosave(%rip), %rdx
> -	movq	%rcx, %rax
> -	salq	$5, %rax
> -	movq	8(%rdx,%rax), %rcx
> -	movq	(%rdx,%rax), %rax
> -	movzbl	(%rsi,%rax), %eax
> -	movb	%al, (%rsi,%rcx)
> -
> -	movq	%cr3, %rax;  # flush TLB
> -	movq	%rax, %cr3;
> -
> -	movq	%r11, %rax
> -	incq	%rax
> -	cmpq	$4095, %rax
> -	movq	%rax, %rsi
> -	movq	%rax, %r11
> -	jbe	copy_one_page
> -	movq	%r10, %rax
> -	incq	%rax
> -	movq	%rax, %rcx
> -	movq	%rax, %r10
> -	mov	nr_copy_pages(%rip), %eax
> -	cmpq	%rax, %rcx
> -	jb	.L105
> +	movq	pagedir_nosave(%rip), %rax
> +	testq	%rax, %rax
> +	je		done
> +
> +copyback_page:
> +	movq	24(%rax), %r9
> +	xorl	%r8d, %r8d
> +

Are you sure %r8 and %r9 are caller-saved? I'd use low registers if I
were you, they look nincer and generate shorter opcodes ;-).

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
