Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbVHHWho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVHHWho (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbVHHWhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:37:43 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:30387 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932310AbVHHWhd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:37:33 -0400
Date: Mon, 8 Aug 2005 15:37:22 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon Derr <Simon.Derr@bull.net>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Message-Id: <20050808223722.22843.86768.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] cpuset release ABBA deadlock fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix possible cpuset_sem ABBA deadlock if 'notify_on_release' set.

For a particular usage pattern, creating and destroying cpusets
fairly frequently using notify_on_release, on a very large system,
this deadlock can be seen every few days.  If you are not using the
cpuset notify_on_release feature, you will never see this deadlock.

The existing code, on task exit (or cpuset deletion) did:

  get cpuset_sem
  if cpuset marked notify_on_release and is ready to release:
    compute cpuset path relative to /dev/cpuset mount point
    call_usermodehelper() forks /sbin/cpuset_release_agent with path
  drop cpuset_sem

Unfortunately, the fork in call_usermodehelper can allocate
memory, and allocating memory can require cpuset_sem, if
the mems_generation values changed in the interim.  This
results in an ABBA deadlock, trying to obtain cpuset_sem
when it is already held by the current task.

To fix this, I put the cpuset path (which must be computed
while holding cpuset_sem) in a temporary buffer, to be used
in the call_usermodehelper call of /sbin/cpuset_release_agent
only _after_ dropping cpuset_sem.

So the new logic is:

  get cpuset_sem
  if cpuset marked notify_on_release and is ready to release:
    compute cpuset path relative to /dev/cpuset mount point
    stash path in kmalloc'd buffer
  drop cpuset_sem
  call_usermodehelper() forks /sbin/cpuset_release_agent with path
  free path

The sharp eyed reader might notice that this patch does not contain
any calls to kmalloc.  The existing code in the check_for_release()
routine was already kmalloc'ing a buffer to hold the cpuset path.
In the old code, it just held the buffer for a few lines, over the
cpuset_release_agent() call that in turn invoked call_usermodehelper().
In the new code, with the application of this patch, it returns that
buffer via the new char **ppathbuf parameter, for later use and freeing
in cpuset_release_agent(), which is called after cpuset_sem is dropped.
Whereas the old code has just one call to cpuset_release_agent(),
right in the check_for_release() routine, the new code has three calls
to cpuset_release_agent(), from the various places that a cpuset can
be released.

