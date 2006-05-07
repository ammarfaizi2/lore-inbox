Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWEGNDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWEGNDc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 09:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWEGNDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 09:03:31 -0400
Received: from master.altlinux.org ([62.118.250.235]:60428 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP id S932151AbWEGNDb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 09:03:31 -0400
Date: Sun, 7 May 2006 17:03:20 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Michael Buesch <mb@bu3sch.de>
Cc: akpm@osdl.org, Deepak Saxena <dsaxena@plexity.net>, mbuesch@freenet.de,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/6] New Generic HW RNG
Message-Id: <20060507170320.3ce0d3e0.vsu@altlinux.ru>
In-Reply-To: <20060507113604.778384000@pc1>
References: <20060507113513.418451000@pc1>
	<20060507113604.778384000@pc1>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__7_May_2006_17_03_20_+0400_3iiyTrtYVfsikK0a"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__7_May_2006_17_03_20_+0400_3iiyTrtYVfsikK0a
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 07 May 2006 13:35:15 +0200 Michael Buesch wrote:

> Add a new generic H/W RNG core.
>=20
> Signed-off-by: Michael Buesch <mb@bu3sch.de>
[skip]
> Index: hwrng/drivers/char/hw_random/core.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ hwrng/drivers/char/hw_random/core.c	2006-05-07 01:04:42.000000000 +02=
00
> @@ -0,0 +1,324 @@
> +/*
> +        Added support for the AMD Geode LX RNG
> +	(c) Copyright 2004-2005 Advanced Micro Devices, Inc.
> +
> +	derived from
> +
> + 	Hardware driver for the Intel/AMD/VIA Random Number Generators (RNG)
> +	(c) Copyright 2003 Red Hat Inc <jgarzik@redhat.com>
> +
> + 	derived from
> +
> +        Hardware driver for the AMD 768 Random Number Generator (RNG)
> +        (c) Copyright 2001 Red Hat Inc <alan@redhat.com>
> +
> + 	derived from
> +
> +	Hardware driver for Intel i810 Random Number Generator (RNG)
> +	Copyright 2000,2001 Jeff Garzik <jgarzik@pobox.com>
> +	Copyright 2000,2001 Philipp Rumpf <prumpf@mandrakesoft.com>
> +
> +	Added generic RNG API
> +	Copyright 2006 Michael Buesch <mbuesch@freenet.de>
> +	Copyright 2005 (c) MontaVista Software, Inc.
> +
> +	Please read Documentation/hw_random.txt for details on use.
> +
> +	----------------------------------------------------------
> +	This software may be used and distributed according to the terms
> +        of the GNU General Public License, incorporated herein by refere=
nce.
> +
> + */
> +
> +
> +#include <linux/device.h>
> +#include <linux/hw_random.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/fs.h>
> +#include <linux/init.h>
> +#include <linux/miscdevice.h>
> +#include <linux/delay.h>
> +#include <asm/uaccess.h>
> +
> +
> +#define RNG_MODULE_NAME		"hw_random"
> +#define PFX RNG_MODULE_NAME	": "
> +#define RNG_MISCDEV_MINOR		183 /* official */
> +
> +
> +static struct hwrng *current_rng;
> +static LIST_HEAD(rng_list);
> +static DEFINE_MUTEX(rng_mutex);
> +
> +
> +static int rng_dev_open(struct inode *inode, struct file *filp)
> +{
> +	/* enforce read-only access to this chrdev */
> +	if ((filp->f_mode & FMODE_READ) =3D=3D 0)
> +		return -EINVAL;
> +	if (filp->f_mode & FMODE_WRITE)
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +static ssize_t rng_dev_read(struct file *filp, char __user *buf,
> +			    size_t size, loff_t *offp)
> +{
> +	unsigned int have_data;
> +	u32 data =3D 0;
> +	ssize_t ret =3D 0;
> +	int i, err;
> +
> +	while (size) {
> +		err =3D mutex_lock_interruptible(&rng_mutex);
> +		if (err)
> +			return err;

This does not handle the case of partial read correctly - the code
should be

			return ret ? : -ERESTARTSYS;

> +		if (!current_rng) {
> +			mutex_unlock(&rng_mutex);
> +			return -ENODEV;

The same problem here (although finding the RNG suddenly missing after
we heve just read something from it is pretty unlikely).

> +		}
> +		have_data =3D 0;
> +		if (current_rng->data_present =3D=3D NULL ||
> +		    current_rng->data_present(current_rng))
> +			have_data =3D current_rng->data_read(current_rng, &data);
> +		mutex_unlock(&rng_mutex);
> +
> +		while (have_data && size) {
> +			if (put_user((u8)data, buf++)) {
> +				ret =3D ret ? : -EFAULT;
> +				break;
> +			}
> +			size--;
> +			ret++;
> +			have_data--;
> +			data>>=3D8;
> +		}
> +
> +		if (filp->f_flags & O_NONBLOCK)
> +			return ret ? : -EAGAIN;
> +
> +		if (need_resched()) {
> +			schedule_timeout_interruptible(1);
> +		} else {
> +			err =3D mutex_lock_interruptible(&rng_mutex);
> +			if (err)
> +				return err;

And here...

> +			if (!current_rng) {
> +				mutex_unlock(&rng_mutex);
> +				return -ENODEV;

And here too.

> +			}
> +			for (i =3D 0; i < 20; i++) {
> +				if (current_rng->data_present =3D=3D NULL ||
> +				    current_rng->data_present(current_rng))
> +					break;
> +				udelay(10);
> +			}
> +			mutex_unlock(&rng_mutex);
> +		}
> +
> +		if (signal_pending(current))
> +			return ret ? : -ERESTARTSYS;
> +	}
> +	return ret;
> +}
> +
> +
> +static struct file_operations rng_chrdev_ops =3D {
> +	.owner		=3D THIS_MODULE,
> +	.open		=3D rng_dev_open,
> +	.read		=3D rng_dev_read,
> +};
> +
> +static struct miscdevice rng_miscdev =3D {
> +	.minor		=3D RNG_MISCDEV_MINOR,
> +	.name		=3D RNG_MODULE_NAME,
> +	.fops		=3D &rng_chrdev_ops,
> +};
> +
> +
> +static ssize_t hwrng_attr_current_store(struct class_device *class,
> +					const char *buf, size_t len)
> +{
> +	int err;
> +	struct hwrng *rng;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	err =3D mutex_lock_interruptible(&rng_mutex);
> +	if (err)
> +		return err;
> +	err =3D -ENODEV;
> +	list_for_each_entry(rng, &rng_list, list) {
> +		if (strncmp(rng->name, buf, len) =3D=3D 0) {

This will match if the passed string is just a prefix of rng->name.
Apparently sysfs guarantees that the buffer passed to ->store will be
NUL-terminated, so this should be just a strcmp().

> +			if (rng->init) {
> +				err =3D rng->init(rng);
> +				if (err)
> +					break;
> +			}
> +			if (current_rng && current_rng->cleanup)
> +				current_rng->cleanup(current_rng);

What if rng =3D=3D current_rng here (someone has written the same RNG name
to the "store" attribute)?  The lowlevel RNG driver should not have to
handle nested init/cleanup calls.

[skip]

--Signature=_Sun__7_May_2006_17_03_20_+0400_3iiyTrtYVfsikK0a
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFEXfAbW82GfkQfsqIRAgXKAJ41gohOuBIkh9fF3D7EITE8cQGrJgCeMcMX
iZh7tmJGtiFnWBUqolO9NsY=
=tcp4
-----END PGP SIGNATURE-----

--Signature=_Sun__7_May_2006_17_03_20_+0400_3iiyTrtYVfsikK0a--
