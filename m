Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbTFXN3I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 09:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTFXN3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 09:29:08 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:3469 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262029AbTFXN2v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 09:28:51 -0400
Subject: Re: [RFC][PATCH] Security hook for vm_enough_memory
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       James Morris <jmorris@intercode.com.au>,
       lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
In-Reply-To: <1056386424.14228.78.camel@dhcp22.swansea.linux.org.uk>
References: <1056385527.1709.415.camel@moss-huskers.epoch.ncsc.mil>
	 <1056386424.14228.78.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1056462130.1110.58.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Jun 2003 09:42:11 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-23 at 12:40, Alan Cox wrote:
> Is there any reason for not wrapping the entire vm_enough_memory() function
> and using the current one as default. In some environments being able to make
> total commit constraints based on roles may actually be useful.
> 
> (Think "sum of students memory < 40% of system" 8))
> 
> vm_enough_memory has to be kernel side but its basically policy so pluggable
> IMHO is good.

This patch against 2.5.73 replaces vm_enough_memory with a security hook
per Alan Cox's suggestion so that security modules can completely
replace the logic if desired.  Note that the patch changes the interface
to follow the convention of the other security hooks, i.e. return 0 if
ok or -errno on failure (-ENOMEM in this case) rather than returning a
boolean.  It also exports various variables and functions required for
the vm_enough_memory logic.  If anyone has any objections to this patch,
please let me know.

 fs/exec.c                |    2 -
 include/linux/mman.h     |    3 +
 include/linux/security.h |   16 ++++++++++
 include/linux/slab.h     |    2 +
 kernel/fork.c            |    2 -
 mm/mmap.c                |   71 +++++------------------------------------------
 mm/mprotect.c            |    2 -
 mm/mremap.c              |    3 +
 mm/page_alloc.c          |    5 +++
 mm/shmem.c               |    9 +++--
 mm/slab.c                |    2 +
 mm/swap.c                |    2 +
 mm/swapfile.c            |    6 +++
 security/capability.c    |   65 +++++++++++++++++++++++++++++++++++++++++++
 security/dummy.c         |   52 ++++++++++++++++++++++++++++++++++
 15 files changed, 169 insertions(+), 73 deletions(-)

diff -X /home/sds/dontdiff -ru linux-2.5.73/fs/exec.c linux-2.5.73-vmenough/fs/exec.c
--- linux-2.5.73/fs/exec.c	2003-06-22 14:32:41.000000000 -0400
+++ linux-2.5.73-vmenough/fs/exec.c	2003-06-24 09:29:38.000000000 -0400
@@ -392,7 +392,7 @@
 	if (!mpnt)
 		return -ENOMEM;
 
-	if (!vm_enough_memory((STACK_TOP - (PAGE_MASK & (unsigned long) bprm->p))>>PAGE_SHIFT)) {
+	if (security_vm_enough_memory((STACK_TOP - (PAGE_MASK & (unsigned long) bprm->p))>>PAGE_SHIFT)) {
 		kmem_cache_free(vm_area_cachep, mpnt);
 		return -ENOMEM;
 	}
diff -X /home/sds/dontdiff -ru linux-2.5.73/include/linux/mman.h linux-2.5.73-vmenough/include/linux/mman.h
--- linux-2.5.73/include/linux/mman.h	2003-06-22 14:32:33.000000000 -0400
+++ linux-2.5.73-vmenough/include/linux/mman.h	2003-06-24 09:29:38.000000000 -0400
@@ -9,7 +9,8 @@
 #define MREMAP_MAYMOVE	1
 #define MREMAP_FIXED	2
 
-extern int vm_enough_memory(long pages);
+extern int sysctl_overcommit_memory;
+extern int sysctl_overcommit_ratio;
 extern atomic_t vm_committed_space;
 
 #ifdef CONFIG_SMP
diff -X /home/sds/dontdiff -ru linux-2.5.73/include/linux/security.h linux-2.5.73-vmenough/include/linux/security.h
--- linux-2.5.73/include/linux/security.h	2003-06-22 14:33:02.000000000 -0400
+++ linux-2.5.73-vmenough/include/linux/security.h	2003-06-24 09:29:38.000000000 -0400
@@ -48,6 +48,7 @@
 extern int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid, int flags);
 extern void cap_task_reparent_to_init (struct task_struct *p);
 extern int cap_syslog (int type);
