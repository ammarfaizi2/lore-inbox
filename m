Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425426AbWLHLxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425426AbWLHLxv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 06:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425434AbWLHLxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 06:53:19 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52383 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425426AbWLHLwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 06:52:55 -0500
Message-Id: <200612081152.kB8BqOkh019750@shell0.pdx.osdl.net>
Subject: [patch 01/13] io-accounting: core statistics
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, balbir@in.ibm.com, csturtiv@sgi.com, daw@sgi.com,
       guillaume.thouvenin@bull.net, jlan@sgi.com, nagar@watson.ibm.com,
       tee@sgi.com
From: akpm@osdl.org
Date: Fri, 08 Dec 2006 03:52:24 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

The present per-task IO accounting isn't very useful.  It simply counts the
number of bytes passed into read() and write().  So if a process reads 1MB
from an already-cached file, it is accused of having performed 1MB of I/O,
which is wrong.

(David Wright had some comments on the applicability of the present logical IO accounting:

  For billing purposes it is useless but for workload analysis it is very
  useful

  read_bytes/read_calls  average read request size
  write_bytes/write_calls average write request size

  read_bytes/read_blocks ie logical/physical can indicate hit rate or thrashing
  write_bytes/write_blocks  ie logical/physical  guess since pdflush writes can
                                                be missed

  I often look for logical larger than physical to see filesystem cache
  problems.  And the bytes/cpusec can help find applications that are
  dominating the cache and causing slow interactive response from page cache
  contention.

  I want to find the IO intensive applications and make sure they are doing
  efficient IO.  Thus the acctcms(sysV) or csacms command would give the high
  IO commands).


This patchset adds new accounting which tries to be more accurate.  We account
for three things:

reads:

  attempt to count the number of bytes which this process really did cause
  to be fetched from the storage layer.  Done at the submit_bio() level, so it
  is accurate for block-backed filesystems.  I also attempt to wire up NFS and
  CIFS.

writes:

  attempt to count the number of bytes which this process caused to be sent
  to the storage layer.  This is done at page-dirtying time.

  The big inaccuracy here is truncate.  If a process writes 1MB to a file
  and then deletes the file, it will in fact perform no writeout.  But it will
  have been accounted as having caused 1MB of write.

  So...

cancelled_writes:

  account the number of bytes which this process caused to not happen, by
  truncating pagecache.

  We _could_ just subtract this from the process's `write' accounting.  But
  that means that some processes would be reported to have done negative
  amounts of write IO, which is silly.

  So we just report the raw number and punt this decision up to userspace.


Now, we _could_ account for writes at the physical I/O level.  But

- This would require that we track memory-dirtying tasks at the per-page
  level (would require a new pointer in struct page).

- It would mean that IO statistics for a process are usually only available
  long after that process has exitted.  Which means that we probably cannot
  communicate this info via taskstats.


This patch:

Wire up the kernel-private data structures and the accessor functions to
manipulate them.

Cc: Jay Lan <jlan@sgi.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Balbir Singh <balbir@in.ibm.com>
Cc: Chris Sturtivant <csturtiv@sgi.com>
Cc: Tony Ernst <tee@sgi.com>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: David Wright <daw@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/sched.h                  |    2 
 include/linux/task_io_accounting.h     |   37 ++++++++++++++++++
 include/linux/task_io_accounting_ops.h |   47 +++++++++++++++++++++++
 init/Kconfig                           |    9 ++++
 kernel/fork.c                          |    2 
 5 files changed, 97 insertions(+)

