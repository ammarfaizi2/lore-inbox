Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267035AbSLRAdB>; Tue, 17 Dec 2002 19:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267041AbSLRAdB>; Tue, 17 Dec 2002 19:33:01 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:31174 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267035AbSLRAc4>; Tue, 17 Dec 2002 19:32:56 -0500
Date: Wed, 18 Dec 2002 01:40:39 +0100
From: Martin Waitz <tali@admingilde.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: device interface api
Message-ID: <20021218004039.GA1115@admingilde.org>
Mail-Followup-To: Patrick Mochel <mochel@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

please have a look at interface_add_data:


int interface_add_data(struct intf_data * data)
{
	struct device_interface * intf =3D intf_from_data(data);

	data->intf_num =3D data->intf->devnum++;
	data->kobj.subsys =3D &intf->subsys;
	kobject_register(&data->kobj);
	[...]


data->kobj.subsys is initialized here, but intf_from_data
is using this data->kobj.subsys to get intf, instead of data->intf.
do you want to remove data->intf?
either way, interface_add_data should change.

are interface users supposed to set data->intf or data->kobj.subsys?



another small glitch i noticed while diggin in the code:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.5/lib/kobject.c  Tue Dec 10 12:59:02 2002
+++ linux/lib/kobject.c       Tue Dec 17 13:15:19 2002
@@ -218,7 +218,7 @@ int subsystem_register(struct subsystem=20
                s->kobj.parent =3D &s->parent->kobj;
        pr_debug("subsystem %s: registering, parent: %s\n",
                 s->kobj.name,s->parent ? s->parent->kobj.name : "<none>");
-       return kobject_register(&s->kobj);
+       return kobject_add(&s->kobj);
 }
=20
 void subsystem_unregister(struct subsystem * s)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

subsystem_register first calls subsystem_init, which already
does kobject_init, so a full kobject_register is not needed
(and is in fact bad, as it again increases the refcounter for kobj.subsys)


--=20
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  [Tali on IRCnet]  [tali.home.pages.de] _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /
			    -
Wer bereit ist, grundlegende Freiheiten aufzugeben, um sich=20
kurzfristige Sicherheit zu verschaffen, der hat weder Freiheit=20
noch Sicherheit verdient.
			Benjamin Franklin  (1706 - 1790)

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE9/8QHj/Eaxd/oD7IRAm7QAJ95inNcMAZ+daQhi7fdkOdPflYXPgCdF7uq
YPJ70FMzkMnbIHaXmtWnL+w=
=nAt1
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
