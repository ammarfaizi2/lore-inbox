Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262760AbVBCOTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbVBCOTP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 09:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbVBCOTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 09:19:15 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:32261 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S263742AbVBCOSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 09:18:23 -0500
Subject: Re: dm-crypt crypt_status reports key?
From: Fruhwirth Clemens <clemens@endorphin.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Christophe Saout <christophe@saout.de>,
       linux-kernel <linux-kernel@vger.kernel.org>, dm-crypt@saout.de,
       Alasdair G Kergon <agk@redhat.com>
In-Reply-To: <20050203040542.GQ2493@waste.org>
References: <20050202211916.GJ2493@waste.org>
	 <1107394381.10497.16.camel@server.cs.pocnet.net>
	 <20050203015236.GO2493@waste.org>
	 <1107398069.11826.16.camel@server.cs.pocnet.net>
	 <20050203040542.GQ2493@waste.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xY8Sh2YwbyCn+2rYo8U3"
Date: Thu, 03 Feb 2005 15:18:20 +0100
Message-Id: <1107440300.15236.58.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xY8Sh2YwbyCn+2rYo8U3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-02-02 at 20:05 -0800, Matt Mackall wrote:

> Dunno here, seems that having one tool that gave the kernel a key named
> "foo" and then telling dm-crypt to use key "foo" is probably not a bad
> way to go. Then we don't have stuff like "echo <key> | dmsetup create"
> and the like and the key-handling smarts can all be put in one
> separate place.
>=20
> Getting from here to there might be interesting though. Perhaps we can
> teach dm-crypt to understand keys of the form "keyname:<foo>"? in
> addition to raw keys to keep compatibility. Might even be possible to
> push this down into crypt_decode_key() (or a smarter variant of same).

Way too complicated. This is a crypto project, why does nobody think of
crypto to solve the problem :). Here's the idea:

Keys are handed to dm-crypt regularly the first time. But when dm-crypt
hands keys back to user space, it uses some sort of blinding to make the
keys meaningless for user space.=20

That can easily be done by generating a kernel internal secret after
boot, and then before handing out the keys to user space, XOR-ing the
kernel secret into the key. When these keys are handed back from user
space to the kernel, the process is reversed.=20

That's an effective blinding mechanism. The kernel has to remember
nothing but a single secret. No special out-of-band setup of "keyname:"
tokens, no additional management for these tokens and blinded key
becomes useless after reboot.

Of course, the blinded keys need to be distinguished from regular keys.
I propose to prepend "!" to the keys handed back to the user space, so
we have "!<hex..key>", and add a simple conditional post processing to
crypt_decode_key.

Of course, one can use encryption instead of XOR-ing with the kernel
secret as blinding mechanism, as the kernel secret can easily be
recovered by setting up a all-zero key. But the main intend of this
approach is to protect against incompetent roots and user space
programs, so I think this XOR OTP is sufficient, and further, trivially
to implement. (Actually it's a Multi Time Pad.)

--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-xY8Sh2YwbyCn+2rYo8U3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCAjKsW7sr9DEJLk4RApjpAJ93z/iwj8OGH1pAYvB6NnR1vaiC3gCfcUtX
+tTbnNSP+JTVsOZaHfvvuzo=
=12E8
-----END PGP SIGNATURE-----

--=-xY8Sh2YwbyCn+2rYo8U3--
