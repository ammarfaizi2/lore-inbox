Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262949AbTCKPl1>; Tue, 11 Mar 2003 10:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262952AbTCKPl1>; Tue, 11 Mar 2003 10:41:27 -0500
Received: from air-2.osdl.org ([65.172.181.6]:26314 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262949AbTCKPl0>;
	Tue, 11 Mar 2003 10:41:26 -0500
Date: Tue, 11 Mar 2003 09:27:27 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Greg KH <greg@kroah.com>, Oliver Neukum <oliver@neukum.name>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: PCI driver module unload race?
In-Reply-To: <Pine.LNX.4.44.0303111200070.5042-100000@serv>
Message-ID: <Pine.LNX.4.33.0303110916540.1003-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Somehow you have to protect dev->driver, you cannot resolve the driver 
> pointer without holding the bus lock or holding a reference. If you don't 
> get a reference, any access via this pointer must be done under the bus 
> lock.

struct device_driver has a separate reference count than the module 
reference count. In the driver core, this reference count is used. It is 
acquired by taking the bus's lock. 

The module refcount isn't used, because it resides in the driver, so we 
have to guarantee we can dereference the pointer before we deref the 
pointer to increment the refcount. It's a bloody mess, and we work around 
it. 

The driver has an unload_sem that is locked until the driver's refcount 
goes to 0. When it does, it's unlocked. A driver_unregister() call will 
try and take this semaphore while unregistering, meaning it will block 
until outstanding references go away. 

I don't particularly love it, but it's simple enough and it works.  
Ideally, we'd have one reference count and this wouldn't be an issue.  
However, with the evolution of the driver core and the module core in 2.5,
these details haven't had a chance to be worked. I hope in 2.7, we can
achieve more unification between the two. 

> > Yeah, I still think there are some nasty issues with regards to being in
> > a sysfs directory, with a open file handle, and the module is removed.
> > But I haven't checked stuff like that in a while.
> > 
> > CONFIG_MODULE_UNLOAD, just say no.
> 
> That's certainly an option, but I'm afraid not too many people will do 
> this.

Greg, and Rusty, are right. Dealing with this is a PITA, and I think will 
always be. I'm willing to take the Nancy Reagan platform, too. 


	-pat

