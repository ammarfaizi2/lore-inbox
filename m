Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbUCLTs0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 14:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbUCLTlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 14:41:19 -0500
Received: from mtagate7.de.ibm.com ([195.212.29.156]:41460 "EHLO
	mtagate7.de.ibm.com") by vger.kernel.org with ESMTP id S262434AbUCLThG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 14:37:06 -0500
Date: Fri, 12 Mar 2004 20:36:52 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (4/10): network driver fixes.
Message-ID: <20040312193652.GE2757@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

network driver fixes:
 - Use SET_NETDEV_DEV to create the link from the network device to the
   physical device. Remove link from physical to network device.
 - Remove some unnecessary casts in netiucv.
 - Add missing strings to dev_stat_names & dev_event_names.
 - Add missing preempt_disable/preempt_enable pairs in iucv.

diffstat:
 drivers/s390/net/ctcmain.c |   27 ++++------------------
 drivers/s390/net/iucv.c    |   16 +++++++------
 drivers/s390/net/lcs.c     |   22 +++---------------
 drivers/s390/net/netiucv.c |   55 ++++++++++++++++++---------------------------
 drivers/s390/net/qeth.c    |   17 +------------
 5 files changed, 43 insertions(+), 94 deletions(-)

diff -urN linux-2.6/drivers/s390/net/ctcmain.c linux-2.6-s390/drivers/s390/net/ctcmain.c
--- linux-2.6/drivers/s390/net/ctcmain.c	Thu Mar 11 03:55:25 2004
+++ linux-2.6-s390/drivers/s390/net/ctcmain.c	Fri Mar 12 20:03:32 2004
@@ -1,5 +1,5 @@
 /*
- * $Id: ctcmain.c,v 1.56 2004/02/27 17:53:26 mschwide Exp $
+ * $Id: ctcmain.c,v 1.57 2004/03/02 15:34:01 mschwide Exp $
  *
  * CTC / ESCON network driver
  *
@@ -36,7 +36,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.56 $
+ * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.57 $
  *
  */
 
@@ -319,7 +319,7 @@
 print_banner(void)
 {
 	static int printed = 0;
-	char vbuf[] = "$Revision: 1.56 $";
+	char vbuf[] = "$Revision: 1.57 $";
 	char *version = vbuf;
 
 	if (printed)
@@ -3043,26 +3043,13 @@
 		privptr->channel[direction]->protocol = privptr->protocol;
 		privptr->channel[direction]->max_bufsize = CTC_BUFSIZE_DEFAULT;
 	}
+	/* sysfs magic */
+	SET_NETDEV_DEV(dev, &cgdev->dev);
+
 	if (ctc_netdev_register(dev) != 0) {
 		ctc_free_netdevice(dev, 1);
 		goto out;
 	}
-	/* Create symlinks. */
-	if (sysfs_create_link(&cgdev->dev.kobj, &dev->class_dev.kobj,
-			      dev->name)) {
-		ctc_netdev_unregister(dev);
-		dev->priv = 0;
-		ctc_free_netdevice(dev, 1);
-		goto out;
-	}
-	if (sysfs_create_link(&dev->class_dev.kobj, &cgdev->dev.kobj,
-			      cgdev->dev.bus_id)) {
-		sysfs_remove_link(&cgdev->dev.kobj, dev->name);
-		ctc_netdev_unregister(dev);
-		dev->priv = 0;
-		ctc_free_netdevice(dev, 1);
-		goto out;
-	}
 
 	ctc_add_attributes(&cgdev->dev);
 
@@ -3118,8 +3105,6 @@
 		channel_free(priv->channel[WRITE]);
 
 	if (ndev) {
-		sysfs_remove_link(&ndev->class_dev.kobj, cgdev->dev.bus_id);
-		sysfs_remove_link(&cgdev->dev.kobj, ndev->name);
 		ctc_netdev_unregister(ndev);
 		ndev->priv = NULL;
 		ctc_free_netdevice(ndev, 1);
diff -urN linux-2.6/drivers/s390/net/iucv.c linux-2.6-s390/drivers/s390/net/iucv.c
--- linux-2.6/drivers/s390/net/iucv.c	Thu Mar 11 03:55:22 2004
+++ linux-2.6-s390/drivers/s390/net/iucv.c	Fri Mar 12 20:03:32 2004
@@ -1,5 +1,5 @@
 /* 
- * $Id: iucv.c,v 1.24 2004/02/05 14:16:01 braunu Exp $
+ * $Id: iucv.c,v 1.26 2004/03/10 11:55:31 braunu Exp $
  *
  * IUCV network driver
  *
@@ -29,7 +29,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.24 $
+ * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.26 $
  *
  */
 
@@ -351,7 +351,7 @@
 static void
 iucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.24 $";
+	char vbuf[] = "$Revision: 1.26 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
@@ -670,10 +670,12 @@
 	ulong b2f0_result = 0x0deadbeef;
 
 	iucv_debug(1, "entering");
+	preempt_disable();
 	if (smp_processor_id() == 0)
 		iucv_declare_buffer_cpu0(&b2f0_result);
 	else
 		smp_call_function(iucv_declare_buffer_cpu0, &b2f0_result, 0, 1);
+	preempt_enable();
 	iucv_debug(1, "Address of EIB = %p", iucv_external_int_buffer);
 	if (b2f0_result == 0x0deadbeef)
 	    b2f0_result = 0xaa;
@@ -692,11 +694,13 @@
 {
 	iucv_debug(1, "entering");
 	if (declare_flag) {
+		preempt_disable();
 		if (smp_processor_id() == 0)
 			iucv_retrieve_buffer_cpu0(0);
 		else
 			smp_call_function(iucv_retrieve_buffer_cpu0, 0, 0, 1);
 		declare_flag = 0;
+		preempt_enable();
 	}
 	iucv_debug(1, "exiting");
 	return 0;
@@ -2216,10 +2220,12 @@
 	} u;
 
 	u.param = SetMaskFlag;
+	preempt_disable();
 	if (smp_processor_id() == 0)
 		iucv_setmask_cpu0(&u);
 	else
 		smp_call_function(iucv_setmask_cpu0, &u, 0, 1);
+	preempt_enable();
 
 	return u.result;
 }
@@ -2519,10 +2525,6 @@
 
 /**
  * Export all public stuff
- * FIXME: I have commented out all the functions that
- * 	  are not used in netiucv. Is anyone else
- * 	  using them or should some of them be made
- * 	  static / removed? pls review. Arnd
  */
 EXPORT_SYMBOL (iucv_bus);
 EXPORT_SYMBOL (iucv_root);
diff -urN linux-2.6/drivers/s390/net/lcs.c linux-2.6-s390/drivers/s390/net/lcs.c
--- linux-2.6/drivers/s390/net/lcs.c	Thu Mar 11 03:55:22 2004
+++ linux-2.6-s390/drivers/s390/net/lcs.c	Fri Mar 12 20:03:32 2004
@@ -11,7 +11,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Martin Schwidefsky <schwidefsky@de.ibm.com>
  *
- *    $Revision: 1.67 $	 $Date: 2004/02/26 18:26:50 $
+ *    $Revision: 1.68 $	 $Date: 2004/03/02 15:34:01 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -58,7 +58,7 @@
 /**
  * initialization string for output
  */
-#define VERSION_LCS_C  "$Revision: 1.67 $"
+#define VERSION_LCS_C  "$Revision: 1.68 $"
 
 static char version[] __initdata = "LCS driver ("VERSION_LCS_C "/" VERSION_LCS_H ")";
 
@@ -1855,17 +1855,8 @@
 	if (register_netdev(dev) != 0)
 		goto out;
 	/* Create symlinks. */
-	if (sysfs_create_link(&ccwgdev->dev.kobj, &dev->class_dev.kobj,
-			      dev->name)) {
-		unregister_netdev(dev);
-		goto out;
-	}
-	if (sysfs_create_link(&dev->class_dev.kobj, &ccwgdev->dev.kobj,
-			      ccwgdev->dev.bus_id)) {
-		sysfs_remove_link(&ccwgdev->dev.kobj, dev->name);
-		unregister_netdev(dev);
-		goto out;
-	}
+	SET_NETDEV_DEV(dev, &ccwgdev->dev);
+
 	netif_stop_queue(dev);
 	lcs_stopcard(card);
 	return 0;
@@ -1891,8 +1882,6 @@
 	ret = lcs_stop_device(card->dev);
 	if (ret)
 		return ret;
-	sysfs_remove_link(&card->dev->class_dev.kobj, ccwgdev->dev.bus_id);
-	sysfs_remove_link(&ccwgdev->dev.kobj, card->dev->name);
 	unregister_netdev(card->dev);
 	return 0;
 }
