Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbTIYRYe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbTIYRX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:23:26 -0400
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:60806 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261188AbTIYRSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:18:51 -0400
Date: Thu, 25 Sep 2003 19:18:09 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (7/19): sysfs_create_group.
Message-ID: <20030925171809.GH2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of sysfs_create_group in s390 device drivers.

diffstat:
 drivers/s390/block/dasd.c  |   24 ++++---
 drivers/s390/cio/device.c  |   50 ++++++++++-----
 drivers/s390/net/ctcmain.c |   15 +++-
 drivers/s390/net/lcs.c     |   12 +++
 drivers/s390/net/netiucv.c |   60 ++++++++++++------
 drivers/s390/net/qeth.c    |  146 +++++++++++++--------------------------------
 6 files changed, 155 insertions(+), 152 deletions(-)

diff -urN linux-2.6/drivers/s390/block/dasd.c linux-2.6-s390/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	Mon Sep  8 21:50:03 2003
+++ linux-2.6-s390/drivers/s390/block/dasd.c	Thu Sep 25 18:33:26 2003
@@ -1996,20 +1996,22 @@
 
 static DEVICE_ATTR(discipline, 0444, dasd_discipline_show, NULL);
 
+static struct attribute * dasd_attrs[] = {
+	//&dev_attr_dasd.attr,
+	&dev_attr_readonly.attr,
+	&dev_attr_discipline.attr,
+	&dev_attr_use_diag.attr,
+	NULL,
+};
+
+static struct attribute_group dasd_attr_group = {
+	.attrs = dasd_attrs,
+};
+
 static int
 dasd_add_sysfs_files(struct ccw_device *cdev)
 {
-	int ret;
-
-	if (/* (ret = device_create_file(&cdev->dev, &dev_attr_dasd)) || */
-	    (ret = device_create_file(&cdev->dev, &dev_attr_readonly)) ||
-	    (ret = device_create_file(&cdev->dev, &dev_attr_discipline)) ||
-	    (ret = device_create_file(&cdev->dev, &dev_attr_use_diag))) {
-		device_remove_file(&cdev->dev, &dev_attr_discipline);
-		device_remove_file(&cdev->dev, &dev_attr_readonly);
-		/* device_remove_file(&cdev->dev, &dev_attr_dasd); */
-	}
-	return ret;
+	return sysfs_create_group(&cdev->dev.kobj, &dasd_attr_group);
 }
 
 static int __init
diff -urN linux-2.6/drivers/s390/cio/device.c linux-2.6-s390/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	Thu Sep 25 18:33:23 2003
+++ linux-2.6-s390/drivers/s390/cio/device.c	Thu Sep 25 18:33:26 2003
@@ -373,30 +373,43 @@
 	spin_unlock_irq(cdev->ccwlock);
 }
 
+static struct attribute * subch_attrs[] = {
+	&dev_attr_chpids.attr,
+	&dev_attr_pimpampom.attr,
+	NULL,
+};
+
+static struct attribute_group subch_attr_group = {
+	.attrs = subch_attrs,
+};
+
 static inline int
 subchannel_add_files (struct device *dev)
 {
-	int ret;
-
-	if ((ret = device_create_file(dev, &dev_attr_chpids)) ||
-	    (ret = device_create_file(dev, &dev_attr_pimpampom))) {
-		device_remove_file(dev, &dev_attr_chpids);
-	}
-	return ret;
+	return sysfs_create_group(&dev->kobj, &subch_attr_group);
 }
 
+static struct attribute * ccwdev_attrs[] = {
+	&dev_attr_devtype.attr,
+	&dev_attr_cutype.attr,
+	&dev_attr_online.attr,
+	NULL,
+};
+
+static struct attribute_group ccwdev_attr_group = {
+	.attrs = ccwdev_attrs,
+};
+
 static inline int
 device_add_files (struct device *dev)
 {
-	int ret;
+	return sysfs_create_group(&dev->kobj, &ccwdev_attr_group);
+}
 
