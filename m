Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbTIEFB5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 01:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbTIEFB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 01:01:57 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:28557 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262232AbTIEFBb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 01:01:31 -0400
Date: Fri, 5 Sep 2003 06:01:12 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Unpinned futexes v2 - part 2: mremap & munmap
Message-ID: <20030905050112.GB2197@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an optional add-on to the previous patch.
See description.

Thanks,
-- Jamie


Patch: futex-mremap-2.6.0-test4-12jl
Requires: futex-fixes-2.6.0-test4-11jl

This patch does two things.

	1. It fixes the interaction between mremap() and futexes on
	   private mappings implemented by the earlier patch.  mremap()
	   now moves the futexes.  The rehashing is done carefully to
	   retain the order of queued waiters on an address.

	   When mremap() shrinks a region, it is equivalent to a partial
	   unmapping, which is handled by the do_munmap() change below.

	2. do_munmap() is also handled.  Whenever a private mapping is
	   unmapped, for whatever reason, futexes waiting on the
	   unmapped region are immediately woken.  Those that are
	   waiting with FUTEX_WAIT will return -EFAULT to their caller.
	   Those waiting with FUTEX_FD will report a hangup condition.

Note that truncation of files underlying shared mappings is not handled
by this patch.  Only private mappings are handled.

Various combinations of mremap, munmap and remap_file_pages of shared
and private mappings have been tested.

Enjoy,
-- Jamie


diff -urN --exclude-from=dontdiff newfut-2.6.0-test4/include/linux/futex.h laptop-2.6.0-test4/include/linux/futex.h
--- newfut-2.6.0-test4/include/linux/futex.h	2003-07-08 21:43:52.000000000 +0100
+++ laptop-2.6.0-test4/include/linux/futex.h	2003-09-05 03:19:07.000000000 +0100
@@ -17,4 +17,8 @@
 long do_futex(unsigned long uaddr, int op, int val,
 		unsigned long timeout, unsigned long uaddr2, int val2);
 
+int futex_remap_range(struct mm_struct *mm,
+		      unsigned long old_start, unsigned long old_len,
+		      unsigned long new_start, unsigned long new_len);
+
 #endif
diff -urN --exclude-from=dontdiff newfut-2.6.0-test4/include/linux/mm.h laptop-2.6.0-test4/include/linux/mm.h
--- newfut-2.6.0-test4/include/linux/mm.h	2003-09-05 00:50:09.000000000 +0100
+++ laptop-2.6.0-test4/include/linux/mm.h	2003-09-05 03:21:05.000000000 +0100
@@ -109,8 +109,9 @@
 #define VM_DONTEXPAND	0x00040000	/* Cannot expand with mremap() */
 #define VM_RESERVED	0x00080000	/* Don't unmap it from swap_out */
 #define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
-#define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
-#define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
+#define VM_HUGETLB	0x00200000	/* Huge TLB Page VM */
+#define VM_NONLINEAR	0x00400000	/* Is non-linear (remap_file_pages) */
+#define VM_FUTEX	0x00800000	/* May have private-mapped futexes */
 
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
diff -urN --exclude-from=dontdiff newfut-2.6.0-test4/kernel/futex.c laptop-2.6.0-test4/kernel/futex.c
--- newfut-2.6.0-test4/kernel/futex.c	2003-09-05 03:23:17.000000000 +0100
+++ laptop-2.6.0-test4/kernel/futex.c	2003-09-05 05:37:08.494152396 +0100
@@ -71,8 +71,9 @@
 	/* Key which the futex is hashed on. */
 	union futex_key key;
 
-	/* For fd, sigio sent using these. */
-	int fd;
+	/* While a futex is waiting, this holds fd; sigio is sent using it.
+	   When woken, this holds either 0 or -EFAULT, set by the waker. */
+	int fd_or_result;
 	struct file *filp;
 };
 
@@ -118,10 +119,11 @@
  * Should be called with &current->mm->mmap_sem,
  * but NOT &futex_lock or &current->mm->page_table_lock.
  */
