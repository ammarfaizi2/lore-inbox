Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbTJIQ5f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 12:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbTJIQ5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 12:57:35 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:24242 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262330AbTJIQ51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 12:57:27 -0400
Subject: Re: [RFC] disable_irq()/enable_irq() semantics and ide-probe.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <3F858EF8.5080105@pobox.com>
References: <3F858885.1070202@colorfullife.com> <3F858EF8.5080105@pobox.com>
Content-Type: text/plain
Message-Id: <1065718629.663.3.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 09 Oct 2003 18:57:10 +0200
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-09 at 18:38, Jeff Garzik wrote:
> Manfred Spraul wrote:
> > I'd like to use that for nic shutdown for natsemi:
> > 
> >    disable_irq();
> >    shutdown_nic();
> >    free_irq();
> >    enable_irq();
> 
> 
> Why not just shutdown the NIC inside spin_lock_irqsave or disable_irq, 
> and then free_irq separately?
> 
> If you can't stop the NIC hardware from generating interrupts, that's a 
> driver bug.  And if the driver cannot handle its interrupt handler 
> between the spin_unlock_irqrestore() and free_irq() (shared irq case), 
> it's also buggy.

Actually you may still get a stale irq ;) The problem is that IRQs are
typically an asynchronous event, and an irq can be sort of "queued" up
(especially if it's a level one) in the PIC... though at least this
won't be a stale level irq so you won't deadlock in an irq handler that
can do nothing...

Anyway, I quite like the idea. I've been trying to avoid taking a lock
in some similar shutdown routine for sungem, because some bits in there
need a few ms delay to workaround a chip bug (or machine sleep will
break) and I want to schedule. Breaking the lock makes things ugly,
beeing able to just disable_irq before/after is nice.

The problem of course is when that irq is shared... you are suddently
shutting off for a potentially long time a neighbour irq, bad bad...
(at least I know that on pmac, sungem irq is never shared).

Ben.
  

