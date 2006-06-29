Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWF2Vo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWF2Vo7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932922AbWF2Voa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:44:30 -0400
Received: from mx.pathscale.com ([64.160.42.68]:40335 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932911AbWF2VoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:10 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 37 of 39] IB/ipath - namespace cleanup: replace ips with ipath
X-Mercurial-Node: 2a721e1f490b74df373723766840e057756033bf
Message-Id: <2a721e1f490b74df3737.1151617288@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:41:28 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ips namespace from infinipath drivers.  This renames ips_common.h
to ipath_common.h.  Definitions, data structures, etc. that were not
used by kernel modules have moved to user-only headers.  All names
including ips have been renamed to ipath.  Some names have had an ipath
prefix added.

Signed-off-by: Christian Bell <christian.bell@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 31c382d8210a -r 2a721e1f490b drivers/infiniband/hw/ipath/ipath_common.h
--- a/drivers/infiniband/hw/ipath/ipath_common.h	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_common.h	Thu Jun 29 14:33:26 2006 -0700
@@ -39,7 +39,8 @@
  * to communicate between kernel and user code.
  */
 
-/* This is the IEEE-assigned OUI for QLogic, Inc. InfiniPath */
+
+/* This is the IEEE-assigned OUI for QLogic Inc. InfiniPath */
 #define IPATH_SRC_OUI_1 0x00
 #define IPATH_SRC_OUI_2 0x11
 #define IPATH_SRC_OUI_3 0x75
