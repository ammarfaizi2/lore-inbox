Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWDXVXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWDXVXm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWDXVXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:23:42 -0400
Received: from mx.pathscale.com ([64.160.42.68]:29891 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751285AbWDXVXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:23:41 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 4 of 13] ipath - change handling of PIO buffers
X-Mercurial-Node: 8e724d49e74bc1155f4e4fbca7dea52d5b1b7a52
Message-Id: <8e724d49e74bc1155f4e.1145913780@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1145913776@eng-12.pathscale.com>
Date: Mon, 24 Apr 2006 14:23:00 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Different ipath hardware types have different numbers of buffers
available, so we decide on the counts ourselves unless we are specifically
overridden with a module parameter.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 49f2286e0bdc -r 8e724d49e74b drivers/infiniband/hw/ipath/ipath_init_chip.c
--- a/drivers/infiniband/hw/ipath/ipath_init_chip.c	Wed Apr 19 15:24:36 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_init_chip.c	Wed Apr 19 15:24:36 2006 -0700
@@ -53,13 +53,19 @@ MODULE_PARM_DESC(cfgports, "Set max numb
 
 /*
  * Number of buffers reserved for driver (layered drivers and SMA
- * send).  Reserved at end of buffer list.
+ * send).  Reserved at end of buffer list.   Initialized based on
+ * number of PIO buffers if not set via module interface.
+ * The problem with this is that it's global, but we'll use different
+ * numbers for different chip types.  So the default value is not
+ * very useful.  I've redefined it for the 1.3 release so that it's
+ * zero unless set by the user to something else, in which case we
+ * try to respect it.
  */
-static ushort ipath_kpiobufs = 32;
+static ushort ipath_kpiobufs;
 
 static int ipath_set_kpiobufs(const char *val, struct kernel_param *kp);
 
-module_param_call(kpiobufs, ipath_set_kpiobufs, param_get_uint,
+module_param_call(kpiobufs, ipath_set_kpiobufs, param_get_ushort,
 		  &ipath_kpiobufs, S_IWUSR | S_IRUGO);
 MODULE_PARM_DESC(kpiobufs, "Set number of PIO buffers for driver");
 
@@ -531,8 +537,11 @@ static int init_housekeeping(struct ipat
 	 * Don't clear ipath_flags as 8bit mode was set before
 	 * entering this func. However, we do set the linkstate to
 	 * unknown, so we can watch for a transition.
-	 */
-	dd->ipath_flags |= IPATH_LINKUNK;
+	 * PRESENT is set because we want register reads to work,
+	 * and the kernel infrastructure saw it in config space;
+	 * We clear it if we have failures.
+	 */
+	dd->ipath_flags |= IPATH_LINKUNK | IPATH_PRESENT;
 	dd->ipath_flags &= ~(IPATH_LINKACTIVE | IPATH_LINKARMED |
 			     IPATH_LINKDOWN | IPATH_LINKINIT);
 
@@ -560,6 +569,7 @@ static int init_housekeeping(struct ipat
 	    || (dd->ipath_uregbase & 0xffffffff) == 0xffffffff) {
 		ipath_dev_err(dd, "Register read failures from chip, "
 			      "giving up initialization\n");
+		dd->ipath_flags &= ~IPATH_PRESENT;
 		ret = -ENODEV;
 		goto done;
 	}
@@ -682,16 +692,14 @@ int ipath_init_chip(struct ipath_devdata
 	 */
 	dd->ipath_pioavregs = ALIGN(val, sizeof(u64) * BITS_PER_BYTE / 2)
 		/ (sizeof(u64) * BITS_PER_BYTE / 2);
-	if (!ipath_kpiobufs)	/* have to have at least 1, for SMA */
-		kpiobufs = ipath_kpiobufs = 1;
-	else if ((dd->ipath_piobcnt2k + dd->ipath_piobcnt4k) <
-		 (dd->ipath_cfgports * IPATH_MIN_USER_PORT_BUFCNT)) {
-		dev_info(&dd->pcidev->dev, "Too few PIO buffers (%u) "
-			 "for %u ports to have %u each!\n",
-			 dd->ipath_piobcnt2k + dd->ipath_piobcnt4k,
-			 dd->ipath_cfgports, IPATH_MIN_USER_PORT_BUFCNT);
-		kpiobufs = 1;	/* reserve just the minimum for SMA/ether */
-	} else
+	if (ipath_kpiobufs == 0) {
+		/* not set by user, or set explictly to default  */
+		if ((dd->ipath_piobcnt2k + dd->ipath_piobcnt4k) > 128)
+			kpiobufs = 32;
+		else
+			kpiobufs = 16;
+	}
+	else
 		kpiobufs = ipath_kpiobufs;
 
 	if (kpiobufs >
