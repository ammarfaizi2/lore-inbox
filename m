Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266308AbTBXKam>; Mon, 24 Feb 2003 05:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266368AbTBXKal>; Mon, 24 Feb 2003 05:30:41 -0500
Received: from bdpp-p-144-138-18-161.prem.tmns.net.au ([144.138.18.161]:48774
	"EHLO portal.frood.au") by vger.kernel.org with ESMTP
	id <S266308AbTBXKak>; Mon, 24 Feb 2003 05:30:40 -0500
Message-ID: <3E59F611.3020206@bigpond.com>
Date: Mon, 24 Feb 2003 21:38:09 +1100
From: James Harper <james.harper@bigpond.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PATCH to fix irq sharing and SA_INTERRUPT on x86. please review
Content-Type: multipart/mixed;
 boundary="------------000506020201080706070907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000506020201080706070907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

further to my email yesterday (to which i've had no response :) i 
propose the attached patch to arch/i386/kernel/irq.c. it corrects what i 
see as a bug in interrupt handling.

currently if a driver requests SA_INTERRUPT in an interrupt handler, it 
is only called with interrupts disabled if it is the first handler in 
the list.

my patch modifies setup_irq to put any interrupt with SA_INTERRUPT in 
the front of the handler queue (eg before any handlers without the flag).

and also modifies handle_IRQ_event to only enable interrupts when it 
hits the first handler with SA_INTERRUPT not set.

the patch is against 2.5.62 and greatly improves stability on my SMP system.

james


--------------000506020201080706070907
Content-Type: text/plain;
 name="SA_INTERRUPT_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="SA_INTERRUPT_fix.diff"

--- linux/arch/i386/kernel/irq.c	Wed Feb 12 21:36:34 2003
+++ linux.test/arch/i386/kernel/irq.c	Mon Feb 24 21:01:04 2003
@@ -201,11 +201,13 @@
 int handle_IRQ_event(unsigned int irq, struct pt_regs * regs, struct irqaction * action)
 {
 	int status = 1;	/* Force the "do bottom halves" bit */
-
-	if (!(action->flags & SA_INTERRUPT))
-		local_irq_enable();
+	int enabled = SA_INTERRUPT;
 
 	do {
+		if (~action->flags & enabled) {
+			local_irq_enable();
+			enabled = 0;
+		}
 		status |= action->flags;
 		action->handler(irq, action->dev_id, regs);
 		action = action->next;
@@ -761,23 +763,38 @@
 	 * The following block of code has to be executed atomically
 	 */
 	spin_lock_irqsave(&desc->lock,flags);
-	p = &desc->action;
-	if ((old = *p) != NULL) {
-		/* Can't share interrupts unless both agree to */
-		if (!(old->flags & new->flags & SA_SHIRQ)) {
-			spin_unlock_irqrestore(&desc->lock,flags);
-			return -EBUSY;
+	if (new->flags & SA_INTERRUPT) {
+		p = &desc->action;
+		old = *p;
+		/* Add SA_INTERRUPT interrupts to the front of the queue
+		 * 'cos it's faster than adding them in the middle */
+		if (old) {
+			if (!(old->flags & new->flags & SA_SHIRQ)) {
+				spin_unlock_irqrestore(&desc->lock,flags);
+				return -EBUSY;
+			}
+			new->next = old;
+			shared = 1;
 		}
+		*p = new;
+	} else {
+		p = &desc->action;
+		if ((old = *p) != NULL) {
+			/* Can't share interrupts unless both agree to */
+			if (!(old->flags & new->flags & SA_SHIRQ)) {
+				spin_unlock_irqrestore(&desc->lock,flags);
+				return -EBUSY;
+			}
 
-		/* add new interrupt at end of irq queue */
-		do {
-			p = &old->next;
-			old = *p;
-		} while (old);
-		shared = 1;
+			/* add new interrupt at end of irq queue */
+			do {
+				p = &old->next;
+				old = *p;
+			} while (old);
+			shared = 1;
+		}
+		*p = new;
 	}
-
-	*p = new;
 
 	if (!shared) {
 		desc->depth = 0;

--------------000506020201080706070907--

