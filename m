Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbUK2FJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbUK2FJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 00:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbUK2FJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 00:09:56 -0500
Received: from dea.vocord.ru ([217.67.177.50]:9427 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261632AbUK2FJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 00:09:27 -0500
Subject: Re: [2.6 patch] drivers/w1/: possible cleanups
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Adrian Bunk <bunk@stusta.de>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
In-Reply-To: <20041129015257.GN4390@stusta.de>
References: <1101108672.2843.55.camel@uganda>
	 <20041122133344.GA19419@stusta.de> <1101140745.9784.7.camel@uganda>
	 <20041122165145.GH19419@stusta.de> <1101143109.9784.9.camel@uganda>
	 <20041122171956.GI19419@stusta.de> <1101145020.9784.17.camel@uganda>
	 <20041123002028.GN19419@stusta.de> <1101206052.9784.26.camel@uganda>
	 <20041125155614.GD3537@stusta.de>  <20041129015257.GN4390@stusta.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pRt4D33mMi4mpOhom374"
Organization: MIPT
Date: Mon, 29 Nov 2004 08:12:45 +0300
Message-Id: <1101705165.18807.318.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Mon, 29 Nov 2004 05:08:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pRt4D33mMi4mpOhom374
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-11-29 at 02:52 +0100, Adrian Bunk wrote:
> The patch below includes the following possible cleanups:
> - make needlessly global code static
> - remove unused code
>=20
> Please review and comment which parts are correct and which conflict=20
> with pending changes that will add in-kernel users for the functions in=20
> question.

Thank you, but I will not apply your patch as is, since many parts of it
are generic
and need to be used for any ds2490 based devices.

Comments below.

> diffstat output:
>  drivers/w1/dscore.c    |  103 +++++++++++------------------------------
>  drivers/w1/dscore.h    |    7 --
>  drivers/w1/w1.c        |   25 ++++-----
>  drivers/w1/w1.h        |    1=20
>  drivers/w1/w1_family.c |   16 +-----
>  drivers/w1/w1_family.h |    2=20
>  drivers/w1/w1_int.c    |    7 --
>  drivers/w1/w1_int.h    |    2=20
>  drivers/w1/w1_io.c     |   13 ++---
>  drivers/w1/w1_io.h     |    3 -
>  10 files changed, 51 insertions(+), 128 deletions(-)
>=20
>=20
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>=20
> --- linux-2.6.10-rc2-mm3-full/drivers/w1/dscore.h.old	2004-11-29 02:07:27=
.000000000 +0100
> +++ linux-2.6.10-rc2-mm3-full/drivers/w1/dscore.h	2004-11-29 02:12:44.000=
000000 +0100
> @@ -156,14 +156,7 @@
>  int ds_read_bit(struct ds_device *, u8 *);
>  int ds_write_byte(struct ds_device *, u8);
>  int ds_write_bit(struct ds_device *, u8);
> -int ds_start_pulse(struct ds_device *, int);
> -int ds_set_speed(struct ds_device *, int);
>  int ds_reset(struct ds_device *, struct ds_status *);
> -int ds_detect(struct ds_device *, struct ds_status *);
> -int ds_stop_pulse(struct ds_device *, int);
> -int ds_send_data(struct ds_device *, unsigned char *, int);
> -int ds_recv_data(struct ds_device *, unsigned char *, int);
> -int ds_recv_status(struct ds_device *, struct ds_status *);

1. ds_start_pulse() and ds_set_speed() are needed for eeprom programming
and setting device speed.
2. ds_{send,recv}_data can be used to receive bulks of data.
3. ds_send_status() is used to obtain status.

You may say that they are used only in ds9490 driver, but not -
they are generic functions to control any ds2490 based device.

Here is example: if I want to enable network only for netlink
communication
I will get even some qdisk functions exported.
Any above and some below functions _can_ be used to control ds2490 based
hardware.
DS9490R is _just_one_ of such devices. ds9490r is built on top of
(actually it is only)
dscore.o.
dscore.o - this is _generic_ driver for DS2490 based hardware.=20
Some of it requires above function, others not.
When(if) kernel connector patch will be applied, many of this functions
can be accessed by it,=20
but nevertheless they are needed for some hardware, and thus can be
accessed from it's drivers.

>  struct ds_device * ds_get_device(void);
>  void ds_put_device(struct ds_device *);
>  int ds_write_block(struct ds_device *, u8 *, int);
> --- linux-2.6.10-rc2-mm3-full/drivers/w1/dscore.c.old	2004-11-29 02:07:43=
.000000000 +0100
> +++ linux-2.6.10-rc2-mm3-full/drivers/w1/dscore.c	2004-11-29 02:24:28.000=
000000 +0100
> @@ -32,22 +32,19 @@
>  };
>  MODULE_DEVICE_TABLE(usb, ds_id_table);
> =20
> -int ds_probe(struct usb_interface *, const struct usb_device_id *);
> -void ds_disconnect(struct usb_interface *);
> +static int ds_probe(struct usb_interface *, const struct usb_device_id *=
);
> +static void ds_disconnect(struct usb_interface *);

