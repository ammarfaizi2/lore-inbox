Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132454AbQKKUvo>; Sat, 11 Nov 2000 15:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132452AbQKKUve>; Sat, 11 Nov 2000 15:51:34 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:21257 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S132454AbQKKUvT>; Sat, 11 Nov 2000 15:51:19 -0500
Date: Sat, 11 Nov 2000 20:52:14 GMT
Message-Id: <200011112052.UAA31496@tepid.osl.fast.no>
Subject: [patch] patch-2.4.0-test10-irda3 (was: Re The IrDA patches)
X-Mailer: Pygmy (v0.4.4pre)
Subject: [patch] patch-2.4.0-test10-irda3 (was: Re The IrDA patches)
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

The name of this patch is irda3.diff. 

(Many thanks to Jean Tourrilhes for splitting up the big patch)

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash
[OUPS   ] : Error that will be fixed in a later patch

irda3.diff :
----------------
	o [CORRECT] Move query/discovery/watchdog data in per socket struct
	o [CORRECT] Identify socket in discovery callback (priv arg)
	o [CORRECT] Handle LAP waiting for timeout
	o [-OUPS  ] Remove extra printk

diff -urpN old-linux/include/net/irda/discovery.h linux/include/net/irda/discovery.h
--- old-linux/include/net/irda/discovery.h	Thu Nov  9 13:24:13 2000
+++ linux/include/net/irda/discovery.h	Thu Nov  9 13:24:28 2000
@@ -44,7 +44,7 @@
 /*
  * The DISCOVERY structure is used for both discovery requests and responses
  */
