Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270626AbUJUCkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270626AbUJUCkR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 22:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270629AbUJUC3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 22:29:13 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:1189 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S270608AbUJUC0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 22:26:45 -0400
Date: Wed, 20 Oct 2004 19:26:30 -0700
From: Chris Wedgwood <cw@f00f.org>
To: LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: [RFC] add struct hw_interrupt_type->release
Message-ID: <20041021022630.GA320@taniwha.stupidest.org>
References: <20041020023156.GA8597@taniwha.stupidest.org> <20041020130715.GA20287@infradead.org> <20041020023156.GA8597@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020130715.GA20287@infradead.org> <20041020023156.GA8597@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 07:31:56PM -0700, Chris Wedgwood wrote:

> +++ b/kernel/irq/manage.c	2004-10-19 17:47:40 -07:00
> @@ -260,6 +260,7 @@
>  				else
>  					desc->handler->disable(irq);
>  			}
                       ^^^
> +			platform_free_irq_notify(irq, dev_id);
>  			spin_unlock_irqrestore(&desc->lock,flags);
>  			unregister_handler_proc(irq, action);
>  

On Wed, Oct 20, 2004 at 02:07:15PM +0100, Christoph Hellwig wrote:

> This looks rather bogus to me.  What prevents UML from doing it's
> work at the struct hw_interrupt_type level?

the ^^^ marked part reads something like if (!desc->action) { ... }
presumably meaning the shutdown/disable is only done when the very
last user of an interrupt source is removed

UML needs to be notified when *any* user is removed so either need
some way to tell the generic code this or perhaps we could introduce
another op to hw_interrupt_type along the lines of ->release like
this:


===== include/linux/irq.h 1.12 vs edited =====
--- 1.12/include/linux/irq.h	2004-10-18 22:26:45 -07:00
+++ edited/include/linux/irq.h	2004-10-20 19:13:01 -07:00
@@ -47,6 +47,7 @@ struct hw_interrupt_type {
 	void (*ack)(unsigned int irq);
 	void (*end)(unsigned int irq);
 	void (*set_affinity)(unsigned int irq, cpumask_t dest);
+	void (*release)(unsigned int irq, void *dev_id);
 };
 
 typedef struct hw_interrupt_type  hw_irq_controller;
===== kernel/irq/manage.c 1.1 vs edited =====
--- 1.1/kernel/irq/manage.c	2004-10-18 22:26:39 -07:00
+++ edited/kernel/irq/manage.c	2004-10-20 18:55:05 -07:00
@@ -253,6 +253,10 @@ void free_irq(unsigned int irq, void *de
 
 			/* Found it - now remove it from the list of entries */
 			*pp = action->next;
+
+			if (desc->handler->release)
+				desc->handler->release(irq, dev_id);
+
 			if (!desc->action) {
 				desc->status |= IRQ_DISABLED;
 				if (desc->handler->shutdown)


