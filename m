Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264488AbUEMTdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbUEMTdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbUEMTdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:33:11 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:30444 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S264488AbUEMTPr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:15:47 -0400
Date: Thu, 13 May 2004 21:15:39 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (6/6): network driver.
Message-ID: <20040513191539.GG2916@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: network device driver.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Network driver changes:
 - lcs: Add missing irb error checking.
 - lcs: Fix multicasting.
 - lcs: Use a seperate lock (ipm_lock) for multicast list.
 - lcs: Add missing in_dev_put in multicase address list handling.
 - iucv: Set static variables to NULL after kfree.
 - iucv: Do bus_unregister if module initialization fails.
 - netiucv: Convert iucvMagic to EBCDIC in con_action_start.
 - netiucv: Remove administration of ifno-stuff for device name,
 - netiucv: Add attribute to remove a netiucv device.
 - qeth: Add version string that is displayed at driver load time.
 - qeth: Fix memory leak in qeth_arp_query.
 - qeth: Remove duplicate case statements in qeth_do_ioctl.
 - qeth: Fix OSA broadcast filtering.
 - qeth: Increase timeout for purge ARP cache IPA.
 - qeth: Fix hsi device naming.
 - qeth: Add do_QDIO count to qeth performance statistics.
 - qeth: Allow writing to IP address takeover attribute only in
         state DOWN or RECOVER.
 - qeth: Fix hang when removing a vlan device.
 - qeth: Cleanup error messages for ARP commands.
 - qeth: Return EOPNOTSUPP for purge ARP on HiperSockets.
 - qeth: Drop skbs if the net_device of a qeth device is down.
 - qeth: Simplify ip address list processing.

diffstat:
 drivers/s390/net/iucv.c      |   18 +
 drivers/s390/net/lcs.c       |   99 ++++++--
 drivers/s390/net/lcs.h       |    3 
 drivers/s390/net/netiucv.c   |  116 +++++++---
 drivers/s390/net/qeth.h      |   12 -
 drivers/s390/net/qeth_fs.h   |    5 
 drivers/s390/net/qeth_main.c |  475 ++++++++++++++++++++++++-------------------
 drivers/s390/net/qeth_mpc.c  |    5 
 drivers/s390/net/qeth_mpc.h  |   65 +++--
 drivers/s390/net/qeth_proc.c |   26 +-
 drivers/s390/net/qeth_sys.c  |    8 
 include/asm-s390/qeth.h      |   16 -
 12 files changed, 528 insertions(+), 320 deletions(-)

diff -urN linux-2.6/drivers/s390/net/iucv.c linux-2.6-s390/drivers/s390/net/iucv.c
--- linux-2.6/drivers/s390/net/iucv.c	Mon May 10 04:32:00 2004
+++ linux-2.6-s390/drivers/s390/net/iucv.c	Thu May 13 21:01:05 2004
@@ -1,5 +1,5 @@
 /* 
- * $Id: iucv.c,v 1.28 2004/04/15 06:34:58 braunu Exp $
+ * $Id: iucv.c,v 1.30 2004/05/13 09:21:23 braunu Exp $
  *
  * IUCV network driver
  *
@@ -29,7 +29,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.28 $
+ * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.30 $
  *
  */
 
@@ -98,7 +98,7 @@
 	__u8  res3[24];
 } iucv_GeneralInterrupt;
 
-static iucv_GeneralInterrupt *iucv_external_int_buffer;
+static iucv_GeneralInterrupt *iucv_external_int_buffer = NULL;
 
 /* Spin Lock declaration */
 
@@ -351,7 +351,7 @@
 static void
 iucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.28 $";
+	char vbuf[] = "$Revision: 1.30 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
@@ -403,6 +403,7 @@
 		       "%s: Could not allocate external interrupt buffer\n",
 		       __FUNCTION__);
 		s390_root_dev_unregister(iucv_root);
+		bus_unregister(&iucv_bus);
 		return -ENOMEM;
 	}
 	memset(iucv_external_int_buffer, 0, sizeof(iucv_GeneralInterrupt));
@@ -416,6 +417,7 @@
 		kfree(iucv_external_int_buffer);
 		iucv_external_int_buffer = NULL;
 		s390_root_dev_unregister(iucv_root);
+		bus_unregister(&iucv_bus);
 		return -ENOMEM;
 	}
 	memset(iucv_param_pool, 0, sizeof(iucv_param) * PARAM_POOL_SIZE);
@@ -441,10 +443,14 @@
 iucv_exit(void)
 {
 	iucv_retrieve_buffer();
-      	if (iucv_external_int_buffer)
+      	if (iucv_external_int_buffer) {
 		kfree(iucv_external_int_buffer);
-	if (iucv_param_pool)
+		iucv_external_int_buffer = NULL;
+	}
+	if (iucv_param_pool) {
 		kfree(iucv_param_pool);
+		iucv_param_pool = NULL;
+	}
 	s390_root_dev_unregister(iucv_root);
 	bus_unregister(&iucv_bus);
 	printk(KERN_INFO "IUCV lowlevel driver unloaded\n");
diff -urN linux-2.6/drivers/s390/net/lcs.c linux-2.6-s390/drivers/s390/net/lcs.c
--- linux-2.6/drivers/s390/net/lcs.c	Mon May 10 04:32:01 2004
+++ linux-2.6-s390/drivers/s390/net/lcs.c	Thu May 13 21:01:05 2004
@@ -11,7 +11,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Martin Schwidefsky <schwidefsky@de.ibm.com>
  *
- *    $Revision: 1.74 $	 $Date: 2004/04/05 00:01:04 $
+ *    $Revision: 1.80 $	 $Date: 2004/05/13 08:22:06 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -58,7 +58,7 @@
 /**
  * initialization string for output
  */
-#define VERSION_LCS_C  "$Revision: 1.74 $"
+#define VERSION_LCS_C  "$Revision: 1.80 $"
 
 static char version[] __initdata = "LCS driver ("VERSION_LCS_C "/" VERSION_LCS_H ")";
 static char debug_buffer[255];
@@ -99,9 +99,9 @@
 		return -ENOMEM;
 	}
 	debug_register_view(lcs_dbf_setup, &debug_hex_ascii_view);
-	debug_set_level(lcs_dbf_setup, 5);
+	debug_set_level(lcs_dbf_setup, 2);
 	debug_register_view(lcs_dbf_trace, &debug_hex_ascii_view);
-	debug_set_level(lcs_dbf_trace, 5);
+	debug_set_level(lcs_dbf_trace, 2);
 	return 0;
 }
 
@@ -338,6 +338,7 @@
 		  (void *)lcs_start_kernel_thread,card);
 	card->thread_mask = 0;
 	spin_lock_init(&card->lock);
+	spin_lock_init(&card->ipm_lock);
 #ifdef CONFIG_IP_MULTICAST
 	INIT_LIST_HEAD(&card->ipm_list);
 #endif
@@ -935,18 +936,14 @@
 /**
  * set or del multicast address on LCS card
  */
