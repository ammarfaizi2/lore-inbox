Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263984AbUFBUAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263984AbUFBUAc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 16:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbUFBUAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 16:00:31 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:4617 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S263984AbUFBUAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 16:00:19 -0400
Message-ID: <40BE3235.5060906@suse.com>
Date: Wed, 02 Jun 2004 16:01:57 -0400
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ext3_orphan_del may double-decrement bh->b_count
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090805070403080702050007"
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.16.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090805070403080702050007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Andrew -

Chris Mason and I ran across this one while hunting down another bug.

If ext3_mark_iloc_dirty() fails in ext3_orphan_del() on the outer
buffer, bh->b_count will be decremented twice. ext3_mark_iloc_dirty()
will brelse the buffer, even on error. ext3_orphan_del() is explicity
brelse'ing the buffer on error. Prior to calling ext3_mark_iloc_dirty(),
this is the correct behavior.

Fix attached.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAvjI1LPWxlyuTD7IRAht5AJ9sM8mN2TiLb+RFCqHF/Fj/pVsuCgCfWXse
izGrI5bgD1zhoM5sqXgkM5Q=
=Td4v
-----END PGP SIGNATURE-----

--------------090805070403080702050007
Content-Type: text/plain;
 name="ext3_orphan_del.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ext3_orphan_del.diff"

#
# ext3_mark_iloc_dirty brelse's the buffer even on error,
# jumping to the out_brelse label causes a double decrement to occur.
#
--- linux-2.5.orig/fs/ext3/namei.c.orig	2004-06-02 11:46:52.903565552 -0400
+++ linux-2.5/fs/ext3/namei.c	2004-06-02 11:47:00.494411568 -0400
@@ -1963,7 +1963,7 @@
 	NEXT_ORPHAN(inode) = 0;
 	err = ext3_mark_iloc_dirty(handle, inode, &iloc);
 	if (err)
-		goto out_brelse;
+		goto out_err;
 
 out_err:
 	ext3_std_error(inode->i_sb, err);

--------------090805070403080702050007--
