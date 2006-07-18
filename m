Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWGRJ2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWGRJ2r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 05:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWGRJU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 05:20:57 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37250 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932114AbWGRJUj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 05:20:39 -0400
Message-Id: <20060718091950.999859000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 18 Jul 2006 00:00:10 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Zachary Amsden <zach@vmware.com>, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 10/33] add support for Xen feature queries
Content-Disposition: inline; filename=xen-features
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for parsing and interpreting hypervisor feature
flags. These allow the kernel to determine what features are provided
by the underlying hypervisor. For example, whether page tables need to
be write protected explicitly by the kernel, and whether the kernel
(appears to) run in ring 0 rather than ring 1. This information allows
the kernel to improve performance by avoiding unnecessary actions.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 arch/i386/mach-xen/setup-xen.c |    2 ++
 drivers/Makefile               |    1 +
 drivers/xen/Makefile           |    3 +++
 drivers/xen/core/Makefile      |    3 +++
 drivers/xen/core/features.c    |   31 +++++++++++++++++++++++++++++++
 include/asm-i386/hypervisor.h  |    1 +
 include/xen/features.h         |   20 ++++++++++++++++++++
 7 files changed, 61 insertions(+)


diff -r 1f0f17cb7700 arch/i386/mach-xen/setup-xen.c
--- a/arch/i386/mach-xen/setup-xen.c	Fri Jun 16 17:57:31 2006 -0700
+++ b/arch/i386/mach-xen/setup-xen.c	Fri Jun 16 18:00:23 2006 -0700
@@ -40,6 +40,8 @@ char * __init machine_specific_memory_se
 
 void __init machine_specific_arch_setup(void)
 {
+	setup_xen_features();
+
 #ifdef CONFIG_ACPI
 	if (!(xen_start_info->flags & SIF_INITDOMAIN)) {
 		printk(KERN_INFO "ACPI in unprivileged domain disabled\n");
diff -r 1f0f17cb7700 drivers/Makefile
--- a/drivers/Makefile	Fri Jun 16 17:57:31 2006 -0700
+++ b/drivers/Makefile	Fri Jun 16 18:00:23 2006 -0700
@@ -31,6 +31,7 @@ obj-$(CONFIG_NUBUS)		+= nubus/
 obj-$(CONFIG_NUBUS)		+= nubus/
 obj-$(CONFIG_ATM)		+= atm/
 obj-$(CONFIG_PPC_PMAC)		+= macintosh/
+obj-$(CONFIG_XEN)		+= xen/
 obj-$(CONFIG_IDE)		+= ide/
 obj-$(CONFIG_FC4)		+= fc4/
 obj-$(CONFIG_SCSI)		+= scsi/
diff -r 1f0f17cb7700 include/asm-i386/hypervisor.h
--- a/include/asm-i386/hypervisor.h	Fri Jun 16 17:57:31 2006 -0700
+++ b/include/asm-i386/hypervisor.h	Fri Jun 16 18:00:23 2006 -0700
@@ -40,6 +40,7 @@
 
 #include <xen/interface/xen.h>
 #include <xen/interface/version.h>
+#include <xen/features.h>
 
 #include <asm/ptrace.h>
 #include <asm/page.h>
diff -r 1f0f17cb7700 drivers/xen/Makefile
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/drivers/xen/Makefile	Fri Jun 16 18:00:23 2006 -0700
@@ -0,0 +1,3 @@
+
+obj-y	+= core/
+
diff -r 1f0f17cb7700 drivers/xen/core/Makefile
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/drivers/xen/core/Makefile	Fri Jun 16 18:00:23 2006 -0700
@@ -0,0 +1,3 @@
+
+obj-y	:= features.o
+
diff -r 1f0f17cb7700 drivers/xen/core/features.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/drivers/xen/core/features.c	Fri Jun 16 18:00:23 2006 -0700
@@ -0,0 +1,31 @@
+/******************************************************************************
+ * features.c
+ *
+ * Xen feature flags.
+ *
+ * Copyright (c) 2006, Ian Campbell, XenSource Inc.
+ */
+#include <linux/types.h>
+#include <linux/cache.h>
+#include <linux/module.h>
+#include <asm/hypervisor.h>
+#include <xen/features.h>
+
+u8 xen_features[XENFEAT_NR_SUBMAPS * 32] __read_mostly;
+EXPORT_SYMBOL_GPL(xen_features);
+
+void setup_xen_features(void)
+{
+#if 0	/* hypercalls come later in the series */
+	struct xen_feature_info fi;
+	int i, j;
+
+	for (i = 0; i < XENFEAT_NR_SUBMAPS; i++) {
+		fi.submap_idx = i;
+		if (HYPERVISOR_xen_version(XENVER_get_features, &fi) < 0)
+			break;
+		for (j=0; j<32; j++)
+			xen_features[i*32+j] = !!(fi.submap & 1<<j);
+	}
+#endif
+}
diff -r 1f0f17cb7700 include/xen/features.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/xen/features.h	Fri Jun 16 18:00:23 2006 -0700
@@ -0,0 +1,20 @@
+/******************************************************************************
+ * features.h
+ *
+ * Query the features reported by Xen.
+ *
+ * Copyright (c) 2006, Ian Campbell
+ */
+
+#ifndef __ASM_XEN_FEATURES_H__
+#define __ASM_XEN_FEATURES_H__
+
+#include <xen/interface/version.h>
+
+extern void setup_xen_features(void);
+
+extern u8 xen_features[XENFEAT_NR_SUBMAPS * 32];
+
+#define xen_feature(flag)	(xen_features[flag])
+
+#endif /* __ASM_XEN_FEATURES_H__ */

--
