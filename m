Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUDCUVl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 15:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbUDCUVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 15:21:40 -0500
Received: from [213.177.124.6] ([213.177.124.6]:26249 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S261928AbUDCUVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 15:21:30 -0500
Date: Sun, 4 Apr 2004 00:20:42 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Jean Delvare <khali@linux-fr.org>
Cc: LM Sensors <sensors@stimpy.netroedge.com>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2.6] Rework memory allocation in i2c chip drivers
Message-ID: <20040403202042.GA3898@sirius.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20040403191023.08f60ff1.khali@linux-fr.org>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

> Some times ago, Ralf Roesch reported that the memory allocation scheme
> used in the i2c eeprom driver was causing trouble on MIPS architecture:
>=20
> http://archives.andrew.net.au/lm-sensors/msg07233.html
>=20
> The cause of the problems is that we do allocate two structures with a
> single kmalloc, which breaks alignment. This doesn't seem to be a
> problem on x86, but is on mips and probably on other architectures as
> well. It happens that all other chip drivers work the same way too, so
> they all would need to be fixed.

Instead of splitting one kmalloc in two, it would also be possible to
add a "struct i2c_client client" field to each of the *_data
structures - the compiler should align all fields appropriately.
Probably this way will result in less changes to the code (and also
less labels and less error paths).

Example patch for lm75 (untested):

--- linux/drivers/i2c/chips/lm75.c.sensors-kmalloc	2004-02-18 06:57:11 +0300
+++ linux/drivers/i2c/chips/lm75.c	2004-04-04 00:11:41 +0400
@@ -50,6 +50,7 @@
=20
 /* Each client has this additional data */
 struct lm75_data {
+	struct i2c_client	client;
 	struct semaphore	update_lock;
 	char			valid;		/* !=3D0 if following fields are valid */
 	unsigned long		last_updated;	/* In jiffies */
@@ -141,16 +142,13 @@
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access lm75_{read,write}_value. */
-	if (!(new_client =3D kmalloc(sizeof(struct i2c_client) +
-				   sizeof(struct lm75_data),
-				   GFP_KERNEL))) {
+	if (!(data =3D kmalloc(sizeof(struct lm75_data), GFP_KERNEL))) {
 		err =3D -ENOMEM;
 		goto exit;
 	}
-	memset(new_client, 0x00, sizeof(struct i2c_client) +
-				 sizeof(struct lm75_data));
+	memset(data, 0x00, sizeof(struct lm75_data));
=20
-	data =3D (struct lm75_data *) (new_client + 1);
+	new_client =3D &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr =3D address;
 	new_client->adapter =3D adapter;
@@ -204,7 +202,7 @@
 	return 0;
=20
 exit_free:
-	kfree(new_client);
+	kfree(data);
 exit:
 	return err;
 }
@@ -212,7 +210,7 @@
 static int lm75_detach_client(struct i2c_client *client)
 {
 	i2c_detach_client(client);
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
=20

--=20
Sergey Vlasov

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAbxyaW82GfkQfsqIRAhegAJ40Gv7qYAJqAqy/dTiZfVhHrnCHoQCgkpCm
rq+HgwXV5Dah4U89oBLjesM=
=O+9a
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
