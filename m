Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTJARoh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 13:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbTJARoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 13:44:34 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:47111 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262071AbTJARoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 13:44:12 -0400
Date: Wed, 1 Oct 2003 14:50:19 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCHES] more moving out of stuff from kernel/ksyms.c
Message-ID: <20031001175019.GG964@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please pull from:

bk://kernel.bkbits.net/acme/ksyms-2.6

	Thanks to Al Viro for pointing the set_cpus_schedule bogosity.

- Arnaldo

===================================================================


ChangeSet@1.1356, 2003-10-01 17:23:39-03:00, acme@parisc.kerneljanitors.org
  o kernel/ksyms.c: set_cpus_schedule was EXPORT_SYMBOL_GPL, bring it back
  
  Originally, before this set of patches moving stuff out from kernel/ksyms.c,
  set_cpus_schedule was EXPORT_SYMBOL_GPL, my mistake, bring it back.
  
  Also follow Andrew Morton's suggestions of moving the EXPORT_SYMBOL{_GPL) even
  closer to the place where the symbol exported is defined, i.e. just after the
  symbol definition, this makes mistakes more difficult to happen, as when the
  symbol definition is #ifdefed the EXPORT_SYMBOL{_GPL} is in the same block.

ChangeSet@1.1355, 2003-10-01 17:08:07-03:00, acme@parisc.kerneljanitors.org
  o kernel/ksyms.c: move relevant EXPORT_SYMBOLs to mm/filemap.c


 kernel/ksyms.c |   24 -------------------
 kernel/sched.c |   71 +++++++++++++++++++++++++++++++++------------------------
 mm/filemap.c   |   54 +++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 94 insertions(+), 55 deletions(-)


diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Wed Oct  1 17:32:38 2003
+++ b/kernel/ksyms.c	Wed Oct  1 17:32:38 2003
@@ -182,14 +182,7 @@
 EXPORT_SYMBOL(close_bdev_excl);
 EXPORT_SYMBOL(open_by_devnum);
 EXPORT_SYMBOL(blockdev_direct_IO);
-EXPORT_SYMBOL(generic_file_read);
-EXPORT_SYMBOL(generic_file_sendfile);
-EXPORT_SYMBOL(do_generic_mapping_read);
 EXPORT_SYMBOL(file_ra_state_init);
-EXPORT_SYMBOL(generic_file_write);
-EXPORT_SYMBOL(generic_file_write_nolock);
-EXPORT_SYMBOL(generic_file_mmap);
-EXPORT_SYMBOL(generic_file_readonly_mmap);
 EXPORT_SYMBOL(generic_ro_fops);
 EXPORT_SYMBOL(get_unused_fd);
 EXPORT_SYMBOL(vfs_read);
@@ -212,12 +205,6 @@
 EXPORT_SYMBOL(poll_initwait);
 EXPORT_SYMBOL(poll_freewait);
 EXPORT_SYMBOL(ROOT_DEV);
-EXPORT_SYMBOL(find_get_page);
-EXPORT_SYMBOL(find_lock_page);
-EXPORT_SYMBOL(find_trylock_page);
-EXPORT_SYMBOL(find_or_create_page);
-EXPORT_SYMBOL(grab_cache_page_nowait);
-EXPORT_SYMBOL(read_cache_page);
 EXPORT_SYMBOL(read_cache_pages);
 EXPORT_SYMBOL(mark_page_accessed);
 EXPORT_SYMBOL(vfs_readdir);
@@ -242,13 +229,7 @@
 /* for stackable file systems (lofs, wrapfs, cryptfs, etc.) */
 EXPORT_SYMBOL(default_llseek);
 EXPORT_SYMBOL(dentry_open);
-#ifdef CONFIG_MMU
-EXPORT_SYMBOL(filemap_nopage);
-#endif
-EXPORT_SYMBOL(filemap_fdatawrite);
-EXPORT_SYMBOL(filemap_fdatawait);
 EXPORT_SYMBOL(lock_page);
