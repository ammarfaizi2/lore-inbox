Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVBKWvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVBKWvA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 17:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVBKWvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 17:51:00 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:16772 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261388AbVBKWuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 17:50:50 -0500
Date: Fri, 11 Feb 2005 15:50:47 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       "Theodore Ts'o" <tytso@mit.edu>, Alex Tomas <alex@clusterfs.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Ext2/3 32-bit stat() wrap for ~2TB files
Message-ID: <20050211225047.GF16520@schnapps.adilger.int>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	"ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
	Theodore Ts'o <tytso@mit.edu>, Alex Tomas <alex@clusterfs.com>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <1108155135.1944.196.camel@sisko.sctweedie.blueyonder.co.uk> <20050211212736.GD16520@schnapps.adilger.int> <1108157964.1944.209.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DO5DiztRLs659m5i"
Content-Disposition: inline
In-Reply-To: <1108157964.1944.209.camel@sisko.sctweedie.blueyonder.co.uk>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DO5DiztRLs659m5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Feb 11, 2005  21:39 +0000, Stephen C. Tweedie wrote:
> ...i_blocks is counted in fs blocksize units, so we're nowhere near
> overflowing that.  It's only when stat() converts it to st_blocks'
> 512-byte units that we get into trouble within the kernel.

Umm, I don't think so.  ext3 i_blocks is sectors and not fs blocks (one of
my pet peeves actually).  In 2.4 it is as below, 2.6 has one more copy.

ext3_read_inode()
{
	:
	inode->i_blocks = le32_to_cpu(raw_inode->i_blocks);

cp_new_stat()
{
	:
	tmp.st_blocks = inode->i_blocks;


I've wondered at times whether it might make sense to store i_blocks in
fs blocksize units when we add some new feature (e.g. high bits for
i_blocks if we overflow 2^32) but I'm not sure the increased complexity
makes up for the minor increase in dynamic range.

In the end, we hit the 2^64 fs size limit before we would run out of
range for i_blocks (assuming 64 bits there) so changing it doesn't help
much.  The only reason to change would be to store up to 2^48 fs blocks
(only using 16 bits in the core inode, e.g. i_frag + i_fsize) and assume
we need to use 2^16 blocksize for the largest files with extents.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--DO5DiztRLs659m5i
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFCDTbHpIg59Q01vtYRApNJAJ4txmrWESZH3KokjyNajW990DWCcwCghJaX
AEPVMnOheapfAwk8XEFFet8=
=IoaY
-----END PGP SIGNATURE-----

--DO5DiztRLs659m5i--
