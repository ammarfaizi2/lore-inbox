Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758473AbWK1Mkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758473AbWK1Mkw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 07:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758492AbWK1Mkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 07:40:52 -0500
Received: from il.qumranet.com ([62.219.232.206]:47265 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758473AbWK1Mkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 07:40:51 -0500
Subject: [PATCH 2/6] KVM: AMD SVM: Enhance x86 emulator
From: Avi Kivity <avi@qumranet.com>
Date: Tue, 28 Nov 2006 12:40:49 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, yaniv.kamay@qumranet.com,
       mingo@elte.hu
References: <456C2D89.4050508@qumranet.com>
In-Reply-To: <456C2D89.4050508@qumranet.com>
Message-Id: <20061128124049.5142F25017B@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add decoding support for the few instructions AMD SVM does not decode itself,
and corresponding entries in the arch function vector.  They will never
be called on Intel machines.

The invlpg instruction is a special case:  unlike other instructions with
the same main opcode, it may not fetch data from the referenced memory
address (since it's invalidating it).  The emulator can't really handle this,
but fortunately AMD doesn't need any of the other instructions for that
opcode, so we just tell the emulator not to fetch data for any of them.

Signed-off-by: Yaniv Kamay <yaniv@qumranet.com>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -287,11 +287,15 @@ struct kvm_arch_ops {
 	void (*set_idt)(struct kvm_vcpu *vcpu, struct descriptor_table *dt);
 	void (*get_gdt)(struct kvm_vcpu *vcpu, struct descriptor_table *dt);
 	void (*set_gdt)(struct kvm_vcpu *vcpu, struct descriptor_table *dt);
+	unsigned long (*get_dr)(struct kvm_vcpu *vcpu, int dr);
+	void (*set_dr)(struct kvm_vcpu *vcpu, int dr, unsigned long value,
+		       int *exception);
 	void (*cache_regs)(struct kvm_vcpu *vcpu);
 	void (*decache_regs)(struct kvm_vcpu *vcpu);
 	unsigned long (*get_rflags)(struct kvm_vcpu *vcpu);
 	void (*set_rflags)(struct kvm_vcpu *vcpu, unsigned long rflags);
 
+	void (*invlpg)(struct kvm_vcpu *vcpu, gva_t addr);
 	void (*flush_tlb)(struct kvm_vcpu *vcpu);
 	void (*inject_page_fault)(struct kvm_vcpu *vcpu,
 				  unsigned long addr, u32 err_code);
@@ -324,6 +328,8 @@ hpa_t gpa_to_hpa(struct kvm_vcpu *vcpu, 
 static inline int is_error_hpa(hpa_t hpa) { return hpa >> HPA_MSB; }
 hpa_t gva_to_hpa(struct kvm_vcpu *vcpu, gva_t gva);
 
+void kvm_emulator_want_group7_invlpg(void);
+
 extern hpa_t bad_page_address;
 
 static inline struct page *gfn_to_page(struct kvm_memory_slot *slot, gfn_t gfn)
@@ -351,6 +357,15 @@ unsigned long realmode_get_cr(struct kvm
 void realmode_set_cr(struct kvm_vcpu *vcpu, int cr, unsigned long value,
 		     unsigned long *rflags);
 
+struct x86_emulate_ctxt;
+
+int emulate_invlpg(struct kvm_vcpu *vcpu, gva_t address);
+int emulate_clts(struct kvm_vcpu *vcpu);
+int emulator_get_dr(struct x86_emulate_ctxt* ctxt, int dr,
+		    unsigned long *dest);
+int emulator_set_dr(struct x86_emulate_ctxt *ctxt, int dr,
+		    unsigned long value);
+
 void set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
 void set_cr3(struct kvm_vcpu *vcpu, unsigned long cr0);
 void set_cr4(struct kvm_vcpu *vcpu, unsigned long cr0);
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -907,6 +907,52 @@ static unsigned long get_segment_base(st
 	return kvm_arch_ops->get_segment_base(vcpu, seg);
 }
 
+int emulate_invlpg(struct kvm_vcpu *vcpu, gva_t address)
+{
+	spin_lock(&vcpu->kvm->lock);
+	vcpu->mmu.inval_page(vcpu, address);
+	spin_unlock(&vcpu->kvm->lock);
+	kvm_arch_ops->invlpg(vcpu, address);
+	return X86EMUL_CONTINUE;
+}
+
+int emulate_clts(struct kvm_vcpu *vcpu)
+{
+	unsigned long cr0 = vcpu->cr0;
+
+	cr0 &= ~CR0_TS_MASK;
+	kvm_arch_ops->set_cr0(vcpu, cr0);
+	return X86EMUL_CONTINUE;
+}
+
+int emulator_get_dr(struct x86_emulate_ctxt* ctxt, int dr, unsigned long *dest)
+{
+	struct kvm_vcpu *vcpu = ctxt->vcpu;
+
+	switch (dr) {
+	case 0 ... 3:
+		*dest = kvm_arch_ops->get_dr(vcpu, dr);
+		return X86EMUL_CONTINUE;
+	default:
+		printk(KERN_DEBUG "%s: unexpected dr %u\n",
+		       __FUNCTION__, dr);
+		return X86EMUL_UNHANDLEABLE;
+	}
+}
+
+int emulator_set_dr(struct x86_emulate_ctxt *ctxt, int dr, unsigned long value)
+{
+	unsigned long mask = (ctxt->mode == X86EMUL_MODE_PROT64) ? ~0ULL : ~0U;
+	int exception;
+
+	kvm_arch_ops->set_dr(ctxt->vcpu, dr, value & mask, &exception);
+	if (exception) {
+		/* FIXME: better handling */
+		return X86EMUL_UNHANDLEABLE;
+	}
+	return X86EMUL_CONTINUE;
+}
+
 static void report_emulation_failure(struct x86_emulate_ctxt *ctxt)
 {
 	static int reported;
Index: linux-2.6/drivers/kvm/x86_emulate.c
===================================================================
--- linux-2.6.orig/drivers/kvm/x86_emulate.c
+++ linux-2.6/drivers/kvm/x86_emulate.c
@@ -29,6 +29,7 @@
 #define DPRINTF(x...) do {} while (0)
 #endif
 #include "x86_emulate.h"
+#include <linux/module.h>
 
 /*
  * Opcode effective-address decode tables.
@@ -149,12 +150,12 @@ static u8 opcode_table[256] = {
 
 static u8 twobyte_table[256] = {
 	/* 0x00 - 0x0F */
-	0, SrcMem | ModRM | DstReg | Mov, 0, 0, 0, 0, 0, 0,
+	0, SrcMem | ModRM | DstReg, 0, 0, 0, 0, ImplicitOps, 0,
 	0, 0, 0, 0, 0, ImplicitOps | ModRM, 0, 0,
 	/* 0x10 - 0x1F */
 	0, 0, 0, 0, 0, 0, 0, 0, ImplicitOps | ModRM, 0, 0, 0, 0, 0, 0, 0,
 	/* 0x20 - 0x2F */
-	ImplicitOps, 0, ImplicitOps, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	ImplicitOps, ModRM, ImplicitOps, ModRM, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 	/* 0x30 - 0x3F */
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 	/* 0x40 - 0x47 */
@@ -200,6 +201,19 @@ static u8 twobyte_table[256] = {
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
 };
 
+/*
+ * Tell the emulator that of the Group 7 instructions (sgdt, lidt, etc.) we
+ * are interested only in invlpg and not in any of the rest.
+ *
+ * invlpg is a special instruction in that the data it references may not
+ * be mapped.
+ */
+void kvm_emulator_want_group7_invlpg(void)
+{
+	twobyte_table[1] &= ~SrcMem;
+}
+EXPORT_SYMBOL_GPL(kvm_emulator_want_group7_invlpg);
+
 /* Type, address-of, and value of an instruction's operand. */
 struct operand {
 	enum { OP_REG, OP_MEM, OP_IMM } type;
@@ -1154,10 +1168,23 @@ twobyte_insn:
 		case 6: /* lmsw */
 			realmode_lmsw(ctxt->vcpu, (u16)modrm_val, &_eflags);
 			break;
+		case 7: /* invlpg*/
+			emulate_invlpg(ctxt->vcpu, cr2);
+			break;
 		default:
 			goto cannot_emulate;
 		}
 		break;
+	case 0x21: /* mov from dr to reg */
+		if (modrm_mod != 3)
+			goto cannot_emulate;
+		rc = emulator_get_dr(ctxt, modrm_reg, &_regs[modrm_rm]);
+		break;
+	case 0x23: /* mov from reg to dr */
+		if (modrm_mod != 3)
+			goto cannot_emulate;
+		rc = emulator_set_dr(ctxt, modrm_reg, _regs[modrm_rm]);
+		break;
 	case 0x40 ... 0x4f:	/* cmov */
 		dst.val = dst.orig_val = src.val;
 		d &= ~Mov;	/* default to no move */
@@ -1264,6 +1291,9 @@ twobyte_special_insn:
 	case 0x0d:		/* GrpP (prefetch) */
 	case 0x18:		/* Grp16 (prefetch/nop) */
 		break;
+	case 0x06:
+		emulate_clts(ctxt->vcpu);
+		break;
 	case 0x20: /* mov cr, reg */
 		b = insn_fetch(u8, 1, _eip);
 		if ((b & 0xc0) != 0xc0)
