Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbQKKVc6>; Sat, 11 Nov 2000 16:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129178AbQKKVcs>; Sat, 11 Nov 2000 16:32:48 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:55561 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S129130AbQKKVci>; Sat, 11 Nov 2000 16:32:38 -0500
Date: Sat, 11 Nov 2000 21:33:39 GMT
Message-Id: <200011112133.VAA32631@tepid.osl.fast.no>
Subject: [patch] patch-2.4.0-test10-irda19 (was: Re: The IrDA patches)
X-Mailer: Pygmy (v0.4.4pre)
Subject: [patch] patch-2.4.0-test10-irda19 (was: Re: The IrDA patches)
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

The name of this patch is irda19.diff. 

(Many thanks to Jean Tourrilhes for splitting up the big patch)

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash
[OUPS   ] : Error that will be fixed in a later patch

irda19.diff :
-----------------
	o [CORRECT] Correctly handle interleaved discovery frames

diff -urpN old-linux/net/irda/irlap_event.c linux/net/irda/irlap_event.c
--- old-linux/net/irda/irlap_event.c	Thu Nov  9 17:52:56 2000
+++ linux/net/irda/irlap_event.c	Thu Nov  9 17:53:16 2000
@@ -407,6 +407,27 @@ static int irlap_state_ndm(struct irlap_
 			irlap_start_query_timer(self, QUERY_TIMEOUT*info->S);
 			irlap_next_state(self, LAP_REPLY);
 		}
+		else {
+		/* This is the final slot. How is it possible ?
+		 * This would happen is both discoveries are just slightly
+		 * offset (if they are in sync, all packets are lost).
+		 * Most often, all the discovery requests will be received
+		 * in QUERY state (see my comment there), except for the
+		 * last frame that will come here.
+		 * The big trouble when it happen is that active discovery
+		 * doesn't happen, because nobody answer the discoveries
+		 * frame of the other guy, so the log shows up empty.
+		 * What should we do ?
+		 * Not much. It's too late to answer those discovery frames,
+		 * so we just pass the info to IrLMP who will put it in the
+		 * log (and post an event).
+		 * Jean II
+		 */
+			IRDA_DEBUG(1, __FUNCTION__ "(), Receiving final discovery request, missed the discovery slots :-(\n");
+
+			/* Last discovery request -> in the log */
+			irlap_discovery_indication(self, info->discovery); 
+		}
 		break;
 #ifdef CONFIG_IRDA_ULTRA
 	case SEND_UI_FRAME:
@@ -494,11 +515,8 @@ static int irlap_state_query(struct irla
 		break;
 	case RECV_DISCOVERY_XID_CMD:
 		/* Yes, it is possible to receive those frames in this mode.
-		 * This would happen is both discoveries are just slightly
-		 * offset (if they are in sync, all packets are lost).
-		 * The big trouble when it happen is that passive discovery
-		 * doesn't happen, because nobody answer the discoveries
-		 * frame of the other guy, so the log shows up empty.
+		 * Note that most often the last discovery request won't
+		 * occur here but in NDM state (see my comment there).
 		 * What should we do ?
 		 * Not much. We are currently performing our own discovery,
 		 * therefore we can't answer those frames. We don't want
@@ -509,10 +527,9 @@ static int irlap_state_query(struct irla
 
 		ASSERT(info != NULL, return -1;);
 
-		IRDA_DEBUG(1, __FUNCTION__ "(), Receiving event %d, %s\n",
-			   event, irlap_event[event]);
+		IRDA_DEBUG(1, __FUNCTION__ "(), Receiving discovery request (s = %d) while performing discovery :-(\n", info->s);
 
-		/* Last discovery frame? */
+		/* Last discovery request ? */
 		if (info->s == 0xff)
 			irlap_discovery_indication(self, info->discovery); 
 		break;


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
