Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266226AbTGIXis (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 19:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268725AbTGIXha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 19:37:30 -0400
Received: from palrel10.hp.com ([156.153.255.245]:16334 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S268745AbTGIXfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 19:35:42 -0400
Date: Wed, 9 Jul 2003 16:50:20 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5 IrDA] irtty leaks
Message-ID: <20030709235020.GD12747@bougret.hpl.hp.com>
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

ir250_irttp_leak.diff :
~~~~~~~~~~~~~~~~~~~~~
		<Stanford checker>
	o [CORRECT] fix two additional potential skb leaks in IrTTP.


diff -u -p linux/net/irda/irttp.d1.c linux/net/irda/irttp.c
--- linux/net/irda/irttp.d1.c	Wed Jun  4 13:31:22 2003
+++ linux/net/irda/irttp.c	Wed Jun  4 13:34:45 2003
@@ -1094,7 +1094,8 @@ int irttp_connect_request(struct tsap_cb
 		 *  Check that the client has reserved enough space for
 		 *  headers
 		 */
-		ASSERT(skb_headroom(userdata) >= TTP_MAX_HEADER, return -1;);
+		ASSERT(skb_headroom(userdata) >= TTP_MAX_HEADER,
+		       { dev_kfree_skb(tx_skb); return -1; } );
 	}
 
 	/* Initialize connection parameters */
@@ -1123,7 +1124,7 @@ int irttp_connect_request(struct tsap_cb
 	/* SAR enabled? */
 	if (max_sdu_size > 0) {
 		ASSERT(skb_headroom(tx_skb) >= (TTP_MAX_HEADER + TTP_SAR_HEADER),
-		       return -1;);
+		       { dev_kfree_skb(tx_skb); return -1; } );
 
 		/* Insert SAR parameters */
 		frame = skb_push(tx_skb, TTP_HEADER+TTP_SAR_HEADER);
