Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264288AbTCXRIQ>; Mon, 24 Mar 2003 12:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264345AbTCXRG7>; Mon, 24 Mar 2003 12:06:59 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:1505 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S264288AbTCXRGX>; Mon, 24 Mar 2003 12:06:23 -0500
Date: Mon, 24 Mar 2003 18:17:03 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Stelian Pop <stelian.pop@fr.alcove.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: rusty@rustcorp.com.au
Subject: Re: pcmcia_bus_type changes cause oops...
Message-ID: <20030324171703.GA3152@brodo.de>
References: <20030324153659.GA32044@hottah.alcove-fr> <20030324162519.GB2194@brodo.de> <20030324163744.GD32044@hottah.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030324163744.GD32044@hottah.alcove-fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, understanding more and more of the problem:

Firstly, though: is all compiled as modules? If not, it's really strange, as
I use the same driver locally, but built into the kernel. This is what I'd
recommend for cs.o, ds.o and pci-socket.o/yenta.o anyways.

On Mon, Mar 24, 2003 at 05:37:44PM +0100, Stelian Pop wrote:
> On Mon, Mar 24, 2003 at 05:25:19PM +0100, Dominik Brodowski wrote:
> 
> > Hi Stelian,
> > 
> > Thanks for your bug report. Let me analyze it a bit:
> > 
> > > ds: no socket drivers loaded!
> > 
> > ds.o is loaded for the first time, but fails as the yenta-socket driver was 
> > not loaded before
> > 
> > > pcnet_cs: Unknown symbol pcmcia_unregister_driver
> > > pcnet_cs: Unknown symbol pcmcia_register_driver
> > 
> > This is strange. There is an EXPORT_SYMBOL(pcmcia_register_driver) ...
> > maybe gets away after a "make clean"... not worriesome, though; as the
> > loading continues.
> 
> I did a make mrproper before compiling it. I could do it again but
> it would take some time. But I agree it is strance.

[CC'ed Russell on this 'cause its partly a module loading problem.]

After further reflection, it isn't strange at all: Module initialization of
ds.ko failed, so pcmcia_register_driver shouldn't be available to other 
modules. Somehow, though, pcnet_cs DOES get access to it. Strrrange...

> Linux Kernel Card Services 3.1.22
>   options:  [pci] [cardbus] [pm]
> subsystem pcmcia_socket: registering
> kobject pcmcia_socket: registering. parent: <NULL>, set: class
> kobject devices: registering. parent: pcmcia_socket, set: <NULL>
> kobject drivers: registering. parent: pcmcia_socket, set: <NULL>
> subsystem pcmcia: registering
> kobject pcmcia: registering. parent: <NULL>, set: bus
> kobject devices: registering. parent: pcmcia, set: <NULL>
> kobject drivers: registering. parent: pcmcia, set: <NULL>
> ds: no socket drivers loaded!
> kobject drivers: unregistering
> kobject drivers: cleaning up
> kobject devices: unregistering
> kobject devices: cleaning up
> subsystem pcmcia: unregistering
> kobject pcmcia: unregistering
> kobject pcmcia: cleaning up

At this stage ds.ko should not be available to anyone. trying to load
pcnet_cs.ko should fail with unresolved symbols. Of course, as ds.ko doesn't
really exist any more, we get into trouble....

> Unable to handle kernel NULL pointer dereference at virtual address 00000068
>  printing eip:
>  [<c79a5cb0>] pcnet_driver+0x30/0x80 [pcnet_cs]
>  [<c01b857e>] kobject_init+0x2e/0x50
>  [<c79a5cb0>] pcnet_driver+0x30/0x80 [pcnet_cs]
>  [<c01b8778>] kobject_register+0x18/0x70
>  [<c79a5cb0>] pcnet_driver+0x30/0x80 [pcnet_cs]
>  [<c79a5d00>] +0x0/0x100 [pcnet_cs]
>  [<c021286f>] get_bus+0x1f/0x40
>  [<c79a5cb0>] pcnet_driver+0x30/0x80 [pcnet_cs]
>  [<c0212697>] bus_add_driver+0x57/0xf0
>  [<c79a5cb0>] pcnet_driver+0x30/0x80 [pcnet_cs]
>  [<c79a5d00>] +0x0/0x100 [pcnet_cs]
>  [<c0212ba1>] driver_register+0x31/0x40
>  [<c79a5c94>] pcnet_driver+0x14/0x80 [pcnet_cs]
>  [<c79a5d00>] +0x0/0x100 [pcnet_cs]
>  [<c7951043>] +0x43/0x47 [pcnet_cs]
>  [<c79a5c94>] pcnet_driver+0x14/0x80 [pcnet_cs]
>  [<c79941c0>] +0x1e0/0x3a0 [pcmcia_core]
>  [<c0135c5a>] sys_init_module+0x15a/0x240
>  [<c010b25b>] syscall_call+0x7/0xb
> 
> Code: 8b 43 10 85 c0 7e 24 ff 43 10 b8 00 e0 ff ff 21 e0 ff 48 14 
>  <6>note: modprobe[603] exited with preempt_count 1
> kobject cardbus: registering. parent: <NULL>, set: drivers
> Yenta IRQ list 0cb8, PCI irq9
> Socket status: 30000419
> ------------------8<-------------------------8<----------------

So, I'd suggest you do one of these two things:
a) modify the process done by modprobe to load the modules in the following
   order:
	- cs.ko
	- pci-socket.ko/yenta.ko
	- ds.ko
	- pcnet_cs.ko

_or_ b) compile cs.ko / pci-socket.ko/yenta.ko into the kernel

until I get a proper fix for this problem. The requirement of having to load
the socket drivers before ds.ko will be removed soon... that patch is
already in my queue somewhere (and will remove the issue you're seeing
almost surely), but depends on some other stuff. But maybe I can split the
decisive things out sooner, let's see...

Thanks,

	Dominik
