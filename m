Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269367AbUI3RmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269367AbUI3RmI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 13:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269370AbUI3RmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 13:42:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32227 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269367AbUI3Rl6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 13:41:58 -0400
Date: Thu, 30 Sep 2004 18:41:55 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       parisc-linux@parisc-linux.org
Subject: Re: [PATCH] Sort generic PCI fixups after specific ones
Message-ID: <20040930174155.GT16153@parcelfarce.linux.theplanet.co.uk>
References: <20040922214304.GS16153@parcelfarce.linux.theplanet.co.uk> <20040923172038.GA8812@kroah.com> <20040923173151.GX16153@parcelfarce.linux.theplanet.co.uk> <20040924023357.A2526@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924023357.A2526@jurassic.park.msu.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 02:33:57AM +0400, Ivan Kokshaysky wrote:
> I believe we do need third level of fixups, specifically for devices like
> IDE which can change the PCI header contents (class code, BAR layout etc.)
> depending on some magic bits in their registers.
> Such "early" or "pre-header" fixups should be called right after the device
> discovery, before probing the BARs. Apparently pci_setup_device()
> is a proper place for that.

OK, fine.

Allow prioritising PCI fixups.  "How it works" is covered in the comment
in pci.h.  The patch to superio.c may well only apply with fuzz to the
current Linux tree; I include it only to show an example.

Index: linux-2.6/drivers/parisc/superio.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/parisc/superio.c,v
retrieving revision 1.11
diff -u -p -r1.11 superio.c
--- linux-2.6/drivers/parisc/superio.c	28 Sep 2004 17:07:01 -0000	1.11
+++ linux-2.6/drivers/parisc/superio.c	30 Sep 2004 17:36:34 -0000
@@ -481,7 +481,7 @@ void superio_fixup_pci(struct pci_dev *p
 	pci_read_config_byte(pdev, PCI_CLASS_PROG, &prog);
 	printk("PCI: Enabled native mode for NS87415 (pif=0x%x)\n", prog);
 }
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_87415, superio_fixup_pci);
+DECLARE_PCI_FIXUP_HEADER_PRI(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_87415, superio_fixup_pci, 1);
 
 
 static int __devinit superio_probe(struct pci_dev *dev, const struct pci_device_id *id)
Index: linux-2.6/include/asm-generic/vmlinux.lds.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-generic/vmlinux.lds.h,v
retrieving revision 1.4
diff -u -p -r1.4 vmlinux.lds.h
--- linux-2.6/include/asm-generic/vmlinux.lds.h	13 Sep 2004 15:24:02 -0000	1.4
+++ linux-2.6/include/asm-generic/vmlinux.lds.h	30 Sep 2004 17:36:35 -0000
@@ -19,10 +19,14 @@
 	/* PCI quirks */						\
 	.pci_fixup        : AT(ADDR(.pci_fixup) - LOAD_OFFSET) {	\
 		VMLINUX_SYMBOL(__start_pci_fixups_header) = .;		\
-		*(.pci_fixup_header)					\
+		*(.pci_fixup_header1)					\
+		*(.pci_fixup_header2)					\
+		*(.pci_fixup_header3)					\
 		VMLINUX_SYMBOL(__end_pci_fixups_header) = .;		\
 		VMLINUX_SYMBOL(__start_pci_fixups_final) = .;		\
-		*(.pci_fixup_final)					\
+		*(.pci_fixup_final1)					\
+		*(.pci_fixup_final2)					\
+		*(.pci_fixup_final3)					\
 		VMLINUX_SYMBOL(__end_pci_fixups_final) = .;		\
 	}								\
 									\
Index: linux-2.6/include/linux/pci.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/pci.h,v
retrieving revision 1.18
diff -u -p -r1.18 pci.h
--- linux-2.6/include/linux/pci.h	13 Sep 2004 15:24:12 -0000	1.18
+++ linux-2.6/include/linux/pci.h	30 Sep 2004 17:36:36 -0000
@@ -1010,16 +1010,29 @@ enum pci_fixup_pass {
 	pci_fixup_final,	/* Final phase of device fixups */
 };
 
-/* Anonymous variables would be nice... */
-#define DECLARE_PCI_FIXUP_HEADER(vendor, device, hook)					\
-	static struct pci_fixup __pci_fixup_##vendor##device##hook __attribute_used__	\
-	__attribute__((__section__(".pci_fixup_header"))) = {				\
-		vendor, device, hook };
-
-#define DECLARE_PCI_FIXUP_FINAL(vendor, device, hook)				\
-	static struct pci_fixup __pci_fixup_##vendor##device##hook __attribute_used__	\
-	__attribute__((__section__(".pci_fixup_final"))) = {				\
+/*
+ * Most fixups should be declared as DECLARE_PCI_FIXUP_HEADER() or
+ * DECLARE_PCI_FIXUP_FINAL().  If you need to ensure ordering, you can
+ * specify a priority.  Current available priorities are 1, 2 (the default)
+ * and 3.  If you need to add more priorities, see
+ * include/asm-generic/vmlinux.lds.h
+ */
+#define DECLARE_PCI_FIXUP_SECTION(section, name, vendor, device, hook)	\
+	static struct pci_fixup __pci_fixup_##name			\
+	__attribute_used__ __attribute__((__section__( #section ))) = {	\
 		vendor, device, hook };
+#define DECLARE_PCI_FIXUP_HEADER(vendor, device, hook)			\
+	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_header2,			\
+			vendor##device##hook, vendor, device, hook)
+#define DECLARE_PCI_FIXUP_HEADER_PRI(vendor, device, hook, pri)		\
+	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_header##pri,		\
+			vendor##device##hook, vendor, device, hook)
+#define DECLARE_PCI_FIXUP_FINAL(vendor, device, hook)			\
+	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_final2,			\
+			vendor##device##hook, vendor, device, hook)
+#define DECLARE_PCI_FIXUP_FINAL_PRI(vendor, device, hook, pri)		\
+	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_final##pri,		\
+			vendor##device##hook, vendor, device, hook)
 
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev);
 

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
