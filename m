Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030474AbVKIAkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030474AbVKIAkM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 19:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbVKIAkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 19:40:12 -0500
Received: from gate.crashing.org ([63.228.1.57]:63644 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030474AbVKIAkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 19:40:10 -0500
Subject: Posssible bug in kernel/irq/handle.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>
Cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 09 Nov 2005 11:38:59 +1100
Message-Id: <1131496739.24637.12.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, Linus !

We were going through __do_IRQ (trying to figure out if we can use it
instead of keeping our own in ppc64) while we found that bit that seems
bogus to me:

	/*
	 * If the IRQ is disabled for whatever reason, we cannot
	 * use the action we have.
	 */
	action = NULL;
	if (likely(!(status & (IRQ_DISABLED | IRQ_INPROGRESS)))) {
		action = desc->action;
		status &= ~IRQ_PENDING; /* we commit to handling */
		status |= IRQ_INPROGRESS; /* we are handling it */
	}
	desc->status = status;

	/*
	 * If there is no IRQ handler or it was disabled, exit early.
	 * Since we set PENDING, if another processor is handling
	 * a different instance of this same irq, the other processor
	 * will take care of it.
	 */
	if (unlikely(!action))
		goto out;

Now, look at what's going on if there is no action, that is desc->action
is NULL. In that case, the code will go out, leaving the IRQ marked
IN_PROGRESS, call the end() handler and go out without ever calling
note_interrupt().

That means that

 1) The interrupt will be stuck IN_PROGRESS. I don't see how IN_PROGRESS
can ever be cleared afterward

 2) We won't go through the code in note_interrupt() that protects us
against a stuck interrupt, so if the interrupt is indeed stuck, we'll
just lockup the processor taking the same IRQ for ever (and not being
able to handle it, even if an action magically gets registered, due to
1)

I think we need to differentiate the case DISABLED | IN_PROGRESS from
the case no action.

Something like (just typing in the mailer) :

	if (unlikely(status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
		desc->status = status;
		goto out;
	}
	action = desc->action;
	status &= ~IRQ_PENDING; /* we commit to handling */
	status |= IRQ_INPROGRESS; /* we are handling it */
	desc->status = status;

Then, test for action != NULL in the for (;;) loop before calling
handle_IRQ_event() and set action_ret to IRQ_NONE by default. (I think
we should get to the for loop and not avoid it, in case the PENDING bit
happens to be set by another CPU in the meantime).

Did I miss something ? If you think that's ok, I'll produce a patch.

In addition, I'd like an arch hook in note_interrupt() in order to pass
unhandled interrupts to the firmware but that's a different matter (still
let me know if you have any objection)

Cheers,
Ben.


