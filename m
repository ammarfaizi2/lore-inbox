Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbULMQEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbULMQEf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 11:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbULMQEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 11:04:30 -0500
Received: from port-83-236-152-146.static.qsc.de ([83.236.152.146]:35200 "EHLO
	heck.convergence.de") by vger.kernel.org with ESMTP id S261269AbULMQDN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 11:03:13 -0500
Date: Mon, 13 Dec 2004 17:03:09 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Michael Hunold <hunold@linuxtv.org>
Subject: [PATCH] fix dvb-net Oops
Message-ID: <20041213160309.GA12700@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Michael Hunold <hunold@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

emard<at>softhome!net discovered an embarrasing bug in
dvb_net.c where the NET_REMOVE_IF ioctl will cause an
Oops when called with an invalid interface number.

The patch applies on top of the other dvb patches in linux-2.6.10-rc3-mm1
and should go into 2.6.10.

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

Johannes


--- linux-2.6.10-rc3-mm1/drivers/media/dvb/dvb-core/dvb_net.c.orig	2004-12-13 15:12:51.000000000 +0100
+++ linux-2.6.10-rc3-mm1/drivers/media/dvb/dvb-core/dvb_net.c	2004-12-13 15:34:28.000000000 +0100
@@ -1201,13 +1201,14 @@ static int dvb_net_add_if(struct dvb_net
 }
 
 
-static int dvb_net_remove_if(struct dvb_net *dvbnet, int num)
+static int dvb_net_remove_if(struct dvb_net *dvbnet, unsigned int num)
 {
 	struct net_device *net = dvbnet->device[num];
-	struct dvb_net_priv *priv = net->priv;
+	struct dvb_net_priv *priv;
 
 	if (!dvbnet->state[num])
 		return -EINVAL;
+	priv = net->priv;
 	if (priv->in_use)
 		return -EBUSY;
 
@@ -1268,10 +1269,18 @@ static int dvb_net_do_ioctl(struct inode
 		break;
 	}
 	case NET_REMOVE_IF:
+	{
+		int ret;
+
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		module_put(dvbdev->adapter->module);
-		return dvb_net_remove_if(dvbnet, (int) (long) parg);
+		if ((unsigned int) parg >= DVB_NET_DEVICES_MAX)
+			return -EINVAL;
+		ret = dvb_net_remove_if(dvbnet, (unsigned int) parg);
+		if (!ret)
+			module_put(dvbdev->adapter->module);
+		return ret;
+	}
 
 	/* binary compatiblity cruft */
 	case __NET_ADD_IF_OLD:
