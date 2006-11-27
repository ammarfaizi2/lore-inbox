Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758091AbWK0MPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758091AbWK0MPj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758092AbWK0MPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:15:39 -0500
Received: from il.qumranet.com ([62.219.232.206]:11218 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758091AbWK0MPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:15:38 -0500
Subject: [PATCH 5/38] KVM: Make the hardware setup operations (non-percpu)
	arch operations
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:15:37 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127121537.2542125015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -240,6 +240,8 @@ struct kvm_arch_ops {
 	int (*disabled_by_bios)(void);             /* __init */
 	void (*hardware_enable)(void *dummy);      /* __init */
 	void (*hardware_disable)(void *dummy);
+	int (*hardware_setup)(void);               /* __init */
+	void (*hardware_unsetup)(void);            /* __exit */
 };
 
 extern struct kvm_stat kvm_stat;
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -124,7 +124,6 @@ static const u32 vmx_msr_index[] = {
 
 #define MSR_IA32_TIME_STAMP_COUNTER		0x010
 #define MSR_IA32_FEATURE_CONTROL 		0x03a
-#define MSR_IA32_VMX_BASIC_MSR   		0x480
 #define MSR_IA32_VMX_PINBASED_CTLS_MSR		0x481
 #define MSR_IA32_VMX_PROCBASED_CTLS_MSR		0x482
 #define MSR_IA32_VMX_EXIT_CTLS_MSR		0x483
@@ -303,11 +302,12 @@ DEFINE_PER_CPU(struct vmcs *, vmxarea);
 EXPORT_SYMBOL_GPL(per_cpu__vmxarea); /* temporary hack */
 static DEFINE_PER_CPU(struct vmcs *, current_vmcs);
 
-static struct vmcs_descriptor {
+struct vmcs_descriptor {
 	int size;
 	int order;
 	u32 revision_id;
 } vmcs_descriptor;
+EXPORT_SYMBOL_GPL(vmcs_descriptor);
 
 #ifdef __x86_64__
 static unsigned long read_msr(unsigned long msr)
@@ -394,16 +394,6 @@ int kvm_write_guest(struct kvm_vcpu *vcp
 	return req_size - size;
 }
 
-static __init void setup_vmcs_descriptor(void)
-{
-	u32 vmx_msr_low, vmx_msr_high;
-
-	rdmsr(MSR_IA32_VMX_BASIC_MSR, vmx_msr_low, vmx_msr_high);
-	vmcs_descriptor.size = vmx_msr_high & 0x1fff;
-	vmcs_descriptor.order = get_order(vmcs_descriptor.size);
-	vmcs_descriptor.revision_id = vmx_msr_low;
-};
-
 static void vmcs_clear(struct vmcs *vmcs)
 {
 	u64 phys_addr = __pa(vmcs);
@@ -501,8 +491,7 @@ static void vcpu_put(struct kvm_vcpu *vc
 	mutex_unlock(&vcpu->mutex);
 }
 
-
-static struct vmcs *alloc_vmcs_cpu(int cpu)
+struct vmcs *alloc_vmcs_cpu(int cpu)
 {
 	int node = cpu_to_node(cpu);
 	struct page *pages;
@@ -516,42 +505,18 @@ static struct vmcs *alloc_vmcs_cpu(int c
 	vmcs->revision_id = vmcs_descriptor.revision_id; /* vmcs revision id */
 	return vmcs;
 }
+EXPORT_SYMBOL_GPL(alloc_vmcs_cpu);
 
 static struct vmcs *alloc_vmcs(void)
 {
 	return alloc_vmcs_cpu(smp_processor_id());
 }
 
-static void free_vmcs(struct vmcs *vmcs)
+void free_vmcs(struct vmcs *vmcs)
 {
 	free_pages((unsigned long)vmcs, vmcs_descriptor.order);
 }
-
-static __exit void free_kvm_area(void)
-{
-	int cpu;
-
-	for_each_online_cpu(cpu)
-		free_vmcs(per_cpu(vmxarea, cpu));
-}
-
-static __init int alloc_kvm_area(void)
-{
-	int cpu;
-
-	for_each_online_cpu(cpu) {
-		struct vmcs *vmcs;
-
-		vmcs = alloc_vmcs_cpu(cpu);
-		if (!vmcs) {
-			free_kvm_area();
-			return -ENOMEM;
-		}
-
-		per_cpu(vmxarea, cpu) = vmcs;
-	}
-	return 0;
-}
+EXPORT_SYMBOL_GPL(free_vmcs);
 
 static int kvm_dev_open(struct inode *inode, struct file *filp)
 {
@@ -3592,6 +3557,10 @@ int kvm_init_arch(struct kvm_arch_ops *o
 		return -EOPNOTSUPP;
 	}
 
+	r = kvm_arch_ops->hardware_setup();
+	if (r < 0)
+	    return r;
+
 	on_each_cpu(kvm_arch_ops->hardware_enable, 0, 0, 1);
 	register_reboot_notifier(&kvm_reboot_notifier);
 
@@ -3603,7 +3572,12 @@ int kvm_init_arch(struct kvm_arch_ops *o
 		goto out_free;
 	}
 
+	return r;
+
 out_free:
+	unregister_reboot_notifier(&kvm_reboot_notifier);
+	on_each_cpu(kvm_arch_ops->hardware_disable, 0, 0, 1);
+	kvm_arch_ops->hardware_unsetup();
 	return r;
 }
 
@@ -3613,6 +3587,7 @@ void kvm_exit_arch(void)
 
 	unregister_reboot_notifier(&kvm_reboot_notifier);
 	on_each_cpu(kvm_arch_ops->hardware_disable, 0, 0, 1);
+	kvm_arch_ops->hardware_unsetup();
 }
 
 static __init int kvm_init(void)
@@ -3622,14 +3597,9 @@ static __init int kvm_init(void)
 
 	kvm_init_debug();
 
-	setup_vmcs_descriptor();
-	r = alloc_kvm_area();
-	if (r)
-		goto out;
-
 	if ((bad_page = alloc_page(GFP_KERNEL)) == NULL) {
 		r = -ENOMEM;
-		goto out_free;
+		goto out;
 	}
 
 	bad_page_address = page_to_pfn(bad_page) << PAGE_SHIFT;
@@ -3637,8 +3607,6 @@ static __init int kvm_init(void)
 
 	return r;
 
-out_free:
-	free_kvm_area();
 out:
 	kvm_exit_debug();
 	return r;
@@ -3647,7 +3615,6 @@ out:
 static __exit void kvm_exit(void)
 {
 	kvm_exit_debug();
-	free_kvm_area();
 	__free_page(pfn_to_page(bad_page_address >> PAGE_SHIFT));
 }
 
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -25,6 +25,12 @@ MODULE_LICENSE("GPL");
 
 DECLARE_PER_CPU(struct vmcs *, vmxarea);
 
+extern struct vmcs_descriptor {
+	int size;
+	int order;
+	u32 revision_id;
+} vmcs_descriptor;
+
 static __init int cpu_has_kvm_support(void)
 {
 	unsigned long ecx = cpuid_ecx(1);
@@ -59,9 +65,62 @@ static void hardware_disable(void *garba
 	asm volatile (ASM_VMX_VMXOFF : : : "cc");
 }
 
+static __init void setup_vmcs_descriptor(void)
+{
+	u32 vmx_msr_low, vmx_msr_high;
+
+	rdmsr(MSR_IA32_VMX_BASIC_MSR, vmx_msr_low, vmx_msr_high);
+	vmcs_descriptor.size = vmx_msr_high & 0x1fff;
+	vmcs_descriptor.order = get_order(vmcs_descriptor.size);
+	vmcs_descriptor.revision_id = vmx_msr_low;
+};
+
+void free_vmcs(struct vmcs *vmcs);
+
+static __exit void free_kvm_area(void)
+{
+	int cpu;
+
+	for_each_online_cpu(cpu)
+		free_vmcs(per_cpu(vmxarea, cpu));
+}
+
+extern struct vmcs *alloc_vmcs_cpu(int cpu);
+
+static __init int alloc_kvm_area(void)
+{
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		struct vmcs *vmcs;
+
+		vmcs = alloc_vmcs_cpu(cpu);
+		if (!vmcs) {
+			free_kvm_area();
+			return -ENOMEM;
+		}
+
+		per_cpu(vmxarea, cpu) = vmcs;
+	}
+	return 0;
+}
+
+static __init int hardware_setup(void)
+{
+	setup_vmcs_descriptor();
+	return alloc_kvm_area();
+}
+
+static __exit void hardware_unsetup(void)
+{
+	free_kvm_area();
+}
+
 static struct kvm_arch_ops vmx_arch_ops = {
 	.cpu_has_kvm_support = cpu_has_kvm_support,
 	.disabled_by_bios = vmx_disabled_by_bios,
+	.hardware_setup = hardware_setup,
+	.hardware_unsetup = hardware_unsetup,
 	.hardware_enable = hardware_enable,
 	.hardware_disable = hardware_disable,
 };
Index: linux-2.6/drivers/kvm/vmx.h
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.h
+++ linux-2.6/drivers/kvm/vmx.h
@@ -286,4 +286,6 @@ enum vmcs_field {
 
 #define CR4_VMXE 0x2000
 
+#define MSR_IA32_VMX_BASIC_MSR   		0x480
+
 #endif
