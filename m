Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbVKKTWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbVKKTWf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbVKKTWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:22:35 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.117]:1209 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751088AbVKKTWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:22:34 -0500
Message-ID: <4374EF75.5010105@namesys.com>
Date: Fri, 11 Nov 2005 11:22:29 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [Fwd: [PATCH 3/3] reiser4-fix-readlink.patch]
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020800080403040701020607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020800080403040701020607
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



--------------020800080403040701020607
Content-Type: message/rfc822;
 name="[PATCH 3/3] reiser4-fix-readlink.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH 3/3] reiser4-fix-readlink.patch"

Return-Path: <vs@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 20248 invoked from network); 11 Nov 2005 16:17:54 -0000
Received: from ppp85-140-14-29.pppoe.mtu-net.ru (HELO ?192.168.1.10?) (85.140.14.29)
  by thebsh.namesys.com with SMTP; 11 Nov 2005 16:17:54 -0000
Message-ID: <4374C429.7050202@namesys.com>
Date: Fri, 11 Nov 2005 19:17:45 +0300
From: "Vladimir V. Saveliev" <vs@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
Subject: [PATCH 3/3] reiser4-fix-readlink.patch
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------070203000306090103080500"

This is a multi-part message in MIME format.
--------------070203000306090103080500
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------070203000306090103080500
Content-Type: text/plain;
 name="reiser4-fix-readlink.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reiser4-fix-readlink.patch"


From: Hans Reiser <reiser@namesys.com>

There is no need to implement reiser4 specific readlink. Use generic function.

Signed-off-by: Vladimir V. Saveliev <vs@namesys.com>


 fs/reiser4/plugin/inode_ops.c |   19 -------------------
 fs/reiser4/plugin/object.c    |    2 +-
 fs/reiser4/plugin/object.h    |    1 -
 3 files changed, 1 insertion(+), 21 deletions(-)

diff -puN fs/reiser4/plugin/inode_ops.c~reiser4-fix-readlink fs/reiser4/plugin/inode_ops.c
--- linux-2.6.14-rc5-mm1/fs/reiser4/plugin/inode_ops.c~reiser4-fix-readlink	2005-11-11 17:57:23.562310906 +0300
+++ linux-2.6.14-rc5-mm1-vs/fs/reiser4/plugin/inode_ops.c	2005-11-11 17:57:23.638327165 +0300
@@ -383,25 +383,6 @@ int mknod_common(struct inode *parent, s
  */
 
 /**
- * readlink_common - readlink of inode operations
- * @dentry: dentry of symlink
- * @buf: user buffer to read symlink content to
- * @buflen: size of user buffer
- *
- * This is common implementation of vfs's readlink method of struct
- * inode_operations.
- * Assumes that inode's generic_ip points to the content of symbolic link.
- */
-int readlink_common(struct dentry *dentry, char __user *buf, int buflen)
-{
-	assert("vs-852", S_ISLNK(dentry->d_inode->i_mode));
-	if (!dentry->d_inode->u.generic_ip
-	    || !inode_get_flag(dentry->d_inode, REISER4_GENERIC_PTR_USED))
-		return RETERR(-EINVAL);
-	return vfs_readlink(dentry, buf, buflen, dentry->d_inode->u.generic_ip);
-}
-
-/**
  * follow_link_common - follow_link of inode operations
  * @dentry: dentry of symlink
  * @data:
diff -puN fs/reiser4/plugin/object.c~reiser4-fix-readlink fs/reiser4/plugin/object.c
--- linux-2.6.14-rc5-mm1/fs/reiser4/plugin/object.c~reiser4-fix-readlink	2005-11-11 17:57:23.578314329 +0300
+++ linux-2.6.14-rc5-mm1-vs/fs/reiser4/plugin/object.c	2005-11-11 17:57:23.638327165 +0300
@@ -202,7 +202,7 @@ file_plugin file_plugins[LAST_FILE_PLUGI
 			.linkage = {NULL,NULL}
 		},
 		.inode_ops = {
-			.readlink = readlink_common,
+			.readlink = generic_readlink,
 			.follow_link = follow_link_common,
 			.permission = permission_common,
 			.setattr = setattr_common,
diff -puN fs/reiser4/plugin/object.h~reiser4-fix-readlink fs/reiser4/plugin/object.h
--- linux-2.6.14-rc5-mm1/fs/reiser4/plugin/object.h~reiser4-fix-readlink	2005-11-11 17:57:23.582315185 +0300
+++ linux-2.6.14-rc5-mm1-vs/fs/reiser4/plugin/object.h	2005-11-11 17:57:23.650329732 +0300
@@ -23,7 +23,6 @@ int mknod_common(struct inode *parent, s
 		 int mode, dev_t rdev);
 int rename_common(struct inode *old_dir, struct dentry *old_name,
 		  struct inode *new_dir, struct dentry *new_name);
-int readlink_common(struct dentry *, char __user *buf, int buflen);
 void *follow_link_common(struct dentry *, struct nameidata *data);
 int permission_common(struct inode *, int mask,	/* mode bits to check permissions for */
 		      struct nameidata *nameidata);

_

--------------070203000306090103080500--



--------------020800080403040701020607--
