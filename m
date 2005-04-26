Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVDZHNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVDZHNr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 03:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVDZHNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 03:13:47 -0400
Received: from user-edvans3.msk.internet2.ru ([217.25.93.4]:41416 "EHLO
	vocord.com") by vger.kernel.org with ESMTP id S261366AbVDZHMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 03:12:09 -0400
Subject: Re: [RFC/PATCH 0/22] W1: sysfs, lifetime and other fixes
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: dtor_core@ameritech.net
Cc: sensors@stimpy.netroedge.com, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
In-Reply-To: <d120d50005042514322a8c9e18@mail.gmail.com>
References: <200504210207.02421.dtor_core@ameritech.net>
	 <1114089504.29655.93.camel@uganda>
	 <d120d50005042107314cbacdea@mail.gmail.com>
	 <1114420131.8527.52.camel@uganda>
	 <d120d50005042509326241a302@mail.gmail.com>
	 <20050425232658.08f71275@zanzibar.2ka.mipt.ru>
	 <d120d50005042514322a8c9e18@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GgTtIIU8zO0Oiny8aHsa"
Organization: MIPT
Date: Tue, 26 Apr 2005 11:19:16 +0400
Message-Id: <1114499956.8527.100.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Tue, 26 Apr 2005 11:11:46 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GgTtIIU8zO0Oiny8aHsa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-04-25 at 16:32 -0500, Dmitry Torokhov wrote:
> On 4/25/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> >=20
> > How do you suppose to notify about alarm condition?
> > Not from bus layer?
> > Who does send "link is down" messages? It is not the same
> > as device is present and found, it like "w1 device has something to rea=
d".
> > For example w1 ds18s20 thermal sensor may send information
> > about "85 degree problem" - it is read when sensor did not
> > finished temerature transformation yet, how non-bus layer may know abou=
t it?
>=20
> Classes. And return -EAGAIN when reading is not ready (for some reason).

Device may be broken, btw, and return that value always.
How to notify about such condition?

> >=20
> > Your idea about classes over the various buses is good,
> > but unfortunately it is utopia, al least for now,
>=20
> It is not an utopia, it is Linux kernel and we do not need to get in
> unfinished solution.

That will require too many changes to say:=20
"hey, tomorrow we will have new generic w1/i2c/superio set".
I believe it can be done, it is definitely a good idea,=20
but let's fix existing bugs before changing the whole tree.

> > so let's create w1 core layer (which, btw, is not only bus,
> > which is managed by bus master dirver, but also some logic over it,
> > one may call it w1 stack, stack can send such a messages, doesn't it)?
> >=20
>=20
> Heh ;) Let's concentrate on sensors stack, please...

If we still have a bugs there, I do not think it is good idea=20
to move things ahead.
I repeat, I agree that unufied class hierarchy for sensors devices
is a very good idea, but it can not be implemented in a couple of days,
so I would pospone it until others bugs are fixed.

> > > >
> > > > As I said I have feature requests for ability to export w1 devices
> > > > outside w1 core.
> > > > Probably it is due to it's private non-GPL usage, so it is not crea=
ted,
> > > > but it is usefull feature actually and we can not know what will
> > > > happen in what context when we export master/slave devices.
> > >
> > > Look at your present w1_remove_master_device. It sleeps. Sop there is
> > > no need for a separate thread, callers must be able to sleep anyway.
> >=20
> > That is exactly why control thread exists - to manage sleepable operati=
ons!
>=20
> Read what I wrote again - if caller is sleeping on thread's completion
> there is really no need for a thread. The caller can do whetever
> thread does. Only if caller would send request and continue one woudl
> need to set up a thread.

Why do you think caller is in process context?
Control thread was created to process that work, which can not be done
in interrupt context, i.e. some command from unknown context
is deffered to control thread execution, which process it in a safe
context. Using connector for exaple you may send command REMOVE_*,
which will be received in BH context and just set the flag, which=20
will be seen by control thread.

> > > > w1 slaves can be found on the bus without search method reaction
> > > > implemented in it's asic, btw.
> > > > And it is _very_ usefull to add/remove slaves using external comman=
d but
> > > > not using
> > > > automatic detection in search methods.
> > >
> > > But the request for that will come from userspace with is perfectly
> > > able to sleep. You are over-engineering and making kernel code
> > > unnecessarily complex without thinking it through.
> >=20
> > Connector's requests come from BH context.
> > Only module unloading comes with good context  (in our case we do not
> > get read/write operations),
> > but I do not want to limit the system only for that kinds of events.
> >=20
>=20
> And you still have master's thread to manage slaves. Although I don't
> quite understand why you would need manual addition of slaves. Either
> they speak W1 protocol and will be added automatically, or they don't
> speak w1 and then they are not w1 devices.

There are w1 devices that do not respond to search command
[actually there are devices that understand only one command at all],=20
ok, they are broken, but it does not matter.

> > > > > > I have feature requests for both adding/removing and exporting
> > > > > > master devices and slaves to the external world.
> > > > >
> > > > > External as in userspace? It (user thread) can wait just fine...
> > > >
> > > > Exporting them into other kernel modules.
> > > > We do not know in what context that structures will be used there.
> > >
> > > Why other kernel modules would be interested in raw access w1_slaves?
> > > C are to give an example?
> >=20
> > Concider w1 battery slave device, which exports unified interface to
> > the userspace.
> > It requires access that can be obtained from different generic module
> > [like existing kernelspace/userspace protocol,
> > proper device files and so on],
> > which will implement only read/write interface.
> > It's read method will get_slave_by_something() and read it's data
> > or do something else, then generic module will use that data.
> >=20
> > Generic buttery monitor will not scan w1 bus for it's devices,
> > since it even does not know about w1, it only understands reading/writi=
ng
> > operations.
> >=20
>=20
> And here you are thinking of classes again. Writing separate battery
> monitor applets for i2c, w1, superio and the rest is not less silly.
> You are trying to move them over your ocnnector code. Alternatively
> you could have move them to class codes and build netlink notification
> on top of them. This way you'd separate buses (physical interface)
> with userpsace interfaces and allowed use of different transports.

