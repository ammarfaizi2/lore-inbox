Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129573AbQLSJaR>; Tue, 19 Dec 2000 04:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129588AbQLSJ37>; Tue, 19 Dec 2000 04:29:59 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:16126 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129573AbQLSJ34>; Tue, 19 Dec 2000 04:29:56 -0500
From: Christoph Rohland <cr@sap.com>
To: buhr@stat.wisc.edu (Kevin Buhr)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test5 bug: invalid "shmid_kernel" passed to "shm_nopage_core"
In-Reply-To: <vbaaeapf4ti.fsf@mozart.stat.wisc.edu>
	<m3g0kggydi.fsf@linux.local> <vbay9y7dxgr.fsf@mozart.stat.wisc.edu>
	<m37l5rggmm.fsf@linux.local> <vbasnoeeajg.fsf@mozart.stat.wisc.edu>
Organisation: SAP LinuxLab
Date: 19 Dec 2000 09:58:51 +0100
Message-ID: <qww1yv4bxdg.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 26 Nov 2000, Kevin Buhr wrote:
> The fact that this has crashed once in all the time I've been using
> this setup would seem to imply a very subtle race condition.  Ugh.

I am just running a stress test on 2.4.0-test13-pre3 + appended patch
without problems. Is the shm segment deleted sometimes or is it always
the same segment?

> Can you offer me a tutorial on the SHM locking?  What's supposed to
> protect against what?

The locking should be much easier to understand in 2.4.0-test13-pre3:

SYSV has two locks: 
- shmids.sem protects addition/removal of shm ids
- the per id lock protects data changes in the id

shmem uses also to locks:
- the inode semaphore is used to protect nopage to race with itself
  or truncate
- shmem_inode_info.u.shmem_i.lock is used to protect swapout against
  the others

Greetings
		Christoph

diff -uNr 4-13-3/ipc/shm.c c/ipc/shm.c
--- 4-13-3/ipc/shm.c	Mon Dec 18 15:08:32 2000
+++ c/ipc/shm.c	Mon Dec 18 20:07:21 2000
@@ -15,23 +15,13 @@
  *
  */
 
-#include <linux/config.h>
-#include <linux/module.h>
 #include <linux/malloc.h>
 #include <linux/shm.h>
-#include <linux/swap.h>
-#include <linux/smp_lock.h>
 #include <linux/init.h>
-#include <linux/locks.h>
 #include <linux/file.h>
 #include <linux/mman.h>
-#include <linux/vmalloc.h>
-#include <linux/pagemap.h>
 #include <linux/proc_fs.h>
-#include <linux/highmem.h>
-
 #include <asm/uaccess.h>
-#include <asm/pgtable.h>
 
 #include "util.h"
 
@@ -109,6 +99,7 @@
 		BUG();
 	shp->shm_atim = CURRENT_TIME;
 	shp->shm_lprid = current->pid;
+	shp->shm_nattch++;
 	shm_unlock(id);
 }
 
@@ -123,21 +114,14 @@
  *
  * @shp: struct to free
  *
- * It has to be called with shp and shm_ids.sem locked and will
- * release them
+ * It has to be called with shp and shm_ids.sem locked
  */
 static void shm_destroy (struct shmid_kernel *shp)
 {
-	struct file * file = shp->shm_file;
-
-	shp->shm_file = NULL;
 	shm_tot -= (shp->shm_segsz + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	shm_unlock (shp->id);
 	shm_rmid (shp->id);
+	fput (shp->shm_file);
 	kfree (shp);
-	up (&shm_ids.sem);
-	/* put the file outside the critical path to prevent recursion */
-	fput (file);
 }
 
 /*
@@ -158,10 +142,10 @@
 		BUG();
 	shp->shm_lprid = current->pid;
 	shp->shm_dtim = CURRENT_TIME;
-	if(shp->shm_flags & SHM_DEST &&
-	   file_count (file) == 2) /* shp and the vma have the last
-                                      references*/
-		return shm_destroy (shp);
+	shp->shm_nattch--;
+	if(shp->shm_nattch == 0 &&
+	   shp->shm_flags & SHM_DEST)
+		shm_destroy (shp);
 
 	shm_unlock(id);
 	up (&shm_ids.sem);
@@ -176,7 +160,7 @@
 }
 
 static struct file_operations shm_file_operations = {
-	mmap:		shm_mmap
+	mmap:	shm_mmap
 };
 
 static struct vm_operations_struct shm_vm_ops = {
@@ -218,9 +202,10 @@
 	shp->shm_atim = shp->shm_dtim = 0;
 	shp->shm_ctim = CURRENT_TIME;
 	shp->shm_segsz = size;
+	shp->shm_nattch = 0;
 	shp->id = shm_buildid(id,shp->shm_perm.seq);
 	shp->shm_file = file;
-	file->f_dentry->d_inode->i_ino = id;
+	file->f_dentry->d_inode->i_ino = shp->id;
 	file->f_op = &shm_file_operations;
 	shm_tot += numpages;
 	shm_unlock (id);
@@ -370,15 +355,13 @@
 		struct inode * inode;
 
 		shp = shm_get(i);
-		if(shp == NULL || shp->shm_file == NULL)
+		if(shp == NULL)
 			continue;
 		inode = shp->shm_file->f_dentry->d_inode;
-		down (&inode->i_sem);
-		*rss += inode->i_mapping->nrpages;
 		spin_lock (&inode->u.shmem_i.lock);
+		*rss += inode->i_mapping->nrpages;
 		*swp += inode->u.shmem_i.swapped;
 		spin_unlock (&inode->u.shmem_i.lock);
-		up (&inode->i_sem);
 	}
 }
 
