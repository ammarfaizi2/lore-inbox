Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269028AbUIXSSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269028AbUIXSSj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 14:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269014AbUIXSRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 14:17:43 -0400
Received: from [155.35.46.20] ([155.35.46.20]:12365 "EHLO mail18.ca.com")
	by vger.kernel.org with ESMTP id S269072AbUIXSPu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 14:15:50 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6547.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Re: PROBLEM: Interrupt Handling Code (handle_IRQ_event)
Date: Fri, 24 Sep 2004 23:45:41 +0530
Message-ID: <577528CFDFEFA643B3324B88812B57FE28EBCC@inhyms21.ca.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PROBLEM: Interrupt Handling Code (handle_IRQ_event)
Thread-Index: AcSiVywoFLSSAutbQMqKC4pZ92iQMwAAGmNQ
From: "Dhiman, Gaurav" <Gaurav.Dhiman@ca.com>
To: <ar.karthick@veritas.com>, <linux-kernel@vger.kernel.org>
Cc: "Dhiman, Gaurav" <Gaurav.Dhiman@ca.com>, <gauravd_linux@yahoo.com>
X-OriginalArrivalTime: 24 Sep 2004 18:15:41.0408 (UTC) FILETIME=[802C0600:01C4A262]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-----Original Message-----
From: Gaurav Dhiman [mailto:gauravd_linux@yahoo.com] 
Sent: Friday, September 24, 2004 10:24 PM
To: Dhiman, Gaurav
Subject: Fwd: Re: PROBLEM: Interrupt Handling Code (handle_IRQ_event)


--- ar.karthick@veritas.com wrote:

> Date: Fri, 24 Sep 2004 20:58:51 +0530 (IST)
> From: ar.karthick@veritas.com
> To: Gaurav Dhiman <gauravd_linux@yahoo.com>
> Subject: Re: PROBLEM: Interrupt Handling Code
> (handle_IRQ_event)
> 
> >
> > Hi All,
> >
> > It's a Bug-Report.
> > I found a bug in interrupt handling code of
> Kernel. I
> > think it is probably a bug.
> > It's not a bug, which I encountered while running
> a
> > linux box, so I can not provide the output of bug
> or
> > how to re-produce it (as suggested in most of the
> > bug-reporting articles).
> > 	do {
> > 		if (!(action->flags & SA_INTERRUPT))
> >                      __sti();
> > 		else
> > 			__cli();
> >
> > 		status |= action->flags;
> > 		action->handler(irq, action->dev_id, regs);
> > 		action = action->next;
> > 	} while (action);
> >
>   I dont think its a _bug_.
>   Its a win for a non-shared IRQ line.
>   You can get an IRQ for only 1 driver at a time.
>   But the handle_IRQ_event doesnt know the intended
> destination or
>   the action->handler.
>   So for a shared IRQ line, it tries calling all the
> registered IRQ 
> handlers 1 at a time, and its the job of the
> individual handlers to see if 
> its intended for them.
>   Your fix would add an additional overhead on the
> fast-path by
>   checking each action handler to disable/enable
> interrupt line
>   even though that handler wouldnt be actually
> handling the interrupt line.
>   You will end up doing redundant cli/stis on all
> the action->handler, 
> even though only 1 guy is going to handle the
> interrupt.
>   Its an overhead incurred on the fast-path which is
> a waste of 
> time,considering that you actually dont know till
> the "handler" returns, 
> as to who has handled the IRQ.
> 
>   Regards,
>   -Karthick
> -- 
> A.R.Karthick
> Veritas Software,
> Bund Garden Road,
> Next to Ruby Hall Clinic,
> Pune-411001
> India
> Tel: Office: 020 - 406 6905 (Direct)
> Home: http://mir-os.sourceforge.net
> 


I don't think it's a right way to handle interrupts. You are saying that
we should allow the handler to decide if it wants to disable the
interrupts or not, but then can you tell me the use of telling kernel
about our handler type (slow or fast) while registering our handler to
kernel using flag parameter in request_irq() function.

I think the main purpose of passing this flag parameter (third
parameter) in request_irq() function is that the kernel code can disable
or enable the interrupts (as per our flag passed) before invoking our
handler. If it's an handler itself who has to decide, then there is no
use of passing this flag parameter.

Moreover if it is the case as you stated then we should not even check
the type of first handler, which we are doing in current kernel code.
First handler should also be able to decide if it wants the interrupts
to be enabled or disabled according to its own requirement.

I raised the same issue on kernelnewbies mailing list also and got
majority of responses that it might be a bug. Some guys told that it
might be a left over bug, as in earlier versions kernel used to allow
only one type of handlers to share an IRQ line, so at that time only
checking the type of first handler used to do our work (as handlers used
to be of same type), but now as different types of handlers can share a
same IRQ line, so we need to check the type of handler before invoking
it.

Moreover as explained in Interrupt handling chapter of Linux Device
Driver (LDD) book (http://www.xml.com/ldd/chapter/book/ch09.html#t3)
under section "The internals of interrupt handling on the x86", it
handle_IRQ_event() function which actually take care of enabling and
disabling the interrupts rather than the handler itself. Following is
the text from LDD book.

"The function handle_IRQ_event is called to actually invoke the
handlers. It starts by testing a global interrupt lock bit; if that bit
is set, the processor will spin until it is cleared. Calling cli sets
this bit, thus blocking handling of interrupts; the normal interrupt
handling mechanism does not set this bit, and thus allows further
processing of interrupts. If the handler is of the slow variety,
interrupts are reenabled in the hardware and the handler is invoked.
Then it's just a matter of cleaning up, running tasklets and bottom
halves, and getting back to regular work"


Regards,
Gaurav Dhiman.
_____________________________
Thanks & Regards,
Gaurav Dhiman
Computer Associates - ITC,
eTrust Security Solutions
Hyderabad, India
Mobile: +91-040-32384853
Direct Tel: +91-40-55670911
Website: www.ca.com
E-Mail: Gaurav.Dhiman@ca.com
_____________________________

