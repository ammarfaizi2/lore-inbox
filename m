Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272074AbRIRPLm>; Tue, 18 Sep 2001 11:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272090AbRIRPLd>; Tue, 18 Sep 2001 11:11:33 -0400
Received: from t2.redhat.com ([199.183.24.243]:12026 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S272074AbRIRPLV>; Tue, 18 Sep 2001 11:11:21 -0400
To: David Howells <dhowells@redhat.com>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Andrea Arcangeli <andrea@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>, Ulrich.Weigand@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem 
In-Reply-To: Message from David Howells <dhowells@redhat.com> 
   of "Tue, 18 Sep 2001 15:13:45 BST." <5552.1000822425@warthog.cambridge.redhat.com> 
Date: Tue, 18 Sep 2001 16:11:44 +0100
Message-ID: <6401.1000825904@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay tested patch to cure coredumping of the need to hold the mm semaphore:

	- kernel/fork.c: function to partially copy an mm_struct and attach it
			 to the task_struct in place of the old.

	- include/linux/mm.h: declaration for above function

	- fs/exec.c: have do_coredump() call this function and not get the
		     read lock around the binfmt coredumper

It works, and you can core dump without oopsing.

David

diff -uNr -x TAGS linux-2.4.10-pre11/fs/exec.c linux-rwsem/fs/exec.c
--- linux-2.4.10-pre11/fs/exec.c	Tue Sep 18 13:57:06 2001
+++ linux-rwsem/fs/exec.c	Tue Sep 18 15:01:56 2001
@@ -947,6 +947,14 @@
 	if (current->rlim[RLIMIT_CORE].rlim_cur < binfmt->min_coredump)
 		goto fail;
 
+	/* make sure the attached VM has a single ref (this process) to make
+	 * sure only do_exit() will change the VMA list, so we don't have to
+	 * lock the mm->sem around the binfmt coredumper
+	 */
+	retval = copy_mm_for_coredump(current);
+	if (retval<0)
+		goto fail;
+
 	memcpy(corename,"core.", 5);
 	corename[4] = '\0';
  	if (core_uses_pid || atomic_read(&current->mm->mm_users) != 1)
@@ -969,9 +977,7 @@
 	if (do_truncate(file->f_dentry, 0) != 0)
 		goto close_fail;
 
-	down_read(&current->mm->mmap_sem);
 	retval = binfmt->core_dump(signr, regs, file);
-	up_read(&current->mm->mmap_sem);
 
 close_fail:
 	filp_close(file, NULL);
diff -uNr -x TAGS linux-2.4.10-pre11/include/linux/mm.h linux-rwsem/include/linux/mm.h
--- linux-2.4.10-pre11/include/linux/mm.h	Tue Sep 18 13:57:09 2001
+++ linux-rwsem/include/linux/mm.h	Tue Sep 18 15:27:48 2001
@@ -615,6 +615,7 @@
 }
 
 extern struct vm_area_struct *find_extend_vma(struct mm_struct *mm, unsigned long addr);
+extern int copy_mm_for_coredump(struct task_struct *tsk);
 
 #endif /* __KERNEL__ */
 
diff -uNr -x TAGS linux-2.4.10-pre11/kernel/fork.c linux-rwsem/kernel/fork.c
--- linux-2.4.10-pre11/kernel/fork.c	Tue Sep 18 13:57:10 2001
+++ linux-rwsem/kernel/fork.c	Tue Sep 18 15:28:50 2001
@@ -359,6 +359,55 @@
 	return retval;
 }
 
+int copy_mm_for_coredump(struct task_struct * tsk)
+{
+	struct mm_struct *mm, *old_mm;
+	int retval;
+
+	/* don't bother copying if there's only one user anyway */
+	if (atomic_read(&tsk->mm->mm_users)==1)
+		return 0;
+
+	old_mm = tsk->mm;
+
+	retval = -ENOMEM;
+	mm = allocate_mm();
+	if (!mm)
+		goto fail_nomem;
+
+	/* Copy the current MM stuff.. */
+	memcpy(mm, tsk->mm, sizeof(*mm));
+	if (!mm_init(mm))
+		goto fail_nomem;
+
+	down_write(&tsk->mm->mmap_sem);
+	retval = dup_mmap(mm);
+	up_write(&tsk->mm->mmap_sem);
+
+	if (retval)
+		goto free_pt;
+
+	/* no LDT now */
+	mm->context.segments = NULL;
+
+	if (init_new_context(tsk,mm))
+		goto free_pt;
+
+	/* swap to new MM */
+	task_lock(tsk);
+	tsk->mm = mm;
+	tsk->active_mm = mm;
+	task_unlock(tsk);
+	mmput(old_mm);
+
+	return 0;
+
+free_pt:
+	mmput(mm);
+fail_nomem:
+	return retval;
+}
+
 static inline struct fs_struct *__copy_fs_struct(struct fs_struct *old)
 {
 	struct fs_struct *fs = kmem_cache_alloc(fs_cachep, GFP_KERNEL);
