Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbVAYP0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbVAYP0Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 10:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbVAYP0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 10:26:16 -0500
Received: from zeus.kernel.org ([204.152.189.113]:3519 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261975AbVAYPZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 10:25:52 -0500
Subject: Re: 2.6.11-rc2-mm1
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050125142356.GA20206@infradead.org>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <20050125125323.GA19055@infradead.org> <1106662284.5257.53.camel@uganda>
	 <20050125142356.GA20206@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JOqxk/2MMLRqhQRh9CYx"
Organization: MIPT
Date: Tue, 25 Jan 2005 18:24:50 +0300
Message-Id: <1106666690.5257.97.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Tue, 25 Jan 2005 15:19:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JOqxk/2MMLRqhQRh9CYx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-01-25 at 14:23 +0000, Christoph Hellwig wrote:
> > > +obj-$(CONFIG_SC_SUPERIO)	+=3D superio.o
> > > +obj-$(CONFIG_SC_GPIO)		+=3D sc_gpio.o
> > > +obj-$(CONFIG_SC_ACB)		+=3D sc_acb.o
> > > +obj-$(CONFIG_SC_PC8736X)	+=3D pc8736x.o
> > > +obj-$(CONFIG_SC_SCX200)		+=3D scx200.o
> > > +
> > > +superio-objs		:=3D sc.o chain.o sc_conn.o
> > >=20
> > > please use superio-y +=3D so new conditional objects can be added mor=
e easily.
> >=20
> > They must be added in the same file and line to allow easy control.
> > It is not directory like char/.
>=20
> Huh?
>=20
> What I mean is you should write
>=20
> superio-y		+=3D sc.o chain.o sc_conn.o
>=20
> this allows adding things like
>=20
> superio-$(CONFIG_FOO)	+=3D sc_foo.o
>=20
> and is generally the canonical form since 2.6

Yes, I understand you, but this is the case when it is not supposed to
have external dependent features, they are already inside :)
But who knows.

I think it is better to change.

