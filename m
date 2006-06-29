Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932955AbWF2V4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932955AbWF2V4z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932939AbWF2Vwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:52:41 -0400
Received: from mx.pathscale.com ([64.160.42.68]:38543 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932907AbWF2VoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:10 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 30 of 39] IB/ipath - purge sps_lid and sps_mlid arrays
X-Mercurial-Node: 3ceb73f8bde0e0335b54c166cafa34750ddacb02
Message-Id: <3ceb73f8bde0e0335b54.1151617281@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:41:21 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The two arrays only had space for 4 units.

Also changed from ipath_set_sps_lid() to ipath_set_lid(); the sps
was leftover.

Signed-off-by: Dave Olson <dave.olson@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 1bef8244297a -r 3ceb73f8bde0 drivers/infiniband/hw/ipath/ipath_common.h
--- a/drivers/infiniband/hw/ipath/ipath_common.h	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_common.h	Thu Jun 29 14:33:26 2006 -0700
@@ -122,8 +122,7 @@ struct infinipath_stats {
 	__u64 sps_ports;
 	/* list of pkeys (other than default) accepted (0 means not set) */
 	__u16 sps_pkeys[4];
-	/* lids for up to 4 infinipaths, indexed by infinipath # */
-	__u16 sps_lid[4];
+	__u16 sps_unused16[4]; /* available; maintaining compatible layout */
 	/* number of user ports per chip (not IB ports) */
 	__u32 sps_nports;
 	/* not our interrupt, or already handled */
@@ -141,10 +140,8 @@ struct infinipath_stats {
 	 * packets if ipath not configured, sma/mad, etc.)
 	 */
 	__u64 sps_krdrops;
-	/* mlids for up to 4 infinipaths, indexed by infinipath # */
-	__u16 sps_mlid[4];
 	/* pad for future growth */
-	__u64 __sps_pad[45];
+	__u64 __sps_pad[46];
 };
 
 /*
diff -r 1bef8244297a -r 3ceb73f8bde0 drivers/infiniband/hw/ipath/ipath_init_chip.c
--- a/drivers/infiniband/hw/ipath/ipath_init_chip.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_init_chip.c	Thu Jun 29 14:33:26 2006 -0700
@@ -811,8 +811,6 @@ int ipath_init_chip(struct ipath_devdata
 	/* clear any interrups up to this point (ints still not enabled) */
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_intclear, -1LL);
 
-	ipath_stats.sps_lid[dd->ipath_unit] = dd->ipath_lid;
-
 	/*
 	 * Set up the port 0 (kernel) rcvhdr q and egr TIDs.  If doing
 	 * re-init, the simplest way to handle this is to free
diff -r 1bef8244297a -r 3ceb73f8bde0 drivers/infiniband/hw/ipath/ipath_layer.c
--- a/drivers/infiniband/hw/ipath/ipath_layer.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_layer.c	Thu Jun 29 14:33:26 2006 -0700
@@ -300,9 +300,8 @@ bail:
 
 EXPORT_SYMBOL_GPL(ipath_layer_set_mtu);
 
-int ipath_set_sps_lid(struct ipath_devdata *dd, u32 arg, u8 lmc)
-{
-	ipath_stats.sps_lid[dd->ipath_unit] = arg;
+int ipath_set_lid(struct ipath_devdata *dd, u32 arg, u8 lmc)
+{
 	dd->ipath_lid = arg;
 	dd->ipath_lmc = lmc;
 
@@ -316,7 +315,7 @@ int ipath_set_sps_lid(struct ipath_devda
 	return 0;
 }
 
-EXPORT_SYMBOL_GPL(ipath_set_sps_lid);
+EXPORT_SYMBOL_GPL(ipath_set_lid);
 
 int ipath_layer_set_guid(struct ipath_devdata *dd, __be64 guid)
 {
@@ -632,9 +631,9 @@ int ipath_layer_open(struct ipath_devdat
 
 	if (*dd->ipath_statusp & IPATH_STATUS_IB_READY)
 		intval |= IPATH_LAYER_INT_IF_UP;
-	if (ipath_stats.sps_lid[dd->ipath_unit])
+	if (dd->ipath_lid)
 		intval |= IPATH_LAYER_INT_LID;
-	if (ipath_stats.sps_mlid[dd->ipath_unit])
+	if (dd->ipath_mlid)
 		intval |= IPATH_LAYER_INT_BCAST;
 	/*
 	 * do this on open, in case low level is already up and
diff -r 1bef8244297a -r 3ceb73f8bde0 drivers/infiniband/hw/ipath/ipath_layer.h
--- a/drivers/infiniband/hw/ipath/ipath_layer.h	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_layer.h	Thu Jun 29 14:33:26 2006 -0700
@@ -129,7 +129,7 @@ u32 ipath_layer_get_cr_errpkey(struct ip
 u32 ipath_layer_get_cr_errpkey(struct ipath_devdata *dd);
 int ipath_layer_set_linkstate(struct ipath_devdata *dd, u8 state);
 int ipath_layer_set_mtu(struct ipath_devdata *, u16);
-int ipath_set_sps_lid(struct ipath_devdata *, u32, u8);
+int ipath_set_lid(struct ipath_devdata *, u32, u8);
 int ipath_layer_send_hdr(struct ipath_devdata *dd,
 			 struct ether_header *hdr);
 int ipath_verbs_send(struct ipath_devdata *dd, u32 hdrwords,
diff -r 1bef8244297a -r 3ceb73f8bde0 drivers/infiniband/hw/ipath/ipath_mad.c
--- a/drivers/infiniband/hw/ipath/ipath_mad.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_mad.c	Thu Jun 29 14:33:26 2006 -0700
@@ -308,7 +308,7 @@ static int recv_subn_set_portinfo(struct
 		/* Must be a valid unicast LID address. */
 		if (lid == 0 || lid >= IPS_MULTICAST_LID_BASE)
 			goto err;
