Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWCRSoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWCRSoW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 13:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWCRSoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 13:44:21 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59022 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750784AbWCRSoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 13:44:21 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Michael Kerrisk <mtk-manpages@gmx.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, janak@us.ibm.com, viro@ftp.linux.org.uk,
       hch@lst.de, ak@muc.de, paulus@samba.org
Subject: Re: [PATCH] unshare: Cleanup up the sys_unshare interface before we
 are committed.
References: <Pine.LNX.4.64.0603161555210.3618@g5.osdl.org>
	<29085.1142557915@www064.gmx.net>
	<Pine.LNX.4.64.0603162140190.3618@g5.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 18 Mar 2006 11:41:55 -0700
In-Reply-To: <Pine.LNX.4.64.0603162140190.3618@g5.osdl.org> (Linus
 Torvalds's message of "Thu, 16 Mar 2006 21:42:53 -0800 (PST)")
Message-ID: <m1r74zzjbg.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 17 Mar 2006, Michael Kerrisk wrote:
>> 
>> >  - it's all the same issues that clone() has
>> 
>> At the moment, but possibly not in the future (if one day
>> usnhare() needs a flag that has no analogue in clone()).
>
> I don't believe that.
>
> If we have something we might want to unshare, that implies by definition 
> that it was something we wanted to conditionally share in the first place.
>
> IOW, it ends up being something that would be a clone() flag.
>
> So I really do believe that there is a fundamental 1:1 between the flags. 
> They aren't just "similar". They are very fundamentally about the same 
> thing, and giving two different names to the same thing is CONFUSING.
>
> 		Linus

Was there ever a good reason why we decided to flip the sense of
the bits?

I put a together a patch to see what the code would look like:

- We actually can reuse between clone and unshare.
- We don't need the confusing case of when to add additional resources
  to unshare.
- There is less total code.
- We don't confuse users and developers about the inverted values of
  the clone bits.

 kernel/fork.c |  105 ++++++++++++++++++++++++---------------------------------
 1 files changed, 45 insertions(+), 60 deletions(-)

28e4502c6d2ca48e0b4a08581123b2c3cf94454e
diff --git a/kernel/fork.c b/kernel/fork.c
index 411b10d..0eb0a37 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -900,6 +900,36 @@ asmlinkage long sys_set_tid_address(int 
 }
 
 /*
+ * Check constraints on flags passed to the clone or unshare system call.
+ */
+static int check_clone_flags(unsigned long clone_flags)
+{
+	int err = -EINVAL;
+	if ((clone_flags & (CLONE_NEWNS|CLONE_FS)) == (CLONE_NEWNS|CLONE_FS))
+		goto out;
+
+	/*
+	 * Thread groups must share signals as well, and detached threads
+	 * can only be started up within the thread group.
+	 */
+	if ((clone_flags & CLONE_THREAD) && !(clone_flags & CLONE_SIGHAND))
+		goto out;
+
+	/*
+	 * Shared signal handlers imply shared VM. By way of the above,
+	 * thread groups also imply shared VM. Blocking this case allows
+	 * for various simplifications in other code.
+	 */
+	if ((clone_flags & CLONE_SIGHAND) && !(clone_flags & CLONE_VM))
+		goto out;
+	
+	/* We made it here without problems */
+	err = 0;
+out:	
+	return err;
+}
+
+/*
  * This creates a new process as a copy of the old one,
  * but does not actually start it yet.
  *
@@ -918,23 +948,9 @@ static task_t *copy_process(unsigned lon
 	int retval;
 	struct task_struct *p = NULL;
 
-	if ((clone_flags & (CLONE_NEWNS|CLONE_FS)) == (CLONE_NEWNS|CLONE_FS))
-		return ERR_PTR(-EINVAL);
-
-	/*
-	 * Thread groups must share signals as well, and detached threads
-	 * can only be started up within the thread group.
-	 */
-	if ((clone_flags & CLONE_THREAD) && !(clone_flags & CLONE_SIGHAND))
-		return ERR_PTR(-EINVAL);
-
-	/*
-	 * Shared signal handlers imply shared VM. By way of the above,
-	 * thread groups also imply shared VM. Blocking this case allows
-	 * for various simplifications in other code.
-	 */
-	if ((clone_flags & CLONE_SIGHAND) && !(clone_flags & CLONE_VM))
-		return ERR_PTR(-EINVAL);
+	retval = check_clone_flags(clone_flags);
+	if (retval)
+		return ERR_PTR(retval);
 
 	retval = security_task_create(clone_flags);
 	if (retval)
@@ -1371,47 +1387,12 @@ void __init proc_caches_init(void)
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 }
 
