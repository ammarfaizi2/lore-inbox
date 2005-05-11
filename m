Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVEKGnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVEKGnH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 02:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVEKGnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 02:43:07 -0400
Received: from user-edvans3.msk.internet2.ru ([217.25.93.4]:41353 "EHLO
	vocord.com") by vger.kernel.org with ESMTP id S261877AbVEKGmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 02:42:46 -0400
Subject: Re: [1/1] connector/CBUS: new messaging subsystem. Revision number
	next.
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: dmitry.torokhov@gmail.com, netdev@oss.sgi.com, Greg KH <greg@kroah.com>,
       Jamal Hadi Salim <hadi@cyberus.ca>, Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       James Morris <jmorris@redhat.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Thomas Graf <tgraf@suug.ch>, Jay Lan <jlan@engr.sgi.com>
In-Reply-To: <200505110046.28797.dtor_core@ameritech.net>
References: <20050411125932.GA19538@uganda.factory.vocord.ru>
	 <d120d500050510105012d4ba8b@mail.gmail.com>
	 <20050510222424.5b411c89@zanzibar.2ka.mipt.ru>
	 <200505110046.28797.dtor_core@ameritech.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ie3WZAlwwj3NWxta+but"
Organization: MIPT
Date: Wed, 11 May 2005 10:48:50 +0400
Message-Id: <1115794130.6096.30.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Wed, 11 May 2005 10:41:09 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ie3WZAlwwj3NWxta+but
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-05-11 at 00:46 -0500, Dmitry Torokhov wrote:

> > > > > >
> > > > > > > - drop cn_dev - there is only one connector;
> > > > > >
> > > > > > There may be several connectors with different socket types.
> > > > > > I use it in my environment for tests.
> > > > > >
> > > > >
> > > > > Why do you need that? u32 ID space is not enough?
> > > >=20
> > > > They use different netlink sockets.
> > > > One of them can fail during initialisation, for example...
> > >=20
> > > Are you saying that there more chances successfully allocating 2
> > > netlink sockets than one?
> >=20
> > Of course - one may be in use by ipt_ULOG for example.
>=20
> And what does it have to do with multiple connectors and different socket=
s?
> You just need to find one free socket, once you found it you have only on=
e
> instance of connector running.

Because one connector may be added for general-purpose socket like
existing one,
any other connectors can be added for different transport layer for
example.

> > Although probably it could be better to get new unit from David Miller.
> > I want to create some kind of unused-in-kernel socket number -=20
> > each netlink user outside kernel might use it without kernel users
> > bothering.
>=20
> Right.
>=20
> > > >=20
> > > > > > > - simplify cn_notify_request to carry only one range - it sim=
plifies code
> > > > > > >   quite a bit - nothing stops clientd from sending several no=
tification
> > > > > > >   requests;
> > > > > >
> > > > > > ? Nothing stops clients from sending several notification reque=
sts now.
> > > > > > I do not see how it simplifies the things?
> > > > > > Feel free to set idx_num and val_num to 1 and you will have the=
 same.
> > > > >
> > > > > Compare the implementaion - without variable-length notification
> > > > > requests the code is much simplier and flexible.
> > > >=20
> > > > Hmm, old request had a length, new one - does not.
> > > > But instead of atomically addition of the whole set, one need to se=
nd
> > > > couple of events.
> > > > I do not see any profit here.
> > >=20
> > > Smaller kernel code, simpler notification structure, ability to stop
> > > listenig to a certain events without re-registering the rest of the
> > > block.
> >=20
> > As I said - set idx and val numbers to one and you will have the same=20
> > behaviour.
> > Code is neither smaller [ok, you removed a loop] nor simplier=20
> >  - it is functionality decreasing.
>=20
> Actually, I would do yet another step and just put something like
>=20
> int cn_request_notify(u32 group, u32 idx, u32 idx_range, u32 val, u32 val=
_range)
> int cn_cancel_notify(u32 group, u32 idx, u32 idx_range, u32 val, u32 val_=
range)
>=20
> into connector core. Then drivers could do something like this:
>=20
> static int cn_test_want_notify(void)
> {
>         int error;
>=20
> 	error =3D cn_request_notify(1, cn_test_id.idx, 10, cn_test_id.val, 10);
>         if (error)
> 		return error;
>=20
> 	error =3D cn_request_notify(1, cn_test_id.idx, 10, cn_test_id.val + 20, =
10);
> 	if (error) {
> 		/* unregister */
> 		cn_cancel_notify(1, cn_test_id.idx, 10, cn_test_id.val, 10);
> 		return error;
> 	}
>=20
>         return 0;
> }
>=20
> No messing up with memory allocations and complex message structures.

Yep, it could be done, but it has nothing in common
with request structure changes.
I will place it into TODO, thanks.

> > > > > > Connector with your changes just does not work.
> > > > >
> > > > > As in "I tried to run it and adjusted the application for the new
> > > > > cn_notify_req size and it does not work" or "I am saying it does =
not
> > > > > work"?
> > > >=20
> > > > Second, i.e. "I am saing it does not work".
> > > > With your changes userspace just does not see any message being sen=
t by kernelspace.
> > >=20
> > > Would you care to elaborate on this please. As far as I know
> > > kernel->userspace path was not changed at all.
> >=20
> > I inserted your module and test module, which sends a message using cn_=
netlink_send()
> > one time per second.
> > Usersace application bound to -1 group does not receive that messages.
>=20
> Works for me:
>=20
> root@core cntest]# ./a.out
> recvfrom successful
> counter =3D 0
> recvfrom successful
> counter =3D 1
> recvfrom successful
> counter =3D 2
> recvfrom successful
> counter =3D 3
> recvfrom successful
> counter =3D 4
> recvfrom successful
> counter =3D 5
> recvfrom successful
> counter =3D 6
> recvfrom successful
> counter =3D 7
> recvfrom successful
> counter =3D 8
>=20
> (I won't ever show anyone that gutted piece of ulogd that produced these
> messages :) )
> =20
> Try recompiling your userspace application, messages were changed a bit.

