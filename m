Return-Path: <linux-kernel-owner+w=401wt.eu-S964933AbXADQPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbXADQPL (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbXADQPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:15:11 -0500
Received: from il.qumranet.com ([62.219.232.206]:49234 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964933AbXADQPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:15:09 -0500
Subject: [PATCH 26/33] KVM: MMU: Fix cmpxchg8b emulation
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 16:15:07 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104161507.70F3E250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cmpxchg8b uses edx:eax as the compare operand, not edi:eax.

cmpxchg8b is used by 32-bit pae guests to set page table entries atomically,
and this is emulated touching shadowed guest page tables.

Also, implement it for 32-bit hosts.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/x86_emulate.c
===================================================================
--- linux-2.6.orig/drivers/kvm/x86_emulate.c
+++ linux-2.6/drivers/kvm/x86_emulate.c
@@ -1323,7 +1323,7 @@ twobyte_special_insn:
 							 ctxt)) != 0))
 				goto done;
 			if ((old_lo != _regs[VCPU_REGS_RAX])
-			    || (old_hi != _regs[VCPU_REGS_RDI])) {
+			    || (old_hi != _regs[VCPU_REGS_RDX])) {
 				_regs[VCPU_REGS_RAX] = old_lo;
 				_regs[VCPU_REGS_RDX] = old_hi;
 				_eflags &= ~EFLG_ZF;
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -936,6 +936,30 @@ static int emulator_cmpxchg_emulated(uns
 	return emulator_write_emulated(addr, new, bytes, ctxt);
 }
 
+#ifdef CONFIG_X86_32
+
+static int emulator_cmpxchg8b_emulated(unsigned long addr,
+				       unsigned long old_lo,
+				       unsigned long old_hi,
+				       unsigned long new_lo,
+				       unsigned long new_hi,
+				       struct x86_emulate_ctxt *ctxt)
+{
+	static int reported;
+	int r;
+
+	if (!reported) {
+		reported = 1;
+		printk(KERN_WARNING "kvm: emulating exchange8b as write\n");
+	}
+	r = emulator_write_emulated(addr, new_lo, 4, ctxt);
+	if (r != X86EMUL_CONTINUE)
+		return r;
+	return emulator_write_emulated(addr+4, new_hi, 4, ctxt);
+}
+
+#endif
+
 static unsigned long get_segment_base(struct kvm_vcpu *vcpu, int seg)
 {
 	return kvm_arch_ops->get_segment_base(vcpu, seg);
@@ -1010,6 +1034,9 @@ struct x86_emulate_ops emulate_ops = {
 	.read_emulated       = emulator_read_emulated,
 	.write_emulated      = emulator_write_emulated,
 	.cmpxchg_emulated    = emulator_cmpxchg_emulated,
+#ifdef CONFIG_X86_32
+	.cmpxchg8b_emulated  = emulator_cmpxchg8b_emulated,
+#endif
 };
 
 int emulate_instruction(struct kvm_vcpu *vcpu,
