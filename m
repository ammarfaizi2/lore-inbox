Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270297AbUJTWaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270297AbUJTWaA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269135AbUJTTsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:48:54 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:17331 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S269164AbUJTTig
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:38:36 -0400
From: Esben Nielsen <simlo@phys.au.dk>
Date: Wed, 20 Oct 2004 21:38:32 +0200
Message-Id: <200410201938.AA22241@da410.ifa.au.dk>
Subject: ArcNet patch [PATCH]
Apparently-To: linux-net@vger.kernel.org
Apparently-To: linux-kernel@vger.kernel.org
X-DAIMI-Spam-Score: -1.429 () ALL_TRUSTED,UNDISC_RECIPS
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
 As previously reported the ArcNet driver didn't work with Preempt and SMB on.
They do now. I have changed the locking system from being a global arcnet lock
to being a lock per device. I used the lock in dev->hard_start_xmit = 
arcnet_send_packet. 

Furthermore I added the "CAP mode" encapsulation. As far as I see it it is the
only encapsulation which actually makes ArcNet usefull over ethernet. 
Previously, the driver just ignored the hardware transmit status, now you
can get hardware acknowledge and excessive nacks back to userspace via a raw
socket. The capmode.c is nearly just a copy of  arc-rawmode.c. The difference
is that it inserts a ack_tx() handle into the general driver framework.

This patch is done on 2.6.8.1.

I have tested on my uniprocessor laptop with a PCMCIA card. Should make no
difference if you use this or a PCI or ISA card.

Esben Nielsen
(Vestas Wind Systems A/S, Denmark)

diff -Naur --exclude-from=linux-no-diff linux-2.6.8.1/drivers/net/arcnet/arcnet.c linux-2.6.8.1arcnet/drivers/net/arcnet/arcnet.c
--- linux-2.6.8.1/drivers/net/arcnet/arcnet.c	2004-08-14 12:55:47.000000000 +0200
+++ linux-2.6.8.1arcnet/drivers/net/arcnet/arcnet.c	2004-10-20 19:40:17.000000000 +0200
@@ -51,8 +51,7 @@
 #include <linux/if_arp.h>
 #include <net/arp.h>
 #include <linux/init.h>
