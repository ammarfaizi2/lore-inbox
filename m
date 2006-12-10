Return-Path: <linux-kernel-owner+w=401wt.eu-S1762272AbWLJRLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762272AbWLJRLo (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 12:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762274AbWLJRLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 12:11:44 -0500
Received: from il.qumranet.com ([62.219.232.206]:33994 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762272AbWLJRLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 12:11:43 -0500
Subject: [PATCH 3/4] KVM: Clean up AMD SVM debug registers load and unload
From: Avi Kivity <avi@qumranet.com>
Date: Sun, 10 Dec 2006 17:11:42 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <457C3F26.2090100@qumranet.com>
In-Reply-To: <457C3F26.2090100@qumranet.com>
Message-Id: <20061210171142.7B0442500CF@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By letting gcc choose the temporary register for us, we lose arch
dependency and some ugliness.  Conceivably gcc will also generate
marginally better code.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/svm.c
===================================================================
--- linux-2.6.orig/drivers/kvm/svm.c
+++ linux-2.6/drivers/kvm/svm.c
@@ -1345,53 +1345,18 @@ static void kvm_reput_irq(struct kvm_vcp
 
 static void save_db_regs(unsigned long *db_regs)
 {
-#ifdef __x86_64__
-	asm ("mov %%dr0, %%rax \n\t"
-	     "mov %%rax, %[dr0] \n\t"
-	     "mov %%dr1, %%rax \n\t"
-	     "mov %%rax, %[dr1] \n\t"
-	     "mov %%dr2, %%rax \n\t"
-	     "mov %%rax, %[dr2] \n\t"
-	     "mov %%dr3, %%rax \n\t"
-	     "mov %%rax, %[dr3] \n\t"
-	     : [dr0] "=m"(db_regs[0]),
-	       [dr1] "=m"(db_regs[1]),
-	       [dr2] "=m"(db_regs[2]),
-	       [dr3] "=m"(db_regs[3])
-	     : : "rax");
-#else
-	asm ("mov %%dr0, %%eax \n\t"
-	     "mov %%eax, %[dr0] \n\t"
-	     "mov %%dr1, %%eax \n\t"
-	     "mov %%eax, %[dr1] \n\t"
-	     "mov %%dr2, %%eax \n\t"
-	     "mov %%eax, %[dr2] \n\t"
-	     "mov %%dr3, %%eax \n\t"
-	     "mov %%eax, %[dr3] \n\t"
-	     : [dr0] "=m"(db_regs[0]),
-	       [dr1] "=m"(db_regs[1]),
-	       [dr2] "=m"(db_regs[2]),
-	       [dr3] "=m"(db_regs[3])
-	     : : "eax");
-#endif
+	asm volatile ("mov %%dr0, %0" : "=r"(db_regs[0]));
+	asm volatile ("mov %%dr1, %0" : "=r"(db_regs[1]));
+	asm volatile ("mov %%dr2, %0" : "=r"(db_regs[2]));
+	asm volatile ("mov %%dr3, %0" : "=r"(db_regs[3]));
 }
 
 static void load_db_regs(unsigned long *db_regs)
 {
-	asm volatile ("mov %[dr0], %%dr0 \n\t"
-	     "mov %[dr1], %%dr1 \n\t"
-	     "mov %[dr2], %%dr2 \n\t"
-	     "mov %[dr3], %%dr3 \n\t"
-	     :
-	     : [dr0] "r"(db_regs[0]),
-	       [dr1] "r"(db_regs[1]),
-	       [dr2] "r"(db_regs[2]),
-	       [dr3] "r"(db_regs[3])
-#ifdef __x86_64__
-	     : "rax");
-#else
-	     : "eax");
-#endif
+	asm volatile ("mov %0, %%dr0" : : "r"(db_regs[0]));
+	asm volatile ("mov %0, %%dr1" : : "r"(db_regs[1]));
+	asm volatile ("mov %0, %%dr2" : : "r"(db_regs[2]));
+	asm volatile ("mov %0, %%dr3" : : "r"(db_regs[3]));
 }
 
 static int svm_vcpu_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
