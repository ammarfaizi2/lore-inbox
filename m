Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSDUVs1>; Sun, 21 Apr 2002 17:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313887AbSDUVs0>; Sun, 21 Apr 2002 17:48:26 -0400
Received: from [195.39.17.254] ([195.39.17.254]:13454 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S313867AbSDUVsP>;
	Sun, 21 Apr 2002 17:48:15 -0400
Date: Sun, 21 Apr 2002 23:37:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp for 2.5.8: infrastructure
Message-ID: <20020421213709.GA25056@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Swsusp needs a way to freeze just about everything. That's easy for
ordinary tasks, but needs some support for kernel threads. Please
apply,

[You'll need to > include/asm-i386/suspend.h to make it compile,
unless you also take the next patch].

									Pavel

--- clean.2.5/arch/i386/kernel/apm.c	Thu Mar 21 11:35:51 2002
+++ linux-swsusp/arch/i386/kernel/apm.c	Sun Apr 21 20:40:34 2002
@@ -1667,6 +1667,7 @@
 	daemonize();
 
 	strcpy(current->comm, "kapmd");
+	current->flags |= PF_IOTHREAD;
 	sigfillset(&current->blocked);
 
 	if (apm_info.connection_version == 0) {
--- clean.2.5/arch/i386/kernel/signal.c	Thu Apr 18 22:45:22 2002
+++ linux-swsusp/arch/i386/kernel/signal.c	Sun Apr 21 21:08:58 2002
@@ -21,6 +21,7 @@
 #include <linux/tty.h>
 #include <linux/personality.h>
 #include <linux/binfmts.h>
+#include <linux/suspend.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/i387.h>
@@ -594,6 +595,11 @@
 	if ((regs->xcs & 3) != 3)
 		return 1;
 
+	if (current->flags & PF_FREEZE) {
+		refrigerator(0);
+		goto no_signal;
+	}
+
 	if (!oldset)
 		oldset = &current->blocked;
 
@@ -701,6 +707,7 @@
 		return 1;
 	}
 
+ no_signal:
 	/* Did we come from a system call? */
 	if (regs->orig_eax >= 0) {
 		/* Restart the system call - no handlers present */
--- clean.2.5/drivers/block/loop.c	Thu Apr 18 22:45:31 2002
+++ linux-swsusp/drivers/block/loop.c	Sun Apr 21 20:40:54 2002
@@ -71,11 +71,11 @@
 #include <linux/smp_lock.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
+#include <linux/loop.h>
+#include <linux/suspend.h>
 
 #include <asm/uaccess.h>
 
-#include <linux/loop.h>		
-
 #define MAJOR_NR LOOP_MAJOR
 
 static int max_loop = 8;
@@ -550,7 +550,7 @@
 	atomic_inc(&lo->lo_pending);
 	spin_unlock_irq(&lo->lo_lock);
 
-	current->flags |= PF_NOIO;
+	current->flags |= PF_NOIO | PF_IOTHREAD;
 
 	/*
 	 * up sem, we are running
--- clean.2.5/drivers/usb/storage/usb.c	Tue Mar  5 21:52:43 2002
+++ linux-swsusp/drivers/usb/storage/usb.c	Sun Apr 21 21:08:47 2002
@@ -319,6 +319,7 @@
 	/* avoid getting signals */
 	spin_lock_irq(&current->sigmask_lock);
 	flush_signals(current);
+	current->flags |= PF_IOTHREAD;
 	sigfillset(&current->blocked);
 	recalc_sigpending();
 	spin_unlock_irq(&current->sigmask_lock);
--- clean.2.5/fs/jbd/journal.c	Thu Apr 18 22:46:03 2002
+++ linux-swsusp/fs/jbd/journal.c	Sun Apr 21 20:40:55 2002
@@ -33,6 +33,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 #include <asm/uaccess.h>
 #include <linux/proc_fs.h>
 
@@ -225,6 +226,7 @@
 			journal->j_commit_interval / HZ);
 	list_add(&journal->j_all_journals, &all_journals);
 
+	current->flags |= PF_KERNTHREAD;
 	/* And now, wait forever for commit wakeup events. */
 	while (1) {
 		if (journal->j_flags & JFS_UNMOUNT)
@@ -245,7 +247,15 @@
 		}
 
 		wake_up(&journal->j_wait_done_commit);
-		interruptible_sleep_on(&journal->j_wait_commit);
+		if (current->flags & PF_FREEZE) { /* The simpler the better. Flushing journal isn't a
+						     good idea, because that depends on threads that
+						     may be already stopped. */
+			jbd_debug(1, "Now suspending kjournald\n");
+			refrigerator(PF_IOTHREAD);
+			jbd_debug(1, "Resuming kjournald\n");						
+		} else		/* we assume on resume that commits are already there,
+				   so we don't sleep */
+			interruptible_sleep_on(&journal->j_wait_commit);
 
 		jbd_debug(1, "kjournald wakes\n");
 
--- clean.2.5/fs/reiserfs/journal.c	Thu Apr 18 22:46:12 2002
+++ linux-swsusp/fs/reiserfs/journal.c	Sun Apr 21 20:40:55 2002
@@ -58,6 +58,7 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
+#include <linux/suspend.h> 
 
 /* the number of mounted filesystems.  This is used to decide when to
 ** start and kill the commit thread
@@ -1887,6 +1888,7 @@
   spin_unlock_irq(&current->sigmask_lock);
 
   sprintf(current->comm, "kreiserfsd") ;
+  current->flags |= PF_KERNTHREAD;
   lock_kernel() ;
   while(1) {
 
@@ -1900,7 +1902,12 @@
       break ;
     }
     wake_up(&reiserfs_commit_thread_done) ;
-    interruptible_sleep_on_timeout(&reiserfs_commit_thread_wait, 5 * HZ) ;
+#ifdef CONFIG_SOFTWARE_SUSPEND
+    if (current->flags & PF_FREEZE) {
+	    refrigerator(PF_IOTHREAD);
+    } else
+#endif
+	    interruptible_sleep_on_timeout(&reiserfs_commit_thread_wait, 5 * HZ) ;
   }
   unlock_kernel() ;
   wake_up(&reiserfs_commit_thread_done) ;
--- clean.2.5/include/asm-i386/bitops.h	Thu Apr 18 22:46:15 2002
+++ linux-swsusp/include/asm-i386/bitops.h	Sun Apr 21 21:15:07 2002
@@ -414,6 +414,12 @@
 	return word;
 }
 
+/*
+ * fls: find last bit set.
+ */
+
+#define fls(x) generic_fls(x)
+
 #ifdef __KERNEL__
 
 /*
--- clean.2.5/include/linux/sched.h	Thu Apr 18 22:46:17 2002
+++ linux-swsusp/include/linux/sched.h	Sun Apr 21 21:15:07 2002
@@ -369,6 +369,10 @@
 #define PF_FREE_PAGES	0x00002000	/* per process page freeing */
 #define PF_NOIO		0x00004000	/* avoid generating further I/O */
 #define PF_FLUSHER	0x00008000	/* responsible for disk writeback */
+#define PF_FREEZE	0x00010000	/* this task should be frozen for suspend */
+#define PF_IOTHREAD	0x00020000	/* this thread is needed for doing I/O to swap */
+#define PF_KERNTHREAD	0x00040000	/* this thread is a kernel thread that cannot be sent signals to */
+#define PF_FROZEN	0x00080000	/* frozen for system suspend */
 
 /*
  * Ptrace flags
--- clean.2.5/include/linux/suspend.h	Tue Feb  5 23:17:31 2002
+++ linux-swsusp/include/linux/suspend.h	Sun Apr 21 21:16:16 2002
@@ -0,0 +1,65 @@
+#ifndef _LINUX_SWSUSP_H
+#define _LINUX_SWSUSP_H
+
+#include <asm/suspend.h>
+#include <linux/swap.h>
+#include <linux/notifier.h>
+#include <linux/config.h>
+
+extern unsigned char software_suspend_enabled;
+
+#define NORESUME	 1
+#define RESUME_SPECIFIED 2
+
+#ifdef CONFIG_SOFTWARE_SUSPEND
+/* page backup entry */
+typedef struct pbe {
+	unsigned long address;		/* address of the copy */
+	unsigned long orig_address;	/* original address of page */
+	swp_entry_t swap_address;	
+	swp_entry_t dummy;		/* we need scratch space at 
+					 * end of page (see link, diskpage)
+					 */
+} suspend_pagedir_t;
+
+#define SWAP_FILENAME_MAXLENGTH	32
+
+struct suspend_header {
+	__u32 version_code;
+	unsigned long num_physpages;
+	char machine[8];
+	char version[20];
+	int num_cpus;
+	int page_size;
+	unsigned long suspend_pagedir;
+	unsigned int num_pbes;
+	struct swap_location {
+		char filename[SWAP_FILENAME_MAXLENGTH];
+	} swap_location[MAX_SWAPFILES];
+};
+
+#define SUSPEND_PD_PAGES(x)     (((x)*sizeof(struct pbe))/PAGE_SIZE+1)
+   
+extern struct tq_struct suspend_tq;
+
+/* mm/vmscan.c */
+extern int shrink_mem(void);
+
+/* kernel/suspend.c */
+extern void software_suspend(void);
+extern void software_resume(void);
+extern int resume_setup(char *str);
+
+extern int register_suspend_notifier(struct notifier_block *);
+extern int unregister_suspend_notifier(struct notifier_block *);
+extern void refrigerator(unsigned long);
+
+#else
+#define software_suspend()		do { } while(0)
+#define software_resume()		do { } while(0)
+#define register_suspend_notifier(a)	do { } while(0)
+#define unregister_suspend_notifier(a)	do { } while(0)
+#define refrigerator(a)			do { BUG(); } while(0)
+#endif
+
+#endif /* _LINUX_SWSUSP_H */
--- clean.2.5/kernel/context.c	Tue Mar  5 21:52:50 2002
+++ linux-swsusp/kernel/context.c	Sun Apr 21 20:40:55 2002
@@ -72,6 +72,7 @@
 
 	daemonize();
 	strcpy(curtask->comm, "keventd");
+	current->flags |= PF_IOTHREAD;
 	keventd_running = 1;
 	keventd_task = curtask;
 
--- clean.2.5/kernel/softirq.c	Thu Jan 31 23:42:30 2002
+++ linux-swsusp/kernel/softirq.c	Sun Apr 21 20:49:10 2002
@@ -365,6 +365,7 @@
 
 	daemonize();
 	set_user_nice(current, 19);
+	current->flags |= PF_IOTHREAD;
 	sigfillset(&current->blocked);
 
 	/* Migrate to the right CPU */
--- clean.2.5/mm/pdflush.c	Thu Apr 18 22:46:20 2002
+++ linux-swsusp/mm/pdflush.c	Sun Apr 21 23:16:46 2002
@@ -96,7 +96,7 @@
 	recalc_sigpending();
 	spin_unlock_irq(&current->sigmask_lock);
 
-	current->flags |= PF_FLUSHER;
+	current->flags |= PF_FLUSHER | PF_KERNTHREAD;
 	my_work->fn = NULL;
 	my_work->who = current;
 
@@ -111,10 +111,13 @@
 		set_current_state(TASK_INTERRUPTIBLE);
 		spin_unlock_irq(&pdflush_lock);
 
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_IOTHREAD);
 		schedule();
 
 		preempt_enable();
