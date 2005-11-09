Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030488AbVKIBE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030488AbVKIBE5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 20:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030493AbVKIBE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 20:04:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31419 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030488AbVKIBEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 20:04:55 -0500
Date: Tue, 8 Nov 2005 17:04:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Posssible bug in kernel/irq/handle.c
In-Reply-To: <1131496739.24637.12.camel@gaston>
Message-ID: <Pine.LNX.4.64.0511081651320.3247@g5.osdl.org>
References: <1131496739.24637.12.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Nov 2005, Benjamin Herrenschmidt wrote:
> 
> Now, look at what's going on if there is no action, that is desc->action
> is NULL. In that case, the code will go out, leaving the IRQ marked
> IN_PROGRESS, call the end() handler and go out without ever calling
> note_interrupt().

Not a bug afaik.

> That means that
> 
>  1) The interrupt will be stuck IN_PROGRESS. I don't see how IN_PROGRESS
> can ever be cleared afterward

If desc->action is NULL, the flags are supposed to be cleared when we get 
an action. See kernel/irq/manage.c: setup_irq(), and in particular the 
case where we had no handler before (ie the "!shared" case).

>  2) We won't go through the code in note_interrupt() that protects us
> against a stuck interrupt, so if the interrupt is indeed stuck, we'll
> just lockup the processor taking the same IRQ for ever (and not being
> able to handle it, even if an action magically gets registered, due to
> 1)

If the irq is stuck, you have serious problems with your interrupt 
controller. By definition, the irq should be disabled since there are no 
handlers for that interrupt.

So I think the code is correct. It has certainly worked for years on x86 
(and it got serious debugging, since we had some rather nasty and subtle 
issues with edge-triggered APIC interrupts that just get lost if they are 
disabled at the controller).

			Linus
