Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965255AbVKPM5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965255AbVKPM5J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 07:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965256AbVKPM5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 07:57:09 -0500
Received: from verein.lst.de ([213.95.11.210]:16820 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S965255AbVKPM5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 07:57:06 -0500
Date: Wed, 16 Nov 2005 13:57:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] common compat_sys_trimer_create
Message-ID: <20051116125700.GA28682@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the comment in compat.c is wrong, every architecture provides a
get_compat_sigevent() for the IPC compat code already.

This basically moves the x86_64 version to common code and removes
all the others.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/kernel/compat.c
===================================================================
--- linux-2.6.orig/kernel/compat.c	2005-11-13 13:33:49.000000000 +0100
+++ linux-2.6/kernel/compat.c	2005-11-13 14:28:33.000000000 +0100
@@ -514,6 +514,24 @@
 	return 0;
 } 
 
+long compat_sys_timer_create(clockid_t which_clock,
+			struct compat_sigevent __user *timer_event_spec,
+			timer_t __user *created_timer_id)
+{
+	struct sigevent __user *event = NULL;
+
+	if (timer_event_spec) {
+		struct sigevent kevent;
+
+		event = compat_alloc_user_space(sizeof(*event));
+		if (get_compat_sigevent(&kevent, timer_event_spec) ||
+		    copy_to_user(event, &kevent, sizeof(*event)))
+			return -EFAULT;
+	}
+
+	return sys_timer_create(which_clock, event, created_timer_id);
+}
+
 long compat_sys_timer_settime(timer_t timer_id, int flags,
 			  struct compat_itimerspec __user *new, 
 			  struct compat_itimerspec __user *old)
@@ -649,8 +667,6 @@
 		? -EFAULT : 0;
 }
 
-/* timer_create is architecture specific because it needs sigevent conversion */
-
 long compat_get_bitmap(unsigned long *mask, compat_ulong_t __user *umask,
 		       unsigned long bitmap_size)
 {
Index: linux-2.6/arch/ia64/ia32/ia32_entry.S
===================================================================
--- linux-2.6.orig/arch/ia64/ia32/ia32_entry.S	2005-09-18 13:46:48.000000000 +0200
+++ linux-2.6/arch/ia64/ia32/ia32_entry.S	2005-11-13 14:26:23.000000000 +0100
@@ -469,7 +469,7 @@
 	data8 sys32_epoll_wait
 	data8 sys_remap_file_pages
 	data8 sys_set_tid_address
- 	data8 sys32_timer_create
+ 	data8 compat_sys_timer_create
  	data8 compat_sys_timer_settime	/* 260 */
  	data8 compat_sys_timer_gettime
  	data8 sys_timer_getoverrun
Index: linux-2.6/arch/ia64/ia32/sys_ia32.c
===================================================================
--- linux-2.6.orig/arch/ia64/ia32/sys_ia32.c	2005-11-08 23:07:47.000000000 +0100
+++ linux-2.6/arch/ia64/ia32/sys_ia32.c	2005-11-13 13:43:19.000000000 +0100
@@ -2559,34 +2559,6 @@
 	return 0;
 }
 
-asmlinkage long
-sys32_timer_create(u32 clock, struct compat_sigevent __user *se32, timer_t __user *timer_id)
-{
-	struct sigevent se;
-	mm_segment_t oldfs;
-	timer_t t;
-	long err;
-
-	if (se32 == NULL)
-		return sys_timer_create(clock, NULL, timer_id);
-
-	if (get_compat_sigevent(&se, se32))
-		return -EFAULT;
-
-	if (!access_ok(VERIFY_WRITE,timer_id,sizeof(timer_t)))
-		return -EFAULT;
-
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = sys_timer_create(clock, (struct sigevent __user *) &se, (timer_t __user *) &t);
-	set_fs(oldfs);
-
-	if (!err)
-		err = __put_user (t, timer_id);
-
-	return err;
-}
-
 long sys32_fadvise64_64(int fd, __u32 offset_low, __u32 offset_high, 
 			__u32 len_low, __u32 len_high, int advice)
 { 
Index: linux-2.6/arch/powerpc/kernel/sys_ppc32.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/sys_ppc32.c	2005-11-10 22:17:37.000000000 +0100
+++ linux-2.6/arch/powerpc/kernel/sys_ppc32.c	2005-11-13 13:46:49.000000000 +0100
@@ -956,38 +956,6 @@
 			     advice);
 }
 
