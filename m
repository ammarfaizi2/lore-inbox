Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132425AbRDUBqj>; Fri, 20 Apr 2001 21:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132426AbRDUBq3>; Fri, 20 Apr 2001 21:46:29 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:29190
	"HELO gw.goop.org") by vger.kernel.org with SMTP id <S132425AbRDUBqR>;
	Fri, 20 Apr 2001 21:46:17 -0400
Date: Fri, 20 Apr 2001 18:46:14 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>, autofs@linux.kernel.org
Subject: Re: Fix for SMP deadlock in autofs4
Message-ID: <20010420184613.B12962@goop.org>
Mail-Followup-To: Jeremy Fitzhardinge <jeremy@goop.org>,
	Alexander Viro <viro@math.psu.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	autofs@linux.kernel.org
In-Reply-To: <Pine.LNX.4.31.0104201158290.5632-100000@penguin.transmeta.com> <Pine.GSO.4.21.0104201516480.21455-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0104201516480.21455-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Apr 20, 2001 at 03:53:45PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2001 at 03:53:45PM -0400, Alexander Viro wrote:
> > Why are we doing the mntget/dget at all? We hold the spinlock, so we kn=
ow
> > they are not going away. Not doing the mntget/dget means that we (a) run
> > faster and (b) don't have the bug, because we don't need to put the damn
> > things.
> >=20
> > Comments?
>=20
> It looks like you are right, but I wonder how the hell did that code
> happen at all. Looks like somewhere around 2.4.0-test10-pre* dcache_lock
> was moved out of is_tree_busy() and covered dget/dput. Hmm... Might be
> my fault - I don't remember doing that, but...

I did it.  I couldn't see a point in continiously taking and releasing
the dcache lock, since it just increased complexity and expire is not
a performance-critical path (ie, it happens rarely).

I kept the dget/put out caution and ignorance, but they're clearly
problematic.  I'm happy to drop them if holding dcache_lock is enough
to keep the tree stable while I traverse it.

> Removing that will require an obvious change in is_tree_busy() (shift
> count by 1). However, the real question is WTF are we trying to=20
> get in autofs4_expire() - it returns dentry without grabbing a
> reference to it. The only thing that saves us is that we have a
> ramfs-style situation (dentries are pinned until we rmdir) and
> everything up to the point where we silently forget about dentry
> is covered by BKL. Since ->rmdir() is under BKL too it's enough,
> but... Eww...=20

The dentry it returns is always an autofs4 dentry, and autofs4 always
keeps a refcount on its dentries like ramfs (because like ramfs,
autofs4 exists only in the dcache).

> Jeremy, what are you really trying to do there? is_tree_busy()
> seems to be written in assumption that mnt/dentry is not a
> mountpoint but root of a subtree with something mounted on its
> leaves. And autofs4_expire() traverses the list of root's
> subdirectories, picks one that has nothing busy mounted in
> _its_ subdirectories and essentially pass the name to caller.
> Which sends that name (of first-level subdirectory) to
> userland.

Exactly right.

> Is that what you really want there? It looks very odd - why don't we pass
> the names of actual mountpoints? What's wrong with the case when foo/bar
> is busy, but foo/baz is not?

Say for example you have an autofs4 filesystem mounted on /net.  When you
do a "cd /net/host", all of host's exported NFS filesystems are mounted
on the directory /net/host; obviously the mountpoint /net/host is an
autofs4 directory.

autofs4_expire traverses the directories in its root and finds the ones
which are currently unused and have been idle for some time.  Since all
the filesystems mounted under /net/host are part of the same logical
tree, it examines them as a single unit so they can be umounted as a
single unit.

Note that /net/host may not itself be a mountpoint.  If host doesn't
export / but only, say, /home and /usr/local, then there'll be a tree of
skeleton directories in the autofs4 filesystem to create the paths
up to the mountpoints (so there'll be /net/host/{home,usr/local}).
But because everything under /net/host is treated as a single unit, it's
only correct for autofs4_expire to return /net/host, not /net/host/home
or /net/host/usr/local.

The simplifying assumption I make is that there's a single root directory
with a number of sub-directories; each subdirectory is treated as
a single unit.  They general case would be to mark some directories
as being the root of an atomic set, and other directories simply being
structural, but the need has never come up (and it can be worked around by
having nested autofs filesystems).

	J

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjrg5mUACgkQf6p1nWJ6IgKAIgCfWgdbpaEW5Era6ZKocW8aJmwG
fZ0An1Pimfestkd7tupJ0S1uuBRfhKQX
=R9rC
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
