Return-Path: <linux-kernel-owner+w=401wt.eu-S932958AbWL1KMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932958AbWL1KMU (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 05:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932935AbWL1KMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 05:12:20 -0500
Received: from il.qumranet.com ([62.219.232.206]:44581 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932958AbWL1KMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 05:12:19 -0500
Subject: [PATCH 5/8] KVM: Move common msr handling to arch independent code
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 28 Dec 2006 10:12:17 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <45939755.7010603@qumranet.com>
In-Reply-To: <45939755.7010603@qumranet.com>
Message-Id: <20061228101217.6FA3A2500F7@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -1103,6 +1103,47 @@ void realmode_set_cr(struct kvm_vcpu *vc
 	}
 }
 
+int kvm_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
+{
+	u64 data;
+
+	switch (msr) {
+	case 0xc0010010: /* SYSCFG */
+	case 0xc0010015: /* HWCR */
+	case MSR_IA32_PLATFORM_ID:
+	case MSR_IA32_P5_MC_ADDR:
+	case MSR_IA32_P5_MC_TYPE:
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
+#ifdef CONFIG_X86_64
+	case MSR_EFER:
+		data = vcpu->shadow_efer;
+		break;
+#endif
+	default:
+		printk(KERN_ERR "kvm: unhandled rdmsr: 0x%x\n", msr);
+		return 1;
+	}
+	*pdata = data;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kvm_get_msr_common);
+
 /*
  * Reads an msr value (of 'msr_index') into 'pdata'.
  * Returns 0 on success, non-0 otherwise.
@@ -1115,7 +1156,7 @@ static int get_msr(struct kvm_vcpu *vcpu
 
 #ifdef CONFIG_X86_64
 
-void set_efer(struct kvm_vcpu *vcpu, u64 efer)
+static void set_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
 	if (efer & EFER_RESERVED_BITS) {
 		printk(KERN_DEBUG "set_efer: 0x%llx #GP, reserved bits\n",
@@ -1138,10 +1179,36 @@ void set_efer(struct kvm_vcpu *vcpu, u64
 
 	vcpu->shadow_efer = efer;
 }
-EXPORT_SYMBOL_GPL(set_efer);
 
 #endif
 
+int kvm_set_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 data)
+{
+	switch (msr) {
+#ifdef CONFIG_X86_64
+	case MSR_EFER:
+		set_efer(vcpu, data);
+		break;
+#endif
+	case MSR_IA32_MC0_STATUS:
+		printk(KERN_WARNING "%s: MSR_IA32_MC0_STATUS 0x%llx, nop\n",
+		       __FUNCTION__, data);
+		break;
+	case MSR_IA32_UCODE_REV:
+	case MSR_IA32_UCODE_WRITE:
+	case 0x200 ... 0x2ff: /* MTRRs */
+		break;
+	case MSR_IA32_APICBASE:
+		vcpu->apic_base = data;
+		break;
+	default:
+		printk(KERN_ERR "kvm: unhandled wrmsr: 0x%x\n", msr);
+		return 1;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kvm_set_msr_common);
+
 /*
  * Writes msr value into into the appropriate "register".
  * Returns 0 on success, non-0 otherwise.
Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -374,9 +374,8 @@ void set_cr4(struct kvm_vcpu *vcpu, unsi
 void set_cr8(struct kvm_vcpu *vcpu, unsigned long cr0);
 void lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
 
-#ifdef CONFIG_X86_64
-void set_efer(struct kvm_vcpu *vcpu, u64 efer);
-#endif
+int kvm_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata);
+int kvm_set_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 data);
 
 void fx_init(struct kvm_vcpu *vcpu);
 
Index: linux-2.6/drivers/kvm/svm.c
===================================================================
--- linux-2.6.orig/drivers/kvm/svm.c
+++ linux-2.6/drivers/kvm/svm.c
@@ -1068,25 +1068,6 @@ static int emulate_on_interception(struc
 static int svm_get_msr(struct kvm_vcpu *vcpu, unsigned ecx, u64 *data)
 {
 	switch (ecx) {
-	case 0xc0010010: /* SYSCFG */
-	case 0xc0010015: /* HWCR */
-	case MSR_IA32_PLATFORM_ID:
-	case MSR_IA32_P5_MC_ADDR:
-	case MSR_IA32_P5_MC_TYPE:
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
-		*data = 0;
-		break;
 	case MSR_IA32_TIME_STAMP_COUNTER: {
 		u64 tsc;
 
@@ -1094,12 +1075,6 @@ static int svm_get_msr(struct kvm_vcpu *
 		*data = vcpu->svm->vmcb->control.tsc_offset + tsc;
 		break;
 	}
-	case MSR_EFER:
-		*data = vcpu->shadow_efer;
-		break;
-	case MSR_IA32_APICBASE:
-		*data = vcpu->apic_base;
-		break;
 	case MSR_K6_STAR:
 		*data = vcpu->svm->vmcb->save.star;
 		break;
@@ -1127,8 +1102,7 @@ static int svm_get_msr(struct kvm_vcpu *
 		*data = vcpu->svm->vmcb->save.sysenter_esp;
 		break;
 	default:
-		printk(KERN_ERR "kvm: unhandled rdmsr: 0x%x\n", ecx);
-		return 1;
+		return kvm_get_msr_common(vcpu, ecx, data);
 	}
 	return 0;
 }