-long ppc32_timer_create(clockid_t clock,
-			struct compat_sigevent __user *ev32,
-			timer_t __user *timer_id)
-{
-	sigevent_t event;
-	timer_t t;
-	long err;
-	mm_segment_t savefs;
-
-	if (ev32 == NULL)
-		return sys_timer_create(clock, NULL, timer_id);
-
-	if (get_compat_sigevent(&event, ev32))
-		return -EFAULT;
-
-	if (!access_ok(VERIFY_WRITE, timer_id, sizeof(timer_t)))
-		return -EFAULT;
-
-	savefs = get_fs();
-	set_fs(KERNEL_DS);
-	/* The __user pointer casts are valid due to the set_fs() */
-	err = sys_timer_create(clock,
-		(sigevent_t __user *) &event,
-		(timer_t __user *) &t);
-	set_fs(savefs);
-
-	if (err == 0)
-		err = __put_user(t, timer_id);
-
-	return err;
-}
-
 asmlinkage long compat_sys_add_key(const char __user *_type,
 			      const char __user *_description,
 			      const void __user *_payload,
Index: linux-2.6/arch/powerpc/kernel/systbl.S
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/systbl.S	2005-11-08 23:07:47.000000000 +0100
+++ linux-2.6/arch/powerpc/kernel/systbl.S	2005-11-13 13:47:10.000000000 +0100
@@ -281,7 +281,7 @@
 SYSCALL(epoll_ctl)
 SYSCALL(epoll_wait)
 SYSCALL(remap_file_pages)
-SYSX(sys_timer_create,ppc32_timer_create,sys_timer_create)
+SYSX(sys_timer_create,compat_sys_timer_create,sys_timer_create)
 COMPAT_SYS(timer_settime)
 COMPAT_SYS(timer_gettime)
 SYSCALL(timer_getoverrun)
Index: linux-2.6/arch/s390/kernel/compat_linux.c
===================================================================
--- linux-2.6.orig/arch/s390/kernel/compat_linux.c	2005-09-18 13:46:56.000000000 +0200
+++ linux-2.6/arch/s390/kernel/compat_linux.c	2005-11-13 14:26:23.000000000 +0100
@@ -1014,38 +1014,6 @@
 }
 
 /*
- * Wrapper function for sys_timer_create.
- */
-extern asmlinkage long
-sys_timer_create(clockid_t, struct sigevent *, timer_t *);
-
-asmlinkage long
-sys32_timer_create(clockid_t which_clock, struct compat_sigevent *se32,
-		timer_t *timer_id)
-{
-	struct sigevent se;
-	timer_t ktimer_id;
-	mm_segment_t old_fs;
-	long ret;
-
-	if (se32 == NULL)
-		return sys_timer_create(which_clock, NULL, timer_id);
-
-	if (get_compat_sigevent(&se, se32))
-		return -EFAULT;
-
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	ret = sys_timer_create(which_clock, &se, &ktimer_id);
-	set_fs(old_fs);
-
-	if (!ret)
-		ret = put_user (ktimer_id, timer_id);
-
-	return ret;
-}
-
-/*
  * 31 bit emulation wrapper functions for sys_fadvise64/fadvise64_64.
  * These need to rewrite the advise values for POSIX_FADV_{DONTNEED,NOREUSE}
  * because the 31 bit values differ from the 64 bit values.
Index: linux-2.6/arch/s390/kernel/compat_wrapper.S
===================================================================
--- linux-2.6.orig/arch/s390/kernel/compat_wrapper.S	2005-09-18 13:46:56.000000000 +0200
+++ linux-2.6/arch/s390/kernel/compat_wrapper.S	2005-11-13 14:26:23.000000000 +0100
@@ -1289,7 +1289,7 @@
 	lgfr	%r2,%r2			# timer_t (int)
 	llgtr	%r3,%r3			# struct compat_sigevent *
 	llgtr	%r4,%r4			# timer_t *
-	jg	sys32_timer_create
+	jg	compat_sys_timer_create
 
 	.globl	sys32_timer_settime_wrapper
 sys32_timer_settime_wrapper:
Index: linux-2.6/arch/sparc64/kernel/sys_sparc32.c
===================================================================
--- linux-2.6.orig/arch/sparc64/kernel/sys_sparc32.c	2005-09-18 13:46:58.000000000 +0200
+++ linux-2.6/arch/sparc64/kernel/sys_sparc32.c	2005-11-13 14:26:23.000000000 +0100
@@ -1120,39 +1120,3 @@
 	return sys_lookup_dcookie((cookie_high << 32) | cookie_low,
 				  buf, len);
 }
-
-extern asmlinkage long
-sys_timer_create(clockid_t which_clock,
-		 struct sigevent __user *timer_event_spec,
-		 timer_t __user *created_timer_id);
-
-long
-sys32_timer_create(u32 clock, struct compat_sigevent __user *se32,
-		   timer_t __user *timer_id)
-{
-	struct sigevent se;
-	mm_segment_t oldfs;
-	timer_t t;
-	long err;
-
-	if (se32 == NULL)
-		return sys_timer_create(clock, NULL, timer_id);
-
-	if (get_compat_sigevent(&se, se32))
-		return -EFAULT;
-
-	if (!access_ok(VERIFY_WRITE,timer_id,sizeof(timer_t)))
-		return -EFAULT;
-
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = sys_timer_create(clock,
-			       (struct sigevent __user *) &se,
-			       (timer_t __user *) &t);
-	set_fs(oldfs);
-
-	if (!err)
-		err = __put_user (t, timer_id);
-
-	return err;
-}
Index: linux-2.6/arch/sparc64/kernel/systbls.S
===================================================================
--- linux-2.6.orig/arch/sparc64/kernel/systbls.S	2005-09-18 13:46:58.000000000 +0200
+++ linux-2.6/arch/sparc64/kernel/systbls.S	2005-11-13 13:45:24.000000000 +0100
@@ -73,7 +73,7 @@
 /*250*/	.word sys32_mremap, sys32_sysctl, sys32_getsid, sys_fdatasync, sys32_nfsservctl
 	.word sys_ni_syscall, sys32_clock_settime, compat_sys_clock_gettime, compat_sys_clock_getres, sys32_clock_nanosleep
 /*260*/	.word compat_sys_sched_getaffinity, compat_sys_sched_setaffinity, sys32_timer_settime, compat_sys_timer_gettime, sys_timer_getoverrun
