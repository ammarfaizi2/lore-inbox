Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261409AbTAICnl>; Wed, 8 Jan 2003 21:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261398AbTAICnl>; Wed, 8 Jan 2003 21:43:41 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:1762 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261409AbTAICnM>;
	Wed, 8 Jan 2003 21:43:12 -0500
Date: Wed, 8 Jan 2003 18:51:53 -0800
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] : Discovery locking fixes
Message-ID: <20030109025153.GB19178@bougret.hpl.hp.com>
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

ir254_discovery_locking-2.diff :
------------------------------
	o [CRITICA] Fix remaining locking problem with discovery log
	o [CRITICA] Don't call expiry callback under spinlock
	o [FEATURE] Simplify/cleanup/optimise discovery/expiry code


diff -u -p -r linux/include/net/irda-d4/af_irda.h linux/include/net/irda/af_irda.h
--- linux/include/net/irda-d4/af_irda.h	Mon Nov  4 14:30:49 2002
+++ linux/include/net/irda/af_irda.h	Wed Jan  8 17:00:47 2003
@@ -52,8 +52,8 @@ struct irda_sock {
 	__u8  max_header_size;
 	struct qos_info qos_tx;
 
-	__u16 mask;           /* Hint bits mask */
-	__u16 hints;          /* Hint bits */
+	__u16_host_order mask;           /* Hint bits mask */
+	__u16_host_order hints;          /* Hint bits */
 
 	void *ckey;           /* IrLMP client handle */
 	void *skey;           /* IrLMP service handle */
@@ -63,7 +63,7 @@ struct irda_sock {
 	struct ias_value *ias_result; /* Result of remote IAS query */
 
 	hashbin_t *cachelog;		/* Result of discovery query */
-	struct discovery_t *cachediscovery;	/* Result of selective discovery query */
+	__u32 cachedaddr;	/* Result of selective discovery query */
 
 	int nslots;           /* Number of slots to use for discovery */
 
diff -u -p -r linux/include/net/irda-d4/discovery.h linux/include/net/irda/discovery.h
--- linux/include/net/irda-d4/discovery.h	Mon Nov  4 14:30:36 2002
+++ linux/include/net/irda/discovery.h	Wed Jan  8 17:00:47 2003
@@ -46,12 +46,20 @@
  *  little endian format. A little endian machine stores MSB of word in
  *  byte[1] and LSB in byte[0]. A big endian machine stores MSB in byte[0] 
  *  and LSB in byte[1].
+ *
+ * This structure is used in the code for things that are endian neutral
+ * but that fit in a word so that we can manipulate them efficiently.
+ * By endian neutral, I mean things that are really an array of bytes,
+ * and always used as such, for example the hint bits. Jean II
  */
 typedef union {
 	__u16 word;
 	__u8  byte[2];
 } __u16_host_order;
 
+/* Same purpose, different application */
+#define u16ho(array) (* ((__u16 *) array))
+
 /* Types of discovery */
 typedef enum {
 	DISCOVERY_LOG,		/* What's in our discovery log */
@@ -62,30 +70,31 @@ typedef enum {
 
 #define NICKNAME_MAX_LEN 21
 
+/* Basic discovery information about a peer */
+typedef struct irda_device_info		discinfo_t;	/* linux/irda.h */
+
 /*
  * The DISCOVERY structure is used for both discovery requests and responses
  */
 typedef struct discovery_t {
-	irda_queue_t q;          /* Must be first! */
+	irda_queue_t	q;		/* Must be first! */
+
+	discinfo_t	data;		/* Basic discovery information */
+	int		name_len;	/* Lenght of nickname */
 
-	__u32      saddr;        /* Which link the device was discovered */
-	__u32      daddr;        /* Remote device address */
-	LAP_REASON condition;    /* More info about the discovery */
-
-	__u16_host_order hints;  /* Discovery hint bits */
-	__u8       charset;      /* Encoding of nickname */
-	char       nickname[22]; /* The name of the device (21 bytes + \0) */
-	int        name_len;     /* Lenght of nickname */
-
-	int        gen_addr_bit; /* Need to generate a new device address? */
-	int        nslots;       /* Number of slots to use when discovering */
-	unsigned long timestamp; /* Time discovered */
-	unsigned long first_timestamp; /* First time discovered */
+	LAP_REASON	condition;	/* More info about the discovery */
+	int		gen_addr_bit;	/* Need to generate a new device
+					 * address? */
+	int		nslots;		/* Number of slots to use when
+					 * discovering */
+	unsigned long	timestamp;	/* Last time discovered */
+	unsigned long	firststamp;	/* First time discovered */
 } discovery_t;
 
 void irlmp_add_discovery(hashbin_t *cachelog, discovery_t *discovery);
 void irlmp_add_discovery_log(hashbin_t *cachelog, hashbin_t *log);
 void irlmp_expire_discoveries(hashbin_t *log, __u32 saddr, int force);
-struct irda_device_info *irlmp_copy_discoveries(hashbin_t *log, int *pn, __u16 mask);
+struct irda_device_info *irlmp_copy_discoveries(hashbin_t *log, int *pn,
+						__u16 mask, int old_entries);
 
 #endif
diff -u -p -r linux/include/net/irda-d4/irlan_client.h linux/include/net/irda/irlan_client.h
--- linux/include/net/irda-d4/irlan_client.h	Mon Nov  4 14:30:47 2002
+++ linux/include/net/irda/irlan_client.h	Wed Jan  8 17:00:47 2003
@@ -34,7 +34,7 @@
 #include <net/irda/irlan_event.h>
 
 void irlan_client_start_kick_timer(struct irlan_cb *self, int timeout);
-void irlan_client_discovery_indication(discovery_t *, DISCOVERY_MODE, void *);
+void irlan_client_discovery_indication(discinfo_t *, DISCOVERY_MODE, void *);
 void irlan_client_wakeup(struct irlan_cb *self, __u32 saddr, __u32 daddr);
 
 void irlan_client_open_ctrl_tsap( struct irlan_cb *self);
diff -u -p -r linux/include/net/irda-d4/irlmp.h linux/include/net/irda/irlmp.h
--- linux/include/net/irda-d4/irlmp.h	Mon Nov  4 14:30:04 2002
+++ linux/include/net/irda/irlmp.h	Wed Jan  8 17:00:47 2003
@@ -58,7 +58,7 @@
 #define LM_IDLE_TIMEOUT     2*HZ /* 2 seconds for now */
 
 typedef enum {
-	S_PNP,
+	S_PNP = 0,
 	S_PDA,
 	S_COMPUTER,
 	S_PRINTER,
@@ -72,22 +72,24 @@ typedef enum {
 	S_END,
 } SERVICE;
 
-typedef void (*DISCOVERY_CALLBACK1) (discovery_t *, DISCOVERY_MODE, void *);
-typedef void (*DISCOVERY_CALLBACK2) (hashbin_t *, void *);
+/* For selective discovery */
+typedef void (*DISCOVERY_CALLBACK1) (discinfo_t *, DISCOVERY_MODE, void *);
+/* For expiry (the same) */
+typedef void (*DISCOVERY_CALLBACK2) (discinfo_t *, DISCOVERY_MODE, void *);
 
 typedef struct {
 	irda_queue_t queue; /* Must be first */
 
-	__u16 hints; /* Hint bits */
+	__u16_host_order hints; /* Hint bits */
 } irlmp_service_t;
 
 typedef struct {
 	irda_queue_t queue; /* Must be first */
 
-	__u16 hint_mask;
+	__u16_host_order hint_mask;
 
 	DISCOVERY_CALLBACK1 disco_callback;	/* Selective discovery */
-	DISCOVERY_CALLBACK1 expir_callback;	/* Selective expiration */
+	DISCOVERY_CALLBACK2 expir_callback;	/* Selective expiration */
 	void *priv;                /* Used to identify client */
 } irlmp_client_t;
 
@@ -199,11 +201,11 @@ __u16 irlmp_service_to_hint(int service)
 void *irlmp_register_service(__u16 hints);
 int irlmp_unregister_service(void *handle);
 void *irlmp_register_client(__u16 hint_mask, DISCOVERY_CALLBACK1 disco_clb,
-			    DISCOVERY_CALLBACK1 expir_clb, void *priv);
+			    DISCOVERY_CALLBACK2 expir_clb, void *priv);
 int irlmp_unregister_client(void *handle);
 int irlmp_update_client(void *handle, __u16 hint_mask, 
 			DISCOVERY_CALLBACK1 disco_clb,
-			DISCOVERY_CALLBACK1 expir_clb, void *priv);
+			DISCOVERY_CALLBACK2 expir_clb, void *priv);
 
 void irlmp_register_link(struct irlap_cb *, __u32 saddr, notify_t *);
 void irlmp_unregister_link(__u32 saddr);
@@ -222,11 +224,11 @@ int  irlmp_disconnect_request(struct lsa
 
 void irlmp_discovery_confirm(hashbin_t *discovery_log, DISCOVERY_MODE mode);
 void irlmp_discovery_request(int nslots);
-struct irda_device_info *irlmp_get_discoveries(int *pn, __u16 mask, int nslots);
+discinfo_t *irlmp_get_discoveries(int *pn, __u16 mask, int nslots);
 void irlmp_do_expiry(void);
 void irlmp_do_discovery(int nslots);
 discovery_t *irlmp_get_discovery_response(void);
-void irlmp_discovery_expiry(discovery_t *expiry);
+void irlmp_discovery_expiry(discinfo_t *expiry, int number);
 
 int  irlmp_data_request(struct lsap_cb *, struct sk_buff *);
 void irlmp_data_indication(struct lsap_cb *, struct sk_buff *);
diff -u -p -r linux/net/irda-d4/af_irda.c linux/net/irda/af_irda.c
--- linux/net/irda-d4/af_irda.c	Tue Jan  7 17:59:03 2003
+++ linux/net/irda/af_irda.c	Wed Jan  8 17:00:47 2003
@@ -401,11 +401,10 @@ static void irda_getvalue_confirm(int re
  *
  *    Got a selective discovery indication from IrLMP.
  *
- * IrLMP is telling us that this node is matching our hint bit
- * filter. Check if it's a newly discovered node (or if node changed its
- * hint bits), and then wake up any process waiting for answer...
+ * IrLMP is telling us that this node is new and matching our hint bit
+ * filter. Wake up any process waiting for answer...
  */
-static void irda_selective_discovery_indication(discovery_t *discovery,
+static void irda_selective_discovery_indication(discinfo_t *discovery,
 						DISCOVERY_MODE mode,
 						void *priv)
 {
@@ -419,18 +418,8 @@ static void irda_selective_discovery_ind
 		return;
 	}
 
-	/* Check if node is discovered is a new one or an old one.
-	 * We check when how long ago this node was discovered, with a
-	 * coarse timeout (we may miss some discovery events or be delayed).
-	 * Note : by doing this test here, we avoid waking up a process ;-)
-	 */
-	if((jiffies - discovery->first_timestamp) >
-	   (sysctl_discovery_timeout * HZ)) {
-		return;		/* Too old, not interesting -> goodbye */
-	}
-
 	/* Pass parameter to the caller */
-	self->cachediscovery = discovery;
+	self->cachedaddr = discovery->daddr;
 
 	/* Wake up process if its waiting for device to be discovered */
 	wake_up_interruptible(&self->query_wait);
@@ -455,7 +444,7 @@ static void irda_discovery_timeout(u_lon
 
 	/* Nothing for the caller */
 	self->cachelog = NULL;
-	self->cachediscovery = NULL;
+	self->cachedaddr = 0;
 	self->errno = -ETIME;
 
 	/* Wake up process if its still waiting... */
@@ -627,7 +616,7 @@ static int irda_find_lsap_sel(struct ird
  */
 static int irda_discover_daddr_and_lsap_sel(struct irda_sock *self, char *name)
 {
-	struct irda_device_info *discoveries;	/* Copy of the discovery log */
+	discinfo_t *discoveries;	/* Copy of the discovery log */
 	int	number;			/* Number of nodes in the log */
 	int	i;
 	int	err = -ENETUNREACH;
@@ -642,7 +631,8 @@ static int irda_discover_daddr_and_lsap_
 	 * Note : we have to use irlmp_get_discoveries(), as opposed
 	 * to play with the cachelog directly, because while we are
 	 * making our ias query, le log might change... */
-	discoveries = irlmp_get_discoveries(&number, self->mask, self->nslots);
+	discoveries = irlmp_get_discoveries(&number, self->mask.word,
+					    self->nslots);
 	/* Check if the we got some results */
 	if (discoveries == NULL)
 		return -ENETUNREACH;	/* No nodes discovered */
@@ -1137,7 +1127,7 @@ static int irda_create(struct socket *so
 
 	/* Register as a client with IrLMP */
 	self->ckey = irlmp_register_client(0, NULL, NULL, NULL);
-	self->mask = 0xffff;
+	self->mask.word = 0xffff;
 	self->rx_flow = self->tx_flow = FLOW_START;
 	self->nslots = DISCOVERY_DEFAULT_SLOTS;
 	self->daddr = DEV_ADDR_ANY;	/* Until we get connected */
@@ -1999,6 +1989,7 @@ static int irda_setsockopt(struct socket
 		if (optlen < sizeof(int))
 			return -EINVAL;
 
+		/* The input is really a (__u8 hints[2]), easier as an int */
 		if (get_user(opt, (int *)optval))
 			return -EFAULT;
 
@@ -2017,16 +2008,17 @@ static int irda_setsockopt(struct socket
 		if (optlen < sizeof(int))
 			return -EINVAL;
 
+		/* The input is really a (__u8 hints[2]), easier as an int */
 		if (get_user(opt, (int *)optval))
 			return -EFAULT;
 
 		/* Set the new hint mask */
-		self->mask = (__u16) opt;
+		self->mask.word = (__u16) opt;
 		/* Mask out extension bits */
-		self->mask &= 0x7f7f;
+		self->mask.word &= 0x7f7f;
 		/* Check if no bits */
-		if(!self->mask)
-			self->mask = 0xFFFF;
+		if(!self->mask.word)
+			self->mask.word = 0xFFFF;
 
 		break;
 	default:
@@ -2117,7 +2109,7 @@ static int irda_getsockopt(struct socket
 	switch (optname) {
 	case IRLMP_ENUMDEVICES:
 		/* Ask lmp for the current discovery log */
-		discoveries = irlmp_get_discoveries(&list.len, self->mask,
+		discoveries = irlmp_get_discoveries(&list.len, self->mask.word,
 						    self->nslots);
 		/* Check if the we got some results */
 		if (discoveries == NULL)
@@ -2349,7 +2341,7 @@ bed:
 			return -EFAULT;
 
 		/* Tell IrLMP we want to be notified */
-		irlmp_update_client(self->ckey, self->mask,
+		irlmp_update_client(self->ckey, self->mask.word,
 				    irda_selective_discovery_indication,
 				    NULL, (void *) self);
 
@@ -2357,7 +2349,7 @@ bed:
 		irlmp_discovery_request(self->nslots);
 
 		/* Wait until a node is discovered */
-		if (!self->cachediscovery) {
+		if (!self->cachedaddr) {
 			int ret = 0;
 
 			IRDA_DEBUG(1, "%s(), nothing discovered yet, going to sleep...\n", __FUNCTION__);
@@ -2372,7 +2364,7 @@ bed:
 
 			/* Wait for IR-LMP to call us back */
 			__wait_event_interruptible(self->query_wait,
-			   (self->cachediscovery!=NULL || self->errno==-ETIME),
+			      (self->cachedaddr != 0 || self->errno == -ETIME),
 						   ret);
 
 			/* If watchdog is still activated, kill it! */
@@ -2389,19 +2381,25 @@ bed:
 				   __FUNCTION__);
 
 		/* Tell IrLMP that we have been notified */
-		irlmp_update_client(self->ckey, self->mask, NULL, NULL, NULL);
+		irlmp_update_client(self->ckey, self->mask.word,
+				    NULL, NULL, NULL);
 
 		/* Check if the we got some results */
-		if (!self->cachediscovery)
+		if (!self->cachedaddr)
 			return -EAGAIN;		/* Didn't find any devices */
+		daddr = self->cachedaddr;
 		/* Cleanup */
-		self->cachediscovery = NULL;
+		self->cachedaddr = 0;
 
-		/* Note : We don't return anything to the user.
-		 * We could return the device that triggered the wake up,
-		 * but it's probably better to force the user to query
-		 * the whole discovery log and let him pick one device...
+		/* We return the daddr of the device that trigger the
+		 * wakeup. As irlmp pass us only the new devices, we
+		 * are sure that it's not an old device.
+		 * If the user want more details, he should query
+		 * the whole discovery log and pick one device...
 		 */
+		if (put_user(daddr, (int *)optval))
+			return -EFAULT;
+
 		break;
 	default:
 		return -ENOPROTOOPT;
diff -u -p -r linux/net/irda-d4/discovery.c linux/net/irda/discovery.c
--- linux/net/irda-d4/discovery.c	Mon Nov  4 14:30:15 2002
+++ linux/net/irda/discovery.c	Wed Jan  8 17:00:47 2003
@@ -59,7 +59,7 @@ void irlmp_add_discovery(hashbin_t *cach
 	unsigned long flags;
 
 	/* Set time of first discovery if node is new (see below) */
-	new->first_timestamp = new->timestamp;
+	new->firststamp = new->timestamp;
 
 	spin_lock_irqsave(&cachelog->hb_spinlock, flags);
 
@@ -76,24 +76,24 @@ void irlmp_add_discovery(hashbin_t *cach
 		/* Be sure to stay one item ahead */
 		discovery = (discovery_t *) hashbin_get_next(cachelog);
 
-		if ((node->saddr == new->saddr) &&
-		    ((node->daddr == new->daddr) || 
-		     (strcmp(node->nickname, new->nickname) == 0)))
+		if ((node->data.saddr == new->data.saddr) &&
+		    ((node->data.daddr == new->data.daddr) || 
+		     (strcmp(node->data.info, new->data.info) == 0)))
 		{
 			/* This discovery is a previous discovery 
 			 * from the same device, so just remove it
 			 */
 			hashbin_remove_this(cachelog, (irda_queue_t *) node);
-			/* Check if hints bits have changed */
-			if(node->hints.word == new->hints.word)
+			/* Check if hints bits are unchanged */
+			if(u16ho(node->data.hints) == u16ho(new->data.hints))
 				/* Set time of first discovery for this node */
-				new->first_timestamp = node->first_timestamp;
+				new->firststamp = node->firststamp;
 			kfree(node);
 		}
 	}
 
 	/* Insert the new and updated version */
-	hashbin_insert(cachelog, (irda_queue_t *) new, new->daddr, NULL);
+	hashbin_insert(cachelog, (irda_queue_t *) new, new->data.daddr, NULL);
 
 	spin_unlock_irqrestore(&cachelog->hb_spinlock, flags);
 }
@@ -147,27 +147,50 @@ void irlmp_add_discovery_log(hashbin_t *
  */
 void irlmp_expire_discoveries(hashbin_t *log, __u32 saddr, int force)
 {
-	discovery_t *discovery, *curr;
-	unsigned long flags;
+	discovery_t *		discovery;
+	discovery_t *		curr;
+	unsigned long		flags;
+	discinfo_t *		buffer = NULL;
+	int			n;		/* Size of the full log */
+	int			i = 0;		/* How many we expired */
 
+	ASSERT(log != NULL, return;);
 	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	spin_lock_irqsave(&log->hb_spinlock, flags);
 
 	discovery = (discovery_t *) hashbin_get_first(log);
 	while (discovery != NULL) {
-		curr = discovery;
-
 		/* Be sure to be one item ahead */
+		curr = discovery;
 		discovery = (discovery_t *) hashbin_get_next(log);
 
 		/* Test if it's time to expire this discovery */
-		if ((curr->saddr == saddr) &&
+		if ((curr->data.saddr == saddr) &&
 		    (force ||
 		     ((jiffies - curr->timestamp) > DISCOVERY_EXPIRE_TIMEOUT)))
 		{
-			/* Tell IrLMP and registered clients about it */
-			irlmp_discovery_expiry(curr);
+			/* Create buffer as needed.
+			 * As this function get called a lot and most time
+			 * we don't have anything to put in the log (we are
+			 * quite picky), we can save a lot of overhead
+			 * by not calling kmalloc. Jean II */
+			if(buffer == NULL) {
+				/* Create the client specific buffer */
+				n = HASHBIN_GET_SIZE(log);
+				buffer = kmalloc(n * sizeof(struct irda_device_info), GFP_ATOMIC);
+				if (buffer == NULL) {
+					spin_unlock_irqrestore(&log->hb_spinlock, flags);
+					return;
+				}
+
+			}
+
+			/* Copy discovery information */
+			memcpy(&(buffer[i]), &(curr->data),
+			       sizeof(discinfo_t));
+			i++;
+
 			/* Remove it from the log */
 			curr = hashbin_remove_this(log, (irda_queue_t *) curr);
 			if (curr)
@@ -175,9 +198,23 @@ void irlmp_expire_discoveries(hashbin_t 
 		}
 	}
 
+	/* Drop the spinlock before calling the higher layers, as
+	 * we can't guarantee they won't call us back and create a
+	 * deadlock. We will work on our own private data, so we
+	 * don't care to be interupted. - Jean II */
 	spin_unlock_irqrestore(&log->hb_spinlock, flags);
+
+	if(buffer == NULL)
+		return;
+
+	/* Tell IrLMP and registered clients about it */
+	irlmp_discovery_expiry(buffer, i);
+
+	/* Free up our buffer */
+	kfree(buffer);
 }
 
+#if 0
 /*
  * Function irlmp_dump_discoveries (log)
  *
@@ -193,13 +230,14 @@ void irlmp_dump_discoveries(hashbin_t *l
 	discovery = (discovery_t *) hashbin_get_first(log);
 	while (discovery != NULL) {
 		IRDA_DEBUG(0, "Discovery:\n");
-		IRDA_DEBUG(0, "  daddr=%08x\n", discovery->daddr);
-		IRDA_DEBUG(0, "  saddr=%08x\n", discovery->saddr); 
-		IRDA_DEBUG(0, "  nickname=%s\n", discovery->nickname);
+		IRDA_DEBUG(0, "  daddr=%08x\n", discovery->data.daddr);
+		IRDA_DEBUG(0, "  saddr=%08x\n", discovery->data.saddr); 
+		IRDA_DEBUG(0, "  nickname=%s\n", discovery->data.info);
 
 		discovery = (discovery_t *) hashbin_get_next(log);
 	}
 }
+#endif
 
 /*
  * Function irlmp_copy_discoveries (log, pn, mask)
@@ -221,43 +259,49 @@ void irlmp_dump_discoveries(hashbin_t *l
  * Note : the client must kfree himself() the log...
  * Jean II
  */
-struct irda_device_info *irlmp_copy_discoveries(hashbin_t *log, int *pn, __u16 mask)
+struct irda_device_info *irlmp_copy_discoveries(hashbin_t *log, int *pn,
+						__u16 mask, int old_entries)
 {
-	discovery_t *			discovery;
-	unsigned long			flags;
-	struct irda_device_info *	buffer;
-	int				i = 0;
-	int				n;
+	discovery_t *		discovery;
+	unsigned long		flags;
+	discinfo_t *		buffer = NULL;
+	int			j_timeout = (sysctl_discovery_timeout * HZ);
+	int			n;		/* Size of the full log */
+	int			i = 0;		/* How many we picked */
 
 	ASSERT(pn != NULL, return NULL;);
+	ASSERT(log != NULL, return NULL;);
 
-	/* Check if log is empty */
-	if(log == NULL)
-		return NULL;
-
-	/* Save spin lock - spinlock should be discovery specific */
+	/* Save spin lock */
 	spin_lock_irqsave(&log->hb_spinlock, flags);
 
-	/* Create the client specific buffer */
-	n = HASHBIN_GET_SIZE(log);
-	buffer = kmalloc(n * sizeof(struct irda_device_info), GFP_ATOMIC);
-	if (buffer == NULL) {
-		spin_unlock_irqrestore(&log->hb_spinlock, flags);
-		return NULL;
-	}
-
 	discovery = (discovery_t *) hashbin_get_first(log);
-	while ((discovery != NULL) && (i < n)) {
-		/* Mask out the ones we don't want */
-		if (discovery->hints.word & mask) {
+	while (discovery != NULL) {
+		/* Mask out the ones we don't want :
+		 * We want to match the discovery mask, and to get only
+		 * the most recent one (unless we want old ones) */
+		if ((u16ho(discovery->data.hints) & mask) &&
+		    ((old_entries) ||
+		     ((jiffies - discovery->firststamp) < j_timeout)) ) {
+			/* Create buffer as needed.
+			 * As this function get called a lot and most time
+			 * we don't have anything to put in the log (we are
+			 * quite picky), we can save a lot of overhead
+			 * by not calling kmalloc. Jean II */
+			if(buffer == NULL) {
+				/* Create the client specific buffer */
+				n = HASHBIN_GET_SIZE(log);
+				buffer = kmalloc(n * sizeof(struct irda_device_info), GFP_ATOMIC);
+				if (buffer == NULL) {
+					spin_unlock_irqrestore(&log->hb_spinlock, flags);
+					return NULL;
+				}
+
+			}
+
 			/* Copy discovery information */
-			buffer[i].saddr = discovery->saddr;
-			buffer[i].daddr = discovery->daddr;
-			buffer[i].charset = discovery->charset;
-			buffer[i].hints[0] = discovery->hints.byte[0];
-			buffer[i].hints[1] = discovery->hints.byte[1];
-			strncpy(buffer[i].info, discovery->nickname,
-				NICKNAME_MAX_LEN);
+			memcpy(&(buffer[i]), &(discovery->data),
+			       sizeof(discinfo_t));
 			i++;
 		}
 		discovery = (discovery_t *) hashbin_get_next(log);
@@ -288,14 +332,14 @@ __u32 irlmp_find_device(hashbin_t *cache
 	d = (discovery_t *) hashbin_get_first(cachelog);
 	while (d != NULL) {
 		IRDA_DEBUG(1, "Discovery:\n");
-		IRDA_DEBUG(1, "  daddr=%08x\n", d->daddr);
-		IRDA_DEBUG(1, "  nickname=%s\n", d->nickname);
-		
-		if (strcmp(name, d->nickname) == 0) {
-			*saddr = d->saddr;
+		IRDA_DEBUG(1, "  daddr=%08x\n", d->data.daddr);
+		IRDA_DEBUG(1, "  nickname=%s\n", d->data.info);
+
+		if (strcmp(name, d->data.info) == 0) {
+			*saddr = d->data.saddr;
 			
 			spin_unlock_irqrestore(&cachelog->hb_spinlock, flags);
-			return d->daddr;
+			return d->data.daddr;
 		}
 		d = (discovery_t *) hashbin_get_next(cachelog);
 	}
@@ -328,41 +372,41 @@ int discovery_proc_read(char *buf, char 
 
 	discovery = (discovery_t *) hashbin_get_first(cachelog);
 	while (( discovery != NULL) && (len < length)) {
-		len += sprintf(buf+len, "nickname: %s,", discovery->nickname);
+		len += sprintf(buf+len, "nickname: %s,", discovery->data.info);
 		
 		len += sprintf(buf+len, " hint: 0x%02x%02x", 
-			       discovery->hints.byte[0], 
-			       discovery->hints.byte[1]);
+			       discovery->data.hints[0], 
+			       discovery->data.hints[1]);
 #if 0
-		if ( discovery->hints.byte[0] & HINT_PNP)
+		if ( discovery->data.hints[0] & HINT_PNP)
 			len += sprintf( buf+len, "PnP Compatible ");
-		if ( discovery->hints.byte[0] & HINT_PDA)
+		if ( discovery->data.hints[0] & HINT_PDA)
 			len += sprintf( buf+len, "PDA/Palmtop ");
-		if ( discovery->hints.byte[0] & HINT_COMPUTER)
+		if ( discovery->data.hints[0] & HINT_COMPUTER)
 			len += sprintf( buf+len, "Computer ");
-		if ( discovery->hints.byte[0] & HINT_PRINTER)
+		if ( discovery->data.hints[0] & HINT_PRINTER)
 			len += sprintf( buf+len, "Printer ");
-		if ( discovery->hints.byte[0] & HINT_MODEM)
+		if ( discovery->data.hints[0] & HINT_MODEM)
 			len += sprintf( buf+len, "Modem ");
-		if ( discovery->hints.byte[0] & HINT_FAX)
+		if ( discovery->data.hints[0] & HINT_FAX)
 			len += sprintf( buf+len, "Fax ");
-		if ( discovery->hints.byte[0] & HINT_LAN)
+		if ( discovery->data.hints[0] & HINT_LAN)
 			len += sprintf( buf+len, "LAN Access ");
 		
-		if ( discovery->hints.byte[1] & HINT_TELEPHONY)
+		if ( discovery->data.hints[1] & HINT_TELEPHONY)
 			len += sprintf( buf+len, "Telephony ");
-		if ( discovery->hints.byte[1] & HINT_FILE_SERVER)
+		if ( discovery->data.hints[1] & HINT_FILE_SERVER)
 			len += sprintf( buf+len, "File Server ");       
-		if ( discovery->hints.byte[1] & HINT_COMM)
+		if ( discovery->data.hints[1] & HINT_COMM)
 			len += sprintf( buf+len, "IrCOMM ");
-		if ( discovery->hints.byte[1] & HINT_OBEX)
+		if ( discovery->data.hints[1] & HINT_OBEX)
 			len += sprintf( buf+len, "IrOBEX ");
 #endif		
 		len += sprintf(buf+len, ", saddr: 0x%08x", 
-			       discovery->saddr);
+			       discovery->data.saddr);
 
 		len += sprintf(buf+len, ", daddr: 0x%08x\n", 
-			       discovery->daddr);
+			       discovery->data.daddr);
 		
 		len += sprintf(buf+len, "\n");
 		
diff -u -p -r linux/net/irda-d4/ircomm/ircomm_tty_attach.c linux/net/irda/ircomm/ircomm_tty_attach.c
--- linux/net/irda-d4/ircomm/ircomm_tty_attach.c	Mon Nov  4 14:30:50 2002
+++ linux/net/irda/ircomm/ircomm_tty_attach.c	Wed Jan  8 17:00:47 2003
@@ -46,7 +46,7 @@
 #include <net/irda/ircomm_tty_attach.h>
 
 static void ircomm_tty_ias_register(struct ircomm_tty_cb *self);
-static void ircomm_tty_discovery_indication(discovery_t *discovery,
+static void ircomm_tty_discovery_indication(discinfo_t *discovery,
 					    DISCOVERY_MODE mode,
 					    void *priv);
 static void ircomm_tty_getvalue_confirm(int result, __u16 obj_id, 
@@ -305,7 +305,7 @@ int ircomm_tty_send_initial_parameters(s
  *    device it is, and which services it has.
  *
  */
-static void ircomm_tty_discovery_indication(discovery_t *discovery,
+static void ircomm_tty_discovery_indication(discinfo_t *discovery,
 					    DISCOVERY_MODE mode,
 					    void *priv)
 {
diff -u -p -r linux/net/irda-d4/irlan/irlan_client.c linux/net/irda/irlan/irlan_client.c
--- linux/net/irda-d4/irlan/irlan_client.c	Mon Nov  4 14:30:31 2002
+++ linux/net/irda/irlan/irlan_client.c	Wed Jan  8 17:00:47 2003
@@ -145,7 +145,7 @@ void irlan_client_wakeup(struct irlan_cb
  *    Remote device with IrLAN server support discovered
  *
  */
-void irlan_client_discovery_indication(discovery_t *discovery,
+void irlan_client_discovery_indication(discinfo_t *discovery,
 				       DISCOVERY_MODE mode,
 				       void *priv) 
 {
diff -u -p -r linux/net/irda-d4/irlap_event.c linux/net/irda/irlap_event.c
--- linux/net/irda-d4/irlap_event.c	Mon Nov  4 14:30:33 2002
+++ linux/net/irda/irlap_event.c	Wed Jan  8 17:00:47 2003
@@ -419,7 +419,7 @@ static int irlap_state_ndm(struct irlap_
 								   info->s);
 			if (self->slot == info->s) {
 				discovery_rsp = irlmp_get_discovery_response();
-				discovery_rsp->daddr = info->daddr;
+				discovery_rsp->data.daddr = info->daddr;
 
 				irlap_send_discovery_xid_frame(self, info->S,
 							       self->slot,
@@ -576,7 +576,7 @@ static int irlap_state_query(struct irla
 		ASSERT(info->discovery != NULL, return -1;);
 
 		IRDA_DEBUG(4, "%s(), daddr=%08x\n", __FUNCTION__,
-			   info->discovery->daddr);
+			   info->discovery->data.daddr);
 
 		if (!self->discovery_log) {
 			WARNING("%s: discovery log is gone! "
@@ -586,7 +586,7 @@ static int irlap_state_query(struct irla
 		}
 		hashbin_insert(self->discovery_log,
 			       (irda_queue_t *) info->discovery,
-			       info->discovery->daddr, NULL);
+			       info->discovery->data.daddr, NULL);
 
 		/* Keep state */
 		/* irlap_next_state(self, LAP_QUERY);  */
@@ -704,7 +704,7 @@ static int irlap_state_reply(struct irla
 			irlap_discovery_indication(self, info->discovery);
 		} else if ((info->s >= self->slot) && (!self->frame_sent)) {
 			discovery_rsp = irlmp_get_discovery_response();
-			discovery_rsp->daddr = info->daddr;
+			discovery_rsp->data.daddr = info->daddr;
 
 			irlap_send_discovery_xid_frame(self, info->S,
 						       self->slot, FALSE,
diff -u -p -r linux/net/irda-d4/irlap_frame.c linux/net/irda/irlap_frame.c
--- linux/net/irda-d4/irlap_frame.c	Tue Jan  7 17:58:39 2003
+++ linux/net/irda/irlap_frame.c	Wed Jan  8 17:00:47 2003
@@ -335,7 +335,7 @@ void irlap_send_discovery_xid_frame(stru
 	if (command)
 		frame->daddr = cpu_to_le32(bcast);
 	else
-		frame->daddr = cpu_to_le32(discovery->daddr);
+		frame->daddr = cpu_to_le32(discovery->data.daddr);
 
 	switch (S) {
 	case 1:
@@ -366,20 +366,20 @@ void irlap_send_discovery_xid_frame(stru
 	if (!command || (frame->slotnr == 0xff)) {
 		int len;
 
-		if (discovery->hints.byte[0] & HINT_EXTENSION) {
+		if (discovery->data.hints[0] & HINT_EXTENSION) {
 			info = skb_put(skb, 2);
-			info[0] = discovery->hints.byte[0];
-			info[1] = discovery->hints.byte[1];
+			info[0] = discovery->data.hints[0];
+			info[1] = discovery->data.hints[1];
 		} else {
 			info = skb_put(skb, 1);
-			info[0] = discovery->hints.byte[0];
+			info[0] = discovery->data.hints[0];
 		}
 		info = skb_put(skb, 1);
-		info[0] = discovery->charset;
+		info[0] = discovery->data.charset;
 
 		len = IRDA_MIN(discovery->name_len, skb_tailroom(skb));
 		info = skb_put(skb, len);
-		memcpy(info, discovery->nickname, len);
+		memcpy(info, discovery->data.info, len);
 	}
 	irlap_queue_xmit(self, skb);
 }
@@ -422,24 +422,25 @@ static void irlap_recv_discovery_xid_rsp
 	}
 	memset(discovery, 0, sizeof(discovery_t));
 
-	discovery->daddr = info->daddr;
-	discovery->saddr = self->saddr;
+	discovery->data.daddr = info->daddr;
+	discovery->data.saddr = self->saddr;
 	discovery->timestamp = jiffies;
 
-	IRDA_DEBUG(4, "%s(), daddr=%08x\n", __FUNCTION__, discovery->daddr);
+	IRDA_DEBUG(4, "%s(), daddr=%08x\n", __FUNCTION__,
+		   discovery->data.daddr);
 
 	discovery_info = skb_pull(skb, sizeof(struct xid_frame));
 
 	/* Get info returned from peer */
-	discovery->hints.byte[0] = discovery_info[0];
+	discovery->data.hints[0] = discovery_info[0];
 	if (discovery_info[0] & HINT_EXTENSION) {
 		IRDA_DEBUG(4, "EXTENSION\n");
-		discovery->hints.byte[1] = discovery_info[1];
-		discovery->charset = discovery_info[2];
+		discovery->data.hints[1] = discovery_info[1];
+		discovery->data.charset = discovery_info[2];
 		text = (char *) &discovery_info[3];
 	} else {
-		discovery->hints.byte[1] = 0;
-		discovery->charset = discovery_info[1];
+		discovery->data.hints[1] = 0;
+		discovery->data.charset = discovery_info[1];
 		text = (char *) &discovery_info[2];
 	}
 	/*
@@ -447,8 +448,8 @@ static void irlap_recv_discovery_xid_rsp
 	 *  FCS bytes resides.
 	 */
 	skb->data[skb->len] = '\0';
-	strncpy(discovery->nickname, text, NICKNAME_MAX_LEN);
-	discovery->name_len = strlen(discovery->nickname);
+	strncpy(discovery->data.info, text, NICKNAME_MAX_LEN);
+	discovery->name_len = strlen(discovery->data.info);
 
 	info->discovery = discovery;
 
@@ -523,18 +524,18 @@ static void irlap_recv_discovery_xid_cmd
 			return;
 		}
 
-		discovery->daddr = info->daddr;
-		discovery->saddr = self->saddr;
+		discovery->data.daddr = info->daddr;
+		discovery->data.saddr = self->saddr;
 		discovery->timestamp = jiffies;
 
-		discovery->hints.byte[0] = discovery_info[0];
+		discovery->data.hints[0] = discovery_info[0];
 		if (discovery_info[0] & HINT_EXTENSION) {
-			discovery->hints.byte[1] = discovery_info[1];
-			discovery->charset = discovery_info[2];
+			discovery->data.hints[1] = discovery_info[1];
+			discovery->data.charset = discovery_info[2];
 			text = (char *) &discovery_info[3];
 		} else {
-			discovery->hints.byte[1] = 0;
-			discovery->charset = discovery_info[1];
+			discovery->data.hints[1] = 0;
+			discovery->data.charset = discovery_info[1];
 			text = (char *) &discovery_info[2];
 		}
 		/*
@@ -542,8 +543,8 @@ static void irlap_recv_discovery_xid_cmd
 		 *  FCS bytes resides.
 		 */
 		skb->data[skb->len] = '\0';
-		strncpy(discovery->nickname, text, NICKNAME_MAX_LEN);
-		discovery->name_len = strlen(discovery->nickname);
+		strncpy(discovery->data.info, text, NICKNAME_MAX_LEN);
+		discovery->name_len = strlen(discovery->data.info);
 
 		info->discovery = discovery;
 	} else
diff -u -p -r linux/net/irda-d4/irlmp.c linux/net/irda/irlmp.c
--- linux/net/irda-d4/irlmp.c	Mon Nov  4 14:30:50 2002
+++ linux/net/irda/irlmp.c	Wed Jan  8 17:00:47 2003
@@ -401,8 +401,8 @@ int irlmp_connect_request(struct lsap_cb
 		}
 
 		if (discovery) {
-			saddr = discovery->saddr;
-			daddr = discovery->daddr;
+			saddr = discovery->data.saddr;
+			daddr = discovery->data.daddr;
 		}
 		spin_unlock_irqrestore(&irlmp->cachelog->hb_spinlock, flags);
 	}
@@ -793,17 +793,17 @@ void irlmp_do_discovery(int nslots)
 	}
 
 	/* Construct new discovery info to be used by IrLAP, */
-	irlmp->discovery_cmd.hints.word = irlmp->hints.word;
+	u16ho(irlmp->discovery_cmd.data.hints) = irlmp->hints.word;
 
 	/*
 	 *  Set character set for device name (we use ASCII), and
 	 *  copy device name. Remember to make room for a \0 at the
 	 *  end
 	 */
-	irlmp->discovery_cmd.charset = CS_ASCII;
-	strncpy(irlmp->discovery_cmd.nickname, sysctl_devname,
+	irlmp->discovery_cmd.data.charset = CS_ASCII;
+	strncpy(irlmp->discovery_cmd.data.info, sysctl_devname,
 		NICKNAME_MAX_LEN);
-	irlmp->discovery_cmd.name_len = strlen(irlmp->discovery_cmd.nickname);
+	irlmp->discovery_cmd.name_len = strlen(irlmp->discovery_cmd.data.info);
 	irlmp->discovery_cmd.nslots = nslots;
 
 	/*
@@ -827,10 +827,13 @@ void irlmp_do_discovery(int nslots)
  *
  *    Do a discovery of devices in front of the computer
  *
+ * If the caller has registered a client discovery callback, this
+ * allow him to receive the full content of the discovery log through
+ * this callback (as normally he will receive only new discoveries).
  */
 void irlmp_discovery_request(int nslots)
 {
-	/* Return current cached discovery log */
+	/* Return current cached discovery log (in full) */
 	irlmp_discovery_confirm(irlmp->cachelog, DISCOVERY_LOG);
 
 	/*
@@ -854,6 +857,8 @@ void irlmp_discovery_request(int nslots)
  *
  *    Return the current discovery log
  *
+ * If discovery is not enabled, you should call this function again
+ * after 1 or 2 seconds (i.e. after discovery has been done).
  */
 struct irda_device_info *irlmp_get_discoveries(int *pn, __u16 mask, int nslots)
 {
@@ -875,50 +880,9 @@ struct irda_device_info *irlmp_get_disco
 	}
 
 	/* Return current cached discovery log */
-	return(irlmp_copy_discoveries(irlmp->cachelog, pn, mask));
+	return(irlmp_copy_discoveries(irlmp->cachelog, pn, mask, TRUE));
 }
 
-#if 0
-/*
- * Function irlmp_check_services (discovery)
- */
-void irlmp_check_services(discovery_t *discovery)
-{
-	struct irlmp_client *client;
-	__u8 *service_log;
-	__u8 service;
-	int i = 0;
-
-	IRDA_DEBUG(1, "IrDA Discovered: %s\n", discovery->info);
-	IRDA_DEBUG(1, "    Services: ");
-
-	service_log = irlmp_hint_to_service(discovery->hints.byte);
-	if (!service_log)
-		return;
-
-	/*
-	 *  Check all services on the device
-	 */
-	while ((service = service_log[i++]) != S_END) {
-		IRDA_DEBUG( 4, "service=%02x\n", service);
-		client = hashbin_lock_find(irlmp->registry, service, NULL);
-		if (entry && entry->discovery_callback) {
-			IRDA_DEBUG( 4, "discovery_callback!\n");
-
-			entry->discovery_callback(discovery);
-		} else {
-			/* Don't notify about the ANY service */
-			if (service == S_ANY)
-				continue;
-			/*
-			 * Found no clients for dealing with this service,
-			 */
-		}
-	}
-	kfree(service_log);
-}
-#endif
-
 /*
  * Function irlmp_notify_client (log)
  *
@@ -935,7 +899,9 @@ static inline void
 irlmp_notify_client(irlmp_client_t *client,
 		    hashbin_t *log, DISCOVERY_MODE mode)
 {
-	discovery_t *discovery;
+	discinfo_t *discoveries;	/* Copy of the discovery log */
+	int	number;			/* Number of nodes in the log */
+	int	i;
 
 	IRDA_DEBUG(3, "%s()\n", __FUNCTION__);
 
@@ -944,28 +910,36 @@ irlmp_notify_client(irlmp_client_t *clie
 		return;
 
 	/*
+	 * Locking notes :
+	 * the old code was manipulating the log directly, which was
+	 * very racy. Now, we use copy_discoveries, that protects
+	 * itself while dumping the log for us.
+	 * The overhead of the copy is compensated by the fact that
+	 * we only pass new discoveries in normal mode and don't
+	 * pass the same old entry every 3s to the caller as we used
+	 * to do (virtual function calling is expensive).
+	 * Jean II
+	 */
+
+	/*
 	 * Now, check all discovered devices (if any), and notify client
 	 * only about the services that the client is interested in
-	 * Note : most often, we will get called immediately following
-	 * a discovery, so the log is not going to expire.
-	 * On the other hand, comming here through irlmp_discovery_request()
-	 * is *very* problematic - Jean II
-	 * Can't use hashbin_find_next(), key is not unique. I'm running
-	 * out of options :-( - Jean II
+	 * We also notify only about the new devices unless the caller
+	 * explicity request a dump of the log. Jean II
 	 */
-	discovery = (discovery_t *) hashbin_get_first(log);
-	while (discovery != NULL) {
-		IRDA_DEBUG(3, "discovery->daddr = 0x%08x\n", discovery->daddr);
-
-		/*
-		 * Any common hint bits? Remember to mask away the extension
-		 * bits ;-)
-		 */
-		if (client->hint_mask & discovery->hints.word & 0x7f7f)
-			client->disco_callback(discovery, mode, client->priv);
+	discoveries = irlmp_copy_discoveries(log, &number,
+					     client->hint_mask.word,
+					     (mode == DISCOVERY_LOG));
+	/* Check if the we got some results */
+	if (discoveries == NULL)
+		return;	/* No nodes discovered */
+
+	/* Pass all entries to the listener */
+	for(i = 0; i < number; i++)
+		client->disco_callback(&(discoveries[i]), mode, client->priv);
 
-		discovery = (discovery_t *) hashbin_get_next(log);
-	}
+	/* Free up our buffer */
+	kfree(discoveries);
 }
 
 /*
@@ -987,6 +961,7 @@ void irlmp_discovery_confirm(hashbin_t *
 	if (!(HASHBIN_GET_SIZE(log)))
 		return;
 
+	/* For each client - notify callback may touch client list */
 	client = (irlmp_client_t *) hashbin_get_first(irlmp->clients);
 	while (NULL != hashbin_find_next(irlmp->clients, (long) client, NULL,
 					 (void *) &client_next) ) {
@@ -1005,26 +980,34 @@ void irlmp_discovery_confirm(hashbin_t *
  *	registered for this event...
  *
  *	Note : called exclusively from discovery.c
- *	Note : as we are currently processing the log, the clients callback
- *	should *NOT* attempt to touch the log now.
+ *	Note : this is no longer called under discovery spinlock, so the
+ *		client can do whatever he wants in the callback.
  */
-void irlmp_discovery_expiry(discovery_t *expiry)
+void irlmp_discovery_expiry(discinfo_t *expiries, int number)
 {
 	irlmp_client_t *client;
 	irlmp_client_t *client_next;
+	int		i;
 
 	IRDA_DEBUG(3, "%s()\n", __FUNCTION__);
 
-	ASSERT(expiry != NULL, return;);
+	ASSERT(expiries != NULL, return;);
 
+	/* For each client - notify callback may touch client list */
 	client = (irlmp_client_t *) hashbin_get_first(irlmp->clients);
 	while (NULL != hashbin_find_next(irlmp->clients, (long) client, NULL,
 					 (void *) &client_next) ) {
-		/* Check if we should notify client */
-		if ((client->expir_callback) &&
-		    (client->hint_mask & expiry->hints.word & 0x7f7f))
-			client->expir_callback(expiry, EXPIRY_TIMEOUT,
-					       client->priv);
+
+		/* Pass all entries to the listener */
+		for(i = 0; i < number; i++) {
+			/* Check if we should notify client */
+			if ((client->expir_callback) &&
+			    (client->hint_mask.word & u16ho(expiries[i].hints)
+			     & 0x7f7f) )
+				client->expir_callback(&(expiries[i]),
+						       EXPIRY_TIMEOUT,
+						       client->priv);
+		}
 
 		/* Next client */
 		client = client_next;
@@ -1043,18 +1026,18 @@ discovery_t *irlmp_get_discovery_respons
 
 	ASSERT(irlmp != NULL, return NULL;);
 
-	irlmp->discovery_rsp.hints.word = irlmp->hints.word;
+	u16ho(irlmp->discovery_rsp.data.hints) = irlmp->hints.word;
 
 	/*
 	 *  Set character set for device name (we use ASCII), and
 	 *  copy device name. Remember to make room for a \0 at the
 	 *  end
 	 */
-	irlmp->discovery_rsp.charset = CS_ASCII;
+	irlmp->discovery_rsp.data.charset = CS_ASCII;
 
-	strncpy(irlmp->discovery_rsp.nickname, sysctl_devname,
+	strncpy(irlmp->discovery_rsp.data.info, sysctl_devname,
 		NICKNAME_MAX_LEN);
-	irlmp->discovery_rsp.name_len = strlen(irlmp->discovery_rsp.nickname);
+	irlmp->discovery_rsp.name_len = strlen(irlmp->discovery_rsp.data.info);
 
 	return &irlmp->discovery_rsp;
 }
@@ -1291,6 +1274,7 @@ void irlmp_flow_indication(struct lap_cb
 	}
 }
 
+#if 0
 /*
  * Function irlmp_hint_to_service (hint)
  *
@@ -1365,6 +1349,21 @@ __u8 *irlmp_hint_to_service(__u8 *hint)
 
 	return service;
 }
+#endif
+
+const __u16 service_hint_mapping[S_END][2] = {
+	{ HINT_PNP,		0 },			/* S_PNP */
+	{ HINT_PDA,		0 },			/* S_PDA */
+	{ HINT_COMPUTER,	0 },			/* S_COMPUTER */
+	{ HINT_PRINTER,		0 },			/* S_PRINTER */
+	{ HINT_MODEM,		0 },			/* S_MODEM */
+	{ HINT_FAX,		0 },			/* S_FAX */
+	{ HINT_LAN,		0 },			/* S_LAN */
+	{ HINT_EXTENSION,	HINT_TELEPHONY },	/* S_TELEPHONY */
+	{ HINT_EXTENSION,	HINT_COMM },		/* S_COMM */
+	{ HINT_EXTENSION,	HINT_OBEX },		/* S_OBEX */
+	{ 0xFF,			0xFF },			/* S_ANY */
+};
 
 /*
  * Function irlmp_service_to_hint (service)
@@ -1377,46 +1376,9 @@ __u16 irlmp_service_to_hint(int service)
 {
 	__u16_host_order hint;
 
-	hint.word = 0;
+	hint.byte[0] = service_hint_mapping[service][0];
+	hint.byte[1] = service_hint_mapping[service][1];
 
-	switch (service) {
-	case S_PNP:
-		hint.byte[0] |= HINT_PNP;
-		break;
-	case S_PDA:
-		hint.byte[0] |= HINT_PDA;
-		break;
-	case S_COMPUTER:
-		hint.byte[0] |= HINT_COMPUTER;
-		break;
-	case S_PRINTER:
-		hint.byte[0] |= HINT_PRINTER;
-		break;
-	case S_MODEM:
-		hint.byte[0] |= HINT_PRINTER;
-		break;
-	case S_LAN:
-		hint.byte[0] |= HINT_LAN;
-		break;
-	case S_COMM:
-		hint.byte[0] |= HINT_EXTENSION;
-		hint.byte[1] |= HINT_COMM;
-		break;
-	case S_OBEX:
-		hint.byte[0] |= HINT_EXTENSION;
-		hint.byte[1] |= HINT_OBEX;
-		break;
-	case S_TELEPHONY:
-		hint.byte[0] |= HINT_EXTENSION;
-		hint.byte[1] |= HINT_TELEPHONY;
-		break;
-	case S_ANY:
-		hint.word = 0xffff;
-		break;
-	default:
-		IRDA_DEBUG( 1, "%s(), Unknown service!\n", __FUNCTION__);
-		break;
-	}
 	return hint.word;
 }
 
@@ -1438,7 +1400,7 @@ void *irlmp_register_service(__u16 hints
 		IRDA_DEBUG(1, "%s(), Unable to kmalloc!\n", __FUNCTION__);
 		return 0;
 	}
-	service->hints = hints;
+	service->hints.word = hints;
 	hashbin_insert(irlmp->services, (irda_queue_t *) service,
 		       (long) service, NULL);
 
@@ -1481,7 +1443,7 @@ int irlmp_unregister_service(void *handl
 	spin_lock_irqsave(&irlmp->services->hb_spinlock, flags);
         service = (irlmp_service_t *) hashbin_get_first(irlmp->services);
         while (service) {
-		irlmp->hints.word |= service->hints;
+		irlmp->hints.word |= service->hints.word;
 
                 service = (irlmp_service_t *)hashbin_get_next(irlmp->services);
         }
@@ -1499,7 +1461,7 @@ int irlmp_unregister_service(void *handl
  *    Returns: handle > 0 on success, 0 on error
  */
 void *irlmp_register_client(__u16 hint_mask, DISCOVERY_CALLBACK1 disco_clb,
-			    DISCOVERY_CALLBACK1 expir_clb, void *priv)
+			    DISCOVERY_CALLBACK2 expir_clb, void *priv)
 {
 	irlmp_client_t *client;
 
@@ -1514,7 +1476,7 @@ void *irlmp_register_client(__u16 hint_m
 	}
 
 	/* Register the details */
-	client->hint_mask = hint_mask;
+	client->hint_mask.word = hint_mask;
 	client->disco_callback = disco_clb;
 	client->expir_callback = expir_clb;
 	client->priv = priv;
@@ -1535,7 +1497,7 @@ void *irlmp_register_client(__u16 hint_m
  */
 int irlmp_update_client(void *handle, __u16 hint_mask,
 			DISCOVERY_CALLBACK1 disco_clb,
-			DISCOVERY_CALLBACK1 expir_clb, void *priv)
+			DISCOVERY_CALLBACK2 expir_clb, void *priv)
 {
 	irlmp_client_t *client;
 
@@ -1548,7 +1510,7 @@ int irlmp_update_client(void *handle, __
 		return -1;
 	}
 
-	client->hint_mask = hint_mask;
+	client->hint_mask.word = hint_mask;
 	client->disco_callback = disco_clb;
 	client->expir_callback = expir_clb;
 	client->priv = priv;
diff -u -p -r linux/net/irda-d4/irnet/irnet_irda.c linux/net/irda/irnet/irnet_irda.c
--- linux/net/irda-d4/irnet/irnet_irda.c	Mon Nov  4 14:30:05 2002
+++ linux/net/irda/irnet/irnet_irda.c	Wed Jan  8 17:00:47 2003
@@ -1616,8 +1616,8 @@ irnet_discovervalue_confirm(int		result,
  *
  *    Got a discovery indication from IrLMP, post an event
  *
- * Note : IrLMP take care of matching the hint mask for us, we only
- * check if it is a "new" node...
+ * Note : IrLMP take care of matching the hint mask for us, and also
+ * check if it is a "new" node for us...
  *
  * As IrLMP filter on the IrLAN hint bit, we get both IrLAN and IrNET
  * nodes, so it's only at connection time that we will know if the
@@ -1633,7 +1633,7 @@ irnet_discovervalue_confirm(int		result,
  * is to messy, so we leave that to user space...
  */
 static void
-irnet_discovery_indication(discovery_t *	discovery,
+irnet_discovery_indication(discinfo_t *		discovery,
 			   DISCOVERY_MODE	mode,
 			   void *		priv)
 {
@@ -1643,21 +1643,12 @@ irnet_discovery_indication(discovery_t *
   DASSERT(priv == &irnet_server, , IRDA_OCB_ERROR,
 	  "Invalid instance (0x%X) !!!\n", (unsigned int) priv);
 
-  /* Check if node is discovered is a new one or an old one.
-   * We check when how long ago this node was discovered, with a
-   * coarse timeout (we may miss some discovery events or be delayed).
-   */
-  if((jiffies - discovery->first_timestamp) >= (sysctl_discovery_timeout * HZ))
-    {
-      return;		/* Too old, not interesting -> goodbye */
-    }
-
   DEBUG(IRDA_OCB_INFO, "Discovered new IrNET/IrLAN node %s...\n",
-	discovery->nickname);
+	discovery->info);
 
   /* Notify the control channel */
   irnet_post_event(NULL, IRNET_DISCOVER,
-		   discovery->saddr, discovery->daddr, discovery->nickname);
+		   discovery->saddr, discovery->daddr, discovery->info);
 
   DEXIT(IRDA_OCB_TRACE, "\n");
 }
@@ -1672,7 +1663,7 @@ irnet_discovery_indication(discovery_t *
  * check if it is a "new" node...
  */
 static void
-irnet_expiry_indication(discovery_t *	expiry,
+irnet_expiry_indication(discinfo_t *	expiry,
 			DISCOVERY_MODE	mode,
 			void *		priv)
 {
@@ -1683,11 +1674,11 @@ irnet_expiry_indication(discovery_t *	ex
 	  "Invalid instance (0x%X) !!!\n", (unsigned int) priv);
 
   DEBUG(IRDA_OCB_INFO, "IrNET/IrLAN node %s expired...\n",
-	expiry->nickname);
+	expiry->info);
 
   /* Notify the control channel */
   irnet_post_event(NULL, IRNET_EXPIRE,
-		   expiry->saddr, expiry->daddr, expiry->nickname);
+		   expiry->saddr, expiry->daddr, expiry->info);
 
   DEXIT(IRDA_OCB_TRACE, "\n");
 }
diff -u -p -r linux/net/irda-d4/irnet/irnet_irda.h linux/net/irda/irnet/irnet_irda.h
--- linux/net/irda-d4/irnet/irnet_irda.h	Mon Nov  4 14:30:07 2002
+++ linux/net/irda/irnet/irnet_irda.h	Wed Jan  8 17:00:47 2003
@@ -150,11 +150,11 @@ static void
 				    void *);
 #ifdef DISCOVERY_EVENTS
 static void
-	irnet_discovery_indication(discovery_t *,
+	irnet_discovery_indication(discinfo_t *,
 				   DISCOVERY_MODE,
 				   void *);
 static void
-	irnet_expiry_indication(discovery_t *,
+	irnet_expiry_indication(discinfo_t *,
 				DISCOVERY_MODE,
 				void *);
 #endif
