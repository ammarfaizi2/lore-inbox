Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265629AbTFNGKu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 02:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265630AbTFNGKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 02:10:50 -0400
Received: from cpt-dial-196-30-180-57.mweb.co.za ([196.30.180.57]:29824 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S265629AbTFNGKp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 02:10:45 -0400
Subject: Re: [RFC][2.5] list_for_each_safe not so safe (was Re: OOPS
	w83781d during rmmod (2.5.70-bk1[1234]))
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>,
       "Mark M. Hoffman" <mhoffman@lightlink.com>
In-Reply-To: <20030613023651.GA1401@earth.solarsys.private>
References: <20030524183748.GA3097@earth.solarsys.private>
	 <3ED8067E.1050503@paradyne.com>
	 <20030601143808.GA30177@earth.solarsys.private>
	 <20030602172040.GC4992@kroah.com>
	 <20030605023922.GA8943@earth.solarsys.private>
	 <20030605194734.GA6238@kroah.com>
	 <1055136870.5280.196.camel@workshop.saharacpt.lan>
	 <20030610054107.GA22719@earth.solarsys.private>
	 <1055401021.5280.3143.camel@workshop.saharacpt.lan>
	 <20030613023651.GA1401@earth.solarsys.private>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/Fxiu3BCa758avlVSDzQ"
Organization: 
Message-Id: <1055571995.12868.5.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 14 Jun 2003 08:26:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/Fxiu3BCa758avlVSDzQ
Content-Type: multipart/mixed; boundary="=-s9L8rOx87mhzJDPrzJr3"


--=-s9L8rOx87mhzJDPrzJr3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-06-13 at 04:36, Mark M. Hoffman wrote:
> > > > Anyhow, Only change I have made to the w83781d driver, is one line
> > > > (just tell it to that if the chip id is 0x72, its also of type
> > > > w83726HF), but now (2.5.70-bk1[123]) it segfaults for me on rmmod, =
where
> > > > it did not with 2.5.68 kernels when I still had the other board.  I=
 will
> > > > attach a oops tomorrow or such when I get home.
> > >=20

> My first patch was naive; the patch below solves the problem by
> letting w83781d_detach_client remove the three clients (1 * primary
> + 2 * subclients) independently.  It's a noisy patch because I had
> to change the way the subclients were kmalloc'ed - sorry.  The meat
> is around line 1422.  This patch works for me... comments?
>=20
> Regards,
>=20
> ---=20
> Mark M. Hoffman
> mhoffman@lightlink.com

Greg, this patch from Mark fixes it, please include in your stuff
to send to Linus.


Thanks,

--=20

Martin Schlemmer




--=-s9L8rOx87mhzJDPrzJr3
Content-Disposition: attachment; filename=w83781d-fix-rmmod-segfault.patch
Content-Type: text/plain; name=w83781d-fix-rmmod-segfault.patch; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

--- linux-2.5.70-bk14/drivers/i2c/chips/w83781d.c	2003-06-10 00:49:19.00000=
0000 -0400
+++ linux-2.5.70/drivers/i2c/chips/w83781d.c	2003-06-12 22:24:47.000000000 =
-0400
@@ -299,8 +299,8 @@
 	char valid;		/* !=3D0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
=20
-	struct i2c_client *lm75;	/* for secondary I2C addresses */
-	/* pointer to array of 2 subclients */
+	struct i2c_client *lm75[2];	/* for secondary I2C addresses */
+	/* array of 2 pointers to subclients */
=20
 	u8 in[9];		/* Register value - 8 & 9 for 782D only */
 	u8 in_max[9];		/* Register value - 8 & 9 for 782D only */
@@ -1043,12 +1043,12 @@
 	const char *client_name;
 	struct w83781d_data *data =3D i2c_get_clientdata(new_client);
=20
-	if (!(data->lm75 =3D kmalloc(2 * sizeof (struct i2c_client),
-			GFP_KERNEL))) {
+	data->lm75[0] =3D kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	if (!(data->lm75[0])) {
 		err =3D -ENOMEM;
 		goto ERROR_SC_0;
 	}
-	memset(data->lm75, 0x00, 2 * sizeof (struct i2c_client));
+	memset(data->lm75[0], 0x00, sizeof (struct i2c_client));
=20
 	id =3D i2c_adapter_id(adapter);
=20
@@ -1066,25 +1066,33 @@
 		w83781d_write_value(new_client, W83781D_REG_I2C_SUBADDR,
 				(force_subclients[2] & 0x07) |
 				((force_subclients[3] & 0x07) << 4));
-		data->lm75[0].addr =3D force_subclients[2];
+		data->lm75[0]->addr =3D force_subclients[2];
 	} else {
 		val1 =3D w83781d_read_value(new_client, W83781D_REG_I2C_SUBADDR);
-		data->lm75[0].addr =3D 0x48 + (val1 & 0x07);
+		data->lm75[0]->addr =3D 0x48 + (val1 & 0x07);
 	}
=20
 	if (kind !=3D w83783s) {
+
+		data->lm75[1] =3D kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+		if (!(data->lm75[1])) {
+			err =3D -ENOMEM;
+			goto ERROR_SC_1;
+		}
+		memset(data->lm75[1], 0x0, sizeof(struct i2c_client));
+
 		if (force_subclients[0] =3D=3D id &&
 		    force_subclients[1] =3D=3D address) {
-			data->lm75[1].addr =3D force_subclients[3];
+			data->lm75[1]->addr =3D force_subclients[3];
 		} else {
-			data->lm75[1].addr =3D 0x48 + ((val1 >> 4) & 0x07);
+			data->lm75[1]->addr =3D 0x48 + ((val1 >> 4) & 0x07);
 		}
-		if (data->lm75[0].addr =3D=3D data->lm75[1].addr) {
+		if (data->lm75[0]->addr =3D=3D data->lm75[1]->addr) {
 			dev_err(&new_client->dev,
 			       "Duplicate addresses 0x%x for subclients.\n",
-			       data->lm75[0].addr);
+			       data->lm75[0]->addr);
 			err =3D -EBUSY;
-			goto ERROR_SC_1;
+			goto ERROR_SC_2;
 		}
 	}
=20
@@ -1103,19 +1111,19 @@
=20
 	for (i =3D 0; i <=3D 1; i++) {
 		/* store all data in w83781d */
-		i2c_set_clientdata(&data->lm75[i], NULL);
-		data->lm75[i].adapter =3D adapter;
-		data->lm75[i].driver =3D &w83781d_driver;
-		data->lm75[i].flags =3D 0;
-		strlcpy(data->lm75[i].dev.name, client_name,
+		i2c_set_clientdata(data->lm75[i], NULL);
+		data->lm75[i]->adapter =3D adapter;
+		data->lm75[i]->driver =3D &w83781d_driver;
+		data->lm75[i]->flags =3D 0;
+		strlcpy(data->lm75[i]->dev.name, client_name,
 			DEVICE_NAME_SIZE);
-		if ((err =3D i2c_attach_client(&(data->lm75[i])))) {
+		if ((err =3D i2c_attach_client(data->lm75[i]))) {
 			dev_err(&new_client->dev, "Subclient %d "
 				"registration at address 0x%x "
-				"failed.\n", i, data->lm75[i].addr);
+				"failed.\n", i, data->lm75[i]->addr);
 			if (i =3D=3D 1)
-				goto ERROR_SC_2;
-			goto ERROR_SC_1;
+				goto ERROR_SC_3;
+			goto ERROR_SC_2;
 		}
 		if (kind =3D=3D w83783s)
 			break;
@@ -1124,10 +1132,14 @@
 	return 0;
=20
 /* Undo inits in case of errors */
+ERROR_SC_3:
+	i2c_detach_client(data->lm75[0]);
 ERROR_SC_2:
-	i2c_detach_client(&(data->lm75[0]));
+	if (NULL !=3D data->lm75[1])
+		kfree(data->lm75[1]);
 ERROR_SC_1:
-	kfree(data->lm75);
+	if (NULL !=3D data->lm75[0])
+		kfree(data->lm75[0]);
 ERROR_SC_0:
 	return err;
 }
@@ -1326,7 +1338,8 @@
 				kind, new_client)))
 			goto ERROR3;
 	} else {
-		data->lm75 =3D NULL;
+		data->lm75[0] =3D NULL;
+		data->lm75[1] =3D NULL;
 	}
