Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268747AbTBZNiv>; Wed, 26 Feb 2003 08:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268748AbTBZNiv>; Wed, 26 Feb 2003 08:38:51 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:46020 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S268747AbTBZNit>; Wed, 26 Feb 2003 08:38:49 -0500
Date: Wed, 26 Feb 2003 13:49:00 GMT
Message-Id: <200302261349.h1QDn06X002823@deviant.impure.org.uk>
To: torvalds@transmeta.com, alan@redhat.com
Cc: linux-kernel@vger.kernel.org
From: davej@codemonkey.org.uk
Subject: Tighten up serverworks workaround.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aparently on rev6 of the LE and above, this workaround
isn't needed. Lets give it a try, and see what happens.

    Dave

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/cpu/mtrr/main.c linux-2.5/arch/i386/kernel/cpu/mtrr/main.c
--- bk-linus/arch/i386/kernel/cpu/mtrr/main.c	2003-02-25 13:10:08.000000000 -0100
+++ linux-2.5/arch/i386/kernel/cpu/mtrr/main.c	2003-02-24 16:36:06.000000000 -0100
@@ -75,20 +75,24 @@ void set_mtrr_ops(struct mtrr_ops * ops)
 static int have_wrcomb(void)
 {
 	struct pci_dev *dev = NULL;
-
-	/* WTF is this?
-	 * Someone, please shoot me.
-	 */
-
-	/* ServerWorks LE chipsets have problems with write-combining 
-	   Don't allow it and leave room for other chipsets to be tagged */
+	u8 rev;
 
 	if ((dev = pci_find_class(PCI_CLASS_BRIDGE_HOST << 8, NULL)) != NULL) {
 		if ((dev->vendor == PCI_VENDOR_ID_SERVERWORKS) &&
 		    (dev->device == PCI_DEVICE_ID_SERVERWORKS_LE)) {
-			printk(KERN_INFO
-			       "mtrr: Serverworks LE detected. Write-combining disabled.\n");
-			return 0;
+
+			/* ServerWorks LE chipsets have problems with write-combining 
+			   Don't allow it and leave room for other chipsets to be tagged.
+			   Rumour has it that rev6 and above are ok. */
+			pci_read_config_byte(dev, PCI_CLASS_REVISION, &rev);  
+			if (rev > 5) {
+				printk ("mtrr: Serverworks LE rev %d detected. Earlier versions of this chipset had mtrr bugs\n", rev);
+				printk ("mtrr: Please send mail to linux-kernel@vger.kernel.org if this seems stable.\n");
+				return 1;
+			} else {
+				printk(KERN_INFO "mtrr: Serverworks LE detected. Write-combining disabled.\n");
+				return 0;
+			}
 		}
 	}
 	return (mtrr_if->have_wrcomb ? mtrr_if->have_wrcomb() : 0);
