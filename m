Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751950AbWFUDNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbWFUDNE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 23:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751951AbWFUDNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 23:13:04 -0400
Received: from xenotime.net ([66.160.160.81]:8660 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751950AbWFUDNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 23:13:01 -0400
Date: Tue, 20 Jun 2006 20:15:48 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: [PATCH] kthread: move kernel-doc and put it into DocBook
Message-Id: <20060620201548.65d7df3c.rdunlap@xenotime.net>
In-Reply-To: <20060620014027.eba58cb7.akpm@osdl.org>
References: <20060615144331.GB16046@sergelap.austin.ibm.com>
	<20060619201450.3434f72f.akpm@osdl.org>
	<20060620082745.GA28092@sergelap>
	<20060620014027.eba58cb7.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

> The documentation for kthread_bind() is irritatingly hidden in the header
> file.

Move kthread API kernel-doc from kthread.h to kthread.c & fix it.
Add kthread API to kernel-api DocBook.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/DocBook/kernel-api.tmpl |    2 +
 include/linux/kthread.h               |   65 +---------------------------------
 kernel/kthread.c                      |   61 +++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 63 deletions(-)

--- linux-2617-pv.orig/include/linux/kthread.h
+++ linux-2617-pv/include/linux/kthread.h
@@ -4,37 +4,19 @@
 #include <linux/err.h>
 #include <linux/sched.h>
 
-/**
- * kthread_create: create a kthread.
- * @threadfn: the function to run until signal_pending(current).
- * @data: data ptr for @threadfn.
- * @namefmt: printf-style name for the thread.
- *
- * Description: This helper function creates and names a kernel
- * thread.  The thread will be stopped: use wake_up_process() to start
- * it.  See also kthread_run(), kthread_create_on_cpu().
- *
- * When woken, the thread will run @threadfn() with @data as its
- * argument. @threadfn can either call do_exit() directly if it is a
- * standalone thread for which noone will call kthread_stop(), or
- * return when 'kthread_should_stop()' is true (which means
- * kthread_stop() has been called).  The return value should be zero
- * or a negative error number: it will be passed to kthread_stop().
- *
- * Returns a task_struct or ERR_PTR(-ENOMEM).
- */
 struct task_struct *kthread_create(int (*threadfn)(void *data),
 				   void *data,
 				   const char namefmt[], ...);
 
 /**
- * kthread_run: create and wake a thread.
+ * kthread_run - create and wake a thread.
  * @threadfn: the function to run until signal_pending(current).
  * @data: data ptr for @threadfn.
  * @namefmt: printf-style name for the thread.
  *
  * Description: Convenient wrapper for kthread_create() followed by
- * wake_up_process().  Returns the kthread, or ERR_PTR(-ENOMEM). */
+ * wake_up_process().  Returns the kthread or ERR_PTR(-ENOMEM).
+ */
 #define kthread_run(threadfn, data, namefmt, ...)			   \
 ({									   \
 	struct task_struct *__k						   \
@@ -44,50 +26,9 @@ struct task_struct *kthread_create(int (
 	__k;								   \
 })
 
-/**
- * kthread_bind: bind a just-created kthread to a cpu.
- * @k: thread created by kthread_create().
- * @cpu: cpu (might not be online, must be possible) for @k to run on.
- *
- * Description: This function is equivalent to set_cpus_allowed(),
- * except that @cpu doesn't need to be online, and the thread must be
- * stopped (ie. just returned from kthread_create().
- */
 void kthread_bind(struct task_struct *k, unsigned int cpu);
-
-/**
- * kthread_stop: stop a thread created by kthread_create().
- * @k: thread created by kthread_create().
- *
- * Sets kthread_should_stop() for @k to return true, wakes it, and
- * waits for it to exit.  Your threadfn() must not call do_exit()
- * itself if you use this function!  This can also be called after
- * kthread_create() instead of calling wake_up_process(): the thread
- * will exit without calling threadfn().
- *
- * Returns the result of threadfn(), or -EINTR if wake_up_process()
- * was never called. */
 int kthread_stop(struct task_struct *k);
-
-/**
- * kthread_stop_sem: stop a thread created by kthread_create().
- * @k: thread created by kthread_create().
- * @s: semaphore that @k waits on while idle.
- *
- * Does essentially the same thing as kthread_stop() above, but wakes
- * @k by calling up(@s).
- *
- * Returns the result of threadfn(), or -EINTR if wake_up_process()
- * was never called. */
 int kthread_stop_sem(struct task_struct *k, struct semaphore *s);
-
-/**
- * kthread_should_stop: should this kthread return now?
- *
- * When someone calls kthread_stop on your kthread, it will be woken
- * and this will return true.  You should then return, and your return
- * value will be passed through to kthread_stop().
- */
 int kthread_should_stop(void);
 
 #endif /* _LINUX_KTHREAD_H */
--- linux-2617-pv.orig/kernel/kthread.c
+++ linux-2617-pv/kernel/kthread.c
@@ -45,6 +45,13 @@ struct kthread_stop_info
 static DEFINE_MUTEX(kthread_stop_lock);
 static struct kthread_stop_info kthread_stop_info;
 
+/**
+ * kthread_should_stop - should this kthread return now?
+ *
+ * When someone calls kthread_stop on your kthread, it will be woken
+ * and this will return true.  You should then return, and your return
+ * value will be passed through to kthread_stop().
+ */
 int kthread_should_stop(void)
 {
 	return (kthread_stop_info.k == current);
@@ -122,6 +129,25 @@ static void keventd_create_kthread(void 
 	complete(&create->done);
 }
 
+/**
+ * kthread_create - create a kthread.
+ * @threadfn: the function to run until signal_pending(current).
+ * @data: data ptr for @threadfn.
+ * @namefmt: printf-style name for the thread.
+ *
+ * Description: This helper function creates and names a kernel
+ * thread.  The thread will be stopped: use wake_up_process() to start
+ * it.  See also kthread_run(), kthread_create_on_cpu().
+ *
+ * When woken, the thread will run @threadfn() with @data as its
+ * argument. @threadfn can either call do_exit() directly if it is a
+ * standalone thread for which noone will call kthread_stop(), or
+ * return when 'kthread_should_stop()' is true (which means
+ * kthread_stop() has been called).  The return value should be zero
+ * or a negative error number; it will be passed to kthread_stop().
+ *
+ * Returns a task_struct or ERR_PTR(-ENOMEM).
+ */
 struct task_struct *kthread_create(int (*threadfn)(void *data),
 				   void *data,
 				   const char namefmt[],
@@ -156,6 +182,15 @@ struct task_struct *kthread_create(int (
 }
 EXPORT_SYMBOL(kthread_create);
 
+/**
+ * kthread_bind - bind a just-created kthread to a cpu.
+ * @k: thread created by kthread_create().
+ * @cpu: cpu (might not be online, must be possible) for @k to run on.
+ *
+ * Description: This function is equivalent to set_cpus_allowed(),
+ * except that @cpu doesn't need to be online, and the thread must be
+ * stopped (i.e., just returned from kthread_create().
+ */
 void kthread_bind(struct task_struct *k, unsigned int cpu)
 {
 	BUG_ON(k->state != TASK_INTERRUPTIBLE);
@@ -166,12 +201,36 @@ void kthread_bind(struct task_struct *k,
 }
 EXPORT_SYMBOL(kthread_bind);
 
+/**
+ * kthread_stop - stop a thread created by kthread_create().
+ * @k: thread created by kthread_create().
+ *
+ * Sets kthread_should_stop() for @k to return true, wakes it, and
+ * waits for it to exit.  Your threadfn() must not call do_exit()
+ * itself if you use this function!  This can also be called after
+ * kthread_create() instead of calling wake_up_process(): the thread
+ * will exit without calling threadfn().
+ *
+ * Returns the result of threadfn(), or %-EINTR if wake_up_process()
+ * was never called.
+ */
 int kthread_stop(struct task_struct *k)
 {
 	return kthread_stop_sem(k, NULL);
 }
 EXPORT_SYMBOL(kthread_stop);
 
+/**
+ * kthread_stop_sem - stop a thread created by kthread_create().
+ * @k: thread created by kthread_create().
+ * @s: semaphore that @k waits on while idle.
+ *
+ * Does essentially the same thing as kthread_stop() above, but wakes
+ * @k by calling up(@s).
+ *
+ * Returns the result of threadfn(), or %-EINTR if wake_up_process()
+ * was never called.
+ */
 int kthread_stop_sem(struct task_struct *k, struct semaphore *s)
 {
 	int ret;
@@ -210,5 +269,5 @@ static __init int helper_init(void)
 
 	return 0;
 }
-core_initcall(helper_init);
 
+core_initcall(helper_init);
--- linux-2617-pv.orig/Documentation/DocBook/kernel-api.tmpl
+++ linux-2617-pv/Documentation/DocBook/kernel-api.tmpl
@@ -62,6 +62,8 @@
      <sect1><title>Internal Functions</title>
 !Ikernel/exit.c
 !Ikernel/signal.c
+!Iinclude/linux/kthread.h
+!Ekernel/kthread.c
      </sect1>
 
      <sect1><title>Kernel objects manipulation</title>

---
