Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261709AbTCZPH3>; Wed, 26 Mar 2003 10:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261711AbTCZPH3>; Wed, 26 Mar 2003 10:07:29 -0500
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:17903 "EHLO
	d12lmsgate-5.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261709AbTCZPHS> convert rfc822-to-8bit; Wed, 26 Mar 2003 10:07:18 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 update (5/9): s390 network driver fixes.
Date: Wed, 26 Mar 2003 16:11:05 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200303261611.05291.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* lcs: Don't free net_device in lcs_stop_device.
* lcs: Reset card after LGW initiaited stoplan.
* lcs: Fix bug in lcs_tasklet
* ctc: Get channel structure from private pointer. Remove __NO_VERSION__.
* lcs,ctc,iucv: Remove MOD_INC_USE_COUNT/MOD_DEC_USE_COUNT. Set dev->owner.

diffstat:
 ctcmain.c |   36 +++++++++++++++---------------------
 ctctty.c  |    3 +--
 lcs.c     |   26 +++++++++++++-------------
 netiucv.c |   15 ++++++++-------
 4 files changed, 37 insertions(+), 43 deletions(-)

diff -urN linux-2.5.66/drivers/s390/net/ctcmain.c linux-2.5.66-s390/drivers/s390/net/ctcmain.c
--- linux-2.5.66/drivers/s390/net/ctcmain.c	Wed Mar 26 15:45:05 2003
+++ linux-2.5.66-s390/drivers/s390/net/ctcmain.c	Wed Mar 26 15:45:16 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: ctcmain.c,v 1.36 2003/02/18 09:15:14 mschwide Exp $
+ * $Id: ctcmain.c,v 1.38 2003/03/25 14:54:59 cohuck Exp $
  *
  * CTC / ESCON network driver
  *
@@ -36,7 +36,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.36 $
+ * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.38 $
  *
  */
 
@@ -273,7 +273,7 @@
 print_banner(void)
 {
 	static int printed = 0;
-	char vbuf[] = "$Revision: 1.36 $";
+	char vbuf[] = "$Revision: 1.38 $";
 	char *version = vbuf;
 
 	if (printed)
@@ -1962,22 +1962,17 @@
 	}
 	
 	priv = cdev->dev.driver_data;
