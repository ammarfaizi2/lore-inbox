Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130018AbRAIWRj>; Tue, 9 Jan 2001 17:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130130AbRAIWR3>; Tue, 9 Jan 2001 17:17:29 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:22759 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S130018AbRAIWRV>; Tue, 9 Jan 2001 17:17:21 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Rik van Riel <riel@conectiva.com.br>,
        "Sergey E. Volkov" <sve@raiden.bancorp.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: VM subsystem bug in 2.4.0 ?
In-Reply-To: <Pine.LNX.4.10.10101091021280.2070-100000@penguin.transmeta.com>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <Pine.LNX.4.10.10101091021280.2070-100000@penguin.transmeta.com>
Message-ID: <m3vgroe6qo.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 09 Jan 2001 23:20:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Tue, 9 Jan 2001, Stephen C. Tweedie wrote:
> > 
> > But again, how do you clear the bit?  Locking is a per-vma property,
> > not per-page.  I can mmap a file twice and mlock just one of the
> > mappings.  If you get a munlock(), how are you to know how many other
> > locked mappings still exist?
> 
> Note that this would be solved very cleanly if the SHM code would use the
> "VM_LOCKED" flag, and actually lock the pages in the VM, instead of trying
> to lock them down for writepage().

here comes the patch. (lightly tested)

Greetings
                Christoph


diff -uNr 2.4.0/include/linux/shmem_fs.h c/include/linux/shmem_fs.h
--- 2.4.0/include/linux/shmem_fs.h	Tue Jan  2 21:58:11 2001
+++ c/include/linux/shmem_fs.h	Tue Jan  9 22:01:48 2001
@@ -22,7 +22,6 @@
 	swp_entry_t	i_direct[SHMEM_NR_DIRECT]; /* for the first blocks */
 	swp_entry_t   **i_indirect; /* doubly indirect blocks */
 	unsigned long	swapped;
-	int		locked;     /* into memory */
 	struct list_head	list;
 };
 
diff -uNr 2.4.0/ipc/shm.c c/ipc/shm.c
--- 2.4.0/ipc/shm.c	Tue Jan  2 21:58:11 2001
+++ c/ipc/shm.c	Tue Jan  9 22:39:18 2001
@@ -91,9 +91,10 @@
 	return ipc_addid(&shm_ids, &shp->shm_perm, shm_ctlmni+1);
 }
 
-
-
-static inline void shm_inc (int id) {
+/* This is called by fork, once for every shm attach. */
+static void shm_open (struct vm_area_struct *shmd)
+{
+	int id = shmd->vm_file->f_dentry->d_inode->i_ino;
 	struct shmid_kernel *shp;
 
 	if(!(shp = shm_lock(id)))
@@ -104,12 +105,6 @@
 	shm_unlock(id);
 }
 
-/* This is called by fork, once for every shm attach. */
-static void shm_open (struct vm_area_struct *shmd)
-{
-	shm_inc (shmd->vm_file->f_dentry->d_inode->i_ino);
-}
-
 /*
  * shm_destroy - free the struct shmid_kernel
  *
@@ -154,9 +149,20 @@
 
 static int shm_mmap(struct file * file, struct vm_area_struct * vma)
 {
-	UPDATE_ATIME(file->f_dentry->d_inode);
+	struct shmid_kernel *shp;
+	struct inode * inode = file->f_dentry->d_inode;
+
+	UPDATE_ATIME(inode);
 	vma->vm_ops = &shm_vm_ops;
-	shm_inc(file->f_dentry->d_inode->i_ino);
+
+	if(!(shp = shm_lock(inode->i_ino)))
+		BUG();
+	shp->shm_atim = CURRENT_TIME;
+	shp->shm_lprid = current->pid;
+	shp->shm_nattch++;
+	if (shp->shm_flags & SHM_LOCKED)
+		vma->vm_flags |= VM_LOCKED;
+	shm_unlock(inode->i_ino);
 	return 0;
 }
 
@@ -365,6 +371,29 @@
 	}
 }
 
+static void shm_lockseg (struct shmid_kernel * shp, int cmd)
+{
+	struct address_space *mapping = shp->shm_file->f_dentry->d_inode->i_mapping;
+	struct vm_area_struct *mpnt;
+
+	spin_lock(&mapping->i_shared_lock);
+	if(cmd==SHM_LOCK) {
+		shp->shm_flags |= SHM_LOCKED;
+		for (mpnt = mapping->i_mmap; mpnt; mpnt = mpnt->vm_next_share)
+			mpnt->vm_flags |= VM_LOCKED;
+		for (mpnt = mapping->i_mmap_shared; mpnt; mpnt = mpnt->vm_next_share)
+			mpnt->vm_flags |= VM_LOCKED;
+	} else {
+		shp->shm_flags &= ~SHM_LOCKED;
+		for (mpnt = mapping->i_mmap; mpnt; mpnt = mpnt->vm_next_share)
+			mpnt->vm_flags &= ~VM_LOCKED;
+		for (mpnt = mapping->i_mmap_shared; mpnt; mpnt = mpnt->vm_next_share)
+			mpnt->vm_flags &= ~VM_LOCKED;
+	}
+	spin_unlock(&mapping->i_shared_lock);
+		
+}
+
 asmlinkage long sys_shmctl (int shmid, int cmd, struct shmid_ds *buf)
 {
 	struct shm_setbuf setbuf;
@@ -466,13 +495,7 @@
 		err = shm_checkid(shp,shmid);
 		if(err)
 			goto out_unlock;
-		if(cmd==SHM_LOCK) {
-			shp->shm_file->f_dentry->d_inode->u.shmem_i.locked = 1;
-			shp->shm_flags |= SHM_LOCKED;
-		} else {
-			shp->shm_file->f_dentry->d_inode->u.shmem_i.locked = 0;
-			shp->shm_flags &= ~SHM_LOCKED;
-		}
+		shm_lockseg(shp, cmd);
 		shm_unlock(shmid);
 		return err;
 	}
diff -uNr 2.4.0/mm/shmem.c c/mm/shmem.c
--- 2.4.0/mm/shmem.c	Tue Jan  2 21:58:11 2001
+++ c/mm/shmem.c	Tue Jan  9 22:02:18 2001
@@ -201,8 +201,6 @@
 	swp_entry_t *entry, swap;
 
 	info = &page->mapping->host->u.shmem_i;
-	if (info->locked)
-		return 1;
 	swap = __get_swap_page(2);
 	if (!swap.val)
 		return 1;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
