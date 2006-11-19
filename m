Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756604AbWKSMIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756604AbWKSMIh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 07:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756606AbWKSMIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 07:08:37 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:14772 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1756604AbWKSMIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 07:08:36 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/4] swsusp: Untangle thaw_processes
Date: Sun, 19 Nov 2006 13:01:56 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
References: <200611182335.27453.rjw@sisk.pl> <200611182347.05656.rjw@sisk.pl> <20061119020445.GB15873@elf.ucw.cz>
In-Reply-To: <20061119020445.GB15873@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611191301.56978.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 19 November 2006 03:04, Pavel Machek wrote:
> Hi!
> 
> > Move the loop from thaw_processes() to a separate function and call it
> > independently for kernel threads and user space processes so that the order
> > of thawing tasks is clearly visible.
> > 
> > Drop thaw_kernel_threads() which is never used.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  include/linux/freezer.h |    6 -----
> >  kernel/power/process.c  |   55 +++++++++++++++++++++++++++---------------------
> >  2 files changed, 33 insertions(+), 28 deletions(-)
> > 
> > Index: linux-2.6.19-rc5-mm2/include/linux/freezer.h
> > ===================================================================
> > --- linux-2.6.19-rc5-mm2.orig/include/linux/freezer.h
> > +++ linux-2.6.19-rc5-mm2/include/linux/freezer.h
> > @@ -1,8 +1,5 @@
> >  /* Freezer declarations */
> >  
> > -#define FREEZER_KERNEL_THREADS 0
> > -#define FREEZER_ALL_THREADS 1
> > -
> >  #ifdef CONFIG_PM
> >  /*
> >   * Check if a process has been frozen
> > @@ -60,8 +57,7 @@ static inline void frozen_process(struct
> >  
> >  extern void refrigerator(void);
> >  extern int freeze_processes(void);
> > -#define thaw_processes() do { thaw_some_processes(FREEZER_ALL_THREADS); } while(0)
> > -#define thaw_kernel_threads() do { thaw_some_processes(FREEZER_KERNEL_THREADS); } while(0)
> > +extern void thaw_processes(void);
> >  
> >  static inline int try_to_freeze(void)
> >  {
> > Index: linux-2.6.19-rc5-mm2/kernel/power/process.c
> > ===================================================================
> > --- linux-2.6.19-rc5-mm2.orig/kernel/power/process.c
> > +++ linux-2.6.19-rc5-mm2/kernel/power/process.c
> > @@ -20,6 +20,8 @@
> >   */
> >  #define TIMEOUT	(20 * HZ)
> >  
> > +#define FREEZER_KERNEL_THREADS 0
> > +#define FREEZER_USER_SPACE 1
> 
> The variable is named "is_user_space"... so maybe the defines are not
> strictly needed?

Not strlctly, but if I see

	thaw_tasks(FREEZER_KERNEL_THREADS);
	thaw_tasks(FREEZER_USER_SPACE);

I can figure out what's going on even without looking at thaw_tasks().

