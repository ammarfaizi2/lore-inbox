Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVFBNTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVFBNTY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 09:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVFBNQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 09:16:54 -0400
Received: from fmr24.intel.com ([143.183.121.16]:61103 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261413AbVFBNKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 09:10:36 -0400
Date: Thu, 2 Jun 2005 06:09:26 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: linux-kernel@vger.kernel.org
Cc: rusty@rustycorp.com.au, vatsa@in.ibm.com, ak@muc.de,
       zwane@arm.linux.org.uk, akpm@osdl.org
Subject: Primitive interface to check IPI broadcast v.s mask in flat mode.
Message-ID: <20050602060926.A9222@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch applies on top of 5 patches submitted for x86-64 cpu hotplug.

NOTE: Not for -mm.

Cheers,
Ashok Raj

This patch provides a primitive interface to switch mask to 
broadcast version of IPI use. Also provides the following interfaces.

#echo "max_iters=100"  > /proc/ipi -- set number of iterations
#echo "curr_mode=1" > /proc/ipi    -- set 1: broadcast 0: mask version
#echo "start" > /proc/ipi	   -- do the test and print results.

dmesg | tail -1 should give avg numbers for last run.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
----------------------------------------------------
 arch/x86_64/kernel/genapic_flat.c |  136 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 135 insertions(+), 1 deletion(-)

Index: linux-2.6.12-rc5-mm2/arch/x86_64/kernel/genapic_flat.c
===================================================================
--- linux-2.6.12-rc5-mm2.orig/arch/x86_64/kernel/genapic_flat.c
+++ linux-2.6.12-rc5-mm2/arch/x86_64/kernel/genapic_flat.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <asm/smp.h>
 #include <asm/ipi.h>
+#include <asm/uaccess.h>
 
 /*
  * The following permit choosing broadcast IPI shortcut v.s sending IPI only
@@ -202,10 +203,143 @@ struct genapic apic_flat =  {
 	.phys_pkg_id = phys_pkg_id,
 };
 
-int print_ipi_mode(void)
+#define MAX_IPI_ITERS	10000
+static int ipi_tip; 	/* Test in Progress */
+static int max_iters = 5;
+static int curr_mode = 1;
+
+static struct ipi_stat_tsc {
+	unsigned long long start_tsc;
+	unsigned long long end_tsc;
+} ipi_stat [MAX_IPI_ITERS];
+
+#include <linux/fs.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+
+static int ipi_test_read_proc(char *page, char **start, off_t off,
+                  int count, int *eof, void *data)
+{
+	int len;
+
+	len = sprintf (page, "Current test iterations = %d\n", max_iters);
+	len += sprintf (page+len, no_broadcast ? "Mask\n" : "Broadcast\n");
+	len += sprintf (page+len, ipi_tip ? "Test in progress\n" : "Test Idle\n");
+
+	return len;
+}
+
+void
+ipi_dummy(void *ptr)
+{
+}
+
+void
+print_ipi_stats(void)
+{
+	int i;
+	unsigned long long sum, min, max;
+
+	min = ~0;
+	max = 0;
+	sum = 0;
+	for (i=0; i<max_iters; i++) {
+		unsigned long long diff;
+
+		diff = ipi_stat[i].end_tsc - ipi_stat[i].start_tsc;
+
+		min = (min < diff ? min : diff);
+		max = (max > diff ? max : diff);
+		sum += diff;
+
+		printk ("[%d] start: %llx end: %llx diff: %llx\n",
+			i, ipi_stat[i].start_tsc, ipi_stat[i].end_tsc,
+			ipi_stat[i].end_tsc - ipi_stat[i].start_tsc);
+	}
+
+	printk ("Avg = %llx, Min = %llx, Max = %llx\n", sum/max_iters, min, max);
+}
+
+static void
+do_ipi_test(void)
+{
+	int i;
+
+	memset(&ipi_stat[0], 0, sizeof(ipi_stat));
+	ipi_tip = 1;
+	for (i=0; i<max_iters;i++) {
+		rdtscll(ipi_stat[i].start_tsc);
+		smp_call_function(ipi_dummy, NULL, 0, 1);
+		rdtscll(ipi_stat[i].end_tsc);
+	}
+	ipi_tip = 0;
+	print_ipi_stats();
+	memset(&ipi_stat[0], 0, sizeof(ipi_stat));
+}
+
+static int ipi_test_write_proc(struct file *file, const char __user *buffer,
+		unsigned long count, void *data)
+{
+	char cmd[512];
+	size_t size;
+	int retval, num = 0;
+	int mode;
+
+	printk ("In test_write\n");
+	size = sizeof(cmd);
+	if (count < size)
+		size = count;
+
+	if (copy_from_user(cmd, buffer, size))
+		return -EFAULT;
+
+	if (!strncmp(cmd, "start", 5)) {
+		printk ("Got start command\n");
+		do_ipi_test();
+	} else {
+		retval = sscanf(cmd, "max_iters=%d", &num);
+		if (retval == 1) {
+			if (num > MAX_IPI_ITERS) {
+				printk ("Cannot be more than %d entries\n", MAX_IPI_ITERS);
+				printk ("Leaving entries at %d\n", max_iters);
+			} else {
+				printk ("Setting max_iters = %d\n", num);
+				max_iters = num;
+			}
+		} else {
+			retval = sscanf(cmd, "curr_mode=%d", &mode);
+			if (retval == 1) {
+				printk ("Setting mode to %s\n", mode ? "broadcast" : "mask");
+				curr_mode = mode;
+				lock_ipi_call_lock();
+				no_broadcast = mode ? 0 : 1;
+				unlock_ipi_call_lock();
+			}
+		}
+	}
+
+	return count;
+}
+
+void __init ipi_test_proc_init(void)
+{
+	struct proc_dir_entry *entry = NULL;
+
+	entry = create_proc_entry("ipi", 0600, NULL);
+
+	if (entry) {
+		entry->read_proc = ipi_test_read_proc;
+		entry->write_proc = ipi_test_write_proc;
+	}
+
+	printk ("Initialized ipi_proc interface\n");
+}
+
+int __init print_ipi_mode(void)
 {
 	printk ("Using IPI %s mode\n", no_broadcast ? "No-Shortcut" :
 											"Shortcut");
+	ipi_test_proc_init();
 	return 0;
 }
 
-- 
Cheers,
Ashok Raj
- Open Source Technology Center
