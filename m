Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263905AbTEFQVP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263928AbTEFQUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:20:03 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:53246 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263905AbTEFQMm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:12:42 -0400
Subject: [PATCH] Move security_d_instantiate hook calls 2.5.69
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1052238293.1377.1002.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 12:24:53 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.5.69 moves the security_d_instantiate hook calls in
d_instantiate and d_splice_alias after the inode has been attached to
the dentry.  This change is necessary so that security modules can
internally call the getxattr inode operation (which takes a dentry
parameter) from this hook to obtain the inode security label.  Al, if
you approve of this change, please acknowledge.  If not, please advise
as to what must change.  Thanks.

 dcache.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.5/fs/dcache.c
diff -u linux-2.5/fs/dcache.c:1.1.1.6 linux-2.5/fs/dcache.c:1.7
--- linux-2.5/fs/dcache.c:1.1.1.6	Mon May  5 09:17:36 2003
+++ linux-2.5/fs/dcache.c	Mon May  5 13:04:55 2003
@@ -770,12 +770,12 @@
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
@@ -903,12 +903,12 @@
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
@@ -917,6 +917,7 @@
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

