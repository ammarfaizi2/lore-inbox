Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265665AbUA0XgV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 18:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265675AbUA0XgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 18:36:20 -0500
Received: from mail.kroah.org ([65.200.24.183]:38847 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265665AbUA0XeT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 18:34:19 -0500
Subject: [PATCH] i2c driver fixes for 2.6.2-rc2
In-Reply-To: <20040127233242.GA28891@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 27 Jan 2004 15:34:13 -0800
Message-Id: <1075246453680@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.148.1, 2004/01/23 17:14:22-08:00, mhoffman@lightlink.com

[PATCH] I2C: i2c-piix4.c bugfix

This patch fixes a "Trying to release non-existent resource" error that
occurs during rmmod when the device isn't actually present.  It includes
some other cleanups too: error paths, whitespace, magic numbers, __devinit.


 drivers/i2c/busses/i2c-piix4.c |   48 +++++++++++++++++++++++------------------
 1 files changed, 27 insertions(+), 21 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Tue Jan 27 15:27:30 2004
+++ b/drivers/i2c/busses/i2c-piix4.c	Tue Jan 27 15:27:30 2004
@@ -68,6 +68,9 @@
 #define SMBSLVEVT	(0xA + piix4_smba)
 #define SMBSLVDAT	(0xC + piix4_smba)
 
+/* count for request_region */
+#define SMBIOSIZE	8
+
 /* PCI Address Constants */
 #define SMBBA		0x090
 #define SMBHSTCFG	0x0D2
@@ -112,14 +115,13 @@
 
 static int piix4_transaction(void);
 
-
 static unsigned short piix4_smba = 0;
 static struct i2c_adapter piix4_adapter;
 
 /*
  * Get DMI information.
  */
-static int ibm_dmi_probe(void)
+static int __devinit ibm_dmi_probe(void)
 {
 #ifdef CONFIG_X86
 	extern int is_unsafe_smbus;
@@ -129,9 +131,9 @@
 #endif
 }
 
-static int piix4_setup(struct pci_dev *PIIX4_dev, const struct pci_device_id *id)
+static int __devinit piix4_setup(struct pci_dev *PIIX4_dev,
+				const struct pci_device_id *id)
 {
-	int error_return = 0;
 	unsigned char temp;
 
 	/* match up the function */
@@ -144,8 +146,7 @@
 		dev_err(&PIIX4_dev->dev, "IBM Laptop detected; this module "
 			"may corrupt your serial eeprom! Refusing to load "
 			"module!\n");
-		error_return = -EPERM;
-		goto END;
+		return -EPERM;
 	}
 
 	/* Determine the address of the SMBus areas */
@@ -163,11 +164,10 @@
 		}
 	}
 
-	if (!request_region(piix4_smba, 8, "piix4-smbus")) {
+	if (!request_region(piix4_smba, SMBIOSIZE, "piix4-smbus")) {
 		dev_err(&PIIX4_dev->dev, "SMB region 0x%x already in use!\n",
 			piix4_smba);
-		error_return = -ENODEV;
-		goto END;
+		return -ENODEV;
 	}
 
 	pci_read_config_byte(PIIX4_dev, SMBHSTCFG, &temp);
@@ -214,8 +214,9 @@
 		} else {
 			dev_err(&PIIX4_dev->dev,
 				"Host SMBus controller not enabled!\n");
-			error_return = -ENODEV;
-			goto END;
+			release_region(piix4_smba, SMBIOSIZE);
+			piix4_smba = 0;
+			return -ENODEV;
 		}
 	}
 
@@ -231,8 +232,7 @@
 	dev_dbg(&PIIX4_dev->dev, "SMBREV = 0x%X\n", temp);
 	dev_dbg(&PIIX4_dev->dev, "SMBA = 0x%X\n", piix4_smba);
 
-END:
-	return error_return;
+	return 0;
 }
 
 /* Another internally used function */
@@ -465,7 +465,8 @@
 	{ 0, }
 };
 
-static int __devinit piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int __devinit piix4_probe(struct pci_dev *dev,
+				const struct pci_device_id *id)
 {
 	int retval;
 
@@ -479,17 +480,24 @@
 	snprintf(piix4_adapter.name, I2C_NAME_SIZE,
 		"SMBus PIIX4 adapter at %04x", piix4_smba);
 
-	retval = i2c_add_adapter(&piix4_adapter);
+	if ((retval = i2c_add_adapter(&piix4_adapter))) {
+		dev_err(&dev->dev, "Couldn't register adapter!\n");
+		release_region(piix4_smba, SMBIOSIZE);
+		piix4_smba = 0;
+	}
 
 	return retval;
 }
 
 static void __devexit piix4_remove(struct pci_dev *dev)
 {
-	i2c_del_adapter(&piix4_adapter);
+	if (piix4_smba) {
+		i2c_del_adapter(&piix4_adapter);
+		release_region(piix4_smba, SMBIOSIZE);
+		piix4_smba = 0;
+	}
 }
 
-
 static struct pci_driver piix4_driver = {
 	.name		= "piix4-smbus",
 	.id_table	= piix4_ids,
@@ -502,15 +510,13 @@
 	return pci_module_init(&piix4_driver);
 }
 
-
 static void __exit i2c_piix4_exit(void)
 {
 	pci_unregister_driver(&piix4_driver);
-	release_region(piix4_smba, 8);
 }
 
-MODULE_AUTHOR
-    ("Frodo Looijaard <frodol@dds.nl> and Philip Edelbrock <phil@netroedge.com>");
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl> and "
+		"Philip Edelbrock <phil@netroedge.com>");
 MODULE_DESCRIPTION("PIIX4 SMBus driver");
 MODULE_LICENSE("GPL");
 

