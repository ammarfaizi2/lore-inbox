Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129932AbQK1Sij>; Tue, 28 Nov 2000 13:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130514AbQK1Sia>; Tue, 28 Nov 2000 13:38:30 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:13263 "EHLO
        ns-inetext.inet.com") by vger.kernel.org with ESMTP
        id <S129932AbQK1SiT>; Tue, 28 Nov 2000 13:38:19 -0500
Message-ID: <3A23F490.69688B84@inet.com>
Date: Tue, 28 Nov 2000 12:08:16 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        becker@webserv.gsfc.nasa.gov
Subject: [PATCH] lance.c - dev_kfree_skb() then reference skb->len
Content-Type: multipart/mixed;
 boundary="------------85C02D6AE9D44FB9D4937197"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------85C02D6AE9D44FB9D4937197
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Greetings all,

Patch is against 2.2.17, drivers/net/lance.c.
I believe this to be "obviously correct," but please correct me if I'm
wrong.
This moves a reference to skb->len to before the possible
dev_kfree_skb(skb) call.  Though it appears to work as is, I suspect it
is incorrect.

Please apply or let me know why.

Eli

ps.  It's an attachment rather than inline because I can't seem to get
Netscape (4.71) to do that without replacing tabs with spaces.  Grr.

--------------------. "To the systems programmer, users and applications
Eli Carter          | serve only to provide a test load."
eli.carter@inet.com `---------------------------------- (random fortune)
--------------85C02D6AE9D44FB9D4937197
Content-Type: text/plain; charset=us-ascii;
 name="lance.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lance.c.diff"

--- lance.c.2.2.17	Mon Nov 13 12:13:11 2000
+++ lance.c	Tue Nov 28 11:46:16 2000
@@ -926,6 +926,8 @@
 
 	lp->tx_ring[entry].misc = 0x0000;
 
+	lp->stats.tx_bytes += skb->len;
+
 	/* If any part of this buffer is >16M we must copy it to a low-memory
 	   buffer. */
 	if ((u32)virt_to_bus(skb->data) + skb->len > 0x01000000) {
@@ -941,7 +943,6 @@
 		lp->tx_ring[entry].base = ((u32)virt_to_bus(skb->data) & 0xffffff) | 0x83000000;
 	}
 	lp->cur_tx++;
-	lp->stats.tx_bytes += skb->len;
 
 	/* Trigger an immediate send poll. */
 	outw(0x0000, ioaddr+LANCE_ADDR);

--------------85C02D6AE9D44FB9D4937197--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
