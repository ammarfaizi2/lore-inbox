Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965142AbWEaUCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142AbWEaUCQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 16:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbWEaUCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 16:02:16 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:13720 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965143AbWEaUCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 16:02:15 -0400
Date: Wed, 31 May 2006 22:02:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: [patch, -rc5-mm1] locking validator: special rule: 8390.c disable_irq()
Message-ID: <20060531200236.GA31619@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

untested on 8390 hardware, but ought to solve the lockdep false 
positive.

-----------------
Subject: locking validator: special rule: 8390.c disable_irq()
From: Ingo Molnar <mingo@elte.hu>

8390.c knows that ei_local->page_lock can only be used by an irq
context that it disabled - and can hence take the ->page_lock
without disabling hardirqs. Teach lockdep about this.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/net/8390.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/drivers/net/8390.c
===================================================================
--- linux.orig/drivers/net/8390.c
+++ linux/drivers/net/8390.c
@@ -249,7 +249,7 @@ void ei_tx_timeout(struct net_device *de
 
 	/* Ugly but a reset can be slow, yet must be protected */
 		
-	disable_irq_nosync(dev->irq);
+	disable_irq_nosync_lockdep(dev->irq);
 	spin_lock(&ei_local->page_lock);
 		
 	/* Try to restart the card.  Perhaps the user has fixed something. */
@@ -257,7 +257,7 @@ void ei_tx_timeout(struct net_device *de
 	NS8390_init(dev, 1);
 		
 	spin_unlock(&ei_local->page_lock);
-	enable_irq(dev->irq);
+	enable_irq_lockdep(dev->irq);
 	netif_wake_queue(dev);
 }
     
