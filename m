Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbVI2XIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbVI2XIr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbVI2XIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:08:47 -0400
Received: from smtp05.auna.com ([62.81.186.15]:3204 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S1751345AbVI2XIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:08:46 -0400
Date: Fri, 30 Sep 2005 01:09:31 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: khali@linux-fr.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: Re: 2.6.14-rc2-mm2
Message-ID: <20050930010931.5beb174e@werewolf.able.es>
In-Reply-To: <20050929143732.59d22569.akpm@osdl.org>
References: <20050929143732.59d22569.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 1.9.14cvs60 (GTK+ 2.8.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=Signature_Fri__30_Sep_2005_01_09_31_+0200_e7xEwli7ORu8lt.u;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.208.71] Login:jamagallon@able.es Fecha:Fri, 30 Sep 2005 01:08:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Fri__30_Sep_2005_01_09_31_+0200_e7xEwli7ORu8lt.u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Sep 2005 14:37:32 -0700, Andrew Morton <akpm@osdl.org> wrote:

>=20
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/=
2.6.14-rc2-mm2/
>=20
> (temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.14-rc2-=
mm2.gz)
>=20

I still need this to make my sensors work. I collected it from the list, he=
ard
people say it was not the proper solution, but without this it still doesn'=
t work.
No sensors.

Another issue. Is there any divisor value for fans hardcoded intially ?
I have 3 fans in my mobo, and 2 report 0 RPM until I put the divisor at 8
This fans are two for the xeons, and one for the box. Strangely, the fans t=
hat
are misread are the one for the board and one of the xeons ?

And more, my board has 2 more fan sensors, but the driver can only see 3. A=
ny idea ?
(Asus PC-DL Deluxe).

TIA

diff -urN linux-2.6.13-5bca.dist/drivers/hwmon/w83627hf.c linux-2.6.13-5bca=
/drivers/hwmon/w83627hf.c
--- linux-2.6.13-5bca.dist/drivers/hwmon/w83627hf.c     2005-09-06 13:50:03=
.000000000 +0200
+++ linux-2.6.13-5bca/drivers/hwmon/w83627hf.c  2005-09-07 19:54:08.0000000=
00 +0200
@@ -142,12 +142,16 @@
 #define WINB_BASE_REG 0x60
 /* Constants specified below */
=20
-/* Length of ISA address segment */
-#define WINB_EXTENT 8
+/* Alignment of ISA address */
+#define WINB_ALIGNMENT		~7
=20
-/* Where are the ISA address/data registers relative to the base address */
-#define W83781D_ADDR_REG_OFFSET 5
-#define W83781D_DATA_REG_OFFSET 6
+/* Offset & size of I/O region we are interested in */
+#define WINB_REGION_OFFSET	5
+#define WINB_REGION_SIZE	2
+
+/* Where are the ISA address/data registers relative to the region start */
+#define W83781D_ADDR_REG_OFFSET 0
+#define W83781D_DATA_REG_OFFSET 1
=20
 /* The W83781D registers */
 /* The W83782D registers for nr=3D7,8 are in bank 5 */
@@ -981,7 +985,7 @@
 	superio_select(W83627HF_LD_HWM);
 	val =3D (superio_inb(WINB_BASE_REG) << 8) |
 	       superio_inb(WINB_BASE_REG + 1);
-	*addr =3D val & ~(WINB_EXTENT - 1);
+	*addr =3D val & WINB_ALIGNMENT;
 	if (*addr =3D=3D 0 && force_addr =3D=3D 0) {
 		superio_exit();
 		return -ENODEV;
@@ -998,11 +1002,13 @@
 	struct w83627hf_data *data;
 	int err =3D 0;
 	const char *client_name =3D "";
+	unsigned short addr;
=20
 	if(force_addr)
-		address =3D force_addr & ~(WINB_EXTENT - 1);
+		address =3D force_addr & WINB_ALIGNMENT;
+	addr =3D address + WINB_REGION_OFFSET;
=20
-	if (!request_region(address, WINB_EXTENT, w83627hf_driver.name)) {
+	if (!request_region(addr, WINB_REGION_SIZE, w83627hf_driver.name)) {
 		err =3D -EBUSY;
 		goto ERROR0;
 	}
@@ -1049,7 +1055,7 @@
=20
 	new_client =3D &data->client;
 	i2c_set_clientdata(new_client, data);
-	new_client->addr =3D address;
+	new_client->addr =3D addr;
 	init_MUTEX(&data->lock);
 	new_client->adapter =3D adapter;
 	new_client->driver =3D &w83627hf_driver;
@@ -1148,7 +1154,7 @@
       ERROR2:
 	kfree(data);
       ERROR1:
-	release_region(address, WINB_EXTENT);
+	release_region(addr, WINB_REGION_SIZE);
       ERROR0:
 	return err;
 }
@@ -1163,7 +1169,7 @@
 	if ((err =3D i2c_detach_client(client)))
 		return err;
=20
-	release_region(client->addr, WINB_EXTENT);
+	release_region(client->addr, WINB_REGION_SIZE);
 	kfree(data);
=20
 	return 0;


--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.0 (2006 rc2) for i586
Linux 2.6.13-jam7 (gcc 4.0.1 (4.0.1-5mdk for Mandriva Linux release 2006.0))

--Signature_Fri__30_Sep_2005_01_09_31_+0200_e7xEwli7ORu8lt.u
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDPHQrRlIHNEGnKMMRAr5vAJ41X/78pNF3QY8OTuJv29asJ6QIEwCeJBUE
IZCDDglBLC5cTDHRW+kZ2eI=
=ZtXM
-----END PGP SIGNATURE-----

--Signature_Fri__30_Sep_2005_01_09_31_+0200_e7xEwli7ORu8lt.u--
