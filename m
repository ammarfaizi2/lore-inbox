Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268672AbUIXKrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268672AbUIXKrm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 06:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268675AbUIXKrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 06:47:42 -0400
Received: from web53505.mail.yahoo.com ([206.190.37.66]:24218 "HELO
	web53505.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268672AbUIXKrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 06:47:36 -0400
Message-ID: <20040924104736.42414.qmail@web53505.mail.yahoo.com>
Date: Fri, 24 Sep 2004 03:47:36 -0700 (PDT)
From: Gaurav Dhiman <gauravd_linux@yahoo.com>
Subject: PROBLEM: Interrupt Handling Code (handle_IRQ_event)
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, alan@lxorguk.ukuu.org.uk,
       gauravd_linux@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

It’s a Bug-Report.
I found a bug in interrupt handling code of Kernel. I
think it is probably a bug.
It’s not a bug, which I encountered while running a
linux box, so I can not provide the output of bug or
how to re-produce it (as suggested in most of the
bug-reporting articles).

I have been analyzing the interrupt handling code of
kernel for i386 platform and found the following,
which I think might be a bug, but at the same time I
also think that kernel developers who actually coded
that segment of kernel code are the right people to
tell me if it’s a bug or not.

Following is the description of it:

- In handle_IRQ_event() function, we are actually
checking the flag of only the first handler for IRQ
line (see the code at :
http://lxr.linux.no/source/arch/i386/kernel/irq.c?v=2.4.21#L430).
Shouldn't we check the flag for each handler
registered for particular IRQ, before invoking that
handler ? As handlers are registered by different
device drivers which can share the IRQ line, they can
be registered as of different types (slow and fast
handlers) for same IRQ.

In 2.4.21 version of kernel, the bug related code in
handle_IRQ_event() function looks like this

	if (!(action->flags & SA_INTERRUPT))
		__sti();

	do {
		status |= action->flags;
		action->handler(irq, action->dev_id, regs);
		action = action->next;
	} while (action); 


If we take the following scenario, above code will not
work as it should work:
- if the first handler in handlers queue for an IRQ is
of slow interrupt type (making the interrupts enable)
and there is any other handler further in the queue
whose flag says that it’s a fast handler (should be
called with interrupt disabled), then in that case,
while calling the first handler, above code will
enable the interrupts and when the fast interrupt
handler further in queue will be called the interrupts
will still be enabled, where as it should be disabled
while calling a fast interrupt.

I think the solution of this would be that, before
calling a handler, we should check the flag of that
handler. If flag says it’s a fast handler, we should
disable the interrupts using __cli(), but if the flag
says it's a slow handler, we should enable interrupts
using __sti() function.

I think the correct code should be somewhat like the
following one:

	do {
		if (!(action->flags & SA_INTERRUPT))
			__sti();
		else
			__cli();

		status |= action->flags;
		action->handler(irq, action->dev_id, regs);
		action = action->next;
	} while (action);

I even checked the latest kernel version 2.6.8.1,
things are same there, so if it is a bug, we need to
fix it. I don’t know if this bug is harmful in some
manner or just a sleeping bug, which does not affect
the kernel functionality.

I think for resolving this problem, my machine
information will be irrelevant as I did not
encountered this bug while running my linux machine,
so I am not sending the machine specific information.
If you still need it, please do let me know, I will
provide it.

Please comment on this, what I observed is a bug or
not ? If it is a bug, please do let me know how to
take the responsibility of bug-fixing as I would like
to provide the fix for it.

At last, please do let me know one more thing, how can
I track the chain of mails for this bug on
linux-kernel@vger.kernel.org without subscribing it. I
have not subscribed to this mailing list as I know
it’s a heavy mailing list. Please let me know the way
to track all replies to this mail without subscribing
the kernel mailing list.
 
Regards,
Gaurav



		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
