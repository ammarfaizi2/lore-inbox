Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbTCPAOk>; Sat, 15 Mar 2003 19:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261687AbTCPAOk>; Sat, 15 Mar 2003 19:14:40 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:19121 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261660AbTCPAOi>; Sat, 15 Mar 2003 19:14:38 -0500
Date: Sat, 15 Mar 2003 19:25:28 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux390@de.ibm.com
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: [s390x] Patch for execve with a mode switch
Message-ID: <20030315192528.A30182@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I boot an s390x kernel over a 31 bit userland, /sbin/init segfaults
in the dynamic linker. This happens because mm->free_area_cache
is set with TASK_UNMAPPED_BASE macro, which needs the TIF_31BIT
set right. Setting TIF_31BIT in ELF_PLAT_INIT is way too late
for this.

The patch below basically ports what sparc64 does to s390x,
according to the Andrew Morton's comment in fs/binfmt_elf.c.
To tell the truth, I actually use equivalent of this on 2.4,
but I think it's important to get stock 2.5 right.

Martin, please consider and let me know what you think.

Greetings,
-- Pete

--- linux-2.5.64/arch/s390x/kernel/binfmt_elf32.c	2003-03-04 21:34:14.000000000 -0800
+++ linux-2.5.64-sparc/arch/s390x/kernel/binfmt_elf32.c	2003-03-15 16:17:34.000000000 -0800
@@ -39,7 +39,6 @@
 #define ELF_PLAT_INIT(_r) \
 	do { \
 	_r->gprs[14] = 0; \
-	set_thread_flag(TIF_31BIT); \
 	} while(0)
 
 #define USE_ELF_CORE_DUMP
@@ -87,6 +86,8 @@
 
 #define SET_PERSONALITY(ex, ibcs2)			\
 do {							\
+	if ((current_thread_info()->flags & _TIF_32BIT) == 0) \
+		set_thread_flag(TIF_ABI_PENDING);	\
 	if (ibcs2)                                      \
 		set_personality(PER_SVR4);              \
 	else if (current->personality != PER_LINUX32)   \
--- linux-2.5.64/arch/s390x/kernel/process.c	2003-03-04 21:34:14.000000000 -0800
+++ linux-2.5.64-sparc/arch/s390x/kernel/process.c	2003-03-15 16:02:19.000000000 -0800
@@ -156,9 +156,14 @@
 
 void flush_thread(void)
 {
+	struct thread_info *t = current_thread_info();
+	struct task_struct *tsk = t->task;
 
-        current->used_math = 0;
-	clear_tsk_thread_flag(current, TIF_USEDFPU);
+	if (t->flags & _TIF_ABI_PENDING)
+		t->flags ^= (_TIF_ABI_PENDING | _TIF_32BIT);
+
+	tsk->used_math = 0;
+	clear_tsk_thread_flag(tsk, TIF_USEDFPU);
 }
 
 void release_thread(struct task_struct *dead_task)
--- linux-2.5.64/include/asm-s390x/elf.h	2003-03-04 21:34:43.000000000 -0800
+++ linux-2.5.64-sparc/include/asm-s390x/elf.h	2003-03-15 16:22:04.000000000 -0800
@@ -39,7 +39,6 @@
 #define ELF_PLAT_INIT(_r) \
 	do { \
 	_r->gprs[14] = 0; \
-	clear_thread_flag(TIF_31BIT); \
 	} while(0)
 
 #define USE_ELF_CORE_DUMP
@@ -79,11 +78,12 @@
 #ifdef __KERNEL__
 #define SET_PERSONALITY(ex, ibcs2)			\
 do {							\
+	if (current_thread_info()->flags & _TIF_32BIT)	\
+		set_thread_flag(TIF_ABI_PENDING);	\
 	if (ibcs2)					\
 		set_personality(PER_SVR4);		\
 	else if (current->personality != PER_LINUX32)	\
 		set_personality(PER_LINUX);		\
-	clear_thread_flag(TIF_31BIT);			\
 } while (0)
 #endif
 
--- linux-2.5.64/include/asm-s390x/thread_info.h	2003-03-04 21:34:43.000000000 -0800
+++ linux-2.5.64-sparc/include/asm-s390x/thread_info.h	2003-03-15 16:04:23.000000000 -0800
@@ -74,6 +74,7 @@
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_RESTART_SVC		4	/* restart svc with new svc number */
+#define TIF_ABI_PENDING		11	/* flush_thread has to switch ABI */
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling 
 					   TIF_NEED_RESCHED */
@@ -84,6 +85,7 @@
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_RESTART_SVC	(1<<TIF_RESTART_SVC)
+#define _TIF_ABI_PENDING	(1<<TIF_ABI_PENDING)
 #define _TIF_USEDFPU		(1<<TIF_USEDFPU)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_31BIT		(1<<TIF_31BIT)
