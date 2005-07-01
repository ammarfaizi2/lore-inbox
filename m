Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVGAXSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVGAXSs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 19:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263317AbVGAXPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 19:15:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15232 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262710AbVGAXKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 19:10:25 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17093.52572.3153.664456@segfault.boston.redhat.com>
Date: Fri, 1 Jul 2005 19:10:20 -0400
To: mpm@selenic.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [rfc | patch 6/6] netpoll: fix deadlock in arp_reply
In-Reply-To: <17093.52306.136742.190912@segfault.boston.redhat.com>
References: <17093.52306.136742.190912@segfault.boston.redhat.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes an obvious deadlock in the netpoll code.  netpoll_rx takes the
npinfo->rx_lock.  netpoll_rx is also the only caller of arp_reply (through
__netpoll_rx).  As such, it is not necessary to take this lock.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

--- linux-2.6.12/net/core/netpoll.c.orig	2005-07-01 17:55:24.313339068 -0400
+++ linux-2.6.12/net/core/netpoll.c	2005-07-01 17:55:57.354863472 -0400
@@ -370,11 +370,8 @@ static void arp_reply(struct sk_buff *sk
 	struct sk_buff *send_skb;
 	struct netpoll *np = NULL;
 
-	spin_lock_irqsave(&npinfo->rx_lock, flags);
 	if (npinfo->rx_np && npinfo->rx_np->dev == skb->dev)
 		np = npinfo->rx_np;
-	spin_unlock_irqrestore(&npinfo->rx_lock, flags);
-
 	if (!np)
 		return;
 
