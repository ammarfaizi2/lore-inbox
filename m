Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132452AbQKKU6g>; Sat, 11 Nov 2000 15:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132472AbQKKU60>; Sat, 11 Nov 2000 15:58:26 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:27401 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S132452AbQKKU6O>; Sat, 11 Nov 2000 15:58:14 -0500
Date: Sat, 11 Nov 2000 20:59:14 GMT
Message-Id: <200011112059.UAA31670@tepid.osl.fast.no>
Subject: [patch] patch-2.4.0-test10-irda5 (was: Re The IrDA patches)
X-Mailer: Pygmy (v0.4.4pre)
Subject: [patch] patch-2.4.0-test10-irda5 (was: Re The IrDA patches)
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

The name of this patch is irda5.diff. 

(Many thanks to Jean Tourrilhes for splitting up the big patch)

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash
[OUPS   ] : Error that will be fixed in a later patch

irda5.diff :
----------------
	o [CRITICA] Stop idle timer when reconnecting
	o [CORRECT] Pass dest address properly for IAS queries

diff -urpN old-linux/include/linux/irda.h linux/include/linux/irda.h
--- old-linux/include/linux/irda.h	Thu Nov  9 12:00:52 2000
+++ linux/include/linux/irda.h	Thu Nov  9 13:29:43 2000
@@ -88,7 +88,7 @@ enum {
 #define IRLMP_IAS_GET            8	/* Get an attribute from local IAS */
 #define IRLMP_IAS_DEL		 9	/* Remove attribute from local IAS */
 #define IRLMP_HINT_MASK_SET	10	/* Set discovery filter */
-#define IRLMP_WAITDEVICE	11	/* Wait for a discovery */
+#define IRLMP_WAITDEVICE	11	/* Wait for a new discovery */
 
 #define IRTTP_MAX_SDU_SIZE IRLMP_MAX_SDU_SIZE /* Compatibility */
 
@@ -97,6 +97,7 @@ enum {
 #define IAS_MAX_CLASSNAME       64
 #define IAS_MAX_ATTRIBNAME     256
 
+/* Attribute type needed for struct irda_ias_set */
 #define IAS_MISSING 0
 #define IAS_INTEGER 1
 #define IAS_OCT_SEQ 2
@@ -140,6 +141,7 @@ struct irda_ias_set {
 			__u8 string[IAS_MAX_STRING];
 		} irda_attrib_string;
 	} attribute;
+	__u32       daddr;    /* Address of device (for some queries only) */
 };
 
 /* Some private IOCTL's (max 16) */
diff -urpN old-linux/include/net/irda/timer.h linux/include/net/irda/timer.h
--- old-linux/include/net/irda/timer.h	Mon Oct 25 20:49:42 1999
+++ linux/include/net/irda/timer.h	Thu Nov  9 13:29:43 2000
@@ -82,6 +82,7 @@ struct lap_cb;
 inline void irlmp_start_watchdog_timer(struct lsap_cb *, int timeout);
 inline void irlmp_start_discovery_timer(struct irlmp_cb *, int timeout);
 inline void irlmp_start_idle_timer(struct lap_cb *, int timeout);
+inline void irlmp_stop_idle_timer(struct lap_cb *self); 
 
 #endif
 
diff -urpN old-linux/net/irda/af_irda.c linux/net/irda/af_irda.c
--- old-linux/net/irda/af_irda.c	Thu Nov  9 13:29:19 2000
+++ linux/net/irda/af_irda.c	Thu Nov  9 13:29:43 2000
@@ -11,7 +11,7 @@
  * Sources:       af_netroom.c, af_ax25.c, af_rose.c, af_x25.c etc.
  * 
  *     Copyright (c) 1999 Dag Brattli <dagb@cs.uit.no>
- *     Copyright (c) 1999 Jean Tourrilhes <jeant@rockfort.hpl.hp.com>
+ *     Copyright (c) 1999 Jean Tourrilhes <jt@hpl.hp.com>
  *     All Rights Reserved.
  *
  *     This program is free software; you can redistribute it and/or 
