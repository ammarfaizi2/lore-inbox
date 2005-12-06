Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbVLFTxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbVLFTxE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 14:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbVLFTxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 14:53:03 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:16349 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964992AbVLFTxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 14:53:02 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] b2c2: make front-ends selectable and include noob option
Date: Tue, 6 Dec 2005 20:52:56 +0100
User-Agent: KMail/1.9
Cc: linux-dvb-maintainer@linuxtv.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1610837.WGg7q8Wmns";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200512062053.00711.prakash@punnoor.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1610837.WGg7q8Wmns
Content-Type: multipart/mixed;
  boundary="Boundary-01=_YwelDFDFexeWxv2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_YwelDFDFexeWxv2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

this patch probably needs some touch-up but mainly I am sking the dvb guys =
why=20
don't they do something like this. Current situation:

=46or my Skystar2 card I am forced to compile in half a dozen front-ends + =
fw=20
loader - but I only need one front-end driver and no fw loader. Furthermore=
=20
this crap in the log goes away by throwing unneccessary stuff out:

before:
b2c2-flexcop: B2C2 FlexcopII/II(b)/III digital TV receiver chip loaded=20
successfully
flexcop-pci: will use the HW PID filter.
flexcop-pci: card revision 1
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [APC1] -> GSI 16 (level, high) =
=2D>=20
IRQ 17
DVB: registering new adapter (FlexCop Digital TV device).
b2c2-flexcop: MAC address =3D 00:d0:d7:03:73:66
b2c2-flexcop: i2c master_xfer failed
b2c2-flexcop: i2c master_xfer failed
b2c2-flexcop: i2c master_xfer failed
mt352_read_register: readreg error (reg=3D127, ret=3D=3D-121)
b2c2-flexcop: i2c master_xfer failed
i2c_readbytes: i2c read error (addr 0a, err =3D=3D -121)
b2c2-flexcop: i2c master_xfer failed
lgdt330x: i2c_read_demod_bytes: addr 0x59 select 0x02 error (ret =3D=3D -12=
1)
b2c2-flexcop: i2c master_xfer failed
b2c2-flexcop: i2c master_xfer failed
stv0297_readreg: readreg error (reg =3D=3D 0x80, ret =3D=3D -22)
b2c2-flexcop: found the vp310 (aka mt312) at i2c address: 0x0e
DVB: registering frontend 0 (Zarlink VP310 DVB-S)...
b2c2-flexcop: initialization of 'Sky2PC/SkyStar 2 DVB-S (old version)' at t=
he=20
'PCI' bus controlled by a 'FlexCopII' complete

after:
b2c2-flexcop: B2C2 FlexcopII/II(b)/III digital TV receiver chip loaded=20
successfully
flexcop-pci: will use the HW PID filter.
flexcop-pci: card revision 1
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [APC1] -> GSI 16 (level, high) =
=2D>=20
IRQ 17
DVB: registering new adapter (FlexCop Digital TV device).
b2c2-flexcop: MAC address =3D 00:d0:d7:03:73:66
b2c2-flexcop: found the vp310 (aka mt312) at i2c address: 0x0e
DVB: registering frontend 0 (Zarlink VP310 DVB-S)...
b2c2-flexcop: initialization of 'Sky2PC/SkyStar 2 DVB-S (old version)' at t=
he=20
'PCI' bus controlled by a 'FlexCopII' complete

Needless to say that my kernel size is a bit smaller and my card still work=
s.

I made the patch trying to follow: http://www.linuxjournal.com/article/5780
by Greg Kroah-Hartman, esp the paragraph "No ifdefs in .c Code". Unfortunat=
ely=20
there this is the problem with request_firmware(...) which I needed to ifde=
f=20
out. Probably someone has a better idea.

