Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262147AbREMR3r>; Sun, 13 May 2001 13:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262088AbREMR2r>; Sun, 13 May 2001 13:28:47 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:6827 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S263010AbREMR2K>;
	Sun, 13 May 2001 13:28:10 -0400
Message-ID: <3AFEC426.50B00B78@mandrakesoft.com>
Date: Sun, 13 May 2001 13:28:06 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: arjanv@redhat.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Axel Thimm <Axel.Thimm@physik.fu-berlin.de>,
        "Manuel A. McLure" <mmt@unify.com>,
        " Rasmus =?iso-8859-1?Q?B=F8g?= Hansen" <moffe@amagerkollegiet.dk>,
        ARND BERGMANN <std7652@et.FH-Osnabrueck.DE>,
        "Dunlap, Randy" <randy.dunlap@intel.com>,
        Martin Diehl <mdiehlcs@compuserve.de>,
        Adrian Cox <adrian@humboldt.co.uk>, Capricelli Thomas <orzel@kde.org>,
        Ian Bicking <ianb@colorstudy.com>, John R Lenton <john@grulic.org.ar>
Subject: PATCH 2.4.5.1: Fix Via interrupt routing issues
Content-Type: multipart/mixed;
 boundary="------------E89EDF00138382F9963F6295"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E89EDF00138382F9963F6295
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

For those of you with Via interrupting routing issues (or
interrupt-not-being-delivered issues, etc), please try out this patch
and let me know if it fixes things.  It originates from a tip from
Adrian Cox... thanks Adrian!

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
--------------E89EDF00138382F9963F6295
Content-Type: text/plain; charset=us-ascii;
 name="via-apic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="via-apic.patch"

Index: drivers/pci/quirks.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/pci/quirks.c,v
retrieving revision 1.1.1.35
diff -u -r1.1.1.35 quirks.c
--- drivers/pci/quirks.c	2001/05/02 09:26:23	1.1.1.35
+++ drivers/pci/quirks.c	2001/05/13 17:22:18
@@ -12,6 +12,7 @@
  *  use the PowerTweak utility (see http://powertweak.sourceforge.net).
  */
 
+#include <linux/config.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
@@ -238,7 +239,34 @@
 	quirk_io_region(dev, smb, 16, PCI_BRIDGE_RESOURCES + 2);
 }
 
+
+/* we will likely need a better ifdef, something like 
+ * ifdef CONFIG_EXTERNAL_APIC
+ */
+#ifdef CONFIG_X86_IO_APIC 
+extern int nr_ioapics;
+
 /*
+ * VIA 686A/B: If an IO-APIC is active, we need to route all on-chip
+ * devices to the external APIC.
+ */
+static void __init quirk_via_ioapic(struct pci_dev *dev)
+{
+	u8 tmp;
+	
+	if (nr_ioapics < 1)
+		tmp = 0;    /* nothing routed to external APIC */
+	else
+		tmp = 0x1f; /* all known bits (4-0) routed to external APIC */
+		
+	/* Offset 0x58: External APIC IRQ output control */
+	pci_write_config_byte (dev, 0x58, tmp);
+}
+
+#endif /* CONFIG_X86_IO_APIC */
+
+
+/*
  * PIIX3 USB: We have to disable USB interrupts that are
  * hardwired to PIRQD# and may be shared with an
  * external device.
@@ -322,6 +350,14 @@
  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371SB_2,	quirk_piix3_usb },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_2,	quirk_piix3_usb },
 	{ PCI_FIXUP_FINAL,	PCI_ANY_ID,		PCI_ANY_ID,			quirk_cardbus_legacy },
+
+/* we will likely need a better ifdef, something like 
+ * ifdef CONFIG_EXTERNAL_APIC
+ */
+#ifdef CONFIG_X86_IO_APIC 
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686,	quirk_via_ioapic },
+#endif
+
 	{ 0 }
 };
 

--------------E89EDF00138382F9963F6295--

