Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751874AbWCVAxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbWCVAxH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 19:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbWCVAxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 19:53:07 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:13036 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751874AbWCVAxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 19:53:06 -0500
Date: Tue, 21 Mar 2006 18:52:54 -0600
From: Dimitri Sivanich <sivanich@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, clameter@sgi.com,
       jes@sgi.com
Subject: Re: [PATCH] Add SA_PERCPU_IRQ flag support
Message-ID: <20060322005254.GA32379@sgi.com>
References: <20060321213803.GC26124@sgi.com> <20060321153747.79f18016.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060321153747.79f18016.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 03:37:47PM -0800, Andrew Morton wrote:
> hm.  Last time around I pointed out that we should be checking that all
> handlers for this IRQ agree about the percpuness.  What happened to
> that?

I believe this version has what you are looking for.

Signed-off-by: Dimitri Sivanich <sivanich@sgi.com>

Index: linux-2.6.15/kernel/irq/manage.c
===================================================================
--- linux-2.6.15.orig/kernel/irq/manage.c	2006-03-20 13:11:01.766522017 -0600
+++ linux-2.6.15/kernel/irq/manage.c	2006-03-21 18:44:52.297990979 -0600
@@ -209,10 +209,14 @@ int setup_irq(unsigned int irq, struct i
 	p = &desc->action;
 	if ((old = *p) != NULL) {
 		/* Can't share interrupts unless both agree to */
-		if (!(old->flags & new->flags & SA_SHIRQ)) {
-			spin_unlock_irqrestore(&desc->lock,flags);
-			return -EBUSY;
-		}
+		if (!(old->flags & new->flags & SA_SHIRQ))
+			goto mismatch;
+
+#if defined(ARCH_HAS_IRQ_PER_CPU) && defined(SA_PERCPU_IRQ)
+		/* All handlers must agree on per-cpuness */
+		if ((old->flags & IRQ_PER_CPU) != (new->flags & IRQ_PER_CPU))
+			goto mismatch;
+#endif
 
 		/* add new interrupt at end of irq queue */
 		do {
@@ -223,7 +227,10 @@ int setup_irq(unsigned int irq, struct i
 	}
 
 	*p = new;
-
+#if defined(ARCH_HAS_IRQ_PER_CPU) && defined(SA_PERCPU_IRQ)
+	if (new->flags & SA_PERCPU_IRQ)
+		desc->status |= IRQ_PER_CPU;
+#endif
 	if (!shared) {
 		desc->depth = 0;
 		desc->status &= ~(IRQ_DISABLED | IRQ_AUTODETECT |
@@ -241,6 +248,12 @@ int setup_irq(unsigned int irq, struct i
 	register_handler_proc(irq, new);
 
 	return 0;
+
+mismatch:
+	spin_unlock_irqrestore(&desc->lock, flags);
+	printk(KERN_ERR "%s: irq handler mismatch\n", __FUNCTION__);
+	dump_stack();
+	return -EBUSY;
 }
 
 /*
