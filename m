Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268313AbUIJGWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268313AbUIJGWd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 02:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268316AbUIJGVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 02:21:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:23247 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268313AbUIJGVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 02:21:40 -0400
Subject: [PATCH] ppc: fix sungem NAPI (#2)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, "David S. Miller" <davem@redhat.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1094797225.2667.124.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 10 Sep 2004 16:20:26 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

(Resent with proper signed-off line after ack from David)

The recent sungem NAPI change introduced a bug: dev_kfree_skb() is called
within the spinlock, thus triggers all sort of WARN_ON's later on down the
stack.

This patch changes it to dev_kfree_skb_any(), I hope that is fine
as we aren't really in interrupt, are we ? (I don't know in what
context NAPI polling occurs, is it a timer IRQ ?)

Ben.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

--- 1.59/drivers/net/sungem.c	2004-09-08 06:17:59 +10:00
+++ edited/drivers/net/sungem.c	2004-09-10 13:44:18 +10:00
@@ -651,7 +651,7 @@
 		}
 
 		gp->net_stats.tx_packets++;
-		dev_kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 	}
 	gp->tx_old = entry;
 