I agree here - this functions are Linux USB callbacks and can be static.

<unacceptible static vs. nostaticchanges are skipped>

> -int ds_init(void)
> +static int ds_init(void)
>  {
>  	int err;
> =20
> @@ -756,7 +717,7 @@
>  	return 0;
>  }
> =20
> -void ds_fini(void)
> +static void ds_fini(void)
>  {
>  	usb_deregister(&ds_driver);
>  }

Sure, it is right changes.

> @@ -774,15 +735,7 @@
>  EXPORT_SYMBOL(ds_write_byte);
>  EXPORT_SYMBOL(ds_write_bit);
>  EXPORT_SYMBOL(ds_write_block);
> -EXPORT_SYMBOL(ds_start_pulse);
> -EXPORT_SYMBOL(ds_set_speed);
>  EXPORT_SYMBOL(ds_reset);
> -EXPORT_SYMBOL(ds_detect);
> -EXPORT_SYMBOL(ds_stop_pulse);
> -EXPORT_SYMBOL(ds_send_data);
> -EXPORT_SYMBOL(ds_recv_data);
> -EXPORT_SYMBOL(ds_recv_status);
> -EXPORT_SYMBOL(ds_search);
>  EXPORT_SYMBOL(ds_get_device);
>  EXPORT_SYMBOL(ds_put_device);
> =20
> --- linux-2.6.10-rc2-mm3-full/drivers/w1/w1_int.h.old	2004-11-29 02:19:06=
.000000000 +0100
> +++ linux-2.6.10-rc2-mm3-full/drivers/w1/w1_int.h	2004-11-29 02:19:32.000=
000000 +0100
> @@ -27,8 +27,6 @@
> =20
>  #include "w1.h"
> =20
> -struct w1_master * w1_alloc_dev(u32, int, int, struct device_driver *, s=
truct device *);
> -void w1_free_dev(struct w1_master *dev);

This can be static too.

>  int w1_add_master_device(struct w1_bus_master *);
>  void w1_remove_master_device(struct w1_bus_master *);
>  void __w1_remove_master_device(struct w1_master *);
> --- linux-2.6.10-rc2-mm3-full/drivers/w1/w1_int.c.old	2004-11-29 02:13:29=
.000000000 +0100
> +++ linux-2.6.10-rc2-mm3-full/drivers/w1/w1_int.c	2004-11-29 02:19:40.000=
000000 +0100
> @@ -30,7 +30,6 @@
>  static u32 w1_ids =3D 1;
> =20
>  extern struct device_driver w1_driver;
> -extern struct bus_type w1_bus_type;

Ok.

