Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130216AbRCCBgq>; Fri, 2 Mar 2001 20:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130215AbRCCBgg>; Fri, 2 Mar 2001 20:36:36 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:36804 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S130214AbRCCBgX>;
	Fri, 2 Mar 2001 20:36:23 -0500
Date: Fri, 2 Mar 2001 17:36:20 -0800
To: Dag Brattli <dag@brattli.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-irda@pasta.cs.uit.no,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Nasty bug in the IrDA stack
Message-ID: <20010302173620.C10036@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Hi,

	I've found a really convoluted bug in the IrDA stack (spend
the week chasing it). As it is not trivial, I would like you to check
and comment on my description and my fix.
	My patch definitely fix the problem on the PC where I was
seeing it, and I can't crash it anymore (whereas it was very
reproducible before).

	The crash :
-----------------------
-> irda_release();			// Close IrDA socket
<- irda_release()
-> irlap_update_nr_received();		// Receive IrLAP ack
-> kfree_skb();				// Free acked packet
-> sock_wfree();
-> sock_def_write_space();		// Increase socket write buffer
-> __wake_up();				// Wake up writer
**** Crash ****
------------------------

	What I believe is happening :
	The socket is closing. We remove all the packet associated
with the socket instance (in IrTTP and the socket layer).
	Unfortunately, there are packets in IrLAP, waiting for
retransmission, and as IrLAP doesn't know about sockets, those packets
are not freed at this point.
	When IrLAP try to free those packets, they refer to a socket
that no longer exist, and we go into the cosmos.

	In fact, it was worse. The packet still had a reference to the
socket when we were calling dev_queue_xmit(skb), and as the device
layer can also queue skbs, the same problem can happen (even if it
would be much more difficult to trigger).

	The fix :
	skb_clone() and skb_free() the packet before passing them to
the LAP layer. This way, they don't refer any socket.

	Alan :
	Is there in the kernel a function doing the equivalent of the
following but optimised (avoiding malloc/free of the skb structure) :
-----------------------
	skb2 = skb_clone(skb1);
	kfree_skb(skb1);
	skb1 = skb2;
-----------------------
	The point there is to remove the reference to skb->sk, so I
want something that do the opposite of skb_set_owner_w(). Something I
would call skb_set_owner_none()...

	Thanks, and good week end...

	Jean

P.S. : I also removed all the skb_set_owner_w() in IrLAP, they are now
totally useless.
P.S.2 : Dag : Do not put this patch yet in the kernel, we need a bit
more testing and comments...

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ir242_sock_detach.diff"

