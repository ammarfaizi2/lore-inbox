Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271289AbUJVMbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271289AbUJVMbE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 08:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271283AbUJVM2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 08:28:08 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:34707 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S271276AbUJVM0G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 08:26:06 -0400
Date: Fri, 22 Oct 2004 14:25:55 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 4/6] s390: debug feature system control.
Message-ID: <20041022122555.GE3720@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 4/6] s390: debug feature system control.

From: Christian Borntraeger <cborntra@de.ibm.com>

Debug feature changes:
 - Add system control to stop the debug feature.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 Documentation/s390/s390dbf.txt |   36 +++++++++++++++++++
 arch/s390/kernel/debug.c       |   77 ++++++++++++++++++++++++++++++++++++++++-
 arch/s390/kernel/traps.c       |    7 ++-
 include/asm-s390/debug.h       |    2 +
 4 files changed, 119 insertions(+), 3 deletions(-)

diff -urN linux-2.6/arch/s390/kernel/debug.c linux-2.6-patched/arch/s390/kernel/debug.c
--- linux-2.6/arch/s390/kernel/debug.c	2004-10-18 23:53:21.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/debug.c	2004-10-22 13:51:45.000000000 +0200
@@ -16,6 +16,7 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/ctype.h>
+#include <linux/sysctl.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 
@@ -708,6 +709,70 @@
 		proceed_active_area(id);
 }
 
+static int debug_stoppable=1;
+static int debug_active=1;
+
+#define CTL_S390DBF 5677
+#define CTL_S390DBF_STOPPABLE 5678
+#define CTL_S390DBF_ACTIVE 5679
+
+/*
+ * proc handler for the running debug_active sysctl
+ * always allow read, allow write only if debug_stoppable is set or
+ * if debug_active is already off
+ */
+static int s390dbf_procactive(ctl_table *table, int write, struct file *filp,
+                     void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	if (!write || debug_stoppable || !debug_active)
+		return proc_dointvec(table, write, filp, buffer, lenp, ppos);
+	else
+		return 0;
+}
+
+
+static struct ctl_table s390dbf_table[] = {
+	{
+		.ctl_name       = CTL_S390DBF_STOPPABLE,
+		.procname       = "debug_stoppable",
+		.data		= &debug_stoppable,
+		.maxlen		= sizeof(int),
+		.mode           = S_IRUGO | S_IWUSR,
+		.proc_handler   = &proc_dointvec,
+		.strategy	= &sysctl_intvec,
+	},
+	 {
+		.ctl_name       = CTL_S390DBF_ACTIVE,
+		.procname       = "debug_active",
+		.data		= &debug_active,
+		.maxlen		= sizeof(int),
+		.mode           = S_IRUGO | S_IWUSR,
+		.proc_handler   = &s390dbf_procactive,
+		.strategy	= &sysctl_intvec,
+	},
+	{ .ctl_name = 0 }
+};
+
+static struct ctl_table s390dbf_dir_table[] = {
+	{
+		.ctl_name       = CTL_S390DBF,
+		.procname       = "s390dbf",
+		.maxlen         = 0,
+		.mode           = S_IRUGO | S_IXUGO,
+		.child          = s390dbf_table,
+	},
+	{ .ctl_name = 0 }
+};
+
+struct ctl_table_header *s390dbf_sysctl_header;
+
+void debug_stop_all(void)
+{
+	if (debug_stoppable)
+		debug_active = 0;
+}
+
+
 /*
  * debug_event_common:
  * - write debug entry with given size
@@ -719,6 +784,8 @@
 	unsigned long flags;
 	debug_entry_t *active;
 
+	if (!debug_active)
+		return NULL;
 	spin_lock_irqsave(&id->lock, flags);
 	active = get_active_entry(id);
 	memset(DEBUG_DATA(active), 0, id->buf_size);
@@ -740,6 +807,8 @@
 	unsigned long flags;
 	debug_entry_t *active;
 
+	if (!debug_active)
+		return NULL;
 	spin_lock_irqsave(&id->lock, flags);
 	active = get_active_entry(id);
 	memset(DEBUG_DATA(active), 0, id->buf_size);
@@ -780,7 +849,8 @@
 
 	if((!id) || (level > id->level))
 		return NULL;
-
+	if (!debug_active)
+		return NULL;
 	numargs=debug_count_numargs(string);
 
 	spin_lock_irqsave(&id->lock, flags);
@@ -812,6 +882,8 @@
 
 	if((!id) || (level > id->level))
 		return NULL;
+	if (!debug_active)
+		return NULL;
 
 	numargs=debug_count_numargs(string);
 
@@ -838,6 +910,7 @@
 {
 	int rc = 0;
 
+	s390dbf_sysctl_header = register_sysctl_table(s390dbf_dir_table, 1);
 	down(&debug_lock);
 #ifdef CONFIG_PROC_FS
 	debug_proc_root_entry = proc_mkdir(DEBUG_DIR_ROOT, NULL);
@@ -1186,6 +1259,7 @@
 #ifdef CONFIG_PROC_FS
 	remove_proc_entry(debug_proc_root_entry->name, NULL);
 #endif /* CONFIG_PROC_FS */
