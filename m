Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWJWNa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWJWNa5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 09:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWJWNau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 09:30:50 -0400
Received: from il.qumranet.com ([62.219.232.206]:27093 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S964854AbWJWNab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 09:30:31 -0400
Subject: [PATCH 5/13] KVM: virtualization infrastructure
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 23 Oct 2006 13:30:26 -0000
To: avi@qumranet.com, linux-kernel@vger.kernel.org
References: <453CC390.9080508@qumranet.com>
In-Reply-To: <453CC390.9080508@qumranet.com>
Message-Id: <20061023133026.92C9F250143@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- ioctl()
- mmap()
- vcpu context management (vcpu_load/vcpu_put)
- some control register logic

Signed-off-by: Yaniv Kamay <yaniv@qumranet.com>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- /dev/null
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -0,0 +1,1260 @@
+/*
+ * Kernel-based Virtual Machine driver for Linux
+ *
+ * This module enables machines with Intel VT-x extensions to run virtual
+ * machines without emulation or binary translation.
+ *
+ * Copyright (C) 2006 Qumranet, Inc.
+ *
+ * Authors:
+ *   Avi Kivity   <avi@qumranet.com>
+ *   Yaniv Kamay  <yaniv@qumranet.com>
+ *
+ */
+
+#include "kvm.h"
+
+#include <linux/kvm.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <asm/processor.h>
+#include <linux/percpu.h>
+#include <linux/gfp.h>
+#include <asm/msr.h>
+#include <linux/mm.h>
+#include <linux/miscdevice.h>
+#include <linux/vmalloc.h>
+#include <asm/uaccess.h>
+#include <linux/reboot.h>
+#include <asm/io.h>
+#include <linux/debugfs.h>
+#include <linux/highmem.h>
+#include <linux/file.h>
+
+#include "vmx.h"
+
+MODULE_AUTHOR("Qumranet");
+MODULE_LICENSE("GPL");
+
+static struct dentry *debugfs_dir;
+static struct dentry *debugfs_pf_fixed;
+static struct dentry *debugfs_pf_guest;
+static struct dentry *debugfs_tlb_flush;
+static struct dentry *debugfs_invlpg;
+static struct dentry *debugfs_exits;
+static struct dentry *debugfs_io_exits;
+static struct dentry *debugfs_mmio_exits;
+static struct dentry *debugfs_signal_exits;
+static struct dentry *debugfs_irq_exits;
+
+struct kvm_stat kvm_stat;
+
+#define KVM_LOG_BUF_SIZE PAGE_SIZE
+
+static const u32 vmx_msr_index[] = {
+	MSR_EFER, MSR_K6_STAR,
+#ifdef __x86_64__
+	MSR_CSTAR, MSR_KERNEL_GS_BASE, MSR_SYSCALL_MASK, MSR_LSTAR
+#endif
+};
+#define NR_VMX_MSR (sizeof(vmx_msr_index) / sizeof(*vmx_msr_index))
+
+
+#ifdef __x86_64__
+/*
+ * avoid save/load MSR_SYSCALL_MASK and MSR_LSTAR by std vt
+ * mechanism (cpu bug AA24)
+ */
+#define NUM_AUTO_MSRS (NR_VMX_MSR-2)
+#else
+#define NUM_AUTO_MSRS NR_VMX_MSR
+#endif
+
+#define TSS_IOPB_BASE_OFFSET 0x66
+#define TSS_BASE_SIZE 0x68
+#define TSS_IOPB_SIZE (65536 / 8)
+#define TSS_REDIRECTION_SIZE (256 / 8)
+#define RMODE_TSS_SIZE (TSS_BASE_SIZE + TSS_REDIRECTION_SIZE + TSS_IOPB_SIZE + 1)
+
+static int rmode_tss_base(struct kvm* kvm);
+static void set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
+static void __set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
+static void lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
+static void set_cr3(struct kvm_vcpu *vcpu, unsigned long cr0);
+static void set_cr4(struct kvm_vcpu *vcpu, unsigned long cr0);
+static void __set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4);
+#ifdef __x86_64__
+static void __set_efer(struct kvm_vcpu *vcpu, u64 efer);
+#endif
+
+static struct vmx_msr_entry *find_msr_entry(struct kvm_vcpu *vcpu, u32 msr)
+{
+	int i;
+
+	for (i = 0; i < NR_VMX_MSR; ++i)
+		if (vmx_msr_index[i] == msr)
+			return &vcpu->guest_msrs[i];
+	return 0;
+}
+
+struct descriptor_table {
+	u16 limit;
+	unsigned long base;
+} __attribute__((packed));
+
+static void get_gdt(struct descriptor_table *table)
+{
+	asm ( "sgdt %0" : "=m"(*table) );
+}
+
+static void get_idt(struct descriptor_table *table)
+{
+	asm ( "sidt %0" : "=m"(*table) );
+}
+
+static u16 read_fs(void)
+{
+	u16 seg;
+	asm ( "mov %%fs, %0" : "=g"(seg) );
+	return seg;
+}
+
+static u16 read_gs(void)
+{
+	u16 seg;
+	asm ( "mov %%gs, %0" : "=g"(seg) );
+	return seg;
+}
+
+static u16 read_ldt(void)
+{
+	u16 ldt;
+	asm ( "sldt %0" : "=g"(ldt) );
+	return ldt;
+}
+
+static void load_fs(u16 sel)
+{
+	asm ( "mov %0, %%fs\n" : : "g"(sel) );
+}
+
+static void load_gs(u16 sel)
+{
+	asm ( "mov %0, %%gs\n" : : "g"(sel) );
+}
+
+#ifndef load_ldt
+static void load_ldt(u16 sel)
+{
+	asm ( "lldt %0" : : "g"(sel) );
+}
+#endif
+
+static void fx_save(void *image)
+{
+	asm ( "fxsave (%0)":: "r" (image));
+}
+
+static void fx_restore(void *image)
+{
+	asm ( "fxrstor (%0)":: "r" (image));
+}
+
+static void fpu_init(void)
+{
+	asm ( "finit" );
+}
+
+struct segment_descriptor {
+	u16 limit_low;
+	u16 base_low;
+	u8  base_mid;
+	u8  type : 4;
+	u8  system : 1;
+	u8  dpl : 2;
+	u8  present : 1;
+	u8  limit_high : 4;
+	u8  avl : 1;
+	u8  long_mode : 1;
+	u8  default_op : 1;
+	u8  granularity : 1;
+	u8  base_high;
+} __attribute__((packed));
+
+#ifdef __x86_64__
+// LDT or TSS descriptor in the GDT. 16 bytes.
+struct segment_descriptor_64 {
+	struct segment_descriptor s;
+	u32 base_higher;
+	u32 pad_zero;
+} __attribute__((packed));
+
+#endif
+
+static unsigned long segment_base(u16 selector)
+{
+	struct descriptor_table gdt;
+	struct segment_descriptor *d;
+	unsigned long table_base;
+	typedef unsigned long ul;
+	unsigned long v;
+
+	asm ( "sgdt %0" : "=m"(gdt) );
+	table_base = gdt.base;
+
+	if (selector & 4) {           /* from ldt */
+		u16 ldt_selector;
+
+		asm ( "sldt %0" : "=g"(ldt_selector) );
+		table_base = segment_base(ldt_selector);
+	}
+	d = (struct segment_descriptor *)(table_base + (selector & ~7));
+	v = d->base_low | ((ul)d->base_mid << 16) | ((ul)d->base_high << 24);
+#ifdef __x86_64__
+	if (d->system == 0
+	    && (d->type == 2 || d->type == 9 || d->type == 11))
+		v |= ((ul)((struct segment_descriptor_64 *)d)->base_higher) << 32;
+#endif
+	return v;
+}
+
+static unsigned long read_tr_base(void)
+{
+	u16 tr;
+	asm ( "str %0" : "=g"(tr) );
+	return segment_base(tr);
+}
+
+static void reload_tss(void)
+{
+#ifndef __x86_64__
+
+	/*
+	 * VT restores TR but not its size.  Useless.
+	 */
+	struct descriptor_table gdt;
+	struct segment_descriptor *descs;
+
+	get_gdt(&gdt);
+	descs = (void *)gdt.base;
+	descs[GDT_ENTRY_TSS].type = 9; /* available TSS */
+	load_TR_desc();
+#endif
+}
+
+DEFINE_PER_CPU(struct vmcs *, vmxarea);
+DEFINE_PER_CPU(struct vmcs *, current_vmcs);
+
+static struct vmcs_descriptor {
+	int size;
+	int order;
+	u32 revision_id;
+} vmcs_descriptor;
+
+#define MSR_IA32_FEATURE_CONTROL 		0x03a
+#define MSR_IA32_VMX_BASIC_MSR   		0x480
+#define MSR_IA32_VMX_PINBASED_CTLS_MSR		0x481
+#define MSR_IA32_VMX_PROCBASED_CTLS_MSR		0x482
+#define MSR_IA32_VMX_EXIT_CTLS_MSR		0x483
+#define MSR_IA32_VMX_ENTRY_CTLS_MSR		0x484
+
+#ifdef __x86_64__
+static unsigned long read_msr(unsigned long msr)
+{
+	u64 value;
+
+	rdmsrl(msr, value);
+	return value;
+}
+#endif
+
+static inline struct page *_gfn_to_page(struct kvm *kvm, gfn_t gfn)
+{
+	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
+	return (slot) ? slot->phys_mem[gfn - slot->base_gfn] : 0;
+}
+
+
+
+int kvm_read_guest(struct kvm_vcpu *vcpu,
+			     gva_t addr,
+			     unsigned long size,
+			     void *dest)
+{
+	unsigned char *host_buf = dest;
+	unsigned long req_size = size;
+
+	while (size) {
+		hpa_t paddr;
+		unsigned now;
+		unsigned offset;
+		hva_t guest_buf;
+
+		paddr = gva_to_hpa(vcpu, addr);
+
+		if (is_error_hpa(paddr))
+			break;
+
+		guest_buf = (hva_t)kmap_atomic(
+					pfn_to_page(paddr >> PAGE_SHIFT),
+					KM_USER0);
+		offset = addr & ~PAGE_MASK;
+		guest_buf |= offset;
+		now = min(size, PAGE_SIZE - offset);
+		memcpy(host_buf, (void*)guest_buf, now);
+		host_buf += now;
+		addr += now;
+		size -= now;
+		kunmap_atomic((void *)(guest_buf & PAGE_MASK), KM_USER0);
+	}
+	return req_size - size;
+}
+
+int kvm_write_guest(struct kvm_vcpu *vcpu,
+			     gva_t addr,
+			     unsigned long size,
+			     void *data)
+{
+	unsigned char *host_buf = data;
+	unsigned long req_size = size;
+
+	while (size) {
+		hpa_t paddr;
+		unsigned now;
+		unsigned offset;
+		hva_t guest_buf;
+
+		paddr = gva_to_hpa(vcpu, addr);
+
+		if (is_error_hpa(paddr))
+			break;
+
+		guest_buf = (hva_t)kmap_atomic(
+				pfn_to_page(paddr >> PAGE_SHIFT), KM_USER0);
+		offset = addr & ~PAGE_MASK;
+		guest_buf |= offset;
+		now = min(size, PAGE_SIZE - offset);
+		memcpy((void*)guest_buf, host_buf, now);
+		host_buf += now;
+		addr += now;
+		size -= now;
+		kunmap_atomic((void *)(guest_buf & PAGE_MASK), KM_USER0);
+	}
+	return req_size - size;
+}
+
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
+static void vmcs_clear(struct vmcs *vmcs)
+{
+	u64 phys_addr = __pa(vmcs);
+	u8 error;
+
+	asm volatile ( "vmclear %1; setna %0"
+		       : "=m"(error) : "m"(phys_addr) : "cc", "memory" );
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
+static int vcpu_slot(struct kvm_vcpu *vcpu)
+{
+	return vcpu - vcpu->kvm->vcpus;
+}
+
+/*
+ * Switches to specified vcpu, until a matching vcpu_put(), but assumes
+ * vcpu mutex is already taken.
+ */
+static struct kvm_vcpu *__vcpu_load(struct kvm_vcpu *vcpu)
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
+		asm volatile ( "vmptrld %1; setna %0"
+			       : "=m"(error) : "m"(phys_addr) : "cc" );
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
+/*
+ * Switches to specified vcpu, until a matching vcpu_put()
+ */
+static struct kvm_vcpu *vcpu_load(struct kvm *kvm, int vcpu_slot)
+{
+	struct kvm_vcpu *vcpu = &kvm->vcpus[vcpu_slot];
+
+	mutex_lock(&vcpu->mutex);
+	if (unlikely(!vcpu->vmcs)) {
+		mutex_unlock(&vcpu->mutex);
+		return 0;
+	}
+	return __vcpu_load(vcpu);
+}
+
+static void vcpu_put(struct kvm_vcpu *vcpu)
+{
+	put_cpu();
+	mutex_unlock(&vcpu->mutex);
+}
+
+
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
+
+static __init int cpu_has_kvm_support(void)
+{
+	unsigned long ecx = cpuid_ecx(1);
+	return test_bit(5, &ecx); /* CPUID.1:ECX.VMX[bit 5] -> VT */
+}
+
+static __exit void free_kvm_area(void)
+{
+	int cpu;
+
+	for_each_online_cpu(cpu)
+		free_vmcs(per_cpu(vmxarea, cpu));
+}
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
+static __init int vmx_disabled_by_bios(void)
+{
+	u64 msr;
+
+	rdmsrl(MSR_IA32_FEATURE_CONTROL, msr);
+	return (msr & 5) == 1; /* locked but not enabled */
+}
+
+#define CR4_VMXE 0x2000
+
+static __init void kvm_enable(void *garbage)
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
+	asm volatile ( "vmxon %0" : : "m"(phys_addr) : "memory", "cc" );
+}
+
+static void kvm_disable(void *garbage)
+{
+	asm volatile ( "vmxoff" : : : "cc" );
+}
+
+static int kvm_dev_open(struct inode *inode, struct file *filp)
+{
+	struct kvm *kvm = kzalloc(sizeof(struct kvm), GFP_KERNEL);
+	int i;
+
+	if (!kvm)
+		return -ENOMEM;
+
+	spin_lock_init(&kvm->lock);
+	INIT_LIST_HEAD(&kvm->active_mmu_pages);
+	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
+		struct kvm_vcpu *vcpu = &kvm->vcpus[i];
+
+		mutex_init(&vcpu->mutex);
+		vcpu->mmu.root_hpa = INVALID_PAGE;
+		INIT_LIST_HEAD(&vcpu->free_pages);
+	}
+	filp->private_data = kvm;
+	return 0;
+}
+
+/*
+ * Free any memory in @free but not in @dont.
+ */
+static void kvm_free_physmem_slot(struct kvm_memory_slot *free,
+				  struct kvm_memory_slot *dont)
+{
+	int i;
+
+	if (!dont || free->phys_mem != dont->phys_mem)
+		if (free->phys_mem) {
+			for (i = 0; i < free->npages; ++i)
+				__free_page(free->phys_mem[i]);
+			vfree(free->phys_mem);
+		}
+
+	if (!dont || free->dirty_bitmap != dont->dirty_bitmap)
+		vfree(free->dirty_bitmap);
+
+	free->phys_mem = 0;
+	free->npages = 0;
+	free->dirty_bitmap = 0;
+}
+
+static void kvm_free_physmem(struct kvm *kvm)
+{
+	int i;
+
+	for (i = 0; i < kvm->nmemslots; ++i)
+		kvm_free_physmem_slot(&kvm->memslots[i], 0);
+}
+
+static void kvm_free_vmcs(struct kvm_vcpu *vcpu)
+{
+	if (vcpu->vmcs) {
+		on_each_cpu(__vcpu_clear, vcpu, 0, 1);
+		free_vmcs(vcpu->vmcs);
+		vcpu->vmcs = 0;
+	}
+}
+
+static void kvm_free_vcpu(struct kvm_vcpu *vcpu)
+{
+	kvm_free_vmcs(vcpu);
+	kvm_mmu_destroy(vcpu);
+}
+
+static void kvm_free_vcpus(struct kvm *kvm)
+{
+	unsigned int i;
+
+	for (i = 0; i < KVM_MAX_VCPUS; ++i)
+		kvm_free_vcpu(&kvm->vcpus[i]);
+}
+
+static int kvm_dev_release(struct inode *inode, struct file *filp)
+{
+	struct kvm *kvm = filp->private_data;
+
+	kvm_free_vcpus(kvm);
+	kvm_free_physmem(kvm);
+	kfree(kvm);
+	return 0;
+}
+
+unsigned long vmcs_readl(unsigned long field)
+{
+	unsigned long value;
+
+	asm volatile ( "vmread %1, %0" : "=g"(value) : "r"(field) : "cc" );
+	return value;
+}
+
+void vmcs_writel(unsigned long field, unsigned long value)
+{
+	u8 error;
+
+	asm volatile ( "vmwrite %1, %2; setna %0"
+		       : "=g"(error) : "r"(value), "r"(field) : "cc" );
+	if (error)
+		printk(KERN_ERR "vmwrite error: reg %lx value %lx (err %d)\n",
+		       field, value, vmcs_read32(VM_INSTRUCTION_ERROR));
+}
+
+static void vmcs_write16(unsigned long field, u16 value)
+{
+	vmcs_writel(field, value);
+}
+
+static void vmcs_write64(unsigned long field, u64 value)
+{
+#ifdef __x86_64__
+	vmcs_writel(field, value);
+#else
+	vmcs_writel(field, value);
+	asm volatile ( "" );
+	vmcs_writel(field+1, value >> 32);
+#endif
+}
+
+/*
+ * Sync the rsp and rip registers into the vcpu structure.  This allows
+ * registers to be accessed by indexing vcpu->regs.
+ */
+static void vcpu_load_rsp_rip(struct kvm_vcpu *vcpu)
+{
+	vcpu->regs[VCPU_REGS_RSP] = vmcs_readl(GUEST_RSP);
+	vcpu->rip = vmcs_readl(GUEST_RIP);
+}
+
+/*
+ * Syncs rsp and rip back into the vmcs.  Should be called after possible
+ * modification.
+ */
+static void vcpu_put_rsp_rip(struct kvm_vcpu *vcpu)
+{
+	vmcs_writel(GUEST_RSP, vcpu->regs[VCPU_REGS_RSP]);
+	vmcs_writel(GUEST_RIP, vcpu->rip);
+}
+
+struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn)
+{
+	int i;
+
+	for (i = 0; i < kvm->nmemslots; ++i) {
+		struct kvm_memory_slot *memslot = &kvm->memslots[i];
+
+		if (gfn >= memslot->base_gfn
+		    && gfn < memslot->base_gfn + memslot->npages)
+			return memslot;
+	}
+	return 0;
+}
+
+void mark_page_dirty(struct kvm *kvm, gfn_t gfn)
+{
+	int i;
+	struct kvm_memory_slot *memslot = 0;
+	unsigned long rel_gfn;
+
+	for (i = 0; i < kvm->nmemslots; ++i) {
+		memslot = &kvm->memslots[i];
+
+		if (gfn >= memslot->base_gfn
+		    && gfn < memslot->base_gfn + memslot->npages) {
+
+			if (!memslot || !memslot->dirty_bitmap)
+				return;
+
+			rel_gfn = gfn - memslot->base_gfn;
+
+			/* avoid RMW */
+			if (!test_bit(rel_gfn, memslot->dirty_bitmap))
+				set_bit(rel_gfn, memslot->dirty_bitmap);
+			return;
+		}
+	}
+}
+
+static int pdptrs_have_reserved_bits_set(struct kvm_vcpu *vcpu,
+					 unsigned long cr3)
+{
+	gfn_t pdpt_gfn = cr3 >> PAGE_SHIFT;
+	unsigned offset = (cr3 & (PAGE_SIZE-1)) >> 5;
+	int i;
+	u64 pdpte;
+	u64 *pdpt;
+	struct kvm_memory_slot *memslot;
+
+	spin_lock(&vcpu->kvm->lock);
+	memslot = gfn_to_memslot(vcpu->kvm, pdpt_gfn);
+	/* FIXME: !memslot - emulate? 0xff? */
+	pdpt = kmap_atomic(gfn_to_page(memslot, pdpt_gfn), KM_USER0);
+
+	for (i = 0; i < 4; ++i) {
+		pdpte = pdpt[offset + i];
+		if ((pdpte & 1) && (pdpte & 0xfffffff0000001e6ull))
+			break;
+	}
+
+	kunmap_atomic(pdpt, KM_USER0);
+	spin_unlock(&vcpu->kvm->lock);
+
+	return i != 4;
+}
+
+#define CR0_RESEVED_BITS 0xffffffff1ffaffc0ULL
+
+static void set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
+{
+	if (cr0 & CR0_RESEVED_BITS) {
+		printk("set_cr0: 0x%lx #GP, reserved bits (0x%lx)\n", cr0, guest_cr0());
+		inject_gp(vcpu);
+		return;
+	}
+
+	if ((cr0 & CR0_NW_MASK) && !(cr0 & CR0_CD_MASK)) {
+		printk("set_cr0: #GP, CD == 0 && NW == 1\n");
+		inject_gp(vcpu);
+		return;
+	}
+
+	if ((cr0 & CR0_PG_MASK) && !(cr0 & CR0_PE_MASK)) {
+		printk("set_cr0: #GP, set PG flag and a clear PE flag\n");
+		inject_gp(vcpu);
+		return;
+	}
+
+	if (is_paging()) {
+#ifdef __x86_64__
+		if (!(cr0 & CR0_PG_MASK)) {
+			vcpu->shadow_efer &= ~EFER_LMA;
+			vmcs_write32(VM_ENTRY_CONTROLS,
+				     vmcs_read32(VM_ENTRY_CONTROLS) &
+				     ~VM_ENTRY_CONTROLS_IA32E_MASK);
+		}
+#endif
+	} else if ((cr0 & CR0_PG_MASK)) {
+#ifdef __x86_64__
+		if ((vcpu->shadow_efer & EFER_LME)) {
+			u32 guest_cs_ar;
+			u32 guest_tr_ar;
+			if (!is_pae()) {
+				printk("set_cr0: #GP, start paging in "
+				       "long mode while PAE is disabled\n");
+				inject_gp(vcpu);
+				return;
+			}
+			guest_cs_ar = vmcs_read32(GUEST_CS_AR_BYTES);
+			if (guest_cs_ar & SEGMENT_AR_L_MASK) {
+				printk("set_cr0: #GP, start paging in "
+				       "long mode while CS.L == 1\n");
+				inject_gp(vcpu);
+				return;
+
+			}
+			guest_tr_ar = vmcs_read32(GUEST_TR_AR_BYTES);
+			if ((guest_tr_ar & AR_TYPE_MASK) != AR_TYPE_BUSY_64_TSS) {
+				printk("%s: tss fixup for long mode. \n",
+				       __FUNCTION__);
+				vmcs_write32(GUEST_TR_AR_BYTES,
+					     (guest_tr_ar & ~AR_TYPE_MASK) |
+					     AR_TYPE_BUSY_64_TSS);
+			}
+			vcpu->shadow_efer |= EFER_LMA;
+			find_msr_entry(vcpu, MSR_EFER)->data |=
+							EFER_LMA | EFER_LME;
+			vmcs_write32(VM_ENTRY_CONTROLS,
+				     vmcs_read32(VM_ENTRY_CONTROLS) |
+				     VM_ENTRY_CONTROLS_IA32E_MASK);
+
+		} else
+#endif
+		if (is_pae() &&
+			    pdptrs_have_reserved_bits_set(vcpu, vcpu->cr3)) {
+			printk("set_cr0: #GP, pdptrs reserved bits\n");
+			inject_gp(vcpu);
+			return;
+		}
+
+	}
+
+	__set_cr0(vcpu, cr0);
+	kvm_mmu_reset_context(vcpu);
+	return;
+}
+
+static void lmsw(struct kvm_vcpu *vcpu, unsigned long msw)
+{
+	unsigned long cr0 = guest_cr0();
+
+	if ((msw & CR0_PE_MASK) && !(cr0 & CR0_PE_MASK)) {
+		enter_pmode(vcpu);
+		vmcs_writel(CR0_READ_SHADOW, cr0 | CR0_PE_MASK);
+
+	} else
+		printk("lmsw: unexpected\n");
+
+	#define LMSW_GUEST_MASK 0x0eULL
+
+	vmcs_writel(GUEST_CR0, (vmcs_readl(GUEST_CR0) & ~LMSW_GUEST_MASK)
+				| (msw & LMSW_GUEST_MASK));
+}
+
+#define CR4_RESEVED_BITS (~((1ULL << 11) - 1))
+
+static void set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
+{
+	if (cr4 & CR4_RESEVED_BITS) {
+		printk("set_cr4: #GP, reserved bits\n");
+		inject_gp(vcpu);
+		return;
+	}
+
+	if (is_long_mode()) {
+		if (!(cr4 & CR4_PAE_MASK)) {
+			printk("set_cr4: #GP, clearing PAE while in long mode\n");
+			inject_gp(vcpu);
+			return;
+		}
+	} else if (is_paging() && !is_pae() && (cr4 & CR4_PAE_MASK)
+		   && pdptrs_have_reserved_bits_set(vcpu, vcpu->cr3)) {
+		printk("set_cr4: #GP, pdptrs reserved bits\n");
+		inject_gp(vcpu);
+	}
+
+	if (cr4 & CR4_VMXE_MASK) {
+		printk("set_cr4: #GP, setting VMXE\n");
+		inject_gp(vcpu);
+		return;
+	}
+	__set_cr4(vcpu, cr4);
+	spin_lock(&vcpu->kvm->lock);
+	kvm_mmu_reset_context(vcpu);
+	spin_unlock(&vcpu->kvm->lock);
+}
+
+static void set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
+{
+	if (is_long_mode()) {
+		if ( cr3 & CR3_L_MODE_RESEVED_BITS) {
+			printk("set_cr3: #GP, reserved bits\n");
+			inject_gp(vcpu);
+			return;
+		}
+	} else {
+		if (cr3 & CR3_RESEVED_BITS) {
+			printk("set_cr3: #GP, reserved bits\n");
+			inject_gp(vcpu);
+			return;
+		}
+		if (is_paging() && is_pae() &&
+		    pdptrs_have_reserved_bits_set(vcpu, cr3)) {
+			printk("set_cr3: #GP, pdptrs reserved bits\n");
+			inject_gp(vcpu);
+			return;
+		}
+	}
+
+	vcpu->cr3 = cr3;
+	spin_lock(&vcpu->kvm->lock);
+	vcpu->mmu.new_cr3(vcpu);
+	spin_unlock(&vcpu->kvm->lock);
+}
+
+#define CR8_RESEVED_BITS (~0x0fULL)
+
+static void set_cr8(struct kvm_vcpu *vcpu, unsigned long cr8)
+{
+	if ( cr8 & CR8_RESEVED_BITS) {
+		printk("set_cr8: #GP, reserved bits 0x%lx\n", cr8);
+		inject_gp(vcpu);
+		return;
+	}
+	vcpu->cr8 = cr8;
+}
+
+
+static void __set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
+{
+	if (vcpu->rmode.active && (cr0 & CR0_PE_MASK))
+		enter_pmode(vcpu);
+
+	if (!vcpu->rmode.active && !(cr0 & CR0_PE_MASK))
+		enter_rmode(vcpu);
+
+	vmcs_writel(CR0_READ_SHADOW, cr0);
+	vmcs_writel(GUEST_CR0, cr0 | KVM_VM_CR0_ALWAYS_ON);
+}
+
+static void __set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
+{
+	vmcs_writel(CR4_READ_SHADOW, cr4);
+	vmcs_writel(GUEST_CR4, cr4 | (vcpu->rmode.active ?
+		    KVM_RMODE_VM_CR4_ALWAYS_ON : KVM_PMODE_VM_CR4_ALWAYS_ON));
+}
+
+#ifdef __x86_64__
+#define EFER_RESERVED_BITS 0xfffffffffffff2fe
+
+static void set_efer(struct kvm_vcpu *vcpu, u64 efer)
+{
+	struct vmx_msr_entry *msr;
+
+	if (efer & EFER_RESERVED_BITS) {
+		printk("set_efer: 0x%llx #GP, reserved bits\n", efer);
+		inject_gp(vcpu);
+		return;
+	}
+
+	if (is_paging() && (vcpu->shadow_efer & EFER_LME) != (efer & EFER_LME)) {
+		printk("set_efer: #GP, change LME while paging\n");
+		inject_gp(vcpu);
+		return;
+	}
+
+	efer &= ~EFER_LMA;
+	efer |= vcpu->shadow_efer & EFER_LMA;
+
+	vcpu->shadow_efer = efer;
+
+	msr = find_msr_entry(vcpu, MSR_EFER);
+
+	if (!(efer & EFER_LMA))
+	    efer &= ~EFER_LME;
+	msr->data = efer;
+	skip_emulated_instruction(vcpu);
+}
+
+static void __set_efer(struct kvm_vcpu *vcpu, u64 efer)
+{
+	struct vmx_msr_entry *msr = find_msr_entry(vcpu, MSR_EFER);
+
+	vcpu->shadow_efer = efer;
+	if (efer & EFER_LMA) {
+		vmcs_write32(VM_ENTRY_CONTROLS,
+				     vmcs_read32(VM_ENTRY_CONTROLS) |
+				     VM_ENTRY_CONTROLS_IA32E_MASK);
+		msr->data = efer;
+
+	} else {
+		vmcs_write32(VM_ENTRY_CONTROLS,
+				     vmcs_read32(VM_ENTRY_CONTROLS) &
+				     ~VM_ENTRY_CONTROLS_IA32E_MASK);
+
+		msr->data = efer & ~EFER_LME;
+	}
+}
+#endif
+
+static void inject_rmode_irq(struct kvm_vcpu *vcpu, int irq)
+{
+	u16 ent[2];
+	u16 cs;
+	u16 ip;
+	unsigned long flags;
+	unsigned long ss_base = vmcs_readl(GUEST_SS_BASE);
+	u16 sp =  vmcs_readl(GUEST_RSP);
+	u32 ss_limit = vmcs_read32(GUEST_SS_LIMIT);
+
+	if (sp > ss_limit || sp - 6 > sp) {
+		vcpu_printf(vcpu, "%s: #SS, rsp 0x%lx ss 0x%lx limit 0x%x\n",
+			    __FUNCTION__,
+			    vmcs_readl(GUEST_RSP),
+			    vmcs_readl(GUEST_SS_BASE),
+			    vmcs_read32(GUEST_SS_LIMIT));
+		return;
+	}
+
+	if (kvm_read_guest(vcpu, irq * sizeof(ent), sizeof(ent), &ent) !=
+								sizeof(ent)) {
+		vcpu_printf(vcpu, "%s: read guest err\n", __FUNCTION__);
+		return;
+	}
+
+	flags =  vmcs_readl(GUEST_RFLAGS);
+	cs =  vmcs_readl(GUEST_CS_BASE) >> 4;
+	ip =  vmcs_readl(GUEST_RIP);
+
+
+	if (kvm_write_guest(vcpu, ss_base + sp - 2, 2, &flags) != 2 ||
+	    kvm_write_guest(vcpu, ss_base + sp - 4, 2, &cs) != 2 ||
+	    kvm_write_guest(vcpu, ss_base + sp - 6, 2, &ip) != 2) {
+		vcpu_printf(vcpu, "%s: write guest err\n", __FUNCTION__);
+		return;
+	}
+
+	vmcs_writel(GUEST_RFLAGS, flags &
+		    ~( X86_EFLAGS_IF | X86_EFLAGS_AC | X86_EFLAGS_TF));
+	vmcs_write16(GUEST_CS_SELECTOR, ent[1]) ;
+	vmcs_writel(GUEST_CS_BASE, ent[1] << 4);
+	vmcs_writel(GUEST_RIP, ent[0]);
+	vmcs_writel(GUEST_RSP, (vmcs_readl(GUEST_RSP) & ~0xffff) | (sp - 6));
+}
+
+static void kvm_do_inject_irq(struct kvm_vcpu *vcpu)
+{
+	int word_index = __ffs(vcpu->irq_summary);
+	int bit_index = __ffs(vcpu->irq_pending[word_index]);
+	int irq = word_index * BITS_PER_LONG + bit_index;
+
+	clear_bit(bit_index, &vcpu->irq_pending[word_index]);
+	if (!vcpu->irq_pending[word_index])
+		clear_bit(word_index, &vcpu->irq_summary);
+
+	if (vcpu->rmode.active) {
+		inject_rmode_irq(vcpu, irq);
+		return;
+	}
+	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
+			irq | INTR_TYPE_EXT_INTR | INTR_INFO_VALID_MASK);
+}
+
+static void kvm_try_inject_irq(struct kvm_vcpu *vcpu)
+{
+	if ((vmcs_readl(GUEST_RFLAGS) & X86_EFLAGS_IF)
+	    && (vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) & 3) == 0)
+		/*
+		 * Interrupts enabled, and not blocked by sti or mov ss. Good.
+		 */
+		kvm_do_inject_irq(vcpu);
+	else
+		/*
+		 * Interrupts blocked.  Wait for unblock.
+		 */
+		vmcs_write32(CPU_BASED_VM_EXEC_CONTROL,
+			     vmcs_read32(CPU_BASED_VM_EXEC_CONTROL)
+			     | CPU_BASED_VIRTUAL_INTR_PENDING);
+}
+
+static void load_msrs(struct vmx_msr_entry *e)
+{
+	int i;
+
+	for (i = NUM_AUTO_MSRS; i < NR_VMX_MSR; ++i)
+		wrmsrl(e[i].index, e[i].data);
+}
+
+static void save_msrs(struct vmx_msr_entry *e, int msr_index)
+{
+	for (; msr_index < NR_VMX_MSR; ++msr_index)
+		rdmsrl(e[msr_index].index, e[msr_index].data);
+}
+
+static long kvm_dev_ioctl(struct file *filp,
+			  unsigned int ioctl, unsigned long arg)
+{
+	struct kvm *kvm = filp->private_data;
+	int r = -EINVAL;
+
+	switch (ioctl) {
+	default:
+		;
+	}
+out:
+	return r;
+}
+
+static struct page *kvm_dev_nopage(struct vm_area_struct *vma,
+				   unsigned long address,
+				   int *type)
+{
+	struct kvm *kvm = vma->vm_file->private_data;
+	unsigned long pgoff;
+	struct kvm_memory_slot *slot;
+	struct page *page;
+
+	*type = VM_FAULT_MINOR;
+	pgoff = ((address - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
+	slot = gfn_to_memslot(kvm, pgoff);
+	if (!slot)
+		return NOPAGE_SIGBUS;
+	page = gfn_to_page(slot, pgoff);
+	if (!page)
+		return NOPAGE_SIGBUS;
+	get_page(page);
+	return page;
+}
+
+static struct vm_operations_struct kvm_dev_vm_ops = {
+	.nopage = kvm_dev_nopage,
+};
+
+static int kvm_dev_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	vma->vm_ops = &kvm_dev_vm_ops;
+	return 0;
+}
+
+static struct file_operations kvm_chardev_ops = {
+	.owner		= THIS_MODULE,
+	.open		= kvm_dev_open,
+	.release        = kvm_dev_release,
+	.unlocked_ioctl = kvm_dev_ioctl,
+	.compat_ioctl   = kvm_dev_ioctl,
+	.mmap           = kvm_dev_mmap,
+};
+
+static struct miscdevice kvm_dev = {
+	MISC_DYNAMIC_MINOR,
+	"kvm",
+	&kvm_chardev_ops,
+};
+
+static int kvm_reboot(struct notifier_block *notifier, unsigned long val,
+                       void *v)
+{
+	if (val == SYS_RESTART) {
+		/*
+		 * Some (well, at least mine) BIOSes hang on reboot if
+		 * in vmx root mode.
+		 */
+		printk(KERN_INFO "kvm: exiting vmx mode\n");
+		on_each_cpu(kvm_disable, 0, 0, 1);
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block kvm_reboot_notifier = {
+	.notifier_call = kvm_reboot,
+	.priority = 0,
+};
+
+static __init void kvm_init_debug(void)
+{
+	debugfs_dir = debugfs_create_dir("kvm", 0);
+	debugfs_pf_fixed = debugfs_create_u32("pf_fixed", 0444, debugfs_dir,
+					      &kvm_stat.pf_fixed);
+	debugfs_pf_guest = debugfs_create_u32("pf_guest", 0444, debugfs_dir,
+					      &kvm_stat.pf_guest);
+	debugfs_tlb_flush = debugfs_create_u32("tlb_flush", 0444, debugfs_dir,
+					       &kvm_stat.tlb_flush);
+	debugfs_invlpg = debugfs_create_u32("invlpg", 0444, debugfs_dir,
+					      &kvm_stat.invlpg);
+	debugfs_exits = debugfs_create_u32("exits", 0444, debugfs_dir,
+					   &kvm_stat.exits);
+	debugfs_io_exits = debugfs_create_u32("io_exits", 0444, debugfs_dir,
+					      &kvm_stat.io_exits);
+	debugfs_mmio_exits = debugfs_create_u32("mmio_exits", 0444,
+						debugfs_dir,
+						&kvm_stat.mmio_exits);
+	debugfs_signal_exits = debugfs_create_u32("signal_exits", 0444,
+						  debugfs_dir,
+						  &kvm_stat.signal_exits);
+	debugfs_irq_exits = debugfs_create_u32("irq_exits", 0444, debugfs_dir,
+					       &kvm_stat.irq_exits);
+}
+
+static void kvm_exit_debug(void)
+{
+	debugfs_remove(debugfs_signal_exits);
+	debugfs_remove(debugfs_irq_exits);
+	debugfs_remove(debugfs_mmio_exits);
+	debugfs_remove(debugfs_io_exits);
+	debugfs_remove(debugfs_exits);
+	debugfs_remove(debugfs_pf_fixed);
+	debugfs_remove(debugfs_pf_guest);
+	debugfs_remove(debugfs_tlb_flush);
+	debugfs_remove(debugfs_invlpg);
+	debugfs_remove(debugfs_dir);
+}
+
+hpa_t bad_page_address;
+
+static __init int kvm_init(void)
+{
+	static struct page *bad_page;
+	int r = 0;
+
+	if (!cpu_has_kvm_support()) {
+		printk(KERN_ERR "kvm: no hardware support\n");
+		return -EOPNOTSUPP;
+	}
+	if (vmx_disabled_by_bios()) {
+		printk(KERN_ERR "kvm: disabled by bios\n");
+		return -EOPNOTSUPP;
+	}
+
+	kvm_init_debug();
+
+	setup_vmcs_descriptor();
+	r = alloc_kvm_area();
+	if (r)
+		goto out;
+	on_each_cpu(kvm_enable, 0, 0, 1);
+	register_reboot_notifier(&kvm_reboot_notifier);
+
+	r = misc_register(&kvm_dev);
+	if (r) {
+		printk (KERN_ERR "kvm: misc device register failed\n");
+		goto out_free;
+	}
+
+
+	if ((bad_page = alloc_page(GFP_KERNEL)) == NULL) {
+		r = -ENOMEM;
+		goto out_free;
+	}
+
+	bad_page_address = page_to_pfn(bad_page) << PAGE_SHIFT;
+	memset(__va(bad_page_address), 0, PAGE_SIZE);
+
+	return r;
+
+out_free:
+	free_kvm_area();
+out:
+	kvm_exit_debug();
+	return r;
+}
+
+static __exit void kvm_exit(void)
+{
+	kvm_exit_debug();
+	misc_deregister(&kvm_dev);
+	unregister_reboot_notifier(&kvm_reboot_notifier);
+	on_each_cpu(kvm_disable, 0, 0, 1);
+	free_kvm_area();
+	__free_page(pfn_to_page(bad_page_address >> PAGE_SHIFT));
+}
+
+module_init(kvm_init)
+module_exit(kvm_exit)
