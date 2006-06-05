Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932360AbWFEBFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWFEBFS (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 21:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWFEBFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 21:05:17 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:62381 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932363AbWFEBFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 21:05:14 -0400
Subject: Re: [patch, -rc5-mm1] locking validator: special rule: 8390.c
	disable_irq()
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Arjan van de Ven <arjan@infradead.org>, Alan Cox <alan@redhat.com>,
        Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060604214448.GA6602@elte.hu>
References: <1149112582.3114.91.camel@laptopd505.fenrus.org>
	 <1149345421.13993.81.camel@localhost.localdomain>
	 <20060603215323.GA13077@devserv.devel.redhat.com>
	 <1149374090.14408.4.camel@localhost.localdomain>
	 <1149413649.3109.92.camel@laptopd505.fenrus.org>
	 <1149426961.27696.7.camel@localhost.localdomain>
	 <1149437412.23209.3.camel@localhost.localdomain>
	 <1149438131.29652.5.camel@localhost.localdomain>
	 <1149456375.23209.13.camel@localhost.localdomain>
	 <1149456532.29652.29.camel@localhost.localdomain>
	 <20060604214448.GA6602@elte.hu>
Content-Type: text/plain
Date: Sun, 04 Jun 2006 21:04:34 -0400
Message-Id: <1149469474.29652.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-04 at 23:44 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Sun, 2006-06-04 at 22:26 +0100, Alan Cox wrote:
> > > Ar Sul, 2006-06-04 am 12:22 -0400, ysgrifennodd Steven Rostedt:
> > > > But can't this machine still cause an interrupt storm if the interrupt
> > > > comes on a wrong line, and we don't call the handler for the interrupt
> > > > source because we are now honoring disable_irq?
> > > 
> > > Yes - that is why we can't honour disable_irq in this case but have to
> > > hope 8)
> > > 
> > 
> > Hmm, maybe this can be solved with something like what the -rt patch 
> > does with threading interrupts and the interrupt mask.  I'm not 
> > suggesting threading interrupts.  But, if the misrouted irq comes 
> > across a disabled_irq, that it sets some flag, and doesn't unmask the 
> > interrupt when finished.  Have enable_irq see the flag and have it 
> > unmask the interrupt if it is safe to do so.
> > 
> > This all may be pretty hacky, but it's trying to fix code for hardware 
> > that is already hacky.  Note, that this would need to be compiled in 
> > as on option to actually implement any of this crap.
> 
> no ... lets not mix threaded IRQs in here. The model of executing an 
> interrupt handler has nothing to do with the irq flow itself. Whatever 
> can be done with a threaded handler can be done via atomic ISRs too.

I wasn't suggesting threading the handler.  But to use the technique
that threaded handlers use.  That is to postpone the unmasking of the
interrupt until a later time. Sorry to not make that point clearer.

> 
> pretty much the only correct solution seems to be to go with Arjan's 
> suggestion and make the 'disabled' property per-action, instead of the 
> current per-desc thing. (obviously the physical act of masking an 
> interrupt line is fundamentally per-desc, but the act of running an 
> action "behind the back" of a masked line is still OK.) Unfortunately 
> this would also mean the manual conversion of 300+ places that use 
> disable_irq()/enable_irq() currently ... so it's no small work. (and the 
> hardest part of the work is to find a safe method to convert them 
> without introducing bugs)

I don't think that solves the problem.  Even if you disable at the
handler level, and that handler happened to cause an interrupt that is
level sensitive and needs the driver to disarm it, the problem returns.
So if disable_irq_handler disabled the handler and the interrupt, but
then this interrupt happened to come in on another line what happens?
If you decide to skip this handler because it was labeled "don't touch
me", we will again get the interrupt storm because as soon as you return
from the interrupt handler from the misrouted irq, it will be triggered
again!

So what I'm suggesting, is that we flag the case that a handler (or the
irq in general) is disabled when a misrouted irq is performed.  If the
irq was not covered by an interrupt handler, and there was a skipped
handler due to disable_irq, we then don't unmask the irq on return from
the interrupt but instead flag it.  Now when the irq is reenabled, the
flag is checked and if it wasn't handled already, we call the handler
then.

Actually this means that we really don't need the use of the
disable_irq_handler. We keep all the code with the interrupt part, and
we can do the accounting there.

Understand where I'm getting at?  By skipping a handler you risk having
an interrupt storm anyway.  But my idea is to have accounting to handle
disabled_irqs and only unmask the irq if it was handled and we didn't
skip any handlers due to disable_irq.  That way we can push the work
into enable_irq and avoid modifying 300+ calls to disable_irq not to
mention enable_irq as well.

I'd do a patch to show what I mean, but you will have to wait a week and
a half. I'll be traveling again, and wont be able to work on it until
then (unless I can squeeze some time tomorrow ;)

-- Steve

