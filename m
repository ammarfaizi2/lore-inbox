Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbUBDPfb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 10:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbUBDPfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 10:35:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23531 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262123AbUBDPdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 10:33:17 -0500
Date: Wed, 4 Feb 2004 10:33:12 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>, Alexander Viro <aviro@redhat.com>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>,
       <selinux@tycho.nsa.gov>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH] (3/3) SELinux context mount support - SELinux changes.
In-Reply-To: <Xine.LNX.4.44.0402040949010.4796@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0402040953280.4796-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements context mount support within SELinux.

Three new mount options are provided:

context=%s
  Label the entire filesystem with the specified security context during
  mount and change the labeling behavior to 'mountpoint labeling'.  The 
  /proc/self/attr/fscreate attribute will be ignored for file creation on 
  the filesystem, although policy-specified transitions will still work 
  normally.  This also sets the aggregate filesystem security context.

fscontext=%s
  Set the label of the aggregate filesystem to the specified security 
  context, so that SELinux policy controls over the filesystem itself may 
  be reinstated.  Only works for filesystems without EA labeling support, 
  and is not valid if 'context' has been specified.

defcontext=%s
  Set the default security context for files created in this filesystem to 
  the specified security context (as opposed to the current global default).
  Only works for filesystems without EA labeling support, and is not 
  valid if 'context' has been specified.

To set the context or fscontext options, the security policy must specify
appropriate permissions for the filesystem relabelfrom and filesystem
relabelto controls.  For the defcontext option, the filesystem relablefrom
and filesystem assoicate controls are invoked.

The security mount options are parsed out and stripped from the normal 
mount option data so that no normal filesystems need to be aware of them.  

Filesystems with binary mount option data (e.g. NFS, SMBFS, AFS, Coda) 
need to be handled as special cases: only NFS is supprted at this stage 
per the previous patch.


 security/selinux/hooks.c            |  315 +++++++++++++++++++++++++++++++++---
 security/selinux/include/objsec.h   |    1 
 security/selinux/include/security.h |   12 -
 3 files changed, 303 insertions(+), 25 deletions(-)

diff -urN -X dontdiff linux-2.6.2.p/security/selinux/hooks.c linux-2.6.2.w/security/selinux/hooks.c
--- linux-2.6.2.p/security/selinux/hooks.c	2004-02-04 08:39:07.000000000 -0500
+++ linux-2.6.2.w/security/selinux/hooks.c	2004-02-04 09:08:51.914484008 -0500
@@ -56,6 +56,8 @@
 #include <linux/quota.h>
 #include <linux/un.h>		/* for Unix socket types */
 #include <net/af_unix.h>	/* for Unix socket types */
+#include <linux/parser.h>
+#include <linux/nfs_mount.h>
 
 #include "avc.h"
 #include "objsec.h"
@@ -223,6 +225,7 @@
 	sbsec->magic = SELINUX_MAGIC;
 	sbsec->sb = sb;
 	sbsec->sid = SECINITSID_UNLABELED;
+	sbsec->def_sid = SECINITSID_FILE;
 	sb->s_security = sbsec;
 
 	return 0;
@@ -283,12 +286,13 @@
 
 /* The file system's label must be initialized prior to use. */
 
-static char *labeling_behaviors[5] = {
+static char *labeling_behaviors[6] = {
 	"uses xattr",
 	"uses transition SIDs",
 	"uses task SIDs",
 	"uses genfs_contexts",
-	"not configured for labeling"
+	"not configured for labeling",
+	"uses mountpoint labeling",
 };
 
 static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry);
@@ -298,7 +302,200 @@
 	return inode_doinit_with_dentry(inode, NULL);
 }
 
