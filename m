Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266555AbUJAVxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266555AbUJAVxK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 17:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266473AbUJAVtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 17:49:10 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:4234 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S266427AbUJAVsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 17:48:22 -0400
Date: Sat, 2 Oct 2004 01:48:17 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, parisc-linux@parisc-linux.org
Subject: Re: [PATCH] Sort generic PCI fixups after specific ones
Message-ID: <20041002014817.A24292@jurassic.park.msu.ru>
References: <20040922214304.GS16153@parcelfarce.linux.theplanet.co.uk> <20040923172038.GA8812@kroah.com> <20040923173151.GX16153@parcelfarce.linux.theplanet.co.uk> <20040924023357.A2526@jurassic.park.msu.ru> <20040930174155.GT16153@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040930174155.GT16153@parcelfarce.linux.theplanet.co.uk>; from matthew@wil.cx on Thu, Sep 30, 2004 at 06:41:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 06:41:55PM +0100, Matthew Wilcox wrote:
> Allow prioritising PCI fixups.  "How it works" is covered in the comment
> in pci.h.  The patch to superio.c may well only apply with fuzz to the
> current Linux tree; I include it only to show an example.

No, you missed my point.
What we need is yet another PCI fixup *pass*, not prioritizing fixups
inside *one* pass - see appended patch (compile tested only).
Speaking of IDE: generally, you cannot switch PCI IDE controller
from "compatible" to native mode in the "fixup header" pass, as at this
point PCI BARs are *already* probed, and in compatible mode a lot of IDE
controllers have some bogus (often read-only) values in the BARs 0-3.
That's why quirk_ide_bases() fixup exists in the first place.
So that parisc superio fix works by mere luck - probably because IDE
BARs 0-3 are readable/writable even in legacy mode on this particular
controller.

Ivan.

--- 2.6/include/asm-generic/vmlinux.lds.h	Mon Sep 27 14:38:14 2004
+++ linux/include/asm-generic/vmlinux.lds.h	Fri Oct  1 15:24:30 2004
@@ -18,6 +18,9 @@
 									\
 	/* PCI quirks */						\
 	.pci_fixup        : AT(ADDR(.pci_fixup) - LOAD_OFFSET) {	\
+		VMLINUX_SYMBOL(__start_pci_fixups_early) = .;		\
+		*(.pci_fixup_early)					\
+		VMLINUX_SYMBOL(__end_pci_fixups_early) = .;		\
 		VMLINUX_SYMBOL(__start_pci_fixups_header) = .;		\
 		*(.pci_fixup_header)					\
 		VMLINUX_SYMBOL(__end_pci_fixups_header) = .;		\
--- 2.6/include/linux/pci.h	Mon Sep 27 14:38:23 2004
+++ linux/include/linux/pci.h	Fri Oct  1 16:16:51 2004
@@ -1006,20 +1006,29 @@ struct pci_fixup {
 };
 
 enum pci_fixup_pass {
-	pci_fixup_header,	/* Called immediately after reading configuration header */
+	pci_fixup_early,	/* Called immediately after reading
+				   device/vendor IDs and class code */
+	pci_fixup_header,	/* Called after reading the entire
+				   configuration header (including BARs) */
 	pci_fixup_final,	/* Final phase of device fixups */
 };
 
 /* Anonymous variables would be nice... */
-#define DECLARE_PCI_FIXUP_HEADER(vendor, device, hook)					\
-	static struct pci_fixup __pci_fixup_##vendor##device##hook __attribute_used__	\
-	__attribute__((__section__(".pci_fixup_header"))) = {				\
-		vendor, device, hook };
+#define DECLARE_PCI_FIXUP_SECTION(section, name, vendor, device, hook)	\
+	static struct pci_fixup __pci_fixup_##name __attribute_used__	\
+	__attribute__((__section__( #section ))) = { vendor, device, hook };
 
-#define DECLARE_PCI_FIXUP_FINAL(vendor, device, hook)				\
-	static struct pci_fixup __pci_fixup_##vendor##device##hook __attribute_used__	\
-	__attribute__((__section__(".pci_fixup_final"))) = {				\
-		vendor, device, hook };
+#define DECLARE_PCI_FIXUP_EARLY(vendor, device, hook)			\
+	 DECLARE_PCI_FIXUP_SECTION(.pci_fixup_early,			\
+			vendor##device##hook, vendor, device, hook)
+
+#define DECLARE_PCI_FIXUP_HEADER(vendor, device, hook)			\
+	 DECLARE_PCI_FIXUP_SECTION(.pci_fixup_header,			\
+			vendor##device##hook, vendor, device, hook)
+
+#define DECLARE_PCI_FIXUP_FINAL(vendor, device, hook)			\
+	 DECLARE_PCI_FIXUP_SECTION(.pci_fixup_final,			\
+			vendor##device##hook, vendor, device, hook)
 
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev);
 
--- 2.6/drivers/pci/quirks.c	Mon Sep 27 14:37:45 2004
+++ linux/drivers/pci/quirks.c	Fri Oct  1 16:24:16 2004
@@ -999,6 +999,8 @@ static void pci_do_fixups(struct pci_dev
 	}
 }
 
+extern struct pci_fixup __start_pci_fixups_early[];
+extern struct pci_fixup __end_pci_fixups_early[];
 extern struct pci_fixup __start_pci_fixups_header[];
 extern struct pci_fixup __end_pci_fixups_header[];
 extern struct pci_fixup __start_pci_fixups_final[];
@@ -1009,6 +1011,11 @@ void pci_fixup_device(enum pci_fixup_pas
 	struct pci_fixup *start, *end;
 
 	switch(pass) {
+	case pci_fixup_early:
+		start = __start_pci_fixups_early;
+		end = __end_pci_fixups_early;
+		break;
+
 	case pci_fixup_header:
 		start = __start_pci_fixups_header;
 		end = __end_pci_fixups_header;
--- 2.6/drivers/pci/probe.c	Mon Sep 27 14:37:45 2004
+++ linux/drivers/pci/probe.c	Fri Oct  1 15:30:00 2004
@@ -475,6 +475,9 @@ static int pci_setup_device(struct pci_d
 	/* "Unknown power state" */
 	dev->current_state = 4;
 
+	/* Early fixups, before probing the BARs */
+	pci_fixup_device(pci_fixup_early, dev);
+
 	switch (dev->hdr_type) {		    /* header type */
 	case PCI_HEADER_TYPE_NORMAL:		    /* standard header */
 		if (class == PCI_CLASS_BRIDGE_PCI)
--- 2.6/drivers/parisc/superio.c	Mon Sep 27 14:37:45 2004
+++ linux/drivers/parisc/superio.c	Fri Oct  1 15:32:20 2004
@@ -484,7 +484,7 @@ void superio_fixup_pci(struct pci_dev *p
 	pci_read_config_byte(pdev, PCI_CLASS_PROG, &prog);
 	printk("PCI: Enabled native mode for NS87415 (pif=0x%x)\n", prog);
 }
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_87415, superio_fixup_pci);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_87415, superio_fixup_pci);
 
 /* Because of a defect in Super I/O, all reads of the PCI DMA status 
  * registers, IDE status register and the IDE select register need to be 
