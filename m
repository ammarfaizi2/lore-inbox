Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316774AbSFQGrM>; Mon, 17 Jun 2002 02:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316773AbSFQGrL>; Mon, 17 Jun 2002 02:47:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15374 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316770AbSFQGrF>;
	Mon, 17 Jun 2002 02:47:05 -0400
Message-ID: <3D0D86D7.644F0C13@zip.com.au>
Date: Sun, 16 Jun 2002 23:51:03 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 1/19] writeback tunables
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Adds five sysctls for tuning the writeback behaviour:

	dirty_async_ratio
	dirty_background_ratio
	dirty_sync_ratio
	dirty_expire_centisecs
	dirty_writeback_centisecs

these are described in Documentation/filesystems/proc.txt  They are
basically the tradiditional knobs which we've always had...

We are accreting a ton of obsolete sysctl numbers under /proc/sys/vm/. 
I didn't recycle these - just mark them unused and remove the obsolete
documentation.  


--- 2.5.22/include/linux/sysctl.h~pdflush-sysctl	Sun Jun 16 22:50:16 2002
+++ 2.5.22-akpm/include/linux/sysctl.h	Sun Jun 16 22:50:16 2002
@@ -130,16 +130,21 @@ enum
 /* CTL_VM names: */
 enum
 {
-	VM_SWAPCTL=1,		/* struct: Set vm swapping control */
-	VM_SWAPOUT=2,		/* int: Linear or sqrt() swapout for hogs */
-	VM_FREEPG=3,		/* struct: Set free page thresholds */
+	VM_UNUSED1=1,		/* was: struct: Set vm swapping control */
+	VM_UNUSED2=2,		/* was; int: Linear or sqrt() swapout for hogs */
+	VM_UNUSED3=3,		/* was: struct: Set free page thresholds */
 	VM_BDFLUSH_UNUSED=4,	/* Spare */
 	VM_OVERCOMMIT_MEMORY=5,	/* Turn off the virtual memory safety limit */
-	VM_BUFFERMEM=6,		/* struct: Set buffer memory thresholds */
-	VM_PAGECACHE=7,		/* struct: Set cache memory thresholds */
+	VM_UNUSED4=6,		/* was: struct: Set buffer memory thresholds */
+	VM_UNUSED5=7,		/* was: struct: Set cache memory thresholds */
 	VM_PAGERDAEMON=8,	/* struct: Control kswapd behaviour */
-	VM_PGT_CACHE=9,		/* struct: Set page table cache parameters */
-	VM_PAGE_CLUSTER=10	/* int: set number of pages to swap together */
+	VM_UNUSED6=9,		/* was: struct: Set page table cache parameters */
+	VM_PAGE_CLUSTER=10,	/* int: set number of pages to swap together */
+	VM_DIRTY_BACKGROUND=11,	/* dirty_background_ratio */
+	VM_DIRTY_ASYNC=12,	/* dirty_async_ratio */
+	VM_DIRTY_SYNC=13,	/* dirty_sync_ratio */
+	VM_DIRTY_WB_CS=14,	/* dirty_writeback_centisecs */
+	VM_DIRTY_EXPIRE_CS=15,	/* dirty_expire_centisecs */
 };
 
 
--- 2.5.22/kernel/sysctl.c~pdflush-sysctl	Sun Jun 16 22:50:16 2002
+++ 2.5.22-akpm/kernel/sysctl.c	Sun Jun 16 22:50:16 2002
@@ -31,6 +31,7 @@
 #include <linux/init.h>
 #include <linux/sysrq.h>
 #include <linux/highuid.h>
+#include <linux/writeback.h>
 
 #include <asm/uaccess.h>
 
@@ -264,6 +265,19 @@ static ctl_table vm_table[] = {
 	 &pager_daemon, sizeof(pager_daemon_t), 0644, NULL, &proc_dointvec},
 	{VM_PAGE_CLUSTER, "page-cluster", 
 	 &page_cluster, sizeof(int), 0644, NULL, &proc_dointvec},