-typedef struct {
+typedef struct discovery_t {
 	queue_t q;               /* Must be first! */
 
 	__u32      saddr;        /* Which link the device was discovered */
diff -urpN old-linux/include/net/irda/irda.h linux/include/net/irda/irda.h
--- old-linux/include/net/irda/irda.h	Thu Nov  9 13:24:13 2000
+++ linux/include/net/irda/irda.h	Thu Nov  9 13:24:28 2000
@@ -110,8 +110,14 @@ if(!(expr)) { \
 
 typedef enum { FLOW_STOP, FLOW_START } LOCAL_FLOW;
 
+/* A few forward declarations (to make compiler happy) */
+struct tsap_cb;		/* in <net/irda/irttp.h> */
+struct lsap_cb;		/* in <net/irda/irlmp.h> */
+struct iriap_cb;	/* in <net/irda/iriap.h> */
+struct ias_value;	/* in <net/irda/irias_object.h> */
+struct discovery_t;	/* in <net/irda/discovery.h> */
+
 /* IrDA Socket */
-struct tsap_cb;
 struct irda_sock {
 	__u32 saddr;          /* my local address */
 	__u32 daddr;          /* peer address */
@@ -137,14 +143,18 @@ struct irda_sock {
 
 	struct ias_object *ias_obj;   /* Our service name + lsap in IAS */
 	struct iriap_cb *iriap;	      /* Used to query remote IAS */
-	struct ias_value *ias_result; /* Used by getsockopt(IRLMP_IAS_QUERY) */
+	struct ias_value *ias_result; /* Result of remote IAS query */
+
+	hashbin_t *cachelog;		/* Result of discovery query */
+	struct discovery_t *cachediscovery;	/* Result of selective discovery query */
 
 	int nslots;           /* Number of slots to use for discovery */
 
 	int errno;            /* status of the IAS query */
 
 	struct sock *sk;
-	wait_queue_head_t ias_wait;       /* Wait for LM-IAS answer */
+	wait_queue_head_t query_wait;	/* Wait for the answer to a query */
+	struct timer_list watchdog;	/* Timeout for discovery */
 
 	LOCAL_FLOW tx_flow;
 	LOCAL_FLOW rx_flow;
diff -urpN old-linux/include/net/irda/irlan_client.h linux/include/net/irda/irlan_client.h
--- old-linux/include/net/irda/irlan_client.h	Thu Nov  9 13:24:13 2000
+++ linux/include/net/irda/irlan_client.h	Thu Nov  9 13:24:28 2000
@@ -34,7 +34,7 @@
 #include <net/irda/irlan_event.h>
 
 void irlan_client_start_kick_timer(struct irlan_cb *self, int timeout);
-void irlan_client_discovery_indication(discovery_t *);
+void irlan_client_discovery_indication(discovery_t *, void *);
 void irlan_client_wakeup(struct irlan_cb *self, __u32 saddr, __u32 daddr);
 
 void irlan_client_open_ctrl_tsap( struct irlan_cb *self);
diff -urpN old-linux/include/net/irda/irlmp.h linux/include/net/irda/irlmp.h
--- old-linux/include/net/irda/irlmp.h	Thu Nov  9 13:24:13 2000
+++ linux/include/net/irda/irlmp.h	Thu Nov  9 13:24:28 2000
@@ -71,8 +71,8 @@ typedef enum {
 	S_END,
 } SERVICE;
 
-typedef void (*DISCOVERY_CALLBACK1) (discovery_t *);
-typedef void (*DISCOVERY_CALLBACK2) (hashbin_t *);
+typedef void (*DISCOVERY_CALLBACK1) (discovery_t *, void *);
+typedef void (*DISCOVERY_CALLBACK2) (hashbin_t *, void *);
 
 typedef struct {
 	queue_t queue; /* Must be first */
@@ -87,6 +87,7 @@ typedef struct {
 
 	DISCOVERY_CALLBACK1 callback1;
 	DISCOVERY_CALLBACK2 callback2;
+	void *priv;                /* Used to identify client */
 } irlmp_client_t;
 
 struct lap_cb; /* Forward decl. */
@@ -192,10 +193,10 @@ __u16 irlmp_service_to_hint(int service)
 __u32 irlmp_register_service(__u16 hints);
 int irlmp_unregister_service(__u32 handle);
 __u32 irlmp_register_client(__u16 hint_mask, DISCOVERY_CALLBACK1 callback1,
-			    DISCOVERY_CALLBACK2 callback2);
+			    DISCOVERY_CALLBACK2 callback2, void *priv);
 int irlmp_unregister_client(__u32 handle);
 int irlmp_update_client(__u32 handle, __u16 hint_mask, 
-			DISCOVERY_CALLBACK1, DISCOVERY_CALLBACK2);
+			DISCOVERY_CALLBACK1, DISCOVERY_CALLBACK2, void *priv);
 
 void irlmp_register_link(struct irlap_cb *, __u32 saddr, notify_t *);
 void irlmp_unregister_link(__u32 saddr);
diff -urpN old-linux/net/irda/af_irda.c linux/net/irda/af_irda.c
--- old-linux/net/irda/af_irda.c	Thu Nov  9 13:24:13 2000
+++ linux/net/irda/af_irda.c	Thu Nov  9 13:25:13 2000
@@ -79,12 +79,6 @@ static struct proto_ops irda_ultra_ops;
 #define ULTRA_MAX_DATA 382
 #endif /* CONFIG_IRDA_ULTRA */
 
-static hashbin_t *cachelog = NULL;
-static DECLARE_WAIT_QUEUE_HEAD(discovery_wait); /* Wait for discovery */
-static discovery_t *cachediscovery = NULL;
-static struct wait_queue *selective_discovery_wait = NULL;
-static struct timer_list discovery_watchdog;	/* to avoid blocking state */
-
 #define IRDA_MAX_HEADER (TTP_MAX_HEADER)
 
 /*
@@ -400,9 +394,7 @@ static void irda_getvalue_confirm(int re
 	
 	IRDA_DEBUG(2, __FUNCTION__ "()\n");
 
-	ASSERT(priv != NULL, return;);
 	self = (struct irda_sock *) priv;
-	
 	if (!self) {
 		WARNING(__FUNCTION__ "(), lost myself!\n");
 		return;
@@ -420,7 +412,7 @@ static void irda_getvalue_confirm(int re
 		self->errno = result;	/* We really need it later */
 
 		/* Wake up any processes waiting for result */
-		wake_up_interruptible(&self->ias_wait);
+		wake_up_interruptible(&self->query_wait);
 
 		return;
 	}
@@ -430,7 +422,7 @@ static void irda_getvalue_confirm(int re
 	self->errno = 0;
 
 	/* Wake up any processes waiting for result */
-	wake_up_interruptible(&self->ias_wait);
+	wake_up_interruptible(&self->query_wait);
 }
 
 /*
@@ -439,14 +431,22 @@ static void irda_getvalue_confirm(int re
  *    Got a discovery log from IrLMP, wake up any process waiting for answer
  *
  */
-static void irda_discovery_indication(hashbin_t *log)
+static void irda_discovery_indication(hashbin_t *log, void *priv)
 {
+	struct irda_sock *self;
+	
 	IRDA_DEBUG(2, __FUNCTION__ "()\n");
 
-	cachelog = log;
+	self = (struct irda_sock *) priv;
+	if (!self) {
+		WARNING(__FUNCTION__ "(), lost myself!\n");
+		return;
+	}
+
+	self->cachelog = log;
 
 	/* Wake up process if its waiting for device to be discovered */
-	wake_up_interruptible(&discovery_wait);
+	wake_up_interruptible(&self->query_wait);
 }
 
 /*
@@ -456,16 +456,24 @@ static void irda_discovery_indication(ha
  * bits), wake up any process waiting for answer
  *
  */
-static void irda_selective_discovery_indication(discovery_t *discovery)
+static void irda_selective_discovery_indication(discovery_t *discovery,
+						void *priv)
 {
+	struct irda_sock *self;
+	
 	IRDA_DEBUG(2, __FUNCTION__ "()\n");
 
+	self = (struct irda_sock *) priv;
+	if (!self) {
+		WARNING(__FUNCTION__ "(), lost myself!\n");
+		return;
+	}
+
 	/* Pass parameter to the caller */
-	cachediscovery = discovery;
+	self->cachediscovery = discovery;
 
 	/* Wake up process if its waiting for device to be discovered */
-	if(selective_discovery_wait != NULL)
-		wake_up_interruptible(&selective_discovery_wait);
+	wake_up_interruptible(&self->query_wait);
 }
 
 /*
@@ -484,9 +492,13 @@ static void irda_discovery_timeout(u_lon
 	self = (struct irda_sock *) priv;
 	ASSERT(self != NULL, return;);
 
+	/* Nothing for the caller */
+	self->cachelog = NULL;
+	self->cachediscovery = NULL;
+	self->errno = -ETIME;
+
 	/* Wake up process if its still waiting... */
-	if(selective_discovery_wait != NULL)
-		wake_up_interruptible(&selective_discovery_wait);
+	wake_up_interruptible(&self->query_wait);
 }
 
 /*
@@ -564,7 +576,7 @@ static int irda_open_lsap(struct irda_so
  *
  *    Try to lookup LSAP selector in remote LM-IAS
  *
- * Basically, we start a IAP query, and the go to sleep. When the query
+ * Basically, we start a IAP query, and then go to sleep. When the query
  * return, irda_getvalue_confirm will wake us up, and we can examine the
  * result of the query...
  * Note that in some case, the query fail even before we go to sleep,
@@ -592,7 +604,7 @@ static int irda_find_lsap_sel(struct ird
 				      name, "IrDA:TinyTP:LsapSel");
 	/* Wait for answer (if not already failed) */
 	if(self->iriap != NULL)
-		interruptible_sleep_on(&self->ias_wait);
+		interruptible_sleep_on(&self->query_wait);
 
 	/* Check what happened */
 	if (self->errno)
@@ -660,16 +672,16 @@ static int irda_discover_daddr_and_lsap_
 
 	/* Tell IrLMP we want to be notified */
 	irlmp_update_client(self->ckey, self->mask, NULL, 
-			    irda_discovery_indication);
+			    irda_discovery_indication, (void *) self);
 	
 	/* Do some discovery (and also return cached discovery results) */
 	irlmp_discovery_request(self->nslots);
 		
 	/* Tell IrLMP that we have been notified */
-	irlmp_update_client(self->ckey, self->mask, NULL, NULL);
+	irlmp_update_client(self->ckey, self->mask, NULL, NULL, NULL);
 
 	/* Check if the we got some results */
-	if (!cachelog)
+	if (!self->cachelog)
 		/* Wait for answer */
 		/*interruptible_sleep_on(&self->discovery_wait);*/
 		return -ENETUNREACH;	/* No nodes discovered */
@@ -679,7 +691,7 @@ static int irda_discover_daddr_and_lsap_
 	 * client only about the services that the client is
 	 * interested in...
 	 */
-	discovery = (discovery_t *) hashbin_get_first(cachelog);
+	discovery = (discovery_t *) hashbin_get_first(self->cachelog);
 	while (discovery != NULL) {
 		/* Mask out the ones we don't want */
 		if (discovery->hints.word & self->mask) {
@@ -699,6 +711,7 @@ static int irda_discover_daddr_and_lsap_
 						   "(), discovered service ''%s'' in two different devices !!!\n",
 						   name);
 					self->daddr = DEV_ADDR_ANY;
+					self->cachelog = NULL;
 					return(-ENOTUNIQ);
 				}
 				/* First time we found that one, save it ! */
@@ -713,15 +726,16 @@ static int irda_discover_daddr_and_lsap_
 				IRDA_DEBUG(0, __FUNCTION__
 					   "(), unexpected IAS query failure\n");
 				self->daddr = DEV_ADDR_ANY;
+				self->cachelog = NULL;
 				return(-EHOSTUNREACH);
 				break;
 			}
 		}
 
 		/* Next node, maybe we will be more lucky...  */
