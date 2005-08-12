Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbVHLCVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbVHLCVs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 22:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbVHLCUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 22:20:18 -0400
Received: from waste.org ([216.27.176.166]:424 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S964790AbVHLCTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 22:19:49 -0400
Date: Thu, 11 Aug 2005 21:19:10 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.com>, "David S. Miller" <davem@davemloft.net>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: ak@suse.de, Jeff Moyer <jmoyer@redhat.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu, john.ronciak@intel.com,
       rostedt@goodmis.org
In-Reply-To: <2.502409567@selenic.com>
Message-Id: <3.502409567@selenic.com>
Subject: [PATCH 2/8] netpoll: deadlock bugfix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes an obvious deadlock in the netpoll code.  netpoll_rx takes the
npinfo->rx_lock.  netpoll_rx is also the only caller of arp_reply (through
__netpoll_rx).  As such, it is not necessary to take this lock.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: l/net/core/netpoll.c
===================================================================
--- l.orig/net/core/netpoll.c	2005-08-06 17:47:48.000000000 -0500
+++ l/net/core/netpoll.c	2005-08-06 17:47:49.000000000 -0500
@@ -353,11 +353,8 @@ static void arp_reply(struct sk_buff *sk
 	struct sk_buff *send_skb;
 	struct netpoll *np = NULL;
 
-	spin_lock_irqsave(&npinfo->rx_lock, flags);
 	if (npinfo->rx_np && npinfo->rx_np->dev == skb->dev)
 		np = npinfo->rx_np;
-	spin_unlock_irqrestore(&npinfo->rx_lock, flags);
-
 	if (!np)
 		return;
 
