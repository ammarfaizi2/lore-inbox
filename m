Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288005AbSAQAAo>; Wed, 16 Jan 2002 19:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288002AbSAQAAd>; Wed, 16 Jan 2002 19:00:33 -0500
Received: from trained-monkey.org ([209.217.122.11]:51212 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id <S287997AbSAQAAV>; Wed, 16 Jan 2002 19:00:21 -0500
From: Jes Sorensen <jes@wildopensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15430.5138.319243.798770@trained-monkey.org>
Date: Wed, 16 Jan 2002 19:00:18 -0500
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [patch] VAIO irq assignment fix
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have gotten a Sony VAIO R505TL laptop which has a Richo RL5C574
Cardbus controller however the broken bios doesn't assign an irq to the
controller even though it is attached.

This patch solves the problem and makes cardbus insert/eject a lot more
stable for me.

Cheers,
Jes
--- ../linux-2.4.18-pre2/arch/i386/kernel/dmi_scan.c	Fri Dec 21 12:41:53 2001
+++ arch/i386/kernel/dmi_scan.c	Wed Jan 16 18:36:05 2002
@@ -5,6 +5,7 @@
 #include <linux/init.h>
 #include <linux/apm_bios.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
 #include <asm/io.h>
 #include <linux/pm.h>
 #include <asm/keyboard.h>
@@ -416,6 +417,26 @@
 
 
 /*
+ * Work around broken Sony VAIO Notebooks which do not assign irqs
+ * to their Richo RL5C475 Cardbus controller, IRQ is 9.
+ */
+static __init int fix_broken_sony_bios_irq(struct dmi_blacklist *d)
+{
+	struct pci_dev *pdev = NULL;
+
+	pdev = pci_find_device(PCI_VENDOR_ID_RICOH,
+			       PCI_DEVICE_ID_RICOH_RL5C475, pdev);
+	if (pdev) {
+		pdev->irq = 9;
+		pci_write_config_byte(pdev, PCI_INTERRUPT_LINE, 9);
+		printk(KERN_INFO "%s detected - fixing missing/"
+		       "broken IRQ routing\n", d->ident);
+	}
+	return 0;
+}
+
+
+/*
  *	Simple "print if true" callback
  */
  
@@ -614,7 +635,13 @@
 			NO_MATCH, NO_MATCH
 			} },
 	 
-			
+	{ fix_broken_sony_bios_irq, "Sony VAIO R505TL Series Laptop", {
+			MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			MATCH(DMI_BIOS_VERSION, "R0202U1"),
+			NO_MATCH
+			} },
+
 	/*
 	 *	Generic per vendor APM settings
 	 */
