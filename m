Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316541AbSFEXQ7>; Wed, 5 Jun 2002 19:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316542AbSFEXQ6>; Wed, 5 Jun 2002 19:16:58 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:58525 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316541AbSFEXQ4>; Wed, 5 Jun 2002 19:16:56 -0400
Date: Wed, 5 Jun 2002 18:15:36 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Greg KH <greg@kroah.com>
cc: Patrick Mochel <mochel@osdl.org>, Andrew Morton <akpm@zip.com.au>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kees Bakker <kees.bakker@xs4all.nl>,
        Anton Altaparmakov <aia21@cantab.net>,
        Anton Blanchard <anton@samba.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] PCI device matching fix
In-Reply-To: <20020604051704.GA26058@kroah.com>
Message-ID: <Pine.LNX.4.44.0206051759440.8309-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> @@ -101,6 +96,28 @@
>  		drv->release(drv);
>  }
>  
> +void remove_driver(struct device_driver * drv)
> +{
> +	spin_lock(&device_lock);
> +	atomic_set(&drv->refcount,0);
> +	spin_unlock(&device_lock);
> +	__remove_driver(drv);
> +}

> @@ -124,7 +136,7 @@
>  void
>  pci_unregister_driver(struct pci_driver *drv)
>  {
> -	put_driver(&drv->driver);
> +	remove_driver(&drv->driver);
>  }
>  
>  static struct pci_driver pci_compat_driver = {

Now does that mean you have given up on getting the ref counting right? 
Forcing the ref count to zero is obviously not a solution, 
pci_unregister_driver is usually called at module unload time, which means 
that struct pci_driver will go away immediately after the call returns. If 
you know that there are no other users at this time (which I doubt), you 
don't need to do the whole refcounting thing at all (since at all times 
before the ref count is surely >= 1). If not, you're racy.

I think I brought up that issue before, though nobody seemed interested. 
AFAICS there are two possible solutions:

o provide a destructor callback which is called from put_driver when we're 
  about to throw away the last reference which would let whoever registered 
  the thing in the beginning know that it's all his again now (If it was
  kmalloced, that would be the time to kfree it). In this case it's 
  rather that the callback would tell us we can now finish 
  module_exit().
o Use a completion or something and do the above inside 
  pci_unregister_driver (or remove_driver). I.e. have it sleep until
  all references are gone. That would fix the race for the typical

void my_module_exit(void) { pci_unregister_driver(&my_driver); }

  case.

(The latter would be my preference, as I see no point in having driver
 authors deal with the complication of waiting for completion of 
 pci_unregister_driver() themselves)

--Kai