@@ -462,7 +445,7 @@
 		tbuf.shm_ctime	= shp->shm_ctim;
 		tbuf.shm_cpid	= shp->shm_cprid;
 		tbuf.shm_lpid	= shp->shm_lprid;
-		tbuf.shm_nattch	= file_count (shp->shm_file) - 1;
+		tbuf.shm_nattch	= shp->shm_nattch;
 		shm_unlock(shmid);
 		if(copy_shmid_to_user (buf, &tbuf, version))
 			return -EFAULT;
@@ -512,13 +495,12 @@
 			goto out_up;
 		err = shm_checkid(shp, shmid);
 		if (err == 0) {
-			if (file_count (shp->shm_file) == 1) {
+			if (shp->shm_nattch){
+				shp->shm_flags |= SHM_DEST;
+				/* Do not find it any more */
+				shp->shm_perm.key = IPC_PRIVATE;
+			} else
 				shm_destroy (shp);
-				return 0;
-			}
-			shp->shm_flags |= SHM_DEST;
-			/* Do not find it any more */
-			shp->shm_perm.key = IPC_PRIVATE;
 		}
 		/* Unlock */
 		shm_unlock(shmid);
@@ -619,13 +601,23 @@
 		return -EACCES;
 	}
 	file = shp->shm_file;
-	get_file (file);
+	shp->shm_nattch++;
 	shm_unlock(shmid);
 
 	down(&current->mm->mmap_sem);
 	user_addr = (void *) do_mmap (file, addr, file->f_dentry->d_inode->i_size, prot, flags, 0);
 	up(&current->mm->mmap_sem);
-	fput (file);
+
+	down (&shm_ids.sem);
+	if(!(shp = shm_lock(shmid)))
+		BUG();
+	shp->shm_nattch--;
+	if(shp->shm_nattch == 0 &&
+	   shp->shm_flags & SHM_DEST)
+		shm_destroy (shp);
+	shm_unlock(shmid);
+	up (&shm_ids.sem);
+
 	*raddr = (unsigned long) user_addr;
 	err = 0;
 	if (IS_ERR(user_addr))
@@ -684,7 +676,7 @@
 				shp->shm_segsz,
 				shp->shm_cprid,
 				shp->shm_lprid,
-				file_count (shp->shm_file) - 1,
+				shp->shm_nattch,
 				shp->shm_perm.uid,
 				shp->shm_perm.gid,
 				shp->shm_perm.cuid,
diff -uNr 4-13-3/mm/shmem.c c/mm/shmem.c
--- 4-13-3/mm/shmem.c	Mon Dec 18 15:08:32 2000
+++ c/mm/shmem.c	Mon Dec 18 15:13:10 2000
@@ -210,37 +210,39 @@
 {
 	int error;
 	struct shmem_inode_info *info;
-	swp_entry_t *entry;
+	swp_entry_t *entry, swap;
 
 	info = &((struct inode *)page->mapping->host)->u.shmem_i;
 	if (info->locked)
 		return 1;
-	spin_lock(&info->lock);
-	entry = shmem_swp_entry (info, page->index);
-	if (!entry)	/* this had been allocted on page allocation */
-		BUG();
-	error = -EAGAIN;
-	if (entry->val)
-		goto out;
-
 	/*
 	 * 1 means "cannot write out".
 	 * We can't drop dirty pages
 	 * just because we ran out of
 	 * swap.
 	 */
-	error = 1;
-	*entry = __get_swap_page(2);
-	if (!entry->val)
+	swap = __get_swap_page(2);
+	if (!swap.val)
+		return 1;
+
+	spin_lock(&info->lock);
+	entry = shmem_swp_entry (info, page->index);
+	if (!entry)	/* this had been allocted on page allocation */
+		BUG();
+	error = -EAGAIN;
+	if (entry->val) {
+                __swap_free(swap, 2);
 		goto out;
+        }
 
+        *entry = swap;
 	error = 0;
 	/* Remove the from the page cache */
 	lru_cache_del(page);
 	remove_inode_page(page);
 
 	/* Add it to the swap cache */
-	add_to_swap_cache(page,*entry);
+	add_to_swap_cache(page, swap);
 	page_cache_release(page);
 	SetPageDirty(page);
 	info->swapped++;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
