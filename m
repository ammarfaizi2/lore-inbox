Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbVAYOIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVAYOIg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 09:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVAYOIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 09:08:36 -0500
Received: from dea.vocord.ru ([217.67.177.50]:59539 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261944AbVAYOHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 09:07:20 -0500
Subject: Re: 2.6.11-rc2-mm1
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050125125323.GA19055@infradead.org>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <20050125125323.GA19055@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+S23q3aqZL/GSiFGnU0b"
Organization: MIPT
Date: Tue, 25 Jan 2005 17:11:24 +0300
Message-Id: <1106662284.5257.53.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Tue, 25 Jan 2005 14:06:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+S23q3aqZL/GSiFGnU0b
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-01-25 at 12:53 +0000, Christoph Hellwig wrote:
> Review of the superio subsystem sneaked in through bk-i2c.patch:

Hmm, "sneaked"... Good start, Christoph.

> diff -Nru a/drivers/superio/Kconfig b/drivers/superio/Kconfig
> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/drivers/superio/Kconfig	2005-01-23 22:34:15 -08:00
> @@ -0,0 +1,56 @@
> +menu "SuperIO subsystem support"
> +
> +config SC_SUPERIO
> +	tristate "SuperIO subsystem support"
> +	depends on CONNECTOR
> +	help
> +	  SuperIO subsystem support.
> +=09
> +	  This support is also available as a module.  If so, the module
> +          will be called superio.ko.
>=20
> This doesn't mention what "SuperIO" is at all.  Also please skip the .ko
> postfix for the module name as the intree Kconfigs do.  The boilerplate h=
as
> changed to:

Ok.

>   To compile this driver as a module, choose M here: the
>   module will be called <foo>.
>=20
> diff -Nru a/drivers/superio/Makefile b/drivers/superio/Makefile
> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/drivers/superio/Makefile	2005-01-23 22:34:15 -08:00
> @@ -0,0 +1,11 @@
> +#
> +# Makefile for the SuperIO subsystem.
> +#
>=20
> Superflous.
>=20
> +
> +obj-$(CONFIG_SC_SUPERIO)	+=3D superio.o
> +obj-$(CONFIG_SC_GPIO)		+=3D sc_gpio.o
> +obj-$(CONFIG_SC_ACB)		+=3D sc_acb.o
> +obj-$(CONFIG_SC_PC8736X)	+=3D pc8736x.o
> +obj-$(CONFIG_SC_SCX200)		+=3D scx200.o
> +
> +superio-objs		:=3D sc.o chain.o sc_conn.o
>=20
> please use superio-y +=3D so new conditional objects can be added more ea=
sily.

They must be added in the same file and line to allow easy control.
It is not directory like char/.

> diff -Nru a/drivers/superio/chain.c b/drivers/superio/chain.c
> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/drivers/superio/chain.c	2005-01-23 22:34:15 -08:00
> @@ -0,0 +1,52 @@
> +/*
> + * 	chain.c
>=20
> superfluos, the file name is obvious.  (Dito for all other files)
>=20
> + *=20
> + * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> + * All rights reserved.
> + *=20
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
 USA
> + *
> + */
> +
> +#include <asm/atomic.h>
> +#include <asm/types.h>
> +
> +#include <linux/list.h>
> +#include <linux/slab.h>
>=20
> always include <asm/*> after <linux/*> headers.  Please use <linux/types.=
h>
> istead of <asm/types.h> always.
>=20
> (comment applies to later files aswell)

Ok.

> +#include "chain.h"
> +
> +struct dev_chain *chain_alloc(void *ptr)
> +{
> +	struct dev_chain *ch;
> +
> +	ch =3D kmalloc(sizeof(struct dev_chain), GFP_ATOMIC);
> +	if (!ch) {
> +		printk(KERN_ERR "Failed to allocate new chain for %p.\n", ptr);
> +		return NULL;
> +	}
> +
> +	memset(ch, 0, sizeof(struct dev_chain));
> +
> +	ch->ptr =3D ptr;
> +
> +	return ch;
> +}
> +
> +void chain_free(struct dev_chain *ch)
> +{
> +	memset(ch, 0, sizeof(struct dev_chain));
> +	kfree(ch);
>=20
> The memset completely defeats slab redzoning to catch bugs, don't
> do that.

What? Does following code also kills redzoning?

int *a;
a =3D kmalloc();
if (a)
{
	memset(a, 0, sizeof(*a));
	kfree(a);
}

Consider size of the dev_chain structure...

> Also what's the reason you can't simply put the list_head into struct
> logical_dev?

Because it is not just list_head, but special structure used for special
pointer manipulations,
which you are obviously saw in sc.c=20

> +static void pc8736x_fini(void)
> +{
> +	sc_del_sc_dev(&pc8736x_dev);
> +
> +	while (atomic_read(&pc8736x_dev.refcnt)) {
> +		printk(KERN_INFO "Waiting for %s to became free: refcnt=3D%d.\n",
> +				pc8736x_dev.name, atomic_read(&pc8736x_dev.refcnt));
> +	=09
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		schedule_timeout(HZ);
> +		=09
> +		if (current->flags & PF_FREEZE)
> +			refrigerator(PF_FREEZE);
> +
> +		if (signal_pending(current))
> +			flush_signals(current);
> +	}
> +}
>=20
> And who gurantess this won't deadlock?  Please use a dynamically allocate=
d
> driver model device and it's refcounting, thanks.

Sigh.

Christoph, please read the code before doing such comments.
I very respect your review and opinion, but only until you respect
others.

> +int sc_add_sc_dev(struct sc_dev *__sdev)
>=20
> btw, what's the reason you use those ugly __ names for local variables al=
l over?
>=20
> +	while (atomic_read(&__sdev->refcnt)) {
> +		printk(KERN_INFO "Waiting SuperIO chip %s to become free: refcnt=3D%d.=
\n",
> +		       __sdev->name, atomic_read(&__sdev->refcnt));
> +		set_current_state(TASK_UNINTERRUPTIBLE);
> +		schedule_timeout(HZ);
> +		=09
> +		if (current->flags & PF_FREEZE)
> +			refrigerator(PF_FREEZE);
> +
> +		if (signal_pending(current))
> +			flush_signals(current);
> +	}
> +}
>=20
> Again as above.
>=20
> +static void sc_deactivate_logical(struct sc_dev *dev, struct logical_dev=
 *ldev)
> +{
> +	printk(KERN_INFO "Deactivating logical device %s in SuperIO chip %s... =
",
> +	       ldev->name, dev->name);
> +=09
> +	if (ldev->irq)
> +	{
> +		free_irq(ldev->irq, ldev);
> +		ldev->irq =3D 0;
> +	}
>=20
> CodingStyle: if (ldev->irq) {  (also in various other places)

Yep.

> +static int __devinit sc_init(void)
> +{
> +	printk(KERN_INFO "SuperIO driver is starting...\n");
> +
> +	return sc_register_callback();
> +}
> +
> +static void __devexit sc_fini(void)
> +{
> +	sc_unregister_callback();
> +	printk(KERN_INFO "SuperIO driver finished.\n");
> +}
>=20
> quite noise.  Please only print messages when you find an actual
> device and not on unloading at all.
>=20
> +	INIT_LIST_HEAD(&ldev_acb.ldev_entry);
> +	spin_lock_init(&ldev_acb.lock);
>=20
> these two can be initialized at compile time.

Ok.

> +#include "../superio/sc.h"
> +#include "../superio/sc_gpio.h"
>=20
> just include them normalluy, ok?

Sure.

> +static int scx200_pci_probe(struct pci_dev *pdev,
> +			    const struct pci_device_id *ent)
> +{
> +	private_base =3D pci_resource_start(pdev, 0);
> +	printk(KERN_INFO "%s: GPIO base 0x%lx.\n", pci_name(pdev), private_base=
);
> +
> +	if (!request_region
> +	    (private_base, SCx200_GPIO_SIZE, "NatSemi SCx200 GPIO")) {
> +		printk(KERN_ERR "%s: failed to request %d bytes I/O region for GPIOs.\=
n",
> +		       pci_name(pdev), SCx200_GPIO_SIZE);
> +		return -EBUSY;
> +	}
> +
> +	pci_set_drvdata(pdev, &private_base);
> +	pci_enable_device(pdev);
>=20
> pci_enable_device needs to be done first, and it returns and error that
> should be handled.

Yep, it can be a problem, thank you.

> +	pci_unregister_driver(&scx200_pci_driver);
> +	if (private_base)
> +		release_region(private_base, SCx200_GPIO_SIZE);
>=20
> this must happen in the ->remove callback.
>=20
> diff -Nru a/drivers/superio/scx200.h b/drivers/superio/scx200.h
> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/drivers/superio/scx200.h	2005-01-23 22:34:15 -08:00
> @@ -0,0 +1,28 @@
> +/*
> + * 	scx200.h
> + *=20
> + * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> + * All rights reserved.
> + *=20
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
 USA
> + *
> + */
> +
> +#ifndef __SCX200_H
> +#define __SCX200_H
> +
> +#define SCx200_GPIO_SIZE 	0x2c
> +
> +#endif /* __SCX200_H */
>=20
> Yeah, right - a 30 line header for a single define that's used in a
> single source file..

Christoph, do you know what SuperIO is?
I doubt...

It is a small chip, which can include various number of devices.
SuperIO currently supports only GPIO and ACB, so this header only
includes
one define. I do not have hardware(sc1100 based for example) that
"exports"
other devices and which can be accessed from the outside of the board,=20
so I did not add other defines.

But specially for you I can remove this file, will it satisfy you?

> Also your locking is broken.  sdev_lock sometimes nests outside
> sdev->lock and sometimes inside.  Similarly dev->chain_lock nests
> inside dev->lock sometimes and sometimes outside.  You really need
> a locking hiearchy document and the lockign should probably be
> simplified a lot.

It is almost the same like after hand waving say that there is a wind.

Each lock protect it's own data, sometimes it happens when other data is
locked,=20
sometimes not. Yes, probably interrupt handling can race, it requires
more review,
I will take a look.

Below is part of the announce in lm_sensors@ which probably will throw
light on your
claims.
************
Main goal was to be able to link any registered SuperIO chip with any
number of registered logical devices. Next step is to add ability to
communicate with SuperIO subsystem from userspace.
External kernel modules may access to logical devices using
sc_{get,put}_ldev() and in similar way to SuperIO chip drivers -
sc_{get,put}_sdev().

Driver writers shoud use sc_{add,del}_logical_dev() and
sc_{add,del}_sc_dev() to accordingly add/remove logical devices and
SuperIO chip drivers.

Any SuperIO chip driver must provite at least 2 functions:
->probe() and ->activate_one().
The former is called with different HW addresses and should return 0 if
device was found there or negative error value.
The latter is called each time new logical device being added with
pointer to it's logical device structure. It should return 0 if logical
device was found to be active or negative error value.

Any logical device must provide 4 functions:
->activate() - it is used to activate logical device.
->read()/write() - what do you think, it is used to read and write
from/to logical device registers.
->control() - it is used to control access to logical device. Actually
it is private combination of ->read()/write() functions but is providede
for convenience.
********************

Resume:
Cristoph, you rudely try to show that this code is badly broken.
It is not.
It was tested as opposed to your claims, and works as expected.

To be more productive please next time be polite and respect others,=20
or you will be just ignored no matter how strong your knowledges are.

Talk is cheap, show me the code, that is broken, and I will fix it.

Thank you.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-+S23q3aqZL/GSiFGnU0b
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB9lOMIKTPhE+8wY0RAhWAAJ9es84B/B6tEHR6j9WjxCTceK7FwQCeOVzZ
gpXg6ZkKL8M+jEm4s02XSzI=
=O55X
-----END PGP SIGNATURE-----

--=-+S23q3aqZL/GSiFGnU0b--