-	if ((ret = device_create_file(dev, &dev_attr_devtype)) ||
-	    (ret = device_create_file(dev, &dev_attr_cutype))  ||
-	    (ret = device_create_file(dev, &dev_attr_online))) {
-		device_remove_file(dev, &dev_attr_cutype);
-		device_remove_file(dev, &dev_attr_devtype);
-	}
-	return ret;
+static inline void
+device_remove_files(struct device *dev)
+{
+	sysfs_remove_group(&dev->kobj, &ccwdev_attr_group);
 }
 
 /*
@@ -437,7 +450,12 @@
 void
 ccw_device_unregister(void *data)
 {
-	device_unregister((struct device *)data);
+	struct device *dev;
+
+	dev = (struct device *)data;
+
+	device_remove_files(dev);
+	device_unregister(dev);
 }
 	
 
diff -urN linux-2.6/drivers/s390/net/ctcmain.c linux-2.6-s390/drivers/s390/net/ctcmain.c
--- linux-2.6/drivers/s390/net/ctcmain.c	Mon Sep  8 21:50:02 2003
+++ linux-2.6-s390/drivers/s390/net/ctcmain.c	Thu Sep 25 18:33:26 2003
@@ -2786,18 +2786,25 @@
 
 static DEVICE_ATTR(protocol, 0644, ctc_proto_show, ctc_proto_store);
 
+static struct attribute *ctc_attr[] = {
+	&dev_attr_protocol.attr,
+	NULL,
+};
+
+static struct attribute_group ctc_attr_group = {
+	.attrs = ctc_attr,
+};
+
 static int
 ctc_add_files(struct device *dev)
 {
-	return device_create_file(dev, &dev_attr_protocol);
-
+	return sysfs_create_group(&dev->kobj, &ctc_attr_group);
 }
 
 static void
 ctc_remove_files(struct device *dev)
 {
-	device_remove_file(dev, &dev_attr_protocol);
-
+	sysfs_remove_group(&dev->kobj, &ctc_attr_group);
 }
 
 /**
diff -urN linux-2.6/drivers/s390/net/lcs.c linux-2.6-s390/drivers/s390/net/lcs.c
--- linux-2.6/drivers/s390/net/lcs.c	Mon Sep  8 21:49:53 2003
+++ linux-2.6-s390/drivers/s390/net/lcs.c	Thu Sep 25 18:33:26 2003
@@ -1675,6 +1675,15 @@
 
 static DEVICE_ATTR(portno, 0644, lcs_portno_show, lcs_portno_store);
 
+static struct attribute * lcs_attrs[] = {
+	&dev_attr_portno.attr,
+	NULL,
+};
+
+static struct attribute_group lcs_attr_group = {
+	.attrs = lcs_attrs,
+};
+
 /**
  * lcs_probe_device is called on establishing a new ccwgroup_device.
  */
@@ -1694,7 +1703,7 @@
 		put_device(&ccwgdev->dev);
                 return -ENOMEM;
         }
