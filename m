Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267869AbUJVV0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267869AbUJVV0Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 17:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267746AbUJVVWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 17:22:45 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:27009 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267807AbUJVVGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 17:06:54 -0400
Date: Fri, 22 Oct 2004 13:51:01 -0700 (PDT)
From: <akepner@sgi.com>
X-X-Sender: <akepner@localhost.localdomain>
To: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
cc: <netdev@oss.sgi.com>, <jgarzik@pobox.com>, <davem@davemloft.net>,
       <jbarnes@engr.sgi.com>, <gnb@sgi.com>
Subject: [PATCH] use mmiowb in tg3_poll
In-Reply-To: <200410211628.06906.jbarnes@engr.sgi.com>
Message-ID: <Pine.LNX.4.33.0410221345400.392-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Returning from tg3_poll() without flushing the PIO write which
reenables interrupts can result in lower cpu utilization and higher
throughput. So use a memory barrier, mmiowb(), instead of flushing the
write with a PIO read.

Signed-off-by: Arthur Kepner <akepner@sgi.com>
---

--- linux-2.6.9-rc4-mm1.orig/drivers/net/tg3.c	2004-10-22 13:51:10.000000000 -0700
+++ linux-2.6.9-rc4-mm1/drivers/net/tg3.c	2004-10-22 13:53:36.000000000 -0700
@@ -417,6 +417,20 @@
 	tg3_cond_int(tp);
 }
 
+/* tg3_restart_ints
+ *  similar to tg3_enable_ints, but it can return without flushing the 
+ *  PIO write which reenables interrupts
+ */
+static void tg3_restart_ints(struct tg3 *tp)
+{
+	tw32(TG3PCI_MISC_HOST_CTRL,
+		(tp->misc_host_ctrl & ~MISC_HOST_CTRL_MASK_PCI_INT));
+	tw32_mailbox(MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW, 0x00000000);
+	mmiowb();
+
+	tg3_cond_int(tp);
+}
+
 static inline void tg3_netif_stop(struct tg3 *tp)
 {
 	netif_poll_disable(tp->dev);
@@ -2787,7 +2801,7 @@
 	if (done) {
 		spin_lock_irqsave(&tp->lock, flags);
 		__netif_rx_complete(netdev);
-		tg3_enable_ints(tp);
+		tg3_restart_ints(tp);
 		spin_unlock_irqrestore(&tp->lock, flags);
 	}
 


-- 
Arthur