@@ -1152,15 +1126,6 @@ static int rdmsr_interception(struct kvm
 static int svm_set_msr(struct kvm_vcpu *vcpu, unsigned ecx, u64 data)
 {
 	switch (ecx) {
-#ifdef CONFIG_X86_64
-	case MSR_EFER:
-		set_efer(vcpu, data);
-		break;
-#endif
-	case MSR_IA32_MC0_STATUS:
-		printk(KERN_WARNING "%s: MSR_IA32_MC0_STATUS 0x%llx, nop\n"
-			    , __FUNCTION__, data);
-		break;
 	case MSR_IA32_TIME_STAMP_COUNTER: {
 		u64 tsc;
 
@@ -1168,13 +1133,6 @@ static int svm_set_msr(struct kvm_vcpu *
 		vcpu->svm->vmcb->control.tsc_offset = data - tsc;
 		break;
 	}
-	case MSR_IA32_UCODE_REV:
-	case MSR_IA32_UCODE_WRITE:
-	case 0x200 ... 0x2ff: /* MTRRs */
-		break;
-	case MSR_IA32_APICBASE:
-		vcpu->apic_base = data;
-		break;
 	case MSR_K6_STAR:
 		vcpu->svm->vmcb->save.star = data;
 		break;
@@ -1202,8 +1160,7 @@ static int svm_set_msr(struct kvm_vcpu *
 		vcpu->svm->vmcb->save.sysenter_esp = data;
 		break;
 	default:
-		printk(KERN_ERR "kvm: unhandled wrmsr: %x\n", ecx);
-		return 1;
+		return kvm_set_msr_common(vcpu, ecx, data);
 	}
 	return 0;
 }
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -344,8 +344,7 @@ static int vmx_get_msr(struct kvm_vcpu *
 		data = vmcs_readl(GUEST_GS_BASE);
 		break;
 	case MSR_EFER:
-		data = vcpu->shadow_efer;
-		break;
+		return kvm_get_msr_common(vcpu, msr_index, pdata);
 #endif
 	case MSR_IA32_TIME_STAMP_COUNTER:
 		data = guest_read_tsc();
@@ -359,36 +358,13 @@ static int vmx_get_msr(struct kvm_vcpu *
 	case MSR_IA32_SYSENTER_ESP:
 		data = vmcs_read32(GUEST_SYSENTER_ESP);
 		break;
-	case 0xc0010010: /* SYSCFG */
-	case 0xc0010015: /* HWCR */
-	case MSR_IA32_PLATFORM_ID:
-	case MSR_IA32_P5_MC_ADDR:
-	case MSR_IA32_P5_MC_TYPE:
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
 	default:
 		msr = find_msr_entry(vcpu, msr_index);
-		if (!msr) {
-			printk(KERN_ERR "kvm: unhandled rdmsr: %x\n", msr_index);
-			return 1;
+		if (msr) {
+			data = msr->data;
+			break;
 		}
-		data = msr->data;
-		break;
+		return kvm_get_msr_common(vcpu, msr_index, pdata);
 	}
 
 	*pdata = data;
@@ -405,6 +381,8 @@ static int vmx_set_msr(struct kvm_vcpu *
 	struct vmx_msr_entry *msr;
 	switch (msr_index) {
 #ifdef CONFIG_X86_64
+	case MSR_EFER:
+		return kvm_set_msr_common(vcpu, msr_index, data);
 	case MSR_FS_BASE:
 		vmcs_writel(GUEST_FS_BASE, data);
 		break;
@@ -421,32 +399,17 @@ static int vmx_set_msr(struct kvm_vcpu *
 	case MSR_IA32_SYSENTER_ESP:
 		vmcs_write32(GUEST_SYSENTER_ESP, data);
 		break;
-#ifdef __x86_64
-	case MSR_EFER:
-		set_efer(vcpu, data);
-		break;
-	case MSR_IA32_MC0_STATUS:
-		printk(KERN_WARNING "%s: MSR_IA32_MC0_STATUS 0x%llx, nop\n"
-			    , __FUNCTION__, data);
-		break;
-#endif
 	case MSR_IA32_TIME_STAMP_COUNTER: {
 		guest_write_tsc(data);
 		break;
 	}
-	case MSR_IA32_UCODE_REV:
-	case MSR_IA32_UCODE_WRITE:
-	case 0x200 ... 0x2ff: /* MTRRs */
-		break;
-	case MSR_IA32_APICBASE:
-		vcpu->apic_base = data;
-		break;
 	default:
 		msr = find_msr_entry(vcpu, msr_index);
-		if (!msr) {
-			printk(KERN_ERR "kvm: unhandled wrmsr: 0x%x\n", msr_index);
-			return 1;
+		if (msr) {
+			msr->data = data;
+			break;
 		}
+		return kvm_set_msr_common(vcpu, msr_index, data);
 		msr->data = data;
 		break;
 	}
