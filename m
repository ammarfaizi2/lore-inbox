Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266754AbSKUPdB>; Thu, 21 Nov 2002 10:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266755AbSKUPdB>; Thu, 21 Nov 2002 10:33:01 -0500
Received: from fmr01.intel.com ([192.55.52.18]:56004 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S266754AbSKUPci>;
	Thu, 21 Nov 2002 10:32:38 -0500
Message-ID: <028501c29174$36792ca0$6901a8c0@amr.corp.intel.com>
From: "Rusty Lynch" <rusty@linux.co.intel.com>
To: <mochel@osdl.org>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: [BUG] sysfs on 2.5.48 unable to remove files while in use
Date: Thu, 21 Nov 2002 07:39:36 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have noticed some strange behavior on my 2.5.48 build
where sysfs is not able to handle file/directory removal
correctly when the file/directory is in use.

I can see this with a little kprobes example code that I have
been playing with that will create entries like:

/sysfsroot/noisy/0xc0107ae0/sys_fork

when someone uses that driver to insert a kernel probe
at 0xc0107ae0 that will printk "sys_fork".

What I have noticed, is that if I create a new probe
(which will create the sysfs entry), open a new shell and
cd to /sysfsroot/noisy/0xc0107ae0, and then use my
driver to remove the probe (which will remove the
sysfs entry), then /sysfsroot/noisy/0xc0107ae0 doesn't
go away after I cd out of the shell.

>From then on any attempts to create new sysfs entries
do not show up in /sysfsroot/ until I unload/load my driver
again.

It seems like this could be an issue with some real code
(not just this stupid play code of mine), like maybe hotswap
code that updates sysfs entries.

My patch to 2.5.48 (with kprobes already applied) can be
grabbed from:
http://www.stinkycat.com/patches/patch-kprobes_sample_with_sysfs-2.5.48.diff

 - or here is an inline version that $%^&^ outlook will surely screw up:

diff -urN linux-2.5.48-kprobes/arch/i386/kernel/i386_ksyms.c
linux-2.5.48-kprobes-patched/arch/i386/kernel/i386_ksyms.c
--- linux-2.5.48-kprobes/arch/i386/kernel/i386_ksyms.c	2002-11-17
20:29:57.000000000 -0800
+++ linux-2.5.48-kprobes-patched/arch/i386/kernel/i386_ksyms.c	2002-11-18
15:14:42.000000000 -0800
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
diff -urN linux-2.5.48-kprobes/arch/i386/kernel/traps.c
linux-2.5.48-kprobes-patched/arch/i386/kernel/traps.c
--- linux-2.5.48-kprobes/arch/i386/kernel/traps.c	2002-11-18
15:14:25.000000000 -0800
+++ linux-2.5.48-kprobes-patched/arch/i386/kernel/traps.c	2002-11-18
15:14:42.000000000 -0800
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
diff -urN linux-2.5.48-kprobes/drivers/char/Kconfig
linux-2.5.48-kprobes-patched/drivers/char/Kconfig
--- linux-2.5.48-kprobes/drivers/char/Kconfig	2002-11-17
20:29:21.000000000 -0800
+++ linux-2.5.48-kprobes-patched/drivers/char/Kconfig	2002-11-18
15:14:59.000000000 -0800
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

diff -urN linux-2.5.48-kprobes/drivers/char/Makefile
linux-2.5.48-kprobes-patched/drivers/char/Makefile
--- linux-2.5.48-kprobes/drivers/char/Makefile	2002-11-17
20:29:56.000000000 -0800
+++ linux-2.5.48-kprobes-patched/drivers/char/Makefile	2002-11-18
15:14:59.000000000 -0800
@@ -102,6 +102,7 @@
 obj-$(CONFIG_AGP) += agp/
 obj-$(CONFIG_DRM) += drm/
 obj-$(CONFIG_PCMCIA) += pcmcia/
+obj-$(CONFIG_NOISY) += noisy.o

 # Files generated that shall be removed upon make clean
 clean-files := consolemap_deftbl.c defkeymap.c qtronixmap.c
diff -urN linux-2.5.48-kprobes/drivers/char/noisy.c
linux-2.5.48-kprobes-patched/drivers/char/noisy.c
--- linux-2.5.48-kprobes/drivers/char/noisy.c	1969-12-31
16:00:00.000000000 -0800
+++ linux-2.5.48-kprobes-patched/drivers/char/noisy.c	2002-11-20
18:28:41.000000000 -0800
@@ -0,0 +1,265 @@
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
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
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
+	struct attribute attr;
+	struct kobject kobj;
+};
+
+/*
+ * sysfs stuff
+ */
+
+struct subsystem noisy_subsys = {
+	.kobj	= { .name = "noisy" },
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
+static int noisy_fault_handler(struct kprobe *p, struct pt_regs *r, int
trapnr)
+{
+	/* Let the kernel handle this fault */
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
+ * The kprobe pre_handler will just do a printk using the MESSAGE passed
in.
+ *
+ * All kprobes are unregistered when the node is closed, so I use this
module
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
+static ssize_t noisy_write(struct file *file, const char *buf, size_t
count,
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
+
+	if (!valid_kernel_address((unsigned long)(n->probe).addr)) {
+		kfree(n);
+
+		ret = -EINVAL;
+		goto out;
+	}
+
+	kobject_init(&(n->kobj));
+	(n->kobj).subsys = &noisy_subsys;
+	snprintf((n->kobj).name, KOBJ_NAME_LEN, "0x%02x",
+		 (unsigned int)(n->probe).addr);
+
+	(n->attr).name = n->message;
+	(n->attr).mode = S_IRUGO;
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
+	if (kobject_register(&(n->kobj))) {
+		printk(KERN_CRIT "Unable to add probe kobject!\n");
+		unregister_kprobe(&(n->probe));
+		kfree(n);
+
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (sysfs_create_file(&(n->kobj), &(n->attr))) {
+		printk(KERN_CRIT "Unable to add probe attr file!\n");
+		unregister_kprobe(&(n->probe));
+		kobject_unregister(&(n->kobj));
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
+		sysfs_remove_file(&(p->kobj), &(p->attr));
+		kobject_unregister(&(p->kobj));
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
+	subsystem_register(&noisy_subsys);
+	return 0;
+}
+
+static void __exit noisy_exit (void)
+{
+	misc_deregister(&noisy_dev);
+	subsystem_unregister(&noisy_subsys);
+}
+
+module_init(noisy_init);
+module_exit(noisy_exit);
+
+MODULE_AUTHOR("Rusty Lynch");
+MODULE_LICENSE("GPL");
diff -urN linux-2.5.48-kprobes/include/linux/miscdevice.h
linux-2.5.48-kprobes-patched/include/linux/miscdevice.h
--- linux-2.5.48-kprobes/include/linux/miscdevice.h	2002-11-17
20:29:47.000000000 -0800
+++ linux-2.5.48-kprobes-patched/include/linux/miscdevice.h	2002-11-18
15:14:59.000000000 -0800
@@ -23,6 +23,7 @@
 #define MICROCODE_MINOR		184
 #define MWAVE_MINOR	219		/* ACP/Mwave Modem */
 #define MPT_MINOR	220
+#define NOISY_MINOR 221
 #define MISC_DYNAMIC_MINOR 255

 #define SGI_GRAPHICS_MINOR   146

