Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422802AbWHYSaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422802AbWHYSaj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422782AbWHYS3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:29:15 -0400
Received: from mx.pathscale.com ([64.160.42.68]:41858 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422746AbWHYSZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:25:19 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 8 of 23] IB/ipath - simplify debugging code after ipath_core
	and ib_ipath merger
X-Mercurial-Node: a0050f760a637de69694d2fecce31093d66a49c9
Message-Id: <a0050f760a637de69694.1156530273@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1156530265@eng-12.pathscale.com>
Date: Fri, 25 Aug 2006 11:24:33 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff --git a/drivers/infiniband/hw/ipath/ipath_driver.c b/drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Fri Aug 25 11:19:45 2006 -0700
@@ -58,7 +58,7 @@ const char *ipath_get_unit_name(int unit
  * The size has to be longer than this string, so we can append
  * board/chip information to it in the init code.
  */
-const char ipath_core_version[] = IPATH_IDSTR "\n";
+const char ib_ipath_version[] = IPATH_IDSTR "\n";
 
 static struct idr unit_table;
 DEFINE_SPINLOCK(ipath_devs_lock);
@@ -1847,7 +1847,7 @@ static int __init infinipath_init(void)
 {
 	int ret;
 
-	ipath_dbg(KERN_INFO DRIVER_LOAD_MSG "%s", ipath_core_version);
+	ipath_dbg(KERN_INFO DRIVER_LOAD_MSG "%s", ib_ipath_version);
 
 	/*
 	 * These must be called before the driver is registered with
diff --git a/drivers/infiniband/hw/ipath/ipath_kernel.h b/drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri Aug 25 11:19:45 2006 -0700
@@ -785,7 +785,7 @@ static inline u32 ipath_read_creg32(cons
 
 struct device_driver;
 
-extern const char ipath_core_version[];
+extern const char ib_ipath_version[];
 
 int ipath_driver_create_group(struct device_driver *);
 void ipath_driver_remove_group(struct device_driver *);
@@ -815,7 +815,7 @@ const char *ipath_get_unit_name(int unit
 
 extern struct mutex ipath_mutex;
 
-#define IPATH_DRV_NAME		"ipath_core"
+#define IPATH_DRV_NAME		"ib_ipath"
 #define IPATH_MAJOR		233
 #define IPATH_USER_MINOR_BASE	0
 #define IPATH_SMA_MINOR		128
diff --git a/drivers/infiniband/hw/ipath/ipath_keys.c b/drivers/infiniband/hw/ipath/ipath_keys.c
--- a/drivers/infiniband/hw/ipath/ipath_keys.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_keys.c	Fri Aug 25 11:19:45 2006 -0700
@@ -34,6 +34,7 @@
 #include <asm/io.h>
 
 #include "ipath_verbs.h"
+#include "ipath_kernel.h"
 
 /**
  * ipath_alloc_lkey - allocate an lkey
@@ -60,7 +61,7 @@ int ipath_alloc_lkey(struct ipath_lkey_t
 		r = (r + 1) & (rkt->max - 1);
 		if (r == n) {
 			spin_unlock_irqrestore(&rkt->lock, flags);
-			_VERBS_INFO("LKEY table full\n");
+			ipath_dbg(KERN_INFO "LKEY table full\n");
 			ret = 0;
 			goto bail;
 		}
diff --git a/drivers/infiniband/hw/ipath/ipath_qp.c b/drivers/infiniband/hw/ipath/ipath_qp.c
--- a/drivers/infiniband/hw/ipath/ipath_qp.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c	Fri Aug 25 11:19:45 2006 -0700
@@ -274,7 +274,7 @@ void ipath_free_all_qps(struct ipath_qp_
 				free_qpn(qpt, qp->ibqp.qp_num);
 			if (!atomic_dec_and_test(&qp->refcount) ||
 			    !ipath_destroy_qp(&qp->ibqp))
-				_VERBS_INFO("QP memory leak!\n");
+				ipath_dbg(KERN_INFO "QP memory leak!\n");
 			qp = nqp;
 		}
 	}
@@ -362,8 +362,8 @@ void ipath_error_qp(struct ipath_qp *qp)
 	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
 	struct ib_wc wc;
 
-	_VERBS_INFO("QP%d/%d in error state\n",
-		    qp->ibqp.qp_num, qp->remote_qpn);
+	ipath_dbg(KERN_INFO "QP%d/%d in error state\n",
+		  qp->ibqp.qp_num, qp->remote_qpn);
 
 	spin_lock(&dev->pending_lock);
 	/* XXX What if its already removed by the timeout code? */
@@ -945,8 +945,8 @@ void ipath_sqerror_qp(struct ipath_qp *q
 	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
 	struct ipath_swqe *wqe = get_swqe_ptr(qp, qp->s_last);
 
-	_VERBS_INFO("Send queue error on QP%d/%d: err: %d\n",
-		    qp->ibqp.qp_num, qp->remote_qpn, wc->status);
+	ipath_dbg(KERN_INFO "Send queue error on QP%d/%d: err: %d\n",
+		  qp->ibqp.qp_num, qp->remote_qpn, wc->status);
 
 	spin_lock(&dev->pending_lock);
 	/* XXX What if its already removed by the timeout code? */
diff --git a/drivers/infiniband/hw/ipath/ipath_sysfs.c b/drivers/infiniband/hw/ipath/ipath_sysfs.c
--- a/drivers/infiniband/hw/ipath/ipath_sysfs.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_sysfs.c	Fri Aug 25 11:19:45 2006 -0700
@@ -75,7 +75,7 @@ static ssize_t show_version(struct devic
 static ssize_t show_version(struct device_driver *dev, char *buf)
 {
 	/* The string printed here is already newline-terminated. */
-	return scnprintf(buf, PAGE_SIZE, "%s", ipath_core_version);
+	return scnprintf(buf, PAGE_SIZE, "%s", ib_ipath_version);
 }
 
 static ssize_t show_num_units(struct device_driver *dev, char *buf)
diff --git a/drivers/infiniband/hw/ipath/ipath_verbs.c b/drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri Aug 25 11:19:45 2006 -0700
@@ -49,10 +49,6 @@ module_param_named(lkey_table_size, ib_i
 		   S_IRUGO);
 MODULE_PARM_DESC(lkey_table_size,
 		 "LKEY table size in bits (2^n, 1 <= n <= 23)");
-
-unsigned int ib_ipath_debug;	/* debug mask */
-module_param_named(debug, ib_ipath_debug, uint, S_IWUSR | S_IRUGO);
-MODULE_PARM_DESC(debug, "Verbs debug mask");
 
 static unsigned int ib_ipath_max_pds = 0xFFFF;
 module_param_named(max_pds, ib_ipath_max_pds, uint, S_IWUSR | S_IRUGO);
@@ -1598,8 +1594,7 @@ err_lk:
 	kfree(idev->qp_table.table);
 err_qp:
 	ib_dealloc_device(dev);
-	_VERBS_ERROR("ib_ipath%d cannot register verbs (%d)!\n",
-		     dd->ipath_unit, -ret);
+	ipath_dev_err(dd, "cannot register verbs: %d!\n", -ret);
 	idev = NULL;
 
 bail:
@@ -1618,17 +1613,13 @@ void ipath_unregister_ib_device(struct i
 	if (!list_empty(&dev->pending[0]) ||
 	    !list_empty(&dev->pending[1]) ||
 	    !list_empty(&dev->pending[2]))
-		_VERBS_ERROR("ipath%d pending list not empty!\n",
-			     dev->ib_unit);
+		ipath_dev_err(dev->dd, "pending list not empty!\n");
 	if (!list_empty(&dev->piowait))
-		_VERBS_ERROR("ipath%d piowait list not empty!\n",
-			     dev->ib_unit);
+		ipath_dev_err(dev->dd, "piowait list not empty!\n");
 	if (!list_empty(&dev->rnrwait))
-		_VERBS_ERROR("ipath%d rnrwait list not empty!\n",
-			     dev->ib_unit);
+		ipath_dev_err(dev->dd, "rnrwait list not empty!\n");
 	if (!ipath_mcast_tree_empty())
-		_VERBS_ERROR("ipath%d multicast table memory leak!\n",
-			     dev->ib_unit);
+		ipath_dev_err(dev->dd, "multicast table memory leak!\n");
 	/*
 	 * Note that ipath_unregister_ib_device() can be called before all
 	 * the QPs are destroyed!
diff --git a/drivers/infiniband/hw/ipath/ipath_verbs.h b/drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri Aug 25 11:19:45 2006 -0700
@@ -42,7 +42,6 @@
 #include <rdma/ib_pack.h>
 
 #include "ipath_layer.h"
-#include "verbs_debug.h"
 
 #define QPN_MAX                 (1 << 24)
 #define QPNMAP_ENTRIES          (QPN_MAX / PAGE_SIZE / BITS_PER_BYTE)
diff --git a/drivers/infiniband/hw/ipath/verbs_debug.h b/drivers/infiniband/hw/ipath/verbs_debug.h
deleted file mode 100644
--- a/drivers/infiniband/hw/ipath/verbs_debug.h	Fri Aug 25 11:19:45 2006 -0700
+++ /dev/null	Thu Jan 01 00:00:00 1970 +0000
@@ -1,108 +0,0 @@
-/*
- * Copyright (c) 2006 QLogic, Inc. All rights reserved.
- * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *      - Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *
- *      - Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
- */
-
-#ifndef _VERBS_DEBUG_H
-#define _VERBS_DEBUG_H
-
-/*
- * This file contains tracing code for the ib_ipath kernel module.
- */
-#ifndef _VERBS_DEBUGGING	/* tracing enabled or not */
-#define _VERBS_DEBUGGING 1
-#endif
-
-extern unsigned ib_ipath_debug;
-
-#define _VERBS_ERROR(fmt,...) \
-	do { \
-		printk(KERN_ERR "%s: " fmt, "ib_ipath", ##__VA_ARGS__); \
-	} while(0)
-
-#define _VERBS_UNIT_ERROR(unit,fmt,...) \
-	do { \
-		printk(KERN_ERR "%s: " fmt, "ib_ipath", ##__VA_ARGS__); \
-	} while(0)
-
-#if _VERBS_DEBUGGING
-
-/*
- * Mask values for debugging.  The scheme allows us to compile out any
- * of the debug tracing stuff, and if compiled in, to enable or
- * disable dynamically.
- * This can be set at modprobe time also:
- *      modprobe ib_path ib_ipath_debug=3
- */
-
-#define __VERBS_INFO        0x1	/* generic low verbosity stuff */
-#define __VERBS_DBG         0x2	/* generic debug */
-#define __VERBS_VDBG        0x4	/* verbose debug */
-#define __VERBS_SMADBG      0x8000	/* sma packet debug */
-
-#define _VERBS_INFO(fmt,...) \
-	do { \
-		if (unlikely(ib_ipath_debug&__VERBS_INFO)) \
-			printk(KERN_INFO "%s: " fmt,"ib_ipath", \
-			       ##__VA_ARGS__); \
-	} while(0)
-
-#define _VERBS_DBG(fmt,...) \
-	do { \
-		if (unlikely(ib_ipath_debug&__VERBS_DBG)) \
-			printk(KERN_DEBUG "%s: " fmt, __func__, \
-			       ##__VA_ARGS__); \
-	} while(0)
-
-#define _VERBS_VDBG(fmt,...) \
-	do { \
-		if (unlikely(ib_ipath_debug&__VERBS_VDBG)) \
-			printk(KERN_DEBUG "%s: " fmt, __func__, \
-			       ##__VA_ARGS__); \
-	} while(0)
-
-#define _VERBS_SMADBG(fmt,...) \
-	do { \
-		if (unlikely(ib_ipath_debug&__VERBS_SMADBG)) \
-			printk(KERN_DEBUG "%s: " fmt, __func__, \
-			       ##__VA_ARGS__); \
-	} while(0)
-
-#else /* ! _VERBS_DEBUGGING */
-
-#define _VERBS_INFO(fmt,...)
-#define _VERBS_DBG(fmt,...)
-#define _VERBS_VDBG(fmt,...)
-#define _VERBS_SMADBG(fmt,...)
-
-#endif /* _VERBS_DEBUGGING */
-
-#endif /* _VERBS_DEBUG_H */
