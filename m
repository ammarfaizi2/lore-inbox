Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316434AbSGIQ5L>; Tue, 9 Jul 2002 12:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316605AbSGIQ5K>; Tue, 9 Jul 2002 12:57:10 -0400
Received: from air-2.osdl.org ([65.172.181.6]:11136 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316434AbSGIQ5I>;
	Tue, 9 Jul 2002 12:57:08 -0400
Date: Tue, 9 Jul 2002 09:56:55 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Driverfs updates 
In-Reply-To: <21467.1026171204@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.33.0207090947140.961-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jul 2002, Keith Owens wrote:

> On Mon, 8 Jul 2002 11:41:52 -0700 (PDT), 
> Patrick Mochel <mochel@osdl.org> wrote:
> >- Add struct module * owner field to struct device_driver
> >- Change {get,put}_driver to use it
> 
> struct device_driver * get_driver(struct device_driver * drv)
> {
>         if (drv && drv->owner)
>                 if (!try_inc_mod_count(drv->owner))
>                         return NULL;
>         return drv;
> }
> 
> is racy.  The module can be unloaded after if (drv->owner) and before
> try_inc_mod_count.  To prevent that race, drv itself must be locked
> around calls to get_driver().
> 
> The "normal" method is to have a high level lock that controls the drv
> list and to take that lock in the register and unregister routines and
> around the call to try_inc_mod_count.  drv->bus->lock is no good,
> anything that relies on reading drv without a lock or module reference
> count is racy.  I suggest you add a global driverfs_lock.

This race really sucks. 

Adding a high level lock is no big deal, but I don't think it will solve 
the problem. Hopefully you can educate me a bit more. 

If you add a driver_lock, you might have something like:

	struct device_driver * d = NULL;

	spin_lock(&driver_lock);
	if (drv && drv->owner)
		if (try_inc_mod_count(drv->owner))
			d = drv;

	spin_unlock(&driver_lock):
	return d;

...but, what if someone has unloaded the module before you get to the if 
statement? The memory for the module has been freed, including drv itself. 

How do you protect against that? The simplest solutions, given the current 
infrastructure, are:

- The BKL
- Not allowing module unload
- Ignoring it, and hoping it goes away

None of those solutions are ideal, though I don't have any bright ideas 
off the top of my head.

	-pat

