Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967194AbWK3NSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967194AbWK3NSK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 08:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936397AbWK3NSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 08:18:10 -0500
Received: from il.qumranet.com ([62.219.232.206]:48089 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S936353AbWK3NSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 08:18:07 -0500
Subject: [PATCH] KVM: x86 emulator: handle smsw
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 30 Nov 2006 13:18:04 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org
Message-Id: <20061130131804.D312825017B@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This allows FreeBSD 6.2rc1 to boot.

Also, don't pretend to support lmsw (mem).

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/x86_emulate.c
===================================================================
--- linux-2.6.orig/drivers/kvm/x86_emulate.c
+++ linux-2.6/drivers/kvm/x86_emulate.c
@@ -1166,7 +1166,15 @@ twobyte_insn:
 				goto done;
 			realmode_lidt(ctxt->vcpu, size, address);
 			break;
+		case 4: /* smsw */
+			if (modrm_mod != 3)
+				goto cannot_emulate;
+			*(u16 *)&_regs[modrm_rm]
+				= realmode_get_cr(ctxt->vcpu, 0);
+			break;
 		case 6: /* lmsw */
+			if (modrm_mod != 3)
+				goto cannot_emulate;
 			realmode_lmsw(ctxt->vcpu, (u16)modrm_val, &_eflags);
 			break;
 		case 7: /* invlpg*/
