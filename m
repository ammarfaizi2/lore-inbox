Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758147AbWK0Mkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758147AbWK0Mkl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758148AbWK0Mkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:40:41 -0500
Received: from il.qumranet.com ([62.219.232.206]:47784 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758147AbWK0Mkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:40:40 -0500
Subject: [PATCH 30/38] KVM: Make vcpu_load() and vcpu_put() arch operations
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:40:38 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127124038.ACAA025015E@cleopatra.q>
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
 
+	struct kvm_vcpu *(*vcpu_load)(struct kvm_vcpu *vcpu);
+	void (*vcpu_put)(struct kvm_vcpu *vcpu);
+
 	int (*set_guest_debug)(struct kvm_vcpu *vcpu,
 			       struct kvm_debug_guest *dbg);
 	int (*get_msr)(struct kvm_vcpu *vcpu, u32 msr_index, u64 *pdata);
@@ -296,6 +299,8 @@ struct kvm_arch_ops {
 	void (*skip_emulated_instruction)(struct kvm_vcpu *vcpu);
 };
 
+void __vcpu_clear(void *arg); /* temporary hack */
+
 extern struct kvm_stat kvm_stat;
 extern struct kvm_arch_ops *kvm_arch_ops;
 
@@ -373,6 +378,8 @@ int kvm_write_guest(struct kvm_vcpu *vcp
 void vmcs_writel(unsigned long field, unsigned long value);
 unsigned long vmcs_readl(unsigned long field);
 
+unsigned long segment_base(u16 selector);
+
 static inline struct page *_gfn_to_page(struct kvm *kvm, gfn_t gfn)
 {
 	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
@@ -501,6 +508,18 @@ static inline void get_idt(struct descri
 	asm ("sidt %0" : "=m"(*table));
 }
 
+static inline void get_gdt(struct descriptor_table *table)
+{
+	asm ("sgdt %0" : "=m"(*table));
+}
+
+static inline unsigned long read_tr_base(void)
+{
+	u16 tr;
+	asm ("str %0" : "=g"(tr));
+	return segment_base(tr);
+}
+
 #ifdef __x86_64__
 static inline unsigned long read_msr(unsigned long msr)
 {
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -84,11 +84,6 @@ struct vmx_msr_entry *find_msr_entry(str
 }
 EXPORT_SYMBOL_GPL(find_msr_entry);
 
-static void get_gdt(struct descriptor_table *table)
-{
-	asm ("sgdt %0" : "=m"(*table));
-}
-
 struct segment_descriptor {
 	u16 limit_low;
 	u16 base_low;
@@ -115,7 +110,7 @@ struct segment_descriptor_64 {
 
 #endif
 
-static unsigned long segment_base(u16 selector)
+unsigned long segment_base(u16 selector)
 {
 	struct descriptor_table gdt;
 	struct segment_descriptor *d;
@@ -141,17 +136,12 @@ static unsigned long segment_base(u16 se
 #endif
 	return v;
 }
-
-static unsigned long read_tr_base(void)
-{
-	u16 tr;
-	asm ("str %0" : "=g"(tr));
-	return segment_base(tr);
-}
+EXPORT_SYMBOL_GPL(segment_base);
 
 DEFINE_PER_CPU(struct vmcs *, vmxarea);
 EXPORT_SYMBOL_GPL(per_cpu__vmxarea); /* temporary hack */
-static DEFINE_PER_CPU(struct vmcs *, current_vmcs);
+DEFINE_PER_CPU(struct vmcs *, current_vmcs);
+EXPORT_SYMBOL_GPL(per_cpu__current_vmcs); /* temporary hack */
 
 struct vmcs_descriptor {
 	int size;
@@ -242,7 +232,7 @@ static void vmcs_clear(struct vmcs *vmcs
 		       vmcs, phys_addr);
 }
 
-static void __vcpu_clear(void *arg)
+void __vcpu_clear(void *arg)
 {
 	struct kvm_vcpu *vcpu = arg;
 	int cpu = smp_processor_id();
@@ -252,6 +242,7 @@ static void __vcpu_clear(void *arg)
 	if (per_cpu(current_vmcs, cpu) == vcpu->vmcs)
 		per_cpu(current_vmcs, cpu) = 0;
 }
+EXPORT_SYMBOL_GPL(__vcpu_clear);
 
 static int vcpu_slot(struct kvm_vcpu *vcpu)
 {
@@ -259,53 +250,6 @@ static int vcpu_slot(struct kvm_vcpu *vc
 }
 
 /*
- * Switches to specified vcpu, until a matching vcpu_put(), but assumes
- * vcpu mutex is already taken.
- */
-static struct kvm_vcpu *__vcpu_load(struct kvm_vcpu *vcpu)
-{
-	u64 phys_addr = __pa(vcpu->vmcs);
-	int cpu;
-
-	cpu = get_cpu();
-
-	if (vcpu->cpu != cpu) {
-		smp_call_function(__vcpu_clear, vcpu, 0, 1);
-		vcpu->launched = 0;
-	}
-
-	if (per_cpu(current_vmcs, cpu) != vcpu->vmcs) {
-		u8 error;
-
-		per_cpu(current_vmcs, cpu) = vcpu->vmcs;
-		asm volatile (ASM_VMX_VMPTRLD_RAX "; setna %0"
-			      : "=g"(error) : "a"(&phys_addr), "m"(phys_addr)
-			      : "cc");
-		if (error)
-			printk(KERN_ERR "kvm: vmptrld %p/%llx fail\n",
-			       vcpu->vmcs, phys_addr);
-	}
-
-	if (vcpu->cpu != cpu) {
-		struct descriptor_table dt;
-		unsigned long sysenter_esp;
-
-		vcpu->cpu = cpu;
-		/*
-		 * Linux uses per-cpu TSS and GDT, so set these when switching
-		 * processors.
-		 */
-		vmcs_writel(HOST_TR_BASE, read_tr_base()); /* 22.2.4 */
-		get_gdt(&dt);
-		vmcs_writel(HOST_GDTR_BASE, dt.base);   /* 22.2.4 */
-
-		rdmsrl(MSR_IA32_SYSENTER_ESP, sysenter_esp);
-		vmcs_writel(HOST_IA32_SYSENTER_ESP, sysenter_esp); /* 22.2.3 */
-	}
-	return vcpu;
-}
-
-/*
  * Switches to specified vcpu, until a matching vcpu_put()
  */
 static struct kvm_vcpu *vcpu_load(struct kvm *kvm, int vcpu_slot)
@@ -317,11 +261,12 @@ static struct kvm_vcpu *vcpu_load(struct
 		mutex_unlock(&vcpu->mutex);
 		return 0;
 	}
-	return __vcpu_load(vcpu);
+	return kvm_arch_ops->vcpu_load(vcpu);
 }
 
 static void vcpu_put(struct kvm_vcpu *vcpu)
 {
+	kvm_arch_ops->vcpu_put(vcpu);
 	put_cpu();
 	mutex_unlock(&vcpu->mutex);
 }
@@ -698,7 +643,7 @@ static int kvm_dev_ioctl_create_vcpu(str
 	vcpu->vmcs = vmcs;
 	vcpu->launched = 0;
 
-	__vcpu_load(vcpu);
+	kvm_arch_ops->vcpu_load(vcpu);
 
 	r = kvm_arch_ops->vcpu_setup(vcpu);
 	if (r >= 0)
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -29,6 +29,7 @@ MODULE_AUTHOR("Qumranet");
 MODULE_LICENSE("GPL");
 
 DECLARE_PER_CPU(struct vmcs *, vmxarea);
+DECLARE_PER_CPU(struct vmcs *, current_vmcs);
 
 #ifdef __x86_64__
 #define HOST_IS_64 1
@@ -76,6 +77,58 @@ static const u32 vmx_msr_index[] = {
 
 struct vmx_msr_entry *find_msr_entry(struct kvm_vcpu *vcpu, u32 msr);
 
+/*
+ * Switches to specified vcpu, until a matching vcpu_put(), but assumes
+ * vcpu mutex is already taken.
+ */
+static struct kvm_vcpu *vmx_vcpu_load(struct kvm_vcpu *vcpu)
+{
+	u64 phys_addr = __pa(vcpu->vmcs);
+	int cpu;
+
+	cpu = get_cpu();
+
+	if (vcpu->cpu != cpu) {
+		smp_call_function(__vcpu_clear, vcpu, 0, 1);
+		vcpu->launched = 0;
+	}
+
+	if (per_cpu(current_vmcs, cpu) != vcpu->vmcs) {
+		u8 error;
+
+		per_cpu(current_vmcs, cpu) = vcpu->vmcs;
+		asm volatile (ASM_VMX_VMPTRLD_RAX "; setna %0"
+			      : "=g"(error) : "a"(&phys_addr), "m"(phys_addr)
+			      : "cc");
+		if (error)
+			printk(KERN_ERR "kvm: vmptrld %p/%llx fail\n",
+			       vcpu->vmcs, phys_addr);
+	}
+
+	if (vcpu->cpu != cpu) {
+		struct descriptor_table dt;
+		unsigned long sysenter_esp;
+
+		vcpu->cpu = cpu;
+		/*
+		 * Linux uses per-cpu TSS and GDT, so set these when switching
+		 * processors.
+		 */
+		vmcs_writel(HOST_TR_BASE, read_tr_base()); /* 22.2.4 */
+		get_gdt(&dt);
+		vmcs_writel(HOST_GDTR_BASE, dt.base);   /* 22.2.4 */
+
+		rdmsrl(MSR_IA32_SYSENTER_ESP, sysenter_esp);
+		vmcs_writel(HOST_IA32_SYSENTER_ESP, sysenter_esp); /* 22.2.3 */
+	}
+	return vcpu;
+}
+
+static void vmx_vcpu_put(struct kvm_vcpu *vcpu)
+{
+	put_cpu();
+}
+
 static unsigned long vmx_get_rflags(struct kvm_vcpu *vcpu)
 {
 	return vmcs_readl(GUEST_RFLAGS);
@@ -1745,6 +1798,9 @@ static struct kvm_arch_ops vmx_arch_ops 
 	.hardware_enable = hardware_enable,
 	.hardware_disable = hardware_disable,
 
+	.vcpu_load = vmx_vcpu_load,
+	.vcpu_put = vmx_vcpu_put,
+
 	.set_guest_debug = set_guest_debug,
 	.get_msr = vmx_get_msr,
 	.set_msr = vmx_set_msr,
