Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262039AbSJIWZh>; Wed, 9 Oct 2002 18:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262060AbSJIWZh>; Wed, 9 Oct 2002 18:25:37 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:24973 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S262039AbSJIWZf>; Wed, 9 Oct 2002 18:25:35 -0400
Date: Wed, 9 Oct 2002 17:31:10 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Roman Zippel <zippel@linux-m68k.org>
cc: Alexander Viro <viro@math.psu.edu>,
       Linus Torvalds <torvalds@transmeta.com>,
       Patrick Mochel <mochel@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.LNX.4.44.0210092246040.8911-100000@serv>
Message-ID: <Pine.LNX.4.44.0210091704040.5883-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2002, Roman Zippel wrote:

> > I did and I'm less than impressed by his arguments.  Filesystem module
> > unloading works fine, thank you very much.
> 
> I agree, that it works, but it's more complex than necessary.
> We need module pointers everywhere, which are needed for reference
> counting. To make this worse this only works for modules, so you possibly
> need another reference count (e.g. see struct proc_dir_entry).
> On the other hand can_unload() isn't really a solution either. From the
> point can_unload() returns true, the module must not be called anymore. So
> without some big lock this would only work if can_unload also calls
> module_exit() and the whole thing gets even more complex.
> Anyway, the module pointers can be easily replaced with a normal ref
> count, but this requires that module_exit() can fail and so a new module
> API, but IMO this can wait for 2.7, try_inc_mod_count() will do until
> then.

This is a never ending story, but anyway. I think the mistake is seeing 
mod->use_count as a reference count for all objects exported from that 
module (apart from symbols). But it is not, and I don't think it should 
be. It's more of a "don't unload me now, I have given away references 
which won't come back anytime soon, so unloading may block a long time" 
hint. The APIs used by the module can still internally do separate exact 
ref counting without that causing races, that's because a 
pci_unregister_driver() call should block until all references are gone 
before returning. The module doesn't need to care. It just calls 
pci_unregister_driver() from module_exit() and it'll be safe without any
additional coding or thinking needed.

The only thing you need to be aware of is that pci_unregister_driver() 
will call ::remove for devices registered with your driver. If you know 
that your ::remove routine can get rid of the reference without further 
delay, that's fine. However, say, your pci device was a network card 
which registered "eth0" and someone said "ifconfig eth0 up", you have to 
unregister "eth0" in your ::remove routine. And you know that this will 
block until "ifconfig eth0 down" has run, which is potentially a long 
time. So at this point, you decide to rather not have the user wait 
forever until his "rmmod net_pci" succeeds, but return -EBUSY right away.
You do it by running MOD_INC_USE_COUNT in ::open(), and DEC again in 
::close(). Actually, you don't even need to do it yourself, the network
layer will do it for you if you tell it which module is associated with 
"eth0" by setting ::owner.

Note that things are actually very similar to your suggestion.

You want a two stage

	module_begin_unload()

	module_finish_unload()

where the first call unregisters the references it registered before, and
possibly sets a flag or something to avoid other code to acquire further
references.

Then you have to wait until the ref count hits zero, then you can call
module_finish_unload()

What we currently use (at the places where it's done right), is just these
two steps embedded into say a single call to pci_unregister_driver(), 
which unregisters the driver from the list of drivers, calls the 
registered devices remove method, to get rid of those references. Then, it 
waits until all references are gone and returns - really much the same 
thing.

The current implementation gives you a way of knowing if unloading will
succeed shortly (if not, it'll fail with -EBUSY). Yours doesn't AFAICS,
and that's actually bad IMO, I think you actually have to try to see if
the unload would succeed, and that's not pretty.

And, done right, the API for the current implementation is so simple that 
I doubt you'll be able to come up with something with more ease-of-use.

--Kai





