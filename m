Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316572AbSFFAII>; Wed, 5 Jun 2002 20:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316579AbSFFAIH>; Wed, 5 Jun 2002 20:08:07 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:63901 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316572AbSFFAIF>; Wed, 5 Jun 2002 20:08:05 -0400
Date: Wed, 5 Jun 2002 19:08:05 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Patrick Mochel <mochel@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] PCI device matching fix
In-Reply-To: <Pine.LNX.4.33.0206051625270.654-100000@geena.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0206051845310.8309-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2002, Patrick Mochel wrote:

> No, I haven't given up on it, and I admit it's fishy. However, I did it
> to ensure that no one can access the driver since it is going away as
> soon as we return to pci_unregister_driver. Though, I'll also admit that
> making the next potential user hit the BUG() in get_driver() is not the
> nicest thing to do...

There's two phases:
o remove_driver():
  Make sure that now one else can find (and inc the refcount) your struct
  anymore. That can and should be done immediately. Drop your reference.
o At some point later, everybody else will have dropped their references
  and the destructor can be called.

Alternatively:
o remove_driver():
  Make sure that now one else can find (and inc the refcount) your struct
  anymore. That can and should be done immediately. Drop your reference.
  Wait for everybody else to drop their reference. Then return to the 
  caller
o At some point later, everybody else will have dropped their references
  and the remove_driver() should be woken up and you get to the return.

I claim the latter is more appropriate, since driver_register() and 
driver_remove() (btw, I'd rather have the latter called 
driver_unregister()) will always be called by the same user, normally
the driver module. That's different from some object which isn't
explicitly unregistered somewhere, but will be cleaned up e.g. due to
memory pressure some time later. You can always achieve the second
if you have the first, but I see no point in having driver authors deal
with it.

> There is a destructor: struct device_driver::release(). It's the last 
> thing called from __remove_driver(). 
> 
> No matter what, the module will get unloaded immediately. What would be 
> nice is if we could delay it until we said it was ok (from the driver's 
> release callback). We could even define a common release callback for all 
> drivers:

That's not true. module_exit() is called from rmmod(8) and thus in process
context. It's perfectly fine to sleep in module_exit() until we're safe to 
be deleted.

> void driver_release(struct device_driver * drv)
> {
> 	struct module * module = drv->module;
> 
> 	/* do unload of module */
> }
> 
> We wouldn't need a completion; we would just have to wait until the 
> refcount hit 0 naturally. But, I'm just making this stuff up. Is this at 
> all possible?

Now this is bad, what if the last reference went away from irq context? 
Unloading a module from irq context doesn't sound like a good idea to me.

I'd suggest something like

pci_driver_release(pdrv)
{
	complete(&pdrv->complete);
}

pci_register_driver(pdrv)
{
	...
	pdrv->driver.release = pci_driver_release;
	pdrv->complete = NULL;
}

pci_unregister_driver(pdrv)
{
	DECLARE_COMPLETION(complete);

	pdrv->complete = &complete;
	put_driver(&drv->driver);
	wait_for_completion(&complete);
}

And make clear that pci_unregister_driver() can be called from process 
context only.

Actually, as said above, I'd rather do the same thing in remove_driver(),
i.e. make that sleep as well - unless you can come up with an example
where anybody would want to call remove_driver() and cannot sleep. 
Just replace ->release with the struct completion *.

--Kai




