Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbTEHOiL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 10:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbTEHOiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 10:38:11 -0400
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:19720 "EHLO
	babylon.d2dc.net") by vger.kernel.org with ESMTP id S261678AbTEHOiG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 10:38:06 -0400
Date: Thu, 8 May 2003 10:50:39 -0400
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: Another it87 patch.
Message-ID: <20030508145039.GA2052@babylon.d2dc.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, greg@kroah.com
References: <20030508082524.GA32348@babylon.d2dc.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20030508082524.GA32348@babylon.d2dc.net>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2003 at 04:25:24AM -0400, Zephaniah E. Hull wrote:
> This is against my last.

And this is against that one.

Ok, after writing up something in the way of a perl script to make some
sense of the data for voltages, and finding that there is no sense to
make, I took a longer look at things.

The it87 driver in 2.5.x is doing some, down right /odd/ math on the
numbers for the in_input* readings, and the 2.4.x driver is doing
something quite different.

And while it might be possible to get sane numbers out of the 2.5.x
driver, people /expect/ to get the numbers that they were getting from
2.4.x.

So this patch puts things back to the simpler calculations done by the
2.4.x lm-sensors drivers, and my script confirms that the numbers come
out right.

(If anyone would like the script, let me know and I'll put it up
somewhere, however it is a messy kludge at the moment.)

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

"Sir," barked one of those useless aristocratic generals to William
Howard Russell, the great Times war correspondent, "I do not like what
you write." "Then, sir," retorted Russell, "I suggest you do not do what
I write about."


--- linux-2.5.65/drivers/i2c/chips/it87.c	2003-05-08 10:38:23.000000000 -04=
00
+++ linux-2.5.69-mm1/drivers/i2c/chips/it87.c	2003-05-08 09:59:49.000000000=
 -0400
@@ -99,46 +99,8 @@
=20
 #define IT87_REG_CHIPID        0x58
=20
-static inline u8 IN_TO_REG(long val, int inNum)
-{
-	/* to avoid floating point, we multiply everything by 100.
-	 val is guaranteed to be positive, so we can achieve the effect of=20
-	 rounding by (...*10+5)/10.  Note that the *10 is hidden in the=20
-	 /250 (which should really be /2500).
-	 At the end, we need to /100 because we *100 everything and we need
-	 to /10 because of the rounding thing, so we /1000.   */
-	if (inNum <=3D 1)
-		return (u8)
-		    SENSORS_LIMIT(((val * 210240 - 13300) / 250 + 5) / 1000,=20
-				  0, 255);
-	else if (inNum =3D=3D 2)
-		return (u8)
-		    SENSORS_LIMIT(((val * 157370 - 13300) / 250 + 5) / 1000,=20
-				  0, 255);
-	else if (inNum =3D=3D 3)
-		return (u8)
-		    SENSORS_LIMIT(((val * 101080 - 13300) / 250 + 5) / 1000,=20
-				  0, 255);
-	else
-		return (u8) SENSORS_LIMIT(((val * 41714 - 13300) / 250 + 5)
-					  / 1000, 0, 255);
-}
-
-static inline long IN_FROM_REG(u8 val, int inNum)
-{
-	/* to avoid floating point, we multiply everything by 100.
-	 val is guaranteed to be positive, so we can achieve the effect of
-	 rounding by adding 0.5.  Or, to avoid fp math, we do (...*10+5)/10.
-	 We need to scale with *100 anyway, so no need to /100 at the end. */
-	if (inNum <=3D 1)
-		return (long) (((250000 * val + 13300) / 210240 * 10 + 5) /10);
-	else if (inNum =3D=3D 2)
-		return (long) (((250000 * val + 13300) / 157370 * 10 + 5) /10);
-	else if (inNum =3D=3D 3)
-		return (long) (((250000 * val + 13300) / 101080 * 10 + 5) /10);
-	else
-		return (long) (((250000 * val + 13300) / 41714 * 10 + 5) /10);
-}
+#define IN_TO_REG(val)  (SENSORS_LIMIT((((val) * 10 + 8)/16),0,255))
+#define IN_FROM_REG(val) (((val) *  16) / 10)
=20
 static inline u8 FAN_TO_REG(long rpm, int div)
 {
@@ -279,7 +241,7 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	it87_update_client(client);
-	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in[nr], nr)*10 );
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in[nr])*10 );
 }
=20
 static ssize_t show_in_min(struct device *dev, char *buf, int nr)
@@ -287,7 +249,7 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	it87_update_client(client);
-	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in_min[nr], nr)*10 );
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_min[nr])*10 );
 }
=20
 static ssize_t show_in_max(struct device *dev, char *buf, int nr)
@@ -295,7 +257,7 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	it87_update_client(client);
-	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in_max[nr], nr)*10 );
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_max[nr])*10 );
 }
