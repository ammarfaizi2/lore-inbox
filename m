Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265771AbRFXWhm>; Sun, 24 Jun 2001 18:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265770AbRFXWhW>; Sun, 24 Jun 2001 18:37:22 -0400
Received: from mail-smtp.socket.net ([216.106.1.32]:55047 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S265769AbRFXWhU>; Sun, 24 Jun 2001 18:37:20 -0400
Date: Sun, 24 Jun 2001 17:37:11 -0500
From: "Gregory T. Norris" <haphazard@socket.net>
To: rio500-devel <rio500-devel@lists.sourceforge.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] rio500 devfs support
Message-ID: <20010624173711.A1764@glitch.snoozer.net>
Mail-Followup-To: rio500-devel <rio500-devel@lists.sourceforge.net>,
	linux-kernel <linux-kernel@vger.redhat.com>
In-Reply-To: <20010619175224.A1137@glitch.snoozer.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
In-Reply-To: <20010619175224.A1137@glitch.snoozer.net>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux glitch 2.4.5 #1 Sun Jun 24 16:53:30 CDT 2001 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's an updated version of the patch - the only real difference is
that rio500.c will printk an error message if devfs_register() fails.=20
I left that out originally because devfs logs the error, but it's
probably a good idea to indicate which driver made the request.

Cheers!

On Tue, Jun 19, 2001 at 05:52:24PM -0500, Gregory T. Norris wrote:
> The attached diff adds devfs support to the rio500 driver, so that
> /dev/usb/rio500 gets created automagically.  It was generated against
> 2.4.5, but probably applies fine against any recent kernel.  Comments
> are welcome (but be gentle, this is my first attempt at a kernel
> patch :-).
>=20
> Cheers!

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rio500-devfs-02.diff"
Content-Transfer-Encoding: quoted-printable

diff -urN linux-2.4.5.orig/drivers/usb/rio500.c linux-2.4.5/drivers/usb/rio=
500.c
--- linux-2.4.5.orig/drivers/usb/rio500.c	Sun Jun 24 16:29:35 2001
+++ linux-2.4.5/drivers/usb/rio500.c	Sun Jun 24 16:45:08 2001
@@ -38,6 +38,7 @@
 #include <linux/spinlock.h>
 #include <linux/usb.h>
 #include <linux/smp_lock.h>
+#include <linux/devfs_fs_kernel.h>
=20
 #include "rio500_usb.h"
=20
@@ -70,6 +71,7 @@
 };
=20
 static struct rio_usb_data rio_instance;
+static devfs_handle_t rio500_devfs_handle;
=20
 static int open_rio(struct inode *inode, struct file *file)
 {
@@ -492,6 +494,14 @@
 	if (usb_register(&rio_driver) < 0)
 		return -1;
=20
+	rio500_devfs_handle =3D devfs_register(NULL, "usb/rio500",
+					DEVFS_FL_DEFAULT,
+					USB_MAJOR, RIO_MINOR,
+					S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP,
+					&usb_rio_fops, NULL);
+	if (rio500_devfs_handle =3D=3D NULL)
+		printk(KERN_WARNING __FILE__ ": unable to register /dev/usb/rio500 with =
devfs\n");
+
 	info(DRIVER_VERSION " " DRIVER_AUTHOR);
 	info(DRIVER_DESC);
=20
@@ -506,6 +516,8 @@
 	rio->present =3D 0;
 	usb_deregister(&rio_driver);
=20
+	if (rio500_devfs_handle !=3D NULL)
+		devfs_unregister(rio500_devfs_handle);
=20
 }
=20

--0F1p//8PRICkK4MW--

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7NmuXgrEMyr8Cx2YRAgxbAJ4giItw/ifI5A5TWyKpTp0QE5e/yQCgkYz9
pUzvkYbLKWZfXcm6jWUG348=
=mp18
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
