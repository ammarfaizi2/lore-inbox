Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268406AbUJMFvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268406AbUJMFvL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 01:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268421AbUJMFvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 01:51:10 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:10439 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S268406AbUJMFuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 01:50:39 -0400
Date: Tue, 12 Oct 2004 23:50:35 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Charles Manning <manningc2@actrix.gen.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Using ilookup?
Message-ID: <20041013055035.GH2061@schnapps.adilger.int>
Mail-Followup-To: Charles Manning <manningc2@actrix.gen.nz>,
	linux-kernel@vger.kernel.org
References: <20041013013930.9BB6649E9@blood.actrix.co.nz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W5Yj4BWVzBU0tpZR"
Content-Disposition: inline
In-Reply-To: <20041013013930.9BB6649E9@blood.actrix.co.nz>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--W5Yj4BWVzBU0tpZR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 13, 2004  14:42 +1300, Charles Manning wrote:
> YAFFS allocates its own "objectId"s which are used as inode numbers for m=
ost=20
> purposes. When objects get deleted (=3D=3D unlinked), the object numbers =
get=20
> recycles.  Sometimes though the Linux cache has an inode after the object
> has been deleted. Then if that object id gets recycled before the cached
> inode is released, a problem occurs since iget() gets the old inode inste=
ad
> of creating a new one. We then end up with an inconsistency.

You can use iget4() along with a filesystem-specific comparison function,
which allows you to distinguish inodes with the same number based on
some extra data (e.g. generation number, 64-bit inode numbers, etc).  Is
there a reason to recycle the inode numbers, or could you just have a
32-bit counter?

> 1)  Somehow plug myself into the inode iput() chain so that I know when
> an inode is removed from the cache. I can then make sure that I don't
> free up the inode number for reuse until the inode is not in the cache.
> Any hints on how to do that?

You can use the ->delete_inode method which is a hook to be called
before/instead of the clear_inode() function in iput(), and is
the last thing action taken when the inode is being unlinked.  There
is also the ->clear_inode inode method, which is called when inodes
are being put away but not only when being unlinked.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--W5Yj4BWVzBU0tpZR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBbMIrpIg59Q01vtYRAj5UAKDVJOVTM4D0sFfLKDkEwoe63th+SgCg2ARL
QRkBVd+M0b7lO1i8Pwp2WxM=
=2QiU
-----END PGP SIGNATURE-----

--W5Yj4BWVzBU0tpZR--
