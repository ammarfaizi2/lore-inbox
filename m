Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263192AbTCNA5W>; Thu, 13 Mar 2003 19:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263205AbTCNA5M>; Thu, 13 Mar 2003 19:57:12 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:57611 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263200AbTCNAzq>;
	Thu, 13 Mar 2003 19:55:46 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.64
In-reply-to: <10476033212149@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Thu, 13 Mar 2003 16:55 -0800
Message-id: <1047603322689@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1110, 2003/03/13 11:59:13-08:00, greg@kroah.com

i2c: get i2c-piix4 driver to actually bind to a PCI device.


 drivers/i2c/busses/i2c-piix4.c |   99 +++++++++++++++++++++--------------------
 1 files changed, 52 insertions(+), 47 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Thu Mar 13 16:57:25 2003
+++ b/drivers/i2c/busses/i2c-piix4.c	Thu Mar 13 16:57:25 2003
@@ -49,18 +49,6 @@
 	const char *name;
 };
 
-/* Note: We assume all devices are identical
-         to the Intel PIIX4; we only mention it during detection.   */
-
-static struct sd supported[] = {
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3, 3, "PIIX4"},
-	{PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4, 0, "OSB4"},
-	{PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5, 0, "CSB5"},
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_3, 3, "440MX"},
-	{PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_3, 0, "Victory66"},
-	{0, 0, 0, NULL}
-};
-
 /* PIIX4 SMBus address offsets */
 #define SMBHSTSTS (0 + piix4_smba)
 #define SMBHSLVSTS (1 + piix4_smba)
@@ -142,41 +130,16 @@
 }
 #endif
 
-/* Detect whether a PIIX4 can be found, and initialize it, where necessary.
-   Note the differences between kernels with the old PCI BIOS interface and
-   newer kernels with the real PCI interface. In compat.h some things are
-   defined to make the transition easier. */
-int piix4_setup(void)
+static int piix4_setup(struct pci_dev *PIIX4_dev, const struct pci_device_id *id)
 {
 	int error_return = 0;
 	unsigned char temp;
-	struct sd *num = supported;
-	struct pci_dev *PIIX4_dev = NULL;
 
-	if (pci_present() == 0) {
-		error_return = -ENODEV;
-		goto END;
-	}
+	/* match up the function */
+	if (PCI_FUNC(PIIX4_dev->devfn) != id->driver_data)
+		return -ENODEV;
 
-	/* Look for a supported device/function */
-	do {
-		if((PIIX4_dev = pci_find_device(num->mfr, num->dev,
-					        PIIX4_dev))) {
-			if(PCI_FUNC(PIIX4_dev->devfn) != num->fn)
-				continue;
-			break;
-		}
-		PIIX4_dev = NULL;
-		num++;
-	} while (num->mfr);
-
-	if (PIIX4_dev == NULL) {
-		printk
-		  (KERN_ERR "i2c-piix4.o: Error: Can't detect PIIX4 or compatible device!\n");
-		 error_return = -ENODEV;
-		 goto END;
-	}
-	printk(KERN_INFO "i2c-piix4.o: Found %s device\n", num->name);
+	printk(KERN_INFO "i2c-piix4.o: Found %s device\n", PIIX4_dev->dev.name);
 
 #ifdef CONFIG_X86
 	if(ibm_dmi_probe()) {
@@ -267,14 +230,14 @@
 
 
 /* Internally used pause function */
-void piix4_do_pause(unsigned int amount)
+static void piix4_do_pause(unsigned int amount)
 {
 	current->state = TASK_INTERRUPTIBLE;
 	schedule_timeout(amount);
 }
 
 /* Another internally used function */
-int piix4_transaction(void)
+static int piix4_transaction(void)
 {
 	int temp;
 	int result = 0;
@@ -363,7 +326,7 @@
 }
 
 /* Return -1 on error. */
-s32 piix4_access(struct i2c_adapter * adap, u16 addr,
+static s32 piix4_access(struct i2c_adapter * adap, u16 addr,
 		 unsigned short flags, char read_write,
 		 u8 command, int size, union i2c_smbus_data * data)
 {
@@ -456,7 +419,7 @@
 }
 
 
-u32 piix4_func(struct i2c_adapter *adapter)
+static u32 piix4_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
@@ -480,16 +443,58 @@
 
 
 static struct pci_device_id piix4_ids[] __devinitdata = {
+	{
+		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_82371AB_3,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+		.driver_data =	3
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_SERVERWORKS,
+		.device =	PCI_DEVICE_ID_SERVERWORKS_OSB4,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+		.driver_data =	0,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_SERVERWORKS,
+		.device =	PCI_DEVICE_ID_SERVERWORKS_CSB5,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+		.driver_data =	0,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_82443MX_3,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+		.driver_data =	3,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_EFAR,
+		.device =	PCI_DEVICE_ID_EFAR_SLC90E66_3,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+		.driver_data =	0,
+	},
 	{ 0, }
 };
 
 static int __devinit piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	int retval;
+	
+	retval = piix4_setup(dev, id);
+	if (retval)
+		return retval;
 
 	sprintf(piix4_adapter.name, "SMBus PIIX4 adapter at %04x",
 		piix4_smba);
 
-	i2c_add_adapter(&piix4_adapter);
+	retval = i2c_add_adapter(&piix4_adapter);
+
+	return retval;
 }
 
 static void __devexit piix4_remove(struct pci_dev *dev)

