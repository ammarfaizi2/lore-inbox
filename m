Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317302AbSIASua>; Sun, 1 Sep 2002 14:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317308AbSIASua>; Sun, 1 Sep 2002 14:50:30 -0400
Received: from ppp-217-133-221-133.dialup.tiscali.it ([217.133.221.133]:24795
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S317302AbSIASuZ>; Sun, 1 Sep 2002 14:50:25 -0400
Subject: Re: [PATCH] Initial support for struct vfs_cred   [0/1]
From: Luca Barbieri <ldb@ldb.ods.org>
To: trond.myklebust@fys.uio.no
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <15730.17171.162970.367575@charged.uio.no>
References: <Pine.LNX.4.44.0208311235110.1255-100000@home.transmeta.com>
	<1030822731.1458.127.camel@ldb> <15729.17279.474307.914587@charged.uio.no>
	<1030835635.1422.39.camel@ldb> <15730.4100.308481.326297@charged.uio.no>
	<15730.8121.554630.859558@charged.uio.no> <1030890022.2145.52.camel@ldb> 
	<15730.17171.162970.367575@charged.uio.no>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-+I9rrTVIIcSdZDCIJz8k"
X-Mailer: Ximian Evolution 1.0.5 
Date: 01 Sep 2002 20:54:48 +0200
Message-Id: <1030906488.2145.104.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+I9rrTVIIcSdZDCIJz8k
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2002-09-01 at 18:40, Trond Myklebust wrote:
> >>>>> " " == Luca Barbieri <ldb@ldb.ods.org> writes:
> 
>     >> You are forgetting that the fscred might simultaneously be
>     >> referenced by an open struct file. Are you saying that this
>     >> file should suddenly see its credential change?
>      > No, it cannot be referenced by an open struct file because you
>      > copy the structure, not pointers to it.
> 
> So you are proposing to optimize for the rare case of setuid(),
> instead of the more common case of file open()?
No, this does not optimize for a setuid. It allows to easily make
temporary modifications to the credentials but that's not the main
focus.
Permanent modifications, if credentials are shared, would need to walk
the shared-cred tasklist and set the propagation flag on all tasks on it
so I'm surely not proposing to optimize for them.

And, in the common case of open, why do you need to copy the structure
to check permissions?
I think that open should just check the current values.
open might want to copy credentials in case you want to do the inode
lookup asynchronously but then it doesn't make sense to optimize for
this since you already have the huge disk read penalty.
BTW, the 2.5.32 open does the check in vfs_permission without copying
anything.
Anyway it's just a 3 long copy plus an atomic inc vs. 1 long copy and
atomic inc.
And if you don't need the groups array, it's just a 2 longs copy that on
some architectures with very slow atomic operations (e.g. sparc) is much
better.


--=-+I9rrTVIIcSdZDCIJz8k
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9cmJ4djkty3ft5+cRAh3RAJ40JWqAh7LpSwGqBiuFaYFu00i34QCgpOm9
RxLcqgV7Ve1iIIGsRpTnD0w=
=QAiO
-----END PGP SIGNATURE-----

--=-+I9rrTVIIcSdZDCIJz8k--
