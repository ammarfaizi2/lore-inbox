Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVBGO2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVBGO2X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 09:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVBGO2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 09:28:23 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:17309 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261428AbVBGOYN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 09:24:13 -0500
Subject: [RFC][PATCH 2.6.11-rc3-mm1] Relay Fork Module
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Gerrit Huizenga <gh@us.ibm.com>,
       guillaume.thouvenin@bull.net,
       elsa-devel <elsa-devel@lists.sourceforge.net>
Date: Mon, 07 Feb 2005 15:24:05 +0100
Message-Id: <1107786245.9582.27.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 07/02/2005 15:32:41,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 07/02/2005 15:32:43,
	Serialize complete at 07/02/2005 15:32:43
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
	
   This module sends a signal to one or several processes (in user
space) when a fork occurs in the kernel. It relays information about
forks (parent and child pid) to a user space application. The relay fork
module adds a hook in the do_fork() routine that can be used by other
modules and it uses the sysfs file system. The main directory is called
"/sys/relayfork" and it contains two files. One keeps the number of the
signal that is send when a fork occurred and the other is a list of
processes that are registered. Those files are readable and writable.
The tree structure is as follow:
	 sys/
	   |
	   --> relayfork/
	          |
		  ---> processes
		  ---> signal

   If you want to register a process, just "echoing" its PID in the file
"processes". Example: 
        - Register process 123 
          echo 123 > /sys/relayfork/processes
        - Un-Register process 123 
          echo -123 > /sys/relayfork/processes

   By default the module sends the RT signal "33". We use a RT signal
because if a signal occurs when an another one is still in the queue it
is added. If it's not a RT signal, the signal is lost. The administrator
is free to change it.
	echo XX > /sys/relayfork/signal

   I compile a kernel 2.6.10 to see performances impact:

      # time sh -c 'make bzImage && make modules'

      with a vanilla kernel: real    8m10.797s
	                     user    7m29.652s
	                     sys     0m49.275s

      with kernel + patch  : real    8m11.137s
                             user    7m30.034s
                             sys     0m49.994s

      with kernel + patch + ELSA(*) : real     8m12.162s
	                              user     7m30.835s
	                              sys      0m50.082s
	
   (*) ELSA uses the patch in order to perform per-group of processes 
       accounting. It's available at http://elsa.sf.net

   You can compile it as a module or directly in the kernel.

   This patch is used by the Enhanced Linux System Accounting tool that
can be downloaded from http://elsa.sf.net

Regards,
Guillaume

$ diffstat linux-2.6.11-rc3-mm1-relayfork.patch
 include/linux/generic_hooks.h |    9
 init/Kconfig                  |   25 ++
 kernel/Makefile               |    1
 kernel/fork.c                 |   27 ++
 kernel/relay_fork.c           |  477 ++++++++....++++++++++++++
 5 files changed, 539 insertions(+)

Signed-off-by: Guillaume Thouvenin <guillaume.thouvenin@bull.net>


diff -uprN -X dontdiff linux-2.6.11-rc3-mm1/include/linux/generic_hooks.h linux-2.6.11-rc3-mm1-relayfork/include/linux/generic_hooks.h
--- linux-2.6.11-rc3-mm1/include/linux/generic_hooks.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-rc3-mm1-relayfork/include/linux/generic_hooks.h	2005-02-07 10:43:41.000000000 +0100
@@ -0,0 +1,9 @@
+#ifndef GENERIC_HOOKS_H
+#define GENERIC_HOOKS_H
+
+struct do_fork_cb {
+	struct list_head list;
+	void (* handler)(struct task_struct *, struct task_struct *);
+};
+
+#endif
diff -uprN -X dontdiff linux-2.6.11-rc3-mm1/init/Kconfig linux-2.6.11-rc3-mm1-relayfork/init/Kconfig
--- linux-2.6.11-rc3-mm1/init/Kconfig	2005-02-07 10:16:38.000000000 +0100
+++ linux-2.6.11-rc3-mm1-relayfork/init/Kconfig	2005-02-07 10:45:06.000000000 +0100
@@ -199,6 +199,31 @@ config KOBJECT_UEVENT
 	  Say Y, unless you are building a system requiring minimal memory
 	  consumption.
 
