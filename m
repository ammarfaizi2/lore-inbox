Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265465AbUAGKrE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 05:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265132AbUAGKrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 05:47:04 -0500
Received: from mail.dit.upm.es ([138.4.2.7]:10440 "EHLO mail.dit.upm.es")
	by vger.kernel.org with ESMTP id S266184AbUAGKqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 05:46:53 -0500
Subject: Re: Joystick Autofire Support for linux
From: Juan Antonio Martinez <jantonio@dit.upm.es>
To: linux-kernel@vger.kernel.org
Cc: emard@softhome.net
In-Reply-To: <20040102160929.GA31075@emard>
References: <20040102160929.GA31075@emard>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-X6+WxYCRHrZoqQaRLV7H"
Organization: Dpto Ingenieria Telematica
Message-Id: <1073472408.20464.68.camel@jonsy.dit.upm.es>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 07 Jan 2004 11:46:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-X6+WxYCRHrZoqQaRLV7H
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

El vie, 02-01-2004 a las 17:09, Emard escribi=F3:
> HI!
>=20
> For linux I made the kernel patch that adds autofire support
> for old mechanic joysticks that don't have it. The linux personna
> in charge doesn't want this functionality in kernel because he
> thinks it belongs to the application but I don't think so=20
> because I know there exist some joysticks with autofire hardware
> TTL circuits built in.
>=20
> Please forward this patch to some xmame related site so people can
> use it.. it is for 2.4 and 2.6 kernels.

I'm not the mantainer of XMame since 1999; anyway, i'll try to forward
your mail to xmame and l-kernel lists

A few comments on your code an a humble opinion. Note that I'm
a kernel "observer" not "programmer" :-)

- Joystick api is too simple: just a syscall to read events and=20
an ioctl's to set device. It's responsability of the user to=20
make polling ant take note on extra features. There are lot of
devices in Linux kernel that follow this approach

- DB9 joysticks are really old. If you really want to implement
 autofire, perhaps a better approach is to make it a generic
option, not exclusive to db9 joysticks... A doubt: are there
similar features in HID devices ? (keypads, mouse buttons...)

- Your code stats autofire on module load. I think it would=20
be better make it a runtime option, via ioctl or sysfs. Not
sure that making changes in API would be a good idea...

- I need further study, but a simple on/off swicht as=20
used in your code could result on missfunction: think on=20
hot plug/unplug issues...

- Some middleware already implements autofire features. No real
need of doing it at kernel level. In fact, i remember some
games that takes care on it... my very (very) early versions=20
on Xmame, for instance... :-)

IM(very)HO, a generic autofire input runtime option is a=20
"could be" at kernel level, but not with this approach

Regards

