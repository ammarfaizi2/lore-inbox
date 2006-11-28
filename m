Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758350AbWK1Mmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758350AbWK1Mmv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 07:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758363AbWK1Mmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 07:42:51 -0500
Received: from il.qumranet.com ([62.219.232.206]:21446 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758350AbWK1Mmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 07:42:50 -0500
Subject: [PATCH 4/6] KVM: AMD SVM: Add data structures
From: Avi Kivity <avi@qumranet.com>
Date: Tue, 28 Nov 2006 12:42:49 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, yaniv.kamay@qumranet.com,
       mingo@elte.hu
References: <456C2D89.4050508@qumranet.com>
In-Reply-To: <456C2D89.4050508@qumranet.com>
Message-Id: <20061128124249.6B74325015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the AMD specific vcpu structure.

Signed-off-by: Yaniv Kamay <yaniv@qumranet.com>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -166,7 +166,10 @@ enum {
 
 struct kvm_vcpu {
 	struct kvm *kvm;
-	struct vmcs *vmcs;
+	union {
+		struct vmcs *vmcs;
+		struct vcpu_svm *svm;
+	};
 	struct mutex mutex;
 	int   cpu;
 	int   launched;
Index: linux-2.6/drivers/kvm/kvm_svm.h
===================================================================
--- /dev/null
+++ linux-2.6/drivers/kvm/kvm_svm.h
@@ -0,0 +1,42 @@
+#ifndef __KVM_SVM_H
+#define __KVM_SVM_H
+
+#include <linux/types.h>
+#include <linux/list.h>
+#include <asm/msr.h>
+
+#include "svm.h"
+#include "kvm.h"
+
+static const u32 host_save_msrs[] = {
+	MSR_STAR, MSR_LSTAR, MSR_CSTAR, MSR_SYSCALL_MASK, MSR_KERNEL_GS_BASE,
+	MSR_IA32_SYSENTER_CS, MSR_IA32_SYSENTER_ESP, MSR_IA32_SYSENTER_EIP,
+	MSR_IA32_DEBUGCTLMSR, /*MSR_IA32_LASTBRANCHFROMIP,
+	MSR_IA32_LASTBRANCHTOIP, MSR_IA32_LASTINTFROMIP,MSR_IA32_LASTINTTOIP,*/
+	MSR_FS_BASE, MSR_GS_BASE,
+};
+
+#define NR_HOST_SAVE_MSRS (sizeof(host_save_msrs) / sizeof(*host_save_msrs))
+#define NUM_DB_REGS 4
+
+struct vcpu_svm {
+	struct vmcb *vmcb;
+	unsigned long vmcb_pa;
+	struct svm_cpu_data *svm_data;
+	uint64_t asid_generation;
+
+	unsigned long cr0;
+	unsigned long cr4;
+	unsigned long db_regs[NUM_DB_REGS];
+
+	u64 next_rip;
+
+	u64 host_msrs[NR_HOST_SAVE_MSRS];
+	unsigned long host_cr2;
+	unsigned long host_db_regs[NUM_DB_REGS];
+	unsigned long host_dr6;
+	unsigned long host_dr7;
+};
+
+#endif
+