-		ipath_set_sps_lid(dev->dd, lid, pip->mkeyprot_resv_lmc & 7);
+		ipath_set_lid(dev->dd, lid, pip->mkeyprot_resv_lmc & 7);
 		event.event = IB_EVENT_LID_CHANGE;
 		ib_dispatch_event(&event);
 	}
diff -r 1bef8244297a -r 3ceb73f8bde0 drivers/infiniband/hw/ipath/ipath_sysfs.c
--- a/drivers/infiniband/hw/ipath/ipath_sysfs.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_sysfs.c	Thu Jun 29 14:33:26 2006 -0700
@@ -115,11 +115,6 @@ DRIVER_STAT(pkey1, pkeys[1]);
 DRIVER_STAT(pkey1, pkeys[1]);
 DRIVER_STAT(pkey2, pkeys[2]);
 DRIVER_STAT(pkey3, pkeys[3]);
-/* XXX fix the following when dynamic table of devices used */
-DRIVER_STAT(lid0, lid[0]);
-DRIVER_STAT(lid1, lid[1]);
-DRIVER_STAT(lid2, lid[2]);
-DRIVER_STAT(lid3, lid[3]);
 
 DRIVER_STAT(nports, nports);
 DRIVER_STAT(null_intr, nullintr);
@@ -128,11 +123,6 @@ DRIVER_STAT(page_locks, pagelocks);
 DRIVER_STAT(page_locks, pagelocks);
 DRIVER_STAT(page_unlocks, pageunlocks);
 DRIVER_STAT(krdrops, krdrops);
-/* XXX fix the following when dynamic table of devices used */
-DRIVER_STAT(mlid0, mlid[0]);
-DRIVER_STAT(mlid1, mlid[1]);
-DRIVER_STAT(mlid2, mlid[2]);
-DRIVER_STAT(mlid3, mlid[3]);
 
 static struct attribute *driver_stat_attributes[] = {
 	&driver_attr_intrs.attr,
@@ -155,10 +145,6 @@ static struct attribute *driver_stat_att
 	&driver_attr_pkey1.attr,
 	&driver_attr_pkey2.attr,
 	&driver_attr_pkey3.attr,
-	&driver_attr_lid0.attr,
-	&driver_attr_lid1.attr,
-	&driver_attr_lid2.attr,
-	&driver_attr_lid3.attr,
 	&driver_attr_nports.attr,
 	&driver_attr_null_intr.attr,
 	&driver_attr_max_pkts_call.attr,
@@ -166,10 +152,6 @@ static struct attribute *driver_stat_att
 	&driver_attr_page_locks.attr,
 	&driver_attr_page_unlocks.attr,
 	&driver_attr_krdrops.attr,
-	&driver_attr_mlid0.attr,
-	&driver_attr_mlid1.attr,
-	&driver_attr_mlid2.attr,
-	&driver_attr_mlid3.attr,
 	NULL
 };
 
@@ -273,7 +255,7 @@ static ssize_t store_lid(struct device *
 			  size_t count)
 {
 	struct ipath_devdata *dd = dev_get_drvdata(dev);
-	u16 lid;
+	u16 lid = 0;
 	int ret;
 
 	ret = ipath_parse_ushort(buf, &lid);
@@ -285,11 +267,11 @@ static ssize_t store_lid(struct device *
 		goto invalid;
 	}
 
-	ipath_set_sps_lid(dd, lid, 0);
+	ipath_set_lid(dd, lid, 0);
 
 	goto bail;
 invalid:
-	ipath_dev_err(dd, "attempt to set invalid LID\n");
+	ipath_dev_err(dd, "attempt to set invalid LID 0x%x\n", lid);
 bail:
 	return ret;
 }
@@ -320,7 +302,6 @@ static ssize_t store_mlid(struct device 
 	unit = dd->ipath_unit;
 
 	dd->ipath_mlid = mlid;
-	ipath_stats.sps_mlid[unit] = mlid;
 	ipath_layer_intr(dd, IPATH_LAYER_INT_BCAST);
 
 	goto bail;