-		(*my_work->fn)(my_work->arg0);
+		if (my_work && my_work->fn)
+			(*my_work->fn)(my_work->arg0);
 		preempt_disable();
 
 		/*
--- clean.2.5/mm/vmscan.c	Thu Apr 18 22:46:20 2002
+++ linux-swsusp/mm/vmscan.c	Sun Apr 21 20:40:55 2002
@@ -22,6 +22,7 @@
 #include <linux/highmem.h>
 #include <linux/file.h>
 #include <linux/compiler.h>
+#include <linux/suspend.h>
 
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
@@ -737,18 +738,22 @@
 	 * us from recursively trying to free more memory as we're
 	 * trying to free the first piece of memory in the first place).
 	 */
-	tsk->flags |= PF_MEMALLOC;
+	tsk->flags |= PF_MEMALLOC | PF_KERNTHREAD;
 
 	/*
 	 * Kswapd main loop.
 	 */
 	for (;;) {
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_IOTHREAD);
 		__set_current_state(TASK_INTERRUPTIBLE);
 		add_wait_queue(&kswapd_wait, &wait);
 
 		mb();
-		if (kswapd_can_sleep())
+		if (kswapd_can_sleep()) {
 			schedule();
+		}
+		
 
 		__set_current_state(TASK_RUNNING);
 		remove_wait_queue(&kswapd_wait, &wait);




-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