I also added an *option* to include every supported front-end, so that noob=
s=20
don't have to guess around and I guess this was the intention by the dvb de=
vs=20
by selection all frontends by default. I only dislike the missing possibili=
ty=20
to deselect unwanted ones. (Is it possible to select this option by default=
?=20
I don't know much about Kbuild.)

Anyway I asked the dvb guys why the included everything unselectable by=20
default, but I got no response, thus I submit this patch hoping to get more=
=20
response now.

Of course, this patch only addresses the b2c2 chips. So here it goes, hopin=
g I=20
haven't missed anything:

signed-off-by: Prakash Punnoor <prakash@punnoor.de>


diff -urd dvb.old/b2c2/flexcop-fe-tuner.c dvb/b2c2/flexcop-fe-tuner.c
=2D-- dvb.old/b2c2/flexcop-fe-tuner.c	2005-12-06 19:55:39.060449080 +0100
+++ dvb/b2c2/flexcop-fe-tuner.c	2005-12-06 20:29:55.144876736 +0100
@@ -293,8 +293,12 @@
=20
 static int flexcop_fe_request_firmware(struct dvb_frontend* fe, const stru=
ct=20
firmware **fw, char* name)
 {
+#ifdef CONFIG_FW_LOADER
 	struct flexcop_device *fc =3D fe->dvb->priv;
 	return request_firmware(fw, name, fc->dev);
+#else
+	return -EINVAL;
+#endif
 }
=20
 static int lgdt3303_pll_set(struct dvb_frontend* fe,
diff -urd dvb.old/b2c2/Kconfig dvb/b2c2/Kconfig
=2D-- dvb.old/b2c2/Kconfig	2005-12-06 19:55:39.060449080 +0100
+++ dvb/b2c2/Kconfig	2005-12-06 20:36:36.751823200 +0100
@@ -1,6 +1,15 @@
 config DVB_B2C2_FLEXCOP
 	tristate "Technisat/B2C2 FlexCopII(b) and FlexCopIII adapters"
 	depends on DVB_CORE
+	help
+	  Support for the digital TV receiver chip made by B2C2 Inc. included in
+	  Technisats PCI cards and USB boxes.
+
+	  Say Y if you own such a device and want to use it.
+
+config DVB_B2C2_FLEXCOP_ALL_FRONTENDS
+	bool "Select all supported front-ends"
+	depends on DVB_B2C2_FLEXCOP
 	select DVB_STV0299
 	select DVB_MT352
 	select DVB_MT312
@@ -9,10 +18,12 @@
 	select DVB_BCM3510
 	select DVB_LGDT330X
 	help
=2D	  Support for the digital TV receiver chip made by B2C2 Inc. included in
=2D	  Technisats PCI cards and USB boxes.
+	  Selects all supported front-ends by Technisat/B2C2 driver.
+	  If you don't select this option, you must select the correct
+	  front-end by hand.
+
+	  Say Y if you don't know your front-end.
=20
=2D	  Say Y if you own such a device and want to use it.
=20
 config DVB_B2C2_FLEXCOP_PCI
 	tristate "Technisat/B2C2 Air/Sky/Cable2PC PCI"
diff -urd dvb.old/frontends/bcm3510.h dvb/frontends/bcm3510.h
=2D-- dvb.old/frontends/bcm3510.h	2005-12-06 19:55:39.445390560 +0100
+++ dvb/frontends/bcm3510.h	2005-12-06 20:09:37.878929288 +0100
@@ -34,7 +34,15 @@
 	int (*request_firmware)(struct dvb_frontend* fe, const struct firmware **=
fw,=20
char* name);
 };
=20
+#ifdef CONFIG_DVB_BCM3510
 extern struct dvb_frontend* bcm3510_attach(const struct bcm3510_config*=20
config,
 					   struct i2c_adapter* i2c);
+#else
+static inline struct dvb_frontend* bcm3510_attach(const struct=20
bcm3510_config* config,
+						  struct i2c_adapter* i2c)
+{
+	return NULL;
+}
+#endif
=20
 #endif
diff -urd dvb.old/frontends/lgdt330x.h dvb/frontends/lgdt330x.h
=2D-- dvb.old/frontends/lgdt330x.h	2005-12-06 19:55:39.645360160 +0100
+++ dvb/frontends/lgdt330x.h	2005-12-06 20:00:10.309213000 +0100
@@ -53,8 +53,16 @@
 	int clock_polarity_flip;
 };
