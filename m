Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbTEAPnZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 11:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbTEAPnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 11:43:25 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:22477 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261422AbTEAPnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 11:43:22 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: hugang <hugang@soulinfo.com>
Subject: Re: [RFC][PATCH] Faster generic_fls
Date: Thu, 1 May 2003 17:54:28 +0200
User-Agent: KMail/1.5
References: <200304300446.24330.dphillips@sistina.com> <20030501135204.GC308@pcw.home.local> <20030501225321.6b30e8dc.hugang@soulinfo.com>
In-Reply-To: <20030501225321.6b30e8dc.hugang@soulinfo.com>
Cc: Willy TARREAU <willy@w.ods.org>, linux-kernel@vger.kernel.org,
       akpm@digeo.com
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_5MUs+Db2JfP20SB";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305011754.33233.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_5MUs+Db2JfP20SB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

Hi,

On March 1, hugang wrote:
> On Thu, 1 May 2003 15:52:04 +0200
>
> Willy TARREAU <willy@w.ods.org> wrote:
> >  However, I have good news for you, the table code is 15% faster than my
> > tree on an Alpha EV6 ;-)
> >  It may be because gcc can use different tricks on this arch.
> >
> >  Cheers
> >  Willy
>
> However, The most code changed has increase a little peformance, Do we
> really need it?
>
> Here is test in my machine, The faster is still table.

I think the table version is so fast as a normal distribution of numbers is=
=20
tested. With this distribution half of the occuring values have the MSB set=
,=20
one quarter the next significant bit and so on...

The tree version is approximately equally fast for every number, but the ta=
ble=20
version is fast if a very significant bit is set and slow if  a less=20
significant bit is set...

If small values occour more often than big ones the tree version should be=
=20
preferred, else following version may be very fast, too.

static inline int fls_shift(int x)
{
	int bit =3D 32;
=20
	while(x > 0) {
		--bit;
		x <<=3D 1;
	}

	return x ? bit : 0;
}

I get following times on my K6-III (compiled with -O3 -march=3Dk6) for=20
4294967296 iterations:

fls_bsrl: (uses the 'bsrl' command via inline assembler)
real    3m39.059s
user    3m27.416s
sys     0m0.345s

fls_shift:
real    1m47.337s
user    1m41.801s
sys     0m0.185s

fls_tree:
real    1m56.746s
user    1m50.681s
sys     0m0.165s

The 32Bit tree is a bit slower here, too:
real    1m59.447s
user    1m53.375s
sys     0m0.200s

I did not test the table version as I think it cannot be faster than the sh=
ift=20
version...

Best regards
  Thomas Schlichter

P.S.: I'd be happy to see how this performs on an Athlon or P-IV...
--Boundary-02=_5MUs+Db2JfP20SB
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+sUM5YAiN+WRIZzQRAt3tAKDKjTYxT5pQ9/B8LHmS+ej9Eg0i7wCg2mLH
U6goTlmi/1bvowKeBhwKTo8=
=JSxz
-----END PGP SIGNATURE-----

--Boundary-02=_5MUs+Db2JfP20SB--

