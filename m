Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbUKSWao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbUKSWao (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUKSW3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 17:29:12 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:28303 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261628AbUKSW2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 17:28:23 -0500
Date: Fri, 19 Nov 2004 15:28:13 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: tridge@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: performance of filesystem xattrs with Samba4
Message-ID: <20041119222812.GP1974@schnapps.adilger.int>
Mail-Followup-To: tridge@samba.org, linux-kernel@vger.kernel.org
References: <1098383538.987.359.camel@new.localdomain> <16797.41728.984065.479474@samba.org> <20041119101600.GM1974@schnapps.adilger.int> <16797.56428.329257.785330@samba.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TnYVF1hk1c8rpHiF"
Content-Disposition: inline
In-Reply-To: <16797.56428.329257.785330@samba.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TnYVF1hk1c8rpHiF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 19, 2004  22:43 +1100, tridge@samba.org wrote:
>  > This patch also provides the infrastructure on disk for storing e.g.
>  > nsecond and create timestamps in the ext3 large inodes, but the actual
>  > implementation to save/load these isn't there yet.  If that were
>  > available, would you use it instead of explicitly storing the NTTIME in
>  > an EA?
>=20
> certainly!=20

I can describe the "infrastructure" here, but there needs to be some
smallish coding work in order to get this working and I don't really
have much time to do that myself.  The basic premise is that for ext3
filesystems formatted with large on-disk inodes we have reserved the first
word in the extra space to describe the "extra size" of the fixed fields
in struct ext3_inode stored in each inode on disk.  This allows us to
add permanent fields to the end of struct ext3_inode, and any remaining
space is used for the fast EAs before falling back to an external block.

This space was always intended to store extra timestamp fields ala:

struct ext3_inode {
	:
	:
	} osd2;
	__u16	i_extra_isize;
	__u16	i_pad1;
	__u32	i_ctime_hilow;	/* do we need nsecond atimes? */
	__u32	i_mtime_hilow;
	__u32	i_crtime;
	__u32	i_crtime_hilow;
};

Since the i_[mac]time fields are in seconds, I would like to store:

_hilow =3D nseconds >> 6 | (([mac]time64 >> 32) << 26)

[mac]time64 =3D [mac]time | (__u64)((_hilow & 0xfc000000) << 6);
nseconds =3D _hilow << 6;

so we get about 60ns resolution but also increase our dynamic range
by a factor of 64 (year 8704 problem here we come ;-).  Since crtime
is new we _could_ store it in the 100ns 64-bit format that NT uses.
Consistency is good on the one hand and we only need to do shift and OR,
while with straight 100ns times we also get a 6x larger dynamic range
(y58000) but also have to do a 64-bit divide by 10^7 for each access.


As we read an inode from disk we check i_extra_isize to determine
which fields, if any, are valid and when writing the inode we fill in
the fields and update i_extra_isize (taking care to push any existing
EAs out a bit, though that should be a rare case).  This avoids the EA
speed/size overhead to parse/read/write these fields, and allows us to
add new "fixed" fields into the large inode as necessary.

We don't touch any fields that we don't understand (normal ext3 compat
flags will tell us if there are incompatible features there).


So, in summary, the "i_extra_isize" handling is already there for inodes
(currently always set to '4') but we don't do anything with that space
yet.

>  - store create_time and change_time in the user.DosAttrib xattr, as
>    64 bit 100ns resolution times (same format as NT uses and Samba
>    uses internally). I store change_time there as its definition is a
>    little different from the posix ctime field (plus its settable).
>=20
> If we had a settable create_time field in the inode then I'd certainly
> want to use it in Samba4. A non-settable one wouldn't be nearly as
> useful. Some win32 applications care about being able to set all the
> time fields (such as excel 2003).

Hmm, seems kind of counter-productive to allow a crtime that is settable...

> I think it would make more sense to have a new varient of utime() for
> setting all available timestamps, and expose all timestamps in stat. A
> separate API for create time seems a bit hackish.

By all means go for it ;-).  I'm not particularly fond of the proposed
pseudo-EA interface.  You are probably more likely than anyone to get
support for it.

>  > I would just configure out the xattr sharing code entirely since it wi=
ll
>  > likely do nothing but increase overhead if any of the EAs on an inode
>  > are unique (this is the most common case, except for POSIX-ACL-only se=
tups).
>=20
> I didn't know it was configurable. I can't see any CONFIG option for
> it - is there some trick I've missed?

It's CONFIG_FS_MBCACHE and/or CONFIG_EXT[23]_FS_XATTR_SHARING in the
original 2.4 xattr patches, not sure if they've disappeared in 2.6 kernels.

Hmm, seems that the CONFIG_FS_MBCACHE option doesn't allow you to turn it
off completely, which is a shame since both are completely useless for any
EAs which are different for each inode and just introduce overhead.  The
CONFIG_EXT[23]_FS_XATTR_SHARING options don't exist at all anymore.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--TnYVF1hk1c8rpHiF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBnnN8pIg59Q01vtYRAgIeAJ9QJkREF82ZCUbNbHXGjUnbar385QCfU05r
5fATQivfAIQ6Y4DBnm4neUQ=
=dGWd
-----END PGP SIGNATURE-----

--TnYVF1hk1c8rpHiF--
