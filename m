Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269055AbTBXBRI>; Sun, 23 Feb 2003 20:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269058AbTBXBRH>; Sun, 23 Feb 2003 20:17:07 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:48780 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S269055AbTBXBRA>; Sun, 23 Feb 2003 20:17:00 -0500
Date: Sun, 23 Feb 2003 20:27:02 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Message-Id: <200302240127.h1O1R2Nd027860@locutus.cmf.nrl.navy.mil>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][ATM] empty tx queue in lane client when flush completes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the lane spec says the following about path switching:

        10.1.2.7 Transmitting Held Frames

        Once the LE_FLUSH_RESPONSE is received, the LE Client MUST
        transmit any held  data frames on the new data path before
        transmitting any further frames on the new path.

        10.1.2.8 Switching Over Paths Without Flush

        Regardless of the provisions of the rest of Section 10.1, when
        switching from the old path to a new path, if an LE Client has
        not transmitted a data frame to a particular LAN Destination via
        the old path for a period of time greater than or equal to the
        C22 Path Switching Delay, then it MAY start using the new path
        without employing the Flush protocol.

the lane client in linux-atm does do this but it doesnt send the
held frames until a frame is transmitted on the vcc after the flush
has completed.  often this doesnt happen until you get an ip retransmit.
the following patch sends the held frames after the flush completes
(or the switching delay expires):

Index: linux/net/atm/lec.c
===================================================================
RCS file: /home/chas/CVSROOT/linux/net/atm/lec.c,v
retrieving revision 1.4
retrieving revision 1.5
diff -u -d -b -w -r1.4 -r1.5
--- linux/net/atm/lec.c	22 Feb 2003 17:43:41 -0000	1.4
+++ linux/net/atm/lec.c	22 Feb 2003 19:23:22 -0000	1.5
@@ -198,6 +198,23 @@
         return 0;
 }
 
+static __inline__ void
+lec_send(struct atm_vcc *vcc, struct sk_buff *skb, struct lec_priv *priv)
+{
+	if (atm_may_send(vcc, skb->len)) {
+		atomic_add(skb->truesize, &vcc->tx_inuse);
+	        ATM_SKB(skb)->vcc = vcc;
+	        ATM_SKB(skb)->iovcnt = 0;
+	        ATM_SKB(skb)->atm_options = vcc->atm_options;
+		priv->stats.tx_packets++;
+		priv->stats.tx_bytes += skb->len;
+		vcc->send(vcc, skb);
+	} else {
+		priv->stats.tx_dropped++;
+		dev_kfree_skb(skb);
+	}
+}
+
 static int 
 lec_send_packet(struct sk_buff *skb, struct net_device *dev)
 {
@@ -343,34 +360,10 @@
                 DPRINTK("MAC address 0x%02x:%02x:%02x:%02x:%02x:%02x\n",
                         lec_h->h_dest[0], lec_h->h_dest[1], lec_h->h_dest[2],
                         lec_h->h_dest[3], lec_h->h_dest[4], lec_h->h_dest[5]);
-                ATM_SKB(skb2)->vcc = send_vcc;
-                ATM_SKB(skb2)->iovcnt = 0;
-                ATM_SKB(skb2)->atm_options = send_vcc->atm_options;
-                DPRINTK("%s:sending to vpi:%d vci:%d\n", dev->name,
-                        send_vcc->vpi, send_vcc->vci);       
-                if (atm_may_send(send_vcc, skb2->len)) {
-                        atomic_add(skb2->truesize, &send_vcc->tx_inuse);
-                        priv->stats.tx_packets++;
-                        priv->stats.tx_bytes += skb2->len;
-                        send_vcc->send(send_vcc, skb2);
-                } else {
-                        priv->stats.tx_dropped++;
-                        dev_kfree_skb(skb2);
-		}
+		lec_send(send_vcc, skb2, priv);
         }
 
-        ATM_SKB(skb)->vcc = send_vcc;
-        ATM_SKB(skb)->iovcnt = 0;
-        ATM_SKB(skb)->atm_options = send_vcc->atm_options;
-        if (atm_may_send(send_vcc, skb->len)) {
-                atomic_add(skb->truesize, &send_vcc->tx_inuse);
-                priv->stats.tx_packets++;
-                priv->stats.tx_bytes += skb->len;
-                send_vcc->send(send_vcc, skb);
-        } else {
-                priv->stats.tx_dropped++;
-                dev_kfree_skb(skb);
-	}
+	lec_send(send_vcc, skb, priv);
 
 #if 0
         /* Should we wait for card's device driver to notify us? */
@@ -1615,6 +1608,10 @@
                                            &&
                                            time_after_eq(now, entry->timestamp+
                                            priv->path_switching_delay)) {
+			                        struct sk_buff *skb;
+
+ 				                while ((skb = skb_dequeue(&entry->tx_wait)))
+					                lec_send(entry->vcc, skb, entry->priv);
                                                 entry->last_used = jiffies;
                                                 entry->status = 
                                                         ESI_FORWARD_DIRECT;
@@ -2008,6 +2005,10 @@
                 for (entry=priv->lec_arp_tables[i];entry;entry=entry->next) {
                         if (entry->flush_tran_id == tran_id &&
                             entry->status == ESI_FLUSH_PENDING) {
+			        struct sk_buff *skb;
+
+ 				while ((skb = skb_dequeue(&entry->tx_wait)))
+					lec_send(entry->vcc, skb, entry->priv);
                                 entry->status = ESI_FORWARD_DIRECT;
                                 DPRINTK("LEC_ARP: Flushed\n");
                         }
