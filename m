Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbVHWTx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbVHWTx7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 15:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbVHWTx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 15:53:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42660 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932350AbVHWTx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 15:53:59 -0400
Message-ID: <430B7EAE.6020001@redhat.com>
Date: Tue, 23 Aug 2005 12:53:18 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla Thunderbird 1.0.6-3 (X11/20050806)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: mremap() use is racy
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB59C9B503C38CF316E191BBF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB59C9B503C38CF316E191BBF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Not the mremap() implementation itself, so don't worry.

If mremap() is to be used without the MREMAP_MAYMOVE flag the call will
only succeed of the address space after the block which is to be
remapped is empty.  This is rarely the case since there are many users
of mmap and memory is allocated consecutively in many cases.

So what programs have to do is to make sure ahead of time that the
mremap() call can succeed.  The best way to do this is using an
anonymous, unused, unusable mapping.  Code like this:

p =3D mmap(NULL, 65536, PROT_NONE, MAP_PRIVATE|MAP_ANON, -1, 0);

mmap(p, 16384, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);


Then when the mapping has to be extended one should be able to use mremap=
():


mremap(p, 16384, 32768, 0);


But this is not possible since mremap() respects the anonymous mapping.
 So one has to use


munmap((char*)p + 16384, 16384);


before the mremap() call.  But this is where the race comes in.  Some
other thread might allocate these blocks before the mremap() call can do =
it.


One possible solution would be to add a flag to mremap() which allows
mremap() to steal memory.  In general that would be too dangerous but we
could limit it to private, anonymous mappings which have no access
permissions (i.e., PROT_NONE with MAP_PRIVATE and MAP_ANON).  One
explicitly has to allocate such blocks, they don't appear naturally.
And the program in any case knows about the address space layout.

So, how about adding MREMAP_MAPOVERNONE or so?

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigB59C9B503C38CF316E191BBF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDC36u2ijCOnn/RHQRAv/yAJ4yApc7nAOkCwA59ZDolYME+tXnCACgvaRj
S4uTtUanIM4l1ZKzbbFCGY4=
=QOCy
-----END PGP SIGNATURE-----

--------------enigB59C9B503C38CF316E191BBF--
