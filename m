Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUDHO76 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 10:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbUDHO76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 10:59:58 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:3824 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261879AbUDHO3e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 10:29:34 -0400
Date: Thu, 8 Apr 2004 16:29:22 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (5/12): network driver fixes.
Message-ID: <20040408142922.GF1793@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Network driver changes:
 - ctc: move kfree of driver structure after the last use of it.
 - netiucv: stay in state startwait if peer is down.
 - lcs: initialize ipm_list and unregister netdev only if it is present.

diffstat:
 drivers/s390/net/ctctty.c  |    4 +-
 drivers/s390/net/lcs.c     |   10 +++--
 drivers/s390/net/netiucv.c |   88 ++++++++++++++-------------------------------
 3 files changed, 37 insertions(+), 65 deletions(-)

diff -urN linux-2.6/drivers/s390/net/ctctty.c linux-2.6-s390/drivers/s390/net/ctctty.c
--- linux-2.6/drivers/s390/net/ctctty.c	Sun Apr  4 05:37:23 2004
+++ linux-2.6-s390/drivers/s390/net/ctctty.c	Thu Apr  8 15:21:26 2004
@@ -1,5 +1,5 @@
 /*
- * $Id: ctctty.c,v 1.16 2004/02/05 12:39:55 felfert Exp $
+ * $Id: ctctty.c,v 1.17 2004/03/31 17:06:34 ptiedem Exp $
  *
  * CTC / ESCON network driver, tty interface.
  *
@@ -1232,7 +1232,7 @@
 	ctc_tty_shuttingdown = 1;
 	spin_unlock_irqrestore(&ctc_tty_lock, saveflags);
 	tty_unregister_driver(driver->ctc_tty_device);
-	kfree(driver);
 	put_tty_driver(driver->ctc_tty_device);
+	kfree(driver);
 	driver = NULL;
 }
diff -urN linux-2.6/drivers/s390/net/lcs.c linux-2.6-s390/drivers/s390/net/lcs.c
--- linux-2.6/drivers/s390/net/lcs.c	Sun Apr  4 05:36:19 2004
+++ linux-2.6-s390/drivers/s390/net/lcs.c	Thu Apr  8 15:21:26 2004
@@ -11,7 +11,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Martin Schwidefsky <schwidefsky@de.ibm.com>
  *
- *    $Revision: 1.72 $	 $Date: 2004/03/22 09:34:27 $
+ *    $Revision: 1.74 $	 $Date: 2004/04/05 00:01:04 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -58,7 +58,7 @@
 /**
  * initialization string for output
  */
-#define VERSION_LCS_C  "$Revision: 1.72 $"
+#define VERSION_LCS_C  "$Revision: 1.74 $"
 
 static char version[] __initdata = "LCS driver ("VERSION_LCS_C "/" VERSION_LCS_H ")";
 static char debug_buffer[255];
@@ -206,6 +206,9 @@
 		return NULL;
 	}
 
+#ifdef CONFIG_IP_MULTICAST
+	INIT_LIST_HEAD(&card->ipm_list);
+#endif
 	LCS_DBF_HEX(2, setup, &card, sizeof(void*));
 	return card;
 }
@@ -1967,7 +1970,8 @@
 	if (ccwgdev->state == CCWGROUP_ONLINE) {
 		lcs_shutdown_device(ccwgdev);
 	}
-	unregister_netdev(card->dev);
+	if (card->dev)
+		unregister_netdev(card->dev);
 	sysfs_remove_group(&ccwgdev->dev.kobj, &lcs_attr_group);
 	lcs_cleanup_card(card);
 	lcs_free_card(card);
diff -urN linux-2.6/drivers/s390/net/netiucv.c linux-2.6-s390/drivers/s390/net/netiucv.c
--- linux-2.6/drivers/s390/net/netiucv.c	Sun Apr  4 05:37:23 2004
+++ linux-2.6-s390/drivers/s390/net/netiucv.c	Thu Apr  8 15:21:26 2004
@@ -1,5 +1,5 @@
 /*
- * $Id: netiucv.c,v 1.47 2004/03/22 07:41:42 braunu Exp $
+ * $Id: netiucv.c,v 1.48 2004/04/01 13:42:09 braunu Exp $
  *
  * IUCV network driver
  *
@@ -30,7 +30,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV network driver $Revision: 1.47 $
+ * RELEASE-TAG: IUCV network driver $Revision: 1.48 $
  *
  */
 
