Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264858AbUGGClP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264858AbUGGClP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 22:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264860AbUGGClP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 22:41:15 -0400
Received: from 221-169-69-23.adsl.static.seed.net.tw ([221.169.69.23]:26511
	"EHLO cola.voip.idv.tw") by vger.kernel.org with ESMTP
	id S264858AbUGGClM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 22:41:12 -0400
Subject: Re: 2.6.7+BK bad: scheduling while atomic! (ALSA?)
From: Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.44.0407070206220.24637-100000@math.ut.ee>
References: <Pine.GSO.4.44.0407070206220.24637-100000@math.ut.ee>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SHEVL+k1T7tbSnqnJKSQ"
Message-Id: <1089168049.3892.19.camel@libra>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 07 Jul 2004 10:40:50 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SHEVL+k1T7tbSnqnJKSQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> Alsamixergui aslo still segfaults (with double
> segfault as it actually did before):
>=20
> bad: scheduling while atomic!
>  [<c02989a3>] schedule+0x463/0x470
>  [<c014a984>] vfs_write+0xe4/0x120
>  [<c014aa58>] sys_write+0x38/0x60
>  [<c0103eee>] work_resched+0x5/0x16

Hi,

I got similar output here when I try to run xmms with alsa plugin.
Solved with modified sound/core/control.c. Maybe you can try this tiny
patch. :)

--=20
Best Regards,
Wen-chien Jesse Sung

--- linux/sound/core/control.c.orig	2004-07-06 18:38:55.000000000 +0800
+++ linux/sound/core/control.c	2004-07-06 18:39:30.000000000 +0800
@@ -1114,7 +1114,7 @@ static ssize_t snd_ctl_read(struct file=20
 			wait_queue_t wait;
 			if ((file->f_flags & O_NONBLOCK) !=3D 0 || result > 0) {
 				err =3D -EAGAIN;
-				goto out;
+				goto __end;
 			}
 			init_waitqueue_entry(&wait, current);
 			add_wait_queue(&ctl->change_sleep, &wait);
@@ -1135,7 +1135,7 @@ static ssize_t snd_ctl_read(struct file=20
 		kfree(kev);
 		if (copy_to_user(buffer, &ev, sizeof(snd_ctl_event_t))) {
 			err =3D -EFAULT;
-			goto __end;
+			goto out;
 		}
 		spin_lock_irq(&ctl->read_lock);
 		buffer +=3D sizeof(snd_ctl_event_t);


--=-SHEVL+k1T7tbSnqnJKSQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: 	=?UTF-8?Q?=E9=80=99=E6=98=AF=E6=95=B8=E4=BD=8D=E5=8A=A0=E7=B0=BD?=
	=?UTF-8?Q?=E7=9A=84=E9=83=B5?= =?UTF-8?Q?=E4=BB=B6?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA62KxlZ/JOHsLIwgRAvCaAJ916/CsW6cYuCzn19xIDIvZxl40YwCeKLcI
lssiFjvXZHVRUBtuyz/Av6g=
=qDrF
-----END PGP SIGNATURE-----

--=-SHEVL+k1T7tbSnqnJKSQ--

