Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbUCQVkT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 16:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbUCQVkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 16:40:18 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:54725 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262088AbUCQVjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 16:39:53 -0500
Date: 17 Mar 2004 16:37:15 -0500
Message-Id: <m33c8788ac.fsf@new.localdomain>
From: Jim Houston <jim.houston@comcast.net>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, amitkale@emsyssoft.com,
       linux-kernel@vger.kernel.org
Subject: Fixes for .cfi directives for x86_64 kgdb
Reply-to: jim.houston@comcast.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andi, Andrew, Amit,

The attached patch fixes the .cfi directives for the common_interrupt
path for opteron.  It seems that the existing .cfi directives in this
path only work by accident.

I spent yesterday decoding a stack by hand and looking at the
dwarf unwind data using "readelf -wF".  I found that the  existing
.cfi directives describe registers sharing the same stack addresses
(not a good thing).

This patch makes the unwind data make sense and makes gdb/kgdb more
likely to produce a useful stack traces.

Jim Houston - Concurrent Computer Corp.

--

diff -urN -X dontdiff linux-2.6.4-rc2-mm1.orig/arch/x86_64/kernel/entry.S linux-2.6.4-rc2-mm1/arch/x86_64/kernel/entry.S
--- linux-2.6.4-rc2-mm1.orig/arch/x86_64/kernel/entry.S	2004-03-10 17:06:03.000000000 -0500
+++ linux-2.6.4-rc2-mm1/arch/x86_64/kernel/entry.S	2004-03-17 09:19:30.000000000 -0500
@@ -402,9 +402,9 @@
 /* 0(%rsp): interrupt number */ 
 	.macro interrupt func
 	CFI_STARTPROC	simple
-	CFI_DEF_CFA	rsp,(SS-ORIG_RAX)
-	CFI_OFFSET	rsp,(RSP-SS)
-	CFI_OFFSET	rip,(RIP-SS)
+	CFI_DEF_CFA	rsp,(SS-RDI)
+	CFI_REL_OFFSET	rsp,(RSP-ORIG_RAX)
+	CFI_REL_OFFSET	rip,(RIP-ORIG_RAX)
 	cld
 #ifdef CONFIG_DEBUG_INFO
 	SAVE_ALL	
diff -urN -X dontdiff linux-2.6.4-rc2-mm1.orig/include/asm-x86_64/calling.h linux-2.6.4-rc2-mm1/include/asm-x86_64/calling.h
--- linux-2.6.4-rc2-mm1.orig/include/asm-x86_64/calling.h	2004-03-10 17:05:42.000000000 -0500
+++ linux-2.6.4-rc2-mm1/include/asm-x86_64/calling.h	2004-03-17 09:19:30.000000000 -0500
@@ -35,26 +35,26 @@
 	subq  $9*8+\addskip,%rsp
 	CFI_ADJUST_CFA_OFFSET	9*8+\addskip
 	movq  %rdi,8*8(%rsp) 
-	CFI_OFFSET	rdi,8*8-(9*8+\addskip)
+	CFI_REL_OFFSET	rdi,8*8
 	movq  %rsi,7*8(%rsp) 
-	CFI_OFFSET	rsi,7*8-(9*8+\addskip)
+	CFI_REL_OFFSET	rsi,7*8
 	movq  %rdx,6*8(%rsp)
-	CFI_OFFSET	rdx,6*8-(9*8+\addskip)
+	CFI_REL_OFFSET	rdx,6*8
 	.if \norcx
 	.else
 	movq  %rcx,5*8(%rsp)
-	CFI_OFFSET	rcx,5*8-(9*8+\addskip)
+	CFI_REL_OFFSET	rcx,5*8
 	.endif
 	movq  %rax,4*8(%rsp) 
-	CFI_OFFSET	rax,4*8-(9*8+\addskip)
+	CFI_REL_OFFSET	rax,4*8
 	movq  %r8,3*8(%rsp) 
-	CFI_OFFSET	r8,3*8-(9*8+\addskip)
+	CFI_REL_OFFSET	r8,3*8
 	movq  %r9,2*8(%rsp) 
-	CFI_OFFSET	r9,2*8-(9*8+\addskip)
+	CFI_REL_OFFSET	r9,2*8
 	movq  %r10,1*8(%rsp) 
-	CFI_OFFSET	r10,1*8-(9*8+\addskip)
+	CFI_REL_OFFSET	r10,1*8
 	movq  %r11,(%rsp) 
-	CFI_OFFSET	r11,-(9*8+\addskip)
+	CFI_REL_OFFSET	r11,
 	.endm
 
 #define ARG_SKIP 9*8
@@ -100,17 +100,17 @@
 	subq $REST_SKIP,%rsp
 	CFI_ADJUST_CFA_OFFSET	REST_SKIP
 	movq %rbx,5*8(%rsp) 
-	CFI_OFFSET	rbx,5*8-(REST_SKIP)
+	CFI_REL_OFFSET	rbx,5*8
 	movq %rbp,4*8(%rsp) 
-	CFI_OFFSET	rbp,4*8-(REST_SKIP)
+	CFI_REL_OFFSET	rbp,4*8
 	movq %r12,3*8(%rsp) 
-	CFI_OFFSET	r12,3*8-(REST_SKIP)
+	CFI_REL_OFFSET	r12,3*8
 	movq %r13,2*8(%rsp) 
-	CFI_OFFSET	r13,2*8-(REST_SKIP)
+	CFI_REL_OFFSET	r13,2*8
 	movq %r14,1*8(%rsp) 
-	CFI_OFFSET	r14,1*8-(REST_SKIP)
+	CFI_REL_OFFSET	r14,1*8
 	movq %r15,(%rsp) 
-	CFI_OFFSET	r15,0*8-(REST_SKIP)
+	CFI_REL_OFFSET	r15,0*8
 	.endm		
 
 	.macro RESTORE_REST
