Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262716AbUKLXZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262716AbUKLXZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbUKLXYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:24:14 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:23683 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262688AbUKLXWn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:43 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017161569@kroah.com>
Date: Fri, 12 Nov 2004 15:21:56 -0800
Message-Id: <11003017162945@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2026.66.13, 2004/11/05 15:05:24-08:00, matthew@wil.cx

[PATCH] PCI: add pci_fixup_early

Port Ivan's early PCI fixups patch to 2.6.10-rc1.  Also fix some indentation
to make it less than 80 columns.

From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/probe.c               |    3 +++
 include/asm-generic/vmlinux.lds.h |    3 +++
 include/linux/pci.h               |   34 ++++++++++++++++++----------------
 3 files changed, 24 insertions(+), 16 deletions(-)


diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	2004-11-12 15:13:20 -08:00
+++ b/drivers/pci/probe.c	2004-11-12 15:13:20 -08:00
@@ -478,6 +478,9 @@
 	/* "Unknown power state" */
 	dev->current_state = 4;
 
+	/* Early fixups, before probing the BARs */
+	pci_fixup_device(pci_fixup_early, dev);
+
 	switch (dev->hdr_type) {		    /* header type */
 	case PCI_HEADER_TYPE_NORMAL:		    /* standard header */
 		if (class == PCI_CLASS_BRIDGE_PCI)
diff -Nru a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h	2004-11-12 15:13:20 -08:00
+++ b/include/asm-generic/vmlinux.lds.h	2004-11-12 15:13:20 -08:00
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
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2004-11-12 15:13:20 -08:00
+++ b/include/linux/pci.h	2004-11-12 15:13:20 -08:00
@@ -989,31 +989,33 @@
  */
 
 struct pci_fixup {
-	u16 vendor, device;			/* You can use PCI_ANY_ID here of course */
+	u16 vendor, device;	/* You can use PCI_ANY_ID here of course */
 	void (*hook)(struct pci_dev *dev);
 };
 
 enum pci_fixup_pass {
-	pci_fixup_header,	/* Called immediately after reading configuration header */
+	pci_fixup_early,	/* Before probing BARs */
+	pci_fixup_header,	/* After reading configuration header */
 	pci_fixup_final,	/* Final phase of device fixups */
 	pci_fixup_enable,	/* pci_enable_device() time */
 };
 
 /* Anonymous variables would be nice... */
-#define DECLARE_PCI_FIXUP_HEADER(vendor, device, hook)					\
-	static struct pci_fixup __pci_fixup_##vendor##device##hook __attribute_used__	\
-	__attribute__((__section__(".pci_fixup_header"))) = {				\
-		vendor, device, hook };
-
-#define DECLARE_PCI_FIXUP_FINAL(vendor, device, hook)				\
-	static struct pci_fixup __pci_fixup_##vendor##device##hook __attribute_used__	\
-	__attribute__((__section__(".pci_fixup_final"))) = {				\
-		vendor, device, hook };
-
-#define DECLARE_PCI_FIXUP_ENABLE(vendor, device, hook)				\
-	static struct pci_fixup __pci_fixup_##vendor##device##hook __attribute_used__	\
-	__attribute__((__section__(".pci_fixup_enable"))) = {				\
-		vendor, device, hook };
+#define DECLARE_PCI_FIXUP_SECTION(section, name, vendor, device, hook)	\
+	static struct pci_fixup __pci_fixup_##name __attribute_used__	\
+	__attribute__((__section__(#section))) = { vendor, device, hook };
+#define DECLARE_PCI_FIXUP_EARLY(vendor, device, hook)			\
+	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_early,			\
+			vendor##device##hook, vendor, device, hook)
+#define DECLARE_PCI_FIXUP_HEADER(vendor, device, hook)			\
+	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_header,			\
+			vendor##device##hook, vendor, device, hook)
+#define DECLARE_PCI_FIXUP_FINAL(vendor, device, hook)			\
+	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_final,			\
+			vendor##device##hook, vendor, device, hook)
+#define DECLARE_PCI_FIXUP_ENABLE(vendor, device, hook)			\
+	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_enable,			\
+			vendor##device##hook, vendor, device, hook)
 
 
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev);

