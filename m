Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932929AbWF2Vrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932929AbWF2Vrj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932919AbWF2Vrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:47:37 -0400
Received: from mx.pathscale.com ([64.160.42.68]:39567 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932910AbWF2VoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:10 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 34 of 39] IB/ipath - fix a bug that results in addresses near
	0 being written via DMA
X-Mercurial-Node: b6ebaf2dd2fddbd384f1e1e8e5f12da565353d02
Message-Id: <b6ebaf2dd2fddbd384f1.1151617285@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:41:25 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We can't tell for sure if any packets are in the infinipath receive buffer
when we shut down a chip port.   Normally this is taken care of by orderly
shutdown, but when processes are terminated, or sending process has a bug,
we can continue to receive packets.   So rather than writing zero to the
address registers for the closing port, we point it at a dummy memory.

Signed-off-by: Dave Olson <dave.olson@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r a7c1ad1e090b -r b6ebaf2dd2fd drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Jun 29 14:33:26 2006 -0700
@@ -1824,6 +1824,12 @@ static void cleanup_device(struct ipath_
 				  dd->ipath_pioavailregs_phys);
 		dd->ipath_pioavailregs_dma = NULL;
 	}
+	if (dd->ipath_dummy_hdrq) {
+		dma_free_coherent(&dd->pcidev->dev,
+			dd->ipath_pd[0]->port_rcvhdrq_size,
+			dd->ipath_dummy_hdrq, dd->ipath_dummy_hdrq_phys);
+		dd->ipath_dummy_hdrq = NULL;
+	}
 
 	if (dd->ipath_pageshadow) {
 		struct page **tmpp = dd->ipath_pageshadow;
diff -r a7c1ad1e090b -r b6ebaf2dd2fd drivers/infiniband/hw/ipath/ipath_file_ops.c
--- a/drivers/infiniband/hw/ipath/ipath_file_ops.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_file_ops.c	Thu Jun 29 14:33:26 2006 -0700
@@ -1486,41 +1486,50 @@ static int ipath_close(struct inode *in,
 	}
 
 	if (dd->ipath_kregbase) {
-		ipath_write_kreg_port(
-			dd, dd->ipath_kregs->kr_rcvhdrtailaddr,
-			port, 0ULL);
-		ipath_write_kreg_port(
-			dd, dd->ipath_kregs->kr_rcvhdraddr,
-			pd->port_port, 0);
+		int i;
+		/* atomically clear receive enable port. */
+		clear_bit(INFINIPATH_R_PORTENABLE_SHIFT + port,
+			  &dd->ipath_rcvctrl);
+		ipath_write_kreg( dd, dd->ipath_kregs->kr_rcvctrl,
+			dd->ipath_rcvctrl);
+		/* and read back from chip to be sure that nothing
+		 * else is in flight when we do the rest */
+		(void)ipath_read_kreg64(dd, dd->ipath_kregs->kr_scratch);
 
 		/* clean up the pkeys for this port user */
 		ipath_clean_part_key(pd, dd);
 
-		if (port < dd->ipath_cfgports) {
-			int i = dd->ipath_pbufsport * (port - 1);
-			ipath_disarm_piobufs(dd, i, dd->ipath_pbufsport);
-
-			/* atomically clear receive enable port. */
-			clear_bit(INFINIPATH_R_PORTENABLE_SHIFT + port,
-				  &dd->ipath_rcvctrl);
-			ipath_write_kreg(
-				dd,
-				dd->ipath_kregs->kr_rcvctrl,
-				dd->ipath_rcvctrl);
-
-			if (dd->ipath_pageshadow)
-				unlock_expected_tids(pd);
-			ipath_stats.sps_ports--;
-			ipath_cdbg(PROC, "%s[%u] closed port %u:%u\n",
-				   pd->port_comm, pd->port_pid,
-				   dd->ipath_unit, port);
-		}
+
+		/*
+		 * be paranoid, and never write 0's to these, just use an
+		 * unused part of the port 0 tail page.  Of course,
+		 * rcvhdraddr points to a large chunk of memory, so this
+		 * could still trash things, but at least it won't trash
+		 * page 0, and by disabling the port, it should stop "soon",
+		 * even if a packet or two is in already in flight after we
+		 * disabled the port.
+		 */
+		ipath_write_kreg_port(dd,
+		        dd->ipath_kregs->kr_rcvhdrtailaddr, port,
+			dd->ipath_dummy_hdrq_phys);
+		ipath_write_kreg_port(dd, dd->ipath_kregs->kr_rcvhdraddr,
+			pd->port_port, dd->ipath_dummy_hdrq_phys);
+
+		i = dd->ipath_pbufsport * (port - 1);
+		ipath_disarm_piobufs(dd, i, dd->ipath_pbufsport);
+
+		if (dd->ipath_pageshadow)
+			unlock_expected_tids(pd);
+		ipath_stats.sps_ports--;
+		ipath_cdbg(PROC, "%s[%u] closed port %u:%u\n",
+			   pd->port_comm, pd->port_pid,
+			   dd->ipath_unit, port);
+
+		dd->ipath_f_clear_tids(dd, pd->port_port);
 	}
 
 	pd->port_cnt = 0;
 	pd->port_pid = 0;
-
-	dd->ipath_f_clear_tids(dd, pd->port_port);
 
 	dd->ipath_pd[pd->port_port] = NULL; /* before releasing mutex */
 	mutex_unlock(&ipath_mutex);
diff -r a7c1ad1e090b -r b6ebaf2dd2fd drivers/infiniband/hw/ipath/ipath_init_chip.c
--- a/drivers/infiniband/hw/ipath/ipath_init_chip.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_init_chip.c	Thu Jun 29 14:33:26 2006 -0700
@@ -647,6 +647,7 @@ int ipath_init_chip(struct ipath_devdata
 	u32 val32, kpiobufs;
 	u64 val;
 	struct ipath_portdata *pd = NULL; /* keep gcc4 happy */
+	gfp_t gfp_flags = GFP_USER | __GFP_COMP;
 
 	ret = init_housekeeping(dd, &pd, reinit);
 	if (ret)
@@ -833,6 +834,22 @@ int ipath_init_chip(struct ipath_devdata
 			      "rcvhdrq and/or egr bufs\n");
 	else
 		enable_chip(dd, pd, reinit);
+
+
+	if (!ret && !reinit) {
+	    /* used when we close a port, for DMA already in flight at close */
+		dd->ipath_dummy_hdrq = dma_alloc_coherent(
+			&dd->pcidev->dev, pd->port_rcvhdrq_size,
+			&dd->ipath_dummy_hdrq_phys,
+			gfp_flags);
+		if (!dd->ipath_dummy_hdrq ) {
+			dev_info(&dd->pcidev->dev,
+				"Couldn't allocate 0x%lx bytes for dummy hdrq\n",
+				pd->port_rcvhdrq_size);
+			/* fallback to just 0'ing */
+			dd->ipath_dummy_hdrq_phys = 0UL;
+		}
+	}
 
 	/*
 	 * cause retrigger of pending interrupts ignored during init,
diff -r a7c1ad1e090b -r b6ebaf2dd2fd drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Jun 29 14:33:26 2006 -0700
@@ -352,6 +352,8 @@ struct ipath_devdata {
 	/* check for stale messages in rcv queue */
 	/* only allow one intr at a time. */
 	unsigned long ipath_rcv_pending;
+	void *ipath_dummy_hdrq;	/* used after port close */
+	dma_addr_t ipath_dummy_hdrq_phys;
 
 	/*
 	 * Shadow copies of registers; size indicates read access size.
