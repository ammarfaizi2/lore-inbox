Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263186AbTCNA5W>; Thu, 13 Mar 2003 19:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263192AbTCNA5B>; Thu, 13 Mar 2003 19:57:01 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:58635 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263205AbTCNAzp>;
	Thu, 13 Mar 2003 19:55:45 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.64
In-reply-to: <10476033153504@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Thu, 13 Mar 2003 16:55 -0800
Message-id: <1047603318248@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1106, 2003/03/13 10:50:41-08:00, greg@kroah.com

i2c: get i2c-ali15x3 driver to actually bind to a PCI device.


 drivers/i2c/busses/i2c-ali15x3.c |   32 +++++++++-----------------------
 1 files changed, 9 insertions(+), 23 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c	Thu Mar 13 16:57:58 2003
+++ b/drivers/i2c/busses/i2c-ali15x3.c	Thu Mar 13 16:57:58 2003
@@ -135,32 +135,11 @@
 
 static unsigned short ali15x3_smba = 0;
 
-/* Detect whether a ALI15X3 can be found, and initialize it, where necessary.
-   Note the differences between kernels with the old PCI BIOS interface and
-   newer kernels with the real PCI interface. In compat.h some things are
-   defined to make the transition easier. */
-int ali15x3_setup(void)
+int ali15x3_setup(struct pci_dev *ALI15X3_dev)
 {
 	u16 a;
 	unsigned char temp;
 
-	struct pci_dev *ALI15X3_dev;
-
-	/* First check whether we can access PCI at all */
-	if (pci_present() == 0) {
-		printk("i2c-ali15x3.o: Error: No PCI-bus found!\n");
-		return -ENODEV;
-	}
-
-	/* Look for the ALI15X3, M7101 device */
-	ALI15X3_dev = NULL;
-	ALI15X3_dev = pci_find_device(PCI_VENDOR_ID_AL,
-				      PCI_DEVICE_ID_AL_M7101, ALI15X3_dev);
-	if (ALI15X3_dev == NULL) {
-		printk("i2c-ali15x3.o: Error: Can't detect ali15x3!\n");
-		return -ENODEV;
-	}
-
 /* Check the following things:
 	- SMB I/O address is initialized
 	- Device is enabled
@@ -534,12 +513,18 @@
 
 
 static struct pci_device_id ali15x3_ids[] __devinitdata = {
+	{
+	.vendor =	PCI_VENDOR_ID_AL,
+	.device =	PCI_DEVICE_ID_AL_M7101,
+	.subvendor =	PCI_ANY_ID,
+	.subdevice =	PCI_ANY_ID,
+	},
 	{ 0, }
 };
 
 static int __devinit ali15x3_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	if (ali15x3_setup()) {
+	if (ali15x3_setup(dev)) {
 		printk
 		    ("i2c-ali15x3.o: ALI15X3 not detected, module not inserted.\n");
 
@@ -549,6 +534,7 @@
 	sprintf(ali15x3_adapter.name, "SMBus ALI15X3 adapter at %04x",
 		ali15x3_smba);
 	i2c_add_adapter(&ali15x3_adapter);
+	return 0;
 }
 
 static void __devexit ali15x3_remove(struct pci_dev *dev)

