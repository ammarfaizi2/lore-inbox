Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbUEVO3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUEVO3B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 10:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbUEVO3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 10:29:01 -0400
Received: from nmts-mur.murom.net ([213.177.124.6]:3466 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S261389AbUEVO26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 10:28:58 -0400
Date: Sat, 22 May 2004 18:28:51 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Paul Serice <paul@serice.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs meta-data beyond 4GB
Message-ID: <20040522142851.GA18121@sirius.home>
References: <40ACC004.8080308@serice.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <40ACC004.8080308@serice.net>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-From: vsu@altlinux.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 20, 2004 at 09:26:12AM -0500, Paul Serice wrote:
<skip/>
> To support these types of DVDs, the inode scheme for isofs must be
> changed.  The patch I'm submitting for review provides one such
> comprehensive inode scheme.  It assigns inode numbers sequentially
> starting with 1 for the root inode.  It keeps a mapping for each inode
> that is indexed both by the inode number and by the block number and
> block offset.  The indexes are implemented using two rbtrees and
> are protected by a reader-writer spin lock.

Why use a spinlock here?  The filesystem code is always called in a
process context, therefore a semaphore is much more appropriate than a
spinlock.  BTW, your code allocates memory with SLAB_KERNEL while
holding a spinlock, which is wrong; the check for allocation failure
is also missing.

Also there are other, more serious problems with your approach:

- The inode map can consume a lot of memory, which is never released
  until unmount.  Someone could prepare a disk full of zero-length
  files and run "find" on it to crash the machine.

- Inode numbers for the same disk become not stable across mounts (can
  be annoying if automounters are used).

However, the 4GB limit problem really needs to be solved.  Here is
another idea (sorry, no patch yet): instead of the byte offset of the
directory entry, use its sector number and index in the sector.
isofs_read_inode() then would need to read the sector and skip the
specified number of directory entries to find the needed one.

The minimum possible size of an ISO9660 directory entry is 34 bytes
(33 bytes for struct iso_directory_record, 1 byte for file name).
Therefore there cannot be more than 60 directory entries in a single
CD-ROM sector (2048 bytes), so the number of a directory entry in the
sector can fit into 6 bits.  With 32-bit inode numbers this leaves 26
bits for the sector number, which is enough for up to 128GB.

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAr2OjW82GfkQfsqIRAkCuAJ9aVT1uvsv69MIzEbgFjDrLzi2m/wCdEWgz
MEP+e5kVwpoGR2EJ6Fw3pz0=
=N2eB
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
