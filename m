Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136074AbREGKiY>; Mon, 7 May 2001 06:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136073AbREGKiO>; Mon, 7 May 2001 06:38:14 -0400
Received: from ns.suse.de ([213.95.15.193]:51468 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S136074AbREGKiF>;
	Mon, 7 May 2001 06:38:05 -0400
Date: Mon, 7 May 2001 12:37:09 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: vt.c: unimap changes to (fg_?)console
Message-ID: <20010507123709.D8052@garloff.suse.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andries Brouwer <Andries.Brouwer@cwi.nl>,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f5QefDQHtn8hx44O"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.19 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--f5QefDQHtn8hx44O
Content-Type: multipart/mixed; boundary="fwqqG+mf3f7vyBCB"
Content-Disposition: inline


--fwqqG+mf3f7vyBCB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus, Alan, Andries,

if you open /dev/tty4 and change the font via ioctl(KDFONTOP), it will be
applied to the opened console, i.e. tty4. Then you set the corresponding
unicodemap via PIO_UNIMAPCLR and PIO_UNIMAP ioctls. Those get applied to the
current foreground console. Which is inconsistent.

Looking at vt.c: vt_ioctl(), the situation is a bit messy: Some ioctls don't
explicitly specify a tty (probably not needed, as some settings are global),
some apply to fg_console, some apply to the opened console which is
((struct vt_struct*)tty->driver_data)->vc_num.

I would appreciate, if somebody with more knowledge could have a look and
check whether this is all correct. At least for the above case, it's not.
(Andries, I would appreciate if you have a look; you understand much more of
it than I do.)

I attach a patch to fix the specific problem reported above. It applies to
both 2.4.4 and 2.2.19. ioctl(PIO_UNIMAP[CLR]) is applied to the opened
console now instead of fg_console.
Please apply until somebody comes with a complete vt.c cleanup!

If you want to test yourself: I also have a patch against kbd-1.05
which allows you to use setfont -c /dev/ttyXX to specify which terminal you
want to. I already sent it to Andries.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--fwqqG+mf3f7vyBCB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="unimap_set-244.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-244.compile/drivers/char/vt.c.orig	Fri Feb  9 20:30:22 2001
+++ linux-244.compile/drivers/char/vt.c	Mon May  7 10:37:25 2001
@@ -392,7 +392,7 @@
 }
=20
 static inline int=20
-do_unimap_ioctl(int cmd, struct unimapdesc *user_ud,int perm)
+do_unimap_ioctl(int cmd, struct unimapdesc *user_ud, int perm, unsigned in=
t console)
 {
 	struct unimapdesc tmp;
 	int i =3D 0;=20
@@ -408,9 +408,11 @@
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
@@ -1029,13 +1031,13 @@
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
 		if (!suser())

--fwqqG+mf3f7vyBCB--

--f5QefDQHtn8hx44O
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE69nrUxmLh6hyYd04RAs3tAKCdDpUvGDQ7D55/9d6K6IvwjTKg6ACcDx4h
VxxvYSh/GyoQjXaYPyXLV5E=
=G8W/
-----END PGP SIGNATURE-----

--f5QefDQHtn8hx44O--
