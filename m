Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbVAVCu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbVAVCu6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 21:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262649AbVAVCu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 21:50:58 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:24738 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262648AbVAVCug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 21:50:36 -0500
Date: Sat, 22 Jan 2005 03:50:19 +0100
From: Andi Kleen <ak@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH][RFC] swsusp: speed up image restoring on x86-64
Message-ID: <20050122025019.GC27060@wotan.suse.de>
References: <200501202032.31481.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501202032.31481.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 08:32:31PM +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> The following patch speeds up the restoring of swsusp images on x86-64
> and makes the assembly code more readable (tested and works on AMD64).  It's
> against 2.6.11-rc1-mm1, but applies to 2.6.11-rc1-mm2.  Please consifer for applying.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Thanks. I applied it with some small changes to not hardcode any 
C fields. 

BTW Pavel, while reading the code I noticed some dubious things
in the code:

- The TLB flush doesn't flush global pages (turn of PGE and turn it
on again). Since that handles kernel pages which are marked global
this is surely wrong. 

- Also is it really needed to flush the TLB after each page and wouldn't
INVLPG be better here? Or do you want to flush other pages than the
just copied one there too? INVLPG would also take care of the global
pages at least on x86-64 (iirc there are some bugs in this regard on some
older i386 cpus) 

- There is a comment that says the code shouldn't use stack, but 
it definitely uses the stack for some things. Either the comment
or the code is wrong. Which is?


-Andi


The following patch speeds up the restoring of swsusp images on x86-64
and makes the assembly code more readable (tested and works on AMD64).  It's
against 2.6.11-rc1-mm1, but applies to 2.6.11-rc1-mm2.  Please consifer for applying.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Changed by AK to not hardcode any C values and get them from offset.h
instead.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/x86_64/kernel/suspend_asm.S
===================================================================
--- linux.orig/arch/x86_64/kernel/suspend_asm.S	2004-10-19 01:55:08.%N +0200
+++ linux/arch/x86_64/kernel/suspend_asm.S	2005-01-22 03:20:28.%N +0100
@@ -11,6 +12,7 @@
 #include <linux/linkage.h>
 #include <asm/segment.h>
 #include <asm/page.h>
+#include <asm/offset.h>
 
 ENTRY(swsusp_arch_suspend)
 
@@ -49,43 +51,31 @@
 	movq	%rcx, %cr3;
 	movq	%rax, %cr4;  # turn PGE back on
 
+	movq	pagedir_nosave(%rip), %rdx
+	/* compute the limit */
 	movl	nr_copy_pages(%rip), %eax
-	xorl	%ecx, %ecx
-	movq	$0, %r10
 	testl	%eax, %eax
 	jz	done
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
+	movq	%rdx,%r8
+	movl	$SIZEOF_PBE,%r9d
+	mul		%r9  # with rax, clobbers rdx
+	movq 	%r8, %rdx
+	addq	%r8, %rax
+loop:
+	/* get addresses from the pbe and copy the page */
+	movq	pbe_address(%rdx), %rsi
+	movq	pbe_orig_address(%rdx), %rdi
+	movq	$512, %rcx
+	rep
+	movsq
+
+	movq	%cr3, %rcx;  # flush TLB
+	movq	%rcx, %cr3;
+
+	/* progress to the next pbe */
+	addq	$SIZEOF_PBE, %rdx
+	cmpq	%rax, %rdx
+	jb	loop
 done:
 	movl	$24, %eax
 	movl	%eax, %ds
Index: linux/arch/x86_64/kernel/asm-offsets.c
===================================================================
--- linux.orig/arch/x86_64/kernel/asm-offsets.c	2004-10-19 01:55:08.%N +0200
+++ linux/arch/x86_64/kernel/asm-offsets.c	2005-01-22 03:09:50.%N +0100
@@ -8,6 +8,7 @@
 #include <linux/stddef.h>
 #include <linux/errno.h> 
 #include <linux/hardirq.h>
+#include <linux/suspend.h>
 #include <asm/pda.h>
 #include <asm/processor.h>
 #include <asm/segment.h>
@@ -61,6 +62,8 @@
 	       offsetof (struct rt_sigframe32, uc.uc_mcontext));
 	BLANK();
 #endif
-
+	DEFINE(SIZEOF_PBE, sizeof(struct pbe));
+	DEFINE(pbe_address, offsetof(struct pbe, address));
+	DEFINE(pbe_orig_address, offsetof(struct pbe, orig_address));	
 	return 0;
 }
