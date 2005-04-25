Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262548AbVDYJKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbVDYJKt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 05:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbVDYJKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 05:10:48 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:45258 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S262548AbVDYJIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 05:08:47 -0400
Subject: Re: [RFC/PATCH 0/22] W1: sysfs, lifetime and other fixes
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: dtor_core@ameritech.net
Cc: sensors@stimpy.netroedge.com, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
In-Reply-To: <d120d50005042107314cbacdea@mail.gmail.com>
References: <200504210207.02421.dtor_core@ameritech.net>
	 <1114089504.29655.93.camel@uganda>
	 <d120d50005042107314cbacdea@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IsfxLxYAyxvefsvRp2hV"
Organization: MIPT
Date: Mon, 25 Apr 2005 13:08:51 +0400
Message-Id: <1114420131.8527.52.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Mon, 25 Apr 2005 13:01:18 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IsfxLxYAyxvefsvRp2hV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-04-21 at 09:31 -0500, Dmitry Torokhov wrote:
> Hi Evgeniy,
>=20
> On 4/21/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > On Thu, 2005-04-21 at 02:07 -0500, Dmitry Torokhov wrote:
> > > Hi,
> >=20
> > Hello, Dmitry.
> >=20
> > > I happened to take a look into drivers/w1 and found there bunch of th=
igs
> > > that IMO should be changed:
> > >
> > > - custom-made refcounting is racy
> >=20
> > Why do you think so?
> > Did you find exactly the place which races against something?
> >=20
> > > - lifetime rules need to be better enforced
> >=20
> > Hmm, I misunderstand you.
> >
>=20
> Consider thie following:
>=20
> 451         while (atomic_read(&sl->refcnt)) {
> 452                 printk(KERN_INFO "Waiting for %s to become free:
> refcnt=3D%d.\n",
> 453                                 sl->name, atomic_read(&sl->refcnt));
> 454=20
> 455                 if (msleep_interruptible(1000))
> 456                         flush_signals(current);
> 457         }
> 458=20
> 459         sysfs_remove_bin_file (&sl->dev.kobj, &sl->attr_bin);
> 460         device_remove_file(&sl->dev, &sl->attr_name);
> 461         device_remove_file(&sl->dev, &sl->attr_val);
> 462         device_unregister(&sl->dev);
> 463         w1_family_put(sl->family);
> .. And caller does kfree(sl);
>=20
> Now, if application opens slave's sysfs attribute while other thread
> exited the loop and is about to remove attributes, then you will kfree
> object that is in use and who knows what will happen. This is example
> of both refcounting being racey and lifetime rules being violated.

Yes, I see now.
I will think of it some more...

> > > - family framework is insufficient for many advanced w1 devices
> >=20
> > No, family framework is just indication which family is used.
> > Feel free to implement additional methods for various devices
> > and store them in driver's private areas like ipaq does.
> >
>=20
> OK, that is what I am aying. But why do you need that attribute with
> variable name and a bin attribute that is not really bin but just a
> dump for all kind of data (looks like debug one).

bin attribute was created for lm_sensors scripts format - it only caches
read value.
I think there might be only 2 "must have" methods - read and write.
I plan to implement them using connector, so probably they will go away
completely.

> > > - custom-made hotplug notification over netlink should be removed in =
favor
> > >   of standard hotplug notification
> >=20
> > It is not hotplug, and your changes broke it completely.
> > I'm waiting for connector to be included or discarded, so I can move
> > w1 on top of it's interface or move connector's bits into the w1
> > subsystem.
> >
>=20
> You will not be able to cram all 1-wire devices into unified
> interface. You will need to build classes on top of it and you might
> use connector (I am not sure) bit not on w1 bus level.
> ...

connector allows to have different objects inside one netlink group,=20
so it will use it in that way.
I think only two w1 methods must exist - read and write,=20
and they must follow protocol, defined in family driver.


> > > w1-drop-owner.patch
> > >    Drop owner field from w1_master and w1_slave structures. Just havi=
ng it
> > >    there does not magically fixes lifetime rules.
> >=20
> > They do not even pretend, I still do not understand what is "lifetime
> > rules"?
>=20
> So there is no point in having them, right?=20

