Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132482AbQKKUyo>; Sat, 11 Nov 2000 15:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132472AbQKKUye>; Sat, 11 Nov 2000 15:54:34 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:23817 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S132452AbQKKUyS>; Sat, 11 Nov 2000 15:54:18 -0500
Date: Sat, 11 Nov 2000 20:55:18 GMT
Message-Id: <200011112055.UAA31574@tepid.osl.fast.no>
Subject: [patch] patch-2.4.0-test10-irda4 (was: Re The IrDA patches)
X-Mailer: Pygmy (v0.4.4pre)
Subject: [patch] patch-2.4.0-test10-irda4 (was: Re The IrDA patches)
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

The name of this patch is irda4.diff. 

(Many thanks to Jean Tourrilhes for splitting up the big patch)

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash
[OUPS   ] : Error that will be fixed in a later patch

irda4.diff :
----------------
	o [CORRECT] Add delay in -> Propagate incoming discovery info
	o [FEATURE] Save time of first discovery -> determine if new or same

diff -urpN old-linux/include/net/irda/discovery.h linux/include/net/irda/discovery.h
--- old-linux/include/net/irda/discovery.h	Thu Nov  9 13:04:53 2000
+++ linux/include/net/irda/discovery.h	Thu Nov  9 13:06:02 2000
@@ -59,6 +59,7 @@ typedef struct discovery_t {
 	int        gen_addr_bit; /* Need to generate a new device address? */
 	int        nslots;       /* Number of slots to use when discovering */
 	unsigned long timestamp; /* Time discovered */
+	unsigned long first_timestamp; /* First time discovered */
 } discovery_t;
 
 void irlmp_add_discovery(hashbin_t *cachelog, discovery_t *discovery);
diff -urpN old-linux/net/irda/af_irda.c linux/net/irda/af_irda.c
--- old-linux/net/irda/af_irda.c	Thu Nov  9 13:04:53 2000
+++ linux/net/irda/af_irda.c	Thu Nov  9 13:12:46 2000
@@ -452,9 +452,11 @@ static void irda_discovery_indication(ha
 /*
  * Function irda_selective_discovery_indication (discovery)
  *
- *    Got a selective discovery indication from IrLMP (node matching hint
- * bits), wake up any process waiting for answer
+ *    Got a selective discovery indication from IrLMP.
  *
+ * IrLMP is telling us that this node is matching our hint bit
+ * filter. Check if it's a newly discovered node (or if node changed its
+ * hint bits), and then wake up any process waiting for answer...
  */
 static void irda_selective_discovery_indication(discovery_t *discovery,
 						void *priv)
@@ -469,6 +471,16 @@ static void irda_selective_discovery_ind
 		return;
 	}
 
+	/* Check if node is discovered is a new one or an old one.
+	 * We check when how long ago this node was discovered, with a
+	 * coarse timeout (we may miss some discovery events or be delayed).
+	 * Note : by doing this test here, we avoid waking up a process ;-)
+	 */
+	if((jiffies - discovery->first_timestamp) >
+	   (sysctl_discovery_timeout * HZ)) {
+		return;		/* Too old, not interesting -> goodbye */
+	}
+
 	/* Pass parameter to the caller */
 	self->cachediscovery = discovery;
 
