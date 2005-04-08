Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262576AbVDHAzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbVDHAzV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 20:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVDHAzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 20:55:04 -0400
Received: from mail.ccur.com ([208.248.32.212]:26289 "EHLO flmx.iccur.com")
	by vger.kernel.org with ESMTP id S262576AbVDHAwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 20:52:50 -0400
Subject: [PATCH] mtime attribute is not being updated on client
From: Linda Dunaphant <linda.dunaphant@ccur.com>
Reply-To: linda.dunaphant@ccur.com
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: CCUR
Message-Id: <1112921570.6182.16.camel@lindad>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Thu, 07 Apr 2005 20:52:50 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Apr 2005 00:52:50.0439 (UTC) FILETIME=[49EED970:01C53BD5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,
 
The acregmin (default=3) and acregmax (default=60) NFS attributes that
control the min and max attribute cache lifetimes don't appear to be
working after the first few timeouts. Using a test program that loops
on the following sequence:
        - write to a file on an NFS3 mounted filesystem from the client
        - sleep for one second
        - stat the file to get the mtime
you see the mtime change once after ~56 seconds, but no further mtime
changes are detected by the test.
  
nfs_refresh_inode() currently bypasses the inode vs fattr mtime comparison
if data_unstable is true. At the end of nfs_refresh_inode(), it resets the
attribute timer. Since nfs_refresh_inode() is being called after every
write to the server (which occurs more often than the attribute timer is
set to expire), the attribute timer never expires again for this file past
the ~56 sec point.
 
In nfs_refresh_inode() I believe the mtime comparison should be moved outside
the check for data_unstable. The server might already have a newer value for
mtime than the value on the client. With this change, the test sees the mtime
change after each write completes on the server.
 
Regards,
Linda
  
The following patch is for 2.6.12-rc2:
  
diff -Nura base/fs/nfs/inode.c new/fs/nfs/inode.c
--- base/fs/nfs/inode.c 2005-04-07 16:04:40.933611205 -0400
+++ new/fs/nfs/inode.c  2005-04-07 16:12:34.484299540 -0400
@@ -1176,9 +1176,11 @@
        }
   
        /* Verify a few of the more important attributes */
+       if (!timespec_equal(&inode->i_mtime, &fattr->mtime))
+               nfsi->flags |= NFS_INO_INVALID_ATTR;
+
        if (!data_unstable) {
-               if (!timespec_equal(&inode->i_mtime, &fattr->mtime)
-                               || cur_size != new_isize)
+               if (cur_size != new_isize)
                        nfsi->flags |= NFS_INO_INVALID_ATTR;
        } else if (S_ISREG(inode->i_mode) && new_isize > cur_size)
                        nfsi->flags |= NFS_INO_INVALID_ATTR;