-	ch = (struct channel *) intparm;
-	if ((ch != priv->channel[READ]) && (ch != priv->channel[WRITE]))
-		ch = NULL;
-	
-	if (!ch) {
-		/* Try to extract channel from driver data. */
-		if (priv->channel[READ]->cdev == cdev)
-			ch = priv->channel[READ];
-		else if (priv->channel[WRITE]->cdev == cdev)
-			ch = priv->channel[READ];
-		else {
-			printk(KERN_ERR
-			       "ctc: Can't determine channel for interrupt, "
-			       "device %s\n", cdev->dev.bus_id);
-			return;
-		}
+
+	/* Try to extract channel from driver data. */
+	if (priv->channel[READ]->cdev == cdev)
+		ch = priv->channel[READ];
+	else if (priv->channel[WRITE]->cdev == cdev)
+		ch = priv->channel[READ];
+	else {
+		printk(KERN_ERR
+		       "ctc: Can't determine channel for interrupt, "
+		       "device %s\n", cdev->dev.bus_id);
+		return;
 	}
 	
 	dev = (struct net_device *) (ch->netdev);
@@ -2392,7 +2387,6 @@
 static int
 ctc_open(struct net_device * dev)
 {
-	MOD_INC_USE_COUNT;
 	fsm_event(((struct ctc_priv *) dev->priv)->fsm, DEV_EVENT_START, dev);
 	return 0;
 }
@@ -2409,7 +2403,6 @@
 ctc_close(struct net_device * dev)
 {
 	fsm_event(((struct ctc_priv *) dev->priv)->fsm, DEV_EVENT_STOP, dev);
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
@@ -2761,6 +2754,7 @@
 	dev->addr_len = 0;
 	dev->type = ARPHRD_SLIP;
 	dev->tx_queue_len = 100;
+	dev->owner = THIS_MODULE;
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
 	return dev;
 }
diff -urN linux-2.5.66/drivers/s390/net/ctctty.c linux-2.5.66-s390/drivers/s390/net/ctctty.c
--- linux-2.5.66/drivers/s390/net/ctctty.c	Mon Mar 24 23:00:45 2003
+++ linux-2.5.66-s390/drivers/s390/net/ctctty.c	Wed Mar 26 15:45:17 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: ctctty.c,v 1.9 2002/12/02 15:25:13 aberg Exp $
+ * $Id: ctctty.c,v 1.10 2003/03/21 18:47:31 aberg Exp $
  *
  * CTC / ESCON network driver, tty interface.
  *
@@ -22,7 +22,6 @@
  *
  */
 
-#define __NO_VERSION__
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/tty.h>
diff -urN linux-2.5.66/drivers/s390/net/lcs.c linux-2.5.66-s390/drivers/s390/net/lcs.c
--- linux-2.5.66/drivers/s390/net/lcs.c	Mon Mar 24 23:00:01 2003
+++ linux-2.5.66-s390/drivers/s390/net/lcs.c	Wed Mar 26 15:45:17 2003
@@ -11,7 +11,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Martin Schwidefsky <schwidefsky@de.ibm.com>
  *
- *    $Revision: 1.44 $	 $Date: 2003/02/18 19:49:02 $
+ *    $Revision: 1.49 $	 $Date: 2003/03/25 14:54:59 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -59,7 +59,7 @@
 /**
  * initialization string for output
  */
-#define VERSION_LCS_C  "$Revision: 1.44 $"
+#define VERSION_LCS_C  "$Revision: 1.49 $"
 
 static char version[] __initdata = "LCS driver ("VERSION_LCS_C "/" VERSION_LCS_H ")";
 
@@ -358,6 +358,7 @@
 		kfree(ipm_list);
 	}
 #endif
+	kfree(card->dev);
 	/* Cleanup channels. */
 	lcs_cleanup_channel(&card->write);
 	lcs_cleanup_channel(&card->read);
