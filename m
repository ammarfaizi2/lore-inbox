Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbWGEXdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbWGEXdu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 19:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbWGEXdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 19:33:50 -0400
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:34973 "EHLO
	mail5.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S965066AbWGEXdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 19:33:49 -0400
Date: Wed, 5 Jul 2006 19:33:47 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>,
       Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 2/2] SELinux: add rootcontext= option to label root inode
 when mounting
In-Reply-To: <Pine.LNX.4.64.0607051931440.7944@d.namei>
Message-ID: <Pine.LNX.4.64.0607051932470.7944@d.namei>
References: <Pine.LNX.4.64.0607051931440.7944@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Paris <eparis@parisplace.org>

The second patch will introduce a new rootcontext= option to FS mounting. 
This option will allow you to explicitly label the root inode of a FS 
being mounted before that FS or inode because visable to userspace.  This 
was found to be useful for things like stateless linux, see 
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=190001

Signed-off-by: Eric Paris <eparis@parisplace.org>
Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: James Morris <jmorris@namei.org>

Please apply.

---

 security/selinux/hooks.c |   66 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 9 deletions(-)

--- linux-2.6.17/security/selinux/hooks.c.withdecouple	2006-07-05 12:39:46.000000000 -0400
+++ linux-2.6.17/security/selinux/hooks.c	2006-07-05 12:57:45.000000000 -0400
@@ -320,12 +320,14 @@ enum {
 	Opt_context = 1,
 	Opt_fscontext = 2,
 	Opt_defcontext = 4,
+	Opt_rootcontext = 8,
 };
 
 static match_table_t tokens = {
 	{Opt_context, "context=%s"},
 	{Opt_fscontext, "fscontext=%s"},
 	{Opt_defcontext, "defcontext=%s"},
+	{Opt_rootcontext, "rootcontext=%s"},
 };
 
 #define SEL_MOUNT_FAIL_MSG "SELinux:  duplicate or incompatible mount options\n"
@@ -346,10 +348,25 @@ static int may_context_mount_sb_relabel(
 	return rc;
 }
 
+static int may_context_mount_inode_relabel(u32 sid, 
+			struct superblock_security_struct *sbsec,
+			struct task_security_struct *tsec)
+{
+	int rc;
+	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
+			  FILESYSTEM__RELABELFROM, NULL);
+	if (rc)
+		return rc;
+
+	rc = avc_has_perm(sid, sbsec->sid, SECCLASS_FILESYSTEM,
+			  FILESYSTEM__ASSOCIATE, NULL);
+	return rc;
+}
+
 static int try_context_mount(struct super_block *sb, void *data)
 {
 	char *context = NULL, *defcontext = NULL;
-	char *fscontext = NULL;
+	char *fscontext = NULL, *rootcontext = NULL;
 	const char *name;
 	u32 sid;
 	int alloc = 0, rc = 0, seen = 0;
@@ -423,6 +440,22 @@ static int try_context_mount(struct supe
 				seen |= Opt_fscontext;
 				break;
 
+			case Opt_rootcontext:
+				if (seen & Opt_rootcontext) {
+					rc = -EINVAL;
+					printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
+					goto out_free;
+				}
+				rootcontext = match_strdup(&args[0]);
+				if (!rootcontext) {
+					rc = -ENOMEM;
+					goto out_free;
+				}
+				if (!alloc)
+					alloc = 1;
+				seen |= Opt_rootcontext;
+				break;
+
 			case Opt_defcontext:
 				if (sbsec->behavior != SECURITY_FS_USE_XATTR) {
 					rc = -EINVAL;
@@ -501,6 +534,25 @@ static int try_context_mount(struct supe
 		sbsec->behavior = SECURITY_FS_USE_MNTPOINT;
 	}
 
+	if (rootcontext) {
+		struct inode *inode = sb->s_root->d_inode;
+		struct inode_security_struct *isec = inode->i_security;
+		rc = security_context_to_sid(rootcontext, strlen(rootcontext), &sid);
+		if (rc) {
+			printk(KERN_WARNING "SELinux: security_context_to_sid"
+			       "(%s) failed for (dev %s, type %s) errno=%d\n",
+			       rootcontext, sb->s_id, name, rc);
+			goto out_free;
+		}
+
+		rc = may_context_mount_inode_relabel(sid, sbsec, tsec);
+		if (rc)
+			goto out_free;
+
+		isec->sid = sid;
+		isec->initialized = 1;
+	}
+
 	if (defcontext) {
 		rc = security_context_to_sid(defcontext, strlen(defcontext), &sid);
 		if (rc) {
@@ -513,13 +565,7 @@ static int try_context_mount(struct supe
 		if (sid == sbsec->def_sid)
 			goto out_free;
 
-		rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
-				  FILESYSTEM__RELABELFROM, NULL);
-		if (rc)
-			goto out_free;
-
-		rc = avc_has_perm(sid, sbsec->sid, SECCLASS_FILESYSTEM,
-				  FILESYSTEM__ASSOCIATE, NULL);
+		rc = may_context_mount_inode_relabel(sid, sbsec, tsec);
 		if (rc)
 			goto out_free;
 
@@ -531,6 +577,7 @@ out_free:
 		kfree(context);
 		kfree(defcontext);
 		kfree(fscontext);
+		kfree(rootcontext);
 	}
 out:
 	return rc;
@@ -1882,7 +1929,8 @@ static inline int selinux_option(char *o
 {
 	return (match_prefix("context=", sizeof("context=")-1, option, len) ||
 	        match_prefix("fscontext=", sizeof("fscontext=")-1, option, len) ||
-	        match_prefix("defcontext=", sizeof("defcontext=")-1, option, len));
+	        match_prefix("defcontext=", sizeof("defcontext=")-1, option, len) ||
+		match_prefix("rootcontext=", sizeof("rootcontext=")-1, option, len));
 }
 
 static inline void take_option(char **to, char *from, int *first, int len)
