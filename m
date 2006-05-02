Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbWEBVmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbWEBVmr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 17:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbWEBVmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 17:42:46 -0400
Received: from over.co.us.ibm.com ([32.97.110.157]:64652 "EHLO
	over.co.us.ibm.com") by vger.kernel.org with ESMTP id S964992AbWEBVmq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 17:42:46 -0400
Date: Tue, 2 May 2006 12:32:00 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, ebiederm@xmission.com,
       herbert@13thfloor.at, dev@sw.ru, linux-kernel@vger.kernel.org,
       sam@vilain.net, xemul@sw.ru, clg@fr.ibm.com, frankeh@us.ibm.com
Subject: Re: [PATCH 7/7] uts namespaces: Implement CLONE_NEWUTS flag
Message-ID: <20060502173200.GA23766@sergelap.austin.ibm.com>
References: <20060501203906.XF1836@sergelap.austin.ibm.com> <20060501203907.XF1836@sergelap.austin.ibm.com> <1146515316.32079.27.camel@localhost.localdomain> <20060501211109.GA21799@sergelap.austin.ibm.com> <1146520732.32079.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146520732.32079.31.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dave Hansen (haveblue@us.ibm.com):
> On Mon, 2006-05-01 at 16:11 -0500, Serge E. Hallyn wrote:
> > Might be worth a separate patch to change over all those helpers in
> > fork.c?  (I think they were all brought in along with the sys_unshare
> > syscall)
> 
> I'd be a little scared to touch good, working code, but it couldn't hurt
> to see the patch.

Hmm, well the following untested patch was just to see the end results.
Summary: it ends up quite a bit uglier  :-(

I think I like it better as is.

thanks,
-serge

Subject: [PATCH] fs/fork.c: unshare cleanup

Switch some of the unshare patch to more kernel conformant style.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 kernel/fork.c |  102 ++++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 64 insertions(+), 38 deletions(-)

c30251d8442cfee2ada7dfd6c46159cf44011213
diff --git a/kernel/fork.c b/kernel/fork.c
index d2fa57d..42753a4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1450,86 +1450,92 @@ static int unshare_thread(unsigned long 
 /*
  * Unshare the filesystem structure if it is being shared
  */
-static int unshare_fs(unsigned long unshare_flags, struct fs_struct **new_fsp)
+static struct fs_struct * unshare_fs(unsigned long flags)
 {
 	struct fs_struct *fs = current->fs;
+	struct fs_struct *new_fs = NULL;
 
-	if ((unshare_flags & CLONE_FS) &&
+	if ((flags & CLONE_FS) &&
 	    (fs && atomic_read(&fs->count) > 1)) {
-		*new_fsp = __copy_fs_struct(current->fs);
-		if (!*new_fsp)
-			return -ENOMEM;
+		new_fs = __copy_fs_struct(current->fs);
+		if (!new_fs)
+			new_fs = ERR_PTR(-ENOMEM);
 	}
 
-	return 0;
+	return new_fs;
 }
 
 /*
  * Unshare the namespace structure if it is being shared
  */
-static int unshare_namespace(unsigned long unshare_flags, struct namespace **new_nsp, struct fs_struct *new_fs)
+static struct namespace *unshare_namespace(unsigned long flags,
+		struct fs_struct *new_fs)
 {
 	struct namespace *ns = current->namespace;
+	struct namespace *new_ns = NULL;
 
-	if ((unshare_flags & CLONE_NEWNS) &&
+	if ((flags & CLONE_NEWNS) &&
 	    (ns && atomic_read(&ns->count) > 1)) {
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
+		if (!capable(CAP_SYS_ADMIN)) {
+			return ERR_PTR(-EPERM);
 
-		*new_nsp = dup_namespace(current, new_fs ? new_fs : current->fs);
+		*new_ns = dup_namespace(current, new_fs ? new_fs : current->fs);
 		if (!*new_nsp)
-			return -ENOMEM;
+			return ERR_PTR(-ENOMEM);
 	}
 
-	return 0;
+	return new_ns;
 }
 
 /*
  * Unsharing of sighand for tasks created with CLONE_SIGHAND is not
  * supported yet
  */
-static int unshare_sighand(unsigned long unshare_flags, struct sighand_struct **new_sighp)
+static struct sighand_struct *unshare_sighand(unsigned long flags);
 {
 	struct sighand_struct *sigh = current->sighand;
+	struct sighand_struct *new_sigh = NULL;
 
-	if ((unshare_flags & CLONE_SIGHAND) &&
+	if ((flags & CLONE_SIGHAND) &&
 	    (sigh && atomic_read(&sigh->count) > 1))
-		return -EINVAL;
-	else
-		return 0;
+		return ERR_PTR(-EINVAL);
+
+	return new_sigh;
 }
 
 /*
  * Unshare vm if it is being shared
  */
-static int unshare_vm(unsigned long unshare_flags, struct mm_struct **new_mmp)
+static mm_struct *unshare_vm(unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
+	struct mm_struct *new_mm = NULL;
 
-	if ((unshare_flags & CLONE_VM) &&
+	if ((flags & CLONE_VM) &&
 	    (mm && atomic_read(&mm->mm_users) > 1)) {
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 
-	return 0;
+	return new_mm;
 }
 
 /*
  * Unshare file descriptor table if it is being shared
  */
-static int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp)
+static struct files_struct *unshare_fd(unsigned long flags)
 {
 	struct files_struct *fd = current->files;
+	struct files_struct *new_fd = NULL;
 	int error = 0;
 
-	if ((unshare_flags & CLONE_FILES) &&
+	if ((flags & CLONE_FILES) &&
 	    (fd && atomic_read(&fd->count) > 1)) {
-		*new_fdp = dup_fd(fd, &error);
-		if (!*new_fdp)
-			return error;
+		new_fd = dup_fd(fd, &error);
+		if (!new_fd)
+			return ERR_PTR(error);
 	}
 
-	return 0;
+	return new_fd;
 }
 
 /*
@@ -1572,16 +1578,36 @@ asmlinkage long sys_unshare(unsigned lon
 
 	if ((err = unshare_thread(unshare_flags)))
 		goto bad_unshare_out;
-	if ((err = unshare_fs(unshare_flags, &new_fs)))
+
+	new_fs = unshare_fs(unshare_flags);
+	if (IS_ERR(new_fs)) {
+		err = PTR_ERR(new_fs);
 		goto bad_unshare_cleanup_thread;
-	if ((err = unshare_namespace(unshare_flags, &new_ns, new_fs)))
+	}
+
+	new_ns = unshare_namespace(unshare_flags, &new_ns);
+	if (IS_ERR(new_ns)) {
+		err = PTR_ERR(new_ns);
 		goto bad_unshare_cleanup_fs;
-	if ((err = unshare_sighand(unshare_flags, &new_sigh)))
+	}
+
+	new_sigh = unshare_sighand(unshare_flags);
+	if (IS_ERR(new_sigh)) {
+		err = PTR_ERR(new_sigh);
 		goto bad_unshare_cleanup_ns;
-	if ((err = unshare_vm(unshare_flags, &new_mm)))
+	}
+	new_mm = unshare_vm(unshare_flags);
+	if (IS_ERR(new_mm)) {
+		err = PTR_ERR(new_mm);
 		goto bad_unshare_cleanup_sigh;
-	if ((err = unshare_fd(unshare_flags, &new_fd)))
+	}
+
+	new_fd = unshare_fd(unshare_flags);
+	if (IS_ERR(new_fd)) {
+		err = PTR_ERR(new_fd);
 		goto bad_unshare_cleanup_vm;
+	}
+
 	if ((err = unshare_semundo(unshare_flags, &new_ulist)))
 		goto bad_unshare_cleanup_fd;
 
@@ -1626,24 +1652,24 @@ asmlinkage long sys_unshare(unsigned lon
 	}
 
 bad_unshare_cleanup_fd:
-	if (new_fd)
+	if (new_fd && !IS_ERR(new_fd))
 		put_files_struct(new_fd);
 
 bad_unshare_cleanup_vm:
-	if (new_mm)
+	if (new_mm && !IS_ERR(new_mm))
 		mmput(new_mm);
 
 bad_unshare_cleanup_sigh:
-	if (new_sigh)
+	if (new_sigh && !IS_ERR(new_sigh))
 		if (atomic_dec_and_test(&new_sigh->count))
 			kmem_cache_free(sighand_cachep, new_sigh);
 
 bad_unshare_cleanup_ns:
-	if (new_ns)
+	if (new_ns && !IS_ERR(new_ns))
 		put_namespace(new_ns);
 
 bad_unshare_cleanup_fs:
-	if (new_fs)
+	if (new_fs && !IS_ERR(new_fs)))
 		put_fs_struct(new_fs);
 
 bad_unshare_cleanup_thread:
-- 
1.3.0

