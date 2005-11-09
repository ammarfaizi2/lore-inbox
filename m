Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161032AbVKIWsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161032AbVKIWsv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161034AbVKIWsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:48:50 -0500
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:39313 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1161019AbVKIWse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:48:34 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Wed, 9 Nov 2005 22:48:29 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de
Subject: [PATCH] Remove read-only check from inode_update_time().
Message-ID: <Pine.LNX.4.64.0511092243001.7946@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

The read-only check in inode_update_time() (or file_update_time() as it is 
now in -mm) is unnecessary as the VFS better have done all the read-only 
checks and aborted much earlier in the file write code paths where 
inode/file_update_time() is only called from.

(In case you were not following the ntfs discussion, Christoph Hellwig 
agreed that check is unnecessary and can be removed.)

Patch against latest Linus git tree is below, please apply.  If you prefer 
a patch on top of Christoph's file_update_time() check please let me 
know...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

---

The read-only check in inode_update_time() (or file_update_time() as it is
now in -mm) is unnecessary as the VFS better have done all the read-only
checks and aborted much earlier in the file write code paths where
inode/file_update_time() is only called from.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

--- inode.c	2005-11-09 19:23:35.000000000 +0000
+++ inode.c.new	2005-11-09 22:45:21.000000000 +0000
@@ -1219,8 +1219,6 @@ void inode_update_time(struct inode *ino
 
 	if (IS_NOCMTIME(inode))
 		return;
-	if (IS_RDONLY(inode))
-		return;
 
 	now = current_fs_time(inode->i_sb);
 	if (!timespec_equal(&inode->i_mtime, &now))