I recompiled everything - still does not work.
Application is just reading from socket after polling, it even does not
know about messages itself.

> > > > > > Dmitry, I do not understand why do you change things in so radi=
cal manner,
> > > > > > especially when there are no 1. new interesting features, 2. no=
 performance
> > > > > > improvements, 3. no right design changes.
> > > > >
> > > > > There is a right design change - it keeps the code simple. It pee=
ls
> > > > > all the layers you invented for something that does not really ne=
ed
> > > > > layers - connector is just a simple wrapper over raw netlink.
> > > >=20
> > > > That is your opinion.
> > > >=20
> > > > Code is already as simple as possible, since it is layered and each
> > > > piece of code is separated from different logical entities.
> > > >=20
> > > > > When I look at the code I see the mess of unneeded refcounting, w=
rong
> > > > > kinds of locking, over-engineering. Of course I want to change it=
.
> > > >=20
> > > > There are no unneded reference counting now.
> > > > Locking was not wrong - you only placed semaphore instead of notify=
 BH lock
> > > > just to have ability to sleep under the lock and send callback addi=
tion/removing
> > > > notification with GFP_KERNEL mask,
> > > > and it is probably right change from the first view, as I said,
> > > > but it can be implemented in a different way.
> > >=20
> > > That's what I was referring to as "wring locking". Notifications do
> > > not need to stop bottom handlers, a spinlock or semaphore willl work
> > > just fine. SInce I wanted to allocate memory only after I determined
> > > that it is a new  notify request a semaphore was a better choise.
> >=20
> > I will think of it, but in long-time I do not like such approach -=20
> > it is some kind of deadlock - we have no memory, so we sleep in allocat=
ion,
> > so we can not remove callback since it will sleep in allocation...
>=20
> There is no deadlock. We are not waiting for memory to be freed, we are
> waiting for paging.

Yep. That is why pool is better.
Actually I even want some kind of pools for skb, but do not think it
will be a good idea.
That will require several of them for different sizes and so on...

> > > > > Keep it simple. Except for your testing environment why do you ne=
ed to
> > > > > have separate netlink sockets? You have an ample ID space. Why do=
 you
