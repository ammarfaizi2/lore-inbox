Return-Path: <linux-kernel-owner+w=401wt.eu-S964969AbWLMNOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbWLMNOk (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 08:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbWLMNOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 08:14:18 -0500
Received: from il.qumranet.com ([62.219.232.206]:47433 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964960AbWLMNOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 08:14:14 -0500
Subject: [PATCH 3/3] KVM: AMD SVM: Save and restore the floating point unit
	state
From: Avi Kivity <avi@qumranet.com>
Date: Wed, 13 Dec 2006 12:45:57 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <457FF542.6050602@qumranet.com>
In-Reply-To: <457FF542.6050602@qumranet.com>
Message-Id: <20061213124557.102AB2502E4@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes sf bug 1614113 (segfaults in nbench).

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/svm.c
===================================================================
--- linux-2.6.orig/drivers/kvm/svm.c
+++ linux-2.6/drivers/kvm/svm.c
@@ -575,6 +575,8 @@ static int svm_create_vcpu(struct kvm_vc
 	memset(vcpu->svm->db_regs, 0, sizeof(vcpu->svm->db_regs));
 	init_vmcb(vcpu->svm->vmcb);
 
+	fx_init(vcpu);
+
 	return 0;
 
 out2:
@@ -1387,6 +1389,10 @@ again:
 		save_db_regs(vcpu->svm->host_db_regs);
 		load_db_regs(vcpu->svm->db_regs);
 	}
+
+	fx_save(vcpu->host_fx_image);
+	fx_restore(vcpu->guest_fx_image);
+
 	asm volatile (
 #ifdef CONFIG_X86_64
 		"push %%rbx; push %%rcx; push %%rdx;"
@@ -1496,6 +1502,9 @@ again:
 #endif
 		: "cc", "memory" );
 
+	fx_save(vcpu->guest_fx_image);
+	fx_restore(vcpu->host_fx_image);
+
 	if ((vcpu->svm->vmcb->save.dr7 & 0xff))
 		load_db_regs(vcpu->svm->host_db_regs);
 
