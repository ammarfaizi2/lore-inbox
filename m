Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289728AbSAJWS7>; Thu, 10 Jan 2002 17:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289736AbSAJWSu>; Thu, 10 Jan 2002 17:18:50 -0500
Received: from h24-71-138-152.ss.shawcable.net ([24.71.138.152]:63992 "HELO
	lorien.untroubled.org") by vger.kernel.org with SMTP
	id <S289728AbSAJWSa>; Thu, 10 Jan 2002 17:18:30 -0500
Date: Thu, 10 Jan 2002 16:18:49 -0600
From: Bruce Guenter <bruceg@em.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: Where's all my memory going?
Message-ID: <20020110161849.M1577@em.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E16OMpF-0001pj-00@the-village.bc.nu> <Pine.LNX.4.33L.0201092034590.2985-100000@imladris.surriel.com> <20020110024520.A29045@em.ca> <20020110030537.C771@lynx.adilger.int>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-rmd160;
	protocol="application/pgp-signature"; boundary="q6mBvMCt6oafMx9a"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020110030537.C771@lynx.adilger.int>; from adilger@turbolabs.com on Thu, Jan 10, 2002 at 03:05:38AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--q6mBvMCt6oafMx9a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2002 at 03:05:38AM -0700, Andreas Dilger wrote:
> On Jan 10, 2002  02:45 -0600, Bruce Guenter wrote:
> > On Wed, Jan 09, 2002 at 08:36:13PM -0200, Rik van Riel wrote:
> > > Matt's system seems to go from 900 MB free to about
> > > 300 MB (free + cache).
> > >=20
> > > I doubt qmail would eat 600 MB of RAM (it might, I
> > > just doubt it) so I'm curious where the RAM is going.
> >=20
> > I am seeing the same symptoms, with similar use -- ext3 filesystems
> > running qmail.
>=20
> Hmm, does qmail put each piece of email is in a separate file?  That
> might explain a lot about what is going on here.

There are actually three to five individual files used as part of the
equation.  qmail stores each message as three our four individual files
while it is in the queue (which for local deliveries is very briefly).
In addition, each delivered message is saved as an individual file,
until the client picks it up (and deletes it) with POP.

> Well, these numbers _are_ high, but with 1GB of RAM you have to use it all
> _somewhere_.

Agreed.  Free RAM is wasted RAM.  However, when adding up the numbers
buffers+cache+RSS+slab,  the totals I am reading account for roughly
half of the used RAM:
	RSS	 84MB (including shared pages counted multiple times)
	slabs	 82MB
	buffers	154MB
	cache	152MB
	-------------
	total	477MB
However, free reports 895MB as used.  What am I missing?

> I'm thinking that if you get _lots_ of dentry and inode items (especially
> under the "postal" benchmark) you may not be able to free the negative
> dentries for all of the created/deleted files in the mailspool (all of
> which will have unique names).  There is a deadlock path in the VM that
> has to be avoided, and as a result it makes it harder to free dentries
> under certain uncommon loads.

The names in the queue are actually reused fairly frequently.  qmail
creates an initial file named for the creating PID, and then renames it
to the inode number of the file.  These inode numbers are of course
recycled as are the filenames.

> The other question would of course be whether we are calling into
> shrink_dcache_memory() enough, but that is an issue for Matt to
> see by testing "postal" with and without the patch, and keeping an
> eye on the slab caches.

I'd love to test this as well, but this is a production server.  I'll
see if I can put one of my home systems to the task.
--=20
Bruce Guenter <bruceg@em.ca> http://em.ca/~bruceg/ http://untroubled.org/
OpenPGP key: 699980E8 / D0B7 C8DD 365D A395 29DA  2E2A E96F B2DC 6999 80E8

--q6mBvMCt6oafMx9a
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8PhNJ6W+y3GmZgOgRAvuaAJ9kQXxLyJ1hdJGCLI/z9/jhNfybZwCeIpos
nBI4lylL1qNJF1ARXnDRi0E=
=w9Qh
-----END PGP SIGNATURE-----

--q6mBvMCt6oafMx9a--
