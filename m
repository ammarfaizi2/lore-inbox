Return-Path: <linux-kernel-owner+w=401wt.eu-S937471AbWLKSlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937471AbWLKSlE (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937480AbWLKSk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:40:58 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3926 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1763016AbWLKSkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:40:41 -0500
Date: Mon, 11 Dec 2006 19:40:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Avi Kivity <avi@qumranet.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/kvm/: possible cleanups
Message-ID: <20061211184051.GC28443@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- proper prototype for kvm_main.c:find_msr_entry()
- #if 0 the unused svm.c:inject_db()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/kvm/kvm.h         |    3 ++-
 drivers/kvm/kvm_main.c    |    2 +-
 drivers/kvm/mmu.c         |   16 ++++++++--------
 drivers/kvm/svm.c         |    6 ++++--
 drivers/kvm/vmx.c         |    3 ---
 drivers/kvm/x86_emulate.c |    9 +++++++--
 drivers/kvm/x86_emulate.h |    8 --------

--- linux-2.6.19-mm1/drivers/kvm/kvm.h.old	2006-12-11 17:51:45.000000000 +0100
+++ linux-2.6.19-mm1/drivers/kvm/kvm.h	2006-12-11 18:05:09.000000000 +0100
@@ -325,7 +325,6 @@
 int kvm_mmu_reset_context(struct kvm_vcpu *vcpu);
 void kvm_mmu_slot_remove_write_access(struct kvm *kvm, int slot);
 
-hpa_t gpa_to_hpa(struct kvm_vcpu *vcpu, gpa_t gpa);
 #define HPA_MSB ((sizeof(hpa_t) * 8) - 1)
 #define HPA_ERR_MASK ((hpa_t)1 << HPA_MSB)
 static inline int is_error_hpa(hpa_t hpa) { return hpa >> HPA_MSB; }
@@ -397,6 +396,8 @@
 
 unsigned long segment_base(u16 selector);
 
+struct vmx_msr_entry *find_msr_entry(struct kvm_vcpu *vcpu, u32 msr);
+
 static inline struct page *_gfn_to_page(struct kvm *kvm, gfn_t gfn)
 {
 	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
--- linux-2.6.19-mm1/drivers/kvm/kvm_main.c.old	2006-12-11 17:51:15.000000000 +0100
+++ linux-2.6.19-mm1/drivers/kvm/kvm_main.c	2006-12-11 17:51:23.000000000 +0100
@@ -973,7 +973,7 @@
 	reported = 1;
 }
 
-struct x86_emulate_ops emulate_ops = {
+static struct x86_emulate_ops emulate_ops = {
 	.read_std            = emulator_read_std,
 	.write_std           = emulator_write_std,
 	.read_emulated       = emulator_read_emulated,
--- linux-2.6.19-mm1/drivers/kvm/mmu.c.old	2006-12-11 17:51:57.000000000 +0100
+++ linux-2.6.19-mm1/drivers/kvm/mmu.c	2006-12-11 17:54:21.000000000 +0100
@@ -208,14 +208,7 @@
 	__set_bit(slot, &page_head->slot_bitmap);
 }
 
-hpa_t safe_gpa_to_hpa(struct kvm_vcpu *vcpu, gpa_t gpa)
-{
-	hpa_t hpa = gpa_to_hpa(vcpu, gpa);
-
-	return is_error_hpa(hpa) ? bad_page_address | (gpa & ~PAGE_MASK): hpa;
-}
-
-hpa_t gpa_to_hpa(struct kvm_vcpu *vcpu, gpa_t gpa)
+static hpa_t gpa_to_hpa(struct kvm_vcpu *vcpu, gpa_t gpa)
 {
 	struct kvm_memory_slot *slot;
 	struct page *page;
@@ -229,6 +222,13 @@
 		| (gpa & (PAGE_SIZE-1));
 }
 
+static hpa_t safe_gpa_to_hpa(struct kvm_vcpu *vcpu, gpa_t gpa)
+{
+	hpa_t hpa = gpa_to_hpa(vcpu, gpa);
+
+	return is_error_hpa(hpa) ? bad_page_address | (gpa & ~PAGE_MASK): hpa;
+}
+
 hpa_t gva_to_hpa(struct kvm_vcpu *vcpu, gva_t gva)
 {
 	gpa_t gpa = vcpu->mmu.gva_to_gpa(vcpu, gva);
--- linux-2.6.19-mm1/drivers/kvm/svm.c.old	2006-12-11 17:55:01.000000000 +0100
+++ linux-2.6.19-mm1/drivers/kvm/svm.c	2006-12-11 18:06:26.000000000 +0100
@@ -42,8 +42,8 @@
 #define KVM_EFER_LMA (1 << 10)
 #define KVM_EFER_LME (1 << 8)
 
-unsigned long iopm_base;
-unsigned long msrpm_base;
+static unsigned long iopm_base;
+static unsigned long msrpm_base;
 
 struct kvm_ldttss_desc {
 	u16 limit0;
@@ -206,12 +206,14 @@
 						UD_VECTOR;
 }
 
+#if 0
 static void inject_db(struct kvm_vcpu *vcpu)
 {
 	vcpu->svm->vmcb->control.event_inj = 	SVM_EVTINJ_VALID |
 						SVM_EVTINJ_TYPE_EXEPT |
 						DB_VECTOR;
 }
+#endif  /*  0  */
 
 static int is_page_fault(uint32_t info)
 {
--- linux-2.6.19-mm1/drivers/kvm/vmx.c.old	2006-12-11 17:56:34.000000000 +0100
+++ linux-2.6.19-mm1/drivers/kvm/vmx.c	2006-12-11 18:05:22.000000000 +0100
@@ -78,8 +78,6 @@
 };
 #define NR_VMX_MSR (sizeof(vmx_msr_index) / sizeof(*vmx_msr_index))
 
-struct vmx_msr_entry *find_msr_entry(struct kvm_vcpu *vcpu, u32 msr);
-
 static inline int is_page_fault(u32 intr_info)
 {
 	return (intr_info & (INTR_INFO_INTR_TYPE_MASK | INTR_INFO_VECTOR_MASK |
@@ -1762,7 +1760,6 @@
 		ASM_VMX_VMLAUNCH "\n\t"
 		"jmp kvm_vmx_return \n\t"
 		"launched: " ASM_VMX_VMRESUME "\n\t"
-		".globl kvm_vmx_return \n\t"
 		"kvm_vmx_return: "
 		/* Save guest registers, load host registers, keep flags */
 #ifdef CONFIG_X86_64
--- linux-2.6.19-mm1/drivers/kvm/x86_emulate.h.old	2006-12-11 17:57:03.000000000 +0100
+++ linux-2.6.19-mm1/drivers/kvm/x86_emulate.h	2006-12-11 17:57:52.000000000 +0100
@@ -174,12 +174,4 @@
 int x86_emulate_memop(struct x86_emulate_ctxt *ctxt,
 		      struct x86_emulate_ops *ops);
 
-/*
- * Given the 'reg' portion of a ModRM byte, and a register block, return a
- * pointer into the block that addresses the relevant register.
- * @highbyte_regs specifies whether to decode AH,CH,DH,BH.
- */
-void *decode_register(u8 modrm_reg, unsigned long *regs,
-		      int highbyte_regs);
-
 #endif				/* __X86_EMULATE_H__ */
--- linux-2.6.19-mm1/drivers/kvm/x86_emulate.c.old	2006-12-11 17:57:27.000000000 +0100
+++ linux-2.6.19-mm1/drivers/kvm/x86_emulate.c	2006-12-11 17:57:44.000000000 +0100
@@ -438,8 +438,13 @@
 			   (((reg) + _inc) & ((1UL << (ad_bytes << 3)) - 1)); \
 	} while (0)
 
-void *decode_register(u8 modrm_reg, unsigned long *regs,
-		      int highbyte_regs)
+/*
+ * Given the 'reg' portion of a ModRM byte, and a register block, return a
+ * pointer into the block that addresses the relevant register.
+ * @highbyte_regs specifies whether to decode AH,CH,DH,BH.
+ */
+static void *decode_register(u8 modrm_reg, unsigned long *regs,
+			     int highbyte_regs)
 {
 	void *p;
 