-#include <linux/arcdevice.h>
-
+#include <linux/arcdevice.h>  
 
 /* "do nothing" functions for protocol drivers */
 static void null_rx(struct net_device *dev, int bufnum,
@@ -69,25 +68,28 @@
  * arc_proto_default instead.  It also must not be NULL; if you would like
  * to set it to NULL, set it to &arc_proto_null instead.
  */
-struct ArcProto *arc_proto_map[256], *arc_proto_default, *arc_bcast_proto;
+ struct ArcProto *arc_proto_map[256], *arc_proto_default, 
+   *arc_bcast_proto, *arc_raw_proto;
 
 struct ArcProto arc_proto_null =
 {
 	.suffix		= '?',
 	.mtu		= XMTU,
+	.is_ip          = 0,
 	.rx		= null_rx,
 	.build_header	= null_build_header,
 	.prepare_tx	= null_prepare_tx,
+	.continue_tx    = NULL,
+	.ack_tx         = NULL	
 };
 
-static spinlock_t arcnet_lock = SPIN_LOCK_UNLOCKED;
-
 /* Exported function prototypes */
 int arcnet_debug = ARCNET_DEBUG;
 
 EXPORT_SYMBOL(arc_proto_map);
 EXPORT_SYMBOL(arc_proto_default);
 EXPORT_SYMBOL(arc_bcast_proto);
+EXPORT_SYMBOL(arc_raw_proto);
 EXPORT_SYMBOL(arc_proto_null);
 EXPORT_SYMBOL(arcnet_unregister_proto);
 EXPORT_SYMBOL(arcnet_debug);
@@ -131,7 +133,7 @@
 #endif
 
 	/* initialize the protocol map */
-	arc_proto_default = arc_bcast_proto = &arc_proto_null;
+	arc_raw_proto = arc_proto_default = arc_bcast_proto = &arc_proto_null;
 	for (count = 0; count < 256; count++)
 		arc_proto_map[count] = arc_proto_default;
 
@@ -155,7 +157,8 @@
  * Dump the contents of an sk_buff
  */
 #if ARCNET_DEBUG_MAX & D_SKB
-void arcnet_dump_skb(struct net_device *dev, struct sk_buff *skb, char *desc)
+void arcnet_dump_skb(struct net_device *dev, 
+		     struct sk_buff *skb, char *desc)
 {
 	int i;
 
@@ -176,18 +179,22 @@
  * Dump the contents of an ARCnet buffer
  */
 #if (ARCNET_DEBUG_MAX & (D_RX | D_TX))
-void arcnet_dump_packet(struct net_device *dev, int bufnum, char *desc)
+void arcnet_dump_packet(struct net_device *dev, int bufnum, char *desc,
+			int take_arcnet_lock)
 {
 	struct arcnet_local *lp = (struct arcnet_local *) dev->priv;
 	int i, length;
-	unsigned long flags;
+	unsigned long flags = 0;
 	static uint8_t buf[512];
 
 	/* hw.copy_from_card expects IRQ context so take the IRQ lock
 	   to keep it single threaded */
-	spin_lock_irqsave(&arcnet_lock, flags);
+	if(take_arcnet_lock)
+		spin_lock_irqsave(&lp->lock, flags);
+
 	lp->hw.copy_from_card(dev, bufnum, 0, buf, 512);
-	spin_unlock_irqrestore(&arcnet_lock, flags);
+	if(take_arcnet_lock)
+		spin_unlock_irqrestore(&lp->lock, flags);
 
 	/* if the offset[0] byte is nonzero, this is a 256-byte packet */
 	length = (buf[2] ? 256 : 512);
@@ -219,6 +226,8 @@
 		arc_proto_default = &arc_proto_null;
 	if (arc_bcast_proto == proto)
 		arc_bcast_proto = arc_proto_default;
+	if (arc_raw_proto == proto)
+		arc_raw_proto = arc_proto_default;
 
 	for (count = 0; count < 256; count++) {
 		if (arc_proto_map[count] == proto)
@@ -261,8 +270,11 @@
 	struct arcnet_local *lp = (struct arcnet_local *) dev->priv;
 	int buf = -1, i;
 
-	if (!atomic_dec_and_test(&lp->buf_lock))	/* already in this function */
-		BUGMSG(D_NORMAL, "get_arcbuf: overlap (%d)!\n", lp->buf_lock.counter);
+	if (!atomic_dec_and_test(&lp->buf_lock)) {
+		/* already in this function */
+		BUGMSG(D_NORMAL, "get_arcbuf: overlap (%d)!\n", 
+		       lp->buf_lock.counter);
+	}
 	else {			/* we can continue */
 		if (lp->next_buf >= 5)
 			lp->next_buf -= 5;
@@ -312,7 +324,7 @@
 	dev->mtu = choose_mtu();
 
 	dev->addr_len = ARCNET_ALEN;
-	dev->tx_queue_len = 30;
+	dev->tx_queue_len = 100;
 	dev->broadcast[0] = 0x00;	/* for us, broadcasts are address 0 */
 	dev->watchdog_timeo = TX_TIMEOUT;
 
@@ -334,8 +346,16 @@
 
 struct net_device *alloc_arcdev(char *name)
 {
-	return alloc_netdev(sizeof(struct arcnet_local),
-			    name && *name ? name : "arc%d", arcdev_setup);
+	struct net_device *dev;
+
+	dev = alloc_netdev(sizeof(struct arcnet_local),
+			   name && *name ? name : "arc%d", arcdev_setup);
+	if(dev) {
+		struct arcnet_local *lp = (struct arcnet_local *) dev->priv;
+		lp->lock = SPIN_LOCK_UNLOCKED;
+	}
+
+	return dev;		
 }
 
 /*
@@ -351,6 +371,8 @@
 	struct arcnet_local *lp = (struct arcnet_local *) dev->priv;
 	int count, newmtu, error;
 
+	BUGMSG(D_INIT,"opened.");
+
 	if (!try_module_get(lp->hw.owner))
 		return -ENODEV;
 
@@ -377,6 +399,8 @@
 	if (newmtu < dev->mtu)
 		dev->mtu = newmtu;
 
+	BUGMSG(D_INIT, "arcnet_open: mtu: %d.\n", dev->mtu);
+
 	/* autodetect the encapsulation for each host. */
 	memset(lp->default_proto, 0, sizeof(lp->default_proto));
 
@@ -390,6 +414,7 @@
 
 	/* initialize buffers */
 	atomic_set(&lp->buf_lock, 1);
+
 	lp->next_buf = lp->first_free_buf = 0;
 	release_arcbuf(dev, 0);
 	release_arcbuf(dev, 1);
@@ -401,7 +426,9 @@
 	lp->rfc1201.sequence = 1;
 
 	/* bring up the hardware driver */
-	lp->hw.open(dev);
+	if(lp->hw.open) {
+		lp->hw.open(dev);
+	}
 
 	if (dev->dev_addr[0] == 0)
 		BUGMSG(D_NORMAL, "WARNING!  Station address 00 is reserved "
@@ -410,17 +437,24 @@
 		BUGMSG(D_NORMAL, "WARNING!  Station address FF may confuse "
 		       "DOS networking programs!\n");
 
-	if (ASTATUS() & RESETflag)
+	BUGMSG(D_DEBUG, "%s: %d: %s\n",__FILE__,__LINE__,__FUNCTION__);
+	if (ASTATUS() & RESETflag) {
+	  	BUGMSG(D_DEBUG, "%s: %d: %s\n",__FILE__,__LINE__,__FUNCTION__);
 		ACOMMAND(CFLAGScmd | RESETclear);
+	}
 
+
+	BUGMSG(D_DEBUG, "%s: %d: %s\n",__FILE__,__LINE__,__FUNCTION__);
 	/* make sure we're ready to receive IRQ's. */
 	AINTMASK(0);
 	udelay(1);		/* give it time to set the mask before
 				 * we reset it again. (may not even be
 				 * necessary)
 				 */
+	BUGMSG(D_DEBUG, "%s: %d: %s\n",__FILE__,__LINE__,__FUNCTION__);
 	lp->intmask = NORXflag | RECONflag;
 	AINTMASK(lp->intmask);
+	BUGMSG(D_DEBUG, "%s: %d: %s\n",__FILE__,__LINE__,__FUNCTION__);
 
 	netif_start_queue(dev);
 
@@ -466,32 +500,41 @@
 	       daddr ? *(uint8_t *) daddr : -1,
 	       type, type, len);
 
-	if (len != skb->len)
+	if (skb->len!=0 && len != skb->len)
 		BUGMSG(D_NORMAL, "arcnet_header: Yikes!  skb->len(%d) != len(%d)!\n",
 		       skb->len, len);
 
-	/*
-	 * if the dest addr isn't provided, we can't choose an encapsulation!
-	 * Store the packet type (eg. ETH_P_IP) for now, and we'll push on a
-	 * real header when we do rebuild_header. 
-	 */
-	if (!daddr) {
+
+  	/* Type is host order - ? */
+  	if(type == ETH_P_ARCNET) {
+  		proto = arc_raw_proto;
+  		BUGMSG(D_DEBUG, "arc_raw_proto used. proto='%c'\n",proto->suffix);
+  		_daddr = daddr ? *(uint8_t *) daddr : 0;
+  	}
+	else if (!daddr) {
+		/*
+		 * if the dest addr isn't provided, we can't choose an encapsulation!
+		 * Store the packet type (eg. ETH_P_IP) for now, and we'll push on a
+		 * real header when we do rebuild_header. 
+		 */
 		*(uint16_t *) skb_push(skb, 2) = type;
 		if (skb->nh.raw - skb->mac.raw != 2)
 			BUGMSG(D_NORMAL, "arcnet_header: Yikes!  diff (%d) is not 2!\n",
 			       (int)(skb->nh.raw - skb->mac.raw));
 		return -2;	/* return error -- can't transmit yet! */
 	}
-	/* otherwise, we can just add the header as usual. */
-	_daddr = *(uint8_t *) daddr;
-	proto_num = lp->default_proto[_daddr];
-	proto = arc_proto_map[proto_num];
-	BUGMSG(D_DURING, "building header for %02Xh using protocol '%c'\n",
-	       proto_num, proto->suffix);
-	if (proto == &arc_proto_null && arc_bcast_proto != proto) {
-		BUGMSG(D_DURING, "actually, let's use '%c' instead.\n",
-		       arc_bcast_proto->suffix);
-		proto = arc_bcast_proto;
+	else {
+		/* otherwise, we can just add the header as usual. */
+		_daddr = *(uint8_t *) daddr;
+		proto_num = lp->default_proto[_daddr];
+		proto = arc_proto_map[proto_num];
+		BUGMSG(D_DURING, "building header for %02Xh using protocol '%c'\n",
+		       proto_num, proto->suffix);
+		if (proto == &arc_proto_null && arc_bcast_proto != proto) {
+			BUGMSG(D_DURING, "actually, let's use '%c' instead.\n",
+			       arc_bcast_proto->suffix);
+			proto = arc_bcast_proto;
+		}
 	}
 	return proto->build_header(skb, dev, type, _daddr);
 }
@@ -518,6 +561,7 @@
 		return 0;
 	}
 	type = *(uint16_t *) skb_pull(skb, 2);
+	BUGMSG(D_DURING, "rebuild header for protocol %Xh\n", type);
 
 	if (type == ETH_P_IP) {
 #ifdef CONFIG_INET
@@ -554,10 +598,12 @@
 	struct arc_rfc1201 *soft;
 	struct ArcProto *proto;
 	int txbuf;
+	unsigned long flags;
+	int freeskb = 0;
 
 	BUGMSG(D_DURING,
-	       "transmit requested (status=%Xh, txbufs=%d/%d, len=%d)\n",
-	       ASTATUS(), lp->cur_tx, lp->next_tx, skb->len);
+	       "transmit requested (status=%Xh, txbufs=%d/%d, len=%d, protocol %x)\n",
+	       ASTATUS(), lp->cur_tx, lp->next_tx, skb->len,skb->protocol);
 
 	pkt = (struct archdr *) skb->data;
 	soft = &pkt->soft.rfc1201;
@@ -577,38 +623,49 @@
 	/* We're busy transmitting a packet... */
 	netif_stop_queue(dev);
 
+	spin_lock_irqsave(&lp->lock, flags);
 	AINTMASK(0);
 
 	txbuf = get_arcbuf(dev);
 	if (txbuf != -1) {
-		if (proto->prepare_tx(dev, pkt, skb->len, txbuf)) {
-			/* done right away */
+		if (proto->prepare_tx(dev, pkt, skb->len, txbuf) &&
+		    !proto->ack_tx) {
+			/* done right away and we don't want to acknowledge
+			   the package later - forget about it now */
 			lp->stats.tx_bytes += skb->len;
-			dev_kfree_skb(skb);
+			freeskb = 1;
 		} else {
 			/* do it the 'split' way */
 			lp->outgoing.proto = proto;
 			lp->outgoing.skb = skb;
 			lp->outgoing.pkt = pkt;
 
-			if (!proto->continue_tx)
-				BUGMSG(D_NORMAL, "bug! prep_tx==0, but no continue_tx!\n");
-			else if (proto->continue_tx(dev, txbuf)) {
-				BUGMSG(D_NORMAL,
-				       "bug! continue_tx finished the first time! "
-				       "(proto='%c')\n", proto->suffix);
+			if (proto->continue_tx &&
+			    proto->continue_tx(dev, txbuf)) {
+			  BUGMSG(D_NORMAL,
+				 "bug! continue_tx finished the first time! "
+				 "(proto='%c')\n", proto->suffix);
 			}
 		}
 
 		lp->next_tx = txbuf;
-	} else
-		dev_kfree_skb(skb);
+	} else {
+		freeskb = 1;
+	}
 
+	BUGMSG(D_DEBUG, "%s: %d: %s, status: %x\n",__FILE__,__LINE__,__FUNCTION__,ASTATUS());
 	/* make sure we didn't ignore a TX IRQ while we were in here */
 	AINTMASK(0);
-	lp->intmask |= TXFREEflag;
+
+	BUGMSG(D_DEBUG, "%s: %d: %s\n",__FILE__,__LINE__,__FUNCTION__);
+	lp->intmask |= TXFREEflag|EXCNAKflag;
 	AINTMASK(lp->intmask);
+	BUGMSG(D_DEBUG, "%s: %d: %s, status: %x\n",__FILE__,__LINE__,__FUNCTION__,ASTATUS());
 
+	spin_unlock_irqrestore(&lp->lock, flags);
+	if (freeskb) {
+		dev_kfree_skb(skb);
+	}
 	return 0;		/* no need to try again */
 }
 
@@ -627,7 +684,7 @@
 	if (lp->cur_tx != -1 || lp->next_tx == -1)
 		return 0;
 
-	BUGLVL(D_TX) arcnet_dump_packet(dev, lp->next_tx, "go_tx");
+	BUGLVL(D_TX) arcnet_dump_packet(dev, lp->next_tx, "go_tx", 0);
 
 	lp->cur_tx = lp->next_tx;
 	lp->next_tx = -1;
@@ -639,7 +696,8 @@
 	lp->stats.tx_packets++;
 	lp->lasttrans_dest = lp->lastload_dest;
 	lp->lastload_dest = 0;
-	lp->intmask |= TXFREEflag;
+	lp->excnak_pending = 0;
+	lp->intmask |= TXFREEflag|EXCNAKflag;
 
 	return 1;
 }
@@ -653,7 +711,7 @@
 	int status = ASTATUS();
 	char *msg;
 
-	spin_lock_irqsave(&arcnet_lock, flags);
+	spin_lock_irqsave(&lp->lock, flags);
 	if (status & TXFREEflag) {	/* transmit _DID_ finish */
 		msg = " - missed IRQ?";
 	} else {
@@ -664,12 +722,12 @@
 	}
 	lp->stats.tx_errors++;
 
-	/* make sure we didn't miss a TX IRQ */
+	/* make sure we didn't miss a TX or a EXC NAK IRQ */
 	AINTMASK(0);
-	lp->intmask |= TXFREEflag;
+	lp->intmask |= TXFREEflag|EXCNAKflag;
 	AINTMASK(lp->intmask);
 	
-	spin_unlock_irqrestore(&arcnet_lock, flags);
+	spin_unlock_irqrestore(&lp->lock, flags);
 
 	if (jiffies - lp->last_timeout > 10*HZ) {
 		BUGMSG(D_EXTRA, "tx timed out%s (status=%Xh, intmask=%Xh, dest=%02Xh)\n",
@@ -691,18 +749,19 @@
 {
 	struct net_device *dev = dev_id;
 	struct arcnet_local *lp;
-	int recbuf, status, didsomething, boguscount;
+	int recbuf, status, diagstatus, didsomething, boguscount;
+	int retval = IRQ_NONE;
 
 	BUGMSG(D_DURING, "\n");
 
 	BUGMSG(D_DURING, "in arcnet_interrupt\n");
-
-	spin_lock(&arcnet_lock);
 	
 	lp = (struct arcnet_local *) dev->priv;
 	if (!lp)
 		BUG();
 		
+	spin_lock(&lp->lock);
+
 	/*
 	 * RESET flag was enabled - if device is not running, we must clear it right
 	 * away (but nothing else).
@@ -711,7 +770,7 @@
 		if (ASTATUS() & RESETflag)
 			ACOMMAND(CFLAGScmd | RESETclear);
 		AINTMASK(0);
-		spin_unlock(&arcnet_lock);
+		spin_unlock(&lp->lock);
 		return IRQ_HANDLED;
 	}
 
@@ -721,6 +780,10 @@
 	boguscount = 5;
 	do {
 		status = ASTATUS();
+                diagstatus = (status >> 8) & 0xFF;
+
+		BUGMSG(D_DEBUG, "%s: %d: %s: status=%x\n",
+			__FILE__,__LINE__,__FUNCTION__,status);
 		didsomething = 0;
 
 		/*
@@ -760,24 +823,55 @@
 			}
 			didsomething++;
 		}
+
+		if((diagstatus & EXCNAKflag)) {
+			BUGMSG(D_DURING, "EXCNAK IRQ (diagstat=%Xh)\n", 
+			       diagstatus);
+
+                        ACOMMAND(NOTXcmd);      /* disable transmit */
+                        lp->excnak_pending = 1;
+
+                        ACOMMAND(EXCNAKclear);
+			lp->intmask &= ~(EXCNAKflag);
+                        didsomething++;
+                }
+
+
 		/* a transmit finished, and we're interested in it. */
 		if ((status & lp->intmask & TXFREEflag) || lp->timed_out) {
-			lp->intmask &= ~TXFREEflag;
+			lp->intmask &= ~(TXFREEflag|EXCNAKflag);
 
 			BUGMSG(D_DURING, "TX IRQ (stat=%Xh)\n", status);
 
-			if (lp->cur_tx != -1 && !(status & TXACKflag) && !lp->timed_out) {
-				if (lp->lasttrans_dest != 0) {
-					BUGMSG(D_EXTRA, "transmit was not acknowledged! "
-					    "(status=%Xh, dest=%02Xh)\n",
-					     status, lp->lasttrans_dest);
-					lp->stats.tx_errors++;
-					lp->stats.tx_carrier_errors++;
-				} else {
-					BUGMSG(D_DURING,
-					       "broadcast was not acknowledged; that's normal "
-					    "(status=%Xh, dest=%02Xh)\n",
-					     status, lp->lasttrans_dest);
+			if (lp->cur_tx != -1 && !lp->timed_out) {
+				if(!(status & TXACKflag)) {
+					if (lp->lasttrans_dest != 0) {
+						BUGMSG(D_EXTRA, 
+						       "transmit was not acknowledged! "
+						       "(status=%Xh, dest=%02Xh)\n",
+						       status, lp->lasttrans_dest);
+						lp->stats.tx_errors++;
+						lp->stats.tx_carrier_errors++;
+					} else {
+						BUGMSG(D_DURING,
+						       "broadcast was not acknowledged; that's normal "
+						       "(status=%Xh, dest=%02Xh)\n",
+						       status, lp->lasttrans_dest);
+					}
+				}
+
+				if (lp->outgoing.proto && 
+				    lp->outgoing.proto->ack_tx) {
+				  int ackstatus;
+				  if(status & TXACKflag)
+                                    ackstatus=2;
+                                  else if(lp->excnak_pending)
+                                    ackstatus=1;
+                                  else
+                                    ackstatus=0;
+
+                                  lp->outgoing.proto
+                                    ->ack_tx(dev, ackstatus);
 				}
 			}
 			if (lp->cur_tx != -1)
@@ -797,8 +891,11 @@
 					if (lp->outgoing.proto->continue_tx(dev, txbuf)) {
 						/* that was the last segment */
 						lp->stats.tx_bytes += lp->outgoing.skb->len;
-						dev_kfree_skb_irq(lp->outgoing.skb);
-						lp->outgoing.proto = NULL;
+						if(!lp->outgoing.proto->ack_tx)
+						  {
+						    dev_kfree_skb_irq(lp->outgoing.skb);
+						    lp->outgoing.proto = NULL;
+						  }
 					}
 					lp->next_tx = txbuf;
 				}
@@ -809,7 +906,7 @@
 		}
 		/* now process the received packet, if any */
 		if (recbuf != -1) {
-			BUGLVL(D_RX) arcnet_dump_packet(dev, recbuf, "rx irq");
+			BUGLVL(D_RX) arcnet_dump_packet(dev, recbuf, "rx irq", 0);
 
 			arcnet_rx(dev, recbuf);
 			release_arcbuf(dev, recbuf);
@@ -867,6 +964,10 @@
 
 			BUGMSG(D_DURING, "not recon: clearing counters anyway.\n");
 		}
+		
+		if(didsomething) {
+			retval |= IRQ_HANDLED; 
+		}
 	}
 	while (--boguscount && didsomething);
 
@@ -879,8 +980,8 @@
 	udelay(1);
 	AINTMASK(lp->intmask);
 	
-	spin_unlock(&arcnet_lock);
-	return IRQ_RETVAL(didsomething);
+	spin_unlock(&lp->lock);
+	return retval;
 }
 
 
@@ -907,7 +1008,7 @@
 	}
 
 	/* get the full header, if possible */
-	if (sizeof(pkt.soft) < length)
+	if (sizeof(pkt.soft) <= length)
 		lp->hw.copy_from_card(dev, bufnum, ofs, soft, sizeof(pkt.soft));
 	else {
 		memset(&pkt.soft, 0, sizeof(pkt.soft));
@@ -922,7 +1023,7 @@
 	lp->stats.rx_bytes += length + ARC_HDR_SIZE;
 
 	/* call the right receiver for the protocol */
-	if (arc_proto_map[soft->proto] != &arc_proto_null) {
+	if (arc_proto_map[soft->proto]->is_ip) {
 		BUGLVL(D_PROTO) {
 			struct ArcProto
 			*oldp = arc_proto_map[lp->default_proto[pkt.hard.source]],
diff -Naur --exclude-from=linux-no-diff linux-2.6.8.1/drivers/net/arcnet/arc-rawmode.c linux-2.6.8.1arcnet/drivers/net/arcnet/arc-rawmode.c
--- linux-2.6.8.1/drivers/net/arcnet/arc-rawmode.c	2004-08-14 12:56:23.000000000 +0200
+++ linux-2.6.8.1arcnet/drivers/net/arcnet/arc-rawmode.c	2004-10-16 18:25:13.000000000 +0200
@@ -42,7 +42,6 @@
 static int prepare_tx(struct net_device *dev, struct archdr *pkt, int length,
 		      int bufnum);
 
-
 struct ArcProto rawmode_proto =
 {
 	.suffix		= 'r',
@@ -50,6 +49,8 @@
 	.rx		= rx,
 	.build_header	= build_header,
 	.prepare_tx	= prepare_tx,
+	.continue_tx    = NULL,
+	.ack_tx         = NULL
 };
 
 
@@ -121,7 +122,8 @@
 
 	BUGLVL(D_SKB) arcnet_dump_skb(dev, skb, "rx");
 
-	skb->protocol = 0;
+	skb->protocol = __constant_htons(ETH_P_ARCNET);
+;
 	netif_rx(skb);
 	dev->last_rx = jiffies;
 }
@@ -190,6 +192,9 @@
 	} else
 		hard->offset[0] = ofs = 256 - length;
 
+	BUGMSG(D_DURING, "prepare_tx: length=%d ofs=%d\n",
+	       length,ofs);
+
 	lp->hw.copy_to_card(dev, bufnum, 0, hard, ARC_HDR_SIZE);
 	lp->hw.copy_to_card(dev, bufnum, ofs, &pkt->soft, length);
 
diff -Naur --exclude-from=linux-no-diff linux-2.6.8.1/drivers/net/arcnet/capmode.c linux-2.6.8.1arcnet/drivers/net/arcnet/capmode.c
--- linux-2.6.8.1/drivers/net/arcnet/capmode.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8.1arcnet/drivers/net/arcnet/capmode.c	2004-10-16 17:49:29.000000000 +0200
@@ -0,0 +1,296 @@
+/*
+ * Linux ARCnet driver - "cap mode" packet encapsulation.
+ * It adds sequence numbers to packets for communicating between a user space 
+ * application and the driver. After a transmit it sends a packet with protocol
+ * byte 0 back up to the userspace containing the sequence number of the packet
+ * plus the transmit-status on the ArcNet.
+ * 
+ * Written 2002-4 by Esben Nielsen, Vestas Wind Systems A/S
+ * Derived from arc-rawmode.c by Avery Pennarun.
+ * arc-rawmode was in turned based on skeleton.c, see below.
+ *
+ * **********************
+ *
+ * The original copyright of skeleton.c was as follows:
+ *
+ * skeleton.c Written 1993 by Donald Becker.
+ * Copyright 1993 United States Government as represented by the
+ * Director, National Security Agency.  This software may only be used
+ * and distributed according to the terms of the GNU General Public License as
+ * modified by SRC, incorporated herein by reference.
+ *
+ * **********************
+ *
+ * For more details, see drivers/net/arcnet.c
+ *
+ * **********************
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/if_arp.h>
+#include <net/arp.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <linux/arcdevice.h>
+
+#define VERSION "arcnet: cap mode (`c') encapsulation support loaded.\n"
+
+
+static void rx(struct net_device *dev, int bufnum,
+	       struct archdr *pkthdr, int length);
+static int build_header(struct sk_buff *skb, 
+			struct net_device *dev,
+			unsigned short type,
+			uint8_t daddr);
+static int prepare_tx(struct net_device *dev, struct archdr *pkt, int length,
+		      int bufnum);
+static int ack_tx(struct net_device *dev, int acked);
+
+
+struct ArcProto capmode_proto =
+{
+	'r',
+	XMTU,
+	0,
+       	rx,
+	build_header,
+	prepare_tx,
+	NULL,
+	ack_tx
+};
+
+
+void arcnet_cap_init(void)
+{
+	int count;
+
+	for (count = 1; count <= 8; count++)
+		if (arc_proto_map[count] == arc_proto_default)
+			arc_proto_map[count] = &capmode_proto;
+
+	/* for cap mode, we only set the bcast proto if there's no better one */
+	if (arc_bcast_proto == arc_proto_default)
+		arc_bcast_proto = &capmode_proto;
+
+	arc_proto_default = &capmode_proto; 
+	arc_raw_proto = &capmode_proto;
+}
+
+
+#ifdef MODULE
+
+int __init init_module(void)
+{
+	printk(VERSION);
+	arcnet_cap_init();
+	return 0;
+}
+
+void cleanup_module(void)
+{
+	arcnet_unregister_proto(&capmode_proto);
+}
+
+MODULE_LICENSE("GPL");
+#endif				/* MODULE */
+
+
+
+/* packet receiver */
+static void rx(struct net_device *dev, int bufnum,
+	       struct archdr *pkthdr, int length)
+{
+	struct arcnet_local *lp = (struct arcnet_local *) dev->priv;
+	struct sk_buff *skb;
+	struct archdr *pkt = pkthdr;
+	char *pktbuf, *pkthdrbuf;
+	int ofs;
+
+	BUGMSG(D_DURING, "it's a raw(cap) packet (length=%d)\n", length);
+
+	if (length >= MinTU)
+		ofs = 512 - length;
+	else
+		ofs = 256 - length;
+
+	skb = alloc_skb(length + ARC_HDR_SIZE + sizeof(int), GFP_ATOMIC);
+	if (skb == NULL) {
+		BUGMSG(D_NORMAL, "Memory squeeze, dropping packet.\n");
+		lp->stats.rx_dropped++;
+		return;
+	}
+	skb_put(skb, length + ARC_HDR_SIZE + sizeof(int));
+	skb->dev = dev;
+
+	pkt = (struct archdr *) skb->data;
+
+	skb->mac.raw = skb->data;
+	skb_pull(skb, ARC_HDR_SIZE);
+
+	/* up to sizeof(pkt->soft) has already been copied from the card */
+	/* squeeze in an int for the cap encapsulation */
+
+	/* use these variables to be sure we count in bytes, not in 
+	   sizeof(struct archdr) */
+	pktbuf=(char*)pkt;
+	pkthdrbuf=(char*)pkthdr;
+	memcpy(pktbuf, pkthdrbuf, ARC_HDR_SIZE+sizeof(pkt->soft.cap.proto));
+	memcpy(pktbuf+ARC_HDR_SIZE+sizeof(pkt->soft.cap.proto)+sizeof(int), 
+	       pkthdrbuf+ARC_HDR_SIZE+sizeof(pkt->soft.cap.proto), 
+	       sizeof(struct archdr)-ARC_HDR_SIZE-sizeof(pkt->soft.cap.proto));
+	
+	if (length > sizeof(pkt->soft))
+		lp->hw.copy_from_card(dev, bufnum, ofs + sizeof(pkt->soft),
+				      pkt->soft.raw + sizeof(pkt->soft) 
+				      + sizeof(int),
+				      length - sizeof(pkt->soft));
+
+	BUGLVL(D_SKB) arcnet_dump_skb(dev, skb, "rx");
+
+	skb->protocol = __constant_htons(ETH_P_ARCNET);
+;
+	netif_rx(skb);
+	dev->last_rx = jiffies;
+}
+
+
+/*
+ * Create the ARCnet hard/soft headers for cap mode.
+ * There aren't any soft headers in cap mode - not even the protocol id.
+ */
+static int build_header(struct sk_buff *skb, 
+			struct net_device *dev,
+			unsigned short type,
+			uint8_t daddr)
+{
+	int hdr_size = ARC_HDR_SIZE;
+	struct archdr *pkt = (struct archdr *) skb_push(skb, hdr_size);
+
+	BUGMSG(D_PROTO, "Preparing header for cap packet %x.\n",
+	       *((int*)&pkt->soft.cap.cookie[0]));
+	/*
+	 * Set the source hardware address.
+	 *
+	 * This is pretty pointless for most purposes, but it can help in
+	 * debugging.  ARCnet does not allow us to change the source address in
+	 * the actual packet sent)
+	 */
+	pkt->hard.source = *dev->dev_addr;
+
+	/* see linux/net/ethernet/eth.c to see where I got the following */
+
+	if (dev->flags & (IFF_LOOPBACK | IFF_NOARP)) {
+		/* 
+		 * FIXME: fill in the last byte of the dest ipaddr here to better
+		 * comply with RFC1051 in "noarp" mode.
+		 */
+		pkt->hard.dest = 0;
+		return hdr_size;
+	}
+	/* otherwise, just fill it in and go! */
+	pkt->hard.dest = daddr;
+
+	return hdr_size;	/* success */
+}
+
+
+static int prepare_tx(struct net_device *dev, struct archdr *pkt, int length,
+		      int bufnum)
+{
+	struct arcnet_local *lp = (struct arcnet_local *) dev->priv;
+	struct arc_hardware *hard = &pkt->hard;
+	int ofs;
+
+
+	/* hard header is not included in packet length */
+	length -= ARC_HDR_SIZE;	
+	/* And neither is the cookie field */
+	length -= sizeof(int);
+
+	BUGMSG(D_DURING, "prepare_tx: txbufs=%d/%d/%d\n",
+	       lp->next_tx, lp->cur_tx, bufnum);
+
+	BUGMSG(D_PROTO, "Sending for cap packet %x.\n",
+	       *((int*)&pkt->soft.cap.cookie[0]));
+
+	if (length > XMTU) {
+		/* should never happen! other people already check for this. */
+		BUGMSG(D_NORMAL, "Bug!  prepare_tx with size %d (> %d)\n",
+		       length, XMTU);
+		length = XMTU;
+	}
+	if (length > MinTU) {
+		hard->offset[0] = 0;
+		hard->offset[1] = ofs = 512 - length;
+	} else if (length > MTU) {
+		hard->offset[0] = 0;
+		hard->offset[1] = ofs = 512 - length - 3;
+	} else
+		hard->offset[0] = ofs = 256 - length;
+
+	BUGMSG(D_DURING, "prepare_tx: length=%d ofs=%d\n",
+	       length,ofs);
+
+	// Copy the arcnet-header + the protocol byte down:
+	lp->hw.copy_to_card(dev, bufnum, 0, hard, ARC_HDR_SIZE);
+	lp->hw.copy_to_card(dev, bufnum, ofs, &pkt->soft.cap.proto,
+			    sizeof(pkt->soft.cap.proto));
+
+	// Skip the extra integer we have written into it as a cookie
+	// but write the rest of the message:
+	lp->hw.copy_to_card(dev, bufnum, ofs+1, 
+			    ((unsigned char*)&pkt->soft.cap.mes),length-1);
+
+	lp->lastload_dest = hard->dest;
+
+	return 1;		/* done */
+}
+
+
+static int ack_tx(struct net_device *dev, int acked)
+{
+  struct arcnet_local *lp = (struct arcnet_local *) dev->priv;
+  struct sk_buff *ackskb;
+  struct archdr *ackpkt;
+  int length=sizeof(struct arc_cap);
+  
+  BUGMSG(D_DURING, "capmode: ack_tx: protocol: %x: result: %d\n",
+	 lp->outgoing.skb->protocol, acked);
+  
+  BUGLVL(D_SKB) arcnet_dump_skb(dev, lp->outgoing.skb, "ack_tx");
+
+  /* Now alloc a skb to send back up through the layers: */
+  ackskb = alloc_skb(length + ARC_HDR_SIZE , GFP_ATOMIC);
+  if (ackskb == NULL) {
+	  BUGMSG(D_NORMAL, "Memory squeeze, can't acknowledge.\n");
+	  goto free_outskb;
+  }
+
+  skb_put(ackskb, length + ARC_HDR_SIZE );
+  ackskb->dev = dev;
+  
+  ackpkt = (struct archdr *) ackskb->data;
+
+  ackskb->mac.raw = ackskb->data;
+  /* skb_pull(ackskb, ARC_HDR_SIZE); */
+  
+  
+  memcpy(ackpkt, lp->outgoing.skb->data, ARC_HDR_SIZE+sizeof(struct arc_cap));
+  ackpkt->soft.cap.proto=0; /* using protocol 0 for acknowledge */
+  ackpkt->soft.cap.mes.ack=acked;
+
+  BUGMSG(D_PROTO, "Ackknowledge for cap packet %x.\n",
+	 *((int*)&ackpkt->soft.cap.cookie[0]));
+
+  ackskb->protocol = __constant_htons(ETH_P_ARCNET);
+
+  BUGLVL(D_SKB) arcnet_dump_skb(dev, ackskb, "ack_tx_recv");
+  netif_rx(ackskb);
+
+ free_outskb:
+  dev_kfree_skb_irq(lp->outgoing.skb);
+  lp->outgoing.proto = NULL; /* We are always finished when in this protocol */
+  
+  return 0;
+}
diff -Naur --exclude-from=linux-no-diff linux-2.6.8.1/drivers/net/arcnet/com20020.c linux-2.6.8.1arcnet/drivers/net/arcnet/com20020.c
--- linux-2.6.8.1/drivers/net/arcnet/com20020.c	2004-08-14 12:55:10.000000000 +0200
+++ linux-2.6.8.1arcnet/drivers/net/arcnet/com20020.c	2004-10-20 19:44:00.000000000 +0200
@@ -117,7 +117,7 @@
 	lp->config = 0x21 | (lp->timeout << 3) | (lp->backplane << 2);
 	/* set node ID to 0x42 (but transmitter is disabled, so it's okay) */
 	SETCONF;
-	outb(0x42, ioaddr + 7);
+	outb(0x42, ioaddr + BUS_ALIGN*7);
 
 	status = ASTATUS();
 
@@ -129,7 +129,7 @@
 
 	/* Enable TX */
 	outb(0x39, _CONFIG);
-	outb(inb(ioaddr + 8), ioaddr + 7);
+	outb(inb(ioaddr + BUS_ALIGN*8), ioaddr + BUS_ALIGN*7);
 
 	ACOMMAND(CFLAGScmd | RESETclear | CONFIGclear);
 
@@ -173,7 +173,7 @@
 	dev->set_multicast_list = com20020_set_mc_list;
 
 	if (!dev->dev_addr[0])
-		dev->dev_addr[0] = inb(ioaddr + 8);	/* FIXME: do this some other way! */
+		dev->dev_addr[0] = inb(ioaddr + BUS_ALIGN*8);	/* FIXME: do this some other way! */
 
 	SET_SUBADR(SUB_SETUP1);
 	outb(lp->setup, _XREG);
@@ -188,7 +188,6 @@
 		outb(0x18, _COMMAND);
 	}
 
-
 	lp->config = 0x20 | (lp->timeout << 3) | (lp->backplane << 2) | 1;
 	/* Default 0x38 + register: Node ID */
 	SETCONF;
@@ -235,15 +234,19 @@
 static int com20020_reset(struct net_device *dev, int really_reset)
 {
 	struct arcnet_local *lp = (struct arcnet_local *) dev->priv;
-	short ioaddr = dev->base_addr;
+	u_int ioaddr = dev->base_addr;
 	u_char inbyte;
 
+	BUGMSG(D_DEBUG, "%s: %d: %s: dev: %p, lp: %p, dev->name: %s\n",
+		__FILE__,__LINE__,__FUNCTION__,dev,lp,dev->name);
 	BUGMSG(D_INIT, "Resetting %s (status=%02Xh)\n",
 	       dev->name, ASTATUS());
 
+	BUGMSG(D_DEBUG, "%s: %d: %s\n",__FILE__,__LINE__,__FUNCTION__);
 	lp->config = TXENcfg | (lp->timeout << 3) | (lp->backplane << 2);
 	/* power-up defaults */
 	SETCONF;
+	BUGMSG(D_DEBUG, "%s: %d: %s\n",__FILE__,__LINE__,__FUNCTION__);
 
 	if (really_reset) {
 		/* reset the card */
@@ -251,17 +254,22 @@
 		mdelay(RESETtime * 2);	/* COM20020 seems to be slower sometimes */
 	}
 	/* clear flags & end reset */
+	BUGMSG(D_DEBUG, "%s: %d: %s\n",__FILE__,__LINE__,__FUNCTION__);
 	ACOMMAND(CFLAGScmd | RESETclear | CONFIGclear);
 
 	/* verify that the ARCnet signature byte is present */
+	BUGMSG(D_DEBUG, "%s: %d: %s\n",__FILE__,__LINE__,__FUNCTION__);
 
 	com20020_copy_from_card(dev, 0, 0, &inbyte, 1);
+	BUGMSG(D_DEBUG, "%s: %d: %s\n",__FILE__,__LINE__,__FUNCTION__);
 	if (inbyte != TESTvalue) {
+		BUGMSG(D_DEBUG, "%s: %d: %s\n",__FILE__,__LINE__,__FUNCTION__);
 		BUGMSG(D_NORMAL, "reset failed: TESTvalue not present.\n");
 		return 1;
 	}
 	/* enable extended (512-byte) packets */
 	ACOMMAND(CONFIGcmd | EXTconf);
+	BUGMSG(D_DEBUG, "%s: %d: %s\n",__FILE__,__LINE__,__FUNCTION__);
 
 	/* done!  return success. */
 	return 0;
@@ -270,22 +278,24 @@
 
 static void com20020_setmask(struct net_device *dev, int mask)
 {
-	short ioaddr = dev->base_addr;
+	u_int ioaddr = dev->base_addr;
+	BUGMSG(D_DURING, "Setting mask to %x at %x\n",mask,ioaddr);
 	AINTMASK(mask);
 }
 
 
 static void com20020_command(struct net_device *dev, int cmd)
 {
-	short ioaddr = dev->base_addr;
+	u_int ioaddr = dev->base_addr;
 	ACOMMAND(cmd);
 }
 
 
 static int com20020_status(struct net_device *dev)
 {
-	short ioaddr = dev->base_addr;
-	return ASTATUS();
+	u_int ioaddr = dev->base_addr;
+	
+	return ASTATUS() + (ADIAGSTATUS()<<8);
 }
 
 static void com20020_close(struct net_device *dev)
diff -Naur --exclude-from=linux-no-diff linux-2.6.8.1/drivers/net/arcnet/com20020-isa.c linux-2.6.8.1arcnet/drivers/net/arcnet/com20020-isa.c
--- linux-2.6.8.1/drivers/net/arcnet/com20020-isa.c	2004-08-14 12:54:50.000000000 +0200
+++ linux-2.6.8.1arcnet/drivers/net/arcnet/com20020-isa.c	2004-10-20 20:01:34.000000000 +0200
@@ -41,7 +41,6 @@
 
 #include <asm/io.h>
 
-
 #define VERSION "arcnet: COM20020 ISA support (by David Woodhouse et al.)\n"
 
 
diff -Naur --exclude-from=linux-no-diff linux-2.6.8.1/drivers/net/arcnet/Kconfig linux-2.6.8.1arcnet/drivers/net/arcnet/Kconfig
--- linux-2.6.8.1/drivers/net/arcnet/Kconfig	2004-08-14 12:56:22.000000000 +0200
+++ linux-2.6.8.1arcnet/drivers/net/arcnet/Kconfig	2004-10-20 20:12:00.000000000 +0200
@@ -59,6 +59,25 @@
 	  to work unless talking to a copy of the same Linux arcnet driver,
 	  but perhaps marginally faster in that case.
 
+config ARCNET_CAP
+	tristate "Enable CAP mode packet interface"
+	depends on ARCNET
+	help
+	  ARCnet "cap mode" packet encapsulation. Used to get the hardware 
+          acknowledge back to userspace. After the initial protocol byte every 
+          packet is stuffed with an extra 4 byte "cookie" which doesn't 
+          actually appear on the network. After transmit the driver will send 
+          back a packet with protocol byte 0 containing the status of the 
+          transmition: 
+             0=no hardware acknowledge
+             1=excessive nak
+             2=transmition accepted by the reciever hardware
+      
+          Received packets are also stuffed with the extra 4 bytes but it will
+          be random data.
+
+          Cap only listens to protocol 1-8.
+
 config ARCNET_COM90xx
 	tristate "ARCnet COM90xx (normal) chipset driver"
 	depends on ARCNET
diff -Naur --exclude-from=linux-no-diff linux-2.6.8.1/drivers/net/arcnet/Makefile linux-2.6.8.1arcnet/drivers/net/arcnet/Makefile
--- linux-2.6.8.1/drivers/net/arcnet/Makefile	2004-08-14 12:55:47.000000000 +0200
+++ linux-2.6.8.1arcnet/drivers/net/arcnet/Makefile	2004-10-18 15:44:32.000000000 +0200
@@ -5,6 +5,7 @@
 obj-$(CONFIG_ARCNET_1201) += rfc1201.o
 obj-$(CONFIG_ARCNET_1051) += rfc1051.o
 obj-$(CONFIG_ARCNET_RAW) += arc-rawmode.o
+obj-$(CONFIG_ARCNET_CAP) += capmode.o
 obj-$(CONFIG_ARCNET_COM90xx) += com90xx.o
 obj-$(CONFIG_ARCNET_COM90xxIO) += com90io.o
 obj-$(CONFIG_ARCNET_RIM_I) += arc-rimi.o
diff -Naur --exclude-from=linux-no-diff linux-2.6.8.1/drivers/net/arcnet/rfc1051.c linux-2.6.8.1arcnet/drivers/net/arcnet/rfc1051.c
--- linux-2.6.8.1/drivers/net/arcnet/rfc1051.c	2004-08-14 12:55:35.000000000 +0200
+++ linux-2.6.8.1arcnet/drivers/net/arcnet/rfc1051.c	2004-10-16 18:11:12.000000000 +0200
@@ -47,9 +47,12 @@
 {
 	.suffix		= 's',
 	.mtu		= XMTU - RFC1051_HDR_SIZE,
+	.is_ip          = 1,
 	.rx		= rx,
 	.build_header	= build_header,
 	.prepare_tx	= prepare_tx,
+	.continue_tx    = NULL,
+	.ack_tx         = NULL
 };
 
 
diff -Naur --exclude-from=linux-no-diff linux-2.6.8.1/drivers/net/arcnet/rfc1201.c linux-2.6.8.1arcnet/drivers/net/arcnet/rfc1201.c
--- linux-2.6.8.1/drivers/net/arcnet/rfc1201.c	2004-08-14 12:55:32.000000000 +0200
+++ linux-2.6.8.1arcnet/drivers/net/arcnet/rfc1201.c	2004-10-16 18:10:29.000000000 +0200
@@ -47,10 +47,12 @@
 {
 	.suffix		= 'a',
 	.mtu		= 1500,	/* could be more, but some receivers can't handle it... */
+	.is_ip          = 1,    /* This is for sending IP and ARP packages */
 	.rx		= rx,
 	.build_header	= build_header,
 	.prepare_tx	= prepare_tx,
 	.continue_tx	= continue_tx,
+	.ack_tx         = NULL
 };
 
 
diff -Naur --exclude-from=linux-no-diff linux-2.6.8.1/include/linux/arcdevice.h linux-2.6.8.1arcnet/include/linux/arcdevice.h
--- linux-2.6.8.1/include/linux/arcdevice.h	2004-08-14 12:54:51.000000000 +0200
+++ linux-2.6.8.1arcnet/include/linux/arcdevice.h	2004-10-20 20:00:51.000000000 +0200
@@ -25,7 +25,6 @@
 #define bool int
 #endif
 
-
 /*
  * RECON_THRESHOLD is the maximum number of RECON messages to receive
  * within one minute before printing a "cabling problem" warning. The
@@ -74,6 +73,7 @@
 #define D_SKB		1024	/* show skb's                             */
 #define D_SKB_SIZE	2048	/* show skb sizes			  */
 #define D_TIMING	4096	/* show time needed to copy buffers to card */
+#define D_DEBUG         8192    /* Very detailed debug line for line */ 
 
 #ifndef ARCNET_DEBUG_MAX
 #define ARCNET_DEBUG_MAX (127)	/* change to ~0 if you want detailed debugging */
@@ -135,6 +135,7 @@
 #define TXACKflag       0x02	/* transmitted msg. ackd */
 #define RECONflag       0x04	/* network reconfigured */
 #define TESTflag        0x08	/* test flag */
+#define EXCNAKflag      0x08    /* excesive nak flag */
 #define RESETflag       0x10	/* power-on-reset */
 #define RES1flag        0x20	/* reserved - usually set by jumper */
 #define RES2flag        0x40	/* reserved - usually set by jumper */
@@ -162,6 +163,8 @@
 #define RESETclear      0x08	/* power-on-reset */
 #define CONFIGclear     0x10	/* system reconfigured */
 
+#define EXCNAKclear     0x0E    /* Clear and acknowledge the excive nak bit */
+
 /* flags for "load test flags" command */
 #define TESTload        0x08	/* test flag (diagnostic) */
 
@@ -187,6 +190,7 @@
 struct ArcProto {
 	char suffix;		/* a for RFC1201, e for ether-encap, etc. */
 	int mtu;		/* largest possible packet */
+	int is_ip;              /* This is a ip plugin - not a raw thing */
 
 	void (*rx) (struct net_device * dev, int bufnum,
 		    struct archdr * pkthdr, int length);
@@ -197,9 +201,11 @@
 	int (*prepare_tx) (struct net_device * dev, struct archdr * pkt, int length,
 			   int bufnum);
 	int (*continue_tx) (struct net_device * dev, int bufnum);
+	int (*ack_tx) (struct net_device * dev, int acked);
 };
 
-extern struct ArcProto *arc_proto_map[256], *arc_proto_default, *arc_bcast_proto;
+extern struct ArcProto *arc_proto_map[256], *arc_proto_default, 
+	*arc_bcast_proto, *arc_raw_proto;
 extern struct ArcProto arc_proto_null;
 
 
@@ -251,6 +257,10 @@
 	char *card_name;	/* card ident string */
 	int card_flags;		/* special card features */
 
+
+	/* On preemtive and SMB a lock is needed */
+	spinlock_t lock;
+
 	/*
 	 * Buffer management: an ARCnet card has 4 x 512-byte buffers, each of
 	 * which can be used for either sending or receiving.  The new dynamic
@@ -279,6 +289,8 @@
 	int num_recons;		/* number of RECONs between first and last. */
 	bool network_down;	/* do we think the network is down? */
 
+	bool excnak_pending;    /* We just got an excesive nak interrupt */
+
 	struct {
 		uint16_t sequence;	/* sequence number (incs with each packet) */
 		uint16_t aborted_seq;
@@ -323,9 +335,10 @@
 #endif
 
 #if (ARCNET_DEBUG_MAX & D_RX) || (ARCNET_DEBUG_MAX & D_TX)
-void arcnet_dump_packet(struct net_device *dev, int bufnum, char *desc);
+void arcnet_dump_packet(struct net_device *dev, int bufnum, char *desc,
+			int take_arcnet_lock);
 #else
-#define arcnet_dump_packet(dev, bufnum, desc) ;
+#define arcnet_dump_packet(dev, bufnum, desc,take_arcnet_lock) ;
 #endif
 
 void arcnet_unregister_proto(struct ArcProto *proto);
diff -Naur --exclude-from=linux-no-diff linux-2.6.8.1/include/linux/com20020.h linux-2.6.8.1arcnet/include/linux/com20020.h
--- linux-2.6.8.1/include/linux/com20020.h	2004-08-14 12:55:47.000000000 +0200
+++ linux-2.6.8.1arcnet/include/linux/com20020.h	2004-10-20 19:42:24.000000000 +0200
@@ -34,18 +34,25 @@
 #define ARCNET_TOTAL_SIZE 8
 
 /* various register addresses */
-#define _INTMASK  (ioaddr+0)	/* writable */
-#define _STATUS   (ioaddr+0)	/* readable */
-#define _COMMAND  (ioaddr+1)	/* standard arcnet commands */
-#define _DIAGSTAT (ioaddr+1)	/* diagnostic status register */
-#define _ADDR_HI  (ioaddr+2)	/* control registers for IO-mapped memory */
-#define _ADDR_LO  (ioaddr+3)
-#define _MEMDATA  (ioaddr+4)	/* data port for IO-mapped memory */
-#define _SUBADR   (ioaddr+5)	/* the extended port _XREG refers to */
-#define _CONFIG   (ioaddr+6)	/* configuration register */
-#define _XREG     (ioaddr+7)	/* extra registers (indexed by _CONFIG 
-					or _SUBADR) */
-
+#ifdef CONFIG_SA1100_CT6001
+#define BUS_ALIGN  2  /* 8 bit device on a 16 bit bus - needs padding */
+#else
+#define BUS_ALIGN  1
+#endif
+
+
+#define _INTMASK  (ioaddr+BUS_ALIGN*0)	/* writable */
+#define _STATUS   (ioaddr+BUS_ALIGN*0)	/* readable */
+#define _COMMAND  (ioaddr+BUS_ALIGN*1)	/* standard arcnet commands */
+#define _DIAGSTAT (ioaddr+BUS_ALIGN*1)	/* diagnostic status register */
+#define _ADDR_HI  (ioaddr+BUS_ALIGN*2)	/* control registers for IO-mapped memory */
+#define _ADDR_LO  (ioaddr+BUS_ALIGN*3)
+#define _MEMDATA  (ioaddr+BUS_ALIGN*4)	/* data port for IO-mapped memory */
+#define _SUBADR   (ioaddr+BUS_ALIGN*5)	/* the extended port _XREG refers to */
+#define _CONFIG   (ioaddr+BUS_ALIGN*6)	/* configuration register */
+#define _XREG     (ioaddr+BUS_ALIGN*7)	/* extra registers (indexed by _CONFIG 
+  					or _SUBADR) */
+  
 /* in the ADDR_HI register */
 #define RDDATAflag	0x80	/* next access is a read (not a write) */
 
@@ -99,6 +106,7 @@
                   }
 
 #define ASTATUS()	inb(_STATUS)
+#define ADIAGSTATUS()	inb(_DIAGSTAT)
 #define ACOMMAND(cmd)	outb((cmd),_COMMAND)
 #define AINTMASK(msk)	outb((msk),_INTMASK)
 
diff -Naur --exclude-from=linux-no-diff linux-2.6.8.1/include/linux/if_arcnet.h linux-2.6.8.1arcnet/include/linux/if_arcnet.h
--- linux-2.6.8.1/include/linux/if_arcnet.h	2004-08-14 12:54:50.000000000 +0200
+++ linux-2.6.8.1arcnet/include/linux/if_arcnet.h	2004-10-20 20:26:15.000000000 +0200
@@ -23,6 +23,9 @@
  *    These are the defined ARCnet Protocol ID's.
  */
 
+/* CAP mode */
+/* No macro but uses 1-8 */
+
 /* RFC1201 Protocol ID's */
 #define ARC_P_IP		212	/* 0xD4 */
 #define ARC_P_IPV6		196	/* 0xC4: RFC2497 */
@@ -86,6 +89,16 @@
 #define ETH_ENCAP_HDR_SIZE 14
 
 
+struct arc_cap
+{
+	uint8_t proto;
+	uint8_t cookie[sizeof(int)];   /* Actually NOT sent over the network */
+	union {
+		uint8_t ack;
+		uint8_t raw[0];		/* 507 bytes */
+	} mes;
+};
+
 /*
  * The data needed by the actual arcnet hardware.
  *
@@ -116,6 +129,7 @@
 	struct arc_rfc1201   rfc1201;
 	struct arc_rfc1051   rfc1051;
 	struct arc_eth_encap eth_encap;
+	struct arc_cap       cap;
 	uint8_t raw[0];		/* 508 bytes				*/
     } soft;
 };
diff -Naur --exclude-from=linux-no-diff linux-2.6.8.1/include/linux/if_ether.h linux-2.6.8.1arcnet/include/linux/if_ether.h
--- linux-2.6.8.1/include/linux/if_ether.h	2004-08-14 12:55:34.000000000 +0200
+++ linux-2.6.8.1arcnet/include/linux/if_ether.h	2004-10-16 17:53:53.000000000 +0200
@@ -89,6 +89,7 @@
 #define ETH_P_IRDA	0x0017		/* Linux-IrDA			*/
 #define ETH_P_ECONET	0x0018		/* Acorn Econet			*/
 #define ETH_P_HDLC	0x0019		/* HDLC frames			*/
+#define ETH_P_ARCNET	0x0020		/* ArcNet			*/
 
 /*
  *	This is an Ethernet frame header.
diff -Naur --exclude-from=linux-no-diff linux-2.6.8.1/include/linux/net.h linux-2.6.8.1arcnet/include/linux/net.h
--- linux-2.6.8.1/include/linux/net.h	2004-08-14 12:55:19.000000000 +0200
+++ linux-2.6.8.1arcnet/include/linux/net.h	2004-10-16 17:53:53.000000000 +0200
@@ -25,7 +25,7 @@
 struct poll_table_struct;
 struct inode;
 
-#define NPROTO		32		/* should be enough for now..	*/
+#define NPROTO		33		/* should be enough for now..	*/
 
 #define SYS_SOCKET	1		/* sys_socket(2)		*/
 #define SYS_BIND	2		/* sys_bind(2)			*/
