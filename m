Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbUKGUHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbUKGUHK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 15:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbUKGUHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 15:07:09 -0500
Received: from mail.murom.net ([213.177.124.17]:49546 "EHLO mail.murom.net")
	by vger.kernel.org with ESMTP id S261596AbUKGUGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 15:06:48 -0500
Date: Sun, 7 Nov 2004 23:06:01 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Jason Baron <jbaron@redhat.com>
Cc: Krzysztof Taraszka <dzimi@pld-linux.org>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] 2.4.28-pre3 tty/ldisc fixes
Message-ID: <20041107200601.GA2345@sirius.home>
References: <200410311053.34927.dzimi@pld-linux.org> <Pine.LNX.4.44.0411020958460.8117-100000@dhcp83-105.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0411020958460.8117-100000@dhcp83-105.boston.redhat.com>
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-SpamCheck: not spam, SpamAssassin (score=-0.745,
	required 6, autolearn=not spam, AWL 0.16, BAYES_10 -0.91)
X-MailScanner-From: vsu@altlinux.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 02, 2004 at 10:02:44AM -0500, Jason Baron wrote:
>=20
> On Sun, 31 Oct 2004, Krzysztof Taraszka wrote:
>=20
> > Dnia sobota, 30 pa?dziernika 2004 21:19, napisa?e?:
> > > On Fri, Oct 29, 2004 at 02:29:43PM -0400, Jason Baron wrote:
> >=20
> > > > Here's an updated 2.4 tty patch. I'm not sure if the updated patch =
would
> > > > fix the above issue, but it has a lot of changes so it might be wor=
th a
> > > > try.
> > >
> > > This looks better - at least the system boots without hang or oops ;)
> >=20
> > where is an updated 2.4 tty patch ?
>=20
> hmmm...seems like my e-mails keeping getting dropped, perhaps the patch is
> too large? Here is a link to the patch:
>=20
> http://people.redhat.com/~jbaron/tty/2.4-tty-V5.patch

Finally I have found the bug which prevented SieFS (slink) from
working.  The bug was in drivers/char/tty_ioctl.c:

@@ -131,16 +141,20 @@ static void change_termios(struct tty_st
 		}
 	}
=20
-	if (tty->driver.set_termios)
-		(*tty->driver.set_termios)(tty, &old_termios);
+	ld =3D tty_ldisc_ref(tty);
+	if (ld !=3D NULL) {
+		if (ld->set_termios)
+			(ld->set_termios)(tty, &old_termios);
+		tty_ldisc_deref(ld);
+	}
+	spin_unlock_irqrestore(&tty_termios_lock, flags);
=20
-	if (tty->ldisc.set_termios)
-		(*tty->ldisc.set_termios)(tty, &old_termios);
 }
=20
The call to tty->driver.set_termios was lost, therefore the serial
port speed was not set properly.

Simply adding this call back does not work, because set_termios
handlers in usbserial use semaphores for locking, and therefore cannot
be called while holding the tty_termios_lock spinlock.  Because of
this, some more backporting from 2.6.x is needed - Alan Cox has
already changed tty_termios_lock to a per-tty semaphore in 2.6.x, this
change is needed for 2.4.x too.

The patches are in separate emails: first is the backport of the
termios locking changes, second patch adds back lost call to
tty->driver.set_termios (which is safe after first patch).

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBjoApW82GfkQfsqIRAskDAJwJwVTm0msFv+x37sqPLmIYQEOnmwCfftUJ
Fue6UlBbV5GJva8d6OyIWLg=
=KP4G
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
