Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263814AbVBDNxC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263814AbVBDNxC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 08:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbVBDNxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 08:53:02 -0500
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:54944 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S266308AbVBDNs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 08:48:29 -0500
Subject: Questions about the Linux key retention services (and dm-crypt)
From: Christophe Saout <christophe@saout.de>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, dm-crypt@saout.de
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-D3p4aEJp57aYeZVfSGy+"
Date: Fri, 04 Feb 2005 14:48:21 +0100
Message-Id: <1107524901.12265.54.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-D3p4aEJp57aYeZVfSGy+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I was investigating a way to hide the dm-crypt key from device-mapper
configuration IOCTLs since the key might accidentally end up somewhere
it shouldn't (see other thread).

Then I stumbled across the new key retention service. This is exectly
what I was looking for.

The idea is to add the crypto configuration as a key and then give the
device-mapper a reference to that key. So everybody can then safely read
and copy the device-mapper configuration without risking to compromise
the key.

I just hacked something up which seems to work, just a prototype though.
(If someone wants to have a look at it:
http://www.saout.de/misc/dm-crypt-key-retention-v1.diff ).

There are some minor issues and questions:

I'd like to create the crypto tfm in the instantiation function (to
verify the validity of the cipher and key immediately). Cryptoapi might
call modprobe to load a cipher. Then it deadlocks. The reason is the
instantiation semaphore (kernel tries to create a keyring for modprobe).
Can we somehow get rid of it?

The other question I have is how should I describe references to the
key. My idea was to use its description. The userspace application adds
the key to one of its keyrings and tells dm-crypt its name. dm-crypt
calls search_process_keyrings to retrieve the key.

The alternative would be to use the key's serial id. What do you think
(as designer of the API) would be the better solution?

What I like is the key refcounting. The process creating the dm-crypt
mapping can put the key in its process keyring and when it exits the
keyring is destroyed, so that the key is "floating" (held by dm-crypt).

Once the dm-crypt mapping is removed the key is also destroy. No risk of
having unused keys hanging around.

The problem is that if an application wants to modify the dm-crypt
mapping is that it needs to get a reference to the key:

With the serial id it would be easy, it just links the key to one of its
keyrings and can then destroy the dm-crypt mapping without having to
worry that the keys gets destroyed.

But if I reference the key by its description, dm-crypt would need to
link the key to one of the caller's (which asks dm-crypt for the key)
keyrings itself so that the caller can then find the key. This sounds a
bit ugly to me. I'd prefer to not keep the keys in the root user keyring
to make sure the key gets destroyed when nobody is using it.

So which solution is better? Should I use the key description or serial
id for references? The downside of using the serial id would be that any
application could reference any key, even keys it does not own. The
problem with using the description is described above.


--=-D3p4aEJp57aYeZVfSGy+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCA30lZCYBcts5dM0RAh6BAJ9UnLLFdWRvHi0GwWFvBIrGbn+u8gCfYBoA
AoV89bqY6ACXdEhUnDnglOQ=
=zoTG
-----END PGP SIGNATURE-----

--=-D3p4aEJp57aYeZVfSGy+--

