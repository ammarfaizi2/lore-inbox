Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbVKKTUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbVKKTUX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbVKKTUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:20:23 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:34946 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751041AbVKKTUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:20:21 -0500
Message-ID: <4374EEF5.2010609@namesys.com>
Date: Fri, 11 Nov 2005 11:20:21 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [Fwd: [PATCH 1/3] reiser4-remove-rwx-perm-plugin.patch]
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020809000406010209010205"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020809000406010209010205
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



--------------020809000406010209010205
Content-Type: message/rfc822;
 name="[PATCH 1/3] reiser4-remove-rwx-perm-plugin.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH 1/3] reiser4-remove-rwx-perm-plugin.patch"

Return-Path: <vs@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 19932 invoked from network); 11 Nov 2005 16:16:30 -0000
Received: from ppp85-140-14-29.pppoe.mtu-net.ru (HELO ?192.168.1.10?) (85.140.14.29)
  by thebsh.namesys.com with SMTP; 11 Nov 2005 16:16:30 -0000
Message-ID: <4374C3D4.5000602@namesys.com>
Date: Fri, 11 Nov 2005 19:16:20 +0300
From: "Vladimir V. Saveliev" <vs@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
Subject: [PATCH 1/3] reiser4-remove-rwx-perm-plugin.patch
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------050504040301030708050902"

This is a multi-part message in MIME format.
--------------050504040301030708050902
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------050504040301030708050902
Content-Type: text/plain;
 name="reiser4-remove-rwx-perm-plugin.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reiser4-remove-rwx-perm-plugin.patch"


From: Hans Reiser <reiser@namesys.com>

Security plugin duplicating LSM is removed.

Signed-off-by: Vladimir V. Saveliev <vs@namesys.com>


 fs/reiser4/init_super.c               |    2 -
 fs/reiser4/plugin/dir_plugin_common.c |    4 --
 fs/reiser4/plugin/inode_ops.c         |   40 +++++-----------------
 fs/reiser4/plugin/security/perm.c     |   61 ++++------------------------------
 fs/reiser4/plugin/security/perm.h     |   13 -------
 5 files changed, 20 insertions(+), 100 deletions(-)

