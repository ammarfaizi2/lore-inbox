Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVDYVgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVDYVgu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 17:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVDYVgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 17:36:49 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:17843 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261214AbVDYVcM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 17:32:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EA7c9gQ6ALrvJ0q8xFX2J140D0VA/yHX2vXqo9CmtXiGgJ6Si5mZm3flsngiUFuqyyWhqZrGnjjIxeUbEViLk7l1f63zpQlkjx2fpBxdzQu4EtM9ddbUKTDJhB2+Sf1bXZBV0cOjHsmiWX39E1Kev0hiuM8whPwGWAtoABQJHi0=
Message-ID: <d120d50005042514322a8c9e18@mail.gmail.com>
Date: Mon, 25 Apr 2005 16:32:11 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: johnpol@2ka.mipt.ru
Subject: Re: [RFC/PATCH 0/22] W1: sysfs, lifetime and other fixes
Cc: sensors@stimpy.netroedge.com, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
In-Reply-To: <20050425232658.08f71275@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200504210207.02421.dtor_core@ameritech.net>
	 <1114089504.29655.93.camel@uganda>
	 <d120d50005042107314cbacdea@mail.gmail.com>
	 <1114420131.8527.52.camel@uganda>
	 <d120d50005042509326241a302@mail.gmail.com>
	 <20050425232658.08f71275@zanzibar.2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> 
> How do you suppose to notify about alarm condition?
> Not from bus layer?
> Who does send "link is down" messages? It is not the same
> as device is present and found, it like "w1 device has something to read".
> For example w1 ds18s20 thermal sensor may send information
> about "85 degree problem" - it is read when sensor did not
> finished temerature transformation yet, how non-bus layer may know about it?

Classes. And return -EAGAIN when reading is not ready (for some reason).

> 
> Your idea about classes over the various buses is good,
> but unfortunately it is utopia, al least for now,

It is not an utopia, it is Linux kernel and we do not need to get in
unfinished solution.

> so let's create w1 core layer (which, btw, is not only bus,
> which is managed by bus master dirver, but also some logic over it,
> one may call it w1 stack, stack can send such a messages, doesn't it)?
> 

Heh ;) Let's concentrate on sensors stack, please...

> > >
> > > As I said I have feature requests for ability to export w1 devices
> > > outside w1 core.
> > > Probably it is due to it's private non-GPL usage, so it is not created,
> > > but it is usefull feature actually and we can not know what will
> > > happen in what context when we export master/slave devices.
> >
> > Look at your present w1_remove_master_device. It sleeps. Sop there is
> > no need for a separate thread, callers must be able to sleep anyway.
> 
> That is exactly why control thread exists - to manage sleepable operations!

Read what I wrote again - if caller is sleeping on thread's completion
there is really no need for a thread. The caller can do whetever
thread does. Only if caller would send request and continue one woudl
need to set up a thread.

> > > w1 slaves can be found on the bus without search method reaction
> > > implemented in it's asic, btw.
> > > And it is _very_ usefull to add/remove slaves using external command but
> > > not using
> > > automatic detection in search methods.
> >
> > But the request for that will come from userspace with is perfectly
> > able to sleep. You are over-engineering and making kernel code
> > unnecessarily complex without thinking it through.
> 
> Connector's requests come from BH context.
> Only module unloading comes with good context  (in our case we do not
> get read/write operations),
> but I do not want to limit the system only for that kinds of events.
> 

And you still have master's thread to manage slaves. Although I don't
quite understand why you would need manual addition of slaves. Either
they speak W1 protocol and will be added automatically, or they don't
speak w1 and then they are not w1 devices.

> > > > > I have feature requests for both adding/removing and exporting
> > > > > master devices and slaves to the external world.
> > > >
> > > > External as in userspace? It (user thread) can wait just fine...
> > >
> > > Exporting them into other kernel modules.
> > > We do not know in what context that structures will be used there.
> >
> > Why other kernel modules would be interested in raw access w1_slaves?
> > C are to give an example?
> 
> Concider w1 battery slave device, which exports unified interface to
> the userspace.
> It requires access that can be obtained from different generic module
> [like existing kernelspace/userspace protocol,
> proper device files and so on],
> which will implement only read/write interface.
> It's read method will get_slave_by_something() and read it's data
> or do something else, then generic module will use that data.
> 
> Generic buttery monitor will not scan w1 bus for it's devices,
> since it even does not know about w1, it only understands reading/writing
> operations.
> 

