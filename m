Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbVKAEag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbVKAEag (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 23:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbVKAEag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 23:30:36 -0500
Received: from ozlabs.org ([203.10.76.45]:35976 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932558AbVKAEaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 23:30:35 -0500
Date: Tue, 1 Nov 2005 15:30:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: powerpc: Move naca.h to platforms/iseries
Message-ID: <20051101043026.GB27961@localhost.localdomain>
Mail-Followup-To: Paul Mackerras <paulus@samba.org>,
	linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulus, please apply.

These days, the NACA only exists on iSeries.  Therefore, this patch
moves naca.h from include/asm-ppc64 to arch/powerpc/platforms/iseries.
There was one file including naca.h outside of platforms/iseries -
arch/ppc64/kernel/udbg_scc.c.  However, that's obviously a hangover
from older days.  The include is not necessary, so this patch simply
removes it.

Built and booted on iSeries, built for G5 (which uses udbg_scc.o).

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/arch/powerpc/platforms/iseries/lpardata.c
===================================================================
--- working-2.6.orig/arch/powerpc/platforms/iseries/lpardata.c	2005-10-31 15:20:20.000000000 +1100
+++ working-2.6/arch/powerpc/platforms/iseries/lpardata.c	2005-11-01 15:15:57.000000000 +1100
@@ -13,7 +13,6 @@
 #include <linux/bitops.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
-#include <asm/naca.h>
 #include <asm/abs_addr.h>
 #include <asm/iSeries/ItLpNaca.h>
 #include <asm/lppaca.h>
@@ -23,6 +22,7 @@
 #include <asm/iSeries/ItExtVpdPanel.h>
 #include <asm/iSeries/ItLpQueue.h>
 
+#include "naca.h"
 #include "vpd_areas.h"
 #include "spcomm_area.h"
 #include "ipl_parms.h"
Index: working-2.6/arch/powerpc/platforms/iseries/naca.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/powerpc/platforms/iseries/naca.h	2005-11-01 15:28:03.000000000 +1100
@@ -0,0 +1,24 @@
+#ifndef _PLATFORMS_ISERIES_NACA_H
+#define _PLATFORMS_ISERIES_NACA_H
+
+/*
+ * c 2001 PPC 64 Team, IBM Corp
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/types.h>
+
+struct naca_struct {
+	/* Kernel only data - undefined for user space */
+	void *xItVpdAreas;              /* VPD Data                  0x00 */
+	void *xRamDisk;                 /* iSeries ramdisk           0x08 */
+	u64   xRamDiskSize;		/* In pages                  0x10 */
+};
+
+extern struct naca_struct naca;
+
+#endif /* _PLATFORMS_ISERIES_NACA_H */
Index: working-2.6/arch/powerpc/platforms/iseries/release_data.h
===================================================================
--- working-2.6.orig/arch/powerpc/platforms/iseries/release_data.h	2005-10-31 15:20:20.000000000 +1100
+++ working-2.6/arch/powerpc/platforms/iseries/release_data.h	2005-11-01 15:15:57.000000000 +1100
@@ -24,7 +24,7 @@
  * address of the OS's NACA).
  */
 #include <asm/types.h>
-#include <asm/naca.h>
+#include "naca.h"
 
 /*
  * When we IPL a secondary partition, we will check if if the
Index: working-2.6/arch/powerpc/platforms/iseries/setup.c
===================================================================
--- working-2.6.orig/arch/powerpc/platforms/iseries/setup.c	2005-10-31 15:44:59.000000000 +1100
+++ working-2.6/arch/powerpc/platforms/iseries/setup.c	2005-11-01 15:15:57.000000000 +1100
@@ -40,7 +40,6 @@
 #include <asm/firmware.h>
 
 #include <asm/time.h>
-#include <asm/naca.h>
 #include <asm/paca.h>
 #include <asm/cache.h>
 #include <asm/sections.h>
@@ -53,6 +52,7 @@
 #include <asm/iSeries/HvLpEvent.h>
 #include <asm/iSeries/LparMap.h>
 
+#include "naca.h"
 #include "setup.h"
 #include "irq.h"
 #include "vpd_areas.h"
Index: working-2.6/arch/ppc64/kernel/udbg_scc.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/udbg_scc.c	2005-10-25 11:59:53.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/udbg_scc.c	2005-11-01 15:15:57.000000000 +1100
@@ -12,7 +12,6 @@
 #include <linux/types.h>
 #include <asm/udbg.h>
 #include <asm/processor.h>
-#include <asm/naca.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/pmac_feature.h>
Index: working-2.6/include/asm-ppc64/naca.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/naca.h	2005-10-25 11:59:59.000000000 +1000
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,24 +0,0 @@
-#ifndef _NACA_H
-#define _NACA_H
-
-/* 
- * c 2001 PPC 64 Team, IBM Corp
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <asm/types.h>
-
-struct naca_struct {
-	/* Kernel only data - undefined for user space */
-	void *xItVpdAreas;              /* VPD Data                  0x00 */
-	void *xRamDisk;                 /* iSeries ramdisk           0x08 */
-	u64   xRamDiskSize;		/* In pages                  0x10 */
-};
-
-extern struct naca_struct naca;
-
-#endif /* _NACA_H */


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