=20
+#ifdef CONFIG_DVB_LGDT330X
 extern struct dvb_frontend* lgdt330x_attach(const struct lgdt330x_config*=
=20
config,
 					    struct i2c_adapter* i2c);
+#else
+static inline struct dvb_frontend* lgdt330x_attach(const struct=20
lgdt330x_config* config,
+						   struct i2c_adapter* i2c)
+{
+	return NULL;
+}
+#endif
=20
 #endif /* LGDT330X_H */
=20
diff -urd dvb.old/frontends/mt312.h dvb/frontends/mt312.h
=2D-- dvb.old/frontends/mt312.h	2005-12-06 19:55:39.503381744 +0100
+++ dvb/frontends/mt312.h	2005-12-06 20:04:07.191201464 +0100
@@ -38,10 +38,24 @@
 	int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters*=20
params);
 };
=20
+#ifdef CONFIG_DVB_MT312
 extern struct dvb_frontend* mt312_attach(const struct mt312_config* config,
 					 struct i2c_adapter* i2c);
=20
 extern struct dvb_frontend* vp310_attach(const struct mt312_config* config,
 					 struct i2c_adapter* i2c);
+#else
+static inline struct dvb_frontend* mt312_attach(const struct mt312_config*=
=20
config,
+						struct i2c_adapter* i2c)
+{
+	return NULL;
+}
+
+static inline struct dvb_frontend* vp310_attach(const struct mt312_config*=
=20
config,
+						struct i2c_adapter* i2c)
+{
+	return NULL;
+}
+#endif
=20
 #endif // MT312_H
diff -urd dvb.old/frontends/mt352.h dvb/frontends/mt352.h
=2D-- dvb.old/frontends/mt352.h	2005-12-06 19:55:39.540376120 +0100
+++ dvb/frontends/mt352.h	2005-12-06 20:04:21.881968128 +0100
@@ -57,9 +57,22 @@
 	int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters*=20
params, u8* pllbuf);
 };
=20
+#ifdef CONFIG_DVB_MT352
 extern struct dvb_frontend* mt352_attach(const struct mt352_config* config,
 					 struct i2c_adapter* i2c);
=20
 extern int mt352_write(struct dvb_frontend* fe, u8* ibuf, int ilen);
+#else
+static inline struct dvb_frontend* mt352_attach(const struct mt352_config*=
=20
config,
+						struct i2c_adapter* i2c)
+{
+	return NULL;
+}
+
+static inline int mt352_write(struct dvb_frontend* fe, u8* ibuf, int ilen)
+{
+	return 0;
+}
+#endif
=20
 #endif // MT352_H
diff -urd dvb.old/frontends/nxt2002.h dvb/frontends/nxt2002.h
=2D-- dvb.old/frontends/nxt2002.h	2005-12-06 19:55:39.540376120 +0100
+++ dvb/frontends/nxt2002.h	2005-12-06 20:08:39.722770368 +0100
@@ -17,7 +17,15 @@
 	int (*request_firmware)(struct dvb_frontend* fe, const struct firmware **=
fw,=20
char* name);
 };
=20
+#ifdef CONFIG_DVB_NXT2002
 extern struct dvb_frontend* nxt2002_attach(const struct nxt2002_config*=20
config,
 					   struct i2c_adapter* i2c);
+#else
+static inline struct dvb_frontend* nxt2002_attach(const struct=20
nxt2002_config* config,
+						  struct i2c_adapter* i2c)
+{
+	return NULL;
+}
+#endif
=20
 #endif // NXT2002_H
diff -urd dvb.old/frontends/stv0297.h dvb/frontends/stv0297.h
=2D-- dvb.old/frontends/stv0297.h	2005-12-06 19:55:39.577370496 +0100
+++ dvb/frontends/stv0297.h	2005-12-06 20:06:34.959737232 +0100
@@ -43,8 +43,21 @@
 	int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters*=20
