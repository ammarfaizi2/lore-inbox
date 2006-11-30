Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759205AbWK3K4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759205AbWK3K4l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 05:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759233AbWK3K4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 05:56:41 -0500
Received: from il.qumranet.com ([62.219.232.206]:39887 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1759205AbWK3K4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 05:56:41 -0500
Subject: [PATCH] KVM: Fix mov to/from control register emulation,
	with r8-r15 as gpr
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 30 Nov 2006 10:56:38 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org
Message-Id: <20061130105638.7EADB25017B@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the standrd modrm decoder instead of special casing these instructions.
This fixes mov %rX, %crY with X >= 8 or Y >= 8.

The fix only applies to AMD SVM, as Intel vmx decodes the instruction for us.
It cures the FC5 installer crashing when loading the xor module.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/x86_emulate.c
===================================================================
--- linux-2.6.orig/drivers/kvm/x86_emulate.c
+++ linux-2.6/drivers/kvm/x86_emulate.c
@@ -155,7 +155,8 @@ static u8 twobyte_table[256] = {
 	/* 0x10 - 0x1F */
 	0, 0, 0, 0, 0, 0, 0, 0, ImplicitOps | ModRM, 0, 0, 0, 0, 0, 0, 0,
 	/* 0x20 - 0x2F */
-	ImplicitOps, ModRM, ImplicitOps, ModRM, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	ModRM | ImplicitOps, ModRM, ModRM | ImplicitOps, ModRM, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0,
 	/* 0x30 - 0x3F */
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 	/* 0x40 - 0x47 */
@@ -1295,17 +1296,14 @@ twobyte_special_insn:
 		emulate_clts(ctxt->vcpu);
 		break;
 	case 0x20: /* mov cr, reg */
-		b = insn_fetch(u8, 1, _eip);
-		if ((b & 0xc0) != 0xc0)
+		if (modrm_mod != 3)
 			goto cannot_emulate;
-		_regs[b & 7] = realmode_get_cr(ctxt->vcpu, (b >> 3) & 7);
+		_regs[modrm_rm] = realmode_get_cr(ctxt->vcpu, modrm_reg);
 		break;
 	case 0x22: /* mov reg, cr */
-		b = insn_fetch(u8, 1, _eip);
-		if ((b & 0xc0) != 0xc0)
+		if (modrm_mod != 3)
 			goto cannot_emulate;
-		realmode_set_cr(ctxt->vcpu, (b >> 3) & 7, _regs[b & 7] & -1u,
-				&_eflags);
+		realmode_set_cr(ctxt->vcpu, modrm_reg, modrm_val, &_eflags);
 		break;
 	case 0xc7:		/* Grp9 (cmpxchg8b) */
 #if defined(__i386__)
