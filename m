Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWJHIYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWJHIYi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 04:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWJHIYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 04:24:37 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:8096 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750917AbWJHIYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 04:24:37 -0400
Date: Sun, 8 Oct 2006 11:24:28 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, jdike@addtoit.com,
       blaisorblade@yahoo.it
Subject: [PATCH] um: setup irq regs in do_IRQ
Message-ID: <Pine.LNX.4.64.0610081121480.3477@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

We need to setup and restore IRQ registers in __do_IRQ so that get_irq_regs
works correctly.  Fixes Alt-Sysrq-p for UML.

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Paolo "Blaisorblade" Giarrusso <blaisorblade@yahoo.it>
Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 arch/um/kernel/irq.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

Index: 2.6/arch/um/kernel/irq.c
===================================================================
--- 2.6.orig/arch/um/kernel/irq.c
+++ 2.6/arch/um/kernel/irq.c
@@ -355,10 +355,14 @@ void forward_interrupts(int pid)
  */
 unsigned int do_IRQ(int irq, union uml_pt_regs *regs)
 {
-       irq_enter();
-       __do_IRQ(irq);
-       irq_exit();
-       return 1;
+	struct pt_regs *old_regs;
+
+	old_regs = set_irq_regs((struct pt_regs *) regs);
+	irq_enter();
+	__do_IRQ(irq);
+	irq_exit();
+	set_irq_regs(old_regs);
+	return 1;
 }
 
 int um_request_irq(unsigned int irq, int fd, int type,
