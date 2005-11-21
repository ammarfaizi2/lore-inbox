Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbVKUTru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbVKUTru (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 14:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVKUTri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 14:47:38 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:55804 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932374AbVKUTre
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 14:47:34 -0500
Message-ID: <43822480.6080301@mvista.com>
Date: Mon, 21 Nov 2005 11:48:16 -0800
From: David Singleton <dsingleton@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Dinakar Guniguntala <dino@in.ibm.com>, linux-kernel@vger.kernel.org,
       "David F. Carlson" <dave@chronolytics.com>
Subject: Re: PI BUG with -rt13
References: <20051117161817.GA3935@in.ibm.com> <437D0C59.1060607@mvista.com> <20051118092909.GC4858@elte.hu> <20051118132137.GA5639@in.ibm.com> <20051118132715.GA3314@elte.hu> <8311ADE9-5855-11DA-BBAB-000A959BB91E@mvista.com> <20051118174454.GA2793@elte.hu>
In-Reply-To: <20051118174454.GA2793@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------080602050102030007050405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080602050102030007050405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:

>* david singleton <dsingleton@mvista.com> wrote:
>
>  
>
>>>both rt_mutex_free() and rt_mutex_set_owner() must be called with the
>>>proper locking. David?
>>>      
>>>
>>        Yes, the lock  needs to be protected by the robust semaphore.
>>        The locking order is:
>>
>>                mmap_sem to protect the vma that holds the pthread_mutex
>>
>>                robust_sem to protect the futex_mutex chain.
>>
>>                futex_mutex - the rt_mutex associated with the 
>>pthread_mutex.
>>    
>>
>
>well, also lock->wait_lock and lock->pi_lock. The act of making another 
>thread the owner of this particular mutex must be performed carefully.  
>Check out rt.c to see what locking dependencies there are. (We can also 
>do a lockless cmpxchg for unlocked mutexes, under certain 
>  
>


Ingo,
    here is a patch that provides the correct locking for the rt_mutex 
backing the robust
pthread_mutex.   The patch also unifies the locking for all the robust 
functions and
adds support for pthread_mutexes on the heap.

David



>circumstances.)
>
>	Ingo
>  
>


--------------080602050102030007050405
Content-Type: text/plain;
 name="patch-2.6.14-rt13-rf1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.14-rt13-rf1"

Signed-off-by: David Singleton <dsingleton@mvista.com>
Description:
	This patch unifies the locking for the robust futex functions,
	correctly protects the rt_mutex backing the pthread mutex and
        adds the support for pthread_mutexes allocated on the heap.

diff -uar base/linux-2.6.14/kernel/futex.c wip/linux-2.6.14/kernel/futex.c
--- base/linux-2.6.14/kernel/futex.c	2005-11-18 20:36:53.000000000 -0800
+++ wip/linux-2.6.14/kernel/futex.c	2005-11-21 11:28:45.000000000 -0800
@@ -145,7 +145,8 @@
  *
  * Should be called with &current->mm->mmap_sem but NOT any spinlocks.
  */
-static int get_futex_key(unsigned long uaddr, union futex_key *key)
+static int get_futex_key(unsigned long uaddr, union futex_key *key,
+			struct list_head **list, struct semaphore **sem)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
@@ -168,6 +169,18 @@
 	if (unlikely(!vma))
 		return -EFAULT;
 
+	if (vma->vm_file == NULL) {
+		if (vma->robust_init) {
+			*list = &vma->robust_list;
+			*sem = &vma->robust_sem;
+		}
+	} else if (vma->vm_file->f_mapping == NULL) {
+		return -EINVAL;
+	} else {
+		*list = &vma->vm_file->f_mapping->robust_list;
+		*sem = &vma->vm_file->f_mapping->robust_sem;
+	}
+
 	/*
 	 * Permissions.
 	 */
@@ -306,13 +319,18 @@
 	struct futex_hash_bucket *bh;
 	struct list_head *head;
 	struct futex_q *this, *next;
+	struct semaphore *sem;
 	int ret;
 
 	down_read(&current->mm->mmap_sem);
 
-	ret = get_futex_key(uaddr, &key);
+	ret = get_futex_key(uaddr, &key, &head, &sem);
 	if (unlikely(ret != 0))
 		goto out;
+	if (head == NULL) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	bh = hash_futex(&key);
 	spin_lock(&bh->lock);
@@ -341,16 +359,17 @@
 	union futex_key key1, key2;
 	struct futex_hash_bucket *bh1, *bh2;
 	struct list_head *head;
+	struct semaphore *sem;
 	struct futex_q *this, *next;
 	int ret, op_ret, attempt = 0;
 
 retryfull:
 	down_read(&current->mm->mmap_sem);
 
-	ret = get_futex_key(uaddr1, &key1);
+	ret = get_futex_key(uaddr1, &key1, &head, &sem);
 	if (unlikely(ret != 0))
 		goto out;
-	ret = get_futex_key(uaddr2, &key2);
+	ret = get_futex_key(uaddr2, &key2, &head, &sem);
 	if (unlikely(ret != 0))
 		goto out;
 
@@ -454,16 +473,17 @@
 	union futex_key key1, key2;
 	struct futex_hash_bucket *bh1, *bh2;
 	struct list_head *head1;
+	struct semaphore *sem;
 	struct futex_q *this, *next;
 	int ret, drop_count = 0;
 
  retry:
 	down_read(&current->mm->mmap_sem);
 
-	ret = get_futex_key(uaddr1, &key1);
+	ret = get_futex_key(uaddr1, &key1, &head1, &sem);
 	if (unlikely(ret != 0))
 		goto out;
-	ret = get_futex_key(uaddr2, &key2);
+	ret = get_futex_key(uaddr2, &key2, &head1, &sem);
 	if (unlikely(ret != 0))
 		goto out;
 
@@ -628,11 +648,13 @@
 	int ret, curval;
 	struct futex_q q;
 	struct futex_hash_bucket *bh;
+	struct list_head *head;
+	struct semaphore *sem;
 
  retry:
 	down_read(&current->mm->mmap_sem);
 
-	ret = get_futex_key(uaddr, &q.key);
+	ret = get_futex_key(uaddr, &q.key, &head, &sem);
 	if (unlikely(ret != 0))
 		goto out_release_sem;
 
@@ -775,6 +797,8 @@
 {
 	struct futex_q *q;
 	struct file *filp;
+	struct list_head *head;
+	struct semaphore *sem;
 	int ret, err;
 
 	ret = -EINVAL;
@@ -810,7 +834,7 @@
 	}
 
 	down_read(&current->mm->mmap_sem);
-	err = get_futex_key(uaddr, &q->key);
+	err = get_futex_key(uaddr, &q->key, &head, &sem);
 
 	if (unlikely(err != 0)) {
 		up_read(&current->mm->mmap_sem);
@@ -863,133 +887,6 @@
 };
 
 /*
- * Get parameters which are the keys for a robust futex.
- *
- * For shared mappings, it's (page->index, vma->vm_file->f_dentry->d_inode,
- * offset_within_page).  For private mappings, it's (uaddr, current->mm).
- * We can usually work out the index without swapping in the page.
- *
- * Returns: 0, or negative error code.
- * The key words are stored in *key on success.
- *
- * Should be called with &current->mm->mmap_sem but NOT any spinlocks.
- */
-static int get_robust_futex_key(unsigned long uaddr, union futex_key *key,
-				struct futex_robust **robust)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	struct address_space *mapping;
-	struct page *page;
-	struct list_head *head;
-	struct futex_robust *this, *next;
-	int found = 0;
-	int err = 1;
-
-	/*
-	 * The futex address must be "naturally" aligned.
-	 */
-	key->both.offset = uaddr % PAGE_SIZE;
-	if (unlikely((key->both.offset % sizeof(u32)) != 0))
-		return -EINVAL;
-	uaddr -= key->both.offset;
-
-	/*
-	 * The futex is hashed differently depending on whether
-	 * it's in a shared or private mapping.  So check vma first.
-	 */
-	vma = find_extend_vma(mm, uaddr);
-	if (unlikely(!vma))
-		return -EFAULT;
-
-	if (vma->vm_file == NULL)
-		return -EINVAL;
-	/*
-	 * Permissions.
-	 */
-	if (unlikely((vma->vm_flags & (VM_IO|VM_READ)) != VM_READ))
-		return (vma->vm_flags & VM_IO) ? -EPERM : -EACCES;
-
-	/*
-	 * Private mappings are handled in a simple way.
-	 *
-	 * NOTE: When userspace waits on a MAP_SHARED mapping, even if
-	 * it's a read-only handle, it's expected that futexes attach to
-	 * the object not the particular process.  Therefore we use
-	 * VM_MAYSHARE here, not VM_SHARED which is restricted to shared
-	 * mappings of _writable_ handles.
-	 */
-	if (likely(!(vma->vm_flags & VM_MAYSHARE))) {
-		key->private.mm = mm;
-		key->private.uaddr = uaddr;
-		err = 0;
-		goto out;
-	}
-
-	/*
-	 * Linear file mappings are also simple.
-	 */
-	key->shared.inode = vma->vm_file->f_dentry->d_inode;
-	key->both.offset++; /* Bit 0 of offset indicates inode-based key. */
-	if (likely(!(vma->vm_flags & VM_NONLINEAR))) {
-		key->shared.pgoff = (((uaddr - vma->vm_start) >> PAGE_SHIFT)
-				     + vma->vm_pgoff);
-		err = 0;
-		goto out;
-	}
-
-	/*
-	 * We could walk the page table to read the non-linear
-	 * pte, and get the page index without fetching the page
-	 * from swap.  But that's a lot of code to duplicate here
-	 * for a rare case, so we simply fetch the page.
-	 */
-
-	/*
-	 * Do a quick atomic lookup first - this is the fastpath.
-	 */
-	spin_lock(&current->mm->page_table_lock);
-	page = follow_page(mm, uaddr, 0);
-	if (likely(page != NULL)) {
-		key->shared.pgoff =
-			page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
-		spin_unlock(&current->mm->page_table_lock);
-		err = 0;
-		goto out;
-	}
-	spin_unlock(&current->mm->page_table_lock);
-
-	/*
-	 * Do it the general way.
-	 */
-	err = get_user_pages(current, mm, uaddr, 1, 0, 0, &page, NULL);
-	if (err >= 0) {
-		key->shared.pgoff =
-			page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
-		put_page(page);
-		err = 0;
-	}
-out:
-	mapping = vma->vm_file->f_mapping;
-	if (mapping) {
-		down(&mapping->robust_sem);
-		head = &mapping->robust_list;
-
-		list_for_each_entry_safe(this, next, head, list) {
-			if (match_futex(&this->key, key)) {
-				found++;
-				*robust = this;
-				break;
-			}
-		}
-		up(&mapping->robust_sem);
-	}
-	if (!found)
-		err = -EINVAL;
-	return err;
-}
-
-/*
  * there really isn't an atomic page fault, so we're going to
  * put the burden on the user. If either futex_get_user or futex_put_user
  * return -EFAULT, it really means it's avoiding a race condition
@@ -1027,29 +924,29 @@
 {
 	struct thread_info *ti = current_thread_info();
 	union futex_key key;
-	struct futex_hash_bucket *bh;
-	struct list_head *head;
-	struct futex_q *this, *next;
+	struct list_head *head = NULL;
+	struct semaphore *sem = NULL;
+	struct futex_robust *this, *next;
 	int ret;
 	int value;
 	int found = 0;
-	struct futex_robust *robust;
 
 retry:
 	down_read(&current->mm->mmap_sem);
 
-	ret = get_robust_futex_key(uaddr, &key, &robust);
+	ret = get_futex_key(uaddr, &key, &head, &sem);
 	if (ret != 0)
 		goto out;
-
-	bh = hash_futex(&key);
-	spin_lock(&bh->lock);
+	if (head == NULL) {
+		ret = -EINVAL;
+		goto out;
+	}
+	down(sem);
 
 	ret = get_futex_value_locked(&value, (int __user *)uaddr);
 
 	if (unlikely(ret)) {
-		spin_unlock(&bh->lock);
-
+		up(sem);
 		/* If we would have faulted, release mmap_sem, fault it in and
 		 * start all over again.
 		 */
