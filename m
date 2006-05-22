Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751573AbWEVD4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbWEVD4v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 23:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbWEVD4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 23:56:50 -0400
Received: from xenotime.net ([66.160.160.81]:13527 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751195AbWEVD4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 23:56:32 -0400
Date: Sun, 21 May 2006 20:57:57 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, prasanna@in.ibm.com
Subject: [PATCH 14/14/] Doc. sources: expose kprobes
Message-Id: <20060521205757.e954b09e.rdunlap@xenotime.net>
In-Reply-To: <20060521203349.40b40930.rdunlap@xenotime.net>
References: <20060521203349.40b40930.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Documentation/kprobes.txt:
Expose example and tool source files in the Documentation/ directory in
their own files instead of being buried (almost hidden) in readme/txt files.

This will make them more visible/usable to users who may need
to use them, to developers who may need to test with them, and
to janitors who would update them if they were more visible.

Also, if any of these possibly should not be in the kernel tree at
all, it will be clearer that they are here and we can discuss if
they should be removed.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/jprobe-example.c    |   60 ++++++++++++
 Documentation/kprobe-example.c    |   69 ++++++++++++++
 Documentation/kprobes.txt         |  182 --------------------------------------
 Documentation/kretprobe-example.c |   57 +++++++++++
 4 files changed, 189 insertions(+), 179 deletions(-)

--- /dev/null
+++ linux-2617-rc4g9-docsrc-split/Documentation/jprobe-example.c
@@ -0,0 +1,60 @@
+/*jprobe-example.c */
+/*
+ * Here's a sample kernel module showing the use of jprobes to dump
+ * the arguments of do_fork().
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/uio.h>
+#include <linux/kprobes.h>
+#include <linux/kallsyms.h>
+
+/*
+ * Jumper probe for do_fork.
+ * Mirror principle enables access to arguments of the probed routine
+ * from the probe handler.
+ */
+
+/* Proxy routine having the same arguments as actual do_fork() routine */
+long jdo_fork(unsigned long clone_flags, unsigned long stack_start,
+	      struct pt_regs *regs, unsigned long stack_size,
+	      int __user * parent_tidptr, int __user * child_tidptr)
+{
+	printk("jprobe: clone_flags=0x%lx, stack_size=0x%lx, regs=0x%p\n",
+	       clone_flags, stack_size, regs);
+	/* Always end with a call to jprobe_return(). */
+	jprobe_return();
+	/*NOTREACHED*/
+	return 0;
+}
+
+static struct jprobe my_jprobe = {
+	.entry = (kprobe_opcode_t *) jdo_fork
+};
+
+int init_module(void)
+{
+	int ret;
+	my_jprobe.kp.addr = (kprobe_opcode_t *) kallsyms_lookup_name("do_fork");
+	if (!my_jprobe.kp.addr) {
+		printk("Couldn't find %s to plant jprobe\n", "do_fork");
+		return -1;
+	}
+
+	if ((ret = register_jprobe(&my_jprobe)) <0) {
+		printk("register_jprobe failed, returned %d\n", ret);
+		return -1;
+	}
+	printk("Planted jprobe at %p, handler addr %p\n",
+	       my_jprobe.kp.addr, my_jprobe.entry);
+	return 0;
+}
+
+void cleanup_module(void)
+{
+	unregister_jprobe(&my_jprobe);
+	printk("jprobe unregistered\n");
+}
+
+MODULE_LICENSE("GPL");
--- /dev/null
+++ linux-2617-rc4g9-docsrc-split/Documentation/kprobe-example.c
@@ -0,0 +1,69 @@
+/*kprobe-example.c*/
+/*
+ * Here's a sample kernel module showing the use of kprobes to dump a
+ * stack trace and selected i386 registers when do_fork() is called.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/kprobes.h>
+#include <linux/kallsyms.h>
+#include <linux/sched.h>
+
+/*For each probe you need to allocate a kprobe structure*/
+static struct kprobe kp;
+
+/*kprobe pre_handler: called just before the probed instruction is executed*/
+int handler_pre(struct kprobe *p, struct pt_regs *regs)
+{
+	printk("pre_handler: p->addr=0x%p, eip=%lx, eflags=0x%lx\n",
+		p->addr, regs->eip, regs->eflags);
+	dump_stack();
+	return 0;
+}
+
+/*kprobe post_handler: called after the probed instruction is executed*/
+void handler_post(struct kprobe *p, struct pt_regs *regs, unsigned long flags)
+{
+	printk("post_handler: p->addr=0x%p, eflags=0x%lx\n",
+		p->addr, regs->eflags);
+}
+
+/* fault_handler: this is called if an exception is generated for any
+ * instruction within the pre- or post-handler, or when Kprobes
+ * single-steps the probed instruction.
+ */
+int handler_fault(struct kprobe *p, struct pt_regs *regs, int trapnr)
+{
+	printk("fault_handler: p->addr=0x%p, trap #%dn",
+		p->addr, trapnr);
+	/* Return 0 because we don't handle the fault. */
+	return 0;
+}
+
+int init_module(void)
+{
+	int ret;
+	kp.pre_handler = handler_pre;
+	kp.post_handler = handler_post;
+	kp.fault_handler = handler_fault;
+	kp.addr = (kprobe_opcode_t*) kallsyms_lookup_name("do_fork");
+	/* register the kprobe now */
+	if (!kp.addr) {
+		printk("Couldn't find %s to plant kprobe\n", "do_fork");
+		return -1;
+	}
+	if ((ret = register_kprobe(&kp) < 0)) {
+		printk("register_kprobe failed, returned %d\n", ret);
+		return -1;
+	}
+	printk("kprobe registered\n");
+	return 0;
+}
+
+void cleanup_module(void)
+{
+	unregister_kprobe(&kp);
+	printk("kprobe unregistered\n");
+}
+
+MODULE_LICENSE("GPL");
--- linux-2617-rc4g9-docsrc-split.orig/Documentation/kprobes.txt
+++ linux-2617-rc4g9-docsrc-split/Documentation/kprobes.txt
@@ -364,73 +364,8 @@ e. Watchpoint probes (which fire on data
 
 Here's a sample kernel module showing the use of kprobes to dump a
 stack trace and selected i386 registers when do_fork() is called.
------ cut here -----
-/*kprobe_example.c*/
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/kprobes.h>
-#include <linux/kallsyms.h>
-#include <linux/sched.h>
-
-/*For each probe you need to allocate a kprobe structure*/
-static struct kprobe kp;
-
-/*kprobe pre_handler: called just before the probed instruction is executed*/
-int handler_pre(struct kprobe *p, struct pt_regs *regs)
-{
-	printk("pre_handler: p->addr=0x%p, eip=%lx, eflags=0x%lx\n",
-		p->addr, regs->eip, regs->eflags);
-	dump_stack();
-	return 0;
-}
-
-/*kprobe post_handler: called after the probed instruction is executed*/
-void handler_post(struct kprobe *p, struct pt_regs *regs, unsigned long flags)
-{
-	printk("post_handler: p->addr=0x%p, eflags=0x%lx\n",
-		p->addr, regs->eflags);
-}
-
-/* fault_handler: this is called if an exception is generated for any
- * instruction within the pre- or post-handler, or when Kprobes
- * single-steps the probed instruction.
- */
-int handler_fault(struct kprobe *p, struct pt_regs *regs, int trapnr)
-{
-	printk("fault_handler: p->addr=0x%p, trap #%dn",
-		p->addr, trapnr);
-	/* Return 0 because we don't handle the fault. */
-	return 0;
-}
-
-int init_module(void)
-{
-	int ret;
-	kp.pre_handler = handler_pre;
-	kp.post_handler = handler_post;
-	kp.fault_handler = handler_fault;
-	kp.addr = (kprobe_opcode_t*) kallsyms_lookup_name("do_fork");
-	/* register the kprobe now */
-	if (!kp.addr) {
-		printk("Couldn't find %s to plant kprobe\n", "do_fork");
-		return -1;
-	}
-	if ((ret = register_kprobe(&kp) < 0)) {
-		printk("register_kprobe failed, returned %d\n", ret);
-		return -1;
-	}
-	printk("kprobe registered\n");
-	return 0;
-}
-
-void cleanup_module(void)
-{
-	unregister_kprobe(&kp);
-	printk("kprobe unregistered\n");
-}
+See Documentation/kprobe-example.c
 
-MODULE_LICENSE("GPL");
------ cut here -----
 
 You can build the kernel module, kprobe-example.ko, using the following
 Makefile:
@@ -456,64 +391,7 @@ whenever do_fork() is invoked to create 
 
 Here's a sample kernel module showing the use of jprobes to dump
 the arguments of do_fork().
------ cut here -----
-/*jprobe-example.c */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/fs.h>
-#include <linux/uio.h>
-#include <linux/kprobes.h>
-#include <linux/kallsyms.h>
-
-/*
- * Jumper probe for do_fork.
- * Mirror principle enables access to arguments of the probed routine
- * from the probe handler.
- */
-
-/* Proxy routine having the same arguments as actual do_fork() routine */
-long jdo_fork(unsigned long clone_flags, unsigned long stack_start,
-	      struct pt_regs *regs, unsigned long stack_size,
-	      int __user * parent_tidptr, int __user * child_tidptr)
-{
-	printk("jprobe: clone_flags=0x%lx, stack_size=0x%lx, regs=0x%p\n",
-	       clone_flags, stack_size, regs);
-	/* Always end with a call to jprobe_return(). */
-	jprobe_return();
-	/*NOTREACHED*/
-	return 0;
-}
-
-static struct jprobe my_jprobe = {
-	.entry = (kprobe_opcode_t *) jdo_fork
-};
-
-int init_module(void)
-{
-	int ret;
-	my_jprobe.kp.addr = (kprobe_opcode_t *) kallsyms_lookup_name("do_fork");
-	if (!my_jprobe.kp.addr) {
-		printk("Couldn't find %s to plant jprobe\n", "do_fork");
-		return -1;
-	}
-
-	if ((ret = register_jprobe(&my_jprobe)) <0) {
-		printk("register_jprobe failed, returned %d\n", ret);
-		return -1;
-	}
-	printk("Planted jprobe at %p, handler addr %p\n",
-	       my_jprobe.kp.addr, my_jprobe.entry);
-	return 0;
-}
-
-void cleanup_module(void)
-{
-	unregister_jprobe(&my_jprobe);
-	printk("jprobe unregistered\n");
-}
-
-MODULE_LICENSE("GPL");
------ cut here -----
+See Documentation/jprobe-example.c
 
 Build and insert the kernel module as shown in the above kprobe
 example.  You will see the trace data in /var/log/messages and on
@@ -525,61 +403,7 @@ eliminate duplicate messages.)
 
 Here's a sample kernel module showing the use of return probes to
 report failed calls to sys_open().
------ cut here -----
-/*kretprobe-example.c*/
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/kprobes.h>
-#include <linux/kallsyms.h>
-
-static const char *probed_func = "sys_open";
-
-/* Return-probe handler: If the probed function fails, log the return value. */
-static int ret_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
-{
-	// Substitute the appropriate register name for your architecture --
-	// e.g., regs->rax for x86_64, regs->gpr[3] for ppc64.
-	int retval = (int) regs->eax;
-	if (retval < 0) {
-		printk("%s returns %d\n", probed_func, retval);
-	}
-	return 0;
-}
-
-static struct kretprobe my_kretprobe = {
-	.handler = ret_handler,
-	/* Probe up to 20 instances concurrently. */
-	.maxactive = 20
-};
-
-int init_module(void)
-{
-	int ret;
-	my_kretprobe.kp.addr =
-		(kprobe_opcode_t *) kallsyms_lookup_name(probed_func);
-	if (!my_kretprobe.kp.addr) {
-		printk("Couldn't find %s to plant return probe\n", probed_func);
-		return -1;
-	}
-	if ((ret = register_kretprobe(&my_kretprobe)) < 0) {
-		printk("register_kretprobe failed, returned %d\n", ret);
-		return -1;
-	}
-	printk("Planted return probe at %p\n", my_kretprobe.kp.addr);
-	return 0;
-}
-
-void cleanup_module(void)
-{
-	unregister_kretprobe(&my_kretprobe);
-	printk("kretprobe unregistered\n");
-	/* nmissed > 0 suggests that maxactive was set too low. */
-	printk("Missed probing %d instances of %s\n",
-		my_kretprobe.nmissed, probed_func);
-}
-
-MODULE_LICENSE("GPL");
------ cut here -----
+See Documentation/kretprobe-example.c
 
 Build and insert the kernel module as shown in the above kprobe
 example.  You will see the trace data in /var/log/messages and on the
--- /dev/null
+++ linux-2617-rc4g9-docsrc-split/Documentation/kretprobe-example.c
@@ -0,0 +1,57 @@
+/*kretprobe-example.c*/
+/*
+ * Here's a sample kernel module showing the use of return probes to
+ * report failed calls to sys_open().
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/kprobes.h>
+#include <linux/kallsyms.h>
+
+static const char *probed_func = "sys_open";
+
+/* Return-probe handler: If the probed function fails, log the return value. */
+static int ret_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
+{
+	// Substitute the appropriate register name for your architecture --
+	// e.g., regs->rax for x86_64, regs->gpr[3] for ppc64.
+	int retval = (int) regs->eax;
+	if (retval < 0) {
+		printk("%s returns %d\n", probed_func, retval);
+	}
+	return 0;
+}
+
+static struct kretprobe my_kretprobe = {
+	.handler = ret_handler,
+	/* Probe up to 20 instances concurrently. */
+	.maxactive = 20
+};
+
+int init_module(void)
+{
+	int ret;
+	my_kretprobe.kp.addr =
+		(kprobe_opcode_t *) kallsyms_lookup_name(probed_func);
+	if (!my_kretprobe.kp.addr) {
+		printk("Couldn't find %s to plant return probe\n", probed_func);
+		return -1;
+	}
+	if ((ret = register_kretprobe(&my_kretprobe)) < 0) {
+		printk("register_kretprobe failed, returned %d\n", ret);
+		return -1;
+	}
+	printk("Planted return probe at %p\n", my_kretprobe.kp.addr);
+	return 0;
+}
+
+void cleanup_module(void)
+{
+	unregister_kretprobe(&my_kretprobe);
+	printk("kretprobe unregistered\n");
+	/* nmissed > 0 suggests that maxactive was set too low. */
+	printk("Missed probing %d instances of %s\n",
+		my_kretprobe.nmissed, probed_func);
+}
+
+MODULE_LICENSE("GPL");


---
