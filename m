Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWBLSog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWBLSog (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 13:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWBLSog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 13:44:36 -0500
Received: from master.altlinux.org ([62.118.250.235]:63241 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1750812AbWBLSog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 13:44:36 -0500
Date: Sun, 12 Feb 2006 21:44:19 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Bernd Schubert <bernd-schubert@gmx.de>
Cc: Chris Wright <chrisw@sous-sol.org>, John M Flinchbaugh <john@hjsoft.com>,
       reiserfs-list@namesys.com, Sam Vilain <sam@vilain.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15 Bug? New security model?
Message-ID: <20060212184419.GA8544@procyon.home>
References: <200602080212.27896.bernd-schubert@gmx.de> <20060208221124.GN30803@sorel.sous-sol.org> <20060212005541.107f7011.vsu@altlinux.ru> <200602120050.31345.bernd-schubert@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <200602120050.31345.bernd-schubert@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 12, 2006 at 12:50:30AM +0100, Bernd Schubert wrote:
> Privet!
>=20
> > > > Yes, 2.6.13 now makes the same trouble. No difference with 2.6.15.3.
> > > > I played with mount -o noattrs, this makes no difference with 2.6.1=
3,
> > > > but has some effects to 2.6.15.3. Creating files in /var/run is
> > > > possible again, lsattr gives "lsattr: Inappropriate ioctl for device
> > > > While reading flags on /var/run", but deleting files in /var/run is
> > > > still impossible (still rather bad for the init-scripts).
> >
> > Is the filesystem in question old - could it be created initially in the
> > reiserfs v3.5 format (used with 2.2.x kernels) and later converted to
> > v3.6 (by mounting with the "conv" option)?
>=20
> Well, I'm rather sure I created this filesystem in May 2001 after the Win=
2000=20
> partion manager selectively deleted all my ext2 partitions (I'm still ver=
y=20
> angry about MS). However, that time I already knew that v3.5 should not b=
e=20
> used with NFS and I always used NFS a lot(my first mail to the reiser lis=
t=20
> was in early 2001 about a reiser v3.5 + nfs problem). I also used=20
> Slackware-8.0-pre that time and also just checked it, the mkreiserfs from=
=20
> slackware-8.0 has v3.6 as default. So really, its very unlikely that my=
=20
> current root partition ever had v3.5 on it.

Still there is a chance (who knows what has been in 8.0-pre at that
time... and changelog says that reiserfsprogs was updated on May 14
2001).

> > > Yes, that's what I thought.  There's still some backward logic in the=
re.
> > > noattrs vs. attrs triggers whether the code path that's patched in
> > > 2.6.15.3 is taken.  I'll dig a bit more, but hopefully the reiserfs f=
olks
> > > can fix this for us.
> >
> > Here is a simple test case which reproduces the problem with a
> > filesystem converted from v3.5:
> >
> > # dd if=3D/dev/zero of=3Dtmp.img bs=3D1M count=3D100
> > # mkreiserfs --format 3.5 -f tmp.img

Add here:

# mount -t reiserfs -o loop tmp.img /mnt/disk
# tar -xz -f something.tar.gz -C /mnt/disk
# umount /mnt/disk

Otherwise the test seems to be unreliable.

> > # mount -t reiserfs -o loop,conv tmp.img /mnt/disk/
> > # umount /mnt/disk/
> > # reiserfsck --clean-attributes tmp.img
> > # mount -t reiserfs -o loop tmp.img /mnt/disk/
> >
> > At this point, I get obviously wrong attributes on /mnt/disk:
> >
> > # lsattr -d /mnt/disk/
> > -----a--c---- /mnt/disk/

Sometimes the root directory seems to have correct attrs, but some
files should still get garbage.

> I already reverted the patch in 2.6.15.2 for some NFSv4 tests with 2.6.15=
, but=20
> of course, this is not the final solution. Neither for me, nor for the ot=
her=20
> thousands of reiserfs filesystems out there, that suddenly break beginnin=
g=20
> with 2.6.15.2.

Of course - therefore Jeff Mahoney already prepared the patch to
remove the problematic feature (automatic enabling of the "attrs"
mount option) completely:

http://lkml.org/lkml/2006/2/12/76

(Backing out only the latest patch is wrong, because then the "tails"
option will remain broken.)

However, the real bug is somewhere else.

> > I have noticed that fs/reiserfs/inode.c:init_inode() does not initialize
> > REISERFS_I(inode)->i_attrs and inode->i_flags (as done by
> > sd_attrs_to_i_attrs()) in the branch for v1 stat data; maybe this causes
> > the problem?
>=20
> Please forgive me my missing knowledge about the internals of reiserfs,=
=20
> reiserfs doesn't have an inode for each file and directory as ext2, right?
> Is there some way to detect if the inode was created on reiser3.5?

You may try to do something like "chgrp 70000" on it - the v1 stat
data format has 16-bit uid/gid fields and therefore does not support
uid/gid greater than 65535.  If "chgrp 70000" fails with "Invalid
argument", but works with a value lower than 65535, most likely the
file in question still has old stat data format.  (If both operations
fail, this may be due to broken attrs on the file which prohibit the
operation).

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD74IDW82GfkQfsqIRAlypAJ9p0f2y6p9dqN//uZaNM+P1hWmxfgCeMo2K
TKb9agIZ9nm9KUpQQb+PgMw=
=M7OX
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
