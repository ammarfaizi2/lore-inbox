Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbUKEQd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbUKEQd4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 11:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbUKEQd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 11:33:56 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:16974 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261254AbUKEQdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 11:33:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Sz1t2FBK7s+ACPk/F27qjN/S+0WDqADe6VyRhOA7kRAacu6QMqST0qGlMUVzNUep6Rq08BPia+XAe2OZh90Sne8N+k3VoLbuYq1EQX2Rn428hu9Jl2MIClpAVOIa7OctamcGV00nEi02CMV9axXMhdsJxi0soOFaw7kmodeeUkU=
Message-ID: <d120d50004110508333c183cc1@mail.gmail.com>
Date: Fri, 5 Nov 2004 11:33:37 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.10-rc1 2/5] driver-model: bus_recan_devices() locking fix
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041105061439.GA27541@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041104185826.GA17756@kroah.com>
	 <20041104191258.77740.qmail@web81309.mail.yahoo.com>
	 <20041105061439.GA27541@home-tj.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2004 15:14:39 +0900, Tejun Heo <tj@home-tj.org> wrote:
> Or maybe just adding a @write_lock argument to bus_for_each_*()
> functions or create a new function named __bus_for_each_*() which
> takes additional @write_lock argument.
> 
> However, I don't really think the get_bus/put_bus() calls are
> necessary there.  Unless the caller already has a reference to the
> bus, we're in trouble anyway.  get_bus() cannot synchronize with the
> last put_bus(), we need outer synchronization to protect that
> (individual bus drivers are expected to perform the synchronization).
> 

Yes I think you are right.

> One thing that bothers me is all the "if (kobject_get(x))" codes.
> Currently, it doesn't seem to do anything other than checking if x is
> NULL or not and incrementing the reference count.  i.e. the return
> value only represents if x is NULL or not.  I find the codes
> misleading.  It seems like above statement can synchronize get() and
> the last put() which isn't true.  I don't how how the using xchg in
> kref went, but with preemtion turned on, I don't see how it's gonna
> change the situation.
>

I agree it is somewhat misleading. And even if _get would synchronize
with _put taht wouldmean that the caller does not have a valid reference
and the kernel will crash there next time callers uses the object in
question.

I think we just have lay down the rules that one needs to get a reference
to an object in the following cases:
- object creation (first reference)
- linking some other object to the object in question. Every link to the
  object should increase reference count.
- before passing object to another thread of execution to guarantee that
  the object will live long enough for both threads.

This we can get rid of the litter in form:
if (get_bus(bus)) {
                sysfs_remove_file(&bus->subsys.kset.kobj, &attr->attr);
                put_bus(bus);
        }

sysfs_remove_file should do just fine by itself, if caller does not have bus
reference it's its fault.

Greg, what do you think?

> Well, I should write the following in another mail but I'll just
> continue here.
> 
>  Another problem I've encountered regarding kobject refcounting is
> that currently each sysfs attr carries its owner and gets the owning
> module when the attr is accessed.  However, there are attributes which
> are provided not by the module which implements whatever the kobject
> represents but by upper-level module or the kernel builtins.  So, it's
> possible to unload a module while it's kobject is still alive by
> holding on to such attributes, and, when the attribute is closed,
> panic occurs, of course (release callback is unloaded already).
> 

I actually spent quite few days thinking about this problem and here
is what I come up with:

You have bus core module that provides generic release function for
devices on the bus. When object is registered you bump up module
count for the core module.
You also have modues that provide devices. At device unregister time
they do all device-specific cleanup, but leave attributes (and memory)
handled by core modules intact. This allows to unload device module
safely at any time and then when reference to the last generic attribute
is dropped the generic cleanup finally removes last traces of the device.

<skip>
> 
> We can do one of
> 
> 1. add unload_sem to all driver-model structures.
>        -> I believe this defeats the purpose of try_module_get()
>        stuff.  We wouldn't know when the module will unload.
> 

As Al Viro pointed out "rmmod module < /sys/bus/devices/xxxx/attr"
will deadlock the kernel with this scheme.

> 2. get the owner field correct for all attributes.
>        -> This will be a chore.  We'll need to allocate separate
>        attr structures for each kobject for all the generic attrs.
> 
> 3. remove the owner field from the attribute structure and add an
>    owner to kobject and make sysfs ops to hold the owner of the
>    respective kobject.
>        -> I think this is the best and most consistent solution.  As
>        we already assume that module which implements a child kobject
>        should depend upon the module which implements its parent, all
>        attr module reference counting will be correct by using the
>        kobject's owner.
> 
> So, I'm currently working on solution #3.
> 

I think this is an overkill and will inflate every kobject out there,
unless you will find a hole in my scheme...

-- 
Dmitry
