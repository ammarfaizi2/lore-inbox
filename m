Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263553AbTJWLal (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 07:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263556AbTJWLal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 07:30:41 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:27578 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263553AbTJWLae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 07:30:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16279.48084.668213.169062@alkaid.it.uu.se>
Date: Thu, 23 Oct 2003 13:30:28 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "M.H.VanLeeuwen" <vanl@megsinet.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <marcelo.tosatti@cyclades.com>
Subject: Re: [BUG somewhere] 2.6.0-test8 irq.c, IRQ_INPROGRESS ?
In-Reply-To: <Pine.LNX.4.44.0310222021410.3151-100000@home.osdl.org>
References: <3F9748A3.D8B313F8@megsinet.net>
	<Pine.LNX.4.44.0310222021410.3151-100000@home.osdl.org>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
 > On Wed, 22 Oct 2003, M.H.VanLeeuwen wrote:
 > > 
 > > I'm seeing an NMI Watchdog detected LOCKUP go away when I revert this patch
 > > previously added into test8.
 > 
 > Yes, the thing is buggy. 
 > 
 > It's not correct for "disable_irq_nosync()" users, and reverting it is the 
 > right thing to do. Thanks for the report.
 > 
 > Marcelo, please note if you played with this in 2.4.x..
 > 
 > 		Linus
 > 
 > ------
 > > diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
 > > --- a/arch/i386/kernel/irq.c    Fri Oct 17 14:43:50 2003
 > > +++ b/arch/i386/kernel/irq.c    Fri Oct 17 14:43:50 2003
 > > @@ -378,7 +380,7 @@
 > >         spin_lock_irqsave(&desc->lock, flags);
 > >         switch (desc->depth) {
 > >         case 1: {
 > > -               unsigned int status = desc->status & ~IRQ_DISABLED;
 > > +               unsigned int status = desc->status & ~(IRQ_DISABLED | IRQ_INPROGRESS);

It seems 2.4.23-pre8 included something like this apparently broken
change (see diff from -pre7 below). Should it be reverted?

--- linux-2.4.23-pre7/arch/i386/kernel/irq.c	2003-10-23 13:17:43.700067608 +0200
+++ linux-2.4.23-pre8/arch/i386/kernel/irq.c	2003-10-23 13:17:10.071202512 +0200
@@ -1036,7 +1036,7 @@
 
 	if (!shared) {
 		desc->depth = 0;
-		desc->status &= ~(IRQ_DISABLED | IRQ_AUTODETECT | IRQ_WAITING);
+		desc->status &= ~(IRQ_DISABLED | IRQ_AUTODETECT | IRQ_WAITING | IRQ_INPROGRESS);
 		desc->handler->startup(irq);
 	}
 	spin_unlock_irqrestore(&desc->lock,flags);
