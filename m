Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132472AbQKKVDQ>; Sat, 11 Nov 2000 16:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132504AbQKKVDG>; Sat, 11 Nov 2000 16:03:06 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:31753 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S132472AbQKKVDA>; Sat, 11 Nov 2000 16:03:00 -0500
Date: Sat, 11 Nov 2000 21:03:56 GMT
Message-Id: <200011112103.VAA31804@tepid.osl.fast.no>
Subject: [patch] patch-2.4.0-test10-irda7 (was: Re: The IrDA patches)
X-Mailer: Pygmy (v0.4.4pre)
Subject: [patch] patch-2.4.0-test10-irda7 (was: Re: The IrDA patches)
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

The name of this patch is irda7.diff. 

(Many thanks to Jean Tourrilhes for splitting up the big patch)

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash
[OUPS   ] : Error that will be fixed in a later patch

irda7.diff :
----------------
	o [CRITICA] Do proper spinlock on the discovery log
	o [CRITICA] Safe concurent reading of discovery log
	o [FEATURE] Remove cruft in af_irda

diff -urpN old-linux/include/net/irda/discovery.h linux/include/net/irda/discovery.h
--- old-linux/include/net/irda/discovery.h	Thu Nov  9 13:29:19 2000
+++ linux/include/net/irda/discovery.h	Thu Nov  9 13:40:12 2000
@@ -65,5 +65,6 @@ typedef struct discovery_t {
 void irlmp_add_discovery(hashbin_t *cachelog, discovery_t *discovery);
 void irlmp_add_discovery_log(hashbin_t *cachelog, hashbin_t *log);
 void irlmp_expire_discoveries(hashbin_t *log, __u32 saddr, int force);
+struct irda_device_info *irlmp_copy_discoveries(hashbin_t *log, int *pn, __u16 mask);
 
 #endif
diff -urpN old-linux/include/net/irda/irlmp.h linux/include/net/irda/irlmp.h
--- old-linux/include/net/irda/irlmp.h	Thu Nov  9 13:27:10 2000
+++ linux/include/net/irda/irlmp.h	Thu Nov  9 13:40:12 2000
@@ -175,10 +175,10 @@ struct irlmp_cb {
  	hashbin_t *clients;
 	hashbin_t *services;
 
-	hashbin_t *cachelog;
-	int running;
+	hashbin_t *cachelog;	/* Current discovery log */
+	spinlock_t log_lock;	/* discovery log spinlock */
 
-	spinlock_t lock;
+	int running;
 
 	__u16_host_order hints; /* Hint bits */
 };
@@ -215,6 +215,7 @@ int  irlmp_disconnect_request(struct lsa
 
 void irlmp_discovery_confirm(hashbin_t *discovery_log);
 void irlmp_discovery_request(int nslots);
+struct irda_device_info *irlmp_get_discoveries(int *pn, __u16 mask);
 void irlmp_do_discovery(int nslots);
 discovery_t *irlmp_get_discovery_response(void);
 
diff -urpN old-linux/net/irda/af_irda.c linux/net/irda/af_irda.c
--- old-linux/net/irda/af_irda.c	Thu Nov  9 13:39:06 2000
+++ linux/net/irda/af_irda.c	Thu Nov  9 13:40:13 2000
@@ -320,65 +320,6 @@ static void irda_flow_indication(void *i
 	}
 }
 
-#if 0
-/* Now obsolete... */
-/*
- * Function irda_getvalue_confirm (obj_id, value, priv)
- *
- *    Got answer from remote LM-IAS
- *
- */
-static void irda_getvalue_confirm(int result, __u16 obj_id, 
-				  struct ias_value *value, void *priv)
-{
-	struct irda_sock *self;
-	
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
-
-	ASSERT(priv != NULL, return;);
-	self = (struct irda_sock *) priv;
-	
-	if (!self) {
-		WARNING(__FUNCTION__ "(), lost myself!\n");
-		return;
-	}
-
-	/* We probably don't need to make any more queries */
-	iriap_close(self->iriap);
-	self->iriap = NULL;
-
-	self->errno = result;
-
-	/* Check if request succeeded */
-	if (result != IAS_SUCCESS) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), IAS query failed!\n");
-
-		/* Wake up any processes waiting for result */
-		wake_up_interruptible(&self->ias_wait);
-
-		return;
-	}
-
-	switch (value->type) {
-	case IAS_INTEGER:
-		IRDA_DEBUG(4, __FUNCTION__ "() int=%d\n", value->t.integer);
-		
-		if (value->t.integer != -1) {
-			self->dtsap_sel = value->t.integer;
-		} else 
-			self->dtsap_sel = 0;
-		break;
-	default:
-		IRDA_DEBUG(0, __FUNCTION__ "(), bad type!\n");
-		break;
-	}
-	irias_delete_value(value);
-
-	/* Wake up any processes waiting for result */
-	wake_up_interruptible(&self->ias_wait);
-}
-#endif
-
 /*
  * Function irda_getvalue_confirm (obj_id, value, priv)
  *
@@ -425,6 +366,8 @@ static void irda_getvalue_confirm(int re
 	wake_up_interruptible(&self->query_wait);
 }
 
+#if 0
+/* Obsolete */
 /*
  * Function irda_discovery_indication (log)
  *
@@ -448,6 +391,7 @@ static void irda_discovery_indication(ha
 	/* Wake up process if its waiting for device to be discovered */
 	wake_up_interruptible(&self->query_wait);
 }
