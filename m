Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUEWKt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUEWKt4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 06:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUEWKt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 06:49:56 -0400
Received: from mail3.bluewin.ch ([195.186.1.75]:13185 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S262328AbUEWKty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 06:49:54 -0400
Date: Sun, 23 May 2004 12:48:59 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@hellgate.ch
Subject: [1/4][PATCH 2.6] via-rhine: Fix force media
Message-ID: <20040523104859.GA10091@k3.hellgate.ch>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@hellgate.ch
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <20040523104650.GA9979@k3.hellgate.ch>
X-Operating-System: Linux 2.6.6 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Lucas Nussbaum and Dirk Koeppen each found independently that the code
for forcing media options in via-rhine is borked and suggested the fix
below. I've been sitting on this way too long because there is more
badness in the immediate vicinity which needs a bigger surgery.

The second hunk fixes a braino I managed to introduce myself.

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-rhine-2.6.6-1-fix.diff"

--- linux-2.6.6/drivers/net/via-rhine.c	2004-05-20 16:17:38.228468522 +0200
+++ linux-2.6.6-patch/drivers/net/via-rhine.c	2004-05-20 17:46:34.466916644 +0200
@@ -860,7 +860,7 @@
 		if (option & 0x220)
 			np->mii_if.full_duplex = 1;
 		np->default_port = option & 0x3ff;
-		if (np->default_port & 0x330) {
+		if (option & 0x330) {
 			/* FIXME: shouldn't someone check this variable? */
 			/* np->medialock = 1; */
 			printk(KERN_INFO "  Forcing %dMbs %s-duplex operation.\n",
@@ -1683,8 +1683,9 @@
 			printk(KERN_INFO "%s: Tx descriptor write-back race.\n",
 				   dev->name);
 	}
-	if ((intr_status & IntrTxError) && ~( IntrTxAborted | IntrTxUnderrun |
-										   IntrTxDescRace )) {
+	if ((intr_status & IntrTxError) &&
+			(intr_status & ( IntrTxAborted |
+			IntrTxUnderrun | IntrTxDescRace )) == 0) {
 		if (np->tx_thresh < 0xE0) {
 			writeb(np->tx_thresh += 0x20, ioaddr + TxConfig);
 		}

--envbJBWh7q8WU6mo--
