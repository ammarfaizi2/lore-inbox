Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbVATTdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVATTdW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 14:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVATTcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 14:32:54 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:1729 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261881AbVATTc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 14:32:28 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][RFC] swsusp: speed up image restoring on x86-64
Date: Thu, 20 Jan 2005 20:32:31 +0100
User-Agent: KMail/1.7.1
Cc: Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501202032.31481.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch speeds up the restoring of swsusp images on x86-64
and makes the assembly code more readable (tested and works on AMD64).  It's
against 2.6.11-rc1-mm1, but applies to 2.6.11-rc1-mm2.  Please consifer for applying.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

--- linux-2.6.11-rc1-mm1/arch/x86_64/kernel/suspend_asm.S	2004-12-24 22:35:28.000000000 +0100
+++ linux-2.6.11-rc1-mm1-rjw/arch/x86_64/kernel/suspend_asm.S	2005-01-20 17:28:30.000000000 +0100
@@ -49,43 +49,28 @@
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
+	shlq	$5, %rax; # multiply by sizeof(struct pbe)
+	addq	%rdx, %rax
+loop:
+	/* get addresses from the pbe and copy the page */
+	movq	(%rdx), %rsi
+	movq	8(%rdx), %rdi
+	movq	$512, %rcx
+	rep
+	movsq
 
-	movq	%cr3, %rax;  # flush TLB
-	movq	%rax, %cr3;
+	movq	%cr3, %rcx;  # flush TLB
+	movq	%rcx, %cr3;
 
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
+	/* progress to the next pbe */
+	addq	$32, %rdx; # add sizeof(struct pbe)
+	cmpq	%rax, %rdx
+	jb	loop
 done:
 	movl	$24, %eax
 	movl	%eax, %ds



Greets,
RJW


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
