Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266717AbUHZCCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266717AbUHZCCf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 22:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266725AbUHZCCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 22:02:32 -0400
Received: from waste.org ([209.173.204.2]:6289 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266717AbUHZCC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 22:02:28 -0400
Date: Wed, 25 Aug 2004 21:02:17 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] allow netpoll_poll to be called recursively
Message-ID: <20040826020216.GS31237@waste.org>
References: <16673.13536.765055.152488@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16673.13536.765055.152488@segfault.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 06:27:44PM -0400, Jeff Moyer wrote:
> Hi, Matt,
> 
> This should fix the recursive netpoll_poll deadlock that can happen with
> the newly introduced netpoll_poll_lock.

I rewrote this to get my head around it:

Index: linux/net/core/netpoll.c
===================================================================
--- linux.orig/net/core/netpoll.c	2004-08-25 12:29:10.783502466 -0500
+++ linux/net/core/netpoll.c	2004-08-25 20:55:05.468729251 -0500
@@ -72,6 +72,7 @@
 	 * timeouts.  Thus, we set our budget to a more reasonable value.
 	 */
 	int budget = 16;
+	static int poll_owner = -1;
 	unsigned long flags;
 
 	if(!np->dev || !netif_running(np->dev) || !np->dev->poll_controller)
@@ -81,18 +82,33 @@
 	np->dev->poll_controller(np->dev);
 
 	/* If scheduling is stopped, tickle NAPI bits */
-	spin_lock_irqsave(&netpoll_poll_lock, flags);
 	if (np->dev->poll &&
 	    test_bit(__LINK_STATE_RX_SCHED, &np->dev->state)) {
-		np->dev->netpoll_rx |= NETPOLL_RX_DROP;
-		atomic_inc(&trapped);
 
-		np->dev->poll(np->dev, &budget);
+		/* attempt to grab the lock to manipulate the _rx bits */
+		local_irq_save(flags);
 
-		atomic_dec(&trapped);
-		np->dev->netpoll_rx &= ~NETPOLL_RX_DROP;
+		if (smp_processor_id() != poll_owner) {
+			/* we're not the lock owner, wait for the lock */
+			spin_lock(&netpoll_poll_lock);
+			poll_owner = smp_processor_id();
+
+			np->dev->netpoll_rx |= NETPOLL_RX_DROP;
+			atomic_inc(&trapped);
+
+			np->dev->poll(np->dev, &budget);
+
+			atomic_dec(&trapped);
+			np->dev->netpoll_rx &= ~NETPOLL_RX_DROP;
+			poll_owner = -1;
+			spin_unlock_irqrestore(&netpoll_poll_lock, flags);
+		}
+		else {
+			/* we're already holding the lock */
+			np->dev->poll(np->dev, &budget);
+			local_irq_restore(flags);
+		}
 	}
-	spin_unlock_irqrestore(&netpoll_poll_lock, flags);
 
 	zap_completion_queue();
 }

I think the above matches your intent, let me know if I missed
something. Note your original version would do an unlock in the
recursive invocation even if it didn't do a lock.

But I still don't like this. dev->poll() is liable to attempt to
recursively take its own driver lock again internally and we still
deadlock. Have we already seen recursion here? If we do, I think we
need to fix that in drivers. Meanwhile we should just bail here and
maybe set a "something bad happened" flag.

-- 
Mathematics is the supreme nostalgia of our time.
