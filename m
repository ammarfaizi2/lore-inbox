Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267047AbSKRXsc>; Mon, 18 Nov 2002 18:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267050AbSKRXsb>; Mon, 18 Nov 2002 18:48:31 -0500
Received: from fmr05.intel.com ([134.134.136.6]:1001 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id <S267047AbSKRXsW>;
	Mon, 18 Nov 2002 18:48:22 -0500
Date: Mon, 18 Nov 2002 15:55:19 -0800
From: Rusty Lynch <rusty@linux.co.intel.com>
Message-Id: <200211182355.gAINtJH03569@linux.intel.com>
To: linux-kernel@vger.kernel.org, vamsi@in.ibm.com
Subject: [PATCH][2.5.48]kprobes sample driver
Cc: dprobes@www-124.southbury.usf.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resubmit of sample kprobes driver for the 2.5.48 kernel.  There
is a couple of minor clean-ups, but the only major change is that I am
adding a function to arch/i386/kernel/traps.c that enables the sample
driver to verify the kernel addresses being passed in are valid.

(I submitted a patch for traps.c, but adding a new function to traps.c
just for this little sample doesn't make for that strong of an argument.)

Oh yea, this patch can also be fetched from 
http://www.stinkycat.com/patches/patch-kprobes_sample-2.5.48.diff.

As before ==>
This is a sample kprobes module that implements a simple misc char device
that can cause arbitrary text to be printk'ed when arbitrary kernel
addresses are executed.

This patch was created on top of a 2.5.47 kernel with the kprobes
patch applied.

I created this driver just to learn what kprobes was all about.  I am 
sending this to the mailing list for other people that are curious about
kprobes (and also to have people who know more about kprobes show me where
my understanding is flawed.)

To use the device, create a misc char node with a minor of 221, and then
write strings of the format "0xADDRESS MESSAGE" to the device.  When the 
file is closed all kprobes are unregistered, so I usually test by doing:

$ mknod /dev/noisy c 10 221
$ cat > /dev/noisy
0xc0107d50 sys_fork

.. and then go do something that will trigger a sys_fork.

diff -urN linux-2.5.48-kprobes/arch/i386/kernel/i386_ksyms.c linux-2.5.48-kprobes-patched/arch/i386/kernel/i386_ksyms.c
--- linux-2.5.48-kprobes/arch/i386/kernel/i386_ksyms.c	2002-11-17 20:29:57.000000000 -0800
+++ linux-2.5.48-kprobes-patched/arch/i386/kernel/i386_ksyms.c	2002-11-18 15:14:42.000000000 -0800
@@ -59,6 +59,8 @@
 extern unsigned long cpu_khz;
 extern unsigned long get_cmos_time(void);
 
+extern int valid_kernel_address(unsigned long addr);
+
 /* platform dependent support */
 EXPORT_SYMBOL(boot_cpu_data);
 #ifdef CONFIG_EISA
@@ -91,6 +93,7 @@
 EXPORT_SYMBOL(get_cmos_time);
 EXPORT_SYMBOL(cpu_khz);
 EXPORT_SYMBOL(apm_info);
+EXPORT_SYMBOL(valid_kernel_address);
 
 #ifdef CONFIG_DEBUG_IOVIRT
 EXPORT_SYMBOL(__io_virt_debug);
diff -urN linux-2.5.48-kprobes/arch/i386/kernel/traps.c linux-2.5.48-kprobes-patched/arch/i386/kernel/traps.c
--- linux-2.5.48-kprobes/arch/i386/kernel/traps.c	2002-11-18 15:14:25.000000000 -0800
+++ linux-2.5.48-kprobes-patched/arch/i386/kernel/traps.c	2002-11-18 15:14:42.000000000 -0800
@@ -131,6 +131,11 @@
 
 #endif
 
+int valid_kernel_address(unsigned long addr)
+{
+	return kernel_text_address(addr);
+}
+
 void show_trace(unsigned long * stack)
 {
 	int i;
diff -urN linux-2.5.48-kprobes/drivers/char/Kconfig linux-2.5.48-kprobes-patched/drivers/char/Kconfig
--- linux-2.5.48-kprobes/drivers/char/Kconfig	2002-11-17 20:29:21.000000000 -0800
+++ linux-2.5.48-kprobes-patched/drivers/char/Kconfig	2002-11-18 15:14:59.000000000 -0800
@@ -1270,5 +1270,20 @@
 	  Once bound, I/O against /dev/raw/rawN uses efficient zero-copy I/O. 
 	  See the raw(8) manpage for more details.
 
+config NOISY
+	tristate "Noisy Interface Support"
+	---help---
+	  If you say Y here and create a character special file /dev/noisy with
+	  major number 10 and minor number 221 using mknod ("man mknod"), you
+	  will get access to an interface for inserting arbitrary printk's
+	  into executing kernel code.
+
+	  This driver is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module is called noisy.o. If you want to compile it as a module,
+	  say M here and read <file:Documentation/modules.txt>.
+
+	  If unsure, say N.
+
 endmenu
 
diff -urN linux-2.5.48-kprobes/drivers/char/Makefile linux-2.5.48-kprobes-patched/drivers/char/Makefile
--- linux-2.5.48-kprobes/drivers/char/Makefile	2002-11-17 20:29:56.000000000 -0800
+++ linux-2.5.48-kprobes-patched/drivers/char/Makefile	2002-11-18 15:14:59.000000000 -0800
@@ -102,6 +102,7 @@
 obj-$(CONFIG_AGP) += agp/
 obj-$(CONFIG_DRM) += drm/
 obj-$(CONFIG_PCMCIA) += pcmcia/
+obj-$(CONFIG_NOISY) += noisy.o
 
 # Files generated that shall be removed upon make clean
 clean-files := consolemap_deftbl.c defkeymap.c qtronixmap.c
diff -urN linux-2.5.48-kprobes/drivers/char/noisy.c linux-2.5.48-kprobes-patched/drivers/char/noisy.c
--- linux-2.5.48-kprobes/drivers/char/noisy.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.5.48-kprobes-patched/drivers/char/noisy.c	2002-11-18 15:18:16.000000000 -0800
@@ -0,0 +1,222 @@
+/*
+ * Noisy Interface for Linux
+ *
+ * This driver allows arbitrary printk's to be inserted into
+ * executing kernel code by using the new kprobes interface.
+ *
+ * Copyright (C) 2002 Rusty Lynch <rusty@linux.intel.com>
+ */
+
+#include <linux/module.h>
+#include <linux/miscdevice.h>
+#include <linux/init.h>
+#include <linux/kprobes.h>
+#include <linux/slab.h>
+#include <asm/uaccess.h>
+
+/* exported by arch/YOURARCH/kernel/traps.c */
+extern int valid_kernel_address(unsigned long);
+
+#define MAX_MSG_SIZE 128
+
+/*
+ * Data structures for managing list of probe points
+ */
+static struct list_head probe_list;
+struct nprobe {
+	struct list_head list;
+	struct kprobe probe;
+	char message[MAX_MSG_SIZE + 1];
+};
+
+/* 
+ * Probe handler called before the execution of all probe points
+ */
+static void noisy_pre_handler(struct kprobe *p, struct pt_regs *r)
+{
+	struct nprobe *c = container_of(p, struct nprobe, probe);
+	printk(KERN_CRIT "%s: %s\n", __FUNCTION__, c->message);
+}
+
+/* 
+ * Probe handler called just after the probed address is single stepped
+ */
+static void noisy_post_handler(struct kprobe *p, struct pt_regs *r, 
+			       unsigned long flags)
+{
+}
+
+/*
+ * Fault handler that covers the pre_handler, single stepping, and 
+ * post_handler executiion.
+ */
+static int noisy_fault_handler(struct kprobe *p, struct pt_regs *r, int trapnr)
+{
+	// Let the kernel handle this fault
+	return 0;
+}
+
+/*
+ * Supported file operations
+ */
+static ssize_t noisy_read(struct file *, char *, size_t, loff_t *);
+static ssize_t noisy_write(struct file *, const char *, size_t, loff_t *);
+static int noisy_open(struct inode *, struct file *);
+static int noisy_release(struct inode *, struct file *);
+
+static struct file_operations noisy_fops = {
+	.owner          = THIS_MODULE,
+	.read           = noisy_read,
+	.write          = noisy_write,
+	.open           = noisy_open,
+	.release        = noisy_release,
+};
+
+/* 
+ * To conserve major numbers, this device uses
+ * the miscdevice subsystem.  
+ */
+static struct miscdevice noisy_dev =
+{
+	.minor        = NOISY_MINOR,
+	.name         = "noisy",
+	.fops         = &noisy_fops
+};
+
+static ssize_t noisy_read(struct file *file, char *buf,
+			size_t count, loff_t *ppos)
+{	
+	struct nprobe *p;
+	list_for_each_entry(p, &probe_list, list) {
+		printk(KERN_CRIT "%p: %s\n", (p->probe).addr, p->message);
+	}
+
+	return 0;
+}
+
+/*
+ * A kprobe is created for each write operation where write is expecting
+ * a string of the form:
+ * 0xADDRESS MESSAGE
+ * 
+ * The kprobe pre_handler will just do a printk using the MESSAGE passed in.
+ *
+ * All kprobes are unregistered when the node is closed, so I use this module
+ * like:
+ * $ mknod /dev/noisy c 10 221
+ * $ cat > /dev/noisy
+ * 0xc0107d50 sys_fork
+ *
+ * ... and then go do something that will trigger a sys_fork, 
+ *     and then control-c to stop the cat process (which 
+ *     will close the node and therefore stop syslog from further
+ *     DOS attacks from this driver)
+ */
+static ssize_t noisy_write(struct file *file, const char *buf, size_t count, 
+			   loff_t *ppos)
+{
+	struct nprobe *n = 0;
+	size_t ret = -ENOMEM;
+	char *tmp = 0;
+
+	if (count > MAX_MSG_SIZE) {
+		printk(KERN_CRIT 
+		       "noisy: Input buffer (%i bytes) is too big!\n",
+		       count);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	tmp = kmalloc(count + 1, GFP_KERNEL);
+	if (!tmp) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	n = kmalloc(sizeof(struct nprobe), GFP_KERNEL);
+	if (!n) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	memset(n, '\0', sizeof(struct nprobe));
+	
+	if (copy_from_user((void *)tmp, (void *)buf, count)) {
+		ret = -ENOMEM;
+		goto out;
+	} 
+	tmp[count] = '\0';
+
+	if (2 != sscanf(tmp, "0x%x %s", &(n->probe).addr, n->message)) {
+		ret = -EINVAL;
+		goto out;
+	}
+	(n->probe).pre_handler = noisy_pre_handler;
+	(n->probe).post_handler = noisy_post_handler;
+	(n->probe).fault_handler = noisy_fault_handler;
+
+	if (!valid_kernel_address((unsigned long)(n->probe).addr)) {
+		kfree(n);
+
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (register_kprobe(&(n->probe))) {
+		printk(KERN_CRIT "Unable to register probe at %p\n", 
+		       (n->probe).addr);
+		kfree(n);
+
+		ret = -EINVAL;
+		goto out;
+	}
+		
+	list_add(&(n->list), &probe_list);
+	ret = count;
+
+ out:
+	kfree(tmp);
+        return ret;
+}
+
+static int noisy_open(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static int noisy_release(struct inode *inode, struct file *file)
+{
+	while(!list_empty(&probe_list)) {
+		struct list_head *n = probe_list.next;
+		struct nprobe *p = list_entry(n, struct nprobe, list);
+
+		printk("Releasing probe %p: %s\n", 
+		       (p->probe).addr, p->message);
+		unregister_kprobe(&(p->probe));
+
+		list_del(n);
+		kfree(p);
+	}
+	return 0;
+}
+
+static int __init noisy_init(void)
+{
+	if (misc_register(&noisy_dev))
+	{
+		return -ENODEV;
+	}	
+	INIT_LIST_HEAD(&probe_list);
+
+	return 0;
+}
+
+static void __exit noisy_exit (void)
+{
+	misc_deregister(&noisy_dev);
+}
+
+module_init(noisy_init);
+module_exit(noisy_exit);
+
+MODULE_AUTHOR("Rusty Lynch");
+MODULE_LICENSE("GPL");
diff -urN linux-2.5.48-kprobes/include/linux/miscdevice.h linux-2.5.48-kprobes-patched/include/linux/miscdevice.h
--- linux-2.5.48-kprobes/include/linux/miscdevice.h	2002-11-17 20:29:47.000000000 -0800
+++ linux-2.5.48-kprobes-patched/include/linux/miscdevice.h	2002-11-18 15:14:59.000000000 -0800
@@ -23,6 +23,7 @@
 #define MICROCODE_MINOR		184
 #define MWAVE_MINOR	219		/* ACP/Mwave Modem */
 #define MPT_MINOR	220
+#define NOISY_MINOR 221
 #define MISC_DYNAMIC_MINOR 255
 
 #define SGI_GRAPHICS_MINOR   146