-EXPORT_SYMBOL(unlock_page);
 
 /* device registration */
 EXPORT_SYMBOL(register_blkdev);
@@ -264,9 +245,6 @@
 EXPORT_SYMBOL(blkdev_put);
 EXPORT_SYMBOL(ioctl_by_bdev);
 EXPORT_SYMBOL(read_dev_sector);
-EXPORT_SYMBOL_GPL(generic_file_direct_IO);
-EXPORT_SYMBOL(generic_file_readv);
-EXPORT_SYMBOL(generic_file_writev);
 EXPORT_SYMBOL(iov_shorten);
 EXPORT_SYMBOL_GPL(default_backing_dev_info);
 
@@ -368,7 +346,6 @@
 EXPORT_SYMBOL(loops_per_jiffy);
 #endif
 
-
 /* misc */
 EXPORT_SYMBOL(panic);
 EXPORT_SYMBOL(panic_notifier_list);
@@ -431,7 +408,6 @@
 EXPORT_SYMBOL(is_bad_inode);
 EXPORT_SYMBOL(__inode_dir_notify);
 EXPORT_SYMBOL(generic_osync_inode);
-EXPORT_SYMBOL(remove_suid);
 
 #ifdef CONFIG_UID16
 EXPORT_SYMBOL(overflowuid);
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Wed Oct  1 17:32:38 2003
+++ b/kernel/sched.c	Wed Oct  1 17:32:38 2003
@@ -643,6 +643,8 @@
 	return try_to_wake_up(p, TASK_STOPPED | TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE, 0, 0);
 }
 
+EXPORT_SYMBOL(wake_up_process);
+
 int wake_up_process_kick(task_t * p)
 {
 	return try_to_wake_up(p, TASK_STOPPED | TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE, 0, 1);
@@ -1586,6 +1588,8 @@
 		goto need_resched;
 }
 
+EXPORT_SYMBOL(schedule);
+
 #ifdef CONFIG_PREEMPT
 /*
  * this is is the entry point to schedule() from in-kernel preemption
@@ -1613,6 +1617,8 @@
 	if (unlikely(test_thread_flag(TIF_NEED_RESCHED)))
 		goto need_resched;
 }
+
+EXPORT_SYMBOL(preempt_schedule);
 #endif /* CONFIG_PREEMPT */
 
 int default_wake_function(wait_queue_t *curr, unsigned mode, int sync)
@@ -1621,6 +1627,8 @@
 	return try_to_wake_up(p, mode, sync, 0);
 }
 
+EXPORT_SYMBOL(default_wake_function);
+
 /*
  * The core wakeup function.  Non-exclusive wakeups (nr_exclusive == 0) just
  * wake everything up.  If it's an exclusive wakeup (nr_exclusive == small +ve
@@ -1661,6 +1669,8 @@
 	spin_unlock_irqrestore(&q->lock, flags);
 }
 
+EXPORT_SYMBOL(__wake_up);
+
 /*
  * Same as __wake_up but called with the spinlock in wait_queue_head_t held.
  */
@@ -1697,6 +1707,8 @@
 	spin_unlock_irqrestore(&q->lock, flags);
 }
 
+EXPORT_SYMBOL(__wake_up_sync);
+
 void complete(struct completion *x)
 {
 	unsigned long flags;
@@ -1707,6 +1719,8 @@
 	spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 
+EXPORT_SYMBOL(complete);
+
 void complete_all(struct completion *x)
 {
 	unsigned long flags;
@@ -1738,6 +1752,8 @@
 	spin_unlock_irq(&x->wait.lock);
 }
 
+EXPORT_SYMBOL(wait_for_completion);
+
 #define	SLEEP_ON_VAR				\
 	unsigned long flags;			\
 	wait_queue_t wait;			\
@@ -1764,6 +1780,8 @@
 	SLEEP_ON_TAIL
 }
 
+EXPORT_SYMBOL(interruptible_sleep_on);
+
 long interruptible_sleep_on_timeout(wait_queue_head_t *q, long timeout)
 {
 	SLEEP_ON_VAR
@@ -1777,6 +1795,8 @@
 	return timeout;
 }
 