=20
 static ssize_t set_in_min(struct device *dev, const char *buf,=20
@@ -304,7 +266,7 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10)/10;
-	data->in_min[nr] =3D IN_TO_REG(val,nr);
+	data->in_min[nr] =3D IN_TO_REG(val);
 	it87_write_value(client, IT87_REG_VIN_MIN(nr),=20
 			data->in_min[nr]);
 	return count;
@@ -315,7 +277,7 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10)/10;
-	data->in_max[nr] =3D IN_TO_REG(val,nr);
+	data->in_max[nr] =3D IN_TO_REG(val);
 	it87_write_value(client, IT87_REG_VIN_MAX(nr),=20
 			data->in_max[nr]);
 	return count;
@@ -851,37 +813,37 @@
 	   This sets fan-divs to 2, among others */
 	it87_write_value(client, IT87_REG_CONFIG, 0x80);
 	it87_write_value(client, IT87_REG_VIN_MIN(0),
-			 IN_TO_REG(IT87_INIT_IN_MIN_0, 0));
+			 IN_TO_REG(IT87_INIT_IN_MIN_0));
 	it87_write_value(client, IT87_REG_VIN_MAX(0),
-			 IN_TO_REG(IT87_INIT_IN_MAX_0, 0));
+			 IN_TO_REG(IT87_INIT_IN_MAX_0));
 	it87_write_value(client, IT87_REG_VIN_MIN(1),
-			 IN_TO_REG(IT87_INIT_IN_MIN_1, 1));
+			 IN_TO_REG(IT87_INIT_IN_MIN_1));
 	it87_write_value(client, IT87_REG_VIN_MAX(1),
-			 IN_TO_REG(IT87_INIT_IN_MAX_1, 1));
+			 IN_TO_REG(IT87_INIT_IN_MAX_1));
 	it87_write_value(client, IT87_REG_VIN_MIN(2),
-			 IN_TO_REG(IT87_INIT_IN_MIN_2, 2));
+			 IN_TO_REG(IT87_INIT_IN_MIN_2));
 	it87_write_value(client, IT87_REG_VIN_MAX(2),
-			 IN_TO_REG(IT87_INIT_IN_MAX_2, 2));
+			 IN_TO_REG(IT87_INIT_IN_MAX_2));
 	it87_write_value(client, IT87_REG_VIN_MIN(3),
-			 IN_TO_REG(IT87_INIT_IN_MIN_3, 3));
+			 IN_TO_REG(IT87_INIT_IN_MIN_3));
 	it87_write_value(client, IT87_REG_VIN_MAX(3),
-			 IN_TO_REG(IT87_INIT_IN_MAX_3, 3));
+			 IN_TO_REG(IT87_INIT_IN_MAX_3));
 	it87_write_value(client, IT87_REG_VIN_MIN(4),
-			 IN_TO_REG(IT87_INIT_IN_MIN_4, 4));
+			 IN_TO_REG(IT87_INIT_IN_MIN_4));
 	it87_write_value(client, IT87_REG_VIN_MAX(4),
-			 IN_TO_REG(IT87_INIT_IN_MAX_4, 4));
+			 IN_TO_REG(IT87_INIT_IN_MAX_4));
 	it87_write_value(client, IT87_REG_VIN_MIN(5),
-			 IN_TO_REG(IT87_INIT_IN_MIN_5, 5));
+			 IN_TO_REG(IT87_INIT_IN_MIN_5));
 	it87_write_value(client, IT87_REG_VIN_MAX(5),
-			 IN_TO_REG(IT87_INIT_IN_MAX_5, 5));
+			 IN_TO_REG(IT87_INIT_IN_MAX_5));
 	it87_write_value(client, IT87_REG_VIN_MIN(6),
-			 IN_TO_REG(IT87_INIT_IN_MIN_6, 6));
+			 IN_TO_REG(IT87_INIT_IN_MIN_6));
 	it87_write_value(client, IT87_REG_VIN_MAX(6),
-			 IN_TO_REG(IT87_INIT_IN_MAX_6, 6));
+			 IN_TO_REG(IT87_INIT_IN_MAX_6));
 	it87_write_value(client, IT87_REG_VIN_MIN(7),
-			 IN_TO_REG(IT87_INIT_IN_MIN_7, 7));
+			 IN_TO_REG(IT87_INIT_IN_MIN_7));
 	it87_write_value(client, IT87_REG_VIN_MAX(7),
-			 IN_TO_REG(IT87_INIT_IN_MAX_7, 7));
+			 IN_TO_REG(IT87_INIT_IN_MAX_7));
 	/* Note: Battery voltage does not have limit registers */
 	it87_write_value(client, IT87_REG_FAN_MIN(1),
 			 FAN_TO_REG(IT87_INIT_FAN_MIN_1, 2));

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+um6/RFMAi+ZaeAERArMUAKCPm3rHCDrNM5vwZH0d508Y41TWRgCg7sDD
+KJ6eKkp9ZcHpp0YGSzv6e4=
=xpyP
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