+extern int cap_vm_enough_memory (long pages);
 
 static inline int cap_netlink_send (struct sk_buff *skb)
 {
@@ -951,6 +952,10 @@
  *	See the syslog(2) manual page for an explanation of the @type values.  
  *	@type contains the type of action.
  *	Return 0 if permission is granted.
+ * @vm_enough_memory:
+ *	Check permissions for allocating a new virtual mapping.
+ *      @pages contains the number of pages.
+ *	Return 0 if permission is granted.
  *
  * @register_security:
  * 	allow module stacking.
@@ -982,6 +987,7 @@
 	int (*quotactl) (int cmds, int type, int id, struct super_block * sb);
 	int (*quota_on) (struct file * f);
 	int (*syslog) (int type);
+	int (*vm_enough_memory) (long pages);
 
 	int (*bprm_alloc_security) (struct linux_binprm * bprm);
 	void (*bprm_free_security) (struct linux_binprm * bprm);
@@ -1230,6 +1236,11 @@
 	return security_ops->syslog(type);
 }
 
+static inline int security_vm_enough_memory(long pages)
+{
+	return security_ops->vm_enough_memory(pages);
+}
+
 static inline int security_bprm_alloc (struct linux_binprm *bprm)
 {
 	return security_ops->bprm_alloc_security (bprm);
@@ -1884,6 +1895,11 @@
 	return cap_syslog(type);
 }
 
+static inline int security_vm_enough_memory(long pages)
+{
+	return cap_vm_enough_memory(pages);
+}
+
 static inline int security_bprm_alloc (struct linux_binprm *bprm)
 {
 	return 0;
diff -X /home/sds/dontdiff -ru linux-2.5.73/include/linux/slab.h linux-2.5.73-vmenough/include/linux/slab.h
--- linux-2.5.73/include/linux/slab.h	2003-06-22 14:33:35.000000000 -0400
+++ linux-2.5.73-vmenough/include/linux/slab.h	2003-06-24 09:29:38.000000000 -0400
@@ -114,6 +114,8 @@
 extern kmem_cache_t	*sighand_cachep;
 extern kmem_cache_t	*bio_cachep;
 
+extern atomic_t slab_reclaim_pages;
+
 #endif	/* __KERNEL__ */
 
 #endif	/* _LINUX_SLAB_H */
diff -X /home/sds/dontdiff -ru linux-2.5.73/kernel/fork.c linux-2.5.73-vmenough/kernel/fork.c
--- linux-2.5.73/kernel/fork.c	2003-06-22 14:32:32.000000000 -0400
+++ linux-2.5.73-vmenough/kernel/fork.c	2003-06-24 09:29:38.000000000 -0400
@@ -286,7 +286,7 @@
 			continue;
 		if (mpnt->vm_flags & VM_ACCOUNT) {
 			unsigned int len = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
-			if (!vm_enough_memory(len))
+			if (security_vm_enough_memory(len))
 				goto fail_nomem;
 			charge += len;
 		}
diff -X /home/sds/dontdiff -ru linux-2.5.73/mm/mmap.c linux-2.5.73-vmenough/mm/mmap.c
--- linux-2.5.73/mm/mmap.c	2003-06-22 14:32:57.000000000 -0400
+++ linux-2.5.73-vmenough/mm/mmap.c	2003-06-24 09:29:38.000000000 -0400
@@ -18,6 +18,7 @@
 #include <linux/security.h>
 #include <linux/hugetlb.h>
 #include <linux/profile.h>
+#include <linux/module.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -53,65 +54,9 @@
 int sysctl_overcommit_ratio = 50;	/* default is 50% */
 atomic_t vm_committed_space = ATOMIC_INIT(0);
 
-/*
- * Check that a process has enough memory to allocate a new virtual
- * mapping. 1 means there is enough memory for the allocation to
- * succeed and 0 implies there is not.
- *
- * We currently support three overcommit policies, which are set via the
- * vm.overcommit_memory sysctl.  See Documentation/vm/overcommit-acounting
- *
- * Strict overcommit modes added 2002 Feb 26 by Alan Cox.
- * Additional code 2002 Jul 20 by Robert Love.
- */
-extern atomic_t slab_reclaim_pages;
-int vm_enough_memory(long pages)
-{
-	unsigned long free, allowed;
-
-	vm_acct_memory(pages);
-
-        /*
-	 * Sometimes we want to use more memory than we have
-	 */
-	if (sysctl_overcommit_memory == 1)
-		return 1;
-
-	if (sysctl_overcommit_memory == 0) {
-		free = get_page_cache_size();
-		free += nr_free_pages();
-		free += nr_swap_pages;
-
-		/*
-		 * Any slabs which are created with the
-		 * SLAB_RECLAIM_ACCOUNT flag claim to have contents
-		 * which are reclaimable, under pressure.  The dentry
-		 * cache and most inode caches should fall into this
-		 */
-		free += atomic_read(&slab_reclaim_pages);
-
-		/*
-		 * Leave the last 3% for root
-		 */
-		if (!capable(CAP_SYS_ADMIN))
-			free -= free / 32;
-		
-		if (free > pages)
-			return 1;
-		vm_unacct_memory(pages);
-		return 0;
-	}
-
-	allowed = totalram_pages * sysctl_overcommit_ratio / 100;
-	allowed += total_swap_pages;
-
-	if (atomic_read(&vm_committed_space) < allowed)
-		return 1;
-
-	vm_unacct_memory(pages);
-
-	return 0;
-}
+EXPORT_SYMBOL(sysctl_overcommit_memory);
+EXPORT_SYMBOL(sysctl_overcommit_ratio);
+EXPORT_SYMBOL(vm_committed_space);
 
 /*
  * Requires inode->i_mapping->i_shared_sem
@@ -646,7 +591,7 @@
 			 * Private writable mapping: check memory availability
 			 */
 			charged = len >> PAGE_SHIFT;
-			if (!vm_enough_memory(charged))
+			if (security_vm_enough_memory(charged))
 				return -ENOMEM;
 			vm_flags |= VM_ACCOUNT;
 		}
