Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbVACUwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVACUwj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 15:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbVACUwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 15:52:39 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:51334 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261773AbVACUwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 15:52:35 -0500
Date: Mon, 3 Jan 2005 13:52:31 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Justin Thiessen <jthiessen@penguincomputing.com>
Cc: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: Ticket #1851 - PATCH (take 2) for adm1026.c, kernel 2.6.10-bk6
Message-ID: <20050103205231.GK9923@schnapps.adilger.int>
Mail-Followup-To: Justin Thiessen <jthiessen@penguincomputing.com>,
	LM Sensors <sensors@stimpy.netroedge.com>,
	LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
References: <41D5D075.4000200@paradyne.com> <20050101001205.6b2a44d3.khali@linux-fr.org> <20050103194355.GA11979@penguincomputing.com> <20050103201056.3c55e330.khali@linux-fr.org> <20050103213707.GA12765@penguincomputing.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qoynMflHD4PlumZh"
Content-Disposition: inline
In-Reply-To: <20050103213707.GA12765@penguincomputing.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qoynMflHD4PlumZh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 03, 2005  13:37 -0800, Justin Thiessen wrote:
> The amount of duplicated code is only a few lines, and I think the result=
 is
> clearer if it is not extracted into a separate function.  See the followi=
ng
> patch.

> +	value =3D adm1026_read_value(client, ADM1026_REG_FAN_DIV_0_3)
> +		| (adm1026_read_value(client, ADM1026_REG_FAN_DIV_4_7)
> +		<< 8);

The formatting of this makes it hard to follow the logic.  The "<< 8"
operation isn't aligned with the nesting parenthesis and at first I
thought there was an ambiguous order of operation "|" vs "<<".

How about the following:

--- linux-2.6.10/drivers/i2c/chips/adm1026.c.orig	2005-01-02 15:21:58.00000=
0000 -0800
+++ linux-2.6.10/drivers/i2c/chips/adm1026.c	2005-01-02 18:27:40.695689832 =
-0800
@@ -452,6 +452,14 @@ void adm1026_init_client(struct i2c_clie
 		client->id, value);
 	data->config1 =3D value;
 	adm1026_write_value(client, ADM1026_REG_CONFIG1, value);
+
+	/* initialize fan_div[] to hardware defaults */
+	value =3D adm1026_read_value(client, ADM1026_REG_FAN_DIV_0_3) |
+		(adm1026_read_value(client, ADM1026_REG_FAN_DIV_4_7) << 8);
+	for (i =3D 0;i <=3D 7;++i) {
+		data->fan_div[i] =3D DIV_FROM_REG(value & 0x03);
+		value >>=3D 2;
+	}
 }
=20
 void adm1026_print_gpio(struct i2c_client *client)



Also, on a completely "I don't know what the hell I'm talking about" point,
it seems odd that for values named "0_3" and "4_7" you would upshift the
"4_7" value 8 bits instead of 4, but it could be just a bad choice of
variable names.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--qoynMflHD4PlumZh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFB2bCPpIg59Q01vtYRAhVRAKDJ+ERng0/QNgWpaka0RnYv/zn4ywCgq1sj
zz5qUBEyS2peP48/3XG8yww=
=FHxr
-----END PGP SIGNATURE-----

--qoynMflHD4PlumZh--
