Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSGDXvJ>; Thu, 4 Jul 2002 19:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSGDXuj>; Thu, 4 Jul 2002 19:50:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34573 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315162AbSGDXps>;
	Thu, 4 Jul 2002 19:45:48 -0400
Message-ID: <3D24E022.B647B1C@zip.com.au>
Date: Thu, 04 Jul 2002 16:54:10 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 8/27] pdflush cleanup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Writeback/pdflush cleanup patch from Steven Augart

* Exposes nr_pdflush_threads as /proc/sys/vm/nr_pdflush_threads, read-only.

  (I like this - I expect that management of the pdflush thread pool
  will be important for many-spindle machines, and this is a neat way
  of getting at the info).

* Adds minimum and maximum checking to the five writable pdflush 
  and fs-writeback  parameters.

* Minor indentation fix in sysctl.c

* mm/pdflush.c now includes linux/writeback.h, which prototypes 
  pdflush_operation.  This is so that the compiler can 
  automatically check that the prototype matches the definition. 

* Adds a few comments to existing code.



 include/linux/sysctl.h    |    6 +++++-
 include/linux/writeback.h |    7 +++++++
 kernel/sysctl.c           |   42 ++++++++++++++++++++++++++++++++++--------
 mm/page-writeback.c       |   12 +++++++++---
 mm/pdflush.c              |    8 +++++++-
 5 files changed, 62 insertions(+), 13 deletions(-)

--- 2.5.24/include/linux/sysctl.h~pdflush-cleanup	Thu Jul  4 16:17:14 2002
+++ 2.5.24-akpm/include/linux/sysctl.h	Thu Jul  4 16:17:14 2002
@@ -30,7 +30,10 @@
 
 struct file;
 
-#define CTL_MAXNAME 10
+#define CTL_MAXNAME 10		/* how many path components do we allow in a
+				   call to sysctl?   In other words, what is
+				   the largest acceptable value for the nlen
+				   member of a struct __sysctl_args to have? */
 
 struct __sysctl_args {
 	int *name;
@@ -145,6 +148,7 @@ enum
 	VM_DIRTY_SYNC=13,	/* dirty_sync_ratio */
 	VM_DIRTY_WB_CS=14,	/* dirty_writeback_centisecs */
 	VM_DIRTY_EXPIRE_CS=15,	/* dirty_expire_centisecs */
+	VM_NR_PDFLUSH_THREADS=16, /* nr_pdflush_threads */
 };
 
 
--- 2.5.24/include/linux/writeback.h~pdflush-cleanup	Thu Jul  4 16:17:14 2002
+++ 2.5.24-akpm/include/linux/writeback.h	Thu Jul  4 16:17:14 2002
@@ -49,15 +49,22 @@ static inline void wait_on_inode(struct 
 /*
  * mm/page-writeback.c
  */
+/* These 5 are exported to sysctl. */
 extern int dirty_background_ratio;
 extern int dirty_async_ratio;
 extern int dirty_sync_ratio;
 extern int dirty_writeback_centisecs;
 extern int dirty_expire_centisecs;
 
+
 void balance_dirty_pages(struct address_space *mapping);
 void balance_dirty_pages_ratelimited(struct address_space *mapping);
 int pdflush_operation(void (*fn)(unsigned long), unsigned long arg0);
 int do_writepages(struct address_space *mapping, int *nr_to_write);
 
+/* pdflush.c */
+extern int nr_pdflush_threads;	/* Global so it can be exported to sysctl
+				   read-only. */
+
+
 #endif		/* WRITEBACK_H */
--- 2.5.24/kernel/sysctl.c~pdflush-cleanup	Thu Jul  4 16:17:14 2002
+++ 2.5.24-akpm/kernel/sysctl.c	Thu Jul  4 16:17:14 2002
@@ -258,6 +258,13 @@ static ctl_table kern_table[] = {
 	{0}
 };
 
+/* Constants for minimum and maximum testing in vm_table.
+   We use these as one-element integer vectors. */
+static int zero = 0;
+static int one = 1;
+static int one_hundred = 100;
+
+
 static ctl_table vm_table[] = {
 	{VM_OVERCOMMIT_MEMORY, "overcommit_memory", &sysctl_overcommit_memory,
 	 sizeof(sysctl_overcommit_memory), 0644, NULL, &proc_dointvec},
@@ -266,18 +273,37 @@ static ctl_table vm_table[] = {
 	{VM_PAGE_CLUSTER, "page-cluster", 
 	 &page_cluster, sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_DIRTY_BACKGROUND, "dirty_background_ratio",
-	&dirty_background_ratio, sizeof(dirty_background_ratio),
-	0644, NULL, &proc_dointvec},
+	 &dirty_background_ratio, sizeof(dirty_background_ratio),
+	 0644, NULL, &proc_dointvec_minmax,  &sysctl_intvec, NULL,
+	 &zero, &one_hundred },
 	{VM_DIRTY_ASYNC, "dirty_async_ratio", &dirty_async_ratio,
-	sizeof(dirty_async_ratio), 0644, NULL, &proc_dointvec},
+	 sizeof(dirty_async_ratio), 0644, NULL, &proc_dointvec_minmax,
+	 &sysctl_intvec, NULL, &zero, &one_hundred },
 	{VM_DIRTY_SYNC, "dirty_sync_ratio", &dirty_sync_ratio,
-	sizeof(dirty_sync_ratio), 0644, NULL, &proc_dointvec},
+	 sizeof(dirty_sync_ratio), 0644, NULL, &proc_dointvec_minmax,
+	 &sysctl_intvec, NULL, &zero, &one_hundred },
 	{VM_DIRTY_WB_CS, "dirty_writeback_centisecs",
-	&dirty_writeback_centisecs, sizeof(dirty_writeback_centisecs), 0644,
-	NULL, &proc_dointvec},
+	 &dirty_writeback_centisecs, sizeof(dirty_writeback_centisecs), 0644,
+	 NULL, &proc_dointvec_minmax, &sysctl_intvec, NULL,
+	 /* Here, we define the range of possible values for
+	    dirty_writeback_centisecs.
+
+	    The default value is 5 seconds (500 centisec).  We will use 1
+	    centisec, the smallest possible value that could make any sort of
+	    sense.  If we allowed the user to set the interval to 0 seconds
+	    (which would presumably mean to chew up all of the CPU looking for
+	    dirty pages and writing them out, without taking a break), the
+	    interval would effectively become 1 second (100 centisecs), due to
+	    some nicely documented throttling code in wb_kupdate().
+
+	    There is no maximum legal value for dirty_writeback. */
+	 &one , NULL},
 	{VM_DIRTY_EXPIRE_CS, "dirty_expire_centisecs",
-	&dirty_expire_centisecs, sizeof(dirty_expire_centisecs), 0644,
-	NULL, &proc_dointvec},
+	 &dirty_expire_centisecs, sizeof(dirty_expire_centisecs), 0644,
+	 NULL, &proc_dointvec},
+	{ VM_NR_PDFLUSH_THREADS, "nr_pdflush_threads",
+	  &nr_pdflush_threads, sizeof nr_pdflush_threads,
+	  0444 /* read-only*/, NULL, &proc_dointvec},
 	{0}
 };
 
