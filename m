Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVBOUVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVBOUVd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 15:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVBOUVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 15:21:33 -0500
Received: from mail.murom.net ([213.177.124.17]:26307 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S261870AbVBOUNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 15:13:25 -0500
Date: Tue, 15 Feb 2005 23:13:18 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Pty is losing bytes
Message-ID: <20050215201318.GA13756@sirius.home>
References: <jebramy75q.fsf@sykes.suse.de> <Pine.LNX.4.58.0502151053060.5570@ppc970.osdl.org> <20050215225802.6321e9a8.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20050215225802.6321e9a8.vsu@altlinux.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 15, 2005 at 10:58:02PM +0300, Sergey Vlasov wrote:
> On Tue, 15 Feb 2005 11:08:07 -0800 (PST) Linus Torvalds wrote:
>=20
> > On Tue, 15 Feb 2005, Andreas Schwab wrote:
> > >
> > > Recent kernel are losing bytes on a pty.=20
> >=20
> > Great catch.
> >=20
> > I think it may be a n_tty line discipline bug, brought on by the fact t=
hat
> > the PTY buffering is now 4kB rather than 2kB. 4kB is also the
> > N_TTY_BUF_SIZE, and if n_tty has some off-by-one error, that would expl=
ain=20
> > it.
> >=20
> > Does the problem go away if you change the default value of "chunk" (in=
=20
> > drivers/char/tty_io.c:do_tty_write) from 4096 to 2048? If so, that mean=
s=20
> > that the pty code has _claimed_ to have written 4kB, and only ever wrot=
e=20
> > 4kB-1 bytes. That in turn implies that "ldisc.receive_room()" disagrees=
=20
> > with "ldisc.receive_buf()".
>=20
> The problem also goes away after unsetting ECHO on the slave terminal.
> This seems to point to this code in n_tty_receive_char():
>=20
> 	if (L_ECHO(tty)) {
> 		if (tty->read_cnt >=3D N_TTY_BUF_SIZE-1) {
> 			put_char('\a', tty); /* beep if no space */
> 			return;
> 		}
> 	.......
> 	}
>=20
> This code sets the maximum number of buffered characters to
> N_TTY_BUF_SIZE-1, however, put_tty_queue() considers the maximum to be
> N_TTY_BUF_SIZE, and n_tty_receive_room() also returns N_TTY_BUF_SIZE for
> canonical mode if the canon_data buffer is empty - therefore after
> unsetting ECHO bytes are no longer lost.

But all this really is not important, because n_tty_receive_char() can
put more than one char into buffer for a single input char in lots of
cases.  Therefore n_tty_receive_room() can overestimate the available
space at least by 2 times.

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCElfeW82GfkQfsqIRAqtyAJ4+YITDxm/+2WIMw2/2kSu/au3seQCdE3kc
Pp3TASCkv5S3MHucqiXYgcU=
=zJab
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
