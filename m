Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129548AbRB0D2p>; Mon, 26 Feb 2001 22:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129552AbRB0D20>; Mon, 26 Feb 2001 22:28:26 -0500
Received: from 2-113.cwb-adsl.telepar.net.br ([200.193.161.113]:47599 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129548AbRB0D2U>; Mon, 26 Feb 2001 22:28:20 -0500
Date: Mon, 26 Feb 2001 22:49:11 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Yaroslav Polyakov <xenon@granch.ru>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sbni: update last_rx after netif_rx
Message-ID: <20010226224911.C8692@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Yaroslav Polyakov <xenon@granch.ru>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Please consider applying.

- Arnaldo

--- linux-2.4.2/drivers/net/wan/sbni.c	Tue Feb 13 19:15:05 2001
+++ linux-2.4.2.acme/drivers/net/wan/sbni.c	Tue Feb 27 00:19:32 2001
@@ -460,7 +460,7 @@
 	 * generate Ethernet address (0x00ff01xxxxxx)
 	 */
 
-	*(u16*)dev->dev_addr = htons(0x00ff);
+	*(u16*)dev->dev_addr = __constant_htons(0x00ff);
 	*(u32*)(dev->dev_addr+2) = htonl(((def_mac ? def_mac : (u32) dev->priv) & 0x00ffffff) | 0x01000000);
    
 	lp = dev->priv;
@@ -962,12 +962,17 @@
 static inline void sbni_get_packet(struct net_device* dev)
 {
 	struct net_local* lp = (struct net_local*)dev->priv;
+	int pktlen = lp->inppos - ETH_HLEN + sizeof(struct sbni_hard_header);
+	struct net_device* rx_dev =
+#ifdef KATYUSHA
+		lp->m;
+#else
+		dev;
+#endif      
 	struct sk_buff* skb;
 	unsigned char *rawp;
     
-   
-     
-	skb = dev_alloc_skb(lp->inppos - ETH_HLEN + sizeof(struct sbni_hard_header));
+	skb = dev_alloc_skb(pktlen);
    
 	if(skb == NULL)
 	{
@@ -975,11 +980,7 @@
 		lp->stats.rx_dropped++;
 		return;
 	} else {
-#ifdef KATYUSHA
-		skb->dev = lp->m;
-#else
-		skb->dev = dev;
-#endif      
+		skb->dev = rx_dev;
 		memcpy((unsigned char*)skb_put(skb, lp->inppos + 8)+8,
 			lp->eth_rcv_buffer,
 			lp->inppos);
@@ -1006,9 +1007,9 @@
 		{
 			rawp = (unsigned char*)(&lp->eth_rcv_buffer[2*ETH_ALEN]);
 			if (*(unsigned short *)rawp == 0xFFFF)
-				skb->protocol=htons(ETH_P_802_3);
+				skb->protocol=__constant_htons(ETH_P_802_3);
 			else
-				skb->protocol=htons(ETH_P_802_2);
+				skb->protocol=__constant_htons(ETH_P_802_2);
 		}
             
 
@@ -1016,6 +1017,8 @@
    
 		netif_rx(skb);
 		lp->stats.rx_packets++;
+		lp->stats.rx_bytes += pktlen;
+		rx_dev->last_rx = jiffies;
 	}
 	return;
 }