@@ -942,7 +887,7 @@
 	grow = (address - vma->vm_end) >> PAGE_SHIFT;
 
 	/* Overcommit.. */
-	if (!vm_enough_memory(grow)) {
+	if (security_vm_enough_memory(grow)) {
 		spin_unlock(&vma->vm_mm->page_table_lock);
 		return -ENOMEM;
 	}
@@ -996,7 +941,7 @@
 	grow = (vma->vm_start - address) >> PAGE_SHIFT;
 
 	/* Overcommit.. */
-	if (!vm_enough_memory(grow)) {
+	if (security_vm_enough_memory(grow)) {
 		spin_unlock(&vma->vm_mm->page_table_lock);
 		return -ENOMEM;
 	}
@@ -1368,7 +1313,7 @@
 	if (mm->map_count > MAX_MAP_COUNT)
 		return -ENOMEM;
 
-	if (!vm_enough_memory(len >> PAGE_SHIFT))
+	if (security_vm_enough_memory(len >> PAGE_SHIFT))
 		return -ENOMEM;
 
 	flags = VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
diff -X /home/sds/dontdiff -ru linux-2.5.73/mm/mprotect.c linux-2.5.73-vmenough/mm/mprotect.c
--- linux-2.5.73/mm/mprotect.c	2003-06-22 14:32:42.000000000 -0400
+++ linux-2.5.73-vmenough/mm/mprotect.c	2003-06-24 09:29:38.000000000 -0400
@@ -175,7 +175,7 @@
 	if (newflags & VM_WRITE) {
 		if (!(vma->vm_flags & (VM_ACCOUNT|VM_WRITE|VM_SHARED))) {
 			charged = (end - start) >> PAGE_SHIFT;
-			if (!vm_enough_memory(charged))
+			if (security_vm_enough_memory(charged))
 				return -ENOMEM;
 			newflags |= VM_ACCOUNT;
 		}
diff -X /home/sds/dontdiff -ru linux-2.5.73/mm/mremap.c linux-2.5.73-vmenough/mm/mremap.c
--- linux-2.5.73/mm/mremap.c	2003-06-22 14:32:55.000000000 -0400
+++ linux-2.5.73-vmenough/mm/mremap.c	2003-06-24 09:29:38.000000000 -0400
@@ -16,6 +16,7 @@
 #include <linux/fs.h>
 #include <linux/highmem.h>
 #include <linux/rmap-locking.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -391,7 +392,7 @@
 
 	if (vma->vm_flags & VM_ACCOUNT) {
 		charged = (new_len - old_len) >> PAGE_SHIFT;
-		if (!vm_enough_memory(charged))
+		if (security_vm_enough_memory(charged))
 			goto out_nc;
 	}
 
diff -X /home/sds/dontdiff -ru linux-2.5.73/mm/page_alloc.c linux-2.5.73-vmenough/mm/page_alloc.c
--- linux-2.5.73/mm/page_alloc.c	2003-06-22 14:32:32.000000000 -0400
+++ linux-2.5.73-vmenough/mm/page_alloc.c	2003-06-24 09:29:38.000000000 -0400
@@ -41,6 +41,9 @@
 int numnodes = 1;
 int sysctl_lower_zone_protection = 0;
 
+EXPORT_SYMBOL(totalram_pages);
+EXPORT_SYMBOL(nr_swap_pages);
+
 /*
  * Used by page_zone() to look up the address of the struct zone whose
  * id is encoded in the upper bits of page->flags
@@ -726,6 +729,7 @@
 
 	return sum;
 }
+EXPORT_SYMBOL(nr_free_pages);
 
 unsigned int nr_used_zone_pages(void)
 {
@@ -818,6 +822,7 @@
 EXPORT_PER_CPU_SYMBOL(page_states);
 
 atomic_t nr_pagecache = ATOMIC_INIT(0);
+EXPORT_SYMBOL(nr_pagecache);
 #ifdef CONFIG_SMP
 DEFINE_PER_CPU(long, nr_pagecache_local) = 0;
 #endif
diff -X /home/sds/dontdiff -ru linux-2.5.73/mm/shmem.c linux-2.5.73-vmenough/mm/shmem.c
--- linux-2.5.73/mm/shmem.c	2003-06-22 14:32:43.000000000 -0400
+++ linux-2.5.73-vmenough/mm/shmem.c	2003-06-24 09:29:38.000000000 -0400
@@ -36,6 +36,7 @@
 #include <linux/writeback.h>
 #include <linux/vfs.h>
 #include <linux/blkdev.h>
+#include <linux/security.h>
 #include <asm/uaccess.h>
 #include <asm/div64.h>
 
@@ -507,7 +508,7 @@
 	 	 */
 		change = VM_ACCT(attr->ia_size) - VM_ACCT(inode->i_size);
 		if (change > 0) {
-			if (!vm_enough_memory(change))
+			if (security_vm_enough_memory(change))
 				return -ENOMEM;
 		} else if (attr->ia_size < inode->i_size) {
 			vm_unacct_memory(-change);
@@ -1139,7 +1140,7 @@
 	maxpos = inode->i_size;
 	if (maxpos < pos + count) {
 		maxpos = pos + count;
-		if (!vm_enough_memory(VM_ACCT(maxpos) - VM_ACCT(inode->i_size))) {
+		if (security_vm_enough_memory(VM_ACCT(maxpos) - VM_ACCT(inode->i_size))) {
 			err = -ENOMEM;
 			goto out;
 		}
@@ -1493,7 +1494,7 @@
 		memcpy(info, symname, len);
 		inode->i_op = &shmem_symlink_inline_operations;
 	} else {
-		if (!vm_enough_memory(VM_ACCT(1))) {
+		if (security_vm_enough_memory(VM_ACCT(1))) {
 			iput(inode);
 			return -ENOMEM;
 		}
@@ -1887,7 +1888,7 @@
 	if (size > SHMEM_MAX_BYTES)
 		return ERR_PTR(-EINVAL);
 
-	if ((flags & VM_ACCOUNT) && !vm_enough_memory(VM_ACCT(size)))
+	if ((flags & VM_ACCOUNT) && security_vm_enough_memory(VM_ACCT(size)))
 		return ERR_PTR(-ENOMEM);
 
 	error = -ENOMEM;
diff -X /home/sds/dontdiff -ru linux-2.5.73/mm/slab.c linux-2.5.73-vmenough/mm/slab.c
--- linux-2.5.73/mm/slab.c	2003-06-22 14:33:07.000000000 -0400
+++ linux-2.5.73-vmenough/mm/slab.c	2003-06-24 09:29:38.000000000 -0400
@@ -89,6 +89,7 @@
 #include	<linux/notifier.h>
 #include	<linux/kallsyms.h>
 #include	<linux/cpu.h>
+#include	<linux/module.h>
 #include	<asm/uaccess.h>
 
 /*
@@ -430,6 +431,7 @@
  * SLAB_RECLAIM_ACCOUNT turns this on per-slab
  */
 atomic_t slab_reclaim_pages;
+EXPORT_SYMBOL(slab_reclaim_pages);
 
 /*
  * chicken and egg problem: delay the per-cpu array allocation
diff -X /home/sds/dontdiff -ru linux-2.5.73/mm/swap.c linux-2.5.73-vmenough/mm/swap.c
--- linux-2.5.73/mm/swap.c	2003-06-22 14:32:42.000000000 -0400
+++ linux-2.5.73-vmenough/mm/swap.c	2003-06-24 09:29:38.000000000 -0400
@@ -20,6 +20,7 @@
 #include <linux/pagemap.h>
 #include <linux/pagevec.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/mm_inline.h>
 #include <linux/buffer_head.h>	/* for try_to_release_page() */
 #include <linux/percpu.h>
@@ -371,6 +372,7 @@
 	}
 	preempt_enable();
 }
+EXPORT_SYMBOL(vm_acct_memory);
 #endif
 
 
diff -X /home/sds/dontdiff -ru linux-2.5.73/mm/swapfile.c linux-2.5.73-vmenough/mm/swapfile.c
--- linux-2.5.73/mm/swapfile.c	2003-06-22 14:32:36.000000000 -0400
+++ linux-2.5.73-vmenough/mm/swapfile.c	2003-06-24 09:29:38.000000000 -0400
@@ -20,7 +20,9 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/rmap-locking.h>
+#include <linux/security.h>
 
 #include <asm/pgtable.h>
 #include <linux/swapops.h>
@@ -30,6 +32,8 @@
 int total_swap_pages;
 static int swap_overflow;
 
+EXPORT_SYMBOL(total_swap_pages);
+
 static const char Bad_file[] = "Bad swap file entry ";
 static const char Unused_file[] = "Unused swap file entry ";
 static const char Bad_offset[] = "Bad swap offset entry ";
@@ -1042,7 +1046,7 @@
 		swap_list_unlock();
 		goto out_dput;
 	}
-	if (vm_enough_memory(p->pages))
+	if (!security_vm_enough_memory(p->pages))
 		vm_unacct_memory(p->pages);
 	else {
 		err = -ENOMEM;
diff -X /home/sds/dontdiff -ru linux-2.5.73/security/capability.c linux-2.5.73-vmenough/security/capability.c
--- linux-2.5.73/security/capability.c	2003-06-22 14:32:41.000000000 -0400
+++ linux-2.5.73-vmenough/security/capability.c	2003-06-24 09:29:38.000000000 -0400
@@ -15,6 +15,9 @@
 #include <linux/security.h>
 #include <linux/file.h>
 #include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/pagemap.h>
+#include <linux/swap.h>
 #include <linux/smp_lock.h>
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
@@ -264,6 +267,65 @@
 	return 0;
 }
 
+/*
+ * Check that a process has enough memory to allocate a new virtual
+ * mapping. 0 means there is enough memory for the allocation to
+ * succeed and -ENOMEM implies there is not.
+ *
+ * We currently support three overcommit policies, which are set via the
+ * vm.overcommit_memory sysctl.  See Documentation/vm/overcommit-acounting
+ *
+ * Strict overcommit modes added 2002 Feb 26 by Alan Cox.
+ * Additional code 2002 Jul 20 by Robert Love.
+ */
+int cap_vm_enough_memory(long pages)
+{
+	unsigned long free, allowed;
+
+	vm_acct_memory(pages);
+
+        /*
+	 * Sometimes we want to use more memory than we have
+	 */
+	if (sysctl_overcommit_memory == 1)
+		return 0;
+
+	if (sysctl_overcommit_memory == 0) {
+		free = get_page_cache_size();
+		free += nr_free_pages();
+		free += nr_swap_pages;
+
+		/*
+		 * Any slabs which are created with the
+		 * SLAB_RECLAIM_ACCOUNT flag claim to have contents
+		 * which are reclaimable, under pressure.  The dentry
+		 * cache and most inode caches should fall into this
+		 */
+		free += atomic_read(&slab_reclaim_pages);
+
+		/*
+		 * Leave the last 3% for root
+		 */
+		if (!capable(CAP_SYS_ADMIN))
+			free -= free / 32;
+		
+		if (free > pages)
+			return 0;
+		vm_unacct_memory(pages);
+		return -ENOMEM;
+	}
+
+	allowed = totalram_pages * sysctl_overcommit_ratio / 100;
+	allowed += total_swap_pages;
+
+	if (atomic_read(&vm_committed_space) < allowed)
+		return 0;
+
+	vm_unacct_memory(pages);
+
+	return -ENOMEM;
+}
+
 EXPORT_SYMBOL(cap_capable);
 EXPORT_SYMBOL(cap_ptrace);
 EXPORT_SYMBOL(cap_capget);
@@ -274,6 +336,7 @@
 EXPORT_SYMBOL(cap_task_post_setuid);
 EXPORT_SYMBOL(cap_task_reparent_to_init);
 EXPORT_SYMBOL(cap_syslog);
+EXPORT_SYMBOL(cap_vm_enough_memory);
 
 #ifdef CONFIG_SECURITY
 
@@ -294,6 +357,8 @@
 	.task_reparent_to_init =	cap_task_reparent_to_init,
 
 	.syslog =                       cap_syslog,
+
+	.vm_enough_memory =             cap_vm_enough_memory,
 };
 
 #if defined(CONFIG_SECURITY_CAPABILITIES_MODULE)
diff -X /home/sds/dontdiff -ru linux-2.5.73/security/dummy.c linux-2.5.73-vmenough/security/dummy.c
--- linux-2.5.73/security/dummy.c	2003-06-22 14:32:36.000000000 -0400
+++ linux-2.5.73-vmenough/security/dummy.c	2003-06-24 09:29:38.000000000 -0400
@@ -17,6 +17,9 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/mman.h>
+#include <linux/pagemap.h>
+#include <linux/swap.h>
 #include <linux/security.h>
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
@@ -97,6 +100,54 @@
 	return 0;
 }
 
+static int dummy_vm_enough_memory(long pages)
+{
+	unsigned long free, allowed;
+
+	vm_acct_memory(pages);
+
+        /*
+	 * Sometimes we want to use more memory than we have
+	 */
+	if (sysctl_overcommit_memory == 1)
+		return 0;
+
+	if (sysctl_overcommit_memory == 0) {
+		free = get_page_cache_size();
+		free += nr_free_pages();
+		free += nr_swap_pages;
+
+		/*
+		 * Any slabs which are created with the
+		 * SLAB_RECLAIM_ACCOUNT flag claim to have contents
+		 * which are reclaimable, under pressure.  The dentry
+		 * cache and most inode caches should fall into this
+		 */
+		free += atomic_read(&slab_reclaim_pages);
+
+		/*
+		 * Leave the last 3% for root
+		 */
+		if (current->euid)
+			free -= free / 32;
+		
+		if (free > pages)
+			return 0;
+		vm_unacct_memory(pages);
+		return -ENOMEM;
+	}
+
+	allowed = totalram_pages * sysctl_overcommit_ratio / 100;
+	allowed += total_swap_pages;
+
+	if (atomic_read(&vm_committed_space) < allowed)
+		return 0;
+
+	vm_unacct_memory(pages);
+
+	return -ENOMEM;
+}
+
 static int dummy_bprm_alloc_security (struct linux_binprm *bprm)
 {
 	return 0;
@@ -783,6 +834,7 @@
 	set_to_dummy_if_null(ops, quota_on);
 	set_to_dummy_if_null(ops, sysctl);
 	set_to_dummy_if_null(ops, syslog);
+	set_to_dummy_if_null(ops, vm_enough_memory);
 	set_to_dummy_if_null(ops, bprm_alloc_security);
 	set_to_dummy_if_null(ops, bprm_free_security);
 	set_to_dummy_if_null(ops, bprm_compute_creds);

  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