@@ -477,11 +489,12 @@ static void irda_selective_discovery_ind
 }
 
 /*
- * Function irda_discovery_timeout (a)
+ * Function irda_discovery_timeout (priv)
  *
- *    Got a selective discovery indication from IrLMP (node matching hint
- * bits), wake up any process waiting for answer
+ *    Timeout in the selective discovery process
  *
+ * We were waiting for a node to be discovered, but nothing has come up
+ * so far. Wake up the user and tell him that we failed...
  */
 static void irda_discovery_timeout(u_long	priv)
 {
@@ -2245,6 +2258,10 @@ static int irda_getsockopt(struct socket
 		 * come into range. When this device arrive, we just wake
 		 * up the caller, so that he has time to connect to it before
 		 * the device goes away...
+		 * Note : once the node has been discovered for more than a
+		 * few second, it won't trigger this function, unless it
+		 * goes away and come back changes its hint bits (so we
+		 * might call it IRLMP_WAITNEWDEVICE).
 		 */
 
 		/* Check that the user is passing us an int */
diff -urpN old-linux/net/irda/discovery.c linux/net/irda/discovery.c
--- old-linux/net/irda/discovery.c	Tue Dec 21 10:17:58 1999
+++ linux/net/irda/discovery.c	Thu Nov  9 13:06:02 2000
@@ -43,12 +43,23 @@
  *
  *    Add a new discovery to the cachelog, and remove any old discoveries
  *    from the same device
+ *
+ * Note : we try to preserve the time this device was *first* discovered
+ * (as opposed to the time of last discovery used for cleanup). This is
+ * used by clients waiting for discovery events to tell if the device
+ * discovered is "new" or just the same old one. They can't rely there
+ * on a binary flag (new/old), because not all discovery events are
+ * propagated to them, and they might not always listen, so they would
+ * miss some new devices popping up...
  */
 void irlmp_add_discovery(hashbin_t *cachelog, discovery_t *new)
 {
 	discovery_t *discovery, *node;
 	unsigned long flags;
 
+	/* Set time of first discovery if node is new (see below) */
+	new->first_timestamp = new->timestamp;
+
 	spin_lock_irqsave(&irlmp->lock, flags);
 
 	/* 
@@ -59,22 +70,25 @@ void irlmp_add_discovery(hashbin_t *cach
 	 */
 	discovery = (discovery_t *) hashbin_get_first(cachelog);
 	while (discovery != NULL ) {
-			node = discovery;
+		node = discovery;
 
-			/* Be sure to stay one item ahead */
-			discovery = (discovery_t *) hashbin_get_next(cachelog);
+		/* Be sure to stay one item ahead */
+		discovery = (discovery_t *) hashbin_get_next(cachelog);
 			
-			if ((node->daddr == new->daddr) || 
-			    (strcmp(node->nickname, new->nickname) == 0))
-			{
-				/* This discovery is a previous discovery 
-				 * from the same device, so just remove it
-				 */
-				hashbin_remove(cachelog, node->daddr, NULL);
-				kfree(node);
-			}
+		if ((node->daddr == new->daddr) || 
+		    (strcmp(node->nickname, new->nickname) == 0))
+		{
+			/* This discovery is a previous discovery 
+			 * from the same device, so just remove it
+			 */
+			hashbin_remove(cachelog, node->daddr, NULL);
+			/* Check if hints bits have changed */
+			if(node->hints.word == new->hints.word)
+				/* Set time of first discovery for this node */
+				new->first_timestamp = node->first_timestamp;
+			kfree(node);
 		}
-
+	}
 
 	/* Insert the new and updated version */
 	hashbin_insert(cachelog, (queue_t *) new, new->daddr, NULL);
diff -urpN old-linux/net/irda/irlmp_frame.c linux/net/irda/irlmp_frame.c
--- old-linux/net/irda/irlmp_frame.c	Thu Nov  9 12:00:52 2000
+++ linux/net/irda/irlmp_frame.c	Thu Nov  9 13:06:02 2000
@@ -34,6 +34,9 @@
 #include <net/irda/irlmp_frame.h>
 #include <net/irda/discovery.h>
 
+#define	DISCO_SMALL_DELAY	250	/* Delay for some discoveries in ms */
+struct timer_list disco_delay;		/* The timer associated */
+
 static struct lsap_cb *irlmp_find_lsap(struct lap_cb *self, __u8 dlsap, 
 				       __u8 slsap, int status, hashbin_t *);
 
@@ -338,10 +341,49 @@ void irlmp_link_connect_confirm(struct l
 }
 
 /*
+ * Function irlmp_discovery_timeout (priv)
+ *
+ *    Create a discovery event to the state machine (called after a delay)
+ *
+ * Note : irlmp_do_lap_event will handle the very rare case where the LAP
+ * is destroyed while we were sleeping.
+ */
+static void irlmp_discovery_timeout(u_long	priv)
+{
+	struct lap_cb *self;
+
+	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+
+	self = (struct lap_cb *) priv;
+	ASSERT(self != NULL, return;);
+
+	/* Just handle it the same way as a discovery confirm */
+	irlmp_do_lap_event(self, LM_LAP_DISCOVERY_CONFIRM, NULL);
+}
+
+/*
  * Function irlmp_link_discovery_indication (self, log)
  *
  *    Device is discovering us
  *
+ * It's not an answer to our own discoveries, just another device trying
+ * to perform discovery, but we don't want to miss the opportunity
+ * to exploit this information, because :
+ *	o We may not actively perform discovery (just passive discovery)
+ *	o This type of discovery is much more reliable. In some cases, it
+ *	  seem that less than 50% of our discoveries get an answer, while
+ *	  we always get ~100% of these.
+ *	o Make faster discovery, statistically divide time of discovery
+ *	  events by 2 (important for the latency aspect and user feel)
+ * However, when both devices discover each other, they might attempt to
+ * connect to each other, and it would create collisions on the medium.
+ * The trick here is to defer the event by a little delay to avoid both
+ * devices to jump in exactly at the same time...
+ *
+ * The delay is currently set to 0.25s, which leave enough time to perform
+ * a connection and don't interfer with next discovery (the lowest discovery
+ * period/timeout that may be set is 1s).
+ * Probably more testing is needed to get the value right...
  */
 void irlmp_link_discovery_indication(struct lap_cb *self, 
 				     discovery_t *discovery)
@@ -351,24 +393,14 @@ void irlmp_link_discovery_indication(str
 
 	irlmp_add_discovery(irlmp->cachelog, discovery);
 	
-	/* If we are already performing our own discovery, we don't
-	 * want to notify higher layers.
-	 * The first reason is that, if it is a new node they are
-	 * interested in, they would immediately connect to it, and as
-	 * the other end of the link is already doing the same (so we
-	 * break the symetry).
-	 * The second reason is that we will call them anyway when
-	 * we discover the node through our own discovery.
-	 *
-	 * On the other hand, if we don't perform discovery ourselves,
-	 * the higher layer will never get notified. So, we better do
-	 * it now...
-	 * Maybe we could add a delay or mark the medium as busy to
-	 * avoid collisions...
-	 */
-	if (!sysctl_discovery)
-		/* Just handle it the same way as a discovery confirm */
-		irlmp_do_lap_event(self, LM_LAP_DISCOVERY_CONFIRM, NULL);
+	/* If delay was activated, kill it! */
+	if(disco_delay.prev != (struct timer_list *) NULL)
+		del_timer(&disco_delay);
+	/* Set delay timer to expire in 0.5s. */
+	disco_delay.expires = jiffies + (DISCO_SMALL_DELAY * HZ/1000);
+	disco_delay.function = irlmp_discovery_timeout;
+	disco_delay.data = (unsigned long) self;
+	add_timer(&disco_delay);
 }
 
 /*
@@ -388,6 +420,11 @@ void irlmp_link_discovery_confirm(struct
 	
 	irlmp_add_discovery_log(irlmp->cachelog, log);
       
+	/* If delay was activated, kill it! */
+	if(disco_delay.prev != (struct timer_list *) NULL)
+		del_timer(&disco_delay);
+
+	/* Propagate event to the state machine */
 	irlmp_do_lap_event(self, LM_LAP_DISCOVERY_CONFIRM, NULL);
 }
 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
