Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbWEII4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWEII4X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWEIItO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:49:14 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:2688 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751513AbWEIIsx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:48:53 -0400
Message-Id: <20060509085158.933866000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
Date: Tue, 09 May 2006 00:00:28 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 28/35] add support for Xen feature queries
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
 drivers/Makefile                            |    1 
 drivers/xen/Makefile                        |    3 ++
 drivers/xen/core/Makefile                   |    3 ++
 drivers/xen/core/features.c                 |   29 ++++++++++++++++++++++++++++
 include/asm-i386/mach-xen/setup_arch_post.h |    2 +
 include/xen/features.h                      |   20 +++++++++++++++++++
 6 files changed, 58 insertions(+)

--- linus-2.6.orig/include/asm-i386/mach-xen/setup_arch_post.h
+++ linus-2.6/include/asm-i386/mach-xen/setup_arch_post.h
@@ -27,6 +27,8 @@ static void __init machine_specific_arch
 {
 	struct physdev_op op;
 
+	setup_xen_features();
+
 	HYPERVISOR_shared_info =
 		(struct shared_info *)__va(xen_start_info->shared_info);
 	memset(empty_zero_page, 0, sizeof(empty_zero_page));
--- linus-2.6.orig/drivers/Makefile
+++ linus-2.6/drivers/Makefile
@@ -31,6 +31,7 @@ obj-y				+= base/ block/ misc/ mfd/ net/
 obj-$(CONFIG_NUBUS)		+= nubus/
 obj-$(CONFIG_ATM)		+= atm/
 obj-$(CONFIG_PPC_PMAC)		+= macintosh/
+obj-$(CONFIG_XEN)		+= xen/
 obj-$(CONFIG_IDE)		+= ide/
 obj-$(CONFIG_FC4)		+= fc4/
 obj-$(CONFIG_SCSI)		+= scsi/
--- /dev/null
+++ linus-2.6/include/xen/features.h
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
--- /dev/null
+++ linus-2.6/drivers/xen/Makefile
@@ -0,0 +1,3 @@
+
+obj-y	+= core/
+
--- /dev/null
+++ linus-2.6/drivers/xen/core/Makefile
@@ -0,0 +1,3 @@
+
+obj-y	:= features.o
+
--- /dev/null
+++ linus-2.6/drivers/xen/core/features.c
@@ -0,0 +1,29 @@
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
+}

--