> > > > > need separate cn_dev and cn_queue_dev (and in the end have them a=
t
> > > > > all)? Why do you need "input" handler, do you expect to use diffe=
rent
> > > > > handlers? If so which? And why? Do you expect to use other transp=
orts?
> > > > > If so which? And why? You need to have justifiction for every
> > > > > additional layer you putting on.
> > > >=20
> > > > Sigh.
> > > > It was already answered so many times, as far as I remember...
> > > > Ok, let's do it again.
> > > >=20
> > > > Several netlink sockets - if you can see, connector uses NETLINK_UL=
OG
> > > > for it's notification, you can not use the same socket twice, so yo=
u
> > > > may have new device with new socket, or several of them, and system
> > > > may work if one initialisation failed.
> > >=20
> > > Or it may not. Why do you think that having several sockets is safer
> > > than using one? After all, it is just a matter of setting it up and
> > > finally allocating a separate socket number for connector.
> >=20
> > Yes, there can be such a way.
> > But when connector was not in mainline it used TUN/TAP netlink sockets
> > and tried to get one by one, until successfully allocated.
> > Using dmesg userspace could find needed socket number for itself.
> >
>=20
> And in the end you have one connector bound to some socket. There is no
> multiple connectors - the goal (as far as I see it) was to have single
> transport web of messages and callbacks for entire kernel. It does not ma=
ke
> sense to divide it.

Callbacks and messages live in cn_queue_dev - it could be the same for
different transport layers, transport layer - it is cn_dev, they might
be different.
You want to remove even ability to extend the system, since you do not
see and want
to understand that with existing design it could be somehow extended,
with your
patch - it will be completely closed system.

> > > > cn_dev is connector device structure, cn_queue_dev - it's queueing =
part.
> > > > input handler is needed for ability to receive messages.
> > >=20
> > > You chose not to understand my question. Why do you need to have is a=
s
> > > a pointer? Do you expect to have different input handler?
> >=20
> > In runtime - no.
> > cn_dev is a main transport structure, while cn_queue_dev is for
> > callback queue handling.
> >=20
> > > > Couple of next questions can be answered in one reply:
> > > > original connector's idea was to implement notification based
> > > > not on top of netlink protocol, but using ioctls of char device,
> > > > so there could be different connector device, input method,
> > > > transport and so on. Probably I will not implement it thought.
> > >=20
> > > IOW this all is remnants of an older design. You have no plans to
> > > utilize the framework and therefore it is not needed anymore and can
> > > be dropped.
> >=20
> > Different connector devices still there.
> > They use different sockets.
> > Concider netlink2 [with guaranteed delivering - I have some ideas about=
 it] -=20
> > one just needs to add a new connector device, no new braindumping and
> > recalling how it was cool before.
> > It will require some changes to the connector structure, but it will no=
t=20
> > be complete rewrite because some time ago someone decided we do not
> > need it and completely removed anything that lives outside simple
> > netlink wrapper.
>=20
> Think about implications some more - userspace needs to be aware and chos=
e
> what socket to bind to, applications will change... Messages will change.
> In-kernel users will also have to select kind of transport they want to u=
se
> (guaranteed delivery or not) - it looks like you'll be better off having
> these connectors completely separated.

No, I do not think messages will be changed, they are quite
selfcontained,=20
may be some kind of flags - but existing 32bit length can be closed to
16 bit -=20
16kb is quite enough, especiall with 1024byte checks in connector
itself.
It is only transport layer that will be changed.
Naive approach is just attaching a timer to selected skb and reinit it
each time
socket has overrun until some timeout, of course with some simple
congestion mechanism.
Logical high-level messages were separated specially to hide transport
layer.
We do not change route table when switching from UDP to TCP routes,=20
and connector message header is exactly a "route" for included message.
Using flags in connector message header one may select desired connector
from
kernelspace, binding to different socket or using ioctl selects
appropriate=20
connector from userspace.
And even better - kernelspace might use not flags, but might add/remove
callback
to appropriate transport device and thus cn_netlink_send will select
required device using message idx.val.

Your changes break this idea completely - it will require new queues,
new request lists,
new set of messages, new ids - almost all will be duplicated instead of
new device
strucutre which is 28 bytes in size and has a pointer to the common
part, which=20
has reference counter for such kind of use.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-ie3WZAlwwj3NWxta+but
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCgarSIKTPhE+8wY0RAnxnAJ423+l9JmEw6CiafZmRKeOT4sEDGgCfQTCt
s7tuL5uxf8CqALxaOIT9+UU=
=1yn0
-----END PGP SIGNATURE-----

--=-ie3WZAlwwj3NWxta+but--

