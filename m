Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758103AbWK0Mlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758103AbWK0Mlm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758150AbWK0Mll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:41:41 -0500
Received: from il.qumranet.com ([62.219.232.206]:41440 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758103AbWK0Mlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:41:40 -0500
Subject: [PATCH 31/38] KVM: Make vcpu creation and destruction arch operations
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:41:38 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127124138.BA36825015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -260,6 +260,9 @@ struct kvm_arch_ops {
 	int (*hardware_setup)(void);               /* __init */
 	void (*hardware_unsetup)(void);            /* __exit */
 
+	int (*vcpu_create)(struct kvm_vcpu *vcpu);
+	void (*vcpu_free)(struct kvm_vcpu *vcpu);
+
 	struct kvm_vcpu *(*vcpu_load)(struct kvm_vcpu *vcpu);
 	void (*vcpu_put)(struct kvm_vcpu *vcpu);
 
@@ -299,8 +302,6 @@ struct kvm_arch_ops {
 	void (*skip_emulated_instruction)(struct kvm_vcpu *vcpu);
 };
 
-void __vcpu_clear(void *arg); /* temporary hack */
-
 extern struct kvm_stat kvm_stat;
 extern struct kvm_arch_ops *kvm_arch_ops;
 
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -219,31 +219,6 @@ int kvm_write_guest(struct kvm_vcpu *vcp
 }
 EXPORT_SYMBOL_GPL(kvm_write_guest);
 
-static void vmcs_clear(struct vmcs *vmcs)
-{
-	u64 phys_addr = __pa(vmcs);
-	u8 error;
-
-	asm volatile (ASM_VMX_VMCLEAR_RAX "; setna %0"
-		      : "=g"(error) : "a"(&phys_addr), "m"(phys_addr)
-		      : "cc", "memory");
-	if (error)
-		printk(KERN_ERR "kvm: vmclear fail: %p/%llx\n",
-		       vmcs, phys_addr);
-}
-
-void __vcpu_clear(void *arg)
-{
-	struct kvm_vcpu *vcpu = arg;
-	int cpu = smp_processor_id();
-
-	if (vcpu->cpu == cpu)
-		vmcs_clear(vcpu->vmcs);
-	if (per_cpu(current_vmcs, cpu) == vcpu->vmcs)
-		per_cpu(current_vmcs, cpu) = 0;
-}
-EXPORT_SYMBOL_GPL(__vcpu_clear);
-
 static int vcpu_slot(struct kvm_vcpu *vcpu)
 {
 	return vcpu - vcpu->kvm->vcpus;
@@ -271,33 +246,6 @@ static void vcpu_put(struct kvm_vcpu *vc
 	mutex_unlock(&vcpu->mutex);
 }
 
-struct vmcs *alloc_vmcs_cpu(int cpu)
-{
-	int node = cpu_to_node(cpu);
-	struct page *pages;
-	struct vmcs *vmcs;
-
-	pages = alloc_pages_node(node, GFP_KERNEL, vmcs_descriptor.order);
-	if (!pages)
-		return 0;
-	vmcs = page_address(pages);
-	memset(vmcs, 0, vmcs_descriptor.size);
-	vmcs->revision_id = vmcs_descriptor.revision_id; /* vmcs revision id */
-	return vmcs;
-}
-EXPORT_SYMBOL_GPL(alloc_vmcs_cpu);
-
-static struct vmcs *alloc_vmcs(void)
-{
-	return alloc_vmcs_cpu(smp_processor_id());
-}
-
-void free_vmcs(struct vmcs *vmcs)
-{
-	free_pages((unsigned long)vmcs, vmcs_descriptor.order);
-}
-EXPORT_SYMBOL_GPL(free_vmcs);
-
 static int kvm_dev_open(struct inode *inode, struct file *filp)
 {
 	struct kvm *kvm = kzalloc(sizeof(struct kvm), GFP_KERNEL);
@@ -350,18 +298,9 @@ static void kvm_free_physmem(struct kvm 
 		kvm_free_physmem_slot(&kvm->memslots[i], 0);
 }
 
-static void kvm_free_vmcs(struct kvm_vcpu *vcpu)
-{
-	if (vcpu->vmcs) {
-		on_each_cpu(__vcpu_clear, vcpu, 0, 1);
-		free_vmcs(vcpu->vmcs);
-		vcpu->vmcs = 0;
-	}
-}
-
 static void kvm_free_vcpu(struct kvm_vcpu *vcpu)
 {
-	kvm_free_vmcs(vcpu);
+	kvm_arch_ops->vcpu_free(vcpu);
 	kvm_mmu_destroy(vcpu);
 }
 
@@ -613,7 +552,6 @@ static int kvm_dev_ioctl_create_vcpu(str
 {
 	int r;
 	struct kvm_vcpu *vcpu;
-	struct vmcs *vmcs;
 
 	r = -EINVAL;
 	if (n < 0 || n >= KVM_MAX_VCPUS)
@@ -634,14 +572,9 @@ static int kvm_dev_ioctl_create_vcpu(str
 
 	vcpu->cpu = -1;  /* First load will set up TR */
 	vcpu->kvm = kvm;
-	vmcs = alloc_vmcs();
-	if (!vmcs) {
-		mutex_unlock(&vcpu->mutex);
+	r = kvm_arch_ops->vcpu_create(vcpu);
+	if (r < 0)
 		goto out_free_vcpus;
-	}
-	vmcs_clear(vmcs);
-	vcpu->vmcs = vmcs;
-	vcpu->launched = 0;
 
 	kvm_arch_ops->vcpu_load(vcpu);
 
@@ -658,6 +591,7 @@ static int kvm_dev_ioctl_create_vcpu(str
 
 out_free_vcpus:
 	kvm_free_vcpu(vcpu);
+	mutex_unlock(&vcpu->mutex);
 out:
 	return r;
 }
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -77,6 +77,30 @@ static const u32 vmx_msr_index[] = {
 
 struct vmx_msr_entry *find_msr_entry(struct kvm_vcpu *vcpu, u32 msr);
 
+static void vmcs_clear(struct vmcs *vmcs)
+{
+	u64 phys_addr = __pa(vmcs);
+	u8 error;
+
+	asm volatile (ASM_VMX_VMCLEAR_RAX "; setna %0"
+		      : "=g"(error) : "a"(&phys_addr), "m"(phys_addr)
+		      : "cc", "memory");
+	if (error)
+		printk(KERN_ERR "kvm: vmclear fail: %p/%llx\n",
+		       vmcs, phys_addr);
+}
+
+static void __vcpu_clear(void *arg)
+{
+	struct kvm_vcpu *vcpu = arg;
+	int cpu = smp_processor_id();
+
+	if (vcpu->cpu == cpu)
+		vmcs_clear(vcpu->vmcs);
+	if (per_cpu(current_vmcs, cpu) == vcpu->vmcs)
+		per_cpu(current_vmcs, cpu) = 0;
+}
+
 /*
  * Switches to specified vcpu, until a matching vcpu_put(), but assumes
  * vcpu mutex is already taken.
@@ -449,7 +473,30 @@ static __init void setup_vmcs_descriptor
 	vmcs_descriptor.revision_id = vmx_msr_low;
 };
 
-void free_vmcs(struct vmcs *vmcs);
+static struct vmcs *alloc_vmcs_cpu(int cpu)
+{
+	int node = cpu_to_node(cpu);
+	struct page *pages;
+	struct vmcs *vmcs;
+
+	pages = alloc_pages_node(node, GFP_KERNEL, vmcs_descriptor.order);
+	if (!pages)
+		return 0;
+	vmcs = page_address(pages);
+	memset(vmcs, 0, vmcs_descriptor.size);
+	vmcs->revision_id = vmcs_descriptor.revision_id; /* vmcs revision id */
+	return vmcs;
+}
+
+static struct vmcs *alloc_vmcs(void)
+{
+	return alloc_vmcs_cpu(smp_processor_id());
+}
+
+static void free_vmcs(struct vmcs *vmcs)
+{
+	free_pages((unsigned long)vmcs, vmcs_descriptor.order);
+}
 
 static __exit void free_kvm_area(void)
 {
@@ -1790,6 +1837,33 @@ static void vmx_inject_page_fault(struct
 
 }
 
+static void vmx_free_vmcs(struct kvm_vcpu *vcpu)
+{
+	if (vcpu->vmcs) {
+		on_each_cpu(__vcpu_clear, vcpu, 0, 1);
+		free_vmcs(vcpu->vmcs);
+		vcpu->vmcs = 0;
+	}
+}
+
+static void vmx_free_vcpu(struct kvm_vcpu *vcpu)
+{
+	vmx_free_vmcs(vcpu);
+}
+
+static int vmx_create_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct vmcs *vmcs;
+
+	vmcs = alloc_vmcs();
+	if (!vmcs)
+		return -ENOMEM;
+	vmcs_clear(vmcs);
+	vcpu->vmcs = vmcs;
+	vcpu->launched = 0;
+	return 0;
+}
+
 static struct kvm_arch_ops vmx_arch_ops = {
 	.cpu_has_kvm_support = cpu_has_kvm_support,
 	.disabled_by_bios = vmx_disabled_by_bios,
@@ -1798,6 +1872,9 @@ static struct kvm_arch_ops vmx_arch_ops 
 	.hardware_enable = hardware_enable,
 	.hardware_disable = hardware_disable,
 
+	.vcpu_create = vmx_create_vcpu,
+	.vcpu_free = vmx_free_vcpu,
+
 	.vcpu_load = vmx_vcpu_load,
 	.vcpu_put = vmx_vcpu_put,
 
