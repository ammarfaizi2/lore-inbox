Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbTJIQBs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 12:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbTJIQBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 12:01:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:18658 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261235AbTJIQBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 12:01:46 -0400
Date: Thu, 9 Oct 2003 09:01:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [RFC] disable_irq()/enable_irq() semantics and ide-probe.c
In-Reply-To: <20031009154641.GB7665@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0310090851390.10041-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 9 Oct 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
>
> IOW, the question is: do we want enable_irq() to undo all effects of
> disable_irq()?  Whether the current behaviour is intentional or not,
> it's worth documenting, IMO...

I think yes, it would be clean to make enable_irq() clean up properly. 
That includes clearing the IRQ_INPROGRESS bit along with the IRQ_DISABLED 
but. It won't even make the codepath longer, it just changes a constant.

And yes, I think we should just remove the clearing of depth in 
setup_irq(), _and_ make the enabling of the irq be dependent on depth 
being non-zero.

In 2.6.x terms, we'd like to go towards something like the appended, but 
this actually has a _different_ problem: we have separate "->startup()" vs 
"->enable()" functions for the irq controller, and this means that if the 
interrupt was disabled when the first irq handler was requested, 
"->startup()" wouldn't be called at all.

So my suggestion would be:
 - do the IRQ_INPROGRESS clearing (safe, since disable_irq() will have 
   waited for it if it was valid)
 - leave the depth reset as-is for now, and think about how we'd like to 
   solve it.
 - make the synchronize_irq() conditional in irq_disable() (2.6.x now
   already does that part, so it's not in the patch)

Hmm?

		Linus

----
--- 1.43/arch/i386/kernel/irq.c	Wed Oct  8 20:47:36 2003
+++ edited/arch/i386/kernel/irq.c	Thu Oct  9 08:55:54 2003
@@ -380,7 +380,7 @@
 	spin_lock_irqsave(&desc->lock, flags);
 	switch (desc->depth) {
 	case 1: {
-		unsigned int status = desc->status & ~IRQ_DISABLED;
+		unsigned int status = desc->status & ~(IRQ_DISABLED | IRQ_INPROGRESS);
 		desc->status = status;
 		if ((status & (IRQ_PENDING | IRQ_REPLAY)) == IRQ_PENDING) {
 			desc->status = status | IRQ_REPLAY;
@@ -884,8 +884,7 @@
 
 	*p = new;
 
-	if (!shared) {
-		desc->depth = 0;
+	if (!shared && !desc->depth) {
 		desc->status &= ~(IRQ_DISABLED | IRQ_AUTODETECT | IRQ_WAITING | IRQ_INPROGRESS);
 		desc->handler->startup(irq);
 	}

