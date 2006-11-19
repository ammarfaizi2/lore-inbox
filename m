Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932575AbWKSR44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbWKSR44 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 12:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbWKSR44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 12:56:56 -0500
Received: from il.qumranet.com ([62.219.232.206]:46006 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S932575AbWKSR4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 12:56:55 -0500
Subject: [PATCH] KVM: Expose MSRs to userspace (v2)
From: Avi Kivity <avi@qumranet.com>
Date: Sun, 19 Nov 2006 17:56:51 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, uril@qumranet.com
Message-Id: <20061119175652.0ABBB25015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v1:

 - get msrs and set msrs are now symmetric: both accept a list of msrs. it
   is now possible to retrieve a single msr.
 - a new KVM_GET_MSR_INDEX_LIST allows discovering which msrs are supported
   by kvm (previously this was integrated into KVM_GET_MSRS)
 - error handling is simpler and correcter
 - the implementation is collapsed into a single msr_io() function
 - avoid pointers in ioctl structs, instead use zero length arrays

Andrew, this patch replaces kvm-exposer-msrs-to-userspace.patch.

--

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
@@ -129,6 +129,8 @@ static const u32 vmx_msr_index[] = {
 #define MSR_IA32_VMX_EXIT_CTLS_MSR		0x483
 #define MSR_IA32_VMX_ENTRY_CTLS_MSR		0x484
 
+#define MAX_IO_MSRS 256
+
 #define CR0_RESEVED_BITS 0xffffffff1ffaffc0ULL
 #define LMSW_GUEST_MASK 0x0eULL
 #define CR4_RESEVED_BITS (~((1ULL << 11) - 1))
@@ -2298,21 +2300,22 @@ static int handle_cpuid(struct kvm_vcpu 
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
@@ -2351,11 +2354,25 @@ static int handle_rdmsr(struct kvm_vcpu 
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
@@ -2401,22 +2418,16 @@ static void set_efer(struct kvm_vcpu *vc
 
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
@@ -2437,7 +2448,7 @@ static int handle_wrmsr(struct kvm_vcpu 
 #ifdef __x86_64
 	case MSR_EFER:
 		set_efer(vcpu, data);
-		return 1;
+		break;
 	case MSR_IA32_MC0_STATUS:
 		printk(KERN_WARNING "%s: MSR_IA32_MC0_STATUS 0x%llx, nop\n"
 			    , __FUNCTION__, data);
@@ -2455,16 +2466,31 @@ static int handle_wrmsr(struct kvm_vcpu 
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
 
@@ -3121,6 +3147,106 @@ static int kvm_dev_ioctl_set_sregs(struc
 }
 
 /*
+ * List of msr numbers which we expose to userspace through KVM_GET_MSRS
+ * and KVM_SET_MSRS, and KVM_GET_MSR_INDEX_LIST.
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
+
+/*
+ * Adapt set_msr() to msr_io()'s calling convention
+ */
+static int do_set_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
+{
+	return set_msr(vcpu, index, *data);
+}
+
+/*
+ * Read or write a bunch of msrs. All parameters are kernel addresses.
+ *
+ * @return number of msrs set successfully.
+ */
+static int __msr_io(struct kvm *kvm, struct kvm_msrs *msrs,
+		    struct kvm_msr_entry *entries,
+		    int (*do_msr)(struct kvm_vcpu *vcpu,
+				  unsigned index, u64 *data))
+{
+	struct kvm_vcpu *vcpu;
+	int i;
+
+	if (msrs->vcpu < 0 || msrs->vcpu >= KVM_MAX_VCPUS)
+		return -EINVAL;
+
+	vcpu = vcpu_load(kvm, msrs->vcpu);
+	if (!vcpu)
+		return -ENOENT;
+
+	for (i = 0; i < msrs->nmsrs; ++i)
+		if (do_msr(vcpu, entries[i].index, &entries[i].data))
+			break;
+
+	vcpu_put(vcpu);
+
+	return i;
+}
+
+/*
+ * Read or write a bunch of msrs. Parameters are user addresses.
+ *
+ * @return number of msrs set successfully.
+ */
+static int msr_io(struct kvm *kvm, struct kvm_msrs __user *user_msrs,
+		  int (*do_msr)(struct kvm_vcpu *vcpu,
+				unsigned index, u64 *data),
+		  int writeback)
+{
+	struct kvm_msrs msrs;
+	struct kvm_msr_entry *entries;
+	int r, n;
+	unsigned size;
+
+	r = -EFAULT;
+	if (copy_from_user(&msrs, user_msrs, sizeof msrs))
+		goto out;
+
+	r = -E2BIG;
+	if (msrs.nmsrs >= MAX_IO_MSRS)
+		goto out;
+
+	r = -ENOMEM;
+	size = sizeof(struct kvm_msr_entry) * msrs.nmsrs;
+	entries = vmalloc(size);
+	if (!entries)
+		goto out;
+
+	r = -EFAULT;
+	if (copy_from_user(entries, user_msrs->entries, size))
+		goto out_free;
+
+	r = n = __msr_io(kvm, &msrs, entries, do_msr);
+	if (r < 0)
+		goto out_free;
+
+	r = -EFAULT;
+	if (writeback && copy_to_user(user_msrs->entries, entries, size))
+		goto out_free;
+
+	r = n;
+
+out_free:
+	vfree(entries);
+out:
+	return r;
+}
+
+/*
  * Translate a guest virtual address to a guest physical address.
  */
 static int kvm_dev_ioctl_translate(struct kvm *kvm, struct kvm_translation *tr)
@@ -3361,6 +3487,33 @@ static long kvm_dev_ioctl(struct file *f
 			goto out;
 		break;
 	}
+	case KVM_GET_MSRS:
+		r = msr_io(kvm, (void __user *)arg, get_msr, 1);
+		break;
+	case KVM_SET_MSRS:
+		r = msr_io(kvm, (void __user *)arg, do_set_msr, 0);
+		break;
+	case KVM_GET_MSR_INDEX_LIST: {
+		struct kvm_msr_list __user *user_msr_list = (void __user *)arg;
+		struct kvm_msr_list msr_list;
+		unsigned n;
+
+		r = -EFAULT;
+		if (copy_from_user(&msr_list, user_msr_list, sizeof msr_list))
+			goto out;
+		n = msr_list.nmsrs;
+		msr_list.nmsrs = ARRAY_SIZE(msrs_to_save);
+		if (copy_to_user(user_msr_list, &msr_list, sizeof msr_list))
+			goto out;
+		r = -E2BIG;
+		if (n < ARRAY_SIZE(msrs_to_save))
+			goto out;
+		r = -EFAULT;
+		if (copy_to_user(user_msr_list->indices, &msrs_to_save,
+				 sizeof msrs_to_save))
+			goto out;
+		r = 0;
+	}
 	default:
 		;
 	}
Index: linux-2.6/include/linux/kvm.h
===================================================================
--- linux-2.6.orig/include/linux/kvm.h
+++ linux-2.6/include/linux/kvm.h
@@ -141,6 +141,26 @@ struct kvm_sregs {
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
+	struct kvm_msr_entry entries[0];
+};
+
+/* for KVM_GET_MSR_INDEX_LIST */
+struct kvm_msr_list {
+	__u32 nmsrs; /* number of msrs in entries */
+	__u32 indices[0];
+};
+
 /* for KVM_TRANSLATE */
 struct kvm_translation {
 	/* in */
@@ -200,5 +220,8 @@ struct kvm_dirty_log {
 #define KVM_SET_MEMORY_REGION     _IOW(KVMIO, 10, struct kvm_memory_region)
 #define KVM_CREATE_VCPU           _IOW(KVMIO, 11, int /* vcpu_slot */)
 #define KVM_GET_DIRTY_LOG         _IOW(KVMIO, 12, struct kvm_dirty_log)
+#define KVM_GET_MSRS              _IOWR(KVMIO, 13, struct kvm_msrs)
+#define KVM_SET_MSRS              _IOWR(KVMIO, 14, struct kvm_msrs)
+#define KVM_GET_MSR_INDEX_LIST    _IOWR(KVMIO, 15, struct kvm_msr_list)
 
 #endif
