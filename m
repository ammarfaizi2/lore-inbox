Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269864AbSKEBuy>; Mon, 4 Nov 2002 20:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269753AbSKEBtX>; Mon, 4 Nov 2002 20:49:23 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:20703 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S269745AbSKEBtQ>;
	Mon, 4 Nov 2002 20:49:16 -0500
Date: Mon, 4 Nov 2002 17:55:50 -0800
To: irda-users@lists.sourceforge.net, Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] : ir256_packet_type.diff
Message-ID: <20021105015550.GD8849@bougret.hpl.hp.com>
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

ir256_packet_type.diff :
----------------------
		<Thanks to Martin Diehl>
	o [CORRECT] Handle non-linear and shared skbs
	o [CORRECT] Tell kernel we can handle multithreaded receive
		<Of course, this has been tested extensively on SMP>


diff -u -p linux/net/irda/irsyms.d5.c linux/net/irda/irsyms.c
--- linux/net/irda/irsyms.d5.c	Mon Nov  4 17:04:28 2002
+++ linux/net/irda/irsyms.c	Mon Nov  4 17:04:42 2002
@@ -180,13 +180,16 @@ EXPORT_SYMBOL(irtty_set_packet_mode);
 __u32 irda_debug = IRDA_DEBUG_LEVEL;
 #endif
 
+/* Packet type handler.
+ * Tell the kernel how IrDA packets should be handled.
+ */
 static struct packet_type irda_packet_type = 
 {
-	0,	/* MUTTER ntohs(ETH_P_IRDA),*/
-	NULL,
-	irlap_driver_rcv,
-	NULL,
-	NULL,
+	.type	= __constant_htons(ETH_P_IRDA),
+	.dev	= NULL,			/* Wildcard : All devices */
+	.func	= irlap_driver_rcv,	/* Packet type handler irlap_frame.c */
+	.data	= (void*) 1,		/* Understand shared skbs */
+	//.next	= NULL,
 };
 
 /*
@@ -267,7 +270,6 @@ int __init irda_init(void)
 	irsock_init();
 	
 	/* Add IrDA packet type (Start receiving packets) */
-	irda_packet_type.type = htons(ETH_P_IRDA);
         dev_add_pack(&irda_packet_type);
 
 	/* Notifier for Interface changes */
diff -u -p linux/net/irda/irlap_frame.d5.c linux/net/irda/irlap_frame.c
--- linux/net/irda/irlap_frame.d5.c	Mon Nov  4 17:04:35 2002
+++ linux/net/irda/irlap_frame.c	Mon Nov  4 17:04:42 2002
@@ -1280,6 +1280,20 @@ int irlap_driver_rcv(struct sk_buff *skb
 		return -1;
 	}
 
+	/* We are no longer an "old" protocol, so we need to handle
+	 * share and non linear skbs. This should never happen, so
+	 * we don't need to be clever about it. Jean II */
+	if ((skb = skb_share_check(skb, GFP_ATOMIC)) == NULL) {
+		ERROR("%s: can't clone shared skb!\n", __FUNCTION__);
+		return -1;
+	}
+	if (skb_is_nonlinear(skb))
+		if (skb_linearize(skb, GFP_ATOMIC) != 0) {
+			ERROR("%s: can't linearize skb!\n", __FUNCTION__);
+			dev_kfree_skb(skb);
+			return -1;
+		}
+
 	/* Check if frame is large enough for parsing */
 	if (skb->len < 2) {
 		ERROR("%s: frame to short!\n", __FUNCTION__);
