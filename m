Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129220AbQKKV2s>; Sat, 11 Nov 2000 16:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129245AbQKKV2i>; Sat, 11 Nov 2000 16:28:38 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:51465 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S129225AbQKKV2a>; Sat, 11 Nov 2000 16:28:30 -0500
Date: Sat, 11 Nov 2000 21:29:27 GMT
Message-Id: <200011112129.VAA32516@tepid.osl.fast.no>
Subject: [patch] patch-2.4.0-test10-irda17 (was: Re: The IrDA patches)
X-Mailer: Pygmy (v0.4.4pre)
Subject: [patch] patch-2.4.0-test10-irda17 (was: Re: The IrDA patches)
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

The name of this patch is irda17.diff. 

(Many thanks to Jean Tourrilhes for splitting up the big patch)

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash
[OUPS   ] : Error that will be fixed in a later patch

irda17.diff :
-----------------
	o [FEATURE] Removed unused discovery callback
	o [FEATURE] Give discovery and expery callback meaningful names

diff -urpN old-linux/include/net/irda/irlmp.h linux/include/net/irda/irlmp.h
--- old-linux/include/net/irda/irlmp.h	Thu Nov  9 17:39:46 2000
+++ linux/include/net/irda/irlmp.h	Thu Nov  9 17:40:01 2000
@@ -85,9 +85,8 @@ typedef struct {
 
 	__u16 hint_mask;
 
-	DISCOVERY_CALLBACK1 callback1;		/* Selective discovery */
-	DISCOVERY_CALLBACK2 callback2;		/* Whole discovery */
-	DISCOVERY_CALLBACK1 callback3;		/* Selective expiration */
+	DISCOVERY_CALLBACK1 disco_callback;	/* Selective discovery */
+	DISCOVERY_CALLBACK1 expir_callback;	/* Selective expiration */
 	void *priv;                /* Used to identify client */
 } irlmp_client_t;
 
@@ -193,14 +192,12 @@ void irlmp_close_lsap( struct lsap_cb *s
 __u16 irlmp_service_to_hint(int service);
 __u32 irlmp_register_service(__u16 hints);
 int irlmp_unregister_service(__u32 handle);
-__u32 irlmp_register_client(__u16 hint_mask, DISCOVERY_CALLBACK1 callback1,
-			    DISCOVERY_CALLBACK2 callback2,
-			    DISCOVERY_CALLBACK1 callback3, void *priv);
+__u32 irlmp_register_client(__u16 hint_mask, DISCOVERY_CALLBACK1 disco_clb,
+			    DISCOVERY_CALLBACK1 expir_clb, void *priv);
 int irlmp_unregister_client(__u32 handle);
 int irlmp_update_client(__u32 handle, __u16 hint_mask, 
-			DISCOVERY_CALLBACK1 callback1,
-			DISCOVERY_CALLBACK2 callback2,
-			DISCOVERY_CALLBACK1 callback3, void *priv);
+			DISCOVERY_CALLBACK1 disco_clb,
+			DISCOVERY_CALLBACK1 expir_clb, void *priv);
 
 void irlmp_register_link(struct irlap_cb *, __u32 saddr, notify_t *);
 void irlmp_unregister_link(__u32 saddr);
diff -urpN old-linux/net/irda/af_irda.c linux/net/irda/af_irda.c
--- old-linux/net/irda/af_irda.c	Thu Nov  9 17:39:46 2000
+++ linux/net/irda/af_irda.c	Thu Nov  9 17:40:01 2000
@@ -1096,7 +1096,7 @@ static int irda_create(struct socket *so
 	sk->protocol = protocol;
 
 	/* Register as a client with IrLMP */
-	self->ckey = irlmp_register_client(0, NULL, NULL, NULL, NULL);
+	self->ckey = irlmp_register_client(0, NULL, NULL, NULL);
 	self->mask = 0xffff;
 	self->rx_flow = self->tx_flow = FLOW_START;
 	self->nslots = DISCOVERY_DEFAULT_SLOTS;
@@ -2147,7 +2147,7 @@ static int irda_getsockopt(struct socket
 
 		/* Tell IrLMP we want to be notified */
 		irlmp_update_client(self->ckey, self->mask,
-				    irda_selective_discovery_indication, NULL,
+				    irda_selective_discovery_indication,
 				    NULL, (void *) self);
 		
 		/* Do some discovery (and also return cached results) */
@@ -2179,8 +2179,7 @@ static int irda_getsockopt(struct socket
 				   "(), found immediately !\n");
 
 		/* Tell IrLMP that we have been notified */
-		irlmp_update_client(self->ckey, self->mask, NULL, NULL,
-				    NULL, NULL);
+		irlmp_update_client(self->ckey, self->mask, NULL, NULL, NULL);
 
 		/* Check if the we got some results */
 		if (!self->cachediscovery)
diff -urpN old-linux/net/irda/ircomm/ircomm_tty_attach.c linux/net/irda/ircomm/ircomm_tty_attach.c
--- old-linux/net/irda/ircomm/ircomm_tty_attach.c	Thu Nov  9 17:39:46 2000
+++ linux/net/irda/ircomm/ircomm_tty_attach.c	Thu Nov  9 17:39:55 2000
@@ -236,8 +236,7 @@ static void ircomm_tty_ias_register(stru
 	}
 	self->skey = irlmp_register_service(hints);
 	self->ckey = irlmp_register_client(
-		hints, ircomm_tty_discovery_indication, NULL, NULL,
-		(void *) self);
+		hints, ircomm_tty_discovery_indication, NULL, (void *) self);
 }
 
 /*
diff -urpN old-linux/net/irda/irlan/irlan_common.c linux/net/irda/irlan/irlan_common.c
--- old-linux/net/irda/irlan/irlan_common.c	Thu Nov  9 17:39:46 2000
+++ linux/net/irda/irlan/irlan_common.c	Thu Nov  9 17:39:55 2000
@@ -137,7 +137,7 @@ int __init irlan_init(void)
 
 	/* Register with IrLMP as a client */
 	ckey = irlmp_register_client(hints, irlan_client_discovery_indication,
-				     NULL, NULL, NULL);
+				     NULL, NULL);
 	
 	/* Register with IrLMP as a service */
  	skey = irlmp_register_service(hints);
