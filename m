Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270214AbUJTBYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270214AbUJTBYn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 21:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270290AbUJTBYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 21:24:15 -0400
Received: from palrel13.hp.com ([156.153.255.238]:39601 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S270214AbUJTBFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 21:05:33 -0400
Date: Tue, 19 Oct 2004 18:05:32 -0700
To: "David S. Miller" <davem@davemloft.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] IrCOMM IAS object fix
Message-ID: <20041020010532.GG12932@bougret.hpl.hp.com>
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

ir269_ircomm_ias_fix-1.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [CORRECT] Restore properly the IAS object when IrCOMM disconnect.
	Allow "pppd passive persist" to work properly.
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>


diff -u -p linux/include/net/irda/ircomm_tty_attach.d0.h linux/include/net/irda/ircomm_tty_attach.h
--- linux/include/net/irda/ircomm_tty_attach.d0.h	Tue Sep 21 12:17:22 2004
+++ linux/include/net/irda/ircomm_tty_attach.h	Tue Sep 21 12:17:35 2004
@@ -72,7 +72,6 @@ extern char *ircomm_tty_state[];
 
 int ircomm_tty_do_event(struct ircomm_tty_cb *self, IRCOMM_TTY_EVENT event,
 			struct sk_buff *skb, struct ircomm_tty_info *info);
-void ircomm_tty_next_state(struct ircomm_tty_cb *self, IRCOMM_TTY_STATE state);
 
 
 int  ircomm_tty_attach_cable(struct ircomm_tty_cb *self);
