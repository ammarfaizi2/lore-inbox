Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbWGBW4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWGBW4z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 18:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbWGBW4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 18:56:55 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:28117 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751043AbWGBW4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 18:56:54 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 3 Jul 2006 00:56:37 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 02/19] ieee1394: fix calculation of csr->expire
To: Ben Collins <bcollins@ubuntu.com>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
Message-ID: <tkrat.bc54ed2b3970ffd6@s5r6.in-berlin.de>
References: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.904) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This variant of calculate_expire() is more correct and easier to read.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/csr.c |   31 ++++++++++---------------------
 1 files changed, 10 insertions(+), 21 deletions(-)

Index: linux/drivers/ieee1394/csr.c
===================================================================
--- linux.orig/drivers/ieee1394/csr.c	2006-06-24 18:58:14.000000000 +0200
+++ linux/drivers/ieee1394/csr.c	2006-06-24 19:04:09.000000000 +0200
@@ -17,11 +17,13 @@
  *
  */
 
-#include <linux/string.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/param.h>
 #include <linux/spinlock.h>
+#include <linux/string.h>
 
 #include "csr1212.h"
 #include "ieee1394_types.h"
@@ -149,31 +151,18 @@ static void host_reset(struct hpsb_host 
 
 /*
  * HI == seconds (bits 0:2)
- * LO == fraction units of 1/8000 of a second, as per 1394 (bits 19:31)
- *
- * Convert to units and then to HZ, for comparison to jiffies.
- *
- * By default this will end up being 800 units, or 100ms (125usec per
- * unit).
+ * LO == fractions of a second in units of 125usec (bits 19:31)
  *
- * NOTE: The spec says 1/8000, but also says we can compute based on 1/8192
- * like CSR specifies. Should make our math less complex.
+ * Convert SPLIT_TIMEOUT to jiffies.
+ * The default and minimum as per 1394a-2000 clause 8.3.2.2.6 is 100ms.
  */
 static inline void calculate_expire(struct csr_control *csr)
 {
-	unsigned long units;
-
-	/* Take the seconds, and convert to units */
-	units = (unsigned long)(csr->split_timeout_hi & 0x07) << 13;
-
-	/* Add in the fractional units */
-	units += (unsigned long)(csr->split_timeout_lo >> 19);
-
-	/* Convert to jiffies */
-	csr->expire = (unsigned long)(units * HZ) >> 13UL;
+	unsigned long usecs =
+		(csr->split_timeout_hi & 0x07) * USEC_PER_SEC +
+		(csr->split_timeout_lo >> 19) * 125L;
 
-	/* Just to keep from rounding low */
-	csr->expire++;
+	csr->expire = usecs_to_jiffies(usecs > 100000L ? usecs : 100000L);
 
 	HPSB_VERBOSE("CSR: setting expire to %lu, HZ=%u", csr->expire, HZ);
 }