@@ -1911,9 +1900,6 @@
 		return;
 	if (ccwgdev->state == CCWGROUP_ONLINE) {
 		lcs_stop_device(card->dev); /* Ignore rc. */
-		sysfs_remove_link(&card->dev->class_dev.kobj,
-				  ccwgdev->dev.bus_id);
-		sysfs_remove_link(&ccwgdev->dev.kobj, card->dev->name);
 		unregister_netdev(card->dev);
 	}
 	sysfs_remove_group(&ccwgdev->dev.kobj, &lcs_attr_group);
diff -urN linux-2.6/drivers/s390/net/netiucv.c linux-2.6-s390/drivers/s390/net/netiucv.c
--- linux-2.6/drivers/s390/net/netiucv.c	Thu Mar 11 03:55:28 2004
+++ linux-2.6-s390/drivers/s390/net/netiucv.c	Fri Mar 12 20:03:32 2004
@@ -1,5 +1,5 @@
 /*
- * $Id: netiucv.c,v 1.38 2004/02/19 13:12:57 mschwide Exp $
+ * $Id: netiucv.c,v 1.44 2004/03/10 08:59:00 braunu Exp $
  *
  * IUCV network driver
  *
@@ -30,7 +30,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV network driver $Revision: 1.38 $
+ * RELEASE-TAG: IUCV network driver $Revision: 1.44 $
  *
  */
 
