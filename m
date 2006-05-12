Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWELXpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWELXpJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWELXog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:44:36 -0400
Received: from mx.pathscale.com ([64.160.42.68]:33449 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932187AbWELXoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:32 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 2 of 53] ipath - purge sps_lid and sps_mlid arrays,
	and /sys entries
X-Mercurial-Node: 3ab7a7b10bf2ec62ee0e148e8078474cec581c92
Message-Id: <3ab7a7b10bf2ec62ee0e.1147477367@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:42:47 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The two arrays only had space for 4 units, so didn't work for larger
numbers of units.  I thought I'd eliminated these before submitting the
original driver patches.

Also fixed error return on ipath_sysfs_unit_write to not set an error
code if the sysfs code reports consuming more chars than we wrote (since
that can include the nul, and the user doesn't have to include the nul
in the write).

Also changed from ipath_set_sps_lid() to ipath_set_lid(); the sps
was a leftover piece of naming.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 9b9f24aab350 -r 3ab7a7b10bf2 drivers/infiniband/hw/ipath/ipath_common.h
--- a/drivers/infiniband/hw/ipath/ipath_common.h	Fri May 12 15:55:27 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_common.h	Fri May 12 15:55:27 2006 -0700
@@ -121,8 +121,7 @@ struct infinipath_stats {
 	__u64 sps_ports;
 	/* list of pkeys (other than default) accepted (0 means not set) */
 	__u16 sps_pkeys[4];
-	/* lids for up to 4 infinipaths, indexed by infinipath # */
-	__u16 sps_lid[4];
+	__u16 sps_unused16[4]; /* available; maintaining compatible layout */
 	/* number of user ports per chip (not IB ports) */
 	__u32 sps_nports;
 	/* not our interrupt, or already handled */
@@ -140,10 +139,8 @@ struct infinipath_stats {
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
diff -r 9b9f24aab350 -r 3ab7a7b10bf2 drivers/infiniband/hw/ipath/ipath_init_chip.c
--- a/drivers/infiniband/hw/ipath/ipath_init_chip.c	Fri May 12 15:55:27 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_init_chip.c	Fri May 12 15:55:27 2006 -0700
@@ -836,8 +836,6 @@ int ipath_init_chip(struct ipath_devdata
 	/* clear any interrups up to this point (ints still not enabled) */
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_intclear, -1LL);
 
-	ipath_stats.sps_lid[dd->ipath_unit] = dd->ipath_lid;
-
 	/*
 	 * Set up the port 0 (kernel) rcvhdr q and egr TIDs.  If doing
 	 * re-init, the simplest way to handle this is to free
diff -r 9b9f24aab350 -r 3ab7a7b10bf2 drivers/infiniband/hw/ipath/ipath_layer.c
--- a/drivers/infiniband/hw/ipath/ipath_layer.c	Fri May 12 15:55:27 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_layer.c	Fri May 12 15:55:27 2006 -0700
@@ -299,9 +299,8 @@ bail:
 
 EXPORT_SYMBOL_GPL(ipath_layer_set_mtu);
 
-int ipath_set_sps_lid(struct ipath_devdata *dd, u32 arg, u8 lmc)
-{
-	ipath_stats.sps_lid[dd->ipath_unit] = arg;
+int ipath_set_lid(struct ipath_devdata *dd, u32 arg, u8 lmc)
+{
 	dd->ipath_lid = arg;
 	dd->ipath_lmc = lmc;
 
@@ -315,7 +314,7 @@ int ipath_set_sps_lid(struct ipath_devda
 	return 0;
 }
 
-EXPORT_SYMBOL_GPL(ipath_set_sps_lid);
+EXPORT_SYMBOL_GPL(ipath_set_lid);
 
 int ipath_layer_set_guid(struct ipath_devdata *dd, __be64 guid)
 {
@@ -616,9 +615,9 @@ int ipath_layer_open(struct ipath_devdat
 
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
diff -r 9b9f24aab350 -r 3ab7a7b10bf2 drivers/infiniband/hw/ipath/ipath_layer.h
--- a/drivers/infiniband/hw/ipath/ipath_layer.h	Fri May 12 15:55:27 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_layer.h	Fri May 12 15:55:27 2006 -0700
@@ -126,7 +126,7 @@ u32 ipath_layer_get_cr_errpkey(struct ip
 u32 ipath_layer_get_cr_errpkey(struct ipath_devdata *dd);
 int ipath_layer_set_linkstate(struct ipath_devdata *dd, u8 state);
 int ipath_layer_set_mtu(struct ipath_devdata *, u16);
-int ipath_set_sps_lid(struct ipath_devdata *, u32, u8);
+int ipath_set_lid(struct ipath_devdata *, u32, u8);
 int ipath_layer_send_hdr(struct ipath_devdata *dd,
 			 struct ether_header *hdr);
 int ipath_verbs_send(struct ipath_devdata *dd, u32 hdrwords,
diff -r 9b9f24aab350 -r 3ab7a7b10bf2 drivers/infiniband/hw/ipath/ipath_mad.c
--- a/drivers/infiniband/hw/ipath/ipath_mad.c	Fri May 12 15:55:27 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_mad.c	Fri May 12 15:55:27 2006 -0700
@@ -341,7 +341,7 @@ static int recv_subn_set_portinfo(struct
 		/* Must be a valid unicast LID address. */
 		if (lid == 0 || lid >= IPS_MULTICAST_LID_BASE)
 			goto err;
-		ipath_set_sps_lid(dev->dd, lid, pip->mkeyprot_resv_lmc & 7);
+		ipath_set_lid(dev->dd, lid, pip->mkeyprot_resv_lmc & 7);
 		event.event = IB_EVENT_LID_CHANGE;
 		ib_dispatch_event(&event);
 	}
diff -r 9b9f24aab350 -r 3ab7a7b10bf2 drivers/infiniband/hw/ipath/ipath_sysfs.c
--- a/drivers/infiniband/hw/ipath/ipath_sysfs.c	Fri May 12 15:55:27 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_sysfs.c	Fri May 12 15:55:27 2006 -0700
@@ -84,98 +84,6 @@ static ssize_t show_num_units(struct dev
 			 ipath_count_units(NULL, NULL, NULL));
 }
 
