Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752409AbWCPQwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752409AbWCPQwe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 11:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752413AbWCPQwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 11:52:34 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35810 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1752407AbWCPQwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 11:52:33 -0500
To: Linus Torvalds <torvalds@osdl.org>
CC: <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Janak Desai <janak@us.ibm.com>, Al Viro <viro@ftp.linux.org.uk>,
       Christoph Hellwig <hch@lst.de>, Michael Kerrisk <mtk-manpages@gmx.net>,
       Andi Kleen <ak@muc.de>, Paul Mackerras <paulus@samba.org>,
       JANAK DESAI <janak@us.ibm.com>
Subject: [PATCH] unshare: Cleanup up the sys_unshare interface before we are
 committed.
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 16 Mar 2006 09:49:08 -0700
Message-ID: <m1y7za9vy3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since we have not crossed the magic 2.6.16 line can we please
include this patch.  My apologies for catching this so late in the
cycle.

- Error if we are passed any flags we don't expect.

  This preserves forward compatibility so programs that use new flags that
  run on old kernels will fail instead of silently doing the wrong thing.

- Use separate defines from sys_clone.

  sys_unshare can't implement half of the clone flags under any circumstances
  and those that it does implement have subtlely different semantics than
  the clone flags.  Using a different set of flags sets the
  expectation that things will be different.

  Binary compatibility with current users of the is still maintained
  as the unshare flags and the clone flags have the same values.


Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 include/linux/sched.h |   17 +++++++++++++++++
 kernel/fork.c         |   34 +++++++++++++++++++---------------
 2 files changed, 36 insertions(+), 15 deletions(-)

1b9e67b9696f1e828ba789d3f6c8247d1171f367
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 62e6314..8e46f05 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -69,6 +69,23 @@ struct exec_domain;
 #define CLONE_KERNEL	(CLONE_FS | CLONE_FILES | CLONE_SIGHAND)
 
 /*
+ * unsharing flags: (Keep in sync with the clone flags if possible)
+ */
+#define UNSHARE_VM	0x00000100	/* stop sharing the VM between processes */
+#define UNSHARE_FS	0x00000200	/* stop sharing the fs info between processes */
+#define UNSHARE_FILES	0x00000400	/* stop sharing open files between processes */
+#define UNSHARE_SIGHAND	0x00000800	/* stop sharing signal handlers and blocked signals */
+#define UNSHARE_THREAD	0x00010000	/* stop sharing a thread group */
+#define UNSHARE_NS	0x00020000	/* stop sharing the mount namespace */
+#define UNSHARE_SYSVSEM	0x00040000	/* stop sharing system V SEM_UNDO semantics */
+
+/*
+ * Helper so sys_unshare can check if it is passed valid flags.
+ */
+#define UNSHARE_VALID	(UNSHARE_VM|UNSHARE_FS|UNSHARE_FILES|UNSHARE_SIGHAND| \
+				UNSHARE_THREAD|UNSHARE_NS|UNSHARE_SYSVSEM)
+
+/*
  * These are the constant used to fake the fixed-point load-average
  * counting. Some notes:
  *  - 11 bit fractions expand to 22 bits by the multiplies: this gives
diff --git a/kernel/fork.c b/kernel/fork.c
index ccdfbb1..d2706e9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1382,28 +1382,28 @@ static inline void check_unshare_flags(u
 	 * If unsharing a thread from a thread group, must also
 	 * unshare vm.
 	 */
-	if (*flags_ptr & CLONE_THREAD)
-		*flags_ptr |= CLONE_VM;
+	if (*flags_ptr & UNSHARE_THREAD)
+		*flags_ptr |= UNSHARE_VM;
 
 	/*
 	 * If unsharing vm, must also unshare signal handlers.
 	 */
-	if (*flags_ptr & CLONE_VM)
-		*flags_ptr |= CLONE_SIGHAND;
+	if (*flags_ptr & UNSHARE_VM)
+		*flags_ptr |= UNSHARE_SIGHAND;
 
 	/*
 	 * If unsharing signal handlers and the task was created
 	 * using CLONE_THREAD, then must unshare the thread
 	 */