+config RELAY_FORK
+	tristate "Relay Fork Event"
+	depends on SYSFS
+	default n
+	---help---
+   	  This module sends a signal to one or several processes when a fork
+ 	  occurs in the kernel. It relays information about forks.
+
+   	  The relay fork module is configured by using the sysfs. The main
+	  directory is called "/sys/relayfork" and it contains two files. One
+	  keeps the number of the signal that is send when a fork occurred and
+	  the other is a list of processes that are registered. Those files
+	  are writable. The tree structure is as follow:
+         	sys/
+         	sys/relayfork/
+         	sys/relayfork/processes
+         	sys/relayfork/signal
+
+   	  If you want to register a process, just "echoing" its PID in the
+	  file "processes". Example:
+        	- Register process 123
+          	echo 123 > /sys/relayfork/processes
+        	- Un-Register process 123
+          	echo -123 > /sys/relayfork/processes
+
 config IKCONFIG
 	bool "Kernel .config support"
 	---help---
diff -uprN -X dontdiff linux-2.6.11-rc3-mm1/kernel/fork.c linux-2.6.11-rc3-mm1-relayfork/kernel/fork.c
--- linux-2.6.11-rc3-mm1/kernel/fork.c	2005-02-07 10:16:38.000000000 +0100
+++ linux-2.6.11-rc3-mm1-relayfork/kernel/fork.c	2005-02-07 10:48:20.000000000 +0100
@@ -41,6 +41,7 @@
 #include <linux/profile.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
+#include <linux/generic_hooks.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -63,6 +64,26 @@ DEFINE_PER_CPU(unsigned long, process_co
 
 EXPORT_SYMBOL(tasklist_lock);
 
