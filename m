Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVEZRv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVEZRv6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 13:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVEZRv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 13:51:58 -0400
Received: from fmr18.intel.com ([134.134.136.17]:7115 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261649AbVEZRvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 13:51:52 -0400
Date: Thu, 26 May 2005 10:51:45 -0700
Message-Id: <200505261751.j4QHpjei009076@linux.jf.intel.com>
From: Rusty Lynch <rusty.lynch@intel.com>
Subject: [patch] Kprobes ia64 qp fix
To: akpm@osdl.org
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       Rusty Lynch <rusty.lynch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch is for the 2.6.12-rc5-mm1 + my previous
"Kprobes ia64 cleanup" patch that fixes a bug where a kprobe still 
fires when the instruction is predicated off.  So given the p6=0, 
and we have an instruction like:

(p6) move loc1=0

we should not be triggering the kprobe.  This is handled by carrying over
the qp section of the original instruction into the break instruction.

    --rusty

signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
signed-off-by: Rusty Lynch <Rusty.lynch@intel.com>

 arch/ia64/kernel/kprobes.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.12-rc5/arch/ia64/kernel/kprobes.c
===================================================================
--- linux-2.6.12-rc5.orig/arch/ia64/kernel/kprobes.c
+++ linux-2.6.12-rc5/arch/ia64/kernel/kprobes.c
@@ -115,19 +115,19 @@ int arch_prepare_kprobe(struct kprobe *p
 	case 0:
  		major_opcode = (bundle->quad0.slot0 >> SLOT0_OPCODE_SHIFT);
  		kprobe_inst = bundle->quad0.slot0;
-		bundle->quad0.slot0 = BREAK_INST;
+		bundle->quad0.slot0 = BREAK_INST | (0x3f & kprobe_inst);
 		break;
 	case 1:
  		major_opcode = (bundle->quad1.slot1_p1 >> SLOT1_p1_OPCODE_SHIFT);
  		kprobe_inst = (bundle->quad0.slot1_p0 |
  				(bundle->quad1.slot1_p1 << (64-46)));
-		bundle->quad0.slot1_p0 = BREAK_INST;
+		bundle->quad0.slot1_p0 = BREAK_INST | (0x3f & kprobe_inst);
 		bundle->quad1.slot1_p1 = (BREAK_INST >> (64-46));
 		break;
 	case 2:
  		major_opcode = (bundle->quad1.slot2 >> SLOT2_OPCODE_SHIFT);
  		kprobe_inst = bundle->quad1.slot2;
-		bundle->quad1.slot2 = BREAK_INST;
+		bundle->quad1.slot2 = BREAK_INST | (0x3f & kprobe_inst);
 		break;
 	}
 
