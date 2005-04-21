Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVDUNMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVDUNMp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 09:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVDUNMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 09:12:45 -0400
Received: from dea.vocord.ru ([217.67.177.50]:30949 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261356AbVDUNMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 09:12:03 -0400
Subject: Re: [RFC/PATCH 0/22] W1: sysfs, lifetime and other fixes
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: sensors@Stimpy.netroedge.com, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
In-Reply-To: <200504210207.02421.dtor_core@ameritech.net>
References: <200504210207.02421.dtor_core@ameritech.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LdaL8OsblPa5f6dxsUJf"
Organization: MIPT
Date: Thu, 21 Apr 2005 17:18:24 +0400
Message-Id: <1114089504.29655.93.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Thu, 21 Apr 2005 17:11:05 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LdaL8OsblPa5f6dxsUJf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-04-21 at 02:07 -0500, Dmitry Torokhov wrote:
> Hi,

Hello, Dmitry.

> I happened to take a look into drivers/w1 and found there bunch of thigs
> that IMO should be changed:
>=20
> - custom-made refcounting is racy

Why do you think so?
Did you find exactly the place which races against something?

> - lifetime rules need to be better enforced

Hmm, I misunderstand you.

> - family framework is insufficient for many advanced w1 devices

No, family framework is just indication which family is used.
Feel free to implement additional methods for various devices
and store them in driver's private areas like ipaq does.

> - custom-made hotplug notification over netlink should be removed in favo=
r
>   of standard hotplug notification

It is not hotplug, and your changes broke it completely.
I'm waiting for connector to be included or discarded, so I can move
w1 on top of it's interface or move connector's bits into the w1
subsystem.

> - sysfs attributes have unnecessary prefixes (like w1_master) or not need=
ed
>   at all (w1_master_pointer)

Yep, some of them can be suspicious from the first point of view.

> Please consider series of patches below. Unfortunately I do not have any =
W1
> equipment so it was only compile-tested. Please also note that lifetime a=
nd
> locking rules were changed on object-by-object base so mid-series some st=
uff
> may appear broken but as far as I can see the end result shoudl work pret=
ty
> well.


I can test your changes next week, but I already have too many
objections
to apply the whole patch set.

> w1-whitespace.patch
>    Whitespace fixes.
>=20
> w1-formatting.patch
>    Some formatting changes to bring the code in line with CodingStyle
>    guidelines.

Both above look ok, although they will not apply after patches
already sent to Greg but not yet in the tree are applied.

> w1-master-attr-group.patch
>    Use attribute_group to create master device attributes to guarantee
>    proper cleanup in case of failure. Also, hide most of attribute define
>    ugliness in macros.

Yep, I like it.

> w1-slave-attr-group.patc
>    Add 2 default attributes "family" and "serial" to slave devices, every
>    1-Wire slave has them. Use attribute_group to handle. The rest of slav=
e
>    attributes are left as is - will be dealt with later.

Serial number is already there in bus_id, family is there too.
Why do you need separate files?

> w1-lists-cleanup.patch
>    List handling cleanup. Most of the list_for_each_safe users don't need
>    *_safe variant, *_entry variant is better suited in most places. Also,
>    checking retrieved list element for null is a bit pointless...

Yep, it is correct.

> w1-drop-owner.patch
>    Drop owner field from w1_master and w1_slave structures. Just having i=
t
>    there does not magically fixes lifetime rules.

They do not even pretend, I still do not understand what is "lifetime
rules"?

> w1-bus-ops.patch
>    Cleanup bus operations code:
>    - have bus operatiions accept w1_master instead of unsigned long and
>      drop data field from w1_bus_master so the structure can be staticall=
y
>      allocated by driver implementing it;
>    - rename w1_bus_master to w1_bus_ops to avoid confusion with w1_master=
;
>    - separate master registering and allocation so drivers can setup prop=
er
>      link between private data and master and set useable master's name.

I strongly object against such changes.
1. w1 was designed in the way that w1 bus master drivers do not
know about other w1 world. It is very simple and very low-level
abstraction,
that only understands how to do low-level functions. It is not needed
do know about w1_master structure and even about it's existence.
2. All renaming are superfluous, I'm not against it, but completely do
not
understand it's merits.
3. You broke netlink allocation routing - it may fail and it is not
fatal.

> w1-fold-w1-int.patch
>    Fold w1_int.c into w1.c - there is no point in artificially separating
>    code for master devices between 2 files.

w1_int.c was created to store external interface implementation,=20
why do you want to move it into w1 core code?
It will only soil the code...

> w1-drop-netlink.patch
>    Drop custom-made hotplug over netlink notification from w1 core.
>    Standard hotplug mechanism should work just fine (patch will follow).

netlink notification was not created for hotplug.
Also I'm against w1 hotplug support, since hotplug is quite rarely used
in embedded platforms where the majority of w1 devices live.
I mean not to completely forget this idea,=20
but implement it in the way it will not hurt existing model.

> w1-drop-control-thread.patch
>    Drop control thread from w1 core, whatever it does can also be done in
>    the context of w1_remove_master_device. Also, pin the module when
>    registering new master device to make sure that w1 core is not unloade=
d
>    until last device is gone. This simplifies logic a lot.

Why do you think master can be removed in safe context only?
I have feature requests for both adding/removing and exporting
master devices and slaves to the external world.
Control thread is also the place in which we kick all devices
when we need it, but not only when we need to remove w1 core module.

> w1-move-search-to-io.patch
>    Move w1_search function to w1_io.c to be with the rest of IO code.

w1_search() is high-level protocol method, w1_io.c only contains
calls for low-level methods like bite/byte banging, reset, HW search and
so on.

> w1-master-drop-attrs.patch
>    Get rid of unneeded master device attributes:
>    - 'pointer' and 'attempts' are meaningless for userspace;
>    - information provided by 'slaves' and 'slave_count' can be gathered
>      from other sysfs bits;
>    - w1_slave_found has to be rearranged now that slave_count field is go=
ne.

attempts is usefull for broken lines.
pointer was definitely for debug, it can be removed now.

> w1-master-attr-cleanup.patch
>    Clean-up master attribute implementation:
>    - drop unnecessary "w1_master" prefix from attribute names;
>    - do not acquire master->mutex when accessing attributes;
>    - move attribute code "closer" to the rest of master code.

Ok, but slave count and slaves attributes itself requires that mutex.

> w1-master-scan-interval.patch
>    More master attributes changes:
>    - rename timeout parameter/attribute to scan_interval to better
>      reflect its purpose;
>    - make scan_timeout be a per-device attribute and allow changing
>      it from userspace via sysfs;
>    - allow changing max_slave_count it from userspace as well.

I like that change, but why do you ned to change the name?

> w1-master-add-ttl-attr.patch
>    Add slave_ttl attribute to w1 masters.

Ok.

> w1-master-cleanup.patch
>    Clean-up master device implementation:
>    - get rid of separate refcount, rely on driver model to enforce
>      lifetime rules;
>    - use atomic to generate unique master IDs;
>    - drop unused fields.

That patch is very broken.
I completely against it:
1. it breaks process logic - searching can be interrupted and stopped,
thread will exit on signals.
2. Your changes will break master/slave structure exporting.

> w1-slave-cleanup.patch
>    Clean-up slave device implementation:
>    - get rid of separate refcount, rely on driver model to enforce
>      lifetime rules;
>    - pin w1 module until slave device is registered with sysfs to make
>      sure W1 core stays loaded.
>    - drop 'name' attribute as we already have it in bus_id.

The same and even worse.

> w1-family-cleanup.patch
>    Clean-up family implementation:
>    - get rid of w1_family_ops and template attributes in w1_slave
>      structure and have family drivers create necessary attributes
>      themselves. There are too many different devices using 1-Wire
>      interface and it is impossible to fit them all into single
>      attribute model. If interface unification is needed it can be
>      done by building cross-bus class hierarchy.
>    - rename w1_smem to w1_sernum because devices are called Silicon
>      serial numbers, they have address (ID) but don't have memory
>      in regular sense.
>    - rename w1_therm to w1_thermal.

smem =3D=3D simple memory id, it is official name AFAIR.
Renames are superfluous, family_ops contains a "must have" operations,=20
driver writer can easily add it's own if it is needed.

> w1-family-is-driver.patch
>    Convert family into proper device-model drivers:
>    - embed driver structure into w1_family and register with the
>      driver core;
>    - do not try to manually bind slaves to familes, leave it to
>      the driver core;
>    - fold w1_family.c into w1.c

Why do you break it?
They were separated intentionally - it simplifies code review,=20
it is completely different logical models, family processing
is not hte same as slave.

> w1-device-id.patch
>    Support for automatic family drivers loading via hotplug:
>    - allow family drivers support list of families;
>    - export supported families through MODULE_DEVICE_TABLE.
>=20
> w1-hotplug.patch
>    Implement W1 bus hotplug handler. Slave devices will define
>    FID=3D%02x (family ID) end SN=3D%024llX environment variables.

I'm against hotplug since it is too embedded world unfriendly :)
Actually it can be added, but as option, but not rely
the whole logic on it.

> w1-module-attrs.patch
>    Allow changing w1 module parameters through sysfs, add parameter
>    descriptions and document them in Documentation/kernel-parameters.txt
>
> Thanks!

Thank you very much for your changes and ideas,=20
but as you can see I'm against several of it.
The main reason is why dig into the driver model in a such way?=20
It will complicate strucutre exporting too much.
Existing locking/refcnt schema is very flexible and allows device=20
manipulation while it "holds" the reference counter,=20
and it will not be possible if one just blindly gets/puts module's
refcnt.
Object has reference counter which is incremented and decremented when=20
object is in use, not the whole module reference counter,=20
one may remove and add separate objects without knowledge of
what family or bus master driver handles that.
Your changes mix low-level driver logic with w1 core.
You have removed netlink notification and replace it with hotplug,
but it can not be used for systems without shell userspace support.

I will manually apply safe changes after Adrians changes=20
when Greg ACKs current pending patches.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-LdaL8OsblPa5f6dxsUJf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCZ6ggIKTPhE+8wY0RAm3qAJ4v/jnx2JtJmdP89jo6QPyb9HcaSQCgjIA9
1eW1GYd3PtvnptVwgRlyFHQ=
=anQ8
-----END PGP SIGNATURE-----

--=-LdaL8OsblPa5f6dxsUJf--

