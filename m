Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbVHKV0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbVHKV0V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 17:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbVHKV0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 17:26:21 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:23998 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750974AbVHKV0U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 17:26:20 -0400
Date: Thu, 11 Aug 2005 16:24:03 -0500
From: serue@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: [PATCH] [LSM - stacker] ext2+ext3 init_security stacking
Message-ID: <20050811212403.GD28004@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch redies ext2 and ext3 for stacking inode_init_security.  It
mainly needs to check for multiple name/value pairs, and call xattr_set
for each pair.

thanks,
-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
--
 ext2/xattr_security.c |   30 ++++++++++++++++++++++++++----
 ext3/xattr_security.c |   35 +++++++++++++++++++++++++++++++----
 2 files changed, 57 insertions(+), 8 deletions(-)

Index: linux-2.6.13-rc5-mm1/fs/ext2/xattr_security.c
===================================================================
--- linux-2.6.13-rc5-mm1.orig/fs/ext2/xattr_security.c	2005-08-11 18:55:45.000000000 -0500
+++ linux-2.6.13-rc5-mm1/fs/ext2/xattr_security.c	2005-08-11 19:08:18.000000000 -0500
@@ -50,9 +50,10 @@ int
 ext2_init_security(struct inode *inode, struct inode *dir)
 {
 	int err;
-	size_t len;
+	size_t len, runlen;
 	void *value;
-	char *name;
+	char *vfirst, *vstart, *vend;
+	char *name, *nstart, *nend;
 
 	err = security_inode_init_security(inode, dir, &name, &value, &len);
 	if (err) {
@@ -60,8 +61,29 @@ ext2_init_security(struct inode *inode, 
 			return 0;
 		return err;
 	}
-	err = ext2_xattr_set(inode, EXT2_XATTR_INDEX_SECURITY,
-			     name, value, len, 0);
+	runlen = 0;
+	vstart = vfirst = value;
+	nstart = name;
+	do {
+		size_t tmplen = 0;
+
+		vend = vstart;
+		while (*vend && runlen+tmplen<len)
+			vend++;
+		while (!*nstart)
+			nstart++;
+		nend = nstart;
+		while (*nend)
+			nend++;
+
+		err = ext2_xattr_set(inode, EXT2_XATTR_INDEX_SECURITY,
+				     nstart, vstart, tmplen, 0);
+		vstart = vend;
+		while (!(*vstart) && vstart-vfirst<len)
+			vstart++;
+		nstart = nend;
+	} while (vstart-vfirst < len);
+
 	kfree(name);
 	kfree(value);
 	return err;
Index: linux-2.6.13-rc5-mm1/fs/ext3/xattr_security.c
===================================================================
--- linux-2.6.13-rc5-mm1.orig/fs/ext3/xattr_security.c	2005-08-11 18:55:45.000000000 -0500
+++ linux-2.6.13-rc5-mm1/fs/ext3/xattr_security.c	2005-08-11 19:09:49.000000000 -0500
@@ -52,9 +52,10 @@ int
 ext3_init_security(handle_t *handle, struct inode *inode, struct inode *dir)
 {
 	int err;
-	size_t len;
+	size_t len, runlen;
 	void *value;
-	char *name;
+	char *vfirst, *vstart, *vend;
+	char *name, *nstart, *nend;
 
 	err = security_inode_init_security(inode, dir, &name, &value, &len);
 	if (err) {
@@ -62,8 +63,34 @@ ext3_init_security(handle_t *handle, str
 			return 0;
 		return err;
 	}
-	err = ext3_xattr_set_handle(handle, inode, EXT3_XATTR_INDEX_SECURITY,
-				    name, value, len, 0);
+	runlen = 0;
+	vstart = vfirst = value;
+	nstart = name;
+	do {
+		size_t tmplen = 0;
+
+		vend = vstart;
+		while (*vend && runlen+tmplen<len)
+			vend++;
+		while (!*nstart)
+			nstart++;
+		nend = nstart;
+		while (*nend)
+			nend++;
+
+		if (err) {
+			if (err == -EOPNOTSUPP)
+				return 0;
+			return err;
+		}
+		err = ext3_xattr_set_handle(handle, inode, EXT3_XATTR_INDEX_SECURITY,
+					    nstart, vstart, tmplen, 0);
+		vstart = vend;
+		while (!(*vstart) && vstart-vfirst<len)
+			vstart++;
+		nstart = nend;
+	} while (vstart-vfirst < len);
+
 	kfree(name);
 	kfree(value);
 	return err;
