Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161166AbWJ3P5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161166AbWJ3P5J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 10:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161194AbWJ3P5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 10:57:09 -0500
Received: from il.qumranet.com ([62.219.232.206]:18648 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1161166AbWJ3P5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 10:57:06 -0500
Subject: [PATCH] KVM: Dynamically determine which msrs to load and save
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 30 Oct 2006 15:57:01 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Message-Id: <20061030155701.C80B025013C@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Different cpus have different msrs available.  The Core (not Core 2)
cpu lacks the STAR msr, so kvm faults when accessing it.

Fix by determining which msrs are available dynamically, and only loading
and saving available msrs.

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -167,6 +167,7 @@ struct kvm_vcpu {
 	unsigned long cr8;
 	u64 shadow_efer;
 	u64 apic_base;
+	int nmsrs;
 	struct vmx_msr_entry *guest_msrs;
 	struct vmx_msr_entry *host_msrs;
 
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -59,22 +59,21 @@ static struct kvm_stats_debugfs_item {
 static struct dentry *debugfs_dir;
 
 static const u32 vmx_msr_index[] = {
-	MSR_EFER, MSR_K6_STAR,
 #ifdef __x86_64__
-	MSR_CSTAR, MSR_KERNEL_GS_BASE, MSR_SYSCALL_MASK, MSR_LSTAR
+	MSR_SYSCALL_MASK, MSR_LSTAR, MSR_CSTAR, MSR_KERNEL_GS_BASE,
 #endif
+	MSR_EFER, MSR_K6_STAR,
 };
 #define NR_VMX_MSR (sizeof(vmx_msr_index) / sizeof(*vmx_msr_index))
 
-
 #ifdef __x86_64__
 /*
  * avoid save/load MSR_SYSCALL_MASK and MSR_LSTAR by std vt
  * mechanism (cpu bug AA24)
  */
-#define NUM_AUTO_MSRS (NR_VMX_MSR-2)
+#define NR_BAD_MSRS 2
 #else
-#define NUM_AUTO_MSRS NR_VMX_MSR
+#define NR_BAD_MSRS 0
 #endif
 
 #define TSS_IOPB_BASE_OFFSET 0x66
@@ -107,8 +106,8 @@ static struct vmx_msr_entry *find_msr_en
 {
 	int i;
 
-	for (i = 0; i < NR_VMX_MSR; ++i)
-		if (vmx_msr_index[i] == msr)
+	for (i = 0; i < vcpu->nmsrs; ++i)
+		if (vcpu->guest_msrs[i].index == msr)
 			return &vcpu->guest_msrs[i];
 	return 0;
 }
@@ -1110,6 +1109,7 @@ static int kvm_vcpu_setup(struct kvm_vcp
 	int i;
 	int ret;
 	u64 tsc;
+	int nr_good_msrs;
 
 
 	if (!init_rmode_tss(vcpu->kvm)) {
@@ -1250,12 +1250,6 @@ static int kvm_vcpu_setup(struct kvm_vcp
 	rdmsrl(MSR_IA32_SYSENTER_EIP, a);
 	vmcs_writel(HOST_IA32_SYSENTER_EIP, a);   /* 22.2.3 */
 
-	vmcs_write32_fixedbits(MSR_IA32_VMX_EXIT_CTLS_MSR, VM_EXIT_CONTROLS,
-		     	       (HOST_IS_64 << 9));  /* 22.2,1, 20.7.1 */
-	vmcs_write32(VM_EXIT_MSR_STORE_COUNT, NUM_AUTO_MSRS); /* 22.2.2 */
-	vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, NUM_AUTO_MSRS);  /* 22.2.2 */
-	vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, NUM_AUTO_MSRS); /* 22.2.2 */
-
 	ret = -ENOMEM;
 	vcpu->guest_msrs = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!vcpu->guest_msrs)
@@ -1266,18 +1260,34 @@ static int kvm_vcpu_setup(struct kvm_vcp
 
 	for (i = 0; i < NR_VMX_MSR; ++i) {
 		u32 index = vmx_msr_index[i];
+		u32 data_low, data_high;
 		u64 data;
+		int j = vcpu->nmsrs;
 
-		rdmsrl(index, data);
-		vcpu->host_msrs[i].index = index;
-		vcpu->host_msrs[i].reserved = 0;
-		vcpu->host_msrs[i].data = data;
-		vcpu->guest_msrs[i] = vcpu->host_msrs[i];
-	}
+		if (rdmsr_safe(index, &data_low, &data_high) < 0)
+			continue;
+		data = data_low | ((u64)data_high << 32);
+		vcpu->host_msrs[j].index = index;
+		vcpu->host_msrs[j].reserved = 0;
+		vcpu->host_msrs[j].data = data;
+		vcpu->guest_msrs[j] = vcpu->host_msrs[j];
+		++vcpu->nmsrs;
+	}
+	printk("msrs: %d\n", vcpu->nmsrs);
+
+	nr_good_msrs = vcpu->nmsrs - NR_BAD_MSRS;
+	vmcs_writel(VM_ENTRY_MSR_LOAD_ADDR,
+		    virt_to_phys(vcpu->guest_msrs + NR_BAD_MSRS));
+	vmcs_writel(VM_EXIT_MSR_STORE_ADDR,
+		    virt_to_phys(vcpu->guest_msrs + NR_BAD_MSRS));
+	vmcs_writel(VM_EXIT_MSR_LOAD_ADDR,
+		    virt_to_phys(vcpu->host_msrs + NR_BAD_MSRS));
+	vmcs_write32_fixedbits(MSR_IA32_VMX_EXIT_CTLS_MSR, VM_EXIT_CONTROLS,
+		     	       (HOST_IS_64 << 9));  /* 22.2,1, 20.7.1 */
+	vmcs_write32(VM_EXIT_MSR_STORE_COUNT, nr_good_msrs); /* 22.2.2 */
+	vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, nr_good_msrs);  /* 22.2.2 */
+	vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, nr_good_msrs); /* 22.2.2 */
 
-	vmcs_writel(VM_ENTRY_MSR_LOAD_ADDR, virt_to_phys(vcpu->guest_msrs));
-	vmcs_writel(VM_EXIT_MSR_STORE_ADDR, virt_to_phys(vcpu->guest_msrs));
-	vmcs_writel(VM_EXIT_MSR_LOAD_ADDR, virt_to_phys(vcpu->host_msrs));
 
 	/* 22.2.1, 20.8.1 */
 	vmcs_write32_fixedbits(MSR_IA32_VMX_ENTRY_CTLS_MSR,
@@ -2539,18 +2549,20 @@ static void kvm_guest_debug_pre(struct k
 	}
 }
 
-static void load_msrs(struct vmx_msr_entry *e)
+static void load_msrs(struct vmx_msr_entry *e, int n)
 {
 	int i;
 
-	for (i = NUM_AUTO_MSRS; i < NR_VMX_MSR; ++i)
+	for (i = 0; i < n; ++i)
 		wrmsrl(e[i].index, e[i].data);
 }
 
-static void save_msrs(struct vmx_msr_entry *e, int msr_index)
+static void save_msrs(struct vmx_msr_entry *e, int n)
 {
-	for (; msr_index < NR_VMX_MSR; ++msr_index)
-		rdmsrl(e[msr_index].index, e[msr_index].data);
+	int i;
+
+	for (i = 0; i < n; ++i)
+		rdmsrl(e[i].index, e[i].data);
 }
 
 static int kvm_dev_ioctl_run(struct kvm *kvm, struct kvm_run *kvm_run)
@@ -2611,8 +2623,8 @@ again:
 	fx_save(vcpu->host_fx_image);
 	fx_restore(vcpu->guest_fx_image);
 
-	save_msrs(vcpu->host_msrs, 0);
-	load_msrs(vcpu->guest_msrs);
+	save_msrs(vcpu->host_msrs, vcpu->nmsrs);
+	load_msrs(vcpu->guest_msrs, NR_BAD_MSRS);
 
 	asm (
 		/* Store host registers */
@@ -2735,8 +2747,8 @@ again:
 
 	++kvm_stat.exits;
 
-	save_msrs(vcpu->guest_msrs, NUM_AUTO_MSRS);
-	load_msrs(vcpu->host_msrs);
+	save_msrs(vcpu->guest_msrs, NR_BAD_MSRS);
+	load_msrs(vcpu->host_msrs, NR_BAD_MSRS);
 
 	fx_save(vcpu->guest_fx_image);
 	fx_restore(vcpu->host_fx_image);
