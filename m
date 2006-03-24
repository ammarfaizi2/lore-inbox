Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423021AbWCXEmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423021AbWCXEmi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 23:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423020AbWCXEmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 23:42:33 -0500
Received: from mx.pathscale.com ([64.160.42.68]:36075 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1423022AbWCXEl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 23:41:58 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 18 of 18] ipath - kbuild infrastructure
X-Mercurial-Node: d303ccc5870e111346f2dc75c67f7f59bbcc2c6b
Message-Id: <d303ccc5870e111346f2.1143175310@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1143175292@eng-12.pathscale.com>
Date: Thu, 23 Mar 2006 20:41:50 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, greg@kroah.com, rdreier@cisco.com,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Integrate the ipath core and OpenIB drivers into the kernel build
infrastructure.  Add entry to MAINTAINERS.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r fd3710b1b069 -r d303ccc5870e MAINTAINERS
--- a/MAINTAINERS	Thu Mar 23 20:27:45 2006 -0800
+++ b/MAINTAINERS	Thu Mar 23 20:27:45 2006 -0800
@@ -1404,6 +1404,12 @@ P:	Juanjo Ciarlante
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
diff -r fd3710b1b069 -r d303ccc5870e drivers/infiniband/Kconfig
--- a/drivers/infiniband/Kconfig	Thu Mar 23 20:27:45 2006 -0800
+++ b/drivers/infiniband/Kconfig	Thu Mar 23 20:27:45 2006 -0800
@@ -30,6 +30,7 @@ config INFINIBAND_USER_ACCESS
 	  <http://www.openib.org>.
 
 source "drivers/infiniband/hw/mthca/Kconfig"
+source "drivers/infiniband/hw/ipath/Kconfig"
 
 source "drivers/infiniband/ulp/ipoib/Kconfig"
 
diff -r fd3710b1b069 -r d303ccc5870e drivers/infiniband/Makefile
--- a/drivers/infiniband/Makefile	Thu Mar 23 20:27:45 2006 -0800
+++ b/drivers/infiniband/Makefile	Thu Mar 23 20:27:45 2006 -0800
@@ -1,4 +1,5 @@ obj-$(CONFIG_INFINIBAND)		+= core/
 obj-$(CONFIG_INFINIBAND)		+= core/
 obj-$(CONFIG_INFINIBAND_MTHCA)		+= hw/mthca/
+obj-$(CONFIG_IPATH_CORE)		+= hw/ipath/
 obj-$(CONFIG_INFINIBAND_IPOIB)		+= ulp/ipoib/
 obj-$(CONFIG_INFINIBAND_SRP)		+= ulp/srp/
diff -r fd3710b1b069 -r d303ccc5870e drivers/infiniband/hw/ipath/Kconfig
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/Kconfig	Thu Mar 23 20:27:45 2006 -0800
@@ -0,0 +1,18 @@
+config IPATH_CORE
+	tristate "PathScale InfiniPath Driver"
+	depends on 64BIT && PCI_MSI
+	---help---
+	This is a low-level driver for PathScale InfiniPath host channel
+	adapters (HCAs) based on the HT-400 and PE-800 chips, including
+	the InfiniPath HT-460, the small form factor InfiniPath HT-460,
+	the InfiniPath HT-470 and the Linux Networx LS/X.
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
diff -r fd3710b1b069 -r d303ccc5870e drivers/infiniband/hw/ipath/Makefile
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/Makefile	Thu Mar 23 20:27:45 2006 -0800
@@ -0,0 +1,41 @@
+EXTRA_CFLAGS += -DIPATH_IDSTR='"PathScale kernel.org driver"' \
+	-DIPATH_KERN_TYPE=0
+
+obj-$(CONFIG_IPATH_CORE) += ipath_core.o
+obj-$(CONFIG_INFINIBAND_IPATH) += ib_ipath.o
+obj-$(CONFIG_IPATH_ETHER) += ipath_ether.o
+
+ipath_core-y := \
+	ipath_copy.o \
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
+	ipath_sma.o \
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
+
+ipath_ether-y := ipath_eth.o
