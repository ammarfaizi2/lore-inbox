Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVCGXxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVCGXxY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVCGXie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:38:34 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:53659 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261960AbVCGXWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 18:22:30 -0500
Date: Mon, 7 Mar 2005 16:22:21 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Junfeng Yang <yjf@stanford.edu>
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, mc@cs.Stanford.EDU
Subject: Re: [Ext2-devel] Re: [CHECKER] crash after fsync causing serious FS corruptions (ext2, 2.6.11)
Message-ID: <20050307232221.GJ27352@schnapps.adilger.int>
Mail-Followup-To: Junfeng Yang <yjf@stanford.edu>,
	Jens Axboe <axboe@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net, mc@cs.Stanford.EDU
References: <20050307104513.GD8071@suse.de> <Pine.GSO.4.44.0503071433490.7287-100000@elaine24.Stanford.EDU>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K1J4S+9Iyh/oeWZQ"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0503071433490.7287-100000@elaine24.Stanford.EDU>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--K1J4S+9Iyh/oeWZQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 07, 2005  14:55 -0800, Junfeng Yang wrote:
> > fsync on ext2 only really guarantees that the data has reached
> > the disk, what the disk does it outside the realm of the fs.
> > If the ide drive has write back caching enabled, the data just
> > might only be in cache. If the power is removed right after fsync
> > returns, the drive might not get a chance to actually commit the
> > write to platter.
>=20
> Thanks for the reply.  I tried your patch, and also setting hdparm -W0.
> The warning is still there.  This warning and the previous ones I reported
> should be irrelevant to IDE drivers, as FiSC (our FS checker) doesn't
> actually crash the machine but simulates a crash using a ramdisk.
>=20
> It appears to me that this warning can be triggered by the following step=
s:
>=20
> 1. create a file A with several data blocks. fsync(A) to disk
>=20
> 2. truncate A to a smaller size, causing a few blocks to be freed.
> However, they are only freed in memory.  The corresponding changes in
> bitmaps haven't yet hit the disk.
>=20
> 3. create a file B with several data blocks.  ext2 will re-use the freed
> blocks from step 2.
>=20
> 4. fsync(B).  Once fsync returns, crash.

In ext3 this case is handled because the filesystem won't reallocate the
metadata blocks freed from file A before they have been committed to disk.
Also, the operations on file A are guaranteed to complete before or with
operations on file B so fsync(B) will also cause the changes from A to
be flushed to disk at the same time (this is guaranteed to complete before
fsync(B) returns).

I'm not sure how easy it would be to fix this in ext2 without introducing
at least some of the mechanisms from ext3, nor whether there is desire to
do this given the presence of ext3.

> At this moment, the truncate in step 2 hasn't reached the disk yet, so the
> file A on disk still contains pointers to the freed blocks.  However, the
> fsync(B) in step 4 flushes B's inode and other metadata to disk.  Now we
> end up with a file system where a block is shared by two files.
>=20
> I'm not sure how the invalid block number warning is triggered.

If B file was larger than 48kB, and you are filling it with e.g. 0xffffffe
then this could overwrite file A's indirect block from the data in file B.

Cheers, Andreas
--
Andreas Dilger
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--K1J4S+9Iyh/oeWZQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFCLOItpIg59Q01vtYRAvsVAJ9f0Hw47uA6f0QMyizUzPH++2HwYwCglGVV
dkSkE3S7ssLDaE1QoLMZF7s=
=FNtB
-----END PGP SIGNATURE-----

--K1J4S+9Iyh/oeWZQ--