-static int superblock_doinit(struct super_block *sb)
+enum {
+	Opt_context = 1,
+	Opt_fscontext = 2,
+	Opt_defcontext = 4,
+};
+
+static match_table_t tokens = {
+	{Opt_context, "context=%s"},
+	{Opt_fscontext, "fscontext=%s"},
+	{Opt_defcontext, "defcontext=%s"},
+};
+
+#define SEL_MOUNT_FAIL_MSG "SELinux:  duplicate or incompatible mount options\n"
+
+static int try_context_mount(struct super_block *sb, void *data)
+{
+	char *context = NULL, *defcontext = NULL;
+	const char *name;
+	u32 sid;
+	int alloc = 0, rc = 0, seen = 0;
+	struct task_security_struct *tsec = current->security;
+	struct superblock_security_struct *sbsec = sb->s_security;
+
+	if (!data)
+		goto out;
+	
+	name = sb->s_type->name;
+	
+	/* Ignore these fileystems with binary mount option data. */
+	if (!strcmp(name, "coda") ||
+	    !strcmp(name, "afs") || !strcmp(name, "smbfs"))
+		goto out;
+
+	/* NFS we understand. */
+	if (!strcmp(name, "nfs")) {
+		struct nfs_mount_data *d = data;
+		
+		if (d->version <  NFS_MOUNT_VERSION)
+			goto out;
+			
+		if (d->context[0]) {
+			context = d->context;
+			seen |= Opt_context;
+		}
+
+	/* Standard string-based options. */
+	} else {
+		char *p, *options = data;
+		
+		while ((p = strsep(&options, ",")) != NULL) {
+			int token;
+			substring_t args[MAX_OPT_ARGS];
+			
+			if (!*p)
+				continue;
+
+			token = match_token(p, tokens, args);
+
+			switch (token) {
+			case Opt_context:
+				if (seen) {
+					rc = -EINVAL;
+					printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
+					goto out_free;
+				}
+				context = match_strdup(&args[0]);
+				if (!context) {
+					rc = -ENOMEM;
+					goto out_free;
+				}
+				if (!alloc)
+					alloc = 1;
+				seen |= Opt_context;
+				break;
+			
+			case Opt_fscontext:
+				if (sbsec->behavior != SECURITY_FS_USE_XATTR) {
+					rc = -EINVAL;
+					printk(KERN_WARNING "SELinux:  "
+					       "fscontext option is invalid for"
+					       " this filesystem type\n");
+					goto out_free;
+				}
+				if (seen & (Opt_context|Opt_fscontext)) {
+					rc = -EINVAL;
+					printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
+					goto out_free;
+				}
+				context = match_strdup(&args[0]);
+				if (!context) {
+					rc = -ENOMEM;
+					goto out_free;
+				}
+				if (!alloc)
+					alloc = 1;
+				seen |= Opt_fscontext;
+				break;
+
+			case Opt_defcontext:
+				if (sbsec->behavior != SECURITY_FS_USE_XATTR) {
+					rc = -EINVAL;
+					printk(KERN_WARNING "SELinux:  "
+					       "defcontext option is invalid "
+					       "for this filesystem type\n");
+					goto out_free;
+				}
+				if (seen & (Opt_context|Opt_defcontext)) {
+					rc = -EINVAL;
+					printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
+					goto out_free;
+				}
+				defcontext = match_strdup(&args[0]);
+				if (!defcontext) {
+					rc = -ENOMEM;
+					goto out_free;
+				}
+				if (!alloc)
+					alloc = 1;
+				seen |= Opt_defcontext;
+				break;
+
+			default:
+				rc = -EINVAL;
+				printk(KERN_WARNING "SELinux:  unknown mount "
+				       "option\n");
+				goto out_free;
+			
+			}
+		}
+	}
+	
+	if (!seen)
+		goto out;
+
+	if (context) {
+		rc = security_context_to_sid(context, strlen(context), &sid);
+		if (rc) {
+			printk(KERN_WARNING "SELinux: security_context_to_sid"
+			       "(%s) failed for (dev %s, type %s) errno=%d\n",
+			       context, sb->s_id, name, rc);
+			goto out_free;
+		}
+		
+		rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
+		                  FILESYSTEM__RELABELFROM, NULL, NULL);
+		if (rc)
+			goto out_free;
+			
+		rc = avc_has_perm(tsec->sid, sid, SECCLASS_FILESYSTEM,
+		                  FILESYSTEM__RELABELTO, NULL, NULL);
+		if (rc)
+			goto out_free;
+			
+		sbsec->sid = sid;
+		
+		if (seen & Opt_context)
+			sbsec->behavior = SECURITY_FS_USE_MNTPOINT;
+	}
+
+	if (defcontext) {
+		rc = security_context_to_sid(defcontext, strlen(defcontext), &sid);
+		if (rc) {
+			printk(KERN_WARNING "SELinux: security_context_to_sid"
+			       "(%s) failed for (dev %s, type %s) errno=%d\n",
+			       defcontext, sb->s_id, name, rc);
+			goto out_free;
+		}
+
+		if (sid == sbsec->def_sid)
+			goto out_free;
+		
+		rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
+				  FILESYSTEM__RELABELFROM, NULL, NULL);
+		if (rc)
+			goto out_free;
+			
+		rc = avc_has_perm(sid, sbsec->sid, SECCLASS_FILESYSTEM,
+				  FILESYSTEM__ASSOCIATE, NULL, NULL); 
+		if (rc)
+			goto out_free;
+
+		sbsec->def_sid = sid;
+	}
+
+out_free:
+	if (alloc) {
+		kfree(context);
+		kfree(defcontext);
+	}
+out:
+	return rc;
+}
+
+static int superblock_doinit(struct super_block *sb, void *data)
 {
 	struct superblock_security_struct *sbsec = sb->s_security;
 	struct dentry *root = sb->s_root;
@@ -328,6 +525,10 @@
 		goto out;
 	}
 