-	.word sys_timer_delete, sys32_timer_create, sys_ni_syscall, compat_sys_io_setup, sys_io_destroy
+	.word sys_timer_delete, compat_sys_timer_create, sys_ni_syscall, compat_sys_io_setup, sys_io_destroy
 /*270*/	.word sys32_io_submit, sys_io_cancel, compat_sys_io_getevents, sys32_mq_open, sys_mq_unlink
 	.word compat_sys_mq_timedsend, compat_sys_mq_timedreceive, compat_sys_mq_notify, compat_sys_mq_getsetattr, compat_sys_waitid
 /*280*/	.word sys_ni_syscall, sys_add_key, sys_request_key, sys_keyctl
Index: linux-2.6/arch/x86_64/ia32/ia32entry.S
===================================================================
--- linux-2.6.orig/arch/x86_64/ia32/ia32entry.S	2005-09-18 13:47:00.000000000 +0200
+++ linux-2.6/arch/x86_64/ia32/ia32entry.S	2005-11-13 14:26:23.000000000 +0100
@@ -608,7 +608,7 @@
 	.quad sys_epoll_wait
 	.quad sys_remap_file_pages
 	.quad sys_set_tid_address
-	.quad sys32_timer_create
+	.quad compat_sys_timer_create
 	.quad compat_sys_timer_settime	/* 260 */
 	.quad compat_sys_timer_gettime
 	.quad sys_timer_getoverrun
Index: linux-2.6/arch/x86_64/ia32/sys_ia32.c
===================================================================
--- linux-2.6.orig/arch/x86_64/ia32/sys_ia32.c	2005-09-18 13:47:00.000000000 +0200
+++ linux-2.6/arch/x86_64/ia32/sys_ia32.c	2005-11-13 14:26:23.000000000 +0100
@@ -969,25 +969,6 @@
 	return sys_kill(pid, sig);
 }
  
-extern asmlinkage long
-sys_timer_create(clockid_t which_clock,
-		 struct sigevent __user *timer_event_spec,
-		 timer_t __user * created_timer_id);
-
-long
-sys32_timer_create(u32 clock, struct compat_sigevent __user *se32, timer_t __user *timer_id)
-{
-	struct sigevent __user *p = NULL;
-	if (se32) { 
-		struct sigevent se;
-		p = compat_alloc_user_space(sizeof(struct sigevent));
-		if (get_compat_sigevent(&se, se32) ||
-		    copy_to_user(p, &se, sizeof(se)))
-			return -EFAULT;
-	} 
-	return sys_timer_create(clock, p, timer_id);
-} 
-
 long sys32_fadvise64_64(int fd, __u32 offset_low, __u32 offset_high, 
 			__u32 len_low, __u32 len_high, int advice)
 { 
