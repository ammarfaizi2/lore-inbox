Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVKDRAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVKDRAi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 12:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbVKDRAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 12:00:38 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:11864 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1750728AbVKDRAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 12:00:38 -0500
Date: Fri, 4 Nov 2005 18:00:36 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: Dave Jones <davej@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] Don't include sched.h from module.h
In-Reply-To: <Pine.LNX.4.61.0511041746470.4856@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.61.0511041757190.4887@gans.physik3.uni-rostock.de>
References: <Pine.LNX.4.61.0511041746470.4856@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not include sched.h from module.h. Also move some stuff to wait.h
where it fits better (this part actually is from a patch by Dave Jones).
This reduces the number of files directly or indirectly including sched.h
from 5492 to 5057 on i386. Further reduction of this number is possible
and will be achieved with future patches.

Extensive ctags- and grep-based analysis was performed for all
architectures to locate files that rely on indirectly including
sched.h through module.h. Fixes for these where submitted previously.
Compile tested with allnoconfig, defconfig and allmodconfig on
i386, x86_64, alpha, ppc64, ia64, arm, mips and um (not that all
of these actually build, but make -k gives the same messages with
and without this patch). Still this patch bears some risk of compile
breakage, which should however be easily fixed when uncovered.

Analysis and compile tests where done against 2.6.14-git3.
A quick x86_64 only compile test seems to indicate the patch still
applies well to 2.6.14-git7.

Signed-off-by: Tim Schmielau <tim@physik3.uni-rostock.de>
---
diff -urpP linux-2.6.14-git3/include/linux/module.h linux-2.6.14-git3-sr/include/linux/module.h
--- linux-2.6.14-git3/include/linux/module.h	2005-10-31 12:32:56.000000000 +0100
+++ linux-2.6.14-git3-sr/include/linux/module.h	2005-10-31 12:34:33.000000000 +0100
@@ -7,7 +7,6 @@
  * Rewritten again by Rusty Russell, 2002
  */
 #include <linux/config.h>
-#include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/stat.h>
@@ -18,8 +17,11 @@
 #include <linux/stringify.h>
 #include <linux/kobject.h>
 #include <linux/moduleparam.h>
-#include <asm/local.h>
+#include <linux/wait.h>
+#include <linux/smp.h>
+#include <linux/threads.h>
 
+#include <asm/local.h>
 #include <asm/module.h>
 
 /* Not Yet Implemented */
diff -urpP linux-2.6.14-git3/include/linux/sched.h linux-2.6.14-git3-sr/include/linux/sched.h
--- linux-2.6.14-git3/include/linux/sched.h	2005-10-31 12:32:56.000000000 +0100
+++ linux-2.6.14-git3-sr/include/linux/sched.h	2005-10-31 12:34:33.000000000 +0100
@@ -1020,15 +1020,8 @@ extern void switch_uid(struct user_struc
 
 extern void do_timer(struct pt_regs *);
 
-extern int FASTCALL(wake_up_state(struct task_struct * tsk, unsigned int state));
-extern int FASTCALL(wake_up_process(struct task_struct * tsk));
-extern void FASTCALL(wake_up_new_task(struct task_struct * tsk,
-						unsigned long clone_flags));
-#ifdef CONFIG_SMP
- extern void kick_process(struct task_struct *tsk);
-#else
- static inline void kick_process(struct task_struct *tsk) { }
-#endif
+#include <linux/wait.h>
+
 extern void FASTCALL(sched_fork(task_t * p, int clone_flags));
 extern void FASTCALL(sched_exit(task_t * p));
 
diff -urpP linux-2.6.14-git3/include/linux/wait.h linux-2.6.14-git3-sr/include/linux/wait.h
--- linux-2.6.14-git3/include/linux/wait.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3-sr/include/linux/wait.h	2005-10-31 12:34:33.000000000 +0100
@@ -148,6 +148,16 @@ int FASTCALL(out_of_line_wait_on_bit(voi
 int FASTCALL(out_of_line_wait_on_bit_lock(void *, int, int (*)(void *), unsigned));
 wait_queue_head_t *FASTCALL(bit_waitqueue(void *, int));
 
+extern int FASTCALL(wake_up_state(struct task_struct * tsk, unsigned int state));
+extern int FASTCALL(wake_up_process(struct task_struct * tsk));
+extern void FASTCALL(wake_up_new_task(struct task_struct * tsk,
+				      unsigned long clone_flags));
+#ifdef CONFIG_SMP
+ extern void kick_process(struct task_struct *tsk);
+#else
+ static inline void kick_process(struct task_struct *tsk) { }
+#endif
+
 #define wake_up(x)			__wake_up(x, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1, NULL)
 #define wake_up_nr(x, nr)		__wake_up(x, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, nr, NULL)
 #define wake_up_all(x)			__wake_up(x, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 0, NULL)