-	ret = device_create_file(&ccwgdev->dev, &dev_attr_portno);
+	ret = sysfs_create_group(&ccwgdev->dev.kobj, &lcs_attr_group);
 	if (ret) {
                 PRINT_ERR("Creating attributes failed");
 		lcs_free_card(card);
@@ -1826,6 +1835,7 @@
 	card = (struct lcs_card *)ccwgdev->dev.driver_data;
 	if (!card)
 		return 0;
+	sysfs_remove_group(&ccwgdev->dev.kobj, &lcs_attr_group);
 	lcs_cleanup_card(card);
 	lcs_free_card(card);
 	put_device(&ccwgdev->dev);
diff -urN linux-2.6/drivers/s390/net/netiucv.c linux-2.6-s390/drivers/s390/net/netiucv.c
--- linux-2.6/drivers/s390/net/netiucv.c	Mon Sep  8 21:50:07 2003
+++ linux-2.6-s390/drivers/s390/net/netiucv.c	Thu Sep 25 18:33:26 2003
@@ -1435,32 +1435,53 @@
 
 static DEVICE_ATTR(max_tx_io_time, 0644, txtime_show, txtime_write);
 
+static struct attribute *netiucv_attrs[] = {
+	&dev_attr_buffer.attr,
+	NULL,
+};
+
+static struct attribute_group netiucv_attr_group = {
+	.attrs = netiucv_attrs,
+};
+
+static struct attribute *netiucv_stat_attrs[] = {
+	&dev_attr_device_fsm_state.attr,
+	&dev_attr_connection_fsm_state.attr,
+	&dev_attr_max_tx_buffer_used.attr,
+	&dev_attr_max_chained_skbs.attr,
+	&dev_attr_tx_single_write_ops.attr,
+	&dev_attr_tx_multi_write_ops.attr,
+	&dev_attr_netto_bytes.attr,
+	&dev_attr_max_tx_io_time.attr,
+	NULL,
+};
+
+static struct attribute_group netiucv_stat_attr_group = {
+	.name  = "stats",
+	.attrs = netiucv_stat_attrs,
+};
+
 static inline int
 netiucv_add_files(struct device *dev)
 {
-	int ret = 0;
+	int ret;
 
-	if ((ret = device_create_file(dev, &dev_attr_buffer)) ||
-	    (ret = device_create_file(dev, &dev_attr_device_fsm_state)) ||
-	    (ret = device_create_file(dev, &dev_attr_connection_fsm_state)) ||
-	    (ret = device_create_file(dev, &dev_attr_max_tx_buffer_used)) ||
-	    (ret = device_create_file(dev, &dev_attr_max_chained_skbs)) ||
-	    (ret = device_create_file(dev, &dev_attr_tx_single_write_ops)) ||
-	    (ret = device_create_file(dev, &dev_attr_tx_multi_write_ops)) ||
-	    (ret = device_create_file(dev, &dev_attr_netto_bytes)) ||
-	    (ret = device_create_file(dev, &dev_attr_max_tx_io_time))) {
-		device_remove_file(dev, &dev_attr_netto_bytes);
-		device_remove_file(dev, &dev_attr_tx_multi_write_ops);
-		device_remove_file(dev, &dev_attr_tx_single_write_ops);
-		device_remove_file(dev, &dev_attr_max_chained_skbs);
-		device_remove_file(dev, &dev_attr_max_tx_buffer_used);
-		device_remove_file(dev, &dev_attr_connection_fsm_state);
-		device_remove_file(dev, &dev_attr_device_fsm_state);
-		device_remove_file(dev, &dev_attr_buffer);
-	}
+	ret = sysfs_create_group(&dev->kobj, &netiucv_attr_group);
+	if (ret)
+		return ret;
+	ret = sysfs_create_group(&dev->kobj, &netiucv_stat_attr_group);
+	if (ret)
+		sysfs_remove_group(&dev->kobj, &netiucv_stat_attr_group);
 	return ret;
 }
 
+static inline void
+netiucv_remove_files(struct device *dev)
+{
+	sysfs_remove_group(&dev->kobj, &netiucv_stat_attr_group);
+	sysfs_remove_group(&dev->kobj, &netiucv_stat_attr_group);
+}
+
 static int
 netiucv_register_device(struct net_device *ndev, int ifno)
 {
@@ -1494,6 +1515,7 @@
 	struct netiucv_priv *priv = (struct netiucv_priv*)ndev->priv;
 	struct device *dev = &priv->dev;
 	
+	netiucv_remove_files(dev);
 	device_unregister(dev);
 }
 
diff -urN linux-2.6/drivers/s390/net/qeth.c linux-2.6-s390/drivers/s390/net/qeth.c
--- linux-2.6/drivers/s390/net/qeth.c	Mon Sep  8 21:50:58 2003
+++ linux-2.6-s390/drivers/s390/net/qeth.c	Thu Sep 25 18:33:26 2003
@@ -10830,115 +10830,58 @@
 
 static DEVICE_ATTR(recover, 0200, 0, qeth_recover_store);
 
-static inline int
-__qeth_create_attributes(struct device *dev)
+static ssize_t
+qeth_card_type_show(struct device *dev, char *buf)
 {
-	int ret;
-
-	ret = device_create_file(dev, &dev_attr_bufcnt);
-	if (ret != 0)
-		goto out_nobufcnt;
-
-	ret = device_create_file(dev, &dev_attr_portname);
-	if (ret != 0)
-		goto out_noportname;
-
-	ret = device_create_file(dev, &dev_attr_route4);
-	if (ret != 0)
-		goto out_noroute4;
-
-	ret = device_create_file(dev, &dev_attr_route6);
-	if (ret != 0)
-		goto out_noroute6;
-
-	ret = device_create_file(dev, &dev_attr_checksumming);
-	if (ret != 0)
-		goto out_nochecksum;
-
-	ret = device_create_file(dev, &dev_attr_priority_queueing);
-	if (ret != 0)
-		goto out_noprioq;
+	struct qeth_card *card = dev->driver_data;
 
-	ret = device_create_file(dev, &dev_attr_portno);
-	if (ret != 0)
-		goto out_noportno;
+	if (!card)
+		return -EINVAL;
 
-	ret = device_create_file(dev, &dev_attr_contig);
-	if (ret != 0)
-		goto out_nocontig;
+	if (!atomic_read(&card->is_softsetup))
+		return sprintf(buf, "n/a\n");
 
-	ret = device_create_file(dev, &dev_attr_polltime);
-	if (ret != 0)
-		goto out_nopolltime;
-
-	ret = device_create_file(dev, &dev_attr_add_hhlen);
-	if (ret != 0)
-		goto out_nohhlen;
-
-	ret = device_create_file(dev, &dev_attr_enable_takeover);
-	if (ret != 0)
-		goto out_noipat;
-
-	ret = device_create_file(dev, &dev_attr_canonical_macaddr);
-	if (ret != 0)
-		goto out_nomac;
-	
-	ret = device_create_file(dev, &dev_attr_fake_broadcast);
-	if (ret != 0)
-		goto out_nofakebr;
+	return sprintf(buf, "%s\n",
+		       qeth_get_cardname_short(card->type, card->link_type,
+					       card->is_guest_lan));
+}
 
-	ret = device_create_file(dev, &dev_attr_fake_ll);
-	if (ret != 0)
-		goto out_nofakell;
+static DEVICE_ATTR(card_type, 0444, qeth_card_type_show, NULL);
 
-	ret = device_create_file(dev, &dev_attr_async_hsi);
-	if (ret != 0)
-		goto out_nohsi;
-
-	ret = device_create_file(dev, &dev_attr_broadcast_mode);
-	if (ret != 0)
-		goto out_nobrmode;
+static struct attribute * qeth_attrs[] = {
+	&dev_attr_bufcnt.attr,
+	&dev_attr_portname.attr,
+	&dev_attr_route4.attr,
+	&dev_attr_route6.attr,
+	&dev_attr_checksumming.attr,
+	&dev_attr_priority_queueing.attr,
+	&dev_attr_portno.attr,
+	&dev_attr_polltime.attr,
+	&dev_attr_add_hhlen.attr,
+	&dev_attr_enable_takeover.attr,
+	&dev_attr_canonical_macaddr.attr,
+	&dev_attr_fake_broadcast.attr,
+	&dev_attr_fake_ll.attr,
+	&dev_attr_broadcast_mode.attr,
+	&dev_attr_recover.attr,
+	&dev_attr_card_type.attr,
+	NULL,
+};
+
+static struct attribute_group qeth_attr_group = {
+	.attrs = qeth_attrs,
+};
 
-	ret = device_create_file(dev, &dev_attr_recover);
-	if (ret != 0)
-		goto out_norecover;
-
-	return 0;
+static inline int
+__qeth_create_attributes(struct device *dev)
+{
+	return sysfs_create_group(&dev->kobj, &qeth_attr_group);
+}
 
-out_norecover:
-	device_remove_file(dev, &dev_attr_broadcast_mode);
-out_nobrmode:
-	device_remove_file(dev, &dev_attr_async_hsi);
-out_nohsi:
-	device_remove_file(dev, &dev_attr_fake_ll);
-out_nofakell:
-	device_remove_file(dev, &dev_attr_fake_broadcast);
-out_nofakebr:
-	device_remove_file(dev, &dev_attr_canonical_macaddr);
-out_nomac:
-	device_remove_file(dev, &dev_attr_enable_takeover);
-out_noipat:
-	device_remove_file(dev, &dev_attr_add_hhlen);
-out_nohhlen:
-	device_remove_file(dev, &dev_attr_polltime);
-out_nopolltime:
-	device_remove_file(dev, &dev_attr_contig);
-out_nocontig:
-	device_remove_file(dev, &dev_attr_portno);
-out_noportno:
-	device_remove_file(dev, &dev_attr_priority_queueing);
-out_noprioq:
-	device_remove_file(dev, &dev_attr_checksumming);
-out_nochecksum:
-	device_remove_file(dev, &dev_attr_route6);
-out_noroute6:
-	device_remove_file(dev, &dev_attr_route4);
-out_noroute4:
-	device_remove_file(dev, &dev_attr_portname);
-out_noportname:
-	device_remove_file(dev, &dev_attr_bufcnt);
-out_nobufcnt:
-	return ret;
+static inline void
+__qeth_remove_attributes(struct device *dev)
+{
+	sysfs_remove_group(&dev->kobj, &qeth_attr_group);
 }
 
 static int
@@ -11060,6 +11003,7 @@
 {
 	struct qeth_card *card = gdev->dev.driver_data;
 
+	__qeth_remove_attributes(&gdev->dev);
 	gdev->dev.driver_data = NULL;
 	if (card)
 		kfree(card);
