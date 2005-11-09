Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbVKIBvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbVKIBvg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 20:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbVKIBvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 20:51:36 -0500
Received: from gate.crashing.org ([63.228.1.57]:42909 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964987AbVKIBvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 20:51:36 -0500
Subject: Re: Posssible bug in kernel/irq/handle.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0511081651320.3247@g5.osdl.org>
References: <1131496739.24637.12.camel@gaston>
	 <Pine.LNX.4.64.0511081651320.3247@g5.osdl.org>
Content-Type: text/plain
Date: Wed, 09 Nov 2005 12:50:21 +1100
Message-Id: <1131501021.24637.18.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 17:04 -0800, Linus Torvalds wrote:

> >  1) The interrupt will be stuck IN_PROGRESS. I don't see how IN_PROGRESS
> > can ever be cleared afterward
> 
> If desc->action is NULL, the flags are supposed to be cleared when we get 
> an action. See kernel/irq/manage.c: setup_irq(), and in particular the 
> case where we had no handler before (ie the "!shared" case).

Yes, but in the meantime, the CPU will be stuck taking the same irq for
ever without ever going through note_interrupt().

> >  2) We won't go through the code in note_interrupt() that protects us
> > against a stuck interrupt, so if the interrupt is indeed stuck, we'll
> > just lockup the processor taking the same IRQ for ever (and not being
> > able to handle it, even if an action magically gets registered, due to
> > 1)
> 
> If the irq is stuck, you have serious problems with your interrupt 
> controller. By definition, the irq should be disabled since there are no 
> handlers for that interrupt.

Hrm... yah, it should... still, I find that a bit fragile.

> So I think the code is correct. It has certainly worked for years on x86 
> (and it got serious debugging, since we had some rather nasty and subtle 
> issues with edge-triggered APIC interrupts that just get lost if they are 
> disabled at the controller).

Well, we have a "funny" case with some pSeries... the firmware may
enable interrupts behind our back, and expects us to call a firmware
"try to handle that interrupt" kind of call when we get one we don't
handle. That is, either all the handlers returned IRQ_NONE or there is
no action. I'm not sure how to do that with the current code without
having our own __do_IRQ() which I'd rather avoid...

Ben.