+#endif
 
 /*
  * Function irda_selective_discovery_indication (discovery)
@@ -655,7 +599,7 @@ static int irda_find_lsap_sel(struct ird
 	return -EADDRNOTAVAIL;
 }
 
- /*
+/*
  * Function irda_discover_daddr_and_lsap_sel (self, name)
  *
  *    This try to find a device with the requested service.
@@ -674,8 +618,10 @@ static int irda_find_lsap_sel(struct ird
  */
 static int irda_discover_daddr_and_lsap_sel(struct irda_sock *self, char *name)
 {
-	discovery_t *discovery;
-	int err = -ENETUNREACH;
+	struct irda_device_info *discoveries;	/* Copy of the discovery log */
+	int	number;			/* Number of nodes in the log */
+	int	i;
+	int	err = -ENETUNREACH;
 	__u32	daddr = DEV_ADDR_ANY;	/* Address we found the service on */
 	__u8	dtsap_sel = 0x0;	/* TSAP associated with it */
 
@@ -683,20 +629,13 @@ static int irda_discover_daddr_and_lsap_
 
 	ASSERT(self != NULL, return -1;);
 
-	/* Tell IrLMP we want to be notified */
-	irlmp_update_client(self->ckey, self->mask, NULL, 
-			    irda_discovery_indication, (void *) self);
-	
-	/* Do some discovery (and also return cached discovery results) */
-	irlmp_discovery_request(self->nslots);
-		
-	/* Tell IrLMP that we have been notified */
-	irlmp_update_client(self->ckey, self->mask, NULL, NULL, NULL);
-
+	/* Ask lmp for the current discovery log
+	 * Note : we have to use irlmp_get_discoveries(), as opposed
+	 * to play with the cachelog directly, because while we are
+	 * making our ias query, le log might change... */
+	discoveries = irlmp_get_discoveries(&number, self->mask);
 	/* Check if the we got some results */
-	if (!self->cachelog)
-		/* Wait for answer */
-		/*interruptible_sleep_on(&self->discovery_wait);*/
+	if (discoveries == NULL)
 		return -ENETUNREACH;	/* No nodes discovered */
 
 	/* 
@@ -704,51 +643,45 @@ static int irda_discover_daddr_and_lsap_
 	 * client only about the services that the client is
 	 * interested in...
 	 */
-	discovery = (discovery_t *) hashbin_get_first(self->cachelog);
-	while (discovery != NULL) {
-		/* Mask out the ones we don't want */
-		if (discovery->hints.word & self->mask) {
-			/* Try this address */
-			self->daddr = discovery->daddr;
-			self->saddr = 0x0;
-			IRDA_DEBUG(1, __FUNCTION__ "(), trying daddr = %08x\n",
-				   self->daddr);
-
-			/* Query remote LM-IAS for this service */
-			err = irda_find_lsap_sel(self, name);
-			switch (err) {
-			case 0:
-				/* We found the requested service */
-				if(daddr != DEV_ADDR_ANY) {
-					IRDA_DEBUG(1, __FUNCTION__
-						   "(), discovered service ''%s'' in two different devices !!!\n",
-						   name);
-					self->daddr = DEV_ADDR_ANY;
-					self->cachelog = NULL;
-					return(-ENOTUNIQ);
-				}
-				/* First time we found that one, save it ! */
-				daddr = self->daddr;
-				dtsap_sel = self->dtsap_sel;
-				break;
-			case -EADDRNOTAVAIL:
-				/* Requested service simply doesn't exist on this node */
-				break;
-			default:
-				/* Something bad did happen :-( */
-				IRDA_DEBUG(0, __FUNCTION__
-					   "(), unexpected IAS query failure\n");
+	for(i = 0; i < number; i++) {
+		/* Try the address in the log */
+		self->daddr = discoveries[i].daddr;
+		self->saddr = 0x0;
+		IRDA_DEBUG(1, __FUNCTION__ "(), trying daddr = %08x\n",
+			   self->daddr);
+
+		/* Query remote LM-IAS for this service */
+		err = irda_find_lsap_sel(self, name);
+		switch (err) {
+		case 0:
+			/* We found the requested service */
+			if(daddr != DEV_ADDR_ANY) {
+				IRDA_DEBUG(1, __FUNCTION__
+					   "(), discovered service ''%s'' in two different devices !!!\n",
+					   name);
 				self->daddr = DEV_ADDR_ANY;
-				self->cachelog = NULL;
-				return(-EHOSTUNREACH);
-				break;
+				kfree(discoveries);
+				return(-ENOTUNIQ);
 			}
+			/* First time we found that one, save it ! */
+			daddr = self->daddr;
+			dtsap_sel = self->dtsap_sel;
+			break;
+		case -EADDRNOTAVAIL:
+			/* Requested service simply doesn't exist on this node */
+			break;
+		default:
+			/* Something bad did happen :-( */
+			IRDA_DEBUG(0, __FUNCTION__
+				   "(), unexpected IAS query failure\n");
+			self->daddr = DEV_ADDR_ANY;
+			kfree(discoveries);
+			return(-EHOSTUNREACH);
+			break;
 		}
-
-		/* Next node, maybe we will be more lucky...  */
-		discovery = (discovery_t *) hashbin_get_next(self->cachelog);
 	}
-	self->cachelog = NULL;
+	/* Cleanup our copy of the discovery log */
+	kfree(discoveries);
 
 	/* Check out what we found */
 	if(daddr == DEV_ADDR_ANY) {
@@ -2042,8 +1975,7 @@ static int irda_getsockopt(struct socket
 	struct sock *sk = sock->sk;
 	struct irda_sock *self;
 	struct irda_device_list list;
-	struct irda_device_info *info;
-	discovery_t *discovery;
+	struct irda_device_info *discoveries;
 	struct irda_ias_set	ias_opt;	/* IAS get/query params */
 	struct ias_object *	ias_obj;	/* Object in IAS */
 	struct ias_attrib *	ias_attr;	/* Attribute in IAS object */
@@ -2063,70 +1995,38 @@ static int irda_getsockopt(struct socket
 
 	switch (optname) {
 	case IRLMP_ENUMDEVICES:
-		/* Tell IrLMP we want to be notified */
-		irlmp_update_client(self->ckey, self->mask, NULL, 
-				    irda_discovery_indication, self);
-		
-		/* Do some discovery (and also return cached results) */
-		irlmp_discovery_request(self->nslots);
-		
-		/* Tell IrLMP that we have been notified */
-		irlmp_update_client(self->ckey, self->mask, NULL, NULL, NULL);
-
+		/* Ask lmp for the current discovery log */
+		discoveries = irlmp_get_discoveries(&list.len, self->mask);
 		/* Check if the we got some results */
-		if (!self->cachelog)
+		if (discoveries == NULL)
 			return -EAGAIN;		/* Didn't find any devices */
+		err = 0;
 
-		info = &list.dev[0];
+		/* Write total list length back to client */
+		if (copy_to_user(optval, &list, 
+				 sizeof(struct irda_device_list) -
+				 sizeof(struct irda_device_info)))
+			err = -EFAULT;
 
 		/* Offset to first device entry */
 		offset = sizeof(struct irda_device_list) - 
 			sizeof(struct irda_device_info);
 
-		total = offset;   /* Initialized to size of the device list */
-		list.len = 0;     /* Initialize lenght of list */
-
-		/* 
-		 * Now, check all discovered devices (if any), and notify
-		 * client only about the services that the client is
-		 * interested in 
-		 */
-		discovery = (discovery_t *) hashbin_get_first(self->cachelog);
-		while (discovery != NULL) {
-			/* Mask out the ones we don't want */
-			if (discovery->hints.word & self->mask) {
-				/* Check if room for this device entry */
-				if (len-total<sizeof(struct irda_device_info))
-					break;
-
-				/* Copy discovery information */
-				info->saddr = discovery->saddr;
-				info->daddr = discovery->daddr;
-				info->charset = discovery->charset;
-				info->hints[0] = discovery->hints.byte[0];
-				info->hints[1] = discovery->hints.byte[1];
-				strncpy(info->info, discovery->nickname,
-					NICKNAME_MAX_LEN);
-
-				if (copy_to_user(optval+total, info, 
-						 sizeof(struct irda_device_info)))
-					return -EFAULT;
-				list.len++;
-				total += sizeof(struct irda_device_info);
-			}
-			discovery = (discovery_t *) hashbin_get_next(self->cachelog);
-		}
-		self->cachelog = NULL;
+		/* Copy the list itself */
+		total = offset + (list.len * sizeof(struct irda_device_info));
+		if (total > len)
+			total = len;
+		if (copy_to_user(optval+offset, discoveries, total - offset))
+			err = -EFAULT;
 
 		/* Write total number of bytes used back to client */
 		if (put_user(total, optlen))
-			return -EFAULT;
+			err = -EFAULT;
 
-		/* Write total list length back to client */
-		if (copy_to_user(optval, &list, 
-				 sizeof(struct irda_device_list) -
-				 sizeof(struct irda_device_info)))
-			return -EFAULT;
+		/* Free up our buffer */
+		kfree(discoveries);
+		if (err)
+			return err;
 		break;
 	case IRLMP_MAX_SDU_SIZE:
 		val = self->max_data_size;
diff -urpN old-linux/net/irda/discovery.c linux/net/irda/discovery.c
--- old-linux/net/irda/discovery.c	Thu Nov  9 13:29:19 2000
+++ linux/net/irda/discovery.c	Thu Nov  9 13:40:12 2000
@@ -51,6 +51,7 @@
  * on a binary flag (new/old), because not all discovery events are
  * propagated to them, and they might not always listen, so they would
  * miss some new devices popping up...
+ * Jean II
  */
 void irlmp_add_discovery(hashbin_t *cachelog, discovery_t *new)
 {
@@ -60,7 +61,7 @@ void irlmp_add_discovery(hashbin_t *cach
 	/* Set time of first discovery if node is new (see below) */
 	new->first_timestamp = new->timestamp;
 
-	spin_lock_irqsave(&irlmp->lock, flags);
+	spin_lock_irqsave(&irlmp->log_lock, flags);
 
 	/* 
 	 * Remove all discoveries of devices that has previously been 
@@ -93,7 +94,7 @@ void irlmp_add_discovery(hashbin_t *cach
 	/* Insert the new and updated version */
 	hashbin_insert(cachelog, (queue_t *) new, new->daddr, NULL);
 
-	spin_unlock_irqrestore(&irlmp->lock, flags);
+	spin_unlock_irqrestore(&irlmp->log_lock, flags);
 }
 
 /*
@@ -138,9 +139,12 @@ void irlmp_add_discovery_log(hashbin_t *
 void irlmp_expire_discoveries(hashbin_t *log, __u32 saddr, int force)
 {
 	discovery_t *discovery, *curr;
+	unsigned long flags;
 
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
 
+	spin_lock_irqsave(&irlmp->log_lock, flags);
+
 	discovery = (discovery_t *) hashbin_get_first(log);
 	while (discovery != NULL) {
 		curr = discovery;
@@ -157,6 +161,8 @@ void irlmp_expire_discoveries(hashbin_t 
 				kfree(curr);
 		}
 	}
+
+	spin_unlock_irqrestore(&irlmp->log_lock, flags);
 }
 
 /*
@@ -183,6 +189,75 @@ void irlmp_dump_discoveries(hashbin_t *l
 }
 
 /*
+ * Function irlmp_copy_discoveries (log, pn, mask)
+ *
+ *    Copy all discoveries in a buffer
+ *
+ * This function implement a safe way for lmp clients to access the
+ * discovery log. The basic problem is that we don't want the log
+ * to change (add/remove) while the client is reading it. If the
+ * lmp client manipulate directly the hashbin, he is sure to get
+ * into troubles...
+ * The idea is that we copy all the current discovery log in a buffer
+ * which is specific to the client and pass this copy to him. As we
+ * do this operation with the spinlock grabbed, we are safe...
+ * Note : we don't want those clients to grab the spinlock, because
+ * we have no control on how long they will hold it...
+ * Note : we choose to copy the log in "struct irda_device_info" to
+ * save space...
+ * Note : the client must kfree himself() the log...
+ * Jean II
+ */
+struct irda_device_info *irlmp_copy_discoveries(hashbin_t *log, int *pn, __u16 mask)
+{
+	discovery_t *			discovery;
+	unsigned long			flags;
+	struct irda_device_info *	buffer;
+	int				i = 0;
+	int				n;
+
+	ASSERT(pn != NULL, return NULL;);
+
+	/* Check if log is empty */
+	if(log == NULL)
+		return NULL;
+
+	/* Save spin lock - spinlock should be discovery specific */
+	spin_lock_irqsave(&irlmp->log_lock, flags);
+
+	/* Create the client specific buffer */
+	n = HASHBIN_GET_SIZE(log);
+	buffer = kmalloc(n * sizeof(struct irda_device_info), GFP_ATOMIC);
+	if (buffer == NULL) {
+		spin_unlock_irqrestore(&irlmp->log_lock, flags);
+		return NULL;
+	}
+
+	discovery = (discovery_t *) hashbin_get_first(log);
+	while ((discovery != NULL) && (i < n)) {
+		/* Mask out the ones we don't want */
+		if (discovery->hints.word & mask) {
+			/* Copy discovery information */
+			buffer[i].saddr = discovery->saddr;
+			buffer[i].daddr = discovery->daddr;
+			buffer[i].charset = discovery->charset;
+			buffer[i].hints[0] = discovery->hints.byte[0];
+			buffer[i].hints[1] = discovery->hints.byte[1];
+			strncpy(buffer[i].info, discovery->nickname,
+				NICKNAME_MAX_LEN);
+			i++;
+		}
+		discovery = (discovery_t *) hashbin_get_next(log);
+	}
+
+	spin_unlock_irqrestore(&irlmp->log_lock, flags);
+
+	/* Get the actual number of device in the buffer and return */
+	*pn = i;
+	return(buffer);
+}
+
+/*
  * Function irlmp_find_device (name, saddr)
  *
  *    Look through the discovery log at each of the links and try to find 
@@ -194,7 +269,7 @@ __u32 irlmp_find_device(hashbin_t *cache
 	unsigned long flags;
 	discovery_t *d;
 
-	spin_lock_irqsave(&irlmp->lock, flags);
+	spin_lock_irqsave(&irlmp->log_lock, flags);
 
 	/* Look at all discoveries for that link */
 	d = (discovery_t *) hashbin_get_first(cachelog);
@@ -206,13 +281,13 @@ __u32 irlmp_find_device(hashbin_t *cache
 		if (strcmp(name, d->nickname) == 0) {
 			*saddr = d->saddr;
 			
-			spin_unlock_irqrestore(&irlmp->lock, flags);
+			spin_unlock_irqrestore(&irlmp->log_lock, flags);
 			return d->daddr;
 		}
 		d = (discovery_t *) hashbin_get_next(cachelog);
 	}
 
-	spin_unlock_irqrestore(&irlmp->lock, flags);
+	spin_unlock_irqrestore(&irlmp->log_lock, flags);
 
 	return 0;
 }
diff -urpN old-linux/net/irda/irlmp.c linux/net/irda/irlmp.c
--- old-linux/net/irda/irlmp.c	Thu Nov  9 13:27:10 2000
+++ linux/net/irda/irlmp.c	Thu Nov  9 13:40:12 2000
@@ -81,7 +81,7 @@ int __init irlmp_init(void)
 	memset(irlmp, 0, sizeof(struct irlmp_cb));
 	
 	irlmp->magic = LMP_MAGIC;
-	spin_lock_init(&irlmp->lock);
+	spin_lock_init(&irlmp->log_lock);
 
 	irlmp->clients = hashbin_new(HB_GLOBAL);
 	irlmp->services = hashbin_new(HB_GLOBAL);
@@ -763,6 +763,18 @@ void irlmp_discovery_request(int nslots)
 	 */
 	if (!sysctl_discovery)
 		irlmp_do_discovery(nslots);
+}
+
+/*
+ * Function irlmp_get_discoveries (pn, mask)
+ *
+ *    Return the current discovery log
+ *
+ */
+struct irda_device_info *irlmp_get_discoveries(int *pn, __u16 mask)
+{
+	/* Return current cached discovery log */
+	return(irlmp_copy_discoveries(irlmp->cachelog, pn, mask));
 }
 
 #if 0
diff -urpN old-linux/net/irda/irmod.c linux/net/irda/irmod.c
--- old-linux/net/irda/irmod.c	Mon Oct 16 12:42:54 2000
+++ linux/net/irda/irmod.c	Thu Nov  9 13:40:12 2000
@@ -145,6 +145,8 @@ EXPORT_SYMBOL(irias_new_octseq_value);
 
 /* IrLMP */
 EXPORT_SYMBOL(irlmp_discovery_request);
+EXPORT_SYMBOL(irlmp_get_discoveries);
+EXPORT_SYMBOL(sysctl_discovery_timeout);
 EXPORT_SYMBOL(irlmp_register_client);
 EXPORT_SYMBOL(irlmp_unregister_client);
 EXPORT_SYMBOL(irlmp_update_client);


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
