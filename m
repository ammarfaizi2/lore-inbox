Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269483AbUHZUJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269483AbUHZUJX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269504AbUHZUGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:06:08 -0400
Received: from waste.org ([209.173.204.2]:34716 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S269545AbUHZUAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:00:16 -0400
Date: Thu, 26 Aug 2004 14:59:53 -0500
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Moyer <jmoyer@redhat.com>
Subject: [PATCH 2/5] netpoll: revert queue stopped change
Message-ID: <20040826195953.GZ31237@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Moyer <jmoyer@redhat.com>

Here's the first of the broken out patch set.  This puts the check for
netif_queue_stopped back into netpoll_send_skb.  Network drivers are not
designed to have their hard_start_xmit routines called when the queue is
stopped.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Matt Mackall <mpm@selenic.com>

--- linux-2.6.7/net/core/netpoll.c.orig	2004-08-16 11:57:46.890322256 -0400
+++ linux-2.6.7/net/core/netpoll.c	2004-08-16 12:17:34.477781520 -0400
@@ -168,6 +168,18 @@ repeat:
 	spin_lock(&np->dev->xmit_lock);
 	np->dev->xmit_lock_owner = smp_processor_id();
 
+	/*
+	 * network drivers do not expect to be called if the queue is
+	 * stopped.
+	 */
+	if (netif_queue_stopped(np->dev)) {
+		np->dev->xmit_lock_owner = -1;
+		spin_unlock(&np->dev->xmit_lock);
+
+		netpoll_poll(np);
+		goto repeat;
+	}
+
 	status = np->dev->hard_start_xmit(skb, np->dev);
 	np->dev->xmit_lock_owner = -1;
 	spin_unlock(&np->dev->xmit_lock);


-- 
Mathematics is the supreme nostalgia of our time.
