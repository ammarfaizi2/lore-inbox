Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161418AbWJSNyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161418AbWJSNyL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 09:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161426AbWJSNyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 09:54:11 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:36009 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1161418AbWJSNyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 09:54:07 -0400
Message-ID: <45378377.9080604@qumranet.com>
Date: Thu, 19 Oct 2006 15:53:59 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/7] KVM: mmu virtualization
References: <4537818D.4060204@qumranet.com>
In-Reply-To: <4537818D.4060204@qumranet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Oct 2006 13:54:05.0759 (UTC) FILETIME=[0AB74CF0:01C6F386]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the shadow page table code.

This is a fairly naive implementation that uses the tlb management
instructions
to keep the shadow page tables in sync with the guest page tables:

- invlpg: remove the shadow pte for the given virtual address
- tlb flush: remove all shadow ptes for non-global pages

The relative simplicity of the approach comes at a price: every guest
address
space switch needs to rebuild the shadow page tables for the new address
space.

Other noteworthy items:

- the dirty bit is emulated by mapping non-dirty, writable pages as
read-only.
  the first write will set the dirty bit and remap the page as writable
- we support both 32-bit and 64-bit guest ptes
- the host ptes are always 64-bit, even on non-pae i386 hosts

Signed-off-by: Yaniv Kamay <yaniv@qumranet.com>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- /dev/null
+++ linux-2.6/drivers/kvm/mmu.c
@@ -0,0 +1,718 @@
+/*
+ * Kernel-based Virtual Machine driver for Linux
+ *
+ * This module enables machines with Intel VT-x extensions to run virtual
+ * machines without emulation or binary translation.
+ *
+ * MMU support
+ *
+ * Copyright (C) 2006 Qumranet, Inc.
+ *
+ * Authors:
+ *   Yaniv Kamay  <yaniv@qumranet.com>
+ *   Avi Kivity   <avi@qumranet.com>
+ *
+ */
+#include <linux/types.h>
+#include <linux/string.h>
+#include <asm/page.h>
+#include <linux/mm.h>
+#include <linux/highmem.h>
+#include <linux/module.h>
+
+#include "vmx.h"
+#include "kvm.h"
+
+#define pgprintk(x...) do { } while (0)
+
+#define ASSERT(x)                                   \
+    if (!(x)) {                                  \
+        printk("assertion failed %s:%d: %s\n", __FILE__, __LINE__, #x);\
+    }
+
+#define PT64_ENT_PER_PAGE 512
+#define PT32_ENT_PER_PAGE 1024
+
+#define PT_WRITABLE_SHIFT 1
+
+#define PT_PRESENT_MASK (1ULL << 0)
+#define PT_WRITABLE_MASK (1ULL << PT_WRITABLE_SHIFT)
+#define PT_USER_MASK (1ULL << 2)
+#define PT_PWT_MASK (1ULL << 3)
+#define PT_PCD_MASK (1ULL << 4)
+#define PT_ACCESSED_MASK (1ULL << 5)
+#define PT_DIRTY_MASK (1ULL << 6)
+#define PT_PAGE_SIZE_MASK (1ULL << 7)
+#define PT_PAT_MASK (1ULL << 7)
+#define PT_GLOBAL_MASK (1ULL << 8)
+#define PT64_NX_MASK (1ULL << 63)
+
+#define PT_PAT_SHIFT 7
+#define PT_DIR_PAT_SHIFT 12
+#define PT_DIR_PAT_MASK (1ULL << PT_DIR_PAT_SHIFT)
+
+#define PT32_DIR_PSE36_SIZE 4
+#define PT32_DIR_PSE36_SHIFT 13
+#define PT32_DIR_PSE36_MASK (((1ULL << PT32_DIR_PSE36_SIZE) - 1) <<
PT32_DIR_PSE36_SHIFT)
+
+
+#define PT32_PTE_COPY_MASK \
+    (PT_PRESENT_MASK | PT_PWT_MASK | PT_PCD_MASK | \
+    PT_ACCESSED_MASK | PT_DIRTY_MASK | PT_PAT_MASK | \
+    PT_GLOBAL_MASK )
+
+#define PT32_NON_PTE_COPY_MASK \
+    (PT_PRESENT_MASK | PT_PWT_MASK | PT_PCD_MASK | \
+    PT_ACCESSED_MASK | PT_DIRTY_MASK)
+
+
+#define PT64_PTE_COPY_MASK \
+    (PT64_NX_MASK | PT32_PTE_COPY_MASK)
+
+#define PT64_NON_PTE_COPY_MASK \
+    (PT64_NX_MASK | PT32_NON_PTE_COPY_MASK)
+
+
+
+#define PT_FIRST_AVAIL_BITS_SHIFT 9
+#define PT64_SECOND_AVAIL_BITS_SHIFT 52
+
+#define PT_SHADOW_PS_MARK (1ULL << PT_FIRST_AVAIL_BITS_SHIFT)
+#define PT_SHADOW_IO_MARK (1ULL << PT_FIRST_AVAIL_BITS_SHIFT)
+
+#define PT_SHADOW_WRITABLE_SHIFT (PT_FIRST_AVAIL_BITS_SHIFT + 1)
+#define PT_SHADOW_WRITABLE_MASK (1ULL << PT_SHADOW_WRITABLE_SHIFT)
+
+#define PT_SHADOW_USER_SHIFT (PT_SHADOW_WRITABLE_SHIFT + 1)
+#define PT_SHADOW_USER_MASK (1ULL << (PT_SHADOW_USER_SHIFT))
+
+#define PT_SHADOW_BITS_OFFSET (PT_SHADOW_WRITABLE_SHIFT -
PT_WRITABLE_SHIFT)
+
+#define VALID_PAGE(x) ((x) != INVALID_PAGE)
+
+#define PT64_LEVEL_BITS 9
+
+#define PT64_LEVEL_SHIFT(level) \
+        ( PAGE_SHIFT + (level - 1) * PT64_LEVEL_BITS )
+
+#define PT64_LEVEL_MASK(level) \
+        (((1ULL << PT64_LEVEL_BITS) - 1) << PT64_LEVEL_SHIFT(level))
+
+#define PT64_INDEX(address, level)\
+    (((address) >> PT64_LEVEL_SHIFT(level)) & ((1 << PT64_LEVEL_BITS) - 1))
+
+
+#define PT32_LEVEL_BITS 10
+
+#define PT32_LEVEL_SHIFT(level) \
+        ( PAGE_SHIFT + (level - 1) * PT32_LEVEL_BITS )
+
+#define PT32_LEVEL_MASK(level) \
+        (((1ULL << PT32_LEVEL_BITS) - 1) << PT32_LEVEL_SHIFT(level))
+
+#define PT32_INDEX(address, level)\
+    (((address) >> PT32_LEVEL_SHIFT(level)) & ((1 << PT32_LEVEL_BITS) - 1))
+
+
+#define PT64_BASE_ADDR_MASK (((1ULL << 52) - 1) & PAGE_MASK)
+#define PT64_DIR_BASE_ADDR_MASK \
+    (PT64_BASE_ADDR_MASK & ~((1ULL << (PAGE_SHIFT + PT64_LEVEL_BITS)) - 1))
+
+#define PT32_BASE_ADDR_MASK PAGE_MASK
+#define PT32_DIR_BASE_ADDR_MASK \
+    (PAGE_MASK & ~((1ULL << (PAGE_SHIFT + PT32_LEVEL_BITS)) - 1))
+
+
+#define PFERR_PRESENT_MASK (1U << 0)
+#define PFERR_WRITE_MASK (1U << 1)
+#define PFERR_USER_MASK (1U << 2)
+
+#define PT64_ROOT_LEVEL 4
+#define PT32_ROOT_LEVEL 2
+#define PT32E_ROOT_LEVEL 3
+
+#define PT_DIRECTORY_LEVEL 2
+#define PT_PAGE_TABLE_LEVEL 1
+
+static int is_write_protection(void)
+{
+    return guest_cr0() & CR0_WP_MASK;
+}
+
+static int is_cpuid_PSE36(void)
+{
+    return 1;
+}
+
+static int is_present_pte(unsigned long pte)
+{
+    return pte & PT_PRESENT_MASK;
+}
+
+static int is_writeble_pte(unsigned long pte)
+{
+    return pte & PT_WRITABLE_MASK;
+}
+
+static int is_io_pte(unsigned long pte)
+{
+    return pte & PT_SHADOW_IO_MARK;
+}
+
+static void kvm_mmu_free_page(struct kvm_vcpu *vcpu, hpa_t page_hpa)
+{
+    struct kvm_mmu_page *page_head = page_header(page_hpa);
+
+    list_del(&page_head->link);
+    page_head->page_hpa = page_hpa;
+    list_add(&page_head->link, &vcpu->free_pages);
+}
+
+static int is_empty_shadow_page(hpa_t page_hpa)
+{
+    u32 *pos;
+    u32 *end;
+    for (pos = __va(page_hpa), end = pos + PAGE_SIZE / sizeof(u32);
+              pos != end; pos++)
+        if (*pos != 0)
+            return 0;
+    return 1;
+}
+
+static hpa_t kvm_mmu_alloc_page(struct kvm_vcpu *vcpu, u64 *parent_pte)
+{
+    struct kvm_mmu_page *page;
+
+    if (list_empty(&vcpu->free_pages))
+        return INVALID_PAGE;
+
+    page = list_entry(vcpu->free_pages.next, struct kvm_mmu_page, link);
+    list_del(&page->link);
+    list_add(&page->link, &vcpu->kvm->active_mmu_pages);
+    ASSERT(is_empty_shadow_page(page->page_hpa));
+    page->slot_bitmap = 0;
+    page->global = 1;
+    page->parent_pte = parent_pte;
+    return page->page_hpa;
+}
+
+static void page_header_update_slot(struct kvm *kvm, void *pte, gpa_t gpa)
+{
+    int slot = memslot_id(kvm, gfn_to_memslot(kvm, gpa >> PAGE_SHIFT));
+    struct kvm_mmu_page *page_head = page_header(__pa(pte));
+
+    __set_bit(slot, &page_head->slot_bitmap);
+}
+
+hpa_t safe_gpa_to_hpa(struct kvm_vcpu *vcpu, gpa_t gpa)
+{
+    hpa_t hpa = gpa_to_hpa(vcpu, gpa);
+
+    return is_error_hpa(hpa) ? bad_page_address | (gpa & ~PAGE_MASK): hpa;
+}
+
+hpa_t gpa_to_hpa(struct kvm_vcpu *vcpu, gpa_t gpa)
+{
+    struct kvm_memory_slot *slot;
+    struct page *page;
+
+    ASSERT((gpa & HPA_ERR_MASK) == 0);
+    slot = gfn_to_memslot(vcpu->kvm, gpa >> PAGE_SHIFT);
+    if (!slot)
+        return gpa | HPA_ERR_MASK;
+    page = gfn_to_page(slot, gpa >> PAGE_SHIFT);
+    return (page_to_pfn(page) << PAGE_SHIFT) | (gpa & (PAGE_SIZE-1));
+}
+
+hpa_t gva_to_hpa(struct kvm_vcpu *vcpu, gva_t gva)
+{
+    gpa_t gpa = vcpu->mmu.gva_to_gpa(vcpu, gva);
+
+    if (gpa == UNMAPPED_GVA)
+        return UNMAPPED_GVA;
+    return gpa_to_hpa(vcpu, gpa);
+}
+
+
+static void release_pt_page_64(struct kvm_vcpu *vcpu, hpa_t page_hpa,
+                   int level)
+{
+    ASSERT(vcpu);
+    ASSERT(VALID_PAGE(page_hpa));
+    ASSERT(level <= PT64_ROOT_LEVEL && level > 0);
+
+    if (level == 1)
+        memset(__va(page_hpa), 0, PAGE_SIZE);
+    else {
+        u64 *pos;
+        u64 *end;
+
+        for (pos = __va(page_hpa), end = pos + PT64_ENT_PER_PAGE;
+             pos != end; pos++) {
+            u64 current_ent = *pos;
+
+            *pos = 0;
+            if (is_present_pte(current_ent))
+                release_pt_page_64(vcpu,
+                          current_ent &
+                          PT64_BASE_ADDR_MASK,
+                          level - 1);
+        }
+    }
+    kvm_mmu_free_page(vcpu, page_hpa);
+}
+
+static void nonpaging_new_cr3(struct kvm_vcpu *vcpu)
+{
+}
+
+static int nonpaging_map(struct kvm_vcpu *vcpu, gva_t v, hpa_t p)
+{
+    int level = PT32E_ROOT_LEVEL;
+    hpa_t table_addr = vcpu->mmu.root_hpa;
+
+    for (; ; level--) {
+        u32 index = PT64_INDEX(v, level);
+        u64 *table;
+
+        ASSERT(VALID_PAGE(table_addr));
+        table = __va(table_addr);
+
+        if (level == 1) {
+            mark_page_dirty(vcpu->kvm, v >> PAGE_SHIFT);
+            page_header_update_slot(vcpu->kvm, table, v);
+            table[index] = p | PT_PRESENT_MASK | PT_WRITABLE_MASK |
+                                PT_USER_MASK;
+            return 0;
+        }
+
+        if (table[index] == 0) {
+            hpa_t new_table = kvm_mmu_alloc_page(vcpu,
+                                 &table[index]);
+
+            if (!VALID_PAGE(new_table)) {
+                pgprintk("nonpaging_map: ENOMEM\n");
+                return -ENOMEM;
+            }
+
+            if (level == PT32E_ROOT_LEVEL)
+                table[index] = new_table | PT_PRESENT_MASK;
+            else
+                table[index] = new_table | PT_PRESENT_MASK |
+                        PT_WRITABLE_MASK | PT_USER_MASK;
+        }
+        table_addr = table[index] & PT64_BASE_ADDR_MASK;
+    }
+}
+
+static void nonpaging_flush(struct kvm_vcpu *vcpu)
+{
+    hpa_t root = vcpu->mmu.root_hpa;
+
+    ++kvm_stat.tlb_flush;
+    pgprintk("nonpaging_flush\n");
+    ASSERT(VALID_PAGE(root));
+    release_pt_page_64(vcpu, root, vcpu->mmu.shadow_root_level);
+    root = kvm_mmu_alloc_page(vcpu, 0);
+    ASSERT(VALID_PAGE(root));
+    vcpu->mmu.root_hpa = root;
+    if (is_paging())
+        root |= (vcpu->cr3 & (CR3_PCD_MASK | CR3_WPT_MASK));
+    vmcs_writel(GUEST_CR3, root);
+}
+
+static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, gva_t vaddr)
+{
+    return vaddr;
+}
+
+static int nonpaging_page_fault(struct kvm_vcpu *vcpu, gva_t gva,
+                   u32 error_code)
+{
+    int ret;
+    gpa_t addr = gva;
+
+    ASSERT(vcpu);
+    ASSERT(VALID_PAGE(vcpu->mmu.root_hpa));
+
+    for (;;) {
+         hpa_t paddr;
+
+         paddr = gpa_to_hpa(vcpu , addr & PT64_BASE_ADDR_MASK);
+
+         if (is_error_hpa(paddr))
+             return 1;
+
+         ret = nonpaging_map(vcpu, addr & PAGE_MASK, paddr);
+         if (ret) {
+             nonpaging_flush(vcpu);
+             continue;
+         }
+         break;
+    }
+    return ret;
+}
+
+static void nonpaging_inval_page(struct kvm_vcpu *vcpu, gva_t addr)
+{
+}
+
+static void nonpaging_free(struct kvm_vcpu *vcpu)
+{
+    hpa_t root;
+
+    ASSERT(vcpu);
+    root = vcpu->mmu.root_hpa;
+    if (VALID_PAGE(root))
+        release_pt_page_64(vcpu, root, vcpu->mmu.shadow_root_level);
+    vcpu->mmu.root_hpa = INVALID_PAGE;
+}
+
+static int nonpaging_init_context(struct kvm_vcpu *vcpu)
+{
+    struct kvm_mmu *context = &vcpu->mmu;
+
+    context->new_cr3 = nonpaging_new_cr3;
+    context->page_fault = nonpaging_page_fault;
+    context->inval_page = nonpaging_inval_page;
+    context->gva_to_gpa = nonpaging_gva_to_gpa;
+    context->free = nonpaging_free;
+    context->root_level = PT32E_ROOT_LEVEL;
+    context->shadow_root_level = PT32E_ROOT_LEVEL;
+    context->root_hpa = kvm_mmu_alloc_page(vcpu, 0);
+    ASSERT(VALID_PAGE(context->root_hpa));
+    vmcs_writel(GUEST_CR3, context->root_hpa);
+    return 0;
+}
+
+
+static void kvm_mmu_flush_tlb(struct kvm_vcpu *vcpu)
+{
+    struct kvm_mmu_page *page, *npage;
+
+    list_for_each_entry_safe(page, npage, &vcpu->kvm->active_mmu_pages,
+                 link) {
+        if (page->global)
+            continue;
+
+        if (!page->parent_pte)
+            continue;
+
+        *page->parent_pte = 0;
+        release_pt_page_64(vcpu, page->page_hpa, 1);
+    }
+    ++kvm_stat.tlb_flush;
+}
+
+static void paging_new_cr3(struct kvm_vcpu *vcpu)
+{
+    kvm_mmu_flush_tlb(vcpu);
+}
+
+static void mark_pagetable_nonglobal(void *shadow_pte)
+{
+    page_header(__pa(shadow_pte))->global = 0;
+}
+
+static inline void set_pte_common(struct kvm_vcpu *vcpu,
+                 u64 *shadow_pte,
+                 gpa_t gaddr,
+                 int dirty,
+                 u64 access_bits)
+{
+    hpa_t paddr;
+
+    *shadow_pte |= access_bits << PT_SHADOW_BITS_OFFSET;
+    if (!dirty)
+        access_bits &= ~PT_WRITABLE_MASK;
+
+    if (access_bits & PT_WRITABLE_MASK)
+        mark_page_dirty(vcpu->kvm, gaddr >> PAGE_SHIFT);
+
+    *shadow_pte |= access_bits;
+
+    paddr = gpa_to_hpa(vcpu, gaddr & PT64_BASE_ADDR_MASK);
+
+    if (!(*shadow_pte & PT_GLOBAL_MASK))
+        mark_pagetable_nonglobal(shadow_pte);
+
+    if (is_error_hpa(paddr)) {
+        *shadow_pte |= gaddr;
+        *shadow_pte |= PT_SHADOW_IO_MARK;
+        *shadow_pte &= ~PT_PRESENT_MASK;
+    } else {
+        *shadow_pte |= paddr;
+        page_header_update_slot(vcpu->kvm, shadow_pte, gaddr);
+    }
+}
+
+static void inject_page_fault(struct kvm_vcpu *vcpu,
+                  u64 addr,
+                  u32 err_code)
+{
+    u32 vect_info = vmcs_read32(IDT_VECTORING_INFO_FIELD);
+
+    pgprintk("inject_page_fault: 0x%llx err 0x%x\n", addr, err_code);
+
+    ++kvm_stat.pf_guest;
+
+    if (is_page_fault(vect_info)) {
+        printk("inject_page_fault: double fault 0x%llx @ 0x%lx\n",
+               addr, vmcs_readl(GUEST_RIP));
+        vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE, 0);
+        vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
+                 DF_VECTOR |
+                 INTR_TYPE_EXCEPTION |
+                 INTR_INFO_DELIEVER_CODE_MASK |
+                 INTR_INFO_VALID_MASK);
+        return;
+    }
+    vcpu->cr2 = addr;
+    vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE, err_code);
+    vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
+             PF_VECTOR |
+             INTR_TYPE_EXCEPTION |
+             INTR_INFO_DELIEVER_CODE_MASK |
+             INTR_INFO_VALID_MASK);
+
+}
+
+static inline int fix_read_pf(u64 *shadow_ent)
+{
+    if ((*shadow_ent & PT_SHADOW_USER_MASK) &&
+        !(*shadow_ent & PT_USER_MASK)) {
+        /*
+         * If supervisor write protect is disabled, we shadow kernel
+         * pages as user pages so we can trap the write access.
+         */
+        *shadow_ent |= PT_USER_MASK;
+        *shadow_ent &= ~PT_WRITABLE_MASK;
+
+        return 1;
+
+    }
+    return 0;
+}
+
+static int may_access(u64 pte, int write, int user)
+{
+
+    if (user && !(pte & PT_USER_MASK))
+        return 0;
+    if (write && !(pte & PT_WRITABLE_MASK))
+        return 0;
+    return 1;
+}
+
+/*
+ * Remove a shadow pte.
+ */
+static void paging_inval_page(struct kvm_vcpu *vcpu, gva_t addr)
+{
+    hpa_t page_addr = vcpu->mmu.root_hpa;
+    int level = vcpu->mmu.shadow_root_level;
+
+    ++kvm_stat.invlpg;
+
+    for (; ; level--) {
+        u32 index = PT64_INDEX(addr, level);
+        u64 *table = __va(page_addr);
+
+        if (level == PT_PAGE_TABLE_LEVEL ) {
+            table[index] = 0;
+            return;
+        }
+
+        if (!is_present_pte(table[index]))
+            return;
+
+        page_addr = table[index] & PT64_BASE_ADDR_MASK;
+
+        if (level == PT_DIRECTORY_LEVEL &&
+              (table[index] & PT_SHADOW_PS_MARK)) {
+            table[index] = 0;
+            release_pt_page_64(vcpu, page_addr, PT_PAGE_TABLE_LEVEL);
+
+            //flush tlb
+            vmcs_writel(GUEST_CR3, vcpu->mmu.root_hpa |
+                    (vcpu->cr3 & (CR3_PCD_MASK | CR3_WPT_MASK)));
+            return;
+        }
+    }
+}
+
+static void paging_free(struct kvm_vcpu *vcpu)
+{
+    nonpaging_free(vcpu);
+}
+
+#define PTTYPE 64
+#include "paging_tmpl.h"
+#undef PTTYPE
+
+#define PTTYPE 32
+#include "paging_tmpl.h"
+#undef PTTYPE
+
+static int paging64_init_context(struct kvm_vcpu *vcpu)
+{
+    struct kvm_mmu *context = &vcpu->mmu;
+
+    ASSERT(is_pae());
+    context->new_cr3 = paging_new_cr3;
+    context->page_fault = paging64_page_fault;
+    context->inval_page = paging_inval_page;
+    context->gva_to_gpa = paging64_gva_to_gpa;
+    context->free = paging_free;
+    context->root_level = PT64_ROOT_LEVEL;
+    context->shadow_root_level = PT64_ROOT_LEVEL;
+    context->root_hpa = kvm_mmu_alloc_page(vcpu, 0);
+    ASSERT(VALID_PAGE(context->root_hpa));
+    vmcs_writel(GUEST_CR3, context->root_hpa |
+            (vcpu->cr3 & (CR3_PCD_MASK | CR3_WPT_MASK)));
+    return 0;
+}
+
+static int paging32_init_context(struct kvm_vcpu *vcpu)
+{
+    struct kvm_mmu *context = &vcpu->mmu;
+
+    context->new_cr3 = paging_new_cr3;
+    context->page_fault = paging32_page_fault;
+    context->inval_page = paging_inval_page;
+    context->gva_to_gpa = paging32_gva_to_gpa;
+    context->free = paging_free;
+    context->root_level = PT32_ROOT_LEVEL;
+    context->shadow_root_level = PT32E_ROOT_LEVEL;
+    context->root_hpa = kvm_mmu_alloc_page(vcpu, 0);
+    ASSERT(VALID_PAGE(context->root_hpa));
+    vmcs_writel(GUEST_CR3, context->root_hpa |
+            (vcpu->cr3 & (CR3_PCD_MASK | CR3_WPT_MASK)));
+    return 0;
+}
+
+static int paging32E_init_context(struct kvm_vcpu *vcpu)
+{
+    int ret;
+
+    if ((ret = paging64_init_context(vcpu)))
+        return ret;
+
+    vcpu->mmu.root_level = PT32E_ROOT_LEVEL;
+    vcpu->mmu.shadow_root_level = PT32E_ROOT_LEVEL;
+    return 0;
+}
+
+static int init_kvm_mmu(struct kvm_vcpu *vcpu)
+{
+    ASSERT(vcpu);
+    ASSERT(!VALID_PAGE(vcpu->mmu.root_hpa));
+
+    if (!is_paging())
+        return nonpaging_init_context(vcpu);
+    else if (is_long_mode())
+        return paging64_init_context(vcpu);
+    else if (is_pae())
+        return paging32E_init_context(vcpu);
+    else
+        return paging32_init_context(vcpu);
+}
+
+static void destroy_kvm_mmu(struct kvm_vcpu *vcpu)
+{
+    ASSERT(vcpu);
+    if (VALID_PAGE(vcpu->mmu.root_hpa)) {
+        vcpu->mmu.free(vcpu);
+        vcpu->mmu.root_hpa = INVALID_PAGE;
+    }
+}
+
+int kvm_mmu_reset_context(struct kvm_vcpu *vcpu)
+{
+    destroy_kvm_mmu(vcpu);
+    return init_kvm_mmu(vcpu);
+}
+
+static void free_mmu_pages(struct kvm_vcpu *vcpu)
+{
+    while (!list_empty(&vcpu->free_pages)) {
+        struct kvm_mmu_page *page;
+
+        page = list_entry(vcpu->free_pages.next,
+                  struct kvm_mmu_page, link);
+        list_del(&page->link);
+        __free_page(pfn_to_page(page->page_hpa >> PAGE_SHIFT));
+        page->page_hpa = INVALID_PAGE;
+    }
+}
+
+static int alloc_mmu_pages(struct kvm_vcpu *vcpu)
+{
+    int i;
+
+    ASSERT(vcpu);
+
+    for (i = 0; i < KVM_NUM_MMU_PAGES; i++) {
+        struct page *page;
+        struct kvm_mmu_page *page_header = &vcpu->page_header_buf[i];
+
+        INIT_LIST_HEAD(&page_header->link);
+        if ((page = alloc_page(GFP_KVM_MMU)) == NULL)
+            goto error_1;
+        page->private = (unsigned long)page_header;
+        page_header->page_hpa = page_to_pfn(page) << PAGE_SHIFT;
+        memset(__va(page_header->page_hpa), 0, PAGE_SIZE);
+        list_add(&page_header->link, &vcpu->free_pages);
+    }
+    return 0;
+
+error_1:
+    free_mmu_pages(vcpu);
+    return -ENOMEM;
+}
+
+int kvm_mmu_init(struct kvm_vcpu *vcpu)
+{
+    int r;
+
+    ASSERT(vcpu);
+    ASSERT(!VALID_PAGE(vcpu->mmu.root_hpa));
+    ASSERT(list_empty(&vcpu->free_pages));
+
+    if ((r = alloc_mmu_pages(vcpu)))
+        return r;
+
+    if ((r = init_kvm_mmu(vcpu))) {
+        free_mmu_pages(vcpu);
+        return r;
+    }
+    return 0;
+}
+
+void kvm_mmu_destroy(struct kvm_vcpu *vcpu)
+{
+    ASSERT(vcpu);
+
+    destroy_kvm_mmu(vcpu);
+    free_mmu_pages(vcpu);
+}
+
+void kvm_mmu_slot_remove_write_access(struct kvm *kvm, int slot)
+{
+    struct kvm_mmu_page *page;
+
+    list_for_each_entry(page, &kvm->active_mmu_pages, link) {
+        int i;
+        u64 *pt;
+
+        if (!test_bit(slot, &page->slot_bitmap))
+            continue;
+
+        pt = __va(page->page_hpa);
+        for (i = 0; i < PT64_ENT_PER_PAGE; ++i)
+            /* avoid RMW */
+            if (pt[i] & PT_WRITABLE_MASK)
+                pt[i] &= ~PT_WRITABLE_MASK;
+
+    }
+}
Index: linux-2.6/drivers/kvm/paging_tmpl.h
===================================================================
--- /dev/null
+++ linux-2.6/drivers/kvm/paging_tmpl.h
@@ -0,0 +1,378 @@
+/*
+ * We need the mmu code to access both 32-bit and 64-bit guest ptes,
+ * so the code in this file is compiled twice, once per pte size.
+ */
+
+#if PTTYPE == 64
+    #define pt_element_t u64
+    #define guest_walker guest_walker64
+    #define FNAME(name) paging##64_##name
+    #define PT_BASE_ADDR_MASK PT64_BASE_ADDR_MASK
+    #define PT_DIR_BASE_ADDR_MASK PT64_DIR_BASE_ADDR_MASK
+    #define PT_INDEX(addr, level) PT64_INDEX(addr, level)
+    #define SHADOW_PT_INDEX(addr, level) PT64_INDEX(addr, level)
+    #define PT_LEVEL_MASK(level) PT64_LEVEL_MASK(level)
+    #define PT_PTE_COPY_MASK PT64_PTE_COPY_MASK
+    #define PT_NON_PTE_COPY_MASK PT64_NON_PTE_COPY_MASK
+#elif PTTYPE == 32
+    #define pt_element_t u32
+    #define guest_walker guest_walker32
+    #define FNAME(name) paging##32_##name
+    #define PT_BASE_ADDR_MASK PT32_BASE_ADDR_MASK
+    #define PT_DIR_BASE_ADDR_MASK PT32_DIR_BASE_ADDR_MASK
+    #define PT_INDEX(addr, level) PT32_INDEX(addr, level)
+    #define SHADOW_PT_INDEX(addr, level) PT64_INDEX(addr, level)
+    #define PT_LEVEL_MASK(level) PT32_LEVEL_MASK(level)
+    #define PT_PTE_COPY_MASK PT32_PTE_COPY_MASK
+    #define PT_NON_PTE_COPY_MASK PT32_NON_PTE_COPY_MASK
+#else
+    error
+#endif
+
+/*
+ * The guest_walker structure emulates the behavior of the hardware page
+ * table walker.
+ */
+struct guest_walker {
+    int level;
+    pt_element_t *table;
+    pt_element_t inherited_ar;
+};
+
+static void FNAME(init_walker)(struct guest_walker *walker,
+                   struct kvm_vcpu *vcpu)
+{
+    hpa_t hpa;
+    struct kvm_memory_slot *slot;
+
+    walker->level = vcpu->mmu.root_level;
+    slot = gfn_to_memslot(vcpu->kvm,
+                  (vcpu->cr3 & PT64_BASE_ADDR_MASK) >> PAGE_SHIFT);
+    hpa = safe_gpa_to_hpa(vcpu, vcpu->cr3 & PT64_BASE_ADDR_MASK);
+    walker->table = kmap_atomic(pfn_to_page(hpa >> PAGE_SHIFT), KM_USER0);
+
+    ASSERT((!is_long_mode() && is_pae()) ||
+           (vcpu->cr3 & ~(PAGE_MASK | CR3_FLAGS_MASK)) == 0);
+
+    walker->table = (pt_element_t *)( (unsigned long)walker->table |
+        (unsigned long)(vcpu->cr3 & ~(PAGE_MASK | CR3_FLAGS_MASK)) );
+    walker->inherited_ar = PT_USER_MASK | PT_WRITABLE_MASK;
+}
+
+static void FNAME(release_walker)(struct guest_walker *walker)
+{
+    kunmap_atomic(walker->table, KM_USER0);
+}
+
+static void FNAME(set_pte)(struct kvm_vcpu *vcpu, u64 guest_pte,
+               u64 *shadow_pte, u64 access_bits)
+{
+    ASSERT(*shadow_pte == 0);
+    access_bits &= guest_pte;
+    *shadow_pte = (guest_pte & PT_PTE_COPY_MASK);
+    set_pte_common(vcpu, shadow_pte, guest_pte & PT_BASE_ADDR_MASK,
+               guest_pte & PT_DIRTY_MASK, access_bits);
+}
+
+static void FNAME(set_pde)(struct kvm_vcpu *vcpu, u64 guest_pde,
+               u64 *shadow_pte, u64 access_bits,
+               int index)
+{
+    gpa_t gaddr;
+
+    ASSERT(*shadow_pte == 0);
+    access_bits &= guest_pde;
+    gaddr = (guest_pde & PT_DIR_BASE_ADDR_MASK) + PAGE_SIZE * index;
+    if (PTTYPE == 32 && is_cpuid_PSE36())
+        gaddr |= (guest_pde & PT32_DIR_PSE36_MASK) <<
+            (32 - PT32_DIR_PSE36_SHIFT);
+    *shadow_pte = (guest_pde & PT_NON_PTE_COPY_MASK) |
+                  ((guest_pde & PT_DIR_PAT_MASK) >>
+                        (PT_DIR_PAT_SHIFT - PT_PAT_SHIFT));
+    set_pte_common(vcpu, shadow_pte, gaddr,
+               guest_pde & PT_DIRTY_MASK, access_bits);
+}
+
+/*
+ * Fetch a guest pte from a specific level in the paging hierarchy.
+ */
+static pt_element_t *FNAME(fetch_guest)(struct kvm_vcpu *vcpu,
+                    struct guest_walker *walker,
+                    int level,
+                    gva_t addr)
+{
+
+    ASSERT(level > 0  && level <= walker->level);
+
+    for (;;) {
+        int index = PT_INDEX(addr, walker->level);
+        hpa_t paddr;
+
+        ASSERT(((unsigned long)walker->table & PAGE_MASK) ==
+               ((unsigned long)&walker->table[index] & PAGE_MASK));
+        if (level == walker->level ||
+            !is_present_pte(walker->table[index]) ||
+            (walker->level == PT_DIRECTORY_LEVEL &&
+             (walker->table[index] & PT_PAGE_SIZE_MASK) &&
+             (PTTYPE == 64 || is_pse())))
+            return &walker->table[index];
+        if (walker->level != 3 || is_long_mode())
+            walker->inherited_ar &= walker->table[index];
+        paddr = safe_gpa_to_hpa(vcpu, walker->table[index] &
PT_BASE_ADDR_MASK);
+        kunmap_atomic(walker->table, KM_USER0);
+        walker->table = kmap_atomic(pfn_to_page(paddr >> PAGE_SHIFT),
+                        KM_USER0);
+        --walker->level;
+    }
+}
+
+/*
+ * Fetch a shadow pte for a specific level in the paging hierarchy.
+ */
+static u64 *FNAME(fetch)(struct kvm_vcpu *vcpu, gva_t addr,
+                  struct guest_walker *walker)
+{
+    hpa_t shadow_addr;
+    int level;
+    u64 *prev_shadow_ent = NULL;
+
+    shadow_addr = vcpu->mmu.root_hpa;
+    level = vcpu->mmu.shadow_root_level;
+
+    for (; ; level--) {
+        u32 index = SHADOW_PT_INDEX(addr, level);
+        u64 *shadow_ent = ((u64 *)__va(shadow_addr)) + index;
+        pt_element_t *guest_ent;
+
+        if (is_present_pte(*shadow_ent) || is_io_pte(*shadow_ent)) {
+            if (level == PT_PAGE_TABLE_LEVEL)
+                return shadow_ent;
+            shadow_addr = *shadow_ent & PT64_BASE_ADDR_MASK;
+            prev_shadow_ent = shadow_ent;
+            continue;
+        }
+
+        if (PTTYPE == 32 && level > PT32_ROOT_LEVEL) {
+            ASSERT(level == PT32E_ROOT_LEVEL);
+            guest_ent = FNAME(fetch_guest)(vcpu, walker,
+                               PT32_ROOT_LEVEL, addr);
+        } else
+            guest_ent = FNAME(fetch_guest)(vcpu, walker,
+                               level, addr);
+
+        if (!is_present_pte(*guest_ent))
+            return NULL;
+
+        /* Don't set accessed bit on PAE PDPTRs */
+        if (vcpu->mmu.root_level != 3 || walker->level != 3)
+            *guest_ent |= PT_ACCESSED_MASK;
+
+        if (level == PT_PAGE_TABLE_LEVEL) {
+
+            if (walker->level == PT_DIRECTORY_LEVEL) {
+                if (prev_shadow_ent)
+                    *prev_shadow_ent |= PT_SHADOW_PS_MARK;
+                FNAME(set_pde)(vcpu, *guest_ent, shadow_ent,
+                           walker->inherited_ar,
+                          PT_INDEX(addr, PT_PAGE_TABLE_LEVEL));
+            } else {
+                ASSERT(walker->level == PT_PAGE_TABLE_LEVEL);
+                FNAME(set_pte)(vcpu, *guest_ent, shadow_ent,
walker->inherited_ar);
+            }
+            return shadow_ent;
+        }
+
+        shadow_addr = kvm_mmu_alloc_page(vcpu, shadow_ent);
+        if (!VALID_PAGE(shadow_addr))
+            return ERR_PTR(-ENOMEM);
+        if (!is_long_mode() && level == 3)
+            *shadow_ent = shadow_addr |
+                (*guest_ent & (PT_PRESENT_MASK | PT_PWT_MASK |
PT_PCD_MASK));
+        else {
+            *shadow_ent = shadow_addr |
+                (*guest_ent & PT_NON_PTE_COPY_MASK);
+            *shadow_ent |= (PT_WRITABLE_MASK | PT_USER_MASK);
+        }
+        prev_shadow_ent = shadow_ent;
+    }
+}
+
+/*
+ * The guest faulted for write.  We need to
+ *
+ * - check write permissions
+ * - update the guest pte dirty bit
+ * - update our own dirty page tracking structures
+ */
+static int FNAME(fix_write_pf)(struct kvm_vcpu *vcpu,
+                   u64 *shadow_ent,
+                   struct guest_walker *walker,
+                   gva_t addr,
+                   int user)
+{
+    pt_element_t *guest_ent;
+    int writable_shadow;
+    gfn_t gfn;
+
+    if (is_writeble_pte(*shadow_ent))
+        return 0;
+
+    writable_shadow = *shadow_ent & PT_SHADOW_WRITABLE_MASK;
+    if (user) {
+        /*
+         * User mode access.  Fail if it's a kernel page or a read-only
+         * page.
+         */
+        if (!(*shadow_ent & PT_SHADOW_USER_MASK) || !writable_shadow)
+            return 0;
+        ASSERT(*shadow_ent & PT_USER_MASK);
+    } else
+        /*
+         * Kernel mode access.  Fail if it's a read-only page and
+         * supervisor write protection is enabled.
+         */
+        if (!writable_shadow) {
+            if (is_write_protection())
+                return 0;
+            *shadow_ent &= ~PT_USER_MASK;
+        }
+
+    guest_ent = FNAME(fetch_guest)(vcpu, walker, PT_PAGE_TABLE_LEVEL,
addr);
+
+    if (!is_present_pte(*guest_ent)) {
+        *shadow_ent = 0;
+        return 0;
+    }
+
+    gfn = (*guest_ent & PT64_BASE_ADDR_MASK) >> PAGE_SHIFT;
+    mark_page_dirty(vcpu->kvm, gfn);
+    *shadow_ent |= PT_WRITABLE_MASK;
+    *guest_ent |= PT_DIRTY_MASK;
+
+    return 1;
+}
+
+/*
+ * Page fault handler.  There are several causes for a page fault:
+ *   - there is no shadow pte for the guest pte
+ *   - write access through a shadow pte marked read only so that we
can set
+ *     the dirty bit
+ *   - write access to a shadow pte marked read only so we can update
the page
+ *     dirty bitmap, when userspace requests it
+ *   - mmio access; in this case we will never install a present shadow pte
+ *   - normal guest page fault due to the guest pte marked not present, not
+ *     writable, or not executable
+ *
+ *  Returns: 1 if we need to emulate the instruction, 0 otherwise
+ */
+static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gva_t addr,
+                   u32 error_code)
+{
+    int write_fault = error_code & PFERR_WRITE_MASK;
+    int pte_present = error_code & PFERR_PRESENT_MASK;
+    int user_fault = error_code & PFERR_USER_MASK;
+    struct guest_walker walker;
+    u64 *shadow_pte;
+    int fixed;
+
+    /*
+     * Look up the shadow pte for the faulting address.
+     */
+    for (;;) {
+        FNAME(init_walker)(&walker, vcpu);
+        shadow_pte = FNAME(fetch)(vcpu, addr, &walker);
+        if (IS_ERR(shadow_pte)) {  /* must be -ENOMEM */
+            nonpaging_flush(vcpu);
+            FNAME(release_walker)(&walker);
+            continue;
+        }
+        break;
+    }
+
+    /*
+     * The page is not mapped by the guest.  Let the guest handle it.
+     */
+    if (!shadow_pte) {
+        inject_page_fault(vcpu, addr, error_code);
+        FNAME(release_walker)(&walker);
+        return 0;
+    }
+
+    /*
+     * Update the shadow pte.
+     */
+    if (write_fault)
+        fixed = FNAME(fix_write_pf)(vcpu, shadow_pte, &walker, addr,
+                        user_fault);
+    else
+        fixed = fix_read_pf(shadow_pte);
+
+    FNAME(release_walker)(&walker);
+
+    /*
+     * mmio: emulate if accessible, otherwise its a guest fault.
+     */
+    if (is_io_pte(*shadow_pte)) {
+        if (may_access(*shadow_pte, write_fault, user_fault))
+            return 1;
+        pgprintk("%s: io work, no access\n", __FUNCTION__);
+        inject_page_fault(vcpu, addr,
+                  error_code | PFERR_PRESENT_MASK);
+        return 0;
+    }
+
+    /*
+     * pte not present, guest page fault.
+     */
+    if (pte_present && !fixed) {
+        inject_page_fault(vcpu, addr, error_code);
+        return 0;
+    }
+
+    ++kvm_stat.pf_fixed;
+
+    return 0;
+}
+
+static gpa_t FNAME(gva_to_gpa)(struct kvm_vcpu *vcpu, gva_t vaddr)
+{
+    struct guest_walker walker;
+    pt_element_t guest_pte;
+    gpa_t gpa;
+
+    FNAME(init_walker)(&walker, vcpu);
+    guest_pte = *FNAME(fetch_guest)(vcpu, &walker, PT_PAGE_TABLE_LEVEL,
+                    vaddr);
+    FNAME(release_walker)(&walker);
+
+    if (!is_present_pte(guest_pte))
+        return UNMAPPED_GVA;
+
+    if (walker.level == PT_DIRECTORY_LEVEL) {
+        ASSERT((guest_pte & PT_PAGE_SIZE_MASK));
+        ASSERT(PTTYPE == 64 || is_pse());
+
+        gpa = (guest_pte & PT_DIR_BASE_ADDR_MASK) | (vaddr &
+            (PT_LEVEL_MASK(PT_PAGE_TABLE_LEVEL) | ~PAGE_MASK));
+
+        if (PTTYPE == 32 && is_cpuid_PSE36())
+            gpa |= (guest_pte & PT32_DIR_PSE36_MASK) <<
+                    (32 - PT32_DIR_PSE36_SHIFT);
+    } else {
+        gpa = (guest_pte & PT_BASE_ADDR_MASK);
+        gpa |= (vaddr & ~PAGE_MASK);
+    }
+
+    return gpa;
+}
+
+#undef pt_element_t
+#undef guest_walker
+#undef FNAME
+#undef PT_BASE_ADDR_MASK
+#undef PT_INDEX
+#undef SHADOW_PT_INDEX
+#undef PT_LEVEL_MASK
+#undef PT_PTE_COPY_MASK
+#undef PT_NON_PTE_COPY_MASK
+#undef PT_DIR_BASE_ADDR_MASK
Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -369,4 +369,19 @@ static inline struct kvm_mmu_page *page_
     return (struct kvm_mmu_page *)page->private;
 }
 
+#ifdef __x86_64__
+
+/*
+ * When emulating 32-bit mode, cr3 is only 32 bits even on x86_64. 
Therefore
+ * we need to allocate shadow page tables in the first 4GB of memory, which
+ * happens to fit the DMA32 zone.
+ */
+#define GFP_KVM_MMU (GFP_KERNEL | __GFP_DMA32)
+
+#else
+
+#define GFP_KVM_MMU GFP_KERNEL
+
+#endif
+
 #endif


-- 
error compiling committee.c: too many arguments to function