If I understand you correctly, "lifetime rules" are implemented in a
following way:
when object is created it has 0 refcnt, each access increments it and
must=20
decrements when access is finished.
According to mix of sysfs vs. current refcnt I see a possibility to
free object in ->relese()/remove() method and that is all, but I need to
investigate it more deeply.

> >=20
> > > w1-bus-ops.patch
> > >    Cleanup bus operations code:
> > >    - have bus operatiions accept w1_master instead of unsigned long a=
nd
> > >      drop data field from w1_bus_master so the structure can be stati=
cally
> > >      allocated by driver implementing it;
> > >    - rename w1_bus_master to w1_bus_ops to avoid confusion with w1_ma=
ster;
> > >    - separate master registering and allocation so drivers can setup =
proper
> > >      link between private data and master and set useable master's na=
me.
> >=20
> > I strongly object against such changes.
> > 1. w1 was designed in the way that w1 bus master drivers do not
> > know about other w1 world. It is very simple and very low-level
> > abstraction,
> > that only understands how to do low-level functions. It is not needed
> > do know about w1_master structure and even about it's existence.
>=20
> Well, it does need to know about w1_bus_master structure, which is
> pretty much the same. And it allows having static bus_ops allocation
> and removes need for casting from unsigned longs...

w1_bus_master structure is low-level physical operations.
It _completely_ does not know abou logical links to other
w1 core objects, Why _bus_ driver should know about logical
objects on top of it? That is why they are separate.
Even if they are not too different (and actually they _are_ different)
from your point of view, they differ in abstration model.
Bus master driver - is like NIC driver, it does not know about the rest
of
the network stack, but you want it to have all info about neighbours,
routes
and so on...

> > 2. All renaming are superfluous, I'm not against it, but completely do
> > not
> > understand it's merits.
>=20
> Because now it represents operations only, data field has been
> dropped. I my head hurt when I see w1_master and w1_bus_muster
> together as 2 separate objects both representing the same piece of
> hardware.

No.

w1_bus_master is low-level driver for physical hardware operations.
w1_master is logical structure which is operated by w1 w1 core stack.
It has it's logical slaves, it has it's own attributes and features,
it _completely_ does not belong to low-level physical layer where you
want to place them both.

> > 3. You broke netlink allocation routing - it may fail and it is not
> > fatal.
>=20
> Because it is going away in later patcehs ;)

This is wrong - netlink notification is used and will be moved to
connector
interface later.

> >=20
> > > w1-fold-w1-int.patch
> > >    Fold w1_int.c into w1.c - there is no point in artificially separa=
ting
> > >    code for master devices between 2 files.
> >=20
> > w1_int.c was created to store external interface implementation,
> > why do you want to move it into w1 core code?
> > It will only soil the code...
>=20
> Because I do not understand why code creating master devices is
> separate from code creating master device's attributes.

It is better to move all attributes inside code creating master device
so place that attribute creating into w1_int.c

> >=20
> > > w1-drop-netlink.patch
> > >    Drop custom-made hotplug over netlink notification from w1 core.
> > >    Standard hotplug mechanism should work just fine (patch will follo=
w).
> >=20
> > netlink notification was not created for hotplug.
> > Also I'm against w1 hotplug support, since hotplug is quite rarely used
> > in embedded platforms where the majority of w1 devices live.
>=20
> kobject_uevent does notification over netlink so I do not understand
> why custom approach is better. You don't really need to use script.

kobject is too big for that. It is used exactly for kobject changes.
Custom netlink notifications are created for w1 specific objects
and it's control. You can not control w1 slaves/masters using hotplug.

> > > w1-drop-control-thread.patch
> > >    Drop control thread from w1 core, whatever it does can also be don=
e in
> > >    the context of w1_remove_master_device. Also, pin the module when
> > >    registering new master device to make sure that w1 core is not unl=
oaded
> > >    until last device is gone. This simplifies logic a lot.
> >=20
> > Why do you think master can be removed in safe context only?
>=20
> Can you show me example where you remove master from an interrupt
> context or a tasklet? I doubt you will ever see one.

