Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132504AbQKKVH0>; Sat, 11 Nov 2000 16:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132527AbQKKVHG>; Sat, 11 Nov 2000 16:07:06 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:34569 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S132504AbQKKVGz>; Sat, 11 Nov 2000 16:06:55 -0500
Date: Sat, 11 Nov 2000 21:07:52 GMT
Message-Id: <200011112107.VAA31913@tepid.osl.fast.no>
Subject: [patch] patch-2.4.0-test10-irda9 (was: Re: The IrDA patches)
X-Mailer: Pygmy (v0.4.4pre)
Subject: [patch] patch-2.4.0-test10-irda9 (was: Re: The IrDA patches)
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

The name of this patch is irda9.diff. 

(Many thanks to Jean Tourrilhes for splitting up the big patch)

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash
[OUPS   ] : Error that will be fixed in a later patch

irda9.diff :
----------------
	o [CORRECT] Change queue_t to irda_queue_t (namespace pollution)

diff -urpN old-linux/include/net/irda/discovery.h linux/include/net/irda/discovery.h
--- old-linux/include/net/irda/discovery.h	Thu Nov  9 13:45:18 2000
+++ linux/include/net/irda/discovery.h	Thu Nov  9 14:44:44 2000
@@ -45,7 +45,7 @@
  * The DISCOVERY structure is used for both discovery requests and responses
  */
 typedef struct discovery_t {
-	queue_t q;               /* Must be first! */
+	irda_queue_t q;          /* Must be first! */
 
 	__u32      saddr;        /* Which link the device was discovered */
 	__u32      daddr;        /* Remote device address */
diff -urpN old-linux/include/net/irda/ircomm_core.h linux/include/net/irda/ircomm_core.h
--- old-linux/include/net/irda/ircomm_core.h	Tue Dec 21 10:17:31 1999
+++ linux/include/net/irda/ircomm_core.h	Thu Nov  9 14:44:44 2000
@@ -53,7 +53,7 @@ typedef struct {
 } call_t;
 
 struct ircomm_cb {
-	queue_t queue;
+	irda_queue_t queue;
 	magic_t magic;
 
 	notify_t notify;
diff -urpN old-linux/include/net/irda/ircomm_tty.h linux/include/net/irda/ircomm_tty.h
--- old-linux/include/net/irda/ircomm_tty.h	Fri Jan 28 19:36:22 2000
+++ linux/include/net/irda/ircomm_tty.h	Thu Nov  9 14:44:44 2000
@@ -48,7 +48,7 @@
  * IrCOMM TTY driver state
  */
 struct ircomm_tty_cb {
-	queue_t queue;            /* Must be first */
+	irda_queue_t queue;            /* Must be first */
 	magic_t magic;
 
 	int state;                /* Connect state */
diff -urpN old-linux/include/net/irda/irda_device.h linux/include/net/irda/irda_device.h
--- old-linux/include/net/irda/irda_device.h	Tue Oct 31 11:18:04 2000
+++ linux/include/net/irda/irda_device.h	Thu Nov  9 14:44:44 2000
@@ -79,7 +79,7 @@ struct irda_task;
 typedef int (*IRDA_TASK_CALLBACK) (struct irda_task *task);
 
 struct irda_task {
-	queue_t q;
+	irda_queue_t q;
 	magic_t magic;
 
 	IRDA_TASK_STATE state;
@@ -111,7 +111,7 @@ typedef struct {
 
 /* Dongle registration info */
 struct dongle_reg {
-	queue_t q;         /* Must be first */
+	irda_queue_t q;         /* Must be first */
 	IRDA_DONGLE type;
 
 	void (*open)(dongle_t *dongle, struct qos_info *qos);
diff -urpN old-linux/include/net/irda/iriap.h linux/include/net/irda/iriap.h
--- old-linux/include/net/irda/iriap.h	Thu Jan  6 14:46:18 2000
+++ linux/include/net/irda/iriap.h	Thu Nov  9 14:44:44 2000
@@ -58,7 +58,7 @@ typedef void (*CONFIRM_CALLBACK)(int res
 				 struct ias_value *value, void *priv);
 
 struct iriap_cb {
-	queue_t q;      /* Must be first */	
+	irda_queue_t q; /* Must be first */	
 	magic_t magic;  /* Magic cookie */
 
 	int          mode;   /* Client or server */
diff -urpN old-linux/include/net/irda/irias_object.h linux/include/net/irda/irias_object.h
--- old-linux/include/net/irda/irias_object.h	Thu Nov  9 11:49:35 2000
+++ linux/include/net/irda/irias_object.h	Thu Nov  9 14:44:44 2000
@@ -42,7 +42,7 @@
  *  LM-IAS Object
  */
 struct ias_object {
-	queue_t q;     /* Must be first! */
+	irda_queue_t q;     /* Must be first! */
 	magic_t magic;
 	
 	char  *name;
@@ -71,7 +71,7 @@ struct ias_value {
  *  Attributes used by LM-IAS objects
  */
 struct ias_attrib {
-	queue_t q; /* Must be first! */
+	irda_queue_t q; /* Must be first! */
 	int magic;
 
         char *name;   	         /* Attribute name */
diff -urpN old-linux/include/net/irda/irlan_common.h linux/include/net/irda/irlan_common.h
--- old-linux/include/net/irda/irlan_common.h	Tue Jul 11 11:12:24 2000
+++ linux/include/net/irda/irlan_common.h	Thu Nov  9 14:44:44 2000
@@ -161,7 +161,7 @@ struct irlan_provider_cb {
  *  IrLAN control block
  */
 struct irlan_cb {
-	queue_t q; /* Must be first */
+	irda_queue_t q; /* Must be first */
 
 	int    magic;
 	struct net_device dev;        /* Ethernet device structure*/
diff -urpN old-linux/include/net/irda/irlap.h linux/include/net/irda/irlap.h
--- old-linux/include/net/irda/irlap.h	Tue Oct 31 11:18:04 2000
+++ linux/include/net/irda/irlap.h	Thu Nov  9 14:44:44 2000
@@ -81,7 +81,7 @@
 #define irda_incomp      (*self->decompressor.cp->incomp)
 
 struct irda_compressor {
-	queue_t q;
+	irda_queue_t q;
 
 	struct compressor *cp;
 	void *state; /* Not used by IrDA */
@@ -90,7 +90,7 @@ struct irda_compressor {
 
 /* Main structure of IrLAP */
 struct irlap_cb {
-	queue_t q;     /* Must be first */
+	irda_queue_t q;     /* Must be first */
 	magic_t magic;
 
 	struct net_device  *netdev;
diff -urpN old-linux/include/net/irda/irlmp.h linux/include/net/irda/irlmp.h
--- old-linux/include/net/irda/irlmp.h	Thu Nov  9 13:45:18 2000
+++ linux/include/net/irda/irlmp.h	Thu Nov  9 14:44:44 2000
@@ -75,13 +75,13 @@ typedef void (*DISCOVERY_CALLBACK1) (dis
 typedef void (*DISCOVERY_CALLBACK2) (hashbin_t *, void *);
 
 typedef struct {
-	queue_t queue; /* Must be first */
+	irda_queue_t queue; /* Must be first */
 
 	__u16 hints; /* Hint bits */
 } irlmp_service_t;
 
 typedef struct {
-	queue_t queue; /* Must be first */
+	irda_queue_t queue; /* Must be first */
 
 	__u16 hint_mask;
 
@@ -96,7 +96,7 @@ struct lap_cb; /* Forward decl. */
  *  Information about each logical LSAP connection
  */
 struct lsap_cb {
-	queue_t queue;      /* Must be first */
+	irda_queue_t queue;      /* Must be first */
 	magic_t magic;
 
 	int  connected;
@@ -122,7 +122,7 @@ struct lsap_cb {
  *  Information about each registred IrLAP layer
  */
 struct lap_cb {
-	queue_t queue; /* Must be first */
+	irda_queue_t queue; /* Must be first */
 	magic_t magic;
 
 	int reason;    /* LAP disconnect reason */
diff -urpN old-linux/include/net/irda/irmod.h linux/include/net/irda/irmod.h
--- old-linux/include/net/irda/irmod.h	Fri Jan 28 19:36:22 2000
+++ linux/include/net/irda/irmod.h	Thu Nov  9 14:44:44 2000
@@ -69,7 +69,7 @@ typedef void (*TODO_CALLBACK)( void *sel
  *  addtional information
  */
 struct irda_event {
-	queue_t q; /* Must be first */
+	irda_queue_t q; /* Must be first */
 	
 	struct irmanager_event event;
 };
@@ -78,7 +78,7 @@ struct irda_event {
  *  Funtions with needs to be called with a process context
  */
 struct irda_todo {
-	queue_t q; /* Must be first */
+	irda_queue_t q; /* Must be first */
 
 	void *self;
 	TODO_CALLBACK callback;
@@ -94,8 +94,8 @@ struct irda_cb {
 
 	int in_use;
 
-	queue_t *event_queue; /* Events queued for the irmanager */
-	queue_t *todo_queue;  /* Todo list */
+	irda_queue_t *event_queue; /* Events queued for the irmanager */
+	irda_queue_t *todo_queue;  /* Todo list */
 };
 
 int irmod_init_module(void);
diff -urpN old-linux/include/net/irda/irqueue.h linux/include/net/irda/irqueue.h
--- old-linux/include/net/irda/irqueue.h	Tue Oct 31 11:18:17 2000
+++ linux/include/net/irda/irqueue.h	Thu Nov  9 14:44:44 2000
@@ -30,8 +30,8 @@
 #include <linux/types.h>
 #include <linux/spinlock.h>
 
-#ifndef QUEUE_H
-#define QUEUE_H
+#ifndef IRDA_QUEUE_H
+#define IRDA_QUEUE_H
 
 #define NAME_SIZE      32
 
@@ -62,39 +62,39 @@ typedef void (*FREE_FUNC)(void *arg);
  */
 #define GET_HASHBIN(x) ( x & HASHBIN_MASK )
 
-struct irqueue {
-	struct irqueue *q_next;
-	struct irqueue *q_prev;
+struct irda_queue {
+	struct irda_queue *q_next;
+	struct irda_queue *q_prev;
 
 	char   q_name[NAME_SIZE];
 	__u32  q_hash;
 };
-typedef struct irqueue queue_t;
+typedef struct irda_queue irda_queue_t;
 
 typedef struct hashbin_t {
 	__u32      magic;
 	int        hb_type;
 	int        hb_size;
 	spinlock_t hb_mutex[HASHBIN_SIZE] ALIGN;
-	queue_t   *hb_queue[HASHBIN_SIZE] ALIGN;
+	irda_queue_t   *hb_queue[HASHBIN_SIZE] ALIGN;
 
-	queue_t* hb_current;
+	irda_queue_t* hb_current;
 } hashbin_t;
 
 hashbin_t *hashbin_new(int type);
 int      hashbin_delete(hashbin_t* hashbin, FREE_FUNC func);
 int      hashbin_clear(hashbin_t* hashbin, FREE_FUNC free_func);
-void     hashbin_insert(hashbin_t* hashbin, queue_t* entry, __u32 hashv, 
+void     hashbin_insert(hashbin_t* hashbin, irda_queue_t* entry, __u32 hashv, 
 			char* name);
 void*    hashbin_find(hashbin_t* hashbin, __u32 hashv, char* name);
 void*    hashbin_remove(hashbin_t* hashbin, __u32 hashv, char* name);
 void*    hashbin_remove_first(hashbin_t *hashbin);
-queue_t *hashbin_get_first(hashbin_t *hashbin);
-queue_t *hashbin_get_next(hashbin_t *hashbin);
+irda_queue_t *hashbin_get_first(hashbin_t *hashbin);
+irda_queue_t *hashbin_get_next(hashbin_t *hashbin);
 
-void enqueue_last(queue_t **queue, queue_t* element);
-void enqueue_first(queue_t **queue, queue_t* element);
-queue_t *dequeue_first(queue_t **queue);
+void enqueue_last(irda_queue_t **queue, irda_queue_t* element);
+void enqueue_first(irda_queue_t **queue, irda_queue_t* element);
+irda_queue_t *dequeue_first(irda_queue_t **queue);
 
 #define HASHBIN_GET_SIZE(hashbin) hashbin->hb_size
 
diff -urpN old-linux/include/net/irda/irttp.h linux/include/net/irda/irttp.h
--- old-linux/include/net/irda/irttp.h	Tue Dec 21 10:17:31 1999
+++ linux/include/net/irda/irttp.h	Thu Nov  9 14:44:44 2000
@@ -63,7 +63,7 @@
  *  connection.
  */
 struct tsap_cb {
-	queue_t q;            /* Must be first */
+	irda_queue_t q;            /* Must be first */
 	magic_t magic;        /* Just in case */
 
 	__u8 stsap_sel;       /* Source TSAP */
diff -urpN old-linux/include/net/irda/irtty.h linux/include/net/irda/irtty.h
--- old-linux/include/net/irda/irtty.h	Fri Jan 28 19:36:22 2000
+++ linux/include/net/irda/irtty.h	Thu Nov  9 14:44:44 2000
@@ -45,7 +45,7 @@ struct irtty_info {
 #define IRTTY_IOC_MAXNR   2
 
 struct irtty_cb {
-	queue_t q;     /* Must be first */
+	irda_queue_t q;     /* Must be first */
 	magic_t magic;
 
 	struct net_device *netdev; /* Yes! we are some kind of netdevice */
diff -urpN old-linux/drivers/net/irda/irtty.c linux/drivers/net/irda/irtty.c
--- old-linux/drivers/net/irda/irtty.c	Thu Nov  9 13:48:34 2000
+++ linux/drivers/net/irda/irtty.c	Thu Nov  9 14:44:44 2000
@@ -176,7 +176,7 @@ static int irtty_open(struct tty_struct 
 		MINOR(tty->device) - tty->driver.minor_start +
 		tty->driver.name_base);
 
-	hashbin_insert(irtty, (queue_t *) self, (int) self, NULL);
+	hashbin_insert(irtty, (irda_queue_t *) self, (int) self, NULL);
 
 	if (tty->driver.flush_buffer)
 		tty->driver.flush_buffer(tty);
diff -urpN old-linux/net/irda/discovery.c linux/net/irda/discovery.c
--- old-linux/net/irda/discovery.c	Thu Nov  9 13:45:18 2000
+++ linux/net/irda/discovery.c	Thu Nov  9 14:44:44 2000
@@ -92,7 +92,7 @@ void irlmp_add_discovery(hashbin_t *cach
 	}
 
 	/* Insert the new and updated version */
-	hashbin_insert(cachelog, (queue_t *) new, new->daddr, NULL);
+	hashbin_insert(cachelog, (irda_queue_t *) new, new->daddr, NULL);
 
 	spin_unlock_irqrestore(&irlmp->log_lock, flags);
 }
diff -urpN old-linux/net/irda/ircomm/ircomm_core.c linux/net/irda/ircomm/ircomm_core.c
--- old-linux/net/irda/ircomm/ircomm_core.c	Thu Jan  6 14:46:18 2000
+++ linux/net/irda/ircomm/ircomm_core.c	Thu Nov  9 14:44:44 2000
@@ -127,7 +127,7 @@ struct ircomm_cb *ircomm_open(notify_t *
 	self->service_type = service_type;
 	self->line = line;
 
-	hashbin_insert(ircomm, (queue_t *) self, line, NULL);
+	hashbin_insert(ircomm, (irda_queue_t *) self, line, NULL);
 
 	ircomm_next_state(self, IRCOMM_IDLE);	
 
diff -urpN old-linux/net/irda/ircomm/ircomm_tty.c linux/net/irda/ircomm/ircomm_tty.c
--- old-linux/net/irda/ircomm/ircomm_tty.c	Fri Apr 21 15:17:57 2000
+++ linux/net/irda/ircomm/ircomm_tty.c	Thu Nov  9 14:44:44 2000
@@ -429,7 +429,7 @@ static int ircomm_tty_open(struct tty_st
 		tty->termios->c_oflag = 0;
 
 		/* Insert into hash */
-		hashbin_insert(ircomm_tty, (queue_t *) self, line, NULL);
+		hashbin_insert(ircomm_tty, (irda_queue_t *) self, line, NULL);
 	}
 	self->open_count++;
 
diff -urpN old-linux/net/irda/irda_device.c linux/net/irda/irda_device.c
--- old-linux/net/irda/irda_device.c	Tue Mar 21 11:17:28 2000
+++ linux/net/irda/irda_device.c	Thu Nov  9 14:44:44 2000
@@ -379,7 +379,7 @@ struct irda_task *irda_task_execute(void
 	init_timer(&task->timer);
 
 	/* Register task */
-	hashbin_insert(tasks, (queue_t *) task, (int) task, NULL);
+	hashbin_insert(tasks, (irda_queue_t *) task, (int) task, NULL);
 
 	/* No time to waste, so lets get going! */
 	ret = irda_task_kick(task);
@@ -518,7 +518,7 @@ int irda_device_register_dongle(struct d
         }
 	
 	/* Insert IrDA dongle into hashbin */
-	hashbin_insert(dongles, (queue_t *) new, new->type, NULL);
+	hashbin_insert(dongles, (irda_queue_t *) new, new->type, NULL);
 	
         return 0;
 }
diff -urpN old-linux/net/irda/iriap.c linux/net/irda/iriap.c
--- old-linux/net/irda/iriap.c	Thu Nov  9 11:49:35 2000
+++ linux/net/irda/iriap.c	Thu Nov  9 14:44:44 2000
@@ -180,7 +180,7 @@ struct iriap_cb *iriap_open(__u8 slsap_s
 
 	init_timer(&self->watchdog_timer);
 
-	hashbin_insert(iriap, (queue_t *) self, (int) self, NULL);
+	hashbin_insert(iriap, (irda_queue_t *) self, (int) self, NULL);
 	
 	/* Initialize state machines */
 	iriap_next_client_state(self, S_DISCONNECT);
diff -urpN old-linux/net/irda/irias_object.c linux/net/irda/irias_object.c
--- old-linux/net/irda/irias_object.c	Thu Nov  9 11:49:35 2000
+++ linux/net/irda/irias_object.c	Thu Nov  9 14:44:44 2000
@@ -189,7 +189,7 @@ void irias_insert_object(struct ias_obje
 	ASSERT(obj != NULL, return;);
 	ASSERT(obj->magic == IAS_OBJECT_MAGIC, return;);
 	
-	hashbin_insert(objects, (queue_t *) obj, 0, obj->name);
+	hashbin_insert(objects, (irda_queue_t *) obj, 0, obj->name);
 }
 
 /*
@@ -244,7 +244,7 @@ void irias_add_attrib( struct ias_object
 	/* Set if attrib is owned by kernel or user space */
 	attrib->value->owner = owner;
 
-	hashbin_insert(obj->attribs, (queue_t *) attrib, 0, attrib->name);
+	hashbin_insert(obj->attribs, (irda_queue_t *) attrib, 0, attrib->name);
 }
 
 /*
diff -urpN old-linux/net/irda/irlan/irlan_common.c linux/net/irda/irlan/irlan_common.c
--- old-linux/net/irda/irlan/irlan_common.c	Thu Nov  9 13:27:10 2000
+++ linux/net/irda/irlan/irlan_common.c	Thu Nov  9 14:44:44 2000
@@ -293,7 +293,7 @@ struct irlan_cb *irlan_open(__u32 saddr,
 	init_timer(&self->watchdog_timer);
 	init_timer(&self->client.kick_timer);
 
-	hashbin_insert(irlan, (queue_t *) self, daddr, NULL);
+	hashbin_insert(irlan, (irda_queue_t *) self, daddr, NULL);
 	
 	skb_queue_head_init(&self->client.txq);
 	
diff -urpN old-linux/net/irda/irlap.c linux/net/irda/irlap.c
--- old-linux/net/irda/irlap.c	Thu Jan  6 14:46:18 2000
+++ linux/net/irda/irlap.c	Thu Nov  9 14:44:44 2000
@@ -154,7 +154,7 @@ struct irlap_cb *irlap_open(struct net_d
 	
 	irlap_next_state(self, LAP_NDM);
 
-	hashbin_insert(irlap, (queue_t *) self, self->saddr, NULL);
+	hashbin_insert(irlap, (irda_queue_t *) self, self->saddr, NULL);
 
 	irlmp_register_link(self, self->saddr, &self->notify);
 	
diff -urpN old-linux/net/irda/irlap_comp.c linux/net/irda/irlap_comp.c
--- old-linux/net/irda/irlap_comp.c	Mon Oct 25 20:49:42 1999
+++ linux/net/irda/irlap_comp.c	Thu Nov  9 14:44:44 2000
@@ -63,7 +63,7 @@ int irda_register_compressor( struct com
         new->cp = cp;
 
 	/* Insert IrDA compressor into hashbin */
-	hashbin_insert( irlap_compressors, (queue_t *) new, cp->compress_proto,
+	hashbin_insert( irlap_compressors, (irda_queue_t *) new, cp->compress_proto,
 			NULL);
 	
         return 0;
diff -urpN old-linux/net/irda/irlap_event.c linux/net/irda/irlap_event.c
--- old-linux/net/irda/irlap_event.c	Thu Jan  6 14:46:18 2000
+++ linux/net/irda/irlap_event.c	Thu Nov  9 14:44:44 2000
@@ -496,7 +496,7 @@ static int irlap_state_query(struct irla
 			break;
 		}
 		hashbin_insert(self->discovery_log, 
-			       (queue_t *) info->discovery,
+			       (irda_queue_t *) info->discovery,
 			       info->discovery->daddr, NULL);
 
 		/* Keep state */
diff -urpN old-linux/net/irda/irlmp.c linux/net/irda/irlmp.c
--- old-linux/net/irda/irlmp.c	Thu Nov  9 13:45:18 2000
+++ linux/net/irda/irlmp.c	Thu Nov  9 14:44:44 2000
@@ -178,7 +178,7 @@ struct lsap_cb *irlmp_open_lsap(__u8 sls
 	irlmp_next_lsap_state(self, LSAP_DISCONNECTED);
 	
 	/* Insert into queue of unconnected LSAPs */
-	hashbin_insert(irlmp->unconnected_lsaps, (queue_t *) self, (int) self, 
+	hashbin_insert(irlmp->unconnected_lsaps, (irda_queue_t *) self, (int) self, 
 		       NULL);
 	
 	return self;
@@ -286,7 +286,7 @@ void irlmp_register_link(struct irlap_cb
 	/*
 	 *  Insert into queue of unconnected LSAPs
 	 */
-	hashbin_insert(irlmp->links, (queue_t *) lap, lap->saddr, NULL);
+	hashbin_insert(irlmp->links, (irda_queue_t *) lap, lap->saddr, NULL);
 
 	/* 
 	 *  We set only this variable so IrLAP can tell us on which link the
@@ -431,7 +431,7 @@ int irlmp_connect_request(struct lsap_cb
 	ASSERT(lsap->lap != NULL, return -1;);
 	ASSERT(lsap->lap->magic == LMP_LAP_MAGIC, return -1;);
 
-	hashbin_insert(self->lap->lsaps, (queue_t *) self, (int) self, NULL);
+	hashbin_insert(self->lap->lsaps, (irda_queue_t *) self, (int) self, NULL);
 
 	self->connected = TRUE;
 	
@@ -573,7 +573,7 @@ struct lsap_cb *irlmp_dup(struct lsap_cb
 	
 	init_timer(&new->watchdog_timer);
 	
-	hashbin_insert(irlmp->unconnected_lsaps, (queue_t *) new, (int) new, 
+	hashbin_insert(irlmp->unconnected_lsaps, (irda_queue_t *) new, (int) new, 
 		       NULL);
 
 	/* Make sure that we invalidate the cache */
@@ -628,7 +628,7 @@ int irlmp_disconnect_request(struct lsap
 	ASSERT(lsap->magic == LMP_LSAP_MAGIC, return -1;);
 	ASSERT(lsap == self, return -1;);
 
-	hashbin_insert(irlmp->unconnected_lsaps, (queue_t *) self, (int) self, 
+	hashbin_insert(irlmp->unconnected_lsaps, (irda_queue_t *) self, (int) self, 
 		       NULL);
 	
 	/* Reset some values */
@@ -674,7 +674,7 @@ void irlmp_disconnect_indication(struct 
 
 	ASSERT(lsap != NULL, return;);
 	ASSERT(lsap == self, return;);
-	hashbin_insert(irlmp->unconnected_lsaps, (queue_t *) lsap, (int) lsap, 
+	hashbin_insert(irlmp->unconnected_lsaps, (irda_queue_t *) lsap, (int) lsap, 
 		       NULL);
 
 	self->lap = NULL;
@@ -1246,7 +1246,7 @@ __u32 irlmp_register_service(__u16 hints
 		return 0;
 	}
 	service->hints = hints;
-	hashbin_insert(irlmp->services, (queue_t *) service, handle, NULL);
+	hashbin_insert(irlmp->services, (irda_queue_t *) service, handle, NULL);
 
 	return handle;
 }
@@ -1322,7 +1322,7 @@ __u32 irlmp_register_client(__u16 hint_m
 	client->callback2 = callback2;
 	client->priv = priv;
 
- 	hashbin_insert(irlmp->clients, (queue_t *) client, handle, NULL);
+ 	hashbin_insert(irlmp->clients, (irda_queue_t *) client, handle, NULL);
 
 	return handle;
 }
diff -urpN old-linux/net/irda/irlmp_event.c linux/net/irda/irlmp_event.c
--- old-linux/net/irda/irlmp_event.c	Thu Nov  9 13:36:27 2000
+++ linux/net/irda/irlmp_event.c	Thu Nov  9 14:44:44 2000
@@ -523,7 +523,7 @@ static int irlmp_state_connect(struct ls
 		ASSERT(self->lap != NULL, return -1;);
 		ASSERT(self->lap->lsaps != NULL, return -1;);
 		
-		hashbin_insert(self->lap->lsaps, (queue_t *) self, (int) self, 
+		hashbin_insert(self->lap->lsaps, (irda_queue_t *) self, (int) self, 
 			       NULL);
 
 		irlmp_send_lcf_pdu(self->lap, self->dlsap_sel, 
diff -urpN old-linux/net/irda/irmod.c linux/net/irda/irmod.c
--- old-linux/net/irda/irmod.c	Thu Nov  9 13:45:18 2000
+++ linux/net/irda/irmod.c	Thu Nov  9 14:44:44 2000
@@ -347,7 +347,7 @@ void irda_execute_as_process( void *self
 	new->param = param;
 	
 	/* Queue todo */
-	enqueue_last(&irda.todo_queue, (queue_t *) new);
+	enqueue_last(&irda.todo_queue, (irda_queue_t *) new);
 
 	event.event = EVENT_NEED_PROCESS_CONTEXT;
 
@@ -382,7 +382,7 @@ void irmanager_notify( struct irmanager_
 	new->event = *event;
 	
 	/* Queue event */
-	enqueue_last(&irda.event_queue, (queue_t *) new);
+	enqueue_last(&irda.event_queue, (irda_queue_t *) new);
 	
 	/* Wake up irmanager sleeping on read */
 	wake_up_interruptible(&irda.wait_queue);
diff -urpN old-linux/net/irda/irqueue.c linux/net/irda/irqueue.c
--- old-linux/net/irda/irqueue.c	Tue Dec 21 10:17:58 1999
+++ linux/net/irda/irqueue.c	Thu Nov  9 14:44:44 2000
@@ -36,7 +36,7 @@
 #include <net/irda/irqueue.h>
 #include <net/irda/irmod.h>
 
-static queue_t *dequeue_general( queue_t **queue, queue_t* element);
+static irda_queue_t *dequeue_general( irda_queue_t **queue, irda_queue_t* element);
 static __u32 hash( char* name);
 
 /*
@@ -79,7 +79,7 @@ hashbin_t *hashbin_new(int type)
  */
 int hashbin_clear( hashbin_t* hashbin, FREE_FUNC free_func)
 {
-	queue_t* queue;
+	irda_queue_t* queue;
 	int i;
 	
 	ASSERT(hashbin != NULL, return -1;);
@@ -89,12 +89,12 @@ int hashbin_clear( hashbin_t* hashbin, F
 	 * Free the entries in the hashbin
 	 */
 	for (i = 0; i < HASHBIN_SIZE; i ++ ) {
-		queue = dequeue_first( (queue_t**) &hashbin->hb_queue[i]);
+		queue = dequeue_first( (irda_queue_t**) &hashbin->hb_queue[i]);
 		while (queue) {
 			if (free_func)
 				(*free_func)(queue);
 			queue = dequeue_first( 
-				(queue_t**) &hashbin->hb_queue[i]);
+				(irda_queue_t**) &hashbin->hb_queue[i]);
 		}
 	}
 	hashbin->hb_size = 0;
@@ -112,7 +112,7 @@ int hashbin_clear( hashbin_t* hashbin, F
  */
 int hashbin_delete( hashbin_t* hashbin, FREE_FUNC free_func)
 {
-	queue_t* queue;
+	irda_queue_t* queue;
 	int i;
 
 	ASSERT(hashbin != NULL, return -1;);
@@ -123,12 +123,12 @@ int hashbin_delete( hashbin_t* hashbin, 
 	 *  it has been shown to work
 	 */
 	for (i = 0; i < HASHBIN_SIZE; i ++ ) {
-		queue = dequeue_first((queue_t**) &hashbin->hb_queue[i]);
+		queue = dequeue_first((irda_queue_t**) &hashbin->hb_queue[i]);
 		while (queue ) {
 			if (free_func)
 				(*free_func)(queue);
 			queue = dequeue_first( 
-				(queue_t**) &hashbin->hb_queue[i]);
+				(irda_queue_t**) &hashbin->hb_queue[i]);
 		}
 	}
 	
@@ -210,7 +210,7 @@ void hashbin_unlock(hashbin_t* hashbin, 
  *    Insert an entry into the hashbin
  *
  */
-void hashbin_insert(hashbin_t* hashbin, queue_t* entry, __u32 hashv, char* name)
+void hashbin_insert(hashbin_t* hashbin, irda_queue_t* entry, __u32 hashv, char* name)
 {
 	unsigned long flags = 0;
 	int bin;
@@ -250,7 +250,7 @@ void hashbin_insert(hashbin_t* hashbin, 
 	 */
 	if ( hashbin->hb_type & HB_SORTED) {
 	} else {
-		enqueue_first( (queue_t**) &hashbin->hb_queue[ bin ],
+		enqueue_first( (irda_queue_t**) &hashbin->hb_queue[ bin ],
 			       entry);
 	}
 	hashbin->hb_size++;
@@ -275,7 +275,7 @@ void* hashbin_find( hashbin_t* hashbin, 
 {
 	int bin, found = FALSE;
 	unsigned long flags = 0;
-	queue_t* entry;
+	irda_queue_t* entry;
 
 	IRDA_DEBUG( 4, "hashbin_find()\n");
 
@@ -342,7 +342,7 @@ void* hashbin_find( hashbin_t* hashbin, 
 void *hashbin_remove_first( hashbin_t *hashbin)
 {
 	unsigned long flags;
-	queue_t *entry = NULL;
+	irda_queue_t *entry = NULL;
 
 	save_flags(flags);
 	cli();
@@ -367,7 +367,7 @@ void* hashbin_remove( hashbin_t* hashbin
 {
 	int bin, found = FALSE;
 	unsigned long flags = 0;
-	queue_t* entry;
+	irda_queue_t* entry;
 
 	IRDA_DEBUG( 4, __FUNCTION__ "()\n");
 
@@ -421,8 +421,8 @@ void* hashbin_remove( hashbin_t* hashbin
 	 * If entry was found, dequeue it
 	 */
 	if ( found ) {
-		dequeue_general( (queue_t**) &hashbin->hb_queue[ bin ],
-				 (queue_t*) entry );
+		dequeue_general( (irda_queue_t**) &hashbin->hb_queue[ bin ],
+				 (irda_queue_t*) entry );
 		hashbin->hb_size--;
 
 		/*
@@ -457,9 +457,9 @@ void* hashbin_remove( hashbin_t* hashbin
  *    called before any calls to hashbin_get_next()!
  *
  */
-queue_t *hashbin_get_first( hashbin_t* hashbin) 
+irda_queue_t *hashbin_get_first( hashbin_t* hashbin) 
 {
-	queue_t *entry;
+	irda_queue_t *entry;
 	int i;
 
 	ASSERT( hashbin != NULL, return NULL;);
@@ -489,9 +489,9 @@ queue_t *hashbin_get_first( hashbin_t* h
  *    NULL when all items have been traversed
  * 
  */
-queue_t *hashbin_get_next( hashbin_t *hashbin)
+irda_queue_t *hashbin_get_next( hashbin_t *hashbin)
 {
-	queue_t* entry;
+	irda_queue_t* entry;
 	int bin;
 	int i;
 
@@ -542,7 +542,7 @@ queue_t *hashbin_get_next( hashbin_t *ha
  *    Insert item into end of queue.
  *
  */
-static void __enqueue_last( queue_t **queue, queue_t* element)
+static void __enqueue_last( irda_queue_t **queue, irda_queue_t* element)
 {
 	IRDA_DEBUG( 4, __FUNCTION__ "()\n");
 
@@ -566,7 +566,7 @@ static void __enqueue_last( queue_t **qu
 	}	
 }
 
-inline void enqueue_last( queue_t **queue, queue_t* element)
+inline void enqueue_last( irda_queue_t **queue, irda_queue_t* element)
 {
 	unsigned long flags;
 	
@@ -584,7 +584,7 @@ inline void enqueue_last( queue_t **queu
  *    Insert item first in queue.
  *
  */
-void enqueue_first(queue_t **queue, queue_t* element)
+void enqueue_first(irda_queue_t **queue, irda_queue_t* element)
 {
 	
 	IRDA_DEBUG( 4, __FUNCTION__ "()\n");
@@ -616,9 +616,9 @@ void enqueue_first(queue_t **queue, queu
  *    Insert a queue (list) into the start of the first queue
  *
  */
-void enqueue_queue( queue_t** queue, queue_t** list )
+void enqueue_queue( irda_queue_t** queue, irda_queue_t** list )
 {
-	queue_t* tmp;
+	irda_queue_t* tmp;
 	
 	/*
 	 * Check if queue is empty
@@ -643,7 +643,7 @@ void enqueue_queue( queue_t** queue, que
  *
  */
 #if 0
-static void enqueue_second(queue_t **queue, queue_t* element)
+static void enqueue_second(irda_queue_t **queue, irda_queue_t* element)
 {
 	IRDA_DEBUG( 0, "enqueue_second()\n");
 
@@ -674,9 +674,9 @@ static void enqueue_second(queue_t **que
  *    Remove first entry in queue
  *
  */
-queue_t *dequeue_first(queue_t **queue)
+irda_queue_t *dequeue_first(irda_queue_t **queue)
 {
-	queue_t *ret;
+	irda_queue_t *ret;
 
 	IRDA_DEBUG( 4, "dequeue_first()\n");
 	
@@ -715,9 +715,9 @@ queue_t *dequeue_first(queue_t **queue)
  *
  *
  */
-static queue_t *dequeue_general(queue_t **queue, queue_t* element)
+static irda_queue_t *dequeue_general(irda_queue_t **queue, irda_queue_t* element)
 {
-	queue_t *ret;
+	irda_queue_t *ret;
 	
 	IRDA_DEBUG( 4, "dequeue_general()\n");
 	
diff -urpN old-linux/net/irda/irttp.c linux/net/irda/irttp.c
--- old-linux/net/irda/irttp.c	Tue Mar 21 11:17:28 2000
+++ linux/net/irda/irttp.c	Thu Nov  9 14:44:44 2000
@@ -185,7 +185,7 @@ struct tsap_cb *irttp_open_tsap(__u8 sts
 	self->notify = *notify;
 	self->lsap = lsap;
 
-	hashbin_insert(irttp->tsaps, (queue_t *) self, (int) self, NULL);
+	hashbin_insert(irttp->tsaps, (irda_queue_t *) self, (int) self, NULL);
 
 	if (credit > TTP_MAX_QUEUE)
 		self->initial_credit = TTP_MAX_QUEUE;
@@ -1002,7 +1002,7 @@ struct tsap_cb *irttp_dup(struct tsap_cb
 	skb_queue_head_init(&new->tx_queue);
 	skb_queue_head_init(&new->rx_fragments);
 
-	hashbin_insert(irttp->tsaps, (queue_t *) new, (int) new, NULL);
+	hashbin_insert(irttp->tsaps, (irda_queue_t *) new, (int) new, NULL);
 
 	return new;
 }


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
