Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317159AbSFFUAR>; Thu, 6 Jun 2002 16:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317161AbSFFUAR>; Thu, 6 Jun 2002 16:00:17 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:23712 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317159AbSFFUAQ>; Thu, 6 Jun 2002 16:00:16 -0400
Date: Thu, 6 Jun 2002 15:00:16 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Patrick Mochel <mochel@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] PCI device matching fix
In-Reply-To: <Pine.LNX.4.33.0206061150570.654-100000@geena.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0206061418010.31896-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2002, Patrick Mochel wrote:

> Actually, I don't think the completion is needed at all. For one, it
> didn't work, and I found another bug. When we find a driver to a device,
> we inc the refcount. But, when we detach the driver via driver_detach(),
> we weren't decrementing it. The patch below does this. When you call
> driver_unregister(), it detaches the driver, then decs the refcount once,
> and Lo! it works.

Well, of course, when the refcounting is messed up, it doesn't work, but 
at least it pointed out the error - I suppose after fixing that, it did 
work?

> Second, Greg brought up an interesting point: if something is using a 
> module, it should have already inc'd the refcount, and rmmod(8) won't let 
> you remove it. If we can remove a module, but something is still using it, 
> it's a bug. And, exposing those will get those fixed sooner...

That's not quite right. It's okay to be using a module while the module
refcount is zero, in fact it's very common. But you need to have a 
module_exit() function which makes sure that the module is not used 
anymore before it returns.

I think a good example are network drivers, since I think they get the 
refcounting right. If you load your network driver, it'll register_netdev(), 
but not inc the module use count. If someone ifconfig up's the interface,
only then the module use count is incremented and the ::open() method is
called. If you ifdown the interface, the module use count goes back to 
zero after ::close() has been called. However, the struct net_device
is still registered with the network layer.

When you rmmod the module, which is possible since its use count is zero,
module_exit() will call unregister_netdev(), which initiate unregistering 
and then sleep until noone else is using the struct net_device anymore.
At that point it's save to return to the module, which will kfree()
and exit.

(One thing is different there, though not really: struct net_device is
alloced dynamically, so the problem is to kfree() only after noone else
uses it, for struct driver it's most likely statically alloced and freed
after module_exit(), so that's why we have to wait for other users to go 
away)

Anyway, the completion/wait is needed, there may be someone else using
struct driver at this moment (say someone doing driver_for_each_dev() on
it). Otherwise, the refcount is completely useless, between
driver_register() and driver_unregister() it will always be >= 1, so
inc'ing / dec'ing doesn't make any difference, the only point where it is
needed is exactly at driver_unregister() time.

> That said, I'm an offender of that rule with driverfs. It's the topic of
> another thread, and I haven't quite figured out the best solution. When we
> open a file belonging to a driver, we want to inc the module refcount.
> But, we don't currently have anyway to get at the module to do this. 

Well, if you do the refcounting correctly, this should be doable, too.

I don't really have the time to go through drivers/base and fs/driverfs in 
detail, but the general idea would be to following:

At driver_unregister() time, you need to unregister the dir_entry from its 
parent, so that it won't be found anymore. However, the dir_entry still 
is referenced from the dentry, so you hopefully inc'ed the 
refcount for that. Eventually, the dentry will become unreferenced and
driverfs_d_delete_file() be called. You kfree() the dentry and put the
reference you had - if it was the last one, the usual mechanism
kicks in, your completion gets done and your module removed.

Alternatively, make it possible to dissociate the dentry and dir_entry 
before, so you can do that, drop the ref count there and someone keeping 
open a dir in /driversfs won't be able to delay the module unload 
indefinitely. (The latter problem you'd surely have when you go
to driver::owner and use the to inc the use count) 

You didn't select an easy problem to hack on, that's for sure. But I think 
it's possible to get it right, just consistently make sure your refcount
is always right, and don't forget about indirect references e.g. via 
list_entry in driversfs/inode.c.

--Kai


