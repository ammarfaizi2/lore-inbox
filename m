Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263205AbTCNA5W>; Thu, 13 Mar 2003 19:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263211AbTCNA5R>; Thu, 13 Mar 2003 19:57:17 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:60939 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263206AbTCNAzt>;
	Thu, 13 Mar 2003 19:55:49 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.64
In-reply-to: <1047603322689@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Thu, 13 Mar 2003 16:55 -0800
Message-id: <10476033233796@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1111, 2003/03/13 12:16:52-08:00, greg@kroah.com

i2c: i2c-piix4.c: Clean up the ibm dma scan logic

Also export the is_unsafe_smbus variable, which is needed.


 arch/i386/kernel/dmi_scan.c    |    3 +++
 drivers/i2c/busses/i2c-piix4.c |   20 ++------------------
 2 files changed, 5 insertions(+), 18 deletions(-)


diff -Nru a/arch/i386/kernel/dmi_scan.c b/arch/i386/kernel/dmi_scan.c
--- a/arch/i386/kernel/dmi_scan.c	Thu Mar 13 16:57:17 2003
+++ b/arch/i386/kernel/dmi_scan.c	Thu Mar 13 16:57:17 2003
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/apm_bios.h>
 #include <linux/slab.h>
 #include <asm/io.h>
@@ -893,3 +894,5 @@
 	if(err == 0)
 		dmi_check_blacklist();
 }
+
+EXPORT_SYMBOL(is_unsafe_smbus);
diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Thu Mar 13 16:57:17 2003
+++ b/drivers/i2c/busses/i2c-piix4.c	Thu Mar 13 16:57:17 2003
@@ -28,7 +28,6 @@
    Note: we assume there can only be one device, with one SMBus interface.
 */
 
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/pci.h>
@@ -104,31 +103,18 @@
 
 static unsigned short piix4_smba = 0;
 
-#ifdef CONFIG_X86
 /*
  * Get DMI information.
  */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,34)
-void dmi_scan_mach(void);
-#endif
-
-static int __init ibm_dmi_probe(void)
+static int ibm_dmi_probe(void)
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,34)
+#ifdef CONFIG_X86
 	extern int is_unsafe_smbus;
 	return is_unsafe_smbus;
 #else
-#define IBM_SIGNATURE		"IBM"
-	dmi_scan_mach();
-	if(dmi_ident[DMI_SYS_VENDOR] == NULL)
-		return 0;
-	if(strncmp(dmi_ident[DMI_SYS_VENDOR], IBM_SIGNATURE,
-	           strlen(IBM_SIGNATURE)) == 0)
-		return 1;
 	return 0;
 #endif
 }
-#endif
 
 static int piix4_setup(struct pci_dev *PIIX4_dev, const struct pci_device_id *id)
 {
@@ -141,7 +127,6 @@
 
 	printk(KERN_INFO "i2c-piix4.o: Found %s device\n", PIIX4_dev->dev.name);
 
-#ifdef CONFIG_X86
 	if(ibm_dmi_probe()) {
 		printk
 		  (KERN_ERR "i2c-piix4.o: IBM Laptop detected; this module may corrupt\n");
@@ -150,7 +135,6 @@
 		 error_return = -EPERM;
 		 goto END;
 	}
-#endif
 
 /* Determine the address of the SMBus areas */
 	if (force_addr) {