As I said I have feature requests for ability to export w1 devices
outside w1 core.
Probably it is due to it's private non-GPL usage, so it is not created,=20
but it is usefull feature actually and we can not know what will=20
happen in what context when we export master/slave devices.
w1 slaves can be found on the bus without search method reaction=20
implemented in it's asic, btw.
And it is _very_ usefull to add/remove slaves using external command but
not using
automatic detection in search methods.
=20
> > I have feature requests for both adding/removing and exporting
> > master devices and slaves to the external world.
>=20
> External as in userspace? It (user thread) can wait just fine...

Exporting them into other kernel modules.
We do not know in what context that structures will be used there.

> > Control thread is also the place in which we kick all devices
> > when we need it, but not only when we need to remove w1 core module.
>=20
> Define kicking for me please...

Removing master device using netlink command for exaple.

> >=20
> > > w1-move-search-to-io.patch
> > >    Move w1_search function to w1_io.c to be with the rest of IO code.
> >=20
> > w1_search() is high-level protocol method, w1_io.c only contains
> > calls for low-level methods like bite/byte banging, reset, HW search an=
d
> > so on.
>=20
> Well it does bit banging and completely foreign to the rest of w1
> code. It may be high-level operation as fas as 1-wire on-wire protocol
> goes, but it surely does not belong with kernel's W1 bus
> implementattion code.

It does not only low-level operations,=20
but, well, probably it is better to place it there.

> > > w1-master-attr-cleanup.patch
> > >    Clean-up master attribute implementation:
> > >    - drop unnecessary "w1_master" prefix from attribute names;
> > >    - do not acquire master->mutex when accessing attributes;
> > >    - move attribute code "closer" to the rest of master code.
> >=20
> > Ok, but slave count and slaves attributes itself requires that mutex.
>=20
> They are gone. You can scan sysfs to get your slaves and count. Kernel
> does not need to do that.

I created that files exactly for reaason to not scan the tree, but only=20
read one [two] files :)

> > > w1-master-scan-interval.patch
> > >    More master attributes changes:
> > >    - rename timeout parameter/attribute to scan_interval to better
> > >      reflect its purpose;
> > >    - make scan_timeout be a per-device attribute and allow changing
> > >      it from userspace via sysfs;
> > >    - allow changing max_slave_count it from userspace as well.
> >=20
> > I like that change, but why do you ned to change the name?
>=20
> Because nothing times out (as in error). It defines interval between
> scans -> scan_interval.

Ok.

> > > w1-master-cleanup.patch
> > >    Clean-up master device implementation:
> > >    - get rid of separate refcount, rely on driver model to enforce
> > >      lifetime rules;
> > >    - use atomic to generate unique master IDs;
> > >    - drop unused fields.
> >=20
> > That patch is very broken.
> > I completely against it:
> > 1. it breaks process logic - searching can be interrupted and stopped,
> > thread will exit on signals.
>=20
> Interrupted/stopped from userspace?

Your loop waits only until interrupt happens - it can be delivered from
anywhere.

> > 2. Your changes will break master/slave structure exporting.
>=20
> -ENEEDMOREDATA.

I think I described it in a master exporting paragraph, let's drop it
here.

> >=20
> > > w1-slave-cleanup.patch
> > >    Clean-up slave device implementation:
> > >    - get rid of separate refcount, rely on driver model to enforce
> > >      lifetime rules;
> > >    - pin w1 module until slave device is registered with sysfs to mak=
e
> > >      sure W1 core stays loaded.
> > >    - drop 'name' attribute as we already have it in bus_id.
> >=20
> > The same and even worse.
>
> You need to fix lifetime rules.

You moved all lto device model, while I want to have existing model
due to described actions.
So the right solution is to not break all existing locking, which
is mixed with device driver model, but create preper interoperability
model.
I will think of it some more, I will integrate your ad Adrian Bunk's=20
cleanups first when current pending patches are pushed.

