Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbUKIBux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbUKIBux (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 20:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbUKIBs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 20:48:56 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:62889 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261339AbUKIBn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 20:43:27 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.10-rc1 2/5] driver-model: bus_recan_devices() locking fix
Date: Mon, 8 Nov 2004 20:43:21 -0500
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
References: <20041104185826.GA17756@kroah.com> <d120d50004110508333c183cc1@mail.gmail.com> <20041109012722.GA20689@home-tj.org>
In-Reply-To: <20041109012722.GA20689@home-tj.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411082043.21818.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 November 2004 08:27 pm, Tejun Heo wrote:
> On Fri, Nov 05, 2004 at 11:33:37AM -0500, Dmitry Torokhov wrote:
> > On Fri, 5 Nov 2004 15:14:39 +0900, Tejun Heo <tj@home-tj.org> wrote:
> >
> > >  Another problem I've encountered regarding kobject refcounting is
> > > that currently each sysfs attr carries its owner and gets the owning
> > > module when the attr is accessed.  However, there are attributes which
> > > are provided not by the module which implements whatever the kobject
> > > represents but by upper-level module or the kernel builtins.  So, it's
> > > possible to unload a module while it's kobject is still alive by
> > > holding on to such attributes, and, when the attribute is closed,
> > > panic occurs, of course (release callback is unloaded already).
> > > 
> > 
> > I actually spent quite few days thinking about this problem and here
> > is what I come up with:
> > 
> > You have bus core module that provides generic release function for
> > devices on the bus. When object is registered you bump up module
> > count for the core module.
> > You also have modues that provide devices. At device unregister time
> > they do all device-specific cleanup, but leave attributes (and memory)
> > handled by core modules intact. This allows to unload device module
> > safely at any time and then when reference to the last generic attribute
> > is dropped the generic cleanup finally removes last traces of the device.
> 
>  Are you suggesting splitting every bus implementation into two
> separate modules?  Otherwise, we will have to move kobj field of every
> bus-specific device structure to the head (to use the common release
> function).  Either way, it can be done, but it just seems another
> twist added to the already twisted refcounting.  Moreoever, not only
> the devices are problematic, refcounting in class devices and block
> device hierarchy seems broken too.
>

It is already defacto implementation standard - every subsystem has a core
modules (pci, usbcore, serio) plus modules (drivers) actually talking to
hardware and registering devices (ports, whatever) with the corresponding
core. It is just a matter of splitting cleanup functions into core and
device-specific parts.
 
> > <skip>
> > > 
> > > We can do one of
> > > 
> > > 1. add unload_sem to all driver-model structures.
> > >        -> I believe this defeats the purpose of try_module_get()
> > >        stuff.  We wouldn't know when the module will unload.
> > > 
> > 
> > As Al Viro pointed out "rmmod module < /sys/bus/devices/xxxx/attr"
> > will deadlock the kernel with this scheme.
> > 
> > > 2. get the owner field correct for all attributes.
> > >        -> This will be a chore.  We'll need to allocate separate
> > >        attr structures for each kobject for all the generic attrs.
> > > 
> > > 3. remove the owner field from the attribute structure and add an
> > >    owner to kobject and make sysfs ops to hold the owner of the
> > >    respective kobject.
> > >        -> I think this is the best and most consistent solution.  As
> > >        we already assume that module which implements a child kobject
> > >        should depend upon the module which implements its parent, all
> > >        attr module reference counting will be correct by using the
> > >        kobject's owner.
> > > 
> > > So, I'm currently working on solution #3.
> > > 
> > 
> > I think this is an overkill and will inflate every kobject out there,
> > unless you will find a hole in my scheme...
> 
>  But all attrs will be deflated and it just seems the right thing to
> do(tm).
> 

I think there are much more kobjects than attrs.

-- 
Dmitry