>  extern struct device w1_device;
>  extern int w1_max_slave_count;
>  extern int w1_max_slave_ttl;
> @@ -39,7 +38,7 @@
> =20
>  extern int w1_process(void *);
> =20
> -struct w1_master * w1_alloc_dev(u32 id, int slave_count, int slave_ttl,
> +static struct w1_master * w1_alloc_dev(u32 id, int slave_count, int slav=
e_ttl,
>  	      struct device_driver *driver, struct device *device)
>  {
>  	struct w1_master *dev;
> @@ -109,7 +108,7 @@
>  	return dev;
>  }
> =20
> -void w1_free_dev(struct w1_master *dev)
> +static void w1_free_dev(struct w1_master *dev)
>  {
>  	device_unregister(&dev->dev);
>  	if (dev->nls->sk_socket)
> @@ -220,8 +219,6 @@
>  	__w1_remove_master_device(dev);
>  }
> =20
> -EXPORT_SYMBOL(w1_alloc_dev);
> -EXPORT_SYMBOL(w1_free_dev);

As I say this change is right.

>  EXPORT_SYMBOL(w1_add_master_device);
>  EXPORT_SYMBOL(w1_remove_master_device);
>  EXPORT_SYMBOL(__w1_remove_master_device);
> --- linux-2.6.10-rc2-mm3-full/drivers/w1/w1.h.old	2004-11-29 02:14:36.000=
000000 +0100
> +++ linux-2.6.10-rc2-mm3-full/drivers/w1/w1.h	2004-11-29 02:14:40.0000000=
00 +0100
> @@ -126,7 +126,6 @@
>  };
> =20
>  int w1_create_master_attributes(struct w1_master *);
> -void w1_destroy_master_attributes(struct w1_master *);

I've exported it for completeness - it was used before in error exit
path.
I need to change it back - w1_create_master_attributes() must be called
before=20
w1_process() thread creation - this will reduce error recovery path.

>  #endif /* __KERNEL__ */
> =20
> --- linux-2.6.10-rc2-mm3-full/drivers/w1/w1.c.old	2004-11-29 02:13:43.000=
000000 +0100
> +++ linux-2.6.10-rc2-mm3-full/drivers/w1/w1.c	2004-11-29 02:16:47.0000000=
00 +0100
> @@ -101,7 +101,7 @@
>  	return sprintf(buf, "No family registered.\n");
>  }
> =20
> -struct bus_type w1_bus_type =3D {
> +static struct bus_type w1_bus_type =3D {
>  	.name =3D "w1",
>  	.match =3D w1_master_match,
>  };
> @@ -139,7 +139,7 @@
>  	.show =3D &w1_default_read_name,
>  };
> =20
> -ssize_t w1_master_attribute_show_name(struct device *dev, char *buf)
> +static ssize_t w1_master_attribute_show_name(struct device *dev, char *b=
uf)
>  {
>  	struct w1_master *md =3D container_of (dev, struct w1_master, dev);
>  	ssize_t count;
> @@ -154,7 +154,7 @@
>  	return count;
>  }
> =20
> -ssize_t w1_master_attribute_show_pointer(struct device *dev, char *buf)
> +static ssize_t w1_master_attribute_show_pointer(struct device *dev, char=
 *buf)
>  {
>  	struct w1_master *md =3D container_of(dev, struct w1_master, dev);
>  	ssize_t count;
> @@ -168,14 +168,14 @@
>  	return count;
>  }
> =20
> -ssize_t w1_master_attribute_show_timeout(struct device *dev, char *buf)
> +static ssize_t w1_master_attribute_show_timeout(struct device *dev, char=
 *buf)
