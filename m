Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbWF3TCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbWF3TCh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 15:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933056AbWF3TCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 15:02:15 -0400
Received: from isilmar.linta.de ([213.239.214.66]:25498 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S933069AbWF3TCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 15:02:12 -0400
Date: Fri, 30 Jun 2006 21:00:59 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Fix deadlock in pcmcia as found by lockdep
Message-ID: <20060630190059.GD8721@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Miles Lane <miles.lane@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <a44ae5cd0606292318n5a788a30xa1c28ed4fc973056@mail.gmail.com> <1151656273.11434.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151656273.11434.5.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2006 at 10:31:13AM +0200, Arjan van de Ven wrote:
> On Thu, 2006-06-29 at 23:18 -0700, Miles Lane wrote:
> > To trigger this, I booted with a U.S. Robotics USR2210 Wifi card
> > plugged into my cardbus slot.  I then ran "pccardctl eject" and then
> > removed and then reinserted the card.  After looking at the latest
> > PCMCIA info, it seems that I may need to add some kernel boot options
> > to work around a BIOS or other problem that causes trouble when
> > removing a card.
> > 
> > PM: Removing info for pci:0000:02:00.0
> > PCMCIA: socket c1ebc9e0: *** DANGER *** unable to remove socket power
> 
> 
> ok this looks like a real bug:
> 
> void pcmcia_parse_events(struct pcmcia_socket *s, u_int events)
> {
>         cs_dbg(s, 4, "parse_events: events %08x\n", events);
>         if (s->thread) {
>                 spin_lock(&s->thread_lock);
>                 s->thread_events |= events;
>                 spin_unlock(&s->thread_lock);
> 
>                 wake_up(&s->thread_wait);
>         }
> } /* pcmcia_parse_events */
> 
> 
> that function gets called from both user context and irq context!
> 
> user context:
> [<c1181270>] pcmcia_parse_events+0x3e/0x6b
> [<c1181945>] pcmcia_register_socket+0x29b/0x2fc
> [<c118a8d1>] yenta_probe+0x51b/0x55c
> [<c110d537>] pci_device_probe+0x39/0x5b
> 
> eg in pcmcia_register_socket:
> 
>         ret = kernel_thread(pccardd, socket, CLONE_KERNEL);
>         if (ret < 0)
>                 goto err;
> 
>         wait_for_completion(&socket->thread_done);
>         if(!socket->thread) {
>                 printk(KERN_WARNING "PCMCIA: warning: socket thread for
> socket %p did not start\n", socket);
>                 return -EIO;
>         }
>         pcmcia_parse_events(socket, SS_DETECT);
> 
> clearly sleeping/user context
> 
> 
> interrupt context:
> yenta_interrupt calls pcmcia_parse_events like this:
> ....
>         if (events)
>                 pcmcia_parse_events(&socket->socket, events);
> 
>         return IRQ_HANDLED;
> }
> 
> and that's the irq handler.
> 
> Dominik: this really wants to have _irqsave versions of the spinlock
> like this:

Applied.

Thanks,
	Dominik
