Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWI1QBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWI1QBr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbWI1QBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:01:31 -0400
Received: from mx.pathscale.com ([64.160.42.68]:58293 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751594AbWI1QBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:22 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 3 of 28] IB/ipath - driver support for userspace sharing of HW
	contexts
X-Mercurial-Node: 7f5b6127be15cded56e17412c35b36154f119c08
Message-Id: <7f5b6127be15cded56e1.1159459199@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 08:59:59 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This allows multiple userspace processes to share a single hardware
context in a master/slave arrangement.  It is backwards binary compatible
with existing userspace.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 45079acba208 -r 7f5b6127be15 drivers/infiniband/hw/ipath/ipath_common.h
--- a/drivers/infiniband/hw/ipath/ipath_common.h	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_common.h	Thu Sep 28 08:57:12 2006 -0700
@@ -185,6 +185,7 @@ typedef enum _ipath_ureg {
 #define IPATH_RUNTIME_PCIE	0x2
 #define IPATH_RUNTIME_FORCE_WC_ORDER	0x4
 #define IPATH_RUNTIME_RCVHDR_COPY	0x8
+#define IPATH_RUNTIME_MASTER	0x10
 
 /*
  * This structure is returned by ipath_userinit() immediately after
@@ -202,7 +203,8 @@ struct ipath_base_info {
 	/* version of software, for feature checking. */
 	__u32 spi_sw_version;
 	/* InfiniPath port assigned, goes into sent packets */
-	__u32 spi_port;
+	__u16 spi_port;
+	__u16 spi_subport;
 	/*
 	 * IB MTU, packets IB data must be less than this.
 	 * The MTU is in bytes, and will be a multiple of 4 bytes.
@@ -218,7 +220,7 @@ struct ipath_base_info {
 	__u32 spi_tidcnt;
 	/* size of the TID Eager list in infinipath, in entries */
 	__u32 spi_tidegrcnt;
-	/* size of a single receive header queue entry. */
+	/* size of a single receive header queue entry in words. */
 	__u32 spi_rcvhdrent_size;
 	/*
 	 * Count of receive header queue entries allocated.
@@ -310,6 +312,12 @@ struct ipath_base_info {
 	__u32 spi_filler_for_align;
 	/* address of readonly memory copy of the rcvhdrq tail register. */
 	__u64 spi_rcvhdr_tailaddr;
+
+	/* shared memory pages for subports if IPATH_RUNTIME_MASTER is set */
+	__u64 spi_subport_uregbase;
+	__u64 spi_subport_rcvegrbuf;
+	__u64 spi_subport_rcvhdr_base;
+
 } __attribute__ ((aligned(8)));
 
 
