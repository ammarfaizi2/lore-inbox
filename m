Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbQKKV06>; Sat, 11 Nov 2000 16:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129033AbQKKV0s>; Sat, 11 Nov 2000 16:26:48 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:50441 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S129047AbQKKV0d>; Sat, 11 Nov 2000 16:26:33 -0500
Date: Sat, 11 Nov 2000 21:27:31 GMT
Message-Id: <200011112127.VAA32469@tepid.osl.fast.no>
Subject: [patch] patch-2.4.0-test10-irda16 (was: Re: The IrDA patches)
X-Mailer: Pygmy (v0.4.4pre)
Subject: [patch] patch-2.4.0-test10-irda16 (was: Re: The IrDA patches)
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

The name of this patch is irda16.diff. 

(Many thanks to Jean Tourrilhes for splitting up the big patch)

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash
[OUPS   ] : Error that will be fixed in a later patch

irda16.diff :
-----------------
	o [CRITICA] Add hashbin_remove_first for safe linked list removal
	o [CRITICA] Modify discovery to handle safely duplicate nodes
	o [CRITICA] Fix infinite loop in discovery_proc_read
	o [CORRECT] Handle interleaved discovery frames (not complete) 
	o [FEATURE] Add discovery expiry callback
	o [FEATURE] Remove cruft in af_irda

diff -urpN old-linux/include/net/irda/irlmp.h linux/include/net/irda/irlmp.h
--- old-linux/include/net/irda/irlmp.h	Thu Nov  9 14:47:22 2000
+++ linux/include/net/irda/irlmp.h	Thu Nov  9 17:33:48 2000
@@ -85,8 +85,9 @@ typedef struct {
 
 	__u16 hint_mask;
 
-	DISCOVERY_CALLBACK1 callback1;
-	DISCOVERY_CALLBACK2 callback2;
+	DISCOVERY_CALLBACK1 callback1;		/* Selective discovery */
+	DISCOVERY_CALLBACK2 callback2;		/* Whole discovery */
+	DISCOVERY_CALLBACK1 callback3;		/* Selective expiration */
 	void *priv;                /* Used to identify client */
 } irlmp_client_t;
 
@@ -193,10 +194,13 @@ __u16 irlmp_service_to_hint(int service)
 __u32 irlmp_register_service(__u16 hints);
 int irlmp_unregister_service(__u32 handle);
 __u32 irlmp_register_client(__u16 hint_mask, DISCOVERY_CALLBACK1 callback1,
-			    DISCOVERY_CALLBACK2 callback2, void *priv);
+			    DISCOVERY_CALLBACK2 callback2,
+			    DISCOVERY_CALLBACK1 callback3, void *priv);
 int irlmp_unregister_client(__u32 handle);
 int irlmp_update_client(__u32 handle, __u16 hint_mask, 
-			DISCOVERY_CALLBACK1, DISCOVERY_CALLBACK2, void *priv);
+			DISCOVERY_CALLBACK1 callback1,
+			DISCOVERY_CALLBACK2 callback2,
+			DISCOVERY_CALLBACK1 callback3, void *priv);
 
 void irlmp_register_link(struct irlap_cb *, __u32 saddr, notify_t *);
 void irlmp_unregister_link(__u32 saddr);
@@ -218,6 +222,7 @@ void irlmp_discovery_request(int nslots)
 struct irda_device_info *irlmp_get_discoveries(int *pn, __u16 mask);
 void irlmp_do_discovery(int nslots);
 discovery_t *irlmp_get_discovery_response(void);
+void irlmp_discovery_expiry(discovery_t *expiry);
 
 int  irlmp_data_request(struct lsap_cb *, struct sk_buff *);
 void irlmp_data_indication(struct lsap_cb *, struct sk_buff *);