> > +	do_each_thread(g, p) {
> > +		if (!freezeable(p))
> > +			continue;
> >  
> > +		if (is_user_space(p)) {
> > +			if (!thaw_user_space)
> > +				continue;
> > +		} else {
> > +			if (thaw_user_space)
> > +				continue;
> > +		}
> 
> if (is_user_space(p) != thaw_user_space)
> 	continue;

Ah, good idea.  In fact I prefer if (is_user_space(p) == !thaw_user_space),
because it will work even if thaw_user_space is different to 1 and 0.

Revised patch follows.

---
Move the loop from thaw_processes() to a separate function and call it
independently for kernel threads and user space processes so that the order
of thawing tasks is clearly visible.

Drop thaw_kernel_threads() which is never used.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/freezer.h |    6 -----
 kernel/power/process.c  |   53 ++++++++++++++++++++++++++----------------------
 2 files changed, 30 insertions(+), 29 deletions(-)

Index: linux-2.6.19-rc5-mm2/include/linux/freezer.h
===================================================================
--- linux-2.6.19-rc5-mm2.orig/include/linux/freezer.h
+++ linux-2.6.19-rc5-mm2/include/linux/freezer.h
@@ -1,8 +1,5 @@
 /* Freezer declarations */
 
-#define FREEZER_KERNEL_THREADS 0
-#define FREEZER_ALL_THREADS 1
-
 #ifdef CONFIG_PM
 /*
  * Check if a process has been frozen
@@ -60,8 +57,7 @@ static inline void frozen_process(struct
 
 extern void refrigerator(void);
 extern int freeze_processes(void);
-#define thaw_processes() do { thaw_some_processes(FREEZER_ALL_THREADS); } while(0)
-#define thaw_kernel_threads() do { thaw_some_processes(FREEZER_KERNEL_THREADS); } while(0)
+extern void thaw_processes(void);
 
 static inline int try_to_freeze(void)
 {
Index: linux-2.6.19-rc5-mm2/kernel/power/process.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/kernel/power/process.c
+++ linux-2.6.19-rc5-mm2/kernel/power/process.c
@@ -20,6 +20,8 @@
  */
 #define TIMEOUT	(20 * HZ)
 
+#define FREEZER_KERNEL_THREADS 0
+#define FREEZER_USER_SPACE 1
 
 static inline int freezeable(struct task_struct * p)
 {
@@ -79,6 +81,11 @@ static void cancel_freezing(struct task_
 	}
 }
 
+static inline int is_user_space(struct task_struct *p)
+{
+	return p->mm && !(p->flags & PF_BORROWED_MM);
+}
+
 /* 0 = success, else # of processes that we failed to stop */
 int freeze_processes(void)
 {
@@ -103,10 +110,9 @@ int freeze_processes(void)
 				cancel_freezing(p);
 				continue;
 			}
-			if (p->mm && !(p->flags & PF_BORROWED_MM)) {
-				/* The task is a user-space one.
-				 * Freeze it unless there's a vfork completion
-				 * pending
+			if (is_user_space(p)) {
+				/* Freeze the task unless there is a vfork
+				 * completion pending
 				 */
 				if (!p->vfork_done)
 					freeze_process(p);
@@ -155,31 +161,30 @@ int freeze_processes(void)
 	return 0;
 }
 
-void thaw_some_processes(int all)
+static void thaw_tasks(int thaw_user_space)
 {
 	struct task_struct *g, *p;
-	int pass = 0; /* Pass 0 = Kernel space, 1 = Userspace */
 
-	printk("Restarting tasks... ");
 	read_lock(&tasklist_lock);
-	do {
-		do_each_thread(g, p) {
-			/*
-			 * is_user = 0 if kernel thread or borrowed mm,
-			 * 1 otherwise.
-			 */
-			int is_user = !!(p->mm && !(p->flags & PF_BORROWED_MM));
-			if (!freezeable(p) || (is_user != pass))
-				continue;
-			if (!thaw_process(p))
-				printk(KERN_INFO
-					"Strange, %s not stopped\n", p->comm);
-		} while_each_thread(g, p);
-
-		pass++;
-	} while (pass < 2 && all);
-
+	do_each_thread(g, p) {
+		if (!freezeable(p))
+			continue;
+
+		if (is_user_space(p) == !thaw_user_space)
+			continue;
+
+		if (!thaw_process(p))
+			printk(KERN_WARNING " Strange, %s not stopped\n",
+				p->comm );
+	} while_each_thread(g, p);
 	read_unlock(&tasklist_lock);
+}
+
+void thaw_processes(void)
+{
+	printk("Restarting tasks ... ");
+	thaw_tasks(FREEZER_KERNEL_THREADS);
+	thaw_tasks(FREEZER_USER_SPACE);
 	schedule();
 	printk("done.\n");
 }

