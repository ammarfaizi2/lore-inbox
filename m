Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbTFQB6n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 21:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264534AbTFQBzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 21:55:24 -0400
Received: from palrel12.hp.com ([156.153.255.237]:63684 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S264535AbTFQByk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 21:54:40 -0400
Date: Mon, 16 Jun 2003 19:08:33 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] Fix IrIAP skb leak
Message-ID: <20030617020833.GH30944@bougret.hpl.hp.com>
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

ir241_iriap_skb_leak.diff :
		<Patch from Jan Kiszka>
	o [CORRECT] Fix obvious skb leak in IrIAP state machines


diff -u -p linux/net/irda/iriap_event.d7.c linux/net/irda/iriap_event.c
--- linux/net/irda/iriap_event.d7.c	Mon Dec  2 16:24:29 2002
+++ linux/net/irda/iriap_event.c	Mon Dec  2 16:25:50 2002
@@ -251,22 +251,25 @@ static void state_s_call(struct iriap_cb
 static void state_s_make_call(struct iriap_cb *self, IRIAP_EVENT event, 
 			      struct sk_buff *skb) 
 {
+	struct sk_buff *tx_skb;
+
 	ASSERT(self != NULL, return;);
 
 	switch (event) {
 	case IAP_CALL_REQUEST:
-		skb = self->skb;
+		tx_skb = self->skb;
 		self->skb = NULL;
 		
-		irlmp_data_request(self->lsap, skb);
+		irlmp_data_request(self->lsap, tx_skb);
 		iriap_next_call_state(self, S_OUTSTANDING);
 		break;
 	default:
 		IRDA_DEBUG(0, "%s(), Unknown event %d\n", __FUNCTION__, event);
-		if (skb)
-			dev_kfree_skb(skb);
 		break;
 	}
+	/* Cleanup time ! */
+	if (skb)
+		dev_kfree_skb(skb);
 }
 
 /*
