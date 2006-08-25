Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422780AbWHYS0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422780AbWHYS0g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422777AbWHYSZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:25:49 -0400
Received: from mx.pathscale.com ([64.160.42.68]:41602 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422743AbWHYSZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:25:19 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 7 of 23] IB/ipath - simplify layering code
X-Mercurial-Node: 6016a3c7c50a035985238484675ed39caee1557d
Message-Id: <6016a3c7c50a03598523.1156530272@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1156530265@eng-12.pathscale.com>
Date: Fri, 25 Aug 2006 11:24:32 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of ipath layer code was only called in one place. Now that the
ipath_core and ib_ipath drivers are merged, it's more sensible to simply
inline the simple stuff that the layer code was doing.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff --git a/drivers/infiniband/hw/ipath/ipath_diag.c b/drivers/infiniband/hw/ipath/ipath_diag.c
--- a/drivers/infiniband/hw/ipath/ipath_diag.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_diag.c	Fri Aug 25 11:19:45 2006 -0700
@@ -45,7 +45,6 @@
 #include <asm/uaccess.h>
 
 #include "ipath_kernel.h"
-#include "ipath_layer.h"
 #include "ipath_common.h"
 
 int ipath_diag_inuse;
diff --git a/drivers/infiniband/hw/ipath/ipath_driver.c b/drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Fri Aug 25 11:19:45 2006 -0700
@@ -39,7 +39,6 @@
 #include <linux/vmalloc.h>
 
 #include "ipath_kernel.h"
-#include "ipath_layer.h"
 #include "ipath_verbs.h"
 #include "ipath_common.h"
 
