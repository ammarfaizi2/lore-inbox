Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263847AbUEMHAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbUEMHAz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 03:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbUEMHAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 03:00:55 -0400
Received: from holomorphy.com ([207.189.100.168]:29116 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263850AbUEMHAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 03:00:15 -0400
Date: Wed, 12 May 2004 23:59:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, Adam Litke <agl@us.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: More convenient way to grab hugepage memory
Message-ID: <20040513065912.GR1397@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Muli Ben-Yehuda <mulix@mulix.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Adam Litke <agl@us.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
References: <20040513055520.GF27403@zax> <20040513060549.GA12695@mulix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513060549.GA12695@mulix.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 09:05:50AM +0300, Muli Ben-Yehuda wrote:
> These two global variables do not appear to be used anywhere in this
> patch? 
> > +static inline unsigned long __do_mmap_pgoff(struct file * file, unsigned long addr,
> __do_mmap_pgoff seems rather long to be inline? 

Atop my other patch to nuke the unused global variables, here is a patch
to manually inline __do_mmap_pgoff(), removing the inline usage. Untested.
Are you sure you want this? #ifdef'ing out the hugetlb case is somewhat
more digestible with the inline in place, e.g.:

Index: wli-2.6.6-mm1/mm/mmap.c
===================================================================
--- wli-2.6.6-mm1.orig/mm/mmap.c	2004-05-12 23:29:53.000000000 -0700
+++ wli-2.6.6-mm1/mm/mmap.c	2004-05-12 23:56:40.000000000 -0700
@@ -771,6 +771,25 @@
 	return error;
 }
 
+#ifdef CONFIG_HUGETLB_PAGE
+static inline int create_hugetlb_file(struct file **file, unsigned long flags)
+{
+	/* Create an implicit hugetlb file if necessary */
+	if (*file || !(flags & MAP_HUGETLB))
+		return 0;
+	*file = hugetlb_zero_setup(len);
+	if (!IS_ERR(*file))
+		return 0;
+	else
+		return PTR_ERR(*file);
+}
+#else
+static inline int create_hugetlb_file(struct file **file, unsigned long flags)
+{
+	return 0;
+}
+#endif
+
 /*
  * The caller must hold down_write(current->mm->mmap_sem).
  */
@@ -809,14 +828,10 @@
 	if (current->mm->map_count > sysctl_max_map_count)
 		return -ENOMEM;
 
-	/* Create an implicit hugetlb file if necessary */
-	if (!file && (flags & MAP_HUGETLB)) {
-		file = hugetlb_file = hugetlb_zero_setup(len);
-		if (IS_ERR(file))
-			return PTR_ERR(file);
-	}
-
-	result = __do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
+	if (!(result = create_hugetlb_file(&hugetlb_file, flags)))
+		result = __do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
+	else
+		return result;
 
 	/* Drop reference to implicit hugetlb file, it's already been
 	 * "gotten" in __do_mmap_pgoff in case of success

though I suppose it's possible in principle to combine things.


-- wli

Remove __do_mmap_pgoff() in favor of direct case analysis within
do_mmap_pgoff() proper.

Index: wli-2.6.6-mm1/mm/mmap.c
===================================================================
--- wli-2.6.6-mm1.orig/mm/mmap.c	2004-05-12 23:29:53.000000000 -0700
+++ wli-2.6.6-mm1/mm/mmap.c	2004-05-12 23:40:37.000000000 -0700
@@ -529,9 +529,12 @@
 	return NULL;
 }
 
-static inline unsigned long __do_mmap_pgoff(struct file * file, unsigned long addr,
-					    unsigned long len, unsigned long prot,
-					    unsigned long flags, unsigned long pgoff)
+/*
+ * The caller must hold down_write(current->mm->mmap_sem).
+ */
+unsigned long do_mmap_pgoff(struct file * file, unsigned long addr,
+			unsigned long len, unsigned long prot,
+			unsigned long flags, unsigned long pgoff)
 {
 	struct mm_struct * mm = current->mm;
 	struct vm_area_struct * vma, * prev;
@@ -542,6 +545,42 @@
 	struct rb_node ** rb_link, * rb_parent;
 	int accountable = 1;
 	unsigned long charged = 0;
+	struct file *hugetlb_file = NULL;
+	unsigned long result;
+
+	if (file) {
+		if ((flags & MAP_HUGETLB) && !is_file_hugepages(file))
+			return -EINVAL;
+
+		if (!file->f_op || !file->f_op->mmap)
+			return -ENODEV;
+
+		if ((prot & PROT_EXEC) && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
+			return -EPERM;
+	}
+
+	if (!len)
+		return addr;
+
+	/* Careful about overflows.. */
+	len = PAGE_ALIGN(len);
+	if (!len || len > TASK_SIZE)
+		return -EINVAL;
+
+	/* offset overflow? */
+	if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)
+		return -EINVAL;
+
+	/* Too many mappings? */
+	if (mm->map_count > sysctl_max_map_count)
+		return -ENOMEM;
+
+	/* Create an implicit hugetlb file if necessary */
+	if (!file && (flags & MAP_HUGETLB)) {
+		file = hugetlb_file = hugetlb_zero_setup(len);
+		if (IS_ERR(file))
+			return PTR_ERR(file);
+	}
 
 	/* Obtain the address to map to. we verify (or select) it and
 	 * ensure that it represents a valid section of the address
@@ -549,9 +588,10 @@
 	 * CONFIG_HUGETLB is unset.
 	 */
 	addr = get_unmapped_area(file, addr, len, pgoff, flags);
-	if (addr & ~PAGE_MASK)
-		return addr;
-
+	if (addr & ~PAGE_MASK) {
+		result = addr;
+		goto out_check_hugetlb;
+	}
 	/* Huge pages aren't accounted for here */
 	if (file && is_file_hugepages(file))
 		accountable = 0;
@@ -564,16 +604,21 @@
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
 	if (flags & MAP_LOCKED) {
-		if (!can_do_mlock())
-			return -EPERM;
-		vm_flags |= VM_LOCKED;
+		if (can_do_mlock())
+			vm_flags |= VM_LOCKED;
+		else {
+			result = -EPERM;
+			goto out_check_hugetlb;
+		}
 	}
 	/* mlock MCL_FUTURE? */
 	if (vm_flags & VM_LOCKED) {
 		unsigned long locked = mm->locked_vm << PAGE_SHIFT;
 		locked += len;
-		if (locked > current->rlim[RLIMIT_MEMLOCK].rlim_cur)
-			return -EAGAIN;
+		if (locked > current->rlim[RLIMIT_MEMLOCK].rlim_cur) {
+			result = -EAGAIN;
+			goto out_check_hugetlb;
+		}
 	}
 
 	inode = file ? file->f_dentry->d_inode : NULL;
@@ -581,21 +626,27 @@
 	if (file) {
 		switch (flags & MAP_TYPE) {
 		case MAP_SHARED:
-			if ((prot&PROT_WRITE) && !(file->f_mode&FMODE_WRITE))
-				return -EACCES;
+			if ((prot & PROT_WRITE) && !(file->f_mode & FMODE_WRITE)) {
+				result = -EACCES;
+				goto out_check_hugetlb;
+			}
 
 			/*
 			 * Make sure we don't allow writing to an append-only
 			 * file..
 			 */
-			if (IS_APPEND(inode) && (file->f_mode & FMODE_WRITE))
-				return -EACCES;
+			if (IS_APPEND(inode) && (file->f_mode & FMODE_WRITE)) {
+				result = -EACCES;
+				goto out_check_hugetlb;
+			}
 
 			/*
 			 * Make sure there are no mandatory locks on the file.
 			 */
-			if (locks_verify_locked(inode))
-				return -EAGAIN;
+			if (locks_verify_locked(inode)) {
+				result = -EAGAIN;
+				goto out_check_hugetlb;
+			}
 
 			vm_flags |= VM_SHARED | VM_MAYSHARE;
 			if (!(file->f_mode & FMODE_WRITE))
@@ -603,18 +654,22 @@
 
 			/* fall through */
 		case MAP_PRIVATE:
-			if (!(file->f_mode & FMODE_READ))
-				return -EACCES;
+			if (!(file->f_mode & FMODE_READ)) {
+				result = -EACCES;
+				goto out_check_hugetlb;
+			}
 			break;
 
 		default:
-			return -EINVAL;
+			result = -EINVAL;
+			goto out_check_hugetlb;
 		}
 	} else {
 		vm_flags |= VM_SHARED | VM_MAYSHARE;
 		switch (flags & MAP_TYPE) {
 		default:
-			return -EINVAL;
+			result = -EINVAL;
+			goto out_check_hugetlb;
 		case MAP_PRIVATE:
 			vm_flags &= ~(VM_SHARED | VM_MAYSHARE);
 			/* fall through */
@@ -624,23 +679,29 @@
 	}
 
 	error = security_file_mmap(file, prot, flags);
-	if (error)
-		return error;
-		
+	if (error) {
+		result = error;
+		goto out_check_hugetlb;
+	}
+
 	/* Clear old maps */
 	error = -ENOMEM;
 munmap_back:
 	vma = find_vma_prepare(mm, addr, &prev, &rb_link, &rb_parent);
 	if (vma && vma->vm_start < addr + len) {
-		if (do_munmap(mm, addr, len))
-			return -ENOMEM;
+		if (do_munmap(mm, addr, len)) {
+			result = -ENOMEM;
+			goto out_check_hugetlb;
+		}
 		goto munmap_back;
 	}
 
 	/* Check against address space limit. */
 	if ((mm->total_vm << PAGE_SHIFT) + len
-	    > current->rlim[RLIMIT_AS].rlim_cur)
-		return -ENOMEM;
+	    > current->rlim[RLIMIT_AS].rlim_cur) {
+		result = -ENOMEM;
+		goto out_check_hugetlb;
+	}
 
 	if (accountable && (!(flags & MAP_NORESERVE) ||
 			sysctl_overcommit_memory > 1)) {
@@ -652,8 +713,10 @@
 			 * Private writable mapping: check memory availability
 			 */
 			charged = len >> PAGE_SHIFT;
-			if (security_vm_enough_memory(charged))
-				return -ENOMEM;
+			if (security_vm_enough_memory(charged)) {
+				result = -ENOMEM;
+				goto out_check_hugetlb;
+			}
 			vm_flags |= VM_ACCOUNT;
 		}
 	}
@@ -747,7 +810,8 @@
 					pgoff, flags & MAP_NONBLOCK);
 		down_write(&mm->mmap_sem);
 	}
