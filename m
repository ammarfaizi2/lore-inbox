Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbTJJXT7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 19:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbTJJXT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 19:19:59 -0400
Received: from mail.kroah.org ([65.200.24.183]:26082 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263174AbTJJXTx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 19:19:53 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10658274951920@kroah.com>
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test7
In-Reply-To: <10658274953710@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 10 Oct 2003 16:11:35 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1337.1.3, 2003/10/10 14:11:04-07:00, amalysh@web.de

[PATCH] I2C: i2c-sis630 driver fixes

attached you can find a patch that should fix i2c-sis630 driver for
2.6.0-X kernel. With i2c-sis630 from stock 2.6.0-X we have oops and
driver was not correct registered against i2c-core.

Changes:
	1) fixed a oops while modprobing
	2) added check for buffer overflow for i2c block data read transaction
	3) added 'force' modprobe parameter. It's allow more easily
	   testing for not yet supported SiS chips.


 drivers/i2c/busses/Kconfig      |    4 +-
 drivers/i2c/busses/i2c-sis630.c |   67 ++++++++++++++++++++++++++++------------
 2 files changed, 49 insertions(+), 22 deletions(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Fri Oct 10 16:00:43 2003
+++ b/drivers/i2c/busses/Kconfig	Fri Oct 10 16:00:43 2003
@@ -248,11 +248,11 @@
 	  will be called i2c-sis5595.
 
 config I2C_SIS630
-	tristate "SiS 630"
+	tristate "SiS 630/730"
 	depends on I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the 
-	  SiS630 SMBus (a subset of I2C) interface.
+	  SiS630 and SiS730 SMBus (a subset of I2C) interface.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-sis630.
diff -Nru a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
--- a/drivers/i2c/busses/i2c-sis630.c	Fri Oct 10 16:00:43 2003
+++ b/drivers/i2c/busses/i2c-sis630.c	Fri Oct 10 16:00:43 2003
@@ -25,10 +25,10 @@
    	Fixed the typo in sis630_access (Thanks to Mark M. Hoffman)
 	Changed sis630_transaction.(Thanks to Mark M. Hoffman)
    18.09.2002
-	Added SIS730 as supported
+	Added SIS730 as supported.
    21.09.2002
 	Added high_clock module option.If this option is set
-	used Host Master Clock 56KHz (default 14KHz).For now we are save old Host
+	used Host Master Clock 56KHz (default 14KHz).For now we save old Host
 	Master Clock and after transaction completed restore (otherwise
 	it's confuse BIOS and hung Machine).
    24.09.2002
@@ -95,12 +95,22 @@
 
 /* insmod parameters */
 static int high_clock = 0;
+static int force = 0;
 MODULE_PARM(high_clock, "i");
 MODULE_PARM_DESC(high_clock, "Set Host Master Clock to 56KHz (default 14KHz).");
+MODULE_PARM(force, "i");
+MODULE_PARM_DESC(force, "Forcibly enable the SIS630. DANGEROUS!");
 
-
+/* acpi base address */
 static unsigned short acpi_base = 0;
 
+/* supported chips */
+static int supported[] = {
+	PCI_DEVICE_ID_SI_630,
+	PCI_DEVICE_ID_SI_730,
+	0 /* terminates the list */
+};
+
 static inline u8 sis630_read(u8 reg)
 {
 	return inb(acpi_base + reg);
@@ -277,6 +287,10 @@
 			if (len == 0)
 				data->block[0] = sis630_read(SMB_COUNT);
 
+			/* just to be sure */
+			if (data->block[0] > 32)
+				data->block[0] = 32;
+
 			dev_dbg(&adap->dev, "block data read len=0x%x\n", data->block[0]);
 
 			for (i=0; i < 8 && len < data->block[0]; i++,len++) {
@@ -372,16 +386,26 @@
 		I2C_FUNC_SMBUS_BLOCK_DATA;
 }
 
-static int sis630_setup(struct pci_dev *dummy)
+static int sis630_setup(struct pci_dev *sis630_dev)
 {
 	unsigned char b;
-	struct pci_dev *sis630_dev = NULL;
-	int retval = -ENODEV;
+	struct pci_dev *dummy = NULL;
+	int retval = -ENODEV, i;
 
-	/* We need ISA bridge and not pci device passed in.  */
-	sis630_dev = pci_get_device(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_503, sis630_dev);
-	if (!sis630_dev) {
-		dev_err(&dummy->dev, "Error: Can't detect 85C503/5513 ISA bridge!\n");
+	/* check for supported SiS devices */
+	for (i=0; supported[i] > 0 ; i++) {
+		if ((dummy = pci_get_device(PCI_VENDOR_ID_SI, supported[i], dummy)))
+			break; /* found */
+	}
+
+	if (dummy) {
+		pci_dev_put(dummy);
+	}
+        else if (force > 0) {
+		dev_err(&sis630_dev->dev, "WARNING: Can't detect SIS630 compatible device, but "
+			"loading because of force option enabled\n");
+ 	}
+	else {
 		return -ENODEV;
 	}
 
@@ -389,19 +413,19 @@
 	   Enable ACPI first , so we can accsess reg 74-75
 	   in acpi io space and read acpi base addr
 	*/
-	if (!pci_read_config_byte(sis630_dev, SIS630_BIOS_CTL_REG,&b)) {
+	if (pci_read_config_byte(sis630_dev, SIS630_BIOS_CTL_REG,&b)) {
 		dev_err(&sis630_dev->dev, "Error: Can't read bios ctl reg\n");
 		goto exit;
 	}
-
 	/* if ACPI already enabled , do nothing */
 	if (!(b & 0x80) &&
-	    !pci_write_config_byte(sis630_dev, SIS630_BIOS_CTL_REG, b | 0x80)) {
+	    pci_write_config_byte(sis630_dev, SIS630_BIOS_CTL_REG, b | 0x80)) {
 		dev_err(&sis630_dev->dev, "Error: Can't enable ACPI\n");
 		goto exit;
 	}
+
 	/* Determine the ACPI base address */
-	if (!pci_read_config_word(sis630_dev,SIS630_ACPI_BASE_REG,&acpi_base)) {
+	if (pci_read_config_word(sis630_dev,SIS630_ACPI_BASE_REG,&acpi_base)) {
 		dev_err(&sis630_dev->dev, "Error: Can't determine ACPI base address\n");
 		goto exit;
 	}
@@ -418,7 +442,8 @@
 	retval = 0;
 
 exit:
-	pci_dev_put(sis630_dev);
+	if (retval)
+		acpi_base = 0;
 	return retval;
 }
 
@@ -432,19 +457,18 @@
 
 static struct i2c_adapter sis630_adapter = {
 	.owner		= THIS_MODULE,
+	.class		= I2C_ADAP_CLASS_SMBUS,
 	.name		= "unset",
 	.algo		= &smbus_algorithm,
 };
 
 static struct pci_device_id sis630_ids[] __devinitdata = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_630) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_730) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_503) },
 	{ 0, }
 };
 
 static int __devinit sis630_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
-
 	if (sis630_setup(dev)) {
 		dev_err(&dev->dev, "SIS630 comp. bus not detected, module not inserted.\n");
 		return -ENODEV;
@@ -461,7 +485,11 @@
 
 static void __devexit sis630_remove(struct pci_dev *dev)
 {
-	i2c_del_adapter(&sis630_adapter);
+	if (acpi_base) {
+		i2c_del_adapter(&sis630_adapter);
+		release_region(acpi_base + SMB_STS, SIS630_SMB_IOREGION);
+		acpi_base = 0;
+	}
 }
 
 
@@ -481,7 +509,6 @@
 static void __exit i2c_sis630_exit(void)
 {
 	pci_unregister_driver(&sis630_driver);
-	release_region(acpi_base + SMB_STS, SIS630_SMB_IOREGION);
 }
 
 

