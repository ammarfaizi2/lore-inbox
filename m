Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265555AbTFWWwx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 18:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265554AbTFWWvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 18:51:32 -0400
Received: from palrel10.hp.com ([156.153.255.245]:56270 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S265546AbTFWWtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 18:49:52 -0400
Date: Mon, 23 Jun 2003 16:03:59 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4 IrDA] IrLMP timer race fix
Message-ID: <20030623230359.GD12593@bougret.hpl.hp.com>
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

	Hi Marcelo,

	This fixes a race condition. Race conditions are bad.
	Please apply ;-)

	Jean


ir241_lmp_timer_race-2.diff :
---------------------------
	o [CORRECT] Start timer before sending event to fix race condition
	o [FEATURE] Improve the IrLMP event debugging messages.


diff -u -p linux/net/irda/irlmp_event.d3.c linux/net/irda/irlmp_event.c
--- linux/net/irda/irlmp_event.d3.c	Thu Sep 12 11:47:45 2002
+++ linux/net/irda/irlmp_event.c	Thu Sep 12 11:54:22 2002
@@ -515,10 +515,10 @@ static int irlmp_state_disconnected(stru
 
 		irlmp_next_lsap_state(self, LSAP_SETUP_PEND);
 
-		irlmp_do_lap_event(self->lap, LM_LAP_CONNECT_REQUEST, NULL);
-
 		/* Start watchdog timer (5 secs for now) */
 		irlmp_start_watchdog_timer(self, 5*HZ);
+
+		irlmp_do_lap_event(self->lap, LM_LAP_CONNECT_REQUEST, NULL);
 		break;
 	case LM_CONNECT_INDICATION:
 		if (self->conn_skb) {
@@ -529,8 +529,6 @@ static int irlmp_state_disconnected(stru
 
 		irlmp_next_lsap_state(self, LSAP_CONNECT_PEND);
 
-		irlmp_do_lap_event(self->lap, LM_LAP_CONNECT_REQUEST, NULL);
-
 		/* Start watchdog timer
 		 * This is not mentionned in the spec, but there is a rare
 		 * race condition that can get the socket stuck.
@@ -543,10 +541,12 @@ static int irlmp_state_disconnected(stru
 		 * a backup plan. 1 second is plenty (should be immediate).
 		 * Jean II */
 		irlmp_start_watchdog_timer(self, 1*HZ);
+
+		irlmp_do_lap_event(self->lap, LM_LAP_CONNECT_REQUEST, NULL);
 		break;
 	default:
-		IRDA_DEBUG(2, "%s(), Unknown event %s\n", 
-			 __FUNCTION__, irlmp_event[event]);
+		IRDA_DEBUG(1, "%s(), Unknown event %s on LSAP %#02x\n", 
+			   __FUNCTION__, irlmp_event[event], self->slsap_sel);
 		if (skb)
   			dev_kfree_skb(skb);
 		break;
@@ -604,8 +604,8 @@ static int irlmp_state_connect(struct ls
 		irlmp_next_lsap_state(self, LSAP_DISCONNECTED);
 		break;
 	default:
-		IRDA_DEBUG(0, "%s(), Unknown event %s\n",
-			 __FUNCTION__, irlmp_event[event]);
+		IRDA_DEBUG(0, "%s(), Unknown event %s on LSAP %#02x\n", 
+			   __FUNCTION__, irlmp_event[event], self->slsap_sel);
 		if (skb)
  			dev_kfree_skb(skb);
 		break;
@@ -666,8 +666,8 @@ static int irlmp_state_connect_pend(stru
 		irlmp_next_lsap_state(self, LSAP_DISCONNECTED);
 		break;
 	default:
-		IRDA_DEBUG(0, "%s() Unknown event %s\n", 
-			 __FUNCTION__, irlmp_event[event]);
+		IRDA_DEBUG(0, "%s(), Unknown event %s on LSAP %#02x\n", 
+			   __FUNCTION__, irlmp_event[event], self->slsap_sel);
 		if (skb)
  			dev_kfree_skb(skb);
 		break;	
@@ -756,8 +756,8 @@ static int irlmp_state_dtr(struct lsap_c
 		irlmp_disconnect_indication(self, reason, skb);
 		break;
 	default:
-		IRDA_DEBUG(0, "%s(), Unknown event %s\n", 
-			 __FUNCTION__, irlmp_event[event]);
+		IRDA_DEBUG(0, "%s(), Unknown event %s on LSAP %#02x\n", 
+			   __FUNCTION__, irlmp_event[event], self->slsap_sel);
 		if (skb)
  			dev_kfree_skb(skb);
 		break;	
@@ -829,8 +829,8 @@ static int irlmp_state_setup(struct lsap
 		irlmp_disconnect_indication(self, LM_CONNECT_FAILURE, NULL);
 		break;
 	default:
-		IRDA_DEBUG(0, "%s(), Unknown event %s\n", 
-			 __FUNCTION__, irlmp_event[event]);
+		IRDA_DEBUG(0, "%s(), Unknown event %s on LSAP %#02x\n", 
+			   __FUNCTION__, irlmp_event[event], self->slsap_sel);
 		if (skb)
  			dev_kfree_skb(skb);
 		break;	
@@ -888,8 +888,8 @@ static int irlmp_state_setup_pend(struct
 		irlmp_disconnect_indication(self, reason, NULL);
 		break;
 	default:
-		IRDA_DEBUG(0, "%s(), Unknown event %s\n", 
-			 __FUNCTION__, irlmp_event[event]);
+		IRDA_DEBUG(0, "%s(), Unknown event %s on LSAP %#02x\n", 
+			   __FUNCTION__, irlmp_event[event], self->slsap_sel);
 		if (skb)
  			dev_kfree_skb(skb);
 		break;	
