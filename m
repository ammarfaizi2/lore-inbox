Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWJWNa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWJWNa5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 09:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWJWNav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 09:30:51 -0400
Received: from il.qumranet.com ([62.219.232.206]:26581 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S964849AbWJWNaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 09:30:18 -0400
Subject: [PATCH 4/13] KVM: random accessors and constants
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 23 Oct 2006 13:30:16 -0000
To: avi@qumranet.com, linux-kernel@vger.kernel.org
References: <453CC390.9080508@qumranet.com>
In-Reply-To: <453CC390.9080508@qumranet.com>
Message-Id: <20061023133016.6B26B250143@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define some constants and accessors to be used later on.

Signed-off-by: Yaniv Kamay <yaniv@qumranet.com>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -7,6 +7,38 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 
+#include "vmx.h"
+
+#define CR0_PE_MASK (1ULL << 0)
+#define CR0_TS_MASK (1ULL << 3)
+#define CR0_NE_MASK (1ULL << 5)
+#define CR0_WP_MASK (1ULL << 16)
+#define CR0_NW_MASK (1ULL << 29)
+#define CR0_CD_MASK (1ULL << 30)
+#define CR0_PG_MASK (1ULL << 31)
+
+#define CR3_WPT_MASK (1ULL << 3)
+#define CR3_PCD_MASK (1ULL << 4)
+
+#define CR3_RESEVED_BITS 0x07ULL
+#define CR3_L_MODE_RESEVED_BITS (~((1ULL << 40) - 1) | 0x0fe7ULL)
+#define CR3_FLAGS_MASK ((1ULL << 5) - 1)
+
+#define CR4_VME_MASK (1ULL << 0)
+#define CR4_PSE_MASK (1ULL << 4)
+#define CR4_PAE_MASK (1ULL << 5)
+#define CR4_PGE_MASK (1ULL << 7)
+#define CR4_VMXE_MASK (1ULL << 13)
+
+#define KVM_GUEST_CR0_MASK \
+	(CR0_PG_MASK | CR0_PE_MASK | CR0_WP_MASK | CR0_NE_MASK)
+#define KVM_VM_CR0_ALWAYS_ON KVM_GUEST_CR0_MASK
+
+#define KVM_GUEST_CR4_MASK \
+	(CR4_PSE_MASK | CR4_PAE_MASK | CR4_PGE_MASK | CR4_VMXE_MASK | CR4_VME_MASK)
+#define KVM_PMODE_VM_CR4_ALWAYS_ON (CR4_VMXE_MASK | CR4_PAE_MASK)
+#define KVM_RMODE_VM_CR4_ALWAYS_ON (CR4_VMXE_MASK | CR4_PAE_MASK | CR4_VME_MASK)
+
 #define INVALID_PAGE (~(hpa_t)0)
 #define UNMAPPED_GVA (~(gpa_t)0)
 
@@ -18,6 +50,19 @@
 #define FX_IMAGE_ALIGN 16
 #define FX_BUF_SIZE (2 * FX_IMAGE_SIZE + FX_IMAGE_ALIGN)
 
+#define DE_VECTOR 0
+#define DF_VECTOR 8
+#define TS_VECTOR 10
+#define NP_VECTOR 11
+#define SS_VECTOR 12
+#define GP_VECTOR 13
+#define PF_VECTOR 14
+
+#define SELECTOR_TI_MASK (1 << 2)
+#define SELECTOR_RPL_MASK 0x03
+
+#define IOPL_SHIFT 12
+
 /*
  * Address types:
  *
@@ -203,4 +248,125 @@ hpa_t gva_to_hpa(struct kvm_vcpu *vcpu, 
 
 extern hpa_t bad_page_address;
 
+static inline struct page *gfn_to_page(struct kvm_memory_slot *slot, gfn_t gfn)
+{
+	return slot->phys_mem[gfn - slot->base_gfn];
+}
+
+struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn);
+void mark_page_dirty(struct kvm *kvm, gfn_t gfn);
+
+void realmode_lgdt(struct kvm_vcpu *vcpu, u16 size, unsigned long address);
+void realmode_lidt(struct kvm_vcpu *vcpu, u16 size, unsigned long address);
+void realmode_lmsw(struct kvm_vcpu *vcpu, unsigned long msw,
+		   unsigned long *rflags);
+
+unsigned long realmode_get_cr(struct kvm_vcpu *vcpu, int cr);
+void realmode_set_cr(struct kvm_vcpu *vcpu, int cr, unsigned long value,
+		     unsigned long *rflags);
+
+int kvm_read_guest(struct kvm_vcpu *vcpu,
+	       gva_t addr,
+	       unsigned long size,
+	       void *dest);
+
+int kvm_write_guest(struct kvm_vcpu *vcpu,
+		gva_t addr,
+		unsigned long size,
+		void *data);
+
+void vmcs_writel(unsigned long field, unsigned long value);
+unsigned long vmcs_readl(unsigned long field);
+
+static inline u16 vmcs_read16(unsigned long field)
+{
+	return vmcs_readl(field);
+}
+
+static inline u32 vmcs_read32(unsigned long field)
+{
+	return vmcs_readl(field);
+}
+
+static inline u64 vmcs_read64(unsigned long field)
+{
+#ifdef __x86_64__
+	return vmcs_readl(field);
+#else
+	return vmcs_readl(field) | ((u64)vmcs_readl(field+1) << 32);
+#endif
+}
+
+static inline void vmcs_write32(unsigned long field, u32 value)
+{
+	vmcs_writel(field, value);
+}
+
+static inline int is_long_mode(void)
+{
+	return vmcs_read32(VM_ENTRY_CONTROLS) & VM_ENTRY_CONTROLS_IA32E_MASK;
+}
+
+static inline unsigned long guest_cr4(void)
+{
+	return (vmcs_readl(CR4_READ_SHADOW) & KVM_GUEST_CR4_MASK) |
+		(vmcs_readl(GUEST_CR4) & ~KVM_GUEST_CR4_MASK);
+}
+
+static inline int is_pae(void)
+{
+	return guest_cr4() & CR4_PAE_MASK;
+}
+
+static inline int is_pse(void)
+{
+	return guest_cr4() & CR4_PSE_MASK;
+}
+
+static inline unsigned long guest_cr0(void)
+{
+	return (vmcs_readl(CR0_READ_SHADOW) & KVM_GUEST_CR0_MASK) |
+		(vmcs_readl(GUEST_CR0) & ~KVM_GUEST_CR0_MASK);
+}
+
+static inline unsigned guest_cpl(void)
+{
+	return vmcs_read16(GUEST_CS_SELECTOR) & SELECTOR_RPL_MASK;
+}
+
+static inline int is_paging(void)
+{
+	return guest_cr0() & CR0_PG_MASK;
+}
+
+static inline int is_page_fault(u32 intr_info)
+{
+	return (intr_info & (INTR_INFO_INTR_TYPE_MASK | INTR_INFO_VECTOR_MASK |
+			     INTR_INFO_VALID_MASK)) ==
+		(INTR_TYPE_EXCEPTION | PF_VECTOR | INTR_INFO_VALID_MASK);
+}
+
+static inline int is_external_interrupt(u32 intr_info)
+{
+	return (intr_info & (INTR_INFO_INTR_TYPE_MASK | INTR_INFO_VALID_MASK))
+		== (INTR_TYPE_EXT_INTR | INTR_INFO_VALID_MASK);
+}
+
+static inline void flush_guest_tlb(struct kvm_vcpu *vcpu)
+{
+	vmcs_writel(GUEST_CR3, vmcs_readl(GUEST_CR3));
+}
+
+static inline int memslot_id(struct kvm *kvm, struct kvm_memory_slot *slot)
+{
+	return slot - kvm->memslots;
+}
+
+static inline struct kvm_mmu_page *page_header(hpa_t shadow_page)
+{
+	struct page *page = pfn_to_page(shadow_page >> PAGE_SHIFT);
+
+	return (struct kvm_mmu_page *)page->private;
+}
+
 #endif
