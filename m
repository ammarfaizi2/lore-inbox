Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262407AbVCSEe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbVCSEe7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 23:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbVCSEel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 23:34:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37008 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262407AbVCSEe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 23:34:29 -0500
Message-ID: <423BABBF.6030103@pobox.com>
Date: Fri, 18 Mar 2005 23:34:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Richard Henderson <rth@twiddle.net>,
       Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
       "chas williams - CONTRACTOR" <chas@cmf.nrl.navy.mil>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Reiner Sailer <sailer@watson.ibm.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] alpha build fixes
Content-Type: multipart/mixed;
 boundary="------------010003020800010807040509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010003020800010807040509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Needed this to build Fedora rawhide kernel (2.6.12-rc1 + some patches) 
on alpha.  This is the upstream portion of the build fixes.

Signed-off-by: Jeff Garzik <jgarzik@pobox.com>


--------------010003020800010807040509
Content-Type: text/x-patch;
 name="kernel-build1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel-build1.patch"

diff -urN ../kernel-2.6.11.orig/linux-2.6.11/drivers/char/agp/generic.c linux-2.6.11/drivers/char/agp/generic.c
--- ../kernel-2.6.11.orig/linux-2.6.11/drivers/char/agp/generic.c	2005-03-18 16:45:23.000000000 -0500
+++ linux-2.6.11/drivers/char/agp/generic.c	2005-03-18 18:34:00.000000000 -0500
@@ -35,6 +35,7 @@
 #include <linux/pm.h>
 #include <linux/agp_backend.h>
 #include <linux/vmalloc.h>
+#include <linux/dma-mapping.h>
 #include <linux/mm.h>
 #include <asm/io.h>
 #include <asm/cacheflush.h>
diff -urN ../kernel-2.6.11.orig/linux-2.6.11/include/asm-alpha/pci.h linux-2.6.11/include/asm-alpha/pci.h
--- ../kernel-2.6.11.orig/linux-2.6.11/include/asm-alpha/pci.h	2005-03-02 02:38:34.000000000 -0500
+++ linux-2.6.11/include/asm-alpha/pci.h	2005-03-18 18:39:31.000000000 -0500
@@ -223,6 +223,12 @@
 	/* Nothing to do. */
 }
 
+/* TODO: integrate with include/asm-generic/pci.h ? */
+static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
+{
+	return channel ? 15 : 14;
+}
+
 extern void pcibios_resource_to_bus(struct pci_dev *, struct pci_bus_region *,
 				    struct resource *);
 
diff -urN ../kernel-2.6.11.orig/linux-2.6.11/include/linux/debugfs.h linux-2.6.11/include/linux/debugfs.h
--- ../kernel-2.6.11.orig/linux-2.6.11/include/linux/debugfs.h	2005-03-02 02:38:33.000000000 -0500
+++ linux-2.6.11/include/linux/debugfs.h	2005-03-18 18:14:12.000000000 -0500
@@ -15,6 +15,8 @@
 #ifndef _DEBUGFS_H_
 #define _DEBUGFS_H_
 
+#include <linux/fs.h>
+
 #if defined(CONFIG_DEBUG_FS)
 struct dentry *debugfs_create_file(const char *name, mode_t mode,
 				   struct dentry *parent, void *data,
diff -ur ../kernel-2.6.11.orig/linux-2.6.11/drivers/atm/lanai.c linux-2.6.11/drivers/atm/lanai.c
--- ../kernel-2.6.11.orig/linux-2.6.11/drivers/atm/lanai.c	2005-03-18 20:06:31.000000000 -0500
+++ linux-2.6.11/drivers/atm/lanai.c	2005-03-18 20:36:19.000000000 -0500
@@ -61,6 +61,7 @@
 #include <asm/byteorder.h>
 #include <linux/spinlock.h>
 #include <linux/pci.h>
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
diff -ur ../kernel-2.6.11.orig/linux-2.6.11/drivers/char/tpm/tpm.h linux-2.6.11/drivers/char/tpm/tpm.h
--- ../kernel-2.6.11.orig/linux-2.6.11/drivers/char/tpm/tpm.h	2005-03-18 20:06:31.000000000 -0500
+++ linux-2.6.11/drivers/char/tpm/tpm.h	2005-03-18 20:50:31.000000000 -0500
@@ -22,6 +22,7 @@
 #include <linux/version.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
+#include <linux/fs.h>
 #include <linux/miscdevice.h>
 
 #define TPM_TIMEOUT msecs_to_jiffies(5)

--------------010003020800010807040509--