-static int
-lcs_fix_multicast_list(void *data)
+static void
+lcs_fix_multicast_list(struct lcs_card *card)
 {
 	struct list_head *l, *n;
 	struct lcs_ipm_list *ipm;
-	struct lcs_card *card;
 
-	card = (struct lcs_card *) data;
-
-	daemonize("fixipm");
 	LCS_DBF_TEXT(4,trace, "fixipm");
-	spin_lock(&card->lock);
+	spin_lock(&card->ipm_lock);
 	list_for_each_safe(l, n, &card->ipm_list) {
 		ipm = list_entry(l, struct lcs_ipm_list, list);
 		switch (ipm->ipm_state) {
@@ -968,8 +965,7 @@
 	}
 	if (card->state == DEV_STATE_UP)
 		netif_wake_queue(card->dev);
-	spin_unlock(&card->lock);
-	return 0;
+	spin_unlock(&card->ipm_lock);
 }
 
 /**
@@ -988,28 +984,30 @@
 /**
  * function called by net device to handle multicast address relevant things
  */
-static void
-lcs_set_multicast_list(struct net_device *dev)
+static int
+lcs_register_mc_addresses(void *data)
 {
+	struct lcs_card *card;
 	char buf[MAX_ADDR_LEN];
 	struct list_head *l;
 	struct ip_mc_list *im4;
 	struct in_device *in4_dev;
 	struct lcs_ipm_list *ipm, *tmp;
-	struct lcs_card *card;
 
-	LCS_DBF_TEXT(4, trace, "setmulti");
-	in4_dev = in_dev_get(dev);
+	daemonize("regipm");
+	LCS_DBF_TEXT(4, trace, "regmulti");
+
+	card = (struct lcs_card *) data;
+	in4_dev = in_dev_get(card->dev);
 	if (in4_dev == NULL)
-		return;
+		return 0;
 	read_lock(&in4_dev->lock);
-	card = (struct lcs_card *) dev->priv;
-	spin_lock(&card->lock);
+	spin_lock(&card->ipm_lock);
 	/* Check for multicast addresses to be removed. */
 	list_for_each(l, &card->ipm_list) {
 		ipm = list_entry(l, struct lcs_ipm_list, list);
 		for (im4 = in4_dev->mc_list; im4 != NULL; im4 = im4->next) {
-			lcs_get_mac_for_ipm(im4->multiaddr, buf, dev);
+			lcs_get_mac_for_ipm(im4->multiaddr, buf, card->dev);
 			if (memcmp(buf, &ipm->ipm.mac_addr,
 				   LCS_MAC_LENGTH) == 0 &&
 			    ipm->ipm.ip_addr == im4->multiaddr)
@@ -1020,7 +1018,7 @@
 	}
 	/* Check for multicast addresses to be added. */
 	for (im4 = in4_dev->mc_list; im4; im4 = im4->next) {
-		lcs_get_mac_for_ipm(im4->multiaddr, buf, dev);
+		lcs_get_mac_for_ipm(im4->multiaddr, buf, card->dev);
 		ipm = NULL;
 		list_for_each(l, &card->ipm_list) {
 			tmp = list_entry(l, struct lcs_ipm_list, list);
@@ -1046,14 +1044,56 @@
 		ipm->ipm_state = LCS_IPM_STATE_SET_REQUIRED;
 		list_add(&ipm->list, &card->ipm_list);
 	}
-	spin_unlock(&card->lock);
+	spin_unlock(&card->ipm_lock);
 	read_unlock(&in4_dev->lock);
-	set_bit(3, &card->thread_mask);
-	schedule_work(&card->kernel_thread_starter);
+	lcs_fix_multicast_list(card);
+	in_dev_put(in4_dev);
+	return 0;
+}
+/**
+ * function called by net device to
+ * handle multicast address relevant things
+ */
+static void
+lcs_set_multicast_list(struct net_device *dev)
+{
+        struct lcs_card *card;
+
+        LCS_DBF_TEXT(4, trace, "setmulti");
+        card = (struct lcs_card *) dev->priv;
+        set_bit(3, &card->thread_mask);
+        schedule_work(&card->kernel_thread_starter);
 }
 
 #endif /* CONFIG_IP_MULTICAST */
 
+static long
+lcs_check_irb_error(struct ccw_device *cdev, struct irb *irb)
+{
+	if (!IS_ERR(irb))
+		return 0;
+
+	switch (PTR_ERR(irb)) {
+	case -EIO:
+		PRINT_WARN("i/o-error on device %s\n", cdev->dev.bus_id);
+		LCS_DBF_TEXT(2, trace, "ckirberr");
+		LCS_DBF_TEXT_(2, trace, "  rc%d", -EIO);
+		break;
+	case -ETIMEDOUT:
+		PRINT_WARN("timeout on device %s\n", cdev->dev.bus_id);
+		LCS_DBF_TEXT(2, trace, "ckirberr");
+		LCS_DBF_TEXT_(2, trace, "  rc%d", -ETIMEDOUT);
+		break;
+	default:
+		PRINT_WARN("unknown error %ld on device %s\n", PTR_ERR(irb),
+			   cdev->dev.bus_id);
+		LCS_DBF_TEXT(2, trace, "ckirberr");
+		LCS_DBF_TEXT(2, trace, "  rc???");
+	}
+	return PTR_ERR(irb);
+}
+
+
 /**
  * IRQ Handler for LCS channels
  */
@@ -1064,6 +1104,9 @@
 	struct lcs_channel *channel;
 	int index;
 
+	if (lcs_check_irb_error(cdev, irb))
+		return;
+
 	card = CARD_FROM_DEV(cdev);
 	if (card->read.ccwdev == cdev)
 		channel = &card->read;
@@ -1513,7 +1556,7 @@
 		kernel_thread(lcs_lgw_stoplan_thread, (void *) card, SIGCHLD);
 #ifdef CONFIG_IP_MULTICAST
 	if (test_and_clear_bit(3, &card->thread_mask))
-		kernel_thread(lcs_fix_multicast_list, (void *) card, SIGCHLD);
+		kernel_thread(lcs_register_mc_addresses, (void *) card, SIGCHLD);
 #endif
 }
 
@@ -1903,7 +1946,7 @@
 		goto out;
 	memcpy(card->dev->dev_addr, card->mac, LCS_MAC_LENGTH);
 #ifdef CONFIG_IP_MULTICAST
-	if (lcs_check_multicast_support(card))
+	if (!lcs_check_multicast_support(card))
 		card->dev->set_multicast_list = lcs_set_multicast_list;
 #endif
 	netif_stop_queue(card->dev);
diff -urN linux-2.6/drivers/s390/net/lcs.h linux-2.6-s390/drivers/s390/net/lcs.h
--- linux-2.6/drivers/s390/net/lcs.h	Mon May 10 04:32:54 2004
+++ linux-2.6-s390/drivers/s390/net/lcs.h	Thu May 13 21:01:05 2004
@@ -6,7 +6,7 @@
 #include <linux/workqueue.h>
 #include <asm/ccwdev.h>
 
-#define VERSION_LCS_H "$Revision: 1.15 $"
+#define VERSION_LCS_H "$Revision: 1.16 $"
 
 #define LCS_DBF_TEXT(level, name, text) \
 	do { \
@@ -273,6 +273,7 @@
  */
 struct lcs_card {
 	spinlock_t lock;
+	spinlock_t ipm_lock;
 	enum lcs_dev_states state;
 	struct net_device *dev;
 	struct net_device_stats stats;
diff -urN linux-2.6/drivers/s390/net/netiucv.c linux-2.6-s390/drivers/s390/net/netiucv.c
--- linux-2.6/drivers/s390/net/netiucv.c	Mon May 10 04:32:38 2004
+++ linux-2.6-s390/drivers/s390/net/netiucv.c	Thu May 13 21:01:05 2004
@@ -1,5 +1,5 @@
 /*
- * $Id: netiucv.c,v 1.51 2004/04/23 08:11:21 mschwide Exp $
+ * $Id: netiucv.c,v 1.53 2004/05/07 14:29:37 mschwide Exp $
  *
  * IUCV network driver
  *
@@ -30,7 +30,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV network driver $Revision: 1.51 $
+ * RELEASE-TAG: IUCV network driver $Revision: 1.53 $
  *
  */
 
@@ -60,6 +60,7 @@
 #include <asm/io.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
+#include <asm/ebcdic.h>
 
 #include "iucv.h"
 #include "fsm.h"
@@ -113,9 +114,6 @@
  */
 static struct iucv_connection *connections;
 
-/* Keep track of interfaces. */
-static int ifno;
-
 /**
  * Representation of event-data for the
  * connection state machine.
@@ -549,7 +547,7 @@
 	iucv_MessagePending *eib = (iucv_MessagePending *)ev->data;
 	struct netiucv_priv *privptr = (struct netiucv_priv *)conn->netdev->priv;
 
-	__u16 msglen = eib->ln1msg2.ipbfln1f;
+	__u32 msglen = eib->ln1msg2.ipbfln1f;
 	int rc;
 
 	pr_debug("%s() called\n", __FUNCTION__);
@@ -571,6 +569,7 @@
 			  conn->rx_buff->data, msglen, NULL, NULL, NULL);
 	if (rc != 0 || msglen < 5) {
 		privptr->stats.rx_errors++;
+		printk(KERN_INFO "iucv_receive returned %08x\n", rc);
 		return;
 	}
 	netiucv_unpack_skb(conn, conn->rx_buff);
@@ -647,7 +646,7 @@
 			fsm_newstate(fi, CONN_STATE_IDLE);
 			if (privptr)
 				privptr->stats.tx_errors += txpackets;
-			printk(KERN_DEBUG "iucv_send returned %08x\n",
+			printk(KERN_INFO "iucv_send returned %08x\n",
 				rc);
 		} else {
 			if (privptr) {
@@ -770,7 +769,7 @@
 	struct iucv_event *ev = (struct iucv_event *)arg;
 	struct iucv_connection *conn = ev->conn;
 	__u16 msglimit;
-	int rc;
+	int rc, len;
 	__u8 iucvMagic[16] = {
 	0xF0, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40,
         0xF0, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40
@@ -778,7 +777,10 @@
 
 	pr_debug("%s() called\n", __FUNCTION__);
 
-	memcpy(iucvMagic, conn->netdev->name, IFNAMSIZ);
+	len = (IFNAMSIZ < sizeof(conn->netdev->name)) ?
+		IFNAMSIZ : sizeof(conn->netdev->name);
+	memcpy(iucvMagic, conn->netdev->name, len);
+	ASCEBC (iucvMagic, len);
 	if (conn->handle == 0) {
 		conn->handle =
 			iucv_register_program(iucvMagic, conn->userid, mask,
@@ -992,6 +994,7 @@
 dev_action_connup(fsm_instance *fi, int event, void *arg)
 {
 	struct net_device   *dev = (struct net_device *)arg;
+	struct netiucv_priv *privptr = dev->priv;
 
 	pr_debug("%s() called\n", __FUNCTION__);
 
@@ -999,8 +1002,8 @@
 		case DEV_STATE_STARTWAIT:
 			fsm_newstate(fi, DEV_STATE_RUNNING);
 			printk(KERN_INFO
-			       "%s: connected with remote side\n",
-			       dev->name);
+			       "%s: connected with remote side %s\n",
+			       dev->name, privptr->conn->userid);
 			break;
 		case DEV_STATE_STOPWAIT:
 			printk(KERN_INFO
@@ -1140,7 +1143,7 @@
 				skb_pull(skb, NETIUCV_HDRLEN);
 				skb_trim(skb, skb->len - NETIUCV_HDRLEN);
 			}
-			printk(KERN_DEBUG "iucv_send returned %08x\n",
+			printk(KERN_INFO "iucv_send returned %08x\n",
 				rc);
 		} else {
 			if (copied)
@@ -1612,7 +1615,7 @@
 }
 
 static int
-netiucv_register_device(struct net_device *ndev, int ifno)
+netiucv_register_device(struct net_device *ndev)
 {
 	struct netiucv_priv *priv = ndev->priv;
 	struct device *dev = kmalloc(sizeof(struct device), GFP_KERNEL);
@@ -1623,7 +1626,7 @@
 
 	if (dev) {
 		memset(dev, 0, sizeof(struct device));
-		snprintf(dev->bus_id, BUS_ID_SIZE, "netiucv%x", ifno);
+		snprintf(dev->bus_id, BUS_ID_SIZE, "net%s", ndev->name);
 		dev->bus = &iucv_bus;
 		dev->parent = iucv_root;
 		/*
@@ -1801,16 +1804,15 @@
  * Allocate and initialize everything of a net device.
  */
 static struct net_device *
-netiucv_init_netdevice(int ifno, char *username)
+netiucv_init_netdevice(char *username)
 {
 	struct netiucv_priv *privptr;
 	struct net_device *dev;
 
-	dev = alloc_netdev(sizeof(struct netiucv_priv), "",
+	dev = alloc_netdev(sizeof(struct netiucv_priv), "iucv%d",
 			   netiucv_setup_netdevice);
 	if (!dev)
 		return NULL;
-	sprintf(dev->name, "iucv%d", ifno);
 
         privptr = (struct netiucv_priv *)dev->priv;
 	privptr->fsm = init_fsm("netiucvdev", dev_state_names,
@@ -1861,7 +1863,7 @@
 	while (i<9)
 		username[i++] = ' ';
 	username[9] = '\0';
-	dev = netiucv_init_netdevice(ifno, username);
+	dev = netiucv_init_netdevice(username);
 	if (!dev) {
 		printk(KERN_WARNING
 		       "netiucv: Could not allocate network device structure "
@@ -1869,16 +1871,18 @@
 		return -ENODEV;
 	}
 	
-	if ((ret = netiucv_register_device(dev, ifno)))
-		goto out_free_ndev;
-	/* sysfs magic */
-	SET_NETDEV_DEV(dev, (struct device*)((struct netiucv_priv*)dev->priv)->dev);
 	if ((ret = register_netdev(dev))) {
-		netiucv_unregister_device((struct device*)((struct netiucv_priv*)dev->priv)->dev);
 		goto out_free_ndev;
 	}
+
+	if ((ret = netiucv_register_device(dev))) {
+		unregister_netdev(dev);
+		goto out_free_ndev;
+	}
+
+	/* sysfs magic */
+	SET_NETDEV_DEV(dev, (struct device*)((struct netiucv_priv*)dev->priv)->dev);
 	printk(KERN_INFO "%s: '%s'\n", dev->name, netiucv_printname(username));
-	ifno++;
 	
 	return count;
 
@@ -1891,6 +1895,61 @@
 
 DRIVER_ATTR(connection, 0200, NULL, conn_write);
 
+static ssize_t
+remove_write (struct device_driver *drv, const char *buf, size_t count)
+{
+	struct iucv_connection **clist = &connections;
+        struct net_device *ndev;
+        struct netiucv_priv *priv;
+        struct device *dev;
+        char name[IFNAMSIZ];
+        char *p;
+        int i;
+
+        pr_debug("%s() called\n", __FUNCTION__);
+
+        if (count >= IFNAMSIZ)
+                count = IFNAMSIZ-1;
+
+        for (i=0, p=(char *)buf; i<count && *p; i++, p++) {
+                if ((*p == '\n') | (*p == ' ')) {
+                        /* trailing lf, grr */
+                        break;
+                } else {
+                        name[i]=*p;
+                }
+        }
+        name[i] = '\0';
+
+        while (*clist) {
+                ndev = (*clist)->netdev;
+                priv = (struct netiucv_priv*)ndev->priv;
+                dev = priv->dev;
+
+                if (strncmp(name, ndev->name, count)) {
+                        clist = &((*clist)->next);
+                        continue;
+                }
+                if (ndev->flags & (IFF_UP | IFF_RUNNING)) {
+                        printk(KERN_WARNING
+                                "netiucv: net device %s active with peer %s\n",
+                                ndev->name, priv->conn->userid);
+                        printk(KERN_WARNING
+                                "netiucv: %s cannot be removed\n",
+                                ndev->name);
+                        return -EBUSY;
+                }
+                unregister_netdev(ndev);
+                netiucv_unregister_device(dev);
+                return count;
+        }
+        printk(KERN_WARNING
+                "netiucv: net device %s unknown\n", name);
+        return -EINVAL;
+}
+
+DRIVER_ATTR(remove, 0200, NULL, remove_write);
+
 static struct device_driver netiucv_driver = {
 	.name = "netiucv",
 	.bus  = &iucv_bus,
@@ -1899,7 +1958,7 @@
 static void
 netiucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.51 $";
+	char vbuf[] = "$Revision: 1.53 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
@@ -1924,6 +1983,7 @@
 	}
 
 	driver_remove_file(&netiucv_driver, &driver_attr_connection);
+	driver_remove_file(&netiucv_driver, &driver_attr_remove);
 	driver_unregister(&netiucv_driver);
 
 	printk(KERN_INFO "NETIUCV driver unloaded\n");
@@ -1943,10 +2003,10 @@
 
 	/* Add entry for specifying connections. */
 	ret = driver_create_file(&netiucv_driver, &driver_attr_connection);
-
-	if (ret == 0)
+	if (ret == 0) {
+		ret = driver_create_file(&netiucv_driver, &driver_attr_remove);
 		netiucv_banner();
-	else {
+	} else {
 		printk(KERN_ERR "NETIUCV: failed to add driver attribute.\n");
 		driver_unregister(&netiucv_driver);
 	}
diff -urN linux-2.6/drivers/s390/net/qeth.h linux-2.6-s390/drivers/s390/net/qeth.h
--- linux-2.6/drivers/s390/net/qeth.h	Mon May 10 04:31:58 2004
+++ linux-2.6-s390/drivers/s390/net/qeth.h	Thu May 13 21:01:05 2004
@@ -23,7 +23,7 @@
 
 #include "qeth_mpc.h"
 
-#define VERSION_QETH_H 		"$Revision: 1.102 $"
+#define VERSION_QETH_H 		"$Revision: 1.107 $"
 
 #ifdef CONFIG_QETH_IPV6
 #define QETH_VERSION_IPV6 	":IPv6"
@@ -186,6 +186,8 @@
 	__u64 outbound_start_time;
 	unsigned int outbound_cnt;
 	unsigned int outbound_time;
+	unsigned int inbound_do_qdio;
+	unsigned int outbound_do_qdio;
 };
 #endif /* CONFIG_QETH_PERF_STATS */
 
@@ -279,7 +281,7 @@
 #define QETH_IN_BUF_COUNT_MAX 128
 #define QETH_MAX_BUFFER_ELEMENTS(card) ((card)->qdio.in_buf_size >> 12)
 #define QETH_IN_BUF_REQUEUE_THRESHOLD(card) \
-		((card)->qdio.in_buf_pool.buf_count / 4)
+		((card)->qdio.in_buf_pool.buf_count / 2)
 
 /* buffers we have to be behind before we get a PCI */
 #define QETH_PCI_THRESHOLD_A(card) ((card)->qdio.in_buf_pool.buf_count+1)
@@ -606,6 +608,7 @@
 	wait_queue_head_t wait_q;
 	int (*callback)(struct qeth_card *,struct qeth_reply *,unsigned long);
  	int seqno;
+	unsigned long offset;
 	int received;
 	int rc;
 	void *param;
@@ -613,8 +616,10 @@
 	atomic_t refcnt;
 };
 
-struct qeth_card_info {
+#define QETH_BROADCAST_WITH_ECHO    1
+#define QETH_BROADCAST_WITHOUT_ECHO 2
 
+struct qeth_card_info {
 	char if_name[IF_NAME_LEN];
 	unsigned short unit_addr2;
 	unsigned short cula;
@@ -646,7 +651,6 @@
 	enum qeth_checksum_types checksum_type;
 	int broadcast_mode;
 	int macaddr_mode;
-	int enable_takeover;
 	int fake_broadcast;
 	int add_hhlen;
 	int fake_ll;
diff -urN linux-2.6/drivers/s390/net/qeth_fs.h linux-2.6-s390/drivers/s390/net/qeth_fs.h
--- linux-2.6/drivers/s390/net/qeth_fs.h	Mon May 10 04:32:28 2004
+++ linux-2.6-s390/drivers/s390/net/qeth_fs.h	Thu May 13 21:01:05 2004
@@ -12,6 +12,11 @@
 #ifndef __QETH_FS_H__
 #define __QETH_FS_H__
 
+#define VERSION_QETH_FS_H "$Revision: 1.8 $"
+
+extern const char *VERSION_QETH_PROC_C;
+extern const char *VERSION_QETH_SYS_C;
+
 #ifdef CONFIG_PROC_FS
 extern int
 qeth_create_procfs_entries(void);
diff -urN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-s390/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	Mon May 10 04:32:30 2004
+++ linux-2.6-s390/drivers/s390/net/qeth_main.c	Thu May 13 21:01:05 2004
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.89 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.107 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.89 $	 $Date: 2004/04/27 16:27:26 $
+ *    $Revision: 1.107 $	 $Date: 2004/05/13 16:07:59 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -78,10 +78,9 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-#define VERSION_QETH_C "$Revision: 1.89 $"
-static const char *version = "qeth S/390 OSA-Express driver ("
-	VERSION_QETH_C "/" VERSION_QETH_H "/" VERSION_QETH_MPC_H
-	QETH_VERSION_IPV6 QETH_VERSION_VLAN ")";
+#define VERSION_QETH_C "$Revision: 1.107 $"
+static const char *version = "qeth S/390 OSA-Express driver";
+
 /**
  * Debug Facility Stuff
  */
@@ -105,8 +104,6 @@
 static void qeth_send_control_data_cb(struct qeth_channel *,
 				      struct qeth_cmd_buffer *);
 
-static atomic_t qeth_hsi_count;
-
 /**
  * here we go with function implementation
  */
@@ -154,6 +151,10 @@
 
 static int
 qeth_set_online(struct ccwgroup_device *);
+
+static struct qeth_ipaddr *
+qeth_get_addr_buffer(enum qeth_prot_versions);
+
 /**
  * free channel command buffers
  */
@@ -478,8 +479,6 @@
 		card->use_hard_stop = 1;
 		qeth_set_offline(cgdev);
 	}
-	if (card->info.type == QETH_CARD_TYPE_IQD)
-		atomic_dec(&qeth_hsi_count);
 	/* remove form our internal list */
 	write_lock_irqsave(&qeth_card_list.rwlock, flags);
 	list_del(&card->list);
@@ -700,7 +699,7 @@
 qeth_set_ip_addr_list(struct qeth_card *card)
 {
 	struct list_head failed_todos;
-	struct qeth_ipaddr *todo, *addr, *tmp;
+	struct qeth_ipaddr *todo, *addr;
 	unsigned long flags;
 	int rc;
 
@@ -709,9 +708,10 @@
 
 	INIT_LIST_HEAD(&failed_todos);
 
-process_todos:
 	spin_lock_irqsave(&card->ip_lock, flags);
-	list_for_each_entry_safe(todo, tmp, &card->ip_tbd_list, entry) {
+	while (!list_empty(&card->ip_tbd_list)) {
+		todo = list_entry(card->ip_tbd_list.next,
+				  struct qeth_ipaddr, entry);
 		list_del_init(&todo->entry);
 		rc = __qeth_ref_ip_on_card(card, todo, &addr);
 		if (rc == 0) {
@@ -721,28 +721,24 @@
 			/* new entry to be added to on-card list */
 			spin_unlock_irqrestore(&card->ip_lock, flags);
 			rc = qeth_register_addr_entry(card, todo);
-			if (!rc){
-				spin_lock_irqsave(&card->ip_lock, flags);
+			spin_lock_irqsave(&card->ip_lock, flags);
+			if (!rc)
 				list_add_tail(&todo->entry, &card->ip_list);
-				spin_unlock_irqrestore(&card->ip_lock, flags);
-			} else
+			else
 				list_add_tail(&todo->entry, &failed_todos);
-			goto process_todos;
 		} else if (rc == -1) {
 			/* on-card entry to be removed */
 			list_del_init(&addr->entry);
 			spin_unlock_irqrestore(&card->ip_lock, flags);
 			rc = qeth_deregister_addr_entry(card, addr);
+			spin_lock_irqsave(&card->ip_lock, flags);
 			if (!rc) {
 				kfree(addr);
 				kfree(todo);
 			} else {
-				spin_lock_irqsave(&card->ip_lock, flags);
 				list_add_tail(&addr->entry, &card->ip_list);
 				list_add_tail(&todo->entry, &failed_todos);
-				spin_unlock_irqrestore(&card->ip_lock, flags);
 			}
-			goto process_todos;
 		}
 	}
 	spin_unlock_irqrestore(&card->ip_lock, flags);
@@ -937,7 +933,6 @@
 	card->options.checksum_type = QETH_CHECKSUM_DEFAULT;
 	card->options.broadcast_mode = QETH_TR_BROADCAST_ALLRINGS;
 	card->options.macaddr_mode = QETH_TR_MACADDR_NONCANONICAL;
-	card->options.enable_takeover = 1;
 	card->options.fake_broadcast = 0;
 	card->options.add_hhlen = DEFAULT_ADD_HHLEN;
 	card->options.fake_ll = 0;
@@ -998,10 +993,6 @@
 		if ((CARD_RDEV(card)->id.dev_type == known_devices[i][2]) &&
 		    (CARD_RDEV(card)->id.dev_model == known_devices[i][3])) {
 			card->info.type = known_devices[i][4];
-			if (card->options.enable_takeover)
-				card->info.func_level = known_devices[i][6];
-			else
-				card->info.func_level = known_devices[i][7];
 			card->qdio.no_out_queues = known_devices[i][8];
 			card->info.is_multicast_different = known_devices[i][9];
 			return 0;
@@ -1627,10 +1618,13 @@
 			spin_unlock_irqrestore(&card->lock, flags);
 			keep_reply = 0;
 			if (reply->callback != NULL) {
-				if (cmd)
+				if (cmd) {
+					reply->offset = (__u16)((char*)cmd -
+								(char *)iob->data);
 					keep_reply = reply->callback(card,
 							reply,
 							(unsigned long)cmd);
+				}
 				else
 					keep_reply = reply->callback(card,
 							reply,
@@ -1703,7 +1697,10 @@
 	init_timer(&timer);
 	timer.function = qeth_cmd_timeout;
 	timer.data = (unsigned long) reply;
-	timer.expires = jiffies + QETH_TIMEOUT;
+	if (IS_IPA(iob->data))
+		timer.expires = jiffies + QETH_IPA_TIMEOUT;
+	else
+		timer.expires = jiffies + QETH_TIMEOUT;
 	init_waitqueue_head(&reply->wait_q);
 	spin_lock_irqsave(&card->lock, flags);
 	list_add_tail(&reply->list, &card->cmd_waiter_list);
@@ -1743,12 +1740,10 @@
 		  (struct qeth_card *,struct qeth_reply*, unsigned long),
 		  void *reply_param)
 {
-	struct qeth_ipa_cmd *cmd;
 	int rc;
 
 	QETH_DBF_TEXT(trace,4,"sendipa");
 
-	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
 	memcpy(iob->data, IPA_PDU_HEADER, IPA_PDU_HEADER_SIZE);
 	memcpy(QETH_IPA_CMD_DEST_ADDR(iob->data),
 	       &card->token.ulp_connection_r, QETH_MPC_TOKEN_LENGTH);
@@ -2227,12 +2222,14 @@
 	while((skb = qeth_get_next_skb(card, buf->buffer, &element,
 				       &offset, &hdr))){
 		qeth_rebuild_skb(card, skb, hdr);
-
-#ifdef CONFIG_QETH_PERF_STATS
-		card->perf_stats.inbound_time += qeth_get_micros() -
-			card->perf_stats.inbound_start_time;
-		card->perf_stats.inbound_cnt++;
-#endif
+		if (((*(int *)0xff0)==1) &&
+		    (skb->pkt_type == PACKET_BROADCAST))
+			qeth_hex_dump(skb->data, 100);
+		/* is device UP ? */
+		if (!(card->dev->flags & IFF_UP)){
+			dev_kfree_skb_irq(skb);
+			continue;
+		}
 		skb->dev = card->dev;
 		rxrc = netif_rx(skb);
 		card->dev->last_rx = jiffies;
@@ -2330,6 +2327,9 @@
 		 * 'index') un-requeued -> this buffer is the first buffer that
 		 * will be requeued the next time
 		 */
+#ifdef CONFIG_QETH_PERF_STATS
+		card->perf_stats.inbound_do_qdio++;
+#endif
 		rc = do_QDIO(CARD_DDEV(card),
 			     QDIO_FLAG_SYNC_INPUT,
 			     0, queue->next_buf_to_init, count, NULL);
@@ -2369,6 +2369,7 @@
 	card = (struct qeth_card *) card_ptr;
 	net_dev = card->dev;
 #ifdef CONFIG_QETH_PERF_STATS
+	card->perf_stats.inbound_cnt++;
 	card->perf_stats.inbound_start_time = qeth_get_micros();
 #endif
 	if (status & QDIO_STATUS_LOOK_FOR_ERROR) {
@@ -2391,6 +2392,10 @@
 		qeth_put_buffer_pool_entry(card, buffer->pool_entry);
 		qeth_queue_input_buffer(card, index);
 	}
+#ifdef CONFIG_QETH_PERF_STATS
+	card->perf_stats.inbound_time += qeth_get_micros() -
+		card->perf_stats.inbound_start_time;
+#endif
 }
 
 static inline int
@@ -2479,6 +2484,9 @@
 	}
 
 	queue->card->dev->trans_start = jiffies;
+#ifdef CONFIG_QETH_PERF_STATS
+		queue->card->perf_stats.outbound_do_qdio++;
+#endif
 	if (under_int)
 		rc = do_QDIO(CARD_DDEV(queue->card),
 			     QDIO_FLAG_SYNC_OUTPUT | QDIO_FLAG_UNDER_INTERRUPT,
@@ -2497,7 +2505,6 @@
 	}
 #ifdef CONFIG_QETH_PERF_STATS
 	queue->card->perf_stats.bufs_sent += count;
-	queue->card->perf_stats.outbound_cnt++;
 #endif
 }
 
@@ -2850,6 +2857,9 @@
 	for (i = 0; i < card->qdio.in_buf_pool.buf_count - 1; ++i)
 		qeth_init_input_buffer(card, &card->qdio.in_q->bufs[i]);
 	card->qdio.in_q->next_buf_to_init = card->qdio.in_buf_pool.buf_count - 1;
+#ifdef CONFIG_QETH_PERF_STATS
+		card->perf_stats.inbound_do_qdio++;
+#endif
 	rc = do_QDIO(CARD_DDEV(card), QDIO_FLAG_SYNC_INPUT, 0, 0,
 		     card->qdio.in_buf_pool.buf_count - 1, NULL);
 	if (rc) {
@@ -3134,20 +3144,6 @@
 	return rc;
 }
 
-static void
-qeth_set_device_name(struct qeth_card *card)
-{
-	char buf[IF_NAME_LEN];
-
-	memset(buf, 0, IF_NAME_LEN);
-	if (card->info.type == QETH_CARD_TYPE_IQD) {
-		sprintf(buf,"hsi%d", atomic_read(&qeth_hsi_count));
-		atomic_inc(&qeth_hsi_count);
-		memcpy(card->dev->name,buf,IF_NAME_LEN);
-	}
-
-}
-
 static struct net_device *
 qeth_get_netdevice(enum qeth_card_types type, enum qeth_link_types linktype)
 {
@@ -3167,6 +3163,8 @@
 		}
 		break;
 	case QETH_CARD_TYPE_IQD:
+		dev = alloc_netdev(0, "hsi%d", ether_setup);
+		break;
 	default:
 		dev = alloc_etherdev(0);
 	}
@@ -3200,6 +3198,7 @@
 		return -EBUSY;
 	}
 #ifdef CONFIG_QETH_PERF_STATS
+	card->perf_stats.outbound_cnt++;
 	card->perf_stats.outbound_start_time = qeth_get_micros();
 #endif
 	/*
@@ -3210,6 +3209,10 @@
 	if (!(rc = qeth_send_packet(card, skb)))
 		netif_wake_queue(dev);
 
+#ifdef CONFIG_QETH_PERF_STATS
+	card->perf_stats.outbound_time += qeth_get_micros() -
+		card->perf_stats.outbound_start_time;
+#endif
 	return rc;
 }
 
@@ -3556,7 +3559,6 @@
 	int first_lap = 1;
 
 	QETH_DBF_TEXT(trace, 6, "qdfillbf");
-
 	buffer = buf->buffer;
 	atomic_inc(&skb->users);
 	skb_queue_tail(&buf->skb_list, skb);
@@ -3710,10 +3712,6 @@
 	if (!rc){
 		card->stats.tx_packets++;
 		card->stats.tx_bytes += skb->len;
-#ifdef CONFIG_QETH_PERF_STATS
-		card->perf_stats.outbound_time += qeth_get_micros() -
-			card->perf_stats.outbound_start_time;
-#endif
 	}
 	return rc;
 }
@@ -3859,9 +3857,9 @@
 	if (rc) {
 		tmp = rc;
 		PRINT_WARN("Could not set number of ARP entries on %s: "
-			   "%s (0x%x)\n",
+			   "%s (0x%x/%d)\n",
 			   card->info.if_name, qeth_arp_get_error_cause(&rc),
-			   tmp);
+			   tmp, tmp);
 	}
 	return rc;
 }
@@ -3870,7 +3868,7 @@
 qeth_arp_query_cb(struct qeth_card *card, struct qeth_reply *reply,
 		  unsigned long data)
 {
-	struct qeth_ipa_arp_cmd *cmd;
+	struct qeth_ipa_cmd *cmd;
 	struct qeth_arp_query_data *qdata;
 	struct qeth_arp_query_info *qinfo;
 	int entry_size;
@@ -3879,17 +3877,17 @@
 	QETH_DBF_TEXT(trace,4,"arpquecb");
 
 	qinfo = (struct qeth_arp_query_info *) reply->param;
-	cmd = (struct qeth_ipa_arp_cmd *) data;
-	if (cmd->ihdr.return_code) {
-		QETH_DBF_TEXT_(trace,4,"qaer1%i", cmd->ihdr.return_code);
+	cmd = (struct qeth_ipa_cmd *) data;
+	if (cmd->hdr.return_code) {
+		QETH_DBF_TEXT_(trace,4,"qaer1%i", cmd->hdr.return_code);
 		return 0;
 	}
-	if (cmd->shdr.return_code) {
-		cmd->ihdr.return_code = cmd->shdr.return_code;
-		QETH_DBF_TEXT_(trace,4,"qaer2%i", cmd->ihdr.return_code);
+	if (cmd->data.setassparms.hdr.return_code) {
+		cmd->hdr.return_code = cmd->data.setassparms.hdr.return_code;
+		QETH_DBF_TEXT_(trace,4,"qaer2%i", cmd->hdr.return_code);
 		return 0;
 	}
-	qdata = &cmd->data.query_arp;
+	qdata = &cmd->data.setassparms.data.query_arp;
 	switch(qdata->reply_bits){
 	case 5:
 		entry_size = sizeof(struct qeth_arp_qi_entry5);
@@ -3906,20 +3904,21 @@
 	if ((qinfo->udata_len - qinfo->udata_offset) <
 			qdata->no_entries * entry_size){
 		QETH_DBF_TEXT_(trace, 4, "qaer3%i", -ENOMEM);
-		cmd->ihdr.return_code = -ENOMEM;
+		cmd->hdr.return_code = -ENOMEM;
 		goto out_error;
 	}
-	QETH_DBF_TEXT_(trace, 4, "anore%i", cmd->shdr.number_of_replies);
-	QETH_DBF_TEXT_(trace, 4, "aseqn%i", cmd->shdr.seq_no);
+	QETH_DBF_TEXT_(trace, 4, "anore%i",
+		       cmd->data.setassparms.hdr.number_of_replies);
+	QETH_DBF_TEXT_(trace, 4, "aseqn%i", cmd->data.setassparms.hdr.seq_no);
 	QETH_DBF_TEXT_(trace, 4, "anoen%i", qdata->no_entries);
-	for (i = 0; i < qdata->no_entries; ++i){
-		memcpy(qinfo->udata + qinfo->udata_offset,
-		       qdata->data + i*entry_size, entry_size);
-		qinfo->no_entries++;
-		qinfo->udata_offset += entry_size;
-	}
+	/*copy entries to user buffer*/
+	memcpy(qinfo->udata + qinfo->udata_offset,
+	       (char *)&qdata->data, qdata->no_entries*entry_size);
+	qinfo->no_entries += qdata->no_entries;
+	qinfo->udata_offset += (qdata->no_entries*entry_size);
 	/* check if all replies received ... */
-	if (cmd->shdr.seq_no < cmd->shdr.number_of_replies)
+	if (cmd->data.setassparms.hdr.seq_no <
+	    cmd->data.setassparms.hdr.number_of_replies)
 		return 1;
 	memcpy(qinfo->udata, &qinfo->no_entries, 4);
 	memcpy(qinfo->udata + QETH_QARP_MASK_OFFSET,&qdata->reply_bits,2);
@@ -3930,70 +3929,32 @@
 	return 0;
 }
 
-static struct qeth_cmd_buffer *
-qeth_get_ipacmd_buffer(struct qeth_card *, enum qeth_ipa_cmds,
-		       enum qeth_prot_versions);
-
-struct qeth_cmd_buffer *
-qeth_get_ipa_arp_cmd_buffer(struct qeth_card *card, u16 cmd_code,
-			    u32 data_len, enum qeth_prot_versions proto)
-{
-	struct qeth_cmd_buffer *iob;
-	struct qeth_ipa_arp_cmd *cmd;
-	u16 s1, s2;
-
-	QETH_DBF_TEXT(trace,4,"getarpcm");
-	iob = qeth_get_ipacmd_buffer(card, IPA_CMD_SETASSPARMS, proto);
-
-	memcpy(iob->data, IPA_PDU_HEADER, IPA_PDU_HEADER_SIZE);
-
-	if ((IPA_PDU_HEADER_SIZE + QETH_ARP_CMD_BASE_LEN + data_len) > 256) {
-		/* adjust sizes in IPA_PDU_HEADER */
-		s1 = (u32) IPA_PDU_HEADER_SIZE + QETH_ARP_CMD_BASE_LEN +
-			   data_len;
-		s2 = (u32) QETH_ARP_CMD_BASE_LEN + data_len;
-		memcpy(QETH_IPA_PDU_LEN_TOTAL(iob->data), &s1, 2);
-		memcpy(QETH_IPA_PDU_LEN_PDU1(iob->data), &s2, 2);
-		memcpy(QETH_IPA_PDU_LEN_PDU2(iob->data), &s2, 2);
-		memcpy(QETH_IPA_PDU_LEN_PDU3(iob->data), &s2, 2);
-	}
-
-	cmd = (struct qeth_ipa_arp_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
-	cmd->shdr.assist_no = IPA_ARP_PROCESSING;
-	cmd->shdr.length = 8 + data_len;
-	cmd->shdr.command_code = cmd_code;
-	cmd->shdr.return_code = 0;
-	cmd->shdr.seq_no = 0;
-
-	return iob;
-}
-
 static int
 qeth_send_ipa_arp_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
-		      char *data, int data_len,
-		      int (*reply_cb)
-		      (struct qeth_card *,struct qeth_reply*, unsigned long),
+		      int len, int (*reply_cb)
+			      		(struct qeth_card *,
+					 struct qeth_reply*, unsigned long),
 		      void *reply_param)
 {
 	int rc;
 
 	QETH_DBF_TEXT(trace,4,"sendarp");
 
-	memcpy(QETH_IPA_ARP_DATA_POS(iob->data), data, data_len);
+	memcpy(iob->data, IPA_PDU_HEADER, IPA_PDU_HEADER_SIZE);
 	memcpy(QETH_IPA_CMD_DEST_ADDR(iob->data),
 	       &card->token.ulp_connection_r, QETH_MPC_TOKEN_LENGTH);
-
-	rc = qeth_send_control_data(card, IPA_PDU_HEADER_SIZE +
-				    QETH_ARP_CMD_BASE_LEN + data_len, iob,
+	rc = qeth_send_control_data(card, IPA_PDU_HEADER_SIZE + len, iob,
 				    reply_cb, reply_param);
 	return rc;
 }
 
+static struct qeth_cmd_buffer *
+qeth_get_setassparms_cmd(struct qeth_card *, enum qeth_ipa_funcs,
+			 __u16, __u16, enum qeth_prot_versions);
 static int
 qeth_arp_query(struct qeth_card *card, char *udata)
 {
 	struct qeth_cmd_buffer *iob;
-	struct qeth_arp_query_data *qdata;
 	struct qeth_arp_query_info qinfo = {0, };
 	int tmp;
 	int rc;
@@ -4008,40 +3969,33 @@
 	 */
 	if (card->info.guestlan)
 		return -EOPNOTSUPP;
-	if (!qeth_is_supported(card,IPA_ARP_PROCESSING)) {
+	if (!qeth_is_supported(card,/*IPA_QUERY_ARP_ADDR_INFO*/
+			       IPA_ARP_PROCESSING)) {
 		PRINT_WARN("ARP processing not supported "
 			   "on %s!\n", card->info.if_name);
 		return -EOPNOTSUPP;
 	}
-	/* get size of userspace mem area */
+
 	if (copy_from_user(&qinfo.udata_len, udata, 4))
 		return -EFAULT;
 	if (!(qinfo.udata = kmalloc(qinfo.udata_len, GFP_KERNEL)))
 		return -ENOMEM;
 	memset(qinfo.udata, 0, qinfo.udata_len);
 	qinfo.udata_offset = QETH_QARP_ENTRIES_OFFSET;
-	/* alloc mem area for the actual query */
-	if (!(qdata = kmalloc(sizeof(struct qeth_arp_query_data),
-			      GFP_KERNEL))){
-		kfree(qinfo.udata);
-		return -ENOMEM;
-	}
-	memset(qdata, 0, sizeof(struct qeth_arp_query_data));
-	/* do not give sizeof(struct qeth_arp_query_data) to next command;
-	 * this would cause the IPA PDU size to be set to a value of > 256
-	 * and this is to much for HiperSockets */
-	iob = qeth_get_ipa_arp_cmd_buffer(card, IPA_CMD_ASS_ARP_QUERY_INFO,
-					  0, QETH_PROT_IPV4);
+	iob = qeth_get_setassparms_cmd(card, IPA_ARP_PROCESSING,
+				       IPA_CMD_ASS_ARP_QUERY_INFO,
+				       sizeof(int),QETH_PROT_IPV4);
+
 	rc = qeth_send_ipa_arp_cmd(card, iob,
-				   (char *) qdata,
-				   sizeof(struct qeth_arp_query_data),
+				   QETH_SETASS_BASE_LEN+QETH_ARP_CMD_LEN,
 				   qeth_arp_query_cb,
 				   (void *)&qinfo);
 	if (rc) {
 		tmp = rc;
-		PRINT_WARN("Error while querying ARP cache on %s: %s (0x%x)\n",
+		PRINT_WARN("Error while querying ARP cache on %s: %s "
+			   "(0x%x/%d)\n",
 			   card->info.if_name, qeth_arp_get_error_cause(&rc),
-			   tmp);
+			   tmp, tmp);
 		copy_to_user(udata, qinfo.udata, 4);
 	} else {
 		copy_to_user(udata, qinfo.udata, qinfo.udata_len);
@@ -4054,10 +4008,6 @@
 qeth_default_setassparms_cb(struct qeth_card *, struct qeth_reply *,
 			    unsigned long);
 
-static struct qeth_cmd_buffer *
-qeth_get_setassparms_cmd(struct qeth_card *, enum qeth_ipa_funcs,
-			 __u16, __u16, enum qeth_prot_versions);
-
 static int
 qeth_send_setassparms(struct qeth_card *, struct qeth_cmd_buffer *,
 		      __u16, long,
@@ -4101,9 +4051,9 @@
 		tmp = rc;
 		qeth_ipaddr4_to_string((u8 *)entry->ipaddr, buf);
 		PRINT_WARN("Could not add ARP entry for address %s on %s: "
-			   "%s (0x%x)\n",
+			   "%s (0x%x/%d)\n",
 			   buf, card->info.if_name,
-			   qeth_arp_get_error_cause(&rc), tmp);
+			   qeth_arp_get_error_cause(&rc), tmp, tmp);
 	}
 	return rc;
 }
@@ -4144,9 +4094,9 @@
 		memset(buf, 0, 16);
 		qeth_ipaddr4_to_string((u8 *)entry->ipaddr, buf);
 		PRINT_WARN("Could not delete ARP entry for address %s on %s: "
-			   "%s (0x%x)\n",
+			   "%s (0x%x/%d)\n",
 			   buf, card->info.if_name,
-			   qeth_arp_get_error_cause(&rc), tmp);
+			   qeth_arp_get_error_cause(&rc), tmp, tmp);
 	}
 	return rc;
 }
@@ -4165,7 +4115,7 @@
 	 * funcs flags); since all zeros is no valueable information,
 	 * we say EOPNOTSUPP for all ARP functions
 	 */
-	if (card->info.guestlan)
+	if (card->info.guestlan || (card->info.type == QETH_CARD_TYPE_IQD))
 		return -EOPNOTSUPP;
 	if (!qeth_is_supported(card,IPA_ARP_PROCESSING)) {
 		PRINT_WARN("ARP processing not supported "
@@ -4176,9 +4126,9 @@
 					  IPA_CMD_ASS_ARP_FLUSH_CACHE, 0);
 	if (rc){
 		tmp = rc;
-		PRINT_WARN("Could not flush ARP cache on %s: %s (0x%x)\n",
+		PRINT_WARN("Could not flush ARP cache on %s: %s (0x%x/%d)\n",
 			   card->info.if_name, qeth_arp_get_error_cause(&rc),
-			   tmp);
+			   tmp, tmp);
 	}
 	return rc;
 }
@@ -4198,7 +4148,6 @@
 		return -ENODEV;
 
 	switch (cmd){
-	case SIOCDEVPRIVATE:
 	case SIOC_QETH_ARP_SET_NO_ENTRIES:
 		if (!capable(CAP_NET_ADMIN)){
 			rc = -EPERM;
@@ -4206,7 +4155,6 @@
 		}
 		rc = qeth_arp_set_no_entries(card, rq->ifr_ifru.ifru_ivalue);
 		break;
-	case SIOCDEVPRIVATE+1:
 	case SIOC_QETH_ARP_QUERY_INFO:
 		if (!capable(CAP_NET_ADMIN)){
 			rc = -EPERM;
@@ -4214,7 +4162,6 @@
 		}
 		rc = qeth_arp_query(card, rq->ifr_ifru.ifru_data);
 		break;
-	case SIOCDEVPRIVATE+2:
 	case SIOC_QETH_ARP_ADD_ENTRY:
 		if (!capable(CAP_NET_ADMIN)){
 			rc = -EPERM;
@@ -4226,7 +4173,6 @@
 		else
 			rc = qeth_arp_add_entry(card, &arp_entry);
 		break;
-	case SIOCDEVPRIVATE+3:
 	case SIOC_QETH_ARP_REMOVE_ENTRY:
 		if (!capable(CAP_NET_ADMIN)){
 			rc = -EPERM;
@@ -4238,7 +4184,6 @@
 		else
 			rc = qeth_arp_remove_entry(card, &arp_entry);
 		break;
-	case SIOCDEVPRIVATE+4:
 	case SIOC_QETH_ARP_FLUSH_CACHE:
 		if (!capable(CAP_NET_ADMIN)){
 			rc = -EPERM;
@@ -4246,10 +4191,8 @@
 		}
 		rc = qeth_arp_flush_cache(card);
 		break;
-	case SIOCDEVPRIVATE+5:
 	case SIOC_QETH_ADP_SET_SNMP_CONTROL:
 		break;
-	case SIOCDEVPRIVATE+6:
 	case SIOC_QETH_GET_CARD_TYPE:
 		break;
 	case SIOCGMIIPHY:
@@ -4282,6 +4225,8 @@
 	default:
 		rc = -EOPNOTSUPP;
 	}
+	if (rc)
+		QETH_DBF_TEXT_(trace, 2, "ioce%d", rc);
 	return rc;
 }
 
@@ -4325,27 +4270,124 @@
 qeth_vlan_rx_register(struct net_device *dev, struct vlan_group *grp)
 {
 	struct qeth_card *card;
+	unsigned long flags;
 
 	QETH_DBF_TEXT(trace,4,"vlanreg");
 
 	card = (struct qeth_card *) dev->priv;
-	spin_lock_irq(&card->vlanlock);
+	spin_lock_irqsave(&card->vlanlock, flags);
 	card->vlangrp = grp;
-	spin_unlock_irq(&card->vlanlock);
+	spin_unlock_irqrestore(&card->vlanlock, flags);
+}
+
+static inline void
+qeth_free_vlan_buffer(struct qeth_card *card, struct qeth_qdio_out_buffer *buf,
+		      unsigned short vid)
+{
+	int i;
+	struct sk_buff *skb;
+	struct sk_buff_head tmp_list;
+
+	skb_queue_head_init(&tmp_list);
+	for(i = 0; i < QETH_MAX_BUFFER_ELEMENTS(card); ++i){
+		while ((skb = skb_dequeue(&buf->skb_list))){
+			if (vlan_tx_tag_present(skb) &&
+			    (vlan_tx_tag_get(skb) == vid)) {
+				atomic_dec(&skb->users);
+				dev_kfree_skb(skb);
+			} else
+				skb_queue_tail(&tmp_list, skb);
+		}
+	}
+	while ((skb = skb_dequeue(&tmp_list)))
+		skb_queue_tail(&buf->skb_list, skb);
+}
+
+static void
+qeth_free_vlan_skbs(struct qeth_card *card, unsigned short vid)
+{
+	int i, j;
+
+	QETH_DBF_TEXT(trace, 4, "frvlskbs");
+	for (i = 0; i < card->qdio.no_out_queues; ++i){
+		for (j = 0; j < QDIO_MAX_BUFFERS_PER_Q; ++j)
+			qeth_free_vlan_buffer(card, &card->qdio.
+					      out_qs[i]->bufs[j], vid);
+	}
+}
+
+static void
+qeth_free_vlan_addresses4(struct qeth_card *card, unsigned short vid)
+{
+	struct in_device *in_dev;
+	struct in_ifaddr *ifa;
+	struct qeth_ipaddr *addr;
+
+	QETH_DBF_TEXT(trace, 4, "frvaddr4");
+	if (!card->vlangrp)
+		return;
+	in_dev = in_dev_get(card->vlangrp->vlan_devices[vid]);
+	if (!in_dev)
+		return;
+	for (ifa = in_dev->ifa_list; ifa; ifa = ifa->ifa_next){
+		addr = qeth_get_addr_buffer(QETH_PROT_IPV4);
+		if (addr){
+			addr->u.a4.addr = ifa->ifa_address;
+			addr->u.a4.mask = ifa->ifa_mask;
+			addr->type = QETH_IP_TYPE_NORMAL;
+			if (!qeth_delete_ip(card, addr))
+				kfree(addr);
+		}
+	}
+	in_dev_put(in_dev);
+}
+
+static void
+qeth_free_vlan_addresses6(struct qeth_card *card, unsigned short vid)
+{
+	struct inet6_dev *in6_dev;
+	struct inet6_ifaddr *ifa;
+	struct qeth_ipaddr *addr;
+
+	QETH_DBF_TEXT(trace, 4, "frvaddr6");
+	if (!card->vlangrp)
+		return;
+	in6_dev = in6_dev_get(card->vlangrp->vlan_devices[vid]);
+	if (!in6_dev)
+		return;
+	for (ifa = in6_dev->addr_list; ifa; ifa = ifa->lst_next){
+		addr = qeth_get_addr_buffer(QETH_PROT_IPV6);
+		if (addr){
+			memcpy(&addr->u.a6.addr, &ifa->addr,
+			       sizeof(struct in6_addr));
+			addr->u.a6.pfxlen = ifa->prefix_len;
+			addr->type = QETH_IP_TYPE_NORMAL;
+			if (!qeth_delete_ip(card, addr))
+				kfree(addr);
+		}
+	}
+	in6_dev_put(in6_dev);
 }
 
 static void
 qeth_vlan_rx_kill_vid(struct net_device *dev, unsigned short vid)
 {
 	struct qeth_card *card;
+	unsigned long flags;
 
 	QETH_DBF_TEXT(trace,4,"vlkilvid");
 
 	card = (struct qeth_card *) dev->priv;
-	spin_lock_irq(&card->vlanlock);
+	/* free all skbs for the vlan device */
+	qeth_free_vlan_skbs(card, vid);
+	spin_lock_irqsave(&card->vlanlock, flags);
+	/* unregister IP addresses of vlan device */
+	qeth_free_vlan_addresses4(card, vid);
+	qeth_free_vlan_addresses6(card, vid);
 	if (card->vlangrp)
 		card->vlangrp->vlan_devices[vid] = NULL;
-	spin_unlock_irq(&card->vlanlock);
+	spin_unlock_irqrestore(&card->vlanlock, flags);
+	qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD);
 	/* delete mc addresses for this vlan dev */
 	qeth_set_thread_start_bit(card, QETH_SET_MC_THREAD);
 	schedule_work(&card->kernel_thread_starter);
@@ -4401,10 +4443,6 @@
 	memset(addr,0,sizeof(struct qeth_ipaddr));
 	addr->type = QETH_IP_TYPE_NORMAL;
 	addr->proto = prot;
-	addr->is_multicast = 0;
-	addr->users = 0;
-	addr->set_flags = 0;
-	addr->del_flags = 0;
 	return addr;
 }
 
@@ -4811,6 +4849,26 @@
 	return 0;
 }
 
+static void
+qeth_init_func_level(struct qeth_card *card)
+{
+	if (card->ipato.enabled) {
+		if (card->info.type == QETH_CARD_TYPE_IQD)
+				card->info.func_level =
+					QETH_IDX_FUNC_LEVEL_IQD_ENA_IPAT;
+		else
+				card->info.func_level =
+					QETH_IDX_FUNC_LEVEL_OSAE_ENA_IPAT;
+	} else {
+		if (card->info.type == QETH_CARD_TYPE_IQD)
+			card->info.func_level =
+				QETH_IDX_FUNC_LEVEL_IQD_DIS_IPAT;
+		else
+			card->info.func_level =
+				QETH_IDX_FUNC_LEVEL_OSAE_DIS_IPAT;
+	}
+}
+
 /**
  * hardsetup card, initialize MPC and QDIO stuff
  */
@@ -4848,6 +4906,7 @@
 		return rc;
 	}
 	qeth_init_tokens(card);
+	qeth_init_func_level(card);
 	rc = qeth_idx_activate_channel(&card->read, qeth_idx_read_cb);
 	if (rc == -ERESTARTSYS) {
 		QETH_DBF_TEXT(setup, 2, "break2");
@@ -4885,7 +4944,6 @@
 			QETH_DBF_TEXT_(setup, 2, "6err%d", rc);
 			goto out;
 		}
-		qeth_set_device_name(card);
 		card->dev->priv = card;
 		card->dev->type = qeth_get_arphdr_type(card->info.type,
 						       card->info.link_type);
@@ -4898,7 +4956,7 @@
 }
 
 static struct qeth_cmd_buffer *
-qeth_get_adapter_cmd(struct qeth_card *card, __u32 command)
+qeth_get_adapter_cmd(struct qeth_card *card, __u32 command, __u32 cmdlen)
 {
 	struct qeth_cmd_buffer *iob;
 	struct qeth_ipa_cmd *cmd;
@@ -4906,11 +4964,10 @@
 	iob = qeth_get_ipacmd_buffer(card,IPA_CMD_SETADAPTERPARMS,
 				     QETH_PROT_IPV4);
 	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
-	cmd->data.setadapterparms.cmdlength =
-				sizeof(struct qeth_ipacmd_setadpparms);
-	cmd->data.setadapterparms.command_code = command;
-	cmd->data.setadapterparms.frames_used_total = 1;
-	cmd->data.setadapterparms.frame_seq_no = 1;
+	cmd->data.setadapterparms.hdr.cmdlength = cmdlen;
+	cmd->data.setadapterparms.hdr.command_code = command;
+	cmd->data.setadapterparms.hdr.used_total = 1;
+	cmd->data.setadapterparms.hdr.seq_no = 1;
 
 	return iob;
 }
@@ -4952,7 +5009,7 @@
 
 	cmd = (struct qeth_ipa_cmd *) data;
 	if (cmd->hdr.return_code == 0)
-		cmd->hdr.return_code = cmd->data.setadapterparms.return_code;
+		cmd->hdr.return_code = cmd->data.setadapterparms.hdr.return_code;
 	return 0;
 }
 
@@ -4980,7 +5037,8 @@
 	struct qeth_cmd_buffer *iob;
 
 	QETH_DBF_TEXT(trace,3,"queryadp");
-	iob = qeth_get_adapter_cmd(card,IPA_SETADP_QUERY_COMMANDS_SUPPORTED);
+	iob = qeth_get_adapter_cmd(card, IPA_SETADP_QUERY_COMMANDS_SUPPORTED,
+				   sizeof(struct qeth_ipacmd_setadpparms));
 	rc = qeth_send_ipa_cmd(card, iob, qeth_query_setadapterparms_cb, NULL);
 	return rc;
 }