diff -puN fs/reiser4/init_super.c~reiser4-remove-rwx-perm-plugin fs/reiser4/init_super.c
--- linux-2.6.14-rc5-mm1/fs/reiser4/init_super.c~reiser4-remove-rwx-perm-plugin	2005-11-11 17:55:57.775962799 +0300
+++ linux-2.6.14-rc5-mm1-vs/fs/reiser4/init_super.c	2005-11-11 17:55:57.907991038 +0300
@@ -626,7 +626,7 @@ static struct {
 	},
 	[PSET_PERM] = {
 		.type = REISER4_PERM_PLUGIN_TYPE,
-		.id = RWX_PERM_ID
+		.id = NULL_PERM_ID
 	},
 	[PSET_FORMATTING] = {
 		.type = REISER4_FORMATTING_PLUGIN_TYPE,
diff -puN fs/reiser4/plugin/dir_plugin_common.c~reiser4-remove-rwx-perm-plugin fs/reiser4/plugin/dir_plugin_common.c
--- linux-2.6.14-rc5-mm1/fs/reiser4/plugin/dir_plugin_common.c~reiser4-remove-rwx-perm-plugin	2005-11-11 17:55:57.807969645 +0300
+++ linux-2.6.14-rc5-mm1-vs/fs/reiser4/plugin/dir_plugin_common.c	2005-11-11 17:55:57.931996172 +0300
@@ -488,10 +488,6 @@ int lookup_name(struct inode *parent,	/*
 	assert("vs-1486",
 	       dentry->d_op == &get_super_private(parent->i_sb)->ops.dentry);
 
-	result = perm_chk(parent, lookup, parent, dentry);
-	if (result != 0)
-		return 0;
-
 	name = dentry->d_name.name;
 	len = dentry->d_name.len;
 
diff -puN fs/reiser4/plugin/inode_ops.c~reiser4-remove-rwx-perm-plugin fs/reiser4/plugin/inode_ops.c
--- linux-2.6.14-rc5-mm1/fs/reiser4/plugin/inode_ops.c~reiser4-remove-rwx-perm-plugin	2005-11-11 17:55:57.819972212 +0300
+++ linux-2.6.14-rc5-mm1-vs/fs/reiser4/plugin/inode_ops.c	2005-11-11 17:55:57.911991894 +0300
@@ -150,14 +150,6 @@ int link_common(struct dentry *existing,
 		return RETERR(-EISDIR);
 	}
 
-	/* check permissions */
-	result = perm_chk(parent, link, existing, parent, newname);
-	if (result != 0) {
-		context_set_commit_async(ctx);
-		reiser4_exit_context(ctx);
-		return result;
-	}
-
 	parent_dplug = inode_dir_plugin(parent);
 
 	memset(&entry, 0, sizeof entry);
@@ -438,20 +430,18 @@ void *follow_link_common(struct dentry *
 	return NULL;
 }
 
-/* this is common implementation of vfs's permission method of struct
-   inode_operations
-*/
-int permission_common(struct inode *inode /* object */ ,
-		      int mask,	/* mode bits to check permissions for */
+/**
+ * permission_common - permission of inode operations
+ * @inode: inode to check permissions for
+ * @mask: mode bits to check permissions for
+ * @nameidata:
+ *
+ * Uses generic function to check for rwx permissions.
+ */
+int permission_common(struct inode *inode, int mask,
 		      struct nameidata *nameidata)
 {
-	/* reiser4_context creation/destruction removed from here,
-	   because permission checks currently don't require this.
-
-	   Permission plugin have to create context itself if necessary. */
-	assert("nikita-1687", inode != NULL);
-
-	return perm_chk(inode, mask, inode, mask);
+	return generic_permission(inode, mask, NULL);
 }
 
 static int setattr_reserve(reiser4_tree *);
@@ -597,11 +587,6 @@ static int do_create_vfs_child(reiser4_o
 	assert("nikita-1418", parent != NULL);
 	assert("nikita-1419", dentry != NULL);
 
-	/* check permissions */
-	result = perm_chk(parent, create, parent, dentry, data);
-	if (result != 0)
-		return result;
-
 	/* check, that name is acceptable for parent */
 	par_dir = inode_dir_plugin(parent);
 	if (par_dir->is_name_acceptable &&
@@ -901,11 +886,6 @@ static int unlink_check_and_grab(struct 
 	/* object being deleted should have stat data */
 	assert("vs-949", !inode_get_flag(child, REISER4_NO_SD));
 
-	/* check permissions */
-	result = perm_chk(parent, unlink, parent, victim);
-	if (result != 0)
-		return result;
-
 	/* ask object plugin */
 	if (fplug->can_rem_link != NULL && !fplug->can_rem_link(child))
 		return RETERR(-ENOTEMPTY);
diff -puN fs/reiser4/plugin/security/perm.c~reiser4-remove-rwx-perm-plugin fs/reiser4/plugin/security/perm.c
--- linux-2.6.14-rc5-mm1/fs/reiser4/plugin/security/perm.c~reiser4-remove-rwx-perm-plugin	2005-11-11 17:55:57.839976491 +0300
+++ linux-2.6.14-rc5-mm1-vs/fs/reiser4/plugin/security/perm.c	2005-11-11 17:55:57.887986759 +0300
@@ -9,70 +9,25 @@
 #include "../plugin_header.h"
 #include "../../debug.h"
 
-#include <linux/fs.h>
-#include <linux/dcache.h>	/* for struct dentry */
-#include <linux/quotaops.h>
-#include <asm/uaccess.h>
-
-static int mask_ok_common(struct inode *inode, int mask)
-{
-	return generic_permission(inode, mask, NULL);
-}
-
-static int setattr_ok_common(struct dentry *dentry, struct iattr *attr)
-{
-	int result;
-	struct inode *inode;
-
-	assert("nikita-2272", dentry != NULL);
-	assert("nikita-2273", attr != NULL);
-
-	inode = dentry->d_inode;
-	assert("nikita-2274", inode != NULL);
-
-	result = inode_change_ok(inode, attr);
-	if (result == 0) {
-		unsigned int valid;
-
-		valid = attr->ia_valid;
-		if ((valid & ATTR_UID && attr->ia_uid != inode->i_uid) ||
-		    (valid & ATTR_GID && attr->ia_gid != inode->i_gid))
-			result = DQUOT_TRANSFER(inode, attr) ? -EDQUOT : 0;
-	}
-	return result;
-}
-
-static int
-read_ok_common(struct file *file, const char __user *buf, size_t size, loff_t * off)
-{
-	return access_ok(VERIFY_WRITE, buf, size) ? 0 : -EFAULT;
-}
-
-static int
-write_ok_common(struct file *file, const char __user *buf, size_t size, loff_t * off)
-{
-	return access_ok(VERIFY_READ, buf, size) ? 0 : -EFAULT;
-}
-
 perm_plugin perm_plugins[LAST_PERM_ID] = {
-	[RWX_PERM_ID] = {
+	[NULL_PERM_ID] = {
 		.h = {
 			.type_id = REISER4_PERM_PLUGIN_TYPE,
-			.id = RWX_PERM_ID,
+			.id = NULL_PERM_ID,
 			.pops = NULL,
-			.label = "rwx",
-			.desc = "standard UNIX permissions",
+			.label = "null",
+			.desc = "stub permission plugin",
 			.linkage = {NULL, NULL}
 		},
-		.read_ok = read_ok_common,
-		.write_ok = write_ok_common,
+		.read_ok = NULL,
+		.write_ok = NULL,
 		.lookup_ok = NULL,
 		.create_ok = NULL,
 		.link_ok = NULL,
 		.unlink_ok = NULL,
 		.delete_ok = NULL,
-		.mask_ok = mask_ok_common,
-		.setattr_ok = setattr_ok_common,
+		.mask_ok = NULL,
+		.setattr_ok = NULL,
 		.getattr_ok = NULL,
 		.rename_ok = NULL,
 	}
diff -puN fs/reiser4/plugin/security/perm.h~reiser4-remove-rwx-perm-plugin fs/reiser4/plugin/security/perm.h
--- linux-2.6.14-rc5-mm1/fs/reiser4/plugin/security/perm.h~reiser4-remove-rwx-perm-plugin	2005-11-11 17:55:57.843977346 +0300
+++ linux-2.6.14-rc5-mm1-vs/fs/reiser4/plugin/security/perm.h	2005-11-11 17:55:57.907991038 +0300
@@ -65,19 +65,8 @@ typedef struct perm_plugin {
 	int (*rename_ok) (struct inode * old_dir, struct dentry * old,
 			  struct inode * new_dir, struct dentry * new);
 } perm_plugin;
-/* NIKITA-FIXME-HANS: I really hate things like this that kill the ability of Meta-. to work.  Please eliminate this macro, exce */
-/* call ->check_ok method of perm plugin for inode */
-#define perm_chk(inode, check, ...)			\
-({							\
-	perm_plugin *perm;				\
-							\
-	perm = inode_perm_plugin(inode);		\
-	(perm == NULL || perm->check ## _ok == NULL) ?	\
-		0 :					\
-		perm->check ## _ok(__VA_ARGS__);	\
-})
 
-typedef enum { RWX_PERM_ID, LAST_PERM_ID } reiser4_perm_id;
+typedef enum { NULL_PERM_ID, LAST_PERM_ID } reiser4_perm_id;
 
 /* __REISER4_PERM_H__ */
 #endif

_

--------------050504040301030708050902--



--------------020809000406010209010205--
