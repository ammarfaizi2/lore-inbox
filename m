Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262923AbVD2URQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262923AbVD2URQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 16:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262944AbVD2UOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 16:14:24 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:50934 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262930AbVD2UL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 16:11:26 -0400
Message-ID: <427294EA.502@acm.org>
Date: Fri, 29 Apr 2005 15:11:22 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Enable interrupts on the IPMI BT driver
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050605030706030707020101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050605030706030707020101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------050605030706030707020101
Content-Type: text/x-patch;
 name="ipmi_bt_irq.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi_bt_irq.diff"

Enable interrupts for a BT interface.  There is a specific register
that needs to be set up to enable interrupts that also must be
modified to clear the irq.

Also, don't reset the BMC on a BT interface.  That's probably not a
good idea as the BMC may be performing other important functions and a
reset should only be a last resort.  Also, that register is also used
to enable/disable interrupts to the BT; modifying it may screw up the
interrupts.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.12-rc2/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.12-rc2.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.12-rc2/drivers/char/ipmi/ipmi_si_intf.c
@@ -100,6 +100,11 @@
 	/* FIXME - add watchdog stuff. */
 };
 
+/* Some BT-specific defines we need here. */
+#define IPMI_BT_INTMASK_REG		2
+#define IPMI_BT_INTMASK_CLEAR_IRQ_BIT	2
+#define IPMI_BT_INTMASK_ENABLE_IRQ_BIT	1
+
 enum si_type {
     SI_KCS, SI_SMIC, SI_BT
 };
@@ -876,6 +881,17 @@
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t si_bt_irq_handler(int irq, void *data, struct pt_regs *regs)
+{
+	struct smi_info *smi_info = data;
+	/* We need to clear the IRQ flag for the BT interface. */
+	smi_info->io.outputb(&smi_info->io, IPMI_BT_INTMASK_REG,
+			     IPMI_BT_INTMASK_CLEAR_IRQ_BIT
+			     | IPMI_BT_INTMASK_ENABLE_IRQ_BIT);
+	return si_irq_handler(irq, data, regs);
+}
+
+
 static struct ipmi_smi_handlers handlers =
 {
 	.owner                  = THIS_MODULE,
@@ -1002,11 +1018,22 @@
 	if (!info->irq)
 		return 0;
 
-	rv = request_irq(info->irq,
-			 si_irq_handler,
-			 SA_INTERRUPT,
-			 DEVICE_NAME,
-			 info);
+	if (info->si_type == SI_BT) {
+		rv = request_irq(info->irq,
+				 si_bt_irq_handler,
+				 SA_INTERRUPT,
+				 DEVICE_NAME,
+				 info);
+		if (!rv)
+			/* Enable the interrupt in the BT interface. */
+			info->io.outputb(&info->io, IPMI_BT_INTMASK_REG,
+					 IPMI_BT_INTMASK_ENABLE_IRQ_BIT);
+	} else
+		rv = request_irq(info->irq,
+				 si_irq_handler,
+				 SA_INTERRUPT,
+				 DEVICE_NAME,
+				 info);
 	if (rv) {
 		printk(KERN_WARNING
 		       "ipmi_si: %s unable to claim interrupt %d,"
@@ -1025,6 +1052,9 @@
 	if (!info->irq)
 		return;
 
+	if (info->si_type == SI_BT)
+		/* Disable the interrupt in the BT interface. */
+		info->io.outputb(&info->io, IPMI_BT_INTMASK_REG, 0);
 	free_irq(info->irq, info);
 }
 
Index: linux-2.6.12-rc2/drivers/char/ipmi/ipmi_bt_sm.c
===================================================================
--- linux-2.6.12-rc2.orig/drivers/char/ipmi/ipmi_bt_sm.c
+++ linux-2.6.12-rc2/drivers/char/ipmi/ipmi_bt_sm.c
@@ -235,7 +235,6 @@
 	if (BT_STATUS & BT_B_BUSY) BT_CONTROL(BT_B_BUSY);
 	BT_CONTROL(BT_CLR_WR_PTR);
 	BT_CONTROL(BT_SMS_ATN);
-	BT_INTMASK_W(BT_BMC_HWRST);
 #ifdef DEVELOPMENT_ONLY_NOT_FOR_PRODUCTION
 	if (BT_STATUS & BT_B2H_ATN) {
 		int i;

--------------050605030706030707020101--