>  {
>  	ssize_t count;
>  	count =3D sprintf(buf, "%d\n", w1_timeout);
>  	return count;
>  }
> =20
> -ssize_t w1_master_attribute_show_max_slave_count(struct device *dev, cha=
r *buf)
> +static ssize_t w1_master_attribute_show_max_slave_count(struct device *d=
ev, char *buf)
>  {
>  	struct w1_master *md =3D container_of(dev, struct w1_master, dev);
>  	ssize_t count;
> @@ -189,7 +189,7 @@
>  	return count;
>  }
> =20
> -ssize_t w1_master_attribute_show_attempts(struct device *dev, char *buf)
> +static ssize_t w1_master_attribute_show_attempts(struct device *dev, cha=
r *buf)
>  {
>  	struct w1_master *md =3D container_of(dev, struct w1_master, dev);
>  	ssize_t count;
> @@ -203,7 +203,7 @@
>  	return count;
>  }
> =20
> -ssize_t w1_master_attribute_show_slave_count(struct device *dev, char *b=
uf)
> +static ssize_t w1_master_attribute_show_slave_count(struct device *dev, =
char *buf)
>  {
>  	struct w1_master *md =3D container_of(dev, struct w1_master, dev);
>  	ssize_t count;
> @@ -217,7 +217,7 @@
>  	return count;
>  }
> =20
> -ssize_t w1_master_attribute_show_slaves(struct device *dev, char *buf)
> +static ssize_t w1_master_attribute_show_slaves(struct device *dev, char =
*buf)
> =20
>  {
>  	struct w1_master *md =3D container_of(dev, struct w1_master, dev);
> @@ -600,7 +600,7 @@
>  	return 0;
>  }
> =20
> -void w1_destroy_master_attributes(struct w1_master *dev)
> +static void w1_destroy_master_attributes(struct w1_master *dev)
>  {
>  	device_remove_file(&dev->dev, &w1_master_attribute_slaves);
>  	device_remove_file(&dev->dev, &w1_master_attribute_slave_count);
> @@ -612,7 +612,7 @@
>  }
> =20
>=20
> -int w1_control(void *data)
> +static int w1_control(void *data)
>  {
>  	struct w1_slave *sl;
>  	struct w1_master *dev;
> @@ -749,7 +749,7 @@
>  	return 0;
>  }
> =20
> -int w1_init(void)
> +static int w1_init(void)
>  {
>  	int retval;
> =20
> @@ -789,7 +789,7 @@
>  	return retval;
>  }
> =20
> -void w1_fini(void)
> +static void w1_fini(void)
>  {
>  	struct w1_master *dev;
>  	struct list_head *ent, *n;
> @@ -811,4 +811,3 @@
>  module_exit(w1_fini);

I agree with above changes.

>  EXPORT_SYMBOL(w1_create_master_attributes);
> -EXPORT_SYMBOL(w1_destroy_master_attributes);
> --- linux-2.6.10-rc2-mm3-full/drivers/w1/w1_family.h.old	2004-11-29 02:17=
:17.000000000 +0100
> +++ linux-2.6.10-rc2-mm3-full/drivers/w1/w1_family.h	2004-11-29 02:18:19.=
000000000 +0100
> @@ -54,10 +54,8 @@
> =20
>  extern spinlock_t w1_flock;
> =20
> -void w1_family_get(struct w1_family *);
>  void w1_family_put(struct w1_family *);
>  void __w1_family_get(struct w1_family *);
> -void __w1_family_put(struct w1_family *);
>  struct w1_family * w1_family_registered(u8);
>  void w1_unregister_family(struct w1_family *);
>  int w1_register_family(struct w1_family *);
> --- linux-2.6.10-rc2-mm3-full/drivers/w1/w1_family.c.old	2004-11-29 02:17=
:29.000000000 +0100
> +++ linux-2.6.10-rc2-mm3-full/drivers/w1/w1_family.c	2004-11-29 02:18:38.=
000000000 +0100
> @@ -115,25 +115,17 @@
>  	return (ret) ? f : NULL;
>  }
> =20
> -void w1_family_put(struct w1_family *f)
> -{
> -	spin_lock(&w1_flock);
> -	__w1_family_put(f);
> -	spin_unlock(&w1_flock);
> -}
> -
> -void __w1_family_put(struct w1_family *f)
> +static void __w1_family_put(struct w1_family *f)
>  {
>  	if (atomic_dec_and_test(&f->refcnt))
>  		f->need_exit =3D 1;
>  }
> =20
> -void w1_family_get(struct w1_family *f)
> +void w1_family_put(struct w1_family *f)
>  {
>  	spin_lock(&w1_flock);
> -	__w1_family_get(f);
> +	__w1_family_put(f);
>  	spin_unlock(&w1_flock);
> -
>  }
> =20
>  void __w1_family_get(struct w1_family *f)
> @@ -141,10 +133,8 @@
>  	atomic_inc(&f->refcnt);
>  }
> =20
> -EXPORT_SYMBOL(w1_family_get);
>  EXPORT_SYMBOL(w1_family_put);
>  EXPORT_SYMBOL(__w1_family_get);
> -EXPORT_SYMBOL(__w1_family_put);
>  EXPORT_SYMBOL(w1_family_registered);
>  EXPORT_SYMBOL(w1_unregister_family);
>  EXPORT_SYMBOL(w1_register_family);