@@ -100,7 +100,6 @@
 	int                       max_buffsize;
 	int                       flags;
 	fsm_timer                 timer;
-	int                       retry;
 	fsm_instance              *fsm;
 	struct net_device         *netdev;
 	struct connection_profile prof;
@@ -169,8 +168,6 @@
 	return test_and_set_bit(0, &((struct netiucv_priv *)dev->priv)->tbusy);
 }
 
-#define SET_DEVICE_START(device, value)
-
 static __u8 iucv_host[8] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
 static __u8 iucvMagic[16] = {
 	0xF0, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40,
@@ -217,7 +214,6 @@
 	DEV_STATE_STARTWAIT,
 	DEV_STATE_STOPWAIT,
 	DEV_STATE_RUNNING,
-	DEV_STATE_STARTRETRY,
 	/**
 	 * MUST be always the last element!!
 	 */
@@ -229,7 +225,6 @@
 	"StartWait",
 	"StopWait",
 	"Running",
-	"StartRetry",
 };
 
 /**
@@ -599,7 +594,6 @@
 
 	pr_debug("%s() called\n", __FUNCTION__);
 
-	fsm_deltimer(&conn->timer);
 	if (conn && conn->netdev && conn->netdev->priv)
 		privptr = (struct netiucv_priv *)conn->netdev->priv;
 	conn->prof.tx_pending--;
@@ -639,8 +633,6 @@
 		memcpy(skb_put(conn->tx_buff, NETIUCV_HDRLEN), &header,
 		       NETIUCV_HDRLEN);
 
-		fsm_addtimer(&conn->timer, NETIUCV_TIMEOUT_5SEC,
-			     CONN_EVENT_TIMER, conn);
 		conn->prof.send_stamp = xtime;
 		rc = iucv_send(conn->pathid, NULL, 0, 0, 0, 0,
 			       conn->tx_buff->data, conn->tx_buff->len);
@@ -650,7 +642,6 @@
 		if (conn->prof.tx_pending > conn->prof.tx_max_pending)
 			conn->prof.tx_max_pending = conn->prof.tx_pending;
 		if (rc != 0) {
-			fsm_deltimer(&conn->timer);
 			conn->prof.tx_pending--;
 			fsm_newstate(fi, CONN_STATE_IDLE);
 			if (privptr)
@@ -721,6 +712,7 @@
 
 	pr_debug("%s() called\n", __FUNCTION__);
 
+	fsm_deltimer(&conn->timer);
 	fsm_newstate(fi, CONN_STATE_IDLE);
 	conn->pathid = eib->ippathid;
 	netdev->tx_queue_len = eib->ipmsglim;
@@ -728,35 +720,35 @@
 }
 
 static void
+conn_action_conntimsev(fsm_instance *fi, int event, void *arg)
+{
+	struct iucv_connection *conn = (struct iucv_connection *)arg;
+	__u8 udata[16];
+
+	pr_debug("%s() called\n", __FUNCTION__);
+
+	fsm_deltimer(&conn->timer);
+	iucv_sever(conn->pathid, udata);
+	fsm_newstate(fi, CONN_STATE_STARTWAIT);
+}
+
+static void
 conn_action_connsever(fsm_instance *fi, int event, void *arg)
 {
 	struct iucv_event *ev = (struct iucv_event *)arg;
 	struct iucv_connection *conn = ev->conn;
-	// iucv_ConnectionSevered *eib = (iucv_ConnectionSevered *)ev->data;
 	struct net_device *netdev = conn->netdev;
 	struct netiucv_priv *privptr = (struct netiucv_priv *)netdev->priv;
-	int state = fsm_getstate(fi);
+	__u8 udata[16];
 
 	pr_debug("%s() called\n", __FUNCTION__);
 
-	switch (state) {
-		case CONN_STATE_SETUPWAIT:
-			printk(KERN_INFO "%s: Remote dropped connection\n",
-			       netdev->name);
-			fsm_newstate(fi, CONN_STATE_STOPPED);
-			fsm_event(privptr->fsm, DEV_EVENT_CONDOWN, netdev);
-			break;
-		case CONN_STATE_IDLE:
-		case CONN_STATE_TX:
-			printk(KERN_INFO "%s: Remote dropped connection\n",
-			       netdev->name);
-			if (conn->handle)
-				iucv_unregister_program(conn->handle);
-			conn->handle = 0;
-			fsm_newstate(fi, CONN_STATE_STOPPED);
-			fsm_event(privptr->fsm, DEV_EVENT_CONDOWN, netdev);
-			break;
-	}
+	fsm_deltimer(&conn->timer);
+	iucv_sever(conn->pathid, udata);
+	printk(KERN_INFO "%s: Remote dropped connection\n",
+	       netdev->name);
+	fsm_newstate(fi, CONN_STATE_STARTWAIT);
+	fsm_event(privptr->fsm, DEV_EVENT_CONDOWN, netdev);
 }
 
 static void
@@ -798,6 +790,8 @@
 	switch (rc) {
 		case 0:
 			conn->netdev->tx_queue_len = msglimit;
+			fsm_addtimer(&conn->timer, NETIUCV_TIMEOUT_5SEC,
+				CONN_EVENT_TIMER, conn);
 			return;
 		case 11:
 			printk(KERN_NOTICE
@@ -864,6 +858,7 @@
 
 	pr_debug("%s() called\n", __FUNCTION__);
 
+	fsm_deltimer(&conn->timer);
 	fsm_newstate(fi, CONN_STATE_STOPPED);
 	netiucv_purge_skb_queue(&conn->collect_queue);
 	if (conn->handle)
@@ -888,7 +883,6 @@
 static const fsm_node conn_fsm[] = {
 	{ CONN_STATE_INVALID,   CONN_EVENT_START,    conn_action_inval      },
 	{ CONN_STATE_STOPPED,   CONN_EVENT_START,    conn_action_start      },
-	{ CONN_STATE_STARTWAIT, CONN_EVENT_START,    conn_action_start      },
 
 	{ CONN_STATE_STOPPED,   CONN_EVENT_STOP,     conn_action_stop       },
 	{ CONN_STATE_STARTWAIT, CONN_EVENT_STOP,     conn_action_stop       },
@@ -905,6 +899,7 @@
 	{ CONN_STATE_TX,        CONN_EVENT_CONN_REQ, conn_action_connreject },
 
 	{ CONN_STATE_SETUPWAIT, CONN_EVENT_CONN_ACK, conn_action_connack    },
+	{ CONN_STATE_SETUPWAIT, CONN_EVENT_TIMER,    conn_action_conntimsev },
 
 	{ CONN_STATE_SETUPWAIT, CONN_EVENT_CONN_REJ, conn_action_connsever  },
 	{ CONN_STATE_IDLE,      CONN_EVENT_CONN_REJ, conn_action_connsever  },
@@ -940,7 +935,6 @@
 
 	pr_debug("%s() called\n", __FUNCTION__);
 
-	fsm_deltimer(&privptr->timer);
 	ev.conn = privptr->conn;
 	fsm_newstate(fi, DEV_STATE_STARTWAIT);
 	fsm_event(privptr->conn->fsm, CONN_EVENT_START, &ev);
@@ -964,7 +958,6 @@
 
 	ev.conn = privptr->conn;
 
-	fsm_deltimer(&privptr->timer);
 	fsm_newstate(fi, DEV_STATE_STOPWAIT);
 	fsm_event(privptr->conn->fsm, CONN_EVENT_STOP, &ev);
 }
@@ -981,13 +974,10 @@
 dev_action_connup(fsm_instance *fi, int event, void *arg)
 {
 	struct net_device   *dev = (struct net_device *)arg;
-	struct netiucv_priv *privptr = dev->priv;
 
 	pr_debug("%s() called\n", __FUNCTION__);
 
 	switch (fsm_getstate(fi)) {
-		case DEV_STATE_STARTRETRY:
-			fsm_deltimer(&privptr->timer);
 		case DEV_STATE_STARTWAIT:
 			fsm_newstate(fi, DEV_STATE_RUNNING);
 			printk(KERN_INFO
@@ -1013,22 +1003,11 @@
 static void
 dev_action_conndown(fsm_instance *fi, int event, void *arg)
 {
-	struct net_device   *dev = (struct net_device *)arg;
-	struct netiucv_priv *privptr = dev->priv;
-	struct iucv_event   ev;
-
 	pr_debug("%s() called\n", __FUNCTION__);
 
 	switch (fsm_getstate(fi)) {
 		case DEV_STATE_RUNNING:
 			fsm_newstate(fi, DEV_STATE_STARTWAIT);
-			ev.conn = privptr->conn;
-			fsm_event(privptr->conn->fsm, CONN_EVENT_START, &ev);
-			break;
-		case DEV_STATE_STARTWAIT:
-			fsm_addtimer(&privptr->timer, NETIUCV_TIMEOUT_5SEC,
-				     DEV_EVENT_TIMER, dev);
-			fsm_newstate(fi, DEV_STATE_STARTRETRY);
 			break;
 		case DEV_STATE_STOPWAIT:
 			fsm_newstate(fi, DEV_STATE_STOPPED);
@@ -1044,11 +1023,6 @@
 
 	{ DEV_STATE_STARTWAIT,  DEV_EVENT_STOP,    dev_action_stop     },
 	{ DEV_STATE_STARTWAIT,  DEV_EVENT_CONUP,   dev_action_connup   },
-	{ DEV_STATE_STARTWAIT,  DEV_EVENT_CONDOWN, dev_action_conndown },
-
-	{ DEV_STATE_STARTRETRY, DEV_EVENT_TIMER,   dev_action_start    },
-	{ DEV_STATE_STARTRETRY, DEV_EVENT_CONUP,   dev_action_connup   },
-	{ DEV_STATE_STARTRETRY, DEV_EVENT_STOP,    dev_action_stop     },
 
 	{ DEV_STATE_RUNNING,    DEV_EVENT_STOP,    dev_action_stop     },
 	{ DEV_STATE_RUNNING,    DEV_EVENT_CONDOWN, dev_action_conndown },
@@ -1119,10 +1093,7 @@
 		header.next = 0;
 		memcpy(skb_put(nskb, NETIUCV_HDRLEN), &header,  NETIUCV_HDRLEN);
 
-		conn->retry = 0;
 		fsm_newstate(conn->fsm, CONN_STATE_TX);
-		fsm_addtimer(&conn->timer, NETIUCV_TIMEOUT_5SEC,
-			     CONN_EVENT_TIMER, conn);
 		conn->prof.send_stamp = xtime;
 		
 		rc = iucv_send(conn->pathid, NULL, 0, 0, 1 /* single_flag */,
@@ -1135,7 +1106,6 @@
 			conn->prof.tx_max_pending = conn->prof.tx_pending;
 		if (rc != 0) {
 			struct netiucv_priv *privptr;
-			fsm_deltimer(&conn->timer);
 			fsm_newstate(conn->fsm, CONN_STATE_IDLE);
 			conn->prof.tx_pending--;
 			privptr = (struct netiucv_priv *)conn->netdev->priv;
@@ -1178,7 +1148,6 @@
  */
 static int
 netiucv_open(struct net_device *dev) {
-	SET_DEVICE_START(dev, 1);
 	fsm_event(((struct netiucv_priv *)dev->priv)->fsm, DEV_EVENT_START, dev);
 	return 0;
 }
@@ -1193,7 +1162,6 @@
  */
 static int
 netiucv_close(struct net_device *dev) {
-	SET_DEVICE_START(dev, 0);
 	fsm_event(((struct netiucv_priv *)dev->priv)->fsm, DEV_EVENT_STOP, dev);
 	return 0;
 }
@@ -1912,7 +1880,7 @@
 static void
 netiucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.47 $";
+	char vbuf[] = "$Revision: 1.48 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
