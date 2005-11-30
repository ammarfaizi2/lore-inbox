Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbVK3E0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbVK3E0D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 23:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbVK3EZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 23:25:23 -0500
Received: from kanga.kvack.org ([66.96.29.28]:27624 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750920AbVK3EY4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 23:24:56 -0500
Date: Tue, 29 Nov 2005 23:21:57 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] x86-64 dont use r10 in copy_user and csum-copy
Message-ID: <20051130042157.GG19112@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update the copy_user and csum-copy code to not use r10.

---

 arch/x86_64/lib/copy_user.S |   10 ++++++----
 arch/x86_64/lib/csum-copy.S |   24 +++++++++++++-----------
 2 files changed, 19 insertions(+), 15 deletions(-)

applies-to: 4f2f2d8e70acfdb1d900d930faf9efb83276c4fc
13612c34183fa4f266508d0252c2b678b7f5ce0f
diff --git a/arch/x86_64/lib/copy_user.S b/arch/x86_64/lib/copy_user.S
index dfa358b..f24497d 100644
--- a/arch/x86_64/lib/copy_user.S
+++ b/arch/x86_64/lib/copy_user.S
@@ -95,6 +95,7 @@ copy_user_generic:	
 	.previous
 .Lcug:	
 	pushq %rbx
+	pushq %r12
 	xorl %eax,%eax		/*zero for the exception handler */
 
 #ifdef FIX_ALIGNMENT
@@ -117,20 +118,20 @@ copy_user_generic:	
 .Ls1:	movq (%rsi),%r11
 .Ls2:	movq 1*8(%rsi),%r8
 .Ls3:	movq 2*8(%rsi),%r9
-.Ls4:	movq 3*8(%rsi),%r10
+.Ls4:	movq 3*8(%rsi),%r12
 .Ld1:	movq %r11,(%rdi)
 .Ld2:	movq %r8,1*8(%rdi)
 .Ld3:	movq %r9,2*8(%rdi)
-.Ld4:	movq %r10,3*8(%rdi)
+.Ld4:	movq %r12,3*8(%rdi)
 		
 .Ls5:	movq 4*8(%rsi),%r11
 .Ls6:	movq 5*8(%rsi),%r8
 .Ls7:	movq 6*8(%rsi),%r9
-.Ls8:	movq 7*8(%rsi),%r10
+.Ls8:	movq 7*8(%rsi),%r12
 .Ld5:	movq %r11,4*8(%rdi)
 .Ld6:	movq %r8,5*8(%rdi)
 .Ld7:	movq %r9,6*8(%rdi)
-.Ld8:	movq %r10,7*8(%rdi)
+.Ld8:	movq %r12,7*8(%rdi)
 	
 	decq %rdx
 
@@ -169,6 +170,7 @@ copy_user_generic:	
 	jnz .Lloop_1
 			
 .Lende:
+	popq %r12
 	popq %rbx
 	ret	
 
diff --git a/arch/x86_64/lib/csum-copy.S b/arch/x86_64/lib/csum-copy.S
index 72fd55e..b3d69e5 100644
--- a/arch/x86_64/lib/csum-copy.S
+++ b/arch/x86_64/lib/csum-copy.S
@@ -60,12 +60,13 @@ csum_partial_copy_generic:
 	jle	 .Lignore
 
 .Lignore:		
-	subq  $7*8,%rsp
+	subq  $8*8,%rsp
 	movq  %rbx,2*8(%rsp)
 	movq  %r12,3*8(%rsp)
 	movq  %r14,4*8(%rsp)
 	movq  %r13,5*8(%rsp)
-	movq  %rbp,6*8(%rsp)
+	movq  %r15,6*8(%rsp)
+	movq  %rbp,7*8(%rsp)
 
 	movq  %r8,(%rsp)
 	movq  %r9,1*8(%rsp)
@@ -84,7 +85,7 @@ csum_partial_copy_generic:
 	/* main loop. clear in 64 byte blocks */
 	/* r9: zero, r8: temp2, rbx: temp1, rax: sum, rcx: saved length */
 	/* r11:	temp3, rdx: temp4, r12 loopcnt */
-	/* r10:	temp5, rbp: temp6, r14 temp7, r13 temp8 */
+	/* r15:	temp5, rbp: temp6, r14 temp7, r13 temp8 */
 	.p2align 4
 .Lloop:
 	source
@@ -97,7 +98,7 @@ csum_partial_copy_generic:
 	movq  24(%rdi),%rdx
 
 	source
-	movq  32(%rdi),%r10
+	movq  32(%rdi),%r15
 	source
 	movq  40(%rdi),%rbp
 	source
@@ -112,7 +113,7 @@ csum_partial_copy_generic:
 	adcq  %r8,%rax
 	adcq  %r11,%rax
 	adcq  %rdx,%rax
-	adcq  %r10,%rax
+	adcq  %r15,%rax
 	adcq  %rbp,%rax
 	adcq  %r14,%rax
 	adcq  %r13,%rax
@@ -129,7 +130,7 @@ csum_partial_copy_generic:
 	movq %rdx,24(%rsi)
 
 	dest
-	movq %r10,32(%rsi)
+	movq %r15,32(%rsi)
 	dest
 	movq %rbp,40(%rsi)
 	dest
@@ -149,7 +150,7 @@ csum_partial_copy_generic:
 	/* do last upto 56 bytes */
 .Lhandle_tail:
 	/* ecx:	count */
-	movl %ecx,%r10d
+	movl %ecx,%r15d
 	andl $63,%ecx
 	shrl $3,%ecx
 	jz 	 .Lfold
@@ -176,7 +177,7 @@ csum_partial_copy_generic:
 
 	/* do last upto 6 bytes */	
 .Lhandle_7:
-	movl %r10d,%ecx
+	movl %r15d,%ecx
 	andl $7,%ecx
 	shrl $1,%ecx
 	jz   .Lhandle_1
@@ -198,7 +199,7 @@ csum_partial_copy_generic:
 	
 	/* handle last odd byte */
 .Lhandle_1:
-	testl $1,%r10d
+	testl $1,%r15d
 	jz    .Lende
 	xorl  %ebx,%ebx
 	source
@@ -213,8 +214,9 @@ csum_partial_copy_generic:
 	movq 3*8(%rsp),%r12
 	movq 4*8(%rsp),%r14
 	movq 5*8(%rsp),%r13
-	movq 6*8(%rsp),%rbp
-	addq $7*8,%rsp
+	movq 6*8(%rsp),%r15
+	movq 7*8(%rsp),%rbp
+	addq $8*8,%rsp
 	ret
 
 	/* Exception handlers. Very simple, zeroing is done in the wrappers */
---
0.99.9.GIT