And here you are thinking of classes again. Writing separate battery
monitor applets for i2c, w1, superio and the rest is not less silly.
You are trying to move them over your ocnnector code. Alternatively
you could have move them to class codes and build netlink notification
on top of them. This way you'd separate buses (physical interface)
with userpsace interfaces and allowed use of different transports.

> >
> > Wrong level. You need to start with device implementing w1_bus_master
> > (w1_bus_ops) to remova dangling data structures). Easiest way I think
> > it have the driver compiled as a module and remove it altogether - why
> > keep it if you don't need master?
> 
> 1. master can be removed by command. It is not in process' context.
> Current thread can remove only all object at once, but nevertheless
> I do not want to limit it.

You are also need to remove code controlling physical device presented
as w1_master. The request will go do a different system (module).

> 2. control thread can add/remove new slaves by request.
> Usefullness of that ability was pointed in my previous e-mail,
> but you skipped that part.

I am still missing usefullness of it.

> >
> > The less code in kernel that produces data availavle elsewhere the better :)
> 
> Does 3 lines of code for reading slave's names is too big
> price for not scanning the whole /sys/bus/w1/w1_master1/ directory?
>

How often do you use them? While debugging only?
 

> > > > > > w1-master-cleanup.patch
> > > > > >    Clean-up master device implementation:
> > > > > >    - get rid of separate refcount, rely on driver model to enforce
> > > > > >      lifetime rules;
> > > > > >    - use atomic to generate unique master IDs;
> > > > > >    - drop unused fields.
> > > > >
> > > > > That patch is very broken.
> > > > > I completely against it:
> > > > > 1. it breaks process logic - searching can be interrupted and stopped,
> > > > > thread will exit on signals.
> > > >
> > > > Interrupted/stopped from userspace?
> > >
> > > Your loop waits only until interrupt happens - it can be delivered from
> > > anywhere.
> >
> > No, only root can kill kernel therad so it is pretty safe. And hey, if
> > a thread goes mad maybe it's a good thing that it can be killed.
> 
> And if it exits - it breaks the logic - user can not know the state
> of the master device when thread is exited, but module was not removed
> by request.
> 

I (as a root) have zillion ways to break the system. There is not hing
new. The oint that an ordinary user can't do anything with that
thread.

> >
> > device model is here to _use_ it. It already implements bunch of stuff
> > you have to re-implement if you do it "your own way" and it is already
> > debugged much better than your solution. And if there is a problem
> > with driver core implementation - well, more people are looking at it
> > and are more likely to discover a problem and offer a solution.
> >
> > I do not understand why you are against full integration with device
> > model - it does simplifies and unifies the code.
> 
> Because it is not needed here - and even if it could be integrated
> more closer - your changes broke too many special design cases,
> which are not acceptible.
>

Having too many special design cases in otherwise pretty simple bus
indicates that there something wrong with the design.

> > > With such changes how to increment slave's usage counter? module_get
> > > (w1_family)?
> >
> > Actually if you need it it would be get_device(&w1_slave->dev). And if
> > you need pin family object you would get
> > get_driver(&w1_family->driver). But I don't think you will needed it.
> > Actually, at some point I had w1_family_get() implemented as a wrapper
> > to get_driver() but since it does not seem to be needed I dropped it.
> 
> We can not do it in that way.
> 1. low-level bus master code differs from what w1_master is.
> 2. family itself is different from slave object.
> 
> Having that we need to create w1_master/w1_family device/driver model
> locking + w1_bus_master/w1_slave locking or move them to device/driver
> model too. Why it is needed I still do not see, there is
> proper locking schema, which is broken in the places where
> existing model touches device/driver one, and it will be fixed.
>

You have exactly the same problem with master devices too. What
escapes me is the desire to have 2 separate refcounting for the same
object. Except for ability to introduce 2x more bugs.
 
-- 
Dmitry
