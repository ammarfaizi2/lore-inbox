Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272798AbRIMXT1>; Thu, 13 Sep 2001 19:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272847AbRIMXTH>; Thu, 13 Sep 2001 19:19:07 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:45055 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S272798AbRIMXSo>;
	Thu, 13 Sep 2001 19:18:44 -0400
Date: Thu, 13 Sep 2001 16:19:03 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Dag Brattli <dag@brattli.net>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-irda@pasta.cs.uit.no
Subject: [IrDA patch] ir248_disco_fixes_4.diff
Message-ID: <20010913161903.D7470@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir248_disco_fixes_4.diff :
------------------------
	o [CORRECT] Fix corner case where getting stuck in LMP state machine
	o [CORRECT] Fix rare deadlock in LAP secondary state machine
	o [FEATURE] Bypass LMP state machine when propagating discovery event
		- Fix many case where event is discarded and not passed up
		- Reduce overhead on a critical path
	o [FEATURE] Properly do expiry when discovery is not active

diff -u -p linux/include/net/irda/irlmp.d8.h linux/include/net/irda/irlmp.h
--- linux/include/net/irda/irlmp.d8.h	Thu Sep 13 11:49:34 2001
+++ linux/include/net/irda/irlmp.h	Thu Sep 13 11:51:00 2001
@@ -217,6 +217,7 @@ int  irlmp_disconnect_request(struct lsa
 void irlmp_discovery_confirm(hashbin_t *discovery_log);
 void irlmp_discovery_request(int nslots);
 struct irda_device_info *irlmp_get_discoveries(int *pn, __u16 mask);
+void irlmp_do_expiry(void);
 void irlmp_do_discovery(int nslots);
 discovery_t *irlmp_get_discovery_response(void);
 void irlmp_discovery_expiry(discovery_t *expiry);
diff -u -p linux/net/irda/irlmp.d8.c linux/net/irda/irlmp.c
--- linux/net/irda/irlmp.d8.c	Thu Sep 13 11:49:48 2001
+++ linux/net/irda/irlmp.c	Thu Sep 13 11:51:00 2001
@@ -693,10 +693,43 @@ void irlmp_disconnect_indication(struct 
 }
 
 /*
+ * Function irlmp_do_expiry (void)
+ *
+ *    Do a cleanup of the discovery log (remove old entries)
+ *
+ * Note : separate from irlmp_do_discovery() so that we can handle
+ * passive discovery properly.
+ */
+void irlmp_do_expiry()
+{
+	struct lap_cb *lap;
+
+	/*
+	 * Expire discovery on all links which are *not* connected.
+	 * On links which are connected, we can't do discovery
+	 * anymore and can't refresh the log, so we freeze the
+	 * discovery log to keep info about the device we are
+	 * connected to. - Jean II
+	 */
+	lap = (struct lap_cb *) hashbin_get_first(irlmp->links);
+	while (lap != NULL) {
+		ASSERT(lap->magic == LMP_LAP_MAGIC, return;);
+		
+		if (lap->lap_state == LAP_STANDBY) {
+			/* Expire discoveries discovered on this link */
+			irlmp_expire_discoveries(irlmp->cachelog, lap->saddr,
+						 FALSE);
+		}
+		lap = (struct lap_cb *) hashbin_get_next(irlmp->links);
+	}
+}
+
+/*
  * Function irlmp_do_discovery (nslots)
  *
  *    Do some discovery on all links
  *
+ * Note : log expiry is done above.
  */
 void irlmp_do_discovery(int nslots)
 {
@@ -731,10 +764,6 @@ void irlmp_do_discovery(int nslots)
 		ASSERT(lap->magic == LMP_LAP_MAGIC, return;);
 		
 		if (lap->lap_state == LAP_STANDBY) {
-			/* Expire discoveries discovered on this link */
-			irlmp_expire_discoveries(irlmp->cachelog, lap->saddr,
-						 FALSE);
-
 			/* Try to discover */
 			irlmp_do_lap_event(lap, LM_LAP_DISCOVERY_REQUEST, 
 					   NULL);
@@ -764,6 +793,9 @@ void irlmp_discovery_request(int nslots)
 	 */
 	if (!sysctl_discovery)
 		irlmp_do_discovery(nslots);
+	/* Note : we never do expiry here. Expiry will run on the
+	 * discovery timer regardless of the state of sysctl_discovery
+	 * Jean II */
 }
 
 /*
diff -u -p linux/net/irda/irlmp_event.d8.c linux/net/irda/irlmp_event.c
--- linux/net/irda/irlmp_event.d8.c	Thu Sep 13 11:50:03 2001
+++ linux/net/irda/irlmp_event.c	Thu Sep 13 11:51:00 2001
@@ -150,6 +150,10 @@ void irlmp_discovery_timer_expired(void 
 {
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
 	
+	/* We always cleanup the log (active & passive discovery) */ 
+	irlmp_do_expiry();
+
+	/* Active discovery is conditional */
 	if (sysctl_discovery)
 		irlmp_do_discovery(sysctl_discovery_slots);
 
@@ -205,10 +209,6 @@ static void irlmp_state_standby(struct l
 		
 		irlap_discovery_request(self->irlap, &irlmp->discovery_cmd);
 		break;
-	case LM_LAP_DISCOVERY_CONFIRM:
- 		/* irlmp_next_station_state( LMP_READY); */
-		irlmp_discovery_confirm(irlmp->cachelog);
- 		break;
 	case LM_LAP_CONNECT_INDICATION:
 		/*  It's important to switch state first, to avoid IrLMP to 
 		 *  think that the link is free since IrLMP may then start
@@ -274,6 +274,12 @@ static void irlmp_state_u_connect(struct
 			irlmp_do_lsap_event(lsap, LM_LAP_CONNECT_CONFIRM, NULL);
 			lsap = (struct lsap_cb*) hashbin_get_next(self->lsaps);
 		}
+		/* Note : by the time we get there (LAP retries and co),
+		 * the lsaps may already have gone. This avoid getting stuck
+		 * forever in LAP_ACTIVE state - Jean II */
+		if (HASHBIN_GET_SIZE(self->lsaps) == 0) {
+			irlmp_start_idle_timer(self, LM_IDLE_TIMEOUT);
+		}
 		break;
 	case LM_LAP_CONNECT_REQUEST:
 		/* Already trying to connect */
@@ -287,6 +293,12 @@ static void irlmp_state_u_connect(struct
 		while (lsap != NULL) {
 			irlmp_do_lsap_event(lsap, LM_LAP_CONNECT_CONFIRM, NULL);
 			lsap = (struct lsap_cb*) hashbin_get_next(self->lsaps);
+		}
+		/* Note : by the time we get there (LAP retries and co),
+		 * the lsaps may already have gone. This avoid getting stuck
+		 * forever in LAP_ACTIVE state - Jean II */
+		if (HASHBIN_GET_SIZE(self->lsaps) == 0) {
+			irlmp_start_idle_timer(self, LM_IDLE_TIMEOUT);
 		}
 		break;
 	case LM_LAP_DISCONNECT_INDICATION:
diff -u -p linux/net/irda/irlmp_frame.d8.c linux/net/irda/irlmp_frame.c
--- linux/net/irda/irlmp_frame.d8.c	Thu Sep 13 11:50:15 2001
+++ linux/net/irda/irlmp_frame.c	Thu Sep 13 11:51:00 2001
@@ -359,8 +359,9 @@ static void irlmp_discovery_timeout(u_lo
 	self = (struct lap_cb *) priv;
 	ASSERT(self != NULL, return;);
 
-	/* Just handle it the same way as a discovery confirm */
-	irlmp_do_lap_event(self, LM_LAP_DISCOVERY_CONFIRM, NULL);
+	/* Just handle it the same way as a discovery confirm,
+	 * bypass the LM_LAP state machine (see below) */
+	irlmp_discovery_confirm(irlmp->cachelog);
 }
 
 /*
@@ -377,8 +378,12 @@ static void irlmp_discovery_timeout(u_lo
  *	  we always get ~100% of these.
  *	o Make faster discovery, statistically divide time of discovery
  *	  events by 2 (important for the latency aspect and user feel)
+ *	o Even is we do active discovery, the other node might not
+ *	  answer our discoveries (ex: Palm).
+ *
  * However, when both devices discover each other, they might attempt to
- * connect to each other, and it would create collisions on the medium.
+ * connect to each other following the discovery event, and it would create
+ * collisions on the medium (SNRM battle).
  * The trick here is to defer the event by a little delay to avoid both
  * devices to jump in exactly at the same time...
  *
@@ -387,6 +392,14 @@ static void irlmp_discovery_timeout(u_lo
  * period/timeout that may be set is 1s). The message triggering this
  * event was the last of the discovery, so the medium is now free...
  * Maybe more testing is needed to get the value right...
+
+ * One more problem : the other node might do only a single discovery
+ * and connect immediately to us, and we would receive only a single
+ * discovery indication event, and because of the delay, it will arrive
+ * while the LAP is connected. That's another good reason to
+ * bypass the LM_LAP state machine ;-)
+ *
+ * Jean II
  */
 void irlmp_link_discovery_indication(struct lap_cb *self, 
 				     discovery_t *discovery)
@@ -427,8 +440,13 @@ void irlmp_link_discovery_confirm(struct
 	if(timer_pending(&disco_delay))
 		del_timer(&disco_delay);
 
-	/* Propagate event to the state machine */
-	irlmp_do_lap_event(self, LM_LAP_DISCOVERY_CONFIRM, NULL);
+	/* Propagate event to various LSAPs registered for it.
+	 * We bypass the LM_LAP state machine because
+	 *	1) We do it regardless of the LM_LAP state
+	 *	2) It doesn't affect the LM_LAP state
+	 *	3) Faster, slimer, simpler, ...
+	 * Jean II */
+	irlmp_discovery_confirm(irlmp->cachelog);
 }
 
 #ifdef CONFIG_IRDA_CACHE_LAST_LSAP
diff -u -p linux/net/irda/irlap_event.d8.c linux/net/irda/irlap_event.c
--- linux/net/irda/irlap_event.d8.c	Thu Sep 13 11:50:26 2001
+++ linux/net/irda/irlap_event.c	Thu Sep 13 11:51:00 2001
@@ -2018,7 +2018,7 @@ static int irlap_state_sclose(struct irl
 {
 	int ret = 0;
 
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	IRDA_DEBUG(1, __FUNCTION__ "()\n");
 
 	ASSERT(self != NULL, return -ENODEV;);
 	ASSERT(self->magic == LAP_MAGIC, return -EBADR;);
@@ -2048,6 +2048,9 @@ static int irlap_state_sclose(struct irl
 		irlap_disconnect_indication(self, LAP_DISC_INDICATION);
 		break;
 	case WD_TIMER_EXPIRED:
+		/* Always switch state before calling upper layers */
+		irlap_next_state(self, LAP_NDM);
+
 		irlap_apply_default_connection_parameters(self);
 		
 		irlap_disconnect_indication(self, LAP_DISC_INDICATION);