-static int get_futex_key(unsigned long uaddr, union futex_key *key)
+static int get_futex_key(unsigned long uaddr, union futex_key *key,
+			 int set_vma_futex)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma, *vma2;
 	struct page *page;
 	int err;
 
@@ -138,6 +140,7 @@
 	 * it's in a shared or private mapping.  So check vma first.
 	 */
 	vma = find_extend_vma(mm, uaddr);
+try_again:
 	if (unlikely(!vma))
 		return -EFAULT;
 
@@ -157,6 +160,18 @@
 	 * mappings of _writable_ handles.
 	 */
 	if (likely(!(vma->vm_flags & VM_MAYSHARE))) {
+		if (set_vma_futex && unlikely(!(vma->vm_flags & VM_FUTEX))) {
+			up_read(&mm->mmap_sem);
+			down_write(&mm->mmap_sem);
+			vma2 = find_extend_vma(mm, uaddr);
+			if (unlikely(vma != vma2)) {
+				vma = vma2;
+				downgrade_write(&mm->mmap_sem);
+				goto try_again;
+			}
+			vma->vm_flags |= VM_FUTEX;
+			downgrade_write(&mm->mmap_sem);
+		}
 		key->private.mm = mm;
 		key->private.uaddr = uaddr;
 		return 0;
@@ -206,6 +221,81 @@
 
 
 /*
+ * This function moves and/or wakes futexes when do_munmap() and do_mremap()
+ * are called.  It is only applicable to MAP_PRIVATE mappings.
+ *
+ * It moves all futexes from one address range to another, looking only
+ * at futexes for private mappings within one mm.  Futexes which fit inside
+ * the new address range are reinserted into the hash at their new address.
+ * The others are woken and unqueued - this is done when a mapping shrinks
+ * or is unmapped.
+ *
+ * "old_start", "old_len", "new_start" and "new_len" must all be
+ * multiples of PAGE_SIZE.  The old and new address ranges must be valid
+ * and not wrap.
+ *
+ * This must be called with &mm->mmap_sem held, during the
+ * same lock region as when the actual vmas and ptes are changed.
+ *
+ * Returns the number of futexes in the new region.
+ */
+int futex_remap_range(struct mm_struct *mm,
+		      unsigned long old_start, unsigned long old_len,
+		      unsigned long new_start, unsigned long new_len)
+{
+	int j, count = 0;
+	spin_lock(&futex_lock);
+
+	for (j = 0; j < (1<<FUTEX_HASHBITS); j++) {
+		struct list_head *i, *next, *new_head, *head = &futex_queues[j];
+
+		list_for_each_safe(i, next, head) {
+			struct futex_q *this =
+				list_entry(i, struct futex_q, list);
+
+			if (this->key.both.ptr != mm)
+				continue;
+			if (this->key.offset & 1) {
+				this->key.offset--; /* Skip if moved. */
+				continue;
+			}
+			if (this->key.private.uaddr < old_start
+			    || this->key.private.uaddr - old_start >= old_len)
+				continue;
+
+			if (this->key.private.uaddr - old_start >= new_len) {
+				/*
+				 * Wake and remove futexes which are outside
+				 * the new range, sending them -EFAULT.
+				 */
+				list_del_init(i);
+				wake_up_all(&this->waiters);
+				if (this->filp)
+					send_sigio(&this->filp->f_owner,
+						   this->fd_or_result, POLL_IN);
+				this->fd_or_result = -EFAULT;
+				continue;
+			}
+
+			/*
+			 * Move futexes which are inside the new range.
+			 */
+			count++;
+			this->key.private.uaddr += new_start - old_start;
+			new_head = hash_futex(&this->key);
+			if (new_head == head)
+				continue;
+			if (new_head > head)
+				this->key.offset++; /* Mark as moved. */
+			list_move_tail(i, new_head);
+		}
+	}
+
+	spin_unlock(&futex_lock);
+	return count;
+}
+
+/*
  * Wake up all waiters hashed on the physical page that is mapped
  * to this virtual address:
  */
@@ -217,7 +307,7 @@
 
 	down_read(&current->mm->mmap_sem);
 
-	ret = get_futex_key(uaddr, &key);
+	ret = get_futex_key(uaddr, &key, 0);
 	if (unlikely(ret != 0))
 		goto out;
 
@@ -231,7 +321,9 @@
 			list_del_init(i);
 			wake_up_all(&this->waiters);
 			if (this->filp)
-				send_sigio(&this->filp->f_owner, this->fd, POLL_IN);
+				send_sigio(&this->filp->f_owner,
+					   this->fd_or_result, POLL_IN);
+			this->fd_or_result = 0;
 			ret++;
 			if (ret >= num)
 				break;
@@ -240,6 +332,10 @@
 	spin_unlock(&futex_lock);
 
 out:
+	/*
+	 * The mmap semaphore must be kept until after the wakeups, to
+	 * avoid races against futex_rehash().
+	 */
 	up_read(&current->mm->mmap_sem);
 	return ret;
 }