-#define DRIVER_STAT(name, attr) \
-	static ssize_t show_stat_##name(struct device_driver *dev, \
-					char *buf) \
-	{ \
-		return scnprintf( \
-			buf, PAGE_SIZE, "%llu\n", \
-			(unsigned long long) ipath_stats.sps_ ##attr); \
-	} \
-	static DRIVER_ATTR(name, S_IRUGO, show_stat_##name, NULL)
-
-DRIVER_STAT(intrs, ints);
-DRIVER_STAT(err_intrs, errints);
-DRIVER_STAT(errs, errs);
-DRIVER_STAT(pkt_errs, pkterrs);
-DRIVER_STAT(crc_errs, crcerrs);
-DRIVER_STAT(hw_errs, hwerrs);
-DRIVER_STAT(ib_link, iblink);
-DRIVER_STAT(port0_pkts, port0pkts);
-DRIVER_STAT(ether_spkts, ether_spkts);
-DRIVER_STAT(ether_rpkts, ether_rpkts);
-DRIVER_STAT(sma_spkts, sma_spkts);
-DRIVER_STAT(sma_rpkts, sma_rpkts);
-DRIVER_STAT(hdrq_full, hdrqfull);
-DRIVER_STAT(etid_full, etidfull);
-DRIVER_STAT(no_piobufs, nopiobufs);
-DRIVER_STAT(ports, ports);
-DRIVER_STAT(pkey0, pkeys[0]);
-DRIVER_STAT(pkey1, pkeys[1]);
-DRIVER_STAT(pkey2, pkeys[2]);
-DRIVER_STAT(pkey3, pkeys[3]);
-/* XXX fix the following when dynamic table of devices used */
-DRIVER_STAT(lid0, lid[0]);
-DRIVER_STAT(lid1, lid[1]);
-DRIVER_STAT(lid2, lid[2]);
-DRIVER_STAT(lid3, lid[3]);
-
-DRIVER_STAT(nports, nports);
-DRIVER_STAT(null_intr, nullintr);
-DRIVER_STAT(max_pkts_call, maxpkts_call);
-DRIVER_STAT(avg_pkts_call, avgpkts_call);
-DRIVER_STAT(page_locks, pagelocks);
-DRIVER_STAT(page_unlocks, pageunlocks);
-DRIVER_STAT(krdrops, krdrops);
-/* XXX fix the following when dynamic table of devices used */
-DRIVER_STAT(mlid0, mlid[0]);
-DRIVER_STAT(mlid1, mlid[1]);
-DRIVER_STAT(mlid2, mlid[2]);
-DRIVER_STAT(mlid3, mlid[3]);
-
-static struct attribute *driver_stat_attributes[] = {
-	&driver_attr_intrs.attr,
-	&driver_attr_err_intrs.attr,
-	&driver_attr_errs.attr,
-	&driver_attr_pkt_errs.attr,
-	&driver_attr_crc_errs.attr,
-	&driver_attr_hw_errs.attr,
-	&driver_attr_ib_link.attr,
-	&driver_attr_port0_pkts.attr,
-	&driver_attr_ether_spkts.attr,
-	&driver_attr_ether_rpkts.attr,
-	&driver_attr_sma_spkts.attr,
-	&driver_attr_sma_rpkts.attr,
-	&driver_attr_hdrq_full.attr,
-	&driver_attr_etid_full.attr,
-	&driver_attr_no_piobufs.attr,
-	&driver_attr_ports.attr,
-	&driver_attr_pkey0.attr,
-	&driver_attr_pkey1.attr,
-	&driver_attr_pkey2.attr,
-	&driver_attr_pkey3.attr,
-	&driver_attr_lid0.attr,
-	&driver_attr_lid1.attr,
-	&driver_attr_lid2.attr,
-	&driver_attr_lid3.attr,
-	&driver_attr_nports.attr,
-	&driver_attr_null_intr.attr,
-	&driver_attr_max_pkts_call.attr,
-	&driver_attr_avg_pkts_call.attr,
-	&driver_attr_page_locks.attr,
-	&driver_attr_page_unlocks.attr,
-	&driver_attr_krdrops.attr,
-	&driver_attr_mlid0.attr,
-	&driver_attr_mlid1.attr,
-	&driver_attr_mlid2.attr,
-	&driver_attr_mlid3.attr,
-	NULL
-};
-
-static struct attribute_group driver_stat_attr_group = {
-	.name = "stats",
-	.attrs = driver_stat_attributes
-};
 
 static ssize_t show_status(struct device *dev,
 			   struct device_attribute *attr,
@@ -272,7 +180,7 @@ static ssize_t store_lid(struct device *
 			  size_t count)
 {
 	struct ipath_devdata *dd = dev_get_drvdata(dev);
-	u16 lid;
+	u16 lid = 0; /* gcc thinks might be un-initialized */
 	int ret;
 
 	ret = ipath_parse_ushort(buf, &lid);
@@ -284,11 +192,11 @@ static ssize_t store_lid(struct device *
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
@@ -319,7 +227,6 @@ static ssize_t store_mlid(struct device 
 	unit = dd->ipath_unit;
 
 	dd->ipath_mlid = mlid;
-	ipath_stats.sps_mlid[unit] = mlid;
 	ipath_layer_intr(dd, IPATH_LAYER_INT_BCAST);
 
 	goto bail;
@@ -737,17 +644,12 @@ int ipath_driver_create_group(struct dev
 	if (ret)
 		goto bail;
 
-	ret = sysfs_create_group(&drv->kobj, &driver_stat_attr_group);
-	if (ret)
-		sysfs_remove_group(&drv->kobj, &driver_attr_group);
-
 bail:
 	return ret;
 }
 
 void ipath_driver_remove_group(struct device_driver *drv)
 {
-	sysfs_remove_group(&drv->kobj, &driver_stat_attr_group);
 	sysfs_remove_group(&drv->kobj, &driver_attr_group);
 }
 
