Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265187AbSLVTuD>; Sun, 22 Dec 2002 14:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265190AbSLVTuD>; Sun, 22 Dec 2002 14:50:03 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26414 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265187AbSLVTuC>; Sun, 22 Dec 2002 14:50:02 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Paul Mackerras <paulus@samba.org>, <davidm@hpl.hp.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.x disable BAR when sizing
References: <Pine.LNX.4.44.0212221135210.2692-100000@home.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Dec 2002 12:57:44 -0700
In-Reply-To: <Pine.LNX.4.44.0212221135210.2692-100000@home.transmeta.com>
Message-ID: <m1fzspltc7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Sun, 22 Dec 2002, Paul Mackerras wrote:
> >
> > Linus Torvalds writes:
> >
> > > Actually, I think it's certainly valid to not allow "printk()" to happen
> > > around the BAR probing, at least at bootup when we control all the CPU's
> > > tightly anyway.
> >
> > I'd like us to disable interrupts too.  On powermacs, the interrupt
> > controller is typically inside a combo I/O ASIC which is on the PCI
> > bus.
> 
> I certainly wpouldn't mind disabling local interrupts around that code
> sequence, but the problem with that is that I don't think it much matters,
> since it wouldn't help the SMP case anyway (and in fact even doing an
> old-style "cli/sti" if we still supported it would not have helped either,
> since the global interrupt disable would still have allowed the other
> CPU's to touch the irq controller).
> 
> And since the pci bus will be scanned in an "subsys_initcall", the other
> CPU's are definitely active at that point.

Ouch, I hadn't thought about that one...

> In short, I don't think we can easily fix this. And again, I think that
> the only good approach would be to really make sure the machine is
> quescent while the PCI bus is initially scanned (and again, the later
> scans behing proper hotplug bus bridges should be fine thanks to bridge
> decoding limits).

For a similar reason this is why my kexec stuff does not attempt to
do generic device disables.

> Sadly, as I already mentioned, there isn't any generic PCI method of
> shutting up device interrupts.
> 
> I think the only workable setup (which we effectively already do on x86,
> not that we should have this problem in the first place) is to just turn
> off the interrupts _at_ the interrupt controller. Which simply means that
> we really shouldn't be getting any interrupts while probing the root bus.
> Then you enable the interrupts as device drivers request them..

Well we need southbridge drivers on x86 if we want to prevent SCI interrupts
because those go around the i82559.  Though we might catch them at the local
apic...

Eric
