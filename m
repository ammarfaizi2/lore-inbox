Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbUCYQze (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 11:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbUCYQz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 11:55:27 -0500
Received: from hellhawk.shadowen.org ([212.13.208.175]:46601 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S263376AbUCYQy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 11:54:29 -0500
Date: Thu, 25 Mar 2004 16:58:05 +0000
From: Andy Whitcroft <apw@shadowen.org>
To: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>
cc: Andi Kleen <ak@suse.de>, raybry@sgi.com, lse-tech@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: [PATCH] [1/6] HUGETLB memory commitment
Message-ID: <18641835.1080233885@42.150.104.212.access.eclipse.net.uk>
In-Reply-To: <18429360.1080233672@42.150.104.212.access.eclipse.net.uk>
References: <18429360.1080233672@42.150.104.212.access.eclipse.net.uk>
X-Mailer: Mulberry/3.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[050-mem_acctdom_core]

Memory accounting domains (core)

When hugetlb memory is in user we effectivly split memory into to
two independent and non-overlapping 'page' pools from which we can
allocate pages and against which we wish to handle commitments.
Currently all allocations are accounted against the normal page pool
which can lead to false allocation failures.

This patch provides the framework to allow these pools to be treated
separatly, preventing allocation in the hugetlb pool from being accounted
against the small page pool.  The hugetlb page pool is not accounted at all
and effectibly is treated as in overcommit mode.

The patch creates the concept of an accounting domain, against which
pages are to be accounted.  In this implementation there are two
domains VM_AD_DEFAULT which is used to account normal small pages
in the normal way and VM_AD_HUGETLB which is used to select and
identify VM_HUGETLB pages.  I have not attempted to add any actual
accounting for VM_HUGETLB pages, as currently they are prefaulted and
thus there is always 0 outstanding commitment to track.  Obviously,
if hugetlb was also changed to support demand paging that would

---
 fs/exec.c                |    2 +-
 include/linux/mm.h       |    6 ++++++
 include/linux/security.h |   15 ++++++++-------
 kernel/fork.c            |    8 +++++---
 mm/memory.c              |    1 +
 mm/mmap.c                |   18 +++++++++++-------
 mm/mprotect.c            |    5 +++--
 mm/mremap.c              |    4 ++--
 mm/shmem.c               |   10 ++++++----
 mm/swapfile.c            |    2 +-
 security/commoncap.c     |    8 +++++++-
 security/dummy.c         |    8 +++++++-
 security/selinux/hooks.c |    8 +++++++-
 13 files changed, 65 insertions(+), 30 deletions(-)

diff -upN reference/fs/exec.c current/fs/exec.c
--- reference/fs/exec.c	2004-03-11 20:47:24.000000000 +0000
+++ current/fs/exec.c	2004-03-25 15:03:32.000000000 +0000
@@ -409,7 +409,7 @@ int setup_arg_pages(struct linux_binprm 
 	if (!mpnt)
 		return -ENOMEM;
 
-	if (security_vm_enough_memory(arg_size >> PAGE_SHIFT)) {
+	if (security_vm_enough_memory(VM_AD_DEFAULT, arg_size >> PAGE_SHIFT)) {
 		kmem_cache_free(vm_area_cachep, mpnt);
 		return -ENOMEM;
 	}
diff -upN reference/include/linux/mm.h current/include/linux/mm.h
--- reference/include/linux/mm.h	2004-03-25 02:43:39.000000000 +0000
+++ current/include/linux/mm.h	2004-03-25 15:03:32.000000000 +0000
@@ -112,6 +112,12 @@ struct vm_area_struct {
 #define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
 
+/* Memory accounting domains. */
+#define VM_ACCTDOM_NR	2
+#define VM_ACCTDOM(vma) (!!((vma)->vm_flags & VM_HUGETLB))
+#define VM_AD_DEFAULT	0
+#define VM_AD_HUGETLB	1
+
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
 #endif
diff -upN reference/include/linux/security.h current/include/linux/security.h
--- reference/include/linux/security.h	2004-03-25 02:43:39.000000000 +0000
+++ current/include/linux/security.h	2004-03-25 15:03:32.000000000 +0000
@@ -51,7 +51,7 @@ extern int cap_inode_removexattr(struct 
 extern int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid, int flags);
 extern void cap_task_reparent_to_init (struct task_struct *p);
 extern int cap_syslog (int type);
-extern int cap_vm_enough_memory (long pages);
+extern int cap_vm_enough_memory (int domain, long pages);
 
 static inline int cap_netlink_send (struct sk_buff *skb)
 {
@@ -988,7 +988,8 @@ struct swap_info_struct;
  *	@type contains the type of action.
  *	Return 0 if permission is granted.
  * @vm_enough_memory:
- *	Check permissions for allocating a new virtual mapping.
+ *      Check permissions for allocating a new virtual mapping.
+ *      @domain contains the accounting domain.
  *      @pages contains the number of pages.
  *	Return 0 if permission is granted.
  *
@@ -1022,7 +1023,7 @@ struct security_operations {
 	int (*quotactl) (int cmds, int type, int id, struct super_block * sb);
 	int (*quota_on) (struct file * f);
 	int (*syslog) (int type);
-	int (*vm_enough_memory) (long pages);
+	int (*vm_enough_memory) (int domain, long pages);
 
 	int (*bprm_alloc_security) (struct linux_binprm * bprm);
 	void (*bprm_free_security) (struct linux_binprm * bprm);
@@ -1277,9 +1278,9 @@ static inline int security_syslog(int ty
 	return security_ops->syslog(type);
 }
 
-static inline int security_vm_enough_memory(long pages)
+static inline int security_vm_enough_memory(int domain, long pages)
 {
-	return security_ops->vm_enough_memory(pages);
+	return security_ops->vm_enough_memory(domain, pages);
 }
 
 static inline int security_bprm_alloc (struct linux_binprm *bprm)
@@ -1949,9 +1950,9 @@ static inline int security_syslog(int ty
 	return cap_syslog(type);
 }
 
-static inline int security_vm_enough_memory(long pages)
+static inline int security_vm_enough_memory(int domain, long pages)
 {
-	return cap_vm_enough_memory(pages);
+	return cap_vm_enough_memory(domain, pages);
 }
 
 static inline int security_bprm_alloc (struct linux_binprm *bprm)
diff -upN reference/kernel/fork.c current/kernel/fork.c
--- reference/kernel/fork.c	2004-03-11 20:47:29.000000000 +0000
+++ current/kernel/fork.c	2004-03-25 15:03:32.000000000 +0000
@@ -301,9 +301,10 @@ static inline int dup_mmap(struct mm_str
 			continue;
 		if (mpnt->vm_flags & VM_ACCOUNT) {
 			unsigned int len = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
-			if (security_vm_enough_memory(len))
+			if (security_vm_enough_memory(VM_ACCTDOM(mpnt), len))
 				goto fail_nomem;
-			charge += len;
+			if (VM_ACCTDOM(mpnt) == VM_AD_DEFAULT)
+				charge += len;
 		}
 		tmp = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 		if (!tmp)
@@ -358,7 +359,8 @@ out:
 fail_nomem:
 	retval = -ENOMEM;
 fail:
-	vm_unacct_memory(charge);
+	if (charge)
+		vm_unacct_memory(charge);
 	goto out;
 }
 static inline int mm_alloc_pgd(struct mm_struct * mm)
diff -upN reference/mm/memory.c current/mm/memory.c
--- reference/mm/memory.c	2004-03-25 02:43:43.000000000 +0000
+++ current/mm/memory.c	2004-03-25 15:03:32.000000000 +0000
@@ -551,6 +551,7 @@ int unmap_vmas(struct mmu_gather **tlbp,
 		if (end <= vma->vm_start)
 			continue;
 
+		/* We assume that only accountable VMAs are VM_ACCOUNT. */
 		if (vma->vm_flags & VM_ACCOUNT)
 			*nr_accounted += (end - start) >> PAGE_SHIFT;
 
diff -upN reference/mm/mmap.c current/mm/mmap.c
--- reference/mm/mmap.c	2004-03-25 02:43:43.000000000 +0000
+++ current/mm/mmap.c	2004-03-25 15:03:32.000000000 +0000
@@ -490,8 +490,11 @@ unsigned long do_mmap_pgoff(struct file 
 	int error;
 	struct rb_node ** rb_link, * rb_parent;
 	unsigned long charged = 0;
+	long acctdom = VM_AD_DEFAULT;
 
 	if (file) {
+		if (is_file_hugepages(file))
+			acctdom = VM_AD_HUGETLB;
 		if (!file->f_op || !file->f_op->mmap)
 			return -ENODEV;
 
@@ -608,7 +611,8 @@ munmap_back:
 	    > current->rlim[RLIMIT_AS].rlim_cur)
 		return -ENOMEM;
 
-	if (!(flags & MAP_NORESERVE) || sysctl_overcommit_memory > 1) {
+	if (acctdom == VM_AD_DEFAULT && (!(flags & MAP_NORESERVE) || 
+	    sysctl_overcommit_memory > 1)) {
 		if (vm_flags & VM_SHARED) {
 			/* Check memory availability in shmem_file_setup? */
 			vm_flags |= VM_ACCOUNT;
@@ -617,7 +621,7 @@ munmap_back:
 			 * Private writable mapping: check memory availability
 			 */
 			charged = len >> PAGE_SHIFT;
-			if (security_vm_enough_memory(charged))
+			if (security_vm_enough_memory(acctdom, charged))
 				return -ENOMEM;
 			vm_flags |= VM_ACCOUNT;
 		}
@@ -926,8 +930,8 @@ int expand_stack(struct vm_area_struct *
  	spin_lock(&vma->vm_mm->page_table_lock);
 	grow = (address - vma->vm_end) >> PAGE_SHIFT;
 
-	/* Overcommit.. */
-	if (security_vm_enough_memory(grow)) {
+	/* Overcommit ... assume stack is in normal memory */
+	if (security_vm_enough_memory(VM_AD_DEFAULT, grow)) {
 		spin_unlock(&vma->vm_mm->page_table_lock);
 		return -ENOMEM;
 	}
@@ -980,8 +984,8 @@ int expand_stack(struct vm_area_struct *
  	spin_lock(&vma->vm_mm->page_table_lock);
 	grow = (vma->vm_start - address) >> PAGE_SHIFT;
 
-	/* Overcommit.. */
-	if (security_vm_enough_memory(grow)) {
+	/* Overcommit ... assume stack is in normal memory */
+	if (security_vm_enough_memory(VM_AD_DEFAULT, grow)) {
 		spin_unlock(&vma->vm_mm->page_table_lock);
 		return -ENOMEM;
 	}
@@ -1378,7 +1382,7 @@ unsigned long do_brk(unsigned long addr,
 	if (mm->map_count > MAX_MAP_COUNT)
 		return -ENOMEM;
 
-	if (security_vm_enough_memory(len >> PAGE_SHIFT))
+	if (security_vm_enough_memory(VM_AD_DEFAULT, len >> PAGE_SHIFT))
 		return -ENOMEM;
 
 	flags = VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
diff -upN reference/mm/mprotect.c current/mm/mprotect.c
--- reference/mm/mprotect.c	2004-03-25 15:03:28.000000000 +0000
+++ current/mm/mprotect.c	2004-03-25 15:03:32.000000000 +0000
@@ -173,9 +173,10 @@ mprotect_fixup(struct vm_area_struct *vm
 	 * a MAP_NORESERVE private mapping to writable will now reserve.
 	 */
 	if (newflags & VM_WRITE) {
-		if (!(vma->vm_flags & (VM_ACCOUNT|VM_WRITE|VM_SHARED))) {
+		if (!(vma->vm_flags & (VM_ACCOUNT|VM_WRITE|VM_SHARED)) &&
+				VM_ACCTDOM(vma) == VM_AD_DEFAULT) {
 			charged = (end - start) >> PAGE_SHIFT;
-			if (security_vm_enough_memory(charged))
+			if (security_vm_enough_memory(VM_ACCTDOM(vma), charged))
 				return -ENOMEM;
 			newflags |= VM_ACCOUNT;
 		}
diff -upN reference/mm/mremap.c current/mm/mremap.c
--- reference/mm/mremap.c	2004-02-23 18:15:13.000000000 +0000
+++ current/mm/mremap.c	2004-03-25 15:03:32.000000000 +0000
@@ -400,10 +400,10 @@ unsigned long do_mremap(unsigned long ad
 
 	if (vma->vm_flags & VM_ACCOUNT) {
 		charged = (new_len - old_len) >> PAGE_SHIFT;
-		if (security_vm_enough_memory(charged))
+		if (security_vm_enough_memory(VM_ACCTDOM(vma), charged))
 			goto out_nc;
 	}
-
+  
 	/* old_len exactly to the end of the area..
 	 * And we're not relocating the area.
 	 */
diff -upN reference/mm/shmem.c current/mm/shmem.c
--- reference/mm/shmem.c	2004-03-25 02:43:43.000000000 +0000
+++ current/mm/shmem.c	2004-03-25 15:03:32.000000000 +0000
@@ -526,7 +526,7 @@ static int shmem_notify_change(struct de
 	 	 */
 		change = VM_ACCT(attr->ia_size) - VM_ACCT(inode->i_size);
 		if (change > 0) {
-			if (security_vm_enough_memory(change))
+			if (security_vm_enough_memory(VM_AD_DEFAULT, change))
 				return -ENOMEM;
 		} else if (attr->ia_size < inode->i_size) {
 			vm_unacct_memory(-change);
@@ -1187,7 +1187,8 @@ shmem_file_write(struct file *file, cons
 	maxpos = inode->i_size;
 	if (maxpos < pos + count) {
 		maxpos = pos + count;
-		if (security_vm_enough_memory(VM_ACCT(maxpos) - VM_ACCT(inode->i_size))) {
+		if (security_vm_enough_memory(VM_AD_DEFAULT,
+				VM_ACCT(maxpos) - VM_ACCT(inode->i_size))) {
 			err = -ENOMEM;
 			goto out;
 		}
@@ -1551,7 +1552,7 @@ static int shmem_symlink(struct inode *d
 		memcpy(info, symname, len);
 		inode->i_op = &shmem_symlink_inline_operations;
 	} else {
-		if (security_vm_enough_memory(VM_ACCT(1))) {
+		if (security_vm_enough_memory(VM_AD_DEFAULT, VM_ACCT(1))) {
 			iput(inode);
 			return -ENOMEM;
 		}
@@ -1947,7 +1948,8 @@ struct file *shmem_file_setup(char *name
 	if (size > SHMEM_MAX_BYTES)
 		return ERR_PTR(-EINVAL);
 
-	if ((flags & VM_ACCOUNT) && security_vm_enough_memory(VM_ACCT(size)))
+	if ((flags & VM_ACCOUNT) && security_vm_enough_memory(VM_AD_DEFAULT,
+			VM_ACCT(size)))
 		return ERR_PTR(-ENOMEM);
 
 	error = -ENOMEM;
diff -upN reference/mm/swapfile.c current/mm/swapfile.c
--- reference/mm/swapfile.c	2004-03-25 02:43:43.000000000 +0000
+++ current/mm/swapfile.c	2004-03-25 15:03:32.000000000 +0000
@@ -1048,7 +1048,7 @@ asmlinkage long sys_swapoff(const char _
 		swap_list_unlock();
 		goto out_dput;
 	}
-	if (!security_vm_enough_memory(p->pages))
+	if (!security_vm_enough_memory(VM_AD_DEFAULT, p->pages))
 		vm_unacct_memory(p->pages);
 	else {
 		err = -ENOMEM;
diff -upN reference/security/commoncap.c current/security/commoncap.c
--- reference/security/commoncap.c	2004-03-25 02:43:44.000000000 +0000
+++ current/security/commoncap.c	2004-03-25 15:03:32.000000000 +0000
@@ -308,10 +308,16 @@ int cap_syslog (int type)
  * Strict overcommit modes added 2002 Feb 26 by Alan Cox.
  * Additional code 2002 Jul 20 by Robert Love.
  */
-int cap_vm_enough_memory(long pages)
+int cap_vm_enough_memory(int domain, long pages)
 {
 	unsigned long free, allowed;
 
+	/* We only account for the default memory domain, assume overcommit
+	 * for all others.
+	 */
+	if (domain != VM_AD_DEFAULT)
+		return 0;
+
 	vm_acct_memory(pages);
 
         /*
diff -upN reference/security/dummy.c current/security/dummy.c
--- reference/security/dummy.c	2004-03-25 02:43:44.000000000 +0000
+++ current/security/dummy.c	2004-03-25 15:03:32.000000000 +0000
@@ -109,10 +109,16 @@ static int dummy_syslog (int type)
  * We currently support three overcommit policies, which are set via the
  * vm.overcommit_memory sysctl.  See Documentation/vm/overcommit-accounting
  */
-static int dummy_vm_enough_memory(long pages)
+static int dummy_vm_enough_memory(int domain, long pages)
 {
 	unsigned long free, allowed;
 
+	/* We only account for the default memory domain, assume overcommit
+	 * for all others.
+	 */
+	if (domain != VM_AD_DEFAULT)
+		return 0;
+
 	vm_acct_memory(pages);
 
         /*
diff -upN reference/security/selinux/hooks.c current/security/selinux/hooks.c
--- reference/security/selinux/hooks.c	2004-03-25 02:43:44.000000000 +0000
+++ current/security/selinux/hooks.c	2004-03-25 15:03:32.000000000 +0000
@@ -1496,12 +1496,18 @@ static int selinux_syslog(int type)
  * Strict overcommit modes added 2002 Feb 26 by Alan Cox.
  * Additional code 2002 Jul 20 by Robert Love.
  */
-static int selinux_vm_enough_memory(long pages)
+static int selinux_vm_enough_memory(int domain, long pages)
 {
 	unsigned long free, allowed;
 	int rc;
 	struct task_security_struct *tsec = current->security;
 
+	/* We only account for the default memory domain, assume overcommit
+	 * for all others.
+	 */
+	if (domain != VM_AD_DEFAULT)
+		return 0;
+
 	vm_acct_memory(pages);
 
         /*