+EXPORT_SYMBOL(interruptible_sleep_on_timeout);
+
 void sleep_on(wait_queue_head_t *q)
 {
 	SLEEP_ON_VAR
@@ -1788,6 +1808,8 @@
 	SLEEP_ON_TAIL
 }
 
+EXPORT_SYMBOL(sleep_on);
+
 long sleep_on_timeout(wait_queue_head_t *q, long timeout)
 {
 	SLEEP_ON_VAR
@@ -1801,6 +1823,8 @@
 	return timeout;
 }
 
+EXPORT_SYMBOL(sleep_on_timeout);
+
 void scheduling_functions_end_here(void) { }
 
 void set_user_nice(task_t *p, long nice)
@@ -1850,6 +1874,8 @@
 	task_rq_unlock(rq, &flags);
 }
 
+EXPORT_SYMBOL(set_user_nice);
+
 #ifndef __alpha__
 
 /*
@@ -1916,6 +1942,8 @@
 	return TASK_NICE(p);
 }
 
+EXPORT_SYMBOL(task_nice);
+
 /**
  * task_curr - is this task currently executing on a CPU?
  * @p: the task in question.
@@ -1934,6 +1962,8 @@
 	return cpu_curr(cpu) == cpu_rq(cpu)->idle;
 }
 
+EXPORT_SYMBOL(idle_cpu);
+
 /**
  * find_process_by_pid - find a process with a matching PID value.
  * @pid: the pid in question.
@@ -2261,6 +2291,8 @@
 	schedule();
 }
 
+EXPORT_SYMBOL(__cond_resched);
+
 /**
  * yield - yield the current processor to other threads.
  *
@@ -2273,6 +2305,8 @@
 	sys_sched_yield();
 }
 
+EXPORT_SYMBOL(yield);
+
 /*
  * This task is about to go to sleep on IO.  Increment rq->nr_iowait so
  * that process accounting knows that this is a task in IO wait state.
@@ -2289,6 +2323,8 @@
 	atomic_dec(&rq->nr_iowait);
 }
 
+EXPORT_SYMBOL(io_schedule);
+
 long io_schedule_timeout(long timeout)
 {
 	struct runqueue *rq = this_rq();
@@ -2574,7 +2610,8 @@
 	wait_for_completion(&req.done);
 	return 0;
 }
-EXPORT_SYMBOL(set_cpus_allowed);
+
+EXPORT_SYMBOL_GPL(set_cpus_allowed);
 
 /* Move (not current) task off this cpu, onto dest cpu. */
 static void move_task_away(struct task_struct *p, int dest_cpu)
@@ -2821,6 +2858,7 @@
 	}
 #endif
 }
+EXPORT_SYMBOL(__might_sleep);
 #endif
 
 
@@ -2849,6 +2887,8 @@
 	} while (!_raw_spin_trylock(lock));
 }
 
+EXPORT_SYMBOL(__preempt_spin_lock);
+
 void __preempt_write_lock(rwlock_t *lock)
 {
 	if (preempt_count() > 1) {
@@ -2863,33 +2903,6 @@
 		preempt_disable();
 	} while (!_raw_write_trylock(lock));
 }
-#endif
-
-EXPORT_SYMBOL(__cond_resched);
-EXPORT_SYMBOL(__wake_up);
-EXPORT_SYMBOL(__wake_up_sync);
-EXPORT_SYMBOL(complete);
-EXPORT_SYMBOL(default_wake_function);
-EXPORT_SYMBOL(idle_cpu);
-EXPORT_SYMBOL(interruptible_sleep_on);
-EXPORT_SYMBOL(interruptible_sleep_on_timeout);
-EXPORT_SYMBOL(io_schedule);
-EXPORT_SYMBOL(schedule);
-EXPORT_SYMBOL(set_user_nice);
-EXPORT_SYMBOL(sleep_on);
-EXPORT_SYMBOL(sleep_on_timeout);
-EXPORT_SYMBOL(task_nice);
-EXPORT_SYMBOL(wait_for_completion);
-EXPORT_SYMBOL(wake_up_process);
-EXPORT_SYMBOL(yield);
 
