Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVD0Jeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVD0Jeq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 05:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVD0Jeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 05:34:46 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:33717 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S261308AbVD0Jed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 05:34:33 -0400
Date: Wed, 27 Apr 2005 11:34:12 +0200
From: Jan Hudec <bulb@ucw.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: John Stoffel <john@stoffel.org>,
       "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>, Ville Herva <v@iki.fi>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: filesystem transactions API
Message-ID: <20050427093412.GB1904@vagabond>
References: <20050426134629.GU16169@viasys.com> <20050426141426.GC10833@mail.shareable.org> <426E4EBD.6070104@oktetlabs.ru> <20050426143247.GF10833@mail.shareable.org> <17006.22498.394169.98413@smtp.charter.net> <20050426152434.GB14297@mail.shareable.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <20050426152434.GB14297@mail.shareable.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 26, 2005 at 16:24:34 +0100, Jamie Lokier wrote:
> John Stoffel wrote:
> > >>>>> "Jamie" =3D=3D Jamie Lokier <jamie@shareable.org> writes:
> >=20
> > Jamie> No.  A transaction means that _all_ processes will see the
> > Jamie> whole transaction or not.
> >=20
> > This is really hard.  How do you handle the case where process X
> > starts a transaction modifies files a, b & c, but process Y has file b
> > open for writing, and never lets it go?  Or the file gets unlinked? =20
>=20
> Then it starts to depend on what kind of transactions you want to
> implement.
>=20
> You can say that a transaction isn't allowed when a process has one of
> the files opened for writing.  Or you can say a transaction is
> equivalent to calling all of the I/O system calls at once.  You can
> also decide if you want the reads and directory lookups performed in
> the transactions to become prerequisites for the transaction
> completing (so it's aborted if another process writes to those file
> regions or changes the directory structure in a way which breaks a
> prerequisite), or if you want those to lock the things which are read
> for the duration of the transaction, or even just ignore reads for
> transaction purposes.  Or, you can say that transactions are limited
> to just directory structure, and not file contents (that's good enough
> for package management), or you can say they're limited to just file
> contents (that's good enough for databases and text file edits).
>=20
> Etc, etc, quite a lot of semantic choices.

How do we specify which calls belong to a transaction? By some kind of
extra file handle?

I'd think having global per-process transaction is not the best way.
So I think we should have some kind of transaction handle (probably in
the file handle space) and a way to say that a syscall is done within
a transaction. To avoid duplicating all syscalls, we could have
set_active_transaction() operation.

Now I think the criteria for semantics should be serializability. That
would mean, that lookup paths would have to be locked IFF the lookup was
done within the transaction -- but you would be free to open a file
without transaction, then set_active_transaction and write that file.
That way the write would become atomic, but someone else could freely
rename the file from under you.

Note: Editors currently write to a temporary file and rename over the
original (if they have permissions to do it), which is as good
transaction as they need.

> > What about programs that are already open and running? =20
> >=20
> > It might be doable in some sense, but I can see that details are
> > really hard to get right.  Esp without breaking existing Unix
> > semantics. =20
>=20
> It's even harder without kernel support! :)

If every syscall (touching filesystem) was turned into a transaction of
it's own, it wouldn't break any semantics.

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCb1yURel1vVwhjGURAiuiAKCQdRJciPFUIzzFFEeqfbYCHwdP5ACglWd9
NxZZO77UfbIp2rJb7jMmS3w=
=OsxQ
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
