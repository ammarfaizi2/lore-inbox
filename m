Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbTEAXPn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 19:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbTEAXPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 19:15:43 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:53889 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S262765AbTEAXPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 19:15:40 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Willy TARREAU <willy@w.ods.org>, hugang <hugang@soulinfo.com>
Subject: Re: [RFC][PATCH] Faster generic_fls
Date: Fri, 2 May 2003 01:27:16 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com, dphillips@sistina.com
References: <200304300446.24330.dphillips@sistina.com> <20030501225321.6b30e8dc.hugang@soulinfo.com> <20030501171627.GA1785@pcw.home.local>
In-Reply-To: <20030501171627.GA1785@pcw.home.local>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_e1as+BGWDBV1125";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305020127.26279.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_e1as+BGWDBV1125
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

On May 1, Willy TARREAU wrote:
> On Thu, May 01, 2003 at 10:53:21PM +0800, hugang wrote:
> > Here is test in my machine, The faster is still table.
>
> because, as Falk said, the tests are incremental and the branch prediction
> works very well. I proposed a simple scrambling function based on bswap.
> Please consider this function :
>
>       f(i) =3D i ^ htonl(i) ^ htonl(i<<7)
>
> It returns such values :
>
> 0x00000001 =3D> 0x81000001
> 0x00000002 =3D> 0x02010002
> 0x00000003 =3D> 0x83010003
> 0x00000004 =3D> 0x04020004
> 0x00000005 =3D> 0x85020005
> 0x00000006 =3D> 0x06030006
> 0x00000007 =3D> 0x87030007
> 0x00000008 =3D> 0x08040008
> 0x00000009 =3D> 0x89040009
> 0x0000000a =3D> 0x0a05000a
> 0x0000000b =3D> 0x8b05000b
>
> etc...
>
> As you see, high bits move fast enough to shot a predictor.
>
> The tree function as well as Daniel's "new" resist better to non linear
> suites. BTW, the latest changes I did show that the convergence should be
> between Daniel's function and mine, because there are common concepts. I
> noticed that the expression used in Daniel's function is too complex for
> gcc to optimize it well enough. In my case, gcc 3.2.3 coded too many jumps
> instead of conditional moves. I saw that playing with -mbranch-cost chang=
es
> the code. A mix between the two is used here (and listed after). It's sti=
ll
> not optimial, reading the code, because there's always one useless jump a=
nd
> move. But in the worst case, it gives exactly the same result as Daniel's.
> But in other cases, it is even slightly faster. Honnestly, now it's just a
> matter of taste. Daniel's easier to read, mine produces smaller code. This
> time, it's faster than others Athlon, Alpha and Sparc. I Don't know about
> the PentiumIII nor the P4.
>
> Here are the results on Athlon, gcc-3.2.3, then Alpha and Sparc.

~~ snip~~

Here are some results with the scrambling function on AMD K6-III 450MHz,=20
gcc-2.95.3:

fls_old (generic_fls from linux 2.5.68):
real    3m52.960s
user    3m42.080s
sys     0m0.348s

fls_bsrl:
real    4m39.040s
user    4m25.532s
sys     0m0.401s

fls_table:
real    4m59.622s
user    4m45.511s
sys     0m0.469s

fls_tree:
real    3m3.986s
user    2m55.236s
sys     0m0.272s

fls_shift:
real    2m58.765s
user    2m50.092s
sys     0m0.278s

So for me the table version seems to be the slowest one. The BSRL instructi=
on=20
on the K6-III seems to be very slow, too. The tree and my shift version are=
=20
faster than the original version here...

That someone else can test my fls_shift version I'll provide it here again:
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

> Willy

Thomas
--Boundary-02=_e1as+BGWDBV1125
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+sa1dYAiN+WRIZzQRAm/sAKCXW6H5+UUY5Uxna9F87IHv9Pk/KQCfUw1A
0T8yyXP+39z4N1ho6QENtTU=
=WhV7
-----END PGP SIGNATURE-----

--Boundary-02=_e1as+BGWDBV1125--