diff -urpN old-linux/net/irda/irlmp.c linux/net/irda/irlmp.c
--- old-linux/net/irda/irlmp.c	Thu Nov  9 17:39:46 2000
+++ linux/net/irda/irlmp.c	Thu Nov  9 17:40:01 2000
@@ -837,22 +837,18 @@ void irlmp_check_services(discovery_t *d
  *	o IrComm
  *	o IrLAN
  *	o Any socket (in any state - ouch, that may be a lot !)
- * The client may have defined one of two callback to be notified in case
- * of discovery, one callback for any discovery and one for partial/selective
- * discovery based on the hints that it passed to IrLMP.
+ * The client may have defined a callback to be notified in case of
+ * partial/selective discovery based on the hints that it passed to IrLMP.
  */
-void irlmp_notify_client(irlmp_client_t *client, hashbin_t *log)
+static inline void
+irlmp_notify_client(irlmp_client_t *client, hashbin_t *log)
 {
 	discovery_t *discovery;
 
 	IRDA_DEBUG(3, __FUNCTION__ "()\n");
 	
-	/* Check if client wants the whole log */
-	if (client->callback2)
-		client->callback2(log, client->priv);
-	
 	/* Check if client wants or not partial/selective log (optimisation) */
-	if (!client->callback1)
+	if (!client->disco_callback)
 		return;
 
 	/* 
@@ -867,10 +863,9 @@ void irlmp_notify_client(irlmp_client_t 
 		 * Any common hint bits? Remember to mask away the extension
 		 * bits ;-)
 		 */
-		if (client->hint_mask & discovery->hints.word & 0x7f7f) {
-			if (client->callback1)
-				client->callback1(discovery, client->priv);
-		}
+		if (client->hint_mask & discovery->hints.word & 0x7f7f)
+			client->disco_callback(discovery, client->priv);
+
 		discovery = (discovery_t *) hashbin_get_next(log);
 	}
 }
@@ -924,9 +919,9 @@ void irlmp_discovery_expiry(discovery_t 
 	client = (irlmp_client_t *) hashbin_get_first(irlmp->clients);
 	while (client != NULL) {
 		/* Check if we should notify client */
-		if ((client->callback3) &&
+		if ((client->expir_callback) &&
 		    (client->hint_mask & expiry->hints.word & 0x7f7f))
-			client->callback3(expiry, client->priv);
+			client->expir_callback(expiry, client->priv);
 
 		/* Next client */
 		client = (irlmp_client_t *) hashbin_get_next(irlmp->clients);
@@ -1326,14 +1321,12 @@ int irlmp_unregister_service(__u32 handl
  *
  *    Register a local client with IrLMP
  *	First callback is selective discovery (based on hints)
- *	Second callback is for the whole discovery log
- *	Third callback is for selective discovery expiries
+ *	Second callback is for selective discovery expiries
  *
  *    Returns: handle > 0 on success, 0 on error
  */
-__u32 irlmp_register_client(__u16 hint_mask, DISCOVERY_CALLBACK1 callback1,
-			    DISCOVERY_CALLBACK2 callback2,
-			    DISCOVERY_CALLBACK1 callback3, void *priv)
+__u32 irlmp_register_client(__u16 hint_mask, DISCOVERY_CALLBACK1 disco_clb,
+			    DISCOVERY_CALLBACK1 expir_clb, void *priv)
 {
 	irlmp_client_t *client;
 	__u32 handle;
@@ -1353,9 +1346,8 @@ __u32 irlmp_register_client(__u16 hint_m
 
 	/* Register the details */
 	client->hint_mask = hint_mask;
-	client->callback1 = callback1;
-	client->callback2 = callback2;
-	client->callback3 = callback3;
+	client->disco_callback = disco_clb;
+	client->expir_callback = expir_clb;
 	client->priv = priv;
 
  	hashbin_insert(irlmp->clients, (irda_queue_t *) client, handle, NULL);
@@ -1372,9 +1364,8 @@ __u32 irlmp_register_client(__u16 hint_m
  *    Returns: 0 on success, -1 on error
  */
 int irlmp_update_client(__u32 handle, __u16 hint_mask, 
-			DISCOVERY_CALLBACK1 callback1, 
-			DISCOVERY_CALLBACK2 callback2,
-			DISCOVERY_CALLBACK1 callback3, void *priv)
+			DISCOVERY_CALLBACK1 disco_clb, 
+			DISCOVERY_CALLBACK1 expir_clb, void *priv)
 {
 	irlmp_client_t *client;
 
@@ -1388,9 +1379,8 @@ int irlmp_update_client(__u32 handle, __
 	}
 
 	client->hint_mask = hint_mask;
-	client->callback1 = callback1;
-	client->callback2 = callback2;
-	client->callback3 = callback3;
+	client->disco_callback = disco_clb;
+	client->expir_callback = expir_clb;
 	client->priv = priv;
 	
 	return 0;


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
