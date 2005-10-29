Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbVJ2RZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbVJ2RZx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 13:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbVJ2RZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 13:25:53 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:12713 "EHLO
	smtp.mailbox.co.uk") by vger.kernel.org with ESMTP id S1751096AbVJ2RZw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 13:25:52 -0400
Message-ID: <4363B081.7050300@jonmasters.org>
Date: Sat, 29 Oct 2005 18:25:21 +0100
From: Jon Masters <jonathan@jonmasters.org>
Organization: World Organi[sz]ation Of Broken Dreams
User-Agent: Debian Thunderbird 1.0.6 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix floppy.c to store correct ro/rw status in underlying
 gendisk
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Evgeny Stambulchik found that doing the following always worked:

# mount /dev/fd0 /mnt/floppy/
mount: block device /dev/fd0 is write-protected, mounting read-only
# mount -o remount,rw /mnt/floppy
# echo $?
0

This is the case because the block device /dev/fd0 is writeable but the
floppy disk is marked protected. A fix is to simply have floppy_open
mark the underlying gendisk policy according to reality (since the VFS
doesn't provide a way for do_remount_sb to inquire as to the current
device status).

Signed-off-by: Jon Masters <jcm@jonmasters.org>

- --- linux-2.6.14/drivers/block/floppy.c 2005-10-28 01:02:08.000000000
+0100
+++ linux-2.6.14_new/drivers/block/floppy.c     2005-10-29
18:14:47.000000000 +0100
@@ -3714,6 +3714,13 @@
                USETF(FD_VERIFY);
        }

+       /* set underlying gendisk policy to reflect real ro/rw status */
+       if (UTESTF(FD_DISK_WRITABLE)) {
+               inode->i_bdev->bd_disk->policy = 0;
+       } else {
+               inode->i_bdev->bd_disk->policy = 1;
+       }
+
        if (UDRS->fd_ref == -1 || (UDRS->fd_ref && (filp->f_flags &
O_EXCL)))
                goto out2;
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDY7CAeTyyexZHHxERAvwzAJ0cnuIhiufkEwRK/Kyj0p8URvLAEgCdF38+
k8hBPhPYvtIt3XGKDfkQbeY=
=P0sF
-----END PGP SIGNATURE-----