@@ -508,7 +507,6 @@ static int __devinit ipath_init_one(stru
 	ipathfs_add_device(dd);
 	ipath_user_add(dd);
 	ipath_diag_add(dd);
-	ipath_layer_add(dd);
 	ipath_register_ib_device(dd);
 
 	goto bail;
@@ -539,7 +537,6 @@ static void __devexit ipath_remove_one(s
 
 	dd = pci_get_drvdata(pdev);
 	ipath_unregister_ib_device(dd->verbs_dev);
-	ipath_layer_remove(dd);
 	ipath_diag_remove(dd);
 	ipath_user_remove(dd);
 	ipathfs_remove_device(dd);
@@ -614,11 +611,12 @@ void ipath_disarm_piobufs(struct ipath_d
  *
  * wait up to msecs milliseconds for IB link state change to occur for
  * now, take the easy polling route.  Currently used only by
- * ipath_layer_set_linkstate.  Returns 0 if state reached, otherwise
+ * ipath_set_linkstate.  Returns 0 if state reached, otherwise
  * -ETIMEDOUT state can have multiple states set, for any of several
  * transitions.
  */
-int ipath_wait_linkstate(struct ipath_devdata *dd, u32 state, int msecs)
+static int ipath_wait_linkstate(struct ipath_devdata *dd, u32 state,
+				int msecs)
 {
 	dd->ipath_sma_state_wanted = state;
 	wait_event_interruptible_timeout(ipath_sma_state_wait,
@@ -814,58 +812,6 @@ bail:
 	return skb;
 }
 
-/**
- * ipath_rcv_layer - receive a packet for the layered (ethernet) driver
- * @dd: the infinipath device
- * @etail: the sk_buff number
- * @tlen: the total packet length
- * @hdr: the ethernet header
- *
- * Separate routine for better overall optimization
- */
-static void ipath_rcv_layer(struct ipath_devdata *dd, u32 etail,
-			    u32 tlen, struct ether_header *hdr)
-{
-	u32 elen;
-	u8 pad, *bthbytes;
-	struct sk_buff *skb, *nskb;
-
-	if (dd->ipath_port0_skbs &&
-			hdr->sub_opcode == IPATH_ITH4X_OPCODE_ENCAP) {
-		/*
-		 * Allocate a new sk_buff to replace the one we give
-		 * to the network stack.
-		 */
-		nskb = ipath_alloc_skb(dd, GFP_ATOMIC);
-		if (!nskb) {
-			/* count OK packets that we drop */
-			ipath_stats.sps_krdrops++;
-			return;
-		}
-
-		bthbytes = (u8 *) hdr->bth;
-		pad = (bthbytes[1] >> 4) & 3;
-		/* +CRC32 */
-		elen = tlen - (sizeof(*hdr) + pad + sizeof(u32));
-
-		skb = dd->ipath_port0_skbs[etail];
-		dd->ipath_port0_skbs[etail] = nskb;
-		skb_put(skb, elen);
-
-		dd->ipath_f_put_tid(dd, etail + (u64 __iomem *)
-				    ((char __iomem *) dd->ipath_kregbase
-				     + dd->ipath_rcvegrbase), 0,
-				    virt_to_phys(nskb->data));
-
-		__ipath_layer_rcv(dd, hdr, skb);
-
-		/* another ether packet received */
-		ipath_stats.sps_ether_rpkts++;
-	}
-	else if (hdr->sub_opcode == IPATH_ITH4X_OPCODE_LID_ARP)
-		__ipath_layer_rcv_lid(dd, hdr);
-}
-
 static void ipath_rcv_hdrerr(struct ipath_devdata *dd,
 			     u32 eflags,
 			     u32 l,
@@ -979,22 +925,17 @@ reloop:
 		if (unlikely(eflags))
 			ipath_rcv_hdrerr(dd, eflags, l, etail, rc);
 		else if (etype == RCVHQ_RCV_TYPE_NON_KD) {
-				ipath_ib_rcv(dd->verbs_dev, rc + 1, ebuf,
-					     tlen);
-				if (dd->ipath_lli_counter)
-					dd->ipath_lli_counter--;
-
-		} else if (etype == RCVHQ_RCV_TYPE_EAGER) {
-			if (qp == IPATH_KD_QP &&
-			    bthbytes[0] == ipath_layer_rcv_opcode &&
-			    ebuf)
-				ipath_rcv_layer(dd, etail, tlen,
-						(struct ether_header *)hdr);
-			else
-				ipath_cdbg(PKT, "typ %x, opcode %x (eager, "
-					   "qp=%x), len %x; ignored\n",
-					   etype, bthbytes[0], qp, tlen);
-		}
+			ipath_ib_rcv(dd->verbs_dev, rc + 1, ebuf, tlen);
+			if (dd->ipath_lli_counter)
+				dd->ipath_lli_counter--;
+			ipath_cdbg(PKT, "typ %x, opcode %x (eager, "
+				   "qp=%x), len %x; ignored\n",
+				   etype, bthbytes[0], qp, tlen);
+		}
+		else if (etype == RCVHQ_RCV_TYPE_EAGER)
+			ipath_cdbg(PKT, "typ %x, opcode %x (eager, "
+				   "qp=%x), len %x; ignored\n",
+				   etype, bthbytes[0], qp, tlen);
 		else if (etype == RCVHQ_RCV_TYPE_EXPECTED)
 			ipath_dbg("Bug: Expected TID, opcode %x; ignored\n",
 				  be32_to_cpu(hdr->bth[0]) & 0xff);
@@ -1320,13 +1261,6 @@ rescan:
 		goto bail;
 	}
 
-	if (updated)
-		/*
-		 * ran out of bufs, now some (at least this one we just
-		 * got) are now available, so tell the layered driver.
-		 */
-		__ipath_layer_intr(dd, IPATH_LAYER_INT_SEND_CONTINUE);
-
 	/*
 	 * set next starting place.  Since it's just an optimization,
 	 * it doesn't matter who wins on this, so no locking
@@ -1503,7 +1437,7 @@ int ipath_waitfor_mdio_cmdready(struct i
 	return ret;
 }
 
-void ipath_set_ib_lstate(struct ipath_devdata *dd, int which)
+static void ipath_set_ib_lstate(struct ipath_devdata *dd, int which)
 {
 	static const char *what[4] = {
 		[0] = "DOWN",
@@ -1537,6 +1471,180 @@ void ipath_set_ib_lstate(struct ipath_de
 			 dd->ipath_ibcctrl | which);
 }
 
+int ipath_set_linkstate(struct ipath_devdata *dd, u8 newstate)
+{
+	u32 lstate;
+	int ret;
+
+	switch (newstate) {
+	case IPATH_IB_LINKDOWN:
+		ipath_set_ib_lstate(dd, INFINIPATH_IBCC_LINKINITCMD_POLL <<
+				    INFINIPATH_IBCC_LINKINITCMD_SHIFT);
+		/* don't wait */
+		ret = 0;
+		goto bail;
+
+	case IPATH_IB_LINKDOWN_SLEEP:
+		ipath_set_ib_lstate(dd, INFINIPATH_IBCC_LINKINITCMD_SLEEP <<
+				    INFINIPATH_IBCC_LINKINITCMD_SHIFT);
+		/* don't wait */
+		ret = 0;
+		goto bail;
+
+	case IPATH_IB_LINKDOWN_DISABLE:
+		ipath_set_ib_lstate(dd,
+				    INFINIPATH_IBCC_LINKINITCMD_DISABLE <<
+				    INFINIPATH_IBCC_LINKINITCMD_SHIFT);
+		/* don't wait */
+		ret = 0;
+		goto bail;
+
+	case IPATH_IB_LINKINIT:
+		if (dd->ipath_flags & IPATH_LINKINIT) {
+			ret = 0;
+			goto bail;
+		}
+		ipath_set_ib_lstate(dd, INFINIPATH_IBCC_LINKCMD_INIT <<
+				    INFINIPATH_IBCC_LINKCMD_SHIFT);
+		lstate = IPATH_LINKINIT;
+		break;
+
+	case IPATH_IB_LINKARM:
+		if (dd->ipath_flags & IPATH_LINKARMED) {
+			ret = 0;
+			goto bail;
+		}
+		if (!(dd->ipath_flags &
+		      (IPATH_LINKINIT | IPATH_LINKACTIVE))) {
+			ret = -EINVAL;
+			goto bail;
+		}
+		ipath_set_ib_lstate(dd, INFINIPATH_IBCC_LINKCMD_ARMED <<
+				    INFINIPATH_IBCC_LINKCMD_SHIFT);
+		/*
+		 * Since the port can transition to ACTIVE by receiving
+		 * a non VL 15 packet, wait for either state.
+		 */
+		lstate = IPATH_LINKARMED | IPATH_LINKACTIVE;
+		break;
+
+	case IPATH_IB_LINKACTIVE:
+		if (dd->ipath_flags & IPATH_LINKACTIVE) {
+			ret = 0;
+			goto bail;
+		}
+		if (!(dd->ipath_flags & IPATH_LINKARMED)) {
+			ret = -EINVAL;
+			goto bail;
+		}
+		ipath_set_ib_lstate(dd, INFINIPATH_IBCC_LINKCMD_ACTIVE <<
+				    INFINIPATH_IBCC_LINKCMD_SHIFT);
+		lstate = IPATH_LINKACTIVE;
+		break;
+
+	default:
+		ipath_dbg("Invalid linkstate 0x%x requested\n", newstate);
+		ret = -EINVAL;
+		goto bail;
+	}
+	ret = ipath_wait_linkstate(dd, lstate, 2000);
+
+bail:
+	return ret;
+}
+
+/**
+ * ipath_set_mtu - set the MTU
+ * @dd: the infinipath device
+ * @arg: the new MTU
+ *
+ * we can handle "any" incoming size, the issue here is whether we
+ * need to restrict our outgoing size.   For now, we don't do any
+ * sanity checking on this, and we don't deal with what happens to
+ * programs that are already running when the size changes.
+ * NOTE: changing the MTU will usually cause the IBC to go back to
+ * link initialize (IPATH_IBSTATE_INIT) state...
+ */
+int ipath_set_mtu(struct ipath_devdata *dd, u16 arg)
+{
+	u32 piosize;
+	int changed = 0;
+	int ret;
+
+	/*
+	 * mtu is IB data payload max.  It's the largest power of 2 less
+	 * than piosize (or even larger, since it only really controls the
+	 * largest we can receive; we can send the max of the mtu and
+	 * piosize).  We check that it's one of the valid IB sizes.
+	 */
+	if (arg != 256 && arg != 512 && arg != 1024 && arg != 2048 &&
+	    arg != 4096) {
+		ipath_dbg("Trying to set invalid mtu %u, failing\n", arg);
+		ret = -EINVAL;
+		goto bail;
+	}
+	if (dd->ipath_ibmtu == arg) {
+		ret = 0;        /* same as current */
+		goto bail;
+	}
+
+	piosize = dd->ipath_ibmaxlen;
+	dd->ipath_ibmtu = arg;
+
+	if (arg >= (piosize - IPATH_PIO_MAXIBHDR)) {
+		/* Only if it's not the initial value (or reset to it) */
+		if (piosize != dd->ipath_init_ibmaxlen) {
+			dd->ipath_ibmaxlen = piosize;
+			changed = 1;
+		}
+	} else if ((arg + IPATH_PIO_MAXIBHDR) != dd->ipath_ibmaxlen) {
+		piosize = arg + IPATH_PIO_MAXIBHDR;
+		ipath_cdbg(VERBOSE, "ibmaxlen was 0x%x, setting to 0x%x "
+			   "(mtu 0x%x)\n", dd->ipath_ibmaxlen, piosize,
+			   arg);
+		dd->ipath_ibmaxlen = piosize;
+		changed = 1;
+	}
+
+	if (changed) {
+		/*
+		 * set the IBC maxpktlength to the size of our pio
+		 * buffers in words
+		 */
+		u64 ibc = dd->ipath_ibcctrl;
+		ibc &= ~(INFINIPATH_IBCC_MAXPKTLEN_MASK <<
+			 INFINIPATH_IBCC_MAXPKTLEN_SHIFT);
+
+		piosize = piosize - 2 * sizeof(u32);    /* ignore pbc */
+		dd->ipath_ibmaxlen = piosize;
+		piosize /= sizeof(u32); /* in words */
+		/*
+		 * for ICRC, which we only send in diag test pkt mode, and
+		 * we don't need to worry about that for mtu
+		 */
+		piosize += 1;
+
+		ibc |= piosize << INFINIPATH_IBCC_MAXPKTLEN_SHIFT;
+		dd->ipath_ibcctrl = ibc;
+		ipath_write_kreg(dd, dd->ipath_kregs->kr_ibcctrl,
+				 dd->ipath_ibcctrl);
+		dd->ipath_f_tidtemplate(dd);
+	}
+
+	ret = 0;
+
+bail:
+	return ret;
+}
+
+int ipath_set_lid(struct ipath_devdata *dd, u32 arg, u8 lmc)
+{
+	dd->ipath_lid = arg;
+	dd->ipath_lmc = lmc;
+
+	return 0;
+}
+
 /**
  * ipath_read_kreg64_port - read a device's per-port 64-bit kernel register
  * @dd: the infinipath device
@@ -1639,13 +1747,6 @@ void ipath_shutdown_device(struct ipath_
 
 	ipath_set_ib_lstate(dd, INFINIPATH_IBCC_LINKINITCMD_DISABLE <<
 			    INFINIPATH_IBCC_LINKINITCMD_SHIFT);
-
-	/*
-	 * we are shutting down, so tell the layered driver.  We don't do
-	 * this on just a link state change, much like ethernet, a cable
-	 * unplug, etc. doesn't change driver state
-	 */
-	ipath_layer_intr(dd, IPATH_LAYER_INT_IF_DOWN);
 
 	/* disable IBC */
 	dd->ipath_control &= ~INFINIPATH_C_LINKENABLE;
diff --git a/drivers/infiniband/hw/ipath/ipath_file_ops.c b/drivers/infiniband/hw/ipath/ipath_file_ops.c
--- a/drivers/infiniband/hw/ipath/ipath_file_ops.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_file_ops.c	Fri Aug 25 11:19:45 2006 -0700
@@ -39,7 +39,6 @@
 #include <asm/pgtable.h>
 
 #include "ipath_kernel.h"
-#include "ipath_layer.h"
 #include "ipath_common.h"
 
 static int ipath_open(struct inode *, struct file *);
diff --git a/drivers/infiniband/hw/ipath/ipath_intr.c b/drivers/infiniband/hw/ipath/ipath_intr.c
--- a/drivers/infiniband/hw/ipath/ipath_intr.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_intr.c	Fri Aug 25 11:19:45 2006 -0700
@@ -34,7 +34,6 @@
 #include <linux/pci.h>
 
 #include "ipath_kernel.h"
-#include "ipath_layer.h"
 #include "ipath_verbs.h"
 #include "ipath_common.h"
 
@@ -290,8 +289,6 @@ static void handle_e_ibstatuschanged(str
 		*dd->ipath_statusp |=
 			IPATH_STATUS_IB_READY | IPATH_STATUS_IB_CONF;
 		dd->ipath_f_setextled(dd, lstate, ltstate);
-
-		__ipath_layer_intr(dd, IPATH_LAYER_INT_IF_UP);
 	} else if ((val & IPATH_IBSTATE_MASK) == IPATH_IBSTATE_INIT) {
 		/*
 		 * set INIT and DOWN.  Down is checked by most of the other
@@ -709,10 +706,6 @@ static void handle_layer_pioavail(struct
 {
 	int ret;
 
-	ret = __ipath_layer_intr(dd, IPATH_LAYER_INT_SEND_CONTINUE);
-	if (ret > 0)
-		goto set;
-
 	ret = ipath_ib_piobufavail(dd->verbs_dev);
 	if (ret > 0)
 		goto set;
diff --git a/drivers/infiniband/hw/ipath/ipath_kernel.h b/drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri Aug 25 11:19:45 2006 -0700
@@ -518,16 +518,6 @@ extern spinlock_t ipath_devs_lock;
 extern spinlock_t ipath_devs_lock;
 extern struct ipath_devdata *ipath_lookup(int unit);
 
-extern u16 ipath_layer_rcv_opcode;
-extern int __ipath_layer_intr(struct ipath_devdata *, u32);
-extern int ipath_layer_intr(struct ipath_devdata *, u32);
-extern int __ipath_layer_rcv(struct ipath_devdata *, void *,
-			     struct sk_buff *);
-extern int __ipath_layer_rcv_lid(struct ipath_devdata *, void *);
-
-void ipath_layer_add(struct ipath_devdata *);
-void ipath_layer_remove(struct ipath_devdata *);
-
 int ipath_init_chip(struct ipath_devdata *, int);
 int ipath_enable_wc(struct ipath_devdata *dd);
 void ipath_disable_wc(struct ipath_devdata *dd);
@@ -575,12 +565,13 @@ void ipath_free_pddata(struct ipath_devd
 
 int ipath_parse_ushort(const char *str, unsigned short *valp);
 
-int ipath_wait_linkstate(struct ipath_devdata *, u32, int);
-void ipath_set_ib_lstate(struct ipath_devdata *, int);
 void ipath_kreceive(struct ipath_devdata *);
 int ipath_setrcvhdrsize(struct ipath_devdata *, unsigned);
 int ipath_reset_device(int);
 void ipath_get_faststats(unsigned long);
+int ipath_set_linkstate(struct ipath_devdata *, u8);
+int ipath_set_mtu(struct ipath_devdata *, u16);
+int ipath_set_lid(struct ipath_devdata *, u32, u8);
 
 /* for use in system calls, where we want to know device type, etc. */
 #define port_fp(fp) ((struct ipath_portdata *) (fp)->private_data)
diff --git a/drivers/infiniband/hw/ipath/ipath_layer.c b/drivers/infiniband/hw/ipath/ipath_layer.c
--- a/drivers/infiniband/hw/ipath/ipath_layer.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_layer.c	Fri Aug 25 11:19:45 2006 -0700
@@ -101,242 +101,14 @@ int __ipath_layer_rcv_lid(struct ipath_d
 	return ret;
 }
 
-int ipath_layer_set_linkstate(struct ipath_devdata *dd, u8 newstate)
-{
-	u32 lstate;
-	int ret;
-
-	switch (newstate) {
-	case IPATH_IB_LINKDOWN:
-		ipath_set_ib_lstate(dd, INFINIPATH_IBCC_LINKINITCMD_POLL <<
-				    INFINIPATH_IBCC_LINKINITCMD_SHIFT);
-		/* don't wait */
-		ret = 0;
-		goto bail;
-
-	case IPATH_IB_LINKDOWN_SLEEP:
-		ipath_set_ib_lstate(dd, INFINIPATH_IBCC_LINKINITCMD_SLEEP <<
-				    INFINIPATH_IBCC_LINKINITCMD_SHIFT);
-		/* don't wait */
-		ret = 0;
-		goto bail;
-
-	case IPATH_IB_LINKDOWN_DISABLE:
-		ipath_set_ib_lstate(dd,
-				    INFINIPATH_IBCC_LINKINITCMD_DISABLE <<
-				    INFINIPATH_IBCC_LINKINITCMD_SHIFT);
-		/* don't wait */
-		ret = 0;
-		goto bail;
-
-	case IPATH_IB_LINKINIT:
-		if (dd->ipath_flags & IPATH_LINKINIT) {
-			ret = 0;
-			goto bail;
-		}
-		ipath_set_ib_lstate(dd, INFINIPATH_IBCC_LINKCMD_INIT <<
-				    INFINIPATH_IBCC_LINKCMD_SHIFT);
-		lstate = IPATH_LINKINIT;
-		break;
-
-	case IPATH_IB_LINKARM:
-		if (dd->ipath_flags & IPATH_LINKARMED) {
-			ret = 0;
-			goto bail;
-		}
-		if (!(dd->ipath_flags &
-		      (IPATH_LINKINIT | IPATH_LINKACTIVE))) {
-			ret = -EINVAL;
-			goto bail;
-		}
-		ipath_set_ib_lstate(dd, INFINIPATH_IBCC_LINKCMD_ARMED <<
-				    INFINIPATH_IBCC_LINKCMD_SHIFT);
-		/*
-		 * Since the port can transition to ACTIVE by receiving
-		 * a non VL 15 packet, wait for either state.
-		 */
-		lstate = IPATH_LINKARMED | IPATH_LINKACTIVE;
-		break;
-
-	case IPATH_IB_LINKACTIVE:
-		if (dd->ipath_flags & IPATH_LINKACTIVE) {
-			ret = 0;
-			goto bail;
-		}
-		if (!(dd->ipath_flags & IPATH_LINKARMED)) {
-			ret = -EINVAL;
-			goto bail;
-		}
-		ipath_set_ib_lstate(dd, INFINIPATH_IBCC_LINKCMD_ACTIVE <<
-				    INFINIPATH_IBCC_LINKCMD_SHIFT);
-		lstate = IPATH_LINKACTIVE;
-		break;
-
-	default:
-		ipath_dbg("Invalid linkstate 0x%x requested\n", newstate);
-		ret = -EINVAL;
-		goto bail;
-	}
-	ret = ipath_wait_linkstate(dd, lstate, 2000);
-
-bail:
-	return ret;
-}
-
-/**
- * ipath_layer_set_mtu - set the MTU
- * @dd: the infinipath device
- * @arg: the new MTU
- *
- * we can handle "any" incoming size, the issue here is whether we
- * need to restrict our outgoing size.   For now, we don't do any
- * sanity checking on this, and we don't deal with what happens to
- * programs that are already running when the size changes.
- * NOTE: changing the MTU will usually cause the IBC to go back to
- * link initialize (IPATH_IBSTATE_INIT) state...
- */
-int ipath_layer_set_mtu(struct ipath_devdata *dd, u16 arg)
-{
-	u32 piosize;
-	int changed = 0;
-	int ret;
-
-	/*
-	 * mtu is IB data payload max.  It's the largest power of 2 less
-	 * than piosize (or even larger, since it only really controls the
-	 * largest we can receive; we can send the max of the mtu and
-	 * piosize).  We check that it's one of the valid IB sizes.
-	 */
-	if (arg != 256 && arg != 512 && arg != 1024 && arg != 2048 &&
-	    arg != 4096) {
-		ipath_dbg("Trying to set invalid mtu %u, failing\n", arg);
-		ret = -EINVAL;
-		goto bail;
-	}
-	if (dd->ipath_ibmtu == arg) {
-		ret = 0;	/* same as current */
-		goto bail;
-	}
-
-	piosize = dd->ipath_ibmaxlen;
-	dd->ipath_ibmtu = arg;
-
-	if (arg >= (piosize - IPATH_PIO_MAXIBHDR)) {
-		/* Only if it's not the initial value (or reset to it) */
-		if (piosize != dd->ipath_init_ibmaxlen) {
-			dd->ipath_ibmaxlen = piosize;
-			changed = 1;
-		}
-	} else if ((arg + IPATH_PIO_MAXIBHDR) != dd->ipath_ibmaxlen) {
-		piosize = arg + IPATH_PIO_MAXIBHDR;
-		ipath_cdbg(VERBOSE, "ibmaxlen was 0x%x, setting to 0x%x "
-			   "(mtu 0x%x)\n", dd->ipath_ibmaxlen, piosize,
-			   arg);
-		dd->ipath_ibmaxlen = piosize;
-		changed = 1;
-	}
-
-	if (changed) {
-		/*
-		 * set the IBC maxpktlength to the size of our pio
-		 * buffers in words
-		 */
-		u64 ibc = dd->ipath_ibcctrl;
-		ibc &= ~(INFINIPATH_IBCC_MAXPKTLEN_MASK <<
-			 INFINIPATH_IBCC_MAXPKTLEN_SHIFT);
-
-		piosize = piosize - 2 * sizeof(u32);	/* ignore pbc */
-		dd->ipath_ibmaxlen = piosize;
-		piosize /= sizeof(u32);	/* in words */
-		/*
-		 * for ICRC, which we only send in diag test pkt mode, and
-		 * we don't need to worry about that for mtu
-		 */
-		piosize += 1;
-
-		ibc |= piosize << INFINIPATH_IBCC_MAXPKTLEN_SHIFT;
-		dd->ipath_ibcctrl = ibc;
-		ipath_write_kreg(dd, dd->ipath_kregs->kr_ibcctrl,
-				 dd->ipath_ibcctrl);
-		dd->ipath_f_tidtemplate(dd);
-	}
-
-	ret = 0;
-
-bail:
-	return ret;
-}
-
-int ipath_set_lid(struct ipath_devdata *dd, u32 arg, u8 lmc)
-{
-	dd->ipath_lid = arg;
-	dd->ipath_lmc = lmc;
-
+void ipath_layer_lid_changed(struct ipath_devdata *dd)
+{
 	mutex_lock(&ipath_layer_mutex);
 
 	if (dd->ipath_layer.l_arg && layer_intr)
 		layer_intr(dd->ipath_layer.l_arg, IPATH_LAYER_INT_LID);
 
 	mutex_unlock(&ipath_layer_mutex);
-
-	return 0;
-}
-
-int ipath_layer_set_guid(struct ipath_devdata *dd, __be64 guid)
-{
-	/* XXX - need to inform anyone who cares this just happened. */
-	dd->ipath_guid = guid;
-	return 0;
-}
-
-__be64 ipath_layer_get_guid(struct ipath_devdata *dd)
-{
-	return dd->ipath_guid;
-}
-
-u32 ipath_layer_get_majrev(struct ipath_devdata *dd)
-{
-	return dd->ipath_majrev;
-}
-
-u32 ipath_layer_get_minrev(struct ipath_devdata *dd)
-{
-	return dd->ipath_minrev;
-}
-
-u32 ipath_layer_get_pcirev(struct ipath_devdata *dd)
-{
-	return dd->ipath_pcirev;
-}
-
-u32 ipath_layer_get_flags(struct ipath_devdata *dd)
-{
-	return dd->ipath_flags;
-}
-
-struct device *ipath_layer_get_device(struct ipath_devdata *dd)
-{
-	return &dd->pcidev->dev;
-}
-
-u16 ipath_layer_get_deviceid(struct ipath_devdata *dd)
-{
-	return dd->ipath_deviceid;
-}
-
-u32 ipath_layer_get_vendorid(struct ipath_devdata *dd)
-{
-	return dd->ipath_vendorid;
-}
-
-u64 ipath_layer_get_lastibcstat(struct ipath_devdata *dd)
-{
-	return dd->ipath_lastibcstat;
-}
-
-u32 ipath_layer_get_ibmtu(struct ipath_devdata *dd)
-{
-	return dd->ipath_ibmtu;
 }
 
 void ipath_layer_add(struct ipath_devdata *dd)
@@ -435,22 +207,6 @@ void ipath_layer_unregister(void)
 }
 
 EXPORT_SYMBOL_GPL(ipath_layer_unregister);
-
-static void __ipath_verbs_timer(unsigned long arg)
-{
-	struct ipath_devdata *dd = (struct ipath_devdata *) arg;
-
-	/*
-	 * If port 0 receive packet interrupts are not available, or
-	 * can be missed, poll the receive queue
-	 */
-	if (dd->ipath_flags & IPATH_POLL_RX_INTR)
-		ipath_kreceive(dd);
-
-	/* Handle verbs layer timeouts. */
-	ipath_ib_timer(dd->verbs_dev);
-	mod_timer(&dd->verbs_timer, jiffies + 1);
-}
 
 int ipath_layer_open(struct ipath_devdata *dd, u32 * pktmax)
 {
@@ -539,380 +295,6 @@ u16 ipath_layer_get_bcast(struct ipath_d
 }
 
 EXPORT_SYMBOL_GPL(ipath_layer_get_bcast);
-
-u32 ipath_layer_get_cr_errpkey(struct ipath_devdata *dd)
-{
-	return ipath_read_creg32(dd, dd->ipath_cregs->cr_errpkey);
-}
-
-static void update_sge(struct ipath_sge_state *ss, u32 length)
-{
-	struct ipath_sge *sge = &ss->sge;
-
-	sge->vaddr += length;
-	sge->length -= length;
-	sge->sge_length -= length;
-	if (sge->sge_length == 0) {
-		if (--ss->num_sge)
-			*sge = *ss->sg_list++;
-	} else if (sge->length == 0 && sge->mr != NULL) {
-		if (++sge->n >= IPATH_SEGSZ) {
-			if (++sge->m >= sge->mr->mapsz)
-				return;
-			sge->n = 0;
-		}
-		sge->vaddr = sge->mr->map[sge->m]->segs[sge->n].vaddr;
-		sge->length = sge->mr->map[sge->m]->segs[sge->n].length;
-	}
-}
-
-#ifdef __LITTLE_ENDIAN
-static inline u32 get_upper_bits(u32 data, u32 shift)
-{
-	return data >> shift;
-}
-
-static inline u32 set_upper_bits(u32 data, u32 shift)
-{
-	return data << shift;
-}
-
-static inline u32 clear_upper_bytes(u32 data, u32 n, u32 off)
-{
-	data <<= ((sizeof(u32) - n) * BITS_PER_BYTE);
-	data >>= ((sizeof(u32) - n - off) * BITS_PER_BYTE);
-	return data;
-}
-#else
-static inline u32 get_upper_bits(u32 data, u32 shift)
-{
-	return data << shift;
-}
-
-static inline u32 set_upper_bits(u32 data, u32 shift)
-{
-	return data >> shift;
-}
-
-static inline u32 clear_upper_bytes(u32 data, u32 n, u32 off)
-{
-	data >>= ((sizeof(u32) - n) * BITS_PER_BYTE);
-	data <<= ((sizeof(u32) - n - off) * BITS_PER_BYTE);
-	return data;
-}
-#endif
-
-static void copy_io(u32 __iomem *piobuf, struct ipath_sge_state *ss,
-		    u32 length)
-{
-	u32 extra = 0;
-	u32 data = 0;
-	u32 last;
-
-	while (1) {
-		u32 len = ss->sge.length;
-		u32 off;
-
-		BUG_ON(len == 0);
-		if (len > length)
-			len = length;
-		if (len > ss->sge.sge_length)
-			len = ss->sge.sge_length;
-		/* If the source address is not aligned, try to align it. */
-		off = (unsigned long)ss->sge.vaddr & (sizeof(u32) - 1);
-		if (off) {
-			u32 *addr = (u32 *)((unsigned long)ss->sge.vaddr &
-					    ~(sizeof(u32) - 1));
-			u32 v = get_upper_bits(*addr, off * BITS_PER_BYTE);
-			u32 y;
-
-			y = sizeof(u32) - off;
-			if (len > y)
-				len = y;
-			if (len + extra >= sizeof(u32)) {
-				data |= set_upper_bits(v, extra *
-						       BITS_PER_BYTE);
-				len = sizeof(u32) - extra;
-				if (len == length) {
-					last = data;
-					break;
-				}
-				__raw_writel(data, piobuf);
-				piobuf++;
-				extra = 0;
-				data = 0;
-			} else {
-				/* Clear unused upper bytes */
-				data |= clear_upper_bytes(v, len, extra);
-				if (len == length) {
-					last = data;
-					break;
-				}
-				extra += len;
-			}
-		} else if (extra) {
-			/* Source address is aligned. */
-			u32 *addr = (u32 *) ss->sge.vaddr;
-			int shift = extra * BITS_PER_BYTE;
-			int ushift = 32 - shift;
-			u32 l = len;
-
-			while (l >= sizeof(u32)) {
-				u32 v = *addr;
-
-				data |= set_upper_bits(v, shift);
-				__raw_writel(data, piobuf);
-				data = get_upper_bits(v, ushift);
-				piobuf++;
-				addr++;
-				l -= sizeof(u32);
-			}
-			/*
-			 * We still have 'extra' number of bytes leftover.
-			 */
-			if (l) {
-				u32 v = *addr;
-
-				if (l + extra >= sizeof(u32)) {
-					data |= set_upper_bits(v, shift);
-					len -= l + extra - sizeof(u32);
-					if (len == length) {
-						last = data;
-						break;
-					}
-					__raw_writel(data, piobuf);
-					piobuf++;
-					extra = 0;
-					data = 0;
-				} else {
-					/* Clear unused upper bytes */
-					data |= clear_upper_bytes(v, l,
-								  extra);
-					if (len == length) {
-						last = data;
-						break;
-					}
-					extra += l;
-				}
-			} else if (len == length) {
-				last = data;
-				break;
-			}
-		} else if (len == length) {
-			u32 w;
-
-			/*
-			 * Need to round up for the last dword in the
-			 * packet.
-			 */
-			w = (len + 3) >> 2;
-			__iowrite32_copy(piobuf, ss->sge.vaddr, w - 1);
-			piobuf += w - 1;
-			last = ((u32 *) ss->sge.vaddr)[w - 1];
-			break;
-		} else {
-			u32 w = len >> 2;
-
-			__iowrite32_copy(piobuf, ss->sge.vaddr, w);
-			piobuf += w;
-
-			extra = len & (sizeof(u32) - 1);
-			if (extra) {
-				u32 v = ((u32 *) ss->sge.vaddr)[w];
-
-				/* Clear unused upper bytes */
-				data = clear_upper_bytes(v, extra, 0);
-			}
-		}
-		update_sge(ss, len);
-		length -= len;
-	}
-	/* Update address before sending packet. */
-	update_sge(ss, length);
-	/* must flush early everything before trigger word */
-	ipath_flush_wc();
-	__raw_writel(last, piobuf);
-	/* be sure trigger word is written */
-	ipath_flush_wc();
-}
-
-/**
- * ipath_verbs_send - send a packet from the verbs layer
- * @dd: the infinipath device
- * @hdrwords: the number of words in the header
- * @hdr: the packet header
- * @len: the length of the packet in bytes
- * @ss: the SGE to send
- *
- * This is like ipath_sma_send_pkt() in that we need to be able to send
- * packets after the chip is initialized (MADs) but also like
- * ipath_layer_send_hdr() since its used by the verbs layer.
- */
-int ipath_verbs_send(struct ipath_devdata *dd, u32 hdrwords,
-		     u32 *hdr, u32 len, struct ipath_sge_state *ss)
-{
-	u32 __iomem *piobuf;
-	u32 plen;
-	int ret;
-
-	/* +1 is for the qword padding of pbc */
-	plen = hdrwords + ((len + 3) >> 2) + 1;
-	if (unlikely((plen << 2) > dd->ipath_ibmaxlen)) {
-		ipath_dbg("packet len 0x%x too long, failing\n", plen);
-		ret = -EINVAL;
-		goto bail;
-	}
-
-	/* Get a PIO buffer to use. */
-	piobuf = ipath_getpiobuf(dd, NULL);
-	if (unlikely(piobuf == NULL)) {
-		ret = -EBUSY;
-		goto bail;
-	}
-
-	/*
-	 * Write len to control qword, no flags.
-	 * We have to flush after the PBC for correctness on some cpus
-	 * or WC buffer can be written out of order.
-	 */
-	writeq(plen, piobuf);
-	ipath_flush_wc();
-	piobuf += 2;
-	if (len == 0) {
-		/*
-		 * If there is just the header portion, must flush before
-		 * writing last word of header for correctness, and after
-		 * the last header word (trigger word).
-		 */
-		__iowrite32_copy(piobuf, hdr, hdrwords - 1);
-		ipath_flush_wc();
-		__raw_writel(hdr[hdrwords - 1], piobuf + hdrwords - 1);
-		ipath_flush_wc();
-		ret = 0;
-		goto bail;
-	}
-
-	__iowrite32_copy(piobuf, hdr, hdrwords);
-	piobuf += hdrwords;
-
-	/* The common case is aligned and contained in one segment. */
-	if (likely(ss->num_sge == 1 && len <= ss->sge.length &&
-		   !((unsigned long)ss->sge.vaddr & (sizeof(u32) - 1)))) {
-		u32 w;
-		u32 *addr = (u32 *) ss->sge.vaddr;
-
-		/* Update address before sending packet. */
-		update_sge(ss, len);
-		/* Need to round up for the last dword in the packet. */
-		w = (len + 3) >> 2;
-		__iowrite32_copy(piobuf, addr, w - 1);
-		/* must flush early everything before trigger word */
-		ipath_flush_wc();
-		__raw_writel(addr[w - 1], piobuf + w - 1);
-		/* be sure trigger word is written */
-		ipath_flush_wc();
-		ret = 0;
-		goto bail;
-	}
-	copy_io(piobuf, ss, len);
-	ret = 0;
-
-bail:
-	return ret;
-}
-
-int ipath_layer_snapshot_counters(struct ipath_devdata *dd, u64 *swords,
-				  u64 *rwords, u64 *spkts, u64 *rpkts,
-				  u64 *xmit_wait)
-{
-	int ret;
-
-	if (!(dd->ipath_flags & IPATH_INITTED)) {
-		/* no hardware, freeze, etc. */
-		ipath_dbg("unit %u not usable\n", dd->ipath_unit);
-		ret = -EINVAL;
-		goto bail;
-	}
-	*swords = ipath_snap_cntr(dd, dd->ipath_cregs->cr_wordsendcnt);
-	*rwords = ipath_snap_cntr(dd, dd->ipath_cregs->cr_wordrcvcnt);
-	*spkts = ipath_snap_cntr(dd, dd->ipath_cregs->cr_pktsendcnt);
-	*rpkts = ipath_snap_cntr(dd, dd->ipath_cregs->cr_pktrcvcnt);
-	*xmit_wait = ipath_snap_cntr(dd, dd->ipath_cregs->cr_sendstallcnt);
-
-	ret = 0;
-
-bail:
-	return ret;
-}
-
-/**
- * ipath_layer_get_counters - get various chip counters
- * @dd: the infinipath device
- * @cntrs: counters are placed here
- *
- * Return the counters needed by recv_pma_get_portcounters().
- */
-int ipath_layer_get_counters(struct ipath_devdata *dd,
-			      struct ipath_layer_counters *cntrs)
-{
-	int ret;
-
-	if (!(dd->ipath_flags & IPATH_INITTED)) {
-		/* no hardware, freeze, etc. */
-		ipath_dbg("unit %u not usable\n", dd->ipath_unit);
-		ret = -EINVAL;
-		goto bail;
-	}
-	cntrs->symbol_error_counter =
-		ipath_snap_cntr(dd, dd->ipath_cregs->cr_ibsymbolerrcnt);
-	cntrs->link_error_recovery_counter =
-		ipath_snap_cntr(dd, dd->ipath_cregs->cr_iblinkerrrecovcnt);
-	/*
-	 * The link downed counter counts when the other side downs the
-	 * connection.  We add in the number of times we downed the link
-	 * due to local link integrity errors to compensate.
-	 */
-	cntrs->link_downed_counter =
-		ipath_snap_cntr(dd, dd->ipath_cregs->cr_iblinkdowncnt);
-	cntrs->port_rcv_errors =
-		ipath_snap_cntr(dd, dd->ipath_cregs->cr_rxdroppktcnt) +
-		ipath_snap_cntr(dd, dd->ipath_cregs->cr_rcvovflcnt) +
-		ipath_snap_cntr(dd, dd->ipath_cregs->cr_portovflcnt) +
-		ipath_snap_cntr(dd, dd->ipath_cregs->cr_err_rlencnt) +
-		ipath_snap_cntr(dd, dd->ipath_cregs->cr_invalidrlencnt) +
-		ipath_snap_cntr(dd, dd->ipath_cregs->cr_erricrccnt) +
-		ipath_snap_cntr(dd, dd->ipath_cregs->cr_errvcrccnt) +
-		ipath_snap_cntr(dd, dd->ipath_cregs->cr_errlpcrccnt) +
-		ipath_snap_cntr(dd, dd->ipath_cregs->cr_badformatcnt);
-	cntrs->port_rcv_remphys_errors =
-		ipath_snap_cntr(dd, dd->ipath_cregs->cr_rcvebpcnt);
-	cntrs->port_xmit_discards =
-		ipath_snap_cntr(dd, dd->ipath_cregs->cr_unsupvlcnt);
-	cntrs->port_xmit_data =
-		ipath_snap_cntr(dd, dd->ipath_cregs->cr_wordsendcnt);
-	cntrs->port_rcv_data =
-		ipath_snap_cntr(dd, dd->ipath_cregs->cr_wordrcvcnt);
-	cntrs->port_xmit_packets =
-		ipath_snap_cntr(dd, dd->ipath_cregs->cr_pktsendcnt);
-	cntrs->port_rcv_packets =
-		ipath_snap_cntr(dd, dd->ipath_cregs->cr_pktrcvcnt);
-	cntrs->local_link_integrity_errors = dd->ipath_lli_errors;
-	cntrs->excessive_buffer_overrun_errors = 0; /* XXX */
-
-	ret = 0;
-
-bail:
-	return ret;
-}
-
-int ipath_layer_want_buffer(struct ipath_devdata *dd)
-{
-	set_bit(IPATH_S_PIOINTBUFAVAIL, &dd->ipath_sendctrl);
-	ipath_write_kreg(dd, dd->ipath_kregs->kr_sendctrl,
-			 dd->ipath_sendctrl);
-
-	return 0;
-}
 
 int ipath_layer_send_hdr(struct ipath_devdata *dd, struct ether_header *hdr)
 {
@@ -985,361 +367,3 @@ int ipath_layer_set_piointbufavail_int(s
 }
 
 EXPORT_SYMBOL_GPL(ipath_layer_set_piointbufavail_int);
-
-int ipath_layer_enable_timer(struct ipath_devdata *dd)
-{
-	/*
-	 * HT-400 has a design flaw where the chip and kernel idea
-	 * of the tail register don't always agree, and therefore we won't
-	 * get an interrupt on the next packet received.
-	 * If the board supports per packet receive interrupts, use it.
-	 * Otherwise, the timer function periodically checks for packets
-	 * to cover this case.
-	 * Either way, the timer is needed for verbs layer related
-	 * processing.
-	 */
-	if (dd->ipath_flags & IPATH_GPIO_INTR) {
-		ipath_write_kreg(dd, dd->ipath_kregs->kr_debugportselect,
-				 0x2074076542310ULL);
-		/* Enable GPIO bit 2 interrupt */
-		ipath_write_kreg(dd, dd->ipath_kregs->kr_gpio_mask,
-				 (u64) (1 << 2));
-	}
-
-	init_timer(&dd->verbs_timer);
-	dd->verbs_timer.function = __ipath_verbs_timer;
-	dd->verbs_timer.data = (unsigned long)dd;
-	dd->verbs_timer.expires = jiffies + 1;
-	add_timer(&dd->verbs_timer);
-
-	return 0;
-}
-
-int ipath_layer_disable_timer(struct ipath_devdata *dd)
-{
-	/* Disable GPIO bit 2 interrupt */
-	if (dd->ipath_flags & IPATH_GPIO_INTR)
-		ipath_write_kreg(dd, dd->ipath_kregs->kr_gpio_mask, 0);
-
-	del_timer_sync(&dd->verbs_timer);
-
-	return 0;
-}
-
-/**
- * ipath_layer_set_verbs_flags - set the verbs layer flags
- * @dd: the infinipath device
- * @flags: the flags to set
- */
-int ipath_layer_set_verbs_flags(struct ipath_devdata *dd, unsigned flags)
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
- * ipath_layer_get_npkeys - return the size of the PKEY table for port 0
- * @dd: the infinipath device
- */
-unsigned ipath_layer_get_npkeys(struct ipath_devdata *dd)
-{
-	return ARRAY_SIZE(dd->ipath_pd[0]->port_pkeys);
-}
-
-/**
- * ipath_layer_get_pkey - return the indexed PKEY from the port 0 PKEY table
- * @dd: the infinipath device
- * @index: the PKEY index
- */
-unsigned ipath_layer_get_pkey(struct ipath_devdata *dd, unsigned index)
-{
-	unsigned ret;
-
-	if (index >= ARRAY_SIZE(dd->ipath_pd[0]->port_pkeys))
-		ret = 0;
-	else
-		ret = dd->ipath_pd[0]->port_pkeys[index];
-
-	return ret;
-}
-
-/**
- * ipath_layer_get_pkeys - return the PKEY table for port 0
- * @dd: the infinipath device
- * @pkeys: the pkey table is placed here
- */
-int ipath_layer_get_pkeys(struct ipath_devdata *dd, u16 * pkeys)
-{
-	struct ipath_portdata *pd = dd->ipath_pd[0];
-
-	memcpy(pkeys, pd->port_pkeys, sizeof(pd->port_pkeys));
-
-	return 0;
-}
-
-/**
- * rm_pkey - decrecment the reference count for the given PKEY
- * @dd: the infinipath device
- * @key: the PKEY index
- *
- * Return true if this was the last reference and the hardware table entry
- * needs to be changed.
- */
-static int rm_pkey(struct ipath_devdata *dd, u16 key)
-{
-	int i;
-	int ret;
-
-	for (i = 0; i < ARRAY_SIZE(dd->ipath_pkeys); i++) {
-		if (dd->ipath_pkeys[i] != key)
-			continue;
-		if (atomic_dec_and_test(&dd->ipath_pkeyrefs[i])) {
-			dd->ipath_pkeys[i] = 0;
-			ret = 1;
-			goto bail;
-		}
-		break;
-	}
-
-	ret = 0;
-
-bail:
-	return ret;
-}
-
-/**
- * add_pkey - add the given PKEY to the hardware table
- * @dd: the infinipath device
- * @key: the PKEY
- *
- * Return an error code if unable to add the entry, zero if no change,
- * or 1 if the hardware PKEY register needs to be updated.
- */
-static int add_pkey(struct ipath_devdata *dd, u16 key)
-{
-	int i;
-	u16 lkey = key & 0x7FFF;
-	int any = 0;
-	int ret;
-
-	if (lkey == 0x7FFF) {
-		ret = 0;
-		goto bail;
-	}
-
-	/* Look for an empty slot or a matching PKEY. */
-	for (i = 0; i < ARRAY_SIZE(dd->ipath_pkeys); i++) {
-		if (!dd->ipath_pkeys[i]) {
-			any++;
-			continue;
-		}
-		/* If it matches exactly, try to increment the ref count */
-		if (dd->ipath_pkeys[i] == key) {
-			if (atomic_inc_return(&dd->ipath_pkeyrefs[i]) > 1) {
-				ret = 0;
-				goto bail;
-			}
-			/* Lost the race. Look for an empty slot below. */
-			atomic_dec(&dd->ipath_pkeyrefs[i]);
-			any++;
-		}
-		/*
-		 * It makes no sense to have both the limited and unlimited
-		 * PKEY set at the same time since the unlimited one will
-		 * disable the limited one.
-		 */
-		if ((dd->ipath_pkeys[i] & 0x7FFF) == lkey) {
-			ret = -EEXIST;
-			goto bail;
-		}
-	}
-	if (!any) {
-		ret = -EBUSY;
-		goto bail;
-	}
-	for (i = 0; i < ARRAY_SIZE(dd->ipath_pkeys); i++) {
-		if (!dd->ipath_pkeys[i] &&
-		    atomic_inc_return(&dd->ipath_pkeyrefs[i]) == 1) {
-			/* for ipathstats, etc. */
-			ipath_stats.sps_pkeys[i] = lkey;
-			dd->ipath_pkeys[i] = key;
-			ret = 1;
-			goto bail;
-		}
-	}
-	ret = -EBUSY;
-
-bail:
-	return ret;
-}
-
-/**
- * ipath_layer_set_pkeys - set the PKEY table for port 0
- * @dd: the infinipath device
- * @pkeys: the PKEY table
- */
-int ipath_layer_set_pkeys(struct ipath_devdata *dd, u16 * pkeys)
-{
-	struct ipath_portdata *pd;
-	int i;
-	int changed = 0;
-
-	pd = dd->ipath_pd[0];
-
-	for (i = 0; i < ARRAY_SIZE(pd->port_pkeys); i++) {
-		u16 key = pkeys[i];
-		u16 okey = pd->port_pkeys[i];
-
-		if (key == okey)
-			continue;
-		/*
-		 * The value of this PKEY table entry is changing.
-		 * Remove the old entry in the hardware's array of PKEYs.
-		 */
-		if (okey & 0x7FFF)
-			changed |= rm_pkey(dd, okey);
-		if (key & 0x7FFF) {
-			int ret = add_pkey(dd, key);
-
-			if (ret < 0)
-				key = 0;
-			else
-				changed |= ret;
-		}
-		pd->port_pkeys[i] = key;
-	}
-	if (changed) {
-		u64 pkey;
-
-		pkey = (u64) dd->ipath_pkeys[0] |
-			((u64) dd->ipath_pkeys[1] << 16) |
-			((u64) dd->ipath_pkeys[2] << 32) |
-			((u64) dd->ipath_pkeys[3] << 48);
-		ipath_cdbg(VERBOSE, "p0 new pkey reg %llx\n",
-			   (unsigned long long) pkey);
-		ipath_write_kreg(dd, dd->ipath_kregs->kr_partitionkey,
-				 pkey);
-	}
-	return 0;
-}
-
-/**
- * ipath_layer_get_linkdowndefaultstate - get the default linkdown state
- * @dd: the infinipath device
- *
- * Returns zero if the default is POLL, 1 if the default is SLEEP.
- */
-int ipath_layer_get_linkdowndefaultstate(struct ipath_devdata *dd)
-{
-	return !!(dd->ipath_ibcctrl & INFINIPATH_IBCC_LINKDOWNDEFAULTSTATE);
-}
-
-/**
- * ipath_layer_set_linkdowndefaultstate - set the default linkdown state
- * @dd: the infinipath device
- * @sleep: the new state
- *
- * Note that this will only take effect when the link state changes.
- */
-int ipath_layer_set_linkdowndefaultstate(struct ipath_devdata *dd,
-					 int sleep)
-{
-	if (sleep)
-		dd->ipath_ibcctrl |= INFINIPATH_IBCC_LINKDOWNDEFAULTSTATE;
-	else
-		dd->ipath_ibcctrl &= ~INFINIPATH_IBCC_LINKDOWNDEFAULTSTATE;
-	ipath_write_kreg(dd, dd->ipath_kregs->kr_ibcctrl,
-			 dd->ipath_ibcctrl);
-	return 0;
-}
-
-int ipath_layer_get_phyerrthreshold(struct ipath_devdata *dd)
-{
-	return (dd->ipath_ibcctrl >>
-		INFINIPATH_IBCC_PHYERRTHRESHOLD_SHIFT) &
-		INFINIPATH_IBCC_PHYERRTHRESHOLD_MASK;
-}
-
-/**
- * ipath_layer_set_phyerrthreshold - set the physical error threshold
- * @dd: the infinipath device
- * @n: the new threshold
- *
- * Note that this will only take effect when the link state changes.
- */
-int ipath_layer_set_phyerrthreshold(struct ipath_devdata *dd, unsigned n)
-{
-	unsigned v;
-
-	v = (dd->ipath_ibcctrl >> INFINIPATH_IBCC_PHYERRTHRESHOLD_SHIFT) &
-		INFINIPATH_IBCC_PHYERRTHRESHOLD_MASK;
-	if (v != n) {
-		dd->ipath_ibcctrl &=
-			~(INFINIPATH_IBCC_PHYERRTHRESHOLD_MASK <<
-			  INFINIPATH_IBCC_PHYERRTHRESHOLD_SHIFT);
-		dd->ipath_ibcctrl |=
-			(u64) n << INFINIPATH_IBCC_PHYERRTHRESHOLD_SHIFT;
-		ipath_write_kreg(dd, dd->ipath_kregs->kr_ibcctrl,
-				 dd->ipath_ibcctrl);
-	}
-	return 0;
-}
-
-int ipath_layer_get_overrunthreshold(struct ipath_devdata *dd)
-{
-	return (dd->ipath_ibcctrl >>
-		INFINIPATH_IBCC_OVERRUNTHRESHOLD_SHIFT) &
-		INFINIPATH_IBCC_OVERRUNTHRESHOLD_MASK;
-}
-
-/**
- * ipath_layer_set_overrunthreshold - set the overrun threshold
- * @dd: the infinipath device
- * @n: the new threshold
- *
- * Note that this will only take effect when the link state changes.
- */
-int ipath_layer_set_overrunthreshold(struct ipath_devdata *dd, unsigned n)
-{
-	unsigned v;
-
-	v = (dd->ipath_ibcctrl >> INFINIPATH_IBCC_OVERRUNTHRESHOLD_SHIFT) &
-		INFINIPATH_IBCC_OVERRUNTHRESHOLD_MASK;
-	if (v != n) {
-		dd->ipath_ibcctrl &=
-			~(INFINIPATH_IBCC_OVERRUNTHRESHOLD_MASK <<
-			  INFINIPATH_IBCC_OVERRUNTHRESHOLD_SHIFT);
-		dd->ipath_ibcctrl |=
-			(u64) n << INFINIPATH_IBCC_OVERRUNTHRESHOLD_SHIFT;
-		ipath_write_kreg(dd, dd->ipath_kregs->kr_ibcctrl,
-				 dd->ipath_ibcctrl);
-	}
-	return 0;
-}
-
-int ipath_layer_get_boardname(struct ipath_devdata *dd, char *name,
-			      size_t namelen)
-{
-	return dd->ipath_f_get_boardname(dd, name, namelen);
-}
-
-u32 ipath_layer_get_rcvhdrentsize(struct ipath_devdata *dd)
-{
-	return dd->ipath_rcvhdrentsize;
-}
diff --git a/drivers/infiniband/hw/ipath/ipath_layer.h b/drivers/infiniband/hw/ipath/ipath_layer.h
--- a/drivers/infiniband/hw/ipath/ipath_layer.h	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_layer.h	Fri Aug 25 11:19:45 2006 -0700
@@ -40,72 +40,8 @@
  */
 
 struct sk_buff;
-struct ipath_sge_state;
 struct ipath_devdata;
 struct ether_header;
-
-struct ipath_layer_counters {
-	u64 symbol_error_counter;
-	u64 link_error_recovery_counter;
-	u64 link_downed_counter;
-	u64 port_rcv_errors;
-	u64 port_rcv_remphys_errors;
-	u64 port_xmit_discards;
-	u64 port_xmit_data;
-	u64 port_rcv_data;
-	u64 port_xmit_packets;
-	u64 port_rcv_packets;
-	u32 local_link_integrity_errors;
-	u32 excessive_buffer_overrun_errors;
-};
-
-/*
- * A segment is a linear region of low physical memory.
- * XXX Maybe we should use phys addr here and kmap()/kunmap().
- * Used by the verbs layer.
- */
-struct ipath_seg {
-	void *vaddr;
-	size_t length;
-};
-
-/* The number of ipath_segs that fit in a page. */
-#define IPATH_SEGSZ     (PAGE_SIZE / sizeof (struct ipath_seg))
-
-struct ipath_segarray {
-	struct ipath_seg segs[IPATH_SEGSZ];
-};
-
-struct ipath_mregion {
-	u64 user_base;		/* User's address for this region */
-	u64 iova;		/* IB start address of this region */
-	size_t length;
-	u32 lkey;
-	u32 offset;		/* offset (bytes) to start of region */
-	int access_flags;
-	u32 max_segs;		/* number of ipath_segs in all the arrays */
-	u32 mapsz;		/* size of the map array */
-	struct ipath_segarray *map[0];	/* the segments */
-};
-
-/*
- * These keep track of the copy progress within a memory region.
- * Used by the verbs layer.
- */
-struct ipath_sge {
-	struct ipath_mregion *mr;
-	void *vaddr;		/* current pointer into the segment */
-	u32 sge_length;		/* length of the SGE */
-	u32 length;		/* remaining length of the segment */
-	u16 m;			/* current index: mr->map[m] */
-	u16 n;			/* current index: mr->map[m]->segs[n] */
-};
-
-struct ipath_sge_state {
-	struct ipath_sge *sg_list;	/* next SGE to be used if any */
-	struct ipath_sge sge;	/* progress state for the current SGE */
-	u8 num_sge;
-};
 
 int ipath_layer_register(void *(*l_add)(int, struct ipath_devdata *),
 			 void (*l_remove)(void *),
@@ -119,49 +55,9 @@ u16 ipath_layer_get_lid(struct ipath_dev
 u16 ipath_layer_get_lid(struct ipath_devdata *dd);
 int ipath_layer_get_mac(struct ipath_devdata *dd, u8 *);
 u16 ipath_layer_get_bcast(struct ipath_devdata *dd);
-u32 ipath_layer_get_cr_errpkey(struct ipath_devdata *dd);
-int ipath_layer_set_linkstate(struct ipath_devdata *dd, u8 state);
-int ipath_layer_set_mtu(struct ipath_devdata *, u16);
-int ipath_set_lid(struct ipath_devdata *, u32, u8);
 int ipath_layer_send_hdr(struct ipath_devdata *dd,
 			 struct ether_header *hdr);
-int ipath_verbs_send(struct ipath_devdata *dd, u32 hdrwords,
-		     u32 * hdr, u32 len, struct ipath_sge_state *ss);
 int ipath_layer_set_piointbufavail_int(struct ipath_devdata *dd);
-int ipath_layer_get_boardname(struct ipath_devdata *dd, char *name,
-			      size_t namelen);
-int ipath_layer_snapshot_counters(struct ipath_devdata *dd, u64 *swords,
-				  u64 *rwords, u64 *spkts, u64 *rpkts,
-				  u64 *xmit_wait);
-int ipath_layer_get_counters(struct ipath_devdata *dd,
-			     struct ipath_layer_counters *cntrs);
-int ipath_layer_want_buffer(struct ipath_devdata *dd);
-int ipath_layer_set_guid(struct ipath_devdata *, __be64 guid);
-__be64 ipath_layer_get_guid(struct ipath_devdata *);
-u32 ipath_layer_get_majrev(struct ipath_devdata *);
-u32 ipath_layer_get_minrev(struct ipath_devdata *);
-u32 ipath_layer_get_pcirev(struct ipath_devdata *);
-u32 ipath_layer_get_flags(struct ipath_devdata *dd);
-struct device *ipath_layer_get_device(struct ipath_devdata *dd);
-u16 ipath_layer_get_deviceid(struct ipath_devdata *dd);
-u32 ipath_layer_get_vendorid(struct ipath_devdata *);
-u64 ipath_layer_get_lastibcstat(struct ipath_devdata *dd);
-u32 ipath_layer_get_ibmtu(struct ipath_devdata *dd);
-int ipath_layer_enable_timer(struct ipath_devdata *dd);
-int ipath_layer_disable_timer(struct ipath_devdata *dd);
-int ipath_layer_set_verbs_flags(struct ipath_devdata *dd, unsigned flags);
-unsigned ipath_layer_get_npkeys(struct ipath_devdata *dd);
-unsigned ipath_layer_get_pkey(struct ipath_devdata *dd, unsigned index);
-int ipath_layer_get_pkeys(struct ipath_devdata *dd, u16 *pkeys);
-int ipath_layer_set_pkeys(struct ipath_devdata *dd, u16 *pkeys);
-int ipath_layer_get_linkdowndefaultstate(struct ipath_devdata *dd);
-int ipath_layer_set_linkdowndefaultstate(struct ipath_devdata *dd,
-					 int sleep);
-int ipath_layer_get_phyerrthreshold(struct ipath_devdata *dd);
-int ipath_layer_set_phyerrthreshold(struct ipath_devdata *dd, unsigned n);
-int ipath_layer_get_overrunthreshold(struct ipath_devdata *dd);
-int ipath_layer_set_overrunthreshold(struct ipath_devdata *dd, unsigned n);
-u32 ipath_layer_get_rcvhdrentsize(struct ipath_devdata *dd);
 
 /* ipath_ether interrupt values */
 #define IPATH_LAYER_INT_IF_UP 0x2
diff --git a/drivers/infiniband/hw/ipath/ipath_mad.c b/drivers/infiniband/hw/ipath/ipath_mad.c
--- a/drivers/infiniband/hw/ipath/ipath_mad.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_mad.c	Fri Aug 25 11:19:45 2006 -0700
@@ -101,15 +101,15 @@ static int recv_subn_get_nodeinfo(struct
 	nip->num_ports = ibdev->phys_port_cnt;
 	/* This is already in network order */
 	nip->sys_guid = to_idev(ibdev)->sys_image_guid;
-	nip->node_guid = ipath_layer_get_guid(dd);
+	nip->node_guid = dd->ipath_guid;
 	nip->port_guid = nip->sys_guid;
-	nip->partition_cap = cpu_to_be16(ipath_layer_get_npkeys(dd));
-	nip->device_id = cpu_to_be16(ipath_layer_get_deviceid(dd));
-	majrev = ipath_layer_get_majrev(dd);
-	minrev = ipath_layer_get_minrev(dd);
+	nip->partition_cap = cpu_to_be16(ipath_get_npkeys(dd));
+	nip->device_id = cpu_to_be16(dd->ipath_deviceid);
+	majrev = dd->ipath_majrev;
+	minrev = dd->ipath_minrev;
 	nip->revision = cpu_to_be32((majrev << 16) | minrev);
 	nip->local_port_num = port;
-	vendor = ipath_layer_get_vendorid(dd);
+	vendor = dd->ipath_vendorid;
 	nip->vendor_id[0] = 0;
 	nip->vendor_id[1] = vendor >> 8;
 	nip->vendor_id[2] = vendor;
@@ -133,11 +133,87 @@ static int recv_subn_get_guidinfo(struct
 	 */
 	if (startgx == 0)
 		/* The first is a copy of the read-only HW GUID. */
-		*p = ipath_layer_get_guid(to_idev(ibdev)->dd);
+		*p = to_idev(ibdev)->dd->ipath_guid;
 	else
 		smp->status |= IB_SMP_INVALID_FIELD;
 
 	return reply(smp);
+}
+
+
+static int get_overrunthreshold(struct ipath_devdata *dd)
+{
+	return (dd->ipath_ibcctrl >>
+		INFINIPATH_IBCC_OVERRUNTHRESHOLD_SHIFT) &
+		INFINIPATH_IBCC_OVERRUNTHRESHOLD_MASK;
+}
+
+/**
+ * set_overrunthreshold - set the overrun threshold
+ * @dd: the infinipath device
+ * @n: the new threshold
+ *
+ * Note that this will only take effect when the link state changes.
+ */
+static int set_overrunthreshold(struct ipath_devdata *dd, unsigned n)
+{
+	unsigned v;
+
+	v = (dd->ipath_ibcctrl >> INFINIPATH_IBCC_OVERRUNTHRESHOLD_SHIFT) &
+		INFINIPATH_IBCC_OVERRUNTHRESHOLD_MASK;
+	if (v != n) {
+		dd->ipath_ibcctrl &=
+			~(INFINIPATH_IBCC_OVERRUNTHRESHOLD_MASK <<
+			  INFINIPATH_IBCC_OVERRUNTHRESHOLD_SHIFT);
+		dd->ipath_ibcctrl |=
+			(u64) n << INFINIPATH_IBCC_OVERRUNTHRESHOLD_SHIFT;
+		ipath_write_kreg(dd, dd->ipath_kregs->kr_ibcctrl,
+				 dd->ipath_ibcctrl);
+	}
+	return 0;
+}
+
+static int get_phyerrthreshold(struct ipath_devdata *dd)
+{
+	return (dd->ipath_ibcctrl >>
+		INFINIPATH_IBCC_PHYERRTHRESHOLD_SHIFT) &
+		INFINIPATH_IBCC_PHYERRTHRESHOLD_MASK;
+}
+
+/**
+ * set_phyerrthreshold - set the physical error threshold
+ * @dd: the infinipath device
+ * @n: the new threshold
+ *
+ * Note that this will only take effect when the link state changes.
+ */
+static int set_phyerrthreshold(struct ipath_devdata *dd, unsigned n)
+{
+	unsigned v;
+
+	v = (dd->ipath_ibcctrl >> INFINIPATH_IBCC_PHYERRTHRESHOLD_SHIFT) &
+		INFINIPATH_IBCC_PHYERRTHRESHOLD_MASK;
+	if (v != n) {
+		dd->ipath_ibcctrl &=
+			~(INFINIPATH_IBCC_PHYERRTHRESHOLD_MASK <<
+			  INFINIPATH_IBCC_PHYERRTHRESHOLD_SHIFT);
+		dd->ipath_ibcctrl |=
+			(u64) n << INFINIPATH_IBCC_PHYERRTHRESHOLD_SHIFT;
+		ipath_write_kreg(dd, dd->ipath_kregs->kr_ibcctrl,
+				 dd->ipath_ibcctrl);
+	}
+	return 0;
+}
+
+/**
+ * get_linkdowndefaultstate - get the default linkdown state
+ * @dd: the infinipath device
+ *
+ * Returns zero if the default is POLL, 1 if the default is SLEEP.
+ */
+static int get_linkdowndefaultstate(struct ipath_devdata *dd)
+{
+	return !!(dd->ipath_ibcctrl & INFINIPATH_IBCC_LINKDOWNDEFAULTSTATE);
 }
 
 static int recv_subn_get_portinfo(struct ib_smp *smp,
@@ -166,7 +242,7 @@ static int recv_subn_get_portinfo(struct
 	    (dev->mkeyprot_resv_lmc >> 6) == 0)
 		pip->mkey = dev->mkey;
 	pip->gid_prefix = dev->gid_prefix;
-	lid = ipath_layer_get_lid(dev->dd);
+	lid = dev->dd->ipath_lid;
 	pip->lid = lid ? cpu_to_be16(lid) : IB_LID_PERMISSIVE;
 	pip->sm_lid = cpu_to_be16(dev->sm_lid);
 	pip->cap_mask = cpu_to_be32(dev->port_cap_flags);
@@ -177,14 +253,14 @@ static int recv_subn_get_portinfo(struct
 	pip->link_width_supported = 3;	/* 1x or 4x */
 	pip->link_width_active = 2;	/* 4x */
 	pip->linkspeed_portstate = 0x10;	/* 2.5Gbps */
-	ibcstat = ipath_layer_get_lastibcstat(dev->dd);
+	ibcstat = dev->dd->ipath_lastibcstat;
 	pip->linkspeed_portstate |= ((ibcstat >> 4) & 0x3) + 1;
 	pip->portphysstate_linkdown =
 		(ipath_cvt_physportstate[ibcstat & 0xf] << 4) |
-		(ipath_layer_get_linkdowndefaultstate(dev->dd) ? 1 : 2);
+		(get_linkdowndefaultstate(dev->dd) ? 1 : 2);
 	pip->mkeyprot_resv_lmc = dev->mkeyprot_resv_lmc;
 	pip->linkspeedactive_enabled = 0x11;	/* 2.5Gbps, 2.5Gbps */
-	switch (ipath_layer_get_ibmtu(dev->dd)) {
+	switch (dev->dd->ipath_ibmtu) {
 	case 4096:
 		mtu = IB_MTU_4096;
 		break;
@@ -217,7 +293,7 @@ static int recv_subn_get_portinfo(struct
 	pip->mkey_violations = cpu_to_be16(dev->mkey_violations);
 	/* P_KeyViolations are counted by hardware. */
 	pip->pkey_violations =
-		cpu_to_be16((ipath_layer_get_cr_errpkey(dev->dd) -
+		cpu_to_be16((ipath_get_cr_errpkey(dev->dd) -
 			     dev->z_pkey_violations) & 0xFFFF);
 	pip->qkey_violations = cpu_to_be16(dev->qkey_violations);
 	/* Only the hardware GUID is supported for now */
@@ -226,8 +302,8 @@ static int recv_subn_get_portinfo(struct
 	/* 32.768 usec. response time (guessing) */
 	pip->resv_resptimevalue = 3;
 	pip->localphyerrors_overrunerrors =
-		(ipath_layer_get_phyerrthreshold(dev->dd) << 4) |
-		ipath_layer_get_overrunthreshold(dev->dd);
+		(get_phyerrthreshold(dev->dd) << 4) |
+		get_overrunthreshold(dev->dd);
 	/* pip->max_credit_hint; */
 	/* pip->link_roundtrip_latency[3]; */
 
@@ -235,6 +311,20 @@ static int recv_subn_get_portinfo(struct
 
 bail:
 	return ret;
+}
+
+/**
+ * get_pkeys - return the PKEY table for port 0
+ * @dd: the infinipath device
+ * @pkeys: the pkey table is placed here
+ */
+static int get_pkeys(struct ipath_devdata *dd, u16 * pkeys)
+{
+	struct ipath_portdata *pd = dd->ipath_pd[0];
+
+	memcpy(pkeys, pd->port_pkeys, sizeof(pd->port_pkeys));
+
+	return 0;
 }
 
 static int recv_subn_get_pkeytable(struct ib_smp *smp,
@@ -249,9 +339,9 @@ static int recv_subn_get_pkeytable(struc
 	memset(smp->data, 0, sizeof(smp->data));
 	if (startpx == 0) {
 		struct ipath_ibdev *dev = to_idev(ibdev);
-		unsigned i, n = ipath_layer_get_npkeys(dev->dd);
-
-		ipath_layer_get_pkeys(dev->dd, p);
+		unsigned i, n = ipath_get_npkeys(dev->dd);
+
+		get_pkeys(dev->dd, p);
 
 		for (i = 0; i < n; i++)
 			q[i] = cpu_to_be16(p[i]);
@@ -266,6 +356,24 @@ static int recv_subn_set_guidinfo(struct
 {
 	/* The only GUID we support is the first read-only entry. */
 	return recv_subn_get_guidinfo(smp, ibdev);
+}
+
+/**
+ * set_linkdowndefaultstate - set the default linkdown state
+ * @dd: the infinipath device
+ * @sleep: the new state
+ *
+ * Note that this will only take effect when the link state changes.
+ */
+static int set_linkdowndefaultstate(struct ipath_devdata *dd, int sleep)
+{
+	if (sleep)
+		dd->ipath_ibcctrl |= INFINIPATH_IBCC_LINKDOWNDEFAULTSTATE;
+	else
+		dd->ipath_ibcctrl &= ~INFINIPATH_IBCC_LINKDOWNDEFAULTSTATE;
+	ipath_write_kreg(dd, dd->ipath_kregs->kr_ibcctrl,
+			 dd->ipath_ibcctrl);
+	return 0;
 }
 
 /**
@@ -290,7 +398,7 @@ static int recv_subn_set_portinfo(struct
 	u8 state;
 	u16 lstate;
 	u32 mtu;
-	int ret;
+	int ret, ore;
 
 	if (be32_to_cpu(smp->attr_mod) > ibdev->phys_port_cnt)
 		goto err;
@@ -304,7 +412,7 @@ static int recv_subn_set_portinfo(struct
 	dev->mkey_lease_period = be16_to_cpu(pip->mkey_lease_period);
 
 	lid = be16_to_cpu(pip->lid);
-	if (lid != ipath_layer_get_lid(dev->dd)) {
+	if (lid != dev->dd->ipath_lid) {
 		/* Must be a valid unicast LID address. */
 		if (lid == 0 || lid >= IPATH_MULTICAST_LID_BASE)
 			goto err;
@@ -342,11 +450,11 @@ static int recv_subn_set_portinfo(struct
 	case 0: /* NOP */
 		break;
 	case 1: /* SLEEP */
-		if (ipath_layer_set_linkdowndefaultstate(dev->dd, 1))
+		if (set_linkdowndefaultstate(dev->dd, 1))
 			goto err;
 		break;
 	case 2: /* POLL */
-		if (ipath_layer_set_linkdowndefaultstate(dev->dd, 0))
+		if (set_linkdowndefaultstate(dev->dd, 0))
 			goto err;
 		break;
 	default:
@@ -376,7 +484,7 @@ static int recv_subn_set_portinfo(struct
 		/* XXX We have already partially updated our state! */
 		goto err;
 	}
-	ipath_layer_set_mtu(dev->dd, mtu);
+	ipath_set_mtu(dev->dd, mtu);
 
 	dev->sm_sl = pip->neighbormtu_mastersmsl & 0xF;
 
@@ -392,20 +500,16 @@ static int recv_subn_set_portinfo(struct
 	 * later.
 	 */
 	if (pip->pkey_violations == 0)
-		dev->z_pkey_violations =
-			ipath_layer_get_cr_errpkey(dev->dd);
+		dev->z_pkey_violations = ipath_get_cr_errpkey(dev->dd);
 
 	if (pip->qkey_violations == 0)
 		dev->qkey_violations = 0;
 
-	if (ipath_layer_set_phyerrthreshold(
-		    dev->dd,
-		    (pip->localphyerrors_overrunerrors >> 4) & 0xF))
+	ore = pip->localphyerrors_overrunerrors;
+	if (set_phyerrthreshold(dev->dd, (ore >> 4) & 0xF))
 		goto err;
 
-	if (ipath_layer_set_overrunthreshold(
-		    dev->dd,
-		    (pip->localphyerrors_overrunerrors & 0xF)))
+	if (set_overrunthreshold(dev->dd, (ore & 0xF)))
 		goto err;
 
 	dev->subnet_timeout = pip->clientrereg_resv_subnetto & 0x1F;
@@ -423,7 +527,7 @@ static int recv_subn_set_portinfo(struct
 	 * is down or is being set to down.
 	 */
 	state = pip->linkspeed_portstate & 0xF;
-	flags = ipath_layer_get_flags(dev->dd);
+	flags = dev->dd->ipath_flags;
 	lstate = (pip->portphysstate_linkdown >> 4) & 0xF;
 	if (lstate && !(state == IB_PORT_DOWN || state == IB_PORT_NOP))
 		goto err;
@@ -439,7 +543,7 @@ static int recv_subn_set_portinfo(struct
 		/* FALLTHROUGH */
 	case IB_PORT_DOWN:
 		if (lstate == 0)
-			if (ipath_layer_get_linkdowndefaultstate(dev->dd))
+			if (get_linkdowndefaultstate(dev->dd))
 				lstate = IPATH_IB_LINKDOWN_SLEEP;
 			else
 				lstate = IPATH_IB_LINKDOWN;
@@ -451,7 +555,7 @@ static int recv_subn_set_portinfo(struct
 			lstate = IPATH_IB_LINKDOWN_DISABLE;
 		else
 			goto err;
-		ipath_layer_set_linkstate(dev->dd, lstate);
+		ipath_set_linkstate(dev->dd, lstate);
 		if (flags & IPATH_LINKACTIVE) {
 			event.event = IB_EVENT_PORT_ERR;
 			ib_dispatch_event(&event);
@@ -460,7 +564,7 @@ static int recv_subn_set_portinfo(struct
 	case IB_PORT_ARMED:
 		if (!(flags & (IPATH_LINKINIT | IPATH_LINKACTIVE)))
 			break;
-		ipath_layer_set_linkstate(dev->dd, IPATH_IB_LINKARM);
+		ipath_set_linkstate(dev->dd, IPATH_IB_LINKARM);
 		if (flags & IPATH_LINKACTIVE) {
 			event.event = IB_EVENT_PORT_ERR;
 			ib_dispatch_event(&event);
@@ -469,7 +573,7 @@ static int recv_subn_set_portinfo(struct
 	case IB_PORT_ACTIVE:
 		if (!(flags & IPATH_LINKARMED))
 			break;
-		ipath_layer_set_linkstate(dev->dd, IPATH_IB_LINKACTIVE);
+		ipath_set_linkstate(dev->dd, IPATH_IB_LINKACTIVE);
 		event.event = IB_EVENT_PORT_ACTIVE;
 		ib_dispatch_event(&event);
 		break;
@@ -491,6 +595,152 @@ err:
 
 done:
 	return ret;
+}
+
+/**
+ * rm_pkey - decrecment the reference count for the given PKEY
+ * @dd: the infinipath device
+ * @key: the PKEY index
+ *
+ * Return true if this was the last reference and the hardware table entry
+ * needs to be changed.
+ */
+static int rm_pkey(struct ipath_devdata *dd, u16 key)
+{
+	int i;
+	int ret;
+
+	for (i = 0; i < ARRAY_SIZE(dd->ipath_pkeys); i++) {
+		if (dd->ipath_pkeys[i] != key)
+			continue;
+		if (atomic_dec_and_test(&dd->ipath_pkeyrefs[i])) {
+			dd->ipath_pkeys[i] = 0;
+			ret = 1;
+			goto bail;
+		}
+		break;
+	}
+
+	ret = 0;
+
+bail:
+	return ret;
+}
+
+/**
+ * add_pkey - add the given PKEY to the hardware table
+ * @dd: the infinipath device
+ * @key: the PKEY
+ *
+ * Return an error code if unable to add the entry, zero if no change,
+ * or 1 if the hardware PKEY register needs to be updated.
+ */
+static int add_pkey(struct ipath_devdata *dd, u16 key)
+{
+	int i;
+	u16 lkey = key & 0x7FFF;
+	int any = 0;
+	int ret;
+
+	if (lkey == 0x7FFF) {
+		ret = 0;
+		goto bail;
+	}
+
+	/* Look for an empty slot or a matching PKEY. */
+	for (i = 0; i < ARRAY_SIZE(dd->ipath_pkeys); i++) {
+		if (!dd->ipath_pkeys[i]) {
+			any++;
+			continue;
+		}
+		/* If it matches exactly, try to increment the ref count */
+		if (dd->ipath_pkeys[i] == key) {
+			if (atomic_inc_return(&dd->ipath_pkeyrefs[i]) > 1) {
+				ret = 0;
+				goto bail;
+			}
+			/* Lost the race. Look for an empty slot below. */
+			atomic_dec(&dd->ipath_pkeyrefs[i]);
+			any++;
+		}
+		/*
+		 * It makes no sense to have both the limited and unlimited
+		 * PKEY set at the same time since the unlimited one will
+		 * disable the limited one.
+		 */
+		if ((dd->ipath_pkeys[i] & 0x7FFF) == lkey) {
+			ret = -EEXIST;
+			goto bail;
+		}
+	}
+	if (!any) {
+		ret = -EBUSY;
+		goto bail;
+	}
+	for (i = 0; i < ARRAY_SIZE(dd->ipath_pkeys); i++) {
+		if (!dd->ipath_pkeys[i] &&
+		    atomic_inc_return(&dd->ipath_pkeyrefs[i]) == 1) {
+			/* for ipathstats, etc. */
+			ipath_stats.sps_pkeys[i] = lkey;
+			dd->ipath_pkeys[i] = key;
+			ret = 1;
+			goto bail;
+		}
+	}
+	ret = -EBUSY;
+
+bail:
+	return ret;
+}
+
+/**
+ * set_pkeys - set the PKEY table for port 0
+ * @dd: the infinipath device
+ * @pkeys: the PKEY table
+ */
+static int set_pkeys(struct ipath_devdata *dd, u16 *pkeys)
+{
+	struct ipath_portdata *pd;
+	int i;
+	int changed = 0;
+
+	pd = dd->ipath_pd[0];
+
+	for (i = 0; i < ARRAY_SIZE(pd->port_pkeys); i++) {
+		u16 key = pkeys[i];
+		u16 okey = pd->port_pkeys[i];
+
+		if (key == okey)
+			continue;
+		/*
+		 * The value of this PKEY table entry is changing.
+		 * Remove the old entry in the hardware's array of PKEYs.
+		 */
+		if (okey & 0x7FFF)
+			changed |= rm_pkey(dd, okey);
+		if (key & 0x7FFF) {
+			int ret = add_pkey(dd, key);
+
+			if (ret < 0)
+				key = 0;
+			else
+				changed |= ret;
+		}
+		pd->port_pkeys[i] = key;
+	}
+	if (changed) {
+		u64 pkey;
+
+		pkey = (u64) dd->ipath_pkeys[0] |
+			((u64) dd->ipath_pkeys[1] << 16) |
+			((u64) dd->ipath_pkeys[2] << 32) |
+			((u64) dd->ipath_pkeys[3] << 48);
+		ipath_cdbg(VERBOSE, "p0 new pkey reg %llx\n",
+			   (unsigned long long) pkey);
+		ipath_write_kreg(dd, dd->ipath_kregs->kr_partitionkey,
+				 pkey);
+	}
+	return 0;
 }
 
 static int recv_subn_set_pkeytable(struct ib_smp *smp,
@@ -500,13 +750,12 @@ static int recv_subn_set_pkeytable(struc
 	__be16 *p = (__be16 *) smp->data;
 	u16 *q = (u16 *) smp->data;
 	struct ipath_ibdev *dev = to_idev(ibdev);
-	unsigned i, n = ipath_layer_get_npkeys(dev->dd);
+	unsigned i, n = ipath_get_npkeys(dev->dd);
 
 	for (i = 0; i < n; i++)
 		q[i] = be16_to_cpu(p[i]);
 
-	if (startpx != 0 ||
-	    ipath_layer_set_pkeys(dev->dd, q) != 0)
+	if (startpx != 0 || set_pkeys(dev->dd, q) != 0)
 		smp->status |= IB_SMP_INVALID_FIELD;
 
 	return recv_subn_get_pkeytable(smp, ibdev);
@@ -844,10 +1093,10 @@ static int recv_pma_get_portcounters(str
 	struct ib_pma_portcounters *p = (struct ib_pma_portcounters *)
 		pmp->data;
 	struct ipath_ibdev *dev = to_idev(ibdev);
-	struct ipath_layer_counters cntrs;
+	struct ipath_verbs_counters cntrs;
 	u8 port_select = p->port_select;
 
-	ipath_layer_get_counters(dev->dd, &cntrs);
+	ipath_get_counters(dev->dd, &cntrs);
 
 	/* Adjust counters for any resets done. */
 	cntrs.symbol_error_counter -= dev->z_symbol_error_counter;
@@ -944,8 +1193,8 @@ static int recv_pma_get_portcounters_ext
 	u64 swords, rwords, spkts, rpkts, xwait;
 	u8 port_select = p->port_select;
 
-	ipath_layer_snapshot_counters(dev->dd, &swords, &rwords, &spkts,
-				      &rpkts, &xwait);
+	ipath_snapshot_counters(dev->dd, &swords, &rwords, &spkts,
+				&rpkts, &xwait);
 
 	/* Adjust counters for any resets done. */
 	swords -= dev->z_port_xmit_data;
@@ -978,13 +1227,13 @@ static int recv_pma_set_portcounters(str
 	struct ib_pma_portcounters *p = (struct ib_pma_portcounters *)
 		pmp->data;
 	struct ipath_ibdev *dev = to_idev(ibdev);
-	struct ipath_layer_counters cntrs;
+	struct ipath_verbs_counters cntrs;
 
 	/*
 	 * Since the HW doesn't support clearing counters, we save the
 	 * current count and subtract it from future responses.
 	 */
-	ipath_layer_get_counters(dev->dd, &cntrs);
+	ipath_get_counters(dev->dd, &cntrs);
 
 	if (p->counter_select & IB_PMA_SEL_SYMBOL_ERROR)
 		dev->z_symbol_error_counter = cntrs.symbol_error_counter;
@@ -1041,8 +1290,8 @@ static int recv_pma_set_portcounters_ext
 	struct ipath_ibdev *dev = to_idev(ibdev);
 	u64 swords, rwords, spkts, rpkts, xwait;
 
-	ipath_layer_snapshot_counters(dev->dd, &swords, &rwords, &spkts,
-				      &rpkts, &xwait);
+	ipath_snapshot_counters(dev->dd, &swords, &rwords, &spkts,
+				&rpkts, &xwait);
 
 	if (p->counter_select & IB_PMA_SELX_PORT_XMIT_DATA)
 		dev->z_port_xmit_data = swords;
diff --git a/drivers/infiniband/hw/ipath/ipath_mr.c b/drivers/infiniband/hw/ipath/ipath_mr.c
--- a/drivers/infiniband/hw/ipath/ipath_mr.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_mr.c	Fri Aug 25 11:19:45 2006 -0700
@@ -35,6 +35,18 @@
 #include <rdma/ib_smi.h>
 
 #include "ipath_verbs.h"
+
+/* Fast memory region */
+struct ipath_fmr {
+	struct ib_fmr ibfmr;
+	u8 page_shift;
+	struct ipath_mregion mr;        /* must be last */
+};
+
+static inline struct ipath_fmr *to_ifmr(struct ib_fmr *ibfmr)
+{
+	return container_of(ibfmr, struct ipath_fmr, ibfmr);
+}
 
 /**
  * ipath_get_dma_mr - get a DMA memory region
diff --git a/drivers/infiniband/hw/ipath/ipath_qp.c b/drivers/infiniband/hw/ipath/ipath_qp.c
--- a/drivers/infiniband/hw/ipath/ipath_qp.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c	Fri Aug 25 11:19:45 2006 -0700
@@ -461,7 +461,7 @@ int ipath_modify_qp(struct ib_qp *ibqp, 
 			goto inval;
 
 	if (attr_mask & IB_QP_PKEY_INDEX)
-		if (attr->pkey_index >= ipath_layer_get_npkeys(dev->dd))
+		if (attr->pkey_index >= ipath_get_npkeys(dev->dd))
 			goto inval;
 
 	if (attr_mask & IB_QP_MIN_RNR_TIMER)
@@ -645,6 +645,33 @@ __be32 ipath_compute_aeth(struct ipath_q
 }
 
 /**
+ * set_verbs_flags - set the verbs layer flags
+ * @dd: the infinipath device
+ * @flags: the flags to set
+ */
+static int set_verbs_flags(struct ipath_devdata *dd, unsigned flags)
+{
+	struct ipath_devdata *ss;
+	unsigned long lflags;
+
+	spin_lock_irqsave(&ipath_devs_lock, lflags);
+
+	list_for_each_entry(ss, &ipath_dev_list, ipath_list) {
+		if (!(ss->ipath_flags & IPATH_INITTED))
+			continue;
+		if ((flags & IPATH_VERBS_KERNEL_SMA) &&
+		    !(*ss->ipath_statusp & IPATH_STATUS_SMA))
+			*ss->ipath_statusp |= IPATH_STATUS_OIB_SMA;
+		else
+			*ss->ipath_statusp &= ~IPATH_STATUS_OIB_SMA;
+	}
+
+	spin_unlock_irqrestore(&ipath_devs_lock, lflags);
+
+	return 0;
+}
+
+/**
  * ipath_create_qp - create a queue pair for a device
  * @ibpd: the protection domain who's device we create the queue pair for
  * @init_attr: the attributes of the queue pair
@@ -760,8 +787,7 @@ struct ib_qp *ipath_create_qp(struct ib_
 
 		/* Tell the core driver that the kernel SMA is present. */
 		if (init_attr->qp_type == IB_QPT_SMI)
-			ipath_layer_set_verbs_flags(dev->dd,
-						    IPATH_VERBS_KERNEL_SMA);
+			set_verbs_flags(dev->dd, IPATH_VERBS_KERNEL_SMA);
 		break;
 
 	default:
@@ -838,7 +864,7 @@ int ipath_destroy_qp(struct ib_qp *ibqp)
 
 	/* Tell the core driver that the kernel SMA is gone. */
 	if (qp->ibqp.qp_type == IB_QPT_SMI)
-		ipath_layer_set_verbs_flags(dev->dd, 0);
+		set_verbs_flags(dev->dd, 0);
 
 	spin_lock_irqsave(&qp->s_lock, flags);
 	qp->state = IB_QPS_ERR;
diff --git a/drivers/infiniband/hw/ipath/ipath_rc.c b/drivers/infiniband/hw/ipath/ipath_rc.c
--- a/drivers/infiniband/hw/ipath/ipath_rc.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_rc.c	Fri Aug 25 11:19:45 2006 -0700
@@ -32,7 +32,7 @@
  */
 
 #include "ipath_verbs.h"
-#include "ipath_common.h"
+#include "ipath_kernel.h"
 
 /* cut down ridiculously long IB macro names */
 #define OP(x) IB_OPCODE_RC_##x
@@ -540,7 +540,7 @@ static void send_rc_ack(struct ipath_qp 
 		lrh0 = IPATH_LRH_GRH;
 	}
 	/* read pkey_index w/o lock (its atomic) */
-	bth0 = ipath_layer_get_pkey(dev->dd, qp->s_pkey_index);
+	bth0 = ipath_get_pkey(dev->dd, qp->s_pkey_index);
 	if (qp->r_nak_state)
 		ohdr->u.aeth = cpu_to_be32((qp->r_msn & IPATH_MSN_MASK) |
 					    (qp->r_nak_state <<
@@ -557,7 +557,7 @@ static void send_rc_ack(struct ipath_qp 
 	hdr.lrh[0] = cpu_to_be16(lrh0);
 	hdr.lrh[1] = cpu_to_be16(qp->remote_ah_attr.dlid);
 	hdr.lrh[2] = cpu_to_be16(hwords + SIZE_OF_CRC);
-	hdr.lrh[3] = cpu_to_be16(ipath_layer_get_lid(dev->dd));
+	hdr.lrh[3] = cpu_to_be16(dev->dd->ipath_lid);
 	ohdr->bth[0] = cpu_to_be32(bth0);
 	ohdr->bth[1] = cpu_to_be32(qp->remote_qpn);
 	ohdr->bth[2] = cpu_to_be32(qp->r_ack_psn & IPATH_PSN_MASK);
@@ -1323,8 +1323,7 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 		 * the eager header buffer size to 56 bytes so the last 4
 		 * bytes of the BTH header (PSN) is in the data buffer.
 		 */
-		header_in_data =
-			ipath_layer_get_rcvhdrentsize(dev->dd) == 16;
+		header_in_data = dev->dd->ipath_rcvhdrentsize == 16;
 		if (header_in_data) {
 			psn = be32_to_cpu(((__be32 *) data)[0]);
 			data += sizeof(__be32);
diff --git a/drivers/infiniband/hw/ipath/ipath_ruc.c b/drivers/infiniband/hw/ipath/ipath_ruc.c
--- a/drivers/infiniband/hw/ipath/ipath_ruc.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_ruc.c	Fri Aug 25 11:19:45 2006 -0700
@@ -470,6 +470,15 @@ done:
 		wake_up(&qp->wait);
 }
 
+static int want_buffer(struct ipath_devdata *dd)
+{
+	set_bit(IPATH_S_PIOINTBUFAVAIL, &dd->ipath_sendctrl);
+	ipath_write_kreg(dd, dd->ipath_kregs->kr_sendctrl,
+			 dd->ipath_sendctrl);
+
+	return 0;
+}
+
 /**
  * ipath_no_bufs_available - tell the layer driver we need buffers
  * @qp: the QP that caused the problem
@@ -486,7 +495,7 @@ void ipath_no_bufs_available(struct ipat
 		list_add_tail(&qp->piowait, &dev->piowait);
 	spin_unlock_irqrestore(&dev->pending_lock, flags);
 	/*
-	 * Note that as soon as ipath_layer_want_buffer() is called and
+	 * Note that as soon as want_buffer() is called and
 	 * possibly before it returns, ipath_ib_piobufavail()
 	 * could be called.  If we are still in the tasklet function,
 	 * tasklet_hi_schedule() will not call us until the next time
@@ -496,7 +505,7 @@ void ipath_no_bufs_available(struct ipat
 	 */
 	clear_bit(IPATH_S_BUSY, &qp->s_flags);
 	tasklet_unlock(&qp->s_task);
-	ipath_layer_want_buffer(dev->dd);
+	want_buffer(dev->dd);
 	dev->n_piowait++;
 }
 
@@ -611,7 +620,7 @@ u32 ipath_make_grh(struct ipath_ibdev *d
 	hdr->hop_limit = grh->hop_limit;
 	/* The SGID is 32-bit aligned. */
 	hdr->sgid.global.subnet_prefix = dev->gid_prefix;
-	hdr->sgid.global.interface_id = ipath_layer_get_guid(dev->dd);
+	hdr->sgid.global.interface_id = dev->dd->ipath_guid;
 	hdr->dgid = grh->dgid;
 
 	/* GRH header size in 32-bit words. */
@@ -643,8 +652,7 @@ void ipath_do_ruc_send(unsigned long dat
 	if (test_and_set_bit(IPATH_S_BUSY, &qp->s_flags))
 		goto bail;
 
-	if (unlikely(qp->remote_ah_attr.dlid ==
-		     ipath_layer_get_lid(dev->dd))) {
+	if (unlikely(qp->remote_ah_attr.dlid == dev->dd->ipath_lid)) {
 		ipath_ruc_loopback(qp);
 		goto clear;
 	}
@@ -711,8 +719,8 @@ again:
 	qp->s_hdr.lrh[1] = cpu_to_be16(qp->remote_ah_attr.dlid);
 	qp->s_hdr.lrh[2] = cpu_to_be16(qp->s_hdrwords + nwords +
 				       SIZE_OF_CRC);
-	qp->s_hdr.lrh[3] = cpu_to_be16(ipath_layer_get_lid(dev->dd));
-	bth0 |= ipath_layer_get_pkey(dev->dd, qp->s_pkey_index);
+	qp->s_hdr.lrh[3] = cpu_to_be16(dev->dd->ipath_lid);
+	bth0 |= ipath_get_pkey(dev->dd, qp->s_pkey_index);
 	bth0 |= extra_bytes << 20;
 	ohdr->bth[0] = cpu_to_be32(bth0);
 	ohdr->bth[1] = cpu_to_be32(qp->remote_qpn);
diff --git a/drivers/infiniband/hw/ipath/ipath_sysfs.c b/drivers/infiniband/hw/ipath/ipath_sysfs.c
--- a/drivers/infiniband/hw/ipath/ipath_sysfs.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_sysfs.c	Fri Aug 25 11:19:45 2006 -0700
@@ -35,7 +35,6 @@
 #include <linux/pci.h>
 
 #include "ipath_kernel.h"
-#include "ipath_layer.h"
 #include "ipath_common.h"
 
 /**
@@ -227,7 +226,6 @@ static ssize_t store_mlid(struct device 
 	unit = dd->ipath_unit;
 
 	dd->ipath_mlid = mlid;
-	ipath_layer_intr(dd, IPATH_LAYER_INT_BCAST);
 
 	goto bail;
 invalid:
@@ -467,7 +465,7 @@ static ssize_t store_link_state(struct d
 	if (ret < 0)
 		goto invalid;
 
-	r = ipath_layer_set_linkstate(dd, state);
+	r = ipath_set_linkstate(dd, state);
 	if (r < 0) {
 		ret = r;
 		goto bail;
@@ -502,7 +500,7 @@ static ssize_t store_mtu(struct device *
 	if (ret < 0)
 		goto invalid;
 
-	r = ipath_layer_set_mtu(dd, mtu);
+	r = ipath_set_mtu(dd, mtu);
 	if (r < 0)
 		ret = r;
 
diff --git a/drivers/infiniband/hw/ipath/ipath_uc.c b/drivers/infiniband/hw/ipath/ipath_uc.c
--- a/drivers/infiniband/hw/ipath/ipath_uc.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_uc.c	Fri Aug 25 11:19:45 2006 -0700
@@ -32,7 +32,7 @@
  */
 
 #include "ipath_verbs.h"
-#include "ipath_common.h"
+#include "ipath_kernel.h"
 
 /* cut down ridiculously long IB macro names */
 #define OP(x) IB_OPCODE_UC_##x
@@ -261,8 +261,7 @@ void ipath_uc_rcv(struct ipath_ibdev *de
 		 * size to 56 bytes so the last 4 bytes of
 		 * the BTH header (PSN) is in the data buffer.
 		 */
-		header_in_data =
-			ipath_layer_get_rcvhdrentsize(dev->dd) == 16;
+		header_in_data = dev->dd->ipath_rcvhdrentsize == 16;
 		if (header_in_data) {
 			psn = be32_to_cpu(((__be32 *) data)[0]);
 			data += sizeof(__be32);
diff --git a/drivers/infiniband/hw/ipath/ipath_ud.c b/drivers/infiniband/hw/ipath/ipath_ud.c
--- a/drivers/infiniband/hw/ipath/ipath_ud.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_ud.c	Fri Aug 25 11:19:45 2006 -0700
@@ -353,7 +353,7 @@ int ipath_post_ud_send(struct ipath_qp *
 		ss.num_sge++;
 	}
 	/* Check for invalid packet size. */
-	if (len > ipath_layer_get_ibmtu(dev->dd)) {
+	if (len > dev->dd->ipath_ibmtu) {
 		ret = -EINVAL;
 		goto bail;
 	}
@@ -375,7 +375,7 @@ int ipath_post_ud_send(struct ipath_qp *
 		dev->n_unicast_xmit++;
 		lid = ah_attr->dlid &
 			~((1 << (dev->mkeyprot_resv_lmc & 7)) - 1);
-		if (unlikely(lid == ipath_layer_get_lid(dev->dd))) {
+		if (unlikely(lid == dev->dd->ipath_lid)) {
 			/*
 			 * Pass in an uninitialized ib_wc to save stack
 			 * space.
@@ -404,7 +404,7 @@ int ipath_post_ud_send(struct ipath_qp *
 		qp->s_hdr.u.l.grh.sgid.global.subnet_prefix =
 			dev->gid_prefix;
 		qp->s_hdr.u.l.grh.sgid.global.interface_id =
-			ipath_layer_get_guid(dev->dd);
+			dev->dd->ipath_guid;
 		qp->s_hdr.u.l.grh.dgid = ah_attr->grh.dgid;
 		/*
 		 * Don't worry about sending to locally attached multicast
@@ -434,7 +434,7 @@ int ipath_post_ud_send(struct ipath_qp *
 	qp->s_hdr.lrh[0] = cpu_to_be16(lrh0);
 	qp->s_hdr.lrh[1] = cpu_to_be16(ah_attr->dlid);	/* DEST LID */
 	qp->s_hdr.lrh[2] = cpu_to_be16(hwords + nwords + SIZE_OF_CRC);
-	lid = ipath_layer_get_lid(dev->dd);
+	lid = dev->dd->ipath_lid;
 	if (lid) {
 		lid |= ah_attr->src_path_bits &
 			((1 << (dev->mkeyprot_resv_lmc & 7)) - 1);
@@ -445,7 +445,7 @@ int ipath_post_ud_send(struct ipath_qp *
 		bth0 |= 1 << 23;
 	bth0 |= extra_bytes << 20;
 	bth0 |= qp->ibqp.qp_type == IB_QPT_SMI ? IPATH_DEFAULT_P_KEY :
-		ipath_layer_get_pkey(dev->dd, qp->s_pkey_index);
+		ipath_get_pkey(dev->dd, qp->s_pkey_index);
 	ohdr->bth[0] = cpu_to_be32(bth0);
 	/*
 	 * Use the multicast QP if the destination LID is a multicast LID.
@@ -531,8 +531,7 @@ void ipath_ud_rcv(struct ipath_ibdev *de
 		 * the eager header buffer size to 56 bytes so the last 12
 		 * bytes of the IB header is in the data buffer.
 		 */
-		header_in_data =
-			ipath_layer_get_rcvhdrentsize(dev->dd) == 16;
+		header_in_data = dev->dd->ipath_rcvhdrentsize == 16;
 		if (header_in_data) {
 			qkey = be32_to_cpu(((__be32 *) data)[1]);
 			src_qp = be32_to_cpu(((__be32 *) data)[2]);
diff --git a/drivers/infiniband/hw/ipath/ipath_verbs.c b/drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri Aug 25 11:19:45 2006 -0700
@@ -33,14 +33,12 @@
 
 #include <rdma/ib_mad.h>
 #include <rdma/ib_user_verbs.h>
+#include <linux/io.h>
 #include <linux/utsname.h>
 
 #include "ipath_kernel.h"
 #include "ipath_verbs.h"
 #include "ipath_common.h"
-
-/* Not static, because we don't want the compiler removing it */
-const char ipath_verbs_version[] = "ipath_verbs " IPATH_IDSTR;
 
 static unsigned int ib_ipath_qp_table_size = 251;
 module_param_named(qp_table_size, ib_ipath_qp_table_size, uint, S_IRUGO);
@@ -108,10 +106,6 @@ module_param_named(max_srq_wrs, ib_ipath
 module_param_named(max_srq_wrs, ib_ipath_max_srq_wrs,
 		   uint, S_IWUSR | S_IRUGO);
 MODULE_PARM_DESC(max_srq_wrs, "Maximum number of SRQ WRs support");
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("QLogic <support@pathscale.com>");
-MODULE_DESCRIPTION("QLogic InfiniPath driver");
 
 const int ib_ipath_state_ops[IB_QPS_ERR + 1] = {
 	[IB_QPS_RESET] = 0,
@@ -124,6 +118,16 @@ const int ib_ipath_state_ops[IB_QPS_ERR 
 	[IB_QPS_SQE] = IPATH_POST_RECV_OK | IPATH_PROCESS_RECV_OK,
 	[IB_QPS_ERR] = 0,
 };
+
+struct ipath_ucontext {
+	struct ib_ucontext ibucontext;
+};
+
+static inline struct ipath_ucontext *to_iucontext(struct ib_ucontext
+						  *ibucontext)
+{
+	return container_of(ibucontext, struct ipath_ucontext, ibucontext);
+}
 
 /*
  * Translate ib_wr_opcode into ib_wc_opcode.
@@ -400,7 +404,7 @@ void ipath_ib_rcv(struct ipath_ibdev *de
 	lid = be16_to_cpu(hdr->lrh[1]);
 	if (lid < IPATH_MULTICAST_LID_BASE) {
 		lid &= ~((1 << (dev->mkeyprot_resv_lmc & 7)) - 1);
-		if (unlikely(lid != ipath_layer_get_lid(dev->dd))) {
+		if (unlikely(lid != dev->dd->ipath_lid)) {
 			dev->rcv_errors++;
 			goto bail;
 		}
@@ -511,19 +515,19 @@ void ipath_ib_timer(struct ipath_ibdev *
 	if (dev->pma_sample_status == IB_PMA_SAMPLE_STATUS_STARTED &&
 	    --dev->pma_sample_start == 0) {
 		dev->pma_sample_status = IB_PMA_SAMPLE_STATUS_RUNNING;
-		ipath_layer_snapshot_counters(dev->dd, &dev->ipath_sword,
-					      &dev->ipath_rword,
-					      &dev->ipath_spkts,
-					      &dev->ipath_rpkts,
-					      &dev->ipath_xmit_wait);
+		ipath_snapshot_counters(dev->dd, &dev->ipath_sword,
+					&dev->ipath_rword,
+					&dev->ipath_spkts,
+					&dev->ipath_rpkts,
+					&dev->ipath_xmit_wait);
 	}
 	if (dev->pma_sample_status == IB_PMA_SAMPLE_STATUS_RUNNING) {
 		if (dev->pma_sample_interval == 0) {
 			u64 ta, tb, tc, td, te;
 
 			dev->pma_sample_status = IB_PMA_SAMPLE_STATUS_DONE;
-			ipath_layer_snapshot_counters(dev->dd, &ta, &tb,
-						      &tc, &td, &te);
+			ipath_snapshot_counters(dev->dd, &ta, &tb,
+						&tc, &td, &te);
 
 			dev->ipath_sword = ta - dev->ipath_sword;
 			dev->ipath_rword = tb - dev->ipath_rword;
@@ -551,6 +555,362 @@ void ipath_ib_timer(struct ipath_ibdev *
 		if (atomic_dec_and_test(&qp->refcount))
 			wake_up(&qp->wait);
 	}
+}
+
+static void update_sge(struct ipath_sge_state *ss, u32 length)
+{
+	struct ipath_sge *sge = &ss->sge;
+
+	sge->vaddr += length;
+	sge->length -= length;
+	sge->sge_length -= length;
+	if (sge->sge_length == 0) {
+		if (--ss->num_sge)
+			*sge = *ss->sg_list++;
+	} else if (sge->length == 0 && sge->mr != NULL) {
+		if (++sge->n >= IPATH_SEGSZ) {
+			if (++sge->m >= sge->mr->mapsz)
+				return;
+			sge->n = 0;
+		}
+		sge->vaddr = sge->mr->map[sge->m]->segs[sge->n].vaddr;
+		sge->length = sge->mr->map[sge->m]->segs[sge->n].length;
+	}
+}
+
+#ifdef __LITTLE_ENDIAN
+static inline u32 get_upper_bits(u32 data, u32 shift)
+{
+	return data >> shift;
+}
+
+static inline u32 set_upper_bits(u32 data, u32 shift)
+{
+	return data << shift;
+}
+
+static inline u32 clear_upper_bytes(u32 data, u32 n, u32 off)
+{
+	data <<= ((sizeof(u32) - n) * BITS_PER_BYTE);
+	data >>= ((sizeof(u32) - n - off) * BITS_PER_BYTE);
+	return data;
+}
+#else
+static inline u32 get_upper_bits(u32 data, u32 shift)
+{
+	return data << shift;
+}
+
+static inline u32 set_upper_bits(u32 data, u32 shift)
+{
+	return data >> shift;
+}
+
+static inline u32 clear_upper_bytes(u32 data, u32 n, u32 off)
+{
+	data >>= ((sizeof(u32) - n) * BITS_PER_BYTE);
+	data <<= ((sizeof(u32) - n - off) * BITS_PER_BYTE);
+	return data;
+}
+#endif
+
+static void copy_io(u32 __iomem *piobuf, struct ipath_sge_state *ss,
+		    u32 length)
+{
+	u32 extra = 0;
+	u32 data = 0;
+	u32 last;
+
+	while (1) {
+		u32 len = ss->sge.length;
+		u32 off;
+
+		BUG_ON(len == 0);
+		if (len > length)
+			len = length;
+		if (len > ss->sge.sge_length)
+			len = ss->sge.sge_length;
+		/* If the source address is not aligned, try to align it. */
+		off = (unsigned long)ss->sge.vaddr & (sizeof(u32) - 1);
+		if (off) {
+			u32 *addr = (u32 *)((unsigned long)ss->sge.vaddr &
+					    ~(sizeof(u32) - 1));
+			u32 v = get_upper_bits(*addr, off * BITS_PER_BYTE);
+			u32 y;
+
+			y = sizeof(u32) - off;
+			if (len > y)
+				len = y;
+			if (len + extra >= sizeof(u32)) {
+				data |= set_upper_bits(v, extra *
+						       BITS_PER_BYTE);
+				len = sizeof(u32) - extra;
+				if (len == length) {
+					last = data;
+					break;
+				}
+				__raw_writel(data, piobuf);
+				piobuf++;
+				extra = 0;
+				data = 0;
+			} else {
+				/* Clear unused upper bytes */
+				data |= clear_upper_bytes(v, len, extra);
+				if (len == length) {
+					last = data;
+					break;
+				}
+				extra += len;
+			}
+		} else if (extra) {
+			/* Source address is aligned. */
+			u32 *addr = (u32 *) ss->sge.vaddr;
+			int shift = extra * BITS_PER_BYTE;
+			int ushift = 32 - shift;
+			u32 l = len;
+
+			while (l >= sizeof(u32)) {
+				u32 v = *addr;
+
+				data |= set_upper_bits(v, shift);
+				__raw_writel(data, piobuf);
+				data = get_upper_bits(v, ushift);
+				piobuf++;
+				addr++;
+				l -= sizeof(u32);
+			}
+			/*
+			 * We still have 'extra' number of bytes leftover.
+			 */
+			if (l) {
+				u32 v = *addr;
+
+				if (l + extra >= sizeof(u32)) {
+					data |= set_upper_bits(v, shift);
+					len -= l + extra - sizeof(u32);
+					if (len == length) {
+						last = data;
+						break;
+					}
+					__raw_writel(data, piobuf);
+					piobuf++;
+					extra = 0;
+					data = 0;
+				} else {
+					/* Clear unused upper bytes */
+					data |= clear_upper_bytes(v, l,
+								  extra);
+					if (len == length) {
+						last = data;
+						break;
+					}
+					extra += l;
+				}
+			} else if (len == length) {
+				last = data;
+				break;
+			}
+		} else if (len == length) {
+			u32 w;
+
+			/*
+			 * Need to round up for the last dword in the
+			 * packet.
+			 */
+			w = (len + 3) >> 2;
+			__iowrite32_copy(piobuf, ss->sge.vaddr, w - 1);
+			piobuf += w - 1;
+			last = ((u32 *) ss->sge.vaddr)[w - 1];
+			break;
+		} else {
+			u32 w = len >> 2;
+
+			__iowrite32_copy(piobuf, ss->sge.vaddr, w);
+			piobuf += w;
+
+			extra = len & (sizeof(u32) - 1);
+			if (extra) {
+				u32 v = ((u32 *) ss->sge.vaddr)[w];
+
+				/* Clear unused upper bytes */
+				data = clear_upper_bytes(v, extra, 0);
+			}
+		}
+		update_sge(ss, len);
+		length -= len;
+	}
+	/* Update address before sending packet. */
+	update_sge(ss, length);
+	/* must flush early everything before trigger word */
+	ipath_flush_wc();
+	__raw_writel(last, piobuf);
+	/* be sure trigger word is written */
+	ipath_flush_wc();
+}
+
+/**
+ * ipath_verbs_send - send a packet
+ * @dd: the infinipath device
+ * @hdrwords: the number of words in the header
+ * @hdr: the packet header
+ * @len: the length of the packet in bytes
+ * @ss: the SGE to send
+ */
+int ipath_verbs_send(struct ipath_devdata *dd, u32 hdrwords,
+		     u32 *hdr, u32 len, struct ipath_sge_state *ss)
+{
+	u32 __iomem *piobuf;
+	u32 plen;
+	int ret;
+
+	/* +1 is for the qword padding of pbc */
+	plen = hdrwords + ((len + 3) >> 2) + 1;
+	if (unlikely((plen << 2) > dd->ipath_ibmaxlen)) {
+		ipath_dbg("packet len 0x%x too long, failing\n", plen);
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	/* Get a PIO buffer to use. */
+	piobuf = ipath_getpiobuf(dd, NULL);
+	if (unlikely(piobuf == NULL)) {
+		ret = -EBUSY;
+		goto bail;
+	}
+
+	/*
+	 * Write len to control qword, no flags.
+	 * We have to flush after the PBC for correctness on some cpus
+	 * or WC buffer can be written out of order.
+	 */
+	writeq(plen, piobuf);
+	ipath_flush_wc();
+	piobuf += 2;
+	if (len == 0) {
+		/*
+		 * If there is just the header portion, must flush before
+		 * writing last word of header for correctness, and after
+		 * the last header word (trigger word).
+		 */
+		__iowrite32_copy(piobuf, hdr, hdrwords - 1);
+		ipath_flush_wc();
+		__raw_writel(hdr[hdrwords - 1], piobuf + hdrwords - 1);
+		ipath_flush_wc();
+		ret = 0;
+		goto bail;
+	}
+
+	__iowrite32_copy(piobuf, hdr, hdrwords);
+	piobuf += hdrwords;
+
+	/* The common case is aligned and contained in one segment. */
+	if (likely(ss->num_sge == 1 && len <= ss->sge.length &&
+		   !((unsigned long)ss->sge.vaddr & (sizeof(u32) - 1)))) {
+		u32 w;
+		u32 *addr = (u32 *) ss->sge.vaddr;
+
+		/* Update address before sending packet. */
+		update_sge(ss, len);
+		/* Need to round up for the last dword in the packet. */
+		w = (len + 3) >> 2;
+		__iowrite32_copy(piobuf, addr, w - 1);
+		/* must flush early everything before trigger word */
+		ipath_flush_wc();
+		__raw_writel(addr[w - 1], piobuf + w - 1);
+		/* be sure trigger word is written */
+		ipath_flush_wc();
+		ret = 0;
+		goto bail;
+	}
+	copy_io(piobuf, ss, len);
+	ret = 0;
+
+bail:
+	return ret;
+}
+
+int ipath_snapshot_counters(struct ipath_devdata *dd, u64 *swords,
+			    u64 *rwords, u64 *spkts, u64 *rpkts,
+			    u64 *xmit_wait)
+{
+	int ret;
+
+	if (!(dd->ipath_flags & IPATH_INITTED)) {
+		/* no hardware, freeze, etc. */
+		ipath_dbg("unit %u not usable\n", dd->ipath_unit);
+		ret = -EINVAL;
+		goto bail;
+	}
+	*swords = ipath_snap_cntr(dd, dd->ipath_cregs->cr_wordsendcnt);
+	*rwords = ipath_snap_cntr(dd, dd->ipath_cregs->cr_wordrcvcnt);
+	*spkts = ipath_snap_cntr(dd, dd->ipath_cregs->cr_pktsendcnt);
+	*rpkts = ipath_snap_cntr(dd, dd->ipath_cregs->cr_pktrcvcnt);
+	*xmit_wait = ipath_snap_cntr(dd, dd->ipath_cregs->cr_sendstallcnt);
+
+	ret = 0;
+
+bail:
+	return ret;
+}
+
+/**
+ * ipath_get_counters - get various chip counters
+ * @dd: the infinipath device
+ * @cntrs: counters are placed here
+ *
+ * Return the counters needed by recv_pma_get_portcounters().
+ */
+int ipath_get_counters(struct ipath_devdata *dd,
+		       struct ipath_verbs_counters *cntrs)
+{
+	int ret;
+
+	if (!(dd->ipath_flags & IPATH_INITTED)) {
+		/* no hardware, freeze, etc. */
+		ipath_dbg("unit %u not usable\n", dd->ipath_unit);
+		ret = -EINVAL;
+		goto bail;
+	}
+	cntrs->symbol_error_counter =
+		ipath_snap_cntr(dd, dd->ipath_cregs->cr_ibsymbolerrcnt);
+	cntrs->link_error_recovery_counter =
+		ipath_snap_cntr(dd, dd->ipath_cregs->cr_iblinkerrrecovcnt);
+	/*
+	 * The link downed counter counts when the other side downs the
+	 * connection.  We add in the number of times we downed the link
+	 * due to local link integrity errors to compensate.
+	 */
+	cntrs->link_downed_counter =
+		ipath_snap_cntr(dd, dd->ipath_cregs->cr_iblinkdowncnt);
+	cntrs->port_rcv_errors =
+		ipath_snap_cntr(dd, dd->ipath_cregs->cr_rxdroppktcnt) +
+		ipath_snap_cntr(dd, dd->ipath_cregs->cr_rcvovflcnt) +
+		ipath_snap_cntr(dd, dd->ipath_cregs->cr_portovflcnt) +
+		ipath_snap_cntr(dd, dd->ipath_cregs->cr_err_rlencnt) +
+		ipath_snap_cntr(dd, dd->ipath_cregs->cr_invalidrlencnt) +
+		ipath_snap_cntr(dd, dd->ipath_cregs->cr_erricrccnt) +
+		ipath_snap_cntr(dd, dd->ipath_cregs->cr_errvcrccnt) +
+		ipath_snap_cntr(dd, dd->ipath_cregs->cr_errlpcrccnt) +
+		ipath_snap_cntr(dd, dd->ipath_cregs->cr_badformatcnt);
+	cntrs->port_rcv_remphys_errors =
+		ipath_snap_cntr(dd, dd->ipath_cregs->cr_rcvebpcnt);
+	cntrs->port_xmit_discards =
+		ipath_snap_cntr(dd, dd->ipath_cregs->cr_unsupvlcnt);
+	cntrs->port_xmit_data =
+		ipath_snap_cntr(dd, dd->ipath_cregs->cr_wordsendcnt);
+	cntrs->port_rcv_data =
+		ipath_snap_cntr(dd, dd->ipath_cregs->cr_wordrcvcnt);
+	cntrs->port_xmit_packets =
+		ipath_snap_cntr(dd, dd->ipath_cregs->cr_pktsendcnt);
+	cntrs->port_rcv_packets =
+		ipath_snap_cntr(dd, dd->ipath_cregs->cr_pktrcvcnt);
+	cntrs->local_link_integrity_errors = dd->ipath_lli_errors;
+	cntrs->excessive_buffer_overrun_errors = 0; /* XXX */
+
+	ret = 0;
+
+bail:
+	return ret;
 }
 
 /**
@@ -595,9 +955,9 @@ static int ipath_query_device(struct ib_
 		IB_DEVICE_BAD_QKEY_CNTR | IB_DEVICE_SHUTDOWN_PORT |
 		IB_DEVICE_SYS_IMAGE_GUID;
 	props->page_size_cap = PAGE_SIZE;
-	props->vendor_id = ipath_layer_get_vendorid(dev->dd);
-	props->vendor_part_id = ipath_layer_get_deviceid(dev->dd);
-	props->hw_ver = ipath_layer_get_pcirev(dev->dd);
+	props->vendor_id = dev->dd->ipath_vendorid;
+	props->vendor_part_id = dev->dd->ipath_deviceid;
+	props->hw_ver = dev->dd->ipath_pcirev;
 
 	props->sys_image_guid = dev->sys_image_guid;
 
@@ -618,7 +978,7 @@ static int ipath_query_device(struct ib_
 	props->max_srq_sge = ib_ipath_max_srq_sges;
 	/* props->local_ca_ack_delay */
 	props->atomic_cap = IB_ATOMIC_HCA;
-	props->max_pkeys = ipath_layer_get_npkeys(dev->dd);
+	props->max_pkeys = ipath_get_npkeys(dev->dd);
 	props->max_mcast_grp = ib_ipath_max_mcast_grps;
 	props->max_mcast_qp_attach = ib_ipath_max_mcast_qp_attached;
 	props->max_total_mcast_qp_attach = props->max_mcast_qp_attach *
@@ -643,12 +1003,17 @@ const u8 ipath_cvt_physportstate[16] = {
 	[INFINIPATH_IBCS_LT_STATE_RECOVERIDLE] = 6,
 };
 
+u32 ipath_get_cr_errpkey(struct ipath_devdata *dd)
+{
+	return ipath_read_creg32(dd, dd->ipath_cregs->cr_errpkey);
+}
+
 static int ipath_query_port(struct ib_device *ibdev,
 			    u8 port, struct ib_port_attr *props)
 {
 	struct ipath_ibdev *dev = to_idev(ibdev);
 	enum ib_mtu mtu;
-	u16 lid = ipath_layer_get_lid(dev->dd);
+	u16 lid = dev->dd->ipath_lid;
 	u64 ibcstat;
 
 	memset(props, 0, sizeof(*props));
@@ -656,16 +1021,16 @@ static int ipath_query_port(struct ib_de
 	props->lmc = dev->mkeyprot_resv_lmc & 7;
 	props->sm_lid = dev->sm_lid;
 	props->sm_sl = dev->sm_sl;
-	ibcstat = ipath_layer_get_lastibcstat(dev->dd);
+	ibcstat = dev->dd->ipath_lastibcstat;
 	props->state = ((ibcstat >> 4) & 0x3) + 1;
 	/* See phys_state_show() */
 	props->phys_state = ipath_cvt_physportstate[
-		ipath_layer_get_lastibcstat(dev->dd) & 0xf];
+		dev->dd->ipath_lastibcstat & 0xf];
 	props->port_cap_flags = dev->port_cap_flags;
 	props->gid_tbl_len = 1;
 	props->max_msg_sz = 0x80000000;
-	props->pkey_tbl_len = ipath_layer_get_npkeys(dev->dd);
-	props->bad_pkey_cntr = ipath_layer_get_cr_errpkey(dev->dd) -
+	props->pkey_tbl_len = ipath_get_npkeys(dev->dd);
+	props->bad_pkey_cntr = ipath_get_cr_errpkey(dev->dd) -
 		dev->z_pkey_violations;
 	props->qkey_viol_cntr = dev->qkey_violations;
 	props->active_width = IB_WIDTH_4X;
@@ -675,7 +1040,7 @@ static int ipath_query_port(struct ib_de
 	props->init_type_reply = 0;
 
 	props->max_mtu = IB_MTU_4096;
-	switch (ipath_layer_get_ibmtu(dev->dd)) {
+	switch (dev->dd->ipath_ibmtu) {
 	case 4096:
 		mtu = IB_MTU_4096;
 		break;
@@ -734,7 +1099,7 @@ static int ipath_modify_port(struct ib_d
 	dev->port_cap_flags |= props->set_port_cap_mask;
 	dev->port_cap_flags &= ~props->clr_port_cap_mask;
 	if (port_modify_mask & IB_PORT_SHUTDOWN)
-		ipath_layer_set_linkstate(dev->dd, IPATH_IB_LINKDOWN);
+		ipath_set_linkstate(dev->dd, IPATH_IB_LINKDOWN);
 	if (port_modify_mask & IB_PORT_RESET_QKEY_CNTR)
 		dev->qkey_violations = 0;
 	return 0;
@@ -751,7 +1116,7 @@ static int ipath_query_gid(struct ib_dev
 		goto bail;
 	}
 	gid->global.subnet_prefix = dev->gid_prefix;
-	gid->global.interface_id = ipath_layer_get_guid(dev->dd);
+	gid->global.interface_id = dev->dd->ipath_guid;
 
 	ret = 0;
 
@@ -902,24 +1267,49 @@ static int ipath_query_ah(struct ib_ah *
 	return 0;
 }
 
+/**
+ * ipath_get_npkeys - return the size of the PKEY table for port 0
+ * @dd: the infinipath device
+ */
+unsigned ipath_get_npkeys(struct ipath_devdata *dd)
+{
+	return ARRAY_SIZE(dd->ipath_pd[0]->port_pkeys);
+}
+
+/**
+ * ipath_get_pkey - return the indexed PKEY from the port 0 PKEY table
+ * @dd: the infinipath device
+ * @index: the PKEY index
+ */
+unsigned ipath_get_pkey(struct ipath_devdata *dd, unsigned index)
+{
+	unsigned ret;
+
+	if (index >= ARRAY_SIZE(dd->ipath_pd[0]->port_pkeys))
+		ret = 0;
+	else
+		ret = dd->ipath_pd[0]->port_pkeys[index];
+
+	return ret;
+}
+
 static int ipath_query_pkey(struct ib_device *ibdev, u8 port, u16 index,
 			    u16 *pkey)
 {
 	struct ipath_ibdev *dev = to_idev(ibdev);
 	int ret;
 
-	if (index >= ipath_layer_get_npkeys(dev->dd)) {
+	if (index >= ipath_get_npkeys(dev->dd)) {
 		ret = -EINVAL;
 		goto bail;
 	}
 
-	*pkey = ipath_layer_get_pkey(dev->dd, index);
+	*pkey = ipath_get_pkey(dev->dd, index);
 	ret = 0;
 
 bail:
 	return ret;
 }
-
 
 /**
  * ipath_alloc_ucontext - allocate a ucontest
@@ -953,6 +1343,63 @@ static int ipath_dealloc_ucontext(struct
 
 static int ipath_verbs_register_sysfs(struct ib_device *dev);
 
+static void __verbs_timer(unsigned long arg)
+{
+	struct ipath_devdata *dd = (struct ipath_devdata *) arg;
+
+	/*
+	 * If port 0 receive packet interrupts are not available, or
+	 * can be missed, poll the receive queue
+	 */
+	if (dd->ipath_flags & IPATH_POLL_RX_INTR)
+		ipath_kreceive(dd);
+
+	/* Handle verbs layer timeouts. */
+	ipath_ib_timer(dd->verbs_dev);
+
+	mod_timer(&dd->verbs_timer, jiffies + 1);
+}
+
+static int enable_timer(struct ipath_devdata *dd)
+{
+	/*
+	 * Early chips had a design flaw where the chip and kernel idea
+	 * of the tail register don't always agree, and therefore we won't
+	 * get an interrupt on the next packet received.
+	 * If the board supports per packet receive interrupts, use it.
+	 * Otherwise, the timer function periodically checks for packets
+	 * to cover this case.
+	 * Either way, the timer is needed for verbs layer related
+	 * processing.
+	 */
+	if (dd->ipath_flags & IPATH_GPIO_INTR) {
+		ipath_write_kreg(dd, dd->ipath_kregs->kr_debugportselect,
+				 0x2074076542310ULL);
+		/* Enable GPIO bit 2 interrupt */
+		ipath_write_kreg(dd, dd->ipath_kregs->kr_gpio_mask,
+				 (u64) (1 << 2));
+	}
+
+	init_timer(&dd->verbs_timer);
+	dd->verbs_timer.function = __verbs_timer;
+	dd->verbs_timer.data = (unsigned long)dd;
+	dd->verbs_timer.expires = jiffies + 1;
+	add_timer(&dd->verbs_timer);
+
+	return 0;
+}
+
+static int disable_timer(struct ipath_devdata *dd)
+{
+	/* Disable GPIO bit 2 interrupt */
+	if (dd->ipath_flags & IPATH_GPIO_INTR)
+		ipath_write_kreg(dd, dd->ipath_kregs->kr_gpio_mask, 0);
+
+	del_timer_sync(&dd->verbs_timer);
+
+	return 0;
+}
+
 /**
  * ipath_register_ib_device - register our device with the infiniband core
  * @dd: the device data structure
@@ -960,7 +1407,7 @@ static int ipath_verbs_register_sysfs(st
  */
 int ipath_register_ib_device(struct ipath_devdata *dd)
 {
-	struct ipath_layer_counters cntrs;
+	struct ipath_verbs_counters cntrs;
 	struct ipath_ibdev *idev;
 	struct ib_device *dev;
 	int ret;
@@ -1020,7 +1467,7 @@ int ipath_register_ib_device(struct ipat
 	idev->link_width_enabled = 3;	/* 1x or 4x */
 
 	/* Snapshot current HW counters to "clear" them. */
-	ipath_layer_get_counters(dd, &cntrs);
+	ipath_get_counters(dd, &cntrs);
 	idev->z_symbol_error_counter = cntrs.symbol_error_counter;
 	idev->z_link_error_recovery_counter =
 		cntrs.link_error_recovery_counter;
@@ -1044,14 +1491,14 @@ int ipath_register_ib_device(struct ipat
 	 * device types in the system, we can't be sure this is unique.
 	 */
 	if (!sys_image_guid)
-		sys_image_guid = ipath_layer_get_guid(dd);
+		sys_image_guid = dd->ipath_guid;
 	idev->sys_image_guid = sys_image_guid;
 	idev->ib_unit = dd->ipath_unit;
 	idev->dd = dd;
 
 	strlcpy(dev->name, "ipath%d", IB_DEVICE_NAME_MAX);
 	dev->owner = THIS_MODULE;
-	dev->node_guid = ipath_layer_get_guid(dd);
+	dev->node_guid = dd->ipath_guid;
 	dev->uverbs_abi_ver = IPATH_UVERBS_ABI_VERSION;
 	dev->uverbs_cmd_mask =
 		(1ull << IB_USER_VERBS_CMD_GET_CONTEXT)		|
@@ -1085,7 +1532,7 @@ int ipath_register_ib_device(struct ipat
 		(1ull << IB_USER_VERBS_CMD_POST_SRQ_RECV);
 	dev->node_type = IB_NODE_CA;
 	dev->phys_port_cnt = 1;
-	dev->dma_device = ipath_layer_get_device(dd);
+	dev->dma_device = &dd->pcidev->dev;
 	dev->class_dev.dev = dev->dma_device;
 	dev->query_device = ipath_query_device;
 	dev->modify_device = ipath_modify_device;
@@ -1139,7 +1586,7 @@ int ipath_register_ib_device(struct ipat
 	if (ipath_verbs_register_sysfs(dev))
 		goto err_class;
 
-	ipath_layer_enable_timer(dd);
+	enable_timer(dd);
 
 	goto bail;
 
@@ -1164,7 +1611,7 @@ void ipath_unregister_ib_device(struct i
 {
 	struct ib_device *ibdev = &dev->ibdev;
 
-	ipath_layer_disable_timer(dev->dd);
+	disable_timer(dev->dd);
 
 	ib_unregister_device(ibdev);
 
@@ -1197,7 +1644,7 @@ static ssize_t show_rev(struct class_dev
 	struct ipath_ibdev *dev =
 		container_of(cdev, struct ipath_ibdev, ibdev.class_dev);
 
-	return sprintf(buf, "%x\n", ipath_layer_get_pcirev(dev->dd));
+	return sprintf(buf, "%x\n", dev->dd->ipath_pcirev);
 }
 
 static ssize_t show_hca(struct class_device *cdev, char *buf)
@@ -1206,7 +1653,7 @@ static ssize_t show_hca(struct class_dev
 		container_of(cdev, struct ipath_ibdev, ibdev.class_dev);
 	int ret;
 
-	ret = ipath_layer_get_boardname(dev->dd, buf, 128);
+	ret = dev->dd->ipath_f_get_boardname(dev->dd, buf, 128);
 	if (ret < 0)
 		goto bail;
 	strcat(buf, "\n");
diff --git a/drivers/infiniband/hw/ipath/ipath_verbs.h b/drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri Aug 25 11:19:45 2006 -0700
@@ -153,19 +153,6 @@ struct ipath_mcast {
 	int n_attached;
 };
 
-/* Memory region */
-struct ipath_mr {
-	struct ib_mr ibmr;
-	struct ipath_mregion mr;	/* must be last */
-};
-
-/* Fast memory region */
-struct ipath_fmr {
-	struct ib_fmr ibfmr;
-	u8 page_shift;
-	struct ipath_mregion mr;	/* must be last */
-};
-
 /* Protection domain */
 struct ipath_pd {
 	struct ib_pd ibpd;
@@ -217,6 +204,54 @@ struct ipath_cq {
 };
 
 /*
+ * A segment is a linear region of low physical memory.
+ * XXX Maybe we should use phys addr here and kmap()/kunmap().
+ * Used by the verbs layer.
+ */
+struct ipath_seg {
+	void *vaddr;
+	size_t length;
+};
+
+/* The number of ipath_segs that fit in a page. */
+#define IPATH_SEGSZ     (PAGE_SIZE / sizeof (struct ipath_seg))
+
+struct ipath_segarray {
+	struct ipath_seg segs[IPATH_SEGSZ];
+};
+
+struct ipath_mregion {
+	u64 user_base;		/* User's address for this region */
+	u64 iova;		/* IB start address of this region */
+	size_t length;
+	u32 lkey;
+	u32 offset;		/* offset (bytes) to start of region */
+	int access_flags;
+	u32 max_segs;		/* number of ipath_segs in all the arrays */
+	u32 mapsz;		/* size of the map array */
+	struct ipath_segarray *map[0];	/* the segments */
+};
+
+/*
+ * These keep track of the copy progress within a memory region.
+ * Used by the verbs layer.
+ */
+struct ipath_sge {
+	struct ipath_mregion *mr;
+	void *vaddr;		/* current pointer into the segment */
+	u32 sge_length;		/* length of the SGE */
+	u32 length;		/* remaining length of the segment */
+	u16 m;			/* current index: mr->map[m] */
+	u16 n;			/* current index: mr->map[m]->segs[n] */
+};
+
+/* Memory region */
+struct ipath_mr {
+	struct ib_mr ibmr;
+	struct ipath_mregion mr;	/* must be last */
+};
+
+/*
  * Send work request queue entry.
  * The size of the sg_list is determined when the QP is created and stored
  * in qp->s_max_sge.
@@ -268,6 +303,12 @@ struct ipath_srq {
 	struct ipath_mmap_info *ip;
 	/* send signal when number of RWQEs < limit */
 	u32 limit;
+};
+
+struct ipath_sge_state {
+	struct ipath_sge *sg_list;      /* next SGE to be used if any */
+	struct ipath_sge sge;   /* progress state for the current SGE */
+	u8 num_sge;
 };
 
 /*
@@ -500,18 +541,24 @@ struct ipath_ibdev {
 	struct ipath_opcode_stats opstats[128];
 };
 
-struct ipath_ucontext {
-	struct ib_ucontext ibucontext;
+struct ipath_verbs_counters {
+	u64 symbol_error_counter;
+	u64 link_error_recovery_counter;
+	u64 link_downed_counter;
+	u64 port_rcv_errors;
+	u64 port_rcv_remphys_errors;
+	u64 port_xmit_discards;
+	u64 port_xmit_data;
+	u64 port_rcv_data;
+	u64 port_xmit_packets;
+	u64 port_rcv_packets;
+	u32 local_link_integrity_errors;
+	u32 excessive_buffer_overrun_errors;
 };
 
 static inline struct ipath_mr *to_imr(struct ib_mr *ibmr)
 {
 	return container_of(ibmr, struct ipath_mr, ibmr);
-}
-
-static inline struct ipath_fmr *to_ifmr(struct ib_fmr *ibfmr)
-{
-	return container_of(ibfmr, struct ipath_fmr, ibfmr);
 }
 
 static inline struct ipath_pd *to_ipd(struct ib_pd *ibpd)
@@ -551,12 +598,6 @@ int ipath_process_mad(struct ib_device *
 		      struct ib_grh *in_grh,
 		      struct ib_mad *in_mad, struct ib_mad *out_mad);
 
-static inline struct ipath_ucontext *to_iucontext(struct ib_ucontext
-						  *ibucontext)
-{
-	return container_of(ibucontext, struct ipath_ucontext, ibucontext);
-}
-
 /*
  * Compare the lower 24 bits of the two values.
  * Returns an integer <, ==, or > than zero.
@@ -567,6 +608,13 @@ static inline int ipath_cmp24(u32 a, u32
 }
 
 struct ipath_mcast *ipath_mcast_find(union ib_gid *mgid);
+
+int ipath_snapshot_counters(struct ipath_devdata *dd, u64 *swords,
+			    u64 *rwords, u64 *spkts, u64 *rpkts,
+			    u64 *xmit_wait);
+
+int ipath_get_counters(struct ipath_devdata *dd,
+		       struct ipath_verbs_counters *cntrs);
 
 int ipath_multicast_attach(struct ib_qp *ibqp, union ib_gid *gid, u16 lid);
 
@@ -598,6 +646,9 @@ void ipath_sqerror_qp(struct ipath_qp *q
 
 void ipath_get_credit(struct ipath_qp *qp, u32 aeth);
 
+int ipath_verbs_send(struct ipath_devdata *dd, u32 hdrwords,
+		     u32 *hdr, u32 len, struct ipath_sge_state *ss);
+
 void ipath_cq_enter(struct ipath_cq *cq, struct ib_wc *entry, int sig);
 
 int ipath_rkey_ok(struct ipath_ibdev *dev, struct ipath_sge_state *ss,
@@ -721,6 +772,12 @@ int ipath_ib_piobufavail(struct ipath_ib
 
 void ipath_ib_timer(struct ipath_ibdev *);
 
+unsigned ipath_get_npkeys(struct ipath_devdata *);
+
+u32 ipath_get_cr_errpkey(struct ipath_devdata *);
+
+unsigned ipath_get_pkey(struct ipath_devdata *, unsigned);
+
 extern const enum ib_wc_opcode ib_ipath_wc_opcode[];
 
 extern const u8 ipath_cvt_physportstate[];
