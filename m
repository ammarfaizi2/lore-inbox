Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWDTQZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWDTQZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 12:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWDTQZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 12:25:29 -0400
Received: from silver.veritas.com ([143.127.12.111]:1390 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751057AbWDTQZ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 12:25:28 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.04,141,1144047600"; 
   d="scan'208"; a="37402436:sNHT25872952"
Date: Thu, 20 Apr 2006 17:24:10 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: David Wilk <davidwilk@gmail.com>
cc: Greg KH <greg@kroah.com>, Chris Wright <chrisw@sous-sol.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, stable@kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [stable] 2.6.16.6 breaks java... sort of
In-Reply-To: <Pine.LNX.4.64.0604192046590.17491@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0604201706540.14395@blonde.wat.veritas.com>
References: <a4403ff60604191152u5a71e70fr9f54c104a654fc99@mail.gmail.com>
 <20060419192803.GA19852@kroah.com> <Pine.LNX.4.64.0604192046590.17491@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 20 Apr 2006 16:24:15.0232 (UTC) FILETIME=[DD994800:01C66496]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2006, Hugh Dickins wrote:
> On Wed, 19 Apr 2006, Greg KH wrote:
> > On Wed, Apr 19, 2006 at 12:52:33PM -0600, David Wilk wrote:
> > > 
> > > I think an issue was introduced with mprotect (the first patch in
> > > 2.6.16.6).  With 2.6.16.5, tomcat runs fine (in sun-1.5), but in
> > > 2.6.16.7, the JVM bails out complaining that it couldn't allocate
> > > enough heap space.
> 
> Neither expected nor satisfactory.  Sorry about that.  We were hoping
> the straightforward shm/mprotect fix would be good enough, but it
> appears not.  JVM is probably doing something we can allow with a
> more complicated patch, but it _might_ turn out to be doing something
> we simply cannot allow: I'll hope for the first and work out a patch
> for that; but won't be ready to post it until tomorrow.

David, would you please try this patch on top of your 2.6.16.7 or later.
The first hunk undoes the problematic patch, the remainder does it in a
more permissive way.  Aesthetically, not as satisfactory as the previous
patch; but it's important that we not break userspace, unless security
absolutely demands.  Please let us know how this fares: thanks.

Hugh

--- 2.6.16.9/ipc/shm.c	2006-04-20 11:59:03.000000000 +0100
+++ linux/ipc/shm.c	2006-04-20 16:57:36.000000000 +0100
@@ -161,8 +161,6 @@ static int shm_mmap(struct file * file, 
 	ret = shmem_mmap(file, vma);
 	if (ret == 0) {
 		vma->vm_ops = &shm_vm_ops;
-		if (!(vma->vm_flags & VM_WRITE))
-			vma->vm_flags &= ~VM_MAYWRITE;
 		shm_inc(file->f_dentry->d_inode->i_ino);
 	}
 
@@ -677,6 +675,8 @@ out:
  */
 long do_shmat(int shmid, char __user *shmaddr, int shmflg, ulong *raddr)
 {
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
 	struct shmid_kernel *shp;
 	unsigned long addr;
 	unsigned long size;
@@ -684,7 +684,7 @@ long do_shmat(int shmid, char __user *sh
 	int    err;
 	unsigned long flags;
 	unsigned long prot;
-	unsigned long o_flags;
+	int maywrite;
 	int acc_mode;
 	void *user_addr;
 
@@ -711,11 +711,11 @@ long do_shmat(int shmid, char __user *sh
 
 	if (shmflg & SHM_RDONLY) {
 		prot = PROT_READ;
-		o_flags = O_RDONLY;
+		maywrite = 0;
 		acc_mode = S_IRUGO;
 	} else {
 		prot = PROT_READ | PROT_WRITE;
-		o_flags = O_RDWR;
+		maywrite = 1;
 		acc_mode = S_IRUGO | S_IWUGO;
 	}
 	if (shmflg & SHM_EXEC) {
@@ -748,30 +748,43 @@ long do_shmat(int shmid, char __user *sh
 		shm_unlock(shp);
 		return err;
 	}
-		
+
+	if (!maywrite && !ipcperms_dac(&shp->shm_perm, S_IWUGO))
+		maywrite = 1;
+
 	file = shp->shm_file;
 	size = i_size_read(file->f_dentry->d_inode);
 	shp->shm_nattch++;
 	shm_unlock(shp);
 
-	down_write(&current->mm->mmap_sem);
+	down_write(&mm->mmap_sem);
 	if (addr && !(shmflg & SHM_REMAP)) {
 		user_addr = ERR_PTR(-EINVAL);
-		if (find_vma_intersection(current->mm, addr, addr + size))
+		if (find_vma_intersection(mm, addr, addr + size))
 			goto invalid;
 		/*
 		 * If shm segment goes below stack, make sure there is some
 		 * space left for the stack to grow (at least 4 pages).
 		 */
-		if (addr < current->mm->start_stack &&
-		    addr > current->mm->start_stack - size - PAGE_SIZE * 5)
+		if (addr < mm->start_stack &&
+		    addr > mm->start_stack - size - PAGE_SIZE * 5)
 			goto invalid;
 	}
-		
+
 	user_addr = (void*) do_mmap (file, addr, size, prot, flags, 0);
 
+	if (!maywrite && !IS_ERR(user_addr)) {
+		/*
+		 * Prevent mprotect from giving write permission later on.
+		 * We would prefer just to clear VM_MAYWRITE from a readonly
+		 * attachment in shm_mmap, but it seems that JVM has got into
+		 * the habit of attaching readonly then mprotecting to write.
+		 */
+		vma = find_vma(mm, (unsigned long) user_addr);
+		vma->vm_flags &= ~VM_MAYWRITE;
+	}
 invalid:
-	up_write(&current->mm->mmap_sem);
+	up_write(&mm->mmap_sem);
 
 	down (&shm_ids.sem);
 	if(!(shp = shm_lock(shmid)))
--- 2.6.16.9/ipc/util.c	2006-03-20 05:53:29.000000000 +0000
+++ linux/ipc/util.c	2006-04-20 16:57:36.000000000 +0100
@@ -464,7 +464,7 @@ void ipc_rcu_putref(void *ptr)
  *	to ipc resources. return 0 if allowed
  */
  
-int ipcperms (struct kern_ipc_perm *ipcp, short flag)
+int ipcperms_dac(struct kern_ipc_perm *ipcp, short flag)
 {	/* flag will most probably be 0 or S_...UGO from <linux/stat.h> */
 	int requested_mode, granted_mode;
 
@@ -478,7 +478,13 @@ int ipcperms (struct kern_ipc_perm *ipcp
 	if ((requested_mode & ~granted_mode & 0007) && 
 	    !capable(CAP_IPC_OWNER))
 		return -1;
+	return 0;
+}
 
+int ipcperms(struct kern_ipc_perm *ipcp, short flag)
+{
+	if (ipcperms_dac(ipcp, flag))
+		return -1;
 	return security_ipc_permission(ipcp, flag);
 }
 
--- 2.6.16.9/ipc/util.h	2006-03-20 05:53:29.000000000 +0000
+++ linux/ipc/util.h	2006-04-20 16:57:36.000000000 +0100
@@ -47,7 +47,8 @@ int ipc_addid(struct ipc_ids* ids, struc
 /* must be called with both locks acquired. */
 struct kern_ipc_perm* ipc_rmid(struct ipc_ids* ids, int id);
 
-int ipcperms (struct kern_ipc_perm *ipcp, short flg);
+int ipcperms_dac(struct kern_ipc_perm *ipcp, short flag);
+int ipcperms(struct kern_ipc_perm *ipcp, short flag);
 
 /* for rare, potentially huge allocations.
  * both function can sleep
