Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262241AbVFIMph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbVFIMph (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 08:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVFIMph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 08:45:37 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:25032 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261539AbVFIMpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 08:45:01 -0400
Message-ID: <42A83A8F.9020503@jp.fujitsu.com>
Date: Thu, 09 Jun 2005 21:48:15 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Cc: Linas Vepstas <linas@austin.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH 01/10] IOCHK interface for I/O error handling/detecting
References: <42A8386F.2060100@jp.fujitsu.com>
In-Reply-To: <42A8386F.2060100@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This is 1 of 10 patches, "iochk-01-generic.patch"]

- It defines:
     a pair of function  : iochk_clear and iochk_read
     a function for init : iochk_init
     type of control var : iocookie
   and describe "no-ops" as its "generic" action.

- HAVE_ARCH_IOMAP_CHECK allows us to change whole definition
   of these functions and type from generic one to specific one.
   See next patch (2 of 10).

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

---

  drivers/pci/pci.c           |    2 ++
  include/asm-generic/iomap.h |   16 ++++++++++++++++
  lib/iomap.c                 |   26 ++++++++++++++++++++++++++
  3 files changed, 44 insertions(+)

Index: linux-2.6.11.11/lib/iomap.c
===================================================================
--- linux-2.6.11.11.orig/lib/iomap.c
+++ linux-2.6.11.11/lib/iomap.c
@@ -210,3 +210,29 @@ void pci_iounmap(struct pci_dev *dev, vo
  }
  EXPORT_SYMBOL(pci_iomap);
  EXPORT_SYMBOL(pci_iounmap);
+
+/*
+ * Clear/Read iocookie to check IO error while using iomap.
+ *
+ * Note that default iochk_clear-read pair interfaces don't have
+ * any effective error check, but some high-reliable platforms
+ * would provide useful information to you.
+ * And note that some action may be limited (ex. irq-unsafe)
+ * between the pair depend on the facility of the platform.
+ */
+#ifndef HAVE_ARCH_IOMAP_CHECK
+void iochk_init(void) { ; }
+
+void iochk_clear(iocookie *cookie, struct pci_dev *dev)
+{
+	/* no-ops */
+}
+
+int iochk_read(iocookie *cookie)
+{
+	/* no-ops */
+	return 0;
+}
+EXPORT_SYMBOL(iochk_clear);
+EXPORT_SYMBOL(iochk_read);
+#endif /* HAVE_ARCH_IOMAP_CHECK */
Index: linux-2.6.11.11/include/asm-generic/iomap.h
===================================================================
--- linux-2.6.11.11.orig/include/asm-generic/iomap.h
+++ linux-2.6.11.11/include/asm-generic/iomap.h
@@ -60,4 +60,20 @@ struct pci_dev;
  extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
  extern void pci_iounmap(struct pci_dev *dev, void __iomem *);

+/*
+ * IOMAP_CHECK provides additional interfaces for drivers to detect
+ * some IO errors, supports drivers having ability to recover errors.
+ *
+ * All works around iomap-check depends on the design of "iocookie"
+ * structure. Every architecture owning its iomap-check is free to
+ * define the actual design of iocookie to fit its special style.
+ */
+#ifndef HAVE_ARCH_IOMAP_CHECK
+typedef unsigned long iocookie;
+#endif
+
+extern void iochk_init(void);
+extern void iochk_clear(iocookie *cookie, struct pci_dev *dev);
+extern int  iochk_read(iocookie *cookie);
+
  #endif
Index: linux-2.6.11.11/drivers/pci/pci.c
===================================================================
--- linux-2.6.11.11.orig/drivers/pci/pci.c
+++ linux-2.6.11.11/drivers/pci/pci.c
@@ -782,6 +782,8 @@ static int __devinit pci_init(void)
  	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
  		pci_fixup_device(pci_fixup_final, dev);
  	}
+
+	iochk_init();
  	return 0;
  }

