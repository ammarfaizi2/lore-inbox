Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWJHIsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWJHIsU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 04:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWJHIsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 04:48:19 -0400
Received: from lug-owl.de ([195.71.106.12]:3741 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1750952AbWJHIsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 04:48:18 -0400
Date: Sun, 8 Oct 2006 10:48:16 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Andrew Morton <akpm@osdl.org>, Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sct@redhat.com, adilger@clusterfs.com, linux-ext4@vger.kernel.org
Subject: Re: 2.6.18-mm2: ext3 BUG?
Message-ID: <20061008084816.GF30283@lug-owl.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Jiri Slaby <jirislaby@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	sct@redhat.com, adilger@clusterfs.com, linux-ext4@vger.kernel.org
References: <45257A6C.3060804@gmail.com> <20061005145042.fd62289a.akpm@osdl.org> <4525925C.6060807@gmail.com> <20061005171428.636c087c.akpm@osdl.org> <20061008063330.GA30283@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sjel/IY1pyoUgMMX"
Content-Disposition: inline
In-Reply-To: <20061008063330.GA30283@lug-owl.de>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sjel/IY1pyoUgMMX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-10-08 08:33:30 +0200, Jan-Benedict Glaw <jbglaw@lug-owl.de> wr=
ote:
> dd bs=3D1M count=3D200 if=3D/dev/zero of=3Dtest0
> while :; do
> 	echo "cp 0-1"; cp test0 test1 || break
> 	echo "cp 1-2"; cp test1 test2 || break
> 	echo "cp 2-3"; cp test2 test3 || break
> 	echo "cp 3-4"; cp test3 test4 || break
> 	echo "od 0" ; od test0 || break
> 	echo "rm 1"; rm test1 || break
> 	echo "rm 2"; rm test2 || break
> 	echo "rm 3"; rm test3 || break
> 	echo "rm 4"; rm test4 || break
> done

Just tested again and got *exactly* the same error message, bit
already cleared for block 194810, but this time after only 20min:

> EXT3-fs error (device dm-5): ext3_free_blocks_sb: bit already cleared for=
 block 194810
> Aborting journal on device dm-5.
> ext3_abort called.
> EXT3-fs error (device dm-5): ext3_journal_start_sb: Detected aborted jour=
nal
> Remounting filesystem read-only
> EXT3-fs error (device dm-5) in ext3_reserve_inode_write: Journal has abor=
ted
> EXT3-fs error (device dm-5) in ext3_truncate: Journal has aborted
> EXT3-fs error (device dm-5) in ext3_reserve_inode_write: Journal has abor=
ted
> EXT3-fs error (device dm-5) in ext3_orphan_del: Journal has aborted
> EXT3-fs error (device dm-5) in ext3_reserve_inode_write: Journal has abor=
ted
> __journal_remove_journal_head: freeing b_committed_data
> __journal_remove_journal_head: freeing b_committed_data
> __journal_remove_journal_head: freeing b_committed_data
>=20
>=20
> Last echoes from the testcase above:
>=20
> rm 1
> rm 2
> rm: cannot remove `test2': Read-only file system

=2E..and with exactly the same position it broke again.

> kolbe34-backup:/mnt# dumpe2fs /dev/kolbe34_backup/ext3crash 2>/dev/null |=
 grep features
> Filesystem features:      has_journal resize_inode dir_index filetype nee=
ds_recovery sparse_super large_file

However, fsck looks a bit different this time:

kolbe34-backup:/mnt# e2fsck -jy /dev/kolbe34_backup/ext3crash
e2fsck 1.39 (29-May-2006)
/dev/kolbe34_backup/ext3crash: recovering journal
/dev/kolbe34_backup/ext3crash contains a file system with errors, check for=
ced.
Pass 1: Checking inodes, blocks, and sizes
Deleted inode 49154 has zero dtime.  Fix<y>?

/dev/kolbe34_backup/ext3crash: e2fsck canceled.

/dev/kolbe34_backup/ext3crash: ***** FILE SYSTEM WAS MODIFIED *****

/dev/kolbe34_backup/ext3crash: ********** WARNING: Filesystem still has err=
ors **********

kolbe34-backup:/mnt# e2fsck -fy /dev/kolbe34_backup/ext3crash
e2fsck 1.39 (29-May-2006)
Pass 1: Checking inodes, blocks, and sizes
Deleted inode 49154 has zero dtime.  Fix? yes

Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Block bitmap differences:  -(107533--124927) -(178242--194673)
Fix? yes

Free blocks count wrong for group #3 (7686, counted=3D25081).
Fix? yes

Free blocks count wrong for group #5 (1933, counted=3D18366).
Fix? yes

Free blocks count wrong (15196903, counted=3D15230731).
Fix? yes

Inode bitmap differences:  -49154
Fix? yes

Free inodes count wrong for group #3 (16379, counted=3D16380).
Fix? yes

Free inodes count wrong (7864304, counted=3D7864305).
Fix? yes


/dev/kolbe34_backup/ext3crash: ***** FILE SYSTEM WAS MODIFIED *****
/dev/kolbe34_backup/ext3crash: 15/7864320 files (6.7% non-contiguous), 4979=
09/15728640 blocks


MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:            http://www.chiark.greenend.org.uk/~sgtatham/bugs.h=
tml
the second  :

--sjel/IY1pyoUgMMX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFKLtQHb1edYOZ4bsRAtqUAJwIqwiVrZDOHnhzC5+SzKFU+ePpRQCeIfdp
FYOCETTRDfM+HC4OoY1RP5U=
=RZzV
-----END PGP SIGNATURE-----

--sjel/IY1pyoUgMMX--
