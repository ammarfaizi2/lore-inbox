Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758093AbWK0MRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758093AbWK0MRk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758087AbWK0MRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:17:39 -0500
Received: from il.qumranet.com ([62.219.232.206]:32693 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758093AbWK0MRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:17:38 -0500
Subject: [PATCH 7/38] KVM: Make msr accessors arch operations
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:17:37 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127121737.4984F25015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -245,6 +245,8 @@ struct kvm_arch_ops {
 
 	int (*set_guest_debug)(struct kvm_vcpu *vcpu,
 			       struct kvm_debug_guest *dbg);
+	int (*get_msr)(struct kvm_vcpu *vcpu, u32 msr_index, u64 *pdata);
+	int (*set_msr)(struct kvm_vcpu *vcpu, u32 msr_index, u64 data);
 };
 
 extern struct kvm_stat kvm_stat;
@@ -401,6 +403,8 @@ static inline struct kvm_mmu_page *page_
 #define ASM_VMX_VMXOFF            ".byte 0x0f, 0x01, 0xc4"
 #define ASM_VMX_VMXON_RAX         ".byte 0xf3, 0x0f, 0xc7, 0x30"
 
+#define MSR_IA32_TIME_STAMP_COUNTER		0x010
+
 #ifdef __x86_64__
 
 /*
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -122,7 +122,6 @@ static const u32 vmx_msr_index[] = {
 #define TSS_REDIRECTION_SIZE (256 / 8)
 #define RMODE_TSS_SIZE (TSS_BASE_SIZE + TSS_REDIRECTION_SIZE + TSS_IOPB_SIZE + 1)
 
-#define MSR_IA32_TIME_STAMP_COUNTER		0x010
 #define MSR_IA32_FEATURE_CONTROL 		0x03a
 #define MSR_IA32_VMX_PINBASED_CTLS_MSR		0x481
 #define MSR_IA32_VMX_PROCBASED_CTLS_MSR		0x482
@@ -143,7 +142,7 @@ static const u32 vmx_msr_index[] = {
 #define HOST_IS_64 0
 #endif
 
-static struct vmx_msr_entry *find_msr_entry(struct kvm_vcpu *vcpu, u32 msr)
+struct vmx_msr_entry *find_msr_entry(struct kvm_vcpu *vcpu, u32 msr)
 {
 	int i;
 
@@ -152,6 +151,7 @@ static struct vmx_msr_entry *find_msr_en
 			return &vcpu->guest_msrs[i];
 	return 0;
 }
+EXPORT_SYMBOL_GPL(find_msr_entry);
 
 struct descriptor_table {
 	u16 limit;
@@ -657,7 +657,7 @@ static void inject_gp(struct kvm_vcpu *v
  * reads and returns guest's timestamp counter "register"
  * guest_tsc = host_tsc + tsc_offset    -- 21.3
  */
-static u64 guest_read_tsc(void)
+u64 guest_read_tsc(void)
 {
 	u64 host_tsc, tsc_offset;
 
@@ -665,18 +665,20 @@ static u64 guest_read_tsc(void)
 	tsc_offset = vmcs_read64(TSC_OFFSET);
 	return host_tsc + tsc_offset;
 }
+EXPORT_SYMBOL_GPL(guest_read_tsc);
 
 /*
  * writes 'guest_tsc' into guest's timestamp counter "register"
  * guest_tsc = host_tsc + tsc_offset ==> tsc_offset = guest_tsc - host_tsc
  */
-static void guest_write_tsc(u64 guest_tsc)
+void guest_write_tsc(u64 guest_tsc)
 {
 	u64 host_tsc;
 
 	rdtscll(host_tsc);
 	vmcs_write64(TSC_OFFSET, guest_tsc - host_tsc);
 }
+EXPORT_SYMBOL_GPL(guest_write_tsc);
 
 static void update_exception_bitmap(struct kvm_vcpu *vcpu)
 {
@@ -2242,67 +2244,7 @@ static int handle_cpuid(struct kvm_vcpu 
  */
 static int get_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 *pdata)
 {
-	u64 data;
-	struct vmx_msr_entry *msr;
-
-	if (!pdata) {
-		printk(KERN_ERR "BUG: get_msr called with NULL pdata\n");
-		return -EINVAL;
-	}
-
-	switch (msr_index) {
-#ifdef __x86_64__
-	case MSR_FS_BASE:
-		data = vmcs_readl(GUEST_FS_BASE);
-		break;
-	case MSR_GS_BASE:
-		data = vmcs_readl(GUEST_GS_BASE);
-		break;
-	case MSR_EFER:
-		data = vcpu->shadow_efer;
-		break;
-#endif
-	case MSR_IA32_TIME_STAMP_COUNTER:
-		data = guest_read_tsc();
-		break;
-	case MSR_IA32_SYSENTER_CS:
-		data = vmcs_read32(GUEST_SYSENTER_CS);
-		break;
-	case MSR_IA32_SYSENTER_EIP:
-		data = vmcs_read32(GUEST_SYSENTER_EIP);
-		break;
-	case MSR_IA32_SYSENTER_ESP:
-		data = vmcs_read32(GUEST_SYSENTER_ESP);
-		break;
-	case MSR_IA32_MC0_CTL:
-	case MSR_IA32_MCG_STATUS:
-	case MSR_IA32_MCG_CAP:
-	case MSR_IA32_MC0_MISC:
-	case MSR_IA32_MC0_MISC+4:
-	case MSR_IA32_MC0_MISC+8:
-	case MSR_IA32_MC0_MISC+12:
-	case MSR_IA32_MC0_MISC+16:
-	case MSR_IA32_UCODE_REV:
-		/* MTRR registers */
-	case 0xfe:
-	case 0x200 ... 0x2ff:
-		data = 0;
-		break;
-	case MSR_IA32_APICBASE:
-		data = vcpu->apic_base;
-		break;
-	default:
-		msr = find_msr_entry(vcpu, msr_index);
-		if (!msr) {
-			printk(KERN_ERR "kvm: unhandled rdmsr: %x\n", msr_index);
-			return 1;
-		}
-		data = msr->data;
-		break;
-	}
-
-	*pdata = data;
-	return 0;
+	return kvm_arch_ops->get_msr(vcpu, msr_index, pdata);
 }
 
 static int handle_rdmsr(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
@@ -2324,7 +2266,7 @@ static int handle_rdmsr(struct kvm_vcpu 
 
 #ifdef __x86_64__
 
-static void set_efer(struct kvm_vcpu *vcpu, u64 efer)
+void set_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
 	struct vmx_msr_entry *msr;
 
@@ -2353,10 +2295,10 @@ static void set_efer(struct kvm_vcpu *vc
 	msr->data = efer;
 	skip_emulated_instruction(vcpu);
 }
+EXPORT_SYMBOL_GPL(set_efer);
 
 #endif
 
-
 /*
  * Writes msr value into into the appropriate "register".
  * Returns 0 on success, non-0 otherwise.
@@ -2364,56 +2306,7 @@ static void set_efer(struct kvm_vcpu *vc
  */
 static int set_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 data)
 {
-	struct vmx_msr_entry *msr;
-	switch (msr_index) {
-#ifdef __x86_64__
-	case MSR_FS_BASE:
-		vmcs_writel(GUEST_FS_BASE, data);
-		break;
-	case MSR_GS_BASE:
-		vmcs_writel(GUEST_GS_BASE, data);
-		break;
-#endif
-	case MSR_IA32_SYSENTER_CS:
-		vmcs_write32(GUEST_SYSENTER_CS, data);
-		break;
-	case MSR_IA32_SYSENTER_EIP:
-		vmcs_write32(GUEST_SYSENTER_EIP, data);
-		break;
-	case MSR_IA32_SYSENTER_ESP:
-		vmcs_write32(GUEST_SYSENTER_ESP, data);
-		break;
-#ifdef __x86_64
-	case MSR_EFER:
-		set_efer(vcpu, data);
-		break;
-	case MSR_IA32_MC0_STATUS:
-		printk(KERN_WARNING "%s: MSR_IA32_MC0_STATUS 0x%llx, nop\n"
-			    , __FUNCTION__, data);
-		break;
-#endif
-	case MSR_IA32_TIME_STAMP_COUNTER: {
-		guest_write_tsc(data);
-		break;
-	}
-	case MSR_IA32_UCODE_REV:
-	case MSR_IA32_UCODE_WRITE:
-	case 0x200 ... 0x2ff: /* MTRRs */
-		break;
-	case MSR_IA32_APICBASE:
-		vcpu->apic_base = data;
-		break;
-	default:
-		msr = find_msr_entry(vcpu, msr_index);
-		if (!msr) {
-			printk(KERN_ERR "kvm: unhandled wrmsr: 0x%x\n", msr_index);
-			return 1;
-		}
-		msr->data = data;
-		break;
-	}
-
-	return 0;
+	return kvm_arch_ops->set_msr(vcpu, msr_index, data);
 }
 
 static int handle_wrmsr(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -31,6 +31,146 @@ extern struct vmcs_descriptor {
 	u32 revision_id;
 } vmcs_descriptor;
 
+u64 guest_read_tsc(void);
+void guest_write_tsc(u64 guest_tsc);
+struct vmx_msr_entry *find_msr_entry(struct kvm_vcpu *vcpu, u32 msr);
+
+#ifdef __x86_64__
+
+void set_efer(struct kvm_vcpu *vcpu, u64 efer);
+
+#endif
+
+
+/*
+ * Reads an msr value (of 'msr_index') into 'pdata'.
+ * Returns 0 on success, non-0 otherwise.
+ * Assumes vcpu_load() was already called.
+ */
+static int vmx_get_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 *pdata)
+{
+	u64 data;
+	struct vmx_msr_entry *msr;
+
+	if (!pdata) {
+		printk(KERN_ERR "BUG: get_msr called with NULL pdata\n");
+		return -EINVAL;
+	}
+
+	switch (msr_index) {
+#ifdef __x86_64__
+	case MSR_FS_BASE:
+		data = vmcs_readl(GUEST_FS_BASE);
+		break;
+	case MSR_GS_BASE:
+		data = vmcs_readl(GUEST_GS_BASE);
+		break;
+	case MSR_EFER:
+		data = vcpu->shadow_efer;
+		break;
+#endif
+	case MSR_IA32_TIME_STAMP_COUNTER:
+		data = guest_read_tsc();
+		break;
+	case MSR_IA32_SYSENTER_CS:
+		data = vmcs_read32(GUEST_SYSENTER_CS);
+		break;
+	case MSR_IA32_SYSENTER_EIP:
+		data = vmcs_read32(GUEST_SYSENTER_EIP);
+		break;
+	case MSR_IA32_SYSENTER_ESP:
+		data = vmcs_read32(GUEST_SYSENTER_ESP);
+		break;
+	case MSR_IA32_MC0_CTL:
+	case MSR_IA32_MCG_STATUS:
+	case MSR_IA32_MCG_CAP:
+	case MSR_IA32_MC0_MISC:
+	case MSR_IA32_MC0_MISC+4:
+	case MSR_IA32_MC0_MISC+8:
+	case MSR_IA32_MC0_MISC+12:
+	case MSR_IA32_MC0_MISC+16:
+	case MSR_IA32_UCODE_REV:
+		/* MTRR registers */
+	case 0xfe:
+	case 0x200 ... 0x2ff:
+		data = 0;
+		break;
+	case MSR_IA32_APICBASE:
+		data = vcpu->apic_base;
+		break;
+	default:
+		msr = find_msr_entry(vcpu, msr_index);
+		if (!msr) {
+			printk(KERN_ERR "kvm: unhandled rdmsr: %x\n", msr_index);
+			return 1;
+		}
+		data = msr->data;
+		break;
+	}
+
+	*pdata = data;
+	return 0;
+}
+
+/*
+ * Writes msr value into into the appropriate "register".
+ * Returns 0 on success, non-0 otherwise.
+ * Assumes vcpu_load() was already called.
+ */
+static int vmx_set_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 data)
+{
+	struct vmx_msr_entry *msr;
+	switch (msr_index) {
+#ifdef __x86_64__
+	case MSR_FS_BASE:
+		vmcs_writel(GUEST_FS_BASE, data);
+		break;
+	case MSR_GS_BASE:
+		vmcs_writel(GUEST_GS_BASE, data);
+		break;
+#endif
+	case MSR_IA32_SYSENTER_CS:
+		vmcs_write32(GUEST_SYSENTER_CS, data);
+		break;
+	case MSR_IA32_SYSENTER_EIP:
+		vmcs_write32(GUEST_SYSENTER_EIP, data);
+		break;
+	case MSR_IA32_SYSENTER_ESP:
+		vmcs_write32(GUEST_SYSENTER_ESP, data);
+		break;
+#ifdef __x86_64
+	case MSR_EFER:
+		set_efer(vcpu, data);
+		break;
+	case MSR_IA32_MC0_STATUS:
+		printk(KERN_WARNING "%s: MSR_IA32_MC0_STATUS 0x%llx, nop\n"
+			    , __FUNCTION__, data);
+		break;
+#endif
+	case MSR_IA32_TIME_STAMP_COUNTER: {
+		guest_write_tsc(data);
+		break;
+	}
+	case MSR_IA32_UCODE_REV:
+	case MSR_IA32_UCODE_WRITE:
+	case 0x200 ... 0x2ff: /* MTRRs */
+		break;
+	case MSR_IA32_APICBASE:
+		vcpu->apic_base = data;
+		break;
+	default:
+		msr = find_msr_entry(vcpu, msr_index);
+		if (!msr) {
+			printk(KERN_ERR "kvm: unhandled wrmsr: 0x%x\n", msr_index);
+			return 1;
+		}
+		msr->data = data;
+		break;
+	}
+
+	return 0;
+}
+
 static int set_guest_debug(struct kvm_vcpu *vcpu, struct kvm_debug_guest *dbg)
 {
 	unsigned long dr7 = 0x400;
@@ -169,6 +309,8 @@ static struct kvm_arch_ops vmx_arch_ops 
 	.hardware_disable = hardware_disable,
 
 	.set_guest_debug = set_guest_debug,
+	.get_msr = vmx_get_msr,
+	.set_msr = vmx_set_msr,
 };
 
 static int __init vmx_init(void)
