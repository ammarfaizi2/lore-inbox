Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264608AbUAJFS3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 00:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUAJFS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 00:18:29 -0500
Received: from ugw.utcc.utoronto.ca ([128.100.102.3]:53512 "HELO
	ugw.utcc.utoronto.ca") by vger.kernel.org with SMTP id S264608AbUAJFS2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 00:18:28 -0500
To: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH/BUGFIX] ext2: update inode ctime on rename()
Date: Sat, 10 Jan 2004 00:18:17 -0500
From: Chris Siebenmann <cks@utcc.utoronto.ca>
Message-Id: <04Jan10.001818est.3526@ugw.utcc.utoronto.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Traditionally, Unix filesystems updated the inode ctime of the file
being rename()'d. While SuS does not strictly require this it does
permit it, and a number of programs (including dump and some commercial
backup tools) count on it. People on linux-kernel may remember the
Reiserfs people discovering and patching this rename() issue and the
discussion that resulted.

 After 2.2.12, it was noticed that Linux ext2 didn't do this, and it
was duly patched in 2.2.13. The ext3 people picked up the change at
that time, down to the comment, and you will find the comment there
in ext3 to this day (2.4 and 2.6 both). Unfortunately, however, the
change was not pushed into 2.3, and so 2.4 and now 2.6 have a ext2
rename() implementation that does not update inode ctime.

 Here is a 2.4 patch to fix this; it's been tested and it works. I
believe a similar if not identical patch would work on 2.6, but I don't
have a 2.6 system to test it with. (It's possible that the use of
'mark_inode_dirty' is no longer necessary, but I don't know enough
about ext2 internals to be sure.)

===== fs/ext2/namei.c 1.3 vs edited =====
--- 1.3/fs/ext2/namei.c	Tue Feb  5 02:41:03 2002
+++ edited/fs/ext2/namei.c	Wed Dec 10 17:13:30 2003
@@ -313,6 +313,13 @@
 			ext2_inc_count(new_dir);
 	}
 
+	/*
+	 * Like most other Unix systems, set the ctime for inodes on a
+	 * rename. 
+	 */
+	old_inode->i_ctime = CURRENT_TIME;
+	mark_inode_dirty(old_inode);
+
 	ext2_delete_entry (old_de, old_page);
 	ext2_dec_count(old_inode);
 
	- cks
