Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbTEAUKB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 16:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbTEAUKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 16:10:01 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:3982 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262336AbTEAUJ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 16:09:58 -0400
Subject: [PATCH] Move security_d_instantiate hook calls in 2.5.68
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1051820503.1377.396.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 May 2003 16:21:44 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.5.68 moves the security_d_instantiate hook calls in
d_instantiate and d_splice_alias after the inode has been attached to
the dentry.  This change is necessary so that security modules can
internally call the getxattr inode operation (which takes a dentry
parameter) from this hook to obtain the inode security label.  Please
apply, or let me know if any changes are needed.


 dcache.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.5/fs/dcache.c
===================================================================
RCS file: /home/pal/CVS/linux-2.5/fs/dcache.c,v
retrieving revision 1.5
diff -u -r1.5 dcache.c
--- linux-2.5/fs/dcache.c	21 Apr 2003 15:03:31 -0000	1.5
+++ linux-2.5/fs/dcache.c	28 Apr 2003 11:42:05 -0000
@@ -763,12 +763,12 @@
 void d_instantiate(struct dentry *entry, struct inode * inode)
 {
 	if (!list_empty(&entry->d_alias)) BUG();
-	security_d_instantiate(entry, inode);
 	spin_lock(&dcache_lock);
 	if (inode)
 		list_add(&entry->d_alias, &inode->i_dentry);
 	entry->d_inode = inode;
 	spin_unlock(&dcache_lock);
+	security_d_instantiate(entry, inode);
 }
 
 /**
@@ -896,12 +896,12 @@
 	struct dentry *new = NULL;
 
 	if (inode && S_ISDIR(inode->i_mode)) {
-		security_d_instantiate(dentry, inode);
 		spin_lock(&dcache_lock);
 		if (!list_empty(&inode->i_dentry)) {
 			new = list_entry(inode->i_dentry.next, struct dentry, d_alias);
 			__dget_locked(new);
 			spin_unlock(&dcache_lock);
+			security_d_instantiate(dentry, inode);
 			d_rehash(dentry);
 			d_move(new, dentry);
 			iput(inode);
@@ -910,6 +910,7 @@
 			list_add(&dentry->d_alias, &inode->i_dentry);
 			dentry->d_inode = inode;
 			spin_unlock(&dcache_lock);
+			security_d_instantiate(dentry, inode);
 			d_rehash(dentry);
 		}
 	} else

  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

