Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132416AbQKKUqf>; Sat, 11 Nov 2000 15:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132466AbQKKUqY>; Sat, 11 Nov 2000 15:46:24 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:17929 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S132416AbQKKUqM>; Sat, 11 Nov 2000 15:46:12 -0500
Date: Sat, 11 Nov 2000 20:47:12 GMT
Message-Id: <200011112047.UAA31368@tepid.osl.fast.no>
Subject: [patch] patch-2.4.0-test10-irda2 (was: Re The IrDA patches)
X-Mailer: Pygmy (v0.4.4pre)
Subject: [patch] patch-2.4.0-test10-irda2 (was: Re The IrDA patches)
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

The name of this patch is irda2.diff. 

(Many thanks to Jean Tourrilhes for splitting up the big patch)

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash
[OUPS   ] : Error that will be fixed in a later patch

irda2.diff :
----------------
	o [CORRECT] Propagate incoming discovery info
	o [CORRECT] Inform user in case of discarded frames
	o [FEATURE] Set hint mask filter for discovery
	o [FEATURE] WAITDEVICE ioctl for blocking discovery
	o [FEATURE] Discovery callback optimisation
	o [OUPS   ] Extra printk

diff -urpN old-linux/include/linux/irda.h linux/include/linux/irda.h
--- old-linux/include/linux/irda.h	Thu Nov  9 11:49:35 2000
+++ linux/include/linux/irda.h	Thu Nov  9 11:50:18 2000
@@ -78,15 +78,17 @@ enum {
 #define SOL_IRLMP      266 /* Same as SOL_IRDA for now */
 #define SOL_IRTTP      266 /* Same as SOL_IRDA for now */
 
-#define IRLMP_ENUMDEVICES        1
-#define IRLMP_IAS_SET            2
-#define IRLMP_IAS_QUERY          3
-#define IRLMP_HINTS_SET          4
+#define IRLMP_ENUMDEVICES        1	/* Return discovery log */
+#define IRLMP_IAS_SET            2	/* Set an attribute in local IAS */
+#define IRLMP_IAS_QUERY          3	/* Query remote IAS for attribute */
+#define IRLMP_HINTS_SET          4	/* Set hint bits advertised */
 #define IRLMP_QOS_SET            5
 #define IRLMP_QOS_GET            6
 #define IRLMP_MAX_SDU_SIZE       7
-#define IRLMP_IAS_GET            8
-#define IRLMP_IAS_DEL		 9
+#define IRLMP_IAS_GET            8	/* Get an attribute from local IAS */
+#define IRLMP_IAS_DEL		 9	/* Remove attribute from local IAS */
+#define IRLMP_HINT_MASK_SET	10	/* Set discovery filter */
+#define IRLMP_WAITDEVICE	11	/* Wait for a discovery */
 
 #define IRTTP_MAX_SDU_SIZE IRLMP_MAX_SDU_SIZE /* Compatibility */
 
diff -urpN old-linux/net/irda/af_irda.c linux/net/irda/af_irda.c
--- old-linux/net/irda/af_irda.c	Thu Nov  9 11:49:35 2000
+++ linux/net/irda/af_irda.c	Thu Nov  9 11:53:21 2000
@@ -81,6 +81,9 @@ static struct proto_ops irda_ultra_ops;
 
 static hashbin_t *cachelog = NULL;
 static DECLARE_WAIT_QUEUE_HEAD(discovery_wait); /* Wait for discovery */
+static discovery_t *cachediscovery = NULL;
+static struct wait_queue *selective_discovery_wait = NULL;
+static struct timer_list discovery_watchdog;	/* to avoid blocking state */
 
 #define IRDA_MAX_HEADER (TTP_MAX_HEADER)
 
@@ -433,7 +436,7 @@ static void irda_getvalue_confirm(int re
 /*
  * Function irda_discovery_indication (log)
  *
- *    Got a discovery log from IrLMP, wake ut any process waiting for answer
+ *    Got a discovery log from IrLMP, wake up any process waiting for answer
  *
  */
 static void irda_discovery_indication(hashbin_t *log)
@@ -447,6 +450,46 @@ static void irda_discovery_indication(ha
 }
 
 /*
+ * Function irda_selective_discovery_indication (discovery)
+ *
+ *    Got a selective discovery indication from IrLMP (node matching hint
+ * bits), wake up any process waiting for answer
+ *
+ */
+static void irda_selective_discovery_indication(discovery_t *discovery)
+{
+	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+
+	/* Pass parameter to the caller */
+	cachediscovery = discovery;
+
+	/* Wake up process if its waiting for device to be discovered */
+	if(selective_discovery_wait != NULL)
+		wake_up_interruptible(&selective_discovery_wait);
+}
+
+/*
+ * Function irda_discovery_timeout (a)
+ *
+ *    Got a selective discovery indication from IrLMP (node matching hint
+ * bits), wake up any process waiting for answer
+ *
+ */
+static void irda_discovery_timeout(u_long	priv)
+{
+	struct irda_sock *self;
+	
+	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+
+	self = (struct irda_sock *) priv;
+	ASSERT(self != NULL, return;);
+
+	/* Wake up process if its still waiting... */
+	if(selective_discovery_wait != NULL)
+		wake_up_interruptible(&selective_discovery_wait);
+}
+
+/*
  * Function irda_open_tsap (self)
  *
  *    Open local Transport Service Access Point (TSAP)
@@ -619,9 +662,12 @@ static int irda_discover_daddr_and_lsap_
 	irlmp_update_client(self->ckey, self->mask, NULL, 
 			    irda_discovery_indication);
 	
-	/* Do some discovery */
+	/* Do some discovery (and also return cached discovery results) */
 	irlmp_discovery_request(self->nslots);
 		
+	/* Tell IrLMP that we have been notified */
+	irlmp_update_client(self->ckey, self->mask, NULL, NULL);
+
 	/* Check if the we got some results */
 	if (!cachelog)
 		/* Wait for answer */
@@ -675,6 +721,7 @@ static int irda_discover_daddr_and_lsap_
 		/* Next node, maybe we will be more lucky...  */
 		discovery = (discovery_t *) hashbin_get_next(cachelog);
 	}
+	cachelog = NULL;
 
 	/* Check out what we found */
 	if(daddr == DEV_ADDR_ANY) {
@@ -1870,6 +1917,27 @@ static int irda_setsockopt(struct socket
 
 		self->skey = irlmp_register_service((__u16) opt);
 		break;
+	case IRLMP_HINT_MASK_SET:
+		/* As opposed to the previous case which set the hint bits
+		 * that we advertise, this one set the filter we use when
+		 * making a discovery (nodes which don't match any hint
+		 * bit in the mask are not reported).
+		 */
+		if (optlen < sizeof(int))
+			return -EINVAL;
+	
+		if (get_user(opt, (int *)optval))
+			return -EFAULT;
+
+		/* Set the new hint mask */
+		self->mask = (__u16) opt;
+		/* Mask out extension bits */
+		self->mask &= 0x7f7f;
+		/* Check if no bits */
+		if(!self->mask)
+			self->mask = 0xFFFF;
+
+		break;
 	default:
 		return -ENOPROTOOPT;
 	}
@@ -1962,9 +2030,12 @@ static int irda_getsockopt(struct socket
 		irlmp_update_client(self->ckey, self->mask, NULL, 
 				    irda_discovery_indication);
 		
-		/* Do some discovery */
+		/* Do some discovery (and also return cached results) */
 		irlmp_discovery_request(self->nslots);
 		
+		/* Tell IrLMP that we have been notified */
+		irlmp_update_client(self->ckey, self->mask, NULL, NULL);
+
 		/* Check if the we got some results */
 		if (!cachelog)
 			return -EAGAIN;		/* Didn't find any devices */
@@ -2009,10 +2080,6 @@ static int irda_getsockopt(struct socket
 			discovery = (discovery_t *) hashbin_get_next(cachelog);
 		}
 		cachelog = NULL;
-		/* Problem : at this point, the discovery log got scrapped
-		 * and will be regenerated only later. If anybody (another
-		 * app) want to perform a discovery now, it will get screwed.
-		 */
 
 		/* Write total number of bytes used back to client */
 		if (put_user(total, optlen))
@@ -2145,6 +2212,86 @@ static int irda_getsockopt(struct socket
 				 sizeof(ias_opt)))
 		  	return -EFAULT;
 		/* Note : don't need to put optlen, we checked it */
+		break;
+	case IRLMP_WAITDEVICE:
+		/* This function is just another way of seeing life ;-)
+		 * IRLMP_ENUMDEVICES assumes that you have a static network,
+		 * and that you just want to pick one of the devices present.
+		 * On the other hand, in here we assume that no device is
+		 * present and that at some point in the future a device will
+		 * come into range. When this device arrive, we just wake
+		 * up the caller, so that he has time to connect to it before
+		 * the device goes away...
+		 */
+
+		/* Check that the user is passing us an int */
+		if (len != sizeof(int))
+			return -EINVAL;
+		/* Get timeout in ms (max time we block the caller) */
+		if (get_user(val, (int *)optval))
+			return -EFAULT;
+printk(KERN_DEBUG "val = %d\n", val);
+
+		/* Note : IRLMP is able to handle multiple client waiting
+		 * for discovery. Unfortunately, all the sockets use the same
+		 * notification function, making it impossible to have more
+		 * than one socket waiting for discovery */
+		/* Prevent re-entrancy */
+		if(selective_discovery_wait != NULL) {
+			IRDA_DEBUG(1, __FUNCTION__ 
+				   "(), already busy.\n");
+			return -EAGAIN;		/* Already busy */
+		}
+
+		/* Tell IrLMP we want to be notified */
+		irlmp_update_client(self->ckey, self->mask,
+				    irda_selective_discovery_indication, NULL);
+		
+		/* Do some discovery (and also return cached results) */
+		irlmp_discovery_request(self->nslots);
+		
+		/* Wait until a node is discovered */
+		if (!cachediscovery) {
+			IRDA_DEBUG(1, __FUNCTION__ 
+				   "(), nothing discovered yet, going to sleep...\n");
+
+			/* Set watchdog timer to expire in <val> ms. */
+			discovery_watchdog.function = irda_discovery_timeout;
+			discovery_watchdog.data = (unsigned long) self;
+			discovery_watchdog.expires = jiffies + (val *HZ/1000);
+			add_timer(&discovery_watchdog);
+
+			/* Wait for IR-LMP to call us back */
+			interruptible_sleep_on(&selective_discovery_wait);
+
+			/* If watchdog is still activated, kill it! */
+			if(discovery_watchdog.prev != (struct timer_list *) NULL)
+				del_timer(&discovery_watchdog);
+
+			IRDA_DEBUG(1, __FUNCTION__ 
+				   "(), ...waking up !\n");
+		}
+		else
+			IRDA_DEBUG(1, __FUNCTION__ 
+				   "(), found immediately !\n");
+
+		/* Tell IrLMP that we have been notified */
+		irlmp_update_client(self->ckey, self->mask, NULL, NULL);
+
+		/* Allow other people to wait */
+		selective_discovery_wait = NULL;
+
+		/* Check if the we got some results */
+		if (!cachediscovery)
+			return -EAGAIN;		/* Didn't find any devices */
+		/* Cleanup */
+		cachediscovery = NULL;
+
+		/* Note : We don't return anything to the user.
+		 * We could return the device that triggered the wake up,
+		 * but it's probably better to force the user to query
+		 * the whole discovery log and let him pick one device...
+		 */
 		break;
 	default:
 		return -ENOPROTOOPT;
diff -urpN old-linux/net/irda/irlmp.c linux/net/irda/irlmp.c
--- old-linux/net/irda/irlmp.c	Thu Jan  6 14:46:18 2000
+++ linux/net/irda/irlmp.c	Thu Nov  9 11:50:18 2000
@@ -805,6 +805,13 @@ void irlmp_check_services(discovery_t *d
  *
  *    Notify all about discovered devices
  *
+ * Clients registered with IrLMP are :
+ *	o IrComm
+ *	o IrLAN
+ *	o Any socket (in any state - ouch, that may be a lot !)
+ * The client may have defined one of two callback to be notified in case
+ * of discovery, one callback for any discovery and one for partial/selective
+ * discovery based on the hints that it pass to IrLMP.
  */
 void irlmp_notify_client(irlmp_client_t *client, hashbin_t *log)
 {
@@ -816,6 +823,10 @@ void irlmp_notify_client(irlmp_client_t 
 	if (client->callback2)
 		client->callback2(log);
 	
+	/* Check if client wants or not partial/selective log (optimisation) */
+	if (!client->callback1)
+		return;
+
 	/* 
 	 * Now, check all discovered devices (if any), and notify client 
 	 * only about the services that the client is interested in 
diff -urpN old-linux/net/irda/irlmp_frame.c linux/net/irda/irlmp_frame.c
--- old-linux/net/irda/irlmp_frame.c	Tue Dec 21 10:17:58 1999
+++ linux/net/irda/irlmp_frame.c	Thu Nov  9 11:50:18 2000
@@ -351,11 +351,24 @@ void irlmp_link_discovery_indication(str
 
 	irlmp_add_discovery(irlmp->cachelog, discovery);
 	
-#if 0   /* This will just cause a lot of connection collisions */
-
-	/* Just handle it the same way as a discovery confirm */
-	irlmp_do_lap_event(self, LM_LAP_DISCOVERY_CONFIRM, NULL);
-#endif
+	/* If we are already performing our own discovery, we don't
+	 * want to notify higher layers.
+	 * The first reason is that, if it is a new node they are
+	 * interested in, they would immediately connect to it, and as
+	 * the other end of the link is already doing the same (so we
+	 * break the symetry).
+	 * The second reason is that we will call them anyway when
+	 * we discover the node through our own discovery.
+	 *
+	 * On the other hand, if we don't perform discovery ourselves,
+	 * the higher layer will never get notified. So, we better do
+	 * it now...
+	 * Maybe we could add a delay or mark the medium as busy to
+	 * avoid collisions...
+	 */
+	if (!sysctl_discovery)
+		/* Just handle it the same way as a discovery confirm */
+		irlmp_do_lap_event(self, LM_LAP_DISCOVERY_CONFIRM, NULL);
 }
 
 /*
diff -urpN old-linux/net/irda/wrapper.c linux/net/irda/wrapper.c
--- old-linux/net/irda/wrapper.c	Fri Jan 28 19:36:22 2000
+++ linux/net/irda/wrapper.c	Thu Nov  9 11:50:18 2000
@@ -287,6 +287,8 @@ static void state_link_escape(struct net
 {
 	switch (byte) {
 	case BOF: /* New frame? */
+		IRDA_DEBUG(1, __FUNCTION__ 
+			   "(), Discarding incomplete frame\n");
 		rx_buff->state = BEGIN_FRAME;
 		irda_device_set_media_busy(dev, TRUE);
 		break;
@@ -328,6 +330,8 @@ static void state_inside_frame(struct ne
 
 	switch (byte) {
 	case BOF: /* New frame? */
+		IRDA_DEBUG(1, __FUNCTION__ 
+			   "(), Discarding incomplete frame\n");
 		rx_buff->state = BEGIN_FRAME;
 		irda_device_set_media_busy(dev, TRUE);
 		break;


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
