Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317217AbSFFWWU>; Thu, 6 Jun 2002 18:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317218AbSFFWWT>; Thu, 6 Jun 2002 18:22:19 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:56224 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317217AbSFFWWR>; Thu, 6 Jun 2002 18:22:17 -0400
Date: Thu, 6 Jun 2002 17:22:17 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Patrick Mochel <mochel@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] PCI device matching fix
In-Reply-To: <Pine.LNX.4.33.0206061423160.654-100000@geena.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0206061706230.31896-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2002, Patrick Mochel wrote:

> > That's not quite right. It's okay to be using a module while the module
> > refcount is zero, in fact it's very common. But you need to have a
> > module_exit() function which makes sure that the module is not used
> > anymore before it returns.
> 
> Is that correct behavior? Shouldn't any use increment the refcount?

It's safe, as in not racy. It's the only way to do it if you want to be 
able to use "rmmod" to unregister your driver, see below. Well, there was
some talk about going to a two stage module unload in 2.5. I don't 
remember how exactly that worked, but it didn't happen yet, anyway.

> > (One thing is different there, though not really: struct net_device is
> > alloced dynamically, so the problem is to kfree() only after noone else
> > uses it, for struct driver it's most likely statically alloced and freed
> > after module_exit(), so that's why we have to wait for other users to go 
> > away)
> 
> One minor, though important, distinction is that there is one struct 
> net_device allocated for each device the driver is attached to. When 
> module_exit() calls pci_unregister_driver(), the driver's remove callback 
> is called for each of these devices, at which point the struct net_device 
> is freed. 

That's what I meant above, the way the memory is deallocated is different, 
kfree() vs. module_unload(), but the way to handle it is the same - wait 
until it's all ours, and the free it - explicitly with kfree() vs 
implicitly by finishing module_exit()

> However, taking a step back... The only time the driver refcount will hit
> 0 is if it's going away. The only time it goes away is if the module is
> removed. If someone is using the driver, you don't want the module to 
> unload. Instead of trying to keep the refcounts of the two objects 
> synchronized against each other, can't we just use the same one? 

Yes, you're basically right, whether you use the refcount in struct driver 
or the module use count doesn't make any difference. Except for one thing:
You cannot call module_exit() when the module count is > 0. Since only 
then unregister_driver() is called, there's no way to get the use count to 
zero and thus unload the module. One could of course change the policy to 
call unregister_driver() not from module_exit(), but e.g. by
"echo remove > /driversfs/../my_driver", but it's surely not that I'm 
suggesting this.

> We can replace the refcount in struct device_driver with a struct module
> pointer, which modular drivers will already have. get_driver and
> put_driver can either go away, or simply become wrappers for touching the
> module reference count.

They would still need to be wrappers for touching the module count 
instead. So it doesn't buy anything.

> I'm pretty sure the file/directory refcounting is ok. Famous last words, 
> but I'm doing something like you described. My concern was instead over 
> the validity of the callback pointers that a driver has registered for a 
> file. 
> 
> A user opens a file. Before they read from it, the module is unloaded. 
> They try and read from it, the show() callback is referenced, and we 
> crash. 
> 
> Currently, the driverfs open call increments the reference count of the 
> device that created it. There are currently no provisions for device 
> drivers or bus drivers. So, no matter what, I have to modify that call to 
> handle those types. If the refcounting is right, the module won't be 
> unloaded, and the callbacks will be valid. 

Yeah, that seems right. Maybe it's better to not install callbacks 
directly, but a reference to the struct driver, where the struct driver 
contains the callbacks. This way it's explicit you still reference the 
struct driver (and need to get/put it). But I didn't even look how you do 
it currently, so maybe you're doing it that way already.

--Kai


