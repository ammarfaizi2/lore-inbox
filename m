Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265677AbTIEVtD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 17:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265648AbTIEVru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 17:47:50 -0400
Received: from palrel11.hp.com ([156.153.255.246]:29590 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S264313AbTIEVoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 17:44:01 -0400
Date: Fri, 5 Sep 2003 14:44:00 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] connect watchdog fixes
Message-ID: <20030905214400.GF14233@bougret.hpl.hp.com>
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

ir2604_connect_watchdog-5.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [CRITICA] In case of connect watchdog, drop reference to the LAP
	o [CORRECT] Prevent dumping LSAP after connect watchdog
	o [CRITICA] Prevent dumping TSAP if dumping LSAP did fail
	o [CORRECT] Only set connected bit on response if LSAP state is correct


diff -u -p linux/net/irda/irlmp.d3.c linux/net/irda/irlmp.c
--- linux/net/irda/irlmp.d3.c	Thu Sep  4 18:34:13 2003
+++ linux/net/irda/irlmp.c	Thu Sep  4 18:35:06 2003
@@ -540,7 +540,8 @@ int irlmp_connect_response(struct lsap_c
 	ASSERT(self->magic == LMP_LSAP_MAGIC, return -1;);
 	ASSERT(userdata != NULL, return -1;);
 
-	set_bit(0, &self->connected);	/* TRUE */
+	/* We set the connected bit and move the lsap to the connected list
+	 * in the state machine itself. Jean II */
 
 	IRDA_DEBUG(2, "%s(), slsap_sel=%02x, dlsap_sel=%02x\n",
 		   __FUNCTION__, self->slsap_sel, self->dlsap_sel);
@@ -612,13 +613,17 @@ struct lsap_cb *irlmp_dup(struct lsap_cb
 
 	spin_lock_irqsave(&irlmp->unconnected_lsaps->hb_spinlock, flags);
 
-	/* Only allowed to duplicate unconnected LSAP's */
-	if (!hashbin_find(irlmp->unconnected_lsaps, (long) orig, NULL)) {
-		IRDA_DEBUG(0, "%s(), unable to find LSAP\n", __FUNCTION__);
+	/* Only allowed to duplicate unconnected LSAP's, and only LSAPs
+	 * that have received a connect indication. Jean II */
+	if ((!hashbin_find(irlmp->unconnected_lsaps, (long) orig, NULL)) ||
+	    (orig->lap == NULL)) {
+		IRDA_DEBUG(0, "%s(), invalid LSAP (wrong state)\n",
+			   __FUNCTION__);
 		spin_unlock_irqrestore(&irlmp->unconnected_lsaps->hb_spinlock,
 				       flags);
 		return NULL;
 	}
+
 	/* Allocate a new instance */
 	new = kmalloc(sizeof(struct lsap_cb), GFP_ATOMIC);
 	if (!new)  {
@@ -643,8 +648,8 @@ struct lsap_cb *irlmp_dup(struct lsap_cb
 	hashbin_insert(irlmp->unconnected_lsaps, (irda_queue_t *) new,
 		       (long) new, NULL);
 
-	/* Make sure that we invalidate the cache */
 #ifdef CONFIG_IRDA_CACHE_LAST_LSAP
+	/* Make sure that we invalidate the LSAP cache */
 	new->lap->cache.valid = FALSE;
 #endif /* CONFIG_IRDA_CACHE_LAST_LSAP */
 
diff -u -p linux/net/irda/irlmp_event.d3.c linux/net/irda/irlmp_event.c
--- linux/net/irda/irlmp_event.d3.c	Thu Sep  4 18:34:23 2003
+++ linux/net/irda/irlmp_event.c	Thu Sep  4 18:35:06 2003
@@ -586,6 +586,8 @@ static int irlmp_state_connect(struct ls
 		hashbin_insert(self->lap->lsaps, (irda_queue_t *) self,
 			       (long) self, NULL);
 
+		set_bit(0, &self->connected);	/* TRUE */
+
 		irlmp_send_lcf_pdu(self->lap, self->dlsap_sel,
 				   self->slsap_sel, CONNECT_CNF, skb);
 
@@ -599,10 +601,13 @@ static int irlmp_state_connect(struct ls
 		IRDA_DEBUG(0, "%s() WATCHDOG_TIMEOUT!\n",  __FUNCTION__);
 
 		/* Disconnect, get out... - Jean II */
+		self->lap = NULL;
 		self->dlsap_sel = LSAP_ANY;
 		irlmp_next_lsap_state(self, LSAP_DISCONNECTED);
 		break;
 	default:
+		/* LM_LAP_DISCONNECT_INDICATION : Should never happen, we
+		 * are *not* yet bound to the IrLAP link. Jean II */
 		IRDA_DEBUG(0, "%s(), Unknown event %s on LSAP %#02x\n", 
 			   __FUNCTION__, irlmp_event[event], self->slsap_sel);
 		break;
@@ -659,6 +664,7 @@ static int irlmp_state_connect_pend(stru
 		IRDA_DEBUG(0, "%s() WATCHDOG_TIMEOUT!\n",  __FUNCTION__);
 
 		/* Go back to disconnected mode, keep the socket waiting */
+		self->lap = NULL;
 		self->dlsap_sel = LSAP_ANY;
 		if(self->conn_skb)
 			dev_kfree_skb(self->conn_skb);
@@ -666,6 +672,8 @@ static int irlmp_state_connect_pend(stru
 		irlmp_next_lsap_state(self, LSAP_DISCONNECTED);
 		break;
 	default:
+		/* LM_LAP_DISCONNECT_INDICATION : Should never happen, we
+		 * are *not* yet bound to the IrLAP link. Jean II */
 		IRDA_DEBUG(0, "%s(), Unknown event %s on LSAP %#02x\n",
 			   __FUNCTION__, irlmp_event[event], self->slsap_sel);
 		break;
@@ -721,6 +729,8 @@ static int irlmp_state_dtr(struct lsap_c
 		irlmp_send_lcf_pdu(self->lap, self->dlsap_sel, self->slsap_sel,
 				   DISCONNECT, skb);
 		irlmp_next_lsap_state(self, LSAP_DISCONNECTED);
+		/* Called only from irlmp_disconnect_request(), will
+		 * unbind from LAP over there. Jean II */
 
 		/* Try to close the LAP connection if its still there */
 		if (self->lap) {
diff -u -p linux/net/irda/irttp.d3.c linux/net/irda/irttp.c
--- linux/net/irda/irttp.d3.c	Thu Sep  4 18:34:33 2003
+++ linux/net/irda/irttp.c	Thu Sep  4 18:35:06 2003
@@ -1428,9 +1428,16 @@ struct tsap_cb *irttp_dup(struct tsap_cb
 	/* We don't need the old instance any more */
 	spin_unlock_irqrestore(&irttp->tsaps->hb_spinlock, flags);
 
+	/* Try to dup the LSAP (may fail if we were too slow) */
+	new->lsap = irlmp_dup(orig->lsap, new);
+	if (!new->lsap) {
+		IRDA_DEBUG(0, "%s(), dup failed!\n", __FUNCTION__);
+		kfree(new);
+		return NULL;
+	}
+
 	/* Not everything should be copied */
 	new->notify.instance = instance;
-	new->lsap = irlmp_dup(orig->lsap, new);
 	init_timer(&new->todo_timer);
 
 	skb_queue_head_init(&new->rx_queue);
