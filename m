Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265112AbUGGMzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265112AbUGGMzI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 08:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265114AbUGGMxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 08:53:01 -0400
Received: from linuxhacker.ru ([217.76.32.60]:14807 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S265108AbUGGMts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 08:49:48 -0400
Date: Wed, 7 Jul 2004 15:47:33 +0300
From: Oleg Drokin <green@clusterfs.com>
To: linux-kernel@vger.kernel.org, braam@clusterfs.com
Subject: [8/9] Lustre VFS patches for 2.6
Message-ID: <20040707124733.GA25982@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark lookup of last path element so that filesystems can distinguish it
and e.g. perform some actions based on information in intent.

 fs/namei.c            |    8 ++++++++
 include/linux/namei.h |    3 +++
 2 files changed, 11 insertions(+)

Index: linux-2.6.6/fs/namei.c
===================================================================
--- linux-2.6.6.orig/fs/namei.c	2004-05-27 21:24:45.151896688 +0300
+++ linux-2.6.6/fs/namei.c	2004-05-27 22:48:34.155371952 +0300
@@ -677,7 +677,9 @@
 
 		if (inode->i_op->follow_link) {
 			mntget(next.mnt);
+			nd->flags |= LOOKUP_LINK_NOTLAST;
 			err = do_follow_link(next.dentry, nd);
+			nd->flags &= ~LOOKUP_LINK_NOTLAST;
 			dput(next.dentry);
 			mntput(next.mnt);
 			if (err)
@@ -723,7 +725,9 @@
 			if (err < 0)
 				break;
 		}
+		nd->flags |= LOOKUP_LAST;
 		err = do_lookup(nd, &this, &next);
+		nd->flags &= ~LOOKUP_LAST;
 		if (err)
 			break;
 		follow_mount(&next.mnt, &next.dentry);
@@ -1344,7 +1348,9 @@
 	dir = nd->dentry;
 	nd->flags &= ~LOOKUP_PARENT;
 	down(&dir->d_inode->i_sem);
+	nd->flags |= LOOKUP_LAST;
 	dentry = __lookup_hash(&nd->last, nd->dentry, nd);
+	nd->flags &= ~LOOKUP_LAST;
 
 do_last:
 	error = PTR_ERR(dentry);
@@ -1449,7 +1455,9 @@
 	}
 	dir = nd->dentry;
 	down(&dir->d_inode->i_sem);
+	nd->flags |= LOOKUP_LAST;
 	dentry = __lookup_hash(&nd->last, nd->dentry, nd);
+	nd->flags &= ~LOOKUP_LAST;
 	putname(nd->last.name);
 	goto do_last;
 }
Index: linux-2.6.6/include/linux/namei.h
===================================================================
--- linux-2.6.6.orig/include/linux/namei.h	2004-05-27 21:24:45.078907784 +0300
+++ linux-2.6.6/include/linux/namei.h	2004-05-27 22:47:58.870736032 +0300
@@ -70,6 +70,9 @@
 #define LOOKUP_CONTINUE		 4
 #define LOOKUP_PARENT		16
 #define LOOKUP_NOALT		32
+#define LOOKUP_LAST		64
+#define LOOKUP_LINK_NOTLAST	128
+
 /*
  * Intent data
  */
