Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266649AbSKZTkg>; Tue, 26 Nov 2002 14:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266564AbSKZTkg>; Tue, 26 Nov 2002 14:40:36 -0500
Received: from fmr05.intel.com ([134.134.136.6]:34004 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S266693AbSKZTkN>; Tue, 26 Nov 2002 14:40:13 -0500
Date: Tue, 26 Nov 2002 11:47:29 -0800
From: Rusty Lynch <rusty@linux.co.intel.com>
Message-Id: <200211261947.gAQJlTS23275@linux.intel.com>
To: mochel@osdl.org
Subject: [PATCH][2.5.49-bk1]Kprobes Printk Sample Driver
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After recieving lots of input (including a name change)
on the "noisy" driver, I am resending the code as the 
"Kprobes Printk" driver.

This is a sample kprobes driver that enables arbitrary 
printk's to be inserted in valid kernel mapped addresses,
with all user space controls accessed via sysfs.

By building this driver into the kernel (or inserting
it as a module), a new directory called "kprobes_printk"
will be created in your sysfs root. On my system I see:

[root@penguin2 root]# tree /sys/kprobes_printk/
/sys/kprobes_printk/
`-- ctl

Printk probes can be inserted into add by writing a
string of the format "add ADDRESS MESSAGE" to the 
'ctl' file.

For example, I can do the following to make the string
"sys_fork" printk'ed everytime somebody calls the
fork system call:

[root@penguin2 root]# grep sys_fork /usr/src/linux/System.map
c0107d50 T sys_fork
[root@penguin2 root]# echo "add 0xc0107d50 sys_fork" > /sys/kprobes_printk/ctl
[root@penguin2 root]# tree /sys/kprobes_printk/
/sys/kprobes_printk/
|-- c0107d50
|   `-- message
`-- ctl
[root@penguin2 root]# cat /sys/kprobes_printk/c0107d50/message
sys_fork
[root@penguin2 root]# tail --lines=4 /var/log/messages
Nov 26 11:16:15 penguin2 su(pam_unix)[3422]: session opened for user root by rusty(uid=0)
Nov 26 11:23:01 penguin2 kernel: kp_pre_handler: sys_fork
Nov 26 11:23:35 penguin2 kernel: kp_pre_handler: sys_fork
Nov 26 11:24:40 penguin2 last message repeated 2 times

To delete a printk probe write a string of the format
"del ADDRESS" to the 'ctl' file. On my system I do:

[root@penguin2 root]# echo "del 0xc0107d50" > /sys/kprobes_printk/ctl
[root@penguin2 root]# tree /sys/kprobes_printk/
/sys/kprobes_printk/
`-- ctl

This driver depends on:
* Kprobes 
* A tweak to traps.c that addes an exported function
  that enables kprobes_printk to verify user space
  is handing a valid kernel mapped address to
  insert a probe.
* A few tweaks to sysfs that Patrick Mochel has made 
  to his tree, but are not in 2.5.49-bk1.     

To make it easier for somebody to play with this, I 
have uploading all the needed patches for this to
be built on a 2.5.49-bk1 tree.

Kprobes => 
http://www.stinkycat.com/patches/changes_to_bk1/kprobes-2.5.49-bk1.diff

Sysfs Tweaks =>
http://www.stinkycat.com/patches/changes_to_bk1/sysfs_tweaks_2.5.49-bk1.diff

Traps.c tweak =>
http://www.stinkycat.com/patches/changes_to_bk1/vka-2.5.49-bk1.diff

The driver itself (depends on all three above)=>
http://www.stinkycat.com/patches/changes_to_bk1/kprobes-printk-2.5.49-bk1.diff

Here is that last patch inlined:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.876   -> 1.877  
#	   arch/i386/Kconfig	1.13    -> 1.14   
#	drivers/char/Makefile	1.46    -> 1.47   
#	               (new)	        -> 1.1     drivers/char/kprobes_printk.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/26	rusty@penguin.(none)	1.877
# Adding KPROBES_PRINTK option to build the kprobes printk driver that 
# enables arbitrary printk statements to be inserted into valid kernel
# address using kprobes.
# --------------------------------------------
#
diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Tue Nov 26 10:54:44 2002
+++ b/arch/i386/Kconfig	Tue Nov 26 10:54:44 2002
@@ -1560,6 +1560,23 @@
 	  for kernel debugging, non-intrusive instrumentation and testing.  If
 	  in doubt, say "N".
 
+config KPROBES_PRINTK
+	tristate "Kprobes Printk Driver"
+	depends on KPROBES
+	help
+	  This kprobes sample driver enables arbitrary printk statements
+	  to be inserted at any address where a valid kprobe can be inserted.
+	  User space can access this functionality through sysfs.  For 
+	  details see <file:Documentation/kprobes_printk_sample.txt>.
+	   
+	  This driver is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module will be called kprobes_printk.o.  If you want to compile 
+	  it as a module, say M here and read <file:Documentation/modules.txt>.
+
+	  Inserting printk statements in very busy code is a quick way to
+	  bring your system to it's knees.  If in doubt, say "N".
+
 config DEBUG_STACKOVERFLOW
 	bool "Check for stack overflows"
 	depends on DEBUG_KERNEL
diff -Nru a/drivers/char/Makefile b/drivers/char/Makefile
--- a/drivers/char/Makefile	Tue Nov 26 10:54:44 2002
+++ b/drivers/char/Makefile	Tue Nov 26 10:54:44 2002
@@ -82,6 +82,7 @@
 obj-$(CONFIG_AGP) += agp/
 obj-$(CONFIG_DRM) += drm/
 obj-$(CONFIG_PCMCIA) += pcmcia/
+obj-$(CONFIG_KPROBES_PRINTK) += kprobes_printk.o
 
 
 # Files generated that shall be removed upon make clean
diff -Nru a/drivers/char/kprobes_printk.c b/drivers/char/kprobes_printk.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/char/kprobes_printk.c	Tue Nov 26 10:54:44 2002
@@ -0,0 +1,298 @@
+/*
+ * Kprobes Printk Interface for Linux
+ *
+ * This driver allows arbitrary printk's to be inserted into
+ * executing kernel code by using the new kprobes interface.
+ * A message is attached to an address, and when that address
+ * is reached, the message is printed. 
+ *
+ * This uses a sysfs control file to manage a list of probes. 
+ * The sysfs directory is at
+ *
+ * /sys/kprobes_printk/
+ *
+ * and the control is named 'ctl'. 
+ *
+ * A Printk Probe can be added by echoing into the file, like:
+ *
+ *	$ echo "add <address> <message>" > /sys/kprobes_printk/ctl
+ *
+ * where <address> is the address to break on, and <message> 
+ * is the message to print when the address is reached. 
+ *
+ * Probes can be removed by doing:
+ *
+ *	$ echo "del <address>" > /sys/kprobes_printk/ctl
+ *
+ * where <address> is the address of the probe.
+ *
+ * The probes themselves get a directory under /sys/kprobes_printk/, and
+ * the name of the directory is the address of the probe. Each
+ * probe directory contains one file ('message') that contains
+ * the message to be printed. (More may be added later).
+ *
+ * Copyright (C) 2002 Rusty Lynch <rusty@linux.intel.com>
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kprobes.h>
+#include <linux/slab.h>
+#include <linux/kobject.h>
+
+/* exported by arch/YOURARCH/kernel/traps.c */
+extern int valid_kernel_address(unsigned long);
+
+#define MAX_MSG_SIZE 128
+
+#define to_nprobe(entry) container_of(entry,struct nprobe,kobj.entry);
+
+static DECLARE_MUTEX(kp_sem);
+static struct subsystem kp_subsys;
+
+/*
+ * struct nrpobe: data structure for managing list of probe points
+ */
+struct nprobe {
+	struct kprobe probe;
+	char message[MAX_MSG_SIZE + 1];
+	struct kobject kobj;
+};
+
+/* 
+ * Probe handlers.
+ * Only one is used (pre) to print the message out.
+ */
+static void kp_pre_handler(struct kprobe *p, struct pt_regs *r)
+{
+	struct nprobe *c = container_of(p, struct nprobe, probe);
+	printk(KERN_CRIT "%s: %s\n", __FUNCTION__, c->message);
+}
+
+static void kp_post_handler(struct kprobe *p, struct pt_regs *r, 
+			    unsigned long flags)
+{ }
+
+static int kp_fault_handler(struct kprobe *p, struct pt_regs *r, int trapnr)
+{
+	/* Let the kernel handle this fault */
+	return 0;
+}
+
+
+/*
+ * struct kp_attribute - used for defining probe attributes, 
+ * with a typesafe show method.
+ */
+struct kp_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct nprobe *,char *,size_t,loff_t);
+};
+
+
+/**
+ *	kp_attr_show - forward sysfs read call to proper handler.
+ *	@kobj:	kobject of probe being acessed.
+ *	@attr:	generic attribute portion of struct kp_attribute.
+ *	@page:	buffer to write into.
+ *	@count:	number of bytes requested.
+ *	@off:	offset into buffer.
+ *
+ *	This is called from sysfs and is necessary to convert the generic
+ *	kobject into the right type, and to convert the attribute into the
+ *	right attribute type.
+ */
+
+static ssize_t kp_attr_show(struct kobject * kobj, struct attribute * attr,
+			    char * page, size_t count, loff_t off)
+{
+	struct nprobe * n = container_of(kobj,struct nprobe,kobj);
+	struct kp_attribute * kp_attr = 
+		container_of(attr,struct kp_attribute,attr);
+	return kp_attr->show ? kp_attr->show(n,page,count,off) : 0;
+}
+
+/*
+ * kp_sysfs_ops - sysfs operations for struct nprobes.
+ */
+static struct sysfs_ops kp_sysfs_ops = {
+	.show	= kp_attr_show,
+};
+
+
+/* Default Attribute - the message to print out. */
+static ssize_t kp_message_read(struct nprobe * n, char * page, 
+			       size_t count, loff_t off)
+{
+	return off ? 0: snprintf(page,MAX_MSG_SIZE,"%s\n",n->message);
+}
+
+static struct kp_attribute attr_message = {
+	.attr	= { .name = "message", .mode = S_IRUGO },
+	.show	= kp_message_read,
+};
+
+/* Declare array of default attributes to be added when an nprobe is added */
+static struct attribute * default_attrs[] = {
+	&attr_message.attr,
+	NULL,
+};
+
+
+/* Declare kp_subsys for addition to sysfs */
+static struct subsystem kp_subsys = {
+	.kobj	= { .name = "kprobes_printk" },
+	.default_attrs	= default_attrs,
+	.sysfs_ops	= &kp_sysfs_ops,
+};
+
+
+/*
+ * kp ctl attribute.
+ * This is declared as an attribute of the subsystem, and added in 
+ * kp_init(). 
+ * 
+ * Reading this attribute dumps all the registered kp probes.
+ * Writing to it either adds or deletes a kp probe, as described at 
+ * the beginning of the file.
+ */
+static ssize_t ctl_show(struct subsystem * s, char * page, 
+			size_t count, loff_t off)
+{
+	char * str = page;
+	int ret = 0;
+
+	down(&kp_sem);
+	if (!off) {
+		struct list_head * entry, * next;
+		list_for_each_safe(entry,next,&kp_subsys.list) {
+			struct nprobe * n = to_nprobe(entry);
+			if ((ret + MAX_MSG_SIZE) > PAGE_SIZE)
+				break;
+			str += snprintf(str,PAGE_SIZE - ret,"%p: %s\n",
+					n->probe.addr,n->message);
+			ret = str - page;
+		}
+	}
+	up(&kp_sem);
+	return ret;
+}
+
+static int add(unsigned long addr, char * message)
+{
+	struct nprobe * n;
+	int error = 0;
+
+	if (!valid_kernel_address(addr))
+		return -EFAULT;
+
+	n = kmalloc(sizeof(struct nprobe),GFP_KERNEL);
+	if (!n)
+		return -ENOMEM;
+	memset(n,0,sizeof(struct nprobe));
+
+	n->probe.addr = (kprobe_opcode_t *)addr;
+	strncpy(n->message,message,MAX_MSG_SIZE);
+	n->probe.pre_handler = kp_pre_handler;
+	n->probe.post_handler = kp_post_handler;
+	n->probe.fault_handler = kp_fault_handler;
+
+	/* Doing this manually will be unnecessary soon. */
+	kobject_init(&n->kobj);
+	n->kobj.subsys = &kp_subsys;
+	snprintf(n->kobj.name, KOBJ_NAME_LEN, "%p", n->probe.addr);
+	
+	if ((error = register_kprobe(&n->probe))) {
+		printk(KERN_ERR "Unable to register probe at %p\n", 
+		       (n->probe).addr);
+		goto Error;
+	}
+
+	if (!try_module_get(THIS_MODULE))
+		goto Error;
+
+	if ((error = kobject_register(&n->kobj))) {
+		unregister_kprobe(&n->probe);
+		module_put(THIS_MODULE);
+		goto Error;
+	}
+
+	goto Done;
+ Error:
+	kfree(n);
+ Done:
+	return error;
+}
+
+static int del(unsigned long addr)
+{
+	struct list_head * entry;
+	struct nprobe * n;
+
+	list_for_each(entry,&kp_subsys.list) {
+		n = to_nprobe(entry);
+		if ((unsigned long)(n->probe.addr) == addr) {
+			unregister_kprobe(&n->probe);
+			kobject_unregister(&n->kobj);
+			module_put(THIS_MODULE);
+			return 0;
+		}
+	}
+	return -EFAULT;
+}
+
+static ssize_t ctl_store(struct subsystem * s, const char * page, 
+			 size_t count, loff_t off)
+{
+	char message[MAX_MSG_SIZE];
+	char ctl[16];
+	unsigned long addr;
+	int num;
+	int error;
+	int ret = 0;
+
+	down(&kp_sem);
+	if (off)
+		goto Done;
+	num = sscanf(page,"%15s 0x%lx %128s",ctl,&addr,message);
+	if (!num) {
+		error = -EINVAL;
+		goto Done;
+	}
+	if (!strcmp(ctl,"add") && num == 3)
+		error = add(addr,message);
+	else if (!strcmp(ctl,"del") && num == 2)
+		error = del(addr);
+	else
+		error = -EINVAL;
+	ret = error ? error : count;
+ Done:
+	up(&kp_sem);
+	return ret;
+}
+
+static struct subsys_attribute subsys_attr_ctl = {
+	.attr	= { .name = "ctl", .mode = 0644 },
+	.show	= ctl_show,
+	.store	= ctl_store,
+};
+
+
+static int __init kp_init(void)
+{
+	subsystem_register(&kp_subsys);
+	subsys_create_file(&kp_subsys,&subsys_attr_ctl);
+	return 0;
+}
+
+static void __exit kp_exit (void)
+{
+	subsys_remove_file(&kp_subsys,&subsys_attr_ctl);
+	subsystem_unregister(&kp_subsys);
+}
+
+module_init(kp_init);
+module_exit(kp_exit);
+
+MODULE_AUTHOR("Rusty Lynch");
+MODULE_LICENSE("GPL");
