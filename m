Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbUKWWgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbUKWWgJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 17:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUKWWeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 17:34:24 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:28628 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261561AbUKWWdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 17:33:11 -0500
Date: Mon, 22 Nov 2004 14:40:00 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: tridge@samba.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: performance of filesystem xattrs with Samba4
Message-ID: <20041122214000.GV1974@schnapps.adilger.int>
Mail-Followup-To: tridge@samba.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <1098383538.987.359.camel@new.localdomain> <16797.41728.984065.479474@samba.org> <20041119101600.GM1974@schnapps.adilger.int> <16801.58215.621386.125280@samba.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AwNVUpjOmSj7UnwZ"
Content-Disposition: inline
In-Reply-To: <16801.58215.621386.125280@samba.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AwNVUpjOmSj7UnwZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 23, 2004  00:02 +1100, tridge@samba.org wrote:
> I've put up graphs of the first set of dbench3 results for various
> filesystems at:
>=20
>    http://samba.org/~tridge/xattr_results/
>=20
> The results show that the ext3 large inode patch is extremely
> worthwhile. Using a 256 byte inode on ext3 gained a factor of up to 7x
> in performance, and only lost a very small amount when xattrs were not
> used. It took ext3 from a very mediocre performance to being the clear
> winner among current Linux journaled filesystems for performance when
> xattrs are used. Eventually I think that larger inodes should become
> the default.

For Lustre we tune the inode size at format time to allow the storing
of the "default" EA data within the larger inode.  Is this the case with
samba and 256-byte inodes (i.e. is your EA data all going to fit within
the extra 124 bytes of space for storing EAs)?  If you have to put any
of the commonly-used EA data into an external block the benefits are lost.

> The massive gap between ext2 and the other filesystems really shows
> clearly how much we are paying for journaling. I haven't tried any
> journal on external device or journal on nvram card tricks yet, but it
> looks like those will be worth pursuing.

One of the other things we do for Lustre right away is create the ext3
filesystem with larger journal sizes so that for the many-client cases
we do not get synchronous journal flushing if there are lots of active
threads.  This can make a huge difference in overall performance at
high loads.  Use "mke2fs -J size=3D400 ..." to create a 400MB journal
(assuming you have at least that much RAM and a large enough block
device, at least 4x the journal size just from a "don't waste space"
point of view).

One factor is that you don't necessarily need to write so much data at one
time, but also that ext3 needs to reserve journal space for the worst-case
usage, so you get 40-100 threads allocating "worst case" then "filling"
the journal (causing new operations to block) and finally completing with
only a small fraction of those reserved journal blocks actually used.

Having an external journal device also generally gives you a large
journal (by default it is the full size of the block device specified)
so sometimes the effects of the large journal are confused with the
fact that it is external.  I haven't seen any perf numbers recently on
what kind of effect having an external journal has.  I highly doubt that
NVRAM cards are any better than a dedicated disk for the journal, since
journal IO is write-only (except during recovery) and virtually seek-free.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--AwNVUpjOmSj7UnwZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBolywpIg59Q01vtYRAkY7AJ9AJVJM8xG35rN/ed3f7r+y1scsAwCghXYD
cmKKCHjqen1VG8If5RSsBVs=
=c/zF
-----END PGP SIGNATURE-----

--AwNVUpjOmSj7UnwZ--
