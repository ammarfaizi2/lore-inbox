Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265157AbUETRJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265157AbUETRJX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 13:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265172AbUETRJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 13:09:23 -0400
Received: from mail5.bluewin.ch ([195.186.1.207]:25530 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S265157AbUETRJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 13:09:20 -0400
Date: Thu, 20 May 2004 19:05:00 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] via-rhine: Fix force media
Message-ID: <20040520170500.GA11792@k3.hellgate.ch>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
X-Operating-System: Linux 2.6.6 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Lucas Nussbaum and Dirk Koeppen each found independently that the code
for forcing media options in via-rhine is borked and suggested the fix
below. I've been sitting on this way too long because there is more
badness in the immediate vicinity which needs a bigger surgery.

The second hunk fixes a braino I managed to introduce myself.

The patch is for both 2.4 and 2.6. Please apply.

Roger

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-rhine-2.6.6-fix.diff"

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

--qMm9M+Fa2AknHoGS--