@@ -556,13 +557,12 @@
 static int
 __lcs_processed_buffer(struct lcs_channel *channel, struct lcs_buffer *buffer)
 {
-	int index, prevprev, prev, next;
+	int index, prev, next;
 
 	if (buffer->state != BUF_STATE_READY)
 		BUG();
 	buffer->state = BUF_STATE_PROCESSED;
 	index = buffer - channel->iob;
-	prevprev = (index - 1) & (LCS_NUM_BUFFS - 1);
 	prev = (index - 1) & (LCS_NUM_BUFFS - 1);
 	next = (index + 1) & (LCS_NUM_BUFFS - 1);
 	/* Set the suspend bit and clear the PCI bit of this buffer. */
@@ -1082,7 +1082,7 @@
 	unsigned long flags;
 	struct lcs_channel *channel;
 	struct lcs_buffer *iob;
-	int buf_idx, io_idx;
+	int buf_idx;
 	int rc;
 
 	channel = (struct lcs_channel *) data;
@@ -1092,9 +1092,7 @@
 	/* Check for processed buffers. */
 	iob = channel->iob;
 	buf_idx = channel->buf_idx;
-	io_idx = channel->io_idx;
-	while (buf_idx != io_idx &&
-	       iob[buf_idx].state == BUF_STATE_PROCESSED) {
+	while (iob[buf_idx].state == BUF_STATE_PROCESSED) {
 		/* Do the callback thing. */
 		if (iob[buf_idx].callback != NULL)
 			iob[buf_idx].callback(channel, iob + buf_idx);
@@ -1434,6 +1432,7 @@
 lcs_lgw_stoplan_thread(void *data)
 {
 	struct lcs_card *card;
+	int rc;
 
 	card = (struct lcs_card *) data;
 	daemonize("lgwstop");
@@ -1446,7 +1445,11 @@
 	else
 		PRINT_ERR("Stoplan %s initiated by LGW failed!\n",
 			  card->dev->name);
-	return 0;
+	/*Try to reset the card, stop it on failure */
+        rc = lcs_resetcard(card);
+        if (rc != 0)
+                rc = lcs_stopcard(card);
+        return rc;
 }
 
 /**
@@ -1599,12 +1602,9 @@
 	LCS_DBF_TEXT(2, trace, "stopdev");
 	card   = (struct lcs_card *) dev->priv;
 	netif_stop_queue(dev);
-	// FIXME: really free the net_device here ?!?
-	kfree(card->dev);
 	rc = lcs_stopcard(card);
 	if (rc)
 		PRINT_ERR("Try it again!\n ");
-	MOD_DEC_USE_COUNT;
 	return rc;
 }
 
@@ -1626,7 +1626,6 @@
 		PRINT_ERR("LCS:Error in opening device!\n");
 
 	} else {
-		MOD_INC_USE_COUNT;
 		netif_wake_queue(dev);
 		card->state = DEV_STATE_UP;
 	}
@@ -1784,6 +1783,7 @@
 		dev->set_multicast_list = lcs_set_multicast_list;
 #endif
 	dev->get_stats = lcs_getstats;
+	dev->owner = THIS_MODULE;
 	netif_stop_queue(dev);
 	lcs_stopcard(card);
 	return 0;
diff -urN linux-2.5.66/drivers/s390/net/netiucv.c linux-2.5.66-s390/drivers/s390/net/netiucv.c
--- linux-2.5.66/drivers/s390/net/netiucv.c	Wed Mar 26 15:45:05 2003
+++ linux-2.5.66-s390/drivers/s390/net/netiucv.c	Wed Mar 26 15:45:17 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: netiucv.c,v 1.16 2003/02/18 09:15:14 mschwide Exp $
+ * $Id: netiucv.c,v 1.18 2003/03/25 14:54:59 cohuck Exp $
  *
  * IUCV network driver
  *
@@ -30,7 +30,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV network driver $Revision: 1.16 $
+ * RELEASE-TAG: IUCV network driver $Revision: 1.18 $
  *
  */
 
@@ -1140,7 +1140,6 @@
  */
 static int
 netiucv_open(struct net_device *dev) {
-	MOD_INC_USE_COUNT;
 	SET_DEVICE_START(dev, 1);
 	fsm_event(((struct netiucv_priv *)dev->priv)->fsm, DEV_EVENT_START, dev);
 	return 0;
@@ -1158,7 +1157,6 @@
 netiucv_close(struct net_device *dev) {
 	SET_DEVICE_START(dev, 0);
 	fsm_event(((struct netiucv_priv *)dev->priv)->fsm, DEV_EVENT_STOP, dev);
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
@@ -1517,12 +1515,14 @@
 		conn->max_buffsize = NETIUCV_BUFSIZE_DEFAULT;
 		conn->netdev = dev;
 
-		conn->rx_buff = alloc_skb(NETIUCV_BUFSIZE_DEFAULT, GFP_DMA);
+		conn->rx_buff = alloc_skb(NETIUCV_BUFSIZE_DEFAULT,
+					  GFP_KERNEL | GFP_DMA);
 		if (!conn->rx_buff) {
 			kfree(conn);
 			return NULL;
 		}
-		conn->tx_buff = alloc_skb(NETIUCV_BUFSIZE_DEFAULT, GFP_DMA);
+		conn->tx_buff = alloc_skb(NETIUCV_BUFSIZE_DEFAULT,
+					  GFP_KERNEL | GFP_DMA);
 		if (!conn->tx_buff) {
 			kfree_skb(conn->rx_buff);
 			kfree(conn);
@@ -1630,6 +1630,7 @@
 	dev->addr_len            = 0;
 	dev->type                = ARPHRD_SLIP;
 	dev->tx_queue_len        = NETIUCV_QUEUELEN_DEFAULT;
+	dev->owner               = THIS_MODULE;
 	dev->flags	         = IFF_POINTOPOINT | IFF_NOARP;
 	return dev;
 }
@@ -1716,7 +1717,7 @@
 static void
 netiucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.16 $";
+	char vbuf[] = "$Revision: 1.18 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {

