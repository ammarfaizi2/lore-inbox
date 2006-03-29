Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWC2X0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWC2X0j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 18:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWC2XZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 18:25:20 -0500
Received: from mx.pathscale.com ([64.160.42.68]:28360 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751260AbWC2XXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 18:23:55 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 16 of 16] ipath - kbuild infrastructure
X-Mercurial-Node: 36bfb4f1ad322a8fb23ebb1aa3b9e23fd9fee1e3
Message-Id: <36bfb4f1ad322a8fb23e.1143674619@chalcedony.internal.keyresearch.com>
In-Reply-To: <patchbomb.1143674603@chalcedony.internal.keyresearch.com>
Date: Wed, 29 Mar 2006 15:23:39 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Integrate the ipath core and OpenIB drivers into the kernel build
infrastructure.  Add entry to MAINTAINERS.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 330bb2948042 -r 36bfb4f1ad32 MAINTAINERS
--- a/MAINTAINERS	Wed Mar 29 15:21:27 2006 -0800
+++ b/MAINTAINERS	Wed Mar 29 15:21:27 2006 -0800
@@ -1450,6 +1450,12 @@ P:	Juanjo Ciarlante
 P:	Juanjo Ciarlante
 M:	jjciarla@raiz.uncu.edu.ar
 S:	Maintained
+
+IPATH DRIVER:
+P:	Bryan O'Sullivan
+M:	support@pathscale.com
+L:	openib-general@openib.org
+S:	Supported
 
 IPX NETWORK LAYER
 P:	Arnaldo Carvalho de Melo
diff -r 330bb2948042 -r 36bfb4f1ad32 drivers/infiniband/Kconfig
--- a/drivers/infiniband/Kconfig	Wed Mar 29 15:21:27 2006 -0800
+++ b/drivers/infiniband/Kconfig	Wed Mar 29 15:21:27 2006 -0800
@@ -30,6 +30,7 @@ config INFINIBAND_USER_ACCESS
 	  <http://www.openib.org>.
 
 source "drivers/infiniband/hw/mthca/Kconfig"
+source "drivers/infiniband/hw/ipath/Kconfig"
 
 source "drivers/infiniband/ulp/ipoib/Kconfig"
 
diff -r 330bb2948042 -r 36bfb4f1ad32 drivers/infiniband/Makefile
--- a/drivers/infiniband/Makefile	Wed Mar 29 15:21:27 2006 -0800
+++ b/drivers/infiniband/Makefile	Wed Mar 29 15:21:27 2006 -0800
@@ -1,4 +1,5 @@ obj-$(CONFIG_INFINIBAND)		+= core/
 obj-$(CONFIG_INFINIBAND)		+= core/
 obj-$(CONFIG_INFINIBAND_MTHCA)		+= hw/mthca/
+obj-$(CONFIG_IPATH_CORE)		+= hw/ipath/
 obj-$(CONFIG_INFINIBAND_IPOIB)		+= ulp/ipoib/
 obj-$(CONFIG_INFINIBAND_SRP)		+= ulp/srp/
diff -r 330bb2948042 -r 36bfb4f1ad32 drivers/infiniband/hw/ipath/Kconfig
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/Kconfig	Wed Mar 29 15:21:27 2006 -0800
@@ -0,0 +1,16 @@
+config IPATH_CORE
+	tristate "PathScale InfiniPath Driver"
+	depends on 64BIT && PCI_MSI
+	---help---
+	This is a low-level driver for PathScale InfiniPath host channel
+	adapters (HCAs) based on the HT-400 and PE-800 chips.
+
+config INFINIBAND_IPATH
+	tristate "PathScale InfiniPath Verbs Driver"
+	depends on IPATH_CORE && INFINIBAND
+	---help---
+	This is a driver that provides InfiniBand verbs support for
+	PathScale InfiniPath host channel adapters (HCAs).  This
+	allows these devices to be used with both kernel upper level
+	protocols such as IP-over-InfiniBand as well as with userspace
+	applications (in conjunction with InfiniBand userspace access).
diff -r 330bb2948042 -r 36bfb4f1ad32 drivers/infiniband/hw/ipath/Makefile
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/Makefile	Wed Mar 29 15:21:27 2006 -0800
@@ -0,0 +1,36 @@
+EXTRA_CFLAGS += -DIPATH_IDSTR='"PathScale kernel.org driver"' \
+	-DIPATH_KERN_TYPE=0
+
+obj-$(CONFIG_IPATH_CORE) += ipath_core.o
+obj-$(CONFIG_INFINIBAND_IPATH) += ib_ipath.o
+
+ipath_core-y := \
+	ipath_diag.o \
+	ipath_driver.o \
+	ipath_eeprom.o \
+	ipath_file_ops.o \
+	ipath_fs.o \
+	ipath_ht400.o \
+	ipath_init_chip.o \
+	ipath_intr.o \
+	ipath_layer.o \
+	ipath_pe800.o \
+	ipath_stats.o \
+	ipath_sysfs.o \
+	ipath_user_pages.o
+
+ipath_core-$(CONFIG_X86_64) += ipath_wc_x86_64.o
+
+ib_ipath-y := \
+	ipath_cq.o \
+	ipath_keys.o \
+	ipath_mad.o \
+	ipath_mr.o \
+	ipath_qp.o \
+	ipath_rc.o \
+	ipath_ruc.o \
+	ipath_srq.o \
+	ipath_uc.o \
+	ipath_ud.o \
+	ipath_verbs.o \
+	ipath_verbs_mcast.o
