Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbTL3WYB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265351AbTL3WOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:14:21 -0500
Received: from mail.kroah.org ([65.200.24.183]:54209 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265823AbTL3WGg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:06:36 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.0
In-Reply-To: <10728219704116@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Dec 2003 14:06:10 -0800
Message-Id: <10728219702175@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1496.8.30, 2003/12/17 15:52:23-08:00, khali@linux-fr.org

[PATCH] I2C: restore support for AMD8111 in i2c-amd756 driver

This patch restores support for the AMD8111 in the i2c-amd756 driver.

Credits go to Philip Pokorny for the original patch. I tweaked it a bit.

This isn't a bug fix and can be delayed until after 2.6.0 if you want.


 drivers/i2c/busses/i2c-amd756.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
--- a/drivers/i2c/busses/i2c-amd756.c	Tue Dec 30 12:30:50 2003
+++ b/drivers/i2c/busses/i2c-amd756.c	Tue Dec 30 12:30:50 2003
@@ -28,10 +28,12 @@
     2002-04-08: Added nForce support. (Csaba Halasz)
     2002-10-03: Fixed nForce PnP I/O port. (Michael Steil)
     2002-12-28: Rewritten into something that resembles a Linux driver (hch)
+    2003-11-29: Added back AMD8111 removed by the previous rewrite.
+                (Philip Pokorny)
 */
 
 /*
-   Supports AMD756, AMD766, AMD768 and nVidia nForce
+   Supports AMD756, AMD766, AMD768, AMD8111 and nVidia nForce
    Note: we assume there can only be one device, with one SMBus interface.
 */
 
@@ -308,12 +310,13 @@
 	.name		= "unset",
 };
 
-enum chiptype { AMD756, AMD766, AMD768, NFORCE };
+enum chiptype { AMD756, AMD766, AMD768, NFORCE, AMD8111 };
 
 static struct pci_device_id amd756_ids[] = {
 	{PCI_VENDOR_ID_AMD, 0x740B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD756 },
 	{PCI_VENDOR_ID_AMD, 0x7413, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD766 },
 	{PCI_VENDOR_ID_AMD, 0x7443, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD768 },
+	{PCI_VENDOR_ID_AMD, 0x746B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD8111 },
 	{PCI_VENDOR_ID_NVIDIA, 0x01B4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE },
 	{ 0, }
 };
@@ -321,7 +324,8 @@
 static int __devinit amd756_probe(struct pci_dev *pdev,
 				  const struct pci_device_id *id)
 {
-	int nforce = (id->driver_data == NFORCE), error;
+	int nforce = (id->driver_data == NFORCE);
+	int error;
 	u8 temp;
 	
 	if (amd756_ioport) {
@@ -368,7 +372,7 @@
 	amd756_adapter.dev.parent = &pdev->dev;
 
 	snprintf(amd756_adapter.name, I2C_NAME_SIZE,
-		"SMBus AMD75x adapter at %04x", amd756_ioport);
+		"SMBus AMD756 adapter at %04x", amd756_ioport);
 
 	error = i2c_add_adapter(&amd756_adapter);
 	if (error) {
@@ -391,7 +395,7 @@
 }
 
 static struct pci_driver amd756_driver = {
-	.name		= "amd75x smbus",
+	.name		= "amd756 smbus",
 	.id_table	= amd756_ids,
 	.probe		= amd756_probe,
 	.remove		= __devexit_p(amd756_remove),
@@ -408,7 +412,7 @@
 }
 
 MODULE_AUTHOR("Merlin Hughes <merlin@merlin.org>");
-MODULE_DESCRIPTION("AMD756/766/768/nVidia nForce SMBus driver");
+MODULE_DESCRIPTION("AMD756/766/768/8111 and nVidia nForce SMBus driver");
 MODULE_LICENSE("GPL");
 
 module_init(amd756_init)

