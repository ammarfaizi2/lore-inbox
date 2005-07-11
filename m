Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbVGKPEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVGKPEN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 11:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbVGKPB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:01:58 -0400
Received: from fsmlabs.com ([168.103.115.128]:28640 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261908AbVGKPBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:01:11 -0400
Date: Mon, 11 Jul 2005 09:05:42 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC][PATCH] i386: Per node IDT
In-Reply-To: <42D285CD.CF9389F8@tv-sign.ru>
Message-ID: <Pine.LNX.4.61.0507110905070.16055@montezuma.fsmlabs.com>
References: <42D26604.66A75939@tv-sign.ru> <Pine.LNX.4.61.0507110747480.16055@montezuma.fsmlabs.com>
 <42D285CD.CF9389F8@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

On Mon, 11 Jul 2005, Oleg Nesterov wrote:

> > The change is so that we can send IRQs higher than 256 to do_IRQ. That 
> > looks like it tries to check if we came in via system_call since we'd save 
> > the system call number as orig_eax. Now that i think about it, doesn't 
> > that path always get taken when we interrupt userspace and have pending 
> > signals on return from interrupt?
> 
> As far as I can see, we always have orig_eax < 0 on interrupt, because
> 
> irq_entries_start:
> 	pushl $vector-256	<-----  orig_eax
> 	jmp common_interrupt
> 
> and NR_IRQS < 256. So if we have pending signals on return from interrupt,
> do_signal() will not corrupt userspace registers when regs->eax == -ERESTART...
> accidentally.
> 
> Probably it makes sense to change it to
> 	pushl $vector - 0xFFFF - 1
> 
> and in do_IRQ()
> 	int irq = regs->orig_eax & 0xFFFF
> 
> if you need to send IRQs higher than 256 to do_IRQ.

Good catch, thanks i'll change that!

	Zwane

