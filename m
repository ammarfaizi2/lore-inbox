Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbTJIKwm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 06:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTJIKvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 06:51:40 -0400
Received: from mail.convergence.de ([212.84.236.4]:42404 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261971AbTJIKr5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 06:47:57 -0400
Subject: [PATCH 4/7] Fix DVB network device handling
In-Reply-To: <10656964753860@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 9 Oct 2003 12:47:55 +0200
Message-Id: <10656964751857@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] simplify and sanitize add/del handling for dvb net devices
diff -uNrwB --new-file linux-2.6.0-test7/drivers/media/dvb/dvb-core/dvb_net.c linux-2.6.0-test7-patch/drivers/media/dvb/dvb-core/dvb_net.c
--- linux-2.6.0-test7/drivers/media/dvb/dvb-core/dvb_net.c	2003-10-09 10:40:19.000000000 +0200
+++ linux-2.6.0-test7-patch/drivers/media/dvb/dvb-core/dvb_net.c	2003-09-10 12:38:22.000000000 +0200
@@ -456,7 +463,7 @@
 }
 
 
-static void dvb_net_setup(struct net_device *dev)
+static int dvb_net_init_dev (struct net_device *dev)
 {
 	ether_setup(dev);
 
@@ -472,8 +479,11 @@
 	dev->hard_header_cache  = NULL;
 
 	dev->flags |= IFF_NOARP;
+
+	return 0;
 }
 
+
 static int get_if(struct dvb_net *dvbnet)
 {
 	int i;
@@ -493,6 +503,7 @@
 static int dvb_net_add_if(struct dvb_net *dvbnet, u16 pid)
 {
         struct net_device *net;
+	struct dmx_demux *demux;
 	struct dvb_net_priv *priv;
 	int result;
 	int if_num;
@@ -500,20 +511,25 @@
 	if ((if_num = get_if(dvbnet)) < 0)
 		return -EINVAL;
 
-	net = alloc_netdev(sizeof(struct dvb_net_priv), "dvb",
-			   dvb_net_setup);
-	if (!net)
-		return -ENOMEM;
+	net = &dvbnet->device[if_num];
+	demux = dvbnet->demux;
 	
-	sprintf(net->name, "dvb%d_%d", dvbnet->dvbdev->adapter->num, if_num);
+	memset(net, 0, sizeof(struct net_device));
 
+	memcpy(net->name, "dvb0_0", 7);
+	net->name[3]   = dvbnet->dvbdev->adapter->num + '0';
+	net->name[5]   = if_num + '0';
 	net->addr_len  		= 6;
 	memcpy(net->dev_addr, dvbnet->dvbdev->adapter->proposed_mac, 6);
+	net->next      = NULL;
+	net->init      = dvb_net_init_dev;
 
-	dvbnet->device[if_num] = net;
+	if (!(net->priv = kmalloc(sizeof(struct dvb_net_priv), GFP_KERNEL)))
+		return -ENOMEM;
 	
 	priv = net->priv;
-        priv->demux = dvbnet->demux;
+	memset(priv, 0, sizeof(struct dvb_net_priv));
+	priv->demux = demux;
         priv->pid = pid;
 	priv->rx_mode = RX_MODE_UNI;
 
@@ -523,7 +539,6 @@
         net->base_addr = pid;
                 
 	if ((result = register_netdev(net)) < 0) {
-		kfree(net);
 		return result;
 	}
 
@@ -533,20 +548,18 @@
 
 static int dvb_net_remove_if(struct dvb_net *dvbnet, int num)
 {
-	struct net_device *net = dvbnet->device[num];
-	struct dvb_net_priv *priv = net->priv;
+	struct dvb_net_priv *priv = dvbnet->device[num].priv;
 
 	if (!dvbnet->state[num])
 		return -EINVAL;
 	if (priv->in_use)
 		return -EBUSY;
 
-	dvb_net_stop(net);
+	dvb_net_stop(&dvbnet->device[num]);
 	flush_scheduled_work();
-        unregister_netdev(net);
+	kfree(priv);
+	unregister_netdev(&dvbnet->device[num]);
 	dvbnet->state[num]=0;
-	free_netdev(net);
-
 	return 0;
 }
 
diff -uNrwB --new-file linux-2.6.0-test7/drivers/media/dvb/dvb-core/dvb_net.h linux-2.6.0-test7-patch/drivers/media/dvb/dvb-core/dvb_net.h
--- linux-2.6.0-test7/drivers/media/dvb/dvb-core/dvb_net.h	2003-10-09 10:40:19.000000000 +0200
+++ linux-2.6.0-test7-patch/drivers/media/dvb/dvb-core/dvb_net.h	2003-08-25 12:16:12.000000000 +0200
@@ -34,7 +34,7 @@
 
 struct dvb_net {
 	struct dvb_device *dvbdev;
-	struct net_device *device[DVB_NET_DEVICES_MAX];
+	struct net_device device[DVB_NET_DEVICES_MAX];
 	int state[DVB_NET_DEVICES_MAX];
 	struct dmx_demux *demux;
 };

