Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267284AbTAPVnn>; Thu, 16 Jan 2003 16:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267289AbTAPVnn>; Thu, 16 Jan 2003 16:43:43 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:28581 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267284AbTAPVnl>; Thu, 16 Jan 2003 16:43:41 -0500
Date: Thu, 16 Jan 2003 22:52:18 +0100
From: Martin Waitz <tali@admingilde.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: Dominik Brodowski <linux@brodo.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] work around deadlock in add_intf
Message-ID: <20030116215218.GB1770@admingilde.org>
Mail-Followup-To: Patrick Mochel <mochel@osdl.org>,
	Dominik Brodowski <linux@brodo.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20030113205346.GB10365@brodo.de> <Pine.LNX.4.33.0301131425450.1136-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0301131425450.1136-100000@localhost.localdomain>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)


the note for cpufreq sysfs support regarding locking in add_intf
has bitten me, too

i don't have a really good idea how to change the locking
so that it just works, so i wrote a workaround

the following patch allows to add interfaces again for me,
it just deferres the actual device additions:


--- src/linux-2.5/drivers/base/intf.c   Mon Jan 13 09:49:02 2003
+++ src/linux-rc/drivers/base/intf.c    Thu Jan 16 11:13:19 2003
@@ -132,6 +132,22 @@
=20
=20
 /**
+ *     delayed_add - version of add() called via schedule_work
+ *     @_data: pointer to arguments
+ */
+static void delayed_add(void *_data)
+{
+       struct {
+               struct device_interface *intf;
+               struct device *dev;
+               struct work_struct work;
+       } *data =3D _data;
+
+       add(data->intf, data->dev);
+       kfree(data);
+}
+
+/**
  *     add_intf - add class's devices to interface.
  *     @intf:  interface.
  *
@@ -142,12 +158,24 @@
  */
 static void add_intf(struct device_interface * intf)
 {
+       struct {
+               struct device_interface *intf;
+               struct device *dev;
+               struct work_struct work;
+       } *data;
        struct device_class * cls =3D intf->devclass;
        struct list_head * entry;
=20
        down_write(&cls->subsys.rwsem);
-       list_for_each(entry,&cls->devices.list)
-               add(intf,to_dev(entry));
+       list_for_each(entry,&cls->devices.list) {
+               /* add will lock subsys.rwsem via interface_add_data, */
+               /* do it after lock is released */
+               data =3D kmalloc(sizeof(*data), GFP_KERNEL);
+               INIT_WORK(&data->work, delayed_add, data);
+               data->intf =3D intf;
+               data->dev =3D to_dev(entry);
+               schedule_work(&data->work);
+       }
        up_write(&cls->subsys.rwsem);
 }
=20


--=20
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  [Tali on IRCnet]  [tali.home.pages.de] _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /
			    -
Wer bereit ist, grundlegende Freiheiten aufzugeben, um sich=20
kurzfristige Sicherheit zu verschaffen, der hat weder Freiheit=20
noch Sicherheit verdient.            Benjamin Franklin (1706 - 1790)

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+JymRj/Eaxd/oD7IRAhKWAJ9qCvGMi8RfL3274djvep/trDe5ygCdEQoD
DOKcVofNKlGi09JW4yBi/OU=
=Ejfe
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
