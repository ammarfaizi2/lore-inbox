Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267678AbTGOMZw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 08:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267647AbTGOMYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 08:24:22 -0400
Received: from mail.convergence.de ([212.84.236.4]:38304 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S267548AbTGOMGL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 08:06:11 -0400
Subject: [PATCH 13/17] More updates for the dvb core
In-Reply-To: <10582716571753@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 15 Jul 2003 14:20:58 +0200
Message-Id: <10582716581043@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) 
	<hunold@convergence.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/dvb/dvb-core/dvb_demux.c linux-2.6.0-test1.patch/drivers/media/dvb/dvb-core/dvb_demux.c
--- linux-2.6.0-test1.work/drivers/media/dvb/dvb-core/dvb_demux.c	2003-07-15 10:59:30.000000000 +0200
+++ linux-2.6.0-test1.patch/drivers/media/dvb/dvb-core/dvb_demux.c	2003-07-04 11:46:12.000000000 +0200
@@ -403,13 +404,16 @@
 {
 	int p = 0,i, j;
 	
+	spin_lock(&demux->lock);
+
 	if ((i = demux->tsbufp)) {
 		if (count < (j=188-i)) {
 			memcpy(&demux->tsbuf[i], buf, count);
 			demux->tsbufp += count;
-			return;
+			goto bailout;
 		}
 		memcpy(&demux->tsbuf[i], buf, j);
+		if (demux->tsbuf[0] == 0x47)
 		dvb_dmx_swfilter_packet(demux, demux->tsbuf);
 		demux->tsbufp = 0;
 		p += j;
@@ -424,11 +428,14 @@
 				i = count-p;
 				memcpy(demux->tsbuf, buf+p, i);
 				demux->tsbufp=i;
-				return;
+				goto bailout;
 			}
 		} else 
 			p++;
 	}
+
+bailout:
+	spin_unlock(&demux->lock);
 }
 
 
@@ -1030,9 +1051,11 @@
 
 	if (down_interruptible (&dvbdemux->mutex))
 		return -ERESTARTSYS;
-
 	dvb_dmx_swfilter(dvbdemux, buf, count);
 	up(&dvbdemux->mutex);
+
+	if (signal_pending(current))
+		return -EINTR;
 	return count;
 }
 
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/dvb/dvb-core/dvb_net.c linux-2.6.0-test1.patch/drivers/media/dvb/dvb-core/dvb_net.c
--- linux-2.6.0-test1.work/drivers/media/dvb/dvb-core/dvb_net.c	2003-07-15 10:59:32.000000000 +0200
+++ linux-2.6.0-test1.patch/drivers/media/dvb/dvb-core/dvb_net.c	2003-06-29 10:21:16.000000000 +0200
@@ -57,7 +57,8 @@
 #define RX_MODE_MULTI 1
 #define RX_MODE_ALL_MULTI 2
 #define RX_MODE_PROMISC 3
-	struct work_struct wq;
+	struct work_struct set_multicast_list_wq;
+	struct work_struct restart_net_feed_wq;
 };
 
 
@@ -354,7 +361,7 @@
 }
 
 
-static void tq_set_multicast_list (void *data)
+static void wq_set_multicast_list (void *data)
 {
 	struct net_device *dev = data;
 	struct dvb_net_priv *priv = (struct dvb_net_priv*) dev->priv;
@@ -393,7 +400,7 @@
 static void dvb_net_set_multicast_list (struct net_device *dev)
 {
 	struct dvb_net_priv *priv = (struct dvb_net_priv*) dev->priv;
-	schedule_work(&priv->wq);
+	schedule_work(&priv->set_multicast_list_wq);
 }
 
 
@@ -404,16 +411,28 @@
 	return 0;
 }
 
-static int dvb_net_set_mac(struct net_device *dev, void *p)
-{
-	struct sockaddr *addr=p;
 
-	memcpy(dev->dev_addr, addr->sa_data, dev->addr_len);
+static void wq_restart_net_feed (void *data)
+{
+	struct net_device *dev = data;
 
 	if (netif_running(dev)) {
 		dvb_net_feed_stop(dev);
 		dvb_net_feed_start(dev);
 	}
+}
+
+
+static int dvb_net_set_mac (struct net_device *dev, void *p)
+{
+	struct dvb_net_priv *priv = (struct dvb_net_priv*) dev->priv;
+	struct sockaddr *addr=p;
+
+	memcpy(dev->dev_addr, addr->sa_data, dev->addr_len);
+
+	if (netif_running(dev))
+		schedule_work(&priv->restart_net_feed_wq);
+
 	return 0;
 }
 
@@ -493,10 +514,8 @@
 	net=&dvbnet->device[if_num];
 	demux=dvbnet->demux;
 	
-	net->base_addr = 0;
-	net->irq       = 0;
-	net->dma       = 0;
-	net->mem_start = 0;
+	memset(net, 0, sizeof(struct net_device));
+
         memcpy(net->name, "dvb0_0", 7);
 	net->name[3]   = dvbnet->dvbdev->adapter->num + '0';
 	net->name[5]   = if_num + '0';
@@ -514,7 +533,8 @@
         priv->pid = pid;
 	priv->rx_mode = RX_MODE_UNI;
 
-	INIT_WORK(&priv->wq, tq_set_multicast_list, net);
+	INIT_WORK(&priv->set_multicast_list_wq, wq_set_multicast_list, net);
+	INIT_WORK(&priv->restart_net_feed_wq, wq_restart_net_feed, net);
 
         net->base_addr = pid;
                 
@@ -536,6 +556,7 @@
 		return -EBUSY;
 
 	dvb_net_stop(&dvbnet->device[num]);
+	flush_scheduled_work();
 	kfree(priv);
         unregister_netdev(&dvbnet->device[num]);
 	dvbnet->state[num]=0;