params);
 };
=20
+#ifdef CONFIG_DVB_STV0297
 extern struct dvb_frontend* stv0297_attach(const struct stv0297_config*=20
config,
 					   struct i2c_adapter* i2c);
 extern int stv0297_enable_plli2c(struct dvb_frontend* fe);
+#else
+static inline struct dvb_frontend* stv0297_attach(const struct=20
stv0297_config* config,
+						  struct i2c_adapter* i2c)
+{
+	return NULL;
+}
+
+static inline int stv0297_enable_plli2c(struct dvb_frontend* fe)
+{
+	return 0;
+}
+#endif
=20
 #endif // STV0297_H
diff -urd dvb.old/frontends/stv0299.h dvb/frontends/stv0299.h
=2D-- dvb.old/frontends/stv0299.h	2005-12-06 19:55:39.681354688 +0100
+++ dvb/frontends/stv0299.h	2005-12-06 19:59:45.158036560 +0100
@@ -93,9 +93,22 @@
 	int (*pll_set)(struct dvb_frontend *fe, struct i2c_adapter *i2c, struct=20
dvb_frontend_parameters *params);
 };
=20
+#ifdef CONFIG_DVB_STV0299
 extern int stv0299_writereg (struct dvb_frontend* fe, u8 reg, u8 data);
=20
 extern struct dvb_frontend* stv0299_attach(const struct stv0299_config*=20
config,
 					   struct i2c_adapter* i2c);
+#else
+static inline int stv0299_writereg (struct dvb_frontend* fe, u8 reg, u8 da=
ta)
+{
+	return 0;
+}
+
+static inline struct dvb_frontend* stv0299_attach(const struct=20
stv0299_config* config,
+						  struct i2c_adapter* i2c)
+{
+	return NULL;
+}
+#endif
=20
 #endif // STV0299_H




=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--Boundary-01=_YwelDFDFexeWxv2
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="b2c2_selectable_frontends.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="b2c2_selectable_frontends.diff"

diff -urd dvb.old/b2c2/flexcop-fe-tuner.c dvb/b2c2/flexcop-fe-tuner.c
=2D-- dvb.old/b2c2/flexcop-fe-tuner.c	2005-12-06 19:55:39.060449080 +0100
+++ dvb/b2c2/flexcop-fe-tuner.c	2005-12-06 20:29:55.144876736 +0100
@@ -293,8 +293,12 @@
=20
 static int flexcop_fe_request_firmware(struct dvb_frontend* fe, const stru=
ct firmware **fw, char* name)
 {
+#ifdef CONFIG_FW_LOADER
 	struct flexcop_device *fc =3D fe->dvb->priv;
 	return request_firmware(fw, name, fc->dev);
+#else
+	return -EINVAL;
+#endif
 }
=20
 static int lgdt3303_pll_set(struct dvb_frontend* fe,
diff -urd dvb.old/b2c2/Kconfig dvb/b2c2/Kconfig
=2D-- dvb.old/b2c2/Kconfig	2005-12-06 19:55:39.060449080 +0100
+++ dvb/b2c2/Kconfig	2005-12-06 20:36:36.751823200 +0100
@@ -1,6 +1,15 @@
 config DVB_B2C2_FLEXCOP
 	tristate "Technisat/B2C2 FlexCopII(b) and FlexCopIII adapters"
 	depends on DVB_CORE
+	help
+	  Support for the digital TV receiver chip made by B2C2 Inc. included in
+	  Technisats PCI cards and USB boxes.
+
+	  Say Y if you own such a device and want to use it.
+
+config DVB_B2C2_FLEXCOP_ALL_FRONTENDS
+	bool "Select all supported front-ends"
+	depends on DVB_B2C2_FLEXCOP
 	select DVB_STV0299
 	select DVB_MT352
 	select DVB_MT312
@@ -9,10 +18,12 @@
 	select DVB_BCM3510
 	select DVB_LGDT330X
 	help
=2D	  Support for the digital TV receiver chip made by B2C2 Inc. included in
=2D	  Technisats PCI cards and USB boxes.
+	  Selects all supported front-ends by Technisat/B2C2 driver.
+	  If you don't select this option, you must select the correct
+	  front-end by hand.
+
+	  Say Y if you don't know your front-end.
=20
=2D	  Say Y if you own such a device and want to use it.
=20
 config DVB_B2C2_FLEXCOP_PCI
 	tristate "Technisat/B2C2 Air/Sky/Cable2PC PCI"
diff -urd dvb.old/frontends/bcm3510.h dvb/frontends/bcm3510.h
=2D-- dvb.old/frontends/bcm3510.h	2005-12-06 19:55:39.445390560 +0100
+++ dvb/frontends/bcm3510.h	2005-12-06 20:09:37.878929288 +0100
@@ -34,7 +34,15 @@
 	int (*request_firmware)(struct dvb_frontend* fe, const struct firmware **=
fw, char* name);
 };
