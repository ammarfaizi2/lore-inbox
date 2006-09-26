Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWIZVYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWIZVYV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 17:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWIZVYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 17:24:20 -0400
Received: from khc.piap.pl ([195.187.100.11]:41698 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S964807AbWIZVYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 17:24:18 -0400
To: Jeff Garzik <jeff@garzik.org>
Cc: netdev@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
       PC300 Maintainer <pc300@cyclades.com>
Subject: [PATCH 2/2] Make PC300 WAN driver compile again
References: <m3odt21hs5.fsf@defiant.localdomain>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 26 Sep 2006 23:24:16 +0200
In-Reply-To: <m3odt21hs5.fsf@defiant.localdomain> (Krzysztof Halasa's message of "Tue, 26 Sep 2006 22:42:34 +0200")
Message-ID: <m3ejty1fun.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes accesses to the HDLC-internal data structures
from pc300 driver, thus enabling it to compile but breaking part
of its functionality.

Signed-off-by: Krzysztof Halasa <khc@pm.waw.pl>

diff --git a/drivers/net/wan/pc300_drv.c b/drivers/net/wan/pc300_drv.c
index 56e6940..8d9b959 100644
--- a/drivers/net/wan/pc300_drv.c
+++ b/drivers/net/wan/pc300_drv.c
@@ -2016,7 +2016,6 @@ static void sca_intr(pc300_t * card)
 			pc300ch_t *chan = &card->chan[ch];
 			pc300dev_t *d = &chan->d;
 			struct net_device *dev = d->dev;
-			hdlc_device *hdlc = dev_to_hdlc(dev);
 
 			spin_lock(&card->card_lock);
 
@@ -2049,8 +2048,8 @@ #endif
 							}
 							cpc_net_rx(dev);
 							/* Discard invalid frames */
-							hdlc->stats.rx_errors++;
-							hdlc->stats.rx_over_errors++;
+							hdlc_stats(dev)->rx_errors++;
+							hdlc_stats(dev)->rx_over_errors++;
 							chan->rx_first_bd = 0;
 							chan->rx_last_bd = N_DMA_RX_BUF - 1;
 							rx_dma_start(card, ch);
@@ -2116,8 +2115,8 @@ #endif
 										   card->hw.cpld_reg2) &
 								   ~ (CPLD_REG2_FALC_LED1 << (2 * ch)));
 						}
-						hdlc->stats.tx_errors++;
-						hdlc->stats.tx_fifo_errors++;
+						hdlc_stats(dev)->tx_errors++;
+						hdlc_stats(dev)->tx_fifo_errors++;
 						sca_tx_intr(d);
 					}
 				}
@@ -2534,7 +2533,6 @@ static int cpc_change_mtu(struct net_dev
 
 static int cpc_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
-	hdlc_device *hdlc = dev_to_hdlc(dev);
 	pc300dev_t *d = (pc300dev_t *) dev->priv;
 	pc300ch_t *chan = (pc300ch_t *) d->chan;
 	pc300_t *card = (pc300_t *) chan->card;
@@ -2552,10 +2550,10 @@ static int cpc_ioctl(struct net_device *
 		case SIOCGPC300CONF:
 #ifdef CONFIG_PC300_MLPPP
 			if (conf->proto != PC300_PROTO_MLPPP) {
-				conf->proto = hdlc->proto.id;
+				conf->proto = /* FIXME hdlc->proto.id */ 0;
 			}
 #else
-			conf->proto = hdlc->proto.id;
+			conf->proto = /* FIXME hdlc->proto.id */ 0;
 #endif
 			memcpy(&conf_aux.conf, conf, sizeof(pc300chconf_t));
 			memcpy(&conf_aux.hw, &card->hw, sizeof(pc300hw_t));
@@ -2588,12 +2586,12 @@ #ifdef CONFIG_PC300_MLPPP
 					}
 				} else {
 					memcpy(conf, &conf_aux.conf, sizeof(pc300chconf_t));
-					hdlc->proto.id = conf->proto;
+					/* FIXME hdlc->proto.id = conf->proto; */
 				}
 			}
 #else
 			memcpy(conf, &conf_aux.conf, sizeof(pc300chconf_t));
-			hdlc->proto.id = conf->proto;
+			/* FIXME hdlc->proto.id = conf->proto; */
 #endif
 			return 0;
 		case SIOCGPC300STATUS:
@@ -2606,7 +2604,7 @@ #endif
 		case SIOCGPC300UTILSTATS:
 			{
 				if (!arg) {	/* clear statistics */
-					memset(&hdlc->stats, 0, sizeof(struct net_device_stats));
+					memset(hdlc_stats(dev), 0, sizeof(struct net_device_stats));
 					if (card->hw.type == PC300_TE) {
 						memset(&chan->falc, 0, sizeof(falc_t));
 					}
@@ -2617,7 +2615,7 @@ #endif
 					pc300stats.hw_type = card->hw.type;
 					pc300stats.line_on = card->chan[ch].d.line_on;
 					pc300stats.line_off = card->chan[ch].d.line_off;
-					memcpy(&pc300stats.gen_stats, &hdlc->stats,
+					memcpy(&pc300stats.gen_stats, hdlc_stats(dev),
 					       sizeof(struct net_device_stats));
 					if (card->hw.type == PC300_TE)
 						memcpy(&pc300stats.te_stats,&chan->falc,sizeof(falc_t));
@@ -3147,7 +3145,6 @@ static void cpc_closech(pc300dev_t * d)
 
 int cpc_open(struct net_device *dev)
 {
-	hdlc_device *hdlc = dev_to_hdlc(dev);
 	pc300dev_t *d = (pc300dev_t *) dev->priv;
 	struct ifreq ifr;
 	int result;
@@ -3156,12 +3153,14 @@ #ifdef	PC300_DEBUG_OTHER
 	printk("pc300: cpc_open");
 #endif
 
+#ifdef FIXME
 	if (hdlc->proto.id == IF_PROTO_PPP) {
 		d->if_ptr = &hdlc->state.ppp.pppdev;
 	}
+#endif
 
 	result = hdlc_open(dev);
-	if (hdlc->proto.id == IF_PROTO_PPP) {
+	if (/* FIXME hdlc->proto.id == IF_PROTO_PPP*/ 0) {
 		dev->priv = d;
 	}
 	if (result) {
@@ -3176,7 +3175,6 @@ #endif
 
 static int cpc_close(struct net_device *dev)
 {
-	hdlc_device *hdlc = dev_to_hdlc(dev);
 	pc300dev_t *d = (pc300dev_t *) dev->priv;
 	pc300ch_t *chan = (pc300ch_t *) d->chan;
 	pc300_t *card = (pc300_t *) chan->card;
@@ -3193,7 +3191,7 @@ #endif
 	CPC_UNLOCK(card, flags);
 
 	hdlc_close(dev);
-	if (hdlc->proto.id == IF_PROTO_PPP) {
+	if (/* FIXME hdlc->proto.id == IF_PROTO_PPP*/ 0) {
 		d->if_ptr = NULL;
 	}
 #ifdef CONFIG_PC300_MLPPP