@@ -5010,7 +5068,8 @@
 
 	QETH_DBF_TEXT(trace,4,"chgmac");
 
-	iob = qeth_get_adapter_cmd(card,IPA_SETADP_ALTER_MAC_ADDRESS);
+	iob = qeth_get_adapter_cmd(card,IPA_SETADP_ALTER_MAC_ADDRESS,
+				   sizeof(struct qeth_ipacmd_setadpparms));
 	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
 	cmd->data.setadapterparms.data.change_addr.cmd = CHANGE_ADDR_READ_MAC;
 	cmd->data.setadapterparms.data.change_addr.addr_size = OSA_ADDR_LEN;
@@ -5030,7 +5089,8 @@
 
 	QETH_DBF_TEXT(trace,4,"adpmode");
 
-	iob = qeth_get_adapter_cmd(card, command);
+	iob = qeth_get_adapter_cmd(card, command,
+				   sizeof(struct qeth_ipacmd_setadpparms));
 	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
 	cmd->data.setadapterparms.data.mode = mode;
 	rc = qeth_send_ipa_cmd(card, iob, qeth_default_setadapterparms_cb,
@@ -5459,18 +5519,20 @@
 	int rc;
 
 	QETH_DBF_TEXT(trace,3,"stbrdcst");
+	card->info.broadcast_capable = 0;
 	if (!qeth_is_supported(card, IPA_FILTERING)) {
 		PRINT_WARN("Broadcast not supported on %s\n",
 			   card->info.if_name);
-		return -EOPNOTSUPP;
+		rc = -EOPNOTSUPP;
+		goto out;
 	}
 	rc = qeth_send_simple_setassparms(card, IPA_FILTERING,
 					  IPA_CMD_ASS_START, 0);
 	if (rc) {
-		PRINT_WARN("Could not enable broadcasting "
+		PRINT_WARN("Could not enable broadcasting filtering "
 			   "on %s: 0x%x\n",
 			   card->info.if_name, rc);
-		return rc;
+		goto out;
 	}
 
 	rc = qeth_send_simple_setassparms(card, IPA_FILTERING,
@@ -5478,12 +5540,24 @@
 	if (rc) {
 		PRINT_WARN("Could not set up broadcast filtering on %s: 0x%x\n",
 			   card->info.if_name, rc);
-		return rc;
+		goto out;
 	}
+	card->info.broadcast_capable = QETH_BROADCAST_WITH_ECHO;
 	PRINT_INFO("Broadcast enabled \n");
-	card->dev->flags |= IFF_BROADCAST;
-	card->info.broadcast_capable = 1;
-	return 0;
+	rc = qeth_send_simple_setassparms(card, IPA_FILTERING,
+					  IPA_CMD_ASS_ENABLE, 1);
+	if (rc) {
+		PRINT_WARN("Could not set up broadcast echo filtering on "
+			   "%s: 0x%x\n", card->info.if_name, rc);
+		goto out;
+	}
+	card->info.broadcast_capable = QETH_BROADCAST_WITHOUT_ECHO;
+out:
+	if (card->info.broadcast_capable)
+		card->dev->flags |= IFF_BROADCAST;
+	else
+		card->dev->flags &= ~IFF_BROADCAST;
+	return rc;
 }
 
 static int
@@ -5781,7 +5855,6 @@
 qeth_clear_ip_list(struct qeth_card *card, int clean, int recover)
 {
 	struct qeth_ipaddr *addr, *tmp;
-	int first_run = 1;
 	unsigned long flags;
 
 	QETH_DBF_TEXT(trace,4,"clearip");
@@ -5791,29 +5864,21 @@
 		list_del(&addr->entry);
 		kfree(addr);
 	}
-again:
-	if (first_run)
-		first_run = 0;
-	else
-		spin_lock_irqsave(&card->ip_lock, flags);
 
-	list_for_each_entry_safe(addr, tmp, &card->ip_list, entry) {
+	while (!list_empty(&card->ip_list)) {
+		addr = list_entry(card->ip_list.next,
+				  struct qeth_ipaddr, entry);
 		list_del_init(&addr->entry);
-		if (clean){
+		if (clean) {
 			spin_unlock_irqrestore(&card->ip_lock, flags);
 			qeth_deregister_addr_entry(card, addr);
+			spin_lock_irqsave(&card->ip_lock, flags);
 		}
-		if (!recover || addr->is_multicast)
+		if (!recover || addr->is_multicast) {
 			kfree(addr);
-		else {
-			if (clean)
-				spin_lock_irqsave(&card->ip_lock, flags);
-			list_add_tail(&addr->entry, &card->ip_tbd_list);
-			if (clean) {
-				spin_unlock_irqrestore(&card->ip_lock, flags);
-				goto again;
-			}
+			continue;
 		}
+		list_add_tail(&addr->entry, &card->ip_tbd_list);
 	}
 	spin_unlock_irqrestore(&card->ip_lock, flags);
 }
@@ -6775,12 +6840,16 @@
 	int rc=0;
 
 	qeth_eyecatcher();
-	printk(KERN_INFO "qeth: loading %s\n",version);
+	PRINT_INFO("loading %s (%s/%s/%s/%s/%s/%s/%s %s %s)\n",
+		   version, VERSION_QETH_C, VERSION_QETH_H,
+		   VERSION_QETH_MPC_H, VERSION_QETH_MPC_C,
+		   VERSION_QETH_FS_H, VERSION_QETH_PROC_C,
+		   VERSION_QETH_SYS_C, QETH_VERSION_IPV6,
+		   QETH_VERSION_VLAN);
 
 	INIT_LIST_HEAD(&qeth_card_list.list);
 	rwlock_init(&qeth_card_list.rwlock);
 
-	atomic_set(&qeth_hsi_count, 0);
 	if (qeth_register_dbf_views())
 		goto out_err;
 	if (qeth_sysfs_register())
diff -urN linux-2.6/drivers/s390/net/qeth_mpc.c linux-2.6-s390/drivers/s390/net/qeth_mpc.c
--- linux-2.6/drivers/s390/net/qeth_mpc.c	Mon May 10 04:32:39 2004
+++ linux-2.6-s390/drivers/s390/net/qeth_mpc.c	Thu May 13 21:01:05 2004
@@ -11,6 +11,8 @@
 #include <asm/cio.h>
 #include "qeth_mpc.h"
 
+const char *VERSION_QETH_MPC_C = "$Revision: 1.11 $";
+
 unsigned char IDX_ACTIVATE_READ[]={
 	0x00,0x00,0x80,0x00, 0x00,0x00,0x00,0x00,
 	0x19,0x01,0x01,0x80, 0x00,0x00,0x00,0x00,
@@ -129,8 +131,7 @@
 	0x00,0x00,0x00,0x14, 0x00,0x00,
 		(IPA_PDU_HEADER_SIZE+sizeof(struct qeth_ipa_cmd))/256,
 		(IPA_PDU_HEADER_SIZE+sizeof(struct qeth_ipa_cmd))%256,
-	0x10,0x00,0x00,0x01,
-	0x00,0x00,0x00,0x00,
+	0x10,0x00,0x00,0x01, 0x00,0x00,0x00,0x00,
 	0xc1,0x03,0x00,0x01, 0x00,0x00,0x00,0x00,
 	0x00,0x00,0x00,0x00, 0x00,0x24,
 		sizeof(struct qeth_ipa_cmd)/256,
diff -urN linux-2.6/drivers/s390/net/qeth_mpc.h linux-2.6-s390/drivers/s390/net/qeth_mpc.h
--- linux-2.6/drivers/s390/net/qeth_mpc.h	Mon May 10 04:32:29 2004
+++ linux-2.6-s390/drivers/s390/net/qeth_mpc.h	Thu May 13 21:01:05 2004
@@ -14,7 +14,9 @@
 
 #include <asm/qeth.h>
 
-#define VERSION_QETH_MPC_H "$Revision: 1.27 $"
+#define VERSION_QETH_MPC_H "$Revision: 1.34 $"
+
+extern const char *VERSION_QETH_MPC_C;
 
 #define IPA_PDU_HEADER_SIZE	0x40
 #define QETH_IPA_PDU_LEN_TOTAL(buffer) (buffer+0x0e)
@@ -33,6 +35,7 @@
 #define OSA_ADDR_LEN		6
 
 #define QETH_TIMEOUT 		(10 * HZ)
+#define QETH_IPA_TIMEOUT 	(45 * HZ)
 #define QETH_IDX_COMMAND_SEQNO 	-1
 #define SR_INFO_LEN		16
 
@@ -245,12 +248,28 @@
 	__u8 seq_no;
 } __attribute__((packed));
 
+struct qeth_arp_query_data {
+	__u16 request_bits;
+	__u16 reply_bits;
+	__u32 no_entries;
+	char data;
+} __attribute__((packed));
+
+/* used as parameter for arp_query reply */
+struct qeth_arp_query_info {
+	__u32 udata_len;
+	__u32 udata_offset;
+	__u32 no_entries;
+	char *udata;
+};
+
 /* SETASSPARMS IPA Command: */
 struct qeth_ipacmd_setassparms {
 	struct qeth_ipacmd_setassparms_hdr hdr;
 	union {
 		__u32 flags_32bit;
 		struct qeth_arp_cache_entry add_arp_entry;
+		struct qeth_arp_query_data query_arp;
 		__u8 ip[16];
 	} data;
 } __attribute__ ((packed));
@@ -277,16 +296,20 @@
 	__u8 addr[OSA_ADDR_LEN];
 } __attribute__ ((packed));
 
-struct qeth_ipacmd_setadpparms {
+struct qeth_ipacmd_setadpparms_hdr {
 	__u32 supp_hw_cmds;
 	__u32 reserved1;
 	__u16 cmdlength;
 	__u16 reserved2;
 	__u32 command_code;
 	__u16 return_code;
-	__u8 frames_used_total;
-	__u8 frame_seq_no;
+	__u8  used_total;
+	__u8  seq_no;
 	__u32 reserved3;
+} __attribute__ ((packed));
+
+struct qeth_ipacmd_setadpparms {
+	struct qeth_ipacmd_setadpparms_hdr hdr;
 	union {
 		struct qeth_query_cmds_supp query_cmds_supp;
 		struct qeth_change_addr change_addr;
@@ -357,36 +380,16 @@
 	QETH_IPA_ARP_RC_Q_NO_DATA    = 0x0008,
 };
 
-#define QETH_QARP_DATA_SIZE 3968
-struct qeth_arp_query_data {
-	__u16 request_bits;
-	__u16 reply_bits;
-	__u32 no_entries;
-	char data[QETH_QARP_DATA_SIZE];
-} __attribute__((packed));
-
-/* used as parameter for arp_query reply */
-struct qeth_arp_query_info {
-	__u32 udata_len;
-	__u32 udata_offset;
-	__u32 no_entries;
-	char *udata;
-};
-
-#define IPA_ARP_CMD_LEN (IPA_PDU_HEADER_SIZE+sizeof(struct qeth_ipa_arp_cmd))
-#define QETH_ARP_CMD_BASE_LEN (sizeof(struct qeth_ipacmd_hdr) + \
+#define QETH_SETASS_BASE_LEN (sizeof(struct qeth_ipacmd_hdr) + \
 			       sizeof(struct qeth_ipacmd_setassparms_hdr))
 #define QETH_IPA_ARP_DATA_POS(buffer) (buffer + IPA_PDU_HEADER_SIZE + \
-				       QETH_ARP_CMD_BASE_LEN)
-struct qeth_ipa_arp_cmd {
-	struct qeth_ipacmd_hdr ihdr;
-	struct qeth_ipacmd_setassparms_hdr shdr;
-	union {
-		struct qeth_arp_query_data query_arp;
-	} data;
-} __attribute__((packed));
-
+				       QETH_SETASS_BASE_LEN)
+#define QETH_SETADP_BASE_LEN (sizeof(struct qeth_ipacmd_hdr) + \
+			      sizeof(struct qeth_ipacmd_setadpparms_hdr))
+#define QETH_SNMP_SETADP_CMDLENGTH 16
 
+#define QETH_ARP_DATA_SIZE 3968
+#define QETH_ARP_CMD_LEN (QETH_ARP_DATA_SIZE + 8)
 /* Helper functions */
 #define IS_IPA_REPLY(cmd) (cmd->hdr.initiator == IPA_CMD_INITIATOR_HOST)
 
diff -urN linux-2.6/drivers/s390/net/qeth_proc.c linux-2.6-s390/drivers/s390/net/qeth_proc.c
--- linux-2.6/drivers/s390/net/qeth_proc.c	Mon May 10 04:32:37 2004
+++ linux-2.6-s390/drivers/s390/net/qeth_proc.c	Thu May 13 21:01:05 2004
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_fs.c ($Revision: 1.5 $)
+ * linux/drivers/s390/net/qeth_fs.c ($Revision: 1.9 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  * This file contains code related to procfs.
@@ -21,6 +21,8 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
+const char *VERSION_QETH_PROC_C = "$Revision: 1.9 $";
+
 /***** /proc/qeth *****/
 #define QETH_PROCFILE_NAME "qeth"
 static struct proc_dir_entry *qeth_procfile;
@@ -91,13 +93,19 @@
 		return "pri";
 	else if (routing_type == SECONDARY_ROUTER)
 		return "sec";
-	else if (routing_type == MULTICAST_ROUTER)
+	else if (routing_type == MULTICAST_ROUTER) {
+		if (card->info.broadcast_capable == QETH_BROADCAST_WITHOUT_ECHO)
+			return "mc+";
 		return "mc";
-	else if (routing_type == PRIMARY_CONNECTOR)
+	} else if (routing_type == PRIMARY_CONNECTOR) {
+		if (card->info.broadcast_capable == QETH_BROADCAST_WITHOUT_ECHO)
+			return "p+c";
 		return "p.c";
-	else if (routing_type == SECONDARY_CONNECTOR)
+	} else if (routing_type == SECONDARY_CONNECTOR) {
+		if (card->info.broadcast_capable == QETH_BROADCAST_WITHOUT_ECHO)
+			return "s+c";
 		return "s.c";
-	else if (routing_type == NO_ROUTER)
+	} else if (routing_type == NO_ROUTER)
 		return "no";
 	else
 		return "unk";
@@ -244,14 +252,18 @@
 				: 0
 		  );
 	seq_printf(s, "  Inbound time (in us)                   : %i\n"
-		      "  Inbound cnt                            : %i\n"
+		      "  Inbound count                          : %i\n"
+		      "  Inboud do_QDIO count                   : %i\n"
 		      "  Outbound time (in us, incl QDIO)       : %i\n"
-		      "  Outbound cnt                           : %i\n"
+		      "  Outbound count                         : %i\n"
+		      "  Outbound do_QDIO count                 : %i\n"
 		      "  Watermarks L/H                         : %i/%i\n\n",
 		        card->perf_stats.inbound_time,
 			card->perf_stats.inbound_cnt,
+			card->perf_stats.inbound_do_qdio,
 			card->perf_stats.outbound_time,
 			card->perf_stats.outbound_cnt,
+			card->perf_stats.outbound_do_qdio,
 			QETH_LOW_WATERMARK_PACK, QETH_HIGH_WATERMARK_PACK
 		  );
 
diff -urN linux-2.6/drivers/s390/net/qeth_sys.c linux-2.6-s390/drivers/s390/net/qeth_sys.c
--- linux-2.6/drivers/s390/net/qeth_sys.c	Mon May 10 04:32:38 2004
+++ linux-2.6-s390/drivers/s390/net/qeth_sys.c	Thu May 13 21:01:05 2004
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.24 $)
+ * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.29 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  * This file contains code related to sysfs.
@@ -20,6 +20,8 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
+const char *VERSION_QETH_SYS_C = "$Revision: 1.29 $";
+
 /*****************************************************************************/
 /*                                                                           */
 /*          /sys-fs stuff UNDER DEVELOPMENT !!!                              */
