Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422653AbWHYS3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422653AbWHYS3o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWHYS3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:29:19 -0400
Received: from mx.pathscale.com ([64.160.42.68]:42370 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422747AbWHYSZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:25:19 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 9 of 23] IB/ipath - remove stale references to userspace SMA
X-Mercurial-Node: ba25c2fe0e89bd4222bab4417accb8c6c705e2e7
Message-Id: <ba25c2fe0e89bd4222ba.1156530274@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1156530265@eng-12.pathscale.com>
Date: Fri, 25 Aug 2006 11:24:34 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When we first submitted a userspace subnet management agent, it was
rejected, so we left it out of the final driver submission.  This patch
removes a number of vestigial references to it.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff --git a/drivers/infiniband/hw/ipath/ipath_common.h b/drivers/infiniband/hw/ipath/ipath_common.h
--- a/drivers/infiniband/hw/ipath/ipath_common.h	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_common.h	Fri Aug 25 11:19:45 2006 -0700
@@ -106,9 +106,9 @@ struct infinipath_stats {
 	__u64 sps_ether_spkts;
 	/* number of "ethernet" packets received by driver */
 	__u64 sps_ether_rpkts;
-	/* number of SMA packets sent by driver */
+	/* number of SMA packets sent by driver. Obsolete. */
 	__u64 sps_sma_spkts;
-	/* number of SMA packets received by driver */
+	/* number of SMA packets received by driver. Obsolete. */
 	__u64 sps_sma_rpkts;
 	/* number of times all ports rcvhdrq was full and packet dropped */
 	__u64 sps_hdrqfull;
@@ -138,7 +138,7 @@ struct infinipath_stats {
 	__u64 sps_pageunlocks;
 	/*
 	 * Number of packets dropped in kernel other than errors (ether
-	 * packets if ipath not configured, sma/mad, etc.)
+	 * packets if ipath not configured, etc.)
 	 */
 	__u64 sps_krdrops;
 	/* pad for future growth */
@@ -153,8 +153,6 @@ struct infinipath_stats {
 #define IPATH_STATUS_DISABLED      0x2	/* hardware disabled */
 /* Device has been disabled via admin request */
 #define IPATH_STATUS_ADMIN_DISABLED    0x4
-#define IPATH_STATUS_OIB_SMA       0x8	/* ipath_mad kernel SMA running */
-#define IPATH_STATUS_SMA          0x10	/* user SMA running */
 /* Chip has been found and initted */
 #define IPATH_STATUS_CHIP_PRESENT 0x20
 /* IB link is at ACTIVE, usable for data traffic */
@@ -463,14 +461,6 @@ struct __ipath_sendpkt {
 	__u32 sps_cnt;		/* number of entries to use in sps_iov */
 	/* array of iov's describing packet. TEMPORARY */
 	struct ipath_iovec sps_iov[4];
-};
-
-/* Passed into SMA special file's ->read and ->write methods. */
-struct ipath_sma_pkt
-{
-	__u32 unit;	/* unit on which to send packet */
-	__u64 data;	/* address of payload in userspace */
-	__u32 len;	/* length of payload */
 };
 
 /*
diff --git a/drivers/infiniband/hw/ipath/ipath_debug.h b/drivers/infiniband/hw/ipath/ipath_debug.h
--- a/drivers/infiniband/hw/ipath/ipath_debug.h	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_debug.h	Fri Aug 25 11:19:45 2006 -0700
@@ -60,7 +60,6 @@
 #define __IPATH_USER_SEND   0x1000	/* use user mode send */
 #define __IPATH_KERNEL_SEND 0x2000	/* use kernel mode send */
 #define __IPATH_EPKTDBG     0x4000	/* print ethernet packet data */
-#define __IPATH_SMADBG      0x8000	/* sma packet debug */
 #define __IPATH_IPATHDBG    0x10000	/* Ethernet (IPATH) gen debug */
 #define __IPATH_IPATHWARN   0x20000	/* Ethernet (IPATH) warnings */
 #define __IPATH_IPATHERR    0x40000	/* Ethernet (IPATH) errors */
@@ -84,7 +83,6 @@
 /* print mmap/nopage stuff, not using VDBG any more */
 #define __IPATH_MMDBG     0x0
 #define __IPATH_EPKTDBG   0x0	/* print ethernet packet data */
-#define __IPATH_SMADBG    0x0   /* process startup (init)/exit messages */
 #define __IPATH_IPATHDBG  0x0	/* Ethernet (IPATH) table dump on */
 #define __IPATH_IPATHWARN 0x0	/* Ethernet (IPATH) warnings on   */
 #define __IPATH_IPATHERR  0x0	/* Ethernet (IPATH) errors on   */
diff --git a/drivers/infiniband/hw/ipath/ipath_driver.c b/drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Fri Aug 25 11:19:45 2006 -0700
@@ -64,7 +64,7 @@ DEFINE_SPINLOCK(ipath_devs_lock);
 DEFINE_SPINLOCK(ipath_devs_lock);
 LIST_HEAD(ipath_dev_list);
 
-wait_queue_head_t ipath_sma_state_wait;
+wait_queue_head_t ipath_state_wait;
 
 unsigned ipath_debug = __IPATH_INFO;
 
@@ -618,15 +618,16 @@ static int ipath_wait_linkstate(struct i
 static int ipath_wait_linkstate(struct ipath_devdata *dd, u32 state,
 				int msecs)
 {
-	dd->ipath_sma_state_wanted = state;
-	wait_event_interruptible_timeout(ipath_sma_state_wait,
+	dd->ipath_state_wanted = state;
+	wait_event_interruptible_timeout(ipath_state_wait,
 					 (dd->ipath_flags & state),
 					 msecs_to_jiffies(msecs));
-	dd->ipath_sma_state_wanted = 0;
+	dd->ipath_state_wanted = 0;
 
 	if (!(dd->ipath_flags & state)) {
 		u64 val;
-		ipath_cdbg(SMA, "Didn't reach linkstate %s within %u ms\n",
+		ipath_cdbg(VERBOSE, "Didn't reach linkstate %s within %u"
+			   " ms\n",
 			   /* test INIT ahead of DOWN, both can be set */
 			   (state & IPATH_LINKINIT) ? "INIT" :
 			   ((state & IPATH_LINKDOWN) ? "DOWN" :
@@ -1155,7 +1156,7 @@ int ipath_setrcvhdrsize(struct ipath_dev
  *
  * do appropriate marking as busy, etc.
  * returns buffer number if one found (>=0), negative number is error.
- * Used by ipath_sma_send_pkt and ipath_layer_send
+ * Used by ipath_layer_send
  */
 u32 __iomem *ipath_getpiobuf(struct ipath_devdata *dd, u32 * pbufnum)
 {
@@ -1448,7 +1449,7 @@ static void ipath_set_ib_lstate(struct i
 	int linkcmd = (which >> INFINIPATH_IBCC_LINKCMD_SHIFT) &
 			INFINIPATH_IBCC_LINKCMD_MASK;
 
-	ipath_cdbg(SMA, "Trying to move unit %u to %s, current ltstate "
+	ipath_cdbg(VERBOSE, "Trying to move unit %u to %s, current ltstate "
 		   "is %s\n", dd->ipath_unit,
 		   what[linkcmd],
 		   ipath_ibcstatus_str[
@@ -1457,7 +1458,7 @@ static void ipath_set_ib_lstate(struct i
 			    INFINIPATH_IBCS_LINKTRAININGSTATE_SHIFT) &
 			   INFINIPATH_IBCS_LINKTRAININGSTATE_MASK]);
 	/* flush all queued sends when going to DOWN or INIT, to be sure that
-	 * they don't block SMA and other MAD packets */
+	 * they don't block MAD packets */
 	if (!linkcmd || linkcmd == INFINIPATH_IBCC_LINKCMD_INIT) {
 		ipath_write_kreg(dd, dd->ipath_kregs->kr_sendctrl,
 				 INFINIPATH_S_ABORT);
diff --git a/drivers/infiniband/hw/ipath/ipath_file_ops.c b/drivers/infiniband/hw/ipath/ipath_file_ops.c
--- a/drivers/infiniband/hw/ipath/ipath_file_ops.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_file_ops.c	Fri Aug 25 11:19:45 2006 -0700
@@ -1816,7 +1816,7 @@ int ipath_user_add(struct ipath_devdata 
 		if (ret < 0) {
 			ipath_dev_err(dd, "Could not create wildcard "
 				      "minor: error %d\n", -ret);
-			goto bail_sma;
+			goto bail_user;
 		}
 
 		atomic_set(&user_setup, 1);
@@ -1832,7 +1832,7 @@ int ipath_user_add(struct ipath_devdata 
 
 	goto bail;
 
-bail_sma:
+bail_user:
 	user_cleanup();
 bail:
 	return ret;
diff --git a/drivers/infiniband/hw/ipath/ipath_fs.c b/drivers/infiniband/hw/ipath/ipath_fs.c
--- a/drivers/infiniband/hw/ipath/ipath_fs.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_fs.c	Fri Aug 25 11:19:45 2006 -0700
@@ -191,8 +191,8 @@ static ssize_t atomic_port_info_read(str
 	portinfo[4] = (dd->ipath_lid << 16);
 
 	/*
-	 * Notimpl yet SMLID (should we store this in the driver, in case
-	 * SMA dies?)  CapabilityMask is 0, we don't support any of these
+	 * Notimpl yet SMLID.
+	 * CapabilityMask is 0, we don't support any of these
 	 * DiagCode is 0; we don't store any diag info for now Notimpl yet
 	 * M_KeyLeasePeriod (we don't support M_Key)
 	 */
diff --git a/drivers/infiniband/hw/ipath/ipath_init_chip.c b/drivers/infiniband/hw/ipath/ipath_init_chip.c
--- a/drivers/infiniband/hw/ipath/ipath_init_chip.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_init_chip.c	Fri Aug 25 11:19:45 2006 -0700
@@ -53,8 +53,8 @@ MODULE_PARM_DESC(cfgports, "Set max numb
 MODULE_PARM_DESC(cfgports, "Set max number of ports to use");
 
 /*
- * Number of buffers reserved for driver (layered drivers and SMA
- * send).  Reserved at end of buffer list.   Initialized based on
+ * Number of buffers reserved for driver (verbs and layered drivers.)
+ * Reserved at end of buffer list.   Initialized based on
  * number of PIO buffers if not set via module interface.
  * The problem with this is that it's global, but we'll use different
  * numbers for different chip types.  So the default value is not
@@ -80,7 +80,7 @@ MODULE_PARM_DESC(kpiobufs, "Set number o
  *
  * Allocate the eager TID buffers and program them into infinipath.
  * We use the network layer alloc_skb() allocator to allocate the
- * memory, and either use the buffers as is for things like SMA
+ * memory, and either use the buffers as is for things like verbs
  * packets, or pass the buffers up to the ipath layered driver and
  * thence the network layer, replacing them as we do so (see
  * ipath_rcv_layer()).
@@ -450,9 +450,9 @@ static void enable_chip(struct ipath_dev
 	u32 val;
 	int i;
 
-	if (!reinit) {
-		init_waitqueue_head(&ipath_sma_state_wait);
-	}
+	if (!reinit)
+		init_waitqueue_head(&ipath_state_wait);
+
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_rcvctrl,
 			 dd->ipath_rcvctrl);
 
diff --git a/drivers/infiniband/hw/ipath/ipath_intr.c b/drivers/infiniband/hw/ipath/ipath_intr.c
--- a/drivers/infiniband/hw/ipath/ipath_intr.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_intr.c	Fri Aug 25 11:19:45 2006 -0700
@@ -201,7 +201,7 @@ static void handle_e_ibstatuschanged(str
 				  ib_linkstate(lstate));
 		}
 		else
-			ipath_cdbg(SMA, "Unit %u link state %s, last "
+			ipath_cdbg(VERBOSE, "Unit %u link state %s, last "
 				   "was %s\n", dd->ipath_unit,
 				   ib_linkstate(lstate),
 				   ib_linkstate((unsigned)
@@ -213,7 +213,7 @@ static void handle_e_ibstatuschanged(str
 		if (lstate == IPATH_IBSTATE_INIT ||
 		    lstate == IPATH_IBSTATE_ARM ||
 		    lstate == IPATH_IBSTATE_ACTIVE)
-			ipath_cdbg(SMA, "Unit %u link state down"
+			ipath_cdbg(VERBOSE, "Unit %u link state down"
 				   " (state 0x%x), from %s\n",
 				   dd->ipath_unit,
 				   (u32)val & IPATH_IBSTATE_MASK,
@@ -269,7 +269,7 @@ static void handle_e_ibstatuschanged(str
 			     INFINIPATH_IBCS_LINKSTATE_MASK)
 			    == INFINIPATH_IBCS_L_STATE_ACTIVE)
 				/* if from up to down be more vocal */
-				ipath_cdbg(SMA,
+				ipath_cdbg(VERBOSE,
 					   "Unit %u link now down (%s)\n",
 					   dd->ipath_unit,
 					   ipath_ibcstatus_str[ltstate]);
@@ -596,11 +596,11 @@ static int handle_errors(struct ipath_de
 
 	if (!noprint && *msg)
 		ipath_dev_err(dd, "%s error\n", msg);
-	if (dd->ipath_sma_state_wanted & dd->ipath_flags) {
-		ipath_cdbg(VERBOSE, "sma wanted state %x, iflags now %x, "
-			   "waking\n", dd->ipath_sma_state_wanted,
+	if (dd->ipath_state_wanted & dd->ipath_flags) {
+		ipath_cdbg(VERBOSE, "driver wanted state %x, iflags now %x, "
+			   "waking\n", dd->ipath_state_wanted,
 			   dd->ipath_flags);
-		wake_up_interruptible(&ipath_sma_state_wait);
+		wake_up_interruptible(&ipath_state_wait);
 	}
 
 	return chkerrpkts;
diff --git a/drivers/infiniband/hw/ipath/ipath_kernel.h b/drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri Aug 25 11:19:45 2006 -0700
@@ -245,8 +245,8 @@ struct ipath_devdata {
 	u32 ipath_pioavregs;
 	/* IPATH_POLL, etc. */
 	u32 ipath_flags;
-	/* ipath_flags sma is waiting for */
-	u32 ipath_sma_state_wanted;
+	/* ipath_flags driver is waiting for */
+	u32 ipath_state_wanted;
 	/* last buffer for user use, first buf for kernel use is this
 	 * index. */
 	u32 ipath_lastport_piobuf;
@@ -306,10 +306,6 @@ struct ipath_devdata {
 	u32 ipath_pcibar0;
 	/* so we can rewrite it after a chip reset */
 	u32 ipath_pcibar1;
-	/* sequential tries for SMA send and no bufs */
-	u32 ipath_nosma_bufs;
-	/* duration (seconds) ipath_nosma_bufs set */
-	u32 ipath_nosma_secs;
 
 	/* HT/PCI Vendor ID (here for NodeInfo) */
 	u16 ipath_vendorid;
@@ -534,7 +530,7 @@ void ipath_diag_remove(struct ipath_devd
 void ipath_diag_remove(struct ipath_devdata *);
 void ipath_diag_bringup_link(struct ipath_devdata *);
 
-extern wait_queue_head_t ipath_sma_state_wait;
+extern wait_queue_head_t ipath_state_wait;
 
 int ipath_user_add(struct ipath_devdata *dd);
 void ipath_user_remove(struct ipath_devdata *dd);
@@ -818,7 +814,6 @@ extern struct mutex ipath_mutex;
 #define IPATH_DRV_NAME		"ib_ipath"
 #define IPATH_MAJOR		233
 #define IPATH_USER_MINOR_BASE	0
-#define IPATH_SMA_MINOR		128
 #define IPATH_DIAG_MINOR_BASE	129
 #define IPATH_NMINORS		255
 
diff --git a/drivers/infiniband/hw/ipath/ipath_layer.c b/drivers/infiniband/hw/ipath/ipath_layer.c
--- a/drivers/infiniband/hw/ipath/ipath_layer.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_layer.c	Fri Aug 25 11:19:45 2006 -0700
@@ -161,9 +161,6 @@ int ipath_layer_register(void *(*l_add)(
 
 		if (dd->ipath_layer.l_arg)
 			continue;
-
-		if (!(*dd->ipath_statusp & IPATH_STATUS_SMA))
-			*dd->ipath_statusp |= IPATH_STATUS_OIB_SMA;
 
 		spin_unlock_irqrestore(&ipath_devs_lock, flags);
 		dd->ipath_layer.l_arg = l_add(dd->ipath_unit, dd);
diff --git a/drivers/infiniband/hw/ipath/ipath_layer.h b/drivers/infiniband/hw/ipath/ipath_layer.h
--- a/drivers/infiniband/hw/ipath/ipath_layer.h	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_layer.h	Fri Aug 25 11:19:45 2006 -0700
@@ -66,9 +66,6 @@ int ipath_layer_set_piointbufavail_int(s
 #define IPATH_LAYER_INT_SEND_CONTINUE 0x10
 #define IPATH_LAYER_INT_BCAST 0x40
 
-/* _verbs_layer.l_flags */
-#define IPATH_VERBS_KERNEL_SMA 0x1
-
 extern unsigned ipath_debug; /* debugging bit mask */
 
 #endif				/* _IPATH_LAYER_H */
diff --git a/drivers/infiniband/hw/ipath/ipath_qp.c b/drivers/infiniband/hw/ipath/ipath_qp.c
--- a/drivers/infiniband/hw/ipath/ipath_qp.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c	Fri Aug 25 11:19:45 2006 -0700
@@ -645,33 +645,6 @@ __be32 ipath_compute_aeth(struct ipath_q
 }
 
 /**
- * set_verbs_flags - set the verbs layer flags
- * @dd: the infinipath device
- * @flags: the flags to set
- */
-static int set_verbs_flags(struct ipath_devdata *dd, unsigned flags)
-{
-	struct ipath_devdata *ss;
-	unsigned long lflags;
-
-	spin_lock_irqsave(&ipath_devs_lock, lflags);
-
-	list_for_each_entry(ss, &ipath_dev_list, ipath_list) {
-		if (!(ss->ipath_flags & IPATH_INITTED))
-			continue;
-		if ((flags & IPATH_VERBS_KERNEL_SMA) &&
-		    !(*ss->ipath_statusp & IPATH_STATUS_SMA))
-			*ss->ipath_statusp |= IPATH_STATUS_OIB_SMA;
-		else
-			*ss->ipath_statusp &= ~IPATH_STATUS_OIB_SMA;
-	}
-
-	spin_unlock_irqrestore(&ipath_devs_lock, lflags);
-
-	return 0;
-}
-
-/**
  * ipath_create_qp - create a queue pair for a device
  * @ibpd: the protection domain who's device we create the queue pair for
  * @init_attr: the attributes of the queue pair
@@ -784,10 +757,6 @@ struct ib_qp *ipath_create_qp(struct ib_
 		}
 		qp->ip = NULL;
 		ipath_reset_qp(qp);
-
-		/* Tell the core driver that the kernel SMA is present. */
-		if (init_attr->qp_type == IB_QPT_SMI)
-			set_verbs_flags(dev->dd, IPATH_VERBS_KERNEL_SMA);
 		break;
 
 	default:
@@ -862,10 +831,6 @@ int ipath_destroy_qp(struct ib_qp *ibqp)
 	struct ipath_ibdev *dev = to_idev(ibqp->device);
 	unsigned long flags;
 
-	/* Tell the core driver that the kernel SMA is gone. */
-	if (qp->ibqp.qp_type == IB_QPT_SMI)
-		set_verbs_flags(dev->dd, 0);
-
 	spin_lock_irqsave(&qp->s_lock, flags);
 	qp->state = IB_QPS_ERR;
 	spin_unlock_irqrestore(&qp->s_lock, flags);
diff --git a/drivers/infiniband/hw/ipath/ipath_stats.c b/drivers/infiniband/hw/ipath/ipath_stats.c
--- a/drivers/infiniband/hw/ipath/ipath_stats.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_stats.c	Fri Aug 25 11:19:45 2006 -0700
@@ -271,33 +271,6 @@ void ipath_get_faststats(unsigned long o
 		}
 	}
 
-	if (dd->ipath_nosma_bufs) {
-		dd->ipath_nosma_secs += 5;
-		if (dd->ipath_nosma_secs >= 30) {
-			ipath_cdbg(SMA, "No SMA bufs avail %u seconds; "
-				   "cancelling pending sends\n",
-				   dd->ipath_nosma_secs);
-			/*
-			 * issue an abort as well, in case we have a packet
-			 * stuck in launch fifo.  This could corrupt an
-			 * outgoing user packet in the worst case,
-			 * but this is a pretty catastrophic, anyway.
-			 */
-			ipath_write_kreg(dd, dd->ipath_kregs->kr_sendctrl,
-					 INFINIPATH_S_ABORT);
-			ipath_disarm_piobufs(dd, dd->ipath_lastport_piobuf,
-					     dd->ipath_piobcnt2k +
-					     dd->ipath_piobcnt4k -
-					     dd->ipath_lastport_piobuf);
-			/* start again, if necessary */
-			dd->ipath_nosma_secs = 0;
-		} else
-			ipath_cdbg(SMA, "No SMA bufs avail %u tries, "
-				   "after %u seconds\n",
-				   dd->ipath_nosma_bufs,
-				   dd->ipath_nosma_secs);
-	}
-
 done:
 	mod_timer(&dd->ipath_stats_timer, jiffies + HZ * 5);
 }
diff --git a/drivers/infiniband/hw/ipath/ipath_sysfs.c b/drivers/infiniband/hw/ipath/ipath_sysfs.c
--- a/drivers/infiniband/hw/ipath/ipath_sysfs.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_sysfs.c	Fri Aug 25 11:19:45 2006 -0700
@@ -107,8 +107,8 @@ static const char *ipath_status_str[] = 
 	"Initted",
 	"Disabled",
 	"Admin_Disabled",
-	"OIB_SMA",
-	"SMA",
+	"", /* This used to be the old "OIB_SMA" status. */
+	"", /* This used to be the old "SMA" status. */
 	"Present",
 	"IB_link_up",
 	"IB_configured",
diff --git a/drivers/infiniband/hw/ipath/ipath_verbs.c b/drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri Aug 25 11:19:45 2006 -0700
@@ -1573,7 +1573,7 @@ int ipath_register_ib_device(struct ipat
 	dev->mmap = ipath_mmap;
 
 	snprintf(dev->node_desc, sizeof(dev->node_desc),
-		 IPATH_IDSTR " %s kernel_SMA", system_utsname.nodename);
+		 IPATH_IDSTR " %s", system_utsname.nodename);
 
 	ret = ib_register_device(dev);
 	if (ret)