+	{VM_DIRTY_BACKGROUND, "dirty_background_ratio",
+	&dirty_background_ratio, sizeof(dirty_background_ratio),
+	0644, NULL, &proc_dointvec},
+	{VM_DIRTY_ASYNC, "dirty_async_ratio", &dirty_async_ratio,
+	sizeof(dirty_async_ratio), 0644, NULL, &proc_dointvec},
+	{VM_DIRTY_SYNC, "dirty_sync_ratio", &dirty_sync_ratio,
+	sizeof(dirty_sync_ratio), 0644, NULL, &proc_dointvec},
+	{VM_DIRTY_WB_CS, "dirty_writeback_centisecs",
+	&dirty_writeback_centisecs, sizeof(dirty_writeback_centisecs), 0644,
+	NULL, &proc_dointvec},
+	{VM_DIRTY_EXPIRE_CS, "dirty_expire_centisecs",
+	&dirty_expire_centisecs, sizeof(dirty_expire_centisecs), 0644,
+	NULL, &proc_dointvec},
 	{0}
 };
 
--- 2.5.22/mm/page-writeback.c~pdflush-sysctl	Sun Jun 16 22:50:16 2002
+++ 2.5.22-akpm/mm/page-writeback.c	Sun Jun 16 22:50:16 2002
@@ -26,29 +26,56 @@
  * The maximum number of pages to writeout in a single bdflush/kupdate
  * operation.  We do this so we don't hold I_LOCK against an inode for
  * enormous amounts of time, which would block a userspace task which has
- * been forced to throttle against that inode.
+ * been forced to throttle against that inode.  Also, the code reevaluates
+ * the dirty each time it has written this many pages.
  */
 #define MAX_WRITEBACK_PAGES	1024
 
 /*
- * Memory thresholds, in percentages
- * FIXME: expose these via /proc or whatever.
+ * After a CPU has dirtied this many pages, balance_dirty_pages_ratelimited
+ * will look to see if it needs to force writeback or throttling.  Probably
+ * should be scaled by memory size.
+ */
+#define RATELIMIT_PAGES		1000
+
+/*
+ * When balance_dirty_pages decides that the caller needs to perform some
+ * non-background writeback, this is how many pages it will attempt to write.
+ * It should be somewhat larger than RATELIMIT_PAGES to ensure that reasonably
+ * large amounts of I/O are submitted.
+ */
+#define SYNC_WRITEBACK_PAGES	1500
+
+
+/*
+ * Dirty memory thresholds, in percentages
  */
 
 /*
  * Start background writeback (via pdflush) at this level
  */
-static int dirty_background_ratio = 40;
+int dirty_background_ratio = 40;
 
 /*
  * The generator of dirty data starts async writeback at this level
  */
-static int dirty_async_ratio = 50;
+int dirty_async_ratio = 50;
 
 /*
  * The generator of dirty data performs sync writeout at this level
  */
-static int dirty_sync_ratio = 60;
+int dirty_sync_ratio = 60;
+
+/*
+ * The interval between `kupdate'-style writebacks.
+ */
+int dirty_writeback_centisecs = 5 * 100;
+
+/*
+ * The largest amount of time for which data is allowed to remain dirty
+ */
+int dirty_expire_centisecs = 30 * 100;
+
 
 static void background_writeout(unsigned long _min_pages);
 