-#ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
-EXPORT_SYMBOL(__might_sleep);
-#endif
-#ifdef CONFIG_PREEMPT
-#ifdef CONFIG_SMP
-EXPORT_SYMBOL(__preempt_spin_lock);
 EXPORT_SYMBOL(__preempt_write_lock);
-#endif
-EXPORT_SYMBOL(preempt_schedule);
-#endif
+#endif /* defined(CONFIG_SMP) && defined(CONFIG_PREEMPT) */
diff -Nru a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	Wed Oct  1 17:32:38 2003
+++ b/mm/filemap.c	Wed Oct  1 17:32:38 2003
@@ -151,6 +151,8 @@
 	return __filemap_fdatawrite(mapping, WB_SYNC_ALL);
 }
 
+EXPORT_SYMBOL(filemap_fdatawrite);
+
 /*
  * This is a mostly non-blocking flush.  Not suitable for data-integrity
  * purposes.
@@ -216,6 +218,8 @@
 	return ret;
 }
 
+EXPORT_SYMBOL(filemap_fdatawait);
+
 /*
  * This adds a page to the page cache, starting out as locked, unreferenced,
  * not uptodate and with no errors.
@@ -253,6 +257,7 @@
 	}
 	return error;
 }
+
 EXPORT_SYMBOL(add_to_page_cache);
 
 int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
@@ -295,6 +300,7 @@
 	} while (test_bit(bit_nr, &page->flags));
 	finish_wait(waitqueue, &wait);
 }
+
 EXPORT_SYMBOL(wait_on_page_bit);
 
 /**
@@ -323,6 +329,8 @@
 		wake_up_all(waitqueue);
 }
 
+EXPORT_SYMBOL(unlock_page);
+
 /*
  * End writeback against a page.
  */
@@ -339,6 +347,7 @@
 	if (waitqueue_active(waitqueue))
 		wake_up_all(waitqueue);
 }
+
 EXPORT_SYMBOL(end_page_writeback);
 
 /*
@@ -363,6 +372,7 @@
 	}
 	finish_wait(wqh, &wait);
 }
+
 EXPORT_SYMBOL(__lock_page);
 
 /*
@@ -385,6 +395,8 @@
 	return page;
 }
 
+EXPORT_SYMBOL(find_get_page);
+
 /*
  * Same as above, but trylock it instead of incrementing the count.
  */
@@ -400,6 +412,8 @@
 	return page;
 }
 
+EXPORT_SYMBOL(find_trylock_page);
+
 /**
  * find_lock_page - locate, pin and lock a pagecache page
  *
@@ -438,6 +452,8 @@
 	return page;
 }
 
+EXPORT_SYMBOL(find_lock_page);
+
 /**
  * find_or_create_page - locate or add a pagecache page
  *
@@ -482,6 +498,8 @@
 	return page;
 }
 
+EXPORT_SYMBOL(find_or_create_page);
+
 /**
  * find_get_pages - gang pagecache lookup
  * @mapping:	The address_space to search
@@ -543,6 +561,8 @@
 	return page;
 }
 
+EXPORT_SYMBOL(grab_cache_page_nowait);
+
 /*
  * This is a generic file read routine, and uses the
  * inode->i_op->readpage() function for the actual low-level
@@ -699,6 +719,8 @@
 	update_atime(inode);
 }
 
+EXPORT_SYMBOL(do_generic_mapping_read);
+
 int file_read_actor(read_descriptor_t *desc, struct page *page,
 			unsigned long offset, unsigned long size)
 {
@@ -816,6 +838,8 @@
 	return retval;
 }
 
+EXPORT_SYMBOL(__generic_file_aio_read);
+
 ssize_t
 generic_file_aio_read(struct kiocb *iocb, char __user *buf, size_t count, loff_t pos)
 {
@@ -824,8 +848,8 @@
 	BUG_ON(iocb->ki_pos != pos);
 	return __generic_file_aio_read(iocb, &local_iov, 1, &iocb->ki_pos);
 }
+
 EXPORT_SYMBOL(generic_file_aio_read);
-EXPORT_SYMBOL(__generic_file_aio_read);
 
 ssize_t
 generic_file_read(struct file *filp, char __user *buf, size_t count, loff_t *ppos)
@@ -841,6 +865,8 @@
 	return ret;
 }
 
+EXPORT_SYMBOL(generic_file_read);
+
 int file_send_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size)
 {
 	ssize_t written;
@@ -880,6 +906,8 @@
 	return desc.error;
 }
 
+EXPORT_SYMBOL(generic_file_sendfile);
+
 static ssize_t
 do_readahead(struct address_space *mapping, struct file *filp,
 	     unsigned long index, unsigned long nr)
@@ -1126,6 +1154,8 @@
 	return NULL;
 }
 
+EXPORT_SYMBOL(filemap_nopage);
+
 static struct page * filemap_getpage(struct file *file, unsigned long pgoff,
 					int nonblock)
 {
@@ -1330,6 +1360,9 @@
 }
 #endif /* CONFIG_MMU */
 
