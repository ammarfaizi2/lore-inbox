Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbTJNJp7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 05:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbTJNJp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 05:45:59 -0400
Received: from mail.convergence.de ([212.84.236.4]:4539 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261889AbTJNJpw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 05:45:52 -0400
Subject: [PATCH 1/1] Fix dvb_net network subsystem usage
In-Reply-To: 
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 14 Oct 2003 11:45:45 +0200
Message-Id: <10661247452841@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

this patch restores the changes to the dvb_net code done by <shemminger@osdl.org>, which were
wiped out by my last patchset. 

I already subscribed to the bk-commits-head mailing list and some user gave my hints on how
to prevent this in the future. 

Please apply.

CU
Michael.


diff -ura linux-2.6.0-test7-bk5/drivers/media/dvb/dvb-core/dvb_net.c linux-2.6.0-test7-net/drivers/media/dvb/dvb-core/dvb_net.c
--- linux-2.6.0-test7-bk5/drivers/media/dvb/dvb-core/dvb_net.c	2003-10-14 10:53:32.000000000 +0200
+++ linux-2.6.0-test7-net/drivers/media/dvb/dvb-core/dvb_net.c	2003-10-14 10:54:01.000000000 +0200
@@ -456,7 +456,7 @@
 }
 
 
-static int dvb_net_init_dev (struct net_device *dev)
+static void dvb_net_setup(struct net_device *dev)
 {
 	ether_setup(dev);
 
@@ -472,11 +472,8 @@
 	dev->hard_header_cache  = NULL;
 
 	dev->flags |= IFF_NOARP;
-
-	return 0;
 }
 
-
 static int get_if(struct dvb_net *dvbnet)
 {
 	int i;
@@ -496,7 +493,6 @@
 static int dvb_net_add_if(struct dvb_net *dvbnet, u16 pid)
 {
         struct net_device *net;
-	struct dmx_demux *demux;
 	struct dvb_net_priv *priv;
 	int result;
 	int if_num;
@@ -504,25 +500,20 @@
 	if ((if_num = get_if(dvbnet)) < 0)
 		return -EINVAL;
 
-	net = &dvbnet->device[if_num];
-	demux = dvbnet->demux;
+	net = alloc_netdev(sizeof(struct dvb_net_priv), "dvb",
+			   dvb_net_setup);
+	if (!net)
+		return -ENOMEM;
 	
-	memset(net, 0, sizeof(struct net_device));
+	sprintf(net->name, "dvb%d_%d", dvbnet->dvbdev->adapter->num, if_num);
 
-	memcpy(net->name, "dvb0_0", 7);
-	net->name[3]   = dvbnet->dvbdev->adapter->num + '0';
-	net->name[5]   = if_num + '0';
 	net->addr_len  		= 6;
 	memcpy(net->dev_addr, dvbnet->dvbdev->adapter->proposed_mac, 6);
-	net->next      = NULL;
-	net->init      = dvb_net_init_dev;
 
-	if (!(net->priv = kmalloc(sizeof(struct dvb_net_priv), GFP_KERNEL)))
-		return -ENOMEM;
+	dvbnet->device[if_num] = net;
 	
 	priv = net->priv;
-	memset(priv, 0, sizeof(struct dvb_net_priv));
-	priv->demux = demux;
+        priv->demux = dvbnet->demux;
         priv->pid = pid;
 	priv->rx_mode = RX_MODE_UNI;
 
@@ -532,6 +523,7 @@
         net->base_addr = pid;
                 
 	if ((result = register_netdev(net)) < 0) {
+		kfree(net);
 		return result;
 	}
 
@@ -541,18 +533,20 @@
 
 static int dvb_net_remove_if(struct dvb_net *dvbnet, int num)
 {
-	struct dvb_net_priv *priv = dvbnet->device[num].priv;
+	struct net_device *net = dvbnet->device[num];
+	struct dvb_net_priv *priv = net->priv;
 
 	if (!dvbnet->state[num])
 		return -EINVAL;
 	if (priv->in_use)
 		return -EBUSY;
 
-	dvb_net_stop(&dvbnet->device[num]);
+	dvb_net_stop(net);
 	flush_scheduled_work();
-	kfree(priv);
-	unregister_netdev(&dvbnet->device[num]);
+        unregister_netdev(net);
 	dvbnet->state[num]=0;
+	free_netdev(net);
+
 	return 0;
 }
 
diff -ura linux-2.6.0-test7-bk5/drivers/media/dvb/dvb-core/dvb_net.h linux-2.6.0-test7-net/drivers/media/dvb/dvb-core/dvb_net.h
--- linux-2.6.0-test7-bk5/drivers/media/dvb/dvb-core/dvb_net.h	2003-10-14 10:53:32.000000000 +0200
+++ linux-2.6.0-test7-net/drivers/media/dvb/dvb-core/dvb_net.h	2003-10-14 10:55:35.000000000 +0200
@@ -34,7 +34,7 @@
 
 struct dvb_net {
 	struct dvb_device *dvbdev;
-	struct net_device device[DVB_NET_DEVICES_MAX];
+	struct net_device *device[DVB_NET_DEVICES_MAX];
 	int state[DVB_NET_DEVICES_MAX];
 	struct dmx_demux *demux;
 };

