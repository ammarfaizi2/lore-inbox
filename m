Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270760AbTGNTrg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 15:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270761AbTGNTrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 15:47:35 -0400
Received: from mail5.bluewin.ch ([195.186.1.207]:45952 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S270760AbTGNTrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:47:31 -0400
Date: Mon, 14 Jul 2003 22:02:03 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] via-rhine 1.19: One more Rhine-I fix
Message-ID: <20030714200203.GA4774@k3.hellgate.ch>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
X-Operating-System: Linux 2.6.0-test1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch fixes another way the Rhine-I found to break down under load. It
should bring Rhine-I behavior on par with the Rhine-II.

Roger

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-rhine-1.19.diff"

--- linux-2.4/drivers/net/via-rhine.c.org	2003-07-14 21:49:49.000000000 +0200
+++ linux-2.4/drivers/net/via-rhine.c	2003-07-14 21:50:19.000000000 +0200
@@ -122,11 +122,14 @@
 	- No filtering multicast in promisc mode (Edward Peng)
 	- Fix for Rhine-I Tx timeouts
 
+	LK1.1.19 (Roger Luethi)
+	- Increase Tx threshold for unspecified errors
+
 */
 
 #define DRV_NAME	"via-rhine"
-#define DRV_VERSION	"1.1.18"
-#define DRV_RELDATE	"July-4-2003"
+#define DRV_VERSION	"1.1.19"
+#define DRV_RELDATE	"July-12-2003"
 
 
 /* A few user-configurable values.
@@ -1659,9 +1662,13 @@
 	}
 	if ((intr_status & IntrTxError) && ~( IntrTxAborted | IntrTxUnderrun |
 										   IntrTxDescRace )) {
-		if (debug > 2)
-			printk(KERN_INFO "%s: Unspecified error.\n",
-				   dev->name);
+		if (np->tx_thresh < 0xE0) {
+			writeb(np->tx_thresh += 0x20, ioaddr + TxConfig);
+		}
+		if (debug > 1)
+			printk(KERN_INFO "%s: Unspecified error. Tx "
+				   "threshold now %2.2x.\n",
+				   dev->name, np->tx_thresh);
 	}
 	if (intr_status & ( IntrTxAborted | IntrTxUnderrun | IntrTxDescRace |
 						IntrTxError ))

--XsQoSWH+UP9D9v3l--