--- 2.5.24/mm/page-writeback.c~pdflush-cleanup	Thu Jul  4 16:17:14 2002
+++ 2.5.24-akpm/mm/page-writeback.c	Thu Jul  4 16:22:08 2002
@@ -47,6 +47,8 @@
 #define SYNC_WRITEBACK_PAGES	1500
 
 
+/* The following parameters are exported via /proc/sys/vm */
+
 /*
  * Dirty memory thresholds, in percentages
  */
@@ -67,15 +69,18 @@ int dirty_async_ratio = 50;
 int dirty_sync_ratio = 60;
 
 /*
- * The interval between `kupdate'-style writebacks.
+ * The interval between `kupdate'-style writebacks, in centiseconds
+ * (hundredths of a second)
  */
 int dirty_writeback_centisecs = 5 * 100;
 
 /*
- * The largest amount of time for which data is allowed to remain dirty
+ * The longest amount of time for which data is allowed to remain dirty
  */
 int dirty_expire_centisecs = 30 * 100;
 
+/* End of sysctl-exported parameters */
+
 
 static void background_writeout(unsigned long _min_pages);
 
@@ -233,7 +238,8 @@ static void wb_kupdate(unsigned long arg
 static void wb_timer_fn(unsigned long unused)
 {
 	if (pdflush_operation(wb_kupdate, 0) < 0)
-		mod_timer(&wb_timer, jiffies + HZ);
+		mod_timer(&wb_timer, jiffies + HZ); /* delay 1 second */
+
 }
 
 static int __init wb_timer_init(void)
--- 2.5.24/mm/pdflush.c~pdflush-cleanup	Thu Jul  4 16:17:14 2002
+++ 2.5.24-akpm/mm/pdflush.c	Thu Jul  4 16:17:14 2002
@@ -15,6 +15,9 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/suspend.h>
+#include <linux/sched.h>	// Needed by writeback.h
+#include <linux/fs.h>		// Needed by writeback.h
+#include <linux/writeback.h>	// Prototypes pdflush_operation()
 
 
 /*
@@ -44,8 +47,11 @@ static spinlock_t pdflush_lock = SPIN_LO
 /*
  * The count of currently-running pdflush threads.  Protected
  * by pdflush_lock.
+ *
+ * Readable by sysctl, but not writable.  Published to userspace at
+ * /proc/sys/vm/nr_pdflush_threads.
  */
-static int nr_pdflush_threads = 0;
+int nr_pdflush_threads = 0;
 
 /*
  * The time at which the pdflush thread pool last went empty

-
