Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316113AbSHFUtm>; Tue, 6 Aug 2002 16:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315921AbSHFUs6>; Tue, 6 Aug 2002 16:48:58 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:11231 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S315919AbSHFUsb>;
	Tue, 6 Aug 2002 16:48:31 -0400
Date: Tue, 6 Aug 2002 13:52:08 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] : ir240_discovery_fixes.diff
Message-ID: <20020806205208.GE11677@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir240_discovery_fixes.diff :
--------------------------
	<Need to apply after ir240_trivial_fixes-3.diff to avoid "offset">
	o [FEATURE] Propagate mode of discovery to higher protocols
	o [CORRECT] Disable passive discovery in ircomm and irlan
	  Prevent client and server to simultaneously connect to each other
	o [CORRECT] Force expiry of discovery log on LAP disconnect


diff -u -p linux/include/net/irda/irlmp.d7.h linux/include/net/irda/irlmp.h
--- linux/include/net/irda/irlmp.d7.h	Thu Jun  6 16:17:02 2002
+++ linux/include/net/irda/irlmp.h	Thu Jun  6 16:20:02 2002
@@ -72,7 +72,7 @@ typedef enum {
 	S_END,
 } SERVICE;
 
-typedef void (*DISCOVERY_CALLBACK1) (discovery_t *, void *);
+typedef void (*DISCOVERY_CALLBACK1) (discovery_t *, DISCOVERY_MODE, void *);
 typedef void (*DISCOVERY_CALLBACK2) (hashbin_t *, void *);
 
 typedef struct {
@@ -214,7 +214,7 @@ void irlmp_disconnect_indication(struct 
 				 struct sk_buff *userdata);
 int  irlmp_disconnect_request(struct lsap_cb *, struct sk_buff *userdata);
 
-void irlmp_discovery_confirm(hashbin_t *discovery_log);
+void irlmp_discovery_confirm(hashbin_t *discovery_log, DISCOVERY_MODE);
 void irlmp_discovery_request(int nslots);
 struct irda_device_info *irlmp_get_discoveries(int *pn, __u16 mask, int nslots);
 void irlmp_do_expiry(void);
diff -u -p linux/include/net/irda/discovery.d7.h linux/include/net/irda/discovery.h
--- linux/include/net/irda/discovery.d7.h	Thu Jun  6 16:17:12 2002
+++ linux/include/net/irda/discovery.h	Thu Jun  6 16:20:02 2002
@@ -39,6 +39,14 @@
 #define DISCOVERY_EXPIRE_TIMEOUT 6*HZ
 #define DISCOVERY_DEFAULT_SLOTS  0
 
+/* Types of discovery */
+typedef enum {
+	DISCOVERY_LOG,		/* What's in our discovery log */
+	DISCOVERY_ACTIVE,	/* Doing our own discovery on the medium */
+	DISCOVERY_PASSIVE,	/* Peer doing discovery on the medium */
+	EXPIRY_TIMEOUT,		/* Entry expired due to timeout */
+} DISCOVERY_MODE;
+
 #define NICKNAME_MAX_LEN 21
 
 /*
diff -u -p linux/include/net/irda/irlan_client.d7.h linux/include/net/irda/irlan_client.h
--- linux/include/net/irda/irlan_client.d7.h	Thu Jun  6 16:17:26 2002
+++ linux/include/net/irda/irlan_client.h	Thu Jun  6 16:20:02 2002
@@ -34,7 +34,7 @@
 #include <net/irda/irlan_event.h>
 
 void irlan_client_start_kick_timer(struct irlan_cb *self, int timeout);
-void irlan_client_discovery_indication(discovery_t *, void *);
+void irlan_client_discovery_indication(discovery_t *, DISCOVERY_MODE, void *);
 void irlan_client_wakeup(struct irlan_cb *self, __u32 saddr, __u32 daddr);
 
 void irlan_client_open_ctrl_tsap( struct irlan_cb *self);
diff -u -p linux/net/irda/irlmp.d7.c linux/net/irda/irlmp.c
--- linux/net/irda/irlmp.d7.c	Thu Jun  6 16:17:48 2002
+++ linux/net/irda/irlmp.c	Thu Jun  6 16:20:02 2002
@@ -732,7 +732,9 @@ void irlmp_do_expiry()
 	 * On links which are connected, we can't do discovery
 	 * anymore and can't refresh the log, so we freeze the
 	 * discovery log to keep info about the device we are
-	 * connected to. - Jean II
+	 * connected to.
+	 * This info is mandatory if we want irlmp_connect_request()
+	 * to work properly. - Jean II
 	 */
 	lap = (struct lap_cb *) hashbin_get_first(irlmp->links);
 	while (lap != NULL) {
@@ -804,7 +806,7 @@ void irlmp_do_discovery(int nslots)
 void irlmp_discovery_request(int nslots)
 {
 	/* Return current cached discovery log */
-	irlmp_discovery_confirm(irlmp->cachelog);
+	irlmp_discovery_confirm(irlmp->cachelog, DISCOVERY_LOG);
 
 	/* 
 	 * Start a single discovery operation if discovery is not already
@@ -907,7 +909,8 @@ void irlmp_check_services(discovery_t *d
  * partial/selective discovery based on the hints that it passed to IrLMP.
  */
 static inline void
-irlmp_notify_client(irlmp_client_t *client, hashbin_t *log)
+irlmp_notify_client(irlmp_client_t *client,
+		    hashbin_t *log, DISCOVERY_MODE mode)
 {
 	discovery_t *discovery;
 
@@ -930,7 +933,7 @@ irlmp_notify_client(irlmp_client_t *clie
 		 * bits ;-)
 		 */
 		if (client->hint_mask & discovery->hints.word & 0x7f7f)
-			client->disco_callback(discovery, client->priv);
+			client->disco_callback(discovery, mode, client->priv);
 
 		discovery = (discovery_t *) hashbin_get_next(log);
 	}
@@ -943,7 +946,7 @@ irlmp_notify_client(irlmp_client_t *clie
  *    device it is, and give indication to the client(s)
  * 
  */
-void irlmp_discovery_confirm(hashbin_t *log) 
+void irlmp_discovery_confirm(hashbin_t *log, DISCOVERY_MODE mode) 
 {
 	irlmp_client_t *client;
 	
@@ -957,7 +960,7 @@ void irlmp_discovery_confirm(hashbin_t *
 	client = (irlmp_client_t *) hashbin_get_first(irlmp->clients);
 	while (client != NULL) {
 		/* Check if we should notify client */
-		irlmp_notify_client(client, log);
+		irlmp_notify_client(client, log, mode);
 			
 		client = (irlmp_client_t *) hashbin_get_next(irlmp->clients);
 	}
@@ -987,7 +990,8 @@ void irlmp_discovery_expiry(discovery_t 
 		/* Check if we should notify client */
 		if ((client->expir_callback) &&
 		    (client->hint_mask & expiry->hints.word & 0x7f7f))
-			client->expir_callback(expiry, client->priv);
+			client->expir_callback(expiry, EXPIRY_TIMEOUT,
+					       client->priv);
 
 		/* Next client */
 		client = (irlmp_client_t *) hashbin_get_next(irlmp->clients);
diff -u -p linux/net/irda/irlmp_frame.d7.c linux/net/irda/irlmp_frame.c
--- linux/net/irda/irlmp_frame.d7.c	Thu Jun  6 16:18:05 2002
+++ linux/net/irda/irlmp_frame.c	Thu Jun  6 16:20:02 2002
@@ -378,7 +378,7 @@ void irlmp_link_discovery_indication(str
 	
 	/* Just handle it the same way as a discovery confirm,
 	 * bypass the LM_LAP state machine (see below) */
-	irlmp_discovery_confirm(irlmp->cachelog);
+	irlmp_discovery_confirm(irlmp->cachelog, DISCOVERY_PASSIVE);
 }
 
 /*
@@ -404,7 +404,7 @@ void irlmp_link_discovery_confirm(struct
 	 *	2) It doesn't affect the LM_LAP state
 	 *	3) Faster, slimer, simpler, ...
 	 * Jean II */
-	irlmp_discovery_confirm(irlmp->cachelog);
+	irlmp_discovery_confirm(irlmp->cachelog, DISCOVERY_ACTIVE);
 }
 
 #ifdef CONFIG_IRDA_CACHE_LAST_LSAP
diff -u -p linux/net/irda/irlmp_event.d7.c linux/net/irda/irlmp_event.c
--- linux/net/irda/irlmp_event.d7.c	Thu Jun  6 16:18:13 2002
+++ linux/net/irda/irlmp_event.c	Thu Jun  6 16:20:02 2002
@@ -459,6 +459,15 @@ static void irlmp_state_active(struct la
 					    LM_LAP_DISCONNECT_INDICATION,
 					    NULL);
 		}
+
+		/* Force an expiry of the discovery log.
+		 * Now that the LAP is free, the system may attempt to
+		 * connect to another device. Unfortunately, our entries
+		 * are stale. There is a small window (<3s) before the
+		 * normal discovery will run and where irlmp_connect_request()
+		 * can get the wrong info, so make sure things get
+		 * cleaned *NOW* ;-) - Jean II */
+		irlmp_do_expiry();
 		break;
 	default:
 		IRDA_DEBUG(0, __FUNCTION__ "(), Unknown event %s\n",
diff -u -p linux/net/irda/af_irda.d7.c linux/net/irda/af_irda.c
--- linux/net/irda/af_irda.d7.c	Thu Jun  6 16:18:24 2002
+++ linux/net/irda/af_irda.c	Thu Jun  6 16:20:02 2002
@@ -414,6 +414,7 @@ static void irda_getvalue_confirm(int re
  * hint bits), and then wake up any process waiting for answer...
  */
 static void irda_selective_discovery_indication(discovery_t *discovery,
+						DISCOVERY_MODE mode,
 						void *priv)
 {
 	struct irda_sock *self;
diff -u -p linux/net/irda/ircomm/ircomm_tty_attach.d7.c linux/net/irda/ircomm/ircomm_tty_attach.c
--- linux/net/irda/ircomm/ircomm_tty_attach.d7.c	Thu Jun  6 16:18:44 2002
+++ linux/net/irda/ircomm/ircomm_tty_attach.c	Thu Jun  6 16:20:02 2002
@@ -47,6 +47,7 @@
 
 static void ircomm_tty_ias_register(struct ircomm_tty_cb *self);
 static void ircomm_tty_discovery_indication(discovery_t *discovery,
+					    DISCOVERY_MODE mode,
 					    void *priv);
 static void ircomm_tty_getvalue_confirm(int result, __u16 obj_id, 
 					struct ias_value *value, void *priv);
@@ -305,12 +306,27 @@ int ircomm_tty_send_initial_parameters(s
  *
  */
 static void ircomm_tty_discovery_indication(discovery_t *discovery,
+					    DISCOVERY_MODE mode,
 					    void *priv)
 {
 	struct ircomm_tty_cb *self;
 	struct ircomm_tty_info info;
 
 	IRDA_DEBUG(2, __FUNCTION__"()\n");
+
+	/* Important note :
+	 * We need to drop all passive discoveries.
+	 * The LSAP management of IrComm is deficient and doesn't deal
+	 * with the case of two instance connecting to each other
+	 * simultaneously (it will deadlock in LMP).
+	 * The proper fix would be to use the same technique as in IrNET,
+	 * to have one server socket and separate instances for the
+	 * connecting/connected socket.
+	 * The workaround is to drop passive discovery, which drastically
+	 * reduce the probability of this happening.
+	 * Jean II */
+	if(mode == DISCOVERY_PASSIVE)
+		return;
 
 	info.daddr = discovery->daddr;
 	info.saddr = discovery->saddr;
diff -u -p linux/net/irda/irlan/irlan_client.d7.c linux/net/irda/irlan/irlan_client.c
--- linux/net/irda/irlan/irlan_client.d7.c	Thu Jun  6 16:19:08 2002
+++ linux/net/irda/irlan/irlan_client.c	Thu Jun  6 16:20:02 2002
@@ -145,7 +145,9 @@ void irlan_client_wakeup(struct irlan_cb
  *    Remote device with IrLAN server support discovered
  *
  */
-void irlan_client_discovery_indication(discovery_t *discovery, void *priv) 
+void irlan_client_discovery_indication(discovery_t *discovery,
+				       DISCOVERY_MODE mode,
+				       void *priv) 
 {
 	struct irlan_cb *self;
 	__u32 saddr, daddr;
@@ -154,6 +156,15 @@ void irlan_client_discovery_indication(d
 
 	ASSERT(irlan != NULL, return;);
 	ASSERT(discovery != NULL, return;);
+
+	/*
+	 * I didn't check it, but I bet that IrLAN suffer from the same
+	 * deficiency as IrComm and doesn't handle two instances
+	 * simultaneously connecting to each other.
+	 * Same workaround, drop passive discoveries.
+	 * Jean II */
+	if(mode == DISCOVERY_PASSIVE)
+		return;
 
 	saddr = discovery->saddr;
 	daddr = discovery->daddr;
diff -u -p linux/net/irda/irnet/irnet_irda.d7.h linux/net/irda/irnet/irnet_irda.h
--- linux/net/irda/irnet/irnet_irda.d7.h	Thu Jun  6 16:19:36 2002
+++ linux/net/irda/irnet/irnet_irda.h	Thu Jun  6 16:20:02 2002
@@ -151,9 +151,11 @@ static void
 #ifdef DISCOVERY_EVENTS
 static void
 	irnet_discovery_indication(discovery_t *,
+				   DISCOVERY_MODE,
 				   void *);
 static void
 	irnet_expiry_indication(discovery_t *,
+				DISCOVERY_MODE,
 				void *);
 #endif
 /* -------------------------- PROC ENTRY -------------------------- */
diff -u -p linux/net/irda/irnet/irnet_irda.d7.c linux/net/irda/irnet/irnet_irda.c
--- linux/net/irda/irnet/irnet_irda.d7.c	Thu Jun  6 16:19:46 2002
+++ linux/net/irda/irnet/irnet_irda.c	Thu Jun  6 16:20:02 2002
@@ -1599,8 +1599,9 @@ irnet_discovervalue_confirm(int		result,
  * is to messy, so we leave that to user space...
  */
 static void
-irnet_discovery_indication(discovery_t *discovery,
-			   void *	priv)
+irnet_discovery_indication(discovery_t *	discovery,
+			   DISCOVERY_MODE	mode,
+			   void *		priv)
 {
   irnet_socket *	self = &irnet_server.s;
 	
@@ -1638,6 +1639,7 @@ irnet_discovery_indication(discovery_t *
  */
 static void
 irnet_expiry_indication(discovery_t *	expiry,
+			DISCOVERY_MODE	mode,
 			void *		priv)
 {
   irnet_socket *	self = &irnet_server.s;
