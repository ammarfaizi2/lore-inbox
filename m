Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261661AbSKHGMu>; Fri, 8 Nov 2002 01:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261662AbSKHGMu>; Fri, 8 Nov 2002 01:12:50 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:35005 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261661AbSKHGMt>; Fri, 8 Nov 2002 01:12:49 -0500
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: linux-kernel@vger.kernel.org
Cc: viro@math.psu.edu
Subject: [PATCH] 2.5.46: switch quota and BSD acct off for busy fs?
Date: Fri, 08 Nov 2002 07:19:07 +0100
Message-ID: <87adkkoa78.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do_umount() does DQUOT_OFF() and acct_auto_close() before actually
unmounting the fs. I guess, this is wrong, as long as the fs is busy.

Possible fix below. Comments?

Regards, Olaf.

--- a/fs/namespace.c	Sat Oct  5 18:45:36 2002
+++ b/fs/namespace.c	Fri Nov  8 07:07:55 2002
@@ -334,6 +334,8 @@
 	down_write(&current->namespace->sem);
 	spin_lock(&dcache_lock);
 
+	retval = -EBUSY;
+	if (atomic_read(&mnt->mnt_count) == 2 || flags & MNT_DETACH) {
 	if (atomic_read(&sb->s_active) == 1) {
 		/* last instance - try to be smart */
 		spin_unlock(&dcache_lock);
@@ -344,8 +346,6 @@
 		security_ops->sb_umount_close(mnt);
 		spin_lock(&dcache_lock);
 	}
-	retval = -EBUSY;
-	if (atomic_read(&mnt->mnt_count) == 2 || flags & MNT_DETACH) {
 		if (!list_empty(&mnt->mnt_list))
 			umount_tree(mnt);
 		retval = 0;