@@ -2199,7 +2199,7 @@ static int irda_getsockopt(struct socket
 		} else {
 			/* We are not connected, we must specify a valid
 			 * destination address */
-			daddr = ias_opt.attribute.irda_attrib_int;
+			daddr = ias_opt.daddr;
 			if((!daddr) || (daddr == DEV_ADDR_ANY))
 				return -EINVAL;
 		}
diff -urpN old-linux/net/irda/irlmp_event.c linux/net/irda/irlmp_event.c
--- old-linux/net/irda/irlmp_event.c	Fri Jan  7 11:51:56 2000
+++ linux/net/irda/irlmp_event.c	Thu Nov  9 13:29:43 2000
@@ -122,7 +122,7 @@ int irlmp_do_lsap_event(struct lsap_cb *
 	ASSERT(self->magic == LMP_LSAP_MAGIC, return -1;);
 
 	IRDA_DEBUG(4, __FUNCTION__ "(), EVENT = %s, STATE = %s\n",
-		   irlmp_event[event], irlmp_state[ self->lsap_state]);
+		   irlmp_event[event], irlsap_state[ self->lsap_state]);
 
 	return (*lsap_state[self->lsap_state]) (self, event, skb);
 }
@@ -393,6 +393,14 @@ static void irlmp_state_active(struct la
 		irlmp_next_lap_state(self, LAP_STANDBY);		
 		self->refcount = 0;
 		
+		/* In some case, at this point our side has already closed
+		 * all lsaps, and we are waiting for the idle_timer to
+		 * expire. If another device reconnect immediately, the
+		 * idle timer will expire in the midle of the connection
+		 * initialisation, screwing up things a lot...
+		 * Therefore, we must stop the timer... */
+		irlmp_stop_idle_timer(self);
+
 		/* 
 		 *  Inform all connected LSAP's using this link
 		 */
@@ -410,7 +418,8 @@ static void irlmp_state_active(struct la
 		}
 		break;
 	default:
-		IRDA_DEBUG(0, __FUNCTION__ "(), Unknown event %d\n", event);
+		IRDA_DEBUG(0, __FUNCTION__ "(), Unknown event %s\n",
+			   irlmp_event[event]);
 		if (skb)
  			dev_kfree_skb(skb);
 		break;
diff -urpN old-linux/net/irda/irlmp_frame.c linux/net/irda/irlmp_frame.c
--- old-linux/net/irda/irlmp_frame.c	Thu Nov  9 13:29:19 2000
+++ linux/net/irda/irlmp_frame.c	Thu Nov  9 13:29:43 2000
@@ -382,8 +382,9 @@ static void irlmp_discovery_timeout(u_lo
  *
  * The delay is currently set to 0.25s, which leave enough time to perform
  * a connection and don't interfer with next discovery (the lowest discovery
- * period/timeout that may be set is 1s).
- * Probably more testing is needed to get the value right...
+ * period/timeout that may be set is 1s). The message triggering this
+ * event was the last of the discovery, so the medium is now free...
+ * Maybe more testing is needed to get the value right...
  */
 void irlmp_link_discovery_indication(struct lap_cb *self, 
 				     discovery_t *discovery)
diff -urpN old-linux/net/irda/timer.c linux/net/irda/timer.c
--- old-linux/net/irda/timer.c	Tue Dec 21 10:17:58 1999
+++ linux/net/irda/timer.c	Thu Nov  9 13:29:43 2000
@@ -117,6 +117,13 @@ void irlmp_start_idle_timer(struct lap_c
 			 irlmp_idle_timer_expired);
 }
 
+void irlmp_stop_idle_timer(struct lap_cb *self) 
+{
+	/* If timer is activated, kill it! */
+	if(self->idle_timer.prev != (struct timer_list *) NULL)
+		del_timer(&self->idle_timer);
+}
+
 /*
  * Function irlap_slot_timer_expired (data)
  *


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