=20
+#ifdef CONFIG_DVB_BCM3510
 extern struct dvb_frontend* bcm3510_attach(const struct bcm3510_config* co=
nfig,
 					   struct i2c_adapter* i2c);
+#else
+static inline struct dvb_frontend* bcm3510_attach(const struct bcm3510_con=
fig* config,
+						  struct i2c_adapter* i2c)
+{
+	return NULL;
+}
+#endif
=20
 #endif
diff -urd dvb.old/frontends/lgdt330x.h dvb/frontends/lgdt330x.h
=2D-- dvb.old/frontends/lgdt330x.h	2005-12-06 19:55:39.645360160 +0100
+++ dvb/frontends/lgdt330x.h	2005-12-06 20:00:10.309213000 +0100
@@ -53,8 +53,16 @@
 	int clock_polarity_flip;
 };
=20
+#ifdef CONFIG_DVB_LGDT330X
 extern struct dvb_frontend* lgdt330x_attach(const struct lgdt330x_config* =
config,
 					    struct i2c_adapter* i2c);
+#else
+static inline struct dvb_frontend* lgdt330x_attach(const struct lgdt330x_c=
onfig* config,
+						   struct i2c_adapter* i2c)
+{
+	return NULL;
+}
+#endif
=20
 #endif /* LGDT330X_H */
=20
diff -urd dvb.old/frontends/mt312.h dvb/frontends/mt312.h
=2D-- dvb.old/frontends/mt312.h	2005-12-06 19:55:39.503381744 +0100
+++ dvb/frontends/mt312.h	2005-12-06 20:04:07.191201464 +0100
@@ -38,10 +38,24 @@
 	int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters* p=
arams);
 };
=20
+#ifdef CONFIG_DVB_MT312
 extern struct dvb_frontend* mt312_attach(const struct mt312_config* config,
 					 struct i2c_adapter* i2c);
=20
 extern struct dvb_frontend* vp310_attach(const struct mt312_config* config,
 					 struct i2c_adapter* i2c);
+#else
+static inline struct dvb_frontend* mt312_attach(const struct mt312_config*=
 config,
+						struct i2c_adapter* i2c)
+{
+	return NULL;
+}
+
+static inline struct dvb_frontend* vp310_attach(const struct mt312_config*=
 config,
+						struct i2c_adapter* i2c)
+{
+	return NULL;
+}
+#endif
=20
 #endif // MT312_H
diff -urd dvb.old/frontends/mt352.h dvb/frontends/mt352.h
=2D-- dvb.old/frontends/mt352.h	2005-12-06 19:55:39.540376120 +0100
+++ dvb/frontends/mt352.h	2005-12-06 20:04:21.881968128 +0100
@@ -57,9 +57,22 @@
 	int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters* p=
arams, u8* pllbuf);
 };
=20
+#ifdef CONFIG_DVB_MT352
 extern struct dvb_frontend* mt352_attach(const struct mt352_config* config,
 					 struct i2c_adapter* i2c);
