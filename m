Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbTEHIMx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 04:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbTEHIMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 04:12:53 -0400
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:40461 "EHLO
	babylon.d2dc.net") by vger.kernel.org with ESMTP id S261204AbTEHIMv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 04:12:51 -0400
Date: Thu, 8 May 2003 04:25:24 -0400
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Another it87 patch.
Message-ID: <20030508082524.GA32348@babylon.d2dc.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, greg@kroah.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This is against my last.

While the old code most definitely did /something/ to the register for
setting the fan div, the 'what' is a more interesting question.

To be honest I could not figure out what it was trying to do, because
the way it was inserting values disagreed with not only the data sheet,
but how it parsed the very same register.

This corrects the issue, and allows one to properly control the divisor
on all 3 fans, including the (much more limited) 3rd fan.

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

<Upholder> Seen on the back of a T-Shirt: "I am a bomb technician.  If you =
see
           me running, try to keep up."

--- old/drivers/i2c/chips/it87.c	2003-05-08 04:16:39.000000000 -0400
+++ new/drivers/i2c/chips/it87.c	2003-05-08 04:12:19.000000000 -0400
@@ -159,7 +159,14 @@
 				205-(val)*5)
 #define ALARMS_FROM_REG(val) (val)
=20
-#define DIV_TO_REG(val) ((val)=3D=3D8?3:(val)=3D=3D4?2:(val)=3D=3D1?0:1)
+static int log2(int val)
+{
+    int answer =3D 0;
+    while ((val >>=3D 1))
+	answer++;
+    return answer;
+}
+#define DIV_TO_REG(val) log2(val)
 #define DIV_FROM_REG(val) (1 << (val))
=20
 /* Initial limits. Use the config file to set better limits. */
@@ -520,10 +527,25 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
-	int old =3D it87_read_value(client, IT87_REG_FAN_DIV);
-	data->fan_div[nr] =3D DIV_TO_REG(val);
-	old =3D (old & 0x0f) | (data->fan_div[1] << 6) | (data->fan_div[0] << 4);
-	it87_write_value(client, IT87_REG_FAN_DIV, old);
+	u8 old =3D it87_read_value(client, IT87_REG_FAN_DIV);
+
+	switch (nr) {
+	    case 0:
+	    case 1:
+		data->fan_div[nr] =3D DIV_TO_REG(val);
+		break;
+	    case 2:
+		if (val < 8)
+		    data->fan_div[nr] =3D 1;
+		else
+		    data->fan_div[nr] =3D 3;
+	}
+	val =3D old & 0x100;
+	val |=3D (data->fan_div[0] & 0x07);
+	val |=3D (data->fan_div[1] & 0x07) << 3;
+	if (data->fan_div[2] =3D=3D 3)
+	    val |=3D 0x1 << 6;
+	it87_write_value(client, IT87_REG_FAN_DIV, val);
 	return count;
 }
=20
@@ -957,7 +979,7 @@
 		i =3D it87_read_value(client, IT87_REG_FAN_DIV);
 		data->fan_div[0] =3D i & 0x07;
 		data->fan_div[1] =3D (i >> 3) & 0x07;
-		data->fan_div[2] =3D 1;
+		data->fan_div[2] =3D (i & 0x40) ? 3 : 1;
=20
 		data->alarms =3D
 			it87_read_value(client, IT87_REG_ALARM1) |

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD4DBQE+uhR0RFMAi+ZaeAERAniIAJ4pcSaPqf4GlgmwH96NlmHZYAJK5ACXfUzI
UzveKIFYMxpQKwEHoJi/Ng==
=mRlA
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
