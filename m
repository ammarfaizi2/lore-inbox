Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbQKKVfI>; Sat, 11 Nov 2000 16:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129092AbQKKVe6>; Sat, 11 Nov 2000 16:34:58 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:57609 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S129055AbQKKVey>; Sat, 11 Nov 2000 16:34:54 -0500
Date: Sat, 11 Nov 2000 21:35:55 GMT
Message-Id: <200011112135.VAA32693@tepid.osl.fast.no>
Subject: [patch] patch-2.4.0-test10-irda20 (was: Re: The IrDA patches)
X-Mailer: Pygmy (v0.4.4pre)
Subject: [patch] patch-2.4.0-test10-irda20 (was: Re: The IrDA patches)
Cc: linux-kernel@vger.kernel.org
From: Dag Brattli <dagb@fast.no>
To: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here are the new IrDA patches for Linux-2.4.0-test10. Please apply them to
your latest 2.4 code. If you decide to apply them, then I suggest you start
with the first one (irda1.diff) and work your way to the last one 
(irda24.diff) since most of them are not commutative. 

The name of this patch is irda20.diff. 

(Many thanks to Jean Tourrilhes for splitting up the big patch)

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash
[OUPS   ] : Error that will be fixed in a later patch

irda20.diff :
-----------------
	o [CORRECT] Close up LMP socket when receive a disconnect
	o [FEATURE] Cleanups

diff -urpN old-linux/net/irda/af_irda.c linux/net/irda/af_irda.c
--- old-linux/net/irda/af_irda.c	Thu Nov  9 17:41:49 2000
+++ linux/net/irda/af_irda.c	Thu Nov  9 17:55:35 2000
@@ -114,7 +114,7 @@ static int irda_data_indication(void *in
 /*
  * Function irda_disconnect_indication (instance, sap, reason, skb)
  *
- *    Connection has been closed. Chech reason to find out why
+ *    Connection has been closed. Check reason to find out why
  *
  */
 static void irda_disconnect_indication(void *instance, void *sap, 
@@ -138,6 +138,27 @@ static void irda_disconnect_indication(v
 		sk->state_change(sk);
                 sk->dead = 1;
         }
+
+	/* Close our TSAP.
+	 * If we leave it open, IrLMP put it back into the list of
+	 * unconnected LSAPs. The problem is that any incomming request
+	 * can then be matched to this socket (and it will be, because
+	 * it is at the head of the list). This would prevent any
+	 * listening socket waiting on the same TSAP to get those requests.
+	 * Some apps forget to close sockets, or hang to it a bit too long,
+	 * so we may stay in this dead state long enough to be noticed...
+	 * Note : all socket function do check sk->state, so we are safe...
+	 * Jean II
+	 */
+	irttp_close_tsap(self->tsap);
+	self->tsap = NULL;
+
+	/* Note : once we are there, there is not much you want to do
+	 * with the socket anymore, apart from closing it.
+	 * For example, bind() and connect() won't reset sk->err,
+	 * sk->shutdown and sk->dead to valid values...
+	 * Jean II
+	 */
 }
 
 /*
@@ -1126,11 +1147,15 @@ void irda_destroy_socket(struct irda_soc
 	irlmp_unregister_service(self->skey);
 
 	/* Unregister with LM-IAS */
-	if (self->ias_obj)
+	if (self->ias_obj) {
 		irias_delete_object(self->ias_obj);
+		self->ias_obj = NULL;
+	}
 
-	if (self->iriap) 
+	if (self->iriap) {
 		iriap_close(self->iriap);
+		self->iriap = NULL;
+	}
 
 	if (self->tsap) {
 		irttp_disconnect_request(self->tsap, NULL, P_NORMAL);
@@ -1576,9 +1601,11 @@ static int irda_shutdown(struct socket *
 	sk->shutdown   |= SEND_SHUTDOWN;
 	sk->state_change(sk);
 
-	if (self->iriap) 
+	if (self->iriap) {
 		iriap_close(self->iriap);
-	
+		self->iriap = NULL;
+	}
+
 	if (self->tsap) {
 		irttp_disconnect_request(self->tsap, NULL, P_NORMAL);
 		irttp_close_tsap(self->tsap);
diff -urpN old-linux/net/irda/irlmp.c linux/net/irda/irlmp.c
--- old-linux/net/irda/irlmp.c	Thu Nov  9 17:52:56 2000
+++ linux/net/irda/irlmp.c	Thu Nov  9 17:55:35 2000
@@ -284,7 +284,7 @@ void irlmp_register_link(struct irlap_cb
 	init_timer(&lap->idle_timer);
 
 	/*
-	 *  Insert into queue of unconnected LSAPs
+	 *  Insert into queue of LMP links
 	 */
 	hashbin_insert(irlmp->links, (irda_queue_t *) lap, lap->saddr, NULL);
 
diff -urpN old-linux/net/irda/irlmp_frame.c linux/net/irda/irlmp_frame.c
--- old-linux/net/irda/irlmp_frame.c	Thu Nov  9 17:39:46 2000
+++ linux/net/irda/irlmp_frame.c	Thu Nov  9 17:55:35 2000
@@ -127,9 +127,11 @@ void irlmp_link_data_indication(struct l
 				       irlmp->unconnected_lsaps);
 		
 		/* Maybe LSAP was already connected, so try one more time */
-		if (!lsap)
+		if (!lsap) {
+			IRDA_DEBUG(1, __FUNCTION__ "(), incoming connection for LSAP already connected\n");
 			lsap = irlmp_find_lsap(self, dlsap_sel, slsap_sel, 0,
 					       self->lsaps);
+		}
 	} else
 		lsap = irlmp_find_lsap(self, dlsap_sel, slsap_sel, 0, 
 				       self->lsaps);


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