+	unregister_sysctl_table(s390dbf_sysctl_header);
 	return;
 }
 
@@ -1199,6 +1273,7 @@
 EXPORT_SYMBOL(debug_register);
 EXPORT_SYMBOL(debug_unregister); 
 EXPORT_SYMBOL(debug_set_level);
+EXPORT_SYMBOL(debug_stop_all);
 EXPORT_SYMBOL(debug_register_view);
 EXPORT_SYMBOL(debug_unregister_view);
 EXPORT_SYMBOL(debug_event_common);
diff -urN linux-2.6/arch/s390/kernel/traps.c linux-2.6-patched/arch/s390/kernel/traps.c
--- linux-2.6/arch/s390/kernel/traps.c	2004-10-18 23:53:46.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/traps.c	2004-10-22 13:51:45.000000000 +0200
@@ -38,6 +38,7 @@
 #include <asm/cpcmd.h>
 #include <asm/s390_ext.h>
 #include <asm/lowcore.h>
+#include <asm/debug.h>
 
 /* Called from entry.S only */
 extern void handle_per_exception(struct pt_regs *regs);
@@ -277,8 +278,10 @@
 void die(const char * str, struct pt_regs * regs, long err)
 {
 	static int die_counter;
-        console_verbose();
-        spin_lock_irq(&die_lock);
+
+	debug_stop_all();
+	console_verbose();
+	spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
 	printk("%s: %04lx [#%d]\n", str, err & 0xffff, ++die_counter);
         show_regs(regs);
diff -urN linux-2.6/Documentation/s390/s390dbf.txt linux-2.6-patched/Documentation/s390/s390dbf.txt
--- linux-2.6/Documentation/s390/s390dbf.txt	2004-10-18 23:54:39.000000000 +0200
+++ linux-2.6-patched/Documentation/s390/s390dbf.txt	2004-10-22 13:51:45.000000000 +0200
@@ -78,6 +78,23 @@
 
 > echo "-" > /proc/s390dbf/dasd/level
 
+It is also possible to deactivate the debug feature globally for every
+debug log. You can change the behavior using  2 sysctl parameters in
+/proc/sys/s390dbf:
+There are currently 2 possible triggers, which stop the  debug feature
+globally. The first possbility is to use the "debug_active" sysctl. If
+set to 1 the debug feature is running. If "debug_active" is set to 0 the
+debug feature is turned off.
+The second trigger which stops the debug feature is an kernel oops.
+That prevents the debug feature from overwriting debug information that
+happened before the oops. After an oops you can reactivate the debug feature
+by piping 1 to /proc/sys/s390dbf/debug_active. Nevertheless, its not
+suggested to use an oopsed kernel in an production environment.
+If you want to disallow the deactivation of the debug feature, you can use
+the "debug_stoppable" sysctl. If you set "debug_stoppable" to 0 the debug
+feature cannot be stopped. If the debug feature is already stopped, it
+will stay deactivated.
+
 Kernel Interfaces:
 ------------------
 
@@ -115,6 +132,17 @@
 Return Value:  none 
 
 Description:   Sets new actual debug level if new_level is valid. 
+
+---------------------------------------------------------------------------
++void debug_stop_all(void);
+
+Parameter:     none
+
+Return Value:  none
+
+Description:   stops the debug feature if stopping is allowed. Currently
+               used in case of a kernel oops.
+
 ---------------------------------------------------------------------------
 debug_entry_t* debug_event (debug_info_t* id, int level, void* data, 
                             int length);
@@ -377,6 +405,15 @@
 2. Flush all debug areas:
 > echo "-" > /proc/s390dbf/dasd/flush
 
+Stooping the debug feature
+--------------------------
+Example:
+
+1. Check if stopping is allowed
+> cat /proc/sys/s390dbf/debug_stoppable
+2. Stop debug feature
+> echo 0 > /proc/sys/s390dbf/debug_active
+
 lcrash Interface
 ----------------
 It is planned that the dump analysis tool lcrash gets an additional command
diff -urN linux-2.6/include/asm-s390/debug.h linux-2.6-patched/include/asm-s390/debug.h
--- linux-2.6/include/asm-s390/debug.h	2004-10-18 23:54:29.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/debug.h	2004-10-22 13:51:45.000000000 +0200
@@ -127,6 +127,8 @@
 
 void debug_set_level(debug_info_t* id, int new_level);
 
+void debug_stop_all(void);
+
 extern inline debug_entry_t* 
 debug_event(debug_info_t* id, int level, void* data, int length)
 {
