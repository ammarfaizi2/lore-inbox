Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129402AbRB0Bc4>; Mon, 26 Feb 2001 20:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbRB0Bcr>; Mon, 26 Feb 2001 20:32:47 -0500
Received: from 2-113.cwb-adsl.telepar.net.br ([200.193.161.113]:61678 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129402AbRB0Bce>; Mon, 26 Feb 2001 20:32:34 -0500
Date: Mon, 26 Feb 2001 20:53:28 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, davies@maniac.ultranet.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ewrk3.c: don't reference skb after passing it to netif_rx
Message-ID: <20010226205328.I8692@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, davies@maniac.ultranet.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey, look at this! 8)

Em Mon, Feb 26, 2001 at 08:33:59PM -0300, Arnaldo Carvalho de Melo escreveu:
Hi,

	I've just read davem's post at netdev about the brokeness of
referencing skbs after passing it to netif_rx, so please consider applying
this patch. Ah, this was just added to the Janitor's TODO list at
http://bazar.conectiva.com.br/~acme/TODO and I'm doing a quick audit in the
net drivers searching for this, maybe some more patches will follow.

- Arnaldo

--- linux-2.4.2/drivers/net/ewrk3.c	Fri Feb 16 22:06:17 2001
+++ linux-2.4.2.acme/drivers/net/ewrk3.c	Mon Feb 26 22:26:45 2001
@@ -997,19 +997,6 @@
 							isa_memcpy_fromio(p, buf, pkt_len);
 						}
 
-						/*
-						   ** Notify the upper protocol layers that there is another
-						   ** packet to handle
-						 */
-						skb->protocol = eth_type_trans(skb, dev);
-						netif_rx(skb);
-
-						/*
-						   ** Update stats
-						 */
-						dev->last_rx = jiffies;
-						lp->stats.rx_packets++;
-						lp->stats.rx_bytes += pkt_len;
 						for (i = 1; i < EWRK3_PKT_STAT_SZ - 1; i++) {
 							if (pkt_len < i * EWRK3_PKT_BIN_SZ) {
 								lp->pktStats.bins[i]++;
@@ -1031,6 +1018,19 @@
 						if (lp->pktStats.bins[0] == 0) {	/* Reset counters */
 							memset(&lp->pktStats, 0, sizeof(lp->pktStats));
 						}
+						/*
+						   ** Notify the upper protocol layers that there is another
+						   ** packet to handle
+						 */
+						skb->protocol = eth_type_trans(skb, dev);
+						netif_rx(skb);
+
+						/*
+						   ** Update stats
+						 */
+						dev->last_rx = jiffies;
+						lp->stats.rx_packets++;
+						lp->stats.rx_bytes += pkt_len;
 					} else {
 						printk("%s: Insufficient memory; nuking packet.\n", dev->name);
 						lp->stats.rx_dropped++;		/* Really, deferred. */
