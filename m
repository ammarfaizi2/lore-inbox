Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283787AbRK3U6q>; Fri, 30 Nov 2001 15:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283783AbRK3U5Y>; Fri, 30 Nov 2001 15:57:24 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:38083 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S283737AbRK3U5L>;
	Fri, 30 Nov 2001 15:57:11 -0500
Date: Fri, 30 Nov 2001 12:57:05 -0800
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-irda@pasta.cs.uit.no
Subject: [PATCH] : ir245_clean_listen.diff
Message-ID: <20011130125705.E3938@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir245_clean_listen.diff :
-----------------------
	o [FEATURE] Put the code to set the socket back to listen mode in
	  common functions instead of cut'n'pasted all over the place.
	o [CRITICA] When setting a socket back to listen mode, set
	  self->tsap->lsap->lap = NULL; to avoid crashing is LAP is
	  removed before the socket.
	o [CORRECT] Fix disconnect event generation. Doh !

diff -u -p linux/include/net/irda/irlmp.d3.h linux/include/net/irda/irlmp.h
--- linux/include/net/irda/irlmp.d3.h	Thu Nov 29 10:33:26 2001
+++ linux/include/net/irda/irlmp.h	Thu Nov 29 11:04:59 2001
@@ -264,4 +264,16 @@ static inline int irlmp_get_lap_tx_queue
 	return IRLAP_GET_TX_QUEUE_LEN(self->lap->irlap);
 }
 
+/* After doing a irlmp_dup(), this get one of the two socket back into
+ * a state where it's waiting incomming connections.
+ * Note : this can be used *only* if the socket is not yet connected
+ * (i.e. NO irlmp_connect_response() done on this socket).
+ * - Jean II */
+static inline void irlmp_listen(struct lsap_cb *self)
+{
+	self->dlsap_sel = LSAP_ANY;
+	self->lap = NULL;
+	self->lsap_state = LSAP_DISCONNECTED;
+}
+
 #endif
diff -u -p linux/include/net/irda/irttp.d3.h linux/include/net/irda/irttp.h
--- linux/include/net/irda/irttp.d3.h	Thu Nov 29 11:02:29 2001
+++ linux/include/net/irda/irttp.h	Thu Nov 29 11:10:51 2001
@@ -148,6 +148,17 @@ static __inline __u32 irttp_get_max_seg_
 	return self->max_seg_size;
 }
 
+/* After doing a irttp_dup(), this get one of the two socket back into
+ * a state where it's waiting incomming connections.
+ * Note : this can be used *only* if the socket is not yet connected
+ * (i.e. NO irttp_connect_response() done on this socket).
+ * - Jean II */
+static inline void irttp_listen(struct tsap_cb *self)
+{
+	irlmp_listen(self->lsap);
+	self->dtsap_sel = LSAP_ANY;
+}
+
 extern struct irttp_cb *irttp;
 
 #endif /* IRTTP_H */
