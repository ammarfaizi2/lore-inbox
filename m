Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbTK2UMd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 15:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTK2UMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 15:12:33 -0500
Received: from ns.suse.de ([195.135.220.2]:65456 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262686AbTK2UM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 15:12:29 -0500
Date: Sat, 29 Nov 2003 21:12:25 +0100
From: Kurt Garloff <garloff@suse.de>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Allow unimap change on non fg console
Message-ID: <20031129201225.GQ3049@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Andries Brouwer <Andries.Brouwer@cwi.nl>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2/Dpz40iF3jpiHxF"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.6.0-test11-0-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE(DE), TU/e(NL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2/Dpz40iF3jpiHxF
Content-Type: multipart/mixed; boundary="OrT4iOlIQZp3kw4S"
Content-Disposition: inline


--OrT4iOlIQZp3kw4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andries,

The comment in front of vt_ioctl() reads
/*
 * We handle the console-specific ioctl's here.  We allow the
 * capability to modify any console, not just the fg_console.=20
 */

Unfortunately, this does not apply to PIO_UNIMAPCLR, nor
GIO_/PIO_UNIMAP. They always operate on the current foreground
console, which is inconsistent at least. For most ioctls, the
comment is applicable.

It also causes problems, as setfont can't do the full job on
the non-fg consoles. (OK, our setfont is slightly changed to
even try it ... as you know.)

The attached patch does fix this.
Please consider applying to 2.6.x.

I have a similar patch for 2.4, but it never got merged :-(
because not many people seem to care and I submitted in the middle
of the 2.4 series ...
It has been in UnitedLinux/SUSE kernels for ages, though.

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>             [Koeln, DE]
Physics:Plasma modeling <garloff@plasimo.phys.tue.nl> [TU Eindhoven, NL]
Linux:SCSI, Security           <garloff@suse.de>    [SUSE Nuernberg, DE]

--OrT4iOlIQZp3kw4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=unimap_set
Content-Transfer-Encoding: quoted-printable

Binary files linux-2.6.0-test11/drivers/char/.vt.c.rej.swp and linux-2.6.0-=
test11.unimap/drivers/char/.vt.c.rej.swp differ
Binary files linux-2.6.0-test11/drivers/char/.vt.c.swp and linux-2.6.0-test=
11.unimap/drivers/char/.vt.c.swp differ
diff -uNr linux-2.6.0-test11/drivers/char/vt_ioctl.c linux-2.6.0-test11.uni=
map/drivers/char/vt_ioctl.c
--- linux-2.6.0-test11/drivers/char/vt_ioctl.c	2003-11-26 21:44:53.00000000=
0 +0100
+++ linux-2.6.0-test11.unimap/drivers/char/vt_ioctl.c	2003-11-28 11:25:57.6=
71670301 +0100
@@ -332,7 +332,7 @@
 }
=20
 static inline int=20
-do_unimap_ioctl(int cmd, struct unimapdesc *user_ud,int perm)
+do_unimap_ioctl(int cmd, struct unimapdesc *user_ud, int perm, unsigned in=
t console)
 {
 	struct unimapdesc tmp;
 	int i =3D 0;=20
@@ -348,9 +348,11 @@
 	case PIO_UNIMAP:
 		if (!perm)
 			return -EPERM;
-		return con_set_unimap(fg_console, tmp.entry_ct, tmp.entries);
+		return con_set_unimap(console, tmp.entry_ct, tmp.entries);
 	case GIO_UNIMAP:
-		return con_get_unimap(fg_console, tmp.entry_ct, &(user_ud->entry_ct), tm=
p.entries);
+		if (!perm && fg_console !=3D console)
+			return -EPERM;
+		return con_get_unimap(console, tmp.entry_ct, &(user_ud->entry_ct), tmp.e=
ntries);
 	}
 	return 0;
 }
@@ -966,13 +968,13 @@
 			return -EPERM;
 		i =3D copy_from_user(&ui, (void *)arg, sizeof(struct unimapinit));
 		if (i) return -EFAULT;
-		con_clear_unimap(fg_console, &ui);
+		con_clear_unimap(console, &ui);
 		return 0;
 	      }
=20
 	case PIO_UNIMAP:
 	case GIO_UNIMAP:
-		return do_unimap_ioctl(cmd, (struct unimapdesc *)arg, perm);
+		return do_unimap_ioctl(cmd, (struct unimapdesc *)arg, perm, console);
=20
 	case VT_LOCKSWITCH:
 		if (!capable(CAP_SYS_TTY_CONFIG))

--OrT4iOlIQZp3kw4S--

--2/Dpz40iF3jpiHxF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/yP2oxmLh6hyYd04RAp5GAKCZuD7JeQ8SoYvj+t/WH1n2GBzUggCg0OBJ
y5CDoA83547ZfIkH6MOiugM=
=SiHr
-----END PGP SIGNATURE-----

--2/Dpz40iF3jpiHxF--