@@ -84,12 +111,12 @@ void balance_dirty_pages(struct address_
 	sync_thresh = (dirty_sync_ratio * tot) / 100;
 
 	if (dirty_and_writeback > sync_thresh) {
-		int nr_to_write = 1500;
+		int nr_to_write = SYNC_WRITEBACK_PAGES;
 
 		writeback_unlocked_inodes(&nr_to_write, WB_SYNC_LAST, NULL);
 		get_page_state(&ps);
 	} else if (dirty_and_writeback > async_thresh) {
-		int nr_to_write = 1500;
+		int nr_to_write = SYNC_WRITEBACK_PAGES;
 
 		writeback_unlocked_inodes(&nr_to_write, WB_SYNC_NONE, NULL);
 		get_page_state(&ps);
@@ -118,7 +145,7 @@ void balance_dirty_pages_ratelimited(str
 	int cpu;
 
 	cpu = get_cpu();
-	if (ratelimits[cpu].count++ >= 1000) {
+	if (ratelimits[cpu].count++ >= RATELIMIT_PAGES) {
 		ratelimits[cpu].count = 0;
 		put_cpu();
 		balance_dirty_pages(mapping);
@@ -162,17 +189,6 @@ void wakeup_bdflush(void)
 	pdflush_operation(background_writeout, ps.nr_dirty);
 }
 
-/*
- * The interval between `kupdate'-style writebacks.
- *
- * Traditional kupdate writes back data which is 30-35 seconds old.
- * This one does that, but it also writes back just 1/6th of the dirty
- * data.  This is to avoid great I/O storms.
- *
- * We chunk the writes up and yield, to permit any throttled page-allocators
- * to perform their I/O against a large file.
- */
-static int wb_writeback_jifs = 5 * HZ;
 static struct timer_list wb_timer;
 
 /*
@@ -183,9 +199,9 @@ static struct timer_list wb_timer;
  * just walks the superblock inode list, writing back any inodes which are
  * older than a specific point in time.
  *
- * Try to run once per wb_writeback_jifs jiffies.  But if a writeback event
- * takes longer than a wb_writeback_jifs interval, then leave a one-second
- * gap.
+ * Try to run once per dirty_writeback_centisecs.  But if a writeback event
+ * takes longer than a dirty_writeback_centisecs interval, then leave a
+ * one-second gap.
  *
  * older_than_this takes precedence over nr_to_write.  So we'll only write back
  * all dirty pages if they are all attached to "old" mappings.
@@ -201,9 +217,9 @@ static void wb_kupdate(unsigned long arg
 	sync_supers();
 	get_page_state(&ps);
 
-	oldest_jif = jiffies - 30*HZ;
+	oldest_jif = jiffies - (dirty_expire_centisecs * HZ) / 100;
 	start_jif = jiffies;
-	next_jif = start_jif + wb_writeback_jifs;
+	next_jif = start_jif + (dirty_writeback_centisecs * HZ) / 100;
 	nr_to_write = ps.nr_dirty;
 	writeback_unlocked_inodes(&nr_to_write, WB_SYNC_NONE, &oldest_jif);
 	blk_run_queues();
@@ -223,7 +239,7 @@ static void wb_timer_fn(unsigned long un
 static int __init wb_timer_init(void)
 {
 	init_timer(&wb_timer);
-	wb_timer.expires = jiffies + wb_writeback_jifs;
+	wb_timer.expires = jiffies + (dirty_writeback_centisecs * HZ) / 100;
 	wb_timer.data = 0;
 	wb_timer.function = wb_timer_fn;
 	add_timer(&wb_timer);
--- 2.5.22/include/linux/writeback.h~pdflush-sysctl	Sun Jun 16 22:50:16 2002
+++ 2.5.22-akpm/include/linux/writeback.h	Sun Jun 16 22:50:16 2002
@@ -45,6 +45,12 @@ static inline void wait_on_inode(struct 
 /*
  * mm/page-writeback.c
  */
+extern int dirty_background_ratio;
+extern int dirty_async_ratio;
+extern int dirty_sync_ratio;
+extern int dirty_writeback_centisecs;
+extern int dirty_expire_centisecs;
+
 void balance_dirty_pages(struct address_space *mapping);
 void balance_dirty_pages_ratelimited(struct address_space *mapping);
 int pdflush_operation(void (*fn)(unsigned long), unsigned long arg0);
--- 2.5.22/Documentation/filesystems/proc.txt~pdflush-sysctl	Sun Jun 16 22:50:16 2002
+++ 2.5.22-akpm/Documentation/filesystems/proc.txt	Sun Jun 16 22:50:16 2002
@@ -948,120 +948,43 @@ program to load modules on demand.
 -----------------------------------------------
 
 The files  in  this directory can be used to tune the operation of the virtual
-memory (VM)  subsystem  of  the  Linux  kernel.  In addition, one of the files
-(bdflush) has some influence on disk usage.
+memory (VM)  subsystem  of  the  Linux  kernel.
 
-bdflush
--------
+dirty_background_ratio
+----------------------
 
-This file  controls  the  operation of the bdflush kernel daemon. It currently
-contains nine  integer  values,  six of which are actually used by the kernel.
-They are listed in table 2-2.
-
-
-Table 2-2: Parameters in /proc/sys/vm/bdflush 
-..............................................................................
- Value      Meaning                                                            
- nfract     Percentage of buffer cache dirty to  activate bdflush              
- ndirty     Maximum number of dirty blocks to  write out per wake-cycle        
- nrefill    Number of clean buffers to try to obtain  each time we call refill 
- nref_dirt  buffer threshold for activating bdflush when trying to refill
-            buffers. 
- dummy      Unused                                                             
- age_buffer Time for normal buffer to age before we flush it                   
- age_super  Time for superblock to age before we flush it                      
- dummy      Unused                                                             
- dummy      Unused                                                             
-..............................................................................
+Contains, as a percentage of total system memory, the number of pages at which
+the pdflush background writeback daemon will start writing out dirty data.
 
-nfract
-------
-
-This parameter  governs  the  maximum  number  of  dirty buffers in the buffer
-cache. Dirty means that the contents of the buffer still have to be written to
-disk (as  opposed  to  a  clean  buffer,  which  can just be forgotten about).
-Setting this  to  a  higher value means that Linux can delay disk writes for a
-long time, but it also means that it will have to do a lot of I/O at once when
-memory becomes short. A lower value will spread out disk I/O more evenly.
-
-ndirty
-------
-
-Ndirty gives the maximum number of dirty buffers that bdflush can write to the
-disk at  one  time.  A high value will mean delayed, bursty I/O, while a small
-value can lead to memory shortage when bdflush isn't woken up often enough.
-
-nrefill
--------
-
-This is  the  number  of  buffers  that  bdflush  will add to the list of free
-buffers when  refill_freelist()  is  called.  It is necessary to allocate free
-buffers beforehand,  since  the  buffers  are  often  different sizes than the
-memory pages  and some bookkeeping needs to be done beforehand. The higher the
-number, the  more  memory  will be wasted and the less often refill_freelist()
-will need to run.
-
-nref_dirt
----------
-
-When refill_freelist() comes across more than nref_dirt dirty buffers, it will
-wake up bdflush.
-
-age_buffer and age_super
-------------------------
-
-Finally, the age_buffer and age_super parameters govern the maximum time Linux
-waits before  writing  out  a  dirty buffer to disk. The value is expressed in
-jiffies (clockticks),  the  number of jiffies per second is 100. Age_buffer is
-the maximum age for data blocks, while age_super is for filesystems meta data.
-
-buffermem
----------
-
-The three  values  in  this  file  control  how much memory should be used for
-buffer memory.  The  percentage  is calculated as a percentage of total system
-memory.
-
-The values are:
-
-min_percent
------------
-
-This is  the  minimum  percentage  of  memory  that  should be spent on buffer
-memory.
-
-borrow_percent
---------------
-
-When Linux is short on memory, and the buffer cache uses more than it has been
-allotted, the  memory  management  (MM)  subsystem will prune the buffer cache
-more heavily than other memory to compensate.
-
-max_percent
------------
-
-This is the maximum amount of memory that can be used for buffer memory.
-
-freepages
----------
+dirty_async_ratio
+-----------------
 
-This file contains three values: min, low and high:
+Contains, as a percentage of total system memory, the number of pages at which
+a process which is generating disk writes will itself start writing out dirty
+data.
+
+dirty_sync_ratio
+----------------
+
+Contains, as a percentage of total system memory, the number of pages at which
+a process which is generating disk writes will itself start writing out dirty
+data and waiting upon completion of that writeout.
+
+dirty_writeback_centisecs
+-------------------------
+
+The pdflush writeback daemons will periodically wake up and write `old' data
+out to disk.  This tunable expresses the interval between those wakeups, in
+100'ths of a second.
+
+dirty_expire_centisecs
+----------------------
+
+This tunable is used to define when dirty data is old enough to be eligible
+for writeout by the pdflush daemons.  It is expressed in 100'ths of a second. 
+Data which has been dirty in-memory for longer than this interval will be
+written out next time a pdflush daemon wakes up.
 
-min
----
-When the  number  of  free  pages  in the system reaches this number, only the
-kernel can allocate more memory.
-
-low
----
-If the number of free pages falls below this point, the kernel starts swapping
-aggressively.
-
-high
-----
-The kernel  tries  to  keep  up to this amount of memory free; if memory falls
-below this point, the kernel starts gently swapping in the hopes that it never
-has to do really aggressive swapping.
 
 kswapd
 ------
@@ -1113,79 +1036,6 @@ On the  other  hand,  enabling this feat
 and thrash the system to death, so large and/or important servers will want to
 set this value to 0.
 
-pagecache
----------
-
-This file  does exactly the same job as buffermem, only this file controls the
-amount of memory allowed for memory mapping and generic caching of files.
-
-You don't  want  the  minimum level to be too low, otherwise your system might
-thrash when memory is tight or fragmentation is high.
-
-pagetable_cache
----------------
-
-The kernel  keeps a number of page tables in a per-processor cache (this helps
-a lot  on  SMP systems). The cache size for each processor will be between the
-low and the high value.
-
-On a  low-memory,  single  CPU system, you can safely set these values to 0 so
-you don't  waste  memory.  It  is  used  on SMP systems so that the system can
-perform fast  pagetable allocations without having to acquire the kernel memory
-lock.
-
-For large  systems,  the  settings  are probably fine. For normal systems they
-won't hurt  a  bit.  For  small  systems  (  less  than  16MB ram) it might be
-advantageous to set both values to 0.
-
-swapctl
--------
-
-This file  contains  no less than 8 variables. All of these values are used by
-kswapd.
-
-The first four variables
-* sc_max_page_age,
-* sc_page_advance,
-* sc_page_decline and
-* sc_page_initial_age
-are used  to  keep  track  of  Linux's page aging. Page aging is a bookkeeping
-method to  track  which pages of memory are often used, and which pages can be
-swapped out without consequences.
-
-When a  page  is  swapped in, it starts at sc_page_initial_age (default 3) and
-when the  page  is  scanned  by  kswapd,  its age is adjusted according to the
-following scheme:
-
-* If  the  page  was used since the last time we scanned, its age is increased
-  by sc_page_advance  (default  3).  Where  the  maximum  value  is  given  by
-  sc_max_page_age (default 20).
-* Otherwise  (meaning  it wasn't used) its age is decreased by sc_page_decline
-  (default 1).
-
-When a page reaches age 0, it's ready to be swapped out.
-
-The variables  sc_age_cluster_fract, sc_age_cluster_min, sc_pageout_weight and
-sc_bufferout_weight, can  be  used  to  control  kswapd's  aggressiveness  in
-swapping out pages.
-
-Sc_age_cluster_fract is used to calculate how many pages from a process are to
-be scanned by kswapd. The formula used is
-
-(sc_age_cluster_fract divided by 1024) times resident set size
-
-So if you want kswapd to scan the whole process, sc_age_cluster_fract needs to
-have a  value  of  1024.  The  minimum  number  of  pages  kswapd will scan is
-represented by sc_age_cluster_min, which is done so that kswapd will also scan
-small processes.
-
-The values  of  sc_pageout_weight  and sc_bufferout_weight are used to control
-how many  tries  kswapd  will make in order to swap out one page/buffer. These
-values can  be used to fine-tune the ratio between user pages and buffer/cache
-memory. When  you find that your Linux system is swapping out too many process
-pages in  order  to  satisfy  buffer  memory  demands,  you may want to either
-increase sc_bufferout_weight, or decrease the value of sc_pageout_weight.
-
 2.5 /proc/sys/dev - Device specific parameters
 ----------------------------------------------
 
--- 2.5.22/Documentation/sysctl/vm.txt~pdflush-sysctl	Sun Jun 16 22:50:16 2002
+++ 2.5.22-akpm/Documentation/sysctl/vm.txt	Sun Jun 16 22:50:16 2002
@@ -9,116 +9,28 @@ This file contains the documentation for
 /proc/sys/vm and is valid for Linux kernel version 2.2.
 
 The files in this directory can be used to tune the operation
-of the virtual memory (VM) subsystem of the Linux kernel, and
-one of the files (bdflush) also has a little influence on disk
-usage.
+of the virtual memory (VM) subsystem of the Linux kernel and
+the writeout of dirty data to disk.
 
 Default values and initialization routines for most of these
 files can be found in mm/swap.c.
 
 Currently, these files are in /proc/sys/vm:
-- bdflush
-- buffermem
-- freepages
 - kswapd
 - overcommit_memory
 - page-cluster
-- pagecache
-- pagetable_cache
+- dirty_async_ratio
+- dirty_background_ratio
+- dirty_expire_centisecs
+- dirty_sync_ratio
+- dirty_writeback_centisecs
 
 ==============================================================
 
-bdflush:
+dirty_async_ratio, dirty_background_ratio, dirty_expire_centisecs,
+dirty_sync_ratio dirty_writeback_centisecs:
 
-This file controls the operation of the bdflush kernel
-daemon. The source code to this struct can be found in
-linux/fs/buffer.c. It currently contains 9 integer values,
-of which 4 are actually used by the kernel.
-
-From linux/fs/buffer.c:
---------------------------------------------------------------
-union bdflush_param {
-	struct {
-		int nfract;	/* Percentage of buffer cache dirty to 
-				   activate bdflush */
-		int dummy1;	/* old "ndirty" */
-		int dummy2;	/* old "nrefill" */
-		int dummy3;	/* unused */
-		int interval;	/* jiffies delay between kupdate flushes */
-		int age_buffer;	/* Time for normal buffer to age */
-		int nfract_sync;/* Percentage of buffer cache dirty to 
-				   activate bdflush synchronously */
-		int dummy4;	/* unused */
-		int dummy5;	/* unused */
-	} b_un;
-	unsigned int data[N_PARAM];
-} bdf_prm = {{30, 64, 64, 256, 5*HZ, 30*HZ, 60, 0, 0}};
---------------------------------------------------------------
-
-int nfract:
-The first parameter governs the maximum number of dirty
-buffers in the buffer cache. Dirty means that the contents
-of the buffer still have to be written to disk (as opposed
-to a clean buffer, which can just be forgotten about).
-Setting this to a high value means that Linux can delay disk
-writes for a long time, but it also means that it will have
-to do a lot of I/O at once when memory becomes short. A low
-value will spread out disk I/O more evenly, at the cost of
-more frequent I/O operations.  The default value is 30%,
-the minimum is 0%, and the maximum is 100%.
-
-int interval:
-The fifth parameter, interval, is the minimum rate at
-which kupdate will wake and flush.  The value is expressed in
-jiffies (clockticks), the number of jiffies per second is
-normally 100 (Alpha is 1024). Thus, x*HZ is x seconds.  The
-default value is 5 seconds, the minimum is 0 seconds, and the
-maximum is 600 seconds.
-
-int age_buffer:
-The sixth parameter, age_buffer, governs the maximum time
-Linux waits before writing out a dirty buffer to disk.  The
-value is in jiffies.  The default value is 30 seconds,
-the minimum is 1 second, and the maximum 6,000 seconds.
-
-int nfract_sync:
-The seventh parameter, nfract_sync, governs the percentage
-of buffer cache that is dirty before bdflush activates
-synchronously.  This can be viewed as the hard limit before
-bdflush forces buffers to disk.  The default is 60%, the
-minimum is 0%, and the maximum is 100%.
- 
-==============================================================
-buffermem:
-
-The three values in this file correspond to the values in
-the struct buffer_mem. It controls how much memory should
-be used for buffer memory. The percentage is calculated
-as a percentage of total system memory.
-
-The values are:
-min_percent	-- this is the minimum percentage of memory
-		   that should be spent on buffer memory
-borrow_percent  -- UNUSED
-max_percent     -- UNUSED
-
-==============================================================
-freepages:
-
-This file contains the values in the struct freepages. That
-struct contains three members: min, low and high.
-
-The meaning of the numbers is:
-
-freepages.min	When the number of free pages in the system
-		reaches this number, only the kernel can
-		allocate more memory.
-freepages.low	If the number of free pages gets below this
-		point, the kernel starts swapping aggressively.
-freepages.high	The kernel tries to keep up to this amount of
-		memory free; if memory comes below this point,
-		the kernel gently starts swapping in the hopes
-		that it never has to do real aggressive swapping.
+See Documentation/filesystems/proc.txt
 
 ==============================================================
 
@@ -180,38 +92,3 @@ The number of pages the kernel reads in 
 2 ^ page-cluster. Values above 2 ^ 5 don't make much sense
 for swap because we only cluster swap data in 32-page groups.
 
-==============================================================
-
-pagecache:
-
-This file does exactly the same as buffermem, only this
-file controls the struct page_cache, and thus controls
-the amount of memory used for the page cache.
-
-In 2.2, the page cache is used for 3 main purposes:
-- caching read() data from files
-- caching mmap()ed data and executable files
-- swap cache
-
-When your system is both deep in swap and high on cache,
-it probably means that a lot of the swapped data is being
-cached, making for more efficient swapping than possible
-with the 2.0 kernel.
-
-==============================================================
-
-pagetable_cache:
-
-The kernel keeps a number of page tables in a per-processor
-cache (this helps a lot on SMP systems). The cache size for
-each processor will be between the low and the high value.
-
-On a low-memory, single CPU system you can safely set these
-values to 0 so you don't waste the memory. On SMP systems it
-is used so that the system can do fast pagetable allocations
-without having to acquire the kernel memory lock.
-
-For large systems, the settings are probably OK. For normal
-systems they won't hurt a bit. For small systems (<16MB ram)
-it might be advantageous to set both values to 0.
-

-