diff -urpN old-linux/include/net/irda/irqueue.h linux/include/net/irda/irqueue.h
--- old-linux/include/net/irda/irqueue.h	Thu Nov  9 14:47:22 2000
+++ linux/include/net/irda/irqueue.h	Thu Nov  9 17:33:48 2000
@@ -89,6 +89,7 @@ void     hashbin_insert(hashbin_t* hashb
 void*    hashbin_find(hashbin_t* hashbin, __u32 hashv, char* name);
 void*    hashbin_remove(hashbin_t* hashbin, __u32 hashv, char* name);
 void*    hashbin_remove_first(hashbin_t *hashbin);
+void*	 hashbin_remove_this( hashbin_t* hashbin, irda_queue_t* entry);
 irda_queue_t *hashbin_get_first(hashbin_t *hashbin);
 irda_queue_t *hashbin_get_next(hashbin_t *hashbin);
 
diff -urpN old-linux/net/irda/af_irda.c linux/net/irda/af_irda.c
--- old-linux/net/irda/af_irda.c	Thu Nov  9 17:32:39 2000
+++ linux/net/irda/af_irda.c	Thu Nov  9 17:33:48 2000
@@ -366,33 +366,6 @@ static void irda_getvalue_confirm(int re
 	wake_up_interruptible(&self->query_wait);
 }
 
-#if 0
-/* Obsolete */
-/*
- * Function irda_discovery_indication (log)
- *
- *    Got a discovery log from IrLMP, wake up any process waiting for answer
- *
- */
-static void irda_discovery_indication(hashbin_t *log, void *priv)
-{
-	struct irda_sock *self;
-	
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
-
-	self = (struct irda_sock *) priv;
-	if (!self) {
-		WARNING(__FUNCTION__ "(), lost myself!\n");
-		return;
-	}
-
-	self->cachelog = log;
-
-	/* Wake up process if its waiting for device to be discovered */
-	wake_up_interruptible(&self->query_wait);
-}
-#endif
-
 /*
  * Function irda_selective_discovery_indication (discovery)
  *
@@ -1123,7 +1096,7 @@ static int irda_create(struct socket *so
 	sk->protocol = protocol;
 
 	/* Register as a client with IrLMP */
-	self->ckey = irlmp_register_client(0, NULL, NULL, NULL);
+	self->ckey = irlmp_register_client(0, NULL, NULL, NULL, NULL);
 	self->mask = 0xffff;
 	self->rx_flow = self->tx_flow = FLOW_START;
 	self->nslots = DISCOVERY_DEFAULT_SLOTS;
@@ -2175,7 +2148,7 @@ static int irda_getsockopt(struct socket
 		/* Tell IrLMP we want to be notified */
 		irlmp_update_client(self->ckey, self->mask,
 				    irda_selective_discovery_indication, NULL,
-				    (void *) self);
+				    NULL, (void *) self);
 		
 		/* Do some discovery (and also return cached results) */
 		irlmp_discovery_request(self->nslots);
@@ -2206,7 +2179,8 @@ static int irda_getsockopt(struct socket
 				   "(), found immediately !\n");
 
 		/* Tell IrLMP that we have been notified */
-		irlmp_update_client(self->ckey, self->mask, NULL, NULL, NULL);
+		irlmp_update_client(self->ckey, self->mask, NULL, NULL,
+				    NULL, NULL);
 
 		/* Check if the we got some results */
 		if (!self->cachediscovery)
diff -urpN old-linux/net/irda/discovery.c linux/net/irda/discovery.c
--- old-linux/net/irda/discovery.c	Thu Nov  9 14:47:22 2000
+++ linux/net/irda/discovery.c	Thu Nov  9 17:33:48 2000
@@ -75,14 +75,15 @@ void irlmp_add_discovery(hashbin_t *cach
 
 		/* Be sure to stay one item ahead */
 		discovery = (discovery_t *) hashbin_get_next(cachelog);
-			
-		if ((node->daddr == new->daddr) || 
-		    (strcmp(node->nickname, new->nickname) == 0))
+
+		if ((node->saddr == new->saddr) &&
+		    ((node->daddr == new->daddr) || 
+		     (strcmp(node->nickname, new->nickname) == 0)))
 		{
 			/* This discovery is a previous discovery 
 			 * from the same device, so just remove it
 			 */
-			hashbin_remove(cachelog, node->daddr, NULL);
+			hashbin_remove_this(cachelog, (irda_queue_t *) node);
 			/* Check if hints bits have changed */
 			if(node->hints.word == new->hints.word)
 				/* Set time of first discovery for this node */
@@ -135,6 +136,8 @@ void irlmp_add_discovery_log(hashbin_t *
  *
  *    Go through all discoveries and expire all that has stayed to long
  *
+ * Note : this assume that IrLAP won't change its saddr, which
+ * currently is a valid assumption...
  */
 void irlmp_expire_discoveries(hashbin_t *log, __u32 saddr, int force)
 {
@@ -153,10 +156,14 @@ void irlmp_expire_discoveries(hashbin_t 
 		discovery = (discovery_t *) hashbin_get_next(log);
 
 		/* Test if it's time to expire this discovery */
-		if ((curr->saddr == saddr) && (force ||
-		    ((jiffies - curr->timestamp) > DISCOVERY_EXPIRE_TIMEOUT)))
+		if ((curr->saddr == saddr) &&
+		    (force ||
+		     ((jiffies - curr->timestamp) > DISCOVERY_EXPIRE_TIMEOUT)))
 		{
-			curr = hashbin_remove(log, curr->daddr, NULL);
+			/* Tell IrLMP and registered clients about it */
+			irlmp_discovery_expiry(curr);
+			/* Remove it from the log */
+			curr = hashbin_remove_this(log, (irda_queue_t *) curr);
 			if (curr)
 				kfree(curr);
 		}
@@ -298,23 +305,23 @@ __u32 irlmp_find_device(hashbin_t *cache
  *    Print discovery information in /proc file system
  *
  */
-int discovery_proc_read(char *buf, char **start, off_t offset, int len, 
+int discovery_proc_read(char *buf, char **start, off_t offset, int length, 
 			int unused)
 {
 	discovery_t *discovery;
 	unsigned long flags;
 	hashbin_t *cachelog = irlmp_get_cachelog();
+	int		len = 0;
 
 	if (!irlmp)
 		return len;
 
 	len = sprintf(buf, "IrLMP: Discovery log:\n\n");	
 	
-	save_flags(flags);
-	cli();
-	
+	spin_lock_irqsave(&irlmp->log_lock, flags);
+
 	discovery = (discovery_t *) hashbin_get_first(cachelog);
-	while ( discovery != NULL) {
+	while (( discovery != NULL) && (len < length)) {
 		len += sprintf(buf+len, "nickname: %s,", discovery->nickname);
 		
 		len += sprintf(buf+len, " hint: 0x%02x%02x", 
@@ -355,7 +362,7 @@ int discovery_proc_read(char *buf, char 
 		
 		discovery = (discovery_t *) hashbin_get_next(cachelog);
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&irlmp->log_lock, flags);
 
 	return len;
 }
diff -urpN old-linux/net/irda/ircomm/ircomm_tty_attach.c linux/net/irda/ircomm/ircomm_tty_attach.c
--- old-linux/net/irda/ircomm/ircomm_tty_attach.c	Thu Nov  9 13:27:10 2000
+++ linux/net/irda/ircomm/ircomm_tty_attach.c	Thu Nov  9 17:33:48 2000
@@ -236,7 +236,8 @@ static void ircomm_tty_ias_register(stru
 	}
 	self->skey = irlmp_register_service(hints);
 	self->ckey = irlmp_register_client(
-		hints, ircomm_tty_discovery_indication, NULL, (void *) self);
+		hints, ircomm_tty_discovery_indication, NULL, NULL,
+		(void *) self);
 }
 
 /*
diff -urpN old-linux/net/irda/irlan/irlan_common.c linux/net/irda/irlan/irlan_common.c
--- old-linux/net/irda/irlan/irlan_common.c	Thu Nov  9 17:32:39 2000
+++ linux/net/irda/irlan/irlan_common.c	Thu Nov  9 17:33:48 2000
@@ -137,7 +137,7 @@ int __init irlan_init(void)
 
 	/* Register with IrLMP as a client */
 	ckey = irlmp_register_client(hints, irlan_client_discovery_indication,
-				     NULL, NULL);
+				     NULL, NULL, NULL);
 	
 	/* Register with IrLMP as a service */
  	skey = irlmp_register_service(hints);
diff -urpN old-linux/net/irda/irlap_event.c linux/net/irda/irlap_event.c
--- old-linux/net/irda/irlap_event.c	Thu Nov  9 17:11:25 2000
+++ linux/net/irda/irlap_event.c	Thu Nov  9 17:33:48 2000
@@ -492,6 +492,30 @@ static int irlap_state_query(struct irla
 		/* irlap_next_state(self, LAP_QUERY);  */
 
 		break;
+	case RECV_DISCOVERY_XID_CMD:
+		/* Yes, it is possible to receive those frames in this mode.
+		 * This would happen is both discoveries are just slightly
+		 * offset (if they are in sync, all packets are lost).
+		 * The big trouble when it happen is that passive discovery
+		 * doesn't happen, because nobody answer the discoveries
+		 * frame of the other guy, so the log shows up empty.
+		 * What should we do ?
+		 * Not much. We are currently performing our own discovery,
+		 * therefore we can't answer those frames. We don't want
+		 * to change state either. We just pass the info to
+		 * IrLMP who will put it in the log (and post an event).
+		 * Jean II
+		 */
+
+		ASSERT(info != NULL, return -1;);
+
+		IRDA_DEBUG(1, __FUNCTION__ "(), Receiving event %d, %s\n",
+			   event, irlap_event[event]);
+
+		/* Last discovery frame? */
+		if (info->s == 0xff)
+			irlap_discovery_indication(self, info->discovery); 
+		break;
 	case SLOT_TIMER_EXPIRED:
 		/*
 		 * Wait a little longer if we detect an incomming frame. This
diff -urpN old-linux/net/irda/irlmp.c linux/net/irda/irlmp.c
--- old-linux/net/irda/irlmp.c	Thu Nov  9 14:47:22 2000
+++ linux/net/irda/irlmp.c	Thu Nov  9 17:33:48 2000
@@ -903,9 +903,40 @@ void irlmp_discovery_confirm(hashbin_t *
 }
 
 /*
+ * Function irlmp_discovery_expiry (expiry)
+ *
+ *	This device is no longer been discovered, and therefore it is beeing
+ *	purged from the discovery log. Inform all clients who have
+ *	registered for this event...
+ * 
+ *	Note : called exclusively from discovery.c
+ *	Note : as we are currently processing the log, the clients callback
+ *	should *NOT* attempt to touch the log now.
+ */
+void irlmp_discovery_expiry(discovery_t *expiry) 
+{
+	irlmp_client_t *client;
+	
+	IRDA_DEBUG(3, __FUNCTION__ "()\n");
+
+	ASSERT(expiry != NULL, return;);
+	
+	client = (irlmp_client_t *) hashbin_get_first(irlmp->clients);
+	while (client != NULL) {
+		/* Check if we should notify client */
+		if ((client->callback3) &&
+		    (client->hint_mask & expiry->hints.word & 0x7f7f))
+			client->callback3(expiry, client->priv);
+
+		/* Next client */
+		client = (irlmp_client_t *) hashbin_get_next(irlmp->clients);
+	}
+}
+
+/*
  * Function irlmp_get_discovery_response ()
  *
- *    Used by IrLAP to get the disocvery info it needs when answering
+ *    Used by IrLAP to get the discovery info it needs when answering
  *    discovery requests by other devices.
  */
 discovery_t *irlmp_get_discovery_response()
@@ -1294,11 +1325,15 @@ int irlmp_unregister_service(__u32 handl
  * Function irlmp_register_client (hint_mask, callback1, callback2)
  *
  *    Register a local client with IrLMP
+ *	First callback is selective discovery (based on hints)
+ *	Second callback is for the whole discovery log
+ *	Third callback is for selective discovery expiries
  *
  *    Returns: handle > 0 on success, 0 on error
  */
 __u32 irlmp_register_client(__u16 hint_mask, DISCOVERY_CALLBACK1 callback1,
-			    DISCOVERY_CALLBACK2 callback2, void *priv)
+			    DISCOVERY_CALLBACK2 callback2,
+			    DISCOVERY_CALLBACK1 callback3, void *priv)
 {
 	irlmp_client_t *client;
 	__u32 handle;
@@ -1320,6 +1355,7 @@ __u32 irlmp_register_client(__u16 hint_m
 	client->hint_mask = hint_mask;
 	client->callback1 = callback1;
 	client->callback2 = callback2;
+	client->callback3 = callback3;
 	client->priv = priv;
 
  	hashbin_insert(irlmp->clients, (irda_queue_t *) client, handle, NULL);
@@ -1337,7 +1373,8 @@ __u32 irlmp_register_client(__u16 hint_m
  */
 int irlmp_update_client(__u32 handle, __u16 hint_mask, 
 			DISCOVERY_CALLBACK1 callback1, 
-			DISCOVERY_CALLBACK2 callback2, void *priv)
+			DISCOVERY_CALLBACK2 callback2,
+			DISCOVERY_CALLBACK1 callback3, void *priv)
 {
 	irlmp_client_t *client;
 
@@ -1353,6 +1390,7 @@ int irlmp_update_client(__u32 handle, __
 	client->hint_mask = hint_mask;
 	client->callback1 = callback1;
 	client->callback2 = callback2;
+	client->callback3 = callback3;
 	client->priv = priv;
 	
 	return 0;
diff -urpN old-linux/net/irda/irlmp_frame.c linux/net/irda/irlmp_frame.c
--- old-linux/net/irda/irlmp_frame.c	Thu Nov  9 13:48:34 2000
+++ linux/net/irda/irlmp_frame.c	Thu Nov  9 17:33:48 2000
@@ -397,7 +397,7 @@ void irlmp_link_discovery_indication(str
 	/* If delay was activated, kill it! */
 	if(timer_pending(&disco_delay))
 		del_timer(&disco_delay);
-	/* Set delay timer to expire in 0.5s. */
+	/* Set delay timer to expire in 0.25s. */
 	disco_delay.expires = jiffies + (DISCO_SMALL_DELAY * HZ/1000);
 	disco_delay.function = irlmp_discovery_timeout;
 	disco_delay.data = (unsigned long) self;
@@ -420,8 +420,8 @@ void irlmp_link_discovery_confirm(struct
 	ASSERT(self->magic == LMP_LAP_MAGIC, return;);
 	
 	irlmp_add_discovery_log(irlmp->cachelog, log);
-      
-	/* If delay was activated, kill it! */
+
+	/* If discovery delay was activated, kill it! */
 	if(timer_pending(&disco_delay))
 		del_timer(&disco_delay);
 
diff -urpN old-linux/net/irda/irmod.c linux/net/irda/irmod.c
--- old-linux/net/irda/irmod.c	Thu Nov  9 17:09:30 2000
+++ linux/net/irda/irmod.c	Thu Nov  9 17:33:48 2000
@@ -170,6 +170,7 @@ EXPORT_SYMBOL(hashbin_new);
 EXPORT_SYMBOL(hashbin_insert);
 EXPORT_SYMBOL(hashbin_delete);
 EXPORT_SYMBOL(hashbin_remove);
+EXPORT_SYMBOL(hashbin_remove_this);
 EXPORT_SYMBOL(hashbin_get_next);
 EXPORT_SYMBOL(hashbin_get_first);
 
diff -urpN old-linux/net/irda/irqueue.c linux/net/irda/irqueue.c
--- old-linux/net/irda/irqueue.c	Thu Nov  9 14:47:22 2000
+++ linux/net/irda/irqueue.c	Thu Nov  9 17:33:48 2000
@@ -381,6 +381,7 @@ void* hashbin_remove( hashbin_t* hashbin
 		hashv = hash( name );
 	bin = GET_HASHBIN( hashv );
 
+	/* Synchronize */
 	if ( hashbin->hb_type & HB_GLOBAL ) {
 		spin_lock_irqsave( &hashbin->hb_mutex[ bin ], flags);
 
@@ -448,6 +449,75 @@ void* hashbin_remove( hashbin_t* hashbin
 	else
 		return NULL;
 	
+}
+
+/* 
+ *  Function hashbin_remove (hashbin, hashv, name)
+ *
+ *    Remove entry with the given name
+ *
+ * In some cases, the user of hashbin can't guarantee the unicity
+ * of either the hashv or name.
+ * In those cases, using the above function is guaranteed to cause troubles,
+ * so we use this one instead...
+ * And by the way, it's also faster, because we skip the search phase ;-)
+ */
+void* hashbin_remove_this( hashbin_t* hashbin, irda_queue_t* entry)
+{
+	unsigned long flags = 0;
+	int	bin;
+	__u32	hashv;
+
+	IRDA_DEBUG( 4, __FUNCTION__ "()\n");
+
+	ASSERT( hashbin != NULL, return NULL;);
+	ASSERT( hashbin->magic == HB_MAGIC, return NULL;);
+	ASSERT( entry != NULL, return NULL;);
+	
+	/* Check if valid and not already removed... */
+	if((entry->q_next == NULL) || (entry->q_prev == NULL))
+		return NULL;
+
+	/*
+	 * Locate hashbin
+	 */
+	hashv = entry->q_hash;
+	bin = GET_HASHBIN( hashv );
+
+	/* Synchronize */
+	if ( hashbin->hb_type & HB_GLOBAL ) {
+		spin_lock_irqsave( &hashbin->hb_mutex[ bin ], flags);
+
+	} else if ( hashbin->hb_type & HB_LOCAL ) {
+		save_flags(flags);
+		cli();
+	} /* Default is no-lock  */
+
+	/*
+	 * Dequeue the entry...
+	 */
+	dequeue_general( (irda_queue_t**) &hashbin->hb_queue[ bin ],
+			 (irda_queue_t*) entry );
+	hashbin->hb_size--;
+	entry->q_next = NULL;
+	entry->q_prev = NULL;
+
+	/*
+	 *  Check if this item is the currently selected item, and in
+	 *  that case we must reset hb_current
+	 */
+	if ( entry == hashbin->hb_current)
+		hashbin->hb_current = NULL;
+
+	/* Release lock */
+	if ( hashbin->hb_type & HB_GLOBAL) {
+		spin_unlock_irq( &hashbin->hb_mutex[ bin]);
+
+	} else if ( hashbin->hb_type & HB_LOCAL) {
+		restore_flags( flags);
+	}
+
+	return entry;
 }
 
 /*


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