@@ -343,9 +344,9 @@ struct ipath_base_info {
 /*
  * Similarly, this is the kernel version going back to the user.  It's
  * slightly different, in that we want to tell if the driver was built as
- * part of a QLogic release, or from the driver from OpenIB, kernel.org,
- * or a standard distribution, for support reasons.  The high bit is 0 for
- * non-QLogic, and 1 for QLogic-built/supplied.
+ * part of a QLogic release, or from the driver from openfabrics.org,
+ * kernel.org, or a standard distribution, for support reasons.
+ * The high bit is 0 for non-QLogic and 1 for QLogic-built/supplied.
  *
  * It's returned by the driver to the user code during initialization in the
  * spi_sw_version field of ipath_base_info, so the user code can in turn
@@ -600,14 +601,118 @@ struct infinipath_counters {
 #define INFINIPATH_KPF_INTR 0x1
 
 /* SendPIO per-buffer control */
-#define INFINIPATH_SP_LENGTHP1_MASK 0x3FF
-#define INFINIPATH_SP_LENGTHP1_SHIFT 0
-#define INFINIPATH_SP_INTR    0x80000000
-#define INFINIPATH_SP_TEST    0x40000000
-#define INFINIPATH_SP_TESTEBP 0x20000000
+#define INFINIPATH_SP_TEST    0x40
+#define INFINIPATH_SP_TESTEBP 0x20
 
 /* SendPIOAvail bits */
 #define INFINIPATH_SENDPIOAVAIL_BUSY_SHIFT 1
 #define INFINIPATH_SENDPIOAVAIL_CHECK_SHIFT 0
 
+/* infinipath header format */
+struct ipath_header {
+	/*
+	 * Version - 4 bits, Port - 4 bits, TID - 10 bits and Offset -
+	 * 14 bits before ECO change ~28 Dec 03.  After that, Vers 4,
+	 * Port 3, TID 11, offset 14.
+	 */
+	__le32 ver_port_tid_offset;
+	__le16 chksum;
+	__le16 pkt_flags;
+};
+
+/* infinipath user message header format.
+ * This structure contains the first 4 fields common to all protocols
+ * that employ infinipath.
+ */
+struct ipath_message_header {
+	__be16 lrh[4];
+	__be32 bth[3];
+	/* fields below this point are in host byte order */
+	struct ipath_header iph;
+	__u8 sub_opcode;
+};
+
+/* infinipath ethernet header format */
+struct ether_header {
+	__be16 lrh[4];
+	__be32 bth[3];
+	struct ipath_header iph;
+	__u8 sub_opcode;
+	__u8 cmd;
+	__be16 lid;
+	__u16 mac[3];
+	__u8 frag_num;
+	__u8 seq_num;
+	__le32 len;
+	/* MUST be of word size due to PIO write requirements */
+	__le32 csum;
+	__le16 csum_offset;
+	__le16 flags;
+	__u16 first_2_bytes;
+	__u8 unused[2];		/* currently unused */
+};
+
+
+/* IB - LRH header consts */
+#define IPATH_LRH_GRH 0x0003	/* 1. word of IB LRH - next header: GRH */
+#define IPATH_LRH_BTH 0x0002	/* 1. word of IB LRH - next header: BTH */
+
+/* misc. */
+#define SIZE_OF_CRC 1
+
+#define IPATH_DEFAULT_P_KEY 0xFFFF
+#define IPATH_PERMISSIVE_LID 0xFFFF
+#define IPATH_AETH_CREDIT_SHIFT 24
+#define IPATH_AETH_CREDIT_MASK 0x1F
+#define IPATH_AETH_CREDIT_INVAL 0x1F
+#define IPATH_PSN_MASK 0xFFFFFF
+#define IPATH_MSN_MASK 0xFFFFFF
+#define IPATH_QPN_MASK 0xFFFFFF
+#define IPATH_MULTICAST_LID_BASE 0xC000
+#define IPATH_MULTICAST_QPN 0xFFFFFF
+
+/* Receive Header Queue: receive type (from infinipath) */
+#define RCVHQ_RCV_TYPE_EXPECTED  0
+#define RCVHQ_RCV_TYPE_EAGER     1
+#define RCVHQ_RCV_TYPE_NON_KD    2
+#define RCVHQ_RCV_TYPE_ERROR     3
+
+
+/* sub OpCodes - ith4x  */
+#define IPATH_ITH4X_OPCODE_ENCAP 0x81
+#define IPATH_ITH4X_OPCODE_LID_ARP 0x82
+
+#define IPATH_HEADER_QUEUE_WORDS 9
+
+/* functions for extracting fields from rcvhdrq entries for the driver.
+ */
+static inline __u32 ipath_hdrget_err_flags(const __le32 * rbuf)
+{
+	return __le32_to_cpu(rbuf[1]);
+}
+
+static inline __u32 ipath_hdrget_rcv_type(const __le32 * rbuf)
+{
+	return (__le32_to_cpu(rbuf[0]) >> INFINIPATH_RHF_RCVTYPE_SHIFT)
+	    & INFINIPATH_RHF_RCVTYPE_MASK;
+}
+
+static inline __u32 ipath_hdrget_length_in_bytes(const __le32 * rbuf)
+{
+	return ((__le32_to_cpu(rbuf[0]) >> INFINIPATH_RHF_LENGTH_SHIFT)
+		& INFINIPATH_RHF_LENGTH_MASK) << 2;
+}
+
+static inline __u32 ipath_hdrget_index(const __le32 * rbuf)
+{
+	return (__le32_to_cpu(rbuf[0]) >> INFINIPATH_RHF_EGRINDEX_SHIFT)
+	    & INFINIPATH_RHF_EGRINDEX_MASK;
+}
+
+static inline __u32 ipath_hdrget_ipath_ver(__le32 hdrword)
+{
+	return (__le32_to_cpu(hdrword) >> INFINIPATH_I_VERS_SHIFT)
+	    & INFINIPATH_I_VERS_MASK;
+}
+
 #endif				/* _IPATH_COMMON_H */
diff -r 31c382d8210a -r 2a721e1f490b drivers/infiniband/hw/ipath/ipath_diag.c
--- a/drivers/infiniband/hw/ipath/ipath_diag.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_diag.c	Thu Jun 29 14:33:26 2006 -0700
@@ -44,10 +44,9 @@
 #include <linux/pci.h>
 #include <asm/uaccess.h>
 
+#include "ipath_kernel.h"
+#include "ipath_layer.h"
 #include "ipath_common.h"
-#include "ipath_kernel.h"
-#include "ips_common.h"
-#include "ipath_layer.h"
 
 int ipath_diag_inuse;
 static int diag_set_link;
diff -r 31c382d8210a -r 2a721e1f490b drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Jun 29 14:33:26 2006 -0700
@@ -39,8 +39,8 @@
 #include <linux/vmalloc.h>
 
 #include "ipath_kernel.h"
-#include "ips_common.h"
 #include "ipath_layer.h"
+#include "ipath_common.h"
 
 static void ipath_update_pio_bufs(struct ipath_devdata *);
 
@@ -823,7 +823,8 @@ static void ipath_rcv_layer(struct ipath
 	u8 pad, *bthbytes;
 	struct sk_buff *skb, *nskb;
 
-	if (dd->ipath_port0_skbs && hdr->sub_opcode == OPCODE_ENCAP) {
+	if (dd->ipath_port0_skbs && 
+			hdr->sub_opcode == IPATH_ITH4X_OPCODE_ENCAP) {
 		/*
 		 * Allocate a new sk_buff to replace the one we give
 		 * to the network stack.
@@ -854,7 +855,7 @@ static void ipath_rcv_layer(struct ipath
 		/* another ether packet received */
 		ipath_stats.sps_ether_rpkts++;
 	}
-	else if (hdr->sub_opcode == OPCODE_LID_ARP)
+	else if (hdr->sub_opcode == IPATH_ITH4X_OPCODE_LID_ARP)
 		__ipath_layer_rcv_lid(dd, hdr);
 }
 
@@ -871,7 +872,7 @@ void ipath_kreceive(struct ipath_devdata
 	const u32 rsize = dd->ipath_rcvhdrentsize;	/* words */
 	const u32 maxcnt = dd->ipath_rcvhdrcnt * rsize;	/* words */
 	u32 etail = -1, l, hdrqtail;
-	struct ips_message_header *hdr;
+	struct ipath_message_header *hdr;
 	u32 eflags, i, etype, tlen, pkttot = 0, updegr=0, reloop=0;
 	static u64 totcalls;	/* stats, may eventually remove */
 	char emsg[128];
@@ -897,7 +898,7 @@ reloop:
 		u8 *bthbytes;
 
 		rc = (u64 *) (dd->ipath_pd[0]->port_rcvhdrq + (l << 2));
-		hdr = (struct ips_message_header *)&rc[1];
+		hdr = (struct ipath_message_header *)&rc[1];
 		/*
 		 * could make a network order version of IPATH_KD_QP, and
 		 * do the obvious shift before masking to speed this up.
@@ -905,10 +906,10 @@ reloop:
 		qp = ntohl(hdr->bth[1]) & 0xffffff;
 		bthbytes = (u8 *) hdr->bth;
 
-		eflags = ips_get_hdr_err_flags((__le32 *) rc);
-		etype = ips_get_rcv_type((__le32 *) rc);
+		eflags = ipath_hdrget_err_flags((__le32 *) rc);
+		etype = ipath_hdrget_rcv_type((__le32 *) rc);
 		/* total length */
-		tlen = ips_get_length_in_bytes((__le32 *) rc);
+		tlen = ipath_hdrget_length_in_bytes((__le32 *) rc);
 		ebuf = NULL;
 		if (etype != RCVHQ_RCV_TYPE_EXPECTED) {
 			/*
@@ -918,7 +919,7 @@ reloop:
 			 * set ebuf (so we try to copy data) unless the
 			 * length requires it.
 			 */
-			etail = ips_get_index((__le32 *) rc);
+			etail = ipath_hdrget_index((__le32 *) rc);
 			if (tlen > sizeof(*hdr) ||
 			    etype == RCVHQ_RCV_TYPE_NON_KD)
 				ebuf = ipath_get_egrbuf(dd, etail, 0);
@@ -930,7 +931,7 @@ reloop:
 		 */
 
 		if (etype != RCVHQ_RCV_TYPE_NON_KD && etype !=
-		    RCVHQ_RCV_TYPE_ERROR && ips_get_ipath_ver(
+		    RCVHQ_RCV_TYPE_ERROR && ipath_hdrget_ipath_ver(
 			    hdr->iph.ver_port_tid_offset) !=
 		    IPS_PROTO_VERSION) {
 			ipath_cdbg(PKT, "Bad InfiniPath protocol version "
@@ -943,7 +944,7 @@ reloop:
 			ipath_cdbg(PKT, "RHFerrs %x hdrqtail=%x typ=%u "
 				   "tlen=%x opcode=%x egridx=%x: %s\n",
 				   eflags, l, etype, tlen, bthbytes[0],
-				   ips_get_index((__le32 *) rc), emsg);
+				   ipath_hdrget_index((__le32 *) rc), emsg);
 			/* Count local link integrity errors. */
 			if (eflags & (INFINIPATH_RHF_H_ICRCERR |
 				      INFINIPATH_RHF_H_VCRCERR)) {
diff -r 31c382d8210a -r 2a721e1f490b drivers/infiniband/hw/ipath/ipath_file_ops.c
--- a/drivers/infiniband/hw/ipath/ipath_file_ops.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_file_ops.c	Thu Jun 29 14:33:26 2006 -0700
@@ -39,8 +39,8 @@
 #include <asm/pgtable.h>
 
 #include "ipath_kernel.h"
-#include "ips_common.h"
 #include "ipath_layer.h"
+#include "ipath_common.h"
 
 static int ipath_open(struct inode *, struct file *);
 static int ipath_close(struct inode *, struct file *);
@@ -458,7 +458,7 @@ static int ipath_set_part_key(struct ipa
 	u16 lkey = key & 0x7FFF;
 	int ret;
 
-	if (lkey == (IPS_DEFAULT_P_KEY & 0x7FFF)) {
+	if (lkey == (IPATH_DEFAULT_P_KEY & 0x7FFF)) {
 		/* nothing to do; this key always valid */
 		ret = 0;
 		goto bail;
diff -r 31c382d8210a -r 2a721e1f490b drivers/infiniband/hw/ipath/ipath_init_chip.c
--- a/drivers/infiniband/hw/ipath/ipath_init_chip.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_init_chip.c	Thu Jun 29 14:33:26 2006 -0700
@@ -36,7 +36,7 @@
 #include <linux/vmalloc.h>
 
 #include "ipath_kernel.h"
-#include "ips_common.h"
+#include "ipath_common.h"
 
 /*
  * min buffers we want to have per port, after driver
@@ -277,7 +277,7 @@ static int init_chip_first(struct ipath_
 	pd->port_port = 0;
 	pd->port_cnt = 1;
 	/* The port 0 pkey table is used by the layer interface. */
-	pd->port_pkeys[0] = IPS_DEFAULT_P_KEY;
+	pd->port_pkeys[0] = IPATH_DEFAULT_P_KEY;
 	dd->ipath_rcvtidcnt =
 		ipath_read_kreg32(dd, dd->ipath_kregs->kr_rcvtidcnt);
 	dd->ipath_rcvtidbase =
diff -r 31c382d8210a -r 2a721e1f490b drivers/infiniband/hw/ipath/ipath_intr.c
--- a/drivers/infiniband/hw/ipath/ipath_intr.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_intr.c	Thu Jun 29 14:33:26 2006 -0700
@@ -34,8 +34,8 @@
 #include <linux/pci.h>
 
 #include "ipath_kernel.h"
-#include "ips_common.h"
 #include "ipath_layer.h"
+#include "ipath_common.h"
 
 /* These are all rcv-related errors which we want to count for stats */
 #define E_SUM_PKTERRS \
diff -r 31c382d8210a -r 2a721e1f490b drivers/infiniband/hw/ipath/ipath_layer.c
--- a/drivers/infiniband/hw/ipath/ipath_layer.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_layer.c	Thu Jun 29 14:33:26 2006 -0700
@@ -41,8 +41,8 @@
 #include <asm/byteorder.h>
 
 #include "ipath_kernel.h"
-#include "ips_common.h"
 #include "ipath_layer.h"
+#include "ipath_common.h"
 
 /* Acquire before ipath_devs_lock. */
 static DEFINE_MUTEX(ipath_layer_mutex);
@@ -622,7 +622,7 @@ int ipath_layer_open(struct ipath_devdat
 		goto bail;
 	}
 
-	ret = ipath_setrcvhdrsize(dd, NUM_OF_EXTRA_WORDS_IN_HEADER_QUEUE);
+	ret = ipath_setrcvhdrsize(dd, IPATH_HEADER_QUEUE_WORDS);
 
 	if (ret < 0)
 		goto bail;
@@ -1106,10 +1106,10 @@ int ipath_layer_send_hdr(struct ipath_de
 		}
 
 	vlsllnh = *((__be16 *) hdr);
-	if (vlsllnh != htons(IPS_LRH_BTH)) {
+	if (vlsllnh != htons(IPATH_LRH_BTH)) {
 		ipath_dbg("Warning: lrh[0] wrong (%x, not %x); "
 			  "not sending\n", be16_to_cpu(vlsllnh),
-			  IPS_LRH_BTH);
+			  IPATH_LRH_BTH);
 		ret = -EINVAL;
 	}
 	if (ret)
diff -r 31c382d8210a -r 2a721e1f490b drivers/infiniband/hw/ipath/ipath_mad.c
--- a/drivers/infiniband/hw/ipath/ipath_mad.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_mad.c	Thu Jun 29 14:33:26 2006 -0700
@@ -35,7 +35,7 @@
 
 #include "ipath_kernel.h"
 #include "ipath_verbs.h"
-#include "ips_common.h"
+#include "ipath_common.h"
 
 #define IB_SMP_UNSUP_VERSION	__constant_htons(0x0004)
 #define IB_SMP_UNSUP_METHOD	__constant_htons(0x0008)
@@ -306,7 +306,7 @@ static int recv_subn_set_portinfo(struct
 	lid = be16_to_cpu(pip->lid);
 	if (lid != ipath_layer_get_lid(dev->dd)) {
 		/* Must be a valid unicast LID address. */
-		if (lid == 0 || lid >= IPS_MULTICAST_LID_BASE)
+		if (lid == 0 || lid >= IPATH_MULTICAST_LID_BASE)
 			goto err;
 		ipath_set_lid(dev->dd, lid, pip->mkeyprot_resv_lmc & 7);
 		event.event = IB_EVENT_LID_CHANGE;
@@ -316,7 +316,7 @@ static int recv_subn_set_portinfo(struct
 	smlid = be16_to_cpu(pip->sm_lid);
 	if (smlid != dev->sm_lid) {
 		/* Must be a valid unicast LID address. */
-		if (smlid == 0 || smlid >= IPS_MULTICAST_LID_BASE)
+		if (smlid == 0 || smlid >= IPATH_MULTICAST_LID_BASE)
 			goto err;
 		dev->sm_lid = smlid;
 		event.event = IB_EVENT_SM_CHANGE;
diff -r 31c382d8210a -r 2a721e1f490b drivers/infiniband/hw/ipath/ipath_qp.c
--- a/drivers/infiniband/hw/ipath/ipath_qp.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c	Thu Jun 29 14:33:26 2006 -0700
@@ -35,7 +35,7 @@
 #include <linux/vmalloc.h>
 
 #include "ipath_verbs.h"
-#include "ips_common.h"
+#include "ipath_common.h"
 
 #define BITS_PER_PAGE		(PAGE_SIZE*BITS_PER_BYTE)
 #define BITS_PER_PAGE_MASK	(BITS_PER_PAGE-1)
@@ -450,7 +450,7 @@ int ipath_modify_qp(struct ib_qp *ibqp, 
 
 	if (attr_mask & IB_QP_AV)
 		if (attr->ah_attr.dlid == 0 ||
-		    attr->ah_attr.dlid >= IPS_MULTICAST_LID_BASE)
+		    attr->ah_attr.dlid >= IPATH_MULTICAST_LID_BASE)
 			goto inval;
 
 	if (attr_mask & IB_QP_PKEY_INDEX)
@@ -585,14 +585,14 @@ int ipath_query_qp(struct ib_qp *ibqp, s
  */
 __be32 ipath_compute_aeth(struct ipath_qp *qp)
 {
-	u32 aeth = qp->r_msn & IPS_MSN_MASK;
+	u32 aeth = qp->r_msn & IPATH_MSN_MASK;
 
 	if (qp->ibqp.srq) {
 		/*
 		 * Shared receive queues don't generate credits.
 		 * Set the credit field to the invalid value.
 		 */
-		aeth |= IPS_AETH_CREDIT_INVAL << IPS_AETH_CREDIT_SHIFT;
+		aeth |= IPATH_AETH_CREDIT_INVAL << IPATH_AETH_CREDIT_SHIFT;
 	} else {
 		u32 min, max, x;
 		u32 credits;
@@ -622,7 +622,7 @@ __be32 ipath_compute_aeth(struct ipath_q
 			else
 				min = x;
 		}
-		aeth |= x << IPS_AETH_CREDIT_SHIFT;
+		aeth |= x << IPATH_AETH_CREDIT_SHIFT;
 	}
 	return cpu_to_be32(aeth);
 }
@@ -888,18 +888,18 @@ void ipath_sqerror_qp(struct ipath_qp *q
  */
 void ipath_get_credit(struct ipath_qp *qp, u32 aeth)
 {
-	u32 credit = (aeth >> IPS_AETH_CREDIT_SHIFT) & IPS_AETH_CREDIT_MASK;
+	u32 credit = (aeth >> IPATH_AETH_CREDIT_SHIFT) & IPATH_AETH_CREDIT_MASK;
 
 	/*
 	 * If the credit is invalid, we can send
 	 * as many packets as we like.  Otherwise, we have to
 	 * honor the credit field.
 	 */
-	if (credit == IPS_AETH_CREDIT_INVAL)
+	if (credit == IPATH_AETH_CREDIT_INVAL)
 		qp->s_lsn = (u32) -1;
 	else if (qp->s_lsn != (u32) -1) {
 		/* Compute new LSN (i.e., MSN + credit) */
-		credit = (aeth + credit_table[credit]) & IPS_MSN_MASK;
+		credit = (aeth + credit_table[credit]) & IPATH_MSN_MASK;
 		if (ipath_cmp24(credit, qp->s_lsn) > 0)
 			qp->s_lsn = credit;
 	}
diff -r 31c382d8210a -r 2a721e1f490b drivers/infiniband/hw/ipath/ipath_rc.c
--- a/drivers/infiniband/hw/ipath/ipath_rc.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_rc.c	Thu Jun 29 14:33:26 2006 -0700
@@ -32,7 +32,7 @@
  */
 
 #include "ipath_verbs.h"
-#include "ips_common.h"
+#include "ipath_common.h"
 
 /* cut down ridiculously long IB macro names */
 #define OP(x) IB_OPCODE_RC_##x
@@ -49,7 +49,7 @@ static void ipath_init_restart(struct ip
 	struct ipath_ibdev *dev;
 	u32 len;
 
-	len = ((qp->s_psn - wqe->psn) & IPS_PSN_MASK) *
+	len = ((qp->s_psn - wqe->psn) & IPATH_PSN_MASK) *
 		ib_mtu_enum_to_int(qp->path_mtu);
 	qp->s_sge.sge = wqe->sg_list[0];
 	qp->s_sge.sg_list = wqe->sg_list + 1;
@@ -159,9 +159,9 @@ u32 ipath_make_rc_ack(struct ipath_qp *q
 		qp->s_ack_state = OP(RDMA_READ_RESPONSE_LAST);
 		bth0 = OP(ACKNOWLEDGE) << 24;
 		if (qp->s_nak_state)
-			ohdr->u.aeth = cpu_to_be32((qp->r_msn & IPS_MSN_MASK) |
+			ohdr->u.aeth = cpu_to_be32((qp->r_msn & IPATH_MSN_MASK) |
 						    (qp->s_nak_state <<
-						     IPS_AETH_CREDIT_SHIFT));
+						     IPATH_AETH_CREDIT_SHIFT));
 		else
 			ohdr->u.aeth = ipath_compute_aeth(qp);
 		hwords++;
@@ -361,7 +361,7 @@ int ipath_make_rc_req(struct ipath_qp *q
 			if (qp->s_tail >= qp->s_size)
 				qp->s_tail = 0;
 		}
-		bth2 |= qp->s_psn++ & IPS_PSN_MASK;
+		bth2 |= qp->s_psn++ & IPATH_PSN_MASK;
 		if ((int)(qp->s_psn - qp->s_next_psn) > 0)
 			qp->s_next_psn = qp->s_psn;
 		/*
@@ -387,7 +387,7 @@ int ipath_make_rc_req(struct ipath_qp *q
 		qp->s_state = OP(SEND_MIDDLE);
 		/* FALLTHROUGH */
 	case OP(SEND_MIDDLE):
-		bth2 = qp->s_psn++ & IPS_PSN_MASK;
+		bth2 = qp->s_psn++ & IPATH_PSN_MASK;
 		if ((int)(qp->s_psn - qp->s_next_psn) > 0)
 			qp->s_next_psn = qp->s_psn;
 		ss = &qp->s_sge;
@@ -429,7 +429,7 @@ int ipath_make_rc_req(struct ipath_qp *q
 		qp->s_state = OP(RDMA_WRITE_MIDDLE);
 		/* FALLTHROUGH */
 	case OP(RDMA_WRITE_MIDDLE):
-		bth2 = qp->s_psn++ & IPS_PSN_MASK;
+		bth2 = qp->s_psn++ & IPATH_PSN_MASK;
 		if ((int)(qp->s_psn - qp->s_next_psn) > 0)
 			qp->s_next_psn = qp->s_psn;
 		ss = &qp->s_sge;
@@ -466,7 +466,7 @@ int ipath_make_rc_req(struct ipath_qp *q
 		 * See ipath_restart_rc().
 		 */
 		ipath_init_restart(qp, wqe);
-		len = ((qp->s_psn - wqe->psn) & IPS_PSN_MASK) * pmtu;
+		len = ((qp->s_psn - wqe->psn) & IPATH_PSN_MASK) * pmtu;
 		ohdr->u.rc.reth.vaddr =
 			cpu_to_be64(wqe->wr.wr.rdma.remote_addr + len);
 		ohdr->u.rc.reth.rkey =
@@ -474,7 +474,7 @@ int ipath_make_rc_req(struct ipath_qp *q
 		ohdr->u.rc.reth.length = cpu_to_be32(qp->s_len);
 		qp->s_state = OP(RDMA_READ_REQUEST);
 		hwords += sizeof(ohdr->u.rc.reth) / 4;
-		bth2 = qp->s_psn++ & IPS_PSN_MASK;
+		bth2 = qp->s_psn++ & IPATH_PSN_MASK;
 		if ((int)(qp->s_psn - qp->s_next_psn) > 0)
 			qp->s_next_psn = qp->s_psn;
 		ss = NULL;
@@ -529,7 +529,7 @@ static void send_rc_ack(struct ipath_qp 
 
 	/* Construct the header. */
 	ohdr = &hdr.u.oth;
-	lrh0 = IPS_LRH_BTH;
+	lrh0 = IPATH_LRH_BTH;
 	/* header size in 32-bit words LRH+BTH+AETH = (8+12+4)/4. */
 	hwords = 6;
 	if (unlikely(qp->remote_ah_attr.ah_flags & IB_AH_GRH)) {
@@ -537,14 +537,14 @@ static void send_rc_ack(struct ipath_qp 
 					 &qp->remote_ah_attr.grh,
 					 hwords, 0);
 		ohdr = &hdr.u.l.oth;
-		lrh0 = IPS_LRH_GRH;
+		lrh0 = IPATH_LRH_GRH;
 	}
 	/* read pkey_index w/o lock (its atomic) */
 	bth0 = ipath_layer_get_pkey(dev->dd, qp->s_pkey_index);
 	if (qp->r_nak_state)
-		ohdr->u.aeth = cpu_to_be32((qp->r_msn & IPS_MSN_MASK) |
+		ohdr->u.aeth = cpu_to_be32((qp->r_msn & IPATH_MSN_MASK) |
 					    (qp->r_nak_state <<
-					     IPS_AETH_CREDIT_SHIFT));
+					     IPATH_AETH_CREDIT_SHIFT));
 	else
 		ohdr->u.aeth = ipath_compute_aeth(qp);
 	if (qp->r_ack_state >= OP(COMPARE_SWAP)) {
@@ -560,7 +560,7 @@ static void send_rc_ack(struct ipath_qp 
 	hdr.lrh[3] = cpu_to_be16(ipath_layer_get_lid(dev->dd));
 	ohdr->bth[0] = cpu_to_be32(bth0);
 	ohdr->bth[1] = cpu_to_be32(qp->remote_qpn);
-	ohdr->bth[2] = cpu_to_be32(qp->r_ack_psn & IPS_PSN_MASK);
+	ohdr->bth[2] = cpu_to_be32(qp->r_ack_psn & IPATH_PSN_MASK);
 
 	/*
 	 * If we can send the ACK, clear the ACK state.
@@ -890,8 +890,8 @@ static int do_rc_ack(struct ipath_qp *qp
 		reset_psn(qp, psn);
 
 		qp->s_rnr_timeout =
-			ib_ipath_rnr_table[(aeth >> IPS_AETH_CREDIT_SHIFT) &
-					   IPS_AETH_CREDIT_MASK];
+			ib_ipath_rnr_table[(aeth >> IPATH_AETH_CREDIT_SHIFT) &
+					   IPATH_AETH_CREDIT_MASK];
 		ipath_insert_rnr_queue(qp);
 		goto bail;
 
@@ -899,8 +899,8 @@ static int do_rc_ack(struct ipath_qp *qp
 		/* The last valid PSN seen is the previous request's. */
 		if (qp->s_last != qp->s_tail)
 			qp->s_last_psn = wqe->psn - 1;
-		switch ((aeth >> IPS_AETH_CREDIT_SHIFT) &
-			IPS_AETH_CREDIT_MASK) {
+		switch ((aeth >> IPATH_AETH_CREDIT_SHIFT) &
+			IPATH_AETH_CREDIT_MASK) {
 		case 0:	/* PSN sequence error */
 			dev->n_seq_naks++;
 			/*
@@ -1268,7 +1268,7 @@ static inline int ipath_rc_rcv_error(str
 		 * Check for the PSN of the last atomic operation
 		 * performed and resend the result if found.
 		 */
-		if ((psn & IPS_PSN_MASK) != qp->r_atomic_psn)
+		if ((psn & IPATH_PSN_MASK) != qp->r_atomic_psn)
 			goto done;
 		break;
 	}
@@ -1638,7 +1638,7 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 			*(u64 *) qp->r_sge.sge.vaddr = sdata;
 		spin_unlock_irq(&dev->pending_lock);
 		qp->r_msn++;
-		qp->r_atomic_psn = psn & IPS_PSN_MASK;
+		qp->r_atomic_psn = psn & IPATH_PSN_MASK;
 		psn |= 1 << 31;
 		break;
 	}
diff -r 31c382d8210a -r 2a721e1f490b drivers/infiniband/hw/ipath/ipath_ruc.c
--- a/drivers/infiniband/hw/ipath/ipath_ruc.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_ruc.c	Thu Jun 29 14:33:26 2006 -0700
@@ -32,7 +32,7 @@
  */
 
 #include "ipath_verbs.h"
-#include "ips_common.h"
+#include "ipath_common.h"
 
 /*
  * Convert the AETH RNR timeout code into the number of milliseconds.
@@ -632,7 +632,7 @@ again:
 	/* Sending responses has higher priority over sending requests. */
 	if (qp->s_ack_state != IB_OPCODE_RC_ACKNOWLEDGE &&
 	    (bth0 = ipath_make_rc_ack(qp, ohdr, pmtu)) != 0)
-		bth2 = qp->s_ack_psn++ & IPS_PSN_MASK;
+		bth2 = qp->s_ack_psn++ & IPATH_PSN_MASK;
 	else if (!((qp->ibqp.qp_type == IB_QPT_RC) ?
 		   ipath_make_rc_req(qp, ohdr, pmtu, &bth0, &bth2) :
 		   ipath_make_uc_req(qp, ohdr, pmtu, &bth0, &bth2))) {
@@ -651,12 +651,12 @@ again:
 	/* Construct the header. */
 	extra_bytes = (4 - qp->s_cur_size) & 3;
 	nwords = (qp->s_cur_size + extra_bytes) >> 2;
-	lrh0 = IPS_LRH_BTH;
+	lrh0 = IPATH_LRH_BTH;
 	if (unlikely(qp->remote_ah_attr.ah_flags & IB_AH_GRH)) {
 		qp->s_hdrwords += ipath_make_grh(dev, &qp->s_hdr.u.l.grh,
 						 &qp->remote_ah_attr.grh,
 						 qp->s_hdrwords, nwords);
-		lrh0 = IPS_LRH_GRH;
+		lrh0 = IPATH_LRH_GRH;
 	}
 	lrh0 |= qp->remote_ah_attr.sl << 4;
 	qp->s_hdr.lrh[0] = cpu_to_be16(lrh0);
diff -r 31c382d8210a -r 2a721e1f490b drivers/infiniband/hw/ipath/ipath_sysfs.c
--- a/drivers/infiniband/hw/ipath/ipath_sysfs.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_sysfs.c	Thu Jun 29 14:33:26 2006 -0700
@@ -35,8 +35,8 @@
 #include <linux/pci.h>
 
 #include "ipath_kernel.h"
-#include "ips_common.h"
 #include "ipath_layer.h"
+#include "ipath_common.h"
 
 /**
  * ipath_parse_ushort - parse an unsigned short value in an arbitrary base
@@ -187,7 +187,7 @@ static ssize_t store_lid(struct device *
 	if (ret < 0)
 		goto invalid;
 
-	if (lid == 0 || lid >= IPS_MULTICAST_LID_BASE) {
+	if (lid == 0 || lid >= IPATH_MULTICAST_LID_BASE) {
 		ret = -EINVAL;
 		goto invalid;
 	}
@@ -221,7 +221,7 @@ static ssize_t store_mlid(struct device 
 	int ret;
 
 	ret = ipath_parse_ushort(buf, &mlid);
-	if (ret < 0 || mlid < IPS_MULTICAST_LID_BASE)
+	if (ret < 0 || mlid < IPATH_MULTICAST_LID_BASE)
 		goto invalid;
 
 	unit = dd->ipath_unit;
diff -r 31c382d8210a -r 2a721e1f490b drivers/infiniband/hw/ipath/ipath_uc.c
--- a/drivers/infiniband/hw/ipath/ipath_uc.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_uc.c	Thu Jun 29 14:33:26 2006 -0700
@@ -32,7 +32,7 @@
  */
 
 #include "ipath_verbs.h"
-#include "ips_common.h"
+#include "ipath_common.h"
 
 /* cut down ridiculously long IB macro names */
 #define OP(x) IB_OPCODE_UC_##x
@@ -213,7 +213,7 @@ int ipath_make_uc_req(struct ipath_qp *q
 	qp->s_cur_sge = &qp->s_sge;
 	qp->s_cur_size = len;
 	*bth0p = bth0 | (qp->s_state << 24);
-	*bth2p = qp->s_next_psn++ & IPS_PSN_MASK;
+	*bth2p = qp->s_next_psn++ & IPATH_PSN_MASK;
 	return 1;
 
 done:
diff -r 31c382d8210a -r 2a721e1f490b drivers/infiniband/hw/ipath/ipath_ud.c
--- a/drivers/infiniband/hw/ipath/ipath_ud.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_ud.c	Thu Jun 29 14:33:26 2006 -0700
@@ -34,7 +34,7 @@
 #include <rdma/ib_smi.h>
 
 #include "ipath_verbs.h"
-#include "ips_common.h"
+#include "ipath_common.h"
 
 /**
  * ipath_ud_loopback - handle send on loopback QPs
@@ -289,8 +289,8 @@ int ipath_post_ud_send(struct ipath_qp *
 		ret = -EINVAL;
 		goto bail;
 	}
-	if (ah_attr->dlid >= IPS_MULTICAST_LID_BASE) {
-		if (ah_attr->dlid != IPS_PERMISSIVE_LID)
+	if (ah_attr->dlid >= IPATH_MULTICAST_LID_BASE) {
+		if (ah_attr->dlid != IPATH_PERMISSIVE_LID)
 			dev->n_multicast_xmit++;
 		else
 			dev->n_unicast_xmit++;
@@ -310,7 +310,7 @@ int ipath_post_ud_send(struct ipath_qp *
 	if (ah_attr->ah_flags & IB_AH_GRH) {
 		/* Header size in 32-bit words. */
 		hwords = 17;
-		lrh0 = IPS_LRH_GRH;
+		lrh0 = IPATH_LRH_GRH;
 		ohdr = &qp->s_hdr.u.l.oth;
 		qp->s_hdr.u.l.grh.version_tclass_flow =
 			cpu_to_be32((6 << 28) |
@@ -336,7 +336,7 @@ int ipath_post_ud_send(struct ipath_qp *
 	} else {
 		/* Header size in 32-bit words. */
 		hwords = 7;
-		lrh0 = IPS_LRH_BTH;
+		lrh0 = IPATH_LRH_BTH;
 		ohdr = &qp->s_hdr.u.oth;
 	}
 	if (wr->opcode == IB_WR_SEND_WITH_IMM) {
@@ -367,18 +367,18 @@ int ipath_post_ud_send(struct ipath_qp *
 	if (wr->send_flags & IB_SEND_SOLICITED)
 		bth0 |= 1 << 23;
 	bth0 |= extra_bytes << 20;
-	bth0 |= qp->ibqp.qp_type == IB_QPT_SMI ? IPS_DEFAULT_P_KEY :
+	bth0 |= qp->ibqp.qp_type == IB_QPT_SMI ? IPATH_DEFAULT_P_KEY :
 		ipath_layer_get_pkey(dev->dd, qp->s_pkey_index);
 	ohdr->bth[0] = cpu_to_be32(bth0);
 	/*
 	 * Use the multicast QP if the destination LID is a multicast LID.
 	 */
-	ohdr->bth[1] = ah_attr->dlid >= IPS_MULTICAST_LID_BASE &&
-		ah_attr->dlid != IPS_PERMISSIVE_LID ?
-		__constant_cpu_to_be32(IPS_MULTICAST_QPN) :
+	ohdr->bth[1] = ah_attr->dlid >= IPATH_MULTICAST_LID_BASE &&
+		ah_attr->dlid != IPATH_PERMISSIVE_LID ?
+		__constant_cpu_to_be32(IPATH_MULTICAST_QPN) :
 		cpu_to_be32(wr->wr.ud.remote_qpn);
 	/* XXX Could lose a PSN count but not worth locking */
-	ohdr->bth[2] = cpu_to_be32(qp->s_next_psn++ & IPS_PSN_MASK);
+	ohdr->bth[2] = cpu_to_be32(qp->s_next_psn++ & IPATH_PSN_MASK);
 	/*
 	 * Qkeys with the high order bit set mean use the
 	 * qkey from the QP context instead of the WR (see 10.2.5).
@@ -469,7 +469,7 @@ void ipath_ud_rcv(struct ipath_ibdev *de
 			src_qp = be32_to_cpu(ohdr->u.ud.deth[1]);
 		}
 	}
-	src_qp &= IPS_QPN_MASK;
+	src_qp &= IPATH_QPN_MASK;
 
 	/*
 	 * Check that the permissive LID is only used on QP0
@@ -627,7 +627,7 @@ void ipath_ud_rcv(struct ipath_ibdev *de
 	/*
 	 * Save the LMC lower bits if the destination LID is a unicast LID.
 	 */
-	wc.dlid_path_bits = dlid >= IPS_MULTICAST_LID_BASE ? 0 :
+	wc.dlid_path_bits = dlid >= IPATH_MULTICAST_LID_BASE ? 0 :
 		dlid & ((1 << (dev->mkeyprot_resv_lmc & 7)) - 1);
 	/* Signal completion event if the solicited bit is set. */
 	ipath_cq_enter(to_icq(qp->ibqp.recv_cq), &wc,
diff -r 31c382d8210a -r 2a721e1f490b drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Thu Jun 29 14:33:26 2006 -0700
@@ -37,7 +37,7 @@
 
 #include "ipath_kernel.h"
 #include "ipath_verbs.h"
-#include "ips_common.h"
+#include "ipath_common.h"
 
 /* Not static, because we don't want the compiler removing it */
 const char ipath_verbs_version[] = "ipath_verbs " IPATH_IDSTR;
@@ -429,7 +429,7 @@ static void ipath_ib_rcv(void *arg, void
 
 	/* Check for a valid destination LID (see ch. 7.11.1). */
 	lid = be16_to_cpu(hdr->lrh[1]);
-	if (lid < IPS_MULTICAST_LID_BASE) {
+	if (lid < IPATH_MULTICAST_LID_BASE) {
 		lid &= ~((1 << (dev->mkeyprot_resv_lmc & 7)) - 1);
 		if (unlikely(lid != ipath_layer_get_lid(dev->dd))) {
 			dev->rcv_errors++;
@@ -439,9 +439,9 @@ static void ipath_ib_rcv(void *arg, void
 
 	/* Check for GRH */
 	lnh = be16_to_cpu(hdr->lrh[0]) & 3;
-	if (lnh == IPS_LRH_BTH)
+	if (lnh == IPATH_LRH_BTH)
 		ohdr = &hdr->u.oth;
-	else if (lnh == IPS_LRH_GRH)
+	else if (lnh == IPATH_LRH_GRH)
 		ohdr = &hdr->u.l.oth;
 	else {
 		dev->rcv_errors++;
@@ -453,8 +453,8 @@ static void ipath_ib_rcv(void *arg, void
 	dev->opstats[opcode].n_packets++;
 
 	/* Get the destination QP number. */
-	qp_num = be32_to_cpu(ohdr->bth[1]) & IPS_QPN_MASK;
-	if (qp_num == IPS_MULTICAST_QPN) {
+	qp_num = be32_to_cpu(ohdr->bth[1]) & IPATH_QPN_MASK;
+	if (qp_num == IPATH_MULTICAST_QPN) {
 		struct ipath_mcast *mcast;
 		struct ipath_mcast_qp *p;
 
@@ -465,7 +465,7 @@ static void ipath_ib_rcv(void *arg, void
 		}
 		dev->n_multicast_rcv++;
 		list_for_each_entry_rcu(p, &mcast->qp_list, list)
-			ipath_qp_rcv(dev, hdr, lnh == IPS_LRH_GRH, data,
+			ipath_qp_rcv(dev, hdr, lnh == IPATH_LRH_GRH, data,
 				     tlen, p->qp);
 		/*
 		 * Notify ipath_multicast_detach() if it is waiting for us
@@ -477,7 +477,7 @@ static void ipath_ib_rcv(void *arg, void
 		qp = ipath_lookup_qpn(&dev->qp_table, qp_num);
 		if (qp) {
 			dev->n_unicast_rcv++;
-			ipath_qp_rcv(dev, hdr, lnh == IPS_LRH_GRH, data,
+			ipath_qp_rcv(dev, hdr, lnh == IPATH_LRH_GRH, data,
 				     tlen, qp);
 			/*
 			 * Notify ipath_destroy_qp() if it is waiting
@@ -860,8 +860,8 @@ static struct ib_ah *ipath_create_ah(str
 	}
 
 	/* A multicast address requires a GRH (see ch. 8.4.1). */
-	if (ah_attr->dlid >= IPS_MULTICAST_LID_BASE &&
-	    ah_attr->dlid != IPS_PERMISSIVE_LID &&
+	if (ah_attr->dlid >= IPATH_MULTICAST_LID_BASE &&
+	    ah_attr->dlid != IPATH_PERMISSIVE_LID &&
 	    !(ah_attr->ah_flags & IB_AH_GRH)) {
 		ret = ERR_PTR(-EINVAL);
 		goto bail;
diff -r 31c382d8210a -r 2a721e1f490b drivers/infiniband/hw/ipath/ips_common.h
--- a/drivers/infiniband/hw/ipath/ips_common.h	Thu Jun 29 14:33:26 2006 -0700
+++ /dev/null	Thu Jan 01 00:00:00 1970 +0000
@@ -1,264 +0,0 @@
-#ifndef IPS_COMMON_H
-#define IPS_COMMON_H
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
-#include "ipath_common.h"
-
-struct ipath_header {
-	/*
-	 * Version - 4 bits, Port - 4 bits, TID - 10 bits and Offset -
-	 * 14 bits before ECO change ~28 Dec 03.  After that, Vers 4,
-	 * Port 3, TID 11, offset 14.
-	 */
-	__le32 ver_port_tid_offset;
-	__le16 chksum;
-	__le16 pkt_flags;
-};
-
-struct ips_message_header {
-	__be16 lrh[4];
-	__be32 bth[3];
-	/* fields below this point are in host byte order */
-	struct ipath_header iph;
-	__u8 sub_opcode;
-	__u8 flags;
-	__u16 src_rank;
-	/* 24 bits. The upper 8 bit is available for other use */
-	union {
-		struct {
-			unsigned ack_seq_num:24;
-			unsigned port:4;
-			unsigned unused:4;
-		};
-		__u32 ack_seq_num_org;
-	};
-	__u8 expected_tid_session_id;
-	__u8 tinylen;		/* to aid MPI */
-	union {
-	    __u16 tag;		/* to aid MPI */
-	    __u16 mqhdr;	/* for PSM MQ */
-	};
-	union {
-		__u32 mpi[4];	/* to aid MPI */
-		__u32 data[4];
-		__u64 mq[2];	/* for PSM MQ */
-		struct {
-			__u16 mtu;
-			__u8 major_ver;
-			__u8 minor_ver;
-			__u32 not_used;	//free
-			__u32 run_id;
-			__u32 client_ver;
-		};
-	};
-};
-
-struct ether_header {
-	__be16 lrh[4];
-	__be32 bth[3];
-	struct ipath_header iph;
-	__u8 sub_opcode;
-	__u8 cmd;
-	__be16 lid;
-	__u16 mac[3];
-	__u8 frag_num;
-	__u8 seq_num;
-	__le32 len;
-	/* MUST be of word size due to PIO write requirements */
-	__le32 csum;
-	__le16 csum_offset;
-	__le16 flags;
-	__u16 first_2_bytes;
-	__u8 unused[2];		/* currently unused */
-};
-
-/*
- * The PIO buffer used for sending infinipath messages must only be written
- * in 32-bit words, all the data must be written, and no writes can occur
- * after the last word is written (which transfers "ownership" of the buffer
- * to the chip and triggers the message to be sent).
- * Since the Linux sk_buff structure can be recursive, non-aligned, and
- * any number of bytes in each segment, we use the following structure
- * to keep information about the overall state of the copy operation.
- * This is used to save the information needed to store the checksum
- * in the right place before sending the last word to the hardware and
- * to buffer the last 0-3 bytes of non-word sized segments.
- */
-struct copy_data_s {
-	struct ether_header *hdr;
-	/* addr of PIO buf to write csum to */
-	__u32 __iomem *csum_pio;
-	__u32 __iomem *to;	/* addr of PIO buf to write data to */
-	__u32 device;		/* which device to allocate PIO bufs from */
-	__s32 error;		/* set if there is an error. */
-	__s32 extra;		/* amount of data saved in u.buf below */
-	__u32 len;		/* total length to send in bytes */
-	__u32 flen;		/* frament length in words */
-	__u32 csum;		/* partial IP checksum */
-	__u32 pos;		/* position for partial checksum */
-	__u32 offset;		/* offset to where data currently starts */
-	__s32 checksum_calc;	/* set to 1 when csum has been calculated */
-	struct sk_buff *skb;
-	union {
-		__u32 w;
-		__u8 buf[4];
-	} u;
-};
-
-/* IB - LRH header consts */
-#define IPS_LRH_GRH 0x0003	/* 1. word of IB LRH - next header: GRH */
-#define IPS_LRH_BTH 0x0002	/* 1. word of IB LRH - next header: BTH */
-
-#define IPS_OFFSET  0
-
-/*
- * defines the cut-off point between the header queue and eager/expected
- * TID queue
- */
-#define NUM_OF_EXTRA_WORDS_IN_HEADER_QUEUE \
-	((sizeof(struct ips_message_header) - \
-	  offsetof(struct ips_message_header, iph)) >> 2)
-
-/* OpCodes  */
-#define OPCODE_IPS 0xC0
-#define OPCODE_ITH4X 0xC1
-
-/* OpCode 30 is use by stand-alone test programs  */
-#define OPCODE_RAW_DATA 0xDE
-/* last OpCode (31) is reserved for test  */
-#define OPCODE_TEST 0xDF
-
-/* sub OpCodes - ips  */
-#define OPCODE_SEQ_DATA 0x01
-#define OPCODE_SEQ_CTRL 0x02
-
-#define OPCODE_SEQ_MQ_DATA 0x03
-#define OPCODE_SEQ_MQ_CTRL 0x04
-
-#define OPCODE_ACK 0x10
-#define OPCODE_NAK 0x11
-
-#define OPCODE_ERR_CHK 0x20
-#define OPCODE_ERR_CHK_PLS 0x21
-
-#define OPCODE_STARTUP 0x30
-#define OPCODE_STARTUP_ACK 0x31
-#define OPCODE_STARTUP_NAK 0x32
-
-#define OPCODE_STARTUP_EXT 0x34
-#define OPCODE_STARTUP_ACK_EXT 0x35
-#define OPCODE_STARTUP_NAK_EXT 0x36
-
-#define OPCODE_TIDS_RELEASE 0x40
-#define OPCODE_TIDS_RELEASE_CONFIRM 0x41
-
-#define OPCODE_CLOSE 0x50
-#define OPCODE_CLOSE_ACK 0x51
-/*
- * like OPCODE_CLOSE, but no complaint if other side has already closed.
- * Used when doing abort(), MPI_Abort(), etc.
- */
-#define OPCODE_ABORT 0x52
-
-/* sub OpCodes - ith4x  */
-#define OPCODE_ENCAP 0x81
-#define OPCODE_LID_ARP 0x82
-
-/* Receive Header Queue: receive type (from infinipath) */
-#define RCVHQ_RCV_TYPE_EXPECTED  0
-#define RCVHQ_RCV_TYPE_EAGER     1
-#define RCVHQ_RCV_TYPE_NON_KD    2
-#define RCVHQ_RCV_TYPE_ERROR     3
-
-/* misc. */
-#define SIZE_OF_CRC 1
-
-#define EAGER_TID_ID INFINIPATH_I_TID_MASK
-
-#define IPS_DEFAULT_P_KEY 0xFFFF
-
-#define IPS_PERMISSIVE_LID 0xFFFF
-#define IPS_MULTICAST_LID_BASE 0xC000
-
-#define IPS_AETH_CREDIT_SHIFT 24
-#define IPS_AETH_CREDIT_MASK 0x1F
-#define IPS_AETH_CREDIT_INVAL 0x1F
-
-#define IPS_PSN_MASK 0xFFFFFF
-#define IPS_MSN_MASK 0xFFFFFF
-#define IPS_QPN_MASK 0xFFFFFF
-#define IPS_MULTICAST_QPN 0xFFFFFF
-
-/* functions for extracting fields from rcvhdrq entries */
-static inline __u32 ips_get_hdr_err_flags(const __le32 * rbuf)
-{
-	return __le32_to_cpu(rbuf[1]);
-}
-
-static inline __u32 ips_get_index(const __le32 * rbuf)
-{
-	return (__le32_to_cpu(rbuf[0]) >> INFINIPATH_RHF_EGRINDEX_SHIFT)
-	    & INFINIPATH_RHF_EGRINDEX_MASK;
-}
-
-static inline __u32 ips_get_rcv_type(const __le32 * rbuf)
-{
-	return (__le32_to_cpu(rbuf[0]) >> INFINIPATH_RHF_RCVTYPE_SHIFT)
-	    & INFINIPATH_RHF_RCVTYPE_MASK;
-}
-
-static inline __u32 ips_get_length_in_bytes(const __le32 * rbuf)
-{
-	return ((__le32_to_cpu(rbuf[0]) >> INFINIPATH_RHF_LENGTH_SHIFT)
-		& INFINIPATH_RHF_LENGTH_MASK) << 2;
-}
-
-static inline void *ips_get_first_protocol_header(const __u32 * rbuf)
-{
-	return (void *)&rbuf[2];
-}
-
-static inline struct ips_message_header *ips_get_ips_header(const __u32 *
-							    rbuf)
-{
-	return (struct ips_message_header *)&rbuf[2];
-}
-
-static inline __u32 ips_get_ipath_ver(__le32 hdrword)
-{
-	return (__le32_to_cpu(hdrword) >> INFINIPATH_I_VERS_SHIFT)
-	    & INFINIPATH_I_VERS_MASK;
-}
-
-#endif				/* IPS_COMMON_H */
