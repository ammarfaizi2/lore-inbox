Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270452AbTG1T0Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 15:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270453AbTG1T0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 15:26:25 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:39178 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S270452AbTG1T0U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 15:26:20 -0400
Date: Mon, 28 Jul 2003 21:22:32 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: linux-kernel@vger.kernel.org
Cc: henrique@cyclades.com, torvalds@osdl.org, khc@pm.waw.pl
Subject: [PATCH] 2.6.0-test2 - HDLC hook update for drivers/net/wan/pc300_drv.c
Message-ID: <20030728212232.C8054@electric-eye.fr.zoreil.com>
References: <20030728210427.B8054@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030728210427.B8054@electric-eye.fr.zoreil.com>; from romieu@fr.zoreil.com on Mon, Jul 28, 2003 at 09:04:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Layout of struct hdlc_device has changed.


 drivers/net/wan/pc300_drv.c |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)

diff -puN drivers/net/wan/pc300_drv.c~drivers-hooks-changed-pc300 drivers/net/wan/pc300_drv.c
--- linux-2.6.0-test2/drivers/net/wan/pc300_drv.c~drivers-hooks-changed-pc300	Mon Jul 28 21:05:52 2003
+++ linux-2.6.0-test2-fr/drivers/net/wan/pc300_drv.c	Mon Jul 28 21:10:11 2003
@@ -2553,11 +2553,10 @@ int cpc_ioctl(struct net_device *dev, st
 	switch (cmd) {
 		case SIOCGPC300CONF:
 #ifdef CONFIG_PC300_MLPPP
-			if (conf->proto != PC300_PROTO_MLPPP) {
-				conf->proto = hdlc->proto;
-			}
+			if (conf->proto != PC300_PROTO_MLPPP)
+				conf->proto = hdlc->proto.id;
 #else
-			conf->proto = hdlc->proto;
+			conf->proto = hdlc->proto.id;
 #endif
 			memcpy(&conf_aux.conf, conf, sizeof(pc300chconf_t));
 			memcpy(&conf_aux.hw, &card->hw, sizeof(pc300hw_t));
@@ -2590,12 +2589,12 @@ int cpc_ioctl(struct net_device *dev, st
 					}
 				} else {
 					memcpy(conf, &conf_aux.conf, sizeof(pc300chconf_t));
-					hdlc->proto = conf->proto;
+					hdlc->proto.id = conf->proto;
 				}
 			}
 #else
 			memcpy(conf, &conf_aux.conf, sizeof(pc300chconf_t));
-			hdlc->proto = conf->proto;
+			hdlc->proto.id = conf->proto;
 #endif
 			return 0;
 		case SIOCGPC300STATUS:
@@ -3153,14 +3152,13 @@ int cpc_open(struct net_device *dev)
 	printk("pc300: cpc_open");
 #endif
 
-	if (hdlc->proto == IF_PROTO_PPP) {
+	if (hdlc->proto.id == IF_PROTO_PPP)
 		d->if_ptr = &hdlc->state.ppp.pppdev;
-	}
 
 	result = hdlc_open(hdlc);
-	if (hdlc->proto == IF_PROTO_PPP) {
+	if (hdlc->proto.id == IF_PROTO_PPP)
 		dev->priv = d;
-	}
+
 	if (result) {
 		return result;
 	}
@@ -3191,9 +3189,9 @@ int cpc_close(struct net_device *dev)
 	CPC_UNLOCK(card, flags);
 
 	hdlc_close(hdlc);
-	if (hdlc->proto == IF_PROTO_PPP) {
+	if (hdlc->proto.id == IF_PROTO_PPP)
 		d->if_ptr = NULL;
-	}
+
 #ifdef CONFIG_PC300_MLPPP
 	if (chan->conf.proto == PC300_PROTO_MLPPP) {
 		cpc_tty_unregister_service(d);

_