=20
 extern int mt352_write(struct dvb_frontend* fe, u8* ibuf, int ilen);
+#else
+static inline struct dvb_frontend* mt352_attach(const struct mt352_config*=
 config,
+						struct i2c_adapter* i2c)
+{
+	return NULL;
+}
+
+static inline int mt352_write(struct dvb_frontend* fe, u8* ibuf, int ilen)
+{
+	return 0;
+}
+#endif
=20
 #endif // MT352_H
diff -urd dvb.old/frontends/nxt2002.h dvb/frontends/nxt2002.h
=2D-- dvb.old/frontends/nxt2002.h	2005-12-06 19:55:39.540376120 +0100
+++ dvb/frontends/nxt2002.h	2005-12-06 20:08:39.722770368 +0100
@@ -17,7 +17,15 @@
 	int (*request_firmware)(struct dvb_frontend* fe, const struct firmware **=
fw, char* name);
 };
=20
+#ifdef CONFIG_DVB_NXT2002
 extern struct dvb_frontend* nxt2002_attach(const struct nxt2002_config* co=
nfig,
 					   struct i2c_adapter* i2c);
+#else
+static inline struct dvb_frontend* nxt2002_attach(const struct nxt2002_con=
fig* config,
+						  struct i2c_adapter* i2c)
+{
+	return NULL;
+}
+#endif
=20
 #endif // NXT2002_H
diff -urd dvb.old/frontends/stv0297.h dvb/frontends/stv0297.h
=2D-- dvb.old/frontends/stv0297.h	2005-12-06 19:55:39.577370496 +0100
+++ dvb/frontends/stv0297.h	2005-12-06 20:06:34.959737232 +0100
@@ -43,8 +43,21 @@
 	int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters* p=
arams);
 };
=20
+#ifdef CONFIG_DVB_STV0297
 extern struct dvb_frontend* stv0297_attach(const struct stv0297_config* co=
nfig,
 					   struct i2c_adapter* i2c);
 extern int stv0297_enable_plli2c(struct dvb_frontend* fe);
+#else
+static inline struct dvb_frontend* stv0297_attach(const struct stv0297_con=
fig* config,
+						  struct i2c_adapter* i2c)
+{
+	return NULL;
+}
+
+static inline int stv0297_enable_plli2c(struct dvb_frontend* fe)
+{
+	return 0;
+}
+#endif
=20
 #endif // STV0297_H
diff -urd dvb.old/frontends/stv0299.h dvb/frontends/stv0299.h
=2D-- dvb.old/frontends/stv0299.h	2005-12-06 19:55:39.681354688 +0100
+++ dvb/frontends/stv0299.h	2005-12-06 19:59:45.158036560 +0100
@@ -93,9 +93,22 @@
 	int (*pll_set)(struct dvb_frontend *fe, struct i2c_adapter *i2c, struct d=
vb_frontend_parameters *params);
 };
=20
+#ifdef CONFIG_DVB_STV0299
 extern int stv0299_writereg (struct dvb_frontend* fe, u8 reg, u8 data);
=20
 extern struct dvb_frontend* stv0299_attach(const struct stv0299_config* co=
nfig,
 					   struct i2c_adapter* i2c);
+#else
+static inline int stv0299_writereg (struct dvb_frontend* fe, u8 reg, u8 da=
ta)
+{
+	return 0;
+}
+
+static inline struct dvb_frontend* stv0299_attach(const struct stv0299_con=
fig* config,
+						  struct i2c_adapter* i2c)
+{
+	return NULL;
+}
+#endif
=20
 #endif // STV0299_H

--Boundary-01=_YwelDFDFexeWxv2--

--nextPart1610837.WGg7q8Wmns
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDlewcxU2n/+9+t5gRAvV4AKC5CjUAg6lF+6zouu5BOOe+PjnOawCghhfO
wY/Jr90S4kWJeQzb8OOX800=
=wo/q
-----END PGP SIGNATURE-----

--nextPart1610837.WGg7q8Wmns--