> Best regards, and Happy New Year
> Emard
>=20
> --- linux-2.4.23/drivers/char/joystick/db9.c.orig	Thu Sep 13 00:34:06 200=
1
> +++ linux-2.4.23/drivers/char/joystick/db9.c	Thu Jan  1 14:26:33 2004
> @@ -42,9 +42,9 @@
> =20
>  MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
>  MODULE_LICENSE("GPL");
> -MODULE_PARM(db9, "2i");
> -MODULE_PARM(db9_2, "2i");
> -MODULE_PARM(db9_3, "2i");
> +MODULE_PARM(db9, "2-3i");
> +MODULE_PARM(db9_2, "2-3i");
> +MODULE_PARM(db9_3, "2-3i");
> =20
>  #define DB9_MULTI_STICK		0x01
>  #define DB9_MULTI2_STICK	0x02
> @@ -77,15 +77,16 @@ MODULE_PARM(db9_3, "2i");
>  #define DB9_GENESIS6_DELAY	14
>  #define DB9_REFRESH_TIME	HZ/100
> =20
> -static int db9[] __initdata =3D { -1, 0 };
> -static int db9_2[] __initdata =3D { -1, 0 };
> -static int db9_3[] __initdata =3D { -1, 0 };
> +static int db9[] __initdata =3D { -1, 0, 0 };
> +static int db9_2[] __initdata =3D { -1, 0, 0 };
> +static int db9_3[] __initdata =3D { -1, 0, 0 };
> =20
>  struct db9 {
>  	struct input_dev dev[2];
>  	struct timer_list timer;
>  	struct pardevice *pd;=09
>  	int mode;
> +	unsigned int autofire, autofire_hammer;
>  	int used;
>  };
> =20
> @@ -108,6 +109,7 @@ static void db9_timer(unsigned long priv
>  	struct parport *port =3D db9->pd->port;
>  	struct input_dev *dev =3D db9->dev;
>  	int data, i;
> +	unsigned int autofire =3D (db9->autofire_hammer ^=3D db9->autofire);
> =20
>  	switch(db9->mode) {
>  		case DB9_MULTI_0802_2:
> @@ -130,7 +132,7 @@ static void db9_timer(unsigned long priv
>  		case DB9_MULTI_STICK:
> =20
>  			data =3D parport_read_data(port);
> -
> +			data |=3D autofire;
>  			input_report_abs(dev, ABS_X, (data & DB9_RIGHT ? 0 : 1) - (data & DB9=
_LEFT ? 0 : 1));
>  			input_report_abs(dev, ABS_Y, (data & DB9_DOWN  ? 0 : 1) - (data & DB9=
_UP   ? 0 : 1));
>  			input_report_key(dev, BTN_TRIGGER, ~data & DB9_FIRE1);
> @@ -139,7 +141,7 @@ static void db9_timer(unsigned long priv
>  		case DB9_MULTI2_STICK:
> =20
>  			data =3D parport_read_data(port);
> -
> +			data |=3D autofire;
>  			input_report_abs(dev, ABS_X, (data & DB9_RIGHT ? 0 : 1) - (data & DB9=
_LEFT ? 0 : 1));
>  			input_report_abs(dev, ABS_Y, (data & DB9_DOWN  ? 0 : 1) - (data & DB9=
_UP   ? 0 : 1));
>  			input_report_key(dev, BTN_TRIGGER, ~data & DB9_FIRE1);
> @@ -306,7 +308,7 @@ static struct db9 __init *db9_probe(int=20
>  	if (config[0] < 0)
>  		return NULL;
>  	if (config[1] < 1 || config[1] >=3D DB9_MAX_PAD || !db9_buttons[config[=
1]]) {
> -		printk(KERN_ERR "db9.c: bad config\n");
> +		printk(KERN_ERR "db9.c: bad config %d,%d,%d\n", config[0], config[1], =
config[2]);
>  		return NULL;
>  	}
> =20
> @@ -328,6 +330,8 @@ static struct db9 __init *db9_probe(int=20
>  	memset(db9, 0, sizeof(struct db9));
> =20
>  	db9->mode =3D config[1];
> +	db9->autofire =3D config[2];
> +	db9->autofire_hammer =3D 0;
>  	init_timer(&db9->timer);
>  	db9->timer.data =3D (long) db9;
>  	db9->timer.function =3D db9_timer;
>=20
> --- linux-2.6.0/drivers/input/joystick/db9.c.orig	2004-01-01 14:59:30.000=
000000 +0100
> +++ linux-2.6.0/drivers/input/joystick/db9.c	2004-01-01 14:59:35.00000000=
0 +0100
> @@ -42,9 +42,9 @@ MODULE_AUTHOR("Vojtech Pavlik <vojtech@u
>  MODULE_DESCRIPTION("Atari, Amstrad, Commodore, Amiga, Sega, etc. joystic=
k driver");
>  MODULE_LICENSE("GPL");
> =20
> -MODULE_PARM(db9, "2i");
> -MODULE_PARM(db9_2, "2i");
> -MODULE_PARM(db9_3, "2i");
> +MODULE_PARM(db9, "2-3i");
> +MODULE_PARM(db9_2, "2-3i");
> +MODULE_PARM(db9_3, "2-3i");
> =20
>  #define DB9_MULTI_STICK		0x01
>  #define DB9_MULTI2_STICK	0x02
> @@ -76,15 +76,16 @@ MODULE_PARM(db9_3, "2i");
>  #define DB9_GENESIS6_DELAY	14
>  #define DB9_REFRESH_TIME	HZ/100
> =20
> -static int db9[] __initdata =3D { -1, 0 };
> -static int db9_2[] __initdata =3D { -1, 0 };
> -static int db9_3[] __initdata =3D { -1, 0 };
> +static int db9[] __initdata =3D { -1, 0, 0 };
> +static int db9_2[] __initdata =3D { -1, 0, 0 };
> +static int db9_3[] __initdata =3D { -1, 0, 0 };
> =20
>  struct db9 {
>  	struct input_dev dev[DB9_MAX_DEVICES];
>  	struct timer_list timer;
>  	struct pardevice *pd;=09
>  	int mode;
> +	unsigned int autofire, autofire_hammer;
>  	int used;
>  	char phys[2][32];
>  };
> @@ -343,6 +344,7 @@ static void db9_timer(unsigned long priv
>  	struct parport *port =3D db9->pd->port;
>  	struct input_dev *dev =3D db9->dev;
>  	int data, i;
> +	unsigned int autofire =3D (db9->autofire_hammer ^=3D db9->autofire);
> =20
>  	switch(db9->mode) {
>  		case DB9_MULTI_0802_2:
> @@ -365,7 +367,7 @@ static void db9_timer(unsigned long priv
>  		case DB9_MULTI_STICK:
> =20
>  			data =3D parport_read_data(port);
> -
> +			data |=3D autofire;
>  			input_report_abs(dev, ABS_X, (data & DB9_RIGHT ? 0 : 1) - (data & DB9=
_LEFT ? 0 : 1));
>  			input_report_abs(dev, ABS_Y, (data & DB9_DOWN  ? 0 : 1) - (data & DB9=
_UP   ? 0 : 1));
>  			input_report_key(dev, BTN_TRIGGER, ~data & DB9_FIRE1);
> @@ -374,7 +376,7 @@ static void db9_timer(unsigned long priv
>  		case DB9_MULTI2_STICK:
> =20
>  			data =3D parport_read_data(port);
> -
> +			data |=3D autofire;
>  			input_report_abs(dev, ABS_X, (data & DB9_RIGHT ? 0 : 1) - (data & DB9=
_LEFT ? 0 : 1));
>  			input_report_abs(dev, ABS_Y, (data & DB9_DOWN  ? 0 : 1) - (data & DB9=
_UP   ? 0 : 1));
>  			input_report_key(dev, BTN_TRIGGER, ~data & DB9_FIRE1);
> @@ -527,7 +529,7 @@ static struct db9 __init *db9_probe(int=20
>  	if (config[0] < 0)
>  		return NULL;
>  	if (config[1] < 1 || config[1] >=3D DB9_MAX_PAD || !db9_buttons[config[=
1]]) {
> -		printk(KERN_ERR "db9.c: bad config\n");
> +		printk(KERN_ERR "db9.c: bad config %d,%d,%d\n", config[0], config[1], =
config[2]);
>  		return NULL;
>  	}
> =20
> @@ -551,6 +553,8 @@ static struct db9 __init *db9_probe(int=20
>  	memset(db9, 0, sizeof(struct db9));
> =20
>  	db9->mode =3D config[1];
> +	db9->autofire =3D config[2];
> +	db9->autofire_hammer =3D 0;
>  	init_timer(&db9->timer);
>  	db9->timer.data =3D (long) db9;
>  	db9->timer.function =3D db9_timer;
>=20
> --- joystick-parport.txt.orig	Thu Jan  1 14:03:27 2004
> +++ joystick-parport.txt	Thu Jan  1 14:50:35 2004
> @@ -465,7 +465,7 @@ ports.
>    Apart from making an interface, there is nothing difficult on using th=
e
>  db9.c driver. It uses the following kernel/module command line:
> =20
> -	db9=3Dport,type
> +	db9=3Dport,type[,autofire]
> =20
>    Where 'port' is the number of the parport interface (eg. 0 for parport=
0).
> =20
> @@ -473,7 +473,7 @@ db9.c driver. It uses the following kern
>  your parallel port is recent enough, you should have no trouble with thi=
s.
>  Old parallel ports may not have this feature.
> =20
> -  'Type' is the type of joystick or pad attached:
> +  'type' is the type of joystick or pad attached:
> =20
>  	Type | Joystick/Pad
>  	--------------------
> @@ -491,6 +491,37 @@ Old parallel ports may not have this fea
>    Should you want to use more than one of these joysticks/pads at once, =
you
>  can use db9_2 and db9_3 as additional command line parameters for two
>  more joysticks/pads.
> +
> +  'autofire' is bitmask of the controls for which you want to enable
> +autofire. This means when e.g. Button 1 is pressed and the autofire=20
> +control bit is set (nonzero) for this button, then it will keep sending=20
> +rapid button press and release events until the Button 1 is released.
> +
> +	Autofire | Control
> +	------------------
> +	   0     | None
> +	   1     | Up
> +	   2     | Down
> +	   4     | Left
> +	   8     | Right
> +	  16     | Button 1
> +	  32	 | Button 2
> +	  64	 | Button 3
> +	 128     | Button 4
> +
> +Caveat: autofire option takes effect only for multisystem joyticks=20
> +of types 1 and 2. However it is easy to add support for other types=20
> +as well. If you do own such joysticks, support it, test it and send=20
> +the patch.
> +
> +Usage example:
> +
> +On parport0 (port=3D0) is connected Commodore 64 joystick=20
> +(type=3D1, Multisystem 1-button joystick).=20
> +Let autofire be enabled for the 'Button 1' (Control=3D16)=20
> +and 'Up' (Control=3D1), (autofire =3D 16+1 =3D 17)
> +
> +modprobe db9 db9=3D0,1,17
> =20
>  3.3 turbografx.c
>  ~~~~~~~~~~~~~~~~
>=20
>=20
> ----- End forwarded message -----
--=20
Juan Antonio Martinez <jantonio@dit.upm.es>
Dpto Ingenieria Telematica

--=-X6+WxYCRHrZoqQaRLV7H
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/++OY91t204u+Bn4RAoAAAJ9p2oWMrK6FlAp064gegsRLYp62iACfZdot
G3iJWfOlxsJnbZ+Pj+9My90=
=xmKx
-----END PGP SIGNATURE-----

--=-X6+WxYCRHrZoqQaRLV7H--