-		discovery = (discovery_t *) hashbin_get_next(cachelog);
+		discovery = (discovery_t *) hashbin_get_next(self->cachelog);
 	}
-	cachelog = NULL;
+	self->cachelog = NULL;
 
 	/* Check out what we found */
 	if(daddr == DEV_ADDR_ANY) {
@@ -1086,6 +1100,9 @@ static int irda_connect(struct socket *s
 	
 	sti();
 	
+	/* At this point, IrLMP has assigned our source address */
+	self->saddr = irttp_get_saddr(self->tsap);
+
 	return 0;
 }
 
@@ -1121,7 +1138,7 @@ static int irda_create(struct socket *so
 		return -ENOMEM;
 	memset(self, 0, sizeof(struct irda_sock));
 
-	init_waitqueue_head(&self->ias_wait);
+	init_waitqueue_head(&self->query_wait);
 
 	self->sk = sk;
 	sk->protinfo.irda = self;
@@ -1160,11 +1177,12 @@ static int irda_create(struct socket *so
 	sk->protocol = protocol;
 
 	/* Register as a client with IrLMP */
-	self->ckey = irlmp_register_client(0, NULL, NULL);
+	self->ckey = irlmp_register_client(0, NULL, NULL, NULL);
 	self->mask = 0xffff;
 	self->rx_flow = self->tx_flow = FLOW_START;
 	self->nslots = DISCOVERY_DEFAULT_SLOTS;
-	self->daddr = DEV_ADDR_ANY;
+	self->daddr = DEV_ADDR_ANY;	/* Until we get connected */
+	self->saddr = 0x0;		/* so IrLMP assign us any link */
 
 	/* Notify that we are using the irda module, so nobody removes it */
 	irda_mod_inc_use_count();
@@ -1647,6 +1665,11 @@ static int irda_shutdown(struct socket *
 		self->tsap = NULL;
 	}
 
+	/* A few cleanup so the socket look as good as new... */
+	self->rx_flow = self->tx_flow = FLOW_START;	/* needed ??? */
+	self->daddr = DEV_ADDR_ANY;	/* Until we get re-connected */
+	self->saddr = 0x0;		/* so IrLMP assign us any link */
+
         return 0;
 }
 
@@ -2028,16 +2051,16 @@ static int irda_getsockopt(struct socket
 	case IRLMP_ENUMDEVICES:
 		/* Tell IrLMP we want to be notified */
 		irlmp_update_client(self->ckey, self->mask, NULL, 
-				    irda_discovery_indication);
+				    irda_discovery_indication, self);
 		
 		/* Do some discovery (and also return cached results) */
 		irlmp_discovery_request(self->nslots);
 		
 		/* Tell IrLMP that we have been notified */
-		irlmp_update_client(self->ckey, self->mask, NULL, NULL);
+		irlmp_update_client(self->ckey, self->mask, NULL, NULL, NULL);
 
 		/* Check if the we got some results */
-		if (!cachelog)
+		if (!self->cachelog)
 			return -EAGAIN;		/* Didn't find any devices */
 
 		info = &list.dev[0];
@@ -2054,7 +2077,7 @@ static int irda_getsockopt(struct socket
 		 * client only about the services that the client is
 		 * interested in 
 		 */
-		discovery = (discovery_t *) hashbin_get_first(cachelog);
+		discovery = (discovery_t *) hashbin_get_first(self->cachelog);
 		while (discovery != NULL) {
 			/* Mask out the ones we don't want */
 			if (discovery->hints.word & self->mask) {
@@ -2077,9 +2100,9 @@ static int irda_getsockopt(struct socket
 				list.len++;
 				total += sizeof(struct irda_device_info);
 			}
-			discovery = (discovery_t *) hashbin_get_next(cachelog);
+			discovery = (discovery_t *) hashbin_get_next(self->cachelog);
 		}
-		cachelog = NULL;
+		self->cachelog = NULL;
 
 		/* Write total number of bytes used back to client */
 		if (put_user(total, optlen))
@@ -2188,7 +2211,7 @@ static int irda_getsockopt(struct socket
 					      ias_opt.irda_attrib_name);
 		/* Wait for answer (if not already failed) */
 		if(self->iriap != NULL)
-			interruptible_sleep_on(&self->ias_wait);
+			interruptible_sleep_on(&self->query_wait);
 		/* Check what happened */
 		if (self->errno)
 		{
@@ -2230,43 +2253,32 @@ static int irda_getsockopt(struct socket
 		/* Get timeout in ms (max time we block the caller) */
 		if (get_user(val, (int *)optval))
 			return -EFAULT;
-printk(KERN_DEBUG "val = %d\n", val);
-
-		/* Note : IRLMP is able to handle multiple client waiting
-		 * for discovery. Unfortunately, all the sockets use the same
-		 * notification function, making it impossible to have more
-		 * than one socket waiting for discovery */
-		/* Prevent re-entrancy */
-		if(selective_discovery_wait != NULL) {
-			IRDA_DEBUG(1, __FUNCTION__ 
-				   "(), already busy.\n");
-			return -EAGAIN;		/* Already busy */
-		}
 
 		/* Tell IrLMP we want to be notified */
 		irlmp_update_client(self->ckey, self->mask,
-				    irda_selective_discovery_indication, NULL);
+				    irda_selective_discovery_indication, NULL,
+				    (void *) self);
 		
 		/* Do some discovery (and also return cached results) */
 		irlmp_discovery_request(self->nslots);
 		
 		/* Wait until a node is discovered */
-		if (!cachediscovery) {
+		if (!self->cachediscovery) {
 			IRDA_DEBUG(1, __FUNCTION__ 
 				   "(), nothing discovered yet, going to sleep...\n");
 
 			/* Set watchdog timer to expire in <val> ms. */
-			discovery_watchdog.function = irda_discovery_timeout;
-			discovery_watchdog.data = (unsigned long) self;
-			discovery_watchdog.expires = jiffies + (val *HZ/1000);
-			add_timer(&discovery_watchdog);
+			self->watchdog.function = irda_discovery_timeout;
+			self->watchdog.data = (unsigned long) self;
+			self->watchdog.expires = jiffies + (val * HZ/1000);
+			add_timer(&(self->watchdog));
 
 			/* Wait for IR-LMP to call us back */
-			interruptible_sleep_on(&selective_discovery_wait);
+			interruptible_sleep_on(&self->query_wait);
 
 			/* If watchdog is still activated, kill it! */
-			if(discovery_watchdog.prev != (struct timer_list *) NULL)
-				del_timer(&discovery_watchdog);
+			if(self->watchdog.prev != (struct timer_list *) NULL)
+				del_timer(&(self->watchdog));
 
 			IRDA_DEBUG(1, __FUNCTION__ 
 				   "(), ...waking up !\n");
@@ -2276,16 +2288,13 @@ printk(KERN_DEBUG "val = %d\n", val);
 				   "(), found immediately !\n");
 
 		/* Tell IrLMP that we have been notified */
-		irlmp_update_client(self->ckey, self->mask, NULL, NULL);
-
-		/* Allow other people to wait */
-		selective_discovery_wait = NULL;
+		irlmp_update_client(self->ckey, self->mask, NULL, NULL, NULL);
 
 		/* Check if the we got some results */
-		if (!cachediscovery)
+		if (!self->cachediscovery)
 			return -EAGAIN;		/* Didn't find any devices */
 		/* Cleanup */
-		cachediscovery = NULL;
+		self->cachediscovery = NULL;
 
 		/* Note : We don't return anything to the user.
 		 * We could return the device that triggered the wake up,
diff -urpN old-linux/net/irda/ircomm/ircomm_tty_attach.c linux/net/irda/ircomm/ircomm_tty_attach.c
--- old-linux/net/irda/ircomm/ircomm_tty_attach.c	Thu Nov  9 13:24:13 2000
+++ linux/net/irda/ircomm/ircomm_tty_attach.c	Thu Nov  9 13:24:28 2000
@@ -46,7 +46,8 @@
 #include <net/irda/ircomm_tty_attach.h>
 
 static void ircomm_tty_ias_register(struct ircomm_tty_cb *self);
-static void ircomm_tty_discovery_indication(discovery_t *discovery);
+static void ircomm_tty_discovery_indication(discovery_t *discovery,
+					    void *priv);
 static void ircomm_tty_getvalue_confirm(int result, __u16 obj_id, 
 					struct ias_value *value, void *priv);
 void ircomm_tty_start_watchdog_timer(struct ircomm_tty_cb *self, int timeout);
@@ -235,7 +236,7 @@ static void ircomm_tty_ias_register(stru
 	}
 	self->skey = irlmp_register_service(hints);
 	self->ckey = irlmp_register_client(
-		hints, ircomm_tty_discovery_indication, NULL);
+		hints, ircomm_tty_discovery_indication, NULL, (void *) self);
 }
 
 /*
@@ -303,7 +304,8 @@ int ircomm_tty_send_initial_parameters(s
  *    device it is, and which services it has.
  *
  */
-static void ircomm_tty_discovery_indication(discovery_t *discovery)
+static void ircomm_tty_discovery_indication(discovery_t *discovery,
+					    void *priv)
 {
 	struct ircomm_tty_cb *self;
 	struct ircomm_tty_info info;
diff -urpN old-linux/net/irda/irlan/irlan_client.c linux/net/irda/irlan/irlan_client.c
--- old-linux/net/irda/irlan/irlan_client.c	Thu Nov  9 13:24:13 2000
+++ linux/net/irda/irlan/irlan_client.c	Thu Nov  9 13:24:28 2000
@@ -163,7 +163,7 @@ void irlan_client_wakeup(struct irlan_cb
  *    Remote device with IrLAN server support discovered
  *
  */
-void irlan_client_discovery_indication(discovery_t *discovery) 
+void irlan_client_discovery_indication(discovery_t *discovery, void *priv) 
 {
 	struct irlan_cb *self;
 	__u32 saddr, daddr;
diff -urpN old-linux/net/irda/irlan/irlan_common.c linux/net/irda/irlan/irlan_common.c
--- old-linux/net/irda/irlan/irlan_common.c	Thu Nov  9 13:24:13 2000
+++ linux/net/irda/irlan/irlan_common.c	Thu Nov  9 13:24:28 2000
@@ -183,7 +183,7 @@ int __init irlan_init(void)
 
 	/* Register with IrLMP as a client */
 	ckey = irlmp_register_client(hints, irlan_client_discovery_indication,
-				     NULL);
+				     NULL, NULL);
 	
 	/* Register with IrLMP as a service */
  	skey = irlmp_register_service(hints);
diff -urpN old-linux/net/irda/irlmp.c linux/net/irda/irlmp.c
--- old-linux/net/irda/irlmp.c	Thu Nov  9 13:24:13 2000
+++ linux/net/irda/irlmp.c	Thu Nov  9 13:24:28 2000
@@ -395,9 +395,25 @@ int irlmp_connect_request(struct lsap_cb
 		return -EHOSTUNREACH;
 	}
 
+	/* Check if LAP is disconnected or already connected */
 	if (lap->daddr == DEV_ADDR_ANY)
 		lap->daddr = daddr;
 	else if (lap->daddr != daddr) {
+		struct lsap_cb *any_lsap;
+
+		/* Check if some LSAPs are active on this LAP */
+		any_lsap = (struct lsap_cb *) hashbin_get_first(lap->lsaps);
+		if (any_lsap == NULL) {
+			/* No active connection, but LAP hasn't been
+			 * disconnected yet (waiting for timeout in LAP).
+			 * Maybe we could give LAP a bit of help in this case.
+			 */
+			IRDA_DEBUG(0, __FUNCTION__ "(), sorry, but I'm waiting for LAP to timeout!\n");
+			return -EAGAIN;
+		}
+
+		/* LAP is already connected to a different node, and LAP
+		 * can only talk to one node at a time */
 		IRDA_DEBUG(0, __FUNCTION__ "(), sorry, but link is busy!\n");
 		return -EBUSY;
 	}
@@ -811,7 +827,7 @@ void irlmp_check_services(discovery_t *d
  *	o Any socket (in any state - ouch, that may be a lot !)
  * The client may have defined one of two callback to be notified in case
  * of discovery, one callback for any discovery and one for partial/selective
- * discovery based on the hints that it pass to IrLMP.
+ * discovery based on the hints that it passed to IrLMP.
  */
 void irlmp_notify_client(irlmp_client_t *client, hashbin_t *log)
 {
@@ -821,7 +837,7 @@ void irlmp_notify_client(irlmp_client_t 
 	
 	/* Check if client wants the whole log */
 	if (client->callback2)
-		client->callback2(log);
+		client->callback2(log, client->priv);
 	
 	/* Check if client wants or not partial/selective log (optimisation) */
 	if (!client->callback1)
@@ -841,7 +857,7 @@ void irlmp_notify_client(irlmp_client_t 
 		 */
 		if (client->hint_mask & discovery->hints.word & 0x7f7f) {
 			if (client->callback1)
-				client->callback1(discovery);
+				client->callback1(discovery, client->priv);
 		}
 		discovery = (discovery_t *) hashbin_get_next(log);
 	}
@@ -1270,7 +1286,7 @@ int irlmp_unregister_service(__u32 handl
  *    Returns: handle > 0 on success, 0 on error
  */
 __u32 irlmp_register_client(__u16 hint_mask, DISCOVERY_CALLBACK1 callback1,
-			    DISCOVERY_CALLBACK2 callback2)
+			    DISCOVERY_CALLBACK2 callback2, void *priv)
 {
 	irlmp_client_t *client;
 	__u32 handle;
@@ -1292,6 +1308,7 @@ __u32 irlmp_register_client(__u16 hint_m
 	client->hint_mask = hint_mask;
 	client->callback1 = callback1;
 	client->callback2 = callback2;
+	client->priv = priv;
 
  	hashbin_insert(irlmp->clients, (queue_t *) client, handle, NULL);
 
@@ -1308,7 +1325,7 @@ __u32 irlmp_register_client(__u16 hint_m
  */
 int irlmp_update_client(__u32 handle, __u16 hint_mask, 
 			DISCOVERY_CALLBACK1 callback1, 
-			DISCOVERY_CALLBACK2 callback2)
+			DISCOVERY_CALLBACK2 callback2, void *priv)
 {
 	irlmp_client_t *client;
 
@@ -1324,6 +1341,7 @@ int irlmp_update_client(__u32 handle, __
 	client->hint_mask = hint_mask;
 	client->callback1 = callback1;
 	client->callback2 = callback2;
+	client->priv = priv;
 	
 	return 0;
 }


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
