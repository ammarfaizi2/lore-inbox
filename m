Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266489AbUBGGdp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 01:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266490AbUBGGdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 01:33:45 -0500
Received: from nevyn.them.org ([66.93.172.17]:6310 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S266489AbUBGGdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 01:33:41 -0500
Date: Sat, 7 Feb 2004 01:33:40 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc3: irq#19 - nobody cared - with an au88xx
Message-ID: <20040207063340.GA12861@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <BF1FE1855350A0479097B3A0D2A80EE0023E89C2@hdsmsx402.hd.intel.com> <1076134307.2562.1553.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076134307.2562.1553.camel@dhcppc4>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 01:11:48AM -0500, Len Brown wrote:
> Can you isolate this regression to a specific release?  There have been
> several changes to arch/i386/kernel/irq.c since 2.6.0-test7.  Also, it
> would be interesting to know if it also happens with CONFIG_SMP=n (but
> with the IOAPIC still enabled)  Plus, a sanity check of the rate of
> interrutps reported by /proc/interrupts might yield a clue.
> 
> thanks,
> -Len
> 
> ps.
> You can avoid the symptom by booting with "noirqdebug" or having the
> interrupt handling always return IRQ_HANDLED.  But then we'd lose the
> means to find out why the driver is receiving interrupts for which it
> can find no cause.

Thanks for the response, Len.  If I can identify which kernel triggered
the problem I'll let you know.  It will be tricky, since it takes a day
or more to appear.

For the record, I've figured out why no one ever submitted the driver:
I somehow didn't notice the binary-only module in the middle of the
rest of the code.  The main interrupt handler is in there.  The driver
wrapper returns IRQ_NONE if some blob of code in there decides the card
didn't generate an interrupt, so it could be anything.  I see that
there's now a reverse-engineered ALSA driver for this card so I'm going
to see if that works first.

> 
> On Fri, 2004-02-06 at 23:42, Daniel Jacobowitz wrote:
> > I've started getting this, every 24 hours or so:
> > 
> > irq 19: nobody cared!
> > Call Trace:
> >  [<c010d38a>] __report_bad_irq+0x2a/0x90
> >  [<c010d480>] note_interrupt+0x70/0xb0
> >  [<c010d7c0>] do_IRQ+0x160/0x1a0
> >  [<c0105000>] _stext+0x0/0x60
> >  [<c010b8d8>] common_interrupt+0x18/0x20
> >  [<c0108990>] default_idle+0x0/0x40
> >  [<c0105000>] _stext+0x0/0x60
> >  [<c01089bc>] default_idle+0x2c/0x40
> >  [<c0108a4b>] cpu_idle+0x3b/0x50
> >  [<c04b64a0>] unknown_bootoption+0x0/0x120
> >  [<c04b6926>] start_kernel+0x1a6/0x1f0
> >  [<c04b64a0>] unknown_bootoption+0x0/0x120
> > 
> > handlers:
> > [<f886b290>] (au_isr+0x0/0xb0 [au8830])
> > Disabling IRQ #19
> > 
> > and then sound doesn't work for a while.
> > 
> > There's a good chance this is my fault.  IRQ 19 is:
> > 
> >  19:   18500001          0   IO-APIC-level  au88xx
> > 
> > and the au88xx driver is an out-of-tree driver that was developed on
> > 2.4/early-2.5, and I ported it to 2.6 myself.  It worked flawlessly on
> > 2.6.0-test7; has something changed in how interrupt handlers are
> > required to
> > behave?
> > 
> > [Just ask if you actually want the source to this driver... I don't
> > know
> > enough about the card to actually submit it to Linus's tree and the
> > driver's
> > original authors aparently didn't care to.]
> > 
> > --
> > Daniel Jacobowitz
> > MontaVista Software                         Debian GNU/Linux Developer
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> > 
> 
> 

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
