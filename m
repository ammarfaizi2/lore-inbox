Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbVIKSXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbVIKSXy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 14:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbVIKSXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 14:23:54 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:28344 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965014AbVIKSXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 14:23:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=LcqIrswZsClVeXd6oc0V9azqXa5BIRj9IwDL3I5uZl2PJ8Atr1waaw7vUqk9t6zIx0L8TIW8zJPId6ueUSq0LTyhw/7bbOZLG2zkZnKyrON9hO3AdCfdO0R42U/SUvQUr7S4uXOcd/VjZXx+aVeHzbIRrpYr87JfvuG2EWpes6s=
Date: Sun, 11 Sep 2005 22:33:53 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] use add_taint() for setting tainted bit flags
Message-ID: <20050911183353.GA4353@mipter.zuzino.mipt.ru>
References: <20050911104431.1d755c4e.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050911104431.1d755c4e.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2005 at 10:44:31AM -0700, Randy.Dunlap wrote:
> Use the add_taint() interface for setting tainted bit flags
> instead of doing it manually.

> --- linux-2613-git10/kernel/module.c~use_add_taint
> +++ linux-2613-git10/kernel/module.c
> @@ -20,6 +20,7 @@
>  #include <linux/module.h>
>  #include <linux/moduleloader.h>
>  #include <linux/init.h>
> +#include <linux/kernel.h>
   ^^^^^^^^^^^^^^^^^^^^^^^^^

Will something like this be accepted? Not even boot-tested yet.

[PATCH] Separate tainted code.

include/linux/kernel.h is overcrowded. kernel/panic.c has nothing to do
with tainting.

 arch/i386/kernel/smpboot.c |    1 +
 arch/x86_64/kernel/mce.c   |    1 +
 include/linux/kernel.h     |   10 ----------
 include/linux/tainted.h    |   15 +++++++++++++++
 kernel/Makefile            |    2 +-
 kernel/module.c            |    1 +
 kernel/panic.c             |   37 -------------------------------------
 kernel/sysctl.c            |    1 +
 kernel/tainted.c           |   41 +++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c            |    1 +
 10 files changed, 62 insertions(+), 48 deletions(-)

diff -uprN linux-vanilla/arch/i386/kernel/smpboot.c linux-tainted/arch/i386/kernel/smpboot.c
--- linux-vanilla/arch/i386/kernel/smpboot.c	2005-09-11 15:27:27.000000000 +0400
+++ linux-tainted/arch/i386/kernel/smpboot.c	2005-09-11 22:20:15.000000000 +0400
@@ -37,6 +37,7 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/tainted.h>
 
 #include <linux/mm.h>
 #include <linux/sched.h>
diff -uprN linux-vanilla/arch/x86_64/kernel/mce.c linux-tainted/arch/x86_64/kernel/mce.c
--- linux-vanilla/arch/x86_64/kernel/mce.c	2005-09-11 15:27:37.000000000 +0400
+++ linux-tainted/arch/x86_64/kernel/mce.c	2005-09-11 22:20:29.000000000 +0400
@@ -17,6 +17,7 @@
 #include <linux/fs.h>
 #include <linux/cpu.h>
 #include <linux/percpu.h>
+#include <linux/tainted.h>
 #include <asm/processor.h> 
 #include <asm/msr.h>
 #include <asm/mce.h>
diff -uprN linux-vanilla/include/linux/kernel.h linux-tainted/include/linux/kernel.h
--- linux-vanilla/include/linux/kernel.h	2005-09-11 15:28:13.000000000 +0400
+++ linux-tainted/include/linux/kernel.h	2005-09-11 22:18:22.000000000 +0400
@@ -170,9 +170,6 @@ extern void bust_spinlocks(int yes);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
 extern int panic_timeout;
 extern int panic_on_oops;
