Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWAQO7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWAQO7e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWAQO6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:58:55 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:56219 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751256AbWAQOuc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:50:32 -0500
Message-Id: <20060117143329.214857000@sergelap>
References: <20060117143258.150807000@sergelap>
Date: Tue, 17 Jan 2006 08:33:28 -0600
From: Serge Hallyn <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Serge E Hallyn <serue@us.ibm.com>
Subject: RFC [patch 30/34] PID Virtualization /proc/container filesystem
Content-Disposition: inline; filename=G4-container-procfs.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the /proc/container directory to
containerize a process or retrieve an associated container.
We need a reasonable quick mechanism to trigger container creation.

A process becomes the root of a container if it writes
a unique name to the /proc/container file. If the process does
not already belong to a container and the name is unique, 
a container is created and the calling process becomes the root.
Reading from the file returns the name of the container.

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
---
 Makefile        |    2 
 container_api.c |  116 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+), 1 deletion(-)

Index: linux-2.6.15/kernel/Makefile
===================================================================
--- linux-2.6.15.orig/kernel/Makefile	2006-01-17 08:37:08.000000000 -0500
+++ linux-2.6.15/kernel/Makefile	2006-01-17 08:37:09.000000000 -0500
@@ -8,7 +8,7 @@
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
 	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o \
-	    container.o
+	    container.o container_api.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
Index: linux-2.6.15/kernel/container_api.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15/kernel/container_api.c	2006-01-17 08:37:09.000000000 -0500
@@ -0,0 +1,116 @@
+/*
+ * External Interface to containers
+ *
+ * This is only for quick bootstrapping the container support
+ * A proper external API needs to be found
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2005 <frankeh@watson.ibm.com>
+ *
+ */
+
+/* Changes
+ *
+ * 11/22/2005:  Created
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <asm/uaccess.h>
+#include <linux/proc_fs.h>
+#include <linux/timer.h>
+#include <linux/mm.h>
+#include <linux/container.h>
+
+MODULE_LICENSE("GPL");
+
+#define DPRINTK( fmt, args...)  // printk( "%s: " fmt, __FUNCTION__, ##args)
+
+/****************************************************************
+ *		P R O C   F S   S T U F F
+ ****************************************************************/
+
+static ssize_t container_write(struct file *file, const char __user *ubuf,
+			       size_t count, loff_t *p)
+{
+	const char *delims = " \t\n";
+	char kbuf[MAX_CONTAINER_NAME_LEN];
+	char *cptr;
+	char *cname;
+	int rc;
+
+	if (current->container)
+		return -EPERM;
+	if (count >= MAX_CONTAINER_NAME_LEN)
+		return -EINVAL;
+	if (copy_from_user(kbuf, ubuf, count))
+		return -EFAULT;
+	kbuf[MAX_CONTAINER_NAME_LEN-1] = '\0';
+
+	cptr = kbuf;
+	cname = strsep(&cptr,delims);
+	DPRINTK("<%s:%d>: <%s>\n", current->comm, task_pid(current), cname);
+	rc = container_new(cname);
+	if (rc < 0)
+		return rc;
+	return count;
+}
+
+static ssize_t container_read(struct file *file, char __user *ubuf,
+	       		      size_t count, loff_t *ppos)
+{
+	char kbuf[MAX_CONTAINER_NAME_LEN];
+	int len;
+	char *cname;
+	loff_t __ppos = *ppos;
+
+	cname = current->container ? current->container->name : "";
+	len = sprintf(kbuf,"%s\n",cname);
+	if (__ppos >= len)
+		return 0;
+	if (count > len-__ppos)
+		count = len-__ppos;
+	if (copy_to_user(ubuf, kbuf+__ppos, count))
+		return -EFAULT;
+	*ppos += __ppos + count;
+	DPRINTK("%s: caller <%s:%d>: <%s>\n",
+		current->comm, task_pid(current), cname);
+	return count;
+}
+
+static struct file_operations container_proc_operations = {
+	.read  = container_read,
+	.write = container_write,
+};
+
+/****************************************************************
+ *
+ ****************************************************************/
+
+static int __init container_init(void)
+{
+	int rc = 0;
+	struct proc_dir_entry *entry;
+
+	entry = create_proc_entry("container", S_IWUGO|S_IRUGO, NULL);
+	if (entry)
+		entry->proc_fops = &container_proc_operations;
+	else
+		rc = -EINVAL;
+
+	/* Other initialization */
+
+	if (rc)
+		remove_proc_entry("container", NULL);
+	return rc;
+}
+
+static void __exit container_exit(void)
+{
+}
+
+module_init(container_init);
+module_exit(container_exit);
+

--

