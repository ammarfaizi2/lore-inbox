Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbUL0PCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbUL0PCv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 10:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbUL0PCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 10:02:51 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:18404 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261894AbUL0PCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 10:02:33 -0500
Message-ID: <41D032B6.E5D3D00C@tv-sign.ru>
Date: Mon, 27 Dec 2004 19:05:10 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] optimize prefetch() usage in skb_queue_walk()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

This patch changes skb_queue_walk() in the same manner
as in list_for_each() prefetch optimization, see
http://marc.theaimsgroup.com/?l=linux-kernel&m=110399132418587

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.10/include/linux/skbuff.h~	2004-12-26 12:52:43.000000000 +0300
+++ 2.6.10/include/linux/skbuff.h	2004-12-26 12:54:33.000000000 +0300
@@ -1071,9 +1071,9 @@
 }
 
 #define skb_queue_walk(queue, skb) \
-		for (skb = (queue)->next, prefetch(skb->next);	\
-		     (skb != (struct sk_buff *)(queue));	\
-		     skb = skb->next, prefetch(skb->next))
+		for (skb = (queue)->next;					\
+		     prefetch(skb->next), (skb != (struct sk_buff *)(queue));	\
+		     skb = skb->next)
 
 
 extern struct sk_buff *skb_recv_datagram(struct sock *sk, unsigned flags,
