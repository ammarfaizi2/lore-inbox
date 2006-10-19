Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161422AbWJSNuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161422AbWJSNuB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 09:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161429AbWJSNuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 09:50:01 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:2460 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1161426AbWJSNt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 09:49:59 -0400
Message-ID: <45378281.2050505@qumranet.com>
Date: Thu, 19 Oct 2006 15:49:53 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/7] KVM: kvm data structures
References: <4537818D.4060204@qumranet.com>
In-Reply-To: <4537818D.4060204@qumranet.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Oct 2006 13:49:58.0473 (UTC) FILETIME=[77527390:01C6F385]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define data structures and some constants for a virtual machine.

Signed-off-by: Yaniv Kamay <yaniv@qumranet.com>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- /dev/null
+++ linux-2.6/drivers/kvm/kvm.h
@@ -0,0 +1,206 @@
+#ifndef __KVM_H
+#define __KVM_H
+
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/mm.h>
+
+#define INVALID_PAGE (~(hpa_t)0)
+#define UNMAPPED_GVA (~(gpa_t)0)
+
+#define KVM_MAX_VCPUS 1
+#define KVM_MEMORY_SLOTS 4
+#define KVM_NUM_MMU_PAGES 256
+
+#define FX_IMAGE_SIZE 512
+#define FX_IMAGE_ALIGN 16
+#define FX_BUF_SIZE (2 * FX_IMAGE_SIZE + FX_IMAGE_ALIGN)
+
+/*
+ * Address types:
+ *
+ *  gva - guest virtual address
+ *  gpa - guest physical address
+ *  gfn - guest frame number
+ *  hva - host virtual address
+ *  hpa - host physical address
+ *  hfn - host frame number
+ */
+
+typedef unsigned long  gva_t;
+typedef u64            gpa_t;
+typedef unsigned long  gfn_t;
+
+typedef unsigned long  hva_t;
+typedef u64            hpa_t;
+typedef unsigned long  hfn_t;
+
+struct kvm_mmu_page {
+    struct list_head link;
+    hpa_t page_hpa;
+    unsigned long slot_bitmap; /* One bit set per slot which has memory
+                    * in this shadow page.
+                    */
+    int global;              /* Set if all ptes in this page are global */
+    u64 *parent_pte;
+};
+
+struct vmcs {
+    u32 revision_id;
+    u32 abort;
+    char data[0];
+};
+
+struct vmx_msr_entry {
+    u32 index;
+    u32 reserved;
+    u64 data;
+};
+
+struct kvm_vcpu;
+
+/*
+ * x86 supports 3 paging modes (4-level 64-bit, 3-level 64-bit, and 2-level
+ * 32-bit).  The kvm_mmu structure abstracts the details of the current mmu
+ * mode.
+ */
+struct kvm_mmu {
+    void (*new_cr3)(struct kvm_vcpu *vcpu);
+    int (*page_fault)(struct kvm_vcpu *vcpu, gva_t gva, u32 err);
+    void (*inval_page)(struct kvm_vcpu *vcpu, gva_t gva);
+    void (*free)(struct kvm_vcpu *vcpu);
+    gpa_t (*gva_to_gpa)(struct kvm_vcpu *vcpu, gva_t gva);
+    hpa_t root_hpa;
+    int root_level;
+    int shadow_root_level;
+};
+
+struct kvm_guest_debug {
+    int enabled;
+    unsigned long bp[4];
+    int singlestep;
+};
+
+enum {
+    VCPU_REGS_RAX = 0,
+    VCPU_REGS_RCX = 1,
+    VCPU_REGS_RDX = 2,
+    VCPU_REGS_RBX = 3,
+    VCPU_REGS_RSP = 4,
+    VCPU_REGS_RBP = 5,
+    VCPU_REGS_RSI = 6,
+    VCPU_REGS_RDI = 7,
+#ifdef __x86_64__
+    VCPU_REGS_R8 = 8,
+    VCPU_REGS_R9 = 9,
+    VCPU_REGS_R10 = 10,
+    VCPU_REGS_R11 = 11,
+    VCPU_REGS_R12 = 12,
+    VCPU_REGS_R13 = 13,
+    VCPU_REGS_R14 = 14,
+    VCPU_REGS_R15 = 15,
+#endif
+    NR_VCPU_REGS
+};
+
+struct kvm_vcpu {
+    struct kvm *kvm;
+    struct vmcs *vmcs;
+    struct mutex mutex;
+    int   cpu;
+    int   launched;
+    unsigned long irq_summary; /* bit vector: 1 per word in irq_pending */
+#define NR_IRQ_WORDS (256 / BITS_PER_LONG)
+    unsigned long irq_pending[NR_IRQ_WORDS];
+    unsigned long regs[NR_VCPU_REGS]; /* for rsp: vcpu_load_rsp_rip() */
+    unsigned long rip;      /* needs vcpu_load_rsp_rip() */
+
+    unsigned long cr2;
+    unsigned long cr3;
+    unsigned long cr8;
+    u64 shadow_efer;
+    u64 apic_base;
+    struct vmx_msr_entry *guest_msrs;
+    struct vmx_msr_entry *host_msrs;
+
+    struct list_head free_pages;
+    struct kvm_mmu_page page_header_buf[KVM_NUM_MMU_PAGES];
+    struct kvm_mmu mmu;
+
+    struct kvm_guest_debug guest_debug;
+
+    char fx_buf[FX_BUF_SIZE];
+    char *host_fx_image;
+    char *guest_fx_image;
+
+    int mmio_needed;
+    int mmio_read_completed;
+    int mmio_is_write;
+    int mmio_size;
+    unsigned char mmio_data[8];
+    gpa_t mmio_phys_addr;
+
+    struct{
+        int active;
+        u8 save_iopl;
+        struct {
+            unsigned long base;
+            u32 limit;
+            u32 ar;
+        } tr;
+    } rmode;
+};
+
+struct kvm_memory_slot {
+    gfn_t base_gfn;
+    unsigned long npages;
+    unsigned long flags;
+    struct page **phys_mem;
+    unsigned long *dirty_bitmap;
+};
+
+struct kvm {
+    spinlock_t lock; /* protects everything except vcpus */
+    int nmemslots;
+    struct kvm_memory_slot memslots[KVM_MEMORY_SLOTS];
+    struct list_head active_mmu_pages;
+    struct kvm_vcpu vcpus[KVM_MAX_VCPUS];
+    int memory_config_version;
+    int busy;
+};
+
+struct kvm_stat {
+    u32 pf_fixed;
+    u32 pf_guest;
+    u32 tlb_flush;
+    u32 invlpg;
+
+    u32 exits;
+    u32 io_exits;
+    u32 mmio_exits;
+    u32 signal_exits;
+    u32 irq_exits;
+};
+
+extern struct kvm_stat kvm_stat;
+
+#define kvm_printf(kvm, fmt ...) printk(KERN_DEBUG fmt)
+#define vcpu_printf(vcpu, fmt...) kvm_printf(vcpu->kvm, fmt)
+
+void kvm_mmu_destroy(struct kvm_vcpu *vcpu);
+int kvm_mmu_init(struct kvm_vcpu *vcpu);
+
+int kvm_mmu_reset_context(struct kvm_vcpu *vcpu);
+void kvm_mmu_slot_remove_write_access(struct kvm *kvm, int slot);
+
+hpa_t gpa_to_hpa(struct kvm_vcpu *vcpu, gpa_t gpa);
+#define HPA_MSB ((sizeof(hpa_t) * 8) - 1)
+#define HPA_ERR_MASK ((hpa_t)1 << HPA_MSB)
+static inline int is_error_hpa(hpa_t hpa) { return hpa >> HPA_MSB; }
+hpa_t gva_to_hpa(struct kvm_vcpu *vcpu, gva_t gva);
+
+extern hpa_t bad_page_address;
+
+#endif

-- 
error compiling committee.c: too many arguments to function

