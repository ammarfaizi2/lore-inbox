Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262491AbVBCBeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbVBCBeW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 20:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbVBCBeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 20:34:19 -0500
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:2969 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S262491AbVBCBd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 20:33:27 -0500
Subject: Re: dm-crypt crypt_status reports key?
From: Christophe Saout <christophe@saout.de>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Clemens Fruhwirth <clemens@endorphin.org>, dm-crypt@saout.de,
       Alasdair G Kergon <agk@redhat.com>
In-Reply-To: <20050202211916.GJ2493@waste.org>
References: <20050202211916.GJ2493@waste.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EC4mQ2gNSb697zLwztOZ"
Date: Thu, 03 Feb 2005 02:33:01 +0100
Message-Id: <1107394381.10497.16.camel@server.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EC4mQ2gNSb697zLwztOZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mittwoch, den 02.02.2005, 13:19 -0800 schrieb Matt Mackall:

> From looking at the dm_crypt code, it appears that it can be
> interrogated to report the current key. Some quick testing shows:
>=20
> # dmsetup table /dev/mapper/volume1
> 0 2000000 crypt aes-plain 0123456789abcdef0123456789abcdef 0 7:0 0
>=20
> Obviously, root can in principle recover this password from the
> running kernel but it seems silly to make it so easy.

I already tried that. It took me about five minutes using a shell, dd
and hexdump to get the key out of the running kernel...

> Moreover, it seems this facility exists to support some form of
> automated table storage (LVM?). As we don't want anyone/anything
> accidentally storing our passwords on disk in the clear, we probably
> shouldn't facilitate this. Perhaps we can stick something here like
> "<secret>" that the dm_crypt constructor can reject.

Yes, the reason is that the device-mapper supports on-the-fly
modifications of the device. cryptsetup has a command to resize the
mapping for example. It can do that without asking for the password
again. Features like this are the reason I'm doing this. Userspace tools
should be able to assume that they can use the result of a table status
command to create a new table with this information.

An alternativ would be to use some form of handle to point to the key
after it has been given to the kernel. But that would require some more
infrastructure.

I could imagine something like this:

Some kernel infrastructure for key management. It can hold keys which
are referenced by some form of handle. The keys are refcounted and wiped
if the reference count drops to zero.

If you want to create a dm-crypt mapping (or something else that uses
some form of cryptographic key) you create a new handle and assign the
key. Then you give the handle to dm-crypt which increments reference
count. When cryptsetup exits its reference to the key is dropped but the
key still has a reference from the active dm-crypt mapping. Later on
another application could then safely do something with that handle. As
long as an application or in-kernel user references the key it won't be
dropped so it's safe for a userspace application to play around with it.

BTW: The setkey command also seems to return the keys in use for IPSEC
connections.


--=-EC4mQ2gNSb697zLwztOZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCAX9NZCYBcts5dM0RAqsxAKCuWQ0yaCobqN1NQEXjuLJHugeSxgCeLz4a
9HW6xsJdkO7mWZQhNQLCXd4=
=ukTD
-----END PGP SIGNATURE-----

--=-EC4mQ2gNSb697zLwztOZ--