-extern int tainted;
-extern const char *print_tainted(void);
-extern void add_taint(unsigned);
 
 /* Values used for system_state */
 extern enum system_states {
@@ -183,13 +180,6 @@ extern enum system_states {
 	SYSTEM_RESTART,
 } system_state;
 
-#define TAINT_PROPRIETARY_MODULE	(1<<0)
-#define TAINT_FORCED_MODULE		(1<<1)
-#define TAINT_UNSAFE_SMP		(1<<2)
-#define TAINT_FORCED_RMMOD		(1<<3)
-#define TAINT_MACHINE_CHECK		(1<<4)
-#define TAINT_BAD_PAGE			(1<<5)
-
 extern void dump_stack(void);
 
 #ifdef DEBUG
diff -uprN linux-vanilla/include/linux/tainted.h linux-tainted/include/linux/tainted.h
--- linux-vanilla/include/linux/tainted.h	1970-01-01 03:00:00.000000000 +0300
+++ linux-tainted/include/linux/tainted.h	2005-09-11 22:18:00.000000000 +0400
@@ -0,0 +1,15 @@
+#ifndef __TAINTED_H__
+#define __TAINTED_H__
+
+#define TAINT_PROPRIETARY_MODULE	(1<<0)
+#define TAINT_FORCED_MODULE		(1<<1)
+#define TAINT_UNSAFE_SMP		(1<<2)
+#define TAINT_FORCED_RMMOD		(1<<3)
+#define TAINT_MACHINE_CHECK		(1<<4)
+#define TAINT_BAD_PAGE			(1<<5)
+
+extern int tainted;
+const char * print_tainted(void);
+void add_taint(unsigned);
+
+#endif
diff -uprN linux-vanilla/kernel/Makefile linux-tainted/kernel/Makefile
--- linux-vanilla/kernel/Makefile	2005-09-11 15:28:16.000000000 +0400
+++ linux-tainted/kernel/Makefile	2005-09-11 22:12:17.000000000 +0400
@@ -4,7 +4,7 @@
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o profile.o \
 	    exit.o itimer.o time.o softirq.o resource.o \
-	    sysctl.o capability.o ptrace.o timer.o user.o \
+	    sysctl.o capability.o ptrace.o tainted.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
 	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o
diff -uprN linux-vanilla/kernel/module.c linux-tainted/kernel/module.c
--- linux-vanilla/kernel/module.c	2005-09-11 15:28:16.000000000 +0400
+++ linux-tainted/kernel/module.c	2005-09-11 22:21:04.000000000 +0400
@@ -36,6 +36,7 @@
 #include <linux/stop_machine.h>
 #include <linux/device.h>
 #include <linux/string.h>
+#include <linux/tainted.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 #include <asm/cacheflush.h>
diff -uprN linux-vanilla/kernel/panic.c linux-tainted/kernel/panic.c
--- linux-vanilla/kernel/panic.c	2005-09-11 15:28:16.000000000 +0400
+++ linux-tainted/kernel/panic.c	2005-09-11 22:11:41.000000000 +0400
@@ -22,7 +22,6 @@
 
 int panic_timeout;
 int panic_on_oops;
-int tainted;
 
 EXPORT_SYMBOL(panic_timeout);
 
@@ -137,39 +136,3 @@ NORET_TYPE void panic(const char * fmt, 
 }
 
 EXPORT_SYMBOL(panic);
-
-/**
- *	print_tainted - return a string to represent the kernel taint state.
- *
- *  'P' - Proprietary module has been loaded.
- *  'F' - Module has been forcibly loaded.
- *  'S' - SMP with CPUs not designed for SMP.
- *  'R' - User forced a module unload.
- *  'M' - Machine had a machine check experience.
- *  'B' - System has hit bad_page.
- *
- *	The string is overwritten by the next call to print_taint().
- */
- 
-const char *print_tainted(void)
-{
-	static char buf[20];
-	if (tainted) {
-		snprintf(buf, sizeof(buf), "Tainted: %c%c%c%c%c%c",
-			tainted & TAINT_PROPRIETARY_MODULE ? 'P' : 'G',
-			tainted & TAINT_FORCED_MODULE ? 'F' : ' ',
-			tainted & TAINT_UNSAFE_SMP ? 'S' : ' ',
-			tainted & TAINT_FORCED_RMMOD ? 'R' : ' ',
- 			tainted & TAINT_MACHINE_CHECK ? 'M' : ' ',
-			tainted & TAINT_BAD_PAGE ? 'B' : ' ');
-	}
-	else
-		snprintf(buf, sizeof(buf), "Not tainted");
-	return(buf);
-}
-
-void add_taint(unsigned flag)
-{
-	tainted |= flag;
-}
-EXPORT_SYMBOL(add_taint);
diff -uprN linux-vanilla/kernel/sysctl.c linux-tainted/kernel/sysctl.c
--- linux-vanilla/kernel/sysctl.c	2005-09-11 15:28:17.000000000 +0400
+++ linux-tainted/kernel/sysctl.c	2005-09-11 22:21:38.000000000 +0400
@@ -42,6 +42,7 @@
 #include <linux/limits.h>
 #include <linux/dcache.h>
 #include <linux/syscalls.h>
+#include <linux/tainted.h>
 
 #include <asm/uaccess.h>
 #include <asm/processor.h>
diff -uprN linux-vanilla/kernel/tainted.c linux-tainted/kernel/tainted.c
--- linux-vanilla/kernel/tainted.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-tainted/kernel/tainted.c	2005-09-11 22:15:46.000000000 +0400
@@ -0,0 +1,41 @@
+#include <linux/kernel.h> /* FIXME: remove once snprintf prototype removed from kernel.h */
+#include <linux/module.h>
+#include <linux/tainted.h>
+
+int tainted;
+
+/**
+ * print_tainted - return a string to represent the kernel taint state.
+ *
+ * 'P' - Proprietary module has been loaded.
+ * 'F' - Module has been forcibly loaded.
+ * 'S' - SMP with CPUs not designed for SMP.
+ * 'R' - User forced a module unload.
+ * 'M' - Machine had a machine check experience.
+ * 'B' - System has hit bad_page.
+ *
+ * The string is overwritten by the next call to print_taint().
+ */
+
+const char * print_tainted(void)
+{
+	static char buf[20];
+
+	if (tainted)
+		snprintf(buf, sizeof(buf), "Tainted: %c%c%c%c%c%c",
+			tainted & TAINT_PROPRIETARY_MODULE	? 'P' : 'G',
+			tainted & TAINT_FORCED_MODULE		? 'F' : ' ',
+			tainted & TAINT_UNSAFE_SMP		? 'S' : ' ',
+			tainted & TAINT_FORCED_RMMOD		? 'R' : ' ',
+			tainted & TAINT_MACHINE_CHECK		? 'M' : ' ',
+			tainted & TAINT_BAD_PAGE		? 'B' : ' ');
+	else
+		snprintf(buf, sizeof(buf), "Not tainted");
+	return buf;
+}
+
+void add_taint(unsigned flag)
+{
+	tainted |= flag;
+}
+EXPORT_SYMBOL(add_taint);
diff -uprN linux-vanilla/mm/page_alloc.c linux-tainted/mm/page_alloc.c
--- linux-vanilla/mm/page_alloc.c	2005-09-11 15:28:18.000000000 +0400
+++ linux-tainted/mm/page_alloc.c	2005-09-11 22:19:24.000000000 +0400
@@ -34,6 +34,7 @@
 #include <linux/cpuset.h>
 #include <linux/nodemask.h>
 #include <linux/vmalloc.h>
+#include <linux/tainted.h>
 
 #include <asm/tlbflush.h>
 #include "internal.h"

