Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423696AbWJZR1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423696AbWJZR1G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 13:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945898AbWJZR1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 13:27:05 -0400
Received: from il.qumranet.com ([62.219.232.206]:46780 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1945896AbWJZR1A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 13:27:00 -0400
Subject: [PATCH 5/13] KVM: virtualization infrastructure
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 26 Oct 2006 17:26:56 -0000
To: linux-kernel@vger.kernel.org, kvm-devel@lists.sourceforge.net
References: <4540EE2B.9020606@qumranet.com>
In-Reply-To: <4540EE2B.9020606@qumranet.com>
Message-Id: <20061026172656.BE914A0209@cleopatra.q>
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
@@ -0,0 +1,1498 @@
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
+#include "x86_emulate.h"
+
+MODULE_AUTHOR("Qumranet");
+MODULE_LICENSE("GPL");
+
+struct kvm_stat kvm_stat;
+
+static struct kvm_stats_debugfs_item {
+	const char *name;
+	u32 *data;
+	struct dentry *dentry;
+} debugfs_entries[] = {
+	{ "pf_fixed", &kvm_stat.pf_fixed },
+	{ "pf_guest", &kvm_stat.pf_guest },
+	{ "tlb_flush", &kvm_stat.tlb_flush },
+	{ "invlpg", &kvm_stat.invlpg },
+	{ "exits", &kvm_stat.exits },
+	{ "io_exits", &kvm_stat.io_exits },
+	{ "mmio_exits", &kvm_stat.mmio_exits },
+	{ "signal_exits", &kvm_stat.signal_exits },
+	{ "irq_exits", &kvm_stat.irq_exits },
+	{ 0, 0 }
+};
+
+static struct dentry *debugfs_dir;
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
+#define MSR_IA32_FEATURE_CONTROL 		0x03a
+#define MSR_IA32_VMX_BASIC_MSR   		0x480
+#define MSR_IA32_VMX_PINBASED_CTLS_MSR		0x481
+#define MSR_IA32_VMX_PROCBASED_CTLS_MSR		0x482
+#define MSR_IA32_VMX_EXIT_CTLS_MSR		0x483
+#define MSR_IA32_VMX_ENTRY_CTLS_MSR		0x484
+
+#define CR0_RESEVED_BITS 0xffffffff1ffaffc0ULL
+#define LMSW_GUEST_MASK 0x0eULL
+#define CR4_RESEVED_BITS (~((1ULL << 11) - 1))
+#define CR4_VMXE 0x2000
+#define CR8_RESEVED_BITS (~0x0fULL)
+#define EFER_RESERVED_BITS 0xfffffffffffff2fe
+
+#ifdef __x86_64__
+#define HOST_IS_64 1
+#else
+#define HOST_IS_64 0
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
+	asm ("sgdt %0" : "=m"(*table));
+}
+
+static void get_idt(struct descriptor_table *table)
+{
+	asm ("sidt %0" : "=m"(*table));
+}
+
+static u16 read_fs(void)
+{
+	u16 seg;
+	asm ("mov %%fs, %0" : "=g"(seg));
+	return seg;
+}
+
+static u16 read_gs(void)
+{
+	u16 seg;
+	asm ("mov %%gs, %0" : "=g"(seg));
+	return seg;
+}
+
+static u16 read_ldt(void)
+{
+	u16 ldt;
+	asm ("sldt %0" : "=g"(ldt));
+	return ldt;
+}
+
+static void load_fs(u16 sel)
+{
+	asm ("mov %0, %%fs" : : "g"(sel));
+}
+
+static void load_gs(u16 sel)
+{
+	asm ("mov %0, %%gs" : : "g"(sel));
+}
+
+#ifndef load_ldt
+static void load_ldt(u16 sel)
+{
+	asm ("lldt %0" : : "g"(sel));
+}
+#endif
+
+static void fx_save(void *image)
+{
+	asm ("fxsave (%0)":: "r" (image));
+}
+
+static void fx_restore(void *image)
+{
+	asm ("fxrstor (%0)":: "r" (image));
+}
+
+static void fpu_init(void)
+{
+	asm ("finit");
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
+};
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
+	asm ("sgdt %0" : "=m"(gdt));
+	table_base = gdt.base;
+
+	if (selector & 4) {           /* from ldt */
+		u16 ldt_selector;
+
+		asm ("sldt %0" : "=g"(ldt_selector));
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
+	asm ("str %0" : "=g"(tr));
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
+static DEFINE_PER_CPU(struct vmcs *, vmxarea);
+static DEFINE_PER_CPU(struct vmcs *, current_vmcs);
+
+static struct vmcs_descriptor {
+	int size;
+	int order;
+	u32 revision_id;
+} vmcs_descriptor;
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
+	asm volatile ("vmclear %1; setna %0"
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
+		asm volatile ("vmptrld %1; setna %0"
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
+	asm volatile ("vmxon %0" : : "m"(phys_addr) : "memory", "cc");
+}
+
+static void kvm_disable(void *garbage)
+{
+	asm volatile ("vmxoff" : : : "cc");
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
+	asm volatile ("vmread %1, %0" : "=g"(value) : "r"(field) : "cc");
+	return value;
+}
+
+void vmcs_writel(unsigned long field, unsigned long value)
+{
+	u8 error;
+
+	asm volatile ("vmwrite %1, %2; setna %0"
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
+	asm volatile ("");
+	vmcs_writel(field+1, value >> 32);
+#endif
+}
+
+static void inject_gp(struct kvm_vcpu *vcpu)
+{
+	printk(KERN_DEBUG "inject_general_protection: rip 0x%lx\n",
+	       vmcs_readl(GUEST_RIP));
+	vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE, 0);
+	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
+		     GP_VECTOR |
+		     INTR_TYPE_EXCEPTION |
+		     INTR_INFO_DELIEVER_CODE_MASK |
+		     INTR_INFO_VALID_MASK);
+}
+
+static void update_exception_bitmap(struct kvm_vcpu *vcpu)
+{
+	if (vcpu->rmode.active)
+		vmcs_write32(EXCEPTION_BITMAP, ~0);
+	else
+		vmcs_write32(EXCEPTION_BITMAP, 1 << PF_VECTOR);
+}
+
+static void enter_pmode(struct kvm_vcpu *vcpu)
+{
+	unsigned long flags;
+
+	vcpu->rmode.active = 0;
+
+	vmcs_writel(GUEST_TR_BASE, vcpu->rmode.tr.base);
+	vmcs_write32(GUEST_TR_LIMIT, vcpu->rmode.tr.limit);
+	vmcs_write32(GUEST_TR_AR_BYTES, vcpu->rmode.tr.ar);
+
+	flags = vmcs_readl(GUEST_RFLAGS);
+	flags &= ~(IOPL_MASK | X86_EFLAGS_VM);
+	flags |= (vcpu->rmode.save_iopl << IOPL_SHIFT);
+	vmcs_writel(GUEST_RFLAGS, flags);
+
+	vmcs_writel(GUEST_CR4, (vmcs_readl(GUEST_CR4) & ~CR4_VME_MASK) |
+			(vmcs_readl(CR0_READ_SHADOW) & CR4_VME_MASK) );
+
+	update_exception_bitmap(vcpu);
+
+	#define FIX_PMODE_DATASEG(seg, save) {				\
+			vmcs_write16(GUEST_##seg##_SELECTOR, 0); 	\
+			vmcs_writel(GUEST_##seg##_BASE, 0); 		\
+			vmcs_write32(GUEST_##seg##_LIMIT, 0xffff);	\
+			vmcs_write32(GUEST_##seg##_AR_BYTES, 0x93);	\
+	}
+
+	FIX_PMODE_DATASEG(SS, vcpu->rmode.ss);
+	FIX_PMODE_DATASEG(ES, vcpu->rmode.es);
+	FIX_PMODE_DATASEG(DS, vcpu->rmode.ds);
+	FIX_PMODE_DATASEG(GS, vcpu->rmode.gs);
+	FIX_PMODE_DATASEG(FS, vcpu->rmode.fs);
+
+	vmcs_write16(GUEST_CS_SELECTOR,
+		     vmcs_read16(GUEST_CS_SELECTOR) & ~SELECTOR_RPL_MASK);
+	vmcs_write32(GUEST_CS_AR_BYTES, 0x9b);
+}
+
+static int rmode_tss_base(struct kvm* kvm)
+{
+	gfn_t base_gfn = kvm->memslots[0].base_gfn + kvm->memslots[0].npages - 3;
+	return base_gfn << PAGE_SHIFT;
+}
+
+static void enter_rmode(struct kvm_vcpu *vcpu)
+{
+	unsigned long flags;
+
+	vcpu->rmode.active = 1;
+
+	vcpu->rmode.tr.base = vmcs_readl(GUEST_TR_BASE);
+	vmcs_writel(GUEST_TR_BASE, rmode_tss_base(vcpu->kvm));
+
+	vcpu->rmode.tr.limit = vmcs_read32(GUEST_TR_LIMIT);
+	vmcs_write32(GUEST_TR_LIMIT, RMODE_TSS_SIZE - 1);
+
+	vcpu->rmode.tr.ar = vmcs_read32(GUEST_TR_AR_BYTES);
+	vmcs_write32(GUEST_TR_AR_BYTES, 0x008b);
+
+	flags = vmcs_readl(GUEST_RFLAGS);
+	vcpu->rmode.save_iopl = (flags & IOPL_MASK) >> IOPL_SHIFT;
+
+	flags |= IOPL_MASK | X86_EFLAGS_VM;
+
+	vmcs_writel(GUEST_RFLAGS, flags);
+	vmcs_writel(GUEST_CR4, vmcs_readl(GUEST_CR4) | CR4_VME_MASK);
+	update_exception_bitmap(vcpu);
+
+	#define FIX_RMODE_SEG(seg, save) {				   \
+		vmcs_write16(GUEST_##seg##_SELECTOR, 			   \
+					vmcs_readl(GUEST_##seg##_BASE) >> 4); \
+		vmcs_write32(GUEST_##seg##_LIMIT, 0xffff);		   \
+		vmcs_write32(GUEST_##seg##_AR_BYTES, 0xf3);		   \
+	}
+
+	vmcs_write32(GUEST_CS_AR_BYTES, 0xf3);
+	vmcs_write16(GUEST_CS_SELECTOR, vmcs_readl(GUEST_CS_BASE) >> 4);
+
+	FIX_RMODE_SEG(ES, vcpu->rmode.es);
+	FIX_RMODE_SEG(DS, vcpu->rmode.ds);
+	FIX_RMODE_SEG(SS, vcpu->rmode.ss);
+	FIX_RMODE_SEG(GS, vcpu->rmode.gs);
+	FIX_RMODE_SEG(FS, vcpu->rmode.fs);
+}
+
+#ifdef __x86_64__
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
+
+static void enter_lmode(struct kvm_vcpu *vcpu)
+{
+	u32 guest_tr_ar;
+
+	guest_tr_ar = vmcs_read32(GUEST_TR_AR_BYTES);
+	if ((guest_tr_ar & AR_TYPE_MASK) != AR_TYPE_BUSY_64_TSS) {
+		printk(KERN_DEBUG "%s: tss fixup for long mode. \n",
+		       __FUNCTION__);
+		vmcs_write32(GUEST_TR_AR_BYTES,
+			     (guest_tr_ar & ~AR_TYPE_MASK)
+			     | AR_TYPE_BUSY_64_TSS);
+	}
+
+	vcpu->shadow_efer |= EFER_LMA;
+
+	find_msr_entry(vcpu, MSR_EFER)->data |= EFER_LMA | EFER_LME;
+	vmcs_write32(VM_ENTRY_CONTROLS,
+		     vmcs_read32(VM_ENTRY_CONTROLS)
+		     | VM_ENTRY_CONTROLS_IA32E_MASK);
+}
+
+static void exit_lmode(struct kvm_vcpu *vcpu)
+{
+	vcpu->shadow_efer &= ~EFER_LMA;
+
+	vmcs_write32(VM_ENTRY_CONTROLS,
+		     vmcs_read32(VM_ENTRY_CONTROLS)
+		     & ~VM_ENTRY_CONTROLS_IA32E_MASK);
+}
+
+#endif
+
+static void __set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
+{
+	if (vcpu->rmode.active && (cr0 & CR0_PE_MASK))
+		enter_pmode(vcpu);
+
+	if (!vcpu->rmode.active && !(cr0 & CR0_PE_MASK))
+		enter_rmode(vcpu);
+
+#ifdef __x86_64__
+	if (vcpu->shadow_efer & EFER_LME) {
+		if (!is_paging() && (cr0 & CR0_PG_MASK))
+			enter_lmode(vcpu);
+		if (is_paging() && !(cr0 & CR0_PG_MASK))
+			exit_lmode(vcpu);
+	}
+#endif
+
+	vmcs_writel(CR0_READ_SHADOW, cr0);
+	vmcs_writel(GUEST_CR0, cr0 | KVM_VM_CR0_ALWAYS_ON);
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
+static void set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
+{
+	if (cr0 & CR0_RESEVED_BITS) {
+		printk(KERN_DEBUG "set_cr0: 0x%lx #GP, reserved bits 0x%lx\n",
+		       cr0, guest_cr0());
+		inject_gp(vcpu);
+		return;
+	}
+
+	if ((cr0 & CR0_NW_MASK) && !(cr0 & CR0_CD_MASK)) {
+		printk(KERN_DEBUG "set_cr0: #GP, CD == 0 && NW == 1\n");
+		inject_gp(vcpu);
+		return;
+	}
+
+	if ((cr0 & CR0_PG_MASK) && !(cr0 & CR0_PE_MASK)) {
+		printk(KERN_DEBUG "set_cr0: #GP, set PG flag "
+		       "and a clear PE flag\n");
+		inject_gp(vcpu);
+		return;
+	}
+
+	if (!is_paging() && (cr0 & CR0_PG_MASK)) {
+#ifdef __x86_64__
+		if ((vcpu->shadow_efer & EFER_LME)) {
+			u32 guest_cs_ar;
+			if (!is_pae()) {
+				printk(KERN_DEBUG "set_cr0: #GP, start paging "
+				       "in long mode while PAE is disabled\n");
+				inject_gp(vcpu);
+				return;
+			}
+			guest_cs_ar = vmcs_read32(GUEST_CS_AR_BYTES);
+			if (guest_cs_ar & SEGMENT_AR_L_MASK) {
+				printk(KERN_DEBUG "set_cr0: #GP, start paging "
+				       "in long mode while CS.L == 1\n");
+				inject_gp(vcpu);
+				return;
+
+			}
+		} else
+#endif
+		if (is_pae() &&
+			    pdptrs_have_reserved_bits_set(vcpu, vcpu->cr3)) {
+			printk(KERN_DEBUG "set_cr0: #GP, pdptrs "
+			       "reserved bits\n");
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
+		printk(KERN_DEBUG "lmsw: unexpected\n");
+
+	vmcs_writel(GUEST_CR0, (vmcs_readl(GUEST_CR0) & ~LMSW_GUEST_MASK)
+				| (msw & LMSW_GUEST_MASK));
+}
+
+static void __set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
+{
+	vmcs_writel(CR4_READ_SHADOW, cr4);
+	vmcs_writel(GUEST_CR4, cr4 | (vcpu->rmode.active ?
+		    KVM_RMODE_VM_CR4_ALWAYS_ON : KVM_PMODE_VM_CR4_ALWAYS_ON));
+}
+
+static void set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
+{
+	if (cr4 & CR4_RESEVED_BITS) {
+		printk(KERN_DEBUG "set_cr4: #GP, reserved bits\n");
+		inject_gp(vcpu);
+		return;
+	}
+
+	if (is_long_mode()) {
+		if (!(cr4 & CR4_PAE_MASK)) {
+			printk(KERN_DEBUG "set_cr4: #GP, clearing PAE while "
+			       "in long mode\n");
+			inject_gp(vcpu);
+			return;
+		}
+	} else if (is_paging() && !is_pae() && (cr4 & CR4_PAE_MASK)
+		   && pdptrs_have_reserved_bits_set(vcpu, vcpu->cr3)) {
+		printk(KERN_DEBUG "set_cr4: #GP, pdptrs reserved bits\n");
+		inject_gp(vcpu);
+	}
+
+	if (cr4 & CR4_VMXE_MASK) {
+		printk(KERN_DEBUG "set_cr4: #GP, setting VMXE\n");
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
+			printk(KERN_DEBUG "set_cr3: #GP, reserved bits\n");
+			inject_gp(vcpu);
+			return;
+		}
+	} else {
+		if (cr3 & CR3_RESEVED_BITS) {
+			printk(KERN_DEBUG "set_cr3: #GP, reserved bits\n");
+			inject_gp(vcpu);
+			return;
+		}
+		if (is_paging() && is_pae() &&
+		    pdptrs_have_reserved_bits_set(vcpu, cr3)) {
+			printk(KERN_DEBUG "set_cr3: #GP, pdptrs "
+			       "reserved bits\n");
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
+static void set_cr8(struct kvm_vcpu *vcpu, unsigned long cr8)
+{
+	if ( cr8 & CR8_RESEVED_BITS) {
+		printk(KERN_DEBUG "set_cr8: #GP, reserved bits 0x%lx\n", cr8);
+		inject_gp(vcpu);
+		return;
+	}
+	vcpu->cr8 = cr8;
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
+/*
+ * Allocate some memory and give it an address in the guest physical address
+ * space.
+ *
+ * Discontiguous memory is allowed, mostly for framebuffers.
+ */
+static int kvm_dev_ioctl_set_memory_region(struct kvm *kvm,
+					   struct kvm_memory_region *mem)
+{
+	int r;
+	gfn_t base_gfn;
+	unsigned long npages;
+	unsigned long i;
+	struct kvm_memory_slot *memslot;
+	struct kvm_memory_slot old, new;
+	int memory_config_version;
+
+	r = -EINVAL;
+	/* General sanity checks */
+	if (mem->memory_size & (PAGE_SIZE - 1))
+		goto out;
+	if (mem->guest_phys_addr & (PAGE_SIZE - 1))
+		goto out;
+	if (mem->slot >= KVM_MEMORY_SLOTS)
+		goto out;
+	if (mem->guest_phys_addr + mem->memory_size < mem->guest_phys_addr)
+		goto out;
+
+	memslot = &kvm->memslots[mem->slot];
+	base_gfn = mem->guest_phys_addr >> PAGE_SHIFT;
+	npages = mem->memory_size >> PAGE_SHIFT;
+
+	if (!npages)
+		mem->flags &= ~KVM_MEM_LOG_DIRTY_PAGES;
+
+raced:
+	spin_lock(&kvm->lock);
+
+	memory_config_version = kvm->memory_config_version;
+	new = old = *memslot;
+
+	new.base_gfn = base_gfn;
+	new.npages = npages;
+	new.flags = mem->flags;
+
+	/* Disallow changing a memory slot's size. */
+	r = -EINVAL;
+	if (npages && old.npages && npages != old.npages)
+		goto out_unlock;
+
+	/* Check for overlaps */
+	r = -EEXIST;
+	for (i = 0; i < KVM_MEMORY_SLOTS; ++i) {
+		struct kvm_memory_slot *s = &kvm->memslots[i];
+
+		if (s == memslot)
+			continue;
+		if (!((base_gfn + npages <= s->base_gfn) ||
+		      (base_gfn >= s->base_gfn + s->npages)))
+			goto out_unlock;
+	}
+	/*
+	 * Do memory allocations outside lock.  memory_config_version will
+	 * detect any races.
+	 */
+	spin_unlock(&kvm->lock);
+
+	/* Deallocate if slot is being removed */
+	if (!npages)
+		new.phys_mem = 0;
+
+	/* Free page dirty bitmap if unneeded */
+	if (!(new.flags & KVM_MEM_LOG_DIRTY_PAGES))
+		new.dirty_bitmap = 0;
+
+	r = -ENOMEM;
+
+	/* Allocate if a slot is being created */
+	if (npages && !new.phys_mem) {
+		new.phys_mem = vmalloc(npages * sizeof(struct page *));
+
+		if (!new.phys_mem)
+			goto out_free;
+
+		memset(new.phys_mem, 0, npages * sizeof(struct page *));
+		for (i = 0; i < npages; ++i) {
+			new.phys_mem[i] = alloc_page(GFP_HIGHUSER);
+			if (!new.phys_mem[i])
+				goto out_free;
+		}
+	}
+
+	/* Allocate page dirty bitmap if needed */
+	if ((new.flags & KVM_MEM_LOG_DIRTY_PAGES) && !new.dirty_bitmap) {
+		unsigned dirty_bytes = ALIGN(npages, BITS_PER_LONG) / 8;
+
+		new.dirty_bitmap = vmalloc(dirty_bytes);
+		if (!new.dirty_bitmap)
+			goto out_free;
+		memset(new.dirty_bitmap, 0, dirty_bytes);
+	}
+
+	spin_lock(&kvm->lock);
+
+	if (memory_config_version != kvm->memory_config_version) {
+		spin_unlock(&kvm->lock);
+		kvm_free_physmem_slot(&new, &old);
+		goto raced;
+	}
+
+	r = -EAGAIN;
+	if (kvm->busy)
+		goto out_unlock;
+
+	if (mem->slot >= kvm->nmemslots)
+		kvm->nmemslots = mem->slot + 1;
+
+	*memslot = new;
+	++kvm->memory_config_version;
+
+	spin_unlock(&kvm->lock);
+
+	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
+		struct kvm_vcpu *vcpu;
+
+		vcpu = vcpu_load(kvm, i);
+		if (!vcpu)
+			continue;
+		kvm_mmu_reset_context(vcpu);
+		vcpu_put(vcpu);
+	}
+
+	kvm_free_physmem_slot(&old, &new);
+	return 0;
+
+out_unlock:
+	spin_unlock(&kvm->lock);
+out_free:
+	kvm_free_physmem_slot(&new, &old);
+out:
+	return r;
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
+static void skip_emulated_instruction(struct kvm_vcpu *vcpu)
+{
+	unsigned long rip;
+	u32 interruptibility;
+
+	rip = vmcs_readl(GUEST_RIP);
+	rip += vmcs_read32(VM_EXIT_INSTRUCTION_LEN);
+	vmcs_writel(GUEST_RIP, rip);
+
+	/*
+	 * We emulated an instruction, so temporary interrupt blocking
+	 * should be removed, if set.
+	 */
+	interruptibility = vmcs_read32(GUEST_INTERRUPTIBILITY_INFO);
+	if (interruptibility & 3)
+		vmcs_write32(GUEST_INTERRUPTIBILITY_INFO,
+			     interruptibility & ~3);
+}
+
+static u64 mk_cr_64(u64 curr_cr, u32 new_val)
+{
+	return (curr_cr & ~((1ULL << 32) - 1)) | new_val;
+}
+
+void realmode_lgdt(struct kvm_vcpu *vcpu, u16 limit, unsigned long base)
+{
+	vmcs_writel(GUEST_GDTR_BASE, base);
+	vmcs_write32(GUEST_GDTR_LIMIT, limit);
+}
+
+void realmode_lidt(struct kvm_vcpu *vcpu, u16 limit, unsigned long base)
+{
+	vmcs_writel(GUEST_IDTR_BASE, base);
+	vmcs_write32(GUEST_IDTR_LIMIT, limit);
+}
+
+void realmode_lmsw(struct kvm_vcpu *vcpu, unsigned long msw,
+		   unsigned long *rflags)
+{
+	lmsw(vcpu, msw);
+	*rflags = vmcs_readl(GUEST_RFLAGS);
+}
+
+unsigned long realmode_get_cr(struct kvm_vcpu *vcpu, int cr)
+{
+	switch (cr) {
+	case 0:
+		return guest_cr0();
+	case 2:
+		return vcpu->cr2;
+	case 3:
+		return vcpu->cr3;
+	case 4:
+		return guest_cr4();
+	default:
+		vcpu_printf(vcpu, "%s: unexpected cr %u\n", __FUNCTION__, cr);
+		return 0;
+	}
+}
+
+void realmode_set_cr(struct kvm_vcpu *vcpu, int cr, unsigned long val,
+		     unsigned long *rflags)
+{
+	switch (cr) {
+	case 0:
+		set_cr0(vcpu, mk_cr_64(guest_cr0(), val));
+		*rflags = vmcs_readl(GUEST_RFLAGS);
+		break;
+	case 2:
+		vcpu->cr2 = val;
+		break;
+	case 3:
+		set_cr3(vcpu, val);
+		break;
+	case 4:
+		set_cr4(vcpu, mk_cr_64(guest_cr4(), val));
+		break;
+	default:
+		vcpu_printf(vcpu, "%s: unexpected cr %u\n", __FUNCTION__, cr);
+	}
+}
+
+#ifdef __x86_64__
+
+static void set_efer(struct kvm_vcpu *vcpu, u64 efer)
+{
+	struct vmx_msr_entry *msr;
+
+	if (efer & EFER_RESERVED_BITS) {
+		printk(KERN_DEBUG "set_efer: 0x%llx #GP, reserved bits\n",
+		       efer);
+		inject_gp(vcpu);
+		return;
+	}
+
+	if (is_paging() && (vcpu->shadow_efer & EFER_LME) != (efer & EFER_LME)) {
+		printk(KERN_DEBUG "set_efer: #GP, change LME while paging\n");
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
+#endif
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
+	struct kvm_stats_debugfs_item *p;
+
+	debugfs_dir = debugfs_create_dir("kvm", 0);
+	for (p = debugfs_entries; p->name; ++p)
+		p->dentry = debugfs_create_u32(p->name, 0444, debugfs_dir,
+					       p->data);
+}
+
+static void kvm_exit_debug(void)
+{
+	struct kvm_stats_debugfs_item *p;
+
+	for (p = debugfs_entries; p->name; ++p)
+		debugfs_remove(p->dentry);
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
