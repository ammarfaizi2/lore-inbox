Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319528AbSH2W7g>; Thu, 29 Aug 2002 18:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319502AbSH2Wqy>; Thu, 29 Aug 2002 18:46:54 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:51394 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S319500AbSH2Wpm>;
	Thu, 29 Aug 2002 18:45:42 -0400
Date: Thu, 29 Aug 2002 15:48:23 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: [PATCH 2.5] : ir252_lap_unique_saddr.diff
Message-ID: <20020829224823.GC14118@bougret.hpl.hp.com>
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

ir252_lap_unique_saddr.diff :
---------------------------
	o [CORRECT] Make sure LAP address is sane, which mean not NULL,
		not BROADCAST and not already in use by another link.


diff -u -p linux/net/irda/irlap.d5.c linux/net/irda/irlap.c
--- linux/net/irda/irlap.d5.c	Wed Aug 21 15:37:52 2002
+++ linux/net/irda/irlap.c	Wed Aug 21 15:42:05 2002
@@ -139,7 +139,15 @@ struct irlap_cb *irlap_open(struct net_d
 	skb_queue_head_init(&self->wx_list);
 
 	/* My unique IrLAP device address! */
-	get_random_bytes(&self->saddr, sizeof(self->saddr));
+	/* We don't want the broadcast address, neither the NULL address
+	 * (most often used to signify "invalid"), and we don't want an
+	 * address already in use (otherwise connect won't be able
+	 * to select the proper link). - Jean II */
+	do {
+		get_random_bytes(&self->saddr, sizeof(self->saddr));
+	} while ((self->saddr == 0x0) || (self->saddr == BROADCAST) ||
+		 (hashbin_find(irlap, self->saddr, NULL)) );
+	/* Copy to the driver */
 	memcpy(dev->dev_addr, &self->saddr, 4);
 
 	init_timer(&self->slot_timer);
