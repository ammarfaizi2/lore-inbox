Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290212AbSAOSBh>; Tue, 15 Jan 2002 13:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290222AbSAOSBX>; Tue, 15 Jan 2002 13:01:23 -0500
Received: from air-1.osdl.org ([65.201.151.5]:55176 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S290220AbSAOSBF>;
	Tue, 15 Jan 2002 13:01:05 -0500
Date: Tue, 15 Jan 2002 10:02:49 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Defining new section for bus driver init
In-Reply-To: <20020115100041.A994@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0201150955070.827-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Jan 2002, Russell King wrote:

> On Mon, Jan 14, 2002 at 05:47:15PM -0800, Patrick Mochel wrote:
> > Attached is a patch that creates a new section for device subsystem init
> > calls. With it, the root bus init calls are handled just like init calls
> > - the section consists of a table of function pointers.
> > device_driver_init() iterates over that table and calls each one.
> > (device_driver_init() currently happens just before that pci_init() call
> > above).
>
> I've been thinking about this, and would like to suggest something that'd
> reduce the code size, but is dependent on the ordering of stuff in
> do_basic_setup.  So first some questions.  Currently, we do:
>
> 	device_driver_init()
> 	random bus driver init...
> 	sock_init()
> 	start_context_thread()
> 	do_initcalls()
>
> Is there any ordering dependency between sock_init(), start_context_thread()
> and the bus driver init calls?  From a brief look at the code, it would
> appear that start_context_thread() is rather safe, but sock_init() is
> questionable.  If they are both safe, then we could move these two calls
> before, or even just after device_driver_init():
>
> 	device_driver_init()
> 	sock_init()
> 	start_context_thread()
> 	random bus driver init...
> 	do_initcalls()

device_driver_init() is not that special. It only needs to be called
before any of the bus or class subsystems. So, in theory, you could
declare it __devsubsys_init, and use the link order to guarantee its
ordering.

I don't know about sock_init(). That looks like the core network init,
which is the other type of thing that I had intended for this section. It
shouldn't be dependent on any other device classes or device buses,
right? So, it could be moved as well.

Although, device_driver_init() should be called first. So maybe we need a
__dev_bus_init and __dev_class_init. Or, is that much?

> Now we have the bus driver initialisation and the initcall initialisation
> next to each other.  We can then pull this trick with the linker file:
>
> 	__initcall_start = .;
> 	.initcall : {
> 		*(.devsubsys.init)
> 		*(.initcall.init)
> 	}
> 	__initcall_end = .;
>
> All the magic then happens within do_initcalls() without any extra code
> needing to be added.  The really funky thing about this approach is
> that you can add other sections to handle network protocol modules
> and such like with virtually zero code.

Hey, cool. I'd much prefer this.

I had been thinking about creating a new one for device driver init
routines, and grouping them together. This, however, is only for the sake
of grouping, and doesn't bear any obvious technical merit. And, it would
require touching all the drivers, so maybe not...

	-pat


