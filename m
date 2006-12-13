Return-Path: <linux-kernel-owner+w=401wt.eu-S964959AbWLMNOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWLMNOl (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 08:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbWLMNOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 08:14:17 -0500
Received: from il.qumranet.com ([62.219.232.206]:47437 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964959AbWLMNOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 08:14:14 -0500
Subject: [PATCH 1/3] KVM: add valid_vcpu() helper
From: Avi Kivity <avi@qumranet.com>
Date: Wed, 13 Dec 2006 12:43:56 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <457FF542.6050602@qumranet.com>
In-Reply-To: <457FF542.6050602@qumranet.com>
Message-Id: <20061213124356.BB12E25017C@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morris <jmorris@namei.org>

Consolidate the logic for checking whether a vcpu index is valid.  Also, 
use likely(), as a valid value should be the overwhelmingly common case.

Signed-off-by: James Morris <jmorris@namei.org>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -113,6 +113,11 @@ unsigned long segment_base(u16 selector)
 }
 EXPORT_SYMBOL_GPL(segment_base);
 
+static inline int valid_vcpu(int n)
+{
+	return likely(n >= 0 && n < KVM_MAX_VCPUS);
+}
+
 int kvm_read_guest(struct kvm_vcpu *vcpu,
 			     gva_t addr,
 			     unsigned long size,
@@ -494,7 +499,7 @@ static int kvm_dev_ioctl_create_vcpu(str
 	struct kvm_vcpu *vcpu;
 
 	r = -EINVAL;
-	if (n < 0 || n >= KVM_MAX_VCPUS)
+	if (!valid_vcpu(n))
 		goto out;
 
 	vcpu = &kvm->vcpus[n];
@@ -1179,7 +1184,7 @@ static int kvm_dev_ioctl_run(struct kvm 
 	struct kvm_vcpu *vcpu;
 	int r;
 
-	if (kvm_run->vcpu < 0 || kvm_run->vcpu >= KVM_MAX_VCPUS)
+	if (!valid_vcpu(kvm_run->vcpu))
 		return -EINVAL;
 
 	vcpu = vcpu_load(kvm, kvm_run->vcpu);
@@ -1208,7 +1213,7 @@ static int kvm_dev_ioctl_get_regs(struct
 {
 	struct kvm_vcpu *vcpu;
 
-	if (regs->vcpu < 0 || regs->vcpu >= KVM_MAX_VCPUS)
+	if (!valid_vcpu(regs->vcpu))
 		return -EINVAL;
 
 	vcpu = vcpu_load(kvm, regs->vcpu);
@@ -1254,7 +1259,7 @@ static int kvm_dev_ioctl_set_regs(struct
 {
 	struct kvm_vcpu *vcpu;
 
-	if (regs->vcpu < 0 || regs->vcpu >= KVM_MAX_VCPUS)
+	if (!valid_vcpu(regs->vcpu))
 		return -EINVAL;
 
 	vcpu = vcpu_load(kvm, regs->vcpu);
@@ -1301,7 +1306,7 @@ static int kvm_dev_ioctl_get_sregs(struc
 	struct kvm_vcpu *vcpu;
 	struct descriptor_table dt;
 
-	if (sregs->vcpu < 0 || sregs->vcpu >= KVM_MAX_VCPUS)
+	if (!valid_vcpu(sregs->vcpu))
 		return -EINVAL;
 	vcpu = vcpu_load(kvm, sregs->vcpu);
 	if (!vcpu)
@@ -1353,7 +1358,7 @@ static int kvm_dev_ioctl_set_sregs(struc
 	int i;
 	struct descriptor_table dt;
 
-	if (sregs->vcpu < 0 || sregs->vcpu >= KVM_MAX_VCPUS)
+	if (!valid_vcpu(sregs->vcpu))
 		return -EINVAL;
 	vcpu = vcpu_load(kvm, sregs->vcpu);
 	if (!vcpu)
@@ -1444,7 +1449,7 @@ static int __msr_io(struct kvm *kvm, str
 	struct kvm_vcpu *vcpu;
 	int i;
 
-	if (msrs->vcpu < 0 || msrs->vcpu >= KVM_MAX_VCPUS)
+	if (!valid_vcpu(msrs->vcpu))
 		return -EINVAL;
 
 	vcpu = vcpu_load(kvm, msrs->vcpu);
@@ -1537,7 +1542,7 @@ static int kvm_dev_ioctl_interrupt(struc
 {
 	struct kvm_vcpu *vcpu;
 
-	if (irq->vcpu < 0 || irq->vcpu >= KVM_MAX_VCPUS)
+	if (!valid_vcpu(irq->vcpu))
 		return -EINVAL;
 	if (irq->irq < 0 || irq->irq >= 256)
 		return -EINVAL;
@@ -1559,7 +1564,7 @@ static int kvm_dev_ioctl_debug_guest(str
 	struct kvm_vcpu *vcpu;
 	int r;
 
-	if (dbg->vcpu < 0 || dbg->vcpu >= KVM_MAX_VCPUS)
+	if (!valid_vcpu(dbg->vcpu))
 		return -EINVAL;
 	vcpu = vcpu_load(kvm, dbg->vcpu);
 	if (!vcpu)