-	return addr;
+	result = addr;
+	goto out_check_hugetlb;
 
 unmap_and_free_vma:
 	if (correct_wcount)
@@ -768,58 +832,12 @@
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
-	return error;
-}
-
-/*
- * The caller must hold down_write(current->mm->mmap_sem).
- */
-
-unsigned long do_mmap_pgoff(struct file * file, unsigned long addr,
-			unsigned long len, unsigned long prot,
-			unsigned long flags, unsigned long pgoff)
-{
-	struct file *hugetlb_file = NULL;
-	unsigned long result;
-
-	if (file) {
-		if ((flags & MAP_HUGETLB) && !is_file_hugepages(file))
-			return -EINVAL;
-
-		if (!file->f_op || !file->f_op->mmap)
-			return -ENODEV;
+	result = error;
 
-		if ((prot & PROT_EXEC) && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
-			return -EPERM;
-	}
-
-	if (!len)
-		return addr;
-
-	/* Careful about overflows.. */
-	len = PAGE_ALIGN(len);
-	if (!len || len > TASK_SIZE)
-		return -EINVAL;
-
-	/* offset overflow? */
-	if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)
-		return -EINVAL;
-
-	/* Too many mappings? */
-	if (current->mm->map_count > sysctl_max_map_count)
-		return -ENOMEM;
-
-	/* Create an implicit hugetlb file if necessary */
-	if (!file && (flags & MAP_HUGETLB)) {
-		file = hugetlb_file = hugetlb_zero_setup(len);
-		if (IS_ERR(file))
-			return PTR_ERR(file);
-	}
-
-	result = __do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-
-	/* Drop reference to implicit hugetlb file, it's already been
-	 * "gotten" in __do_mmap_pgoff in case of success
+out_check_hugetlb:
+	/*
+	 * Drop reference to the implicitly-allocated hugetlb file, if
+	 * MAP_HUGETLB was passed and the hugetlbfs inode succeeded.
 	 */
 	if (hugetlb_file)
 		fput(hugetlb_file);
