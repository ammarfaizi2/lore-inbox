Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758088AbWK0MOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758088AbWK0MOj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758087AbWK0MOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:14:39 -0500
Received: from il.qumranet.com ([62.219.232.206]:10194 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758088AbWK0MOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:14:38 -0500
Subject: [PATCH 4/38] KVM: Make the per-cpu enable/disable functions arch
	operations
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:14:37 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127121437.187B125015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -238,6 +238,8 @@ struct kvm_stat {
 struct kvm_arch_ops {
 	int (*cpu_has_kvm_support)(void);          /* __init */
 	int (*disabled_by_bios)(void);             /* __init */
+	void (*hardware_enable)(void *dummy);      /* __init */
+	void (*hardware_disable)(void *dummy);
 };
 
 extern struct kvm_stat kvm_stat;
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -135,7 +135,6 @@ static const u32 vmx_msr_index[] = {
 #define CR0_RESEVED_BITS 0xffffffff1ffaffc0ULL
 #define LMSW_GUEST_MASK 0x0eULL
 #define CR4_RESEVED_BITS (~((1ULL << 11) - 1))
-#define CR4_VMXE 0x2000
 #define CR8_RESEVED_BITS (~0x0fULL)
 #define EFER_RESERVED_BITS 0xfffffffffffff2fe
 
@@ -300,7 +299,8 @@ static void reload_tss(void)
 #endif
 }
 
-static DEFINE_PER_CPU(struct vmcs *, vmxarea);
+DEFINE_PER_CPU(struct vmcs *, vmxarea);
+EXPORT_SYMBOL_GPL(per_cpu__vmxarea); /* temporary hack */
 static DEFINE_PER_CPU(struct vmcs *, current_vmcs);
 
 static struct vmcs_descriptor {
@@ -553,26 +553,6 @@ static __init int alloc_kvm_area(void)
 	return 0;
 }
 
-static __init void kvm_enable(void *garbage)
-{
-	int cpu = raw_smp_processor_id();
-	u64 phys_addr = __pa(per_cpu(vmxarea, cpu));
-	u64 old;
-
-	rdmsrl(MSR_IA32_FEATURE_CONTROL, old);
-	if ((old & 5) == 0)
-		/* enable and lock */
-		wrmsrl(MSR_IA32_FEATURE_CONTROL, old | 5);
-	write_cr4(read_cr4() | CR4_VMXE); /* FIXME: not cpu hotplug safe */
-	asm volatile (ASM_VMX_VMXON_RAX : : "a"(&phys_addr), "m"(phys_addr)
-		      : "memory", "cc");
-}
-
-static void kvm_disable(void *garbage)
-{
-	asm volatile (ASM_VMX_VMXOFF : : : "cc");
-}
-
 static int kvm_dev_open(struct inode *inode, struct file *filp)
 {
 	struct kvm *kvm = kzalloc(sizeof(struct kvm), GFP_KERNEL);
@@ -3565,8 +3545,8 @@ static int kvm_reboot(struct notifier_bl
 		 * Some (well, at least mine) BIOSes hang on reboot if
 		 * in vmx root mode.
 		 */
-		printk(KERN_INFO "kvm: exiting vmx mode\n");
-		on_each_cpu(kvm_disable, 0, 0, 1);
+		printk(KERN_INFO "kvm: exiting hardware virtualization\n");
+		on_each_cpu(kvm_arch_ops->hardware_disable, 0, 0, 1);
 	}
 	return NOTIFY_OK;
 }
@@ -3612,6 +3592,9 @@ int kvm_init_arch(struct kvm_arch_ops *o
 		return -EOPNOTSUPP;
 	}
 
+	on_each_cpu(kvm_arch_ops->hardware_enable, 0, 0, 1);
+	register_reboot_notifier(&kvm_reboot_notifier);
+
 	kvm_chardev_ops.owner = module;
 
 	r = misc_register(&kvm_dev);
@@ -3627,6 +3610,9 @@ out_free:
 void kvm_exit_arch(void)
 {
 	misc_deregister(&kvm_dev);
+
+	unregister_reboot_notifier(&kvm_reboot_notifier);
+	on_each_cpu(kvm_arch_ops->hardware_disable, 0, 0, 1);
 }
 
 static __init int kvm_init(void)
@@ -3640,8 +3626,6 @@ static __init int kvm_init(void)
 	r = alloc_kvm_area();
 	if (r)
 		goto out;
-	on_each_cpu(kvm_enable, 0, 0, 1);
-	register_reboot_notifier(&kvm_reboot_notifier);
 
 	if ((bad_page = alloc_page(GFP_KERNEL)) == NULL) {
 		r = -ENOMEM;
@@ -3663,8 +3647,6 @@ out:
 static __exit void kvm_exit(void)
 {
 	kvm_exit_debug();
-	unregister_reboot_notifier(&kvm_reboot_notifier);
-	on_each_cpu(kvm_disable, 0, 0, 1);
 	free_kvm_area();
 	__free_page(pfn_to_page(bad_page_address >> PAGE_SHIFT));
 }
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -23,6 +23,8 @@
 MODULE_AUTHOR("Qumranet");
 MODULE_LICENSE("GPL");
 
+DECLARE_PER_CPU(struct vmcs *, vmxarea);
+
 static __init int cpu_has_kvm_support(void)
 {
 	unsigned long ecx = cpuid_ecx(1);
@@ -37,9 +39,31 @@ static __init int vmx_disabled_by_bios(v
 	return (msr & 5) == 1; /* locked but not enabled */
 }
 
+static __init void hardware_enable(void *garbage)
+{
+	int cpu = raw_smp_processor_id();
+	u64 phys_addr = __pa(per_cpu(vmxarea, cpu));
+	u64 old;
+
+	rdmsrl(MSR_IA32_FEATURE_CONTROL, old);
+	if ((old & 5) == 0)
+		/* enable and lock */
+		wrmsrl(MSR_IA32_FEATURE_CONTROL, old | 5);
+	write_cr4(read_cr4() | CR4_VMXE); /* FIXME: not cpu hotplug safe */
+	asm volatile (ASM_VMX_VMXON_RAX : : "a"(&phys_addr), "m"(phys_addr)
+		      : "memory", "cc");
+}
+
+static void hardware_disable(void *garbage)
+{
+	asm volatile (ASM_VMX_VMXOFF : : : "cc");
+}
+
 static struct kvm_arch_ops vmx_arch_ops = {
 	.cpu_has_kvm_support = cpu_has_kvm_support,
 	.disabled_by_bios = vmx_disabled_by_bios,
+	.hardware_enable = hardware_enable,
+	.hardware_disable = hardware_disable,
 };
 
 static int __init vmx_init(void)
Index: linux-2.6/drivers/kvm/vmx.h
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.h
+++ linux-2.6/drivers/kvm/vmx.h
@@ -284,4 +284,6 @@ enum vmcs_field {
 
 #define AR_RESERVD_MASK 0xfffe0f00
 
+#define CR4_VMXE 0x2000
+
 #endif
