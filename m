Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbVIAFnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbVIAFnB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 01:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbVIAFnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 01:43:00 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:21726 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964850AbVIAFm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 01:42:59 -0400
Message-ID: <431694B2.4040800@jp.fujitsu.com>
Date: Thu, 01 Sep 2005 14:42:10 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
CC: linux-ia64@vger.kernel.org
Subject: [PATCH 2.6.13] IOCHK interface for I/O error handling/detecting
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements IOCHK interfaces that enable PCI drivers to
detect error and make their error handling easier.

Please refer archives if you need, e.g. http://lwn.net/Articles/139240/

Thanks,
H.Seto

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

---

  drivers/pci/pci.c           |    2 ++
  include/asm-generic/iomap.h |   32 ++++++++++++++++++++++++++++++++
  2 files changed, 34 insertions(+)

Index: linux-2.6.13/include/asm-generic/iomap.h
===================================================================
--- linux-2.6.13.orig/include/asm-generic/iomap.h
+++ linux-2.6.13/include/asm-generic/iomap.h
@@ -65,4 +65,36 @@ struct pci_dev;
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
+/* Dummy definition of default iocookie */
+typedef int iocookie;
+#endif
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
+#ifdef HAVE_ARCH_IOMAP_CHECK
+extern void iochk_init(void);
+extern void iochk_clear(iocookie *cookie, struct pci_dev *dev);
+extern int iochk_read(iocookie *cookie);
+#else
+static inline void iochk_init(void) {}
+static inline void iochk_clear(iocookie *cookie, struct pci_dev *dev) {}
+static inline int iochk_read(iocookie *cookie) { return 0; }
+#endif
+
  #endif
Index: linux-2.6.13/drivers/pci/pci.c
===================================================================
--- linux-2.6.13.orig/drivers/pci/pci.c
+++ linux-2.6.13/drivers/pci/pci.c
@@ -777,6 +777,8 @@ static int __devinit pci_init(void)
  	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
  		pci_fixup_device(pci_fixup_final, dev);
  	}
+
+	iochk_init();
  	return 0;
  }


