Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424091AbWKPSEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424091AbWKPSEY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 13:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424125AbWKPSEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 13:04:24 -0500
Received: from il.qumranet.com ([62.219.232.206]:22472 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1424091AbWKPSEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 13:04:23 -0500
Subject: [PATCH 3/3] KVM: Expose MSRs to userspace
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 16 Nov 2006 18:04:22 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, uril@qumranet.com
References: <455CA70C.9060307@qumranet.com>
In-Reply-To: <455CA70C.9060307@qumranet.com>
Message-Id: <20061116180422.0CC9325015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uri Lublin <uril@qumranet.com>

Expose the model-specific registers to userspace.  Primarily useful for
save/resume.

Signed-off-by: Uri Lublin <uril@qumranet.com>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -106,11 +106,7 @@ struct vmcs {
 	char data[0];
 };
 
-struct vmx_msr_entry {
-	u32 index;
-	u32 reserved;
-	u64 data;
-};
+#define vmx_msr_entry kvm_msr_entry
 
 struct kvm_vcpu;
 
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -2298,21 +2298,22 @@ static int handle_cpuid(struct kvm_vcpu 
 	return 0;
 }
 
-static int handle_rdmsr(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
+/*
+ * Reads an msr value (of 'msr_index') into 'pdata'.
+ * Returns 0 on success, non-0 otherwise.
+ * Assumes vcpu_load() was already called.
+ */
+static int get_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 *pdata)
 {
-	u32 ecx = vcpu->regs[VCPU_REGS_RCX];
-	struct vmx_msr_entry *msr = find_msr_entry(vcpu, ecx);
 	u64 data;
+	struct vmx_msr_entry *msr;
 
-#ifdef KVM_DEBUG
-	if (guest_cpl() != 0) {
-		vcpu_printf(vcpu, "%s: not supervisor\n", __FUNCTION__);
-		inject_gp(vcpu);
-		return 1;
+	if (!pdata) {
+		printk(KERN_ERR "BUG: get_msr called with NULL pdata\n");
+		return -EINVAL;
 	}
-#endif
 
-	switch (ecx) {
+	switch (msr_index) {
 #ifdef __x86_64__
 	case MSR_FS_BASE:
 		data = vmcs_readl(GUEST_FS_BASE);
@@ -2351,11 +2352,25 @@ static int handle_rdmsr(struct kvm_vcpu 
 		data = vcpu->apic_base;
 		break;
 	default:
-		if (msr) {
-			data = msr->data;
-			break;
+		msr = find_msr_entry(vcpu, msr_index);
+		if (!msr) {
+			printk(KERN_ERR "kvm: unhandled rdmsr: %x\n", msr_index);
+			return 1;
 		}
-		printk(KERN_ERR "kvm: unhandled rdmsr: %x\n", ecx);
+		data = msr->data;
+		break;
+	}
+
+	*pdata = data;
+	return 0;
+}
+
+static int handle_rdmsr(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
+{
+	u32 ecx = vcpu->regs[VCPU_REGS_RCX];
+	u64 data;
+
+	if (get_msr(vcpu, ecx, &data)) {
 		inject_gp(vcpu);
 		return 1;
 	}
@@ -2401,22 +2416,16 @@ static void set_efer(struct kvm_vcpu *vc
 
 #endif
 
-static int handle_wrmsr(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
+
+/*
+ * Writes msr value into into the appropriate "register".
+ * Returns 0 on success, non-0 otherwise.
+ * Assumes vcpu_load() was already called.
+ */
+static int set_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 data)
 {
-	u32 ecx = vcpu->regs[VCPU_REGS_RCX];
 	struct vmx_msr_entry *msr;
-	u64 data = (vcpu->regs[VCPU_REGS_RAX] & -1u)
-		| ((u64)(vcpu->regs[VCPU_REGS_RDX] & -1u) << 32);
-
-#ifdef KVM_DEBUG
-	if (guest_cpl() != 0) {
-		vcpu_printf(vcpu, "%s: not supervisor\n", __FUNCTION__);
-		inject_gp(vcpu);
-		return 1;
-	}
-#endif
-
-	switch (ecx) {
+	switch (msr_index) {
 #ifdef __x86_64__
 	case MSR_FS_BASE:
 		vmcs_writel(GUEST_FS_BASE, data);
@@ -2437,7 +2446,7 @@ static int handle_wrmsr(struct kvm_vcpu 
 #ifdef __x86_64
 	case MSR_EFER:
 		set_efer(vcpu, data);
-		return 1;
+		break;
 	case MSR_IA32_MC0_STATUS:
 		printk(KERN_WARNING "%s: MSR_IA32_MC0_STATUS 0x%llx, nop\n"
 			    , __FUNCTION__, data);
@@ -2455,16 +2464,31 @@ static int handle_wrmsr(struct kvm_vcpu 
 		vcpu->apic_base = data;
 		break;
 	default:
-		msr = find_msr_entry(vcpu, ecx);
-		if (msr) {
-			msr->data = data;
-			break;
+		msr = find_msr_entry(vcpu, msr_index);
+		if (!msr) {
+			printk(KERN_ERR "kvm: unhandled wrmsr: 0x%x\n", msr_index);
+			return 1;
 		}
-		printk(KERN_ERR "kvm: unhandled wrmsr: %x\n", ecx);
+		msr->data = data;
+		break;
+	}
+
+	return 0;
+}
+
+static int handle_wrmsr(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
+{
+	u32 ecx = vcpu->regs[VCPU_REGS_RCX];
+	u64 data = (vcpu->regs[VCPU_REGS_RAX] & -1u)
+		| ((u64)(vcpu->regs[VCPU_REGS_RDX] & -1u) << 32);
+
+	if (set_msr(vcpu, ecx, data) != 0) {
 		inject_gp(vcpu);
 		return 1;
 	}
-	skip_emulated_instruction(vcpu);
+
+	if (ecx != MSR_EFER)
+		skip_emulated_instruction(vcpu);
 	return 1;
 }
 
@@ -3121,6 +3145,125 @@ static int kvm_dev_ioctl_set_sregs(struc
 }
 
 /*
+ * List of msr numbers which we expose to userspace through KVM_GET_MSRS
+ * and KVM_SET_MSRS.
+ */
+static u32 msrs_to_save[] = {
+	MSR_IA32_SYSENTER_CS, MSR_IA32_SYSENTER_ESP, MSR_IA32_SYSENTER_EIP,
+	MSR_K6_STAR,
+#ifdef __x86_64__
+	MSR_CSTAR, MSR_KERNEL_GS_BASE, MSR_SYSCALL_MASK, MSR_LSTAR,
+#endif
+	MSR_IA32_TIME_STAMP_COUNTER,
+};
+
+static int kvm_dev_ioctl_get_msrs(struct kvm *kvm, struct kvm_msrs *msrs)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_msr_entry *entry, *entries;
+	int rc;
+	u32 size, num_entries, i;
+
+	if (msrs->vcpu < 0 || msrs->vcpu >= KVM_MAX_VCPUS)
+		return -EINVAL;
+
+	num_entries = ARRAY_SIZE(msrs_to_save);
+	if (msrs->nmsrs < num_entries) {
+		/* inform actual number of entries */
+		msrs->nmsrs = num_entries;
+		return -EINVAL;
+	}
+
+	vcpu = vcpu_load(kvm, msrs->vcpu);
+	if (!vcpu)
+		return -ENOENT;
+
+	msrs->nmsrs = num_entries; /* update to actual number of entries */
+	size = msrs->nmsrs * sizeof(struct kvm_msr_entry);
+	rc = -E2BIG;
+	if (size > 4096)
+		goto out_vcpu;
+
+	rc = -ENOMEM;
+	entries = vmalloc(size);
+	if (entries == NULL)
+		goto out_vcpu;
+
+	memset(entries, 0, size);
+	rc = -EINVAL;
+	for (i=0; i<num_entries; i++) {
+		entry = &entries[i];
+		entry->index = msrs_to_save[i];
+		if (get_msr(vcpu, entry->index, &entry->data))
+			goto out_free;
+	}
+
+	rc = -EFAULT;
+	if (copy_to_user(msrs->entries, entries, size))
+		goto out_free;
+
+	rc = 0;
+out_free:
+	vfree(entries);
+
+out_vcpu:
+	vcpu_put(vcpu);
+
+	return rc;
+}
+
+static int kvm_dev_ioctl_set_msrs(struct kvm *kvm, struct kvm_msrs *msrs)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_msr_entry *entry, *entries;
+	int rc;
+	u32 size, num_entries, i;
+
+	if (msrs->vcpu < 0 || msrs->vcpu >= KVM_MAX_VCPUS)
+		return -EINVAL;
+
+	num_entries = ARRAY_SIZE(msrs_to_save);
+	if (msrs->nmsrs < num_entries) {
+		msrs->nmsrs = num_entries; /* inform actual size */
+		return -EINVAL;
+	}
+
+	vcpu = vcpu_load(kvm, msrs->vcpu);
+	if (!vcpu)
+		return -ENOENT;
+
+	size = msrs->nmsrs * sizeof(struct kvm_msr_entry);
+	rc = -E2BIG;
+	if (size > 4096)
+		goto out_vcpu;
+
+	rc = -ENOMEM;
+	entries = vmalloc(size);
+	if (entries == NULL)
+		goto out_vcpu;
+
+	rc = -EFAULT;
+	if (copy_from_user(entries, msrs->entries, size))
+		goto out_free;
+
+	rc = -EINVAL;
+	for (i=0; i<num_entries; i++) {
+		entry = &entries[i];
+		if (set_msr(vcpu, entry->index,  entry->data))
+			goto out_free;
+	}
+
+	rc = 0;
+out_free:
+	vfree(entries);
+
+out_vcpu:
+	vcpu_put(vcpu);
+
+	return rc;
+}
+
+/*
  * Translate a guest virtual address to a guest physical address.
  */
 static int kvm_dev_ioctl_translate(struct kvm *kvm, struct kvm_translation *tr)
@@ -3361,6 +3504,33 @@ static long kvm_dev_ioctl(struct file *f
 			goto out;
 		break;
 	}
+	case KVM_GET_MSRS: {
+		struct kvm_msrs kvm_msrs;
+
+		r = -EFAULT;
+		if (copy_from_user(&kvm_msrs, (void *)arg, sizeof kvm_msrs))
+			goto out;
+		r = kvm_dev_ioctl_get_msrs(kvm, &kvm_msrs);
+		if (r)
+			goto out;
+		r = -EFAULT;
+		if (copy_to_user((void *)arg, &kvm_msrs, sizeof kvm_msrs))
+			goto out;
+		r = 0;
+		break;
+	}
+	case KVM_SET_MSRS: {
+		struct kvm_msrs kvm_msrs;
+
+		r = -EFAULT;
+		if (copy_from_user(&kvm_msrs, (void *)arg, sizeof kvm_msrs))
+			goto out;
+		r = kvm_dev_ioctl_set_msrs(kvm, &kvm_msrs);
+		if (r)
+			goto out;
+		r = 0;
+		break;
+	}
 	default:
 		;
 	}
Index: linux-2.6/include/linux/kvm.h
===================================================================
--- linux-2.6.orig/include/linux/kvm.h
+++ linux-2.6/include/linux/kvm.h
@@ -141,6 +141,23 @@ struct kvm_sregs {
 	__u64 interrupt_bitmap[KVM_IRQ_BITMAP_SIZE(__u64)];
 };
 
+struct kvm_msr_entry {
+	__u32 index;
+	__u32 reserved;
+	__u64 data;
+};
+
+/* for KVM_GET_MSRS and KVM_SET_MSRS */
+struct kvm_msrs {
+	__u32 vcpu;
+	__u32 nmsrs; /* number of msrs in entries */
+
+	union {
+		struct kvm_msr_entry __user *entries;
+		__u64 padding;
+	};
+};
+
 /* for KVM_TRANSLATE */
 struct kvm_translation {
 	/* in */
@@ -200,5 +217,7 @@ struct kvm_dirty_log {
 #define KVM_SET_MEMORY_REGION     _IOW(KVMIO, 10, struct kvm_memory_region)
 #define KVM_CREATE_VCPU           _IOW(KVMIO, 11, int /* vcpu_slot */)
 #define KVM_GET_DIRTY_LOG         _IOW(KVMIO, 12, struct kvm_dirty_log)
+#define KVM_GET_MSRS              _IOWR(KVMIO, 13, struct kvm_msrs)
+#define KVM_SET_MSRS              _IOW(KVMIO, 14, struct kvm_msrs)
 
 #endif
