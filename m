Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316459AbSFEXmq>; Wed, 5 Jun 2002 19:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316489AbSFEXmp>; Wed, 5 Jun 2002 19:42:45 -0400
Received: from air-2.osdl.org ([65.201.151.6]:907 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316459AbSFEXmj>;
	Wed, 5 Jun 2002 19:42:39 -0400
Date: Wed, 5 Jun 2002 16:38:31 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] PCI device matching fix
In-Reply-To: <Pine.LNX.4.44.0206051759440.8309-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.33.0206051625270.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[cc list trimmed]

> Now does that mean you have given up on getting the ref counting right? 
> Forcing the ref count to zero is obviously not a solution, 
> pci_unregister_driver is usually called at module unload time, which means 
> that struct pci_driver will go away immediately after the call returns. If 
> you know that there are no other users at this time (which I doubt), you 
> don't need to do the whole refcounting thing at all (since at all times 
> before the ref count is surely >= 1). If not, you're racy.

No, I haven't given up on it, and I admit it's fishy. However, I did it to 
ensure that no one can access the driver since it is going away as soon as 
we return to pci_unregister_driver. Though, I'll also admit that making 
the next potential user hit the BUG() in get_driver() is not the nicest 
thing to do...

> I think I brought up that issue before, though nobody seemed interested. 
> AFAICS there are two possible solutions:
> 
> o provide a destructor callback which is called from put_driver when we're 
>   about to throw away the last reference which would let whoever registered 
>   the thing in the beginning know that it's all his again now (If it was
>   kmalloced, that would be the time to kfree it). In this case it's 
>   rather that the callback would tell us we can now finish 
>   module_exit().
> o Use a completion or something and do the above inside 
>   pci_unregister_driver (or remove_driver). I.e. have it sleep until
>   all references are gone. That would fix the race for the typical
> 
> void my_module_exit(void) { pci_unregister_driver(&my_driver); }
> 
>   case.
> 
> (The latter would be my preference, as I see no point in having driver
>  authors deal with the complication of waiting for completion of 
>  pci_unregister_driver() themselves)

There is a destructor: struct device_driver::release(). It's the last 
thing called from __remove_driver(). 

No matter what, the module will get unloaded immediately. What would be 
nice is if we could delay it until we said it was ok (from the driver's 
release callback). We could even define a common release callback for all 
drivers:

void driver_release(struct device_driver * drv)
{
	struct module * module = drv->module;

	/* do unload of module */
}

We wouldn't need a completion; we would just have to wait until the 
refcount hit 0 naturally. But, I'm just making this stuff up. Is this at 
all possible?

	-pat

