Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbSKZVPf>; Tue, 26 Nov 2002 16:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261292AbSKZVPf>; Tue, 26 Nov 2002 16:15:35 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:53407 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261238AbSKZVPc>; Tue, 26 Nov 2002 16:15:32 -0500
Date: Tue, 26 Nov 2002 22:22:39 +0100
From: Martin Waitz <tali@admingilde.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] allow to register interfaces after devices
Message-ID: <20021126212239.GA1118@admingilde.org>
Mail-Followup-To: Patrick Mochel <mochel@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)


i had a problem some of my code that registered a interface for cpu_devclass
was being run after cpu devices got added to the class.

current code only adds those devices to the interface that are
added after registering the interface.
this patch changes it by walking all devices that are already registered
to intf->devclass.


--- linux-2.5/drivers/base/intf.c       2002-11-26 21:41:00.000000000 +0100
+++ linux/drivers/base/intf.c   2002-11-26 21:41:00.000000000 +0100
@@ -35,17 +35,36 @@
 int interface_register(struct device_interface * intf)
 {
        struct device_class * cls =3D get_devclass(intf->devclass);
-       int error =3D 0;
+       struct list_head * drv_node;
+
+       if (!cls) {
+               return -EINVAL;
+       }
=20
-       if (cls) {
-               pr_debug("register interface '%s' with class '%s'\n",
-                        intf->name,cls->name);
-               strncpy(intf->kobj.name,intf->name,KOBJ_NAME_LEN);
-               intf->kobj.subsys =3D &cls->subsys;
-               kobject_register(&intf->kobj);
-       } else
-               error =3D -EINVAL;
-       return error;
+       pr_debug("register interface '%s' with class '%s'\n",
+                intf->name,cls->name);
+       strncpy(intf->kobj.name,intf->name,KOBJ_NAME_LEN);
+       intf->kobj.subsys =3D &cls->subsys;
+       kobject_register(&intf->kobj);
+
+       /* walk all devices already registered to intf->devclass */
+       list_for_each(drv_node, &cls->drivers) {
+               struct device_driver * driver =3D
+                       container_of(drv_node,struct device_driver,class_li=
st);
+               struct list_head * dev_node;
+
+               list_for_each(dev_node, &driver->devices) {
+                       int error;
+                       struct device * dev =3D
+                               container_of(dev_node,struct device,driver_=
list);
+                       error =3D intf->add_device(dev);
+                       if (error)
+                               pr_debug("%s:%s: adding '%s' failed: %d\n",
+                                        cls->name,intf->name,dev->name,err=
or);
+               }
+       }
+
+       return 0;
 }
=20
 void interface_unregister(struct device_interface * intf)


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

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE94+Yfj/Eaxd/oD7IRAtMyAJ98SpE7oyTRjyndNmmq9GuiUTV+uQCfSgS6
bZu8U12V7LallaWQASopWa8=
=RBLp
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
