Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWEaUIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWEaUIm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 16:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWEaUIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 16:08:42 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:64445 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932405AbWEaUIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 16:08:41 -0400
Date: Wed, 31 May 2006 22:09:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: [patch, -rc5-mm1] locking validator: special rule: 3c59x.c disable_irq()
Message-ID: <20060531200900.GA32482@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5684]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: locking validator: special rule: 3c59x.c disable_irq()
From: Ingo Molnar <mingo@elte.hu>

3c59x.c's vortex_timer() function knows that vp->lock can only be used
by an irq context that it disabled - and can hence take the vp->lock
without disabling hardirqs. Teach lockdep about this.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/net/3c59x.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/drivers/net/3c59x.c
===================================================================
--- linux.orig/drivers/net/3c59x.c
+++ linux/drivers/net/3c59x.c
@@ -1904,7 +1904,7 @@ vortex_timer(unsigned long data)
 		printk(KERN_DEBUG "dev->watchdog_timeo=%d\n", dev->watchdog_timeo);
 	}
 
-	disable_irq(dev->irq);
+	disable_irq_lockdep(dev->irq);
 	old_window = ioread16(ioaddr + EL3_CMD) >> 13;
 	EL3WINDOW(4);
 	media_status = ioread16(ioaddr + Wn4_Media);
@@ -1985,7 +1985,7 @@ leave_media_alone:
 			 dev->name, media_tbl[dev->if_port].name);
 
 	EL3WINDOW(old_window);
-	enable_irq(dev->irq);
+	enable_irq_lockdep(dev->irq);
 	mod_timer(&vp->timer, RUN_AT(next_tick));
 	if (vp->deferred)
 		iowrite16(FakeIntr, ioaddr + EL3_CMD);
