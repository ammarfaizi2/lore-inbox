Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbTJTHWU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 03:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbTJTHWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 03:22:20 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:51335 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262409AbTJTHWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 03:22:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  Use irqreturn_t on v850 rte-me2-cb platform
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20031020072157.A642B37E8@mcspd15.ucom.lsi.nec.co.jp>
Date: Mon, 20 Oct 2003 16:21:57 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The cb_pic_handle_irq function on this platform hadn't been updated to
use irqreturn_t; do so.

diff -ruN -X../cludes linux-2.6.0-test8-uc0/arch/v850/kernel/rte_me2_cb.c linux-2.6.0-test8-uc0-v850-20031020/arch/v850/kernel/rte_me2_cb.c
--- linux-2.6.0-test8-uc0/arch/v850/kernel/rte_me2_cb.c	2003-07-28 10:13:58.000000000 +0900
+++ linux-2.6.0-test8-uc0-v850-20031020/arch/v850/kernel/rte_me2_cb.c	2003-10-20 13:47:42.000000000 +0900
@@ -230,8 +217,10 @@
 	CB_PIC_INT1M &= ~(1 << (irq - CB_PIC_BASE_IRQ));
 }
 
-static void cb_pic_handle_irq (int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t cb_pic_handle_irq (int irq, void *dev_id,
+				      struct pt_regs *regs)
 {
+	irqreturn_t rval = IRQ_NONE;
 	unsigned status = CB_PIC_INTR;
 	unsigned enable = CB_PIC_INT1M;
 
@@ -257,13 +246,16 @@
 
 			/* Recursively call handle_irq to handle it. */
 			handle_irq (irq, regs);
+			rval = IRQ_HANDLED;
 		} while (status);
 	}
 
 	CB_PIC_INTEN |= CB_PIC_INT1EN;
-}
 
+	return rval;
+}
 
+
 static void irq_nop (unsigned irq) { }
 
 static unsigned cb_pic_startup_irq (unsigned irq)
