Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264487AbTKNUHd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 15:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbTKNUHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 15:07:33 -0500
Received: from coruscant.franken.de ([193.174.159.226]:45754 "EHLO
	dagobah.gnumonks.org") by vger.kernel.org with ESMTP
	id S264487AbTKNUH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 15:07:29 -0500
Date: Fri, 14 Nov 2003 21:06:43 +0100
From: Harald Welte <laforge@netfilter.org>
To: linux-kernel@vger.kernel.org
Subject: seq_file API strangeness
Message-ID: <20031114200642.GG6937@obroa-skai.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lQSB8Tqijvu1+4Ba"
Content-Disposition: inline
X-Operating-System: Linux obroa-skai.de.gnumonks.org 2.4.23-pre7-ben0
X-Date: Today is Pungenday, the 26th day of The Aftermath in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lQSB8Tqijvu1+4Ba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

While porting /proc/net/ip_conntrack over to seq_file, I stumbled across
the following problem:

The documentation says:

 *	seq_open() sets @file, associating it with a sequence described
 *	by @op.  @op->start() sets the iterator up and returns the first
 *	element of sequence. @op->stop() shuts it down.  @op->next()
 *	returns the next element of sequence.  @op->show() prints element
 *	into the buffer.  In case of error ->start() and ->next() return
 *	ERR_PTR(error).  In the end of sequence they return %NULL. ->show()
 *	returns 0 in case of success and negative number in case of error.

Now let's say I'm allocating some chunk of memory in ->start(), and
later on an error occurs.  Now I return ERR_PTR(something).  Later on,=20
->stop() is called with that ERR_PTR(something) as parameter, and I try
to kfree() the chunk of memory that was allocated.  boom.  It's neither
NULL nor a valid pointer.

Also, I am wondering why the ->stop() function is called at all, when
->start() fails.  Initially, I was grabbing a lock, but only at the end
of ->start(), after all potential errors would already result in
returning ERR_PTR(something).  ->stop() however is then called
unconditionally, resulting in an unconditional unlock of my lock. boom.

Was this by intention?  I think it is unusual to call a  stop() function
even if start() didn't succeed.

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--lQSB8Tqijvu1+4Ba
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/tTXSXaXGVTD0i/8RAmhiAJ9Jo8nuEbAjgI9r7DjHsyQqG9Ns+QCff4Hr
KgAufTpOHIeRMXxEPM3/Dq0=
=tILz
-----END PGP SIGNATURE-----

--lQSB8Tqijvu1+4Ba--
