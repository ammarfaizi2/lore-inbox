Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWELXpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWELXpx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWELXo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:44:58 -0400
Received: from mx.pathscale.com ([64.160.42.68]:61097 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932280AbWELXoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:34 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 35 of 53] ipath - some interrelated stability and cleanliness
	fixes
X-Mercurial-Node: e29625bd905036ab31755ae42e77f0b670d8bda1
Message-Id: <e29625bd905036ab3175.1147477400@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:20 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Made in-memory rcvhdrq tail update be in dma_alloc'ed memory, not random
user or special kernel (needed for powerpc, also "just the right thing
to do".

Some cleanups to make unexpected link transitions less likely to produce
complaints about packet errors, and also to not leave SMA packets stuck
and unable to go out.

Call dma_free_coherent without ipath_mutex held.

A few other random debug and comment cleanups.

Always init rcvhdrq head/tail registers to 0, to avoid race conditions
(should have been that way some time ago).

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 09077b2f476f -r e29625bd9050 drivers/infiniband/hw/ipath/ipath_common.h
--- a/drivers/infiniband/hw/ipath/ipath_common.h	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_common.h	Fri May 12 15:55:28 2006 -0700
@@ -307,6 +307,9 @@ struct ipath_base_info {
 	__u32 spi_rcv_egrchunksize;
 	/* total size of mmap to cover full rcvegrbuffers */
 	__u32 spi_rcv_egrbuftotlen;
+	__u32 spi_filler_for_align;
+	/* address of readonly memory copy of the rcvhdrq tail register. */
+	__u64 spi_rcvhdr_tailaddr;
 } __attribute__ ((aligned(8)));
 
 
@@ -376,13 +379,7 @@ struct ipath_user_info {
 	 */
 	__u32 spu_rcvhdrsize;
 
-	/*
-	 * cache line aligned (64 byte) user address to
-	 * which the rcvhdrtail register will be written by infinipath
-	 * whenever it changes, so that no chip registers are read in
-	 * the performance path.
-	 */
-	__u64 spu_rcvhdraddr;
+	__u64 spu_unused; /* kept for compatible layout */
 
 	/*
 	 * address of struct base_info to write to
diff -r 09077b2f476f -r e29625bd9050 drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Fri May 12 15:55:28 2006 -0700
@@ -131,14 +131,6 @@ static struct pci_driver ipath_driver = 
 	.id_table = ipath_pci_tbl,
 };
 
-/*
- * This is where port 0's rcvhdrtail register is written back; we also
- * want nothing else sharing the cache line, so make it a cache line
- * in size.  Used for all units.
- */
-volatile __le64 *ipath_port0_rcvhdrtail;
-dma_addr_t ipath_port0_rcvhdrtail_dma;
-static int port0_rcvhdrtail_refs;
 
 static inline void read_bars(struct ipath_devdata *dd, struct pci_dev *dev,
 			     u32 *bar0, u32 *bar1)
@@ -171,14 +163,13 @@ static void ipath_free_devdata(struct pc
 		list_del(&dd->ipath_list);
 		spin_unlock_irqrestore(&ipath_devs_lock, flags);
 	}
-	dma_free_coherent(&pdev->dev, sizeof(*dd), dd, dd->ipath_dma_addr);
+	vfree(dd);
 }
 
 static struct ipath_devdata *ipath_alloc_devdata(struct pci_dev *pdev)
 {
 	unsigned long flags;
 	struct ipath_devdata *dd;
-	dma_addr_t dma_addr;
 	int ret;
 
 	if (!idr_pre_get(&unit_table, GFP_KERNEL)) {
@@ -186,15 +177,13 @@ static struct ipath_devdata *ipath_alloc
 		goto bail;
 	}
 
-	dd = dma_alloc_coherent(&pdev->dev, sizeof(*dd), &dma_addr,
-				GFP_KERNEL);
-
+	dd = vmalloc(sizeof(*dd));
 	if (!dd) {
 		dd = ERR_PTR(-ENOMEM);
 		goto bail;
 	}
-
-	dd->ipath_dma_addr = dma_addr;
+	memset(dd, 0, sizeof(*dd));
+
 	dd->ipath_unit = -1;
 
 	spin_lock_irqsave(&ipath_devs_lock, flags);
@@ -272,47 +261,6 @@ int ipath_count_units(int *npresentp, in
 	return nunits;
 }
 
-static int init_port0_rcvhdrtail(struct pci_dev *pdev)
-{
-	int ret;
-
-	mutex_lock(&ipath_mutex);
-
-	if (!ipath_port0_rcvhdrtail) {
-		ipath_port0_rcvhdrtail =
-			dma_alloc_coherent(&pdev->dev,
-					   IPATH_PORT0_RCVHDRTAIL_SIZE,
-					   &ipath_port0_rcvhdrtail_dma,
-					   GFP_KERNEL);
-
-		if (!ipath_port0_rcvhdrtail) {
-			ret = -ENOMEM;
-			goto bail;
-		}
-	}
-	port0_rcvhdrtail_refs++;
-	ret = 0;
-
-bail:
-	mutex_unlock(&ipath_mutex);
-
-	return ret;
-}
-
-static void cleanup_port0_rcvhdrtail(struct pci_dev *pdev)
-{
-	mutex_lock(&ipath_mutex);
-
-	if (!--port0_rcvhdrtail_refs) {
-		dma_free_coherent(&pdev->dev, IPATH_PORT0_RCVHDRTAIL_SIZE,
-				  (void *) ipath_port0_rcvhdrtail,
-				  ipath_port0_rcvhdrtail_dma);
-		ipath_port0_rcvhdrtail = NULL;
-	}
-
-	mutex_unlock(&ipath_mutex);
-}
-
 /*
  * These next two routines are placeholders in case we don't have per-arch
  * code for controlling write combining.  If explicit control of write
@@ -337,20 +285,12 @@ static int __devinit ipath_init_one(stru
 	u32 bar0 = 0, bar1 = 0;
 	u8 rev;
 
-	ret = init_port0_rcvhdrtail(pdev);
-	if (ret < 0) {
-		printk(KERN_ERR IPATH_DRV_NAME
-		       ": Could not allocate port0_rcvhdrtail: error %d\n",
-		       -ret);
-		goto bail;
-	}
-
 	dd = ipath_alloc_devdata(pdev);
 	if (IS_ERR(dd)) {
 		ret = PTR_ERR(dd);
 		printk(KERN_ERR IPATH_DRV_NAME
 		       ": Could not allocate devdata: error %d\n", -ret);
-		goto bail_rcvhdrtail;
+		goto bail;
 	}
 
 	ipath_cdbg(VERBOSE, "initializing unit #%u\n", dd->ipath_unit);
@@ -562,9 +502,6 @@ bail_devdata:
 bail_devdata:
 	ipath_free_devdata(pdev, dd);
 
-bail_rcvhdrtail:
-	cleanup_port0_rcvhdrtail(pdev);
-
 bail:
 	return ret;
 }
@@ -595,7 +532,6 @@ static void __devexit ipath_remove_one(s
 	pci_disable_device(pdev);
 
 	ipath_free_devdata(pdev, dd);
-	cleanup_port0_rcvhdrtail(pdev);
 }
 
 /* general driver use */
@@ -1372,26 +1308,20 @@ bail:
  * @dd: the infinipath device
  * @pd: the port data
  *
- * this *must* be physically contiguous memory, and for now,
- * that limits it to what kmalloc can do.
+ * this must be contiguous memory (from an i/o perspective), and must be
+ * DMA'able (which means for some systems, it will go through an IOMMU,
+ * or be forced into a low address range).
  */
 int ipath_create_rcvhdrq(struct ipath_devdata *dd,
 			 struct ipath_portdata *pd)
 {
-	int ret = 0, amt;
-
-	amt = ALIGN(dd->ipath_rcvhdrcnt * dd->ipath_rcvhdrentsize *
-		    sizeof(u32), PAGE_SIZE);
+	int ret = 0;
+
 	if (!pd->port_rcvhdrq) {
-		/*
-		 * not using REPEAT isn't viable; at 128KB, we can easily
-		 * fail this.  The problem with REPEAT is we can block here
-		 * "forever".  There isn't an inbetween, unfortunately.  We
-		 * could reduce the risk by never freeing the rcvhdrq except
-		 * at unload, but even then, the first time a port is used,
-		 * we could delay for some time...
-		 */
+		dma_addr_t phys_hdrqtail;
 		gfp_t gfp_flags = GFP_USER | __GFP_COMP;
+		int amt = ALIGN(dd->ipath_rcvhdrcnt * dd->ipath_rcvhdrentsize *
+				sizeof(u32), PAGE_SIZE);
 
 		pd->port_rcvhdrq = dma_alloc_coherent(
 			&dd->pcidev->dev, amt, &pd->port_rcvhdrq_phys,
@@ -1404,6 +1334,16 @@ int ipath_create_rcvhdrq(struct ipath_de
 			ret = -ENOMEM;
 			goto bail;
 		}
+		pd->port_rcvhdrtail_kvaddr = dma_alloc_coherent(
+			&dd->pcidev->dev, PAGE_SIZE, &phys_hdrqtail, GFP_KERNEL);
+		if (!pd->port_rcvhdrtail_kvaddr) {
+			ipath_dev_err(dd, "attempt to allocate 1 page "
+				      "for port %u rcvhdrqtailaddr failed\n",
+				      pd->port_port);
+			ret = -ENOMEM;
+			goto bail;
+		}
+		pd->port_rcvhdrqtailaddr_phys = phys_hdrqtail;
 
 		pd->port_rcvhdrq_size = amt;
 
@@ -1413,20 +1353,28 @@ int ipath_create_rcvhdrq(struct ipath_de
 			   (unsigned long) pd->port_rcvhdrq_phys,
 			   (unsigned long) pd->port_rcvhdrq_size,
 			   pd->port_port);
-	} else {
-		/*
-		 * clear for security, sanity, and/or debugging, each
-		 * time we reuse
-		 */
-		memset(pd->port_rcvhdrq, 0, amt);
-	}
+
+		ipath_cdbg(VERBOSE, "port %d hdrtailaddr, %llx physical\n",
+			   pd->port_port,
+			   (unsigned long long) phys_hdrqtail);
+	}
+	else
+		ipath_cdbg(VERBOSE, "reuse port %d rcvhdrq @%p %llx phys; "
+			   "hdrtailaddr@%p %llx physical\n",
+			   pd->port_port, pd->port_rcvhdrq,
+			   pd->port_rcvhdrq_phys, pd->port_rcvhdrtail_kvaddr,
+			   (unsigned long long)pd->port_rcvhdrqtailaddr_phys);
+
+	/* clear for security and sanity on each use */
+	memset(pd->port_rcvhdrq, 0, pd->port_rcvhdrq_size);
+	memset((void *)pd->port_rcvhdrtail_kvaddr, 0, PAGE_SIZE);
 
 	/*
 	 * tell chip each time we init it, even if we are re-using previous
-	 * memory (we zero it at process close)
-	 */
-	ipath_cdbg(VERBOSE, "writing port %d rcvhdraddr as %lx\n",
-		   pd->port_port, (unsigned long) pd->port_rcvhdrq_phys);
+	 * memory (we zero the register at process close)
+	 */
+	ipath_write_kreg_port(dd, dd->ipath_kregs->kr_rcvhdrtailaddr,
+			      pd->port_port, pd->port_rcvhdrqtailaddr_phys);
 	ipath_write_kreg_port(dd, dd->ipath_kregs->kr_rcvhdraddr,
 			      pd->port_port, pd->port_rcvhdrq_phys);
 
@@ -1514,15 +1462,27 @@ void ipath_set_ib_lstate(struct ipath_de
 		[INFINIPATH_IBCC_LINKCMD_ARMED] = "ARMED",
 		[INFINIPATH_IBCC_LINKCMD_ACTIVE] = "ACTIVE"
 	};
+	int linkcmd = (which >> INFINIPATH_IBCC_LINKCMD_SHIFT) &
+			INFINIPATH_IBCC_LINKCMD_MASK;
+
 	ipath_cdbg(SMA, "Trying to move unit %u to %s, current ltstate "
 		   "is %s\n", dd->ipath_unit,
-		   what[(which >> INFINIPATH_IBCC_LINKCMD_SHIFT) &
-			INFINIPATH_IBCC_LINKCMD_MASK],
+		   what[linkcmd],
 		   ipath_ibcstatus_str[
 			   (ipath_read_kreg64
 			    (dd, dd->ipath_kregs->kr_ibcstatus) >>
 			    INFINIPATH_IBCS_LINKTRAININGSTATE_SHIFT) &
 			   INFINIPATH_IBCS_LINKTRAININGSTATE_MASK]);
+	/* flush all queued sends when going to DOWN or INIT, to be sure that
+	 * they don't block SMA and other MAD packets */
+	if(!linkcmd || linkcmd == INFINIPATH_IBCC_LINKCMD_INIT) {
+		ipath_write_kreg(dd, dd->ipath_kregs->kr_sendctrl,
+				 INFINIPATH_S_ABORT);
+		ipath_disarm_piobufs(dd, dd->ipath_lastport_piobuf,
+		                    (unsigned)(dd->ipath_piobcnt2k +
+				    dd->ipath_piobcnt4k) -
+				    dd->ipath_lastport_piobuf);
+	}
 
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_ibcctrl,
 			 dd->ipath_ibcctrl | which);
@@ -1670,60 +1630,54 @@ void ipath_shutdown_device(struct ipath_
 /**
  * ipath_free_pddata - free a port's allocated data
  * @dd: the infinipath device
- * @port: the port
- * @freehdrq: free the port data structure if true
- *
- * when closing, free up any allocated data for a port, if the
- * reference count goes to zero
- * Note: this also optionally frees the portdata itself!
- * Any changes here have to be matched up with the reinit case
- * of ipath_init_chip(), which calls this routine on reinit after reset.
- */
-void ipath_free_pddata(struct ipath_devdata *dd, u32 port, int freehdrq)
-{
-	struct ipath_portdata *pd = dd->ipath_pd[port];
-
+ * @pd: the portdata structure
+ *
+ * free up any allocated data for a port
+ * This should not touch anything that would affect a simultaneous
+ * re-allocation of port data, because it is called after ipath_mutex
+ * is released (and can be called from reinit as well).
+ * It should never change any chip state, or global driver state.
+ * (The only exception to global state is freeing the port0 port0_skbs.)
+ */
+void ipath_free_pddata(struct ipath_devdata *dd, struct ipath_portdata *pd)
+{
 	if (!pd)
 		return;
-	if (freehdrq)
-		/*
-		 * only clear and free portdata if we are going to also
-		 * release the hdrq, otherwise we leak the hdrq on each
-		 * open/close cycle
-		 */
-		dd->ipath_pd[port] = NULL;
-	if (freehdrq && pd->port_rcvhdrq) {
+
+	if (pd->port_rcvhdrq) {
 		ipath_cdbg(VERBOSE, "free closed port %d rcvhdrq @ %p "
 			   "(size=%lu)\n", pd->port_port, pd->port_rcvhdrq,
 			   (unsigned long) pd->port_rcvhdrq_size);
 		dma_free_coherent(&dd->pcidev->dev, pd->port_rcvhdrq_size,
 				  pd->port_rcvhdrq, pd->port_rcvhdrq_phys);
 		pd->port_rcvhdrq = NULL;
-	}
-	if (port && pd->port_rcvegrbuf) {
-		/* always free this */
-		if (pd->port_rcvegrbuf) {
-			unsigned e;
-
-			for (e = 0; e < pd->port_rcvegrbuf_chunks; e++) {
-				void *base = pd->port_rcvegrbuf[e];
-				size_t size = pd->port_rcvegrbuf_size;
-
-				ipath_cdbg(VERBOSE, "egrbuf free(%p, %lu), "
-					   "chunk %u/%u\n", base,
-					   (unsigned long) size,
-					   e, pd->port_rcvegrbuf_chunks);
-				dma_free_coherent(
-					&dd->pcidev->dev, size, base,
-					pd->port_rcvegrbuf_phys[e]);
-			}
-			vfree(pd->port_rcvegrbuf);
-			pd->port_rcvegrbuf = NULL;
-			vfree(pd->port_rcvegrbuf_phys);
-			pd->port_rcvegrbuf_phys = NULL;
-		}
+		if(pd->port_rcvhdrtail_kvaddr) {
+			dma_free_coherent(&dd->pcidev->dev, PAGE_SIZE,
+					 (void *)pd->port_rcvhdrtail_kvaddr,
+					 pd->port_rcvhdrqtailaddr_phys);
+			pd->port_rcvhdrtail_kvaddr = NULL;
+		}
+	}
+	if(pd->port_port && pd->port_rcvegrbuf) {
+		unsigned e;
+
+		for (e = 0; e < pd->port_rcvegrbuf_chunks; e++) {
+			void *base = pd->port_rcvegrbuf[e];
+			size_t size = pd->port_rcvegrbuf_size;
+
+			ipath_cdbg(VERBOSE, "egrbuf free(%p, %lu), "
+				   "chunk %u/%u\n", base,
+				   (unsigned long) size,
+				   e, pd->port_rcvegrbuf_chunks);
+			dma_free_coherent(&dd->pcidev->dev, size,
+				base, pd->port_rcvegrbuf_phys[e]);
+		}
+		vfree(pd->port_rcvegrbuf);
+		pd->port_rcvegrbuf = NULL;
+		vfree(pd->port_rcvegrbuf_phys);
+		pd->port_rcvegrbuf_phys = NULL;
 		pd->port_rcvegrbuf_chunks = 0;
-	} else if (port == 0 && dd->ipath_port0_skbs) {
+	} else if (pd->port_port == 0 && dd->ipath_port0_skbs) {
 		unsigned e;
 		struct sk_buff **skbs = dd->ipath_port0_skbs;
 
@@ -1735,10 +1689,8 @@ void ipath_free_pddata(struct ipath_devd
 				dev_kfree_skb(skbs[e]);
 		vfree(skbs);
 	}
-	if (freehdrq) {
-		kfree(pd->port_tid_pg_list);
-		kfree(pd);
-	}
+	kfree(pd->port_tid_pg_list);
+	kfree(pd);
 }
 
 static int __init infinipath_init(void)
@@ -1864,10 +1816,14 @@ static void cleanup_device(struct ipath_
 
 	/*
 	 * free any resources still in use (usually just kernel ports)
-	 * at unload
-	 */
-	for (port = 0; port < dd->ipath_cfgports; port++)
-		ipath_free_pddata(dd, port, 1);
+	 * at unload; we do for portcnt, not cfgports, because cfgports
+	 * could have changed while we were loaded.
+	 */
+	for (port = 0; port < dd->ipath_portcnt; port++) {
+		struct ipath_portdata *pd = dd->ipath_pd[port];
+		dd->ipath_pd[port] = NULL;
+		ipath_free_pddata(dd, pd);
+	}
 	kfree(dd->ipath_pd);
 	/*
 	 * debuggability, in case some cleanup path tries to use it
@@ -1908,19 +1864,19 @@ static void __exit infinipath_cleanup(vo
 			} else
 				ipath_dbg("irq is 0, not doing free_irq "
 					  "for unit %u\n", dd->ipath_unit);
-
-			/*
-			 * we check for NULL here, because it's outside
-			 * the kregbase check, and we need to call it
-			 * after the free_irq.  Thus it's possible that
-			 * the function pointers were never initialized.
-			 */
-			if (dd->ipath_f_cleanup)
-				/* clean up chip-specific stuff */
-				dd->ipath_f_cleanup(dd);
-
 			dd->pcidev = NULL;
 		}
+
+		/*
+		 * we check for NULL here, because it's outside the kregbase
+		 * check, and we need to call it after the free_irq.  Thus
+		 * it's possible that the function pointers were never
+		 * initialized.
+		 */
+		if (dd->ipath_f_cleanup)
+			/* clean up chip-specific stuff */
+			dd->ipath_f_cleanup(dd);
+
 		spin_lock_irqsave(&ipath_devs_lock, flags);
 	}
 
diff -r 09077b2f476f -r e29625bd9050 drivers/infiniband/hw/ipath/ipath_file_ops.c
--- a/drivers/infiniband/hw/ipath/ipath_file_ops.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_file_ops.c	Fri May 12 15:55:28 2006 -0700
@@ -122,6 +122,7 @@ static int ipath_get_base_info(struct ip
 	 * on to yet another method of dealing with this
 	 */
 	kinfo->spi_rcvhdr_base = (u64) pd->port_rcvhdrq_phys;
+	kinfo->spi_rcvhdr_tailaddr = (u64)pd->port_rcvhdrqtailaddr_phys;
 	kinfo->spi_rcv_egrbufs = (u64) pd->port_rcvegr_phys;
 	kinfo->spi_pioavailaddr = (u64) dd->ipath_pioavailregs_phys;
 	kinfo->spi_status = (u64) kinfo->spi_pioavailaddr +
@@ -783,11 +784,12 @@ static int ipath_create_user_egr(struct 
 
 bail_rcvegrbuf_phys:
 	for (e = 0; e < pd->port_rcvegrbuf_chunks &&
-		     pd->port_rcvegrbuf[e]; e++)
+		pd->port_rcvegrbuf[e]; e++) {
 		dma_free_coherent(&dd->pcidev->dev, size,
 				  pd->port_rcvegrbuf[e],
 				  pd->port_rcvegrbuf_phys[e]);
 
+	}
 	vfree(pd->port_rcvegrbuf_phys);
 	pd->port_rcvegrbuf_phys = NULL;
 bail_rcvegrbuf:
@@ -802,10 +804,7 @@ static int ipath_do_user_init(struct ipa
 {
 	int ret = 0;
 	struct ipath_devdata *dd = pd->port_dd;
-	u64 physaddr, uaddr, off, atmp;
-	struct page *pagep;
 	u32 head32;
-	u64 head;
 
 	/* for now, if major version is different, bail */
 	if ((uinfo->spu_userversion >> 16) != IPATH_USER_SWMAJOR) {
@@ -829,54 +828,6 @@ static int ipath_do_user_init(struct ipa
 	}
 
 	/* for now we do nothing with rcvhdrcnt: uinfo->spu_rcvhdrcnt */
-
-	/* set up for the rcvhdr Q tail register writeback to user memory */
-	if (!uinfo->spu_rcvhdraddr ||
-	    !access_ok(VERIFY_WRITE, (u64 __user *) (unsigned long)
-		       uinfo->spu_rcvhdraddr, sizeof(u64))) {
-		ipath_dbg("Port %d rcvhdrtail addr %llx not valid\n",
-			  pd->port_port,
-			  (unsigned long long) uinfo->spu_rcvhdraddr);
-		ret = -EINVAL;
-		goto done;
-	}
-
-	off = offset_in_page(uinfo->spu_rcvhdraddr);
-	uaddr = PAGE_MASK & (unsigned long) uinfo->spu_rcvhdraddr;
-	ret = ipath_get_user_pages_nocopy(uaddr, &pagep);
-	if (ret) {
-		dev_info(&dd->pcidev->dev, "Failed to lookup and lock "
-			 "address %llx for rcvhdrtail: errno %d\n",
-			 (unsigned long long) uinfo->spu_rcvhdraddr, -ret);
-		goto done;
-	}
-	ipath_stats.sps_pagelocks++;
-	pd->port_rcvhdrtail_uaddr = uaddr;
-	pd->port_rcvhdrtail_pagep = pagep;
-	pd->port_rcvhdrtail_kvaddr =
-		page_address(pagep);
-	pd->port_rcvhdrtail_kvaddr += off;
-	physaddr = page_to_phys(pagep) + off;
-	ipath_cdbg(VERBOSE, "port %d user addr %llx hdrtailaddr, %llx "
-		   "physical (off=%llx)\n",
-		   pd->port_port,
-		   (unsigned long long) uinfo->spu_rcvhdraddr,
-		   (unsigned long long) physaddr, (unsigned long long) off);
-	ipath_write_kreg_port(dd, dd->ipath_kregs->kr_rcvhdrtailaddr,
-			      pd->port_port, physaddr);
-	atmp = ipath_read_kreg64_port(dd,
-				      dd->ipath_kregs->kr_rcvhdrtailaddr,
-				      pd->port_port);
-	if (physaddr != atmp) {
-		ipath_dev_err(dd,
-			      "Catastrophic software error, "
-			      "RcvHdrTailAddr%u written as %llx, "
-			      "read back as %llx\n", pd->port_port,
-			      (unsigned long long) physaddr,
-			      (unsigned long long) atmp);
-		ret = -EINVAL;
-		goto done;
-	}
 
 	/* for right now, kernel piobufs are at end, so port 1 is at 0 */
 	pd->port_piobufs = dd->ipath_piobufbase +
@@ -896,26 +847,18 @@ static int ipath_do_user_init(struct ipa
 		ret = ipath_create_user_egr(pd);
 	if (ret)
 		goto done;
-	/* enable receives now */
-	/* atomically set enable bit for this port */
-	set_bit(INFINIPATH_R_PORTENABLE_SHIFT + pd->port_port,
-		&dd->ipath_rcvctrl);
 
 	/*
-	 * set the head registers for this port to the current values
+	 * set the eager head register for this port to the current values
 	 * of the tail pointers, since we don't know if they were
 	 * updated on last use of the port.
 	 */
-	head32 = ipath_read_ureg32(dd, ur_rcvhdrtail, pd->port_port);
-	head = (u64) head32;
-	ipath_write_ureg(dd, ur_rcvhdrhead, head, pd->port_port);
 	head32 = ipath_read_ureg32(dd, ur_rcvegrindextail, pd->port_port);
 	ipath_write_ureg(dd, ur_rcvegrindexhead, head32, pd->port_port);
 	dd->ipath_lastegrheads[pd->port_port] = -1;
 	dd->ipath_lastrcvhdrqtails[pd->port_port] = -1;
-	ipath_cdbg(VERBOSE, "Wrote port%d head %llx, egrhead %x from "
-		   "tail regs\n", pd->port_port,
-		   (unsigned long long) head, head32);
+	ipath_cdbg(VERBOSE, "Wrote port%d egrhead %x from tail regs\n",
+		pd->port_port, head32);
 	pd->port_tidcursor = 0;	/* start at beginning after open */
 	/*
 	 * now enable the port; the tail registers will be written to memory
@@ -924,13 +867,62 @@ static int ipath_do_user_init(struct ipa
 	 * transition from 0 to 1, so clear it first, then set it as part of
 	 * enabling the port.  This will (very briefly) affect any other
 	 * open ports, but it shouldn't be long enough to be an issue.
+	 * We explictly set the in-memory copy to 0 beforehand, so we don't
+	 * have to wait to be sure the DMA update has happened.
 	 */
+	*pd->port_rcvhdrtail_kvaddr = 0ULL;
+	set_bit(INFINIPATH_R_PORTENABLE_SHIFT + pd->port_port,
+		&dd->ipath_rcvctrl);
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_rcvctrl,
 			 dd->ipath_rcvctrl & ~INFINIPATH_R_TAILUPD);
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_rcvctrl,
 			 dd->ipath_rcvctrl);
-
 done:
+	return ret;
+}
+
+
+/* common code for the mappings on dma_alloc_coherent mem */
+static int ipath_mmap_mem(struct vm_area_struct *vma,
+			     struct ipath_portdata *pd, unsigned len,
+			     int write_ok, dma_addr_t addr, char *what)
+{
+	struct ipath_devdata *dd = pd->port_dd;
+	unsigned pfn = (unsigned long)addr >> PAGE_SHIFT;
+	int ret;
+
+	if ((vma->vm_end - vma->vm_start) > len) {
+		dev_info(&dd->pcidev->dev,
+		         "FAIL on %s: len %lx > %x\n", what,
+			 vma->vm_end - vma->vm_start, len);
+		ret = -EFAULT;
+		goto bail;
+	}
+
+	if(!write_ok) {
+		if (vma->vm_flags & VM_WRITE) {
+			dev_info(&dd->pcidev->dev,
+				 "%s must be mapped readonly\n", what);
+			ret = -EPERM;
+			goto bail;
+		}
+
+		/* don't allow them to later change with mprotect */
+		vma->vm_flags &= ~VM_MAYWRITE;
+	}
+
+	ret = remap_pfn_range(vma, vma->vm_start, pfn,
+			      len, vma->vm_page_prot);
+	if(ret)
+		dev_info(&dd->pcidev->dev,
+			 "%s port%u mmap of %lx, %x bytes r%c failed: %d\n",
+			 what, pd->port_port, (unsigned long)addr, len,
+			 write_ok?'w':'o', ret);
+	else
+		ipath_cdbg(VERBOSE, "%s port%u mmaped %lx, %x bytes r%c\n",
+			what, pd->port_port, (unsigned long)addr, len,
+			 write_ok?'w':'o');
+bail:
 	return ret;
 }
 
@@ -940,8 +932,11 @@ static int mmap_ureg(struct vm_area_stru
 	unsigned long phys;
 	int ret;
 
-	/* it's the real hardware, so io_remap works */
-
+	/*
+	 * This is real hardware, so use io_remap.  This is the mechanism
+	 * for the user process to update the head registers for their port
+	 * in the chip.
+	 */
 	if ((vma->vm_end - vma->vm_start) > PAGE_SIZE) {
 		dev_info(&dd->pcidev->dev, "FAIL mmap userreg: reqlen "
 			 "%lx > PAGE\n", vma->vm_end - vma->vm_start);
@@ -967,10 +962,11 @@ static int mmap_piobufs(struct vm_area_s
 	int ret;
 
 	/*
-	 * When we map the PIO buffers, we want to map them as writeonly, no
-	 * read possible.
+	 * When we map the PIO buffers in the chip, we want to map them as
+	 * writeonly, no read possible.   This prevents access to previous
+	 * process data, and catches users who might try to read the i/o
+	 * space due to a bug.
 	 */
-
 	if ((vma->vm_end - vma->vm_start) >
 	    (dd->ipath_pbufsport * dd->ipath_palign)) {
 		dev_info(&dd->pcidev->dev, "FAIL mmap piobufs: "
@@ -981,11 +977,10 @@ static int mmap_piobufs(struct vm_area_s
 	}
 
 	phys = dd->ipath_physaddr + pd->port_piobufs;
+
 	/*
-	 * Do *NOT* mark this as non-cached (PWT bit), or we don't get the
+	 * Don't mark this as non-cached, or we don't get the
 	 * write combining behavior we want on the PIO buffers!
-	 * vma->vm_page_prot =
-	 *        pgprot_noncached(vma->vm_page_prot);
 	 */
 
 	if (vma->vm_flags & VM_READ) {
@@ -997,8 +992,7 @@ static int mmap_piobufs(struct vm_area_s
 	}
 
 	/* don't allow them to later change to readable with mprotect */
-
-	vma->vm_flags &= ~VM_MAYWRITE;
+	vma->vm_flags &= ~VM_MAYREAD;
 	vma->vm_flags |= VM_DONTCOPY | VM_DONTEXPAND;
 
 	ret = io_remap_pfn_range(vma, vma->vm_start, phys >> PAGE_SHIFT,
@@ -1016,11 +1010,6 @@ static int mmap_rcvegrbufs(struct vm_are
 	size_t total_size, i;
 	dma_addr_t *phys;
 	int ret;
-
-	if (!pd->port_rcvegrbuf) {
-		ret = -EFAULT;
-		goto bail;
-	}
 
 	size = pd->port_rcvegrbuf_size;
 	total_size = pd->port_rcvegrbuf_chunks * size;
@@ -1039,12 +1028,11 @@ static int mmap_rcvegrbufs(struct vm_are
 		ret = -EPERM;
 		goto bail;
 	}
+	/* don't allow them to later change to writeable with mprotect */
+	vma->vm_flags &= ~VM_MAYWRITE;
 
 	start = vma->vm_start;
 	phys = pd->port_rcvegrbuf_phys;
-
-	/* don't allow them to later change to writeable with mprotect */
-	vma->vm_flags &= ~VM_MAYWRITE;
 
 	for (i = 0; i < pd->port_rcvegrbuf_chunks; i++, start += size) {
 		ret = remap_pfn_range(vma, start, phys[i] >> PAGE_SHIFT,
@@ -1054,78 +1042,6 @@ static int mmap_rcvegrbufs(struct vm_are
 	}
 	ret = 0;
 
-bail:
-	return ret;
-}
-
-static int mmap_rcvhdrq(struct vm_area_struct *vma,
-			struct ipath_portdata *pd)
-{
-	struct ipath_devdata *dd = pd->port_dd;
-	size_t total_size;
-	int ret;
-
-	/*
-	 * kmalloc'ed memory, physically contiguous; this is from
-	 * spi_rcvhdr_base; we allow user to map read-write so they can
-	 * write hdrq entries to allow protocol code to directly poll
-	 * whether a hdrq entry has been written.
-	 */
-	total_size = ALIGN(dd->ipath_rcvhdrcnt * dd->ipath_rcvhdrentsize *
-			   sizeof(u32), PAGE_SIZE);
-	if ((vma->vm_end - vma->vm_start) > total_size) {
-		dev_info(&dd->pcidev->dev,
-			 "FAIL on rcvhdrq: reqlen %lx > actual %lx\n",
-			 vma->vm_end - vma->vm_start,
-			 (unsigned long) total_size);
-		ret = -EFAULT;
-		goto bail;
-	}
-
-	ret = remap_pfn_range(vma, vma->vm_start,
-			      pd->port_rcvhdrq_phys >> PAGE_SHIFT,
-			      vma->vm_end - vma->vm_start,
-			      vma->vm_page_prot);
-bail:
-	return ret;
-}
-
-static int mmap_pioavailregs(struct vm_area_struct *vma,
-			     struct ipath_portdata *pd)
-{
-	struct ipath_devdata *dd = pd->port_dd;
-	int ret;
-
-	/*
-	 * when we map the PIO bufferavail registers, we want to map them as
-	 * readonly, no write possible.
-	 *
-	 * kmalloc'ed memory, physically contiguous, one page only, readonly
-	 */
-
-	if ((vma->vm_end - vma->vm_start) > PAGE_SIZE) {
-		dev_info(&dd->pcidev->dev, "FAIL on pioavailregs_dma: "
-			 "reqlen %lx > actual %lx\n",
-			 vma->vm_end - vma->vm_start,
-			 (unsigned long) PAGE_SIZE);
-		ret = -EFAULT;
-		goto bail;
-	}
-
-	if (vma->vm_flags & VM_WRITE) {
-		dev_info(&dd->pcidev->dev,
-			 "Can't map pioavailregs as writable (flags=%lx)\n",
-			 vma->vm_flags);
-		ret = -EPERM;
-		goto bail;
-	}
-
-	/* don't allow them to later change with mprotect */
-	vma->vm_flags &= ~VM_MAYWRITE;
-
-	ret = remap_pfn_range(vma, vma->vm_start,
-			      dd->ipath_pioavailregs_phys >> PAGE_SHIFT,
-			      PAGE_SIZE, vma->vm_page_prot);
 bail:
 	return ret;
 }
@@ -1149,6 +1065,7 @@ static int ipath_mmap(struct file *fp, s
 
 	pd = port_fp(fp);
 	dd = pd->port_dd;
+
 	/*
 	 * This is the ipath_do_user_init() code, mapping the shared buffers
 	 * into the user process. The address referred to by vm_pgoff is the
@@ -1158,28 +1075,59 @@ static int ipath_mmap(struct file *fp, s
 	pgaddr = vma->vm_pgoff << PAGE_SHIFT;
 
 	/*
-	 * note that ureg does *NOT* have the kregvirt as part of it, to be
-	 * sure that for 32 bit programs, we don't end up trying to map a >
-	 * 44 address.  Has to match ipath_get_base_info() code that sets
-	 * __spi_uregbase
+	 * Must fit in 40 bits for our hardware; some checked elsewhere,
+	 * but we'll be paranoid.  Check for 0 is mostly in case one of the
+	 * allocations failed, but user called mmap anyway.   We want to catch
+	 * that before it can match.
 	 */
-
+	if(!pgaddr || pgaddr >= (1ULL<<40))  {
+			ipath_dev_err(dd, "Bad physical address %llx, start %lx, end %lx\n",
+				(unsigned long long)pgaddr, vma->vm_start, vma->vm_end);
+			return -EINVAL;
+	}
+
+	/* just the offset of the port user registers, not physical addr */
 	ureg = dd->ipath_uregbase + dd->ipath_palign * pd->port_port;
 
 	ipath_cdbg(MM, "ushare: pgaddr %llx vm_start=%lx, vmlen %lx\n",
 		   (unsigned long long) pgaddr, vma->vm_start,
 		   vma->vm_end - vma->vm_start);
 
-	if (pgaddr == ureg)
+	if(vma->vm_start & (PAGE_SIZE-1)) {
+		ipath_dev_err(dd, 
+			"vm_start not aligned: %lx, end=%lx phys %lx\n",
+			vma->vm_start, vma->vm_end, (unsigned long)pgaddr);
+		ret = -EINVAL;
+	}
+	else if (pgaddr == ureg)
 		ret = mmap_ureg(vma, dd, ureg);
 	else if (pgaddr == pd->port_piobufs)
 		ret = mmap_piobufs(vma, dd, pd);
 	else if (pgaddr == (u64) pd->port_rcvegr_phys)
 		ret = mmap_rcvegrbufs(vma, pd);
-	else if (pgaddr == (u64) pd->port_rcvhdrq_phys)
-		ret = mmap_rcvhdrq(vma, pd);
+	else if (pgaddr == (u64) pd->port_rcvhdrq_phys) {
+		/*
+		 * The rcvhdrq itself; readonly except on HT-400 (so have
+		 * to allow writable mapping), multiple pages, contiguous
+		 * from an i/o perspective.
+		 */
+		unsigned total_size =
+			ALIGN(dd->ipath_rcvhdrcnt * dd->ipath_rcvhdrentsize
+			   * sizeof(u32), PAGE_SIZE);
+		ret = ipath_mmap_mem(vma, pd, total_size, 1,
+				     pd->port_rcvhdrq_phys,
+				     "rcvhdrq");
+	}
+	else if (pgaddr == (u64)pd->port_rcvhdrqtailaddr_phys)
+		/* in-memory copy of rcvhdrq tail register */
+		ret = ipath_mmap_mem(vma, pd, PAGE_SIZE, 0,
+				     pd->port_rcvhdrqtailaddr_phys,
+				     "rcvhdrq tail");
 	else if (pgaddr == dd->ipath_pioavailregs_phys)
-		ret = mmap_pioavailregs(vma, pd);
+		/* in-memory copy of pioavail registers */
+		ret = ipath_mmap_mem(vma, pd, PAGE_SIZE, 0,
+			      	     dd->ipath_pioavailregs_phys,
+				     "pioavail registers");
 	else
 		ret = -EINVAL;
 
@@ -1532,14 +1480,6 @@ static int ipath_close(struct inode *in,
 	}
 
 	if (dd->ipath_kregbase) {
-		if (pd->port_rcvhdrtail_uaddr) {
-			pd->port_rcvhdrtail_uaddr = 0;
-			pd->port_rcvhdrtail_kvaddr = NULL;
-			ipath_release_user_pages_on_close(
-				&pd->port_rcvhdrtail_pagep, 1);
-			pd->port_rcvhdrtail_pagep = NULL;
-			ipath_stats.sps_pageunlocks++;
-		}
 		ipath_write_kreg_port(
 			dd, dd->ipath_kregs->kr_rcvhdrtailaddr,
 			port, 0ULL);
@@ -1576,9 +1516,9 @@ static int ipath_close(struct inode *in,
 
 	dd->ipath_f_clear_tids(dd, pd->port_port);
 
-	ipath_free_pddata(dd, pd->port_port, 0);
-
+	dd->ipath_pd[pd->port_port] = NULL; /* before releasing mutex */
 	mutex_unlock(&ipath_mutex);
+	ipath_free_pddata(dd, pd); /* after releasing the mutex */
 
 	return ret;
 }
@@ -1908,3 +1848,4 @@ bail:
 bail:
 	return;
 }
+
diff -r 09077b2f476f -r e29625bd9050 drivers/infiniband/hw/ipath/ipath_init_chip.c
--- a/drivers/infiniband/hw/ipath/ipath_init_chip.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_init_chip.c	Fri May 12 15:55:28 2006 -0700
@@ -409,17 +409,8 @@ static int init_pioavailregs(struct ipat
 	/* and its length */
 	dd->ipath_freezelen = L1_CACHE_BYTES - sizeof(dd->ipath_statusp[0]);
 
-	if (dd->ipath_unit * 64 > (IPATH_PORT0_RCVHDRTAIL_SIZE - 64)) {
-		ipath_dev_err(dd, "unit %u too large for port 0 "
-			      "rcvhdrtail buffer size\n", dd->ipath_unit);
-		ret = -ENODEV;
-	}
-	else
-		ret = 0;
-
-	/* so we can get current tail in ipath_kreceive(), per chip */
-	dd->ipath_hdrqtailptr = &ipath_port0_rcvhdrtail[
-		dd->ipath_unit * (64 / sizeof(*ipath_port0_rcvhdrtail))];
+	ret = 0;
+
 done:
 	return ret;
 }
@@ -652,7 +643,7 @@ int ipath_init_chip(struct ipath_devdata
 {
 	int ret = 0, i;
 	u32 val32, kpiobufs;
-	u64 val, atmp;
+	u64 val;
 	struct ipath_portdata *pd = NULL; /* keep gcc4 happy */
 
 	ret = init_housekeeping(dd, &pd, reinit);
@@ -775,24 +766,6 @@ int ipath_init_chip(struct ipath_devdata
 		goto done;
 	}
 
-	val = ipath_port0_rcvhdrtail_dma + dd->ipath_unit * 64;
-
-	/* verify that the alignment requirement was met */
-	ipath_write_kreg_port(dd, dd->ipath_kregs->kr_rcvhdrtailaddr,
-			      0, val);
-	atmp = ipath_read_kreg64_port(
-		dd, dd->ipath_kregs->kr_rcvhdrtailaddr, 0);
-	if (val != atmp) {
-		ipath_dev_err(dd, "Catastrophic software error, "
-			      "RcvHdrTailAddr0 written as %llx, "
-			      "read back as %llx from %x\n",
-			      (unsigned long long) val,
-			      (unsigned long long) atmp,
-			      dd->ipath_kregs->kr_rcvhdrtailaddr);
-		ret = -EINVAL;
-		goto done;
-	}
-
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_rcvbthqp, IPATH_KD_QP);
 
 	/*
@@ -841,12 +814,18 @@ int ipath_init_chip(struct ipath_devdata
 	 * re-init, the simplest way to handle this is to free
 	 * existing, and re-allocate.
 	 */
-	if (reinit)
-		ipath_free_pddata(dd, 0, 0);
+	if (reinit) {
+		struct ipath_portdata *pd = dd->ipath_pd[0];
+		dd->ipath_pd[0] = NULL;
+		ipath_free_pddata(dd, pd);
+	}
 	dd->ipath_f_tidtemplate(dd);
 	ret = ipath_create_rcvhdrq(dd, pd);
-	if (!ret)
+	if (!ret) {
+		dd->ipath_hdrqtailptr =
+			(volatile __le64 *)pd->port_rcvhdrtail_kvaddr;
 		ret = create_port0_egr(dd);
+	}
 	if (ret)
 		ipath_dev_err(dd, "failed to allocate port 0 (kernel) "
 			      "rcvhdrq and/or egr bufs\n");
diff -r 09077b2f476f -r e29625bd9050 drivers/infiniband/hw/ipath/ipath_intr.c
--- a/drivers/infiniband/hw/ipath/ipath_intr.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_intr.c	Fri May 12 15:55:28 2006 -0700
@@ -36,6 +36,7 @@
 #include "ips_common.h"
 #include "ipath_layer.h"
 
+/* These are all rcv-related errors which we want to count for stats */
 #define E_SUM_PKTERRS \
 	(INFINIPATH_E_RHDRLEN | INFINIPATH_E_RBADTID | \
 	 INFINIPATH_E_RBADVERSION | INFINIPATH_E_RHDR | \
@@ -44,12 +45,25 @@
 	 INFINIPATH_E_RFORMATERR | INFINIPATH_E_RUNSUPVL | \
 	 INFINIPATH_E_RUNEXPCHAR | INFINIPATH_E_REBP)
 
+/* These are all send-related errors which we want to count for stats */
 #define E_SUM_ERRS \
 	(INFINIPATH_E_SPIOARMLAUNCH | INFINIPATH_E_SUNEXPERRPKTNUM | \
 	 INFINIPATH_E_SDROPPEDDATAPKT | INFINIPATH_E_SDROPPEDSMPPKT | \
 	 INFINIPATH_E_SMAXPKTLEN | INFINIPATH_E_SUNSUPVL | \
 	 INFINIPATH_E_SMINPKTLEN | INFINIPATH_E_SPKTLEN | \
 	 INFINIPATH_E_INVALIDADDR)
+
+/*
+ * these are errors that can occur when the link changes state while
+ * a packet is being sent or received.  This doesn't cover things
+ * like EBP or VCRC that can be the result of a sending having the
+ * link change state, so we receive a "known bad" packet.
+ */
+#define E_SUM_LINK_PKTERRS \
+	(INFINIPATH_E_SDROPPEDDATAPKT | INFINIPATH_E_SDROPPEDSMPPKT | \
+	 INFINIPATH_E_SMINPKTLEN | INFINIPATH_E_SPKTLEN | \
+	 INFINIPATH_E_RSHORTPKTLEN | INFINIPATH_E_RMINPKTLEN | \
+	 INFINIPATH_E_RUNEXPCHAR)
 
 static u64 handle_e_sum_errs(struct ipath_devdata *dd, ipath_err_t errs)
 {
@@ -100,9 +114,7 @@ static u64 handle_e_sum_errs(struct ipat
 		if (ipath_debug & __IPATH_PKTDBG)
 			printk("\n");
 	}
-	if ((errs & (INFINIPATH_E_SDROPPEDDATAPKT |
-		     INFINIPATH_E_SDROPPEDSMPPKT |
-		     INFINIPATH_E_SMINPKTLEN)) &&
+	if ((errs & E_SUM_LINK_PKTERRS) &&
 	    !(dd->ipath_flags & IPATH_LINKACTIVE)) {
 		/*
 		 * This can happen when SMA is trying to bring the link
@@ -111,11 +123,9 @@ static u64 handle_e_sum_errs(struct ipat
 		 * valid.  We don't want to confuse people, so we just
 		 * don't print them, except at debug
 		 */
-		ipath_dbg("Ignoring pktsend errors %llx, because not "
-			  "yet active\n", (unsigned long long) errs);
-		ignore_this_time = INFINIPATH_E_SDROPPEDDATAPKT |
-			INFINIPATH_E_SDROPPEDSMPPKT |
-			INFINIPATH_E_SMINPKTLEN;
+		ipath_dbg("Ignoring packet errors %llx, because link not "
+			  "ACTIVE\n", (unsigned long long) errs);
+		ignore_this_time = errs & E_SUM_LINK_PKTERRS;
 	}
 
 	return ignore_this_time;
@@ -156,7 +166,29 @@ static void handle_e_ibstatuschanged(str
 	 */
 	val = ipath_read_kreg64(dd, dd->ipath_kregs->kr_ibcstatus);
 	lstate = val & IPATH_IBSTATE_MASK;
-	if (lstate == IPATH_IBSTATE_INIT || lstate == IPATH_IBSTATE_ARM ||
+
+	/*
+	 * this is confusing enough when it happens that I want to always put it
+	 * on the console and in the logs.  If it was a requested state change,
+	 * we'll have already cleared the flags, so we won't print this warning
+	 */
+	if ((lstate != IPATH_IBSTATE_ARM && lstate != IPATH_IBSTATE_ACTIVE)
+		&& (dd->ipath_flags & (IPATH_LINKARMED | IPATH_LINKACTIVE))) {
+		dev_info(&dd->pcidev->dev, "Link state changed from %s to %s\n",
+				 (dd->ipath_flags & IPATH_LINKARMED) ? "ARM" : "ACTIVE",
+				 ib_linkstate(lstate));
+		/*
+		 * Flush all queued sends when link went to DOWN or INIT,
+		 * to be sure that they don't block SMA and other MAD packets
+		 */
+		ipath_write_kreg(dd, dd->ipath_kregs->kr_sendctrl,
+				 INFINIPATH_S_ABORT);
+		ipath_disarm_piobufs(dd, dd->ipath_lastport_piobuf,
+							(unsigned)(dd->ipath_piobcnt2k +
+					dd->ipath_piobcnt4k) -
+					dd->ipath_lastport_piobuf);
+	}
+	else if (lstate == IPATH_IBSTATE_INIT || lstate == IPATH_IBSTATE_ARM ||
 	    lstate == IPATH_IBSTATE_ACTIVE) {
 		/*
 		 * only print at SMA if there is a change, debug if not
@@ -379,6 +411,19 @@ static int handle_errors(struct ipath_de
 
 	if (errs & E_SUM_ERRS)
 		ignore_this_time = handle_e_sum_errs(dd, errs);
+	else if ((errs & E_SUM_LINK_PKTERRS) &&
+	    !(dd->ipath_flags & IPATH_LINKACTIVE)) {
+		/*
+		 * This can happen when SMA is trying to bring the link
+		 * up, but the IB link changes state at the "wrong" time.
+		 * The IB logic then complains that the packet isn't
+		 * valid.  We don't want to confuse people, so we just
+		 * don't print them, except at debug
+		 */
+		ipath_dbg("Ignoring packet errors %llx, because link not "
+			  "ACTIVE\n", (unsigned long long) errs);
+		ignore_this_time = errs & E_SUM_LINK_PKTERRS;
+	}
 
 	if (supp_msgs == 250000) {
 		/*
diff -r 09077b2f476f -r e29625bd9050 drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri May 12 15:55:28 2006 -0700
@@ -61,9 +61,7 @@ struct ipath_portdata {
 	/* rcvhdrq base, needs mmap before useful */
 	void *port_rcvhdrq;
 	/* kernel virtual address where hdrqtail is updated */
-	u64 *port_rcvhdrtail_kvaddr;
-	/* page * used for uaddr */
-	struct page *port_rcvhdrtail_pagep;
+	volatile __le64 *port_rcvhdrtail_kvaddr;
 	/*
 	 * temp buffer for expected send setup, allocated at open, instead
 	 * of each setup call
@@ -78,11 +76,7 @@ struct ipath_portdata {
 	dma_addr_t port_rcvegr_phys;
 	/* mmap of hdrq, must fit in 44 bits */
 	dma_addr_t port_rcvhdrq_phys;
-	/*
-	 * the actual user address that we ipath_mlock'ed, so we can
-	 * ipath_munlock it at close
-	 */
-	unsigned long port_rcvhdrtail_uaddr;
+	dma_addr_t port_rcvhdrqtailaddr_phys;
 	/*
 	 * number of opens on this instance (0 or 1; ignoring forks, dup,
 	 * etc. for now)
@@ -167,7 +161,6 @@ struct ipath_devdata {
 	 * only written to by the chip, not the driver.
 	 */
 	volatile __le64 *ipath_hdrqtailptr;
-	dma_addr_t ipath_dma_addr;
 	/* ipath_cfgports pointers */
 	struct ipath_portdata **ipath_pd;
 	/* sk_buffs used by port 0 eager receive queue */
@@ -518,10 +511,6 @@ struct ipath_devdata {
 	u8 ipath_lmc;
 };
 
-extern volatile __le64 *ipath_port0_rcvhdrtail;
-extern dma_addr_t ipath_port0_rcvhdrtail_dma;
-
-#define IPATH_PORT0_RCVHDRTAIL_SIZE PAGE_SIZE
 
 extern struct list_head ipath_dev_list;
 extern spinlock_t ipath_devs_lock;
@@ -582,7 +571,7 @@ void ipath_disarm_piobufs(struct ipath_d
 			  unsigned cnt);
 
 int ipath_create_rcvhdrq(struct ipath_devdata *, struct ipath_portdata *);
-void ipath_free_pddata(struct ipath_devdata *, u32, int);
+void ipath_free_pddata(struct ipath_devdata *, struct ipath_portdata *);
 
 int ipath_parse_ushort(const char *str, unsigned short *valp);
 
