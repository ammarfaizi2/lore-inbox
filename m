Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269575AbTG1NMq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 09:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269583AbTG1NMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 09:12:46 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:31210 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S269575AbTG1NMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 09:12:41 -0400
Date: Mon, 28 Jul 2003 15:27:39 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: Linux v2.6.0-test2
Message-ID: <20030728132738.GH25402@fs.tum.de>
References: <Pine.LNX.4.44.0307271003360.3401-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307271003360.3401-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 27, 2003 at 10:08:40AM -0700, Linus Torvalds wrote:
>...
> Summary of changes from v2.6.0-test1 to v2.6.0-test2
> ============================================
>...
> Krzysztof Halasa:
>   o HDLC update
>...


This patch caused the following compile error:

<--  snip  -->

...
  CC      drivers/net/wan/pc300_drv.o
drivers/net/wan/pc300_drv.c: In function `cpc_ioctl':
drivers/net/wan/pc300_drv.c:2557: error: incompatible types in 
assignment
drivers/net/wan/pc300_drv.c:2593: error: incompatible types in 
assignment
drivers/net/wan/pc300_drv.c: In function `cpc_open':
drivers/net/wan/pc300_drv.c:3156: error: invalid operands to binary ==
drivers/net/wan/pc300_drv.c:3161: error: invalid operands to binary ==
drivers/net/wan/pc300_drv.c: In function `cpc_close':
drivers/net/wan/pc300_drv.c:3194: error: invalid operands to binary ==
make[3]: *** [drivers/net/wan/pc300_drv.o] Error 1

<--  snip  -->


Please check whether the fix below is correct.

TIA
Adrian


--- linux-2.6.0-test2-full-no-smp/drivers/net/wan/pc300_drv.c.tmp	2003-07-28 15:13:06.000000000 +0200
+++ linux-2.6.0-test2-full-no-smp/drivers/net/wan/pc300_drv.c	2003-07-28 15:19:35.000000000 +0200
@@ -2554,10 +2554,10 @@
 		case SIOCGPC300CONF:
 #ifdef CONFIG_PC300_MLPPP
 			if (conf->proto != PC300_PROTO_MLPPP) {
-				conf->proto = hdlc->proto;
+				conf->proto = hdlc->proto.id;
 			}
 #else
-			conf->proto = hdlc->proto;
+			conf->proto = hdlc->proto.id;
 #endif
 			memcpy(&conf_aux.conf, conf, sizeof(pc300chconf_t));
 			memcpy(&conf_aux.hw, &card->hw, sizeof(pc300hw_t));
@@ -2590,12 +2590,12 @@
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
@@ -3153,12 +3153,12 @@
 	printk("pc300: cpc_open");
 #endif
 
-	if (hdlc->proto == IF_PROTO_PPP) {
+	if (hdlc->proto.id == IF_PROTO_PPP) {
 		d->if_ptr = &hdlc->state.ppp.pppdev;
 	}
 
 	result = hdlc_open(hdlc);
-	if (hdlc->proto == IF_PROTO_PPP) {
+	if (hdlc->proto.id == IF_PROTO_PPP) {
 		dev->priv = d;
 	}
 	if (result) {
@@ -3191,7 +3191,7 @@
 	CPC_UNLOCK(card, flags);
 
 	hdlc_close(hdlc);
-	if (hdlc->proto == IF_PROTO_PPP) {
+	if (hdlc->proto.id == IF_PROTO_PPP) {
 		d->if_ptr = NULL;
 	}
 #ifdef CONFIG_PC300_MLPPP

