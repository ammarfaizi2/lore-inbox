Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263016AbUKYHsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263016AbUKYHsu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 02:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbUKYHsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 02:48:47 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:57739 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S263008AbUKYHsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 02:48:33 -0500
Date: Thu, 25 Nov 2004 08:47:41 +0100
From: Jan Hudec <bulb@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: avi@argo.co.il, alan@lxorguk.ukuu.org.uk, torvalds@osdl.org,
       hbryan@us.ibm.com, akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-ID: <20041125074741.GC29278@vagabond>
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com> <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org> <1100798975.6018.26.camel@localhost.localdomain> <41A47B67.6070108@argo.co.il> <E1CWwqF-0007Ng-00@dorka.pomaz.szeredi.hu> <20041125062649.GB29278@vagabond> <E1CXE4k-0000Ow-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline
In-Reply-To: <E1CXE4k-0000Ow-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 25, 2004 at 08:29:58 +0100, Miklos Szeredi wrote:
>=20
> > > There are already "strange" filesystems in the kernel which cannot
> > > really get rid of dirty data.  I'm thinking of tmpfs and ramfs.
> > > Neither of them are prone to deadlock, though both of them are "worse
> > > off" than a userspace filesystem, in the sense that they have not even
> > > the remotest chance of getting rid of the dirty data.
> > >=20
> > > Of course, implementing this is probably not trivial.  But I don't see
> > > it as a theoretical problem as Linus does.=20
> > >=20
> > > Is there something which I'm missing here?
> >=20
> > But they KNOW that they won't be able to get rid of the dirty data. But
> > fuse does not.
>=20
> Why not?  I can set bdi->memory_backed to 1 just like ramfs, implement
> my own writeback thread, and voila, no deadlock.

Yes, you can. Just you have to take care never to occupy too much
memory.

> Of course I believe, that it's probably easier to tweak the page cache
> to teach it that fuse pages _can_ be written back, but not reliably
> like a disk filesystem.  And there's the small problem of limiting the
> number of writable pages allocated to FUSE.

It's not that easy. How do you tell when the page is no longer likely to
get cleaned?

The file backing would be easier, but to be really easy, the interface
would be a bit different (and actualy simpler, since it would need no
data channel, just a control one).

The trick is, that the coda file-granularity interface is not that hard
to extend to page-granularity. Several filesystems allow "files with
holes". So the fuse process could just touch a file and truncate it to
desired length on open. Then kernel would tell it which pages it wants
and the process would acknowledge when they are actualy filled. For
write, kernel would just notify the process of dirty ranges and what --
and when -- the process does with that is not kernel's business.

The legacy interface should still be easy to support in a library.

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBpY4dRel1vVwhjGURAm7IAJ9ImIvsozlxVxvqXej99FzlMHiXNACgtxpa
r6jY45GLbwORN2FHcfn8Q7E=
=PY1P
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
