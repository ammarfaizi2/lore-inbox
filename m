Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271754AbTHHSw4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 14:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271749AbTHHSw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 14:52:56 -0400
Received: from palrel10.hp.com ([156.153.255.245]:7874 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S271754AbTHHSv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 14:51:57 -0400
Date: Fri, 8 Aug 2003 11:51:55 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5 IrDA] IrLAP retry count
Message-ID: <20030808185155.GC13274@bougret.hpl.hp.com>
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

ir260_lap_retry_count.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [CORRECT] add interoperability workaround for 2.4.X IrDA stacks


diff -u -p linux/net/irda/irlap_event.d2.c linux/net/irda/irlap_event.c
--- linux/net/irda/irlap_event.d2.c	Fri Jul 18 11:08:41 2003
+++ linux/net/irda/irlap_event.c	Fri Jul 18 11:30:47 2003
@@ -1215,35 +1215,31 @@ static int irlap_state_nrm_p(struct irla
 		 *  Check for expected I(nformation) frame
 		 */
 		if ((ns_status == NS_EXPECTED) && (nr_status == NR_EXPECTED)) {
-			/*  poll bit cleared?  */
-			if (!info->pf) {
-				self->vr = (self->vr + 1) % 8;
 
-				/* Update Nr received */
-				irlap_update_nr_received( self, info->nr);
+			/* Update Vr (next frame for us to receive) */
+			self->vr = (self->vr + 1) % 8;
 
-				self->ack_required = TRUE;
+			/* Update Nr received, cleanup our retry queue */
+			irlap_update_nr_received(self, info->nr);
+
+			/*
+			 *  Got expected NR, so reset the
+			 *  retry_count. This is not done by IrLAP spec,
+			 *  which is strange!
+			 */
+			self->retry_count = 0;
+			self->ack_required = TRUE;
 
+			/*  poll bit cleared?  */
+			if (!info->pf) {
 				/* Keep state, do not move this line */
 				irlap_next_state(self, LAP_NRM_P);
 
 				irlap_data_indication(self, skb, FALSE);
 			} else {
+				/* No longer waiting for pf */
 				del_timer(&self->final_timer);
 
-				self->vr = (self->vr + 1) % 8;
-
-				/* Update Nr received */
-				irlap_update_nr_received(self, info->nr);
-
-				/*
-				 *  Got expected NR, so reset the
-				 *  retry_count. This is not done by IrLAP,
-				 *  which is strange!
-				 */
-				self->retry_count = 0;
-				self->ack_required = TRUE;
-
 				irlap_wait_min_turn_around(self, &self->qos_tx);
 
 				/* Call higher layer *before* changing state
@@ -1869,14 +1865,17 @@ static int irlap_state_nrm_s(struct irla
 		 *  Check for expected I(nformation) frame
 		 */
 		if ((ns_status == NS_EXPECTED) && (nr_status == NR_EXPECTED)) {
+
+			/* Update Vr (next frame for us to receive) */
+			self->vr = (self->vr + 1) % 8;
+
+			/* Update Nr received */
+			irlap_update_nr_received(self, info->nr);
+
 			/*
 			 *  poll bit cleared?
 			 */
 			if (!info->pf) {
-				self->vr = (self->vr + 1) % 8;
-
-				/* Update Nr received */
-				irlap_update_nr_received(self, info->nr);
 
 				self->ack_required = TRUE;
 
@@ -1893,11 +1892,6 @@ static int irlap_state_nrm_s(struct irla
 				irlap_data_indication(self, skb, FALSE);
 				break;
 			} else {
-				self->vr = (self->vr + 1) % 8;
-
-				/* Update Nr received */
-				irlap_update_nr_received(self, info->nr);
-
 				/*
 				 *  We should wait before sending RR, and
 				 *  also before changing to XMIT_S
