Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbUKIBaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbUKIBaD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 20:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbUKIBaC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 20:30:02 -0500
Received: from [211.58.254.17] ([211.58.254.17]:30945 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S261320AbUKIB1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 20:27:30 -0500
Date: Tue, 9 Nov 2004 10:27:22 +0900
From: Tejun Heo <tj@home-tj.org>
To: dtor_core@ameritech.net
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.10-rc1 2/5] driver-model: bus_recan_devices() locking fix
Message-ID: <20041109012722.GA20689@home-tj.org>
References: <20041104185826.GA17756@kroah.com> <20041104191258.77740.qmail@web81309.mail.yahoo.com> <20041105061439.GA27541@home-tj.org> <d120d50004110508333c183cc1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50004110508333c183cc1@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 11:33:37AM -0500, Dmitry Torokhov wrote:
> On Fri, 5 Nov 2004 15:14:39 +0900, Tejun Heo <tj@home-tj.org> wrote:
>
> >  Another problem I've encountered regarding kobject refcounting is
> > that currently each sysfs attr carries its owner and gets the owning
> > module when the attr is accessed.  However, there are attributes which
> > are provided not by the module which implements whatever the kobject
> > represents but by upper-level module or the kernel builtins.  So, it's
> > possible to unload a module while it's kobject is still alive by
> > holding on to such attributes, and, when the attribute is closed,
> > panic occurs, of course (release callback is unloaded already).
> > 
> 
> I actually spent quite few days thinking about this problem and here
> is what I come up with:
> 
> You have bus core module that provides generic release function for
> devices on the bus. When object is registered you bump up module
> count for the core module.
> You also have modues that provide devices. At device unregister time
> they do all device-specific cleanup, but leave attributes (and memory)
> handled by core modules intact. This allows to unload device module
> safely at any time and then when reference to the last generic attribute
> is dropped the generic cleanup finally removes last traces of the device.

 Are you suggesting splitting every bus implementation into two
separate modules?  Otherwise, we will have to move kobj field of every
bus-specific device structure to the head (to use the common release
function).  Either way, it can be done, but it just seems another
twist added to the already twisted refcounting.  Moreoever, not only
the devices are problematic, refcounting in class devices and block
device hierarchy seems broken too.

> <skip>
> > 
> > We can do one of
> > 
> > 1. add unload_sem to all driver-model structures.
> >        -> I believe this defeats the purpose of try_module_get()
> >        stuff.  We wouldn't know when the module will unload.
> > 
> 
> As Al Viro pointed out "rmmod module < /sys/bus/devices/xxxx/attr"
> will deadlock the kernel with this scheme.
> 
> > 2. get the owner field correct for all attributes.
> >        -> This will be a chore.  We'll need to allocate separate
> >        attr structures for each kobject for all the generic attrs.
> > 
> > 3. remove the owner field from the attribute structure and add an
> >    owner to kobject and make sysfs ops to hold the owner of the
> >    respective kobject.
> >        -> I think this is the best and most consistent solution.  As
> >        we already assume that module which implements a child kobject
> >        should depend upon the module which implements its parent, all
> >        attr module reference counting will be correct by using the
> >        kobject's owner.
> > 
> > So, I'm currently working on solution #3.
> > 
> 
> I think this is an overkill and will inflate every kobject out there,
> unless you will find a hole in my scheme...

 But all attrs will be deflated and it just seems the right thing to
do(tm).

-- 
tejun

