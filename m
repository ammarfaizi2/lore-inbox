Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262128AbVATMQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbVATMQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 07:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbVATMQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 07:16:28 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:64384 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S262128AbVATMQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 07:16:08 -0500
Date: Thu, 20 Jan 2005 05:16:06 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, Andrew Tridgell <tridge@osdl.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Alex Tomas <alex@clusterfs.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 5/5] Disallow in-inode attributes for reserved inodes
Message-ID: <20050120121606.GF22715@schnapps.adilger.int>
Mail-Followup-To: Andreas Gruenbacher <agruen@suse.de>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Theodore Ts'o <tytso@mit.edu>, Andrew Tridgell <tridge@osdl.org>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Alex Tomas <alex@clusterfs.com>, linux-kernel@vger.kernel.org
References: <20050120020124.110155000@suse.de> <20050120032510.917200000@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+dH9khzwljbvYE07"
Content-Disposition: inline
In-Reply-To: <20050120032510.917200000@suse.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+dH9khzwljbvYE07
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 20, 2005  03:01 +0100, Andreas Gruenbacher wrote:
> When creating a filesystem with inodes bigger than 128 bytes, mke2fs
> fails to clear out bytes beyond EXT3_GOOD_OLD_INODE_SIZE in all inodes
> it creates (the journal, the filesystem root, and lost+found). We would
> require a zeroed-out i_extra_isize field but we don't get it, so
> disallow in-inode attributes for those inodes.
>=20
> Add an i_extra_isize sanity check.

I'm not sure I agree with this patch.  It definitely resolves a problem
I had with the previous patch (4/5), namely that for inodes that were
created in a large-inode filesystem using a kernel w/o the large-inode
patch we didn't save EAs into the large-inode space at all.  With this
patch we will start using that space.

It is debatable whether we should mark inodes bad if the i_extra_isize
field is bad, or if we should just initialize i_extra_isize in that case.
On one hand there is very little else we can use to validate the on-disk
inodes, but on the other hand the EA data isn't critical to reading the
inode so this would seem to introduce additional failure cases.

I'm not sure whether an old e2fsck will also clear out the space in a
large inode that it writes or not (I know that the patched one we use
validates i_extra_isize).  If it doesn't it may be that there would be a
largish number of inodes that are marked bad because of this, so having
the kernel fix this would be good.  If the old e2fsck zeroes the large
inodes properly it would be prudent to have an ext3_error() here so that
the disk corruption triggers an e2fsck the next time the system starts.

For the root and lost+found inodes it looks like we can never store an
EA in the extra part of the inode regardless of whether i_extra_isize is
good or not.  If a bad value is found we could just initialize it and
start using that space (though not print an ext3_error() in that case,
an ext3_warning() if anything since this is probably the fault of mke2fs).

> Index: linux-2.6.11-latest/fs/ext3/inode.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.11-latest.orig/fs/ext3/inode.c
> +++ linux-2.6.11-latest/fs/ext3/inode.c
> @@ -2493,15 +2493,30 @@ void ext3_read_inode(struct inode * inod
>  		ei->i_data[block] =3D raw_inode->i_block[block];
>  	INIT_LIST_HEAD(&ei->i_orphan);
> =20
> -	ei->i_extra_isize =3D
> -		(EXT3_INODE_SIZE(inode->i_sb) > EXT3_GOOD_OLD_INODE_SIZE) ?
> -		le16_to_cpu(raw_inode->i_extra_isize) : 0;
> -	if (ei->i_extra_isize) {
> -		__le32 *magic =3D (void *)raw_inode + EXT3_GOOD_OLD_INODE_SIZE +
> -				ei->i_extra_isize;
> -		if (le32_to_cpu(*magic))
> -			 ei->i_state |=3D EXT3_STATE_XATTR;
> -	}
> +	if (inode->i_ino >=3D EXT3_FIRST_INO(inode->i_sb) + 1 &&
> +	    EXT3_INODE_SIZE(inode->i_sb) > EXT3_GOOD_OLD_INODE_SIZE) {
> +		/*
> +		 * When mke2fs creates big inodes it does not zero out
> +		 * the unused bytes above EXT3_GOOD_OLD_INODE_SIZE,
> +		 * so ignore those first few inodes.
> +		 */
> +		ei->i_extra_isize =3D le16_to_cpu(raw_inode->i_extra_isize);
> +		if (EXT3_GOOD_OLD_INODE_SIZE + ei->i_extra_isize >
> +		    EXT3_INODE_SIZE(inode->i_sb))
> +			goto bad_inode;
> +		if (ei->i_extra_isize =3D=3D 0) {
> +			/* The extra space is currently unused. Use it. */
> +			ei->i_extra_isize =3D sizeof(struct ext3_inode) -
> +					    EXT3_GOOD_OLD_INODE_SIZE;
> +		} else {
> +			__le32 *magic =3D (void *)raw_inode +
> +					EXT3_GOOD_OLD_INODE_SIZE +
> +					ei->i_extra_isize;
> +			if (*magic =3D=3D cpu_to_le32(EXT3_XATTR_MAGIC))
> +				 ei->i_state |=3D EXT3_STATE_XATTR;
> +		}
> +	} else
> +		ei->i_extra_isize =3D 0;
> =20
>  	if (S_ISREG(inode->i_mode)) {
>  		inode->i_op =3D &ext3_file_inode_operations;

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--+dH9khzwljbvYE07
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFB76EGpIg59Q01vtYRAoPvAJwIuqncDZKo4LQK0p71Hn5/hbfXhQCgrGa9
+KOHWn7vy1rxJTTqWuVTTGw=
=x5fj
-----END PGP SIGNATURE-----

--+dH9khzwljbvYE07--