@@ -257,10 +353,10 @@
 
 	down_read(&current->mm->mmap_sem);
 
-	ret = get_futex_key(uaddr1, &key1);
+	ret = get_futex_key(uaddr1, &key1, 0);
 	if (unlikely(ret != 0))
 		goto out;
-	ret = get_futex_key(uaddr2, &key2);
+	ret = get_futex_key(uaddr2, &key2, 1);
 	if (unlikely(ret != 0))
 		goto out;
 
@@ -277,7 +373,8 @@
 				wake_up_all(&this->waiters);
 				if (this->filp)
 					send_sigio(&this->filp->f_owner,
-							this->fd, POLL_IN);
+						   this->fd_or_result, POLL_IN);
+				this->fd_or_result = 0;
 			} else {
 				list_add_tail(i, head2);
 				this->key = key2;
@@ -299,7 +396,7 @@
 	struct list_head *head = hash_futex(key);
 
 	q->key = *key;
-	q->fd = fd;
+	q->fd_or_result = fd;
 	q->filp = filp;
 
 	spin_lock(&futex_lock);
@@ -333,7 +430,7 @@
 
 	down_read(&current->mm->mmap_sem);
 
-	ret = get_futex_key(uaddr, &key);
+	ret = get_futex_key(uaddr, &key, 1);
 	if (unlikely(ret != 0))
 		goto out_release_sem;
 
@@ -394,7 +491,7 @@
 	 */
 	ret = unqueue_me(&q);
 	if (ret == 0)
-		return 0;
+		return q.fd_or_result;
 	if (time == 0)
 		return -ETIMEDOUT;
 	if (signal_pending(current))
@@ -410,7 +507,7 @@
 	 * Were we unqueued anyway?
 	 */
 	if (!unqueue_me(&q))
-		ret = 0;
+		ret = q.fd_or_result;
  out_release_sem:
 	up_read(&current->mm->mmap_sem);
 	return ret;
@@ -434,8 +531,15 @@
 
 	poll_wait(filp, &q->waiters, wait);
 	spin_lock(&futex_lock);
-	if (list_empty(&q->list))
+	if (list_empty(&q->list)) {
 		ret = POLLIN | POLLRDNORM;
+		/*
+		 * Report POLLHUP for futexes which are cancelled due
+		 * to the memory disappearing.
+		 */
+		if (q->fd_or_result < 0)
+			ret |= POLLHUP | POLLERR;
+	}
 	spin_unlock(&futex_lock);
 
 	return ret;
@@ -493,7 +597,7 @@
 	}
 
 	down_read(&current->mm->mmap_sem);
