Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319505AbSH2Wqx>; Thu, 29 Aug 2002 18:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319502AbSH2WqA>; Thu, 29 Aug 2002 18:46:00 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:33473 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S319497AbSH2WpB>;
	Thu, 29 Aug 2002 18:45:01 -0400
Date: Thu, 29 Aug 2002 15:47:42 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: [PATCH 2.5] : ir252_hashbin_fixes-4.diff
Message-ID: <20020829224742.GB14118@bougret.hpl.hp.com>
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

ir252_hashbin_fixes-4.diff :
--------------------------
	o [CRITICA] Remove correct IAS Attribute/Object even if name is dup'ed
	o [CORRECT] Make irqueue 64 bit compliant (__u32 -> long)
	o [FEATURE] Don't use random handle for IrLMP handle, use self
		Remove dependancy on random generator in stack init


diff -u -p linux/include/net/irda-d4/af_irda.h linux/include/net/irda/af_irda.h
--- linux/include/net/irda-d4/af_irda.h	Thu Aug 29 12:10:34 2002
+++ linux/include/net/irda/af_irda.h	Thu Aug 29 13:50:08 2002
@@ -55,8 +55,8 @@ struct irda_sock {
 	__u16 mask;           /* Hint bits mask */
 	__u16 hints;          /* Hint bits */
 
-	__u32 ckey;           /* IrLMP client handle */
-	__u32 skey;           /* IrLMP service handle */
+	void *ckey;           /* IrLMP client handle */
+	void *skey;           /* IrLMP service handle */
 
 	struct ias_object *ias_obj;   /* Our service name + lsap in IAS */
 	struct iriap_cb *iriap;	      /* Used to query remote IAS */
diff -u -p linux/include/net/irda-d4/ircomm_tty.h linux/include/net/irda/ircomm_tty.h
--- linux/include/net/irda-d4/ircomm_tty.h	Thu Aug 29 12:10:34 2002
+++ linux/include/net/irda/ircomm_tty.h	Thu Aug 29 13:50:08 2002
@@ -86,8 +86,8 @@ struct ircomm_tty_cb {
 
 	struct iriap_cb *iriap; /* Instance used for querying remote IAS */
 	struct ias_object* obj;
-	int skey;
-	int ckey;
+	void *skey;
+	void *ckey;
 
 	struct termios	  normal_termios;
 	struct termios	  callout_termios;
diff -u -p linux/include/net/irda-d4/irlmp.h linux/include/net/irda/irlmp.h
--- linux/include/net/irda-d4/irlmp.h	Thu Aug 29 12:10:34 2002
+++ linux/include/net/irda/irlmp.h	Thu Aug 29 13:50:08 2002
@@ -197,12 +197,12 @@ struct lsap_cb *irlmp_open_lsap(__u8 sls
 void irlmp_close_lsap( struct lsap_cb *self);
 
 __u16 irlmp_service_to_hint(int service);
-__u32 irlmp_register_service(__u16 hints);
-int irlmp_unregister_service(__u32 handle);
-__u32 irlmp_register_client(__u16 hint_mask, DISCOVERY_CALLBACK1 disco_clb,
+void *irlmp_register_service(__u16 hints);
+int irlmp_unregister_service(void *handle);
+void *irlmp_register_client(__u16 hint_mask, DISCOVERY_CALLBACK1 disco_clb,
 			    DISCOVERY_CALLBACK1 expir_clb, void *priv);
-int irlmp_unregister_client(__u32 handle);
-int irlmp_update_client(__u32 handle, __u16 hint_mask, 
+int irlmp_unregister_client(void *handle);
+int irlmp_update_client(void *handle, __u16 hint_mask, 
 			DISCOVERY_CALLBACK1 disco_clb,
 			DISCOVERY_CALLBACK1 expir_clb, void *priv);
 
diff -u -p linux/include/net/irda-d4/irqueue.h linux/include/net/irda/irqueue.h
--- linux/include/net/irda-d4/irqueue.h	Sat Jun  8 22:31:20 2002
+++ linux/include/net/irda/irqueue.h	Thu Aug 29 13:50:08 2002
@@ -67,7 +67,7 @@ struct irda_queue {
 	struct irda_queue *q_prev;
 
 	char   q_name[NAME_SIZE];
-	__u32  q_hash;
+	long   q_hash;			/* Must be able to cast a (void *) */
 };
 typedef struct irda_queue irda_queue_t;
 
@@ -84,10 +84,10 @@ typedef struct hashbin_t {
 hashbin_t *hashbin_new(int type);
 int      hashbin_delete(hashbin_t* hashbin, FREE_FUNC func);
 int      hashbin_clear(hashbin_t* hashbin, FREE_FUNC free_func);
-void     hashbin_insert(hashbin_t* hashbin, irda_queue_t* entry, __u32 hashv, 
+void     hashbin_insert(hashbin_t* hashbin, irda_queue_t* entry, long hashv, 
 			char* name);
-void*    hashbin_find(hashbin_t* hashbin, __u32 hashv, char* name);
-void*    hashbin_remove(hashbin_t* hashbin, __u32 hashv, char* name);
+void*    hashbin_find(hashbin_t* hashbin, long hashv, char* name);
+void*    hashbin_remove(hashbin_t* hashbin, long hashv, char* name);
 void*    hashbin_remove_first(hashbin_t *hashbin);
 void*	 hashbin_remove_this( hashbin_t* hashbin, irda_queue_t* entry);
 irda_queue_t *hashbin_get_first(hashbin_t *hashbin);
Common subdirectories: linux/net/irda-d4/ircomm and linux/net/irda/ircomm
diff -u -p linux/net/irda-d4/iriap.c linux/net/irda/iriap.c
--- linux/net/irda-d4/iriap.c	Thu Aug 29 12:10:35 2002
+++ linux/net/irda/iriap.c	Thu Aug 29 13:50:08 2002
@@ -58,7 +58,7 @@ static const char *ias_charset_types[] =
 #endif	/* CONFIG_IRDA_DEBUG */
 
 static hashbin_t *iriap = NULL;
-static __u32 service_handle;
+static void *service_handle;
 
 extern char *lmp_reasons[];
 
@@ -182,7 +182,7 @@ struct iriap_cb *iriap_open(__u8 slsap_s
 
 	init_timer(&self->watchdog_timer);
 
-	hashbin_insert(iriap, (irda_queue_t *) self, (int) self, NULL);
+	hashbin_insert(iriap, (irda_queue_t *) self, (long) self, NULL);
 
 	/* Initialize state machines */
 	iriap_next_client_state(self, S_DISCONNECT);
@@ -235,7 +235,7 @@ void iriap_close(struct iriap_cb *self)
 		self->lsap = NULL;
 	}
 
-	entry = (struct iriap_cb *) hashbin_remove(iriap, (int) self, NULL);
+	entry = (struct iriap_cb *) hashbin_remove(iriap, (long) self, NULL);
 	ASSERT(entry == self, return;);
 
 	__iriap_close(self);
diff -u -p linux/net/irda-d4/irias_object.c linux/net/irda/irias_object.c
--- linux/net/irda-d4/irias_object.c	Thu Aug 29 12:10:35 2002
+++ linux/net/irda/irias_object.c	Thu Aug 29 13:50:08 2002
@@ -147,7 +147,7 @@ int irias_delete_object(struct ias_objec
 	ASSERT(obj != NULL, return -1;);
 	ASSERT(obj->magic == IAS_OBJECT_MAGIC, return -1;);
 
-	node = hashbin_remove(objects, 0, obj->name);
+	node = hashbin_remove_this(objects, (irda_queue_t *) obj);
 	if (!node)
 		return 0; /* Already removed */
 
@@ -172,7 +172,7 @@ int irias_delete_attrib(struct ias_objec
 	ASSERT(attrib != NULL, return -1;);
 
 	/* Remove attribute from object */
-	node = hashbin_remove(obj->attribs, 0, attrib->name);
+	node = hashbin_remove_this(obj->attribs, (irda_queue_t *) attrib);
 	if (!node)
 		return 0; /* Already removed or non-existent */
 
Common subdirectories: linux/net/irda-d4/irlan and linux/net/irda/irlan
diff -u -p linux/net/irda-d4/irlmp.c linux/net/irda/irlmp.c
--- linux/net/irda-d4/irlmp.c	Thu Aug 29 12:10:35 2002
+++ linux/net/irda/irlmp.c	Thu Aug 29 13:50:08 2002
@@ -177,8 +177,8 @@ struct lsap_cb *irlmp_open_lsap(__u8 sls
 	self->lsap_state = LSAP_DISCONNECTED;
 
 	/* Insert into queue of unconnected LSAPs */
-	hashbin_insert(irlmp->unconnected_lsaps, (irda_queue_t *) self, (int) self, 
-		       NULL);
+	hashbin_insert(irlmp->unconnected_lsaps, (irda_queue_t *) self,
+		       (long) self, NULL);
 
 	return self;
 }
@@ -238,7 +238,7 @@ void irlmp_close_lsap(struct lsap_cb *se
 					   LM_LAP_DISCONNECT_REQUEST, NULL);
 		}
 		/* Now, remove from the link */
-		lsap = hashbin_remove(lap->lsaps, (int) self, NULL);
+		lsap = hashbin_remove(lap->lsaps, (long) self, NULL);
 #ifdef CONFIG_IRDA_CACHE_LAST_LSAP
 		lap->cache.valid = FALSE;
 #endif
@@ -246,7 +246,7 @@ void irlmp_close_lsap(struct lsap_cb *se
 	self->lap = NULL;
 	/* Check if we found the LSAP! If not then try the unconnected lsaps */
 	if (!lsap) {
-		lsap = hashbin_remove(irlmp->unconnected_lsaps, (int) self,
+		lsap = hashbin_remove(irlmp->unconnected_lsaps, (long) self,
 				      NULL);
 	}
 	if (!lsap) {
@@ -436,14 +436,15 @@ int irlmp_connect_request(struct lsap_cb
 	 *  Remove LSAP from list of unconnected LSAPs and insert it into the
 	 *  list of connected LSAPs for the particular link
 	 */
-	lsap = hashbin_remove(irlmp->unconnected_lsaps, (int) self, NULL);
+	lsap = hashbin_remove(irlmp->unconnected_lsaps, (long) self, NULL);
 
 	ASSERT(lsap != NULL, return -1;);
 	ASSERT(lsap->magic == LMP_LSAP_MAGIC, return -1;);
 	ASSERT(lsap->lap != NULL, return -1;);
 	ASSERT(lsap->lap->magic == LMP_LAP_MAGIC, return -1;);
 
-	hashbin_insert(self->lap->lsaps, (irda_queue_t *) self, (int) self, NULL);
+	hashbin_insert(self->lap->lsaps, (irda_queue_t *) self, (long) self,
+		       NULL);
 
 	set_bit(0, &self->connected);	/* TRUE */
 
@@ -578,7 +579,7 @@ struct lsap_cb *irlmp_dup(struct lsap_cb
 	IRDA_DEBUG(1, __FUNCTION__ "()\n");
 
 	/* Only allowed to duplicate unconnected LSAP's */
-	if (!hashbin_find(irlmp->unconnected_lsaps, (int) orig, NULL)) {
+	if (!hashbin_find(irlmp->unconnected_lsaps, (long) orig, NULL)) {
 		IRDA_DEBUG(0, __FUNCTION__ "(), unable to find LSAP\n");
 		return NULL;
 	}
@@ -595,8 +596,8 @@ struct lsap_cb *irlmp_dup(struct lsap_cb
 
 	init_timer(&new->watchdog_timer);
 
-	hashbin_insert(irlmp->unconnected_lsaps, (irda_queue_t *) new, (int) new,
-		       NULL);
+	hashbin_insert(irlmp->unconnected_lsaps, (irda_queue_t *) new,
+		       (long) new, NULL);
 
 	/* Make sure that we invalidate the cache */
 #ifdef CONFIG_IRDA_CACHE_LAST_LSAP
@@ -646,7 +647,7 @@ int irlmp_disconnect_request(struct lsap
 	ASSERT(self->lap->magic == LMP_LAP_MAGIC, return -1;);
 	ASSERT(self->lap->lsaps != NULL, return -1;);
 
-	lsap = hashbin_remove(self->lap->lsaps, (int) self, NULL);
+	lsap = hashbin_remove(self->lap->lsaps, (long) self, NULL);
 #ifdef CONFIG_IRDA_CACHE_LAST_LSAP
 	self->lap->cache.valid = FALSE;
 #endif
@@ -655,8 +656,8 @@ int irlmp_disconnect_request(struct lsap
 	ASSERT(lsap->magic == LMP_LSAP_MAGIC, return -1;);
 	ASSERT(lsap == self, return -1;);
 
-	hashbin_insert(irlmp->unconnected_lsaps, (irda_queue_t *) self, (int) self,
-		       NULL);
+	hashbin_insert(irlmp->unconnected_lsaps, (irda_queue_t *) self,
+		       (long) self, NULL);
 
 	/* Reset some values */
 	self->dlsap_sel = LSAP_ANY;
@@ -699,15 +700,15 @@ void irlmp_disconnect_indication(struct 
 	ASSERT(self->lap != NULL, return;);
 	ASSERT(self->lap->lsaps != NULL, return;);
 
-	lsap = hashbin_remove(self->lap->lsaps, (int) self, NULL);
+	lsap = hashbin_remove(self->lap->lsaps, (long) self, NULL);
 #ifdef CONFIG_IRDA_CACHE_LAST_LSAP
 	self->lap->cache.valid = FALSE;
 #endif
 
 	ASSERT(lsap != NULL, return;);
 	ASSERT(lsap == self, return;);
-	hashbin_insert(irlmp->unconnected_lsaps, (irda_queue_t *) lsap, (int) lsap,
-		       NULL);
+	hashbin_insert(irlmp->unconnected_lsaps, (irda_queue_t *) lsap,
+		       (long) lsap, NULL);
 
 	self->dlsap_sel = LSAP_ANY;
 	self->lap = NULL;
@@ -1414,20 +1415,12 @@ __u16 irlmp_service_to_hint(int service)
  *    Register local service with IrLMP
  *
  */
-__u32 irlmp_register_service(__u16 hints)
+void *irlmp_register_service(__u16 hints)
 {
 	irlmp_service_t *service;
-	__u32 handle;
 
 	IRDA_DEBUG(4, __FUNCTION__ "(), hints = %04x\n", hints);
 
-	/* Get a unique handle for this service */
-	get_random_bytes(&handle, sizeof(handle));
-	while (hashbin_find(irlmp->services, handle, NULL) || !handle)
-		get_random_bytes(&handle, sizeof(handle));
-
-	irlmp->hints.word |= hints;
-
 	/* Make a new registration */
 	service = kmalloc(sizeof(irlmp_service_t), GFP_ATOMIC);
 	if (!service) {
@@ -1435,9 +1428,12 @@ __u32 irlmp_register_service(__u16 hints
 		return 0;
 	}
 	service->hints = hints;
-	hashbin_insert(irlmp->services, (irda_queue_t *) service, handle, NULL);
+	hashbin_insert(irlmp->services, (irda_queue_t *) service,
+		       (long) service, NULL);
+
+	irlmp->hints.word |= hints;
 
-	return handle;
+	return (void *)service;
 }
 
 /*
@@ -1447,7 +1443,7 @@ __u32 irlmp_register_service(__u16 hints
  *
  *    Returns: 0 on success, -1 on error
  */
-int irlmp_unregister_service(__u32 handle)
+int irlmp_unregister_service(void *handle)
 {
 	irlmp_service_t *service;
 
@@ -1456,15 +1452,15 @@ int irlmp_unregister_service(__u32 handl
 	if (!handle)
 		return -1;
 
-	service = hashbin_find(irlmp->services, handle, NULL);
+	/* Caller may call with invalid handle (it's legal) - Jean II */
+	service = hashbin_find(irlmp->services, (long) handle, NULL);
 	if (!service) {
 		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown service!\n");
 		return -1;
 	}
 
-	service = hashbin_remove(irlmp->services, handle, NULL);
-	if (service)
-		kfree(service);
+	hashbin_remove_this(irlmp->services, (irda_queue_t *) service);
+	kfree(service);
 
 	/* Remove old hint bits */
 	irlmp->hints.word = 0;
@@ -1488,20 +1484,14 @@ int irlmp_unregister_service(__u32 handl
  *
  *    Returns: handle > 0 on success, 0 on error
  */
-__u32 irlmp_register_client(__u16 hint_mask, DISCOVERY_CALLBACK1 disco_clb,
+void *irlmp_register_client(__u16 hint_mask, DISCOVERY_CALLBACK1 disco_clb,
 			    DISCOVERY_CALLBACK1 expir_clb, void *priv)
 {
 	irlmp_client_t *client;
-	__u32 handle;
 
 	IRDA_DEBUG(1, __FUNCTION__ "()\n");
 	ASSERT(irlmp != NULL, return 0;);
 
-	/* Get a unique handle for this client */
-	get_random_bytes(&handle, sizeof(handle));
-	while (hashbin_find(irlmp->clients, handle, NULL) || !handle)
-		get_random_bytes(&handle, sizeof(handle));
-
 	/* Make a new registration */
 	client = kmalloc(sizeof(irlmp_client_t), GFP_ATOMIC);
 	if (!client) {
@@ -1515,9 +1505,10 @@ __u32 irlmp_register_client(__u16 hint_m
 	client->expir_callback = expir_clb;
 	client->priv = priv;
 
-	hashbin_insert(irlmp->clients, (irda_queue_t *) client, handle, NULL);
+	hashbin_insert(irlmp->clients, (irda_queue_t *) client,
+		       (long) client, NULL);
 
-	return handle;
+	return (void *) client;
 }
 
 /*
@@ -1528,7 +1519,7 @@ __u32 irlmp_register_client(__u16 hint_m
  *
  *    Returns: 0 on success, -1 on error
  */
-int irlmp_update_client(__u32 handle, __u16 hint_mask,
+int irlmp_update_client(void *handle, __u16 hint_mask,
 			DISCOVERY_CALLBACK1 disco_clb,
 			DISCOVERY_CALLBACK1 expir_clb, void *priv)
 {
@@ -1537,7 +1528,7 @@ int irlmp_update_client(__u32 handle, __
 	if (!handle)
 		return -1;
 
-	client = hashbin_find(irlmp->clients, handle, NULL);
+	client = hashbin_find(irlmp->clients, (long) handle, NULL);
 	if (!client) {
 		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown client!\n");
 		return -1;
@@ -1557,7 +1548,7 @@ int irlmp_update_client(__u32 handle, __
  *    Returns: 0 on success, -1 on error
  *
  */
-int irlmp_unregister_client(__u32 handle)
+int irlmp_unregister_client(void *handle)
 {
 	struct irlmp_client *client;
 
@@ -1566,16 +1557,16 @@ int irlmp_unregister_client(__u32 handle
 	if (!handle)
 		return -1;
 
-	client = hashbin_find(irlmp->clients, handle, NULL);
+	/* Caller may call with invalid handle (it's legal) - Jean II */
+	client = hashbin_find(irlmp->clients, (long) handle, NULL);
 	if (!client) {
 		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown client!\n");
 		return -1;
 	}
 
 	IRDA_DEBUG( 4, __FUNCTION__ "(), removing client!\n");
-	client = hashbin_remove( irlmp->clients, handle, NULL);
-	if (client)
-		kfree(client);
+	hashbin_remove_this(irlmp->clients, (irda_queue_t *) client);
+	kfree(client);
 
 	return 0;
 }
diff -u -p linux/net/irda-d4/irlmp_event.c linux/net/irda/irlmp_event.c
--- linux/net/irda-d4/irlmp_event.c	Thu Aug 29 12:10:16 2002
+++ linux/net/irda/irlmp_event.c	Thu Aug 29 13:50:08 2002
@@ -581,15 +581,15 @@ static int irlmp_state_connect(struct ls
 		 *  Bind this LSAP to the IrLAP link where the connect was
 		 *  received
 		 */
-		lsap = hashbin_remove(irlmp->unconnected_lsaps, (int) self,
+		lsap = hashbin_remove(irlmp->unconnected_lsaps, (long) self,
 				      NULL);
 
 		ASSERT(lsap == self, return -1;);
 		ASSERT(self->lap != NULL, return -1;);
 		ASSERT(self->lap->lsaps != NULL, return -1;);
 
-		hashbin_insert(self->lap->lsaps, (irda_queue_t *) self, (int) self,
-			       NULL);
+		hashbin_insert(self->lap->lsaps, (irda_queue_t *) self,
+			       (long) self, NULL);
 
 		irlmp_send_lcf_pdu(self->lap, self->dlsap_sel,
 				   self->slsap_sel, CONNECT_CNF, skb);
Common subdirectories: linux/net/irda-d4/irnet and linux/net/irda/irnet
diff -u -p linux/net/irda-d4/irqueue.c linux/net/irda/irqueue.c
--- linux/net/irda-d4/irqueue.c	Thu Aug 29 12:10:35 2002
+++ linux/net/irda/irqueue.c	Thu Aug 29 13:50:08 2002
@@ -34,6 +34,21 @@
  *     
  ********************************************************************/
 
+/*
+ * NOTE :
+ * There are various problems with this package :
+ *	o the hash function for ints is pathetic (but could be changed)
+ *	o locking is sometime suspicious (especially during enumeration)
+ *	o most users have only a few elements (== overhead)
+ *	o most users never use seach, so don't benefit from hashing
+ * Problem already fixed :
+ *	o not 64 bit compliant (most users do hashv = (int) self)
+ *	o hashbin_remove() is broken => use hashbin_remove_this()
+ * I think most users would be better served by a simple linked list
+ * (like include/linux/list.h) with a global spinlock per list.
+ * Jean II
+ */
+
 #include <net/irda/irda.h>
 #include <net/irda/irqueue.h>
 
@@ -148,7 +163,7 @@ int hashbin_delete( hashbin_t* hashbin, 
  *    Insert an entry into the hashbin
  *
  */
-void hashbin_insert(hashbin_t* hashbin, irda_queue_t* entry, __u32 hashv, char* name)
+void hashbin_insert(hashbin_t* hashbin, irda_queue_t* entry, long hashv, char* name)
 {
 	unsigned long flags = 0;
 	int bin;
@@ -209,7 +224,7 @@ void hashbin_insert(hashbin_t* hashbin, 
  *    Find item with the given hashv or name
  *
  */
-void* hashbin_find( hashbin_t* hashbin, __u32 hashv, char* name )
+void* hashbin_find( hashbin_t* hashbin, long hashv, char* name )
 {
 	int bin, found = FALSE;
 	unsigned long flags = 0;
@@ -300,8 +315,16 @@ void *hashbin_remove_first( hashbin_t *h
  *
  *    Remove entry with the given name
  *
+ *  The use of this function is highly discouraged, because the whole
+ *  concept behind hashbin_remove() is broken. In many cases, it's not
+ *  possible to guarantee the unicity of the index (either hashv or name),
+ *  leading to removing the WRONG entry.
+ *  The only simple safe use is :
+ *		hashbin_remove(hasbin, (int) self, NULL);
+ *  In other case, you must think hard to guarantee unicity of the index.
+ *  Jean II
  */
-void* hashbin_remove( hashbin_t* hashbin, __u32 hashv, char* name)
+void* hashbin_remove( hashbin_t* hashbin, long hashv, char* name)
 {
 	int bin, found = FALSE;
 	unsigned long flags = 0;
@@ -404,7 +427,7 @@ void* hashbin_remove_this( hashbin_t* ha
 {
 	unsigned long flags = 0;
 	int	bin;
-	__u32	hashv;
+	long	hashv;
 
 	IRDA_DEBUG( 4, __FUNCTION__ "()\n");
 
diff -u -p linux/net/irda-d4/irsyms.c linux/net/irda/irsyms.c
--- linux/net/irda-d4/irsyms.c	Thu Aug 29 12:10:35 2002
+++ linux/net/irda/irsyms.c	Thu Aug 29 13:50:08 2002
@@ -328,7 +328,8 @@ void __exit irda_cleanup(void)
  * On the other hand, it needs to be initialised *after* the basic
  * networking, the /proc/net filesystem and sysctl module. Those are
  * currently initialised in .../init/main.c (before initcalls).
- * Also, it needs to be initialised *after* the random number generator.
+ * Also, IrDA drivers needs to be initialised *after* the random number
+ * generator (main stack and higher layer init don't need it anymore).
  *
  * Jean II
  */
diff -u -p linux/net/irda-d4/irttp.c linux/net/irda/irttp.c
--- linux/net/irda-d4/irttp.c	Thu Aug 29 12:10:35 2002
+++ linux/net/irda/irttp.c	Thu Aug 29 13:50:08 2002
@@ -433,7 +433,7 @@ struct tsap_cb *irttp_open_tsap(__u8 sts
 	self->notify = *notify;
 	self->lsap = lsap;
 
-	hashbin_insert(irttp->tsaps, (irda_queue_t *) self, (int) self, NULL);
+	hashbin_insert(irttp->tsaps, (irda_queue_t *) self, (long) self, NULL);
 
 	if (credit > TTP_RX_MAX_CREDIT)
 		self->initial_credit = TTP_RX_MAX_CREDIT;
@@ -503,7 +503,7 @@ int irttp_close_tsap(struct tsap_cb *sel
 		return 0; /* Will be back! */
 	}
 
-	tsap = hashbin_remove(irttp->tsaps, (int) self, NULL);
+	tsap = hashbin_remove(irttp->tsaps, (long) self, NULL);
 
 	ASSERT(tsap == self, return -1;);
 
@@ -1368,7 +1368,7 @@ struct tsap_cb *irttp_dup(struct tsap_cb
 
 	IRDA_DEBUG(1, __FUNCTION__ "()\n");
 
-	if (!hashbin_find(irttp->tsaps, (int) orig, NULL)) {
+	if (!hashbin_find(irttp->tsaps, (long) orig, NULL)) {
 		IRDA_DEBUG(0, __FUNCTION__ "(), unable to find TSAP\n");
 		return NULL;
 	}
@@ -1389,7 +1389,7 @@ struct tsap_cb *irttp_dup(struct tsap_cb
 	skb_queue_head_init(&new->tx_queue);
 	skb_queue_head_init(&new->rx_fragments);
 
-	hashbin_insert(irttp->tsaps, (irda_queue_t *) new, (int) new, NULL);
+	hashbin_insert(irttp->tsaps, (irda_queue_t *) new, (long) new, NULL);
 
 	return new;
 }
