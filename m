Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265993AbSKDNM0>; Mon, 4 Nov 2002 08:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265994AbSKDNM0>; Mon, 4 Nov 2002 08:12:26 -0500
Received: from turing.fb12.de ([80.76.224.45]:41630 "HELO turing.fb12.de")
	by vger.kernel.org with SMTP id <S265993AbSKDNMV>;
	Mon, 4 Nov 2002 08:12:21 -0500
Date: Mon, 4 Nov 2002 14:18:53 +0100
From: Sebastian Benoit <benoit-lists@fb12.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [PATCH] tcp hang solved
Message-ID: <20021104141852.A31235@turing.fb12.de>
Mail-Followup-To: Sebastian Benoit <benoit-lists@fb12.de>,
	"David S. Miller" <davem@redhat.com>, Andries.Brouwer@cwi.nl,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <UTC200211040027.gA40RQ103595.aeb@smtp.cwi.nl> <20021104.023620.20862097.davem@redhat.com> <20021104123824.A29797@turing.fb12.de> <20021104.055951.41634255.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021104.055951.41634255.davem@redhat.com>; from davem@redhat.com on Mon, Nov 04, 2002 at 05:59:51AM -0800
X-MSMail-Priority: High
x-gpg-fingerprint: 2999 9839 6C9E E4BF B540  C44B 4EC4 E1BE 5BA2 2F00
x-gpg-key: http://wwwkeys.de.pgp.net:11371
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

David S. Miller(davem@redhat.com)@2002.11.04 05:59:51 +0000:
>    From: Sebastian Benoit <benoit-lists@fb12.de>
>    Date: Mon, 4 Nov 2002 12:38:25 +0100
>   =20
>    This bug was introduced in 2.5.43-bk1, previous versions are ok.
>    I think it might be=20
>    ChangeSet 1.781.1.68 2002/10/15 19:01:33 kuznet@mops.inr.ac.ru
>    but i'm not sure.
>=20
> It's not possible, if this functions modified here did not work you
> would not be able to make any connections at all.
>=20
> Can you try reverting the networking changesets one by one until
> the problem goes away?

I removed parts of 2.5.43-bk1 and that solved my problem, see attached mail
below. When I did this (2 weeks ago) I removed all changes that touched
net/* and associated includes. I was not able to pinpoint the exact change
that causes the problem, the changes there are a bit to much for my knowled=
ge=20
of the kernel, sorry.

/B.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Date: Fri, 18 Oct 2002 12:47:17 +0200
From: Sebastian Benoit <benoit-lists@fb12.de>
To: netdev@oss.sgi.com
Subject: network connection gets stuck with 2.5.43-bk1/mm2
Message-ID: <20021018124717.A21622@turing.fb12.de>

Hi,

i posted the message below to linux-mm yesterday, Andrew Morton told me that
it might be one of the changes in networking in -bk1.

removing these changes solved the problem:

 include/linux/ip.h        |   16=3D20
 include/linux/tcp.h       |    2=3D20
 include/linux/udp.h       |   31 -
 include/net/dst.h         |   56 --
 include/net/ip.h          |   16=3D20
 include/net/sock.h        |    2=3D20
 include/net/tcp.h         |    2=3D20
 include/net/udp.h         |    2=3D20
 net/core/dst.c            |   25 -
 net/ipv4/af_inet.c        |   17=3D20
 net/ipv4/icmp.c           |    4=3D20
 net/ipv4/ip_output.c      |  880 +++++++----------------------------------=
=3D
-----
 net/ipv4/ip_proc.c        |   74 ---
 net/ipv4/ip_sockglue.c    |    4=3D20
 net/ipv4/raw.c            |    7=3D20
 net/ipv4/tcp.c            |   49 --
 net/ipv4/tcp_ipv4.c       |    6=3D20
 net/ipv4/tcp_minisocks.c  |   10=3D20
 net/ipv4/udp.c            |  296 ---------------
 net/ipv6/tcp_ipv6.c       |    5=3D20
 net/netsyms.c             |    1=3D20

(this is the diffstat of the reverse patch)

Is this fixed already?
/B.



----------------- quote -----------------
Hi,=3D20

funny problem w. 2.5.43-mm2:

i'm running 2.5.43-mm2 on my workstation. Normal workload, X-windows, a few
xterms, editor, mozilla, etc. (host A)

I have a NFS/SAMBA-mount (both show the problem) to host B. Host B runs
2.4.19rc5aa1.

I can get a xterm, in which i have a ssh-connection to a third host C
'stuck' by simply cat'ing a large file from the NFS/SAMBA server to
/dev/null.

The xterm/ssh seems stuck, that is no key i press is received on the other
end, but output of the program running on host C is updated in the xterm. I
checked with tcpdump: the keypress does not generate a packet, my host only
sends ACK's on that ssh connection to host C.

The ssh-connection is not unstuck by stopping the data transfer from host B.

I checked that plain 2.5.42 and 2.5.43-mm1 do not have this problem: here my
input goes through to C. At least for small amounts of input, i did not test
anything beyond typing a few hundret chars.

recap:

 "mount /mnt/hostB"
 "ssh hostC" -> type random stuff in that connection
 at the same time do "cat /mnt/hostB/bigfile > /dev/null"
 ssh gets stuck.

hardware: PIII/600, 3c905B on 10baseT half-duplex

I'm sorry i cant do any further checks until Friday afternoon (MET).

/B.
--------------- quote ends ---------------


--=20
Sebastian Benoit <benoit-lists@fb12.de>
My mail is GnuPG signed -- Unsigned ones are bogus -- http://www.gnupg.org/
GnuPG 0x5BA22F00 2001-07-31 2999 9839 6C9E E4BF B540  C44B 4EC4 E1BE 5BA2 2=
F00

Every gun that is made, every warship launched, every rocket fired,
signifies in the final sense a theft from those who hunger and are not fed,
those who are cold and are not clothed.
-- Dwight D. Eisenhower, U.S. President, 1953

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj3Gc7wACgkQTsThvluiLwBZlACdG91BPHzFXqvsmL0gCDyFMEuM
b0IAoJu1JnNLso/ZVJ9AdsP5kN9BZt3s
=7IZ8
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
