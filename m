Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317066AbSIAOQE>; Sun, 1 Sep 2002 10:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315988AbSIAOQE>; Sun, 1 Sep 2002 10:16:04 -0400
Received: from ppp-217-133-221-133.dialup.tiscali.it ([217.133.221.133]:50396
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S317066AbSIAOQB>; Sun, 1 Sep 2002 10:16:01 -0400
Subject: Re: [PATCH] Initial support for struct vfs_cred   [0/1]
From: Luca Barbieri <ldb@ldb.ods.org>
To: trond.myklebust@fys.uio.no
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <15730.8121.554630.859558@charged.uio.no>
References: <Pine.LNX.4.44.0208311235110.1255-100000@home.transmeta.com>
	<1030822731.1458.127.camel@ldb> <15729.17279.474307.914587@charged.uio.no>
	<1030835635.1422.39.camel@ldb> <15730.4100.308481.326297@charged.uio.no> 
	<15730.8121.554630.859558@charged.uio.no>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-+17/mH7ksi44rCBfTZjx"
X-Mailer: Ximian Evolution 1.0.5 
Date: 01 Sep 2002 16:20:22 +0200
Message-Id: <1030890022.2145.52.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+17/mH7ksi44rCBfTZjx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2002-09-01 at 16:10, Trond Myklebust wrote:
> >>>>> " " == Trond Myklebust <trond.myklebust@fys.uio.no> writes:
> 
> >>>>> " " == Luca Barbieri <ldb@ldb.ods.org> writes:
>     >> For example, rather than this;
>      > <snip>
> 
>     >> you can just do this:
>     >> - uid_t saved_fsuid = current->fsuid;
>     >> + uid_t saved_fsuid = current->fscred.uid;
>     >> kernel_cap_t saved_cap =
>     current-> cap_effective;
>  
>      > But I don't want to have to do that at all. Why should I change
> 
> Just to follow up on why the above 'optimization' is just plain wrong.
> 
> You are forgetting that the fscred might simultaneously be referenced
> by an open struct file. Are you saying that this file should suddenly
> see its credential change?
No, it cannot be referenced by an open struct file because you copy the
structure, not pointers to it.

> The alternative without copy on write is to make a full copy of the
> fscred every time we open a file or schedule some form of asynchronous
> I/O, and hence need to cache the current VFS credentials.
Yes.
Note however that the structure is like this:
struct vfs_cred
{
	uid_t uid, gid;
	vfs_cred_groups* groups;
}

vfs_cred_copy(struct vfs_cred* dest, struct vfs_cred* src)
{
	dest->uid = src->uid;
	dest->gid = src->gid;
	dest->groups = src->groups;
	atomic_inc(&src->groups->count);
}

Of course if you don't need groups you can avoid copying them.
This is efficient if you usually either check the uid and gid or copy
only them (omitting groups).
If instead copying the whole structure is more frequent than the
operations described above, then use reference counting and
copy-on-write for the whole structure, but I don't think that this is
the case.


--=-+17/mH7ksi44rCBfTZjx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9ciImdjkty3ft5+cRAh4yAKDEDoif5Cx58N91NSAxWsm9TK69OACgxRIE
eZ7avc48iS1eLZ2dAaCM+x0=
=rAvY
-----END PGP SIGNATURE-----

--=-+17/mH7ksi44rCBfTZjx--
