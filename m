Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbUJ2Dez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbUJ2Dez (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 23:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbUJ2Dez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 23:34:55 -0400
Received: from gate.crashing.org ([63.228.1.57]:49289 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262248AbUJ2Dev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 23:34:51 -0400
Subject: [PATCH] ppc32: Fix boot on PowerMac
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 29 Oct 2004 13:29:46 +1000
Message-Id: <1099020586.29693.105.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Tom's recent irq patch broke PowerMac (and possibly others). I think
he forgot that PReP, CHRP and PowerMac are all built together in a
single kernel image, thus all of those arch_initcall's will end up
beeing called, even on the wrong machine...

This fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc/platforms/chrp_setup.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/chrp_setup.c	2004-10-29 10:46:32.000000000 +1000
+++ linux-work/arch/ppc/platforms/chrp_setup.c	2004-10-29 13:15:59.171074120 +1000
@@ -374,6 +374,9 @@
 static int __init
 chrp_request_cascade(void)
 {
+	if (_machine != _MACH_chrp)
+		return 0;
+
 	/* We have a cascade on OpenPIC IRQ 0, Linux IRQ 16 */
 	openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
 			       i8259_irq);
Index: linux-work/arch/ppc/syslib/i8259.c
===================================================================
--- linux-work.orig/arch/ppc/syslib/i8259.c	2004-10-29 10:46:32.000000000 +1000
+++ linux-work/arch/ppc/syslib/i8259.c	2004-10-29 13:20:45.392561840 +1000
@@ -13,6 +13,7 @@
 static spinlock_t i8259_lock = SPIN_LOCK_UNLOCKED;
 
 int i8259_pic_irq_offset;
+static int i8259_present;
 
 /*
  * Acknowledge the IRQ using either the PCI host bridge's interrupt
@@ -154,6 +155,9 @@
 static int __init
 i8259_hook_cascade(void)
 {
+	if (!i8259_present)
+		return 0;
+
 	/* reserve our resources */
 	request_irq( i8259_pic_irq_offset + 2, no_action, SA_INTERRUPT,
 				"82c59 secondary cascade", NULL );
@@ -201,4 +205,6 @@
 
 	if (intack_addr != 0)
 		pci_intack = ioremap(intack_addr, 1);
+
+	i8259_present = 1;
 }
Index: linux-work/arch/ppc/platforms/prep_setup.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/prep_setup.c	2004-10-29 10:46:32.000000000 +1000
+++ linux-work/arch/ppc/platforms/prep_setup.c	2004-10-29 13:19:31.656771384 +1000
@@ -961,6 +961,9 @@
 static int __init
 prep_request_cascade(void)
 {
+	if (_machine != _MACH_prep)
+		return 0;
+
 	if (OpenPIC_Addr != NULL)
 		/* We have a cascade on OpenPIC IRQ 0, Linux IRQ 16 */
 		openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",


