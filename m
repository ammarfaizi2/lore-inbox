Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317187AbSFFWCJ>; Thu, 6 Jun 2002 18:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317002AbSFFWCI>; Thu, 6 Jun 2002 18:02:08 -0400
Received: from air-2.osdl.org ([65.201.151.6]:22158 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317193AbSFFWCI>;
	Thu, 6 Jun 2002 18:02:08 -0400
Date: Thu, 6 Jun 2002 14:57:52 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] PCI device matching fix
In-Reply-To: <Pine.LNX.4.44.0206061418010.31896-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.33.0206061423160.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That's not quite right. It's okay to be using a module while the module
> refcount is zero, in fact it's very common. But you need to have a 
> module_exit() function which makes sure that the module is not used 
> anymore before it returns.

Is that correct behavior? Shouldn't any use increment the refcount? 

> I think a good example are network drivers, since I think they get the 
> refcounting right. If you load your network driver, it'll register_netdev(), 
> but not inc the module use count. If someone ifconfig up's the interface,
> only then the module use count is incremented and the ::open() method is
> called. If you ifdown the interface, the module use count goes back to 
> zero after ::close() has been called. However, the struct net_device
> is still registered with the network layer.
> 
> When you rmmod the module, which is possible since its use count is zero,
> module_exit() will call unregister_netdev(), which initiate unregistering 
> and then sleep until noone else is using the struct net_device anymore.
> At that point it's save to return to the module, which will kfree()
> and exit.
> 
> (One thing is different there, though not really: struct net_device is
> alloced dynamically, so the problem is to kfree() only after noone else
> uses it, for struct driver it's most likely statically alloced and freed
> after module_exit(), so that's why we have to wait for other users to go 
> away)

One minor, though important, distinction is that there is one struct 
net_device allocated for each device the driver is attached to. When 
module_exit() calls pci_unregister_driver(), the driver's remove callback 
is called for each of these devices, at which point the struct net_device 
is freed. 

The struct device_driver is statically allocated, since there is one per 
driver/module. 

> Anyway, the completion/wait is needed, there may be someone else using
> struct driver at this moment (say someone doing driver_for_each_dev() on
> it). Otherwise, the refcount is completely useless, between
> driver_register() and driver_unregister() it will always be >= 1, so
> inc'ing / dec'ing doesn't make any difference, the only point where it is
> needed is exactly at driver_unregister() time.

Yes, you're right. I think I owe you a beer for keeping me honest. 

However, taking a step back... The only time the driver refcount will hit
0 is if it's going away. The only time it goes away is if the module is
removed. If someone is using the driver, you don't want the module to 
unload. Instead of trying to keep the refcounts of the two objects 
synchronized against each other, can't we just use the same one? 

We can replace the refcount in struct device_driver with a struct module
pointer, which modular drivers will already have. get_driver and
put_driver can either go away, or simply become wrappers for touching the
module reference count.

> > That said, I'm an offender of that rule with driverfs. It's the topic of
> > another thread, and I haven't quite figured out the best solution. When we
> > open a file belonging to a driver, we want to inc the module refcount.
> > But, we don't currently have anyway to get at the module to do this. 
> 
> Well, if you do the refcounting correctly, this should be doable, too.
> 
> I don't really have the time to go through drivers/base and fs/driverfs in 
> detail, but the general idea would be to following:
...

I'm pretty sure the file/directory refcounting is ok. Famous last words, 
but I'm doing something like you described. My concern was instead over 
the validity of the callback pointers that a driver has registered for a 
file. 

A user opens a file. Before they read from it, the module is unloaded. 
They try and read from it, the show() callback is referenced, and we 
crash. 

Currently, the driverfs open call increments the reference count of the 
device that created it. There are currently no provisions for device 
drivers or bus drivers. So, no matter what, I have to modify that call to 
handle those types. If the refcounting is right, the module won't be 
unloaded, and the callbacks will be valid. 

	-pat