@@ -229,6 +229,7 @@
 	"StartWait",
 	"StopWait",
 	"Running",
+	"StartRetry",
 };
 
 /**
@@ -251,6 +252,7 @@
 	"Stop",
 	"Connection up",
 	"Connection down",
+	"Timer",
 };
 
 /**
@@ -345,11 +347,6 @@
 	CONN_STATE_TX,
 
 	/**
-	 * Terminating
-	 */
-	CONN_STATE_TERM,
-
-	/**
 	 * Error during registration.
 	 */
 	CONN_STATE_REGERR,
@@ -495,7 +492,7 @@
 netiucv_unpack_skb(struct iucv_connection *conn, struct sk_buff *pskb)
 {
 	struct net_device     *dev = conn->netdev;
-	struct netiucv_priv   *privptr = (struct netiucv_priv *)dev->priv;
+	struct netiucv_priv   *privptr = dev->priv;
 	__u16          offset = 0;
 
 	skb_put(pskb, NETIUCV_HDRLEN);
@@ -1214,7 +1211,7 @@
 static int netiucv_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	int          rc = 0;
-	struct netiucv_priv *privptr = (struct netiucv_priv *)dev->priv;
+	struct netiucv_priv *privptr = dev->priv;
 
 	/**
 	 * Some sanity checks ...
@@ -1606,20 +1603,10 @@
 	ret = netiucv_add_files(dev);
 	if (ret)
 		goto out_unreg;
-	ret = sysfs_create_link(&dev->kobj, &ndev->class_dev.kobj, ndev->name);
-	if (ret) 
-		goto out_rm_files;
-	ret = sysfs_create_link(&ndev->class_dev.kobj, &dev->kobj, dev->bus_id);
-	if (ret)
-		goto out_rm_link;
 	dev->driver_data = priv;
 	priv->dev = dev;
 	return 0;
 
-out_rm_link:
-	sysfs_remove_link(&dev->kobj, ndev->name);
-out_rm_files:
-	netiucv_remove_files(dev);
 out_unreg:
 	device_unregister(dev);
 	return ret;
@@ -1628,12 +1615,7 @@
 static void
 netiucv_unregister_device(struct device *dev)
 {
-	struct netiucv_priv *priv = dev->driver_data;
-	struct net_device *ndev = priv->conn->netdev;
-
 	pr_debug("%s() called\n", __FUNCTION__);
-	sysfs_remove_link(&ndev->class_dev.kobj, dev->bus_id);
-	sysfs_remove_link(&dev->kobj, ndev->name);
 	netiucv_remove_files(dev);
 	device_unregister(dev);
 }
@@ -1814,7 +1796,7 @@
 {
 	char *p;
 	char username[10];
-	int i;
+	int i, ret;
 	struct net_device *dev;
 
 	if (count>9) {
@@ -1846,30 +1828,37 @@
 		return -ENODEV;
 	}
 	
-	if (register_netdev(dev)) {
-		printk(KERN_WARNING
-		       "netiucv: Could not register '%s'\n", dev->name);
-		netiucv_free_netdevice(dev);
-		return -ENODEV;
+	if ((ret = netiucv_register_device(dev, ifno))) 
+		goto out_free_ndev;
+	/* sysfs magic */
+	SET_NETDEV_DEV(dev, (struct device*)((struct netiucv_priv*)dev->priv)->dev);
+	if ((ret = register_netdev(dev))) {
+		netiucv_unregister_device((struct device*)((struct netiucv_priv*)dev->priv)->dev);
+		goto out_free_ndev;
 	}
 	printk(KERN_INFO "%s: '%s'\n", dev->name, netiucv_printname(username));
-	netiucv_register_device(dev, ifno);
 	ifno++;
 	
 	return count;
+
+out_free_ndev:
+	printk(KERN_WARNING
+		       "netiucv: Could not register '%s'\n", dev->name);
+	netiucv_free_netdevice(dev);
+	return ret;
 }
 
 DRIVER_ATTR(connection, 0200, NULL, conn_write);
 
 static struct device_driver netiucv_driver = {
-	.name = "NETIUCV",
+	.name = "netiucv",
 	.bus  = &iucv_bus,
 };
 
 static void
 netiucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.38 $";
