Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266574AbUHBP61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266574AbUHBP61 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 11:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266578AbUHBP61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 11:58:27 -0400
Received: from ozlabs.org ([203.10.76.45]:46226 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266574AbUHBP5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 11:57:45 -0400
Date: Tue, 3 Aug 2004 01:54:42 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org, pazke@donpac.ru
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: Moving per-arch IRQ handling code into common directories
Message-ID: <20040802155442.GM30253@krispykreme>
References: <16602.9814.700745.300562@wombat.chubb.wattle.id.au> <20040711110919.GI5232@krispykreme> <20040712045916.GD13803@pazke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040712045916.GD13803@pazke>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> No, it almost died because of lack of time to track changes in so many
> architectures. BTW can you take a look at attached patch, which removes
> do_free_irq() crap from ppc64 irq handling code ?

Thanks, looks good.

Anton

--

From: Andrey Panin <pazke@donpac.ru>

Fix ppc64 free_irq.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -urpN -X /usr/share/dontdiff linux-2.6.7.vanilla/arch/ppc64/kernel/irq.c linux-2.6.7-ppc64/arch/ppc64/kernel/irq.c
--- linux-2.6.7.vanilla/arch/ppc64/kernel/irq.c	Sat May 22 14:58:15 2004
+++ linux-2.6.7-ppc64/arch/ppc64/kernel/irq.c	Sat May 22 19:58:35 2004
@@ -143,47 +143,6 @@ EXPORT_SYMBOL(synchronize_irq);
 
 #endif /* CONFIG_SMP */
 
-/* XXX Make this into free_irq() - Anton */
-
-/* This could be promoted to a real free_irq() ... */
-static int
-do_free_irq(int irq, void* dev_id)
-{
-	irq_desc_t *desc = get_irq_desc(irq);
-	struct irqaction **p;
-	unsigned long flags;
-
-	spin_lock_irqsave(&desc->lock,flags);
-	p = &desc->action;
-	for (;;) {
-		struct irqaction * action = *p;
-		if (action) {
-			struct irqaction **pp = p;
-			p = &action->next;
-			if (action->dev_id != dev_id)
-				continue;
-
-			/* Found it - now remove it from the list of entries */
-			*pp = action->next;
-			if (!desc->action) {
-				desc->status |= IRQ_DISABLED;
-				mask_irq(irq);
-			}
-			spin_unlock_irqrestore(&desc->lock,flags);
-
-			/* Wait to make sure it's not being used on another CPU */
-			synchronize_irq(irq);
-			kfree(action);
-			return 0;
-		}
-		printk("Trying to free free IRQ%d\n",irq);
-		spin_unlock_irqrestore(&desc->lock,flags);
-		break;
-	}
-	return -ENOENT;
-}
-
-
 int request_irq(unsigned int irq,
 	irqreturn_t (*handler)(int, void *, struct pt_regs *),
 	unsigned long irqflags, const char * devname, void *dev_id)
@@ -194,8 +153,7 @@ int request_irq(unsigned int irq,
 	if (irq >= NR_IRQS)
 		return -EINVAL;
 	if (!handler)
-		/* We could implement really free_irq() instead of that... */
-		return do_free_irq(irq, dev_id);
+		return -EINVAL;
 
 	action = (struct irqaction *)
 		kmalloc(sizeof(struct irqaction), GFP_KERNEL);
@@ -222,7 +180,38 @@ EXPORT_SYMBOL(request_irq);
 
 void free_irq(unsigned int irq, void *dev_id)
 {
-	request_irq(irq, NULL, 0, NULL, dev_id);
+	irq_desc_t *desc = get_irq_desc(irq);
+	struct irqaction **p;
+	unsigned long flags;
+
+	spin_lock_irqsave(&desc->lock,flags);
+	p = &desc->action;
+	for (;;) {
+		struct irqaction * action = *p;
+		if (action) {
+			struct irqaction **pp = p;
+			p = &action->next;
+			if (action->dev_id != dev_id)
+				continue;
+
+			/* Found it - now remove it from the list of entries */
+			*pp = action->next;
+			if (!desc->action) {
+				desc->status |= IRQ_DISABLED;
+				mask_irq(irq);
+			}
+			spin_unlock_irqrestore(&desc->lock,flags);
+
+			/* Wait to make sure it's not being used on another CPU */
+			synchronize_irq(irq);
+			kfree(action);
+			return;
+		}
+		printk("Trying to free free IRQ%d\n",irq);
+		spin_unlock_irqrestore(&desc->lock,flags);
+		break;
+	}
+	return;
 }
 
 EXPORT_SYMBOL(free_irq);