@@ -328,12 +336,12 @@ struct ipath_base_info {
 
 /*
  * Minor version differences are always compatible
- * a within a major version, however if if user software is larger
+ * a within a major version, however if user software is larger
  * than driver software, some new features and/or structure fields
  * may not be implemented; the user code must deal with this if it
- * cares, or it must abort after initialization reports the difference
- */
-#define IPATH_USER_SWMINOR 2
+ * cares, or it must abort after initialization reports the difference.
+ */
+#define IPATH_USER_SWMINOR 3
 
 #define IPATH_USER_SWVERSION ((IPATH_USER_SWMAJOR<<16) | IPATH_USER_SWMINOR)
 
@@ -379,7 +387,16 @@ struct ipath_user_info {
 	 */
 	__u32 spu_rcvhdrsize;
 
-	__u64 spu_unused; /* kept for compatible layout */
+	/*
+	 * If two or more processes wish to share a port, each process
+	 * must set the spu_subport_cnt and spu_subport_id to the same
+	 * values.  The only restriction on the spu_subport_id is that
+	 * it be unique for a given node.
+	 */
+	__u16 spu_subport_cnt;
+	__u16 spu_subport_id;
+
+	__u32 spu_unused; /* kept for compatible layout */
 
 	/*
 	 * address of struct base_info to write to
@@ -398,13 +415,17 @@ struct ipath_user_info {
 #define IPATH_CMD_TID_UPDATE	19	/* update expected TID entries */
 #define IPATH_CMD_TID_FREE	20	/* free expected TID entries */
 #define IPATH_CMD_SET_PART_KEY	21	/* add partition key */
-
-#define IPATH_CMD_MAX		21
+#define IPATH_CMD_SLAVE_INFO	22	/* return info on slave processes */
+
+#define IPATH_CMD_MAX		22
 
 struct ipath_port_info {
 	__u32 num_active;	/* number of active units */
 	__u32 unit;		/* unit (chip) assigned to caller */
-	__u32 port;		/* port on unit assigned to caller */
+	__u16 port;		/* port on unit assigned to caller */
+	__u16 subport;		/* subport on unit assigned to caller */
+	__u16 num_ports;	/* number of ports available on unit */
+	__u16 num_subports;	/* number of subport slaves opened on port */
 };
 
 struct ipath_tid_info {
@@ -435,6 +456,8 @@ struct ipath_cmd {
 		__u32 recv_ctrl;
 		/* partition key to set */
 		__u16 part_key;
+		/* user address of __u32 bitmask of active slaves */
+		__u64 slave_mask_addr;
 	} cmd;
 };
 
@@ -596,6 +619,10 @@ struct infinipath_counters {
 
 /* K_PktFlags bits */
 #define INFINIPATH_KPF_INTR 0x1
+#define INFINIPATH_KPF_SUBPORT_MASK 0x3
+#define INFINIPATH_KPF_SUBPORT_SHIFT 1
+
+#define INFINIPATH_MAX_SUBPORT	4
 
 /* SendPIO per-buffer control */
 #define INFINIPATH_SP_TEST    0x40
@@ -610,7 +637,7 @@ struct ipath_header {
 	/*
 	 * Version - 4 bits, Port - 4 bits, TID - 10 bits and Offset -
 	 * 14 bits before ECO change ~28 Dec 03.  After that, Vers 4,
-	 * Port 3, TID 11, offset 14.
+	 * Port 4, TID 11, offset 13.
 	 */
 	__le32 ver_port_tid_offset;
 	__le16 chksum;
diff -r 45079acba208 -r 7f5b6127be15 drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Sep 28 08:57:12 2006 -0700
@@ -1827,9 +1827,9 @@ void ipath_free_pddata(struct ipath_devd
 			dma_free_coherent(&dd->pcidev->dev, size,
 				base, pd->port_rcvegrbuf_phys[e]);
 		}
-		vfree(pd->port_rcvegrbuf);
+		kfree(pd->port_rcvegrbuf);
 		pd->port_rcvegrbuf = NULL;
-		vfree(pd->port_rcvegrbuf_phys);
+		kfree(pd->port_rcvegrbuf_phys);
 		pd->port_rcvegrbuf_phys = NULL;
 		pd->port_rcvegrbuf_chunks = 0;
 	} else if (pd->port_port == 0 && dd->ipath_port0_skbs) {
@@ -1845,6 +1845,9 @@ void ipath_free_pddata(struct ipath_devd
 		vfree(skbs);
 	}
 	kfree(pd->port_tid_pg_list);
+	vfree(pd->subport_uregbase);
+	vfree(pd->subport_rcvegrbuf);
+	vfree(pd->subport_rcvhdr_base);
 	kfree(pd);
 }
 
diff -r 45079acba208 -r 7f5b6127be15 drivers/infiniband/hw/ipath/ipath_file_ops.c
--- a/drivers/infiniband/hw/ipath/ipath_file_ops.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_file_ops.c	Thu Sep 28 08:57:12 2006 -0700
@@ -41,6 +41,12 @@
 #include "ipath_kernel.h"
 #include "ipath_common.h"
 
+/*
+ * mmap64 doesn't allow all 64 bits for 32-bit applications
+ * so only use the low 43 bits.
+ */
+#define MMAP64_MASK	0x7FFFFFFFFFFUL
+
 static int ipath_open(struct inode *, struct file *);
 static int ipath_close(struct inode *, struct file *);
 static ssize_t ipath_write(struct file *, const char __user *, size_t,
@@ -57,18 +63,35 @@ static struct file_operations ipath_file
 	.mmap = ipath_mmap
 };
 
-static int ipath_get_base_info(struct ipath_portdata *pd,
+static int ipath_get_base_info(struct file *fp,
 			       void __user *ubase, size_t ubase_size)
 {
+	struct ipath_portdata *pd = port_fp(fp);
 	int ret = 0;
 	struct ipath_base_info *kinfo = NULL;
 	struct ipath_devdata *dd = pd->port_dd;
-
-	if (ubase_size < sizeof(*kinfo)) {
+	unsigned subport_cnt;
+	int shared, master;
+	size_t sz;
+
+	subport_cnt = pd->port_subport_cnt;
+	if (!subport_cnt) {
+		shared = 0;
+		master = 0;
+		subport_cnt = 1;
+	} else {
+		shared = 1;
+		master = !subport_fp(fp);
+	}
+
+	sz = sizeof(*kinfo);
+	/* If port sharing is not requested, allow the old size structure */
+	if (!shared)
+		sz -= 3 * sizeof(u64);
+	if (ubase_size < sz) {
 		ipath_cdbg(PROC,
-			   "Base size %lu, need %lu (version mismatch?)\n",
-			   (unsigned long) ubase_size,
-			   (unsigned long) sizeof(*kinfo));
+			   "Base size %zu, need %zu (version mismatch?)\n",
+			   ubase_size, sz);
 		ret = -EINVAL;
 		goto bail;
 	}
@@ -95,7 +118,9 @@ static int ipath_get_base_info(struct ip
 	kinfo->spi_rcv_egrperchunk = pd->port_rcvegrbufs_perchunk;
 	kinfo->spi_rcv_egrchunksize = kinfo->spi_rcv_egrbuftotlen /
 		pd->port_rcvegrbuf_chunks;
-	kinfo->spi_tidcnt = dd->ipath_rcvtidcnt;
+	kinfo->spi_tidcnt = dd->ipath_rcvtidcnt / subport_cnt;
+	if (master)
+		kinfo->spi_tidcnt += dd->ipath_rcvtidcnt % subport_cnt;
 	/*
 	 * for this use, may be ipath_cfgports summed over all chips that
 	 * are are configured and present
@@ -118,30 +143,75 @@ static int ipath_get_base_info(struct ip
 	 * page_address() macro worked, but in 2.6.11, even that returns the
 	 * full 64 bit address (upper bits all 1's).  So far, using the
 	 * physical addresses (or chip offsets, for chip mapping) works, but
-	 * no doubt some future kernel release will chang that, and we'll be
-	 * on to yet another method of dealing with this
+	 * no doubt some future kernel release will change that, and we'll be
+	 * on to yet another method of dealing with this.
 	 */
 	kinfo->spi_rcvhdr_base = (u64) pd->port_rcvhdrq_phys;
-	kinfo->spi_rcvhdr_tailaddr = (u64)pd->port_rcvhdrqtailaddr_phys;
+	kinfo->spi_rcvhdr_tailaddr = (u64) pd->port_rcvhdrqtailaddr_phys;
 	kinfo->spi_rcv_egrbufs = (u64) pd->port_rcvegr_phys;
 	kinfo->spi_pioavailaddr = (u64) dd->ipath_pioavailregs_phys;
 	kinfo->spi_status = (u64) kinfo->spi_pioavailaddr +
 		(void *) dd->ipath_statusp -
 		(void *) dd->ipath_pioavailregs_dma;
-	kinfo->spi_piobufbase = (u64) pd->port_piobufs;
-	kinfo->__spi_uregbase =
-		dd->ipath_uregbase + dd->ipath_palign * pd->port_port;
-
-	kinfo->spi_pioindex = dd->ipath_pbufsport * (pd->port_port - 1);
-	kinfo->spi_piocnt = dd->ipath_pbufsport;
+	if (!shared) {
+		kinfo->spi_piocnt = dd->ipath_pbufsport;
+		kinfo->spi_piobufbase = (u64) pd->port_piobufs;
+		kinfo->__spi_uregbase = (u64) dd->ipath_uregbase +
+			dd->ipath_palign * pd->port_port;
+	} else if (master) {
+		kinfo->spi_piocnt = (dd->ipath_pbufsport / subport_cnt) +
+				    (dd->ipath_pbufsport % subport_cnt);
+		/* Master's PIO buffers are after all the slave's */
+		kinfo->spi_piobufbase = (u64) pd->port_piobufs +
+			dd->ipath_palign *
+			(dd->ipath_pbufsport - kinfo->spi_piocnt);
+		kinfo->__spi_uregbase = (u64) dd->ipath_uregbase +
+			dd->ipath_palign * pd->port_port;
+	} else {
+		unsigned slave = subport_fp(fp) - 1;
+
+		kinfo->spi_piocnt = dd->ipath_pbufsport / subport_cnt;
+		kinfo->spi_piobufbase = (u64) pd->port_piobufs +
+			dd->ipath_palign * kinfo->spi_piocnt * slave;
+		kinfo->__spi_uregbase = ((u64) pd->subport_uregbase +
+			PAGE_SIZE * slave) & MMAP64_MASK;
+
+		kinfo->spi_rcvhdr_base = ((u64) pd->subport_rcvhdr_base +
+			pd->port_rcvhdrq_size * slave) & MMAP64_MASK;
+		kinfo->spi_rcvhdr_tailaddr =
+			(u64) pd->port_rcvhdrqtailaddr_phys & MMAP64_MASK;
+		kinfo->spi_rcv_egrbufs = ((u64) pd->subport_rcvegrbuf +
+			dd->ipath_rcvegrcnt * dd->ipath_rcvegrbufsize * slave) &
+			MMAP64_MASK;
+	}
+
+	kinfo->spi_pioindex = (kinfo->spi_piobufbase - dd->ipath_piobufbase) /
+		dd->ipath_palign;
 	kinfo->spi_pioalign = dd->ipath_palign;
 
 	kinfo->spi_qpair = IPATH_KD_QP;
 	kinfo->spi_piosize = dd->ipath_ibmaxlen;
 	kinfo->spi_mtu = dd->ipath_ibmaxlen;	/* maxlen, not ibmtu */
 	kinfo->spi_port = pd->port_port;
+	kinfo->spi_subport = subport_fp(fp);
 	kinfo->spi_sw_version = IPATH_KERN_SWVERSION;
 	kinfo->spi_hw_version = dd->ipath_revision;
+
+	if (master) {
+		kinfo->spi_runtime_flags |= IPATH_RUNTIME_MASTER;
+		kinfo->spi_subport_uregbase =
+			(u64) pd->subport_uregbase & MMAP64_MASK;
+		kinfo->spi_subport_rcvegrbuf =
+			(u64) pd->subport_rcvegrbuf & MMAP64_MASK;
+		kinfo->spi_subport_rcvhdr_base =
+			(u64) pd->subport_rcvhdr_base & MMAP64_MASK;
+		ipath_cdbg(PROC, "port %u flags %x %llx %llx %llx\n",
+			kinfo->spi_port,
+			kinfo->spi_runtime_flags,
+			kinfo->spi_subport_uregbase,
+			kinfo->spi_subport_rcvegrbuf,
+			kinfo->spi_subport_rcvhdr_base);
+	}
 
 	if (copy_to_user(ubase, kinfo, sizeof(*kinfo)))
 		ret = -EFAULT;
@@ -154,6 +224,7 @@ bail:
 /**
  * ipath_tid_update - update a port TID
  * @pd: the port
+ * @fp: the ipath device file
  * @ti: the TID information
  *
  * The new implementation as of Oct 2004 is that the driver assigns
@@ -176,11 +247,11 @@ bail:
  * virtually contiguous pages, that should change to improve
  * performance.
  */
-static int ipath_tid_update(struct ipath_portdata *pd,
+static int ipath_tid_update(struct ipath_portdata *pd, struct file *fp,
 			    const struct ipath_tid_info *ti)
 {
 	int ret = 0, ntids;
-	u32 tid, porttid, cnt, i, tidcnt;
+	u32 tid, porttid, cnt, i, tidcnt, tidoff;
 	u16 *tidlist;
 	struct ipath_devdata *dd = pd->port_dd;
 	u64 physaddr;
@@ -188,6 +259,7 @@ static int ipath_tid_update(struct ipath
 	u64 __iomem *tidbase;
 	unsigned long tidmap[8];
 	struct page **pagep = NULL;
+	unsigned subport = subport_fp(fp);
 
 	if (!dd->ipath_pageshadow) {
 		ret = -ENOMEM;
@@ -204,20 +276,34 @@ static int ipath_tid_update(struct ipath
 		ret = -EFAULT;
 		goto done;
 	}
-	tidcnt = dd->ipath_rcvtidcnt;
-	if (cnt >= tidcnt) {
+	porttid = pd->port_port * dd->ipath_rcvtidcnt;
+	if (!pd->port_subport_cnt) {
+		tidcnt = dd->ipath_rcvtidcnt;
+		tid = pd->port_tidcursor;
+		tidoff = 0;
+	} else if (!subport) {
+		tidcnt = (dd->ipath_rcvtidcnt / pd->port_subport_cnt) +
+			 (dd->ipath_rcvtidcnt % pd->port_subport_cnt);
+		tidoff = dd->ipath_rcvtidcnt - tidcnt;
+		porttid += tidoff;
+		tid = tidcursor_fp(fp);
+	} else {
+		tidcnt = dd->ipath_rcvtidcnt / pd->port_subport_cnt;
+		tidoff = tidcnt * (subport - 1);
+		porttid += tidoff;
+		tid = tidcursor_fp(fp);
+	}
+	if (cnt > tidcnt) {
 		/* make sure it all fits in port_tid_pg_list */
 		dev_info(&dd->pcidev->dev, "Process tried to allocate %u "
 			 "TIDs, only trying max (%u)\n", cnt, tidcnt);
 		cnt = tidcnt;
 	}
-	pagep = (struct page **)pd->port_tid_pg_list;
-	tidlist = (u16 *) (&pagep[cnt]);
+	pagep = &((struct page **) pd->port_tid_pg_list)[tidoff];
+	tidlist = &((u16 *) &pagep[dd->ipath_rcvtidcnt])[tidoff];
 
 	memset(tidmap, 0, sizeof(tidmap));
-	tid = pd->port_tidcursor;
 	/* before decrement; chip actual # */
-	porttid = pd->port_port * tidcnt;
 	ntids = tidcnt;
 	tidbase = (u64 __iomem *) (((char __iomem *) dd->ipath_kregbase) +
 				   dd->ipath_rcvtidbase +
@@ -274,9 +360,9 @@ static int ipath_tid_update(struct ipath
 			ret = -ENOMEM;
 			break;
 		}
-		tidlist[i] = tid;
+		tidlist[i] = tid + tidoff;
 		ipath_cdbg(VERBOSE, "Updating idx %u to TID %u, "
-			   "vaddr %lx\n", i, tid, vaddr);
+			   "vaddr %lx\n", i, tid + tidoff, vaddr);
 		/* we "know" system pages and TID pages are same size */
 		dd->ipath_pageshadow[porttid + tid] = pagep[i];
 		/*
@@ -341,7 +427,10 @@ static int ipath_tid_update(struct ipath
 		}
 		if (tid == tidcnt)
 			tid = 0;
-		pd->port_tidcursor = tid;
+		if (!pd->port_subport_cnt)
+			pd->port_tidcursor = tid;
+		else
+			tidcursor_fp(fp) = tid;
 	}
 
 done:
@@ -354,6 +443,7 @@ done:
 /**
  * ipath_tid_free - free a port TID
  * @pd: the port
+ * @subport: the subport
  * @ti: the TID info
  *
  * right now we are unlocking one page at a time, but since
@@ -367,7 +457,7 @@ done:
  * they pass in to us.
  */
 
-static int ipath_tid_free(struct ipath_portdata *pd,
+static int ipath_tid_free(struct ipath_portdata *pd, unsigned subport,
 			  const struct ipath_tid_info *ti)
 {
 	int ret = 0;
@@ -388,11 +478,20 @@ static int ipath_tid_free(struct ipath_p
 	}
 
 	porttid = pd->port_port * dd->ipath_rcvtidcnt;
+	if (!pd->port_subport_cnt)
+		tidcnt = dd->ipath_rcvtidcnt;
+	else if (!subport) {
+		tidcnt = (dd->ipath_rcvtidcnt / pd->port_subport_cnt) +
+			 (dd->ipath_rcvtidcnt % pd->port_subport_cnt);
+		porttid += dd->ipath_rcvtidcnt - tidcnt;
+	} else {
+		tidcnt = dd->ipath_rcvtidcnt / pd->port_subport_cnt;
+		porttid += tidcnt * (subport - 1);
+	}
 	tidbase = (u64 __iomem *) ((char __iomem *)(dd->ipath_kregbase) +
 				   dd->ipath_rcvtidbase +
 				   porttid * sizeof(*tidbase));
 
-	tidcnt = dd->ipath_rcvtidcnt;
 	limit = sizeof(tidmap) * BITS_PER_BYTE;
 	if (limit > tidcnt)
 		/* just in case size changes in future */
@@ -581,20 +680,24 @@ bail:
 /**
  * ipath_manage_rcvq - manage a port's receive queue
  * @pd: the port
+ * @subport: the subport
  * @start_stop: action to carry out
  *
  * start_stop == 0 disables receive on the port, for use in queue
  * overflow conditions.  start_stop==1 re-enables, to be used to
  * re-init the software copy of the head register
  */
-static int ipath_manage_rcvq(struct ipath_portdata *pd, int start_stop)
+static int ipath_manage_rcvq(struct ipath_portdata *pd, unsigned subport,
+			     int start_stop)
 {
 	struct ipath_devdata *dd = pd->port_dd;
 	u64 tval;
 
-	ipath_cdbg(PROC, "%sabling rcv for unit %u port %u\n",
+	ipath_cdbg(PROC, "%sabling rcv for unit %u port %u:%u\n",
 		   start_stop ? "en" : "dis", dd->ipath_unit,
-		   pd->port_port);
+		   pd->port_port, subport);
+	if (subport)
+		goto bail;
 	/* atomically clear receive enable port. */
 	if (start_stop) {
 		/*
@@ -630,6 +733,7 @@ static int ipath_manage_rcvq(struct ipat
 		tval = ipath_read_ureg32(dd, ur_rcvhdrtail, pd->port_port);
 	}
 	/* always; new head should be equal to new tail; see above */
+bail:
 	return 0;
 }
 
@@ -687,6 +791,36 @@ static void ipath_clean_part_key(struct 
 	}
 }
 
+/*
+ * Initialize the port data with the receive buffer sizes
+ * so this can be done while the master port is locked.
+ * Otherwise, there is a race with a slave opening the port
+ * and seeing these fields uninitialized.
+ */
+static void init_user_egr_sizes(struct ipath_portdata *pd)
+{
+	struct ipath_devdata *dd = pd->port_dd;
+	unsigned egrperchunk, egrcnt, size;
+
+	/*
+	 * to avoid wasting a lot of memory, we allocate 32KB chunks of
+	 * physically contiguous memory, advance through it until used up
+	 * and then allocate more.  Of course, we need memory to store those
+	 * extra pointers, now.  Started out with 256KB, but under heavy
+	 * memory pressure (creating large files and then copying them over
+	 * NFS while doing lots of MPI jobs), we hit some allocation
+	 * failures, even though we can sleep...  (2.6.10) Still get
+	 * failures at 64K.  32K is the lowest we can go without wasting
+	 * additional memory.
+	 */
+	size = 0x8000;
+	egrperchunk = size / dd->ipath_rcvegrbufsize;
+	egrcnt = dd->ipath_rcvegrcnt;
+	pd->port_rcvegrbuf_chunks = (egrcnt + egrperchunk - 1) / egrperchunk;
+	pd->port_rcvegrbufs_perchunk = egrperchunk;
+	pd->port_rcvegrbuf_size = size;
+}
+
 /**
  * ipath_create_user_egr - allocate eager TID buffers
  * @pd: the port to allocate TID buffers for
@@ -702,7 +836,7 @@ static int ipath_create_user_egr(struct 
 static int ipath_create_user_egr(struct ipath_portdata *pd)
 {
 	struct ipath_devdata *dd = pd->port_dd;
-	unsigned e, egrcnt, alloced, egrperchunk, chunk, egrsize, egroff;
+	unsigned e, egrcnt, egrperchunk, chunk, egrsize, egroff;
 	size_t size;
 	int ret;
 	gfp_t gfp_flags;
@@ -722,31 +856,18 @@ static int ipath_create_user_egr(struct 
 	ipath_cdbg(VERBOSE, "Allocating %d egr buffers, at egrtid "
 		   "offset %x, egrsize %u\n", egrcnt, egroff, egrsize);
 
-	/*
-	 * to avoid wasting a lot of memory, we allocate 32KB chunks of
-	 * physically contiguous memory, advance through it until used up
-	 * and then allocate more.  Of course, we need memory to store those
-	 * extra pointers, now.  Started out with 256KB, but under heavy
-	 * memory pressure (creating large files and then copying them over
-	 * NFS while doing lots of MPI jobs), we hit some allocation
-	 * failures, even though we can sleep...  (2.6.10) Still get
-	 * failures at 64K.  32K is the lowest we can go without wasting
-	 * additional memory.
-	 */
-	size = 0x8000;
-	alloced = ALIGN(egrsize * egrcnt, size);
-	egrperchunk = size / egrsize;
-	chunk = (egrcnt + egrperchunk - 1) / egrperchunk;
-	pd->port_rcvegrbuf_chunks = chunk;
-	pd->port_rcvegrbufs_perchunk = egrperchunk;
-	pd->port_rcvegrbuf_size = size;
-	pd->port_rcvegrbuf = vmalloc(chunk * sizeof(pd->port_rcvegrbuf[0]));
+	chunk = pd->port_rcvegrbuf_chunks;
+	egrperchunk = pd->port_rcvegrbufs_perchunk;
+	size = pd->port_rcvegrbuf_size;
+	pd->port_rcvegrbuf = kmalloc(chunk * sizeof(pd->port_rcvegrbuf[0]),
+				     GFP_KERNEL);
 	if (!pd->port_rcvegrbuf) {
 		ret = -ENOMEM;
 		goto bail;
 	}
 	pd->port_rcvegrbuf_phys =
-		vmalloc(chunk * sizeof(pd->port_rcvegrbuf_phys[0]));
+		kmalloc(chunk * sizeof(pd->port_rcvegrbuf_phys[0]),
+			GFP_KERNEL);
 	if (!pd->port_rcvegrbuf_phys) {
 		ret = -ENOMEM;
 		goto bail_rcvegrbuf;
@@ -791,94 +912,12 @@ bail_rcvegrbuf_phys:
 				  pd->port_rcvegrbuf_phys[e]);
 
 	}
-	vfree(pd->port_rcvegrbuf_phys);
+	kfree(pd->port_rcvegrbuf_phys);
 	pd->port_rcvegrbuf_phys = NULL;
 bail_rcvegrbuf:
-	vfree(pd->port_rcvegrbuf);
+	kfree(pd->port_rcvegrbuf);
 	pd->port_rcvegrbuf = NULL;
 bail:
-	return ret;
-}
-
-static int ipath_do_user_init(struct ipath_portdata *pd,
-			      const struct ipath_user_info *uinfo)
-{
-	int ret = 0;
-	struct ipath_devdata *dd = pd->port_dd;
-	u32 head32;
-
-	/* for now, if major version is different, bail */
-	if ((uinfo->spu_userversion >> 16) != IPATH_USER_SWMAJOR) {
-		dev_info(&dd->pcidev->dev,
-			 "User major version %d not same as driver "
-			 "major %d\n", uinfo->spu_userversion >> 16,
-			 IPATH_USER_SWMAJOR);
-		ret = -ENODEV;
-		goto done;
-	}
-
-	if ((uinfo->spu_userversion & 0xffff) != IPATH_USER_SWMINOR)
-		ipath_dbg("User minor version %d not same as driver "
-			  "minor %d\n", uinfo->spu_userversion & 0xffff,
-			  IPATH_USER_SWMINOR);
-
-	if (uinfo->spu_rcvhdrsize) {
-		ret = ipath_setrcvhdrsize(dd, uinfo->spu_rcvhdrsize);
-		if (ret)
-			goto done;
-	}
-
-	/* for now we do nothing with rcvhdrcnt: uinfo->spu_rcvhdrcnt */
-
-	/* for right now, kernel piobufs are at end, so port 1 is at 0 */
-	pd->port_piobufs = dd->ipath_piobufbase +
-		dd->ipath_pbufsport * (pd->port_port -
-				       1) * dd->ipath_palign;
-	ipath_cdbg(VERBOSE, "Set base of piobufs for port %u to 0x%x\n",
-		   pd->port_port, pd->port_piobufs);
-
-	/*
-	 * Now allocate the rcvhdr Q and eager TIDs; skip the TID
-	 * array for time being.  If pd->port_port > chip-supported,
-	 * we need to do extra stuff here to handle by handling overflow
-	 * through port 0, someday
-	 */
-	ret = ipath_create_rcvhdrq(dd, pd);
-	if (!ret)
-		ret = ipath_create_user_egr(pd);
-	if (ret)
-		goto done;
-
-	/*
-	 * set the eager head register for this port to the current values
-	 * of the tail pointers, since we don't know if they were
-	 * updated on last use of the port.
-	 */
-	head32 = ipath_read_ureg32(dd, ur_rcvegrindextail, pd->port_port);
-	ipath_write_ureg(dd, ur_rcvegrindexhead, head32, pd->port_port);
-	dd->ipath_lastegrheads[pd->port_port] = -1;
-	dd->ipath_lastrcvhdrqtails[pd->port_port] = -1;
-	ipath_cdbg(VERBOSE, "Wrote port%d egrhead %x from tail regs\n",
-		pd->port_port, head32);
-	pd->port_tidcursor = 0;	/* start at beginning after open */
-	/*
-	 * now enable the port; the tail registers will be written to memory
-	 * by the chip as soon as it sees the write to
-	 * dd->ipath_kregs->kr_rcvctrl.  The update only happens on
-	 * transition from 0 to 1, so clear it first, then set it as part of
-	 * enabling the port.  This will (very briefly) affect any other
-	 * open ports, but it shouldn't be long enough to be an issue.
-	 * We explictly set the in-memory copy to 0 beforehand, so we don't
-	 * have to wait to be sure the DMA update has happened.
-	 */
-	*pd->port_rcvhdrtail_kvaddr = 0ULL;
-	set_bit(INFINIPATH_R_PORTENABLE_SHIFT + pd->port_port,
-		&dd->ipath_rcvctrl);
-	ipath_write_kreg(dd, dd->ipath_kregs->kr_rcvctrl,
-			 dd->ipath_rcvctrl & ~INFINIPATH_R_TAILUPD);
-	ipath_write_kreg(dd, dd->ipath_kregs->kr_rcvctrl,
-			 dd->ipath_rcvctrl);
-done:
 	return ret;
 }
 
@@ -957,7 +996,8 @@ static int mmap_ureg(struct vm_area_stru
 
 static int mmap_piobufs(struct vm_area_struct *vma,
 			struct ipath_devdata *dd,
-			struct ipath_portdata *pd)
+			struct ipath_portdata *pd,
+			unsigned piobufs, unsigned piocnt)
 {
 	unsigned long phys;
 	int ret;
@@ -968,16 +1008,15 @@ static int mmap_piobufs(struct vm_area_s
 	 * process data, and catches users who might try to read the i/o
 	 * space due to a bug.
 	 */
-	if ((vma->vm_end - vma->vm_start) >
-	    (dd->ipath_pbufsport * dd->ipath_palign)) {
+	if ((vma->vm_end - vma->vm_start) > (piocnt * dd->ipath_palign)) {
 		dev_info(&dd->pcidev->dev, "FAIL mmap piobufs: "
 			 "reqlen %lx > PAGE\n",
 			 vma->vm_end - vma->vm_start);
-		ret = -EFAULT;
-		goto bail;
-	}
-
-	phys = dd->ipath_physaddr + pd->port_piobufs;
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	phys = dd->ipath_physaddr + piobufs;
 
 	/*
 	 * Don't mark this as non-cached, or we don't get the
@@ -1021,7 +1060,7 @@ static int mmap_rcvegrbufs(struct vm_are
 			 "reqlen %lx > actual %lx\n",
 			 vma->vm_end - vma->vm_start,
 			 (unsigned long) total_size);
-		ret = -EFAULT;
+		ret = -EINVAL;
 		goto bail;
 	}
 
@@ -1043,6 +1082,122 @@ static int mmap_rcvegrbufs(struct vm_are
 		if (ret < 0)
 			goto bail;
 	}
+	ret = 0;
+
+bail:
+	return ret;
+}
+
+/*
+ * ipath_file_vma_nopage - handle a VMA page fault.
+ */
+static struct page *ipath_file_vma_nopage(struct vm_area_struct *vma,
+					  unsigned long address, int *type)
+{
+	unsigned long offset = address - vma->vm_start;
+	struct page *page = NOPAGE_SIGBUS;
+	void *pageptr;
+
+	/*
+	 * Convert the vmalloc address into a struct page.
+	 */
+	pageptr = (void *)(offset + (vma->vm_pgoff << PAGE_SHIFT));
+	page = vmalloc_to_page(pageptr);
+	if (!page)
+		goto out;
+
+	/* Increment the reference count. */
+	get_page(page);
+	if (type)
+		*type = VM_FAULT_MINOR;
+out:
+	return page;
+}
+
+static struct vm_operations_struct ipath_file_vm_ops = {
+	.nopage = ipath_file_vma_nopage,
+};
+
+static int mmap_kvaddr(struct vm_area_struct *vma, u64 pgaddr,
+		       struct ipath_portdata *pd, unsigned subport)
+{
+	unsigned long len;
+	struct ipath_devdata *dd;
+	void *addr;
+	size_t size;
+	int ret;
+
+	/* If the port is not shared, all addresses should be physical */
+	if (!pd->port_subport_cnt) {
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	dd = pd->port_dd;
+	size = pd->port_rcvegrbuf_chunks * pd->port_rcvegrbuf_size;
+
+	/*
+	 * Master has all the slave uregbase, rcvhdrq, and
+	 * rcvegrbufs mmapped.
+	 */
+	if (subport == 0) {
+		unsigned num_slaves = pd->port_subport_cnt - 1;
+
+		if (pgaddr == ((u64) pd->subport_uregbase & MMAP64_MASK)) {
+			addr = pd->subport_uregbase;
+			size = PAGE_SIZE * num_slaves;
+		} else if (pgaddr == ((u64) pd->subport_rcvhdr_base &
+				      MMAP64_MASK)) {
+			addr = pd->subport_rcvhdr_base;
+			size = pd->port_rcvhdrq_size * num_slaves;
+		} else if (pgaddr == ((u64) pd->subport_rcvegrbuf &
+				      MMAP64_MASK)) {
+			addr = pd->subport_rcvegrbuf;
+			size *= num_slaves;
+		} else {
+			ret = -EINVAL;
+			goto bail;
+		}
+	} else if (pgaddr == (((u64) pd->subport_uregbase +
+			       PAGE_SIZE * (subport - 1)) & MMAP64_MASK)) {
+		addr = pd->subport_uregbase + PAGE_SIZE * (subport - 1);
+		size = PAGE_SIZE;
+	} else if (pgaddr == (((u64) pd->subport_rcvhdr_base +
+			       pd->port_rcvhdrq_size * (subport - 1)) &
+			      MMAP64_MASK)) {
+		addr = pd->subport_rcvhdr_base +
+			pd->port_rcvhdrq_size * (subport - 1);
+		size = pd->port_rcvhdrq_size;
+	} else if (pgaddr == (((u64) pd->subport_rcvegrbuf +
+			       size * (subport - 1)) & MMAP64_MASK)) {
+		addr = pd->subport_rcvegrbuf + size * (subport - 1);
+		/* rcvegrbufs are read-only on the slave */
+		if (vma->vm_flags & VM_WRITE) {
+			dev_info(&dd->pcidev->dev,
+				 "Can't map eager buffers as "
+				 "writable (flags=%lx)\n", vma->vm_flags);
+			ret = -EPERM;
+			goto bail;
+		}
+		/*
+		 * Don't allow permission to later change to writeable
+		 * with mprotect.
+		 */
+		vma->vm_flags &= ~VM_MAYWRITE;
+	} else {
+		ret = -EINVAL;
+		goto bail;
+	}
+	len = vma->vm_end - vma->vm_start;
+	if (len > size) {
+		ipath_cdbg(MM, "FAIL: reqlen %lx > %zx\n", len, size);
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	vma->vm_pgoff = (unsigned long) addr >> PAGE_SHIFT;
+	vma->vm_ops = &ipath_file_vm_ops;
+	vma->vm_flags |= VM_RESERVED | VM_DONTEXPAND;
 	ret = 0;
 
 bail:
@@ -1064,73 +1219,99 @@ static int ipath_mmap(struct file *fp, s
 	struct ipath_portdata *pd;
 	struct ipath_devdata *dd;
 	u64 pgaddr, ureg;
+	unsigned piobufs, piocnt;
 	int ret;
 
 	pd = port_fp(fp);
+	if (!pd) {
+		ret = -EINVAL;
+		goto bail;
+	}
 	dd = pd->port_dd;
 
 	/*
 	 * This is the ipath_do_user_init() code, mapping the shared buffers
 	 * into the user process. The address referred to by vm_pgoff is the
-	 * virtual, not physical, address; we only do one mmap for each
-	 * space mapped.
+	 * file offset passed via mmap().  For shared ports, this is the
+	 * kernel vmalloc() address of the pages to share with the master.
+	 * For non-shared or master ports, this is a physical address.
+	 * We only do one mmap for each space mapped.
 	 */
 	pgaddr = vma->vm_pgoff << PAGE_SHIFT;
 
 	/*
-	 * Must fit in 40 bits for our hardware; some checked elsewhere,
-	 * but we'll be paranoid.  Check for 0 is mostly in case one of the
-	 * allocations failed, but user called mmap anyway.   We want to catch
-	 * that before it can match.
+	 * Check for 0 in case one of the allocations failed, but user
+	 * called mmap anyway.
 	 */
-	if (!pgaddr || pgaddr >= (1ULL<<40))  {
-		ipath_dev_err(dd, "Bad phys addr %llx, start %lx, end %lx\n",
-			(unsigned long long)pgaddr, vma->vm_start, vma->vm_end);
-		return -EINVAL;
-	}
-
-	/* just the offset of the port user registers, not physical addr */
-	ureg = dd->ipath_uregbase + dd->ipath_palign * pd->port_port;
-
-	ipath_cdbg(MM, "ushare: pgaddr %llx vm_start=%lx, vmlen %lx\n",
+	if (!pgaddr)  {
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	ipath_cdbg(MM, "pgaddr %llx vm_start=%lx len %lx port %u:%u:%u\n",
 		   (unsigned long long) pgaddr, vma->vm_start,
-		   vma->vm_end - vma->vm_start);
-
-	if (vma->vm_start & (PAGE_SIZE-1)) {
-		ipath_dev_err(dd,
-			"vm_start not aligned: %lx, end=%lx phys %lx\n",
-			vma->vm_start, vma->vm_end, (unsigned long)pgaddr);
+		   vma->vm_end - vma->vm_start, dd->ipath_unit,
+		   pd->port_port, subport_fp(fp));
+
+	/*
+	 * Physical addresses must fit in 40 bits for our hardware.
+	 * Check for kernel virtual addresses first, anything else must
+	 * match a HW or memory address.
+	 */
+	if (pgaddr >= (1ULL<<40)) {
+		ret = mmap_kvaddr(vma, pgaddr, pd, subport_fp(fp));
+		goto bail;
+	}
+
+	if (!pd->port_subport_cnt) {
+		/* port is not shared */
+		ureg = dd->ipath_uregbase + dd->ipath_palign * pd->port_port;
+		piocnt = dd->ipath_pbufsport;
+		piobufs = pd->port_piobufs;
+	} else if (!subport_fp(fp)) {
+		/* caller is the master */
+		ureg = dd->ipath_uregbase + dd->ipath_palign * pd->port_port;
+		piocnt = (dd->ipath_pbufsport / pd->port_subport_cnt) +
+			 (dd->ipath_pbufsport % pd->port_subport_cnt);
+		piobufs = pd->port_piobufs +
+			dd->ipath_palign * (dd->ipath_pbufsport - piocnt);
+	} else {
+		unsigned slave = subport_fp(fp) - 1;
+
+		/* caller is a slave */
+		ureg = 0;
+		piocnt = dd->ipath_pbufsport / pd->port_subport_cnt;
+		piobufs = pd->port_piobufs + dd->ipath_palign * piocnt * slave;
+	}
+
+	if (pgaddr == ureg)
+		ret = mmap_ureg(vma, dd, ureg);
+	else if (pgaddr == piobufs)
+		ret = mmap_piobufs(vma, dd, pd, piobufs, piocnt);
+	else if (pgaddr == dd->ipath_pioavailregs_phys)
+		/* in-memory copy of pioavail registers */
+		ret = ipath_mmap_mem(vma, pd, PAGE_SIZE, 0,
+			      	     dd->ipath_pioavailregs_phys,
+				     "pioavail registers");
+	else if (subport_fp(fp))
+		/* Subports don't mmap the physical receive buffers */
 		ret = -EINVAL;
-	}
-	else if (pgaddr == ureg)
-		ret = mmap_ureg(vma, dd, ureg);
-	else if (pgaddr == pd->port_piobufs)
-		ret = mmap_piobufs(vma, dd, pd);
-	else if (pgaddr == (u64) pd->port_rcvegr_phys)
+	else if (pgaddr == pd->port_rcvegr_phys)
 		ret = mmap_rcvegrbufs(vma, pd);
-	else if (pgaddr == (u64) pd->port_rcvhdrq_phys) {
+	else if (pgaddr == (u64) pd->port_rcvhdrq_phys)
 		/*
 		 * The rcvhdrq itself; readonly except on HT (so have
 		 * to allow writable mapping), multiple pages, contiguous
 		 * from an i/o perspective.
 		 */
-		unsigned total_size =
-			ALIGN(dd->ipath_rcvhdrcnt * dd->ipath_rcvhdrentsize
-			   * sizeof(u32), PAGE_SIZE);
-		ret = ipath_mmap_mem(vma, pd, total_size, 1,
+		ret = ipath_mmap_mem(vma, pd, pd->port_rcvhdrq_size, 1,
 				     pd->port_rcvhdrq_phys,
 				     "rcvhdrq");
-	}
-	else if (pgaddr == (u64)pd->port_rcvhdrqtailaddr_phys)
+	else if (pgaddr == (u64) pd->port_rcvhdrqtailaddr_phys)
 		/* in-memory copy of rcvhdrq tail register */
 		ret = ipath_mmap_mem(vma, pd, PAGE_SIZE, 0,
 				     pd->port_rcvhdrqtailaddr_phys,
 				     "rcvhdrq tail");
-	else if (pgaddr == dd->ipath_pioavailregs_phys)
-		/* in-memory copy of pioavail registers */
-		ret = ipath_mmap_mem(vma, pd, PAGE_SIZE, 0,
-				     dd->ipath_pioavailregs_phys,
-				     "pioavail registers");
 	else
 		ret = -EINVAL;
 
@@ -1138,9 +1319,10 @@ static int ipath_mmap(struct file *fp, s
 
 	if (ret < 0)
 		dev_info(&dd->pcidev->dev,
-			 "Failure %d on addr %lx, off %lx\n",
-			 -ret, vma->vm_start, vma->vm_pgoff);
-
+			 "Failure %d on off %llx len %lx\n",
+			 -ret, (unsigned long long)pgaddr,
+			 vma->vm_end - vma->vm_start);
+bail:
 	return ret;
 }
 
@@ -1154,6 +1336,8 @@ static unsigned int ipath_poll(struct fi
 	struct ipath_devdata *dd;
 
 	pd = port_fp(fp);
+	if (!pd)
+		goto bail;
 	dd = pd->port_dd;
 
 	bit = pd->port_port + INFINIPATH_R_INTRAVAIL_SHIFT;
@@ -1176,7 +1360,7 @@ static unsigned int ipath_poll(struct fi
 
 	if (tail == head) {
 		set_bit(IPATH_PORT_WAITING_RCV, &pd->port_flag);
-		if(dd->ipath_rhdrhead_intr_off) /* arm rcv interrupt */
+		if (dd->ipath_rhdrhead_intr_off) /* arm rcv interrupt */
 			(void)ipath_write_ureg(dd, ur_rcvhdrhead,
 					       dd->ipath_rhdrhead_intr_off
 					       | head, pd->port_port);
@@ -1200,18 +1384,80 @@ static unsigned int ipath_poll(struct fi
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_rcvctrl,
 			 dd->ipath_rcvctrl);
 
+bail:
 	return pollflag;
 }
 
+static int init_subports(struct ipath_devdata *dd,
+			 struct ipath_portdata *pd,
+			 const struct ipath_user_info *uinfo)
+{
+	int ret = 0;
+	unsigned num_slaves;
+	size_t size;
+
+	/* Old user binaries don't know about subports */
+	if ((uinfo->spu_userversion & 0xffff) != IPATH_USER_SWMINOR)
+		goto bail;
+	/*
+	 * If the user is requesting zero or one port,
+	 * skip the subport allocation.
+	 */
+	if (uinfo->spu_subport_cnt <= 1)
+		goto bail;
+	if (uinfo->spu_subport_cnt > 4) {
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	num_slaves = uinfo->spu_subport_cnt - 1;
+	pd->subport_uregbase = vmalloc(PAGE_SIZE * num_slaves);
+	if (!pd->subport_uregbase) {
+		ret = -ENOMEM;
+		goto bail;
+	}
+	/* Note: pd->port_rcvhdrq_size isn't initialized yet. */
+	size = ALIGN(dd->ipath_rcvhdrcnt * dd->ipath_rcvhdrentsize *
+		     sizeof(u32), PAGE_SIZE) * num_slaves;
+	pd->subport_rcvhdr_base = vmalloc(size);
+	if (!pd->subport_rcvhdr_base) {
+		ret = -ENOMEM;
+		goto bail_ureg;
+	}
+
+	pd->subport_rcvegrbuf = vmalloc(pd->port_rcvegrbuf_chunks *
+					pd->port_rcvegrbuf_size *
+					num_slaves);
+	if (!pd->subport_rcvegrbuf) {
+		ret = -ENOMEM;
+		goto bail_rhdr;
+	}
+
+	pd->port_subport_cnt = uinfo->spu_subport_cnt;
+	pd->port_subport_id = uinfo->spu_subport_id;
+	pd->active_slaves = 1;
+	goto bail;
+
+bail_rhdr:
+	vfree(pd->subport_rcvhdr_base);
+bail_ureg:
+	vfree(pd->subport_uregbase);
+	pd->subport_uregbase = NULL;
+bail:
+	return ret;
+}
+
 static int try_alloc_port(struct ipath_devdata *dd, int port,
-			  struct file *fp)
-{
+			  struct file *fp,
+			  const struct ipath_user_info *uinfo)
+{
+	struct ipath_portdata *pd;
 	int ret;
 
-	if (!dd->ipath_pd[port]) {
-		void *p, *ptmp;
-
-		p = kzalloc(sizeof(struct ipath_portdata), GFP_KERNEL);
+	if (!(pd = dd->ipath_pd[port])) {
+		void *ptmp;
+
+		pd = kzalloc(sizeof(struct ipath_portdata), GFP_KERNEL);
 
 		/*
 		 * Allocate memory for use in ipath_tid_update() just once
@@ -1221,34 +1467,36 @@ static int try_alloc_port(struct ipath_d
 		ptmp = kmalloc(dd->ipath_rcvtidcnt * sizeof(u16) +
 			       dd->ipath_rcvtidcnt * sizeof(struct page **),
 			       GFP_KERNEL);
-		if (!p || !ptmp) {
+		if (!pd || !ptmp) {
 			ipath_dev_err(dd, "Unable to allocate portdata "
 				      "memory, failing open\n");
 			ret = -ENOMEM;
-			kfree(p);
+			kfree(pd);
 			kfree(ptmp);
 			goto bail;
 		}
-		dd->ipath_pd[port] = p;
+		dd->ipath_pd[port] = pd;
 		dd->ipath_pd[port]->port_port = port;
 		dd->ipath_pd[port]->port_dd = dd;
 		dd->ipath_pd[port]->port_tid_pg_list = ptmp;
 		init_waitqueue_head(&dd->ipath_pd[port]->port_wait);
 	}
-	if (!dd->ipath_pd[port]->port_cnt) {
-		dd->ipath_pd[port]->port_cnt = 1;
-		fp->private_data = (void *) dd->ipath_pd[port];
+	if (!pd->port_cnt) {
+		pd->userversion = uinfo->spu_userversion;
+		init_user_egr_sizes(pd);
+		if ((ret = init_subports(dd, pd, uinfo)) != 0)
+			goto bail;
 		ipath_cdbg(PROC, "%s[%u] opened unit:port %u:%u\n",
 			   current->comm, current->pid, dd->ipath_unit,
 			   port);
-		dd->ipath_pd[port]->port_pid = current->pid;
-		strncpy(dd->ipath_pd[port]->port_comm, current->comm,
-			sizeof(dd->ipath_pd[port]->port_comm));
+		pd->port_cnt = 1;
+		port_fp(fp) = pd;
+		pd->port_pid = current->pid;
+		strncpy(pd->port_comm, current->comm, sizeof(pd->port_comm));
 		ipath_stats.sps_ports++;
 		ret = 0;
-		goto bail;
-	}
-	ret = -EBUSY;
+	} else
+		ret = -EBUSY;
 
 bail:
 	return ret;
@@ -1264,7 +1512,8 @@ static inline int usable(struct ipath_de
 				     | IPATH_LINKUNK));
 }
 
-static int find_free_port(int unit, struct file *fp)
+static int find_free_port(int unit, struct file *fp,
+			  const struct ipath_user_info *uinfo)
 {
 	struct ipath_devdata *dd = ipath_lookup(unit);
 	int ret, i;
@@ -1279,8 +1528,8 @@ static int find_free_port(int unit, stru
 		goto bail;
 	}
 
-	for (i = 0; i < dd->ipath_cfgports; i++) {
-		ret = try_alloc_port(dd, i, fp);
+	for (i = 1; i < dd->ipath_cfgports; i++) {
+		ret = try_alloc_port(dd, i, fp, uinfo);
 		if (ret != -EBUSY)
 			goto bail;
 	}
@@ -1290,13 +1539,14 @@ bail:
 	return ret;
 }
 
-static int find_best_unit(struct file *fp)
+static int find_best_unit(struct file *fp,
+			  const struct ipath_user_info *uinfo)
 {
 	int ret = 0, i, prefunit = -1, devmax;
 	int maxofallports, npresent, nup;
 	int ndev;
 
-	(void) ipath_count_units(&npresent, &nup, &maxofallports);
+	devmax = ipath_count_units(&npresent, &nup, &maxofallports);
 
 	/*
 	 * This code is present to allow a knowledgeable person to
@@ -1343,8 +1593,6 @@ static int find_best_unit(struct file *f
 
 	if (prefunit != -1)
 		devmax = prefunit + 1;
-	else
-		devmax = ipath_count_units(NULL, NULL, NULL);
 recheck:
 	for (i = 1; i < maxofallports; i++) {
 		for (ndev = prefunit != -1 ? prefunit : 0; ndev < devmax;
@@ -1359,7 +1607,7 @@ recheck:
 				 * next.
 				 */
 				continue;
-			ret = try_alloc_port(dd, i, fp);
+			ret = try_alloc_port(dd, i, fp, uinfo);
 			if (!ret)
 				goto done;
 		}
@@ -1395,22 +1643,174 @@ done:
 	return ret;
 }
 
+static int find_shared_port(struct file *fp,
+			    const struct ipath_user_info *uinfo)
+{
+	int devmax, ndev, i;
+	int ret = 0;
+
+	devmax = ipath_count_units(NULL, NULL, NULL);
+
+	for (ndev = 0; ndev < devmax; ndev++) {
+		struct ipath_devdata *dd = ipath_lookup(ndev);
+
+		if (!dd)
+			continue;
+		for (i = 1; i < dd->ipath_cfgports; i++) {
+			struct ipath_portdata *pd = dd->ipath_pd[i];
+
+			/* Skip ports which are not yet open */
+			if (!pd || !pd->port_cnt)
+				continue;
+			/* Skip port if it doesn't match the requested one */
+			if (pd->port_subport_id != uinfo->spu_subport_id)
+				continue;
+			/* Verify the sharing process matches the master */
+			if (pd->port_subport_cnt != uinfo->spu_subport_cnt ||
+			    pd->userversion != uinfo->spu_userversion ||
+			    pd->port_cnt >= pd->port_subport_cnt) {
+				ret = -EINVAL;
+				goto done;
+			}
+			port_fp(fp) = pd;
+			subport_fp(fp) = pd->port_cnt++;
+			tidcursor_fp(fp) = 0;
+			pd->active_slaves |= 1 << subport_fp(fp);
+			ipath_cdbg(PROC,
+				   "%s[%u] %u sharing %s[%u] unit:port %u:%u\n",
+				   current->comm, current->pid,
+				   subport_fp(fp),
+				   pd->port_comm, pd->port_pid,
+				   dd->ipath_unit, pd->port_port);
+			ret = 1;
+			goto done;
+		}
+	}
+
+done:
+	return ret;
+}
+
 static int ipath_open(struct inode *in, struct file *fp)
 {
-	int ret, user_minor;
+	/* The real work is performed later in ipath_do_user_init() */
+	fp->private_data = kzalloc(sizeof(struct ipath_filedata), GFP_KERNEL);
+	return fp->private_data ? 0 : -ENOMEM;
+}
+
+static int ipath_do_user_init(struct file *fp,
+			      const struct ipath_user_info *uinfo)
+{
+	int ret;
+	struct ipath_portdata *pd;
+	struct ipath_devdata *dd;
+	u32 head32;
+	int i_minor;
+	unsigned swminor;
+
+	/* Check to be sure we haven't already initialized this file */
+	if (port_fp(fp)) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	/* for now, if major version is different, bail */
+	if ((uinfo->spu_userversion >> 16) != IPATH_USER_SWMAJOR) {
+		ipath_dbg("User major version %d not same as driver "
+			  "major %d\n", uinfo->spu_userversion >> 16,
+			  IPATH_USER_SWMAJOR);
+		ret = -ENODEV;
+		goto done;
+	}
+
+	swminor = uinfo->spu_userversion & 0xffff;
+	if (swminor != IPATH_USER_SWMINOR)
+		ipath_dbg("User minor version %d not same as driver "
+			  "minor %d\n", swminor, IPATH_USER_SWMINOR);
 
 	mutex_lock(&ipath_mutex);
 
-	user_minor = iminor(in) - IPATH_USER_MINOR_BASE;
+	if (swminor == IPATH_USER_SWMINOR && uinfo->spu_subport_cnt &&
+	    (ret = find_shared_port(fp, uinfo))) {
+		mutex_unlock(&ipath_mutex);
+		if (ret > 0)
+			ret = 0;
+		goto done;
+	}
+
+	i_minor = iminor(fp->f_dentry->d_inode) - IPATH_USER_MINOR_BASE;
 	ipath_cdbg(VERBOSE, "open on dev %lx (minor %d)\n",
-		   (long)in->i_rdev, user_minor);
-
-	if (user_minor)
-		ret = find_free_port(user_minor - 1, fp);
+		   (long)fp->f_dentry->d_inode->i_rdev, i_minor);
+
+	if (i_minor)
+		ret = find_free_port(i_minor - 1, fp, uinfo);
 	else
-		ret = find_best_unit(fp);
+		ret = find_best_unit(fp, uinfo);
 
 	mutex_unlock(&ipath_mutex);
+
+	if (ret)
+		goto done;
+
+	pd = port_fp(fp);
+	dd = pd->port_dd;
+
+	if (uinfo->spu_rcvhdrsize) {
+		ret = ipath_setrcvhdrsize(dd, uinfo->spu_rcvhdrsize);
+		if (ret)
+			goto done;
+	}
+
+	/* for now we do nothing with rcvhdrcnt: uinfo->spu_rcvhdrcnt */
+
+	/* for right now, kernel piobufs are at end, so port 1 is at 0 */
+	pd->port_piobufs = dd->ipath_piobufbase +
+		dd->ipath_pbufsport * (pd->port_port - 1) * dd->ipath_palign;
+	ipath_cdbg(VERBOSE, "Set base of piobufs for port %u to 0x%x\n",
+		   pd->port_port, pd->port_piobufs);
+
+	/*
+	 * Now allocate the rcvhdr Q and eager TIDs; skip the TID
+	 * array for time being.  If pd->port_port > chip-supported,
+	 * we need to do extra stuff here to handle by handling overflow
+	 * through port 0, someday
+	 */
+	ret = ipath_create_rcvhdrq(dd, pd);
+	if (!ret)
+		ret = ipath_create_user_egr(pd);
+	if (ret)
+		goto done;
+
+	/*
+	 * set the eager head register for this port to the current values
+	 * of the tail pointers, since we don't know if they were
+	 * updated on last use of the port.
+	 */
+	head32 = ipath_read_ureg32(dd, ur_rcvegrindextail, pd->port_port);
+	ipath_write_ureg(dd, ur_rcvegrindexhead, head32, pd->port_port);
+	dd->ipath_lastegrheads[pd->port_port] = -1;
+	dd->ipath_lastrcvhdrqtails[pd->port_port] = -1;
+	ipath_cdbg(VERBOSE, "Wrote port%d egrhead %x from tail regs\n",
+		pd->port_port, head32);
+	pd->port_tidcursor = 0;	/* start at beginning after open */
+	/*
+	 * now enable the port; the tail registers will be written to memory
+	 * by the chip as soon as it sees the write to
+	 * dd->ipath_kregs->kr_rcvctrl.  The update only happens on
+	 * transition from 0 to 1, so clear it first, then set it as part of
+	 * enabling the port.  This will (very briefly) affect any other
+	 * open ports, but it shouldn't be long enough to be an issue.
+	 * We explictly set the in-memory copy to 0 beforehand, so we don't
+	 * have to wait to be sure the DMA update has happened.
+	 */
+	*pd->port_rcvhdrtail_kvaddr = 0ULL;
+	set_bit(INFINIPATH_R_PORTENABLE_SHIFT + pd->port_port,
+		&dd->ipath_rcvctrl);
+	ipath_write_kreg(dd, dd->ipath_kregs->kr_rcvctrl,
+			 dd->ipath_rcvctrl & ~INFINIPATH_R_TAILUPD);
+	ipath_write_kreg(dd, dd->ipath_kregs->kr_rcvctrl,
+			 dd->ipath_rcvctrl);
+done:
 	return ret;
 }
 
@@ -1453,6 +1853,7 @@ static int ipath_close(struct inode *in,
 static int ipath_close(struct inode *in, struct file *fp)
 {
 	int ret = 0;
+	struct ipath_filedata *fd;
 	struct ipath_portdata *pd;
 	struct ipath_devdata *dd;
 	unsigned port;
@@ -1462,9 +1863,24 @@ static int ipath_close(struct inode *in,
 
 	mutex_lock(&ipath_mutex);
 
-	pd = port_fp(fp);
+	fd = (struct ipath_filedata *) fp->private_data;
+	fp->private_data = NULL;
+	pd = fd->pd;
+	if (!pd) {
+		mutex_unlock(&ipath_mutex);
+		goto bail;
+	}
+	if (--pd->port_cnt) {
+		/*
+		 * XXX If the master closes the port before the slave(s),
+		 * revoke the mmap for the eager receive queue so
+		 * the slave(s) don't wait for receive data forever.
+		 */
+		pd->active_slaves &= ~(1 << fd->subport);
+		mutex_unlock(&ipath_mutex);
+		goto bail;
+	}
 	port = pd->port_port;
-	fp->private_data = NULL;
 	dd = pd->port_dd;
 
 	if (pd->port_hdrqfull) {
@@ -1503,8 +1919,6 @@ static int ipath_close(struct inode *in,
 
 		/* clean up the pkeys for this port user */
 		ipath_clean_part_key(pd, dd);
-
-
 		/*
 		 * be paranoid, and never write 0's to these, just use an
 		 * unused part of the port 0 tail page.  Of course,
@@ -1533,35 +1947,55 @@ static int ipath_close(struct inode *in,
 		dd->ipath_f_clear_tids(dd, pd->port_port);
 	}
 
-	pd->port_cnt = 0;
 	pd->port_pid = 0;
-
 	dd->ipath_pd[pd->port_port] = NULL; /* before releasing mutex */
 	mutex_unlock(&ipath_mutex);
 	ipath_free_pddata(dd, pd); /* after releasing the mutex */
 
-	return ret;
-}
-
-static int ipath_port_info(struct ipath_portdata *pd,
+bail:
+	kfree(fd);
+	return ret;
+}
+
+static int ipath_port_info(struct ipath_portdata *pd, u16 subport,
 			   struct ipath_port_info __user *uinfo)
 {
 	struct ipath_port_info info;
 	int nup;
 	int ret;
+	size_t sz;
 
 	(void) ipath_count_units(NULL, &nup, NULL);
 	info.num_active = nup;
 	info.unit = pd->port_dd->ipath_unit;
 	info.port = pd->port_port;
-
-	if (copy_to_user(uinfo, &info, sizeof(info))) {
+	info.subport = subport;
+	/* Don't return new fields if old library opened the port. */
+	if ((pd->userversion & 0xffff) == IPATH_USER_SWMINOR) {
+		/* Number of user ports available for this device. */
+		info.num_ports = pd->port_dd->ipath_cfgports - 1;
+		info.num_subports = pd->port_subport_cnt;
+		sz = sizeof(info);
+	} else
+		sz = sizeof(info) - 2 * sizeof(u16);
+
+	if (copy_to_user(uinfo, &info, sz)) {
 		ret = -EFAULT;
 		goto bail;
 	}
 	ret = 0;
 
 bail:
+	return ret;
+}
+
+static int ipath_get_slave_info(struct ipath_portdata *pd,
+				void __user *slave_mask_addr)
+{
+	int ret = 0;
+
+	if (copy_to_user(slave_mask_addr, &pd->active_slaves, sizeof(u32)))
+		ret = -EFAULT;
 	return ret;
 }
 
@@ -1617,6 +2051,11 @@ static ssize_t ipath_write(struct file *
 		dest = &cmd.cmd.part_key;
 		src = &ucmd->cmd.part_key;
 		break;
+	case IPATH_CMD_SLAVE_INFO:
+		copy = sizeof(cmd.cmd.slave_mask_addr);
+		dest = &cmd.cmd.slave_mask_addr;
+		src = &ucmd->cmd.slave_mask_addr;
+		break;
 	default:
 		ret = -EINVAL;
 		goto bail;
@@ -1634,33 +2073,42 @@ static ssize_t ipath_write(struct file *
 
 	consumed += copy;
 	pd = port_fp(fp);
+	if (!pd && cmd.type != IPATH_CMD_USER_INIT) {
+		ret = -EINVAL;
+		goto bail;
+	}
 
 	switch (cmd.type) {
 	case IPATH_CMD_USER_INIT:
-		ret = ipath_do_user_init(pd, &cmd.cmd.user_info);
-		if (ret < 0)
+		ret = ipath_do_user_init(fp, &cmd.cmd.user_info);
+		if (ret)
 			goto bail;
 		ret = ipath_get_base_info(
-			pd, (void __user *) (unsigned long)
+			fp, (void __user *) (unsigned long)
 			cmd.cmd.user_info.spu_base_info,
 			cmd.cmd.user_info.spu_base_info_size);
 		break;
 	case IPATH_CMD_RECV_CTRL:
-		ret = ipath_manage_rcvq(pd, cmd.cmd.recv_ctrl);
+		ret = ipath_manage_rcvq(pd, subport_fp(fp), cmd.cmd.recv_ctrl);
 		break;
 	case IPATH_CMD_PORT_INFO:
-		ret = ipath_port_info(pd,
+		ret = ipath_port_info(pd, subport_fp(fp),
 				      (struct ipath_port_info __user *)
 				      (unsigned long) cmd.cmd.port_info);
 		break;
 	case IPATH_CMD_TID_UPDATE:
-		ret = ipath_tid_update(pd, &cmd.cmd.tid_info);
+		ret = ipath_tid_update(pd, fp, &cmd.cmd.tid_info);
 		break;
 	case IPATH_CMD_TID_FREE:
-		ret = ipath_tid_free(pd, &cmd.cmd.tid_info);
+		ret = ipath_tid_free(pd, subport_fp(fp), &cmd.cmd.tid_info);
 		break;
 	case IPATH_CMD_SET_PART_KEY:
 		ret = ipath_set_part_key(pd, cmd.cmd.part_key);
+		break;
+	case IPATH_CMD_SLAVE_INFO:
+		ret = ipath_get_slave_info(pd,
+					   (void __user *) (unsigned long)
+					   cmd.cmd.slave_mask_addr);
 		break;
 	}
 
@@ -1858,4 +2306,3 @@ bail:
 bail:
 	return;
 }
-
diff -r 45079acba208 -r 7f5b6127be15 drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Sep 28 08:57:12 2006 -0700
@@ -79,8 +79,8 @@ struct ipath_portdata {
 	dma_addr_t port_rcvhdrq_phys;
 	dma_addr_t port_rcvhdrqtailaddr_phys;
 	/*
-	 * number of opens on this instance (0 or 1; ignoring forks, dup,
-	 * etc. for now)
+	 * number of opens (including slave subports) on this instance
+	 * (ignoring forks, dup, etc. for now)
 	 */
 	int port_cnt;
 	/*
@@ -89,6 +89,10 @@ struct ipath_portdata {
 	 */
 	/* instead of calculating it */
 	unsigned port_port;
+	/* non-zero if port is being shared. */
+	u16 port_subport_cnt;
+	/* non-zero if port is being shared. */
+	u16 port_subport_id;
 	/* chip offset of PIO buffers for this port */
 	u32 port_piobufs;
 	/* how many alloc_pages() chunks in port_rcvegrbuf_pages */
@@ -121,6 +125,16 @@ struct ipath_portdata {
 	u16 port_pkeys[4];
 	/* so file ops can get at unit */
 	struct ipath_devdata *port_dd;
+	/* A page of memory for rcvhdrhead, rcvegrhead, rcvegrtail * N */
+	void *subport_uregbase;
+	/* An array of pages for the eager receive buffers * N */
+	void *subport_rcvegrbuf;
+	/* An array of pages for the eager header queue entries * N */
+	void *subport_rcvhdr_base;
+	/* The version of the library which opened this port */
+	u32 userversion;
+	/* Bitmask of active slaves */
+	u32 active_slaves;
 };
 
 struct sk_buff;
@@ -512,6 +526,12 @@ struct ipath_devdata {
 	u32 ipath_lli_errors;
 };
 
+/* Private data for file operations */
+struct ipath_filedata {
+	struct ipath_portdata *pd;
+	unsigned subport;
+	unsigned tidcursor;
+};
 extern struct list_head ipath_dev_list;
 extern spinlock_t ipath_devs_lock;
 extern struct ipath_devdata *ipath_lookup(int unit);
@@ -572,7 +592,11 @@ int ipath_set_rx_pol_inv(struct ipath_de
 int ipath_set_rx_pol_inv(struct ipath_devdata *dd, u8 new_pol_inv);
 
 /* for use in system calls, where we want to know device type, etc. */
-#define port_fp(fp) ((struct ipath_portdata *) (fp)->private_data)
+#define port_fp(fp) ((struct ipath_filedata *)(fp)->private_data)->pd
+#define subport_fp(fp) \
+	((struct ipath_filedata *)(fp)->private_data)->subport
+#define tidcursor_fp(fp) \
+	((struct ipath_filedata *)(fp)->private_data)->tidcursor
 
 /*
  * values for ipath_flags
diff -r 45079acba208 -r 7f5b6127be15 drivers/infiniband/hw/ipath/ipath_sysfs.c
--- a/drivers/infiniband/hw/ipath/ipath_sysfs.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_sysfs.c	Thu Sep 28 08:57:12 2006 -0700
@@ -295,6 +295,16 @@ static ssize_t show_nguid(struct device 
 	struct ipath_devdata *dd = dev_get_drvdata(dev);
 
 	return scnprintf(buf, PAGE_SIZE, "%u\n", dd->ipath_nguid);
+}
+
+static ssize_t show_nports(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+
+	/* Return the number of user ports available. */
+	return scnprintf(buf, PAGE_SIZE, "%u\n", dd->ipath_cfgports - 1);
 }
 
 static ssize_t show_serial(struct device *dev,
@@ -608,6 +618,7 @@ static DEVICE_ATTR(mtu, S_IWUSR | S_IRUG
 static DEVICE_ATTR(mtu, S_IWUSR | S_IRUGO, show_mtu, store_mtu);
 static DEVICE_ATTR(enabled, S_IWUSR | S_IRUGO, show_enabled, store_enabled);
 static DEVICE_ATTR(nguid, S_IRUGO, show_nguid, NULL);
+static DEVICE_ATTR(nports, S_IRUGO, show_nports, NULL);
 static DEVICE_ATTR(reset, S_IWUSR, NULL, store_reset);
 static DEVICE_ATTR(serial, S_IRUGO, show_serial, NULL);
 static DEVICE_ATTR(status, S_IRUGO, show_status, NULL);
@@ -623,6 +634,7 @@ static struct attribute *dev_attributes[
 	&dev_attr_mlid.attr,
 	&dev_attr_mtu.attr,
 	&dev_attr_nguid.attr,
+	&dev_attr_nports.attr,
 	&dev_attr_serial.attr,
 	&dev_attr_status.attr,
 	&dev_attr_status_str.attr,