+EXPORT_SYMBOL(generic_file_mmap);
+EXPORT_SYMBOL(generic_file_readonly_mmap);
+
 static inline struct page *__read_cache_page(struct address_space *mapping,
 				unsigned long index,
 				int (*filler)(void *,struct page*),
@@ -1406,6 +1439,8 @@
 	return page;
 }
 
+EXPORT_SYMBOL(read_cache_page);
+
 /*
  * If the page was newly created, increment its refcount and add it to the
  * caller's lru-buffering pagevec.  This function is specifically for
@@ -1456,6 +1491,8 @@
 	}
 }
 
+EXPORT_SYMBOL(remove_suid);
+
 /*
  * Copy as much as we can into the page and return the number of bytes which
  * were sucessfully copied.  If a fault is encountered then clear the page
@@ -1638,6 +1675,7 @@
 	}
 	return 0;
 }
+
 EXPORT_SYMBOL(generic_write_checks);
 
 /*
@@ -1832,6 +1870,8 @@
 	return err;
 }
 
+EXPORT_SYMBOL(generic_file_aio_write_nolock);
+
 ssize_t
 generic_file_write_nolock(struct file *file, const struct iovec *iov,
 				unsigned long nr_segs, loff_t *ppos)
@@ -1846,6 +1886,8 @@
 	return ret;
 }
 
+EXPORT_SYMBOL(generic_file_write_nolock);
+
 ssize_t generic_file_aio_write(struct kiocb *iocb, const char __user *buf,
 			       size_t count, loff_t pos)
 {
@@ -1863,8 +1905,8 @@
 
 	return err;
 }
+
 EXPORT_SYMBOL(generic_file_aio_write);
-EXPORT_SYMBOL(generic_file_aio_write_nolock);
 
 ssize_t generic_file_write(struct file *file, const char __user *buf,
 			   size_t count, loff_t *ppos)
@@ -1880,6 +1922,8 @@
 	return err;
 }
 
+EXPORT_SYMBOL(generic_file_write);
+
 ssize_t generic_file_readv(struct file *filp, const struct iovec *iov,
 			unsigned long nr_segs, loff_t *ppos)
 {
@@ -1893,6 +1937,8 @@
 	return ret;
 }
 
+EXPORT_SYMBOL(generic_file_readv);
+
 ssize_t generic_file_writev(struct file *file, const struct iovec *iov,
 			unsigned long nr_segs, loff_t * ppos) 
 {
@@ -1905,6 +1951,8 @@
 	return ret;
 }
 
+EXPORT_SYMBOL(generic_file_writev);
+
 ssize_t
 generic_file_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
 	loff_t offset, unsigned long nr_segs)
@@ -1927,3 +1975,5 @@
 out:
 	return retval;
 }
+
+EXPORT_SYMBOL_GPL(generic_file_direct_IO);

