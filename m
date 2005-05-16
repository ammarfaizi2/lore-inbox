Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVEPRiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVEPRiW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 13:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVEPRiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 13:38:21 -0400
Received: from imf19aec.mail.bellsouth.net ([205.152.59.67]:1670 "EHLO
	imf19aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261459AbVEPRhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 13:37:23 -0400
Date: Mon, 16 May 2005 07:37:16 -0500
From: Tommy Reynolds <Tommy.Reynolds@MegaCoder.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Hyper-Threading Vulnerability
Message-Id: <20050516073716.36c21fa1.Tommy.Reynolds@MegaCoder.com>
In-Reply-To: <Pine.LNX.4.58.0505160945280.28162@ppc970.osdl.org>
References: <1115963481.1723.3.camel@alderaan.trey.hu>
	<m164xnatpt.fsf@muc.de>
	<1116009347.1448.489.camel@localhost.localdomain>
	<4284F6B5.2080308@coyotegulch.com>
	<Pine.LNX.4.58.0505160945280.28162@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.9.10 (GTK+ 2.6.4; i686-redhat-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$
 t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl
 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__16_May_2005_07_37_16_-0500_KlWkvA2U.qbfEzqs"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__16_May_2005_07_37_16_-0500_KlWkvA2U.qbfEzqs
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Uttered Linus Torvalds <torvalds@osdl.org>, spake thus:

> It does show that if you want to hide key operations, you want to be=20
> careful. I don't think HT is at fault per se.

Trivially easy when two processes share the same FS namespace.
Consider two files:

$ ls -l /tmp/a /tmp/b
-rw------ 1 owner owner xxxxx /tmp/a
-rw------ 1 owner owner xxxxx /tmp/b

One file serves as a clock.  Note that the permissions deny all
access to everyone except the owner.  The owner user then does this,
intentionally or unintentionally:

for x in 0 0 0 1 0 0 0 0 0 1
do
	rm -f /tmp/a /tmp/b
	case "$x" in
	0 )	rm -f /tmp/a;;
	1 )	touch /tmp/a;;
	esac
	touch /tmp/b
	sleep	2
done

And the baddie does this:

let n=3D1
let char=3D0
while (($n < 8))
do
	while [ ! -f /tmp/b ]; do
		sleep 0.5
	done
	let char=3D((char << 1))
	if [ -f /tmp/a ]; do
		let char=3D((char + 1))
	done
done
printf "The letter was: %c\n" $char

This is one of the classic TEMPEST problems that secure systems have
long had to deal with.  See, at no time did HT ever raise its ugly
head ;-)

Cheers

--Signature=_Mon__16_May_2005_07_37_16_-0500_KlWkvA2U.qbfEzqs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCiJP8/0ydqkQDlQERAuE/AJ9DP7QoMLRq3bfcZx4PLbl61jccZACgxryG
KCFHhhWr+EVqaT9Ckn3+L1c=
=Uhvo
-----END PGP SIGNATURE-----

--Signature=_Mon__16_May_2005_07_37_16_-0500_KlWkvA2U.qbfEzqs--
