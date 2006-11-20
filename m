Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965747AbWKTK3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965747AbWKTK3m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 05:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965744AbWKTK3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 05:29:41 -0500
Received: from il.qumranet.com ([62.219.232.206]:25218 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S965747AbWKTK3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 05:29:40 -0500
Subject: [PATCH] KVM: Fix emulator mov cr decoding
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 20 Nov 2006 10:29:39 -0000
To: kvm-devel@lists.sourceforge.net
Cc: akpm@osdl.org, kvm-devel@lists.sourceforge.net, yaniv.kamay@qumranet.com,
       linux-kernel@vger.kernel.org
Message-Id: <20061120102939.C032125015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yaniv Kamay <yaniv@qumranet.com>

Decoding of the mov cr instructions was wrong.

Signed-off-by: Yaniv Kamay <yaniv@qumranet.com>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/x86_emulate.c
===================================================================
--- linux-2.6.orig/drivers/kvm/x86_emulate.c
+++ linux-2.6/drivers/kvm/x86_emulate.c
@@ -1268,13 +1268,13 @@ twobyte_special_insn:
 		b = insn_fetch(u8, 1, _eip);
 		if ((b & 0xc0) != 0xc0)
 			goto cannot_emulate;
-		_regs[(b >> 3) & 7] = realmode_get_cr(ctxt->vcpu, b & 7);
+		_regs[b & 7] = realmode_get_cr(ctxt->vcpu, (b >> 3) & 7);
 		break;
 	case 0x22: /* mov reg, cr */
 		b = insn_fetch(u8, 1, _eip);
 		if ((b & 0xc0) != 0xc0)
 			goto cannot_emulate;
-		realmode_set_cr(ctxt->vcpu, b & 7, _regs[(b >> 3) & 7] & -1u,
+		realmode_set_cr(ctxt->vcpu, (b >> 3) & 7, _regs[b & 7] & -1u,
 				&_eflags);
 		break;
 	case 0xc7:		/* Grp9 (cmpxchg8b) */
