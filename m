Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262541AbSJLAmH>; Fri, 11 Oct 2002 20:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262576AbSJLAmG>; Fri, 11 Oct 2002 20:42:06 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:63752 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262541AbSJLAmF>; Fri, 11 Oct 2002 20:42:05 -0400
Date: Sat, 12 Oct 2002 02:47:19 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.LNX.4.44.0210111725240.14124-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0210120114350.338-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 11 Oct 2002, Kai Germaschewski wrote:

> > Your mistake here is that e.g. start() would call the register function,
> > so it's basically the same. A proc entry would be a better example, so
> > stop() would call proc_unlink() and exit() proc_delete(). This means
> > start()/start() manage access to the driver, init()/exit() manage the
> > driver resources.
>
> Oh, I don't doubt that there are cases where your scheme works, I'm just
> saying restarting in general is hard - sure, for one simple proc_entry, no
> problem.

Restarting from exit() is only an option, leaving the module in the
cleanup state (once it started with the cleanup) is no error.

> > Network drivers are an interesting example, because one can't stop them,
> > because they are always addressed by name (so you can't unregister them).
>
> What? If you have the struct net_device, you can surely get the name from
> it. ::remove gives you the struct pci_dev, pci_dev::drvdata gives you
> your private per netdevice data, where is the problem to get to the
> struct_netdevice or the name?

I was talking about network drivers in general. pci drivers can be stopped
simply with pci_unregister_driver().
To get struct net_device in first place you need the name of the device,
so you can deconfigure it (otherwise the driver stays busy).
For example ISA network drivers are currently not registered as drivers
themselves, only the devices they manage are registered. start()/stop()
does only start/stop (or register/unregister) the driver _not_ the
devices.

> > On the other hand we can also look at the costs of the current API.
> > try_inc_mod_count() is a very expansive call, because you need to protect
> > the access to the module structure and to the device structure. This means
> > it's only usable in slow paths. MOD_INC_USE_COUNT became obsolete with
> > preempt (before it was just a small smp race). The only other possibility
> > is to block in module_exit() and hope that the users will go away soon.
> > Because of the requirement, that all references have to go before you even
> > can attempt to remove the module, a user can give you a hard time to get
> > rid of a module.
>
> You must be kidding me, I pointed out a couple of times now that there is
> *no* race when the module use count is handled right.

Could you please explain how this is related to what I wrote above?

> > So at worst you could say we exchange the race of being able to unload a
> > module at all with a race that a module might stay in the cleanup state
> > for a while. In the worst case scenario it will be easier to get the
> > module out of the cleanup state than to get a module removed with
> > module_exit().
>
> That's just not true. You can say that you save locking a spinlock in
> try_inc_mod_count() (which is used in non performance critical paths) in
> exchange for accepting that unload may race and your module keeps hanging
> in cleanup state for an unbound time. rmmod hanging for an unbound time
> cannot happen today, except for bugs (which still exist).

Have you understood what I wrote? I was talking about worst case behaviour
and you talk about locking???

> Show me how it's supposed to work in the net driver
> case above, than you may convince me.

That case is actually quite trivial. If one device fails to unload, it can
always set itself back to the stopped/running state, the active devices
will continue to work fine. If you want the other devices back you can
start a new bus scan.
Note a the driver cleanup itself only starts when all devices are gone,
until then it can always go back at least to the stopped state. A driver
in the stopped state can get no new users, so there is nothing to race
with.
The cleanup stage is only needed for usage which you don't return with
usecount() (usually proc entries). So if you only use
pci_register_driver() you only need to call pci_unregister_driver() in
stop() and remove the devices in exit() until the refcnt is zero. Until
then the driver stays in the stopped state, you could even call start
again and everything is working again (Practically it needs a few more
changes in driverfs, but it should show the basic idea.)

bye, Roman

PS: Could you please at least try to understand what I wrote before you
start flaming, your answer came a bit too quick for that. :(