-
-/*
- * Check constraints on flags passed to the unshare system call and
- * force unsharing of additional process context as appropriate.
- */
-static inline void check_unshare_flags(unsigned long *flags_ptr)
-{
-	/*
-	 * If unsharing a thread from a thread group, must also
-	 * unshare vm.
-	 */
-	if (*flags_ptr & CLONE_THREAD)
-		*flags_ptr |= CLONE_VM;
-
-	/*
-	 * If unsharing vm, must also unshare signal handlers.
-	 */
-	if (*flags_ptr & CLONE_VM)
-		*flags_ptr |= CLONE_SIGHAND;
-
-	/*
-	 * If unsharing signal handlers and the task was created
-	 * using CLONE_THREAD, then must unshare the thread
-	 */
-	if ((*flags_ptr & CLONE_SIGHAND) &&
-	    (atomic_read(&current->signal->count) > 1))
-		*flags_ptr |= CLONE_THREAD;
-
-	/*
-	 * If unsharing namespace, must also unshare filesystem information.
-	 */
-	if (*flags_ptr & CLONE_NEWNS)
-		*flags_ptr |= CLONE_FS;
-}
-
 /*
  * Unsharing of tasks created with CLONE_THREAD is not supported yet
  */
 static int unshare_thread(unsigned long unshare_flags)
 {
-	if (unshare_flags & CLONE_THREAD)
+	if (!(unshare_flags & CLONE_THREAD) && !thread_group_empty(current))
 		return -EINVAL;
 
 	return 0;
@@ -1424,7 +1405,7 @@ static int unshare_fs(unsigned long unsh
 {
 	struct fs_struct *fs = current->fs;
 
-	if ((unshare_flags & CLONE_FS) &&
+	if (!(unshare_flags & CLONE_FS) &&
 	    (fs && atomic_read(&fs->count) > 1)) {
 		*new_fsp = __copy_fs_struct(current->fs);
 		if (!*new_fsp)
@@ -1441,7 +1422,7 @@ static int unshare_namespace(unsigned lo
 {
 	struct namespace *ns = current->namespace;
 
-	if ((unshare_flags & CLONE_NEWNS) &&
+	if (!(unshare_flags & CLONE_NEWNS) &&
 	    (ns && atomic_read(&ns->count) > 1)) {
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
@@ -1462,7 +1443,7 @@ static int unshare_sighand(unsigned long
 {
 	struct sighand_struct *sigh = current->sighand;
 
-	if ((unshare_flags & CLONE_SIGHAND) &&
+	if (!(unshare_flags & CLONE_SIGHAND) &&
 	    (sigh && atomic_read(&sigh->count) > 1))
 		return -EINVAL;
 	else
@@ -1476,7 +1457,7 @@ static int unshare_vm(unsigned long unsh
 {
 	struct mm_struct *mm = current->mm;
 
-	if ((unshare_flags & CLONE_VM) &&
+	if (!(unshare_flags & CLONE_VM) &&
 	    (mm && atomic_read(&mm->mm_users) > 1)) {
 		*new_mmp = dup_mm(current);
 		if (!*new_mmp)
@@ -1494,7 +1475,7 @@ static int unshare_fd(unsigned long unsh
 	struct files_struct *fd = current->files;
 	int error = 0;
 
-	if ((unshare_flags & CLONE_FILES) &&
+	if (!(unshare_flags & CLONE_FILES) &&
 	    (fd && atomic_read(&fd->count) > 1)) {
 		*new_fdp = dup_fd(fd, &error);
 		if (!*new_fdp)
@@ -1510,7 +1491,9 @@ static int unshare_fd(unsigned long unsh
  */
 static int unshare_semundo(unsigned long unshare_flags, struct sem_undo_list **new_ulistp)
 {
-	if (unshare_flags & CLONE_SYSVSEM)
+	struct sem_undo_list *undo_list = current->sysvsem.undo_list;
+	if (!(unshare_flags & CLONE_SYSVSEM) && 
+	    undo_list && (atomic_read(&undo_list->refcnt) > 1))
 		return -EINVAL;
 
 	return 0;
@@ -1534,7 +1517,9 @@ asmlinkage long sys_unshare(unsigned lon
 	struct files_struct *fd, *new_fd = NULL;
 	struct sem_undo_list *new_ulist = NULL;
 
-	check_unshare_flags(&unshare_flags);
+	err = check_clone_flags(unshare_flags);
+	if (err)
+		goto bad_unshare_out;
        
 	/* Return -EINVAL for all unsupported flags */
 	err = -EINVAL;