@@ -1062,8 +959,6 @@
 		return ret;
 	}
 
-	head = &bh->chain;
-
 	/*
 	 * if the owner died, mark the futex as not recoverable
 	 * and wake up all waiting tasks.
@@ -1075,23 +970,21 @@
 			goto out_unlock;
 		}
 		list_for_each_entry_safe(this, next, head, list) {
-			if (match_futex (&this->key, &robust->key)) {
-				up_futex(&robust->futex_mutex);
-				ret++;
+			if (match_futex (&this->key, &key)) {
+				up_futex(&this->futex_mutex);
 			}
 		}
 		goto out_unlock;
 	}
 
-	/* find the first waiting task */
 	list_for_each_entry_safe(this, next, head, list) {
-		if (match_futex (&this->key, &robust->key)) {
+		if (match_futex (&this->key, &key)) {
 			found++;
-			if ((rt_mutex_owner(&robust->futex_mutex)) != ti) {
+			if ((rt_mutex_owner(&this->futex_mutex)) != ti) {
 				ret = -EINVAL;
-				goto out;
+				goto out_unlock;
 			}
-			if (!rt_mutex_has_waiters(&robust->futex_mutex)) {
+			if (!rt_mutex_has_waiters(&this->futex_mutex)) {
 				value = 0;
 				break;
 			} else {
@@ -1110,11 +1003,11 @@
 		ret = -EFAULT;
 		goto out_unlock;
 	}
-	up_futex(&robust->futex_mutex);
+	up_futex(&this->futex_mutex);
 	ret = 1;
 
 out_unlock:
-	spin_unlock(&bh->lock);
+	up(sem);
 out:
 	up_read(&current->mm->mmap_sem);
 	return ret;
@@ -1132,24 +1025,29 @@
 static int futex_wait_robust(unsigned long uaddr, unsigned long time)
 {
 	int ret, curval;
-	struct futex_q q;
-	struct futex_hash_bucket *bh;
-	struct futex_robust *robust;
+	struct futex_robust *this, *next;
+	struct list_head *head = NULL;
+	struct semaphore *sem = NULL;
+	union futex_key key;
 	pid_t owner_pid;
+	int found = 0;
 
  retry:
 	down_read(&current->mm->mmap_sem);
 
-	ret = get_robust_futex_key(uaddr, &q.key, &robust);
+	ret = get_futex_key(uaddr, &key, &head, &sem);
 	if (ret != 0)
-		goto out_release_sem;
-
-	bh = queue_lock(&q, -1, NULL);
+		goto out;
+	if (head == NULL) {
+		ret = -EINVAL;
+		goto out;
+	}
+	down(sem);
 
 	ret = get_futex_value_locked(&curval, (int __user *)uaddr);
 
 	if (unlikely(ret)) {
-		queue_unlock(&q, bh);
+		up(sem);
 
 		/* If we would have faulted, release mmap_sem, fault it in and
 		 * start all over again.
@@ -1170,54 +1068,49 @@
 	 */
 	if (curval == 0) {
 		ret = -EAGAIN;
-		queue_unlock(&q, bh);
-		goto out_release_sem;
+		goto out_unlock;
+	}
+	if ((curval & FUTEX_PID) == current->pid) {
+		ret = -EAGAIN;
+		goto out_unlock;
 	}
 
 	/* if owner has died, we don't want to wait */
 	if ((curval & FUTEX_OWNER_DIED)) {
 		ret = -EOWNERDEAD;
-		queue_unlock(&q, bh);
-		goto out_release_sem;
+		goto out_unlock;
 	}
 
-	__queue_me(&q, bh);
-
-	/*
-	 * Now the futex is queued and we have checked the data, we
-	 * don't want to hold mmap_sem while we sleep.
-	 */
-	up_read(&current->mm->mmap_sem);
-
-	/*
-	 * There might have been scheduling since the queue_me(), as we
-	 * cannot hold a spinlock across the get_user() in case it
-	 * faults, and we cannot just set TASK_INTERRUPTIBLE state when
-	 * queueing ourselves into the futex hash.  This code thus has to
-	 * rely on the futex_wake() code removing us from hash when it
-	 * wakes us up.
-	 */
+	list_for_each_entry_safe(this, next, head, list) {
+		if (match_futex(&this->key, &key)) {
+			found++;
+			break;
+		}
+	}
+	if (!found) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	get_key_refs(&key);
 
-	ret = down_futex(&robust->futex_mutex, time, owner_pid);
-	unqueue_me(&q);
-	if (ret < 0) {
-		goto out;
-	} else {
+	ret = down_futex(&this->futex_mutex, time, owner_pid, sem);
+	if (ret >= 0) {
 		curval = futex_get_user(uaddr);
 		curval &= ~FUTEX_PID;
 		curval |= current->pid;
-		if (rt_mutex_has_waiters(&robust->futex_mutex))
+		if (rt_mutex_has_waiters(&this->futex_mutex))
 			curval |= FUTEX_WAITERS;
 		ret = futex_put_user(curval, uaddr);
 		if (curval & FUTEX_OWNER_DIED) {
 			ret = -EOWNERDEAD;
 		}
-		goto out;
 	}
+	return ret;
 
-out_release_sem:
-	up_read(&current->mm->mmap_sem);
+out_unlock:
+	up(sem);
 out:
+	up_read(&current->mm->mmap_sem);
 	return ret;
 }
 
@@ -1330,31 +1223,30 @@
 /**
  * find_owned_futex - find futexes owned by the current task
  * @vma: the vma to search for futexes
+ * @head: list head for list of robust futexes
+ * @sem: semaphore that protects the list
  *
  * Walk the list of registered robust futexes for this @vma,
  * setting the %FUTEX_OWNER_DIED flag on those futexes owned
  * by the current, exiting task.
  */
-static void find_owned_futex(struct vm_area_struct *vma)
+static void find_owned_futex(struct vm_area_struct *vma, struct list_head *head,
+				struct semaphore *sem)
 {
 	struct thread_info *ti = current_thread_info();
-	struct address_space *mapping;
-	struct list_head *head;
 	struct futex_robust *this, *next;
  	unsigned long uaddr;
 	int value;
 
-	mapping = vma->vm_file->f_mapping;
-	down(&mapping->robust_sem);
+	down(sem);
 
-	head = &mapping->robust_list;
 	list_for_each_entry_safe(this, next, head, list) {
 
 		uaddr = get_futex_uaddr(&this->key, vma);
 		if (uaddr == 0)
 			continue;
 
-		up(&mapping->robust_sem);
+		up(sem);
 		up_read(&current->mm->mmap_sem);
 		value = futex_get_user(uaddr);
 		if (this->futex_mutex.mutex_attr & FUTEX_ATTR_ROBUST)
@@ -1371,11 +1263,11 @@
 			value &= ~FUTEX_PID;
 			futex_put_user(value, uaddr);
 		}
-		down(&mapping->robust_sem);
+		down(sem);
 		down_read(&current->mm->mmap_sem);
 	}
 
-	up(&mapping->robust_sem);
+	up(sem);
 }
 
 /**
@@ -1390,6 +1282,7 @@
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	struct list_head *list;
+	struct semaphore *sem;
 
 	if (tsk==NULL)
 		return;
@@ -1401,22 +1294,36 @@
 	down_read(&mm->mmap_sem);
 
 	for (vma = mm->mmap; vma != NULL; vma = vma->vm_next) {
-		if (vma->vm_file == NULL)
-			continue;
+		if (vma->vm_file == NULL) {
+			if (vma->robust_init) {
+				sem = &vma->robust_sem;
+				list = &vma->robust_list;
+			} else
+				continue;
 
-		if (vma->vm_file->f_mapping == NULL)
-			continue;
+		} else {
+			if (vma->vm_file->f_mapping == NULL)
+				continue;
 
-		list = &vma->vm_file->f_mapping->robust_list;
+			list = &vma->vm_file->f_mapping->robust_list;
+			sem = &vma->vm_file->f_mapping->robust_sem;
+		}
 		if (list_empty(list))
 			continue;
 
-		find_owned_futex(vma);
+		find_owned_futex(vma, list, sem);
 	}
 
 	up_read(&mm->mmap_sem);
 }
 
+static void futex_init_anon(struct vm_area_struct *vma)
+{
+	INIT_LIST_HEAD(&vma->robust_list);
+	init_MUTEX(&vma->robust_sem);
+	vma->robust_init = 1;
+}
+
 /**
  * futex_register - Record the existence of a robust futex in a vma.
  * @uaddr: user space address of the robust futex
@@ -1431,8 +1338,8 @@
 	struct futex_robust *robust;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	struct file *file;
-	struct address_space *mapping;
+	struct list_head *head = NULL;
+	struct semaphore *sem = NULL;
 
 	robust = kmalloc(sizeof(*robust), GFP_KERNEL);
 	down_read(&current->mm->mmap_sem);
@@ -1449,7 +1356,7 @@
 	 * priority queueing is default on robust mutexes.
 	 */
 
-	ret = get_futex_key(uaddr, &robust->key);
+	ret = get_futex_key(uaddr, &robust->key, &head, &sem);
 	if (unlikely(ret != 0))	{
 		kfree(robust);
 		goto out;
@@ -1462,17 +1369,25 @@
 		goto out;
 	}
 
-	file = vma->vm_file;
-	if (!file) {
-		ret = -EINVAL;
-		kfree(robust);
-		goto out;
+	if (vma->vm_file == NULL) {
+		if (vma->robust_init == 0)
+			futex_init_anon(vma);
+		head = &vma->robust_list;
+		sem = &vma->robust_sem;
+	} else {
+		if (vma->vm_file->f_mapping) {
+			head = &vma->vm_file->f_mapping->robust_list;
+			sem = &vma->vm_file->f_mapping->robust_sem;
+		} else {
+			ret = -EINVAL;
+			kfree(robust);
+			goto out;
+		}
 	}
 
-	mapping = file->f_mapping;
-	down(&mapping->robust_sem);
-	list_add_tail(&robust->list, &mapping->robust_list);
-	up(&mapping->robust_sem);
+	down(sem);
+	list_add_tail(&robust->list, head);
+	up(sem);
 
 out:
 	up_read(&current->mm->mmap_sem);
@@ -1492,35 +1407,21 @@
 {
 	struct thread_info *ti = current_thread_info();
 	union futex_key key;
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	struct file *file;
-	struct address_space *mapping;
-	struct list_head *head;
-	struct futex_robust *this, *next, *robust;
+	struct list_head *head = NULL;
+	struct semaphore *sem = NULL;
+	struct futex_robust *this, *next;
 	int ret;
 
-	down_read(&mm->mmap_sem);
+	down_read(&current->mm->mmap_sem);
 
-	ret = get_robust_futex_key(uaddr, &key, &robust);
+	ret = get_futex_key(uaddr, &key, &head, &sem);
 	if (unlikely(ret != 0))
 		goto out;
-
-	vma = find_extend_vma(mm, uaddr);
-	if (unlikely(!vma)) {
-		ret = -EFAULT;
-		goto out;
-	}
-
-	file = vma->vm_file;
-	if (!file) {
+	if (head == NULL) {
 		ret = -EINVAL;
 		goto out;
 	}
-
-	mapping = file->f_mapping;
-	down(&mapping->robust_sem);
-	head = &mapping->robust_list;
+	down(sem);
 
 	list_for_each_entry_safe(this, next, head, list) {
 		if (match_futex (&this->key, &key)) {
@@ -1540,9 +1441,9 @@
 		}
 	}
 
-	up(&mapping->robust_sem);
+	up(sem);
 out:
-	up_read(&mm->mmap_sem);
+	up_read(&current->mm->mmap_sem);
 	return ret;
 }
 
@@ -1562,24 +1463,45 @@
 	int ret = 0;
 	int value = 0;
 	union futex_key key;
-	struct futex_robust *robust;
+	struct futex_robust *this, *next;
+	struct list_head *head = NULL;
+	struct semaphore *sem = NULL;
 
 	down_read(&current->mm->mmap_sem);
-	ret = get_robust_futex_key(uaddr, &key, &robust);
-	up_read(&current->mm->mmap_sem);
+	ret = get_futex_key(uaddr, &key, &head, &sem);
 	if (ret != 0)
-		return ret;
-	/*
-	 * can't recover a futex we don't own
-	 */
-	if (!rt_mutex_owned_by(&robust->futex_mutex, ti)) {
-		return -EINVAL;
+		goto out;
+	if (head == NULL) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	down(sem);
+	list_for_each_entry_safe(this, next, head, list) {
+		if (match_futex(&this->key, &key)) {
+			/*
+			* can't recover a futex we don't own
+			*/
+			if (!rt_mutex_owned_by(&this->futex_mutex, ti)) {
+				ret = -EINVAL;
+				goto out_unlock;
+			}
+			break;
+		}
+        }
+
+	if ((value = futex_get_user(uaddr)) == -EFAULT) {
+		ret = -EFAULT;
+		goto out_unlock;
 	}
-	if ((value = futex_get_user(uaddr)) == -EFAULT)
-		return ret;
 
 	value &= ~FUTEX_OWNER_DIED;
-	return (futex_put_user(value, uaddr));
+	ret = futex_put_user(value, uaddr);
+out_unlock:
+	up(sem);
+out:
+	up_read(&current->mm->mmap_sem);
+	return ret;
 }
 
 long do_futex(unsigned long uaddr, int op, int val, unsigned long timeout,
diff -uar base/linux-2.6.14/kernel/rt.c wip/linux-2.6.14/kernel/rt.c
--- base/linux-2.6.14/kernel/rt.c	2005-11-18 20:36:53.000000000 -0800
+++ wip/linux-2.6.14/kernel/rt.c	2005-11-21 11:37:15.000000000 -0800
@@ -2927,6 +2927,40 @@
 }
 EXPORT_SYMBOL(rt_mutex_owned_by);
 
+static int
+down_try_futex(struct rt_mutex *lock, struct thread_info *proxy_owner __EIP_DECL__)
+{
+	struct thread_info *old_owner;
+	struct task_struct *task = proxy_owner->task;
+	unsigned long flags;
+	int ret = 0;
+
+	trace_lock_irqsave(&trace_lock, flags, proxy_owner);
+	TRACE_BUG_ON_LOCKED(!raw_irqs_disabled());
+	_raw_spin_lock(&task->pi_lock);
+	_raw_spin_lock(&lock->wait_lock);
+
+	old_owner = lock_owner(lock);
+	init_lists(lock);
+
+	if (likely(!old_owner) || __grab_lock(lock, task, old_owner->task)) {
+		/* granted */
+		TRACE_WARN_ON_LOCKED(!plist_empty(&lock->wait_list) && !old_owner);
+		if (old_owner) {
+			_raw_spin_lock(&old_owner->task->pi_lock);
+			set_new_owner(lock, old_owner, proxy_owner __EIP__);
+			_raw_spin_unlock(&old_owner->task->pi_lock);
+		} else
+			set_new_owner(lock, old_owner, proxy_owner __EIP__);
+		ret = 1;
+	}
+	_raw_spin_unlock(&lock->wait_lock);
+	_raw_spin_unlock(&task->pi_lock);
+	trace_unlock_irqrestore(&trace_lock, flags, proxy_owner);
+
+	return ret;
+}
+
 /*
  * This call has two functions.  The first is to lock the lock on behalf of
  * another thread if the rt_mutex has no owner.  If the rt_mutex has no
@@ -2939,24 +2973,58 @@
  * and now own the lock, or negative values for failure, or positive
  * values for the amount of time we waited before getting the lock.
  */
-int fastcall down_futex(struct rt_mutex *lock, unsigned long time, pid_t owner_pid)
+int fastcall
+down_futex(struct rt_mutex *lock, unsigned long time, pid_t owner_pid, struct semaphore *sem)
 {
 	struct task_struct *owner_task = NULL;
 #ifdef CONFIG_DEBUG_DEADLOCKS
 	unsigned long eip = CALLER_ADDR0;
 #endif
-	read_lock(&tasklist_lock);
+	int ret = 0;
+
+	rcu_read_lock();
 	owner_task = find_task_by_pid(owner_pid);
-	read_unlock(&tasklist_lock);
+	if (!get_task_struct_rcu(owner_task))
+		owner_task = NULL;
+	rcu_read_unlock();
 
-	if (!owner_task)
-		return -EOWNERDEAD;
+	/*
+	 * if the owner can't be found or has changed to us
+	 * then just return.
+	 */
 
-	if (rt_mutex_free(lock)) {
-		__down_mutex(lock __EIP__);
-		rt_mutex_set_owner(lock, owner_task->thread_info);
+	if (!owner_task || owner_task == current) {
+		up(sem);
+		up_read(&current->mm->mmap_sem);
+		return -EAGAIN;
 	}
-	return __down_interruptible(lock, time __EIP__);
+
+	/*
+	 * This works for both ways the down_try_futex functions.
+	 * If it gets the lock then we are the first waiter (This
+	 * is being called from wait_robust because the lock is
+	 * contended) and we've just locked the lock on behalf of
+	 * the owning thread.  If it finds contention then we aren't
+	 * the first waiter and we'll just block on the down_interruptible.
+	 */
+
+	down_try_futex(lock, owner_task->thread_info __EIP__));
+
+	/*
+	 * we can now drop the locks because the rt_mutex is held.
+	 * and we'll just block on the down interruptible OR
+	 * we'll get the lock and return without blocking, if
+	 * it was unlocked between the down_try_futex and the
+	 * down interruptible.
+	 */
+
+	up(sem);
+	up_read(&current->mm->mmap_sem);
+
+	ret = __down_interruptible(lock, time __EIP__);
+	put_task_struct(owner_task);
+
+	return ret;
 }
 EXPORT_SYMBOL(down_futex);
 
Only in wip/linux-2.6.14/kernel/: rt.c.rej
Only in wip/linux-2.6.14/include/linux: autoconf.h
diff -uar base/linux-2.6.14/include/linux/mm.h wip/linux-2.6.14/include/linux/mm.h
--- base/linux-2.6.14/include/linux/mm.h	2005-11-18 20:36:53.000000000 -0800
+++ wip/linux-2.6.14/include/linux/mm.h	2005-11-21 10:51:19.000000000 -0800
@@ -109,6 +109,11 @@
 #ifdef CONFIG_NUMA
 	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
 #endif
+#ifdef CONFIG_FUTEX
+	int robust_init;		/* robust initialized? */
+	struct list_head robust_list;	/* list of robust futexes in this vma */
+	struct semaphore robust_sem;	/* semaphore to protect the list */
+#endif
 };
 
 /*
diff -uar base/linux-2.6.14/include/linux/rt_lock.h wip/linux-2.6.14/include/linux/rt_lock.h
--- base/linux-2.6.14/include/linux/rt_lock.h	2005-11-18 20:36:53.000000000 -0800
+++ wip/linux-2.6.14/include/linux/rt_lock.h	2005-11-21 10:51:29.000000000 -0800
@@ -383,7 +383,7 @@
 #endif /* CONFIG_PREEMPT_RT */
 
 extern void FASTCALL(up_futex(struct rt_mutex *lock));
-extern int FASTCALL(down_futex(struct rt_mutex *lock, unsigned long time, pid_t owner_pid));
+extern int FASTCALL(down_futex(struct rt_mutex *lock, unsigned long time, pid_t owner_pid, struct semaphore *sem));
 extern int FASTCALL(rt_mutex_owned_by(struct rt_mutex *lock, struct thread_info *t));
 extern int FASTCALL(rt_mutex_has_waiters(struct rt_mutex *lock));
 extern struct thread_info *FASTCALL(rt_mutex_owner(struct rt_mutex *lock));
Only in wip/linux-2.6.14/include/linux: version.h

--------------080602050102030007050405--