diff -u -p linux/net/irda/irlmp.d3.c linux/net/irda/irlmp.c
--- linux/net/irda/irlmp.d3.c	Tue Nov 20 11:21:44 2001
+++ linux/net/irda/irlmp.c	Thu Nov 29 10:57:04 2001
@@ -469,7 +469,12 @@ void irlmp_connect_indication(struct lsa
 
 	IRDA_DEBUG(2, __FUNCTION__ "(), slsap_sel=%02x, dlsap_sel=%02x\n", 
 		   self->slsap_sel, self->dlsap_sel);
-	
+
+	/* Note : self->lap is set in irlmp_link_data_indication(),
+	 * (case CONNECT_CMD:) because we have no way to set it here.
+	 * Similarly, self->dlsap_sel is usually set in irlmp_find_lsap().
+	 * Jean II */
+
 	self->qos = *self->lap->qos;
 
 	max_seg_size = self->lap->qos->data_size.value-LMP_HEADER;
@@ -577,7 +582,9 @@ struct lsap_cb *irlmp_dup(struct lsap_cb
 	/* Dup */
 	memcpy(new, orig, sizeof(struct lsap_cb));
 	new->notify.instance = instance;
-	
+	/* new->lap = orig->lap; => done in the memcpy() */
+	/* new->slsap_sel = orig->slsap_sel; => done in the memcpy() */
+
 	init_timer(&new->watchdog_timer);
 	
 	hashbin_insert(irlmp->unconnected_lsaps, (irda_queue_t *) new, (int) new, 
diff -u -p linux/net/irda/iriap.d3.c linux/net/irda/iriap.c
--- linux/net/irda/iriap.d3.c	Thu Nov 29 11:12:55 2001
+++ linux/net/irda/iriap.c	Thu Nov 29 11:13:25 2001
@@ -800,9 +800,7 @@ static void iriap_connect_indication(voi
 	new->max_header_size = max_header_size;
 
 	/* Clean up the original one to keep it in listen state */
-	self->lsap->dlsap_sel = LSAP_ANY;
-	self->lsap->lsap_state = LSAP_DISCONNECTED;
-	/* FIXME: refcount in irlmp might get wrong */
+	irlmp_listen(self->lsap);
 	
 	iriap_do_server_event(new, IAP_LM_CONNECT_INDICATION, userdata);
 }
diff -u -p linux/net/irda/af_irda.d3b.c linux/net/irda/af_irda.c
--- linux/net/irda/af_irda.d3b.c	Thu Nov 29 11:09:09 2001
+++ linux/net/irda/af_irda.c	Thu Nov 29 11:09:36 2001
@@ -914,8 +914,7 @@ static int irda_accept(struct socket *so
 	memcpy(&new->qos_tx, &self->qos_tx, sizeof(struct qos_info));
 
 	/* Clean up the original one to keep it in listen state */
-	self->tsap->dtsap_sel = self->tsap->lsap->dlsap_sel = LSAP_ANY;
-	self->tsap->lsap->lsap_state = LSAP_DISCONNECTED;
+	irttp_listen(self->tsap);
 
 	skb->sk = NULL;
 	skb->destructor = NULL;
diff -u -p linux/net/irda/irnet/irnet.d3.h linux/net/irda/irnet/irnet.h
--- linux/net/irda/irnet/irnet.d3.h	Wed Nov 28 10:15:54 2001
+++ linux/net/irda/irnet/irnet.h	Thu Nov 29 11:15:57 2001
@@ -199,6 +199,13 @@
  *	o Avoid leaking discovery log and skb
  *	o Replace "self" with "server" in irnet_connect_indication() to
  *	  better detect cut'n'paste error ;-)
+ *
+ * v9 - 29.11.01 - Jean II
+ *	o Fix event generation in disconnect indication that I broke in v8
+ *	  It was always generation "No-Answer" because I was testing ttp_open
+ *	  just after clearing it. *blush*.
+ *	o Use newly created irttp_listen() to fix potential crash when LAP
+ *	  destroyed before irnet module removed.
  */
 
 /***************************** INCLUDES *****************************/
diff -u -p linux/net/irda/irnet/irnet_irda.d3.c linux/net/irda/irnet/irnet_irda.c
--- linux/net/irda/irnet/irnet_irda.d3.c	Tue Nov 27 16:19:28 2001
+++ linux/net/irda/irnet/irnet_irda.c	Thu Nov 29 11:50:00 2001
@@ -830,8 +830,7 @@ irnet_connect_socket(irnet_socket *	serv
 #endif /* STREAM_COMPAT */
 
   /* Clean up the original one to keep it in listen state */
-  server->tsap->dtsap_sel = server->tsap->lsap->dlsap_sel = LSAP_ANY;
-  server->tsap->lsap->lsap_state = LSAP_DISCONNECTED;
+  irttp_listen(server->tsap);
 
   /* Send a connection response on the new socket */
   irttp_connect_response(new->tsap, new->max_sdu_size_rx, NULL);
@@ -897,8 +896,7 @@ irnet_disconnect_server(irnet_socket *	s
 		   self->saddr, self->daddr, self->rname);
 
   /* Clean up the server to keep it in listen state */
-  self->tsap->dtsap_sel = self->tsap->lsap->dlsap_sel = LSAP_ANY;
-  self->tsap->lsap->lsap_state = LSAP_DISCONNECTED;
+  irttp_listen(self->tsap);
 
   DEXIT(IRDA_SERV_TRACE, "\n");
   return;
@@ -1081,7 +1079,8 @@ irnet_disconnect_indication(void *	insta
 			    struct sk_buff *skb)
 {
   irnet_socket *	self = (irnet_socket *) instance;
-  int			test = 0;
+  int			test_open;
+  int			test_connect;
 
   DENTER(IRDA_TCB_TRACE, "(self=0x%X)\n", (unsigned int) self);
   DASSERT(self != NULL, , IRDA_CB_ERROR, "Self is NULL !!!\n");
@@ -1091,23 +1090,23 @@ irnet_disconnect_indication(void *	insta
     dev_kfree_skb(skb);
 
   /* Prevent higher layer from accessing IrTTP */
-  test = test_and_clear_bit(0, &self->ttp_open);
+  test_open = test_and_clear_bit(0, &self->ttp_open);
   /* Not connecting anymore...
    * (note : TSAP is open, so IAP callbacks are no longer pending...) */
-  test |= test_and_clear_bit(0, &self->ttp_connect);
+  test_connect = test_and_clear_bit(0, &self->ttp_connect);
 
   /* If both self->ttp_open and self->ttp_connect are NULL, it mean that we
    * have a race condition with irda_irnet_destroy() or
    * irnet_connect_indication(), so don't mess up tsap...
    */
-  if(!test)
+  if(!(test_open || test_connect))
     {
       DERROR(IRDA_CB_ERROR, "Race condition detected...\n");
       return;
     }
 
   /* If we were active, notify the control channel */
-  if(test_bit(0, &self->ttp_open))
+  if(test_open)
     irnet_post_event(self, IRNET_DISCONNECT_FROM,
 		     self->saddr, self->daddr, self->rname);
   else