diff -u -p linux/net/irda/irttp.j2.c linux/net/irda/irttp.c
--- linux/net/irda/irttp.j2.c	Fri Mar  2 14:10:29 2001
+++ linux/net/irda/irttp.c	Fri Mar  2 14:22:10 2001
@@ -404,6 +404,7 @@ int irttp_data_request(struct tsap_cb *s
 static void irttp_run_tx_queue(struct tsap_cb *self) 
 {
 	struct sk_buff *skb;
+	struct sk_buff *tx_skb;
 	unsigned long flags;
 	int n;
 
@@ -454,7 +455,40 @@ static void irttp_run_tx_queue(struct ts
 		 */
 		skb->data[0] |= (n & 0x7f);
 		
-		irlmp_data_request(self->lsap, skb);
+		/* Detach from socket.
+		 * The current skb has a reference to the socket that sent
+		 * it (skb->sk). When we pass it to IrLMP, the skb will be
+		 * stored in in IrLAP (self->wx_list). When we are within
+		 * IrLAP, we loose the notion of socket, so we should not
+		 * have a reference to a socket. So, we drop it here.
+		 * 
+		 * Why does it matter ?
+		 * When the skb is freed (kfree_skb), if it is associated
+		 * with a socket, it release buffer space on the socket
+		 * (through sock_wfree() and sock_def_write_space()).
+		 * If the socket no longer exist, we may crash. Hard.
+		 * When we close a socket, we make sure that associated packets
+		 * in IrTTP are freed. However, we have no way to cancel
+		 * the packet that we have passed to IrLAP. So, if a packet
+		 * remains in IrLAP (retry on the link or else) after we
+		 * close the socket, we are dead !
+		 * Jean II */
+		if (skb->sk != NULL) {
+			IRDA_DEBUG(4, __FUNCTION__ "() : Detaching SKB from socket.\n");
+			/* Get another skb on the same buffer, but without
+			 * a reference to the socket (skb->sk = NULL) */
+			tx_skb = skb_clone(skb, GFP_ATOMIC);
+			if (tx_skb != NULL) {
+				/* Release the skb associated with the
+				 * socket, and use the new skb insted */
+				kfree_skb(skb);
+			}
+		} else {
+			IRDA_DEBUG(3, __FUNCTION__ "() : Got SKB not attached to a socket.\n");
+			tx_skb = skb;
+		}
+
+		irlmp_data_request(self->lsap, tx_skb);
 		self->stats.tx_packets++;
 
 		/* Check if we can accept more frames from client */
diff -u -p linux/net/irda/irlmp.j2.c linux/net/irda/irlmp.c
--- linux/net/irda/irlmp.j2.c	Fri Mar  2 14:10:08 2001
+++ linux/net/irda/irlmp.c	Fri Mar  2 14:15:05 2001
@@ -963,6 +963,7 @@ int irlmp_data_request(struct lsap_cb *s
 {
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == LMP_LSAP_MAGIC, return -1;);
+	ASSERT(skb->sk == NULL, /* Just a warning - NOP */;);
 	
 	/* Make room for MUX header */
 	ASSERT(skb_headroom(skb) >= LMP_HEADER, return -1;);
diff -u -p linux/net/irda/irlap_frame.j2.c linux/net/irda/irlap_frame.c
--- linux/net/irda/irlap_frame.j2.c	Fri Mar  2 14:10:19 2001
+++ linux/net/irda/irlap_frame.c	Fri Mar  2 14:16:06 2001
@@ -742,12 +742,6 @@ void irlap_send_data_primary(struct irla
 			return;
 		}
 		
-		/*
-		 *  make sure the skb->sk accounting of memory usage is sane
-		 */
-		if (skb->sk != NULL)
-			skb_set_owner_w(tx_skb, skb->sk);
-		
 		/* 
 		 *  Insert frame in store, in case of retransmissions 
 		 */
@@ -788,12 +782,6 @@ void irlap_send_data_primary_poll(struct
 			return;
 		}
 		
-		/*
-		 *  make sure the skb->sk accounting of memory usage is sane
-		 */
-		if (skb->sk != NULL)
-			skb_set_owner_w(tx_skb, skb->sk);
-		
 		/* 
 		 *  Insert frame in store, in case of retransmissions 
 		 */
@@ -863,9 +851,6 @@ void irlap_send_data_secondary_final(str
 			return;
 		}		
 
-		if (skb->sk != NULL)
-			skb_set_owner_w(tx_skb, skb->sk);
-		
 		/* Insert frame in store */
 		skb_queue_tail(&self->wx_list, skb_get(skb));
 		
@@ -917,9 +902,6 @@ void irlap_send_data_secondary(struct ir
 			return;
 		}		
 		
-		if (skb->sk != NULL)
-			skb_set_owner_w(tx_skb, skb->sk);
-		
 		/* Insert frame in store */
 		skb_queue_tail(&self->wx_list, skb_get(skb));
 		
@@ -973,12 +955,6 @@ void irlap_resend_rejected_frames(struct
 		tx_skb->next = tx_skb->prev = NULL;
 		tx_skb->list = NULL;
 
-		/*
-		 *  make sure the skb->sk accounting of memory usage is sane
-		 */
-		if (skb->sk != NULL)
-			skb_set_owner_w(tx_skb, skb->sk);
-
 		/* Clear old Nr field + poll bit */
 		tx_skb->data[1] &= 0x0f;
 
@@ -1058,12 +1034,6 @@ void irlap_resend_rejected_frame(struct 
 		/* Unlink tx_skb from list */
 		tx_skb->next = tx_skb->prev = NULL;
 		tx_skb->list = NULL;
-
-		/*
-		 *  make sure the skb->sk accounting of memory usage is sane
-		 */
-		if (skb->sk != NULL)
-			skb_set_owner_w(tx_skb, skb->sk);
 
 		/* Clear old Nr field + poll bit */
 		tx_skb->data[1] &= 0x0f;

--ReaqsoxgOBHFXBhH--
