Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262607AbVAPVDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbVAPVDn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 16:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbVAPVDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 16:03:42 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:37603 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S262605AbVAPVDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 16:03:32 -0500
Date: Sat, 15 Jan 2005 22:46:04 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alex Tomas <alex@clusterfs.com>, Andrew Tridgell <tridge@samba.org>
Subject: Re: [RFC] Ext3 nanosecond timestamps in big inodes
Message-ID: <20050116054604.GI22715@schnapps.adilger.int>
Mail-Followup-To: Andreas Gruenbacher <agruen@suse.de>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alex Tomas <alex@clusterfs.com>, Andrew Tridgell <tridge@samba.org>
References: <200501142216.12726.agruen@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NY6JkbSqL3W9mApi"
Content-Disposition: inline
In-Reply-To: <200501142216.12726.agruen@suse.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NY6JkbSqL3W9mApi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 14, 2005  22:16 +0100, Andreas Gruenbacher wrote:
> this is a spin-off of an old patch by Alex Tomas <alex@clusterfs.com>:
> Alex originally had nanosecond timestamps in his original patch; here is
> a rejuvenated version. Please tell me what you think. Alex also added a
> create timestamp in his original patch. Do we actually need that?

I think the create timestamp can't hurt things and might be useful in some
cases (e.g. CIFS could use this for exporting, and Lustre will also).  It
would also be useful for some disk "forensics" (term used loosely) unlike
the ctime.  I haven't ever been very keen on nsecond atimes, but it can't
kill us (atime is already flushed at most 1/sec I think).

> Nanoseconds consume 30 bits in the 32-bit fields. The remaining two bits=
=20
> currently are zeroed out implicitly. We could later use them remaining tw=
o=20
> bits for years beyond 2038.

My thought has always been to use, say, 24 bits for "nseconds>>6" and 8 bits
for "seconds<<32" or something close to this (a few bits either way) to give
us more range on the high end.  In the past we talked of usecond timestamps
(which would have only been 20 bits, leaving 12 bits for seconds msb),
but the kernel ended up using nseconds for the internal timestamps.

> @@ -2501,6 +2501,14 @@ void ext3_read_inode(struct inode * inod
> +		if (ei->i_extra_isize >=3D 2*sizeof(__le16) + 3*sizeof(__le32)) {
> +			inode->i_atime.tv_nsec =3D
> +				le32_to_cpu(raw_inode->i_atime_nsec);
> +			inode->i_ctime.tv_nsec =3D
> +				le32_to_cpu(raw_inode->i_ctime_nsec);
> +			inode->i_mtime.tv_nsec =3D
> +				le32_to_cpu(raw_inode->i_mtime_nsec);
> +		}

You may as well put a macro here to convert from the raw timestamp
(probably shouldn't just be called "nsec" if we are also encoding more
info there, maybe msb_and_ns?) so we can mask (and shift) as necessary.

> @@ -2638,8 +2646,17 @@ static int ext3_do_update_inode(handle_t
> -	if (EXT3_INODE_SIZE(inode->i_sb) > EXT3_GOOD_OLD_INODE_SIZE)
> +	if (ei->i_extra_isize) {

I don't think this is right.  This means we would only ever store nsec
timestamps if there was already other data in the large inode.  Since
writing that part of the inode is free (we will be writing a full sector
anyways), no reason not to save it.

>  		raw_inode->i_extra_isize =3D cpu_to_le16(ei->i_extra_isize);
> +		if (ei->i_extra_isize > 2*sizeof(__le16) + 3*sizeof(__le32)) {
> +			raw_inode->i_atime_nsec =3D
> +				cpu_to_le32(inode->i_atime.tv_nsec);
> +			raw_inode->i_ctime_nsec =3D
> +				cpu_to_le32(inode->i_ctime.tv_nsec);
> +			raw_inode->i_mtime_nsec =3D
> +				cpu_to_le32(inode->i_mtime.tv_nsec);
> +		}
> +	}

Macro here also to convert from nsec to the ext3-internal "msb_and_ns" form=
at.

> +static inline struct timespec ext3_current_time(struct inode *inode)
> +{
> +	return (inode->i_sb->s_time_gran =3D=3D 1) ?
> +	       CURRENT_TIME : CURRENT_TIME_SEC;
> +}

If "s_time_gran" (I haven't seen this before but it doesn't appear to
be a part of your patch) had some useful meaning we could use it to e.g.
shift the nsec part of the timestamps as Andy requested so as not to make
the timestamps change too often.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--NY6JkbSqL3W9mApi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFB6f+cpIg59Q01vtYRAsvCAKCAVZMQ8Qvu47tUDnvMS+ApU80xBQCfYvjp
MU0WI0/pcFuILNMd6aOQYd0=
=Y7tX
-----END PGP SIGNATURE-----

--NY6JkbSqL3W9mApi--
