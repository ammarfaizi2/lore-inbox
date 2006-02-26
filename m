Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWBZQCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWBZQCu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 11:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWBZQCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 11:02:50 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:42673 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751246AbWBZQCt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 11:02:49 -0500
Date: Sun, 26 Feb 2006 09:02:47 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: hch@infradead.org, alan@lxorguk.ukuu.org.uk, erich@areca.com.tw,
       arjan@infradead.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, billion.wu@areca.com.tw, akpm@osdl.org,
       oliver@neukum.org
Subject: Re: Areca RAID driver remaining items?
Message-ID: <20060226160247.GT28587@parisc-linux.org>
References: <001401c63779$12e49aa0$b100a8c0@erich2003> <20060222145733.GC16269@infradead.org> <00dc01c63842$381f9a30$b100a8c0@erich2003> <1140683157.2972.6.camel@laptopd505.fenrus.org> <001901c6385e$9aee7d40$b100a8c0@erich2003> <1140695990.19361.8.camel@localhost.localdomain> <20060224165647.GA4176@infradead.org> <Pine.LNX.4.58.0602240858180.7894@shark.he.net> <20060224193830.GR28587@parisc-linux.org> <20060225224112.72c20f2f.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060225224112.72c20f2f.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 10:41:12PM -0800, Randy.Dunlap wrote:
> OK, updated patch for "pci=nomsi" is now at
>   http://www.xenotime.net/linux/patches/pci_nomsi.patch

After sleeping on it, I realised this wouldn't work if CONFIG_PCI_MSI
is disabled.  So how about this (not even compile-tested):

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

Index: ./Documentation/kernel-parameters.txt
===================================================================
RCS file: /var/cvs/linux-2.6/Documentation/kernel-parameters.txt,v
retrieving revision 1.41.4.1
diff -u -p -r1.41.4.1 kernel-parameters.txt
--- ./Documentation/kernel-parameters.txt	18 Feb 2006 05:26:01 -0000	1.41.4.1
+++ ./Documentation/kernel-parameters.txt	26 Feb 2006 15:58:40 -0000
@@ -49,6 +49,7 @@ restrictions referred to are that the re
 	MCA	MCA bus support is enabled.
 	MDA	MDA console support is enabled.
 	MOUSE	Appropriate mouse support is enabled.
+	MSI	Message Signaled Interrupts (PCI).
 	MTD	MTD support is enabled.
 	NET	Appropriate network support is enabled.
 	NUMA	NUMA support is enabled.
@@ -1135,6 +1136,9 @@ running once the system is up.
 				Mechanism 2.
 		nommconf	[IA-32,X86_64] Disable use of MMCONFIG for PCI
 				Configuration
+		nomsi		[MSI] If the PCI_MSI kernel config parameter is
+				enabled, this kernel boot option can be used to
+				disable the use of MSI interrupts system-wide.
 		nosort		[IA-32] Don't sort PCI devices according to
 				order given by the PCI BIOS. This sorting is
 				done to get a device order compatible with
Index: ./drivers/pci/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/pci/Kconfig,v
retrieving revision 1.8
diff -u -p -r1.8 Kconfig
--- ./drivers/pci/Kconfig	14 Sep 2005 12:56:32 -0000	1.8
+++ ./drivers/pci/Kconfig	26 Feb 2006 15:58:40 -0000
@@ -11,6 +11,10 @@ config PCI_MSI
 	   generate an interrupt using an inbound Memory Write on its
 	   PCI bus instead of asserting a device IRQ pin.
 
+	   Use of PCI MSI interrupts can be disabled at kernel boot time
+	   by using the 'pci=nomsi' option.  This disables MSI for the
+	   entire system.
+
 	   If you don't know what to do here, say N.
 
 config PCI_LEGACY_PROC
Index: ./drivers/pci/msi.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/pci/msi.c,v
retrieving revision 1.17
diff -u -p -r1.17 msi.c
--- ./drivers/pci/msi.c	4 Feb 2006 04:51:55 -0000	1.17
+++ ./drivers/pci/msi.c	26 Feb 2006 15:58:40 -0000
@@ -755,6 +755,9 @@ void pci_disable_msi(struct pci_dev* dev
 	u16 control;
 	unsigned long flags;
 
+	if (!pci_msi_enable)
+ 		return;
+
    	if (!dev || !(pos = pci_find_capability(dev, PCI_CAP_ID_MSI)))
 		return;
 
@@ -1006,6 +1009,9 @@ void pci_disable_msix(struct pci_dev* de
 	int pos, temp;
 	u16 control;
 
+	if (!pci_msi_enable)
+ 		return;
+
    	if (!dev || !(pos = pci_find_capability(dev, PCI_CAP_ID_MSIX)))
 		return;
 
@@ -1121,6 +1127,11 @@ void msi_remove_pci_irq_vectors(struct p
 		}
 		dev->irq = temp;		/* Restore IOAPIC IRQ */
 	}
+}
+
+void pci_no_msi(void)
+{
+	pci_msi_enable = 0;
 }
 
 EXPORT_SYMBOL(pci_enable_msi);
Index: ./drivers/pci/pci.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/pci/pci.c,v
retrieving revision 1.28
diff -u -p -r1.28 pci.c
--- ./drivers/pci/pci.c	4 Feb 2006 04:51:55 -0000	1.28
+++ ./drivers/pci/pci.c	26 Feb 2006 15:58:40 -0000
@@ -900,8 +900,12 @@ static int __devinit pci_setup(char *str
 		if (k)
 			*k++ = 0;
 		if (*str && (str = pcibios_setup(str)) && *str) {
-			/* PCI layer options should be handled here */
-			printk(KERN_ERR "PCI: Unknown option `%s'\n", str);
+			if (!strcmp(str, "nomsi")) {
+				pci_no_msi();
+			} else {
+				printk(KERN_ERR "PCI: Unknown option `%s'\n",
+						str);
+			}
 		}
 		str = k;
 	}
Index: ./drivers/pci/pci.h
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/pci/pci.h,v
retrieving revision 1.13
diff -u -p -r1.13 pci.h
--- ./drivers/pci/pci.h	17 Jan 2006 14:51:41 -0000	1.13
+++ ./drivers/pci/pci.h	26 Feb 2006 15:58:40 -0000
@@ -50,8 +50,10 @@ extern int pci_msi_quirk;
 
 #ifdef CONFIG_PCI_MSI
 void disable_msi_mode(struct pci_dev *dev, int pos, int type);
+void pci_no_msi(void);
 #else
 static inline void disable_msi_mode(struct pci_dev *dev, int pos, int type) { }
+static inline void pci_no_msi(void) { }
 #endif
 
 extern int pcie_mch_quirk;
