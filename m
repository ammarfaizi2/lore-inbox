Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267826AbRGREBD>; Wed, 18 Jul 2001 00:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267824AbRGREA4>; Wed, 18 Jul 2001 00:00:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37248 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267825AbRGREAh>;
	Wed, 18 Jul 2001 00:00:37 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15189.2408.59953.395204@pizda.ninka.net>
Date: Tue, 17 Jul 2001 20:58:32 -0700 (PDT)
To: Andrew Friedley <saai@swbell.net>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        netdev@oss.sgi.com, mostrows@styx.uwaterloo.ca, prefect_@gmx.net,
        moritz@chaosdorf.de, egger@suse.de, srwalter@yahoo.com,
        kuznet@ms2.inr.ac.ru, rusty@rustcorp.com.au
Subject: [PATCH] PPPOE can kfree SKB twice (was Re: kernel panic problem. (smp, iptables?))
In-Reply-To: <005f01c10e69$28273e60$0200a8c0@loki>
In-Reply-To: <005f01c10e69$28273e60$0200a8c0@loki>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Friedley writes:
 > >>EIP; c01d6fc3 <skb_drop_fraglist+17/3c>   <=====
 > Trace; c01d706b <skb_release_data+5f/74>
 > Trace; c01d7653 <skb_linearize+cf/130>
 > Trace; c01da0f7 <dev_queue_xmit+27/2e8>
 > Trace; c01ddfed <neigh_resolve_output+1cd/240>

This report has been plagueing us for a month or two now, from
different people.  But we hadn't been able to track it down.

Initially we believed it might be some obscure bug in netfilter
which got triggered more easily when the zerocopy stuff went in.
But all of our code audits turned up nothing.

Then I began to notice that "pppoe" was showing up in all the reports
where the user actually bothered to mention what net devices the
machine was using when it crashed.

I spent the past few days auditing the driver and I think I figured
out what was causing the OOPS (along with some other bugs I found
along the way).

I have no way to test out these changes, so can folks do that for me?
If I didn't screw something else up, then I'm pretty sure the OOPS
will go away.  Let me know if something goes wrong due to these
changes.

Thanks.

--- drivers/net/pppoe.c.~1~	Mon Jul  9 17:52:06 2001
+++ drivers/net/pppoe.c	Tue Jul 17 20:46:24 2001
@@ -5,7 +5,7 @@
  * PPPoE --- PPP over Ethernet (RFC 2516)
  *
  *
- * Version:    0.6.6
+ * Version:    0.6.7
  *
  * 030700 :     Fixed connect logic to allow for disconnect.
  * 270700 :	Fixed potential SMP problems; we must protect against
@@ -20,10 +20,16 @@
  * 111100 :	Fix recvmsg.
  * 050101 :	Fix PADT procesing.
  * 140501 :	Use pppoe_rcv_core to handle all backlog. (Alexey)
+ * 170701 :	Do not lock_sock with rwlock held. (DaveM)
+ *		Ignore discovery frames if user has socket
+ *		locked. (DaveM)
+ *		Ignore return value of dev_queue_xmit in __pppoe_xmit
+ *		or else we may kfree an SKB twice. (DaveM)
  *
  * Author:	Michal Ostrowski <mostrows@styx.uwaterloo.ca>
  * Contributors:
  * 		Arnaldo Carvalho de Melo <acme@xconectiva.com.br>
+ *		David S. Miller (davem@redhat.com)
  *
  * License:
  *		This program is free software; you can redistribute it and/or