+	rc = try_context_mount(sb, data);
+	if (rc)
+		goto out;
+
 	if (sbsec->behavior == SECURITY_FS_USE_XATTR) {
 		/* Make sure that the xattr handler exists and that no
 		   error other than -ENODATA is returned by getxattr on
@@ -530,7 +731,7 @@
 	switch (sbsec->behavior) {
 	case SECURITY_FS_USE_XATTR:
 		if (!inode->i_op->getxattr) {
-			isec->sid = SECINITSID_FILE;
+			isec->sid = sbsec->def_sid;
 			break;
 		}
 
@@ -589,7 +790,7 @@
 				goto out;
 			}
 			/* Map ENODATA to the default file SID */
-			sid = SECINITSID_FILE;
+			sid = sbsec->def_sid;
 			rc = 0;
 		} else {
 			rc = security_context_to_sid(context, rc, &sid);
@@ -829,6 +1030,7 @@
 
 	tsec = current->security;
 	dsec = dir->i_security;
+	sbsec = dir->i_sb->s_security;
 
 	AVC_AUDIT_DATA_INIT(&ad, FS);
 	ad.u.fs.dentry = dentry;
@@ -839,7 +1041,7 @@
 	if (rc)
 		return rc;
 
-	if (tsec->create_sid) {
+	if (tsec->create_sid && sbsec->behavior != SECURITY_FS_USE_MNTPOINT) {
 		newsid = tsec->create_sid;
 	} else {
 		rc = security_transition_sid(tsec->sid, dsec->sid, tclass,
@@ -852,8 +1054,6 @@
 	if (rc)
 		return rc;
 
-	sbsec = dir->i_sb->s_security;
-
 	return avc_has_perm(newsid, sbsec->sid,
 			    SECCLASS_FILESYSTEM,
 			    FILESYSTEM__ASSOCIATE, NULL, &ad);
@@ -1061,6 +1261,7 @@
 
 	tsec = current->security;
 	dsec = dir->i_security;
+	sbsec = dir->i_sb->s_security;
 
 	inode = dentry->d_inode;
 	if (!inode) {
@@ -1072,7 +1273,7 @@
 		return 0;
 	}
 
-	if (tsec->create_sid) {
+	if (tsec->create_sid && sbsec->behavior != SECURITY_FS_USE_MNTPOINT) {
 		newsid = tsec->create_sid;
 	} else {
 		rc = security_transition_sid(tsec->sid, dsec->sid,
@@ -1095,10 +1296,6 @@
 		return rc;
 	}
 
-	sbsec = dir->i_sb->s_security;
-	if (!sbsec)
-		return 0;
-
 	if (sbsec->behavior == SECURITY_FS_USE_XATTR &&
 	    inode->i_op->setxattr) {
 		/* Use extended attributes. */
@@ -1660,12 +1857,83 @@
 	superblock_free_security(sb);
 }
 
-static int selinux_sb_kern_mount(struct super_block *sb)
+static inline int match_prefix(char *prefix, int plen, char *option, int olen)
+{
+	if (plen > olen)
+		return 0;
+
+	return !memcmp(prefix, option, plen);
+}
+
+static inline int selinux_option(char *option, int len)
+{
+	return (match_prefix("context=", sizeof("context=")-1, option, len) ||
+	        match_prefix("fscontext=", sizeof("fscontext=")-1, option, len) ||
+	        match_prefix("defcontext=", sizeof("defcontext=")-1, option, len));
+}
+
+static inline void take_option(char **to, char *from, int *first, int len)
+{
+	if (!*first) {
+		**to = ',';
+		*to += 1;
+	}
+	else
+		*first = 0;
+	memcpy(*to, from, len);
+	*to += len;
+}
+
+static int selinux_sb_copy_data(const char *fstype, void *orig, void *copy)
+{
+	int fnosec, fsec, rc = 0;
+	char *in_save, *in_curr, *in_end;
+	char *sec_curr, *nosec_save, *nosec;
+
+	in_curr = orig;
+	sec_curr = copy;
+
+	/* Binary mount data: just copy */
+	if (!strcmp(fstype, "nfs") || !strcmp(fstype, "coda") ||
+	    !strcmp(fstype, "smbfs") || !strcmp(fstype, "afs")) {
+		copy_page(sec_curr, in_curr);
+		goto out;
+	}
+
+	nosec = (char *)get_zeroed_page(GFP_KERNEL);
+	if (!nosec) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	nosec_save = nosec;
+	fnosec = fsec = 1;
+	in_save = in_end = orig;
+
+	do {
+		if (*in_end == ',' || *in_end == '\0') {
+			int len = in_end - in_curr;
+			
+			if (selinux_option(in_curr, len))
+				take_option(&sec_curr, in_curr, &fsec, len);
+			else
+				take_option(&nosec, in_curr, &fnosec, len);
+
+			in_curr = in_end + 1;
+		}
+	} while (*in_end++);
+	
+	copy_page(in_save, nosec_save);
+out:
+	return rc;
+}
+
+static int selinux_sb_kern_mount(struct super_block *sb, void *data)
 {
 	struct avc_audit_data ad;
 	int rc;
 
-	rc = superblock_doinit(sb);
+	rc = superblock_doinit(sb, data);
 	if (rc)
 		return rc;
 
@@ -1857,6 +2125,10 @@
 		return dentry_has_perm(current, NULL, dentry, FILE__SETATTR);
 	}
 
+	sbsec = inode->i_sb->s_security;
+	if (sbsec->behavior == SECURITY_FS_USE_MNTPOINT)
+		return -ENOTSUPP;
+
 	AVC_AUDIT_DATA_INIT(&ad,FS);
 	ad.u.fs.dentry = dentry;
 
@@ -1875,10 +2147,6 @@
 	if (rc)
 		return rc;
 
-	sbsec = inode->i_sb->s_security;
-	if (!sbsec)
-		return 0;
-
 	return avc_has_perm(newsid,
 			    sbsec->sid,
 			    SECCLASS_FILESYSTEM,
@@ -1913,6 +2181,12 @@
 
 static int selinux_inode_getxattr (struct dentry *dentry, char *name)
 {
+	struct inode *inode = dentry->d_inode;
+	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
+	
+	if (sbsec->behavior == SECURITY_FS_USE_MNTPOINT)
+		return -ENOTSUPP;
+
 	return dentry_has_perm(current, NULL, dentry, FILE__GETATTR);
 }
 
@@ -3555,6 +3829,7 @@
 
 	.sb_alloc_security =		selinux_sb_alloc_security,
 	.sb_free_security =		selinux_sb_free_security,
+	.sb_copy_data =			selinux_sb_copy_data,
 	.sb_kern_mount =	        selinux_sb_kern_mount,
 	.sb_statfs =			selinux_sb_statfs,
 	.sb_mount =			selinux_mount,
@@ -3731,7 +4006,7 @@
 		spin_unlock(&sb_security_lock);
 		down_read(&sb->s_umount);
 		if (sb->s_root)
-			superblock_doinit(sb);
+			superblock_doinit(sb, NULL);
 		drop_super(sb);
 		spin_lock(&sb_security_lock);
 		list_del_init(&sbsec->list);
diff -urN -X dontdiff linux-2.6.2.p/security/selinux/include/objsec.h linux-2.6.2.w/security/selinux/include/objsec.h
--- linux-2.6.2.p/security/selinux/include/objsec.h	2004-02-04 08:39:07.000000000 -0500
+++ linux-2.6.2.w/security/selinux/include/objsec.h	2004-02-04 09:08:51.915483856 -0500
@@ -63,6 +63,7 @@
 	struct super_block *sb;         /* back pointer to sb object */
 	struct list_head list;          /* list of superblock_security_struct */
 	u32 sid;              /* SID of file system */
+	u32 def_sid;			/* default SID for labeling */
 	unsigned int behavior;          /* labeling behavior */
 	unsigned char initialized;      /* initialization flag */
 	unsigned char proc;             /* proc fs */
diff -urN -X dontdiff linux-2.6.2.p/security/selinux/include/security.h linux-2.6.2.w/security/selinux/include/security.h
--- linux-2.6.2.p/security/selinux/include/security.h	2003-10-28 10:59:50.000000000 -0500
+++ linux-2.6.2.w/security/selinux/include/security.h	2004-02-04 09:08:51.916483704 -0500
@@ -62,11 +62,13 @@
 int security_node_sid(u16 domain, void *addr, u32 addrlen,
 	u32 *out_sid);
 
-#define SECURITY_FS_USE_XATTR 1 /* use xattr */
-#define SECURITY_FS_USE_TRANS 2 /* use transition SIDs, e.g. devpts/tmpfs */
-#define SECURITY_FS_USE_TASK  3 /* use task SIDs, e.g. pipefs/sockfs */
-#define SECURITY_FS_USE_GENFS 4 /* use the genfs support */
-#define SECURITY_FS_USE_NONE  5 /* no labeling support */
+#define SECURITY_FS_USE_XATTR		1 /* use xattr */
+#define SECURITY_FS_USE_TRANS		2 /* use transition SIDs, e.g. devpts/tmpfs */
+#define SECURITY_FS_USE_TASK		3 /* use task SIDs, e.g. pipefs/sockfs */
+#define SECURITY_FS_USE_GENFS		4 /* use the genfs support */
+#define SECURITY_FS_USE_NONE		5 /* no labeling support */
+#define SECURITY_FS_USE_MNTPOINT	6 /* use mountpoint labeling */
+
 int security_fs_use(const char *fstype, unsigned int *behavior,
 	u32 *sid);
 