-	if ((*flags_ptr & CLONE_SIGHAND) &&
+	if ((*flags_ptr & UNSHARE_SIGHAND) &&
 	    (atomic_read(&current->signal->count) > 1))
-		*flags_ptr |= CLONE_THREAD;
+		*flags_ptr |= UNSHARE_THREAD;
 
 	/*
 	 * If unsharing namespace, must also unshare filesystem information.
 	 */
-	if (*flags_ptr & CLONE_NEWNS)
-		*flags_ptr |= CLONE_FS;
+	if (*flags_ptr & UNSHARE_NS)
+		*flags_ptr |= UNSHARE_FS;
 }
 
 /*
@@ -1411,7 +1411,7 @@ static inline void check_unshare_flags(u
  */
 static int unshare_thread(unsigned long unshare_flags)
 {
-	if (unshare_flags & CLONE_THREAD)
+	if (unshare_flags & UNSHARE_THREAD)
 		return -EINVAL;
 
 	return 0;
@@ -1424,7 +1424,7 @@ static int unshare_fs(unsigned long unsh
 {
 	struct fs_struct *fs = current->fs;
 
-	if ((unshare_flags & CLONE_FS) &&
+	if ((unshare_flags & UNSHARE_FS) &&
 	    (fs && atomic_read(&fs->count) > 1)) {
 		*new_fsp = __copy_fs_struct(current->fs);
 		if (!*new_fsp)
@@ -1441,7 +1441,7 @@ static int unshare_namespace(unsigned lo
 {
 	struct namespace *ns = current->namespace;
 
-	if ((unshare_flags & CLONE_NEWNS) &&
+	if ((unshare_flags & UNSHARE_NS) &&
 	    (ns && atomic_read(&ns->count) > 1)) {
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
@@ -1462,7 +1462,7 @@ static int unshare_sighand(unsigned long
 {
 	struct sighand_struct *sigh = current->sighand;
 
-	if ((unshare_flags & CLONE_SIGHAND) &&
+	if ((unshare_flags & UNSHARE_SIGHAND) &&
 	    (sigh && atomic_read(&sigh->count) > 1))
 		return -EINVAL;
 	else
@@ -1476,7 +1476,7 @@ static int unshare_vm(unsigned long unsh
 {
 	struct mm_struct *mm = current->mm;
 
-	if ((unshare_flags & CLONE_VM) &&
+	if ((unshare_flags & UNSHARE_VM) &&
 	    (mm && atomic_read(&mm->mm_users) > 1)) {
 		*new_mmp = dup_mm(current);
 		if (!*new_mmp)
@@ -1494,7 +1494,7 @@ static int unshare_fd(unsigned long unsh
 	struct files_struct *fd = current->files;
 	int error = 0;
 
-	if ((unshare_flags & CLONE_FILES) &&
+	if ((unshare_flags & UNSHARE_FILES) &&
 	    (fd && atomic_read(&fd->count) > 1)) {
 		*new_fdp = dup_fd(fd, &error);
 		if (!*new_fdp)
@@ -1510,7 +1510,7 @@ static int unshare_fd(unsigned long unsh
  */
 static int unshare_semundo(unsigned long unshare_flags, struct sem_undo_list **new_ulistp)
 {
-	if (unshare_flags & CLONE_SYSVSEM)
+	if (unshare_flags & UNSHARE_SYSVSEM)
 		return -EINVAL;
 
 	return 0;
@@ -1534,6 +1534,10 @@ asmlinkage long sys_unshare(unsigned lon
 	struct files_struct *fd, *new_fd = NULL;
 	struct sem_undo_list *new_ulist = NULL;
 
+	/* Only accept valid unshare flags */
+	if (unshare_flags & ~UNSHARE_VALID)
+		return -EINVAL;
+
 	check_unshare_flags(&unshare_flags);
 
 	if ((err = unshare_thread(unshare_flags)))
-- 
1.2.4.g2d33