+	char vbuf[] = "$Revision: 1.44 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
diff -urN linux-2.6/drivers/s390/net/qeth.c linux-2.6-s390/drivers/s390/net/qeth.c
--- linux-2.6/drivers/s390/net/qeth.c	Thu Mar 11 03:55:55 2004
+++ linux-2.6-s390/drivers/s390/net/qeth.c	Fri Mar 12 20:03:32 2004
@@ -6404,6 +6404,8 @@
 
 	QETH_DBF_CARD3(0, trace, "rgnd", card);
 
+	/* sysfs magic */
+	SET_NETDEV_DEV(card->dev, &card->gdev->dev);
 	result = register_netdev(card->dev);
 
 	return result;
@@ -6681,10 +6683,6 @@
 						   hard_start_xmit */
 
 	if (atomic_read(&card->is_registered)) {
-		/* Remove sysfs symlinks. */
-		sysfs_remove_link(&card->gdev->dev.kobj, card->dev_name);
-		sysfs_remove_link(&card->dev->class_dev.kobj,
-				  CARD_BUS_ID(card));
 		QETH_DBF_TEXT2(0, trace, "unregdev");
 		qeth_unregister_netdev(card);
 		qeth_wait_nonbusy(QETH_REMOVE_WAIT_TIME);
@@ -10694,17 +10692,6 @@
 	if (qeth_init_netdev(card))
 		goto out_remove;
 
-	if (sysfs_create_link(&card->gdev->dev.kobj, &card->dev->class_dev.kobj,
-			      card->dev_name)) {
-		qeth_unregister_netdev(card);
-		goto out_remove;
-	}
-	if (sysfs_create_link(&card->dev->class_dev.kobj, &card->gdev->dev.kobj,
-			      CARD_BUS_ID(card))) {
-		sysfs_remove_link(&card->gdev->dev.kobj, card->dev_name);
-		qeth_unregister_netdev(card);
-		goto out_remove;
-	}
 	return 0;		/* success */
 
 out_remove:
