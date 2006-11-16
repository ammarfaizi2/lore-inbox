Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423750AbWKPSDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423750AbWKPSDY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 13:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424078AbWKPSDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 13:03:24 -0500
Received: from il.qumranet.com ([62.219.232.206]:7073 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1423750AbWKPSDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 13:03:23 -0500
Subject: [PATCH 2/3] KVM: Add time stamp counter msr and accessors
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 16 Nov 2006 18:03:21 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, uril@qumranet.com
References: <455CA70C.9060307@qumranet.com>
In-Reply-To: <455CA70C.9060307@qumranet.com>
Message-Id: <20061116180321.EA4D425015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uri Lublin <uril@qumranet.com>

Add a couple of accessors for the time stamp counter, and expose the tsc msr.

Signed-off-by: Uri Lublin <uril@qumranet.com>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -121,6 +121,7 @@ static const u32 vmx_msr_index[] = {
 #define TSS_REDIRECTION_SIZE (256 / 8)
 #define RMODE_TSS_SIZE (TSS_BASE_SIZE + TSS_REDIRECTION_SIZE + TSS_IOPB_SIZE + 1)
 
+#define MSR_IA32_TIME_STAMP_COUNTER		0x010
 #define MSR_IA32_FEATURE_CONTROL 		0x03a
 #define MSR_IA32_VMX_BASIC_MSR   		0x480
 #define MSR_IA32_VMX_PINBASED_CTLS_MSR		0x481
@@ -716,6 +717,31 @@ static void inject_gp(struct kvm_vcpu *v
 		     INTR_INFO_VALID_MASK);
 }
 
+/*
+ * reads and returns guest's timestamp counter "register"
+ * guest_tsc = host_tsc + tsc_offset    -- 21.3
+ */
+static u64 guest_read_tsc(void)
+{
+	u64 host_tsc, tsc_offset;
+
+	rdtscll(host_tsc);
+	tsc_offset = vmcs_read64(TSC_OFFSET);
+	return host_tsc + tsc_offset;
+}
+
+/*
+ * writes 'guest_tsc' into guest's timestamp counter "register"
+ * guest_tsc = host_tsc + tsc_offset ==> tsc_offset = guest_tsc - host_tsc
+ */
+static void guest_write_tsc(u64 guest_tsc)
+{
+	u64 host_tsc;
+
+	rdtscll(host_tsc);
+	vmcs_write64(TSC_OFFSET, guest_tsc - host_tsc);
+}
+
 static void update_exception_bitmap(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->rmode.active)
@@ -1177,7 +1204,6 @@ static int kvm_vcpu_setup(struct kvm_vcp
 	struct descriptor_table dt;
 	int i;
 	int ret;
-	u64 tsc;
 	int nr_good_msrs;
 
 
@@ -1247,8 +1273,7 @@ static int kvm_vcpu_setup(struct kvm_vcp
 	vmcs_write64(IO_BITMAP_A, 0);
 	vmcs_write64(IO_BITMAP_B, 0);
 
-	rdtscll(tsc);
-	vmcs_write64(TSC_OFFSET, -tsc);
+	guest_write_tsc(0);
 
 	vmcs_write64(VMCS_LINK_POINTER, -1ull); /* 22.3.1.5 */
 
@@ -2297,6 +2322,9 @@ static int handle_rdmsr(struct kvm_vcpu 
 		data = vmcs_readl(GUEST_GS_BASE);
 		break;
 #endif
+	case MSR_IA32_TIME_STAMP_COUNTER:
+		data = guest_read_tsc();
+		break;
 	case MSR_IA32_SYSENTER_CS:
 		data = vmcs_read32(GUEST_SYSENTER_CS);
 		break;
@@ -2374,8 +2402,6 @@ static void set_efer(struct kvm_vcpu *vc
 
 #endif
 
-#define MSR_IA32_TIME_STAMP_COUNTER 0x10
-
 static int handle_wrmsr(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 {
 	u32 ecx = vcpu->regs[VCPU_REGS_RCX];
@@ -2419,10 +2445,7 @@ static int handle_wrmsr(struct kvm_vcpu 
 		break;
 #endif
 	case MSR_IA32_TIME_STAMP_COUNTER: {
-		u64 tsc;
-
-		rdtscll(tsc);
-		vmcs_write64(TSC_OFFSET, data - tsc);
+		guest_write_tsc(data);
 		break;
 	}
 	case MSR_IA32_UCODE_REV:
