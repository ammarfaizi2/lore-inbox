Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267544AbUHJRoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267544AbUHJRoW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 13:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267485AbUHJRnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 13:43:53 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:35658 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S267555AbUHJRgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 13:36:01 -0400
Message-ID: <411907D4.1020205@suse.com>
Date: Tue, 10 Aug 2004 13:37:24 -0400
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: File sizes > 2 GB on isofs?
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060300030100010009040208"
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060300030100010009040208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I recently received a bug report regarding files on an iso9660
filesystem with sizes > 2 GB. mkisofs is apparently capable of creating
these filesystems, so I did a bit of research into if this was actually
valid or not.

It seems the iso9660/ecma119 spec doesn't specify the signedness of the
"32-bit number" for which they assign space to contain the file size.
There are tests in the kernel code to disallow file sizes > 2 GB, with
the apparent reason that there was, at some point, invalid CDs floating
around that hijacked the high byte of the file size field for some other
purpose.

With DVDs becoming widely popular for personal data storage, this 2 GB
limit will probably become more and more of an issue.

Currently, if a file is > 2 GB, 'cruft mode' is enabled which strips the
high byte off a file size. Attached is a patch that adds another
condition to that test: In order to enable 'cruft mode', the file size
must be larger than the volume size. A 3 GB file on a 700 MB CD is
certainly invalid, but a 3 GB file on a 4.7 GB DVD should be valid.

Might someone with a bit more familiarity with the spec be able to
comment on this?

Thanks.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBGQfULPWxlyuTD7IRAqc3AJ9YC8Rg+GGmzm1V5SbHkDumkLKCvQCfSOoJ
NhagL+eCKXGugHcuFFCgZjQ=
=ToTR
-----END PGP SIGNATURE-----

--------------060300030100010009040208
Content-Type: text/plain;
 name="isofs-4GB.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="isofs-4GB.diff"

diff -rup linux-2.6.5-7.97/fs/isofs/inode.c linux-2.6.5-7.97.devel/fs/isofs/inode.c
--- linux-2.6.5-7.97/fs/isofs/inode.c	2004-07-02 10:41:26.000000000 -0400
+++ linux-2.6.5-7.97.devel/fs/isofs/inode.c	2004-08-10 13:26:51.796563112 -0400
@@ -1158,7 +1158,7 @@ static int isofs_read_level3_size(struct
 			de = tmpde;
 		}
 
-		inode->i_size += isonum_733(de->size);
+		inode->i_size += (unsigned)isonum_733(de->size);
 		if (i == 1)
 			ei->i_next_section_ino = f_pos;
 
@@ -1267,23 +1267,25 @@ static void isofs_read_inode(struct inod
 	ei->i_format_parm[1] = 0;
 	ei->i_format_parm[2] = 0;
 
-	ei->i_section_size = isonum_733 (de->size);
+	ei->i_section_size = (unsigned)isonum_733 (de->size);
 	if(de->flags[-high_sierra] & 0x80) {
 		if(isofs_read_level3_size(inode)) goto fail;
 	} else {
 		ei->i_next_section_ino = 0;
-		inode->i_size = isonum_733 (de->size);
+		inode->i_size = (unsigned)isonum_733 (de->size);
 	}
 
-	/*
-	 * The ISO-9660 filesystem only stores 32 bits for file size.
-	 * mkisofs handles files up to 2GB-2 = 2147483646 = 0x7FFFFFFE bytes
-	 * in size. This is according to the large file summit paper from 1996.
-	 * WARNING: ISO-9660 filesystems > 1 GB and even > 2 GB are fully
-	 *	    legal. Do not prevent to use DVD's schilling@fokus.gmd.de
-	 */
+	/* The ISO-9660 filesystem only stores 32 bits for file size.
+	 * mkisofs handles files up to 4 GB-1 = 0xFFFFFFFF bytes in size.
+	 * There used to be issues with some implementations hijacking the
+	 * high byte of the size field for some other purpose. In order to
+	 * allow for the full range of file sizes, yet still protect against
+	 * this, we check and see if the file size is larger than the size
+	 * of the entire volume.
+	 */
 	if ((inode->i_size < 0 || inode->i_size > 0x7FFFFFFE) &&
-	    sbi->s_cruft == 'n') {
+	    inode->i_size > (ISOFS_SB(sb)->s_nzones <<
+	    ISOFS_SB(sb)->s_log_zone_size) && sbi->s_cruft == 'n') {
 		printk(KERN_WARNING "Warning: defective CD-ROM.  "
 		       "Enabling \"cruft\" mount option.\n");
 		sbi->s_cruft = 'y';

--------------060300030100010009040208--
