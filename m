Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbWCVGnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWCVGnj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWCVGiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:38:06 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:42371 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750905AbWCVGhv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:37:51 -0500
Message-Id: <20060322063803.621530000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
Date: Tue, 21 Mar 2006 22:31:08 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 28/35] add support for Xen feature queries
Content-Disposition: inline; filename=27-xen-features
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
 arch/i386/mach-xen/Makefile                 |    2 -
 arch/i386/mach-xen/features.c               |   29 ++++++++++++++++++++++++++++
 include/asm-i386/mach-xen/setup_arch_post.h |    2 +
 include/xen/features.h                      |   20 +++++++++++++++++++
 4 files changed, 52 insertions(+), 1 deletion(-)

--- xen-subarch-2.6.orig/arch/i386/mach-xen/Makefile
+++ xen-subarch-2.6/arch/i386/mach-xen/Makefile
@@ -4,6 +4,6 @@
 
 extra-y				:= head.o
 
-obj-y				:= setup.o
+obj-y				:= setup.o features.o
  
 setup-y				:= ../mach-default/setup.o
--- xen-subarch-2.6.orig/include/asm-i386/mach-xen/setup_arch_post.h
+++ xen-subarch-2.6/include/asm-i386/mach-xen/setup_arch_post.h
@@ -40,6 +40,8 @@ static void __init machine_specific_arch
 {
 	struct physdev_op op;
 
+	setup_xen_features();
+
 	HYPERVISOR_shared_info =
 		(struct shared_info *)__va(xen_start_info->shared_info);
 	memset(empty_zero_page, 0, sizeof(empty_zero_page));
--- /dev/null
+++ xen-subarch-2.6/arch/i386/mach-xen/features.c
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
+EXPORT_SYMBOL(xen_features);
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
--- /dev/null
+++ xen-subarch-2.6/include/xen/features.h
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
