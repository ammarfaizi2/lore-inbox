Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318151AbSIAWqI>; Sun, 1 Sep 2002 18:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318153AbSIAWqH>; Sun, 1 Sep 2002 18:46:07 -0400
Received: from ppp-217-133-221-133.dialup.tiscali.it ([217.133.221.133]:48011
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S318151AbSIAWqF>; Sun, 1 Sep 2002 18:46:05 -0400
Subject: Re: [PATCH] Initial support for struct vfs_cred   [0/1]
From: Luca Barbieri <ldb@ldb.ods.org>
To: trond.myklebust@fys.uio.no
Cc: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <15730.36080.987645.452664@charged.uio.no>
References: <Pine.LNX.4.44.0208311235110.1255-100000@home.transmeta.com>
	<1030822731.1458.127.camel@ldb> <15729.17279.474307.914587@charged.uio.no>
	<1030835635.1422.39.camel@ldb> <15730.4100.308481.326297@charged.uio.no>
	<15730.8121.554630.859558@charged.uio.no> <1030890022.2145.52.camel@ldb>
	<15730.17171.162970.367575@charged.uio.no> <1030906488.2145.104.camel@ldb>
	<15730.27952.29723.552617@charged.uio.no> <1030916061.2145.344.camel@ldb> 
	<15730.36080.987645.452664@charged.uio.no>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-6OrVR8aSX6sj61S2/m5W"
X-Mailer: Ximian Evolution 1.0.5 
Date: 02 Sep 2002 00:50:30 +0200
Message-Id: <1030920630.1993.420.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6OrVR8aSX6sj61S2/m5W
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2002-09-01 at 23:56, Trond Myklebust wrote:
> >>>>> " " == Luca Barbieri <ldb@ldb.ods.org> writes:
> 
>     >> Because, as has been explained to you, we have things like
>     >> Coda, Intermezzo, NFS, for which this is insufficient.
>      > If they only need them at open, and the open is synchronous,
>      > you don't need to copy them.
> 
> Bullshit. You clearly haven't got a clue what you are talking about.
> For all these 3 systems credentials need to be cached from file open
> to file close.
> 
>   YES EVEN NOW, WITH NO CLONE_CRED AND WITH SYNCHRONOUS OPEN !!!!
> 
> On something like NFS or Coda, the server needs to receive
> authentication information for each and every RPC call we send to
> it. There's no state. The server does not know that we have opened a
> file.
But then in the _open_ syscall you don't need to send them from a copy.
However, since you need them in the later syscalls, you need to copy
them to the file structure for the later syscalls in open, but you don't
need to use copied credentials for the operation of opening a file
(assuming it's done synchronously within sys_open).
Anyway this is only relevant to decide whether to always copy uid and
gid or to use copy-write on them and access them with an extra memory
read (to read the pointer to the copy-on-write structure), which is not
the main issue.

BTW, imho a correctly designed network filesystem should have a single
stateful encrypted connection (or a pool of equally authenticated ones)
and credentials (i.e. passwords) should only be passed when the user
makes the first filesystem access. After that the server should do
authentication with the OR of all credentials received and the client
kernel should further decide whether it can give access to a particular
user.
This is off-topic here, though.

> Currently this is done by the NFS client hiding information in the
> file's private_data field. This means that other people that want to
> do write-through-caching etc are in trouble 'cos they have to cope
> with the fact that NFS has its private field, Coda has its private
> field,... And they are all doing the same thing in different ways.
Yes, I agree with the need to provide copy-on-write.
I just disagree with the idea that code should be written to handle
changing credentials and that credentials should be passed as parameters
and I suggest that always copying uid and gid might be better since
accessing uid and gid is more frequent and happens in faster paths than
copying credentials.


--=-6OrVR8aSX6sj61S2/m5W
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9cpm1djkty3ft5+cRApzSAKCM39+oQrCeC85u1VlCLnosdF/8RwCguqCA
iHn8tr7E16dTJXnKq3EU+PI=
=BQbz
-----END PGP SIGNATURE-----

--=-6OrVR8aSX6sj61S2/m5W--
