Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261511AbSJ0RkG>; Sun, 27 Oct 2002 12:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261839AbSJ0RkG>; Sun, 27 Oct 2002 12:40:06 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41269 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261511AbSJ0RkD>; Sun, 27 Oct 2002 12:40:03 -0500
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, Suparna Bhattacharya <suparna@in.ibm.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, fastboot@osdl.org,
       Werner Almesberger <wa@almesberger.net>
Subject: Re: kexec for 2.5.44 (Who do I send this to?)
References: <m1y98uyc1a.fsf@frodo.biederman.org>
	<20021020190939.GA913@elf.ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 27 Oct 2002 10:44:00 -0700
In-Reply-To: <20021020190939.GA913@elf.ucw.cz>
Message-ID: <m1wuo3kc9r.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
> 
> > The kexec code has gone through a fairly decent review, and all known bugs
> > are resolved.  There are still BIOS's that don't work after you have
> > run a kernel but that is an entirely different problem.  
> 
> Looks good... Few comments follow.

 
> Perhaps this should be done using driverfs callbacks?

O.k.  For the cpu shutdown case I am not certain if this can be modeled
properly but here is a shot at thinking it through.


Drawing the APIC dependencies I get a tree is in parallel and usually
flatter than the normal device tree.

boot_strap_processor          
apic
  |
  +----+--------+---------+--------------+
       |        |         |              |
       +        +         +              +
   IOAPIC   IOAPIC        CPU#2         CPU#3
    |
    +--+--------+---------------+--------- .....
       |        |               |
 Legacy PIC     PCI device 1  PCI device 2


The only sane way I can think to do is to put the apic tree, above
the pci bus trees.  This should preserve the requirement not to
shutdown IOAPICs, before shutting down the pci devices, that send
interrupts through them.  The hard challenge is that IOAPICs
can appear as pci devices, so it is at least possible for devices
on one pci bus to depend on the IOAPIC on anther pci bus.  

However, if we do not disable the PCI bridges/busses it should not be
an issue.  We just need to keep from disabling the IOAPICs, and other
PICs until after we have shutdown all of the other devices.

To properly shutdown an SMP system so it can be reinitialized the PICs
must be placed in legacy mode.  Which means all of the IOAPICs must
come down.

Does this sound like something that is reasonable to tackle?
Getting it right is a challenge but I do have a good test case :)

Eric
