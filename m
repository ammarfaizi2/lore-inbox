Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbVH2Rzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbVH2Rzo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 13:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbVH2Rzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 13:55:43 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:34251 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751197AbVH2Rz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 13:55:26 -0400
Date: Mon, 29 Aug 2005 19:55:21 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, cohuck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 5/10] s390: reIPL fix and extern/static inline.
Message-ID: <20050829175521.GE6796@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 5/10] s390: reIPL fix and extern/static inline.

From: Cornelia Huck <cohuck@de.ibm.com>

Common i/o layer changes:
 - Collect the irb at the correct subchannel when waiting for the
   clear interrupt during subchannel cleaning befor reIPL - don't
   stop at the first interrupt that comes in.
 - Change "extern __inline__" to "static inline".
 - Remove unneeded qdio includes.

Signed-off-by: Cornelia Huck <cohuck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/cio/cio.c        |    7 ++++---
 drivers/s390/cio/device_fsm.c |    3 +--
 drivers/s390/cio/device_ops.c |    4 +---
 drivers/s390/cio/ioasm.h      |   26 +++++++++++++-------------
 4 files changed, 19 insertions(+), 21 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/cio.c linux-2.6-patched/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/cio.c	2005-08-29 19:18:08.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/cio.c
  *   S/390 common I/O routines -- low level i/o calls
- *   $Revision: 1.134 $
+ *   $Revision: 1.135 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -815,8 +815,9 @@ __clear_subchannel_easy(unsigned int sch
 		struct tpi_info ti;
 
 		if (tpi(&ti)) {
-			tsch(schid, (struct irb *)__LC_IRB);
-			return 0;
+			tsch(ti.irq, (struct irb *)__LC_IRB);
+			if (ti.irq == schid)
+				return 0;
 		}
 		udelay(100);
 	}
diff -urpN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-patched/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_fsm.c	2005-08-29 19:18:08.000000000 +0200
@@ -13,7 +13,7 @@
 #include <linux/init.h>
 
 #include <asm/ccwdev.h>
-#include <asm/qdio.h>
+#include <asm/cio.h>
 
 #include "cio.h"
 #include "cio_debug.h"
@@ -21,7 +21,6 @@
 #include "device.h"
 #include "chsc.h"
 #include "ioasm.h"
-#include "qdio.h"
 
 int
 device_is_online(struct subchannel *sch)
diff -urpN linux-2.6/drivers/s390/cio/device_ops.c linux-2.6-patched/drivers/s390/cio/device_ops.c
--- linux-2.6/drivers/s390/cio/device_ops.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_ops.c	2005-08-29 19:18:08.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/device_ops.c
  *
- *   $Revision: 1.56 $
+ *   $Revision: 1.57 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -19,14 +19,12 @@
 
 #include <asm/ccwdev.h>
 #include <asm/idals.h>
-#include <asm/qdio.h>
 
 #include "cio.h"
 #include "cio_debug.h"
 #include "css.h"
 #include "chsc.h"
 #include "device.h"
-#include "qdio.h"
 
 int
 ccw_device_set_options(struct ccw_device *cdev, unsigned long flags)
diff -urpN linux-2.6/drivers/s390/cio/ioasm.h linux-2.6-patched/drivers/s390/cio/ioasm.h
--- linux-2.6/drivers/s390/cio/ioasm.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/ioasm.h	2005-08-29 19:18:08.000000000 +0200
@@ -21,7 +21,7 @@ struct tpi_info {
  * Some S390 specific IO instructions as inline
  */
 
-extern __inline__ int stsch(int irq, volatile struct schib *addr)
+static inline int stsch(int irq, volatile struct schib *addr)
 {
 	int ccode;
 
@@ -36,7 +36,7 @@ extern __inline__ int stsch(int irq, vol
 	return ccode;
 }
 
-extern __inline__ int msch(int irq, volatile struct schib *addr)
+static inline int msch(int irq, volatile struct schib *addr)
 {
 	int ccode;
 
@@ -51,7 +51,7 @@ extern __inline__ int msch(int irq, vola
 	return ccode;
 }
 
-extern __inline__ int msch_err(int irq, volatile struct schib *addr)
+static inline int msch_err(int irq, volatile struct schib *addr)
 {
 	int ccode;
 
@@ -79,7 +79,7 @@ extern __inline__ int msch_err(int irq, 
 	return ccode;
 }
 
-extern __inline__ int tsch(int irq, volatile struct irb *addr)
+static inline int tsch(int irq, volatile struct irb *addr)
 {
 	int ccode;
 
@@ -94,7 +94,7 @@ extern __inline__ int tsch(int irq, vola
 	return ccode;
 }
 
-extern __inline__ int tpi( volatile struct tpi_info *addr)
+static inline int tpi( volatile struct tpi_info *addr)
 {
 	int ccode;
 
@@ -108,7 +108,7 @@ extern __inline__ int tpi( volatile stru
 	return ccode;
 }
 
-extern __inline__ int ssch(int irq, volatile struct orb *addr)
+static inline int ssch(int irq, volatile struct orb *addr)
 {
 	int ccode;
 
@@ -123,7 +123,7 @@ extern __inline__ int ssch(int irq, vola
 	return ccode;
 }
 
-extern __inline__ int rsch(int irq)
+static inline int rsch(int irq)
 {
 	int ccode;
 
@@ -138,7 +138,7 @@ extern __inline__ int rsch(int irq)
 	return ccode;
 }
 
-extern __inline__ int csch(int irq)
+static inline int csch(int irq)
 {
 	int ccode;
 
@@ -153,7 +153,7 @@ extern __inline__ int csch(int irq)
 	return ccode;
 }
 
-extern __inline__ int hsch(int irq)
+static inline int hsch(int irq)
 {
 	int ccode;
 
@@ -168,7 +168,7 @@ extern __inline__ int hsch(int irq)
 	return ccode;
 }
 
-extern __inline__ int xsch(int irq)
+static inline int xsch(int irq)
 {
 	int ccode;
 
@@ -183,7 +183,7 @@ extern __inline__ int xsch(int irq)
 	return ccode;
 }
 
-extern __inline__ int chsc(void *chsc_area)
+static inline int chsc(void *chsc_area)
 {
 	int cc;
 
@@ -198,7 +198,7 @@ extern __inline__ int chsc(void *chsc_ar
 	return cc;
 }
 
-extern __inline__ int iac( void)
+static inline int iac( void)
 {
 	int ccode;
 
@@ -210,7 +210,7 @@ extern __inline__ int iac( void)
 	return ccode;
 }
 
-extern __inline__ int rchp(int chpid)
+static inline int rchp(int chpid)
 {
 	int ccode;
 
