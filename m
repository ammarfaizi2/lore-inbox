Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTKYAQp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 19:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbTKYAQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 19:16:45 -0500
Received: from ms-smtp-02-qfe0.nyroc.rr.com ([24.24.2.56]:12729 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261872AbTKYAQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 19:16:37 -0500
Subject: Re: What exactly are the issues with 2.6.0-test10 preempt?
From: Chris Mason <mason@suse.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031125000526.GD28026@wotan.suse.de>
References: <20031124224514.56242.qmail@web40908.mail.yahoo.com.suse.lists.linux.kernel>
	 <Pine.LNX.4.58.0311241452550.15101@home.osdl.org.suse.lists.linux.kernel>
	 <p733ccdpbra.fsf@oldwotan.suse.de>
	 <20031125000002.GB1586@mis-mike-wstn.matchmail.com>
	 <20031125000526.GD28026@wotan.suse.de>
Content-Type: multipart/mixed; boundary="=-s0rgfe5muxPDBApsIY7p"
Message-Id: <1069719401.18795.157.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 24 Nov 2003 19:16:42 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-s0rgfe5muxPDBApsIY7p
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2003-11-24 at 19:05, Andi Kleen wrote:
> > > Me and Chris used that to track down some nasty corruptions on x86-64,
> > > it is especially useful together with LTP which calls a lot of system
> > > calls that could cause corruption.
> > 
> > Do you have your code posted anywhere, and when are you going to merge it
> > with LTP? ;)
> 
> I wrote it always custom tailored to the problem (it is not very difficult, but
> you often have to tune it a bit until it has the right frequency to find the
> corruption) Don't have one here right now, sorry.  Chris had a aimed to be 
> generic patch for 2.4 that may still be around. I don't think it would fit 
> into current LTP because it is an kernel module (LTP doesn't have a kernel build 
> infrastructure right now).  But it would be an useful addition longer term to it 
> I agree, once they support kernel modules.

Here's my 2.4 patch, which was actually against the suse kernel so you
might get fuzz/rejects for Config.in and the drivers/char/Makefile

It's fairly simple, just put the slab sizes you want into the sizes
array in crasher.c

2.6 port won't be hard, if people are interested, I'll do it after
Thanksgiving.

-chris


--=-s0rgfe5muxPDBApsIY7p
Content-Disposition: attachment; filename=crasher-2.diff
Content-Type: text/x-patch; name=crasher-2.diff; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

diff -ur linux.suse.1/drivers/char/Config.in linux.suse/drivers/char/Config.in
--- linux.suse.1/drivers/char/Config.in	2003-10-08 09:17:39.000000000 -0400
+++ linux.suse/drivers/char/Config.in	2003-10-07 11:04:56.000000000 -0400
@@ -357,4 +357,6 @@
    tristate 'ACP Modem (Mwave) support' CONFIG_MWAVE
 fi
 
+tristate 'Crashing module' CONFIG_CRASHER
+
 endmenu
diff -ur linux.suse.1/drivers/char/Makefile linux.suse/drivers/char/Makefile
--- linux.suse.1/drivers/char/Makefile	2003-10-08 09:17:39.000000000 -0400
+++ linux.suse/drivers/char/Makefile	2003-10-07 11:04:56.000000000 -0400
@@ -294,6 +294,7 @@
 obj-$(CONFIG_MIXCOMWD) += mixcomwd.o
 obj-$(CONFIG_DEADMAN) += deadman.o
 obj-$(CONFIG_HANGCHECK_TIMER) += hangcheck-timer.o
+obj-$(CONFIG_CRASHER) += crasher.o
 obj-$(CONFIG_60XX_WDT) += sbc60xxwdt.o
 obj-$(CONFIG_W83877F_WDT) += w83877f_wdt.o
 obj-$(CONFIG_SC520_WDT) += sc520_wdt.o
diff -ur linux.suse.1/drivers/char/crasher.c linux.suse/drivers/char/crasher.c
--- linux.suse.1/drivers/char/crasher.c	2003-10-08 09:18:20.000000000 -0400
+++ linux.suse/drivers/char/crasher.c	2003-10-07 11:40:07.000000000 -0400
@@ -0,0 +1,145 @@
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
+
+static int module_exiting;
+static struct completion startup = COMPLETION_INITIALIZER(startup);
+
+MODULE_PARM_DESC(seed, "random seed for memory tests");
+MODULE_LICENSE("GPL");
+
+static unsigned long rand_seed = 152L;
+
+#define NUM_ALLOC 24
+#define NUM_SIZES 3
+static int sizes[]  = { 128, 256, 4096 };
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
+}
+
+static void mem_verify(void) {
+	struct mem_buf bufs[NUM_ALLOC];
+	struct mem_buf *b;
+	int index;
+	int size;
+	unsigned long sleep;
+	crasher_srandom(rand_seed);
+
+	printk("crasher module memory testing, sizes: ");
+	for (index = 0 ; index < NUM_SIZES ; index++)
+		printk("%d ", sizes[index]);
+	printk("\n");
+
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
+	printk("crasher done\n");
+}
+
+static int crasher_thread(void *unused) {
+
+	struct task_struct *tsk = current;
+
+	daemonize();
+	strcpy(tsk->comm, "crasher");
+
+        /* avoid getting signals */
+        spin_lock_irq(&tsk->sigmask_lock);
+        flush_signals(tsk);
+        sigfillset(&tsk->blocked);
+        recalc_sigpending(tsk);
+        spin_unlock_irq(&tsk->sigmask_lock);
+
+	complete(&startup);
+	mem_verify();
+	complete(&startup);
+	return 0;
+}
+static int __init crasher_init(void)
+{
+	kernel_thread(crasher_thread, crasher_thread, CLONE_FS | CLONE_FILES | 
+	              CLONE_SIGNAL) ;
+
+	wait_for_completion(&startup);
+	return 0;
+}
+
+static void __exit crasher_exit(void)
+{
+	module_exiting = 1;
+	wait_for_completion(&startup);
+	return;
+}
+
+module_init(crasher_init);
+module_exit(crasher_exit);

--=-s0rgfe5muxPDBApsIY7p--

