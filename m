Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268045AbUJMJtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268045AbUJMJtV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 05:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268155AbUJMJtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 05:49:21 -0400
Received: from fmr12.intel.com ([134.134.136.15]:39064 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S268045AbUJMJtR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 05:49:17 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH x86_64]: Correct copy_user_generic return value when exception happens
Date: Wed, 13 Oct 2004 17:49:11 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E8490E1DA@pdsmsx404>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH x86_64]: Correct copy_user_generic return value when exception happens
Thread-Index: AcSt5QWpVL6ooJXiR0KPkdX8I02GAADIm1Xg
From: "Jin, Gordon" <gordon.jin@intel.com>
To: <discuss@x86-64.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Oct 2004 09:49:13.0870 (UTC) FILETIME=[E5A2F2E0:01C4B109]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Fix a bug that arch/x86_64/lib/copy_user:copy_user_generic will return a wrong
value when exception happens.
In the case the address is not 8-byte aligned (i.e. go into Lbad_alignment),
if exception happens in Ls11, %rdx will be wrong number of copied bytes,
then copy_user_generic returns wrong value.
It also fixed a bug of zeroing wrong number of bytes of destination at this
situation. (In Lzero_rest)

Signed-off-by: Yanmin Zhang <yanmin.zhang@intel.com>
Signed-off-by: Nanhai Zou <nanhai.zou@intel.com>
Signed-off-by: Gordon Jin <gordon.jin@intel.com>
Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

--- linux-2.6.9-rc3/arch/x86_64/lib/copy_user.S~	2004-07-15 13:30:14.376131432 -0700
+++ linux-2.6.9-rc3/arch/x86_64/lib/copy_user.S	2004-07-15 23:41:40.572981784 -0700
@@ -73,7 +73,7 @@
  * rdx count
  *
  * Output:		
- * eax uncopied bytes or 0 if successfull. 
+ * eax uncopied bytes or 0 if successful.
  */
 	.globl copy_user_generic	
 	.p2align 4
@@ -179,9 +179,9 @@
 	movl $8,%r9d
 	subl %ecx,%r9d
 	movl %r9d,%ecx
-	subq %r9,%rdx
-	jz   .Lsmall_align
-	js   .Lsmall_align
+	cmpq %r9,%rdx
+	jz   .Lhandle_7
+	js   .Lhandle_7
 .Lalign_1:		
 .Ls11:	movb (%rsi),%bl
 .Ld11:	movb %bl,(%rdi)
@@ -189,10 +189,8 @@
 	incq %rdi
 	decl %ecx
 	jnz .Lalign_1
+	subq %r9,%rdx
 	jmp .Lafter_bad_alignment
-.Lsmall_align:
-	addq %r9,%rdx
-	jmp .Lhandle_7
 #endif
 	
 	/* table sorted by exception address */	
@@ -219,8 +217,8 @@
 	.quad .Ls10,.Le_byte
 	.quad .Ld10,.Le_byte
 #ifdef FIX_ALIGNMENT	
-	.quad .Ls11,.Le_byte
-	.quad .Ld11,.Le_byte
+	.quad .Ls11,.Lzero_rest
+	.quad .Ld11,.Lzero_rest
 #endif
 	.quad .Le5,.Le_zero
 	.previous

Thanks,
Gordon 