This patch has been build and booted on SN2, and passed a stress
test that previously hit the deadlock within a few seconds.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: linux-2.6/kernel/cpuset.c
===================================================================
--- linux-2.6.orig/kernel/cpuset.c
+++ linux-2.6/kernel/cpuset.c
@@ -398,21 +398,31 @@ static int cpuset_path(const struct cpus
  * to continue to serve a useful existence.  Next time it's released,
  * we will get notified again, if it still has 'notify_on_release' set.
  *
- * Note final arg to call_usermodehelper() is 0 - that means
- * don't wait.  Since we are holding the global cpuset_sem here,
- * and we are asking another thread (started from keventd) to rmdir a
- * cpuset, we can't wait - or we'd deadlock with the removing thread
- * on cpuset_sem.
+ * The final arg to call_usermodehelper() is 0, which means don't
+ * wait.  The separate /sbin/cpuset_release_agent task is forked by
+ * call_usermodehelper(), then control in this thread returns here,
+ * without waiting for the release agent task.  We don't bother to
+ * wait because the caller of this routine has no use for the exit
+ * status of the /sbin/cpuset_release_agent task, so no sense holding
+ * our caller up for that.
+ *
+ * The simple act of forking that task might require more memory,
+ * which might need cpuset_sem.  So this routine must be called while
+ * cpuset_sem is not held, to avoid a possible deadlock.  See also
+ * comments for check_for_release(), below.
  */
 
-static int cpuset_release_agent(char *cpuset_str)
+static void cpuset_release_agent(const char *pathbuf)
 {
 	char *argv[3], *envp[3];
 	int i;
 
+	if (!pathbuf)
+		return;
+
 	i = 0;
 	argv[i++] = "/sbin/cpuset_release_agent";
-	argv[i++] = cpuset_str;
+	argv[i++] = (char *) pathbuf;
 	argv[i] = NULL;
 
 	i = 0;
@@ -421,17 +431,29 @@ static int cpuset_release_agent(char *cp
 	envp[i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
 	envp[i] = NULL;
 
-	return call_usermodehelper(argv[0], argv, envp, 0);
+	(void) call_usermodehelper(argv[0], argv, envp, 0);
+	kfree(pathbuf);
 }
 
 /*
  * Either cs->count of using tasks transitioned to zero, or the
  * cs->children list of child cpusets just became empty.  If this
  * cs is notify_on_release() and now both the user count is zero and
- * the list of children is empty, send notice to user land.
+ * the list of children is empty, prepare cpuset path in a kmalloc'd
+ * buffer, to be returned via ppathbuf, so that the caller can invoke
+ * cpuset_release_agent() with it later on, once cpuset_sem is dropped.
+ * Call here with cpuset_sem held.
+ *
+ * This check_for_release() routine is responsible for kmalloc'ing
+ * pathbuf.  The above cpuset_release_agent() is responsible for
+ * kfree'ing pathbuf.  The caller of these routines is responsible
+ * for providing a pathbuf pointer, initialized to NULL, then
+ * calling check_for_release() with cpuset_sem held and the address
+ * of the pathbuf pointer, then dropping cpuset_sem, then calling
+ * cpuset_release_agent() with pathbuf, as set by check_for_release().
  */
 
-static void check_for_release(struct cpuset *cs)
+static void check_for_release(struct cpuset *cs, char **ppathbuf)
 {
 	if (notify_on_release(cs) && atomic_read(&cs->count) == 0 &&
 	    list_empty(&cs->children)) {
@@ -441,10 +463,9 @@ static void check_for_release(struct cpu
 		if (!buf)
 			return;
 		if (cpuset_path(cs, buf, PAGE_SIZE) < 0)
-			goto out;
-		cpuset_release_agent(buf);
-out:
-		kfree(buf);
+			kfree(buf);
+		else
+			*ppathbuf = buf;
 	}
 }
 
@@ -727,14 +748,14 @@ static int update_flag(cpuset_flagbits_t
 	return 0;
 }
 
-static int attach_task(struct cpuset *cs, char *buf)
+static int attach_task(struct cpuset *cs, char *pidbuf, char **ppathbuf)
 {
 	pid_t pid;
 	struct task_struct *tsk;
 	struct cpuset *oldcs;
 	cpumask_t cpus;
 
-	if (sscanf(buf, "%d", &pid) != 1)
+	if (sscanf(pidbuf, "%d", &pid) != 1)
 		return -EIO;
 	if (cpus_empty(cs->cpus_allowed) || nodes_empty(cs->mems_allowed))
 		return -ENOSPC;
@@ -777,7 +798,7 @@ static int attach_task(struct cpuset *cs
 
 	put_task_struct(tsk);
 	if (atomic_dec_and_test(&oldcs->count))
-		check_for_release(oldcs);
+		check_for_release(oldcs, ppathbuf);
 	return 0;
 }
 
@@ -801,6 +822,7 @@ static ssize_t cpuset_common_file_write(
 	struct cftype *cft = __d_cft(file->f_dentry);
 	cpuset_filetype_t type = cft->private;
 	char *buffer;
+	char *pathbuf = NULL;
 	int retval = 0;
 
 	/* Crude upper limit on largest legitimate cpulist user might write. */
@@ -841,7 +863,7 @@ static ssize_t cpuset_common_file_write(
 		retval = update_flag(CS_NOTIFY_ON_RELEASE, cs, buffer);
 		break;
 	case FILE_TASKLIST:
-		retval = attach_task(cs, buffer);
+		retval = attach_task(cs, buffer, &pathbuf);
 		break;
 	default:
 		retval = -EINVAL;
@@ -852,6 +874,7 @@ static ssize_t cpuset_common_file_write(
 		retval = nbytes;
 out2:
 	up(&cpuset_sem);
+	cpuset_release_agent(pathbuf);
 out1:
 	kfree(buffer);
 	return retval;
@@ -1357,6 +1380,7 @@ static int cpuset_rmdir(struct inode *un
 	struct cpuset *cs = dentry->d_fsdata;
 	struct dentry *d;
 	struct cpuset *parent;
+	char *pathbuf = NULL;
 
 	/* the vfs holds both inode->i_sem already */
 
@@ -1376,7 +1400,7 @@ static int cpuset_rmdir(struct inode *un
 		update_cpu_domains(cs);
 	list_del(&cs->sibling);	/* delete my sibling from parent->children */
 	if (list_empty(&parent->children))
-		check_for_release(parent);
+		check_for_release(parent, &pathbuf);
 	spin_lock(&cs->dentry->d_lock);
 	d = dget(cs->dentry);
 	cs->dentry = NULL;
@@ -1384,6 +1408,7 @@ static int cpuset_rmdir(struct inode *un
 	cpuset_d_remove_dir(d);
 	dput(d);
 	up(&cpuset_sem);
+	cpuset_release_agent(pathbuf);
 	return 0;
 }
 
@@ -1483,10 +1508,13 @@ void cpuset_exit(struct task_struct *tsk
 	task_unlock(tsk);
 
 	if (notify_on_release(cs)) {
+		char *pathbuf = NULL;
+
 		down(&cpuset_sem);
 		if (atomic_dec_and_test(&cs->count))
-			check_for_release(cs);
+			check_for_release(cs, &pathbuf);
 		up(&cpuset_sem);
+		cpuset_release_agent(pathbuf);
 	} else {
 		atomic_dec(&cs->count);
 	}

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
