Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265649AbTGDB4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 21:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265652AbTGDBzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 21:55:46 -0400
Received: from granite.he.net ([216.218.226.66]:24590 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265653AbTGDByv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 21:54:51 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10572845531561@kroah.com>
Subject: Re: [PATCH] PCI and sysfs fixes for 2.5.74
In-Reply-To: <10572845532660@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Jul 2003 19:09:13 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1366, 2003/07/03 15:51:30-07:00, willy@debian.org

[PATCH] PCI: Remove pci_bus_exists
Convert all callers of pci_bus_exists() to call pci_find_bus() instead.
Since all callers of pci_find_bus() are __init or __devinit, mark it as
__devinit too.


 arch/i386/pci/legacy.c              |    2 +-
 arch/sh/kernel/cpu/sh4/pci-sh7751.c |    2 +-
 drivers/pci/probe.c                 |   13 +------------
 drivers/pci/search.c                |    5 +++--
 include/linux/pci.h                 |    1 -
 5 files changed, 6 insertions(+), 17 deletions(-)


diff -Nru a/arch/i386/pci/legacy.c b/arch/i386/pci/legacy.c
--- a/arch/i386/pci/legacy.c	Thu Jul  3 18:16:55 2003
+++ b/arch/i386/pci/legacy.c	Thu Jul  3 18:16:55 2003
@@ -28,7 +28,7 @@
 	}
 
 	for (n=0; n <= pcibios_last_bus; n++) {
-		if (pci_bus_exists(&pci_root_buses, n))
+		if (pci_find_bus(0, n))
 			continue;
 		bus->number = n;
 		bus->ops = &pci_root_ops;
diff -Nru a/arch/sh/kernel/cpu/sh4/pci-sh7751.c b/arch/sh/kernel/cpu/sh4/pci-sh7751.c
--- a/arch/sh/kernel/cpu/sh4/pci-sh7751.c	Thu Jul  3 18:16:55 2003
+++ b/arch/sh/kernel/cpu/sh4/pci-sh7751.c	Thu Jul  3 18:16:55 2003
@@ -200,7 +200,7 @@
 		return;
 	PCIDBG(2,"PCI: Peer bridge fixup\n");
 	for (n=0; n <= pcibios_last_bus; n++) {
-		if (pci_bus_exists(&pci_root_buses, n))
+		if (pci_find_bus(0, n))
 			continue;
 		bus.number = n;
 		bus.ops = pci_root_ops;
diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Thu Jul  3 18:16:55 2003
+++ b/drivers/pci/probe.c	Thu Jul  3 18:16:55 2003
@@ -633,22 +633,11 @@
 	return max;
 }
 
-int __devinit pci_bus_exists(const struct list_head *list, int nr)
-{
-	const struct pci_bus *b;
-
-	list_for_each_entry(b, list, node) {
-		if (b->number == nr || pci_bus_exists(&b->children, nr))
-			return 1;
-	}
-	return 0;
-}
-
 struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent, int bus, struct pci_ops *ops, void *sysdata)
 {
 	struct pci_bus *b;
 
-	if (pci_bus_exists(&pci_root_buses, bus)) {
+	if (pci_find_bus(0, bus)) {
 		/* If we already got to this bus through a different bridge, ignore it */
 		DBG("PCI: Bus %02x already known\n", bus);
 		return NULL;
diff -Nru a/drivers/pci/search.c b/drivers/pci/search.c
--- a/drivers/pci/search.c	Thu Jul  3 18:16:55 2003
+++ b/drivers/pci/search.c	Thu Jul  3 18:16:55 2003
@@ -7,13 +7,14 @@
  *	Copyright 2003 -- Greg Kroah-Hartman <greg@kroah.com>
  */
 
+#include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 
 spinlock_t pci_bus_lock = SPIN_LOCK_UNLOCKED;
 
-static struct pci_bus *
+static struct pci_bus * __devinit
 pci_do_find_bus(struct pci_bus* bus, unsigned char busnr)
 {
 	struct pci_bus* child;
@@ -39,7 +40,7 @@
  * in the global list of PCI buses.  If the bus is found, a pointer to its
  * data structure is returned.  If no bus is found, %NULL is returned.
  */
-struct pci_bus * pci_find_bus(int domain, int busnr)
+struct pci_bus * __devinit pci_find_bus(int domain, int busnr)
 {
 	struct pci_bus *bus = NULL;
 	struct pci_bus *tmp_bus;
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Jul  3 18:16:55 2003
+++ b/include/linux/pci.h	Thu Jul  3 18:16:55 2003
@@ -544,7 +544,6 @@
 /* Generic PCI functions used internally */
 
 extern struct pci_bus *pci_find_bus(int domain, int busnr);
-int pci_bus_exists(const struct list_head *list, int nr);
 struct pci_bus *pci_scan_bus_parented(struct device *parent, int bus, struct pci_ops *ops, void *sysdata);
 static inline struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata)
 {

