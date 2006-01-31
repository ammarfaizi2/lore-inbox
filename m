Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWAaTIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWAaTIs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 14:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWAaTIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 14:08:48 -0500
Received: from cantor2.suse.de ([195.135.220.15]:30401 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751393AbWAaTIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 14:08:47 -0500
From: Chris Mason <mason@suse.com>
To: Dave Jones <davej@redhat.com>
Subject: Re: 2.6.16rc1-git4 slab corruption.
Date: Tue, 31 Jan 2006 14:08:35 -0500
User-Agent: KMail/1.9.1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060131180319.GA18948@redhat.com>
In-Reply-To: <20060131180319.GA18948@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601311408.35771.mason@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 January 2006 13:03, Dave Jones wrote:
> Redzone: 0x5a2cf071/0x5a2cf071.
> Last user: [<ffffffff80181cc0>](free_buffer_head+0x2a/0x43)

Haven't seen this one yet, but we have an assortment of strange bugs on 2.6.16-rc1-git.  What were you doing to trigger it?

I've been trying to hammer on things with the slab exerciser below, but haven't had much luck in getting a nice reliable test case.

modprobe crasher threads=X

X defaults to 1.

-chris

diff -r abc01241b9e0 drivers/char/Kconfig
--- a/drivers/char/Kconfig	Tue Jan 24 15:03:39 2006 -0500
+++ b/drivers/char/Kconfig	Wed Jan 25 08:03:06 2006 -0500
@@ -1020,5 +1020,10 @@ config TELCLOCK
 	  sysfs directory, /sys/devices/platform/telco_clock, with a number of
 	  files for controlling the behavior of this hardware.
 
+config CRASHER
+	tristate "Crasher Module"
+	help
+	  Slab cache memory tester.  Only use this as a module
+
 endmenu
 
diff -r abc01241b9e0 drivers/char/Makefile
--- a/drivers/char/Makefile	Tue Jan 24 15:03:39 2006 -0500
+++ b/drivers/char/Makefile	Wed Jan 25 08:03:06 2006 -0500
@@ -95,6 +95,7 @@ obj-$(CONFIG_IPMI_HANDLER) += ipmi/
 
 obj-$(CONFIG_HANGCHECK_TIMER) += hangcheck-timer.o
 obj-$(CONFIG_TCG_TPM) += tpm/
+obj-$(CONFIG_CRASHER) += crasher.o
 # Files generated that shall be removed upon make clean
 clean-files := consolemap_deftbl.c defkeymap.c qtronixmap.c
 
diff -r abc01241b9e0 drivers/char/crasher.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/char/crasher.c	Wed Jan 25 08:03:06 2006 -0500
@@ -0,0 +1,148 @@
+/*
+ * crasher.c, it breaks things
+ */
+
+
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/moduleparam.h>
+
+static int module_exiting;
+static struct completion startup = COMPLETION_INITIALIZER(startup);
+static unsigned long rand_seed = 152L;
+static unsigned long seed = 152L;
+static int threads = 1;
+
+module_param(seed, ulong, 0);
+module_param(threads, int, 0);
+MODULE_PARM_DESC(seed, "random seed for memory tests");
+MODULE_PARM_DESC(threads, "number of threads to run");
+MODULE_LICENSE("GPL");
+
+#define NUM_ALLOC 24
+#define NUM_SIZES 8
+static int sizes[]  = { 32, 64, 128, 192, 256, 1024, 2048, 4096 };
+
+struct mem_buf {
+    char *buf;
+    int size;
+};
+
+static unsigned long crasher_random(void)
+{
+        rand_seed = rand_seed*69069L+1;
+        return rand_seed^jiffies;
+}
+
+void crasher_srandom(unsigned long entropy)
+{
+        rand_seed ^= entropy;
+        crasher_random();
+}
+
+static char *mem_alloc(int size) {
+	char *p = kmalloc(size, GFP_KERNEL);
+	int i;
+	if (!p)
+		return p;
+	for (i = 0 ; i < size; i++)
+		p[i] = (i % 119) + 8;
+	return p;
+}
+
+static void mem_check(char *p, int size) {
+	int i;
+	if (!p) 
+		return;
+	for (i = 0 ; i < size; i++) {
+        	if (p[i] != ((i % 119) + 8)) {
+			printk(KERN_CRIT "verify error at %lX offset %d " 
+			       " wanted %d found %d size %d\n", 
+			       (unsigned long)(p + i), i, (i % 119) + 8, 
+			       p[i], size);
+		}
+	}
+	// try and trigger slab poisoning for people using this buffer
+	// wrong
+	memset(p, 0, size);
+}
+
+static void mem_verify(void) {
+	struct mem_buf bufs[NUM_ALLOC];
+	struct mem_buf *b;
+	int index;
+	int size;
+	unsigned long sleep;
+	memset(bufs, 0, sizeof(struct mem_buf) * NUM_ALLOC);
+	while(!module_exiting) {
+		index = crasher_random() % NUM_ALLOC;
+		b = bufs + index;
+		if (b->size) {
+			mem_check(b->buf, b->size);
+			kfree(b->buf);
+			b->buf = NULL;
+			b->size = 0;
+		} else {
+			size = crasher_random() % NUM_SIZES;
+			size = sizes[size];
+			b->buf = mem_alloc(size);
+			b->size = size;
+		}
+		sleep = crasher_random() % (HZ / 10);
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(sleep);
+		set_current_state(TASK_RUNNING);
+	}
+	for (index = 0 ; index < NUM_ALLOC ; index++) {
+		b = bufs + index;
+		if (b->size) {
+			mem_check(b->buf, b->size);
+			kfree(b->buf);
+		}
+	}
+}
+
+static int crasher_thread(void *unused) 
+{
+	daemonize("crasher");
+	complete(&startup);
+	mem_verify();
+	complete(&startup);
+	return 0;
+}
+
+static int __init crasher_init(void)
+{
+	int i;
+	init_completion(&startup);
+	crasher_srandom(seed);
+
+	printk("crasher module (%d threads).  Testing sizes: ", threads);
+	for (i = 0 ; i < NUM_SIZES ; i++)
+		printk("%d ", sizes[i]);
+	printk("\n");
+
+	for (i = 0 ; i < threads ; i++) 
+		kernel_thread(crasher_thread, crasher_thread, 
+			      CLONE_FS | CLONE_FILES);
+	for (i = 0 ; i < threads ; i++) 
+		wait_for_completion(&startup);
+	return 0;
+}
+
+static void __exit crasher_exit(void)
+{
+	int i;
+	module_exiting = 1;
+	for (i = 0 ; i < threads ; i++) 
+		wait_for_completion(&startup);
+	printk("all crasher threads done\n");
+	return;
+}
+
+module_init(crasher_init);
+module_exit(crasher_exit);
