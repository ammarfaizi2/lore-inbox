Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbVATXFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVATXFj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 18:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbVATXFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 18:05:39 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:45234 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S262209AbVATXFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 18:05:21 -0500
Date: Thu, 20 Jan 2005 16:05:18 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, Andrew Tridgell <tridge@osdl.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Alex Tomas <alex@clusterfs.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 5/5] Disallow in-inode attributes for reserved inodes
Message-ID: <20050120230518.GL22715@schnapps.adilger.int>
Mail-Followup-To: Andreas Gruenbacher <agruen@suse.de>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Theodore Ts'o <tytso@mit.edu>, Andrew Tridgell <tridge@osdl.org>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Alex Tomas <alex@clusterfs.com>, linux-kernel@vger.kernel.org
References: <20050120020124.110155000@suse.de> <20050120032510.917200000@suse.de> <20050120121606.GF22715@schnapps.adilger.int> <200501201429.15681.agruen@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ynll37MX3Fmyj3VY"
Content-Disposition: inline
In-Reply-To: <200501201429.15681.agruen@suse.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ynll37MX3Fmyj3VY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 20, 2005  14:29 +0100, Andreas Gruenbacher wrote:
> The ea-in-inode patch totally relies on getting all the available inode s=
pace=20
> cleared out by the kernel (or mke2fs, or e2fsck). If this is not the case=
 for=20
> any inode we find, then i_extra_isize may contain a random number, and we=
've=20
> just lost, period: There is no way of sanitizing a random i_extra_isize; =
we=20
> cannot know what the right number would be.

The large-inode support is designed to allow different amounts of
"fixed" optional data (i.e. what is stored inside i_extra_isize),
so it is valid to set this to 4 (i.e. just enough to hold i_extra_isize
itself) and store the EA data after that.  Any code which reads "fixed"
fields from a large inode (e.g. i_mtime_nsec) needs to validate that
i_extra_isize on that inode is large enough for that data to actually
be in the fixed area in the large inode.

If the kernel is setting i_extra_isize > 4 (i.e. it is storing optional
fields there like i_mtime_msb_and_ns) it should/is-able-to also initialize
those values since it should know what they are or they shouldn't be in
struct ext3_inode.

The whole point of i_extra_isize is that it is possible for inodes
to have different amounts of the optional fixed fields in each large
inode, depending on what the kernel that wrote the inode knew about.
So any value for i_extra_isize is valid as long as those fields
are initialized.  If we arbitrarily set i_extra_isize =3D 4 instead of
leaving the bad value this is no different than waiting for e2fsck to
do the same.

> > It is debatable whether we should mark inodes bad if the i_extra_isize
> > field is bad, or if we should just initialize i_extra_isize in that cas=
e.
>=20
> IMHO it's not debatable. Taking an i_extra_isize that looks odd and simpl=
y=20
> changing it to something we think is better is a really bad idea.
>=20
> You may have an access acl on the inode. Not being able to read an access=
 acl=20
> is a clear sign of trouble. The same applies for everything else in the=
=20
> system.* and security.* namespaces, at least.

Well, I said it was debatable and we're having a debate ;-).  I don't have
a strong opinion either way.  If we ext3_error() in this case at least we
will check the fs on the next boot (which will just zero i_extra_isize)
instead of never doing anything to resolve the situation.

> > For the root and lost+found inodes it looks like we can never store an
> > EA in the extra part of the inode regardless of whether i_extra_isize is
> > good or not.  If a bad value is found we could just initialize it and
> > start using that space (though not print an ext3_error() in that case,
> > an ext3_warning() if anything since this is probably the fault of mke2f=
s).
>=20
> I disagree. We cannot just use the space when we think the inode is corru=
pted.

But as your patch stands it doesn't ever check if i_extra_isize is valid
for the root or lost+found inode.  It just always sets i_extra_isize =3D 0
and never uses it.  Given that the root inode is fairly high-traffic it
makes sense to use the faster EA space if it is available.

If these inodes have a BAD i_extra_isize it is OK to skip it, but I'm
not so keen to have an ext3_error() there.  If the user doesn't have an
e2fsck with ea-in-inode support there isn't anything they can do to fix
it and they will get a full e2fsck on each boot.

Even so, for the effort of setting i_extra_isize =3D 4 (or larger if we
initialize the fixed fields) we can do the equivalent of what e2fsck will
do when it finds a bogus value.


The good news is that we can still apply your patch as-is and address my
concerns later since this is a transient issue.  Also, given that there
are probably only a handful of filesystems in the world using large inodes
(excluding Lustre filesystems which aren't affected by this) I don't think
it is a pressing issue yet.  I'm going to be away for 2 weeks, so I'll say
accept this patch as is and we can look at it again when I get back, and
maybe Ted and Stephen will have weighed in on this issue also.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--ynll37MX3Fmyj3VY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFB8DkupIg59Q01vtYRAs7MAKDDRMSHxQLCt0pxZSwqGH7dtHoJIQCg8QOn
6nRGkBQiCtIFtpB6QEnpPsg=
=fDu9
-----END PGP SIGNATURE-----

--ynll37MX3Fmyj3VY--