> > > w1-family-cleanup.patch
> > >    Clean-up family implementation:
> > >    - get rid of w1_family_ops and template attributes in w1_slave
> > >      structure and have family drivers create necessary attributes
> > >      themselves. There are too many different devices using 1-Wire
> > >      interface and it is impossible to fit them all into single
> > >      attribute model. If interface unification is needed it can be
> > >      done by building cross-bus class hierarchy.
> > >    - rename w1_smem to w1_sernum because devices are called Silicon
> > >      serial numbers, they have address (ID) but don't have memory
> > >      in regular sense.
> > >    - rename w1_therm to w1_thermal.
> >=20
> > smem =3D=3D simple memory id, it is official name AFAIR.
> > Renames are superfluous, family_ops contains a "must have" operations,
> > driver writer can easily add it's own if it is needed.
>=20
> What is so "must have" about 2 attributes? smem does not need anything
> for exampe...

It is not read and read_bin, but read and write.
I have not implemented write methods monthes ago since I did not
have such a hardware, but now I see it was bad decision which
confused people.

> > > w1-family-is-driver.patch
> > >    Convert family into proper device-model drivers:
> > >    - embed driver structure into w1_family and register with the
> > >      driver core;
> > >    - do not try to manually bind slaves to familes, leave it to
> > >      the driver core;
> > >    - fold w1_family.c into w1.c
> >=20
> > Why do you break it?
> > They were separated intentionally - it simplifies code review,
> > it is completely different logical models, family processing
> > is not hte same as slave.
>=20
> Masters, slaves and families are all objects of W1 kernel bus. With
> cutting a bunch of fat from family code it does not make sense to keep
> them separate anymore.

What you do is exactly the same that already exist, but using other
model.
No need to dig into device model in a such way.

> > Thank you very much for your changes and ideas,
> > but as you can see I'm against several of it.
> > The main reason is why dig into the driver model in a such way?
> > It will complicate strucutre exporting too much.
>=20
> Because it is the standard for implementing devies and drivers in
> linux kernel. You need to explain about exporting structure since the
> rest of the system seem to be doing just fine.
>=20
> > Existing locking/refcnt schema is very flexible and allows device
> > manipulation while it "holds" the reference counter,
>=20
> It is also racy and buggy.

It is not.
You pointed an error, and it will be fixed after I think about it some
more,
the problem is that device model[which is not the main part of the w1
system]
is interfere to the existing locking schema [which is quite big and
allows very flexible object manipulation], and you suggest to almost
completely
replace one with another.
With such changes how to increment slave's usage counter? module_get
(w1_family)?

> > and it will not be possible if one just blindly gets/puts module's
> > refcnt.
>=20
> Only wire.ko is pinned. You are still free to remove family drivers or
> master drivers (or killing their objects somehow). It is only core
> that is pinned to make sure that release functions are available when
> object finally goes away.

If we remove slave deivice, we must be sure it's object is freed=20
when appripriate kobject is released.
The same is with family itself.

No, we need either replace all locking with device driver model,=20
or properly operate with existing one.
I will investigate it deeply, I'm sure will will find the best=20
solution.

> > Object has reference counter which is incremented and decremented when
> > object is in use, not the whole module reference counter,
> > one may remove and add separate objects without knowledge of
> > what family or bus master driver handles that.
>=20
> > Your changes mix low-level driver logic with w1 core.
> > You have removed netlink notification and replace it with hotplug,
> > but it can not be used for systems without shell userspace support.
>=20
> kobject_uevent does not requere a sehll account.

Exactly as existing netlink notifications, which allows=20
to bring not only simple predefined actions, but any information you
like.
As you said, we can not fit all existing w1 devices into very confined=20
limits, so hotplug events which are add/remove can not solve the
whole notification problem.
Simple notification mechanism that was created for w1 is only first
step,
of course it can be replaced with hotplug notification,
but only it, if we want, and I strongly believe we will want, to extend
it a bit we will fail with current hotplug approach.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-IsfxLxYAyxvefsvRp2hV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCbLOjIKTPhE+8wY0RAh66AJ9DTVJQCSSW/NP9T2lenylnxs5YXwCgmKIh
QweZUhtNeVTK/74QOL6nkng=
=NkXi
-----END PGP SIGNATURE-----

--=-IsfxLxYAyxvefsvRp2hV--