> > > +void chain_free(struct dev_chain *ch)
> > > +{
> > > +	memset(ch, 0, sizeof(struct dev_chain));
> > > +	kfree(ch);
> > >=20
> > > The memset completely defeats slab redzoning to catch bugs, don't
> > > do that.
> >=20
> > What? Does following code also kills redzoning?
> >=20
> > int *a;
> > a =3D kmalloc();
> > if (a)
> > {
> > 	memset(a, 0, sizeof(*a));
> > 	kfree(a);
> > }
> >=20
> > Consider size of the dev_chain structure...
>=20
> Sorry, didn't mean redzoning but poisoning in general, little
> brainfart on my side.  The slab code can set freed objects to
> known patters so use after frees can be debugged easily, and
> by zeroing a structure before freeing we lose that.

Zeroing can be found easily - the whole structure is NULL pointer,=20
and will always panic if accessed(from running superio code),=20
but redzoning is only happen on borders,
and can catch writes over the boards, which is rarely in this case.

> > > Also what's the reason you can't simply put the list_head into struct
> > > logical_dev?
> >=20
> > Because it is not just list_head, but special structure used for specia=
l
> > pointer manipulations,
> > which you are obviously saw in sc.c=20
>=20
> No, I didn't see it.  I see that the void pointer ptr in struct dev_chain
> always points to a struct sc_dev *, and I see we never change that
> pointer at run time.  I might have missed something obvious, so maybe
> you could point me to it (or even better add a comment describing it)

Each superio chip is registered with superio core without any devices.
Each logical device is registered with superio core without any superio
chip.
Then core checks if some chip is found in some superio device, and
links=20
it to appropriate device.
So if board has several superio chips(like soekris board) and several
logical devices in it, then we only have 2 superio small drivers, and
several=20
logical device drivers, but not
number_of_superio_chips*number_of_logical_devices drivers.
Without dev_chain structure each logical device should have a separate
list of
superio chips that owns it.
Above chain structure is a glue between superio core, logical devices
and superio chips.
It is especially usefull in case of logical device cloning, when chip
does not follow
the standart and place it somewhere else, but to allow access to it
superio core
"clones" logical device and link them instead of the standart one.

> >=20
> > > +static void pc8736x_fini(void)
> > > +{
> > > +	sc_del_sc_dev(&pc8736x_dev);
> > > +
> > > +	while (atomic_read(&pc8736x_dev.refcnt)) {
> > > +		printk(KERN_INFO "Waiting for %s to became free: refcnt=3D%d.\n",
> > > +				pc8736x_dev.name, atomic_read(&pc8736x_dev.refcnt));
> > > +	=09
> > > +		set_current_state(TASK_INTERRUPTIBLE);
> > > +		schedule_timeout(HZ);
> > > +		=09
> > > +		if (current->flags & PF_FREEZE)
> > > +			refrigerator(PF_FREEZE);
> > > +
> > > +		if (signal_pending(current))
> > > +			flush_signals(current);
> > > +	}
> > > +}
> > >=20
> > > And who gurantess this won't deadlock?  Please use a dynamically allo=
cated
> > > driver model device and it's refcounting, thanks.
> >=20
> > Sigh.
> >=20
> > Christoph, please read the code before doing such comments.
> > I very respect your review and opinion, but only until you respect
> > others.
>=20
> The code above pretty much means you can keep rmmod stalled forever.

Yes, and it is better than removing module whose structures are in use.
SuperIO core is asynchronous in it's nature, one can use logical device=20
through superio core and remove it's module on other CPU, above loop
will
wait untill all reference counters are dropped.

Access to devices can be done not through ioctl or such mechanism which=20
"locks" the module owner.

It is better than module_get() since with the latter variant we may end
up
not removing device at all.

> Also it seems to be the only code intree doing refrigerator() on anything
> but kernel thread.  While I can't comment on swsusp internals it surely
> looks buggy to me.
> =20
> > > +#ifndef __SCX200_H
> > > +#define __SCX200_H
> > > +
> > > +#define SCx200_GPIO_SIZE 	0x2c
> > > +
> > > +#endif /* __SCX200_H */
> > >=20
> > > Yeah, right - a 30 line header for a single define that's used in a
> > > single source file..
> >=20
> > Christoph, do you know what SuperIO is?
> > I doubt...
> >=20
> > It is a small chip, which can include various number of devices.
> > SuperIO currently supports only GPIO and ACB, so this header only
> > includes
> > one define. I do not have hardware(sc1100 based for example) that
> > "exports"
> > other devices and which can be accessed from the outside of the board,=20
> > so I did not add other defines.
> >=20
> > But specially for you I can remove this file, will it satisfy you?
>=20
> I've just told you it looks extremly silly, you need to decide on your
> own whether it's worthwile.
>=20
> > > Also your locking is broken.  sdev_lock sometimes nests outside
> > > sdev->lock and sometimes inside.  Similarly dev->chain_lock nests
> > > inside dev->lock sometimes and sometimes outside.  You really need
> > > a locking hiearchy document and the lockign should probably be
> > > simplified a lot.
> >=20
> > It is almost the same like after hand waving say that there is a wind.
> >=20
> > Each lock protect it's own data, sometimes it happens when other data i=
s
> > locked,=20
> > sometimes not. Yes, probably interrupt handling can race, it requires
> > more review,
> > I will take a look.
>=20
> The thing I mention is called lock order reversal, which means a deadlock
> in most cases.  I don't have the time to actual walk through all codepath=
es
> to tell you whether it can really happen and where, but it's a really
> big warning sign.

No, it is not called lock order reversal.

There are no places like
lock a
lock b
unlock a
unlock b

and if they are, then I'm completely wrong.

What you see is only following:

place 1:
lock a
lock b
unlock b
lock c
unlock c
unlock a

place 2:
lock b
lock a
unlock a
lock c
unlock c
unlock b


It is done since manipulation with the chain pointer can be done from
logical device structure and from superio chip structure, and this
operations are absolutely the same in nature.

> > Resume:
> > Cristoph, you rudely try to show that this code is badly broken.
> > It is not.
> > It was tested as opposed to your claims, and works as expected.
>=20
> I've seen tons of code that "works as expected" but still is buggy.
> That's why code needs to be both tested (with a workload as
> expected and other stress testing that shows it handles loads _not_
> expected) and reviewed for errors that don't happen with a normal
> load or design problems.

Yes, you are right, of course.
That is why we write code, test and discuss(but not knock against each
other) it.

I will send patch to address your comments soon, thank you.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-JOqxk/2MMLRqhQRh9CYx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB9mTCIKTPhE+8wY0RAmg2AKCWKUdnCyw2NykkWwK92kPbmBN+4wCfeso6
bui05xQRn+EzRSVFS131zrY=
=5eHT
-----END PGP SIGNATURE-----

--=-JOqxk/2MMLRqhQRh9CYx--

