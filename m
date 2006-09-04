Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbWIDQCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWIDQCp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 12:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWIDQCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 12:02:45 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:45766 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S964906AbWIDQCo (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 12:02:44 -0400
Message-Id: <200609041602.k84G2SYc005390@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc4-mm3 crypto issues with encrypted disks
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1157385748_3784P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 04 Sep 2006 12:02:28 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1157385748_3784P
Content-Type: text/plain; charset=us-ascii

Sorry for not catching this one earlier..  Sometime between 2.6.18-rc4-mm2
and -mm3, something crept into the git-cryptodev.patch that breaks mounting
encrypted disks.  What I have in /etc/fstab:

/dev/rootvg/crypto1     /crypto/mount_dir    ext3    nodev,nosuid,noexec,noauto,noatime,nodiratime,user,loop,encryption=aes 1 0

This worked in -mm2, and a bisect of -mm patches points git-cryptodev as
the problem, so it's one of the commits in that patch between -mm2 and -mm3.

/sbin/mount is able to set up the loopback, but then gets an error that
no valid superblock was found - which says to me that it's not treating the
passphrase or something the same, and decrypting to something other than what
the -mm2 kernel decrypted the superblock to.

My personal guess as "most likely suspect" (only obvious hit on cryptoloop):

commit d1bc13c88efaa1c1f4f78ac5510297f3187c7f63
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Sun Aug 13 08:45:10 2006 +1000

    [BLOCK] cryptoloop: Use block ciphers where applicable

    This patch converts cryptoloop to use the new block cipher type where
    applicable.  As a result the ECB-specific and CBC-specific transfer
    functions have been merged.

    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

but I have *not* extracted that one GIT commit to test it yet.

--==_Exmh_1157385748_3784P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFE/E4TcC3lWbTT17ARAqm/AJ9TirZSQEZhWoJOZtprXC9Va9WI5QCg+nI9
JNwP1AU3orujkyqGM26VUdc=
=QfKe
-----END PGP SIGNATURE-----

--==_Exmh_1157385748_3784P--
