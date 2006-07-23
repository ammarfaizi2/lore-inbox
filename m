Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWGWOgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWGWOgn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 10:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWGWOgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 10:36:43 -0400
Received: from adsl-230-146.dsl.uva.nl ([146.50.230.146]:63360 "EHLO
	hypnos.var.cx") by vger.kernel.org with ESMTP id S1751216AbWGWOgn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 10:36:43 -0400
Date: Sun, 23 Jul 2006 16:36:46 +0200
From: Frank v Waveren <fvw@var.cx>
To: linux-kernel@vger.kernel.org
Subject: linux capabilities oddity
Message-ID: <20060723143646.GA2840@var.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I sent this to linux-privs-discuss, but that list appears to be dead.
Perhaps someone here can help me?


While debugging an odd problem where /proc/sys/kernel/cap-bound wasn't
working, I came across the following code at
linux-2.6.x/security/commoncap.c:140:

   void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
   {
           /* Derived from fs/exec.c:compute_creds. */
           kernel_cap_t new_permitted, working;

           new_permitted =3D cap_intersect (bprm->cap_permitted, cap_bset);
           working =3D cap_intersect (bprm->cap_inheritable,
                                    current->cap_inheritable);
           new_permitted =3D cap_combine (new_permitted, working);
           ...

Here the new permitted set gets limited to the bits in cap_bset, which
is as it should be, but then the intersection of the of the current
and exec inheritable masks get added to that set, whereas as I
understand it, cap_bset should always be the bounding set.
          =20
This triggered a problem where the /sbin/init on a gentoo install disk
(which I was using as an quick&dirty UML root disk for testing) for
some reason did something to set its inheritable mask to ~0, which
then propagated to all the processes that ran as root, which meant
that the cap bound didn't apply to them.

I took out the cap_combine and didn't notice any ill effects on some
quick tests, though I don't know POSIX capabilities well enough to say
all the behaviour was per the standard. If someone could tell me what
those lines are for, and if its foiling of cap-bound limits is on
purpose, I'd be most grateful.

--=20
Frank v Waveren                                  Key fingerprint: BDD7 D61E
fvw@var.cx                                              5D39 CF05 4BFC F57A
Public key: hkp://wwwkeys.pgp.net/468D62C8              FA00 7D51 468D 62C8

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEw4l++gB9UUaNYsgRAtb9AJsHy3N83pb2dhoVvFGzTqwlP9YeTACdHnM9
QXMEosnoyF12K/C8YJkxKQ0=
=xvAd
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
