Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269764AbUICUE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269764AbUICUE1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 16:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269786AbUICTeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 15:34:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8876 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269776AbUICTbe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 15:31:34 -0400
Date: Fri, 3 Sep 2004 20:31:33 +0100
From: Matthew Wilcox <willy@debian.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Greg KH <greg@kroah.com>, pcihpd-discuss@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: [PATCH] pci_bus_address [1/5]
Message-ID: <20040903193133.GP642@parcelfarce.linux.theplanet.co.uk>
References: <20040903193027.GO642@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040903193027.GO642@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


pci_bus_address() allows one to convert a global system address to a
local PCI bus address.  In Documentation/IO-mapping.txt terms, this is
a phys_to_bus() call, except that we pass the PCI bus or PCI device so
we know which bus is being referred to.

diff -urpNX build-tools/dontdiff linux-2.6/arch/ia64/pci/pci.c hotplug-2.6/arch/ia64/pci/pci.c
--- linux-2.6/arch/ia64/pci/pci.c	2004-07-20 16:05:26.000000000 -0600
+++ hotplug-2.6/arch/ia64/pci/pci.c	2004-09-02 13:10:03.000000000 -0600
@@ -370,6 +371,27 @@ pcibios_fixup_bus (struct pci_bus *b)
 	return;
 }
 
+unsigned long pcibios_bus_address(struct pci_controller *controller,
+		unsigned long addr, int flags)
+{
+	int i;
+	for (i = 0; i < controller->windows; i++) {
+		struct pci_window *window = &controller->window[i];
+		unsigned long offset = window->offset;
+		unsigned long bus_addr = addr - offset;
+		if ((flags & (IORESOURCE_IO | IORESOURCE_MEM)) !=
+				window->resource.flags)
+			continue;
+		if (bus_addr < window->resource.start)
+			continue;
+		if (window->resource.end < bus_addr)
+			continue;
+		return bus_addr;
+	}
+
+	return addr;
+}
+
 void __devinit
 pcibios_update_irq (struct pci_dev *dev, int irq)
 {
diff -urpNX build-tools/dontdiff linux-2.6/include/asm-ia64/pci.h hotplug-2.6/include/asm-ia64/pci.h
--- linux-2.6/include/asm-ia64/pci.h	2004-03-16 08:40:37.000000000 -0700
+++ hotplug-2.6/include/asm-ia64/pci.h	2004-09-02 13:56:21.000000000 -0600
@@ -119,6 +119,12 @@ static inline void pcibios_add_platform_
 {
 }
 
+extern unsigned long pcibios_bus_address(struct pci_controller *,
+		unsigned long, int);
+
+#define pci_bus_address(busdev, addr, flags) \
+		pcibios_bus_address(PCI_CONTROLLER(busdev), (addr), (flags))
+
 /* generic pci stuff */
 #include <asm-generic/pci.h>
 
diff -urpNX build-tools/dontdiff linux-2.6/include/linux/pci.h hotplug-2.6/include/linux/pci.h
--- linux-2.6/include/linux/pci.h	2004-08-13 08:30:23.000000000 -0600
+++ hotplug-2.6/include/linux/pci.h	2004-09-02 13:55:57.000000000 -0600
@@ -951,6 +951,14 @@ static inline int pci_name_bus(char *nam
 
 #endif /* !CONFIG_PCI */
 
+/*
+ * Convert from a global physical address to a bus-local address.  You can
+ * override this in asm/pci.h
+ */
+#ifndef pci_bus_address
+#define pci_bus_address(busdev, addr, flags) (addr)
+#endif
+
 /* these helpers provide future and backwards compatibility
  * for accessing popular PCI BAR info */
 #define pci_resource_start(dev,bar)   ((dev)->resource[(bar)].start)

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