=20
 	device_create_file_in(new_client, 0);
@@ -1409,20 +1422,11 @@
 static int
 w83781d_detach_client(struct i2c_client *client)
 {
-	struct w83781d_data *data =3D i2c_get_clientdata(client);
 	int err;
=20
-	/* release ISA region or I2C subclients first */
-	if (i2c_is_isa_client(client)) {
+	if (i2c_is_isa_client(client))
 		release_region(client->addr, W83781D_EXTENT);
-	} else {
-		i2c_detach_client(&data->lm75[0]);
-		if (data->type !=3D w83783s)
-			i2c_detach_client(&data->lm75[1]);
-		kfree(data->lm75);
-	}
=20
-	/* now it's safe to scrap the rest */
 	if ((err =3D i2c_detach_client(client))) {
 		dev_err(&client->dev,
 		       "Client deregistration failed, client not detached.\n");
@@ -1484,7 +1488,7 @@
 			res =3D i2c_smbus_read_byte_data(client, reg & 0xff);
 		} else {
 			/* switch to subclient */
-			cl =3D &data->lm75[bank - 1];
+			cl =3D data->lm75[bank - 1];
 			/* convert from ISA to LM75 I2C addresses */
 			switch (reg & 0xff) {
 			case 0x50:	/* TEMP */
@@ -1555,7 +1559,7 @@
 						  value & 0xff);
 		} else {
 			/* switch to subclient */
-			cl =3D &data->lm75[bank - 1];
+			cl =3D data->lm75[bank - 1];
 			/* convert from ISA to LM75 I2C addresses */
 			switch (reg & 0xff) {
 			case 0x52:	/* CONFIG */



--=-s9L8rOx87mhzJDPrzJr3--

--=-/Fxiu3BCa758avlVSDzQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+6sAbqburzKaJYLYRAuHZAJ9gOB31P+lf8fEt+a49EF/h0uw2IQCfUZKO
I3CroHfp+8W8m/n80IqAk0Q=
=Inyj
-----END PGP SIGNATURE-----

--=-/Fxiu3BCa758avlVSDzQ--

