Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbUK3TZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbUK3TZW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 14:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUK3TZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 14:25:22 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:50319 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262266AbUK3TX1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 14:23:27 -0500
Subject: Re: 2.6.10-rc2-mm4
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Jeff Mahoney <jeffm@suse.com>,
       James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
In-Reply-To: <20041130095045.090de5ea.akpm@osdl.org>
References: <20041130095045.090de5ea.akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1101842310.4401.111.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 30 Nov 2004 14:18:30 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-30 at 12:50, Andrew Morton wrote:
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm4/
<snip>
> selinux-adds-a-private-inode-operation.patch
>   selinux: adds a private inode operation

Below is a re-base to 2.6.10-rc2-mm4 of a patch I posted earlier during
the original discussion of the above referenced patch.  This patch
removes the unnecessary code in inode_doinit_with_dentry, replaces the
unused inherits flag field (legacy from earlier code) with a private
flag field, does not set the SID in selinux_inode_mark_private (leaving
it with the unlabeled SID, which will ensure that we notice it if it
ever reaches a SELinux permission check), and modifies SELinux
permission checking functions and post_create() to test for the private
flag and skip SELinux processing in that case.  Please include if/when
the reiserfs/selinux patchset goes upstream.  I know that Chris Wright
had raised the question of whether we should be using i_flags to convey
the "private" nature of the inode rather than using a security hook, but
didn't see any resolution of that issue.

Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>

 security/selinux/hooks.c          |   27 ++++++++++++++++-----------
 security/selinux/include/objsec.h |    2 +-
 2 files changed, 17 insertions(+), 12 deletions(-)

diff -X /home/sds/dontdiff -rup linux-2.6.10-rc2-mm4/security/selinux/hooks.c linux-2.6.10-rc2-mm4-work/security/selinux/hooks.c
--- linux-2.6.10-rc2-mm4/security/selinux/hooks.c	2004-11-30 13:36:45.525519696 -0500
+++ linux-2.6.10-rc2-mm4-work/security/selinux/hooks.c	2004-11-30 13:52:30.550854008 -0500
@@ -737,15 +737,6 @@ static int inode_doinit_with_dentry(stru
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
@@ -983,6 +974,9 @@ int inode_has_perm(struct task_struct *t
 	tsec = tsk->security;
 	isec = inode->i_security;
 
+	if (isec->private)
+		return 0;
+
 	if (!adp) {
 		adp = &ad;
 		AVC_AUDIT_DATA_INIT(&ad, FS);
@@ -1064,6 +1058,9 @@ static int may_create(struct inode *dir,
 	dsec = dir->i_security;
 	sbsec = dir->i_sb->s_security;
 
+	if (dsec->private)
+		return 0;
+
 	AVC_AUDIT_DATA_INIT(&ad, FS);
 	ad.u.fs.dentry = dentry;
 
@@ -1111,6 +1108,9 @@ static int may_link(struct inode *dir,
 	dsec = dir->i_security;
 	isec = dentry->d_inode->i_security;
 
+	if (dsec->private)
+		return 0;
+
 	AVC_AUDIT_DATA_INIT(&ad, FS);
 	ad.u.fs.dentry = dentry;
 
@@ -1157,6 +1157,9 @@ static inline int may_rename(struct inod
 	old_is_dir = S_ISDIR(old_dentry->d_inode->i_mode);
 	new_dsec = new_dir->i_security;
 
+	if (old_dsec->private)
+		return 0;
+
 	AVC_AUDIT_DATA_INIT(&ad, FS);
 
 	ad.u.fs.dentry = old_dentry;
@@ -1292,6 +1295,9 @@ static int post_create(struct inode *dir
 	dsec = dir->i_security;
 	sbsec = dir->i_sb->s_security;
 
+	if (dsec->private)
+		return 0;
+
 	inode = dentry->d_inode;
 	if (!inode) {
 		/* Some file system types (e.g. NFS) may not instantiate
@@ -2379,9 +2385,8 @@ static void selinux_inode_mark_private(s
 {
 	struct inode_security_struct *isec = inode->i_security;
 
-	isec->sid = SECINITSID_KERNEL;
+	isec->private = 1;
 	isec->initialized = 1;
-	isec->inherit = 1;
 }
 
 /* file security operations */
diff -X /home/sds/dontdiff -rup linux-2.6.10-rc2-mm4/security/selinux/include/objsec.h linux-2.6.10-rc2-mm4-work/security/selinux/include/objsec.h
--- linux-2.6.10-rc2-mm4/security/selinux/include/objsec.h	2004-11-30 13:36:45.526519544 -0500
+++ linux-2.6.10-rc2-mm4-work/security/selinux/include/objsec.h	2004-11-30 13:52:30.551853856 -0500
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

