Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261562AbRFMKgC>; Wed, 13 Jun 2001 06:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262835AbRFMKfw>; Wed, 13 Jun 2001 06:35:52 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:1286 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S261562AbRFMKfg>;
	Wed, 13 Jun 2001 06:35:36 -0400
Date: Wed, 13 Jun 2001 14:35:33 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] bus mouse drivers cleanup
Message-ID: <20010613143533.A17092@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
User-Agent: Mutt/1.0.1i
X-Uptime: 12:31pm  up 13 days, 20:12,  1 user,  load average: 0.06, 0.03, 0.03
From: <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi all,

attached are patches to add (missing) error checking and proper error code =
returning
in case of request_region(), request_irq and misc_register() fauilures.

Drivers affected: atixlmouse.c, logibusmouse.c, msbusmouse.c, pc110pad.c.

Best regards.

P.S. Also check_region() calls removed from logibusmouse.c and msbusmouse.c

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-atixlmouse
Content-Transfer-Encoding: quoted-printable

diff -u -X /usr/dontdiff /linux.vanilla/drivers/char/atixlmouse.c /linux/dr=
ivers/char/atixlmouse.c
--- /linux.vanilla/drivers/char/atixlmouse.c	Tue Jun 12 10:51:22 2001
+++ /linux/drivers/char/atixlmouse.c	Tue Jun 12 11:32:59 2001
@@ -91,8 +91,9 @@
=20
 static int open_mouse(struct inode * inode, struct file * file)
 {
-	if (request_irq(ATIXL_MOUSE_IRQ, mouse_interrupt, 0, "ATIXL mouse", NULL))
-		return -EBUSY;
+	int retval;
+	if ((retval =3D request_irq(ATIXL_MOUSE_IRQ, mouse_interrupt, SA_INTERRUP=
T | SA_SAMPLE_RANDOM, "ATIXL mouse", NULL)))
+		return retval;
 	ATIXL_MSE_INT_ON(); /* Interrupts are really enabled here */
 	return 0;
 }
@@ -112,7 +113,7 @@
 	 */
=20
 	if (!request_region(ATIXL_MSE_DATA_PORT, 3, "atixlmouse"))
-		return -EIO;
+		return -EBUSY;
=20
 	a =3D inb( ATIXL_MSE_SIGNATURE_PORT );	/* Get signature */
 	b =3D inb( ATIXL_MSE_SIGNATURE_PORT );

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-logibusmouse
Content-Transfer-Encoding: quoted-printable

diff -u -X /usr/dontdiff /linux.vanilla/drivers/char/logibusmouse.c /linux/=
drivers/char/logibusmouse.c
--- /linux.vanilla/drivers/char/logibusmouse.c	Tue Jun 12 10:51:30 2001
+++ /linux/drivers/char/logibusmouse.c	Tue Jun 12 11:35:28 2001
@@ -116,8 +116,9 @@
=20
 static int open_mouse(struct inode * inode, struct file * file)
 {
-	if (request_irq(mouse_irq, mouse_interrupt, 0, "busmouse", NULL))
-		return -EBUSY;
+	int retval;
+	if ((retval =3D request_irq(mouse_irq, mouse_interrupt, SA_INTERRUPT | SA=
_SAMPLE_RANDOM, "busmouse", NULL)))
+		return retval;
 	MSE_INT_ON();
 	return 0;
 }
@@ -128,24 +129,25 @@
=20
 static int __init logi_busmouse_init(void)
 {
-	if (check_region(LOGIBM_BASE, LOGIBM_EXTENT))
-		return -EIO;
+	if (!request_region(LOGIBM_BASE, LOGIBM_EXTENT, "busmouse"))
+		return -EBUSY;
=20
 	outb(MSE_CONFIG_BYTE, MSE_CONFIG_PORT);
 	outb(MSE_SIGNATURE_BYTE, MSE_SIGNATURE_PORT);
 	udelay(100L);	/* wait for reply from mouse */
-	if (inb(MSE_SIGNATURE_PORT) !=3D MSE_SIGNATURE_BYTE)
+	if (inb(MSE_SIGNATURE_PORT) !=3D MSE_SIGNATURE_BYTE) {
+		release_region(LOGIBM_BASE, LOGIBM_EXTENT);
 		return -EIO;
+	}
=20
 	outb(MSE_DEFAULT_MODE, MSE_CONFIG_PORT);
 	MSE_INT_OFF();
-=09
-	request_region(LOGIBM_BASE, LOGIBM_EXTENT, "busmouse");
=20
 	msedev =3D register_busmouse(&busmouse);
-	if (msedev < 0)
+	if (msedev < 0) {
 		printk(KERN_WARNING "Unable to register busmouse driver.\n");
-	else
+		release_region(LOGIBM_BASE, LOGIBM_EXTENT);
+	} else
 		printk(KERN_INFO "Logitech busmouse installed.\n");
 	return msedev < 0 ? msedev : 0;
 }

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-msbusmouse
Content-Transfer-Encoding: quoted-printable

