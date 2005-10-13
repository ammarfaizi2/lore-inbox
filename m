Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbVJMUgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbVJMUgz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 16:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbVJMUgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 16:36:55 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:61059 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S964777AbVJMUgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 16:36:54 -0400
Message-ID: <434E5541.5030307@t-online.de>
Date: Thu, 13 Oct 2005 14:38:25 +0200
From: Manfred Scherer <Manfred.Scherer.Mhm@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: reiserfs-dev@namesys.com
CC: linux-kernel@vger.kernel.org
Subject: PATCH for reiserfs, max 2GB in version 3.5
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: TQJVcMZYgePGHcaOc40Mb1xC3MOwqB363F6xaU9SGuTR3wapUBWfc9
X-TOI-MSGID: ea8eb3bd-a5c2-4f8f-949d-578d5d11aa9d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If we create a file greater than 2GB in a reiserfs v3.5,
the file size will not be checked and the file can be
created like this:

pc1:/mnt_hdg10 # dd if=/dev/zero of=zero_3GB.dd bs=1024 count=3000000
3000000+0 records in
3000000+0 records out
pc1:/mnt_hdg10 #

The command "ls -l" shows the file size as created above:

pc1:/mnt_hdg10 # ls -l zero_3GB.dd
-rw-r--r--  1 root root 3072000000 Oct  3 15:59 zero_3GB.dd
pc1:/mnt_hdg10 #

When we read this file, read will abort when the 2GB border is reached:

pc1:/mnt_hdg10 # dd if=zero_3GB.dd of=/dev/null bs=1024
dd: reading `zero_3GB.dd': Input/output error
2097152+0 records in
2097152+0 records out
pc1:/mnt_hdg10 #


A file system check does not help,
the command "reiserfsck --fix-fixable /dev/hdg10"
spit out this massage:

/zero_3GB.ddvpf-10670: The file [2 23061] has the wrong size in the 
StatData (3072000000) - corrected to (3072000000)

BTW this file can be delete with the command "rm zero_3GB.dd".


The same test in a reiserfs v3.5 with a file greater than 4GB will end 
in more trouble.
You can test this like:

pc1:/mnt_hdg10 # dd if=/dev/zero of=zero_5GB.dd bs=1024 count=5000000


---------------------------------------------------------------------------

A simple check will avoid to create files greater than 2GB in reiserfs v3.5,
see patch below:

---------------------------------------------------------------------------

--- linux-2.6.13/fs/reiserfs/file.c.ORIG        2005-08-29 
01:41:01.000000000 +0200
+++ linux-2.6.13/fs/reiserfs/file.c     2005-10-11 11:41:23.000000000 +0200
@@ -1343,10 +1343,14 @@

         down(&inode->i_sem);    // locks the entire file for just us

         pos = *ppos;

+       // 2005-10-07 --ms, max 2GB on v3.5
+       if (get_inode_item_key_version(inode) == KEY_FORMAT_3_5)
+               file->f_flags &= ~O_LARGEFILE;  // for LFS rule in 
generic_write_checks()
+
         /* Check if we can write to specified region of file, file
            is not overly big and this kind of stuff. Adjust pos and
            count, if needed */
         res = generic_write_checks(file, &pos, &count, 0);
         if (res)


Signed-off-by: Manfred Scherer <manfred.scherer.mhm@t-online.de>

-------------------------------------------------------------------------

BTW the 2.4 kernel will have the same problem.

fs/reiserfs/file.c:

static ssize_t
reiserfs_file_write(struct file *f, const char *b, size_t count, loff_t 
*ppos)
{
     ssize_t ret;
     struct inode *inode = f->f_dentry->d_inode;

+    // 2005-10-07 --ms, max 2GB on v 3.5
+    if (get_inode_item_key_version(inode) == KEY_FORMAT_3_5)
+        file->f_flags &= ~O_LARGEFILE;  // for LFS rule in 
precheck_file_write()
+
     ret = generic_file_write(f, b, count, ppos);
     if (ret >= 0 && f->f_flags & O_SYNC) {
         lock_kernel();
         reiserfs_commit_for_inode(inode);
         unlock_kernel();
     }
     return ret;
}

-------------------------------------------------------------------------

Manfred Scherer