diff -puN include/linux/sched.h~io-accounting-core-statistics include/linux/sched.h
--- a/include/linux/sched.h~io-accounting-core-statistics
+++ a/include/linux/sched.h
@@ -82,6 +82,7 @@ struct sched_param {
 #include <linux/resource.h>
 #include <linux/timer.h>
 #include <linux/hrtimer.h>
+#include <linux/task_io_accounting.h>
 
 #include <asm/processor.h>
 
@@ -1010,6 +1011,7 @@ struct task_struct {
 	wait_queue_t *io_wait;
 /* i/o counters(bytes read/written, #syscalls */
 	u64 rchar, wchar, syscr, syscw;
+	struct task_io_accounting ioac;
 #if defined(CONFIG_TASK_XACCT)
 	u64 acct_rss_mem1;	/* accumulated rss usage */
 	u64 acct_vm_mem1;	/* accumulated virtual memory usage */
diff -puN /dev/null include/linux/task_io_accounting.h
--- /dev/null
+++ a/include/linux/task_io_accounting.h
@@ -0,0 +1,37 @@
+/*
+ * task_io_accounting: a structure which is used for recording a single task's
+ * IO statistics.
+ *
+ * Don't include this header file directly - it is designed to be dragged in via
+ * sched.h.
+ *
+ * Blame akpm@osdl.org for all this.
+ */
+
+#ifdef CONFIG_TASK_IO_ACCOUNTING
+struct task_io_accounting {
+	/*
+	 * The number of bytes which this task has caused to be read from
+	 * storage.
+	 */
+	u64 read_bytes;
+
+	/*
+	 * The number of bytes which this task has caused, or shall cause to be
+	 * written to disk.
+	 */
+	u64 write_bytes;
+
+	/*
+	 * A task can cause "negative" IO too.  If this task truncates some
+	 * dirty pagecache, some IO which another task has been accounted for
+	 * (in its write_bytes) will not be happening.  We _could_ just
+	 * subtract that from the truncating task's write_bytes, but there is
+	 * information loss in doing that.
+	 */
+	u64 cancelled_write_bytes;
+};
+#else
+struct task_io_accounting {
+};
+#endif
diff -puN /dev/null include/linux/task_io_accounting_ops.h
--- /dev/null
+++ a/include/linux/task_io_accounting_ops.h
@@ -0,0 +1,47 @@
+/*
+ * Task I/O accounting operations
+ */
+#ifndef __TASK_IO_ACCOUNTING_OPS_INCLUDED
+#define __TASK_IO_ACCOUNTING_OPS_INCLUDED
+
+#ifdef CONFIG_TASK_IO_ACCOUNTING
+static inline void task_io_account_read(size_t bytes)
+{
+	current->ioac.read_bytes += bytes;
+}
+
+static inline void task_io_account_write(size_t bytes)
+{
+	current->ioac.write_bytes += bytes;
+}
+
+static inline void task_io_account_cancelled_write(size_t bytes)
+{
+	current->ioac.cancelled_write_bytes += bytes;
+}
+
+static inline void task_io_accounting_init(struct task_struct *tsk)
+{
+	memset(&tsk->ioac, 0, sizeof(tsk->ioac));
+}
+
+#else
+
+static inline void task_io_account_read(size_t bytes)
+{
+}
+
+static inline void task_io_account_write(size_t bytes)
+{
+}
+
+static inline void task_io_account_cancelled_write(size_t bytes)
+{
+}
+
+static inline void task_io_accounting_init(struct task_struct *tsk)
+{
+}
+
+#endif		/* CONFIG_TASK_IO_ACCOUNTING */
+#endif		/* __TASK_IO_ACCOUNTING_OPS_INCLUDED */
diff -puN init/Kconfig~io-accounting-core-statistics init/Kconfig
--- a/init/Kconfig~io-accounting-core-statistics
+++ a/init/Kconfig
@@ -304,6 +304,15 @@ config TASK_XACCT
 
 	  Say N if unsure.
 
+config TASK_IO_ACCOUNTING
+	bool "Enable per-task storage I/O accounting (EXPERIMENTAL)"
+	depends on TASK_XACCT
+	help
+	  Collect information on the number of bytes of storage I/O which this
+	  task has caused.
+
+	  Say N if unsure.
+
 config SYSCTL
 	bool
 
diff -puN kernel/fork.c~io-accounting-core-statistics kernel/fork.c
--- a/kernel/fork.c~io-accounting-core-statistics
+++ a/kernel/fork.c
@@ -36,6 +36,7 @@
 #include <linux/syscalls.h>
 #include <linux/jiffies.h>
 #include <linux/futex.h>
+#include <linux/task_io_accounting_ops.h>
 #include <linux/rcupdate.h>
 #include <linux/ptrace.h>
 #include <linux/mount.h>
@@ -1055,6 +1056,7 @@ static struct task_struct *copy_process(
 	p->wchar = 0;		/* I/O counter: bytes written */
 	p->syscr = 0;		/* I/O counter: read syscalls */
 	p->syscw = 0;		/* I/O counter: write syscalls */
+	task_io_accounting_init(p);
 	acct_clear_integrals(p);
 
  	p->it_virt_expires = cputime_zero;
_