-	err = get_futex_key(uaddr, &key);
+	err = get_futex_key(uaddr, &key, 1);
 	up_read(&current->mm->mmap_sem);
 
 	if (unlikely(err != 0)) {
diff -urN --exclude-from=dontdiff newfut-2.6.0-test4/mm/mmap.c laptop-2.6.0-test4/mm/mmap.c
--- newfut-2.6.0-test4/mm/mmap.c	2003-08-27 22:56:05.000000000 +0100
+++ laptop-2.6.0-test4/mm/mmap.c	2003-09-05 05:23:39.000000000 +0100
@@ -19,6 +19,7 @@
 #include <linux/hugetlb.h>
 #include <linux/profile.h>
 #include <linux/module.h>
+#include <linux/futex.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -1093,15 +1094,18 @@
  * Ok - we have the memory areas we should free on the 'free' list,
  * so release them, and do the vma updates.
  */
-static void unmap_vma_list(struct mm_struct *mm,
-	struct vm_area_struct *mpnt)
+static inline int unmap_vma_list(struct mm_struct *mm,
+				 struct vm_area_struct *mpnt)
 {
+	unsigned long flags = 0;
 	do {
 		struct vm_area_struct *next = mpnt->vm_next;
+		flags |= mpnt->vm_flags;
 		unmap_vma(mm, mpnt);
 		mpnt = next;
 	} while (mpnt != NULL);
 	validate_mm(mm);
+	return (flags & VM_FUTEX) ? 1 : 0;
 }
 
 /*
@@ -1260,7 +1264,10 @@
 	spin_unlock(&mm->page_table_lock);
 
 	/* Fix up all other VM information */
-	unmap_vma_list(mm, mpnt);
+	if (unmap_vma_list(mm, mpnt)) {
+		/* Remove futexes which are waiting on private mappings. */
+		futex_remap_range(mm, start, len, start, 0);
+	}
 
 	return 0;
 }
diff -urN --exclude-from=dontdiff newfut-2.6.0-test4/mm/mremap.c laptop-2.6.0-test4/mm/mremap.c
--- newfut-2.6.0-test4/mm/mremap.c	2003-09-02 20:50:46.000000000 +0100
+++ laptop-2.6.0-test4/mm/mremap.c	2003-09-05 04:09:16.000000000 +0100
@@ -17,6 +17,7 @@
 #include <linux/highmem.h>
 #include <linux/rmap-locking.h>
 #include <linux/security.h>
+#include <linux/futex.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -188,6 +189,10 @@
 	struct vm_area_struct *new_vma, *next, *prev;
 	int allocated_vma;
 	int split = 0;
+	unsigned long vm_futex = vma->vm_flags & VM_FUTEX;
+ 
+	if (vm_futex && addr == vma->vm_start && vma->vm_end - addr == old_len)
+		vma->vm_flags &= ~VM_FUTEX;
 
 	new_vma = NULL;
 	next = find_vma_prev(mm, new_addr, &prev);
@@ -253,7 +258,17 @@
 				get_file(new_vma->vm_file);
 			if (new_vma->vm_ops && new_vma->vm_ops->open)
 				new_vma->vm_ops->open(new_vma);
-			insert_vm_struct(current->mm, new_vma);
+			insert_vm_struct(mm, new_vma);
+		}
+
+		/*
+		 * Move futexes if it's a private mapping.  This must be
+		 * done after we've committed to the move (i.e. after
+		 * move_page_tables) and before calling do_munmap.
+		 */
+		if (vm_futex && futex_remap_range(mm, addr, old_len,
+						  new_addr, new_len)) {
+			new_vma->vm_flags |= VM_FUTEX;
 		}
 
 		/* Conceal VM_ACCOUNT so old reservation is not undone */
@@ -267,7 +282,7 @@
 		} else
 			vma = NULL;		/* nothing more to do */
 
-		do_munmap(current->mm, addr, old_len);
+		do_munmap(mm, addr, old_len);
 
 		/* Restore VM_ACCOUNT if one or two pieces of vma left */
 		if (vma) {
@@ -276,9 +291,9 @@
 				vma->vm_next->vm_flags |= VM_ACCOUNT;
 		}
 
-		current->mm->total_vm += new_len >> PAGE_SHIFT;
+		mm->total_vm += new_len >> PAGE_SHIFT;
 		if (vm_locked) {
-			current->mm->locked_vm += new_len >> PAGE_SHIFT;
+			mm->locked_vm += new_len >> PAGE_SHIFT;
 			if (new_len > old_len)
 				make_pages_present(new_addr + old_len,
 						   new_addr + new_len);
