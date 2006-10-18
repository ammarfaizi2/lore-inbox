Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161327AbWJRTis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161327AbWJRTis (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 15:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161326AbWJRTir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 15:38:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65436 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161323AbWJRTiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 15:38:46 -0400
Date: Wed, 18 Oct 2006 12:38:46 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netpoll: retry memory leak
Message-ID: <20061018123846.6dd1ab83@dxpl.pdx.osdl.net>
X-Mailer: Sylpheed-Claws 2.5.3 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If netpoll uses up it's retries, it should drop the skb
not leak memory.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
---
 net/core/netpoll.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index ead5920..c375fde 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -273,10 +273,8 @@ static void netpoll_send_skb(struct netp
 	int status;
 	struct netpoll_info *npinfo;
 
-	if (!np || !np->dev || !netif_running(np->dev)) {
-		__kfree_skb(skb);
-		return;
-	}
+	if (!np || !np->dev || !netif_running(np->dev))
+		goto free_skb;
 
 	npinfo = np->dev->npinfo;
 
@@ -314,6 +312,8 @@ static void netpoll_send_skb(struct netp
 		netpoll_poll(np);
 		udelay(50);
 	} while (npinfo->tries > 0);
+free_skb:
+	__kfree_skb(skb);
 }
 
 void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
-- 
1.4.2.3

