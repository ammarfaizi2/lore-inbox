Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267918AbUIJDu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267918AbUIJDu3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 23:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267939AbUIJDu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 23:50:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:35534 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267918AbUIJDu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 23:50:28 -0400
Subject: [PATCH] ppc: fix sungem NAPI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, "David S. Miller" <davem@redhat.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1094788157.2543.111.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 10 Sep 2004 13:49:17 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The recent sungem NAPI change introduced a bug: dev_kfree_skb() is called
within the spinlock, thus triggers all sort of WARN_ON's later on down the
stack.

This patch changes it to dev_kfree_skb_any(), I hope that is fine
as we aren't really in interrupt, are we ? (I don't know in what
context NAPI polling occurs, is it a timer IRQ ?)

Ben.

===== drivers/net/sungem.c 1.59 vs edited =====
--- 1.59/drivers/net/sungem.c	2004-09-08 06:17:59 +10:00
+++ edited/drivers/net/sungem.c	2004-09-10 13:44:18 +10:00
@@ -651,7 +651,7 @@
 		}
 
 		gp->net_stats.tx_packets++;
-		dev_kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 	}
 	gp->tx_old = entry;
 


