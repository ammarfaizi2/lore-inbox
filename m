Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVE3V1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVE3V1y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 17:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVE3V1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 17:27:53 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:52149 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S261765AbVE3V0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 17:26:48 -0400
Date: Mon, 30 May 2005 23:26:41 +0200
From: Harald Welte <laforge@gnumonks.org>
To: linux-usb-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] oops while completing async USB via usbdevio
Message-ID: <20050530212641.GE25536@sunbeam.de.gnumonks.org>
References: <20050530194443.GA22760@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8nsIa27JVQLqB7/C"
Content-Disposition: inline
In-Reply-To: <20050530194443.GA22760@sunbeam.de.gnumonks.org>
User-Agent: mutt-ng 1.5.8-r168i (Debian)
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "ganesha", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Mon, May 30, 2005 at 09:44:44PM +0200, Harald Welte
	wrote: > I think there is currently no protection/locking/refcounting
	going on. > > If a process issues an URB from userspace and starts to
	terminate before > the URB comes back, we run into the issue described
	above. This is > because the urb saves a pointer to "current" when it
	is posted to the > device, but there's no guarantee that this pointer
	is still valid > afterwards. > > I'm not familiar with the scheduler
	code to decide what fix > is the way to go. Is it sufficient to do
	{get,put}_task_struct() from > the usb code? [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 30, 2005 at 09:44:44PM +0200, Harald Welte wrote:
> I think there is currently no protection/locking/refcounting going on.
>=20
> If a process issues an URB from userspace and starts to terminate before
> the URB comes back, we run into the issue described above.  This is
> because the urb saves a pointer to "current" when it is posted to the
> device, but there's no guarantee that this pointer is still valid
> afterwards. =20
>=20
> I'm not familiar with the scheduler code to decide what fix
> is the way to go.  Is it sufficient to do {get,put}_task_struct() from
> the usb code?

mh. it appears like it's sighand which disappears, not the task itself.

I've tried the following patch:

Index: linux-2.6.12-rc5/kernel/signal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.12-rc5.orig/kernel/signal.c	2005-05-30 18:23:55.000000000 +02=
00
+++ linux-2.6.12-rc5/kernel/signal.c	2005-05-30 23:20:49.000000000 +0200
@@ -1258,6 +1258,15 @@
 	if (!valid_signal(sig))
 		return -EINVAL;
=20
+	if (!p) {
+		printk("%s p =3D=3D NULL\n");
+		return -EINVAL;
+	}
+	if (!p->sighand) {
+		printk("%s:%u p->sighand =3D=3D NULL\n", __FUNCTION__, p->pid);
+		return -EINVAL;
+	}
+
 	/*
 	 * We need the tasklist lock even for the specific
 	 * thread case (when we don't need to follow the group

and it prints "p->sighand =3D=3D NULL" every time I exit a program while
using the usbdevio based driver.

consequently, the following patch 'fixed' the problem.  Please do not
consider this as a real fix, since there's certainly still a race
condition left.   Please use it as a hint to correctly fix the problem.

Index: linux-2.6.12-rc5/drivers/usb/core/devio.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.12-rc5.orig/drivers/usb/core/devio.c	2005-05-26 15:49:57.0000=
00000 +0200
+++ linux-2.6.12-rc5/drivers/usb/core/devio.c	2005-05-30 23:21:06.000000000=
 +0200
@@ -283,7 +283,8 @@
 		sinfo.si_errno =3D as->urb->status;
 		sinfo.si_code =3D SI_ASYNCIO;
 		sinfo.si_addr =3D as->userurb;
-		send_sig_info(as->signr, &sinfo, as->task);
+		if (as->task && as->task->sighand)
+			send_sig_info(as->signr, &sinfo, as->task);
 	}
         wake_up(&ps->wait);
 }

Thanks,
--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--8nsIa27JVQLqB7/C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD4DBQFCm4URXaXGVTD0i/8RAk+JAJ9G+AHHYrN0jfZOhAV9AGkyj9okvACVG4G0
E7wY32ZACxJhqUijDmWC1A==
=ecJ9
-----END PGP SIGNATURE-----

--8nsIa27JVQLqB7/C--
