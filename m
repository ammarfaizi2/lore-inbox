Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbUKUJvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbUKUJvm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 04:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbUKUJvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 04:51:42 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:13024 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S261339AbUKUJvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 04:51:20 -0500
Date: Sun, 21 Nov 2004 10:50:38 +0100
From: Jan Hudec <bulb@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: pavel@ucw.cz, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-ID: <20041121095038.GV2870@vagabond>
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu> <20041117190055.GC6952@openzaurus.ucw.cz> <E1CUVkG-0005sV-00@dorka.pomaz.szeredi.hu> <20041117204424.GC11439@elf.ucw.cz> <E1CUhTd-0006c8-00@dorka.pomaz.szeredi.hu> <20041118144634.GA7922@openzaurus.ucw.cz> <E1CVmN5-0007qq-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vy3x0i7GCC7mAH4A"
Content-Disposition: inline
In-Reply-To: <E1CVmN5-0007qq-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vy3x0i7GCC7mAH4A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 21, 2004 at 08:42:55 +0100, Miklos Szeredi wrote:
>=20
> > Ok, this one works, I agree... But it will be way slower than coda's
> > file-backed approach, right?
>=20
> No.  In both cases there will be two memory copies:
>=20
>   - from userspace fs to pagecache
>   - from pagecache to read buffer
>=20
> And vica versa for write.  FUSE will have some overhead of context
> switches, but in the optimal case (sequential read), the readahead
> code will bundle read requests, and with a 128MByte read, the cost of
> a context switch is probably infinitesimal.

But you won't bundle the *write* requests. And that's what will be
painfuly slow.

Now the file-backed approach is the only that will work for writes
without swapper deadlock.

> > > In the second case there is no deadlock, because the memory subsystem
> > > doesn't wait for data to be written.  If the filesystem refuses to
> > > write back data in a timely manner, memory will get full and OOM
> > > killer will go to work.  Deadlock simply cannot happen.
> >=20
> > Hmmm, so if userspace part is swapped out and data is dirtied
> > "too quickly", OOM is practically guaranteed? That is not nice.
>=20
> Yeah.  I imagined, that the kernel won't assign all it's free pages to
> file mappings, but people on the list enlightened me to the contrary.
>=20
> There seem to be two kinds of solutions:
>=20
>   1) make the userspace part aware of the memory allocation problems
>=20
>   2) limit the number of pages that can be dirtied

    3) Use a real disk file to back the page cache. Exactly like coda
       does it.

> I don't really like 1) because that really kills the point of
> implementing the filesystem in userspace.
>=20
> So I would go along the lines of 2).  However there is no way to know
> when pages are dirtied (ther is no fault), so accounting the dirty
> pages exactly is not possible.  However accounting the _writable_
> pages should be possible with no overhead, since there is a fault when
> the page of a mapping is first touched.
>=20
> Limiting these pages for FUSE, would mean that the user could do
> writable mmap, but with the performance penaly of having a limited
> number of pages present in memory.  If the userspace FS refuses to
> write back data, the filesystem user will be blocked until the
> writeback is completed.  No deadlock (hopefully).

I would not be so sure about this. The deadlock is caused by the fact
that such pages may exist, not by their number. Limiting the number will
only decrease the probability the deadlock will happen, but won't make
it go away.

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--vy3x0i7GCC7mAH4A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBoGTuRel1vVwhjGURApGjAJ47zIi6DKLrZJBCwVRsWeFE86PWOQCfePV6
9JTWqIx+1/QDpv/X8jt2qRk=
=eMqF
-----END PGP SIGNATURE-----

--vy3x0i7GCC7mAH4A--
