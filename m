Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752468AbWAFQg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbWAFQg3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752371AbWAFQ37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:29:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23743 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752448AbWAFQ3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:29:50 -0500
Date: Fri, 6 Jan 2006 16:29:36 GMT
Message-Id: <200601061629.k06GTarX011376@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com
Cc: linux-kernel@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 8/17] FRV: Add pci_iomap
In-Reply-To: <dhowells1136564974@warthog.cambridge.redhat.com>
References: <dhowells1136564974@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch implements pci_iomap() for FRV.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-pci-iomap-2615.diff
 arch/frv/mb93090-mb00/Makefile    |    2 +-
 arch/frv/mb93090-mb00/pci-iomap.c |   29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff -uNrp /warthog/kernels/linux-2.6.15/arch/frv/mb93090-mb00/Makefile linux-2.6.15-frv/arch/frv/mb93090-mb00/Makefile
--- /warthog/kernels/linux-2.6.15/arch/frv/mb93090-mb00/Makefile	2005-03-02 12:07:44.000000000 +0000
+++ linux-2.6.15-frv/arch/frv/mb93090-mb00/Makefile	2006-01-06 14:43:43.000000000 +0000
@@ -3,7 +3,7 @@
 #
 
 ifeq "$(CONFIG_PCI)" "y"
-obj-y := pci-frv.o pci-irq.o pci-vdk.o
+obj-y := pci-frv.o pci-irq.o pci-vdk.o pci-iomap.o
 
 ifeq "$(CONFIG_MMU)" "y"
 obj-y += pci-dma.o
diff -uNrp /warthog/kernels/linux-2.6.15/arch/frv/mb93090-mb00/pci-iomap.c linux-2.6.15-frv/arch/frv/mb93090-mb00/pci-iomap.c
--- /warthog/kernels/linux-2.6.15/arch/frv/mb93090-mb00/pci-iomap.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-frv/arch/frv/mb93090-mb00/pci-iomap.c	2006-01-06 14:43:43.000000000 +0000
@@ -0,0 +1,29 @@
+/* pci-iomap.c: description
+ *
+ * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/pci.h>
+#include <linux/module.h>
+
+void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
+{
+	unsigned long start = pci_resource_start(dev, bar);
+	unsigned long len = pci_resource_len(dev, bar);
+	unsigned long flags = pci_resource_flags(dev, bar);
+
+	if (!len || !start)
+		return NULL;
+
+	if ((flags & IORESOURCE_IO) || (flags & IORESOURCE_MEM))
+		return (void __iomem *) start;
+
+	return NULL;
+}
+
+EXPORT_SYMBOL(pci_iomap);
