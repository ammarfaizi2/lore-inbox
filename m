Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030330AbVI3PE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbVI3PE7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 11:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbVI3PE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 11:04:59 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:51934 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030308AbVI3PE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 11:04:58 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: truncate(2) sometimes updates ctime and sometimes ctime and mtime!
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Fri, 30 Sep 2005 16:04:47 +0100
Message-Id: <1128092687.5715.12.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There is an inconsistency in the way truncate works which was introduced
(relatively) recently.

fs/open.c::sys_truncate
  -> do_sys_truncate
    -> do_truncate does:

        newattrs.ia_size = length;
        newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME;

        down(&dentry->d_inode->i_sem);
        err = notify_change(dentry, &newattrs);
        up(&dentry->d_inode->i_sem);

This changes the ctime only.

But fs/attr.c::notify_change
  -> inode_setattr [happens when !inode->i_op || !inode->i_op->setattr]

which does:

        if (ia_valid & ATTR_SIZE) {
                if (attr->ia_size != i_size_read(inode)) {
                        error = vmtruncate(inode, attr->ia_size);
                        if (error || (ia_valid == ATTR_SIZE))
                                goto out;
                } else {
                        /*
                         * We skipped the truncate but must still update
                         * timestamps
                         */
                        ia_valid |= ATTR_MTIME|ATTR_CTIME;
                }
        }

Which changes both mtime and ctime when the size does not change.

Also, the man page for stat(2) says:

<quote>
The  field st_mtime is changed by file modifications, e.g. by mknod(2),
truncate(2), utime(2) and write(2) (of more than  zero  bytes).
Moreover, st_mtime of a directory is changed by the creation or deletion
of files in that directory.  The st_mtime field is not changed for
changes in owner, group, hard link count, or mode.
</quote>

So it suggests mtime is always modified on truncate.

So what is correct?  mtime and ctime or just ctime?  If just ctime,
Linus please apply below patch to remove the superfluous ATTR_MTIME from
fs/attr.c::inode_setattr().

Also someone ought to fix the man pages if they are not fixed already
(mine are man-pages-2.01-2 from SUSE 9.3)...

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

--- ntfs-2.6/fs/attr.c.old	2005-09-30 16:00:29.000000000 +0100
+++ ntfs-2.6/fs/attr.c	2005-09-30 16:00:47.000000000 +0100
@@ -79,7 +79,7 @@ int inode_setattr(struct inode * inode, 
 			 * We skipped the truncate but must still update
 			 * timestamps
 			 */
-			ia_valid |= ATTR_MTIME|ATTR_CTIME;
+			ia_valid |= ATTR_CTIME;
 		}
 	}
 


