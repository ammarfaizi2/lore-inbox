Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbUKVSfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbUKVSfv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 13:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbUKVSeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 13:34:21 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:17600 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262318AbUKVSdR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 13:33:17 -0500
Subject: Re: [PATCH 2/5] selinux: adds a private inode operation
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Jeff Mahoney <jeffm@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       James Morris <jmorris@redhat.com>
In-Reply-To: <41A22A2D.1000708@suse.com>
References: <20041121001318.GC979@locomotive.unixthugs.org>
	 <1101145050.18273.68.camel@moss-spartans.epoch.ncsc.mil>
	 <41A22A2D.1000708@suse.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1101148090.18273.94.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 22 Nov 2004 13:28:10 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-22 at 13:04, Jeff Mahoney wrote:
> Yes, you're right. The isec->initialized check means that code never
> gets executed.

Ok.  How about the untested diff below relative to your patch?  It
removes the unnecessary code, replaces the unused inherits flag field
(legacy from earlier code) with a private flag field, does not set the
SID in selinux_inode_mark_private (leaving it with the unlabeled SID,
which will ensure that we notice it if it ever reaches a SELinux
permission check), and modifies SELinux permission checking functions
and post_create() to test for the private flag and skip SELinux
processing in that case.  Note that this means that reiserfs should be
able to use the VFS helpers if desired without interference by SELinux
when accessing these private inodes.

diff -X /home/sds/dontdiff -rup linux-2.6.10-rc2-mm3/security/selinux/hooks.c linux-2.6/security/selinux/hooks.c
--- linux-2.6.10-rc2-mm3/security/selinux/hooks.c	2004-11-22 08:30:49.000000000 -0500
+++ linux-2.6/security/selinux/hooks.c	2004-11-22 13:20:08.510714592 -0500
@@ -737,15 +736,6 @@ static int inode_doinit_with_dentry(stru
 	if (isec->initialized)
 		goto out;
 
-	if (opt_dentry && opt_dentry->d_parent && opt_dentry->d_parent->d_inode) {
-		struct inode_security_struct *pisec = opt_dentry->d_parent->d_inode->i_security;
-		if (pisec->inherit) {
-			isec->sid = pisec->sid;
-			isec->initialized = 1;
-			goto out;
-		}
-	}
-
 	down(&isec->sem);
 	hold_sem = 1;
 	if (isec->initialized)
@@ -983,6 +973,9 @@ int inode_has_perm(struct task_struct *t
 	tsec = tsk->security;
 	isec = inode->i_security;
 
+	if (isec->private)
+		return 0;
+
 	if (!adp) {
 		adp = &ad;
 		AVC_AUDIT_DATA_INIT(&ad, FS);
@@ -1064,6 +1057,9 @@ static int may_create(struct inode *dir,
 	dsec = dir->i_security;
 	sbsec = dir->i_sb->s_security;
 
+	if (dsec->private)
+		return 0;
+
 	AVC_AUDIT_DATA_INIT(&ad, FS);
 	ad.u.fs.dentry = dentry;
 
@@ -1111,6 +1107,9 @@ static int may_link(struct inode *dir,
 	dsec = dir->i_security;
 	isec = dentry->d_inode->i_security;
 
+	if (dsec->private)
+		return 0;
+
 	AVC_AUDIT_DATA_INIT(&ad, FS);
 	ad.u.fs.dentry = dentry;
 
@@ -1157,6 +1156,9 @@ static inline int may_rename(struct inod
 	old_is_dir = S_ISDIR(old_dentry->d_inode->i_mode);
 	new_dsec = new_dir->i_security;
 
+	if (old_dsec->private)
+		return 0;
+
 	AVC_AUDIT_DATA_INIT(&ad, FS);
 
 	ad.u.fs.dentry = old_dentry;
@@ -1292,7 +1294,10 @@ static int post_create(struct inode *dir
 	dsec = dir->i_security;
 	sbsec = dir->i_sb->s_security;
 
+	if (dsec->private)
+		return 0;
+
 	inode = dentry->d_inode;
 	if (!inode) {
 		/* Some file system types (e.g. NFS) may not instantiate

@@ -2379,9 +2384,8 @@ static void selinux_inode_mark_private(s
 {
 	struct inode_security_struct *isec = inode->i_security;
 
-	isec->sid = SECINITSID_KERNEL;
+	isec->private = 1;
 	isec->initialized = 1;
-	isec->inherit = 1;
 }
 
 /* file security operations */

diff -X /home/sds/dontdiff -rup linux-2.6.10-rc2-mm3/security/selinux/include/objsec.h linux-2.6/security/selinux/include/objsec.h
--- linux-2.6.10-rc2-mm3/security/selinux/include/objsec.h	2004-11-22 08:30:49.000000000 -0500
+++ linux-2.6/security/selinux/include/objsec.h	2004-11-22 13:00:22.418028088 -0500
@@ -45,7 +45,7 @@ struct inode_security_struct {
 	u16 sclass;       /* security class of this object */
 	unsigned char initialized;     /* initialization flag */
 	struct semaphore sem;
-	unsigned char inherit;         /* inherit SID from parent entry */
+       unsigned char private;         /* private file, skip checks */
 };
 
 struct file_security_struct {


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