+static LIST_HEAD(do_fork_cb_list);
+static spinlock_t do_fork_cb_spinlock = SPIN_LOCK_UNLOCKED;
+
+void do_fork_cb_register(struct do_fork_cb *p)
+{
+	spin_lock(&do_fork_cb_spinlock);
+	list_add(&p->list, &do_fork_cb_list);
+	spin_unlock(&do_fork_cb_spinlock);
+}
+EXPORT_SYMBOL(do_fork_cb_register);
+
+void do_fork_cb_unregister(struct do_fork_cb *p)
+{
+	spin_lock(&do_fork_cb_spinlock);
+	list_del(&p->list);
+	spin_unlock(&do_fork_cb_spinlock);
+}
+EXPORT_SYMBOL(do_fork_cb_unregister);
+
+
 int nr_processes(void)
 {
 	int cpu;
@@ -1209,6 +1230,7 @@ long do_fork(unsigned long clone_flags,
 	 */
 	if (!IS_ERR(p)) {
 		struct completion vfork;
+		struct do_fork_cb *cb;
 
 		if (clone_flags & CLONE_VFORK) {
 			p->vfork_done = &vfork;
@@ -1238,6 +1260,11 @@ long do_fork(unsigned long clone_flags,
 			if (unlikely (current->ptrace & PT_TRACE_VFORK_DONE))
 				ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);
 		}
+
+		spin_lock(&do_fork_cb_spinlock);
+		list_for_each_entry(cb, &do_fork_cb_list,list)
+			cb->handler(current, p);
+		spin_unlock(&do_fork_cb_spinlock);
 	} else {
 		free_pidmap(pid);
 		pid = PTR_ERR(p);
diff -uprN -X dontdiff linux-2.6.11-rc3-mm1/kernel/Makefile linux-2.6.11-rc3-mm1-relayfork/kernel/Makefile
--- linux-2.6.11-rc3-mm1/kernel/Makefile	2005-02-07 10:16:38.000000000 +0100
+++ linux-2.6.11-rc3-mm1-relayfork/kernel/Makefile	2005-02-07 10:48:43.000000000 +0100
@@ -30,6 +30,7 @@ obj-$(CONFIG_SYSFS) += ksysfs.o
 obj-$(CONFIG_DETECT_SOFTLOCKUP) += softlockup.o
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
+obj-$(CONFIG_RELAY_FORK) += relay_fork.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -uprN -X dontdiff linux-2.6.11-rc3-mm1/kernel/relay_fork.c linux-2.6.11-rc3-mm1-relayfork/kernel/relay_fork.c
--- linux-2.6.11-rc3-mm1/kernel/relay_fork.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-rc3-mm1-relayfork/kernel/relay_fork.c	2005-02-07 10:49:02.000000000 +0100
@@ -0,0 +1,477 @@
+/*
+ * Relay fork interface
+ *
+ * Author: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
+ *
+ * This module is a relay for fork monitoring. You use the 
+ * /sys/relayfork/processes to register your process or to 
+ * display registered processes. 
+ * The interface send a signal (default is a the RT signal 33)
+ * to all registered processes when a fork occurs in the kernel. 
+ * The signal can be change by using /sys/relayfork/signal. 
+ *
+ * Conventions:
+ * 	structures are prefixed by rfork_
+ * 	functions  are prefixed by rfd_
+ * 	variable  are prefixed by relayf_
+ */
+
+#include <linux/module.h>	/* for all modules      */
+#include <linux/kernel.h>	/* for KERN_ALERT       */
+#include <linux/init.h>		/* for the macros       */
+
+#include <linux/spinlock.h>	/* for spinlock         */
+#include <linux/sched.h>	/* for task_struct      */
+#include <linux/kobject.h>
+#include <linux/generic_hooks.h>
+
+#define RELAY_FORK_SIGNAL	33
+
+MODULE_AUTHOR("Guillaume Thouvenin <guillaume.thouvenin@bull.net>");
+MODULE_DESCRIPTION("sysfs interface to relay fork device");
+MODULE_LICENSE("GPL");
+
+/* available if the relay-fork patch is applied */
+extern void do_fork_cb_register(struct do_fork_cb *p);
+extern void do_fork_cb_unregister(struct do_fork_cb *p);
+
+/*******************
+ * local definition 
+ *******************/
+
+
+struct rfork_device {
+	struct kobject kobj;
+	struct list_head proclist;	/* registered processes  */
+	unsigned long signal;	/* signal to send to processes */
+};
+
+struct rfork_attribute {
+	struct attribute attr;
+	 ssize_t(*show) (struct rfork_device * dev, char *buf);
+	 ssize_t(*store) (struct rfork_device * dev, const char *buf,
+			  size_t count);
+};
+
+struct rfork_proclist {
+	struct list_head list;
+	unsigned long pid;
+
+};
+
+/*****************************
+ * header for local functions
+ *****************************/
+
+
+ssize_t rfd_attr_show(struct kobject *kobj, struct attribute *attr,
+		      char *buf);
+ssize_t rfd_attr_store(struct kobject *kobj, struct attribute *attr,
+		       const char *buf, size_t size);
+
+ssize_t rfd_proclist_show(struct rfork_device *dev, char *buf);
+ssize_t rfd_proclist_store(struct rfork_device *dev, const char *buf,
+			   size_t size);
+ssize_t rfd_signal_show(struct rfork_device *dev, char *buf);
+ssize_t rfd_signal_store(struct rfork_device *dev, const char *buf,
+			 size_t size);
+
+
+/*****************
+ * local variable 
+ *****************/
+
+static spinlock_t relayf_lock = SPIN_LOCK_UNLOCKED;	/* protect relayf */
+
+struct sysfs_ops relayf_sysfs_ops = {
+	.show = rfd_attr_show,
+	.store = rfd_attr_store,
+};
+
+struct kobj_type relayf_kobj_type = {
+	.sysfs_ops = &relayf_sysfs_ops,
+};
+
+static struct rfork_device relayf;
+
+static struct do_fork_cb fork_hdler;
+
+#define RELAYF_ATTR(_name,_mode,_show,_store)    			\
+struct rfork_attribute relayf_attr_##_name = {            		\
+        .attr = {.name  = __stringify(_name) , .mode   = _mode },      	\
+        .show   = _show,                                		\
+        .store  = _store,                               		\
+};
+/* give write access only to root, otherwise it's a security hole */
+static RELAYF_ATTR(processes, 0644, rfd_proclist_show, rfd_proclist_store);
+static RELAYF_ATTR(signal, 0644, rfd_signal_show, rfd_signal_store);
+
+
+/**************************
+ * body of local functions 
+ **************************/
+
+
+/**
+ * rfd_strtoi - convert a string to an unsigned long
+ * @name: the string to convert
+ *
+ * Convert a string to an unsigned long. When we found 
+ * a character that is not a number, we return immediatly.
+ * The first character can be '-' but if it is, we just 
+ * ignore it and return the positive value.
+ */
+static unsigned long rfd_strtoi(const char *name)
+{
+	unsigned long val = 0;
+
+	/* If it's a negative value we just forgot the '-' */
+	if (*name == '-')
+		name++;
+
+	for (;; name++) {
+		switch (*name) {
+		case '0'...'9':
+			val = 10 * val + (*name - '0');
+			break;
+		default:
+			return val;
+		}
+	}
+}
+
+/**
+ * rfd_nbdigits - return the number of digits of an integer
+ * @i: the integer
+ *
+ * example:  For "0" it returns 1
+ *           For "324" it returns 3
+ *           For "-324" it returns 3
+ */
+
+static inline int rfd_nbdigits(int i)
+{
+	int res = 0;
+
+	if (i < 0)
+		i *= -1;
+
+	do {
+		i = i / 10;
+		res++;
+	} while (i != 0);
+
+	return res;
+}
+
+#define KOBJ_TO_RFORK(obj) container_of(obj, struct rfork_device, kobj)
+#define ATTR_TO_RFORK(obj) container_of(obj, struct rfork_attribute, attr)
+
+/**
+ * rfd_attr_show - method called when a file is read
+ * @kobj: the kobject
+ * @attr: the attribute
+ * @buf:  the buffer
+ *
+ * Translate the generic struct kobject and struct attribute 
+ * pointers to the appropriate pointer types, and calls the 
+ * associated methods.
+ */
+ssize_t rfd_attr_show(struct kobject * kobj, struct attribute * attr,
+		      char *buf)
+{
+	struct rfork_device *rf_dev = KOBJ_TO_RFORK(kobj);
+	struct rfork_attribute *rf_attr = ATTR_TO_RFORK(attr);
+	ssize_t ret = 0;
+
+	if (rf_attr->show)
+		ret = rf_attr->show(rf_dev, buf);
+
+	return ret;
+}
+
+/**
+ * rfd_attr_store - method called when a file is written
+ * @kobj: the kobject
+ * @attr: the attribute
+ * @buf:  the buffer
+ *
+ * Translate the generic struct kobject and struct attribute 
+ * pointers to the appropriate pointer types, and calls the 
+ * associated methods.
+ */
+ssize_t rfd_attr_store(struct kobject * kobj, struct attribute * attr,
+		       const char *buf, size_t size)
+{
+	struct rfork_device *rf_dev = KOBJ_TO_RFORK(kobj);
+	struct rfork_attribute *rf_attr = ATTR_TO_RFORK(attr);
+	ssize_t ret = 0;
+
+	if (rf_attr->store)
+		ret = rf_attr->store(rf_dev, buf, size);
+
+	return ret;
+}
+
+/**
+ * rfd_proclist_show - method called when processes attribute is read
+ * @dev: the relay fork device
+ * @buf: the buffer
+ * 
+ * The buffer is a buffer of size PAGE_SIZE (due to sysfs implementation).
+ * As the method is called only once for a read, the show() method should 
+ * fill the entire buffer. Buffer is filled with a list of processes that
+ * are registered. As the size of the buffer is limited, we also limit 
+ * how many processes are displayed.
+ * Method returns the number of bytes printed into the buffer. If a bad 
+ * value comes through, it returns an  error.
+ */
+ssize_t rfd_proclist_show(struct rfork_device * dev, char *buf)
+{
+	struct rfork_proclist *p;
+	struct list_head *pos;
+	struct list_head *next;
+	int char_print;
+	char tmp[PAGE_SIZE];
+
+	char_print = 0;
+
+	spin_lock_irq(&relayf_lock);
+	list_for_each_safe(pos, next, &dev->proclist) {
+		p = container_of(pos, struct rfork_proclist, list);
+		if (char_print + rfd_nbdigits(p->pid) + 1 < PAGE_SIZE - 1) {
+			memset(tmp, 0, PAGE_SIZE);
+			char_print += sprintf(tmp, "%lu ", p->pid);
+			strcat(buf, tmp);
+		} else
+			/* 
+			 * buf is full enough, we don't need to go through
+			 * the list
+			 */
+			break;
+	}
+	spin_unlock_irq(&relayf_lock);
+	strncat(buf, "\n", 1);
+	char_print++;
+	return char_print;
+}
+
+/**
+ * rfd_proclist_store - method called when processes attribute is written
+ * @dev: the relay fork device
+ * @buf: the buffer
+ * @size:
+ * 
+ * As the method is called only once for a write, the store() method should 
+ * fill the entire buffer. Methods should return the number of bytes used 
+ * from the buffer. If a bad value comes through, we return an error.
+ */
+ssize_t rfd_proclist_store(struct rfork_device * dev, const char *buf,
+			   size_t size)
+{
+	struct rfork_proclist *p;
+	struct list_head *pos;	/* use as a loop counter */
+	struct list_head *next;	/* temporary storage */
+	int pid;		/* process to add or remove */
+
+	pid = rfd_strtoi(buf);
+	if (pid == 0)
+		/* nothing to do */
+		return strlen(buf);
+
+	switch (*buf) {
+	case '-':
+		/* remove the process */
+		spin_lock_irq(&relayf_lock);
+		list_for_each_safe(pos, next, &dev->proclist) {
+			p = container_of(pos, struct rfork_proclist, list);
+			if (p->pid == pid) {
+				list_del(&p->list);
+				spin_unlock_irq(&relayf_lock);
+				kfree(p);
+				return strlen(buf);
+			}
+		}
+		spin_unlock_irq(&relayf_lock);
+		break;
+	default:
+		/* add the process. We check if it is already in the list */
+		spin_lock_irq(&relayf_lock);
+		list_for_each_safe(pos, next, &dev->proclist) {
+			p = container_of(pos, struct rfork_proclist, list);
+			if (p->pid == pid) {
+				spin_unlock_irq(&relayf_lock);
+				return strlen(buf);
+			}
+		}
+
+		/* check if it is a valid pid */
+		read_lock(&tasklist_lock);
+		if (!find_task_by_pid(pid)) {
+			read_unlock(&tasklist_lock);
+			spin_unlock_irq(&relayf_lock);
+			return strlen(buf);
+		}
+		read_unlock(&tasklist_lock);
+		spin_unlock_irq(&relayf_lock);
+
+		p = kmalloc(sizeof(struct rfork_proclist), GFP_KERNEL);
+		if (!p)
+			return -ENOMEM;
+
+		INIT_LIST_HEAD(&p->list);
+		p->pid = rfd_strtoi(buf);
+		spin_lock_irq(&relayf_lock);
+		list_add(&p->list, &dev->proclist);
+		spin_unlock_irq(&relayf_lock);
+	}
+
+	return strlen(buf);
+}
+
+/**
+ * rfd_signal_show - method called when signal attribute is read
+ * @dev: the relay fork device
+ * @buf: the buffer
+ *
+ * Buffer is filled by an integer which is the RT signal used by
+ * the relay fork interface to relay fork information to processes.
+ */
+ssize_t rfd_signal_show(struct rfork_device * dev, char *buf)
+{
+	return sprintf(buf, "%lu\n", dev->signal);
+}
+
+/**
+ * rfd_signal_store - method called when signal attribute is written
+ * @dev: the relay fork device
+ * @buf: the buffer
+ * @size:
+ *
+ * Read the string in the buffer and convert it to an unsigned long
+ * integer. This value is used to set the new RT signal. A RT signal 
+ * must be between SIGRTMIN and SIGRTMAX.
+ */
+ssize_t rfd_signal_store(struct rfork_device * dev, const char *buf,
+			 size_t size)
+{
+	unsigned long rtsignal = rfd_strtoi(buf);
+
+	spin_lock_irq(&relayf_lock);
+	if ((rtsignal > SIGRTMIN) && (rtsignal < SIGRTMAX))
+		dev->signal = rfd_strtoi(buf);
+	spin_unlock_irq(&relayf_lock);
+
+	return strlen(buf);
+}
+
+/**
+ * rfd_relay_fork_info - send information to all registered processes
+ * @parent: PID of the parent 
+ * @child: PID of the child
+ *
+ * Send information to all registered processes when a fork 
+ * occurs in the kernel. 
+ */
+void rfd_relay_fork_info(struct task_struct *parent, struct task_struct *child)
+{
+	struct list_head *pos;
+	struct list_head *next;
+	struct siginfo sinfo;
+	
+	/*pr_info("FORK: parent = %d, child = %d\n", parent, child); */
+
+	spin_lock_irq(&relayf_lock);
+	list_for_each_safe(pos, next, &relayf.proclist) {
+		struct task_struct *taskp;
+		struct rfork_proclist *p =
+		    container_of(pos, struct rfork_proclist, list);
+
+		read_lock(&tasklist_lock);
+		taskp = find_task_by_pid(p->pid);
+		if (taskp) {
+			sinfo.si_signo = relayf.signal;
+			sinfo.si_errno = 0;
+			sinfo.si_code = SI_ASYNCIO;
+			/*
+			 * should be the sender ID but in our case, it is set
+			 * to the pid of the process that initiates the fork.
+			 */
+			sinfo.si_pid = parent->pid;
+			/*
+			 * process created during the fork. This information
+			 *  is needed to keep jobs coherent.
+			 */
+			sinfo.si_value.sival_int = child->pid;
+
+			send_sig_info(relayf.signal, &sinfo, taskp);
+		} else {
+			/* we can remove it from proclist */
+			list_del(&p->list);
+			kfree(p);
+		}
+		read_unlock(&tasklist_lock);
+	}
+	spin_unlock_irq(&relayf_lock);
+}
+
+/**
+ * Modules start and stop
+ **/
+
+/**
+ * rfd_init -
+ */
+static int __init rfd_init(void)
+{
+	int retval;
+
+	INIT_LIST_HEAD(&fork_hdler.list);
+	fork_hdler.handler = &rfd_relay_fork_info;
+
+	do_fork_cb_register(&fork_hdler);
+
+	/* Initialization of relayf */
+	kobject_set_name(&relayf.kobj, "relayfork");
+	relayf.kobj.ktype = &relayf_kobj_type;
+	INIT_LIST_HEAD(&relayf.proclist);
+	relayf.signal = RELAY_FORK_SIGNAL;
+
+	/* 
+	 * Register the kobject. As our object doesn't have a parent
+	 * or a dominant kset, a directory is created at the top-level
+	 * of the sysfs partition.
+	 */
+	retval = kobject_register(&relayf.kobj);
+	sysfs_create_file(&relayf.kobj, &relayf_attr_processes.attr);
+	sysfs_create_file(&relayf.kobj, &relayf_attr_signal.attr);
+
+	return retval;
+}
+
+/**
+ * rfd_cleanup - 
+ */
+static void __exit rfd_cleanup(void)
+{
+	struct list_head *pos;	/* use as a loop counter */
+	struct list_head *next;	/* temporary storage */
+
+	do_fork_cb_register(&fork_hdler);
+
+	/* release entry that was dynamically allocated */
+	list_for_each_safe(pos, next, &relayf.proclist) {
+		struct rfork_proclist *p =
+		    container_of(pos, struct rfork_proclist, list);
+		list_del(&p->list);
+		kfree(p);
+	}
+
+	sysfs_remove_file(&relayf.kobj, &relayf_attr_processes.attr);
+	sysfs_remove_file(&relayf.kobj, &relayf_attr_signal.attr);
+	kobject_unregister(&relayf.kobj);
+}
+
+
+module_init(rfd_init);
+module_exit(rfd_cleanup);


