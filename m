Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbUDFSDC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 14:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263933AbUDFSDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 14:03:01 -0400
Received: from nevyn.them.org ([66.93.172.17]:25985 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S263930AbUDFSCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 14:02:42 -0400
Date: Tue, 6 Apr 2004 14:02:38 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc3: irq#19 - nobody cared - with an au88xx
Message-ID: <20040406180238.GA7439@nevyn.them.org>
Mail-Followup-To: Len Brown <len.brown@intel.com>,
	linux-kernel@vger.kernel.org
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

I still haven't figured out which kernel first introduced the problem,
but it's still present, at 2.6.5.  I didn't see it while I was running
2.6.3-rc3, for some reason.

Now I'm using the ALSA au8830 driver.  There was no output from the
driver before the nobody-cared message, so it was caused by one of
these (sound/pci/au88x0/au88x0_core.c):

        //check if the interrupt is ours.
        if (!(hwread(vortex->mmio, VORTEX_STAT) & 0x1))
                return IRQ_NONE;

        // This is the Interrrupt Enable flag we set before (consistency check).
        if (!(hwread(vortex->mmio, VORTEX_CTRL) & CTRL_IRQ_ENABLE))
                return IRQ_NONE;


About a minute after this happened, USB did the same thing:
Apr  6 12:21:40 nevyn kernel: irq 11: nobody cared!
Apr  6 12:21:40 nevyn kernel: Call Trace:
Apr  6 12:21:40 nevyn kernel:  [__report_bad_irq+42/144] __report_bad_irq+0x2a/0x90
Apr  6 12:21:40 nevyn kernel:  [note_interrupt+112/176] note_interrupt+0x70/0xb0
Apr  6 12:21:40 nevyn kernel:  [do_IRQ+352/416] do_IRQ+0x160/0x1a0
Apr  6 12:21:40 nevyn kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Apr  6 12:21:40 nevyn kernel:  [default_idle+0/64] default_idle+0x0/0x40

Apr  6 12:21:40 nevyn kernel: handlers:
Apr  6 12:21:40 nevyn kernel: [usb_hcd_irq+0/112] (usb_hcd_irq+0x0/0x70)
Apr  6 12:21:40 nevyn kernel: [usb_hcd_irq+0/112] (usb_hcd_irq+0x0/0x70)
Apr  6 12:21:40 nevyn kernel: Disabling IRQ #11

That's the UHCI driver.  The code in question is presumably:
        status = inw(io_addr + USBSTS);
        if (!(status & ~USBSTS_HCH))    /* shared interrupt, not mine */
                return IRQ_NONE;
        outw(status, io_addr + USBSTS);         /* Clear it */

I'm assuming that it is not the fault of either of these drivers, since
both of those are quite straightforward; they appear to be actually
being triggered when nothing is going on.

There was a set of APIC errors an hour before, but they're probably
unrelated:
Apr  6 11:31:31 nevyn kernel: APIC error on CPU1: 00(08)
Apr  6 11:31:31 nevyn kernel: APIC error on CPU0: 00(02)
Other than that, no interesting information in the logs.

The rate of interrupts looks sane.  I'll try to check it the next time
this happens but I didn't see anything strange.

Afraid that's not enough info for anyone to help :(  I'll try a couple
of things...

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
