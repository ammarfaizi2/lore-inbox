Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315928AbSFGAC4>; Thu, 6 Jun 2002 20:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316194AbSFGACz>; Thu, 6 Jun 2002 20:02:55 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:5281 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S315928AbSFGACy>; Thu, 6 Jun 2002 20:02:54 -0400
Date: Thu, 6 Jun 2002 19:02:54 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Patrick Mochel <mochel@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] PCI device matching fix
In-Reply-To: <Pine.LNX.4.33.0206061620490.654-100000@geena.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0206061851360.31896-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2002, Patrick Mochel wrote:

> Actually, it appears to be as easy as the patch below. Or, I just could 
> just not know what the hell I'm talking about. 
> 
> Things appear to be working (with the eepro100 as a module)....
> 
> 	-pat
> 
> ===== drivers/base/driver.c 1.7 vs edited =====
> --- 1.7/drivers/base/driver.c	Wed Jun  5 15:59:31 2002
> +++ edited/drivers/base/driver.c	Thu Jun  6 16:13:35 2002
> @@ -67,9 +67,9 @@
>  	pr_debug("Registering driver '%s' with bus '%s'\n",drv->name,drv->bus->name);
>  
>  	get_bus(drv->bus);
> -	atomic_set(&drv->refcount,2);
>  	rwlock_init(&drv->lock);
>  	INIT_LIST_HEAD(&drv->devices);
> +	SET_MODULE_OWNER(drv);
>  	write_lock(&drv->bus->lock);
>  	list_add(&drv->bus_list,&drv->bus->drivers);
>  	write_unlock(&drv->bus->lock);

drivers/base is always compiled in. So SET_MODULE_OWNER will set the owner 
to NULL.

> -void remove_driver(struct device_driver * drv)
> +struct device_driver * get_driver(struct device_driver * drv)
>  {
> -	write_lock(&drv->bus->lock);
> -	atomic_set(&drv->refcount,0);
> -	list_del_init(&drv->bus_list);
> -	write_unlock(&drv->bus->lock);
> -	__remove_driver(drv);
> +	__MOD_INC_USE_COUNT(drv->owner);
> +	return drv;
>  }
>  
> -/**
> - * put_driver - decrement driver's refcount and clean up if necessary
> - * @drv:	driver in question
> - */
>  void put_driver(struct device_driver * drv)
>  {
> -	write_lock(&drv->bus->lock);
> -	if (!atomic_dec_and_test(&drv->refcount)) {
> -		write_unlock(&drv->bus->lock);
> -		return;
> -	}
> -	list_del_init(&drv->bus_list);
> -	write_unlock(&drv->bus->lock);
> -	__remove_driver(drv);
> +	__MOD_DEC_USE_COUNT(drv->owner);
>  }

So the __MOD_{INC,DEC}_USE_COUNT() should oops right here.
If you tested it and it doesn't oops, I don't understand why.

So, for one, if you want to go that road, you should use fops_get()/put()
(you can use just these, or rename them appropriately), they'll do the
right thing if a thing is modular as opposed to built-in (owner == NULL).

And, you need to set the owner from the module which you want to protect.

So in the your driver:

struct pci_driver my_drv {
	probe: ...
	driver : {
		owner: THIS_MODULE,
	}
}

which certainly is ugly since owner is in a sub-struct. But it's not
really a possibility anyway, since in this case pci_register_driver will 
do a MOD_INC_USE_COUNT and you never have a chance to call 
pci_unregister_driver() to decrement it again, since you need to have it
decremented before you can call pci_unregister_driver() (because
that's called from your module_exit() function).

--Kai

		