diff -u -X /usr/dontdiff /linux.vanilla/drivers/char/msbusmouse.c /linux/dr=
ivers/char/msbusmouse.c
--- /linux.vanilla/drivers/char/msbusmouse.c	Tue Jun 12 10:51:22 2001
+++ /linux/drivers/char/msbusmouse.c	Tue Jun 12 11:38:18 2001
@@ -113,8 +113,9 @@
=20
 static int open_mouse(struct inode * inode, struct file * file)
 {
-	if (request_irq(mouse_irq, ms_mouse_interrupt, 0, "MS Busmouse", NULL))
-		return -EBUSY;
+	int retval;
+	if ((retval =3D request_irq(mouse_irq, ms_mouse_interrupt, SA_INTERRUPT |=
 SA_SAMPLE_RANDOM, "MS Busmouse", NULL)))
+		return retval;
=20
 	outb(MS_MSE_START, MS_MSE_CONTROL_PORT);
 	MS_MSE_INT_ON();=09
@@ -130,8 +131,8 @@
 	int present =3D 0;
 	int mse_byte, i;
=20
-	if (check_region(MS_MSE_CONTROL_PORT, 0x04))
-		return -ENODEV;
+	if (!request_region(MS_MSE_CONTROL_PORT, 0x04, "MS Busmouse"));
+		return -EBUSY;
=20
 	if (inb_p(MS_MSE_SIGNATURE_PORT) =3D=3D 0xde) {
=20
@@ -147,14 +148,17 @@
 				present =3D 0;
 		}
 	}
-	if (present =3D=3D 0)
+	if (present =3D=3D 0) {
+		release_region(MS_MSE_CONTROL_PORT, 0x04);
 		return -EIO;
+	}
 	MS_MSE_INT_OFF();
-	request_region(MS_MSE_CONTROL_PORT, 0x04, "MS Busmouse");
+
 	msedev =3D register_busmouse(&msbusmouse);
-	if (msedev < 0)
+	if (msedev < 0) {
 		printk(KERN_WARNING "Unable to register msbusmouse driver.\n");
-	else
+		release_region(MS_MSE_CONTROL_PORT, 0x04);
+	} else
 		printk(KERN_INFO "Microsoft BusMouse detected and installed.\n");
 	return msedev < 0 ? msedev : 0;
 }

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-pc110pad
Content-Transfer-Encoding: quoted-printable

diff -u -X /usr/dontdiff /linux.vanilla/drivers/char/pc110pad.c /linux/driv=
ers/char/pc110pad.c
--- /linux.vanilla/drivers/char/pc110pad.c	Tue Jun 12 10:51:26 2001
+++ /linux/drivers/char/pc110pad.c	Tue Jun 12 12:01:44 2001
@@ -802,23 +802,36 @@
=20
 static int __init pc110pad_init_driver(void)
 {
+	int retval =3D -EBUSY;
+
 	init_MUTEX(&reader_lock);
 	current_params =3D default_params;
=20
-	if (request_irq(current_params.irq, pad_irq, 0, "pc110pad", 0)) {
-		printk(KERN_ERR "pc110pad: Unable to get IRQ.\n");
-		return -EBUSY;
-	}
 	if (!request_region(current_params.io, 4, "pc110pad"))	{
 		printk(KERN_ERR "pc110pad: I/O area in use.\n");
-		free_irq(current_params.irq,0);
-		return -EBUSY;
+		goto err_out;
+	}
+	if ((retval =3D request_irq(current_params.irq, pad_irq, SA_INTERRUPT | S=
A_SAMPLE_RANDOM, "pc110pad", 0))) {
+		printk(KERN_ERR "pc110pad: Unable to get IRQ.\n");
+		goto err_out_release_region;
 	}
 	init_waitqueue_head(&queue);
+
+	if ((retval =3D misc_register(&pc110_pad))) {
+		printk(KERN_ERR "pc110pad: Unable to register driver.\n");
+		goto err_out_free_irq;
+	}
+
 	printk(banner, current_params.io, current_params.irq);
-	misc_register(&pc110_pad);
 	outb(0x30, current_params.io+2);	/* switch off digitiser */
 	return 0;
+
+err_out_free_irq:
+	free_irq(current_params.irq, 0);
+err_out_release_region:
+	release_region(current_params.io, 4);
+err_out:
+	return retval;
 }
=20
 /*

--VbJkn9YxBvnuCH5J--

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7J0H1Bm4rlNOo3YgRArv1AJwNtuUklnnuG35FTYbuffkY7lCtggCghciV
GcunERz7BxXuiwXuHqvwzNA=
=3mqk
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
