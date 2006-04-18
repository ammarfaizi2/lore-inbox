Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWDRMGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWDRMGl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 08:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWDRMGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 08:06:41 -0400
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:53777 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932219AbWDRMGl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 08:06:41 -0400
Date: Tue, 18 Apr 2006 14:06:29 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Subject: [PATCH] i2c-i801: Fix resume when PEC is used
Message-Id: <20060418140629.7cb21736.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix for bug #6395:
Fail to resume on Tecra M2 with ADM1032 and Intel 82801DBM

The BIOS of the Tecra M2 doesn't like it when it has to reboot or
resume after the i2c-i801 driver has left the SMBus in PEC mode. So we
need to add proper .suspend, .resume and .shutdown callbacks to that
driver, where we clear and restore the PEC mode bit appropriately.

Thanks to Daniele Gaffuri for the very good report and contribution.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/i2c/busses/i2c-i801.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

--- linux-2.6.17-rc1.orig/drivers/i2c/busses/i2c-i801.c	2006-04-18 09:34:15.000000000 +0200
+++ linux-2.6.17-rc1/drivers/i2c/busses/i2c-i801.c	2006-04-18 12:47:07.000000000 +0200
@@ -110,6 +110,7 @@
 static struct pci_driver i801_driver;
 static struct pci_dev *I801_dev;
 static int isich4;
+static u8 saved_auxctl;
 
 static int i801_setup(struct pci_dev *dev)
 {
@@ -551,17 +552,46 @@
 	return i2c_add_adapter(&i801_adapter);
 }
 
+static void i801_shutdown(struct pci_dev *dev)
+{
+	if (isich4) {
+		/* Disable PEC mode before leaving, else some BIOSes will
+		   fail to resume/reboot. */
+		outb_p(0, SMBAUXCTL);
+	}
+}
+
 static void __devexit i801_remove(struct pci_dev *dev)
 {
 	i2c_del_adapter(&i801_adapter);
+	i801_shutdown(dev);
 	release_region(i801_smba, (isich4 ? 16 : 8));
 }
 
+static int i801_suspend(struct pci_dev *dev, pm_message_t state)
+{
+	i801_shutdown(dev);
+	return pci_save_state(dev);
+}
+
+static int i801_resume(struct pci_dev *dev)
+{
+	pci_restore_state(dev);
+	if (isich4) {
+		/* Restore PEC mode */
+		outb_p(saved_auxctl, SMBAUXCTL);
+	}
+	return 0;
+}
+
 static struct pci_driver i801_driver = {
 	.name		= "i801_smbus",
 	.id_table	= i801_ids,
 	.probe		= i801_probe,
 	.remove		= __devexit_p(i801_remove),
+	.suspend	= i801_suspend,
+	.resume		= i801_resume,
+	.shutdown	= i801_shutdown,
 };
 
 static int __init i2c_i801_init(void)


-- 
Jean Delvare
