Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265022AbUGTBMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265022AbUGTBMn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 21:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbUGTBMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 21:12:43 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:53462 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265022AbUGTBMj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 21:12:39 -0400
Subject: [PATCH] x445 usb legacy fix
From: john stultz <johnstul@us.ibm.com>
To: greg kh <greg@kroah.com>
Cc: lkml <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Content-Type: text/plain
Message-Id: <1090286508.1388.434.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 19 Jul 2004 18:21:49 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg, All,
	Apparently there is an issue w/ the IBM x440/x445's BIOS's USB Legacy
support. Due to the delay in issuing SMI's across the IOAPICs, its
possible for I/O to ports 60/64 to cause register corruption. 

The solution is to disable the BIOS's USB Legacy support early in boot
(via PCI quirks) for x440/x445 systems. 

This is the same method posted to lkml here (Originally written by
Vojtech): http://www.ussg.iu.edu/hypermail/linux/kernel/0405.3/1712.html

(Use the following link for the raw mbox email)
http://lkml.org/lkml/mbox/2004/5/31/97

While Greg was cautious that this method couldn't always be used, I've
created a patch that applies on top of Vojtech's that creates a boot
option which allows you to specify "no-usb-legacy". Additionally this
patch enables the "no-usb-legacy" option by default for x440/x445
systems.

Please consider for inclusion (along with the patch linked to above)
into your tree. 

thanks
-john

diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	Mon Jul 19 18:06:40 2004
+++ b/Documentation/kernel-parameters.txt	Mon Jul 19 18:06:40 2004
@@ -757,6 +757,8 @@
 
 	nousb		[USB] Disable the USB subsystem
 
+	no-usb-legacy	[USB] Disables BIOS SMM USB Legacy Support
+
 	nowb		[ARM]
  
 	opl3=		[HW,OSS]
diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	Mon Jul 19 18:06:40 2004
+++ b/drivers/pci/quirks.c	Mon Jul 19 18:06:40 2004
@@ -916,8 +916,18 @@
 #define OHCI_CTRL_IR		(1 << 8)	/* interrupt routing */
 #define OHCI_INTR_OC		(1 << 30)	/* ownership change */
 
+int disable_legacy_usb __initdata = 0;
+static int __init usb_legacy_disable(char *str)
+{
+	disable_legacy_usb = 1;
+	return 0;
+}
+__setup("no-usb-legacy", usb_legacy_disable);
+
 static void __init quirk_usb_disable_smm_bios(struct pci_dev *pdev)
 {
+	if (!disable_legacy_usb)
+		return;
 
 	if (pdev->class == ((PCI_CLASS_SERIAL_USB << 8) | 0x00)) { /* UHCI */
 		int i;
diff -Nru a/include/asm-i386/mach-summit/mach_mpparse.h b/include/asm-i386/mach-summit/mach_mpparse.h
--- a/include/asm-i386/mach-summit/mach_mpparse.h	Mon Jul 19 18:06:40 2004
+++ b/include/asm-i386/mach-summit/mach_mpparse.h	Mon Jul 19 18:06:40 2004
@@ -22,6 +22,7 @@
 {
 }
 
+extern int disable_legacy_usb;
 static inline int mps_oem_check(struct mp_config_table *mpc, char *oem, 
 		char *productid)
 {
@@ -31,6 +32,7 @@
 			 || !strncmp(productid, "RUTHLESS SMP", 12))){
 		use_cyclone = 1; /*enable cyclone-timer*/
 		setup_summit();
+		disable_legacy_usb = 1;
 		return 1;
 	}
 	return 0;
@@ -44,6 +46,7 @@
 	     || !strncmp(oem_table_id, "EXA", 3))){
 		use_cyclone = 1; /*enable cyclone-timer*/
 		setup_summit();
+		disable_legacy_usb = 1;
 		return 1;
 	}
 	return 0;