You break good writting style.

> --- linux-2.6.10-rc2-mm3-full/drivers/w1/w1_io.h.old	2004-11-29 02:19:54.=
000000000 +0100
> +++ linux-2.6.10-rc2-mm3-full/drivers/w1/w1_io.h	2004-11-29 02:21:08.0000=
00000 +0100
> @@ -24,12 +24,9 @@
> =20
>  #include "w1.h"
> =20
> -void w1_delay(unsigned long);
>  u8 w1_touch_bit(struct w1_master *, int);
>  void w1_write_bit(struct w1_master *, int);
>  void w1_write_8(struct w1_master *, u8);
> -u8 w1_read_bit(struct w1_master *);
> -u8 w1_read_8(struct w1_master *);
>  int w1_reset_bus(struct w1_master *);
>  u8 w1_calc_crc8(u8 *, int);
>  void w1_write_block(struct w1_master *, u8 *, int);
> --- linux-2.6.10-rc2-mm3-full/drivers/w1/w1_io.c.old	2004-11-29 02:20:11.=
000000000 +0100
> +++ linux-2.6.10-rc2-mm3-full/drivers/w1/w1_io.c	2004-11-29 02:21:39.0000=
00000 +0100
> @@ -28,7 +28,9 @@
>  #include "w1_log.h"
>  #include "w1_io.h"
> =20
> -int w1_delay_parm =3D 1;
> +static u8 w1_read_bit(struct w1_master *dev);
> +
> +static int w1_delay_parm =3D 1;
>  module_param_named(delay_coef, w1_delay_parm, int, 0);

This can not be static - embedded setups without modules support with
unusual=20
HZ value need this value to create hacks over udelay() to control
protocol timslices.
I have discussion with some arm people about it - this will be changed
when kernel=20
connector will be in mainline.

>  static u8 w1_crc8_table[] =3D {
> @@ -50,7 +52,7 @@
>  	116, 42, 200, 150, 21, 75, 169, 247, 182, 232, 10, 84, 215, 137, 107, 5=
3
>  };
> =20
> -void w1_delay(unsigned long tm)
> +static void w1_delay(unsigned long tm)
>  {
>  	udelay(tm * w1_delay_parm);
>  }
> @@ -89,7 +91,7 @@
>  			w1_write_bit(dev, (byte >> i) & 0x1);
>  }
> =20
> -u8 w1_read_bit(struct w1_master *dev)
> +static u8 w1_read_bit(struct w1_master *dev)
>  {
>  	int result;
> =20
> @@ -104,7 +106,7 @@
>  	return result & 0x1;
>  }
> =20
> -u8 w1_read_8(struct w1_master * dev)
> +static u8 w1_read_8(struct w1_master * dev)
>  {
>  	int i;
>  	u8 res =3D 0;
> @@ -176,10 +178,7 @@
> =20
>  EXPORT_SYMBOL(w1_write_bit);
>  EXPORT_SYMBOL(w1_write_8);
> -EXPORT_SYMBOL(w1_read_bit);
> -EXPORT_SYMBOL(w1_read_8);
>  EXPORT_SYMBOL(w1_reset_bus);
>  EXPORT_SYMBOL(w1_calc_crc8);
> -EXPORT_SYMBOL(w1_delay);
>  EXPORT_SYMBOL(w1_read_block);
>  EXPORT_SYMBOL(w1_write_block);

You break it again.


Resume:
1. Lets wait untill current pending patches will be in mainline - it
includes your previous changes.
2. I will push upstream some of the above changes after 1.

I greatly appreciate your help, thank you Adrian.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-pRt4D33mMi4mpOhom374
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBqq/NIKTPhE+8wY0RAprgAKCGu0pxmSR+QnSr83wc28xesPYCcgCeJF63
L8OKcTzIZSOPt4ITtmeNfgE=
=iar6
-----END PGP SIGNATURE-----

--=-pRt4D33mMi4mpOhom374--

