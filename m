Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262484AbSKDLb7>; Mon, 4 Nov 2002 06:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264642AbSKDLb6>; Mon, 4 Nov 2002 06:31:58 -0500
Received: from turing.fb12.de ([80.76.224.45]:26014 "HELO turing.fb12.de")
	by vger.kernel.org with SMTP id <S262484AbSKDLbx>;
	Mon, 4 Nov 2002 06:31:53 -0500
Date: Mon, 4 Nov 2002 12:38:25 +0100
From: Sebastian Benoit <benoit-lists@fb12.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [PATCH] tcp hang solved
Message-ID: <20021104123824.A29797@turing.fb12.de>
Mail-Followup-To: Sebastian Benoit <benoit-lists@fb12.de>,
	"David S. Miller" <davem@redhat.com>, Andries.Brouwer@cwi.nl,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <UTC200211040027.gA40RQ103595.aeb@smtp.cwi.nl> <20021104.023620.20862097.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021104.023620.20862097.davem@redhat.com>; from davem@redhat.com on Mon, Nov 04, 2002 at 02:36:20AM -0800
X-MSMail-Priority: High
x-gpg-fingerprint: 2999 9839 6C9E E4BF B540  C44B 4EC4 E1BE 5BA2 2F00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

David S. Miller(davem@redhat.com)@2002.11.04 02:36:20 +0000:
>    From: Andries.Brouwer@cwi.nl
>    Date: Mon, 4 Nov 2002 01:27:26 +0100 (MET)
>   =20
>    So, the following patch should be appropriate.
>=20
> Thanks for this fix, I will apply it.  I have no idea why I didn't
> spot this while 'porting' this patch from 2.4.x to 2.5.x :)

This does _not_ fix the tcp hang i reported on netdev 2 weeks ago,
i can still reproduce this with 2.5.45-latest-bk + this patch:

hostA:  ./socket -s 3000 > /dev/null
hostA:  ssh hostC
hostB:  cat largefile | ./socket hostA 3000

  Now typing stuff in the ssh-connection to hostC will
  cause this connection to hang. [*]
  The connection between B and A is not affected.

This bug was introduced in 2.5.43-bk1, previous versions are ok.
I think it might be=20
ChangeSet 1.781.1.68 2002/10/15 19:01:33 kuznet@mops.inr.ac.ru
but i'm not sure.

[*] tcpdump output of the SSH connection at the moment it stops working:
the first packets are ok. 80.76.225.240 =3D hostA, 80.76.224.45 =3D hostC

12:27:06.846266 80.76.225.240.32921 > 80.76.224.45.ssh: P 3072:3120(48) ack=
 897 win 63712 <nop,nop,timestamp 2925577 602150234> (DF) [tos 0x10]=20
12:27:06.895276 80.76.224.45.ssh > 80.76.225.240.32921: P 897:945(48) ack 3=
120 win 15928 <nop,nop,timestamp 602151959 2925577> (DF) [tos 0x10]=20
12:27:06.895316 80.76.225.240.32921 > 80.76.224.45.ssh: . ack 945 win 63712=
 <nop,nop,timestamp 2925626 602151959> (DF) [tos 0x10]=20
12:27:07.095430 80.76.225.240.32921 > 80.76.224.45.ssh: P 3120:3168(48) ack=
 945 win 63712 <nop,nop,timestamp 2925826 602151959> (DF) [tos 0x10]=20
12:27:07.107633 80.76.224.45.ssh > 80.76.225.240.32921: P 897:945(48) ack 3=
120 win 15928 <nop,nop,timestamp 602151981 2925577> (DF) [tos 0x10]=20
12:27:07.107668 80.76.225.240.32921 > 80.76.224.45.ssh: . ack 945 win 63712=
 <nop,nop,timestamp 2925839 602151981,nop,nop,sack sack 1 {897:945} > (DF) =
[tos 0x10]=20
12:27:07.124619 80.76.225.240.32921 > 80.76.224.45.ssh: P 3168:3216(48) ack=
 945 win 63712 <nop,nop,timestamp 2925856 602151981> (DF) [tos 0x10]=20
12:27:07.304553 80.76.225.240.32921 > 80.76.224.45.ssh: P 3120:3168(48) ack=
 945 win 63712 <nop,nop,timestamp 2926036 602151981> (DF) [tos 0x10]=20
12:27:07.328656 80.76.224.45.ssh > 80.76.225.240.32921: P 945:993(48) ack 3=
168 win 15928 <nop,nop,timestamp 602152003 2926036> (DF) [tos 0x10]=20
[ssh stops working around here]
12:27:07.328689 80.76.225.240.32921 > 80.76.224.45.ssh: . ack 993 win 63712=
 <nop,nop,timestamp 2926060 602152003> (DF) [tos 0x10]=20
12:27:07.724482 80.76.225.240.32921 > 80.76.224.45.ssh: P ack 993 win 63712=
 <nop,nop,timestamp 2926456 602152003> (DF) [tos 0x10]=20
12:27:08.564354 80.76.225.240.32921 > 80.76.224.45.ssh: P ack 993 win 63712=
 <nop,nop,timestamp 2927296 602152003> (DF) [tos 0x10]=20
12:27:10.244202 80.76.225.240.32921 > 80.76.224.45.ssh: P ack 993 win 63712=
 <nop,nop,timestamp 2928976 602152003> (DF) [tos 0x10]=20
12:27:13.603809 80.76.225.240.32921 > 80.76.224.45.ssh: P ack 993 win 63712=
 <nop,nop,timestamp 2932336 602152003> (DF) [tos 0x10]=20
12:27:20.323005 80.76.225.240.32921 > 80.76.224.45.ssh: P ack 993 win 63712=
 <nop,nop,timestamp 2939056 602152003> (DF) [tos 0x10]=20

/B.
--=20
Sebastian Benoit <benoit-lists@fb12.de>
My mail is GnuPG signed -- Unsigned ones are bogus -- http://www.gnupg.org/
GnuPG 0x5BA22F00 2001-07-31 2999 9839 6C9E E4BF B540  C44B 4EC4 E1BE 5BA2 2=
F00

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj3GXDAACgkQTsThvluiLwAfnQCgiG7PQa0mSK27Bnnlr5DBMeyh
Y2oAoMDMDW65U0ognM31la19DACKh5Wr
=VEr6
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
