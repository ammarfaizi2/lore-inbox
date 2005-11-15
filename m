Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbVKOCCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbVKOCCJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 21:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVKOCCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 21:02:09 -0500
Received: from ozlabs.org ([203.10.76.45]:2966 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932271AbVKOCCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 21:02:07 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17273.16792.850639.195427@cargo.ozlabs.ibm.com>
Date: Tue, 15 Nov 2005 13:02:00 +1100
From: Paul Mackerras <paulus@samba.org>
To: vojtech@suse.cz
CC: linux-kernel@vger.kernel.org, Michael Neuling <mikey@neuling.org>
Subject: [PATCH] Allow arch to veto PC speaker beeper initialization
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Neuling <mikey@neuling.org>

This patch provides an arch hook in the PC speaker beeper driver which
gives the arch code an opportunity to determine whether the machine
has an i8253 timer or not.  If it doesn't we don't want the driver to
go poking at the i8253's ports; there might be nothing there or there
might be something else there which would be upset by being poked at.

We want to be able to build ppc64 kernels which work both on machines
that have an i8253 equivalent (e.g. some pSeries) and on machines that
don't (e.g. G5 powermacs), which is why we don't just remove it from
the config.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---

Could this go in please, preferably for 2.6.15?  Some people are
finding that their G5 powermacs lock up when this driver pokes the PIT
registers.

 drivers/input/misc/pcspkr.c   |    5 +++++
 include/asm-powerpc/8253pit.h |   13 +++++++++++++
 2 files changed, 18 insertions(+)

Index: linux-2.6/drivers/input/misc/pcspkr.c
===================================================================
--- linux-2.6.orig/drivers/input/misc/pcspkr.c	2005-10-31 15:16:39.000000000 +1100
+++ linux-2.6/drivers/input/misc/pcspkr.c	2005-10-31 15:21:13.000000000 +1100
@@ -66,6 +66,11 @@
 
 static int __init pcspkr_init(void)
 {
+#ifdef HAS_PCSPKR_ARCH_INIT
+	int rc = pcspkr_arch_init();
+	if (rc)
+		return rc;
+#endif
 	pcspkr_dev = input_allocate_device();
 	if (!pcspkr_dev)
 		return -ENOMEM;
Index: linux-2.6/include/asm-powerpc/8253pit.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/8253pit.h	2005-10-31 15:02:18.000000000 +1100
+++ linux-2.6/include/asm-powerpc/8253pit.h	2005-10-31 15:20:30.000000000 +1100
@@ -5,6 +5,19 @@
  * 8253/8254 Programmable Interval Timer
  */
 
+#include <asm/prom.h>
+
 #define PIT_TICK_RATE	1193182UL
 
+#define HAS_PCSPKR_ARCH_INIT
+
+static inline int pcspkr_arch_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "pnpPNP,100");
+	of_node_put(np);
+	return np ? 0 : -ENODEV;
+}
+
 #endif	/* _ASM_POWERPC_8253PIT_H */
