Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161717AbWKEUij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161717AbWKEUij (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 15:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161720AbWKEUii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 15:38:38 -0500
Received: from il.qumranet.com ([62.219.232.206]:43461 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1161717AbWKEUih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 15:38:37 -0500
Subject: [PATCH 10/14] KVM: less common exit handlers
From: Avi Kivity <avi@qumranet.com>
Date: Sun, 05 Nov 2006 20:38:35 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <454E4941.7000108@qumranet.com>
In-Reply-To: <454E4941.7000108@qumranet.com>
Message-Id: <20061105203835.BAF202500A7@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add exit handlers for msrs, debug registers, and cpuid.

Signed-off-by: Yaniv Kamay <yaniv@qumranet.com>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -2161,6 +2161,113 @@ static int handle_cr(struct kvm_vcpu *vc
 	return 0;
 }
 
+static int handle_dr(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
+{
+	u64 exit_qualification;
+	unsigned long val;
+	int dr, reg;
+
+	/*
+	 * FIXME: this code assumes the host is debugging the guest.
+	 *        need to deal with guest debugging itself too.
+	 */
+	exit_qualification = vmcs_read64(EXIT_QUALIFICATION);
+	dr = exit_qualification & 7;
+	reg = (exit_qualification >> 8) & 15;
+	vcpu_load_rsp_rip(vcpu);
+	if (exit_qualification & 16) {
+		/* mov from dr */
+		switch (dr) {
+		case 6:
+			val = 0xffff0ff0;
+			break;
+		case 7:
+			val = 0x400;
+			break;
+		default:
+			val = 0;
+		}
+		vcpu->regs[reg] = val;
+	} else {
+		/* mov to dr */
+	}
+	vcpu_put_rsp_rip(vcpu);
+	skip_emulated_instruction(vcpu);
+	return 1;
+}
+
+static int handle_cpuid(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
+{
+	kvm_run->exit_reason = KVM_EXIT_CPUID;
+	return 0;
+}
+
+static int handle_rdmsr(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
+{
+	u32 ecx = vcpu->regs[VCPU_REGS_RCX];
+	struct vmx_msr_entry *msr = find_msr_entry(vcpu, ecx);
+	u64 data;
+
+#ifdef KVM_DEBUG
+	if (guest_cpl() != 0) {
+		vcpu_printf(vcpu, "%s: not supervisor\n", __FUNCTION__);
+		inject_gp(vcpu);
+		return 1;
+	}
+#endif
+
+	switch (ecx) {
+#ifdef __x86_64__
+	case MSR_FS_BASE:
+		data = vmcs_readl(GUEST_FS_BASE);
+		break;
+	case MSR_GS_BASE:
+		data = vmcs_readl(GUEST_GS_BASE);
+		break;
+#endif
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
+		if (msr) {
+			data = msr->data;
+			break;
+		}
+		printk(KERN_ERR "kvm: unhandled rdmsr: %x\n", ecx);
+		inject_gp(vcpu);
+		return 1;
+	}
+
+	/* FIXME: handling of bits 32:63 of rax, rdx */
+	vcpu->regs[VCPU_REGS_RAX] = data & -1u;
+	vcpu->regs[VCPU_REGS_RDX] = (data >> 32) & -1u;
+	skip_emulated_instruction(vcpu);
+	return 1;
+}
+
 #ifdef __x86_64__
 
 static void set_efer(struct kvm_vcpu *vcpu, u64 efer)
@@ -2195,6 +2302,78 @@ static void set_efer(struct kvm_vcpu *vc
 
 #endif
 
+#define MSR_IA32_TIME_STAMP_COUNTER 0x10
+
+static int handle_wrmsr(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
+{
+	u32 ecx = vcpu->regs[VCPU_REGS_RCX];
+	struct vmx_msr_entry *msr;
+	u64 data = (vcpu->regs[VCPU_REGS_RAX] & -1u)
+		| ((u64)(vcpu->regs[VCPU_REGS_RDX] & -1u) << 32);
+
+#ifdef KVM_DEBUG
+	if (guest_cpl() != 0) {
+		vcpu_printf(vcpu, "%s: not supervisor\n", __FUNCTION__);
+		inject_gp(vcpu);
+		return 1;
+	}
+#endif
+
+	switch (ecx) {
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
+		return 1;
+	case MSR_IA32_MC0_STATUS:
+		printk(KERN_WARNING "%s: MSR_IA32_MC0_STATUS 0x%llx, nop\n"
+			    , __FUNCTION__, data);
+		break;
+#endif
+	case MSR_IA32_TIME_STAMP_COUNTER: {
+		u64 tsc;
+
+		rdtscll(tsc);
+		vmcs_write64(TSC_OFFSET, data - tsc);
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
+		msr = find_msr_entry(vcpu, ecx);
+		if (msr) {
+			msr->data = data;
+			break;
+		}
+		printk(KERN_ERR "kvm: unhandled wrmsr: %x\n", ecx);
+		inject_gp(vcpu);
+		return 1;
+	}
+	skip_emulated_instruction(vcpu);
+	return 1;
+}
+
 static int handle_interrupt_window(struct kvm_vcpu *vcpu,
 				   struct kvm_run *kvm_run)
 {
@@ -2227,6 +2406,10 @@ static int (*kvm_vmx_exit_handlers[])(st
 	[EXIT_REASON_IO_INSTRUCTION]          = handle_io,
 	[EXIT_REASON_INVLPG]                  = handle_invlpg,
 	[EXIT_REASON_CR_ACCESS]               = handle_cr,
+	[EXIT_REASON_DR_ACCESS]               = handle_dr,
+	[EXIT_REASON_CPUID]                   = handle_cpuid,
+	[EXIT_REASON_MSR_READ]                = handle_rdmsr,
+	[EXIT_REASON_MSR_WRITE]               = handle_wrmsr,
 	[EXIT_REASON_PENDING_INTERRUPT]       = handle_interrupt_window,
 	[EXIT_REASON_HLT]                     = handle_halt,
 };
