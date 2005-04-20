Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVDTAxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVDTAxf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 20:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVDTAwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 20:52:53 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:58590 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S261217AbVDTArg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 20:47:36 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Subject: [PATCH 3/4] ppc64: add a simple nvram lowlevel driver
Date: Wed, 20 Apr 2005 02:22:34 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200504200149.22063.arnd@arndb.de>
In-Reply-To: <200504200149.22063.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504200222.34999.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike pSeries, we don't want to use rtas for accessing nvram
because the nvram device is rather large and it already is
mapped into the physical address space, which makes a much
simpler and faster design possible.

The firmware provides the location and size of the nvram
in the device tree, so it does not really contain any
hardware specific bits and could be used on other
machines as well.
 
From: Utz Bacher <utz.bacher@de.ibm.com>
Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linus-2.5/arch/ppc64/kernel/bpa_nvram.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linus-2.5/arch/ppc64/kernel/bpa_nvram.c	2005-04-20 01:55:36.000000000 +0200
@@ -0,0 +1,118 @@
+/*
+ * NVRAM for CPBW
+ *
+ * (C) Copyright IBM Corp. 2005
+ *
+ * Authors : Utz Bacher <utz.bacher@de.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include <asm/machdep.h>
+#include <asm/nvram.h>
+#include <asm/prom.h>
+
+static void __iomem *bpa_nvram_start;
+static long bpa_nvram_len;
+static spinlock_t bpa_nvram_lock = SPIN_LOCK_UNLOCKED;
+
+static ssize_t bpa_nvram_read(char *buf, size_t count, loff_t *index)
+{
+	unsigned long flags;
+
+	if (*index >= bpa_nvram_len)
+		return 0;
+	if (*index + count > bpa_nvram_len)
+		count = bpa_nvram_len - *index;
+
+	spin_lock_irqsave(&bpa_nvram_lock, flags);
+
+	memcpy_fromio(buf, bpa_nvram_start + *index, count);
+
+	spin_unlock_irqrestore(&bpa_nvram_lock, flags);
+	
+	*index += count;
+	return count;
+}
+
+static ssize_t bpa_nvram_write(char *buf, size_t count, loff_t *index)
+{
+	unsigned long flags;
+
+	if (*index >= bpa_nvram_len)
+		return 0;
+	if (*index + count > bpa_nvram_len)
+		count = bpa_nvram_len - *index;
+
+	spin_lock_irqsave(&bpa_nvram_lock, flags);
+
+	memcpy_toio(bpa_nvram_start + *index, buf, count);
+
+	spin_unlock_irqrestore(&bpa_nvram_lock, flags);
+	
+	*index += count;
+	return count;
+}
+
+static ssize_t bpa_nvram_get_size(void)
+{
+	return bpa_nvram_len;
+}
+
+int __init bpa_nvram_init(void)
+{
+	struct device_node *nvram_node;
+	unsigned long *buffer;
+	int proplen;
+	unsigned long nvram_addr;
+	int ret;
+
+	ret = -ENODEV;
+	nvram_node = of_find_node_by_type(NULL, "nvram");
+	if (!nvram_node)
+		goto out;
+
+	ret = -EIO;
+	buffer = (unsigned long *)get_property(nvram_node, "reg", &proplen);
+	if (proplen != 2*sizeof(unsigned long))
+		goto out;
+
+	ret = -ENODEV;
+	nvram_addr = buffer[0];
+	bpa_nvram_len = buffer[1];
+	if ( (!bpa_nvram_len) || (!nvram_addr) )
+		goto out;
+
+	bpa_nvram_start = ioremap(nvram_addr, bpa_nvram_len);
+	if (!bpa_nvram_start)
+		goto out;
+
+	printk(KERN_INFO "BPA NVRAM, %luk mapped to %p\n",
+	       bpa_nvram_len >> 10, bpa_nvram_start);
+
+	ppc_md.nvram_read	= bpa_nvram_read;
+	ppc_md.nvram_write	= bpa_nvram_write;
+	ppc_md.nvram_size	= bpa_nvram_get_size;
+
+out:
+	of_node_put(nvram_node);
+	return ret;
+}
Index: linus-2.5/include/asm-ppc64/nvram.h
===================================================================
--- linus-2.5.orig/include/asm-ppc64/nvram.h	2005-04-20 01:54:03.000000000 +0200
+++ linus-2.5/include/asm-ppc64/nvram.h	2005-04-20 01:55:36.000000000 +0200
@@ -70,6 +70,7 @@
 
 extern int pSeries_nvram_init(void);
 extern int pmac_nvram_init(void);
+extern int bpa_nvram_init(void);
 
 /* PowerMac specific nvram stuffs */
 