No, connector is just an example.

Classes hierarchy for all sensor devices is good idea,=20
but not too easy to be implemeted.
I stronly agree with it and would like to port w1 to it.

Connector could be used to control that classes - just an example.

> > >
> > > Wrong level. You need to start with device implementing w1_bus_master
> > > (w1_bus_ops) to remova dangling data structures). Easiest way I think
> > > it have the driver compiled as a module and remove it altogether - wh=
y
> > > keep it if you don't need master?
> >=20
> > 1. master can be removed by command. It is not in process' context.
> > Current thread can remove only all object at once, but nevertheless
> > I do not want to limit it.
>=20
> You are also need to remove code controlling physical device presented
> as w1_master. The request will go do a different system (module).

No need to remove bus master device, it can be there with zero refcnt,
so when it will call w1_remove_master_device() it wouldn't block.

> > 2. control thread can add/remove new slaves by request.
> > Usefullness of that ability was pointed in my previous e-mail,
> > but you skipped that part.
>=20
> I am still missing usefullness of it.

There are devices that can not be found using w1 search commands,
there are devices that only understand one command,
I agree they are broken, but they still can be easily supported
by w1 subsystem.

> > >
> > > The less code in kernel that produces data availavle elsewhere the be=
tter :)
> >=20
> > Does 3 lines of code for reading slave's names is too big
> > price for not scanning the whole /sys/bus/w1/w1_master1/ directory?
> >
>=20
> How often do you use them? While debugging only?

Always.
With long line it is very common to lose w1 slaves - that is why it was
TTL=20
attribute created - it's purpose is to integrate such events.
With device like iButton it _IS_ thy _only_ behaviour - slave object
exists only couple of seconds.

>=20
> > > > > > > w1-master-cleanup.patch
> > > > > > >    Clean-up master device implementation:
> > > > > > >    - get rid of separate refcount, rely on driver model to en=
force
> > > > > > >      lifetime rules;
> > > > > > >    - use atomic to generate unique master IDs;
> > > > > > >    - drop unused fields.
> > > > > >
> > > > > > That patch is very broken.
> > > > > > I completely against it:
> > > > > > 1. it breaks process logic - searching can be interrupted and s=
topped,
> > > > > > thread will exit on signals.
> > > > >
> > > > > Interrupted/stopped from userspace?
> > > >
> > > > Your loop waits only until interrupt happens - it can be delivered =
from
> > > > anywhere.
> > >
> > > No, only root can kill kernel therad so it is pretty safe. And hey, i=
f
> > > a thread goes mad maybe it's a good thing that it can be killed.
> >=20
> > And if it exits - it breaks the logic - user can not know the state
> > of the master device when thread is exited, but module was not removed
> > by request.
> >=20
>=20
> I (as a root) have zillion ways to break the system. There is not hing
> new. The oint that an ordinary user can't do anything with that
> thread.

Signal can be sent not only by your request.

> > >
> > > device model is here to _use_ it. It already implements bunch of stuf=
f
> > > you have to re-implement if you do it "your own way" and it is alread=
y
> > > debugged much better than your solution. And if there is a problem
> > > with driver core implementation - well, more people are looking at it
> > > and are more likely to discover a problem and offer a solution.
> > >
> > > I do not understand why you are against full integration with device
> > > model - it does simplifies and unifies the code.
> >=20
> > Because it is not needed here - and even if it could be integrated
> > more closer - your changes broke too many special design cases,
> > which are not acceptible.
> >
>=20
> Having too many special design cases in otherwise pretty simple bus
> indicates that there something wrong with the design.

I see your point.

> > > > With such changes how to increment slave's usage counter? module_ge=
t
> > > > (w1_family)?
> > >
> > > Actually if you need it it would be get_device(&w1_slave->dev). And i=
f
> > > you need pin family object you would get
> > > get_driver(&w1_family->driver). But I don't think you will needed it.
> > > Actually, at some point I had w1_family_get() implemented as a wrappe=
r
> > > to get_driver() but since it does not seem to be needed I dropped it.
> >=20
> > We can not do it in that way.
> > 1. low-level bus master code differs from what w1_master is.
> > 2. family itself is different from slave object.
> >=20
> > Having that we need to create w1_master/w1_family device/driver model
> > locking + w1_bus_master/w1_slave locking or move them to device/driver
> > model too. Why it is needed I still do not see, there is
> > proper locking schema, which is broken in the places where
> > existing model touches device/driver one, and it will be fixed.
> >
>=20
> You have exactly the same problem with master devices too. What
> escapes me is the desire to have 2 separate refcounting for the same
> object. Except for ability to introduce 2x more bugs.

Yep.
As I said in previous e-mail - I do want to remove objects in any time,=20
so it has it's own locking schema, but I also do want to use sysfs
objects, so there is another locking schema - in the place they are
touch each other there is a problem and I will fix it,
probably  by moving object freeing into ->remove() callback.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-GgTtIIU8zO0Oiny8aHsa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCbet0IKTPhE+8wY0RAkBcAJ9qR07AFmPaSafQkeaYH1pM5PWjWwCfUsfV
59ybfVeoPTDreW30IWbTy7Q=
=zfqP
-----END PGP SIGNATURE-----

--=-GgTtIIU8zO0Oiny8aHsa--

