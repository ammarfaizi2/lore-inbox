Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVGKOh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVGKOh4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 10:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVGKOfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:35:19 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:8618 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261881AbVGKOex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 10:34:53 -0400
Message-ID: <42D285CD.CF9389F8@tv-sign.ru>
Date: Mon, 11 Jul 2005 18:44:29 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC][PATCH] i386: Per node IDT
References: <42D26604.66A75939@tv-sign.ru> <Pine.LNX.4.61.0507110747480.16055@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Zwane,

Zwane Mwaikambo wrote:
>
> > On Mon, 11 Jul 2005, Oleg Nesterov wrote:
> >
> > Could you explain this change? I think it breaks do_signal/handle_signal,
> > they check orig_eax >= 0 to handle -ERESTARTSYS:
> >
> > 	/* Are we from a system call? */
> > 	if (regs->orig_eax >= 0) {
> > 		/* If so, check system call restarting.. */
> > 		switch (regs->eax) {
> > 		        case -ERESTART_RESTARTBLOCK:
> > 			case -ERESTARTNOHAND:
>
> The change is so that we can send IRQs higher than 256 to do_IRQ. That 
> looks like it tries to check if we came in via system_call since we'd save 
> the system call number as orig_eax. Now that i think about it, doesn't 
> that path always get taken when we interrupt userspace and have pending 
> signals on return from interrupt?

As far as I can see, we always have orig_eax < 0 on interrupt, because

irq_entries_start:
	pushl $vector-256	<-----  orig_eax
	jmp common_interrupt

and NR_IRQS < 256. So if we have pending signals on return from interrupt,
do_signal() will not corrupt userspace registers when regs->eax == -ERESTART...
accidentally.

Probably it makes sense to change it to
	pushl $vector - 0xFFFF - 1

and in do_IRQ()
	int irq = regs->orig_eax & 0xFFFF

if you need to send IRQs higher than 256 to do_IRQ.

Oleg.