@@ -737,6 +739,10 @@
 	if (!card)
 		return -EINVAL;
 
+	if ((card->state != CARD_STATE_DOWN) &&
+	    (card->state != CARD_STATE_RECOVER))
+		return -EPERM;
+
 	tmp = strsep((char **) &buf, "\n");
 	if (!strcmp(tmp, "toggle")){
 		card->ipato.enabled = (card->ipato.enabled)? 0 : 1;
diff -urN linux-2.6/include/asm-s390/qeth.h linux-2.6-s390/include/asm-s390/qeth.h
--- linux-2.6/include/asm-s390/qeth.h	Mon May 10 04:32:54 2004
+++ linux-2.6-s390/include/asm-s390/qeth.h	Thu May 13 21:01:05 2004
@@ -12,15 +12,13 @@
 #define __ASM_S390_IOCTL_H__
 #include <linux/ioctl.h>
 
-#define QETH_IOCTL_LETTER 'Q'
-
-#define SIOC_QETH_ARP_SET_NO_ENTRIES	_IOWR(QETH_IOCTL_LETTER, 1, int)
-#define SIOC_QETH_ARP_QUERY_INFO	_IOWR(QETH_IOCTL_LETTER, 2, int)
-#define SIOC_QETH_ARP_ADD_ENTRY		_IOWR(QETH_IOCTL_LETTER, 3, int)
-#define SIOC_QETH_ARP_REMOVE_ENTRY	_IOWR(QETH_IOCTL_LETTER, 4, int)
-#define SIOC_QETH_ARP_FLUSH_CACHE	_IOWR(QETH_IOCTL_LETTER, 5, int)
-#define SIOC_QETH_ADP_SET_SNMP_CONTROL	_IOWR(QETH_IOCTL_LETTER, 6, int)
-#define SIOC_QETH_GET_CARD_TYPE		_IOWR(QETH_IOCTL_LETTER, 7, int)
+#define SIOC_QETH_ARP_SET_NO_ENTRIES    (SIOCDEVPRIVATE)
+#define SIOC_QETH_ARP_QUERY_INFO        (SIOCDEVPRIVATE + 1)
+#define SIOC_QETH_ARP_ADD_ENTRY         (SIOCDEVPRIVATE + 2)
+#define SIOC_QETH_ARP_REMOVE_ENTRY      (SIOCDEVPRIVATE + 3)
+#define SIOC_QETH_ARP_FLUSH_CACHE       (SIOCDEVPRIVATE + 4)
+#define SIOC_QETH_ADP_SET_SNMP_CONTROL  (SIOCDEVPRIVATE + 5)
+#define SIOC_QETH_GET_CARD_TYPE         (SIOCDEVPRIVATE + 6)
 
 struct qeth_arp_cache_entry {
 	__u8  macaddr[6];
