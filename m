Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVDTXKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVDTXKm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 19:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVDTXKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 19:10:31 -0400
Received: from mailfe01.swip.net ([212.247.154.1]:45000 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261830AbVDTXKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 19:10:11 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: x86_64: Bug in new out of line put_user()
From: Alexander Nyberg <alexn@telia.com>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, nicolas@boichat.ch
Content-Type: text/plain
Date: Thu, 21 Apr 2005 01:10:09 +0200
Message-Id: <1114038609.500.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new out of line put_user() assembly on x86_64 changes %rcx without
telling GCC about it causing things like:

http://bugme.osdl.org/show_bug.cgi?id=4515 

See to it that %rcx is not changed (made it consistent with get_user()).


Signed-off-by: Alexander Nyberg <alexn@telia.com>

Index: test/arch/x86_64/lib/getuser.S
===================================================================
--- test.orig/arch/x86_64/lib/getuser.S	2005-04-20 23:55:35.000000000 +0200
+++ test/arch/x86_64/lib/getuser.S	2005-04-21 00:54:16.000000000 +0200
@@ -78,9 +78,9 @@
 __get_user_8:
 	GET_THREAD_INFO(%r8)
 	addq $7,%rcx
-	jc bad_get_user
+	jc 40f
 	cmpq threadinfo_addr_limit(%r8),%rcx
-	jae	bad_get_user
+	jae	40f
 	subq	$7,%rcx
 4:	movq (%rcx),%rdx
 	xorl %eax,%eax
Index: test/arch/x86_64/lib/putuser.S
===================================================================
--- test.orig/arch/x86_64/lib/putuser.S	2005-04-21 00:50:24.000000000 +0200
+++ test/arch/x86_64/lib/putuser.S	2005-04-21 01:02:15.000000000 +0200
@@ -46,36 +46,45 @@
 __put_user_2:
 	GET_THREAD_INFO(%r8)
 	addq $1,%rcx
-	jc bad_put_user
+	jc 20f
 	cmpq threadinfo_addr_limit(%r8),%rcx
-	jae	 bad_put_user
-2:	movw %dx,-1(%rcx)
+	jae 20f
+2:	decq %rcx
+	movw %dx,(%rcx)
 	xorl %eax,%eax
 	ret
+20:	decq %rcx
+	jmp bad_put_user
 
 	.p2align 4
 .globl __put_user_4
 __put_user_4:
 	GET_THREAD_INFO(%r8)
 	addq $3,%rcx
-	jc bad_put_user
+	jc 30f
 	cmpq threadinfo_addr_limit(%r8),%rcx
-	jae bad_put_user
-3:	movl %edx,-3(%rcx)
+	jae 30f
+3:	subq $3,%rcx
+	movl %edx,(%rcx)
 	xorl %eax,%eax
 	ret
+30:	subq $3,%rcx
+	jmp bad_put_user
 
 	.p2align 4
 .globl __put_user_8
 __put_user_8:
 	GET_THREAD_INFO(%r8)
 	addq $7,%rcx
-	jc bad_put_user
+	jc 40f
 	cmpq threadinfo_addr_limit(%r8),%rcx
-	jae	bad_put_user
-4:	movq %rdx,-7(%rcx)
+	jae 40f
+4:	subq $7,%rcx
+	movq %rdx,(%rcx)
 	xorl %eax,%eax
 	ret
+40:	subq $7,%rcx
+	jmp bad_put_user
 
 bad_put_user:
 	movq $(-EFAULT),%rax