diff -u -p linux/net/irda/ircomm/ircomm_tty_attach.d0.c linux/net/irda/ircomm/ircomm_tty_attach.c
--- linux/net/irda/ircomm/ircomm_tty_attach.d0.c	Tue Sep 21 11:13:31 2004
+++ linux/net/irda/ircomm/ircomm_tty_attach.c	Tue Sep 21 14:39:11 2004
@@ -143,12 +143,6 @@ int ircomm_tty_attach_cable(struct ircom
 
 	ircomm_tty_ias_register(self);
 
-	/* Check if somebody has already connected to us */
-	if (ircomm_is_connected(self->ircomm)) {
-		IRDA_DEBUG(0, "%s(), already connected!\n", __FUNCTION__ );
-		return 0;
-	}
-
 	ircomm_tty_do_event(self, IRCOMM_TTY_ATTACH_CABLE, NULL, NULL);
 
 	return 0;
@@ -169,9 +163,16 @@ void ircomm_tty_detach_cable(struct irco
 
 	del_timer(&self->watchdog_timer);
 
+	/* Remove discovery handler */
+	if (self->ckey) {
+		irlmp_unregister_client(self->ckey);
+		self->ckey = NULL;
+	}
 	/* Remove IrCOMM hint bits */
-	irlmp_unregister_client(self->ckey);
-	irlmp_unregister_service(self->skey);
+	if (self->skey) {
+		irlmp_unregister_service(self->skey);
+		self->skey = NULL;
+	}
 
 	if (self->iriap) { 
 		iriap_close(self->iriap);
@@ -209,18 +210,30 @@ static void ircomm_tty_ias_register(stru
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
 	
+	/* Compute hint bits based on service */
+	hints = irlmp_service_to_hint(S_COMM);
+	if (self->service_type & IRCOMM_3_WIRE_RAW)
+		hints |= irlmp_service_to_hint(S_PRINTER);
+
+	/* Advertise IrCOMM hint bit in discovery */
+	if (!self->skey)
+		self->skey = irlmp_register_service(hints);
+	/* Set up a discovery handler */
+	if (!self->ckey)
+		self->ckey = irlmp_register_client(hints,
+						   ircomm_tty_discovery_indication,
+						   NULL, (void *) self);
+
+	/* If already done, no need to do it again */
+	if (self->obj)
+		return;
+
 	if (self->service_type & IRCOMM_3_WIRE_RAW) {
-		hints = irlmp_service_to_hint(S_PRINTER);
-		hints |= irlmp_service_to_hint(S_COMM);
-		
 		/* Register IrLPT with LM-IAS */
 		self->obj = irias_new_object("IrLPT", IAS_IRLPT_ID);
 		irias_add_integer_attrib(self->obj, "IrDA:IrLMP:LsapSel", 
 					 self->slsap_sel, IAS_KERNEL_ATTR);
-		irias_insert_object(self->obj);
 	} else {
-		hints = irlmp_service_to_hint(S_COMM);
-
 		/* Register IrCOMM with LM-IAS */
 		self->obj = irias_new_object("IrDA:IrCOMM", IAS_IRCOMM_ID);
 		irias_add_integer_attrib(self->obj, "IrDA:TinyTP:LsapSel", 
@@ -234,12 +247,45 @@ static void ircomm_tty_ias_register(stru
 		/* Register parameters with LM-IAS */
 		irias_add_octseq_attrib(self->obj, "Parameters", oct_seq, 6,
 					IAS_KERNEL_ATTR);
-		irias_insert_object(self->obj);
 	}
-	self->skey = irlmp_register_service(hints);
-	self->ckey = irlmp_register_client(hints,
-					   ircomm_tty_discovery_indication,
-					   NULL, (void *) self);
+	irias_insert_object(self->obj);
+}
+
+/*
+ * Function ircomm_tty_ias_unregister (self)
+ *
+ *    Remove our IAS object and client hook while connected.
+ *
+ */
+static void ircomm_tty_ias_unregister(struct ircomm_tty_cb *self)
+{
+	/* Remove LM-IAS object now so it is not reused.
+	 * IrCOMM deals very poorly with multiple incoming connections.
+	 * It should looks a lot more like IrNET, and "dup" a server TSAP
+	 * to the application TSAP (based on various rules).
+	 * This is a cheap workaround allowing multiple clients to
+	 * connect to us. It will not always work.
+	 * Each IrCOMM socket has an IAS entry. Incoming connection will
+	 * pick the first one found. So, when we are fully connected,
+	 * we remove our IAS entries so that the next IAS entry is used.
+	 * We do that for *both* client and server, because a server
+	 * can also create client instances.
+	 * Jean II */
+	if (self->obj) {
+		irias_delete_object(self->obj);
+		self->obj = NULL;
+	}
+
+#if 0
+	/* Remove discovery handler.
+	 * While we are connected, we no longer need to receive
+	 * discovery events. This would be the case if there is
+	 * multiple IrLAP interfaces. Jean II */
+	if (self->ckey) {
+		irlmp_unregister_client(self->ckey);
+		self->ckey = NULL;
+	}
+#endif
 }
 
 /*
@@ -333,7 +379,8 @@ static void ircomm_tty_discovery_indicat
 	info.daddr = discovery->daddr;
 	info.saddr = discovery->saddr;
 
-	/* FIXME. We probably need to use hashbin_find_next(), but we first
+	/* FIXME. We have a locking problem on the hashbin here.
+	 * We probably need to use hashbin_find_next(), but we first
 	 * need to ensure that "line" is unique. - Jean II */
 	self = (struct ircomm_tty_cb *) hashbin_get_first(ircomm_tty);
 	while (self != NULL) {
@@ -519,23 +566,6 @@ void ircomm_tty_link_established(struct 
 	
 	del_timer(&self->watchdog_timer);
 
-	/* Remove LM-IAS object now so it is not reused.
-	 * IrCOMM deals very poorly with multiple incoming connections.
-	 * It should looks a lot more like IrNET, and "dup" a server TSAP
-	 * to the application TSAP (based on various rules).
-	 * This is a cheap workaround allowing multiple clients to
-	 * connect to us. It will not always work.
-	 * Each IrCOMM socket has an IAS entry. Incoming connection will
-	 * pick the first one found. So, when we are fully connected,
-	 * we remove our IAS entries so that the next IAS entry is used.
-	 * We do that for *both* client and server, because a server
-	 * can also create client instances.
-	 * Jean II */
-	if (self->obj) {
-		irias_delete_object(self->obj);
-		self->obj = NULL;
-	}
-
 	/* 
 	 * IrCOMM link is now up, and if we are not using hardware
 	 * flow-control, then declare the hardware as running. Otherwise we
@@ -558,7 +588,7 @@ void ircomm_tty_link_established(struct 
 }
 
 /*
- * Function irlan_start_watchdog_timer (self, timeout)
+ * Function ircomm_tty_start_watchdog_timer (self, timeout)
  *
  *    Start the watchdog timer. This timer is used to make sure that any 
  *    connection attempt is successful, and if not, we will retry after 
@@ -591,6 +621,43 @@ void ircomm_tty_watchdog_timer_expired(v
 	ircomm_tty_do_event(self, IRCOMM_TTY_WD_TIMER_EXPIRED, NULL, NULL);
 }
 
+
+/*
+ * Function ircomm_tty_do_event (self, event, skb)
+ *
+ *    Process event
+ *
+ */
+int ircomm_tty_do_event(struct ircomm_tty_cb *self, IRCOMM_TTY_EVENT event,
+			struct sk_buff *skb, struct ircomm_tty_info *info) 
+{
+	ASSERT(self != NULL, return -1;);
+	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);
+
+	IRDA_DEBUG(2, "%s: state=%s, event=%s\n", __FUNCTION__ ,
+		   ircomm_tty_state[self->state], ircomm_tty_event[event]);
+	
+	return (*state[self->state])(self, event, skb, info);
+}
+
+/*
+ * Function ircomm_tty_next_state (self, state)
+ *
+ *    Switch state
+ *
+ */
+static inline void ircomm_tty_next_state(struct ircomm_tty_cb *self, IRCOMM_TTY_STATE state)
+{
+	/*
+	ASSERT(self != NULL, return;);
+	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
+
+	IRDA_DEBUG(2, "%s: next state=%s, service type=%d\n", __FUNCTION__ , 
+		   ircomm_tty_state[self->state], self->service_type);
+	*/
+	self->state = state;
+}
+
 /*
  * Function ircomm_tty_state_idle (self, event, skb, info)
  *
@@ -700,6 +767,7 @@ static int ircomm_tty_state_search(struc
 		break;
 	case IRCOMM_TTY_CONNECT_INDICATION:
 		del_timer(&self->watchdog_timer);
+		ircomm_tty_ias_unregister(self);
 
 		/* Accept connection */
 		ircomm_connect_response(self->ircomm, NULL);
@@ -765,6 +833,7 @@ static int ircomm_tty_state_query_parame
 		break;
 	case IRCOMM_TTY_CONNECT_INDICATION:
 		del_timer(&self->watchdog_timer);
+		ircomm_tty_ias_unregister(self);
 
 		/* Accept connection */
 		ircomm_connect_response(self->ircomm, NULL);
@@ -813,6 +882,7 @@ static int ircomm_tty_state_query_lsap_s
 		break;
 	case IRCOMM_TTY_CONNECT_INDICATION:
 		del_timer(&self->watchdog_timer);
+		ircomm_tty_ias_unregister(self);
 
 		/* Accept connection */
 		ircomm_connect_response(self->ircomm, NULL);
@@ -848,7 +918,7 @@ static int ircomm_tty_state_setup(struct
 	switch (event) {
 	case IRCOMM_TTY_CONNECT_CONFIRM:
 		del_timer(&self->watchdog_timer);
-		ircomm_tty_next_state(self, IRCOMM_TTY_READY);
+		ircomm_tty_ias_unregister(self);
 		
 		/* 
 		 * Send initial parameters. This will also send out queued
@@ -856,9 +926,11 @@ static int ircomm_tty_state_setup(struct
 		 */
 		ircomm_tty_send_initial_parameters(self);
 		ircomm_tty_link_established(self);
+		ircomm_tty_next_state(self, IRCOMM_TTY_READY);
 		break;
 	case IRCOMM_TTY_CONNECT_INDICATION:
 		del_timer(&self->watchdog_timer);
+		ircomm_tty_ias_unregister(self);
 		
 		/* Accept connection */
 		ircomm_connect_response(self->ircomm, NULL);
@@ -903,6 +975,7 @@ static int ircomm_tty_state_ready(struct
 		ircomm_tty_next_state(self, IRCOMM_TTY_IDLE);
 		break;
 	case IRCOMM_TTY_DISCONNECT_INDICATION:
+		ircomm_tty_ias_register(self);
 		ircomm_tty_next_state(self, IRCOMM_TTY_SEARCH);
 		ircomm_tty_start_watchdog_timer(self, 3*HZ);
 
@@ -922,40 +995,5 @@ static int ircomm_tty_state_ready(struct
 		ret = -EINVAL;
 	}
 	return ret;
-}
-
-/*
- * Function ircomm_tty_do_event (self, event, skb)
- *
- *    Process event
- *
- */
-int ircomm_tty_do_event(struct ircomm_tty_cb *self, IRCOMM_TTY_EVENT event,
-			struct sk_buff *skb, struct ircomm_tty_info *info) 
-{
-	ASSERT(self != NULL, return -1;);
-	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);
-
-	IRDA_DEBUG(2, "%s: state=%s, event=%s\n", __FUNCTION__ ,
-		   ircomm_tty_state[self->state], ircomm_tty_event[event]);
-	
-	return (*state[self->state])(self, event, skb, info);
-}
-
-/*
- * Function ircomm_tty_next_state (self, state)
- *
- *    Switch state
- *
- */
-void ircomm_tty_next_state(struct ircomm_tty_cb *self, IRCOMM_TTY_STATE state)
-{
-	ASSERT(self != NULL, return;);
-	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
-
-	self->state = state;
-	
-	IRDA_DEBUG(2, "%s: next state=%s, service type=%d\n", __FUNCTION__ , 
-		   ircomm_tty_state[self->state], self->service_type);
 }
 
