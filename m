Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270267AbUJTBUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270267AbUJTBUp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 21:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270254AbUJTBFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 21:05:40 -0400
Received: from palrel13.hp.com ([156.153.255.238]:431 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S270257AbUJTBBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 21:01:36 -0400
Date: Tue, 19 Oct 2004 18:01:34 -0700
To: "David S. Miller" <davem@davemloft.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] Fix lmp_lsap_inuse()
Message-ID: <20041020010134.GB12932@bougret.hpl.hp.com>
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

ir269_lmp_lsap_inuse-3.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [CRITICA] Fix locking in error path in IrLMP (Stanford checker)
	o [CORRECT] Don't reuse unconnected LSAPs (listening sockets)
	o [CORRECT] Make sure the LSAP we are picking has just not been grabed
	o [CORRECT] Wrap around the LSAP space properly back to 0x10
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>


diff -u -p linux/include/net/irda/irlmp.d0.h linux/include/net/irda/irlmp.h
--- linux/include/net/irda/irlmp.d0.h	Fri Oct 15 15:49:36 2004
+++ linux/include/net/irda/irlmp.h	Fri Oct 15 15:50:58 2004
@@ -175,7 +175,8 @@ struct irlmp_cb {
 	discovery_t discovery_cmd; /* Discovery command to use by IrLAP */
 	discovery_t discovery_rsp; /* Discovery response to use by IrLAP */
 
-	int free_lsap_sel;
+	/* Last lsap picked automatically by irlmp_find_free_slsap() */
+	int	last_lsap_sel;
 
 	struct timer_list discovery_timer;
 
diff -u -p linux/net/irda/irlmp.d0.c linux/net/irda/irlmp.c
--- linux/net/irda/irlmp.d0.c	Fri Oct 15 15:40:05 2004
+++ linux/net/irda/irlmp.c	Fri Oct 15 17:34:13 2004
@@ -99,7 +99,7 @@ int __init irlmp_init(void)
 
 	spin_lock_init(&irlmp->cachelog->hb_spinlock);
 
-	irlmp->free_lsap_sel = 0x10; /* Reserved 0x00-0x0f */
+	irlmp->last_lsap_sel = 0x0f; /* Reserved 0x00-0x0f */
 	strcpy(sysctl_devname, "Linux");
 
 	/* Do discovery every 3 seconds */
@@ -160,7 +160,7 @@ struct lsap_cb *irlmp_open_lsap(__u8 sls
 	/* Allocate new instance of a LSAP connection */
 	self = kmalloc(sizeof(struct lsap_cb), GFP_ATOMIC);
 	if (self == NULL) {
-		ERROR("%s: can't allocate memory", __FUNCTION__);
+		ERROR("%s: can't allocate memory\n", __FUNCTION__);
 		return NULL;
 	}
 	memset(self, 0, sizeof(struct lsap_cb));
@@ -1649,6 +1649,12 @@ EXPORT_SYMBOL(irlmp_unregister_client);
  * Function irlmp_slsap_inuse (slsap)
  *
  *    Check if the given source LSAP selector is in use
+ *
+ * This function is clearly not very efficient. On the mitigating side, the
+ * stack make sure that in 99% of the cases, we are called only once
+ * for each socket allocation. We could probably keep a bitmap
+ * of the allocated LSAP, but I'm not sure the complexity is worth it.
+ * Jean II
  */
 int irlmp_slsap_inuse(__u8 slsap_sel)
 {
@@ -1668,7 +1674,7 @@ int irlmp_slsap_inuse(__u8 slsap_sel)
 		return FALSE;
 #endif /* CONFIG_IRDA_ULTRA */
 
-	/* Valid values are between 0 and 127 */
+	/* Valid values are between 0 and 127 (0x0-0x6F) */
 	if (slsap_sel > LSAP_MAX)
 		return TRUE;
 
@@ -1680,30 +1686,68 @@ int irlmp_slsap_inuse(__u8 slsap_sel)
 	spin_lock_irqsave(&irlmp->links->hb_spinlock, flags);
 	lap = (struct lap_cb *) hashbin_get_first(irlmp->links);
 	while (lap != NULL) {
-		ASSERT(lap->magic == LMP_LAP_MAGIC, return TRUE;);
+		ASSERT(lap->magic == LMP_LAP_MAGIC, goto errlap;);
 
 		/* Careful for priority inversions here !
-		 * All other uses of attrib spinlock are independent of
-		 * the object spinlock, so we are safe. Jean II */
+		 * irlmp->links is never taken while another IrDA
+		 * spinlock is held, so we are safe. Jean II */
 		spin_lock(&lap->lsaps->hb_spinlock);
 
+		/* For this IrLAP, check all the LSAPs */
 		self = (struct lsap_cb *) hashbin_get_first(lap->lsaps);
 		while (self != NULL) {
-			ASSERT(self->magic == LMP_LSAP_MAGIC, return TRUE;);
+			ASSERT(self->magic == LMP_LSAP_MAGIC, goto errlsap;);
 
 			if ((self->slsap_sel == slsap_sel)) {
 				IRDA_DEBUG(4, "Source LSAP selector=%02x in use\n",
-				      self->slsap_sel);
-				return TRUE;
+					   self->slsap_sel);
+				goto errlsap;
 			}
 			self = (struct lsap_cb*) hashbin_get_next(lap->lsaps);
 		}
 		spin_unlock(&lap->lsaps->hb_spinlock);
+
 		/* Next LAP */
 		lap = (struct lap_cb *) hashbin_get_next(irlmp->links);
 	}
 	spin_unlock_irqrestore(&irlmp->links->hb_spinlock, flags);
+
+	/*
+	 * Server sockets are typically waiting for connections and
+	 * therefore reside in the unconnected list. We don't want
+	 * to give out their LSAPs for obvious reasons...
+	 * Jean II
+	 */
+	spin_lock_irqsave(&irlmp->unconnected_lsaps->hb_spinlock, flags);
+
+	self = (struct lsap_cb *) hashbin_get_first(irlmp->unconnected_lsaps);
+	while (self != NULL) {
+		ASSERT(self->magic == LMP_LSAP_MAGIC, goto erruncon;);
+		if ((self->slsap_sel == slsap_sel)) {
+			IRDA_DEBUG(4, "Source LSAP selector=%02x in use (unconnected)\n",
+				   self->slsap_sel);
+			goto erruncon;
+		}
+		self = (struct lsap_cb*) hashbin_get_next(irlmp->unconnected_lsaps);
+	}
+	spin_unlock_irqrestore(&irlmp->unconnected_lsaps->hb_spinlock, flags);
+
 	return FALSE;
+
+	/* Error exit from within one of the two nested loops.
+	 * Make sure we release the right spinlock in the righ order.
+	 * Jean II */
+errlsap:
+	spin_unlock(&lap->lsaps->hb_spinlock);
+errlap:
+	spin_unlock_irqrestore(&irlmp->links->hb_spinlock, flags);
+	return TRUE;
+
+	/* Error exit from within the unconnected loop.
+	 * Just one spinlock to release... Jean II */
+erruncon:
+	spin_unlock_irqrestore(&irlmp->unconnected_lsaps->hb_spinlock, flags);
+	return TRUE;
 }
 
 /*
@@ -1720,22 +1764,48 @@ __u8 irlmp_find_free_slsap(void)
 	ASSERT(irlmp != NULL, return -1;);
 	ASSERT(irlmp->magic == LMP_MAGIC, return -1;);
 
-	lsap_sel = irlmp->free_lsap_sel++;
-
-	/* Check if the new free lsap is really free */
-	while (irlmp_slsap_inuse(irlmp->free_lsap_sel)) {
-		irlmp->free_lsap_sel++;
+	/* Most users don't really care which LSAPs they are given,
+	 * and therefore we automatically give them a free LSAP.
+	 * This function try to find a suitable LSAP, i.e. which is
+	 * not in use and is within the acceptable range. Jean II */
+
+	do {
+		/* Always increment to LSAP number before using it.
+		 * In theory, we could reuse the last LSAP number, as long
+		 * as it is no longer in use. Some IrDA stack do that.
+		 * However, the previous socket may be half closed, i.e.
+		 * we closed it, we think it's no longer in use, but the
+		 * other side did not receive our close and think it's
+		 * active and still send data on it.
+		 * This is similar to what is done with PIDs and TCP ports.
+		 * Also, this reduce the number of calls to irlmp_slsap_inuse()
+		 * which is an expensive function to call.
+		 * Jean II */
+		irlmp->last_lsap_sel++;
 
 		/* Check if we need to wraparound (0x70-0x7f are reserved) */
-		if (irlmp->free_lsap_sel > LSAP_MAX) {
-			irlmp->free_lsap_sel = 10;
+		if (irlmp->last_lsap_sel > LSAP_MAX) {
+			/* 0x00-0x10 are also reserved for well know ports */
+			irlmp->last_lsap_sel = 0x10;
 
 			/* Make sure we terminate the loop */
-			if (wrapped++)
+			if (wrapped++) {
+				ERROR("%s: no more free LSAPs !\n",
+				      __FUNCTION__);
 				return 0;
+			}
 		}
-	}
-	IRDA_DEBUG(4, "%s(), next free lsap_sel=%02x\n",
+
+		/* If the LSAP is in use, try the next one.
+		 * Despite the autoincrement, we need to check if the lsap
+		 * is really in use or not, first because LSAP may be
+		 * directly allocated in irlmp_open_lsap(), and also because
+		 * we may wraparound on old sockets. Jean II */
+	} while (irlmp_slsap_inuse(irlmp->last_lsap_sel));
+
+	/* Got it ! */
+	lsap_sel = irlmp->last_lsap_sel;
+	IRDA_DEBUG(4, "%s(), found free lsap_sel=%02x\n",
 		   __FUNCTION__, lsap_sel);
 
 	return lsap_sel;
