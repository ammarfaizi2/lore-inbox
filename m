Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319496AbSH2WuC>; Thu, 29 Aug 2002 18:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319516AbSH2Wtx>; Thu, 29 Aug 2002 18:49:53 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:50627 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S319496AbSH2WqK>;
	Thu, 29 Aug 2002 18:46:10 -0400
Date: Thu, 29 Aug 2002 15:49:36 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: [PATCH 2.5] : ir252_hashbin_locking_fixes-4.diff
Message-ID: <20020829224936.GE14118@bougret.hpl.hp.com>
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

ir252_hashbin_locking_fixes-4.diff :
----------------------------------
	o [FEATURE] New hashbin locking scheme for irqueue
	o [FEATURE] Get rid of old broken hashbin locking schemes
	o [FEATURE] Lock hasbins while enumerating it in various places
	o [CORRECT] Remove all remaining "save_flags(flags);cli();"
	o [CORRECT] Fix two "return with spinlock" found by Stanford checker


diff -u -p -r linux/include/net/irda-d5/irlmp.h linux/include/net/irda/irlmp.h
--- linux/include/net/irda-d5/irlmp.h	Mon Aug 19 15:59:28 2002
+++ linux/include/net/irda/irlmp.h	Thu Aug 22 18:08:15 2002
@@ -183,7 +183,6 @@ struct irlmp_cb {
 	hashbin_t *services;
 
 	hashbin_t *cachelog;	/* Current discovery log */
-	spinlock_t log_lock;	/* discovery log spinlock */
 
 	int running;
 
@@ -221,7 +220,7 @@ void irlmp_disconnect_indication(struct 
 				 struct sk_buff *userdata);
 int  irlmp_disconnect_request(struct lsap_cb *, struct sk_buff *userdata);
 
-void irlmp_discovery_confirm(hashbin_t *discovery_log, DISCOVERY_MODE);
+void irlmp_discovery_confirm(hashbin_t *discovery_log, DISCOVERY_MODE mode);
 void irlmp_discovery_request(int nslots);
 struct irda_device_info *irlmp_get_discoveries(int *pn, __u16 mask, int nslots);
 void irlmp_do_expiry(void);
@@ -257,8 +256,6 @@ extern int sysctl_discovery_slots;
 extern int sysctl_discovery;
 extern int sysctl_lap_keepalive_time;	/* in ms, default is LM_IDLE_TIMEOUT */
 extern struct irlmp_cb *irlmp;
-
-static inline hashbin_t *irlmp_get_cachelog(void) { return irlmp->cachelog; }
 
 /* Check if LAP queue is full.
  * Used by IrTTP for low control, see comments in irlap.h - Jean II */
diff -u -p -r linux/include/net/irda-d5/irqueue.h linux/include/net/irda/irqueue.h
--- linux/include/net/irda-d5/irqueue.h	Mon Aug 19 15:59:28 2002
+++ linux/include/net/irda/irqueue.h	Wed Aug 21 16:10:40 2002
@@ -36,12 +36,12 @@
 #define NAME_SIZE      32
 
 /*
- * Hash types
+ * Hash types (some flags can be xored)
+ * See comments in irqueue.c for which one to use...
  */
-#define HB_NOLOCK      0
-#define HB_GLOBAL      1
-#define HB_LOCAL       2
-#define HB_SORTED      4
+#define HB_NOLOCK	0	/* No concurent access prevention */
+#define HB_LOCK		1	/* Prevent concurent write with global lock */
+#define HB_SORTED	4	/* Not yet supported */
 
 /*
  * Hash defines
@@ -57,11 +57,6 @@
 
 typedef void (*FREE_FUNC)(void *arg);
 
-/*
- * Hashbin
- */
-#define GET_HASHBIN(x) ( x & HASHBIN_MASK )
-
 struct irda_queue {
 	struct irda_queue *q_next;
 	struct irda_queue *q_prev;
@@ -75,8 +70,9 @@ typedef struct hashbin_t {
 	__u32      magic;
 	int        hb_type;
 	int        hb_size;
-	spinlock_t hb_mutex[HASHBIN_SIZE] IRDA_ALIGN;
-	irda_queue_t   *hb_queue[HASHBIN_SIZE] IRDA_ALIGN;
+	spinlock_t hb_spinlock;		/* HB_LOCK - Can be used by the user */
+
+	irda_queue_t* hb_queue[HASHBIN_SIZE] IRDA_ALIGN;
 
 	irda_queue_t* hb_current;
 } hashbin_t;
@@ -86,16 +82,15 @@ int      hashbin_delete(hashbin_t* hashb
 int      hashbin_clear(hashbin_t* hashbin, FREE_FUNC free_func);
 void     hashbin_insert(hashbin_t* hashbin, irda_queue_t* entry, long hashv, 
 			char* name);
-void*    hashbin_find(hashbin_t* hashbin, long hashv, char* name);
 void*    hashbin_remove(hashbin_t* hashbin, long hashv, char* name);
 void*    hashbin_remove_first(hashbin_t *hashbin);
 void*	 hashbin_remove_this( hashbin_t* hashbin, irda_queue_t* entry);
+void*    hashbin_find(hashbin_t* hashbin, long hashv, char* name);
+void*    hashbin_lock_find(hashbin_t* hashbin, long hashv, char* name);
+void*    hashbin_find_next(hashbin_t* hashbin, long hashv, char* name,
+			   void ** pnext);
 irda_queue_t *hashbin_get_first(hashbin_t *hashbin);
 irda_queue_t *hashbin_get_next(hashbin_t *hashbin);
-
-void enqueue_last(irda_queue_t **queue, irda_queue_t* element);
-void enqueue_first(irda_queue_t **queue, irda_queue_t* element);
-irda_queue_t *dequeue_first(irda_queue_t **queue);
 
 #define HASHBIN_GET_SIZE(hashbin) hashbin->hb_size
 
diff -u -p -r linux/net/irda-d5/discovery.c linux/net/irda/discovery.c
--- linux/net/irda-d5/discovery.c	Sat Jun  8 22:28:12 2002
+++ linux/net/irda/discovery.c	Wed Aug 21 15:48:58 2002
@@ -61,7 +61,7 @@ void irlmp_add_discovery(hashbin_t *cach
 	/* Set time of first discovery if node is new (see below) */
 	new->first_timestamp = new->timestamp;
 
-	spin_lock_irqsave(&irlmp->log_lock, flags);
+	spin_lock_irqsave(&cachelog->hb_spinlock, flags);
 
 	/* 
 	 * Remove all discoveries of devices that has previously been 
@@ -95,13 +95,13 @@ void irlmp_add_discovery(hashbin_t *cach
 	/* Insert the new and updated version */
 	hashbin_insert(cachelog, (irda_queue_t *) new, new->daddr, NULL);
 
-	spin_unlock_irqrestore(&irlmp->log_lock, flags);
+	spin_unlock_irqrestore(&cachelog->hb_spinlock, flags);
 }
 
 /*
  * Function irlmp_add_discovery_log (cachelog, log)
  *
- *    Merge a disovery log into the cachlog.
+ *    Merge a disovery log into the cachelog.
  *
  */
 void irlmp_add_discovery_log(hashbin_t *cachelog, hashbin_t *log)
@@ -115,11 +115,17 @@ void irlmp_add_discovery_log(hashbin_t *
 	 *  discovery, so restart discovery again with just the half timeout
 	 *  of the normal one.
 	 */
+	/* Well... It means that there was nobody out there - Jean II */
 	if (log == NULL) {
 		/* irlmp_start_discovery_timer(irlmp, 150); */
 		return;
 	}
 
+	/*
+	 * Locking : we are the only owner of this discovery log, so
+	 * no need to lock it.
+	 * We just need to lock the global log in irlmp_add_discovery().
+	 */
 	discovery = (discovery_t *) hashbin_remove_first(log);
 	while (discovery != NULL) {
 		irlmp_add_discovery(cachelog, discovery);
@@ -146,7 +152,7 @@ void irlmp_expire_discoveries(hashbin_t 
 
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
 
-	spin_lock_irqsave(&irlmp->log_lock, flags);
+	spin_lock_irqsave(&log->hb_spinlock, flags);
 
 	discovery = (discovery_t *) hashbin_get_first(log);
 	while (discovery != NULL) {
@@ -169,7 +175,7 @@ void irlmp_expire_discoveries(hashbin_t 
 		}
 	}
 
-	spin_unlock_irqrestore(&irlmp->log_lock, flags);
+	spin_unlock_irqrestore(&log->hb_spinlock, flags);
 }
 
 /*
@@ -230,13 +236,13 @@ struct irda_device_info *irlmp_copy_disc
 		return NULL;
 
 	/* Save spin lock - spinlock should be discovery specific */
-	spin_lock_irqsave(&irlmp->log_lock, flags);
+	spin_lock_irqsave(&log->hb_spinlock, flags);
 
 	/* Create the client specific buffer */
 	n = HASHBIN_GET_SIZE(log);
 	buffer = kmalloc(n * sizeof(struct irda_device_info), GFP_ATOMIC);
 	if (buffer == NULL) {
-		spin_unlock_irqrestore(&irlmp->log_lock, flags);
+		spin_unlock_irqrestore(&log->hb_spinlock, flags);
 		return NULL;
 	}
 
@@ -257,7 +263,7 @@ struct irda_device_info *irlmp_copy_disc
 		discovery = (discovery_t *) hashbin_get_next(log);
 	}
 
-	spin_unlock_irqrestore(&irlmp->log_lock, flags);
+	spin_unlock_irqrestore(&log->hb_spinlock, flags);
 
 	/* Get the actual number of device in the buffer and return */
 	*pn = i;
@@ -276,7 +282,7 @@ __u32 irlmp_find_device(hashbin_t *cache
 	unsigned long flags;
 	discovery_t *d;
 
-	spin_lock_irqsave(&irlmp->log_lock, flags);
+	spin_lock_irqsave(&cachelog->hb_spinlock, flags);
 
 	/* Look at all discoveries for that link */
 	d = (discovery_t *) hashbin_get_first(cachelog);
@@ -288,13 +294,13 @@ __u32 irlmp_find_device(hashbin_t *cache
 		if (strcmp(name, d->nickname) == 0) {
 			*saddr = d->saddr;
 			
-			spin_unlock_irqrestore(&irlmp->log_lock, flags);
+			spin_unlock_irqrestore(&cachelog->hb_spinlock, flags);
 			return d->daddr;
 		}
 		d = (discovery_t *) hashbin_get_next(cachelog);
 	}
 
-	spin_unlock_irqrestore(&irlmp->log_lock, flags);
+	spin_unlock_irqrestore(&cachelog->hb_spinlock, flags);
 
 	return 0;
 }
@@ -310,7 +316,7 @@ int discovery_proc_read(char *buf, char 
 {
 	discovery_t *discovery;
 	unsigned long flags;
-	hashbin_t *cachelog = irlmp_get_cachelog();
+	hashbin_t *cachelog = irlmp->cachelog;
 	int		len = 0;
 
 	if (!irlmp)
@@ -318,7 +324,7 @@ int discovery_proc_read(char *buf, char 
 
 	len = sprintf(buf, "IrLMP: Discovery log:\n\n");	
 	
-	spin_lock_irqsave(&irlmp->log_lock, flags);
+	spin_lock_irqsave(&cachelog->hb_spinlock, flags);
 
 	discovery = (discovery_t *) hashbin_get_first(cachelog);
 	while (( discovery != NULL) && (len < length)) {
@@ -362,7 +368,7 @@ int discovery_proc_read(char *buf, char 
 		
 		discovery = (discovery_t *) hashbin_get_next(cachelog);
 	}
-	spin_unlock_irqrestore(&irlmp->log_lock, flags);
+	spin_unlock_irqrestore(&cachelog->hb_spinlock, flags);
 
 	return len;
 }
diff -u -p -r linux/net/irda-d5/irda_device.c linux/net/irda/irda_device.c
--- linux/net/irda-d5/irda_device.c	Mon Aug 19 14:41:05 2002
+++ linux/net/irda/irda_device.c	Wed Aug 21 16:05:43 2002
@@ -91,13 +91,13 @@ int irda_device_proc_read(char *buf, cha
 
 int __init irda_device_init( void)
 {
-	dongles = hashbin_new(HB_GLOBAL);
+	dongles = hashbin_new(HB_LOCK);
 	if (dongles == NULL) {
 		printk(KERN_WARNING "IrDA: Can't allocate dongles hashbin!\n");
 		return -ENOMEM;
 	}
 
-	tasks = hashbin_new(HB_GLOBAL);
+	tasks = hashbin_new(HB_LOCK);
 	if (tasks == NULL) {
 		printk(KERN_WARNING "IrDA: Can't allocate tasks hashbin!\n");
 		return -ENOMEM;
@@ -438,7 +438,7 @@ dongle_t *irda_device_dongle_init(struct
 	}
 #endif
 
-	if (!(reg = hashbin_find(dongles, type, NULL))) {
+	if (!(reg = hashbin_lock_find(dongles, type, NULL))) {
 		ERROR("IrDA: Unable to find requested dongle\n");
 		return NULL;
 	}
@@ -477,7 +477,7 @@ int irda_device_dongle_cleanup(dongle_t 
 int irda_device_register_dongle(struct dongle_reg *new)
 {
 	/* Check if this dongle has been registred before */
-	if (hashbin_find(dongles, new->type, NULL)) {
+	if (hashbin_lock_find(dongles, new->type, NULL)) {
 		MESSAGE("%s: Dongle already registered\n", __FUNCTION__);
                 return 0;
         }
diff -u -p -r linux/net/irda-d5/iriap.c linux/net/irda/iriap.c
--- linux/net/irda-d5/iriap.c	Mon Aug 19 15:59:28 2002
+++ linux/net/irda/iriap.c	Wed Aug 21 16:05:13 2002
@@ -91,11 +91,12 @@ int __init iriap_init(void)
 	__u16 hints;
 
 	/* Allocate master array */
-	iriap = hashbin_new(HB_LOCAL);
+	iriap = hashbin_new(HB_LOCK);
 	if (!iriap)
 		return -ENOMEM;
 
-	objects = hashbin_new(HB_LOCAL);
+	/* Object repository - defined in irias_object.c */
+	objects = hashbin_new(HB_LOCK);
 	if (!objects) {
 		WARNING("%s: Can't allocate objects hashbin!\n", __FUNCTION__);
 		return -ENOMEM;
@@ -973,13 +974,12 @@ int irias_proc_read(char *buf, char **st
 
 	ASSERT( objects != NULL, return 0;);
 
-	save_flags( flags);
-	cli();
-
 	len = 0;
 
 	len += sprintf(buf+len, "LM-IAS Objects:\n");
 
+	spin_lock_irqsave(&objects->hb_spinlock, flags);
+
 	/* List all objects */
 	obj = (struct ias_object *) hashbin_get_first(objects);
 	while ( obj != NULL) {
@@ -989,6 +989,11 @@ int irias_proc_read(char *buf, char **st
 		len += sprintf(buf+len, "id=%d", obj->id);
 		len += sprintf(buf+len, "\n");
 
+		/* Careful for priority inversions here !
+		 * All other uses of attrib spinlock are independant of
+		 * the object spinlock, so we are safe. Jean II */
+		spin_lock(&obj->attribs->hb_spinlock);
+
 		/* List all attributes for this object */
 		attrib = (struct ias_attrib *)
 			hashbin_get_first(obj->attribs);
@@ -1025,9 +1030,11 @@ int irias_proc_read(char *buf, char **st
 			attrib = (struct ias_attrib *)
 				hashbin_get_next(obj->attribs);
 		}
+		spin_unlock(&obj->attribs->hb_spinlock);
+
 	        obj = (struct ias_object *) hashbin_get_next(objects);
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&objects->hb_spinlock, flags);
 
 	return len;
 }
diff -u -p -r linux/net/irda-d5/irias_object.c linux/net/irda/irias_object.c
--- linux/net/irda-d5/irias_object.c	Mon Aug 19 15:59:28 2002
+++ linux/net/irda/irias_object.c	Tue Aug 20 18:36:18 2002
@@ -93,7 +93,10 @@ struct ias_object *irias_new_object( cha
 	obj->name = strndup(name, IAS_MAX_CLASSNAME);
 	obj->id = id;
 
-	obj->attribs = hashbin_new(HB_LOCAL);
+	/* Locking notes : the attrib spinlock has lower precendence
+	 * than the objects spinlock. Never grap the objects spinlock
+	 * while holding any attrib spinlock (risk of deadlock). Jean II */
+	obj->attribs = hashbin_new(HB_LOCK);
 
 	return obj;
 }
@@ -211,7 +214,8 @@ struct ias_object *irias_find_object(cha
 {
 	ASSERT(name != NULL, return NULL;);
 
-	return hashbin_find(objects, 0, name);
+	/* Unsafe (locking), object might change */
+	return hashbin_lock_find(objects, 0, name);
 }
 
 /*
@@ -228,10 +232,11 @@ struct ias_attrib *irias_find_attrib(str
 	ASSERT(obj->magic == IAS_OBJECT_MAGIC, return NULL;);
 	ASSERT(name != NULL, return NULL;);
 
-	attrib = hashbin_find(obj->attribs, 0, name);
+	attrib = hashbin_lock_find(obj->attribs, 0, name);
 	if (attrib == NULL)
 		return NULL;
 
+	/* Unsafe (locking), attrib might change */
 	return attrib;
 }
 
@@ -267,26 +272,32 @@ int irias_object_change_attribute(char *
 {
 	struct ias_object *obj;
 	struct ias_attrib *attrib;
+	unsigned long flags;
 
 	/* Find object */
-	obj = hashbin_find(objects, 0, obj_name);
+	obj = hashbin_lock_find(objects, 0, obj_name);
 	if (obj == NULL) {
 		WARNING("%s: Unable to find object: %s\n", __FUNCTION__,
 			obj_name);
 		return -1;
 	}
 
+	/* Slightly unsafe (obj might get removed under us) */
+	spin_lock_irqsave(&obj->attribs->hb_spinlock, flags);
+
 	/* Find attribute */
 	attrib = hashbin_find(obj->attribs, 0, attrib_name);
 	if (attrib == NULL) {
 		WARNING("%s: Unable to find attribute: %s\n", __FUNCTION__,
 			attrib_name);
+		spin_unlock_irqrestore(&obj->attribs->hb_spinlock, flags);
 		return -1;
 	}
 
 	if ( attrib->value->type != new_value->type) {
 		IRDA_DEBUG( 0, __FUNCTION__
 		       "(), changing value type not allowed!\n");
+		spin_unlock_irqrestore(&obj->attribs->hb_spinlock, flags);
 		return -1;
 	}
 
@@ -297,6 +308,7 @@ int irias_object_change_attribute(char *
 	attrib->value = new_value;
 
 	/* Success */
+	spin_unlock_irqrestore(&obj->attribs->hb_spinlock, flags);
 	return 0;
 }
 
diff -u -p -r linux/net/irda-d5/irlap.c linux/net/irda/irlap.c
--- linux/net/irda-d5/irlap.c	Thu Aug 22 19:10:08 2002
+++ linux/net/irda/irlap.c	Wed Aug 21 16:02:29 2002
@@ -80,7 +80,7 @@ int irlap_proc_read(char *, char **, off
 int __init irlap_init(void)
 {
 	/* Allocate master array */
-	irlap = hashbin_new(HB_LOCAL);
+	irlap = hashbin_new(HB_LOCK);
 	if (irlap == NULL) {
 	        ERROR("%s: can't allocate irlap hashbin!\n", __FUNCTION__);
 		return -ENOMEM;
@@ -146,7 +146,7 @@ struct irlap_cb *irlap_open(struct net_d
 	do {
 		get_random_bytes(&self->saddr, sizeof(self->saddr));
 	} while ((self->saddr == 0x0) || (self->saddr == BROADCAST) ||
-		 (hashbin_find(irlap, self->saddr, NULL)) );
+		 (hashbin_lock_find(irlap, self->saddr, NULL)) );
 	/* Copy to the driver */
 	memcpy(dev->dev_addr, &self->saddr, 4);
 
@@ -530,7 +530,8 @@ void irlap_discovery_request(struct irla
 		self->discovery_log = NULL;
 	}
 
-	self->discovery_log= hashbin_new(HB_LOCAL);
+	/* All operations will occur at predictable time, no need to lock */
+	self->discovery_log= hashbin_new(HB_NOLOCK);
 
 	info.S = discovery->nslots; /* Number of slots */
 	info.s = 0; /* Current slot */
@@ -1092,15 +1093,14 @@ int irlap_proc_read(char *buf, char **st
 	unsigned long flags;
 	int i = 0;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&irlap->hb_spinlock, flags);
 
 	len = 0;
 
 	self = (struct irlap_cb *) hashbin_get_first(irlap);
 	while (self != NULL) {
-		ASSERT(self != NULL, return -ENODEV;);
-		ASSERT(self->magic == LAP_MAGIC, return -EBADR;);
+		ASSERT(self != NULL, break;);
+		ASSERT(self->magic == LAP_MAGIC, break;);
 
 		len += sprintf(buf+len, "irlap%d ", i++);
 		len += sprintf(buf+len, "state: %s\n",
@@ -1172,7 +1172,7 @@ int irlap_proc_read(char *buf, char **st
 
 		self = (struct irlap_cb *) hashbin_get_next(irlap);
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&irlap->hb_spinlock, flags);
 
 	return len;
 }
diff -u -p -r linux/net/irda-d5/irlmp.c linux/net/irda/irlmp.c
--- linux/net/irda-d5/irlmp.c	Mon Aug 19 15:59:28 2002
+++ linux/net/irda/irlmp.c	Thu Aug 22 18:46:19 2002
@@ -83,13 +83,13 @@ int __init irlmp_init(void)
 	memset(irlmp, 0, sizeof(struct irlmp_cb));
 
 	irlmp->magic = LMP_MAGIC;
-	spin_lock_init(&irlmp->log_lock);
 
-	irlmp->clients = hashbin_new(HB_GLOBAL);
-	irlmp->services = hashbin_new(HB_GLOBAL);
-	irlmp->links = hashbin_new(HB_GLOBAL);
-	irlmp->unconnected_lsaps = hashbin_new(HB_GLOBAL);
-	irlmp->cachelog = hashbin_new(HB_GLOBAL);
+	irlmp->clients = hashbin_new(HB_LOCK);
+	irlmp->services = hashbin_new(HB_LOCK);
+	irlmp->links = hashbin_new(HB_LOCK);
+	irlmp->unconnected_lsaps = hashbin_new(HB_LOCK);
+	irlmp->cachelog = hashbin_new(HB_NOLOCK);
+	spin_lock_init(&irlmp->cachelog->hb_spinlock);
 
 	irlmp->free_lsap_sel = 0x10; /* Reserved 0x00-0x0f */
 	strcpy(sysctl_devname, "Linux");
@@ -286,7 +286,7 @@ void irlmp_register_link(struct irlap_cb
 	lap->magic = LMP_LAP_MAGIC;
 	lap->saddr = saddr;
 	lap->daddr = DEV_ADDR_ANY;
-	lap->lsaps = hashbin_new(HB_GLOBAL);
+	lap->lsaps = hashbin_new(HB_LOCK);
 #ifdef CONFIG_IRDA_CACHE_LAST_LSAP
 	lap->cache.valid = FALSE;
 #endif
@@ -347,7 +347,6 @@ int irlmp_connect_request(struct lsap_cb
 	struct sk_buff *skb = NULL;
 	struct lap_cb *lap;
 	struct lsap_cb *lsap;
-	discovery_t *discovery;
 
 	ASSERT(self != NULL, return -EBADR;);
 	ASSERT(self->magic == LMP_LSAP_MAGIC, return -EBADR;);
@@ -388,6 +387,10 @@ int irlmp_connect_request(struct lsap_cb
 	 * device with the given daddr
 	 */
 	if ((!saddr) || (saddr == DEV_ADDR_ANY)) {
+		discovery_t *discovery;
+		unsigned long flags;
+
+		spin_lock_irqsave(&irlmp->cachelog->hb_spinlock, flags);
 		if (daddr != DEV_ADDR_ANY)
 			discovery = hashbin_find(irlmp->cachelog, daddr, NULL);
 		else {
@@ -400,8 +403,9 @@ int irlmp_connect_request(struct lsap_cb
 			saddr = discovery->saddr;
 			daddr = discovery->daddr;
 		}
+		spin_unlock_irqrestore(&irlmp->cachelog->hb_spinlock, flags);
 	}
-	lap = hashbin_find(irlmp->links, saddr, NULL);
+	lap = hashbin_lock_find(irlmp->links, saddr, NULL);
 	if (lap == NULL) {
 		IRDA_DEBUG(1, __FUNCTION__ "(), Unable to find a usable link!\n");
 		return -EHOSTUNREACH;
@@ -411,11 +415,8 @@ int irlmp_connect_request(struct lsap_cb
 	if (lap->daddr == DEV_ADDR_ANY)
 		lap->daddr = daddr;
 	else if (lap->daddr != daddr) {
-		struct lsap_cb *any_lsap;
-
 		/* Check if some LSAPs are active on this LAP */
-		any_lsap = (struct lsap_cb *) hashbin_get_first(lap->lsaps);
-		if (any_lsap == NULL) {
+		if (HASHBIN_GET_SIZE(lap->lsaps) == 0) {
 			/* No active connection, but LAP hasn't been
 			 * disconnected yet (waiting for timeout in LAP).
 			 * Maybe we could give LAP a bit of help in this case.
@@ -575,25 +576,37 @@ void irlmp_connect_confirm(struct lsap_c
 struct lsap_cb *irlmp_dup(struct lsap_cb *orig, void *instance)
 {
 	struct lsap_cb *new;
+	unsigned long flags;
 
 	IRDA_DEBUG(1, __FUNCTION__ "()\n");
 
+	spin_lock_irqsave(&irlmp->unconnected_lsaps->hb_spinlock, flags);
+
 	/* Only allowed to duplicate unconnected LSAP's */
 	if (!hashbin_find(irlmp->unconnected_lsaps, (long) orig, NULL)) {
 		IRDA_DEBUG(0, __FUNCTION__ "(), unable to find LSAP\n");
+		spin_unlock_irqrestore(&irlmp->unconnected_lsaps->hb_spinlock,
+				       flags);
 		return NULL;
 	}
+	/* Allocate a new instance */
 	new = kmalloc(sizeof(struct lsap_cb), GFP_ATOMIC);
 	if (!new)  {
 		IRDA_DEBUG(0, __FUNCTION__ "(), unable to kmalloc\n");
+		spin_unlock_irqrestore(&irlmp->unconnected_lsaps->hb_spinlock,
+				       flags);
 		return NULL;
 	}
 	/* Dup */
 	memcpy(new, orig, sizeof(struct lsap_cb));
-	new->notify.instance = instance;
 	/* new->lap = orig->lap; => done in the memcpy() */
 	/* new->slsap_sel = orig->slsap_sel; => done in the memcpy() */
 
+	spin_unlock_irqrestore(&irlmp->unconnected_lsaps->hb_spinlock, flags);
+
+	/* Not everything is the same */
+	new->notify.instance = instance;
+
 	init_timer(&new->watchdog_timer);
 
 	hashbin_insert(irlmp->unconnected_lsaps, (irda_queue_t *) new,
@@ -887,7 +900,7 @@ void irlmp_check_services(discovery_t *d
 	 */
 	while ((service = service_log[i++]) != S_END) {
 		IRDA_DEBUG( 4, "service=%02x\n", service);
-		client = hashbin_find(irlmp->registry, service, NULL);
+		client = hashbin_lock_find(irlmp->registry, service, NULL);
 		if (entry && entry->discovery_callback) {
 			IRDA_DEBUG( 4, "discovery_callback!\n");
 
@@ -904,6 +917,7 @@ void irlmp_check_services(discovery_t *d
 	kfree(service_log);
 }
 #endif
+
 /*
  * Function irlmp_notify_client (log)
  *
@@ -931,6 +945,12 @@ irlmp_notify_client(irlmp_client_t *clie
 	/*
 	 * Now, check all discovered devices (if any), and notify client
 	 * only about the services that the client is interested in
+	 * Note : most often, we will get called immediately following
+	 * a discovery, so the log is not going to expire.
+	 * On the other hand, comming here through irlmp_discovery_request()
+	 * is *very* problematic - Jean II
+	 * Can't use hashbin_find_next(), key is not unique. I'm running
+	 * out of options :-( - Jean II
 	 */
 	discovery = (discovery_t *) hashbin_get_first(log);
 	while (discovery != NULL) {
@@ -957,6 +977,7 @@ irlmp_notify_client(irlmp_client_t *clie
 void irlmp_discovery_confirm(hashbin_t *log, DISCOVERY_MODE mode)
 {
 	irlmp_client_t *client;
+	irlmp_client_t *client_next;
 
 	IRDA_DEBUG(3, __FUNCTION__ "()\n");
 
@@ -966,11 +987,12 @@ void irlmp_discovery_confirm(hashbin_t *
 		return;
 
 	client = (irlmp_client_t *) hashbin_get_first(irlmp->clients);
-	while (client != NULL) {
+	while (NULL != hashbin_find_next(irlmp->clients, (long) client, NULL,
+					 (void *) &client_next) ) {
 		/* Check if we should notify client */
 		irlmp_notify_client(client, log, mode);
 
-		client = (irlmp_client_t *) hashbin_get_next(irlmp->clients);
+		client = client_next;
 	}
 }
 
@@ -988,13 +1010,15 @@ void irlmp_discovery_confirm(hashbin_t *
 void irlmp_discovery_expiry(discovery_t *expiry)
 {
 	irlmp_client_t *client;
+	irlmp_client_t *client_next;
 
 	IRDA_DEBUG(3, __FUNCTION__ "()\n");
 
 	ASSERT(expiry != NULL, return;);
 
 	client = (irlmp_client_t *) hashbin_get_first(irlmp->clients);
-	while (client != NULL) {
+	while (NULL != hashbin_find_next(irlmp->clients, (long) client, NULL,
+					 (void *) &client_next) ) {
 		/* Check if we should notify client */
 		if ((client->expir_callback) &&
 		    (client->hint_mask & expiry->hints.word & 0x7f7f))
@@ -1002,7 +1026,7 @@ void irlmp_discovery_expiry(discovery_t 
 					       client->priv);
 
 		/* Next client */
-		client = (irlmp_client_t *) hashbin_get_next(irlmp->clients);
+		client = client_next;
 	}
 }
 
@@ -1197,11 +1221,9 @@ void irlmp_status_indication(struct lap_
 	struct lsap_cb *curr;
 
 	/* Send status_indication to all LSAPs using this link */
-	next = (struct lsap_cb *) hashbin_get_first( self->lsaps);
-	while (next != NULL ) {
-		curr = next;
-		next = (struct lsap_cb *) hashbin_get_next(self->lsaps);
-
+	curr = (struct lsap_cb *) hashbin_get_first( self->lsaps);
+	while (NULL != hashbin_find_next(self->lsaps, (long) curr, NULL,
+					 (void *) &next) ) {
 		ASSERT(curr->magic == LMP_LSAP_MAGIC, return;);
 		/*
 		 *  Inform service user if he has requested it
@@ -1211,6 +1233,8 @@ void irlmp_status_indication(struct lap_
 						       link, lock);
 		else
 			IRDA_DEBUG(2, __FUNCTION__ "(), no handler\n");
+
+		curr = next;
 	}
 }
 
@@ -1246,29 +1270,15 @@ void irlmp_flow_indication(struct lap_cb
 	      (IRLAP_GET_TX_QUEUE_LEN(self->irlap) < LAP_HIGH_THRESHOLD)) {
 		/* Try to find the next lsap we should poll. */
 		next = self->flow_next;
-		if(next != NULL) {
-			/* Note that if there is only one LSAP on the LAP
-			 * (most common case), self->flow_next is always NULL,
-			 * so we always avoid this loop. - Jean II */
-			IRDA_DEBUG(4, __FUNCTION__ "() : searching my LSAP\n");
-
-			/* We look again in hashbins, because the lsap
-			 * might have gone away... - Jean II */
-			curr = (struct lsap_cb *) hashbin_get_first(self->lsaps);
-			while((curr != NULL ) && (curr != next))
-				curr = (struct lsap_cb *) hashbin_get_next(self->lsaps);
-		} else
-			curr = NULL;
-
 		/* If we have no lsap, restart from first one */
-		if(curr == NULL)
-			curr = (struct lsap_cb *) hashbin_get_first(self->lsaps);
+		if(next == NULL)
+			next = (struct lsap_cb *) hashbin_get_first(self->lsaps);
+		/* Verify current one and find the next one */
+		curr = hashbin_find_next(self->lsaps, (long) next, NULL,
+					 (void *) &self->flow_next);
 		/* Uh-oh... Paranoia */
 		if(curr == NULL)
 			break;
-
-		/* Next time, we will get the next one (or the first one) */
-		self->flow_next = (struct lsap_cb *) hashbin_get_next(self->lsaps);
 		IRDA_DEBUG(4, __FUNCTION__ "() : curr is %p, next was %p and is now %p, still %d to go - queue len = %d\n", curr, next, self->flow_next, lsap_todo, IRLAP_GET_TX_QUEUE_LEN(self->irlap));
 
 		/* Inform lsap user that it can send one more packet. */
@@ -1446,6 +1456,7 @@ void *irlmp_register_service(__u16 hints
 int irlmp_unregister_service(void *handle)
 {
 	irlmp_service_t *service;
+	unsigned long flags;
 
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
 
@@ -1453,7 +1464,7 @@ int irlmp_unregister_service(void *handl
 		return -1;
 
 	/* Caller may call with invalid handle (it's legal) - Jean II */
-	service = hashbin_find(irlmp->services, (long) handle, NULL);
+	service = hashbin_lock_find(irlmp->services, (long) handle, NULL);
 	if (!service) {
 		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown service!\n");
 		return -1;
@@ -1466,12 +1477,14 @@ int irlmp_unregister_service(void *handl
 	irlmp->hints.word = 0;
 
 	/* Refresh current hint bits */
+	spin_lock_irqsave(&irlmp->services->hb_spinlock, flags);
         service = (irlmp_service_t *) hashbin_get_first(irlmp->services);
         while (service) {
 		irlmp->hints.word |= service->hints;
 
                 service = (irlmp_service_t *)hashbin_get_next(irlmp->services);
         }
+	spin_unlock_irqrestore(&irlmp->services->hb_spinlock, flags);
 	return 0;
 }
 
@@ -1528,7 +1541,7 @@ int irlmp_update_client(void *handle, __
 	if (!handle)
 		return -1;
 
-	client = hashbin_find(irlmp->clients, (long) handle, NULL);
+	client = hashbin_lock_find(irlmp->clients, (long) handle, NULL);
 	if (!client) {
 		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown client!\n");
 		return -1;
@@ -1558,7 +1571,7 @@ int irlmp_unregister_client(void *handle
 		return -1;
 
 	/* Caller may call with invalid handle (it's legal) - Jean II */
-	client = hashbin_find(irlmp->clients, (long) handle, NULL);
+	client = hashbin_lock_find(irlmp->clients, (long) handle, NULL);
 	if (!client) {
 		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown client!\n");
 		return -1;
@@ -1580,6 +1593,7 @@ int irlmp_slsap_inuse(__u8 slsap_sel)
 {
 	struct lsap_cb *self;
 	struct lap_cb *lap;
+	unsigned long flags;
 
 	ASSERT(irlmp != NULL, return TRUE;);
 	ASSERT(irlmp->magic == LMP_MAGIC, return TRUE;);
@@ -1602,10 +1616,16 @@ int irlmp_slsap_inuse(__u8 slsap_sel)
 	 *  every IrLAP connection and check every LSAP assosiated with each
 	 *  the connection.
 	 */
+	spin_lock_irqsave(&irlmp->links->hb_spinlock, flags);
 	lap = (struct lap_cb *) hashbin_get_first(irlmp->links);
 	while (lap != NULL) {
 		ASSERT(lap->magic == LMP_LAP_MAGIC, return TRUE;);
 
+		/* Careful for priority inversions here !
+		 * All other uses of attrib spinlock are independant of
+		 * the object spinlock, so we are safe. Jean II */
+		spin_lock(&lap->lsaps->hb_spinlock);
+
 		self = (struct lsap_cb *) hashbin_get_first(lap->lsaps);
 		while (self != NULL) {
 			ASSERT(self->magic == LMP_LSAP_MAGIC, return TRUE;);
@@ -1617,8 +1637,11 @@ int irlmp_slsap_inuse(__u8 slsap_sel)
 			}
 			self = (struct lsap_cb*) hashbin_get_next(lap->lsaps);
 		}
+		spin_unlock(&lap->lsaps->hb_spinlock);
+		/* Next LAP */
 		lap = (struct lap_cb *) hashbin_get_next(irlmp->links);
 	}
+	spin_unlock_irqrestore(&irlmp->links->hb_spinlock, flags);
 	return FALSE;
 }
 
@@ -1727,15 +1750,13 @@ int irlmp_proc_read(char *buf, char **st
 
 	ASSERT(irlmp != NULL, return 0;);
 
-	save_flags( flags);
-	cli();
-
 	len = 0;
 
 	len += sprintf( buf+len, "Unconnected LSAPs:\n");
+	spin_lock_irqsave(&irlmp->unconnected_lsaps->hb_spinlock, flags);
 	self = (struct lsap_cb *) hashbin_get_first( irlmp->unconnected_lsaps);
 	while (self != NULL) {
-		ASSERT(self->magic == LMP_LSAP_MAGIC, return 0;);
+		ASSERT(self->magic == LMP_LSAP_MAGIC, break;);
 		len += sprintf(buf+len, "lsap state: %s, ",
 			       irlsap_state[ self->lsap_state]);
 		len += sprintf(buf+len,
@@ -1747,9 +1768,10 @@ int irlmp_proc_read(char *buf, char **st
 		self = (struct lsap_cb *) hashbin_get_next(
 			irlmp->unconnected_lsaps);
 	}
+	spin_unlock_irqrestore(&irlmp->unconnected_lsaps->hb_spinlock, flags);
 
 	len += sprintf(buf+len, "\nRegistred Link Layers:\n");
-
+	spin_lock_irqsave(&irlmp->links->hb_spinlock, flags);
 	lap = (struct lap_cb *) hashbin_get_first(irlmp->links);
 	while (lap != NULL) {
 		len += sprintf(buf+len, "lap state: %s, ",
@@ -1761,10 +1783,15 @@ int irlmp_proc_read(char *buf, char **st
 			       HASHBIN_GET_SIZE(lap->lsaps));
 		len += sprintf(buf+len, "\n");
 
+		/* Careful for priority inversions here !
+		 * All other uses of attrib spinlock are independant of
+		 * the object spinlock, so we are safe. Jean II */
+		spin_lock(&lap->lsaps->hb_spinlock);
+
 		len += sprintf(buf+len, "\n  Connected LSAPs:\n");
 		self = (struct lsap_cb *) hashbin_get_first(lap->lsaps);
 		while (self != NULL) {
-			ASSERT(self->magic == LMP_LSAP_MAGIC, return 0;);
+			ASSERT(self->magic == LMP_LSAP_MAGIC, break;);
 			len += sprintf(buf+len, "  lsap state: %s, ",
 				       irlsap_state[ self->lsap_state]);
 			len += sprintf(buf+len,
@@ -1776,11 +1803,12 @@ int irlmp_proc_read(char *buf, char **st
 			self = (struct lsap_cb *) hashbin_get_next(
 				lap->lsaps);
 		}
+		spin_unlock(&lap->lsaps->hb_spinlock);
 		len += sprintf(buf+len, "\n");
 
 		lap = (struct lap_cb *) hashbin_get_next(irlmp->links);
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&irlmp->links->hb_spinlock, flags);
 
 	return len;
 }
diff -u -p -r linux/net/irda-d5/irlmp_event.c linux/net/irda/irlmp_event.c
--- linux/net/irda-d5/irlmp_event.c	Mon Aug 19 15:59:28 2002
+++ linux/net/irda/irlmp_event.c	Wed Aug 21 13:34:03 2002
@@ -207,6 +207,43 @@ void irlmp_idle_timer_expired(void *data
 	irlmp_do_lap_event(self, LM_LAP_IDLE_TIMEOUT, NULL);
 }
 
+/*
+ * Send an event on all LSAPs attached to this LAP.
+ */
+static inline void
+irlmp_do_all_lsap_event(hashbin_t *	lsap_hashbin,
+			IRLMP_EVENT	event)
+{
+	struct lsap_cb *lsap;
+	struct lsap_cb *lsap_next;
+
+	/* Note : this function use the new hashbin_find_next()
+	 * function, instead of the old hashbin_get_next().
+	 * This make sure that we are always pointing one lsap
+	 * ahead, so that if the current lsap is removed as the
+	 * result of sending the event, we don't care.
+	 * Also, as we store the context ourselves, if an enumeration
+	 * of the same lsap hashbin happens as the result of sending the
+	 * event, we don't care.
+	 * The only problem is if the next lsap is removed. In that case,
+	 * hashbin_find_next() will return NULL and we will abort the
+	 * enumeration. - Jean II */
+
+	/* Also : we don't accept any skb in input. We can *NOT* pass
+	 * the same skb to multiple clients safely, we would need to
+	 * skb_clone() it. - Jean II */
+
+	lsap = (struct lsap_cb *) hashbin_get_first(lsap_hashbin);
+
+	while (NULL != hashbin_find_next(lsap_hashbin,
+					 (long) lsap,
+					 NULL,
+					 (void *) &lsap_next) ) {
+		irlmp_do_lsap_event(lsap, event, NULL);
+		lsap = lsap_next;
+	}
+}
+
 /*********************************************************************
  *
  *    LAP connection control states
@@ -274,9 +311,6 @@ static void irlmp_state_standby(struct l
 static void irlmp_state_u_connect(struct lap_cb *self, IRLMP_EVENT event,
 				  struct sk_buff *skb)
 {
-	struct lsap_cb *lsap;
-	struct lsap_cb *lsap_current;
-
 	IRDA_DEBUG(2, __FUNCTION__ "(), event=%s\n", irlmp_event[event]);
 
 	switch (event) {
@@ -290,11 +324,9 @@ static void irlmp_state_u_connect(struct
 		/* Just accept connection TODO, this should be fixed */
 		irlap_connect_response(self->irlap, skb);
 
-		lsap = (struct lsap_cb *) hashbin_get_first(self->lsaps);
-		while (lsap != NULL) {
-			irlmp_do_lsap_event(lsap, LM_LAP_CONNECT_CONFIRM, NULL);
-			lsap = (struct lsap_cb*) hashbin_get_next(self->lsaps);
-		}
+		/* Tell LSAPs that they can start sending data */
+		irlmp_do_all_lsap_event(self->lsaps, LM_LAP_CONNECT_CONFIRM);
+
 		/* Note : by the time we get there (LAP retries and co),
 		 * the lsaps may already have gone. This avoid getting stuck
 		 * forever in LAP_ACTIVE state - Jean II */
@@ -310,11 +342,9 @@ static void irlmp_state_u_connect(struct
 		/* For all lsap_ce E Associated do LS_Connect_confirm */
 		irlmp_next_lap_state(self, LAP_ACTIVE);
 
-		lsap = (struct lsap_cb *) hashbin_get_first(self->lsaps);
-		while (lsap != NULL) {
-			irlmp_do_lsap_event(lsap, LM_LAP_CONNECT_CONFIRM, NULL);
-			lsap = (struct lsap_cb*) hashbin_get_next(self->lsaps);
-		}
+		/* Tell LSAPs that they can start sending data */
+		irlmp_do_all_lsap_event(self->lsaps, LM_LAP_CONNECT_CONFIRM);
+
 		/* Note : by the time we get there (LAP retries and co),
 		 * the lsaps may already have gone. This avoid getting stuck
 		 * forever in LAP_ACTIVE state - Jean II */
@@ -328,18 +358,8 @@ static void irlmp_state_u_connect(struct
 		irlmp_next_lap_state(self, LAP_STANDBY);
 
 		/* Send disconnect event to all LSAPs using this link */
-		lsap = (struct lsap_cb *) hashbin_get_first( self->lsaps);
-		while (lsap != NULL ) {
-			ASSERT(lsap->magic == LMP_LSAP_MAGIC, return;);
-
-			lsap_current = lsap;
-
-			/* Be sure to stay one item ahead */
-			lsap = (struct lsap_cb *) hashbin_get_next(self->lsaps);
-			irlmp_do_lsap_event(lsap_current,
-					    LM_LAP_DISCONNECT_INDICATION,
-					    NULL);
-		}
+		irlmp_do_all_lsap_event(self->lsaps,
+					LM_LAP_DISCONNECT_INDICATION);
 		break;
 	case LM_LAP_DISCONNECT_REQUEST:
 		IRDA_DEBUG(4, __FUNCTION__ "(), LM_LAP_DISCONNECT_REQUEST\n");
@@ -368,9 +388,6 @@ static void irlmp_state_u_connect(struct
 static void irlmp_state_active(struct lap_cb *self, IRLMP_EVENT event,
 			       struct sk_buff *skb)
 {
-	struct lsap_cb *lsap;
-	struct lsap_cb *lsap_current;
-
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
 
 	switch (event) {
@@ -383,22 +400,11 @@ static void irlmp_state_active(struct la
 		 *  notify all LSAPs using this LAP, but that should be safe to
 		 *  do anyway.
 		 */
-		lsap = (struct lsap_cb *) hashbin_get_first(self->lsaps);
-		while (lsap != NULL) {
-			irlmp_do_lsap_event(lsap, LM_LAP_CONNECT_CONFIRM, NULL);
-			lsap = (struct lsap_cb*) hashbin_get_next(self->lsaps);
-		}
+		irlmp_do_all_lsap_event(self->lsaps, LM_LAP_CONNECT_CONFIRM);
 
 		/* Needed by connect indication */
-		lsap = (struct lsap_cb *) hashbin_get_first(irlmp->unconnected_lsaps);
-		while (lsap != NULL) {
-			lsap_current = lsap;
-
-			/* Be sure to stay one item ahead */
-			lsap = (struct lsap_cb*) hashbin_get_next(irlmp->unconnected_lsaps);
-			irlmp_do_lsap_event(lsap_current,
-					    LM_LAP_CONNECT_CONFIRM, NULL);
-		}
+		irlmp_do_all_lsap_event(irlmp->unconnected_lsaps,
+					LM_LAP_CONNECT_CONFIRM);
 		/* Keep state */
 		break;
 	case LM_LAP_DISCONNECT_REQUEST:
@@ -447,18 +453,8 @@ static void irlmp_state_active(struct la
 		/*
 		 *  Inform all connected LSAP's using this link
 		 */
-		lsap = (struct lsap_cb *) hashbin_get_first(self->lsaps);
-		while (lsap != NULL ) {
-			ASSERT(lsap->magic == LMP_LSAP_MAGIC, return;);
-
-			lsap_current = lsap;
-
-			/* Be sure to stay one item ahead */
-			lsap = (struct lsap_cb *) hashbin_get_next(self->lsaps);
-			irlmp_do_lsap_event(lsap_current,
-					    LM_LAP_DISCONNECT_INDICATION,
-					    NULL);
-		}
+		irlmp_do_all_lsap_event(self->lsaps,
+					LM_LAP_DISCONNECT_INDICATION);
 
 		/* Force an expiry of the discovery log.
 		 * Now that the LAP is free, the system may attempt to
diff -u -p -r linux/net/irda-d5/irlmp_frame.c linux/net/irda/irlmp_frame.c
--- linux/net/irda-d5/irlmp_frame.c	Sat Jun  8 22:30:42 2002
+++ linux/net/irda/irlmp_frame.c	Thu Aug 29 11:04:53 2002
@@ -210,6 +210,7 @@ void irlmp_link_unitdata_indication(stru
 	__u8   dlsap_sel;   /* Destination LSAP address */
 	__u8   pid;         /* Protocol identifier */
 	__u8   *fp;
+	unsigned long flags;
 	
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
 
@@ -242,6 +243,8 @@ void irlmp_link_unitdata_indication(stru
 		return;
 	}
 	
+	/* Search the connectionless LSAP */
+	spin_lock_irqsave(&irlmp->unconnected_lsaps->hb_spinlock, flags);
 	lsap = (struct lsap_cb *) hashbin_get_first(irlmp->unconnected_lsaps);
 	while (lsap != NULL) {
 		/*
@@ -255,6 +258,8 @@ void irlmp_link_unitdata_indication(stru
 		}
 		lsap = (struct lsap_cb *) hashbin_get_next(irlmp->unconnected_lsaps);
 	}
+	spin_unlock_irqrestore(&irlmp->unconnected_lsaps->hb_spinlock, flags);
+
 	if (lsap)
 		irlmp_connless_data_indication(lsap, skb);
 	else {
@@ -374,6 +379,7 @@ void irlmp_link_discovery_indication(str
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LMP_LAP_MAGIC, return;);
 
+	/* Add to main log, cleanup */
 	irlmp_add_discovery(irlmp->cachelog, discovery);
 	
 	/* Just handle it the same way as a discovery confirm,
@@ -396,6 +402,7 @@ void irlmp_link_discovery_confirm(struct
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LMP_LAP_MAGIC, return;);
 	
+	/* Add to main log, cleanup */
 	irlmp_add_discovery_log(irlmp->cachelog, log);
 
 	/* Propagate event to various LSAPs registered for it.
@@ -411,6 +418,8 @@ void irlmp_link_discovery_confirm(struct
 static inline void irlmp_update_cache(struct lap_cb *lap,
 				      struct lsap_cb *lsap)
 {
+	/* Prevent concurent read to get garbage */
+	lap->cache.valid = FALSE;
 	/* Update cache entry */
 	lap->cache.dlsap_sel = lsap->dlsap_sel;
 	lap->cache.slsap_sel = lsap->slsap_sel;
@@ -441,6 +450,7 @@ static struct lsap_cb *irlmp_find_lsap(s
 				       hashbin_t *queue) 
 {
 	struct lsap_cb *lsap;
+	unsigned long flags;
 	
 	/* 
 	 *  Optimize for the common case. We assume that the last frame
@@ -455,6 +465,9 @@ static struct lsap_cb *irlmp_find_lsap(s
 		return (self->cache.lsap);
 	}
 #endif
+
+	spin_lock_irqsave(&queue->hb_spinlock, flags);
+
 	lsap = (struct lsap_cb *) hashbin_get_first(queue);
 	while (lsap != NULL) {
 		/* 
@@ -465,29 +478,27 @@ static struct lsap_cb *irlmp_find_lsap(s
 		 */
 		if ((status == CONNECT_CMD) && 
 		    (lsap->slsap_sel == slsap_sel) &&      
-		    (lsap->dlsap_sel == LSAP_ANY)) 
-		{
+		    (lsap->dlsap_sel == LSAP_ANY)) {
+			/* This is where the dest lsap sel is set on incomming
+			 * lsaps */
 			lsap->dlsap_sel = dlsap_sel;
-			
-#ifdef CONFIG_IRDA_CACHE_LAST_LSAP
-			irlmp_update_cache(self, lsap);
-#endif
-			return lsap;
+			break;
 		}
 		/*
 		 *  Check if source LSAP and dest LSAP selectors match.
 		 */
 		if ((lsap->slsap_sel == slsap_sel) && 
 		    (lsap->dlsap_sel == dlsap_sel)) 
-		{
-#ifdef CONFIG_IRDA_CACHE_LAST_LSAP
-			irlmp_update_cache(self, lsap);
-#endif
-			return lsap;
-		}
+			break;
+
 		lsap = (struct lsap_cb *) hashbin_get_next(queue);
 	}
+#ifdef CONFIG_IRDA_CACHE_LAST_LSAP
+	if(lsap)
+		irlmp_update_cache(self, lsap);
+#endif
+	spin_unlock_irqrestore(&queue->hb_spinlock, flags);
 
-	/* Sorry not found! */
-	return NULL;
+	/* Return what we've found or NULL */
+	return lsap;
 }
diff -u -p -r linux/net/irda-d5/irqueue.c linux/net/irda/irqueue.c
--- linux/net/irda-d5/irqueue.c	Mon Aug 19 15:59:28 2002
+++ linux/net/irda/irqueue.c	Thu Aug 22 18:52:55 2002
@@ -49,11 +49,397 @@
  * Jean II
  */
 
+/*
+ * Notes on the concurent access to hashbin and other SMP issues
+ * -------------------------------------------------------------
+ *	Hashbins are very often in the IrDA stack a global repository of
+ * information, and therefore used in a very asynchronous manner following
+ * various events (driver calls, timers, user calls...).
+ *	Therefore, very often it is highly important to consider the
+ * management of concurent access to the hashbin and how to guarantee the
+ * consistency of the operations on it.
+ *
+ *	First, we need to define the objective of locking :
+ *		1) Protect user data (content pointed by the hashbin)
+ *		2) Protect hashbin structure itself (linked list in each bin)
+ *
+ *			     OLD LOCKING
+ *			     -----------
+ *
+ *	The previous locking strategy, either HB_LOCAL or HB_GLOBAL were
+ * both inadequate in *both* aspect.
+ *		o HB_GLOBAL was using a spinlock for each bin (local locking).
+ *		o HB_LOCAL was disabling irq on *all* CPUs, so use a single
+ *		  global semaphore.
+ *	The problems were :
+ *		A) Global irq disabling is no longer supported by the kernel
+ *		B) No protection for the hashbin struct global data
+ *			o hashbin_delete()
+ *			o hb_current
+ *		C) No protection for user data in some cases
+ *
+ *	A) HB_LOCAL use global irq disabling, so doesn't work on kernel
+ * 2.5.X. Even when it is supported (kernel 2.4.X and earlier), its
+ * performance is not satisfactory on SMP setups. Most hashbins were
+ * HB_LOCAL, so (A) definitely need fixing.
+ *	B) HB_LOCAL could be modified to fix (B). However, because HB_GLOBAL
+ * lock only the individual bins, it will never be able to lock the
+ * global data, so can't do (B).
+ *	C) Some functions return pointer to data that is still in the
+ * hashbin :
+ *		o hashbin_find()
+ *		o hashbin_get_first()
+ *		o hashbin_get_next()
+ *	As the data is still in the hashbin, it may be changed or free'd
+ * while the caller is examinimg the data. In those case, locking can't
+ * be done within the hashbin, but must include use of the data within
+ * the caller.
+ *	The caller can easily do this with HB_LOCAL (just disable irqs).
+ * However, this is impossible with HB_GLOBAL because the caller has no
+ * way to know the proper bin, so don't know which spinlock to use.
+ *
+ *	Quick summary : can no longer use HB_LOCAL, and HB_GLOBAL is
+ * fundamentally broken and will never work.
+ *
+ *			     NEW LOCKING
+ *			     -----------
+ *
+ *	To fix those problems, I've introduce a few changes in the
+ * hashbin locking :
+ *		1) New HB_LOCK scheme
+ *		2) hashbin->hb_spinlock
+ *		3) New hashbin usage policy
+ *
+ * HB_LOCK :
+ * -------
+ *	HB_LOCK is a locking scheme intermediate between the old HB_LOCAL
+ * and HB_GLOBAL. It uses a single spinlock to protect the whole content
+ * of the hashbin. As it is a single spinlock, it can protect the global
+ * data of the hashbin and not only the bins themselves.
+ *	HB_LOCK can only protect some of the hashbin calls, so it only lock
+ * call that can be made 100% safe and leave other call unprotected.
+ *	HB_LOCK in theory is slower than HB_GLOBAL, but as the hashbin
+ * content is always small contention is not high, so it doesn't matter
+ * much. HB_LOCK is probably faster than HB_LOCAL.
+ *
+ * hashbin->hb_spinlock :
+ * --------------------
+ *	The spinlock that HB_LOCK uses is available for caller, so that
+ * the caller can protect unprotected calls (see below).
+ *	If the caller want to do entirely its own locking (HB_NOLOCK), he
+ * can do so and may use safely this spinlock.
+ *	Locking is done like this :
+ *		spin_lock_irqsave(&hashbin->hb_spinlock, flags);
+ *	Releasing the lock :
+ *		spin_unlock_irqrestore(&hashbin->hb_spinlock, flags);
+ *
+ * Safe & Protected calls :
+ * ----------------------
+ *	The following calls are safe or protected via HB_LOCK :
+ *		o hashbin_new()		-> safe
+ *		o hashbin_delete()
+ *		o hashbin_insert()
+ *		o hashbin_remove_first()
+ *		o hashbin_remove()
+ *		o hashbin_remove_this()
+ *		o HASHBIN_GET_SIZE()	-> atomic
+ *
+ *	The following calls only protect the hashbin itself :
+ *		o hashbin_lock_find()
+ *		o hashbin_find_next()
+ *
+ * Unprotected calls :
+ * -----------------
+ *	The following calls need to be protected by the caller :
+ *		o hashbin_find()
+ *		o hashbin_get_first()
+ *		o hashbin_get_next()
+ *
+ * Locking Policy :
+ * --------------
+ *	If the hashbin is used only in a single thread of execution
+ * (explicitely or implicitely), you can use HB_NOLOCK
+ *	If the calling module already provide concurent access protection,
+ * you may use HB_NOLOCK.
+ *
+ *	In all other cases, you need to use HB_LOCK and lock the hashbin
+ * everytime before calling one of the unprotected calls. You also must
+ * use the pointer returned by the unprotected call within the locked
+ * region.
+ *
+ * Extra care for enumeration :
+ * --------------------------
+ *	hashbin_get_first() and hashbin_get_next() use the hashbin to
+ * store the current position, in hb_current.
+ *	As long as the hashbin remains locked, this is safe. If you unlock
+ * the hashbin, the current position may change if anybody else modify
+ * or enumerate the hashbin.
+ *	Summary : do the full enumeration while locked.
+ *
+ *	Alternatively, you may use hashbin_find_next(). But, this will
+ * be slower, is more complex to use and doesn't protect the hashbin
+ * content. So, care is needed here as well.
+ *
+ * Other issues :
+ * ------------
+ *	I believe that we are overdoing it by using spin_lock_irqsave()
+ * and we should use only spin_lock_bh() or similar. But, I don't have
+ * the balls to try it out.
+ *	Don't believe that because hashbin are now (somewhat) SMP safe
+ * that the rest of the code is. Higher layers tend to be safest,
+ * but LAP and LMP would need some serious dedicated love.
+ *
+ * Jean II
+ */
+
 #include <net/irda/irda.h>
 #include <net/irda/irqueue.h>
 
-static irda_queue_t *dequeue_general( irda_queue_t **queue, irda_queue_t* element);
-static __u32 hash( char* name);
+/************************ QUEUE SUBROUTINES ************************/
+
+/*
+ * Hashbin
+ */
+#define GET_HASHBIN(x) ( x & HASHBIN_MASK )
+
+/*
+ * Function hash (name)
+ *
+ *    This function hash the input string 'name' using the ELF hash
+ *    function for strings.
+ */
+static __u32 hash( char* name)
+{
+	__u32 h = 0;
+	__u32 g;
+	
+	while(*name) {
+		h = (h<<4) + *name++;
+		if ((g = (h & 0xf0000000)))
+			h ^=g>>24;
+		h &=~g;
+	}
+	return h;
+}
+
+/*
+ * Function enqueue_first (queue, proc)
+ *
+ *    Insert item first in queue.
+ *
+ */
+static void enqueue_first(irda_queue_t **queue, irda_queue_t* element)
+{
+	
+	IRDA_DEBUG( 4, __FUNCTION__ "()\n");
+
+	/*
+	 * Check if queue is empty.
+	 */
+	if ( *queue == NULL ) {
+		/*
+		 * Queue is empty.  Insert one element into the queue.
+		 */
+		element->q_next = element->q_prev = *queue = element;
+		
+	} else {
+		/*
+		 * Queue is not empty.  Insert element into front of queue.
+		 */
+		element->q_next          = (*queue);
+		(*queue)->q_prev->q_next = element;
+		element->q_prev          = (*queue)->q_prev;
+		(*queue)->q_prev         = element;
+		(*queue)                 = element;
+	}
+}
+
+#ifdef HASHBIN_UNUSED
+/*
+ * Function enqueue_last (queue, proc)
+ *
+ *    Insert item into end of queue.
+ *
+ */
+static void __enqueue_last( irda_queue_t **queue, irda_queue_t* element)
+{
+	IRDA_DEBUG( 4, __FUNCTION__ "()\n");
+
+	/*
+	 * Check if queue is empty.
+	 */
+	if ( *queue == NULL ) {
+		/*
+		 * Queue is empty.  Insert one element into the queue.
+		 */
+		element->q_next = element->q_prev = *queue = element;
+		
+	} else {
+		/*
+		 * Queue is not empty.  Insert element into end of queue.
+		 */
+		element->q_prev         = (*queue)->q_prev;
+		element->q_prev->q_next = element;
+		(*queue)->q_prev        = element;
+		element->q_next         = *queue;
+	}	
+}
+
+static inline void enqueue_last( irda_queue_t **queue, irda_queue_t* element)
+{
+	unsigned long flags;
+	
+        save_flags(flags);
+        cli();
+
+        __enqueue_last( queue, element);
+
+        restore_flags(flags);
+}
+
+/*
+ * Function enqueue_queue (queue, list)
+ *
+ *    Insert a queue (list) into the start of the first queue
+ *
+ */
+static void enqueue_queue( irda_queue_t** queue, irda_queue_t** list )
+{
+	irda_queue_t* tmp;
+	
+	/*
+	 * Check if queue is empty
+	 */ 
+	if ( *queue ) {
+		(*list)->q_prev->q_next  = (*queue);
+		(*queue)->q_prev->q_next = (*list); 
+		tmp                      = (*list)->q_prev;
+		(*list)->q_prev          = (*queue)->q_prev;
+		(*queue)->q_prev         = tmp;
+	} else {
+		*queue                   = (*list); 
+	}
+	
+	(*list) = NULL;
+}
+
+/*
+ * Function enqueue_second (queue, proc)
+ *
+ *    Insert item behind head of queue.
+ *
+ */
+static void enqueue_second(irda_queue_t **queue, irda_queue_t* element)
+{
+	IRDA_DEBUG( 0, "enqueue_second()\n");
+
+	/*
+	 * Check if queue is empty.
+	 */
+	if ( *queue == NULL ) {
+		/*
+		 * Queue is empty.  Insert one element into the queue.
+		 */
+		element->q_next = element->q_prev = *queue = element;
+		
+	} else {
+		/*
+		 * Queue is not empty.  Insert element into ..
+		 */
+		element->q_prev = (*queue);
+		(*queue)->q_next->q_prev = element;
+		element->q_next = (*queue)->q_next;
+		(*queue)->q_next = element;
+	}
+}
+#endif /* HASHBIN_UNUSED */
+
+/*
+ * Function dequeue (queue)
+ *
+ *    Remove first entry in queue
+ *
+ */
+static irda_queue_t *dequeue_first(irda_queue_t **queue)
+{
+	irda_queue_t *ret;
+
+	IRDA_DEBUG( 4, "dequeue_first()\n");
+	
+	/*
+	 * Set return value
+	 */
+	ret =  *queue;
+	
+	if ( *queue == NULL ) {
+		/*
+		 * Queue was empty.
+		 */
+	} else if ( (*queue)->q_next == *queue ) {
+		/* 
+		 *  Queue only contained a single element. It will now be
+		 *  empty.  
+		 */
+		*queue = NULL;
+	} else {
+		/*
+		 * Queue contained several element.  Remove the first one.
+		 */
+		(*queue)->q_prev->q_next = (*queue)->q_next;
+		(*queue)->q_next->q_prev = (*queue)->q_prev;
+		*queue = (*queue)->q_next;
+	}
+	
+	/*
+	 * Return the removed entry (or NULL of queue was empty).
+	 */
+	return ret;
+}
+
+/*
+ * Function dequeue_general (queue, element)
+ *
+ *
+ */
+static irda_queue_t *dequeue_general(irda_queue_t **queue, irda_queue_t* element)
+{
+	irda_queue_t *ret;
+	
+	IRDA_DEBUG( 4, "dequeue_general()\n");
+	
+	/*
+	 * Set return value
+	 */
+	ret =  *queue;
+		
+	if ( *queue == NULL ) {
+		/*
+		 * Queue was empty.
+		 */
+	} else if ( (*queue)->q_next == *queue ) {
+		/* 
+		 *  Queue only contained a single element. It will now be
+		 *  empty.  
+		 */
+		*queue = NULL;
+		
+	} else {
+		/*
+		 *  Remove specific element.
+		 */
+		element->q_prev->q_next = element->q_next;
+		element->q_next->q_prev = element->q_prev;
+		if ( (*queue) == element)
+			(*queue) = element->q_next;
+	}
+	
+	/*
+	 * Return the removed entry (or NULL of queue was empty).
+	 */
+	return ret;
+}
+
+/************************ HASHBIN MANAGEMENT ************************/
 
 /*
  * Function hashbin_create ( type, name )
@@ -64,7 +450,6 @@ static __u32 hash( char* name);
 hashbin_t *hashbin_new(int type)
 {
 	hashbin_t* hashbin;
-	int i;
 	
 	/*
 	 * Allocate new hashbin
@@ -79,14 +464,17 @@ hashbin_t *hashbin_new(int type)
 	memset(hashbin, 0, sizeof(hashbin_t));
 	hashbin->hb_type = type;
 	hashbin->magic = HB_MAGIC;
+	//hashbin->hb_current = NULL;
 
 	/* Make sure all spinlock's are unlocked */
-	for (i=0;i<HASHBIN_SIZE;i++)
-		hashbin->hb_mutex[i] = SPIN_LOCK_UNLOCKED;
-	
+	if ( hashbin->hb_type & HB_LOCK ) {
+		spin_lock_init(&hashbin->hb_spinlock);
+	}
+
 	return hashbin;
 }
 
+#ifdef HASHBIN_UNUSED
 /*
  * Function hashbin_clear (hashbin, free_func)
  *
@@ -117,7 +505,7 @@ int hashbin_clear( hashbin_t* hashbin, F
 
 	return 0;
 }
-
+#endif /* HASHBIN_UNUSED */
 
 /*
  * Function hashbin_delete (hashbin, free_func)
@@ -129,11 +517,17 @@ int hashbin_clear( hashbin_t* hashbin, F
 int hashbin_delete( hashbin_t* hashbin, FREE_FUNC free_func)
 {
 	irda_queue_t* queue;
+	unsigned long flags = 0;
 	int i;
 
 	ASSERT(hashbin != NULL, return -1;);
 	ASSERT(hashbin->magic == HB_MAGIC, return -1;);
 	
+	/* Synchronize */
+	if ( hashbin->hb_type & HB_LOCK ) {
+		spin_lock_irqsave(&hashbin->hb_spinlock, flags);
+	}
+
 	/*
 	 *  Free the entries in the hashbin, TODO: use hashbin_clear when
 	 *  it has been shown to work
@@ -148,15 +542,25 @@ int hashbin_delete( hashbin_t* hashbin, 
 		}
 	}
 	
+	/* Cleanup local data */
+	hashbin->hb_current = NULL;
+	hashbin->magic = ~HB_MAGIC;
+
+	/* Release lock */
+	if ( hashbin->hb_type & HB_LOCK) {
+		spin_unlock_irqrestore(&hashbin->hb_spinlock, flags);
+	}
+
 	/*
 	 *  Free the hashbin structure
 	 */
-	hashbin->magic = ~HB_MAGIC;
 	kfree(hashbin);
 
 	return 0;
 }
 
+/********************* HASHBIN LIST OPERATIONS *********************/
+
 /*
  * Function hashbin_insert (hashbin, entry, name)
  *
@@ -181,12 +585,8 @@ void hashbin_insert(hashbin_t* hashbin, 
 	bin = GET_HASHBIN( hashv );
 
 	/* Synchronize */
-	if ( hashbin->hb_type & HB_GLOBAL ) {
-		spin_lock_irqsave( &hashbin->hb_mutex[ bin ], flags);
-
-	} else if ( hashbin->hb_type & HB_LOCAL ) {
-		save_flags(flags);
-		cli();
+	if ( hashbin->hb_type & HB_LOCK ) {
+		spin_lock_irqsave(&hashbin->hb_spinlock, flags);
 	} /* Default is no-lock  */
 	
 	/*
@@ -209,102 +609,61 @@ void hashbin_insert(hashbin_t* hashbin, 
 	hashbin->hb_size++;
 
 	/* Release lock */
-	if ( hashbin->hb_type & HB_GLOBAL) {
-
-		spin_unlock_irqrestore( &hashbin->hb_mutex[ bin], flags);
-
-	} else if ( hashbin->hb_type & HB_LOCAL) {
-		restore_flags( flags);
-	}
+	if ( hashbin->hb_type & HB_LOCK ) {
+		spin_unlock_irqrestore(&hashbin->hb_spinlock, flags);
+	} /* Default is no-lock  */
 }
 
-/*
- * Function hashbin_find (hashbin, hashv, name)
+/* 
+ *  Function hashbin_remove_first (hashbin)
  *
- *    Find item with the given hashv or name
+ *    Remove first entry of the hashbin
  *
+ * Note : this function no longer use hashbin_remove(), but does things
+ * similar to hashbin_remove_this(), so can be considered safe.
+ * Jean II
  */
-void* hashbin_find( hashbin_t* hashbin, long hashv, char* name )
+void *hashbin_remove_first( hashbin_t *hashbin)
 {
-	int bin, found = FALSE;
 	unsigned long flags = 0;
-	irda_queue_t* entry;
-
-	IRDA_DEBUG( 4, "hashbin_find()\n");
-
-	ASSERT( hashbin != NULL, return NULL;);
-	ASSERT( hashbin->magic == HB_MAGIC, return NULL;);
+	irda_queue_t *entry = NULL;
 
-	/*
-	 * Locate hashbin
-	 */
-	if ( name )
-		hashv = hash( name );
-	bin = GET_HASHBIN( hashv );
-	
 	/* Synchronize */
-	if ( hashbin->hb_type & HB_GLOBAL ) {
-		spin_lock_irqsave( &hashbin->hb_mutex[ bin ], flags);
-
-	} else if ( hashbin->hb_type & HB_LOCAL ) {
-		save_flags(flags);
-		cli();
+	if ( hashbin->hb_type & HB_LOCK ) {
+		spin_lock_irqsave(&hashbin->hb_spinlock, flags);
 	} /* Default is no-lock  */
-	
-	/*
-	 * Search for entry
-	 */
-	entry = hashbin->hb_queue[ bin];
-	if ( entry ) {
-		do {
-			/*
-			 * Check for key
-			 */
-			if ( entry->q_hash == hashv ) {
-				/*
-				 * Name compare too?
-				 */
-				if ( name ) {
-					if ( strcmp( entry->q_name, name ) == 0 ) {
-						found = TRUE;
-						break;
-					}
-				} else {
-					found = TRUE;
-					break;
-				}
-			}
-			entry = entry->q_next;
-		} while ( entry != hashbin->hb_queue[ bin ] );
-	}
-	
-	/* Release lock */
-	if ( hashbin->hb_type & HB_GLOBAL) {
-		spin_unlock_irqrestore( &hashbin->hb_mutex[ bin], flags);
 
-	} else if ( hashbin->hb_type & HB_LOCAL) {
-		restore_flags( flags);
-	}
-	
-	if ( found ) 
-		return entry;
-	else
-		return NULL;
-}
-
-void *hashbin_remove_first( hashbin_t *hashbin)
-{
-	unsigned long flags;
-	irda_queue_t *entry = NULL;
+	entry = hashbin_get_first( hashbin);
+	if ( entry != NULL) {
+		int	bin;
+		long	hashv;
+		/*
+		 * Locate hashbin
+		 */
+		hashv = entry->q_hash;
+		bin = GET_HASHBIN( hashv );
 
-	save_flags(flags);
-	cli();
+		/*
+		 * Dequeue the entry...
+		 */
+		dequeue_general( (irda_queue_t**) &hashbin->hb_queue[ bin ],
+				 (irda_queue_t*) entry );
+		hashbin->hb_size--;
+		entry->q_next = NULL;
+		entry->q_prev = NULL;
 
-	entry = hashbin_get_first( hashbin);
-	if ( entry != NULL)
-		hashbin_remove( hashbin, entry->q_hash, NULL);
+		/*
+		 *  Check if this item is the currently selected item, and in
+		 *  that case we must reset hb_current
+		 */
+		if ( entry == hashbin->hb_current)
+			hashbin->hb_current = NULL;
+	}
 
-	restore_flags( flags);
+	/* Release lock */
+	if ( hashbin->hb_type & HB_LOCK ) {
+		spin_unlock_irqrestore(&hashbin->hb_spinlock, flags);
+	} /* Default is no-lock  */
 
 	return entry;
 }
@@ -343,12 +702,8 @@ void* hashbin_remove( hashbin_t* hashbin
 	bin = GET_HASHBIN( hashv );
 
 	/* Synchronize */
-	if ( hashbin->hb_type & HB_GLOBAL ) {
-		spin_lock_irqsave( &hashbin->hb_mutex[ bin ], flags);
-
-	} else if ( hashbin->hb_type & HB_LOCAL ) {
-		save_flags(flags);
-		cli();
+	if ( hashbin->hb_type & HB_LOCK ) {
+		spin_lock_irqsave(&hashbin->hb_spinlock, flags);
 	} /* Default is no-lock  */
 
 	/*
@@ -396,12 +751,9 @@ void* hashbin_remove( hashbin_t* hashbin
 	}
 
 	/* Release lock */
-	if ( hashbin->hb_type & HB_GLOBAL) {
-		spin_unlock_irqrestore( &hashbin->hb_mutex[ bin], flags);
-
-	} else if ( hashbin->hb_type & HB_LOCAL) {
-		restore_flags( flags);
-	}
+	if ( hashbin->hb_type & HB_LOCK ) {
+		spin_unlock_irqrestore(&hashbin->hb_spinlock, flags);
+	} /* Default is no-lock  */
        
 	
 	/* Return */
@@ -413,7 +765,7 @@ void* hashbin_remove( hashbin_t* hashbin
 }
 
 /* 
- *  Function hashbin_remove (hashbin, hashv, name)
+ *  Function hashbin_remove_this (hashbin, entry)
  *
  *    Remove entry with the given name
  *
@@ -435,6 +787,11 @@ void* hashbin_remove_this( hashbin_t* ha
 	ASSERT( hashbin->magic == HB_MAGIC, return NULL;);
 	ASSERT( entry != NULL, return NULL;);
 	
+	/* Synchronize */
+	if ( hashbin->hb_type & HB_LOCK ) {
+		spin_lock_irqsave(&hashbin->hb_spinlock, flags);
+	} /* Default is no-lock  */
+
 	/* Check if valid and not already removed... */
 	if((entry->q_next == NULL) || (entry->q_prev == NULL))
 		return NULL;
@@ -445,15 +802,6 @@ void* hashbin_remove_this( hashbin_t* ha
 	hashv = entry->q_hash;
 	bin = GET_HASHBIN( hashv );
 
-	/* Synchronize */
-	if ( hashbin->hb_type & HB_GLOBAL ) {
-		spin_lock_irqsave( &hashbin->hb_mutex[ bin ], flags);
-
-	} else if ( hashbin->hb_type & HB_LOCAL ) {
-		save_flags(flags);
-		cli();
-	} /* Default is no-lock  */
-
 	/*
 	 * Dequeue the entry...
 	 */
@@ -471,13 +819,132 @@ void* hashbin_remove_this( hashbin_t* ha
 		hashbin->hb_current = NULL;
 
 	/* Release lock */
-	if ( hashbin->hb_type & HB_GLOBAL) {
-		spin_unlock_irqrestore( &hashbin->hb_mutex[ bin], flags);
+	if ( hashbin->hb_type & HB_LOCK ) {
+		spin_unlock_irqrestore(&hashbin->hb_spinlock, flags);
+	} /* Default is no-lock  */
 
-	} else if ( hashbin->hb_type & HB_LOCAL) {
-		restore_flags( flags);
+	return entry;
+}
+
+/*********************** HASHBIN ENUMERATION ***********************/
+
+/*
+ * Function hashbin_common_find (hashbin, hashv, name)
+ *
+ *    Find item with the given hashv or name
+ *
+ */
+void* hashbin_find( hashbin_t* hashbin, long hashv, char* name )
+{
+	int bin;
+	irda_queue_t* entry;
+
+	IRDA_DEBUG( 4, "hashbin_find()\n");
+
+	ASSERT( hashbin != NULL, return NULL;);
+	ASSERT( hashbin->magic == HB_MAGIC, return NULL;);
+
+	/*
+	 * Locate hashbin
+	 */
+	if ( name )
+		hashv = hash( name );
+	bin = GET_HASHBIN( hashv );
+	
+	/*
+	 * Search for entry
+	 */
+	entry = hashbin->hb_queue[ bin];
+	if ( entry ) {
+		do {
+			/*
+			 * Check for key
+			 */
+			if ( entry->q_hash == hashv ) {
+				/*
+				 * Name compare too?
+				 */
+				if ( name ) {
+					if ( strcmp( entry->q_name, name ) == 0 ) {
+						return entry;
+					}
+				} else {
+					return entry;
+				}
+			}
+			entry = entry->q_next;
+		} while ( entry != hashbin->hb_queue[ bin ] );
 	}
 
+	return NULL;
+}
+
+/*
+ * Function hashbin_lock_find (hashbin, hashv, name)
+ *
+ *    Find item with the given hashv or name
+ *
+ * Same, but with spinlock protection...
+ * I call it safe, but it's only safe with respect to the hashbin, not its
+ * content. - Jean II
+ */
+void* hashbin_lock_find( hashbin_t* hashbin, long hashv, char* name )
+{
+	unsigned long flags = 0;
+	irda_queue_t* entry;
+
+	/* Synchronize */
+	spin_lock_irqsave(&hashbin->hb_spinlock, flags);
+
+	/*
+	 * Search for entry
+	 */
+	entry = (irda_queue_t* ) hashbin_find( hashbin, hashv, name );
+
+	/* Release lock */
+	spin_unlock_irqrestore(&hashbin->hb_spinlock, flags);
+
+	return entry;
+}
+
+/*
+ * Function hashbin_find (hashbin, hashv, name, pnext)
+ *
+ *    Find an item with the given hashv or name, and its successor
+ *
+ * This function allow to do concurent enumerations without the
+ * need to lock over the whole session, because the caller keep the
+ * context of the search. On the other hand, it might fail and return
+ * NULL if the entry is removed. - Jean II
+ */
+void* hashbin_find_next( hashbin_t* hashbin, long hashv, char* name,
+			 void ** pnext)
+{
+	unsigned long flags = 0;
+	irda_queue_t* entry;
+
+	/* Synchronize */
+	spin_lock_irqsave(&hashbin->hb_spinlock, flags);
+
+	/*
+	 * Search for current entry
+	 * This allow to check if the current item is still in the
+	 * hashbin or has been removed.
+	 */
+	entry = (irda_queue_t* ) hashbin_find( hashbin, hashv, name );
+
+	/*
+	 * Trick hashbin_get_next() to return what we want
+	 */
+	if(entry) {
+		hashbin->hb_current = entry;
+		*pnext = hashbin_get_next( hashbin );
+	} else
+		*pnext = NULL;
+
+	/* Release lock */
+	spin_unlock_irqrestore(&hashbin->hb_spinlock, flags);
+
 	return entry;
 }
 
@@ -519,6 +986,8 @@ irda_queue_t *hashbin_get_first( hashbin
  *    be started by a call to hashbin_get_first(). The function returns
  *    NULL when all items have been traversed
  * 
+ * The context of the search is stored within the hashbin, so you must
+ * protect yourself from concurent enumerations. - Jean II
  */
 irda_queue_t *hashbin_get_next( hashbin_t *hashbin)
 {
@@ -565,241 +1034,4 @@ irda_queue_t *hashbin_get_next( hashbin_
 		}
 	}
 	return NULL;
-}
-
-/*
- * Function enqueue_last (queue, proc)
- *
- *    Insert item into end of queue.
- *
- */
-static void __enqueue_last( irda_queue_t **queue, irda_queue_t* element)
-{
-	IRDA_DEBUG( 4, __FUNCTION__ "()\n");
-
-	/*
-	 * Check if queue is empty.
-	 */
-	if ( *queue == NULL ) {
-		/*
-		 * Queue is empty.  Insert one element into the queue.
-		 */
-		element->q_next = element->q_prev = *queue = element;
-		
-	} else {
-		/*
-		 * Queue is not empty.  Insert element into end of queue.
-		 */
-		element->q_prev         = (*queue)->q_prev;
-		element->q_prev->q_next = element;
-		(*queue)->q_prev        = element;
-		element->q_next         = *queue;
-	}	
-}
-
-inline void enqueue_last( irda_queue_t **queue, irda_queue_t* element)
-{
-	unsigned long flags;
-	
-        save_flags(flags);
-        cli();
-
-        __enqueue_last( queue, element);
-
-        restore_flags(flags);
-}
-
-/*
- * Function enqueue_first (queue, proc)
- *
- *    Insert item first in queue.
- *
- */
-void enqueue_first(irda_queue_t **queue, irda_queue_t* element)
-{
-	
-	IRDA_DEBUG( 4, __FUNCTION__ "()\n");
-
-	/*
-	 * Check if queue is empty.
-	 */
-	if ( *queue == NULL ) {
-		/*
-		 * Queue is empty.  Insert one element into the queue.
-		 */
-		element->q_next = element->q_prev = *queue = element;
-		
-	} else {
-		/*
-		 * Queue is not empty.  Insert element into front of queue.
-		 */
-		element->q_next          = (*queue);
-		(*queue)->q_prev->q_next = element;
-		element->q_prev          = (*queue)->q_prev;
-		(*queue)->q_prev         = element;
-		(*queue)                 = element;
-	}
-}
-
-/*
- * Function enqueue_queue (queue, list)
- *
- *    Insert a queue (list) into the start of the first queue
- *
- */
-void enqueue_queue( irda_queue_t** queue, irda_queue_t** list )
-{
-	irda_queue_t* tmp;
-	
-	/*
-	 * Check if queue is empty
-	 */ 
-	if ( *queue ) {
-		(*list)->q_prev->q_next  = (*queue);
-		(*queue)->q_prev->q_next = (*list); 
-		tmp                      = (*list)->q_prev;
-		(*list)->q_prev          = (*queue)->q_prev;
-		(*queue)->q_prev         = tmp;
-	} else {
-		*queue                   = (*list); 
-	}
-	
-	(*list) = NULL;
-}
-
-/*
- * Function enqueue_second (queue, proc)
- *
- *    Insert item behind head of queue.
- *
- */
-#if 0
-static void enqueue_second(irda_queue_t **queue, irda_queue_t* element)
-{
-	IRDA_DEBUG( 0, "enqueue_second()\n");
-
-	/*
-	 * Check if queue is empty.
-	 */
-	if ( *queue == NULL ) {
-		/*
-		 * Queue is empty.  Insert one element into the queue.
-		 */
-		element->q_next = element->q_prev = *queue = element;
-		
-	} else {
-		/*
-		 * Queue is not empty.  Insert element into ..
-		 */
-		element->q_prev = (*queue);
-		(*queue)->q_next->q_prev = element;
-		element->q_next = (*queue)->q_next;
-		(*queue)->q_next = element;
-	}
-}
-#endif
-
-/*
- * Function dequeue (queue)
- *
- *    Remove first entry in queue
- *
- */
-irda_queue_t *dequeue_first(irda_queue_t **queue)
-{
-	irda_queue_t *ret;
-
-	IRDA_DEBUG( 4, "dequeue_first()\n");
-	
-	/*
-	 * Set return value
-	 */
-	ret =  *queue;
-	
-	if ( *queue == NULL ) {
-		/*
-		 * Queue was empty.
-		 */
-	} else if ( (*queue)->q_next == *queue ) {
-		/* 
-		 *  Queue only contained a single element. It will now be
-		 *  empty.  
-		 */
-		*queue = NULL;
-	} else {
-		/*
-		 * Queue contained several element.  Remove the first one.
-		 */
-		(*queue)->q_prev->q_next = (*queue)->q_next;
-		(*queue)->q_next->q_prev = (*queue)->q_prev;
-		*queue = (*queue)->q_next;
-	}
-	
-	/*
-	 * Return the removed entry (or NULL of queue was empty).
-	 */
-	return ret;
-}
-
-/*
- * Function dequeue_general (queue, element)
- *
- *
- */
-static irda_queue_t *dequeue_general(irda_queue_t **queue, irda_queue_t* element)
-{
-	irda_queue_t *ret;
-	
-	IRDA_DEBUG( 4, "dequeue_general()\n");
-	
-	/*
-	 * Set return value
-	 */
-	ret =  *queue;
-		
-	if ( *queue == NULL ) {
-		/*
-		 * Queue was empty.
-		 */
-	} else if ( (*queue)->q_next == *queue ) {
-		/* 
-		 *  Queue only contained a single element. It will now be
-		 *  empty.  
-		 */
-		*queue = NULL;
-		
-	} else {
-		/*
-		 *  Remove specific element.
-		 */
-		element->q_prev->q_next = element->q_next;
-		element->q_next->q_prev = element->q_prev;
-		if ( (*queue) == element)
-			(*queue) = element->q_next;
-	}
-	
-	/*
-	 * Return the removed entry (or NULL of queue was empty).
-	 */
-	return ret;
-}
-
-/*
- * Function hash (name)
- *
- *    This function hash the input string 'name' using the ELF hash
- *    function for strings.
- */
-static __u32 hash( char* name)
-{
-	__u32 h = 0;
-	__u32 g;
-	
-	while(*name) {
-		h = (h<<4) + *name++;
-		if ((g = (h & 0xf0000000)))
-			h ^=g>>24;
-		h &=~g;
-	}
-	return h;
 }
diff -u -p -r linux/net/irda-d5/irsyms.c linux/net/irda/irsyms.c
--- linux/net/irda-d5/irsyms.c	Mon Aug 19 15:59:28 2002
+++ linux/net/irda/irsyms.c	Wed Aug 21 16:09:38 2002
@@ -132,12 +132,14 @@ EXPORT_SYMBOL(irlmp_dup);
 EXPORT_SYMBOL(lmp_reasons);
 
 /* Queue */
-EXPORT_SYMBOL(hashbin_find);
 EXPORT_SYMBOL(hashbin_new);
 EXPORT_SYMBOL(hashbin_insert);
 EXPORT_SYMBOL(hashbin_delete);
 EXPORT_SYMBOL(hashbin_remove);
 EXPORT_SYMBOL(hashbin_remove_this);
+EXPORT_SYMBOL(hashbin_find);
+EXPORT_SYMBOL(hashbin_lock_find);
+EXPORT_SYMBOL(hashbin_find_next);
 EXPORT_SYMBOL(hashbin_get_next);
 EXPORT_SYMBOL(hashbin_get_first);
 
diff -u -p -r linux/net/irda-d5/irttp.c linux/net/irda/irttp.c
--- linux/net/irda-d5/irttp.c	Mon Aug 19 15:59:28 2002
+++ linux/net/irda/irttp.c	Thu Aug 22 18:33:37 2002
@@ -91,7 +91,7 @@ int __init irttp_init(void)
 
 	irttp->magic = TTP_MAGIC;
 
-	irttp->tsaps = hashbin_new(HB_LOCAL);
+	irttp->tsaps = hashbin_new(HB_LOCK);
 	if (!irttp->tsaps) {
 		ERROR("%s: can't allocate IrTTP hashbin!\n", __FUNCTION__);
 		return -ENOMEM;
@@ -1365,30 +1365,43 @@ int irttp_connect_response(struct tsap_c
 struct tsap_cb *irttp_dup(struct tsap_cb *orig, void *instance)
 {
 	struct tsap_cb *new;
+	unsigned long flags;
 
 	IRDA_DEBUG(1, __FUNCTION__ "()\n");
 
-	if (!hashbin_find(irttp->tsaps, (long) orig, NULL)) {
+	/* Protect our access to the old tsap instance */
+	spin_lock_irqsave(&irttp->tsaps->hb_spinlock, flags);
+
+	/* Find the old instance */
+	if (!hashbin_find(irttp->tsaps, (int) orig, NULL)) {
 		IRDA_DEBUG(0, __FUNCTION__ "(), unable to find TSAP\n");
+		spin_unlock_irqrestore(&irttp->tsaps->hb_spinlock, flags);
 		return NULL;
 	}
+
+	/* Allocate a new instance */
 	new = kmalloc(sizeof(struct tsap_cb), GFP_ATOMIC);
 	if (!new) {
 		IRDA_DEBUG(0, __FUNCTION__ "(), unable to kmalloc\n");
+		spin_unlock_irqrestore(&irttp->tsaps->hb_spinlock, flags);
 		return NULL;
 	}
 	/* Dup */
 	memcpy(new, orig, sizeof(struct tsap_cb));
-	new->notify.instance = instance;
-	new->lsap = irlmp_dup(orig->lsap, new);
+
+	/* We don't need the old instance any more */
+	spin_unlock_irqrestore(&irttp->tsaps->hb_spinlock, flags);
 
 	/* Not everything should be copied */
+	new->notify.instance = instance;
+	new->lsap = irlmp_dup(orig->lsap, new);
 	init_timer(&new->todo_timer);
 
 	skb_queue_head_init(&new->rx_queue);
 	skb_queue_head_init(&new->tx_queue);
 	skb_queue_head_init(&new->rx_fragments);
 
+	/* This is locked */
 	hashbin_insert(irttp->tsaps, (irda_queue_t *) new, (long) new, NULL);
 
 	return new;
@@ -1723,8 +1736,8 @@ int irttp_proc_read(char *buf, char **st
 
 	len = 0;
 
-	save_flags(flags);
-	cli();
+	/* Protect our access to the tsap list */
+	spin_lock_irqsave(&irttp->tsaps->hb_spinlock, flags);
 
 	self = (struct tsap_cb *) hashbin_get_first(irttp->tsaps);
 	while (self != NULL) {
@@ -1770,7 +1783,7 @@ int irttp_proc_read(char *buf, char **st
 
 		self = (struct tsap_cb *) hashbin_get_next(irttp->tsaps);
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&irttp->tsaps->hb_spinlock, flags);
 
 	return len;
 }
