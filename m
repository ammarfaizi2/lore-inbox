Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262233AbVAUC0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbVAUC0M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 21:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVAUC0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 21:26:12 -0500
Received: from [220.248.27.114] ([220.248.27.114]:41618 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S262233AbVAUC0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 21:26:06 -0500
Date: Fri, 21 Jan 2005 10:23:48 +0800
From: hugang@soulinfo.com
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] swsusp: speed up image restoring on x86-64
Message-ID: <20050121022348.GA18166@hugang.soulinfo.com>
References: <200501202032.31481.rjw@sisk.pl> <20050120205950.GF468@openzaurus.ucw.cz> <200501202246.38506.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501202246.38506.rjw@sisk.pl>
User-Agent: Mutt/1.3.28i
X-Virus-Checked: Checked
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 10:46:37PM +0100, Rafael J. Wysocki wrote:
> On Thursday, 20 of January 2005 21:59, Pavel Machek wrote:
> 
> Sure, but I think it's there for a reason.
> 
> > Anyway, this is likely to clash with hugang's work; I'd prefer this not to be applied.
> 
> I am aware of that, but you are not going to merge the hugang's patches soon, are you?
> If necessary, I can change the patch to work with his code (hugang, what do you think?).
> 
I like this patch, And I change my code with this, Please have a look,
It pass in qemu X86_64. :)

Full patch still can get from
 http://soulinfo.com/~hugang/swsusp/2005-1-21/

here is only x86_64 part.

--- 2.6.11-rc1-mm1/arch/x86_64/kernel/suspend_asm.S	2004-12-30 14:56:35.000000000 +0800
+++ 2.6.11-rc1-mm1-swsusp-x86_64/arch/x86_64/kernel/suspend_asm.S	2005-01-21 10:13:15.000000000 +0800
@@ -35,6 +35,7 @@ ENTRY(swsusp_arch_suspend)
 	call swsusp_save
 	ret
 
+	.section    .data.nosave
 ENTRY(swsusp_arch_resume)
 	/* set up cr3 */	
 	leaq	init_level4_pgt(%rip),%rax
@@ -49,43 +50,32 @@ ENTRY(swsusp_arch_resume)
 	movq	%rcx, %cr3;
 	movq	%rax, %cr4;  # turn PGE back on
 
-	movl	nr_copy_pages(%rip), %eax
-	xorl	%ecx, %ecx
-	movq	$0, %r10
-	testl	%eax, %eax
-	jz	done
-.L105:
-	xorl	%esi, %esi
-	movq	$0, %r11
-	jmp	.L104
-	.p2align 4,,7
-copy_one_page:
-	movq	%r10, %rcx
-.L104:
-	movq	pagedir_nosave(%rip), %rdx
-	movq	%rcx, %rax
-	salq	$5, %rax
-	movq	8(%rdx,%rax), %rcx
-	movq	(%rdx,%rax), %rax
-	movzbl	(%rsi,%rax), %eax
-	movb	%al, (%rsi,%rcx)
-
-	movq	%cr3, %rax;  # flush TLB
-	movq	%rax, %cr3;
-
-	movq	%r11, %rax
-	incq	%rax
-	cmpq	$4095, %rax
-	movq	%rax, %rsi
-	movq	%rax, %r11
-	jbe	copy_one_page
-	movq	%r10, %rax
-	incq	%rax
-	movq	%rax, %rcx
-	movq	%rax, %r10
-	mov	nr_copy_pages(%rip), %eax
-	cmpq	%rax, %rcx
-	jb	.L105
+	movq	pagedir_nosave(%rip), %rax
+	testq	%rax, %rax
+	je		done
+
+copyback_page:
+	movq	24(%rax), %r9
+	xorl	%r8d, %r8d
+
+copy_one_pgdir:
+	movq    8(%rax), %rdi
+	testq   %rdi, %rdi
+	je  	done
+	movq    (%rax), %rsi
+	movq    $512, %rcx
+	rep
+	movsq
+
+	incq    %r8
+	addq    $32, %rax
+	cmpq    $127, %r8
+	jbe 	copy_one_pgdir; # copy one pgdir
+
+	testq   %r9, %r9
+	movq    %r9, %rax
+	jne 	copyback_page
+
 done:
 	movl	$24, %eax
 	movl	%eax, %ds

-- 
Hu Gang       .-.
              /v\
             // \\ 
Linux User  /(   )\  [204016]
GPG Key ID   ^^-^^   http://soulinfo.com/~hugang/hugang.asc