@@ -100,10 +106,11 @@
 
 static int hash_item(unsigned long sid, unsigned char *addr)
 {
-	char hash=0;
-	int i,j;
-	for (i = 0; i < ETH_ALEN ; ++i){
-		for (j = 0; j < 8/PPPOE_HASH_BITS ; ++j){
+	char hash = 0;
+	int i, j;
+
+	for (i = 0; i < ETH_ALEN ; ++i) {
+		for (j = 0; j < 8/PPPOE_HASH_BITS ; ++j) {
 			hash ^= addr[i] >> ( j * PPPOE_HASH_BITS );
 		}
 	}
@@ -188,7 +195,7 @@
 
 	read_lock_bh(&pppoe_hash_lock);
 	po = __get_item(sid, addr);
-	if(po)
+	if (po)
 		sock_hold(po->sk);
 	read_unlock_bh(&pppoe_hash_lock);
 
@@ -233,62 +240,83 @@
  *  Certain device events require that sockets be unconnected.
  *
  **************************************************************************/
+
+static void pppoe_flush_dev(struct net_device *dev)
+{
+	int hash;
+
+	if (dev == NULL)
+		BUG();
+
+	read_lock_bh(&pppoe_hash_lock);
+	for (hash = 0; hash < PPPOE_HASH_SIZE; hash++) {
+		struct pppox_opt *po = item_hash_table[hash];
+
+		while (po != NULL) {
+			if (po->pppoe_dev == dev) {
+				struct sock *sk = po->sk;
+
+				sock_hold(sk);
+				po->pppoe_dev = NULL;
+
+				/* We hold a reference to SK, now drop the
+				 * hash table lock so that we may attempt
+				 * to lock the socket (which can sleep).
+				 */
+				read_unlock_bh(&pppoe_hash_lock);
+
+				lock_sock(sk);
+
+				if (sk->state & (PPPOX_CONNECTED | PPPOX_BOUND)) {
+					pppox_unbind_sock(sk);
+					dev_put(dev);
+					sk->state = PPPOX_DEAD;
+					sk->state_change(sk);
+				}
+
+				release_sock(sk);
+
+				sock_put(sk);
+
+				read_lock_bh(&pppoe_hash_lock);
+
+				/* Now restart from the beginning of this
+				 * hash chain.  We always NULL out pppoe_dev
+				 * so we are guarenteed to make forward
+				 * progress.
+				 */
+				po = item_hash_table[hash];
+				continue;
+			}
+			po = po->next;
+		}
+	}
+	read_unlock_bh(&pppoe_hash_lock);
+}
+
 static int pppoe_device_event(struct notifier_block *this,
 			      unsigned long event, void *ptr)
 {
-	int error = NOTIFY_DONE;
 	struct net_device *dev = (struct net_device *) ptr;
-	struct pppox_opt *po = NULL;
-	int hash = 0;
 
 	/* Only look at sockets that are using this specific device. */
 	switch (event) {
 	case NETDEV_CHANGEMTU:
-	    /* A change in mtu is a bad thing, requiring
-	     * LCP re-negotiation.
-	     */
+		/* A change in mtu is a bad thing, requiring
+		 * LCP re-negotiation.
+		 */
+
 	case NETDEV_GOING_DOWN:
 	case NETDEV_DOWN:
-
 		/* Find every socket on this device and kill it. */
-		read_lock_bh(&pppoe_hash_lock);
-
-		while (!po && hash < PPPOE_HASH_SIZE){
-			po = item_hash_table[hash];
-			++hash;
-		}
-
-		while (po && hash < PPPOE_HASH_SIZE){
-			if(po->pppoe_dev == dev){
-				lock_sock(po->sk);
-				if (po->sk->state & (PPPOX_CONNECTED|PPPOX_BOUND)){
-					pppox_unbind_sock(po->sk);
-
-					dev_put(po->pppoe_dev);
-					po->pppoe_dev = NULL;
-
-					po->sk->state = PPPOX_DEAD;
-					po->sk->state_change(po->sk);
-				}
- 				release_sock(po->sk);
-			}
-			if (po->next) {
-				po = po->next;
-			} else {
-				po = NULL;
-				while (!po && hash < PPPOE_HASH_SIZE){
-					po = item_hash_table[hash];
-					++hash;
-				}
-			}
-		}
-		read_unlock_bh(&pppoe_hash_lock);
+		pppoe_flush_dev(dev);
 		break;
+
 	default:
 		break;
 	};
 
-	return error;
+	return NOTIFY_DONE;
 }
 
 
@@ -304,40 +332,39 @@
  * Do the real work of receiving a PPPoE Session frame.
  *
  ***********************************************************************/
-int pppoe_rcv_core(struct sock *sk, struct sk_buff *skb){
-	struct pppox_opt  *po=sk->protinfo.pppox;
+int pppoe_rcv_core(struct sock *sk, struct sk_buff *skb)
+{
+	struct pppox_opt *po = sk->protinfo.pppox;
 	struct pppox_opt *relay_po = NULL;
 
 	if (sk->state & PPPOX_BOUND) {
 		skb_pull(skb, sizeof(struct pppoe_hdr));
-
 		ppp_input(&po->chan, skb);
-	} else if( sk->state & PPPOX_RELAY ){
-
-		relay_po = get_item_by_addr( &po->pppoe_relay );
+	} else if (sk->state & PPPOX_RELAY) {
+		relay_po = get_item_by_addr(&po->pppoe_relay);
 
-		if( relay_po == NULL  ||
-		    !( relay_po->sk->state & PPPOX_CONNECTED ) ){
-			goto abort;
-		}
+		if (relay_po == NULL)
+			goto abort_kfree;
+			
+		if ((relay_po->sk->state & PPPOX_CONNECTED) == 0)
+			goto abort_put;
 
 		skb_pull(skb, sizeof(struct pppoe_hdr));
-		if( !__pppoe_xmit( relay_po->sk , skb) ){
-			goto abort;
-		}
+		if (!__pppoe_xmit( relay_po->sk , skb))
+			goto abort_put;
 	} else {
 		sock_queue_rcv_skb(sk, skb);
 	}
-	return 1;
-abort:
-	if(relay_po)
-		sock_put(relay_po->sk);
-	return 0;
-
-}
 
+	return NET_RX_SUCCESS;
 
+abort_put:
+	sock_put(relay_po->sk);
 
+abort_kfree:
+	kfree_skb(skb);
+	return NET_RX_DROP;
+}
 
 /************************************************************************
  *
@@ -356,24 +383,25 @@
 
 	po = get_item((unsigned long) ph->sid, skb->mac.ethernet->h_source);
 
-	if(!po){
+	if (!po) {
 		kfree_skb(skb);
-		return 0;
+		return NET_RX_DROP;
 	}
 
 	sk = po->sk;
         bh_lock_sock(sk);
 
 	/* Socket state is unknown, must put skb into backlog. */
-	if( sk->lock.users != 0 ){
-		sk_add_backlog( sk, skb);
-		ret = 1;
-	}else{
+	if (sk->lock.users != 0) {
+		sk_add_backlog(sk, skb);
+		ret = NET_RX_SUCCESS;
+	} else {
 		ret = pppoe_rcv_core(sk, skb);
 	}
 
 	bh_unlock_sock(sk);
 	sock_put(sk);
+
 	return ret;
 }
 
@@ -390,24 +418,31 @@
 {
 	struct pppoe_hdr *ph = (struct pppoe_hdr *) skb->nh.raw;
 	struct pppox_opt *po;
-	struct sock *sk = NULL;
 
 	if (ph->code != PADT_CODE)
 		goto abort;
 
 	po = get_item((unsigned long) ph->sid, skb->mac.ethernet->h_source);
+	if (po) {
+		struct sock *sk = po->sk;
 
-	if (!po)
-		goto abort;
+		bh_lock_sock(sk);
 
-	sk = po->sk;
+		/* If the user has locked the socket, just ignore
+		 * the packet.  With the way two rcv protocols hook into
+		 * one socket family type, we cannot (easily) distinguish
+		 * what kind of SKB it is during backlog rcv.
+		 */
+		if (sk->lock.users == 0)
+			pppox_unbind_sock(sk);
 
-	pppox_unbind_sock(sk);
+		bh_unlock_sock(sk);
+		sock_put(sk);
+	}
 
-	sock_put(sk);
- abort:
+abort:
 	kfree_skb(skb);
-	return 0;
+	return NET_RX_SUCCESS; /* Lies... :-) */
 }
 
 struct packet_type pppoes_ptype = {
@@ -524,7 +559,7 @@
 	struct sock *sk = sock->sk;
 	struct net_device *dev = NULL;
 	struct sockaddr_pppox *sp = (struct sockaddr_pppox *) uservaddr;
-	struct pppox_opt  *po=sk->protinfo.pppox;
+	struct pppox_opt *po = sk->protinfo.pppox;
 	int error;
 
 	lock_sock(sk);
@@ -569,8 +604,9 @@
 
 		po->pppoe_dev = dev;
 
-		if( ! (dev->flags & IFF_UP) )
+		if (!(dev->flags & IFF_UP))
 			goto err_put;
+
 		memcpy(&po->pppoe_pa,
 		       &sp->sa_addr.pppoe,
 		       sizeof(struct pppoe_addr));
@@ -687,7 +723,7 @@
 		/* PPPoE address from the user specifies an outbound
 		   PPPoE address to which frames are forwarded to */
 		err = -EFAULT;
-		if( copy_from_user(&po->pppoe_relay,
+		if (copy_from_user(&po->pppoe_relay,
 				   (void*)arg,
 				   sizeof(struct sockaddr_pppox)))
 			break;
@@ -752,7 +788,7 @@
 	dev = sk->protinfo.pppox->pppoe_dev;
 
 	error = -EMSGSIZE;
- 	if(total_len > dev->mtu+dev->hard_header_len)
+ 	if (total_len > (dev->mtu + dev->hard_header_len))
 		goto end;
 
 
@@ -775,7 +811,7 @@
 	ph = (struct pppoe_hdr *) skb_put(skb, total_len + sizeof(struct pppoe_hdr));
 	start = (char *) &ph->tag[0];
 
-	error = memcpy_fromiovec( start, m->msg_iov, total_len);
+	error = memcpy_fromiovec(start, m->msg_iov, total_len);
 
 	if (error < 0) {
 		kfree_skb(skb);
@@ -793,7 +829,7 @@
 
 	dev_queue_xmit(skb);
 
- end:
+end:
 	release_sock(sk);
 	return error;
 }
@@ -811,9 +847,8 @@
 	int headroom = skb_headroom(skb);
 	int data_len = skb->len;
 
-	if (sk->dead  || !(sk->state & PPPOX_CONNECTED)) {
+	if (sk->dead  || !(sk->state & PPPOX_CONNECTED))
 		goto abort;
-	}
 
 	hdr.ver	= 1;
 	hdr.type = 1;
@@ -821,9 +856,8 @@
 	hdr.sid	= sk->num;
 	hdr.length = htons(skb->len);
 
-	if (!dev) {
+	if (!dev)
 		goto abort;
-	}
 
 	/* Copy the skb if there is no space for the header. */
 	if (headroom < (sizeof(struct pppoe_hdr) + dev->hard_header_len)) {
@@ -844,6 +878,12 @@
 		skb = skb2;
 	}
 
+	/* We may not return error beyond this point.  Potentially this
+	 * is a new SKB and in such a case we've already freed the
+	 * original SKB.  So if we were to return error, our caller would
+	 * double free that original SKB. -DaveM
+	 */
+
 	ph = (struct pppoe_hdr *) skb_push(skb, sizeof(struct pppoe_hdr));
 	memcpy(ph, &hdr, sizeof(struct pppoe_hdr));
 	skb->protocol = __constant_htons(ETH_P_PPP_SES);
@@ -856,11 +896,10 @@
 			 sk->protinfo.pppox->pppoe_pa.remote,
 			 NULL, data_len);
 
-	if (dev_queue_xmit(skb) < 0)
-		goto abort;
-
+	dev_queue_xmit(skb);
 	return 1;
- abort:
+
+abort:
 	return 0;
 }
 

