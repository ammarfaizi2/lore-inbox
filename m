Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268323AbUHLATo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268323AbUHLATo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 20:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268434AbUHLAOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 20:14:32 -0400
Received: from omx1-ext.SGI.COM ([192.48.179.11]:7658 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268370AbUHKXeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:34:44 -0400
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200408112333.i7BNXMXH163770@fsgi900.americas.sgi.com>
Subject: Re: Altix I/O code reorganization - 14 of 21
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org
Date: Wed, 11 Aug 2004 18:33:22 -0500 (CDT)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 007-io-hub-provider:
>    tio_provider and hub_provider have exactly the same methods, no need to
>    keep the xtalk_provider_t abstraction at all
> 

The abstraction was done for future expansion.  We have removed it 
and in the future if we do need to abstract these 2 providers, we will 
submit another patch.



# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/11 16:48:48-05:00 pfg@sgi.com 
#   Files needed to provide services for our I/O Hub devices
# 
# arch/ia64/sn/ioif/xtalk/xtalk_providers.c
#   2004/08/11 16:47:53-05:00 pfg@sgi.com +59 -0
# 
# arch/ia64/sn/ioif/xtalk/xtalk_providers.c
#   2004/08/11 16:47:53-05:00 pfg@sgi.com +0 -0
#   BitKeeper file /work.attica2/pfg/Linux/2.5-BK/to-base-2.6/arch/ia64/sn/ioif/xtalk/xtalk_providers.c
# 
# arch/ia64/sn/ioif/xtalk/Makefile
#   2004/08/11 16:47:51-05:00 pfg@sgi.com +10 -0
# 
# arch/ia64/sn/ioif/xtalk/Makefile
#   2004/08/11 16:47:51-05:00 pfg@sgi.com +0 -0
#   BitKeeper file /work.attica2/pfg/Linux/2.5-BK/to-base-2.6/arch/ia64/sn/ioif/xtalk/Makefile
# 
diff -Nru a/arch/ia64/sn/ioif/xtalk/Makefile b/arch/ia64/sn/ioif/xtalk/Makefile
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ia64/sn/ioif/xtalk/Makefile	2004-08-11 16:49:20 -05:00
@@ -0,0 +1,10 @@
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright (C) 2002-2003 Silicon Graphics, Inc.  All Rights Reserved.
+#
+# Makefile for the sn2 io routines.
+
+obj-y				+=  xtalk_providers.o
diff -Nru a/arch/ia64/sn/ioif/xtalk/xtalk_providers.c b/arch/ia64/sn/ioif/xtalk/xtalk_providers.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ia64/sn/ioif/xtalk/xtalk_providers.c	2004-08-11 16:49:20 -05:00
@@ -0,0 +1,59 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004 Silicon Graphics, Inc. All rights reserved.
+ */
+
+#include <linux/interrupt.h>
+#include <asm/sn/xtalk/xtalk_provider.h>
+#include <asm/sn/xtalk/xwidgetdev.h>
+#include <asm/sn/xtalk/xtalk_sal.h>
+#include <asm/sn/sn_sal.h>
+
+struct sn_irq_info *sal_xtalk_intr_alloc(struct xwidget_info *widget_info,
+					 int req_irq, nasid_t req_nasid,
+					 int req_slice)
+{
+	struct ia64_sal_retval ret_stuff;
+	ret_stuff.status = 0;
+	ret_stuff.v0 = 0;
+
+	SAL_CALL_NOLOCK(ret_stuff, (u64) SN_SAL_XTALK,
+			(u64) XTALK_CALL_INTR_ALLOC, (u64) widget_info,
+			(u64) req_irq, (u64) req_nasid, (u64) req_slice, 0, 0);
+
+	printk("sal_xtalk_intr_alloc: v0=0x%lx\n", ret_stuff.v0);
+	if (ret_stuff.status == SALRET_OK) {
+		return (struct sn_irq_info *)ret_stuff.v0;
+	} else {
+		return (struct sn_irq_info *)NULL;
+	}
+}
+
+void sal_xtalk_intr_free(struct xwidget_info *widget_info,
+			 struct sn_irq_info *sn_irq_info)
+{
+	struct ia64_sal_retval ret_stuff;
+	ret_stuff.status = 0;
+	ret_stuff.v0 = 0;
+
+	SAL_CALL_NOLOCK(ret_stuff, (u64) SN_SAL_XTALK,
+			(u64) XTALK_CALL_INTR_FREE, (u64) widget_info,
+			(u64) sn_irq_info, 0, 0, 0, 0);
+}
+
+xtalk_provider_t hub_provider = {
+
+	(xtalk_intr_alloc_f *) sal_xtalk_intr_alloc,
+	(xtalk_intr_free_f *) sal_xtalk_intr_free,
+
+};
+
+xtalk_provider_t tio_provider = {
+
+	(xtalk_intr_alloc_f *) sal_xtalk_intr_alloc,
+	(xtalk_intr_free_f *) sal_xtalk_intr_free,
+
+};
