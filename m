Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTHXDFl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 23:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263384AbTHXDFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 23:05:41 -0400
Received: from ns.aratech.co.kr ([61.34.11.200]:28364 "EHLO ns.aratech.co.kr")
	by vger.kernel.org with ESMTP id S262273AbTHXDFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 23:05:32 -0400
Date: Sun, 24 Aug 2003 12:06:51 +0900
From: TeJun Huh <tejun@aratech.co.kr>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org, zwane@linuxpower.ca
Subject: Re: Possible race condition in i386 global_irq_lock handling.
Message-ID: <20030824030651.GA13292@atj.dyndns.org>
References: <3F44FAF3.8020707@colorfullife.com> <20030821172721.GI29612@dualathlon.random> <20030821234824.37497c08.skraw@ithnet.com> <20030822011840.GA14540@atj.dyndns.org> <20030822162546.GQ29612@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030822162546.GQ29612@dualathlon.random>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello Andrea,

On Fri, Aug 22, 2003 at 06:25:46PM +0200, Andrea Arcangeli wrote:
> thanks TeJun,
> 
> just one comment
> 
> On Fri, Aug 22, 2003 at 10:18:40AM +0900, TeJun Huh wrote:
> >  3. remove irqs_running() test from synchronize_irq()
> 
> I'm not convinced this one is needed. An irq can still run on another
> cpu but the cli();sti() may execute while it's here:
> 
> 	irq running		synchronize_irq()
> 	--------------		-----------------
> 	do_IRQ
> 	handle_IRQ_event
> 				cli()
> 				sti()
> 
> 	irq_enter -> way too late
> 
> in short, doing irqs_running() doesn't seem to weaken the semantics of
> synchronize_irq() to me.
> 
> I think it should be changed this way instead:
> 
> void synchronize_irq(void)
> {
> 	smp_mb();
> 	if (irqs_running()) {
> 		/* Stupid approach */
> 		cli();
> 		sti();
> 	}
> }
> 
> to be sure to read the local irq area after the previous code (the
> test_and_set_bit of the global_irq_lock of a cli() in your version would
> achieve the same implicit smp_mb too, so maybe your only point for doing
> cli()/sti() was to execute the smp_mb before the irqs_running?).  the
> above version is more finegrined and it looks equivalent to yours.
> 
> Andrea

 Yes, you're right.  Adding just smp_mb() should guarantee that no cpu
is executing interrupt handler which may not see memory contents
modified before synchronize_irq() after synchronize_irq() returns.  I
think we need some decent comments there. :-)

 As now I know that test_and_set_bit() implies memory barrier,
smb_mb__after_clear_bit() can be removed.  I'll make and post a patch
which fixes this race and the bh race of the other thread.

 Thanks.

-- 
tejun
