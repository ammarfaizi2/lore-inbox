Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262885AbVAFQDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262885AbVAFQDz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 11:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbVAFQDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 11:03:55 -0500
Received: from [220.248.27.114] ([220.248.27.114]:40935 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S262885AbVAFQDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 11:03:33 -0500
Date: Fri, 7 Jan 2005 00:03:06 +0800
From: hugang@soulinfo.com
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [hugang@soulinfo.com: [PATH]software suspend for ppc.]
Message-ID: <20050106160306.GA20127@hugang.soulinfo.com>
References: <20050103122653.GB8827@hugang.soulinfo.com> <20050103221718.GC25250@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103221718.GC25250@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 11:17:18PM +0100, Pavel Machek wrote:
> Hi!
> 
...
> 
> swsusp_arch_{suspend,resume} should really be written in
> assembly. Just compile this, disassemble it and put it into source
> file. Otherwise it looks OK.
> 								Pavel

After do more test, I have to drop my last patch, That's unstable.
Current I using this one from 
 http://honk.physik.uni-konstanz.de/~agx/linux-ppc/kernel/

Here is another patch try make software suspend work well. This idea
base on swsusp2.

adding a option to freeze/thaw_processes, first freeze all user
processess, from now only kernel processess running, Now we can shrink
more memory than current version, after that freeze all processes.
that's mean if your swap space enough, swsusp will not fail. 

--- 2.6.10-mm1/include/linux/sched.h	2005-01-03 18:53:51.000000000 +0800
+++ 2.6.10-mm1-swsusp//include/linux/sched.h	2005-01-03 22:33:37.000000000 +0800
@@ -1172,8 +1172,8 @@ extern void normalize_rt_tasks(void);
  */
 #ifdef CONFIG_PM
 extern void refrigerator(unsigned long);
-extern int freeze_processes(void);
-extern void thaw_processes(void);
+extern int freeze_processes(int);
+extern void thaw_processes(int);
 
 static inline int try_to_freeze(unsigned long refrigerator_flags)
 {
--- 2.6.10-mm1/kernel/power/disk.c	2004-12-30 14:49:03.000000000 +0800
+++ 2.6.10-mm1-swsusp//kernel/power/disk.c	2005-01-03 22:53:11.000000000 +0800
@@ -116,7 +116,7 @@ static void finish(void)
 	device_resume();
 	platform_finish();
 	enable_nonboot_cpus();
-	thaw_processes();
+	thaw_processes(1);
 	pm_restore_console();
 }
 
@@ -128,7 +128,7 @@ static int prepare(void)
 	pm_prepare_console();
 
 	sys_sync();
-	if (freeze_processes()) {
+	if (freeze_processes(0)) {
 		error = -EBUSY;
 		goto Thaw;
 	}
@@ -142,6 +142,8 @@ static int prepare(void)
 
 	/* Free memory before shutting down devices. */
 	free_some_memory();
+	
+	freeze_processes(1);
 
 	disable_nonboot_cpus();
 	if ((error = device_suspend(PM_SUSPEND_DISK)))
@@ -152,7 +154,7 @@ static int prepare(void)
 	platform_finish();
  Thaw:
 	enable_nonboot_cpus();
-	thaw_processes();
+	thaw_processes(1);
 	pm_restore_console();
 	return error;
 }
--- 2.6.10-mm1/kernel/power/main.c	2004-12-30 14:49:02.000000000 +0800
+++ 2.6.10-mm1-swsusp//kernel/power/main.c	2005-01-03 22:39:53.000000000 +0800
@@ -55,7 +55,7 @@ static int suspend_prepare(suspend_state
 
 	pm_prepare_console();
 
-	if (freeze_processes()) {
+	if (freeze_processes(1)) {
 		error = -EAGAIN;
 		goto Thaw;
 	}
@@ -72,7 +72,7 @@ static int suspend_prepare(suspend_state
 	if (pm_ops->finish)
 		pm_ops->finish(state);
  Thaw:
-	thaw_processes();
+	thaw_processes(1);
 	pm_restore_console();
 	return error;
 }
@@ -107,7 +107,7 @@ static void suspend_finish(suspend_state
 	device_resume();
 	if (pm_ops && pm_ops->finish)
 		pm_ops->finish(state);
-	thaw_processes();
+	thaw_processes(1);
 	pm_restore_console();
 }
 
--- 2.6.10-mm1/kernel/power/power.h	2004-12-30 14:49:02.000000000 +0800
+++ 2.6.10-mm1-swsusp//kernel/power/power.h	2005-01-03 22:39:24.000000000 +0800
@@ -45,8 +45,5 @@ static struct subsys_attribute _name##_a
 
 extern struct subsystem power_subsys;
 
-extern int freeze_processes(void);
-extern void thaw_processes(void);
-
 extern int pm_prepare_console(void);
 extern void pm_restore_console(void);
--- 2.6.10-mm1/kernel/power/process.c	2004-12-30 14:49:02.000000000 +0800
+++ 2.6.10-mm1-swsusp//kernel/power/process.c	2005-01-03 22:34:50.000000000 +0800
@@ -19,7 +19,7 @@
 #define TIMEOUT	(6 * HZ)
 
 
-static inline int freezeable(struct task_struct * p)
+static inline int freezeable(struct task_struct * p, int all)
 {
 	if ((p == current) || 
 	    (p->flags & PF_NOFREEZE) ||
@@ -28,6 +28,8 @@ static inline int freezeable(struct task
 	    (p->state == TASK_STOPPED) ||
 	    (p->state == TASK_TRACED))
 		return 0;
+	if (all == 0 && p->mm == NULL) 
+		return 0;
 	return 1;
 }
 
@@ -55,7 +57,7 @@ void refrigerator(unsigned long flag)
 }
 
 /* 0 = success, else # of processes that we failed to stop */
-int freeze_processes(void)
+int freeze_processes(int all)
 {
        int todo;
        unsigned long start_time;
@@ -68,7 +70,7 @@ int freeze_processes(void)
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
 			unsigned long flags;
-			if (!freezeable(p))
+			if (!freezeable(p, all))
 				continue;
 			if ((p->flags & PF_FROZEN) ||
 			    (p->state == TASK_TRACED) ||
@@ -97,14 +99,14 @@ int freeze_processes(void)
 	return 0;
 }
 
-void thaw_processes(void)
+void thaw_processes(int all)
 {
 	struct task_struct *g, *p;
 
 	printk( "Restarting tasks..." );
 	read_lock(&tasklist_lock);
 	do_each_thread(g, p) {
-		if (!freezeable(p))
+		if (!freezeable(p, all))
 			continue;
 		if (p->flags & PF_FROZEN) {
 			p->flags &= ~PF_FROZEN;

-- 
Hu Gang       .-.
              /v\
             // \\ 
Linux User  /(   )\  [204016]
GPG Key ID   ^^-^^   http://soulinfo.com/~hugang/hugang.asc
