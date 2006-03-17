Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWCQXYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWCQXYe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 18:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWCQXYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 18:24:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51598 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751157AbWCQXYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 18:24:32 -0500
Date: Fri, 17 Mar 2006 15:26:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dimitri Sivanich <sivanich@sgi.com>
Cc: torvalds@osdl.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, clameter@sgi.com,
       jes@sgi.com
Subject: Re: [PATCH] Add SA_PERCPU_IRQ flag support
Message-Id: <20060317152645.52112021.akpm@osdl.org>
In-Reply-To: <20060317003114.GA1735@sgi.com>
References: <20060317003114.GA1735@sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitri Sivanich <sivanich@sgi.com> wrote:
>
> he generic request_irq/setup_irq code should support the SA_PERCPU_IRQ flag.
> 
> Not sure why it was left out, but this patch adds that support.
> 
> Signed-off-by: Dimitri Sivanich <sivanich@sgi.com>
> 
> Index: linux/kernel/irq/manage.c
> ===================================================================
> --- linux.orig/kernel/irq/manage.c	2006-03-16 14:05:27.957927445 -0600
> +++ linux/kernel/irq/manage.c	2006-03-16 14:06:02.283661867 -0600
> @@ -201,6 +201,9 @@ int setup_irq(unsigned int irq, struct i
>  	 * The following block of code has to be executed atomically
>  	 */
>  	spin_lock_irqsave(&desc->lock,flags);
> +	if (new->flags & SA_PERCPU_IRQ) {
> +		desc->status |= IRQ_PER_CPU;
> +	}
>  	p = &desc->action;
>  	if ((old = *p) != NULL) {
>  		/* Can't share interrupts unless both agree to */

Yes, we're presently going in and needlessly taking desc->lock on every
cpu-local interrupt.  However it only appears to affect mmtimer.c at
present.

Shouldn't we also have a check in there, to make sure that all the other
handlers off this IRQ agree about the per-cpuness of this interrupt?

Your patch broke the x86 build, btw..


From: Dimitri Sivanich <sivanich@sgi.com>

The generic request_irq/setup_irq code should support the SA_PERCPU_IRQ flag.

Also, check that all handlers agree to do per-cpu IRQs.

Signed-off-by: Dimitri Sivanich <sivanich@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 kernel/irq/manage.c |   23 +++++++++++++++++++----
 1 files changed, 19 insertions(+), 4 deletions(-)

diff -puN kernel/irq/manage.c~generic-irq-add-sa_percpu_irq-flag-support kernel/irq/manage.c
--- 25/kernel/irq/manage.c~generic-irq-add-sa_percpu_irq-flag-support	Fri Mar 17 15:06:44 2006
+++ 25-akpm/kernel/irq/manage.c	Fri Mar 17 15:23:02 2006
@@ -204,10 +204,14 @@ int setup_irq(unsigned int irq, struct i
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
+#ifdef ARCH_HAS_IRQ_PER_CPU
+		/* All handlers must agree on per-cpuness */
+		if ((old->flags & IRQ_PER_CPU) != (new->flags & IRQ_PER_CPU))
+			goto mismatch;
+#endif
 
 		/* add new interrupt at end of irq queue */
 		do {
@@ -219,6 +223,11 @@ int setup_irq(unsigned int irq, struct i
 
 	*p = new;
 
+#ifdef ARCH_HAS_IRQ_PER_CPU
+	if (new->flags & SA_PERCPU_IRQ)
+		desc->status |= IRQ_PER_CPU;
+#endif
+
 	if (!shared) {
 		desc->depth = 0;
 		desc->status &= ~(IRQ_DISABLED | IRQ_AUTODETECT |
@@ -236,6 +245,12 @@ int setup_irq(unsigned int irq, struct i
 	register_handler_proc(irq, new);
 
 	return 0;
+
+mismatch:
+	spin_unlock_irqrestore(&desc->lock, flags);
+	printk(KERN_ERR "%s: irq handler mismatch\n", __FUNCTION__);
+	dump_stack();
+	return -EBUSY;
 }
 
 #ifdef CONFIG_DEBUG_SHIRQ
_

