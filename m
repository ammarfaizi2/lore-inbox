Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265646AbUANK6B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 05:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265870AbUANK5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 05:57:52 -0500
Received: from nikam.ms.mff.cuni.cz ([195.113.18.106]:31187 "EHLO
	nikam.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265646AbUANK5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 05:57:41 -0500
Date: Wed, 14 Jan 2004 11:57:41 +0100
From: Jan Hubicka <jh@suse.cz>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Fix inlining failure (all GCCs) in parport
Message-ID: <20040114105741.GD26326@kam.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
GCC never inline extern inline function redefined by new body (because it is
not clear what body one should choose)

parport contains such duplicated functions for apparently no good reasons.
Both copies differ slightly, not sure whether it is intentional or just
garbage.

Honza

diff -urp drivers/parport.old/parport_pc.c drivers/parport/parport_pc.c
--- drivers/parport.old/parport_pc.c	2004-01-13 15:14:38.000000000 +0100
+++ drivers/parport/parport_pc.c	2004-01-13 19:26:02.235750216 +0100
@@ -270,95 +270,6 @@ static irqreturn_t parport_pc_interrupt(
 	return IRQ_HANDLED;
 }
 
-void parport_pc_write_data(struct parport *p, unsigned char d)
-{
-	outb (d, DATA (p));
-}
-
-unsigned char parport_pc_read_data(struct parport *p)
-{
-	return inb (DATA (p));
-}
-
-void parport_pc_write_control(struct parport *p, unsigned char d)
-{
-	const unsigned char wm = (PARPORT_CONTROL_STROBE |
-				  PARPORT_CONTROL_AUTOFD |
-				  PARPORT_CONTROL_INIT |
-				  PARPORT_CONTROL_SELECT);
-
-	/* Take this out when drivers have adapted to the newer interface. */
-	if (d & 0x20) {
-		printk (KERN_DEBUG "%s (%s): use data_reverse for this!\n",
-			p->name, p->cad->name);
-		parport_pc_data_reverse (p);
-	}
-
-	__parport_pc_frob_control (p, wm, d & wm);
-}
-
-unsigned char parport_pc_read_control(struct parport *p)
-{
-	const unsigned char wm = (PARPORT_CONTROL_STROBE |
-				  PARPORT_CONTROL_AUTOFD |
-				  PARPORT_CONTROL_INIT |
-				  PARPORT_CONTROL_SELECT);
-	const struct parport_pc_private *priv = p->physport->private_data;
-	return priv->ctr & wm; /* Use soft copy */
-}
-
-unsigned char parport_pc_frob_control (struct parport *p, unsigned char mask,
-				       unsigned char val)
-{
-	const unsigned char wm = (PARPORT_CONTROL_STROBE |
-				  PARPORT_CONTROL_AUTOFD |
-				  PARPORT_CONTROL_INIT |
-				  PARPORT_CONTROL_SELECT);
-
-	/* Take this out when drivers have adapted to the newer interface. */
-	if (mask & 0x20) {
-		printk (KERN_DEBUG "%s (%s): use data_%s for this!\n",
-			p->name, p->cad->name,
-			(val & 0x20) ? "reverse" : "forward");
-		if (val & 0x20)
-			parport_pc_data_reverse (p);
-		else
-			parport_pc_data_forward (p);
-	}
-
-	/* Restrict mask and val to control lines. */
-	mask &= wm;
-	val &= wm;
-
-	return __parport_pc_frob_control (p, mask, val);
-}
-
-unsigned char parport_pc_read_status(struct parport *p)
-{
-	return inb (STATUS (p));
-}
-
-void parport_pc_disable_irq(struct parport *p)
-{
-	__parport_pc_frob_control (p, 0x10, 0);
-}
-
-void parport_pc_enable_irq(struct parport *p)
-{
-	if (p->irq != PARPORT_IRQ_NONE)
-		__parport_pc_frob_control (p, 0x10, 0x10);
-}
-
-void parport_pc_data_forward (struct parport *p)
-{
-	__parport_pc_frob_control (p, 0x20, 0);
-}
-
-void parport_pc_data_reverse (struct parport *p)
-{
-	__parport_pc_frob_control (p, 0x20, 0x20);
-}
-
 void parport_pc_init_state(struct pardevice *dev, struct parport_state *s)
 {
 	s->u.pc.ctr = 0xc;
@@ -1235,6 +1146,8 @@ dump_parport_state ("fwd idle", port);
  *	******************************************
  */
 
+/* GCC is not inlining extern inline function later overwriten to non-inline,
+   so we use outlined_ variants here.  */
 struct parport_operations parport_pc_ops = 
 {
 	.write_data	= parport_pc_write_data,
--- include.old/linux/parport_pc.h	2004-01-13 00:38:37.000000000 +0100
+++ include/linux/parport_pc.h	2004-01-13 19:28:04.538157424 +0100
@@ -41,7 +41,7 @@ struct parport_pc_private {
 	struct pci_dev *dev;
 };
 
-extern __inline__ void parport_pc_write_data(struct parport *p, unsigned char d)
+static __inline__ void parport_pc_write_data(struct parport *p, unsigned char d)
 {
 #ifdef DEBUG_PARPORT
 	printk (KERN_DEBUG "parport_pc_write_data(%p,0x%02x)\n", p, d);
@@ -49,7 +49,7 @@ extern __inline__ void parport_pc_write_
 	outb(d, DATA(p));
 }
 
-extern __inline__ unsigned char parport_pc_read_data(struct parport *p)
+static __inline__ unsigned char parport_pc_read_data(struct parport *p)
 {
 	unsigned char val = inb (DATA (p));
 #ifdef DEBUG_PARPORT
@@ -124,17 +124,17 @@ static __inline__ unsigned char __parpor
 	return ctr;
 }
 
-extern __inline__ void parport_pc_data_reverse (struct parport *p)
+static __inline__ void parport_pc_data_reverse (struct parport *p)
 {
 	__parport_pc_frob_control (p, 0x20, 0x20);
 }
 
-extern __inline__ void parport_pc_data_forward (struct parport *p)
+static __inline__ void parport_pc_data_forward (struct parport *p)
 {
 	__parport_pc_frob_control (p, 0x20, 0x00);
 }
 
-extern __inline__ void parport_pc_write_control (struct parport *p,
+static __inline__ void parport_pc_write_control (struct parport *p,
 						 unsigned char d)
 {
 	const unsigned char wm = (PARPORT_CONTROL_STROBE |
@@ -152,7 +152,7 @@ extern __inline__ void parport_pc_write_
 	__parport_pc_frob_control (p, wm, d & wm);
 }
 
-extern __inline__ unsigned char parport_pc_read_control(struct parport *p)
+static __inline__ unsigned char parport_pc_read_control(struct parport *p)
 {
 	const unsigned char rm = (PARPORT_CONTROL_STROBE |
 				  PARPORT_CONTROL_AUTOFD |
@@ -162,7 +162,7 @@ extern __inline__ unsigned char parport_
 	return priv->ctr & rm; /* Use soft copy */
 }
 
-extern __inline__ unsigned char parport_pc_frob_control (struct parport *p,
+static __inline__ unsigned char parport_pc_frob_control (struct parport *p,
 							 unsigned char mask,
 							 unsigned char val)
 {
@@ -189,18 +189,18 @@ extern __inline__ unsigned char parport_
 	return __parport_pc_frob_control (p, mask, val);
 }
 
-extern __inline__ unsigned char parport_pc_read_status(struct parport *p)
+static __inline__ unsigned char parport_pc_read_status(struct parport *p)
 {
 	return inb(STATUS(p));
 }
 
 
-extern __inline__ void parport_pc_disable_irq(struct parport *p)
+static __inline__ void parport_pc_disable_irq(struct parport *p)
 {
 	__parport_pc_frob_control (p, 0x10, 0x00);
 }
 
-extern __inline__ void parport_pc_enable_irq(struct parport *p)
+static __inline__ void parport_pc_enable_irq(struct parport *p)
 {
 	__parport_pc_frob_control (p, 0x10, 0x10);
 }
