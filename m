Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129458AbRB0CIa>; Mon, 26 Feb 2001 21:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129446AbRB0CIL>; Mon, 26 Feb 2001 21:08:11 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:35472 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S129453AbRB0CHw>;
	Mon, 26 Feb 2001 21:07:52 -0500
Message-ID: <3A9B0BF5.4EE5D191@mandrakesoft.com>
Date: Mon, 26 Feb 2001 21:07:49 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, dahinds@users.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 3c589_cs: don't reference skb after passing it to netif_rx
In-Reply-To: <20010226211058.M8692@conectiva.com.br>
Content-Type: multipart/mixed;
 boundary="------------A85589EAB4ABBBB23B427F36"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A85589EAB4ABBBB23B427F36
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

And here are the rest of the ones in pcmcia.
-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
--------------A85589EAB4ABBBB23B427F36
Content-Type: text/plain; charset=us-ascii;
 name="pcmcia-rx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcmcia-rx.patch"

Index: drivers/net/pcmcia/3c574_cs.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/net/pcmcia/3c574_cs.c,v
retrieving revision 1.1.1.11
diff -u -r1.1.1.11 3c574_cs.c
--- drivers/net/pcmcia/3c574_cs.c	2001/02/11 21:28:07	1.1.1.11
+++ drivers/net/pcmcia/3c574_cs.c	2001/02/27 02:05:52
@@ -1166,7 +1166,9 @@
 
 				skb->protocol = eth_type_trans(skb, dev);
 				netif_rx(skb);
+				dev->last_rx = jiffies;
 				lp->stats.rx_packets++;
+				lp->stats.rx_bytes += pkt_len;
 			} else {
 				DEBUG(1, "%s: couldn't allocate a sk_buff of"
 					  " size %d.\n", dev->name, pkt_len);
Index: drivers/net/pcmcia/netwave_cs.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/net/pcmcia/netwave_cs.c,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 netwave_cs.c
--- drivers/net/pcmcia/netwave_cs.c	2001/02/11 21:28:08	1.1.1.8
+++ drivers/net/pcmcia/netwave_cs.c	2001/02/27 02:05:53
@@ -1463,16 +1463,16 @@
 	skb->protocol = eth_type_trans(skb,dev);
 	/* Queue packet for network layer */
 	netif_rx(skb);
-		
+
+	dev->last_rx = jiffies;
+	priv->stats.rx_packets++;
+	priv->stats.rx_bytes += rcvLen;
+
 	/* Got the packet, tell the adapter to skip it */
 	wait_WOC(iobase);
 	writeb(NETWAVE_CMD_SRP, ramBase + NETWAVE_EREG_CB + 0);
 	writeb(NETWAVE_CMD_EOC, ramBase + NETWAVE_EREG_CB + 1);
 	DEBUG(3, "Packet reception ok\n");
-		
-	priv->stats.rx_packets++;
-
-	priv->stats.rx_bytes += skb->len;
     }
     return 0;
 }
Index: drivers/net/pcmcia/nmclan_cs.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/net/pcmcia/nmclan_cs.c,v
retrieving revision 1.1.1.9
diff -u -r1.1.1.9 nmclan_cs.c
--- drivers/net/pcmcia/nmclan_cs.c	2001/02/11 21:28:08	1.1.1.9
+++ drivers/net/pcmcia/nmclan_cs.c	2001/02/27 02:05:53
@@ -1288,9 +1288,9 @@
 	skb->protocol = eth_type_trans(skb, dev);
 	
 	netif_rx(skb); /* Send the packet to the upper (protocol) layers. */
-
+	dev->last_rx = jiffies;
 	lp->linux_stats.rx_packets++;
-	lp->linux_stats.rx_bytes += skb->len;
+	lp->linux_stats.rx_bytes += pkt_len;
 	outb(0xFF, ioaddr + AM2150_RCV_NEXT); /* skip to next frame */
 	continue;
       } else {
Index: drivers/net/pcmcia/ray_cs.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/net/pcmcia/ray_cs.c,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 ray_cs.c
--- drivers/net/pcmcia/ray_cs.c	2001/02/11 21:28:06	1.1.1.8
+++ drivers/net/pcmcia/ray_cs.c	2001/02/27 02:05:54
@@ -2219,9 +2219,9 @@
 
     skb->protocol = eth_type_trans(skb,dev);
     netif_rx(skb);
-
+    dev->last_rx = jiffies;
     local->stats.rx_packets++;
-    local->stats.rx_bytes += skb->len;
+    local->stats.rx_bytes += total_len;
 
     /* Gather signal strength per address */
 #ifdef WIRELESS_SPY
Index: drivers/net/pcmcia/smc91c92_cs.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/net/pcmcia/smc91c92_cs.c,v
retrieving revision 1.1.1.12.2.2
diff -u -r1.1.1.12.2.2 smc91c92_cs.c
--- drivers/net/pcmcia/smc91c92_cs.c	2001/02/25 15:20:31	1.1.1.12.2.2
+++ drivers/net/pcmcia/smc91c92_cs.c	2001/02/27 02:05:55
@@ -1617,8 +1617,9 @@
 	
 	skb->dev = dev;
 	netif_rx(skb);
+	dev->last_rx = jiffies;
 	smc->stats.rx_packets++;
-	smc->stats.rx_bytes += skb->len;
+	smc->stats.rx_bytes += packet_length;
 	if (rx_status & RS_MULTICAST)
 	    smc->stats.multicast++;
     } else {
Index: drivers/net/pcmcia/wavelan_cs.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/net/pcmcia/wavelan_cs.c,v
retrieving revision 1.1.1.16.2.1
diff -u -r1.1.1.16.2.1 wavelan_cs.c
--- drivers/net/pcmcia/wavelan_cs.c	2001/02/23 00:15:34	1.1.1.16.2.1
+++ drivers/net/pcmcia/wavelan_cs.c	2001/02/27 02:05:56
@@ -2733,8 +2733,9 @@
   netif_rx(skb);
 
   /* Keep stats up to date */
+  dev->last_rx = jiffies;
   lp->stats.rx_packets++;
-  lp->stats.rx_bytes += skb->len;
+  lp->stats.rx_bytes += sksize;
 
 #ifdef DEBUG_RX_TRACE
   printk(KERN_DEBUG "%s: <-wv_packet_read()\n", dev->name);
Index: drivers/net/pcmcia/xirc2ps_cs.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/net/pcmcia/xirc2ps_cs.c,v
retrieving revision 1.1.1.14.2.2
diff -u -r1.1.1.14.2.2 xirc2ps_cs.c
--- drivers/net/pcmcia/xirc2ps_cs.c	2001/02/23 03:37:00	1.1.1.14.2.2
+++ drivers/net/pcmcia/xirc2ps_cs.c	2001/02/27 02:05:57
@@ -1420,6 +1420,7 @@
 		skb->protocol = eth_type_trans(skb, dev);
 		skb->dev = dev;
 		netif_rx(skb);
+		dev->last_rx = jiffies;
 		lp->stats.rx_packets++;
 		lp->stats.rx_bytes += pktlen;
 		if (!(rsr & PhyPkt))

--------------A85589EAB4ABBBB23B427F36--

