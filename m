Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262616AbUKEGOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262616AbUKEGOt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 01:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262618AbUKEGOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 01:14:48 -0500
Received: from [211.58.254.17] ([211.58.254.17]:46033 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262616AbUKEGOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 01:14:44 -0500
Date: Fri, 5 Nov 2004 15:14:39 +0900
From: Tejun Heo <tj@home-tj.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.10-rc1 2/5] driver-model: bus_recan_devices() locking fix
Message-ID: <20041105061439.GA27541@home-tj.org>
References: <20041104185826.GA17756@kroah.com> <20041104191258.77740.qmail@web81309.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104191258.77740.qmail@web81309.mail.yahoo.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello Dmitry,

On Thu, Nov 04, 2004 at 11:12:58AM -0800, Dmitry Torokhov wrote:
> Hmm, I do not like that the patch now fiddles with bus's rwsem before
> incrementing bus's refcount.

 Yes, I agree with you.

> I think just iterating through device list right the bus_rescan_devices
> will be good enough. I sent the patch together with other 3, did it get
> lost?

 Or maybe just adding a @write_lock argument to bus_for_each_*()
functions or create a new function named __bus_for_each_*() which
takes additional @write_lock argument.

 However, I don't really think the get_bus/put_bus() calls are
necessary there.  Unless the caller already has a reference to the
bus, we're in trouble anyway.  get_bus() cannot synchronize with the
last put_bus(), we need outer synchronization to protect that
(individual bus drivers are expected to perform the synchronization).

 One thing that bothers me is all the "if (kobject_get(x))" codes.
Currently, it doesn't seem to do anything other than checking if x is
NULL or not and incrementing the reference count.  i.e. the return
value only represents if x is NULL or not.  I find the codes
misleading.  It seems like above statement can synchronize get() and
the last put() which isn't true.  I don't how how the using xchg in
kref went, but with preemtion turned on, I don't see how it's gonna
change the situation.

 Well, I should write the following in another mail but I'll just
continue here.

  Another problem I've encountered regarding kobject refcounting is
that currently each sysfs attr carries its owner and gets the owning
module when the attr is accessed.  However, there are attributes which
are provided not by the module which implements whatever the kobject
represents but by upper-level module or the kernel builtins.  So, it's
possible to unload a module while it's kobject is still alive by
holding on to such attributes, and, when the attribute is closed,
panic occurs, of course (release callback is unloaded already).

 Modules which device_driver kobjects are okay because unload_sem is
used to prevent the module from unloading before it is released;
however, bus_type, class and class_device kobjects have this problem.
I found detach_state attr and all common USB attributes.  Also, all
class_device attributes, including simple_class dev attribute, which
are defined by the class it belongs to suffer this problem (allocated
by individual drivers but owned by the class).

 We can do one of

 1. add unload_sem to all driver-model structures.
	-> I believe this defeats the purpose of try_module_get()
	stuff.  We wouldn't know when the module will unload.

 2. get the owner field correct for all attributes.
	-> This will be a chore.  We'll need to allocate separate
	attr structures for each kobject for all the generic attrs.

 3. remove the owner field from the attribute structure and add an
    owner to kobject and make sysfs ops to hold the owner of the
    respective kobject.
	-> I think this is the best and most consistent solution.  As
	we already assume that module which implements a child kobject
	should depend upon the module which implements its parent, all
	attr module reference counting will be correct by using the
	kobject's owner.

 So, I'm currently working on solution #3.

 IMHO, we really need some kind of documentation describing the
synchronization, reference counting and behavior assumptions in the
driver-model.  It just seems a bit too subtle and fragile as it stands
now.

 Thanks.

-- 
tejun

