Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbULQO7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbULQO7w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 09:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbULQO7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 09:59:52 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:9165 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261231AbULQO6l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 09:58:41 -0500
Subject: [RFC] fork historic module
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: elsa-announce <elsa-announce@lists.sourceforge.net>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       guillaume.thouvenin@bull.net,
       "lse-tech@lists.sourceforge.net" <lse-tech@lists.sourceforge.net>
Date: Fri, 17 Dec 2004 15:58:32 +0100
Message-Id: <1103295512.7329.75.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/12/2004 16:06:08,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/12/2004 16:06:11,
	Serialize complete at 17/12/2004 16:06:11
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  Here is the fork historic module. This module keeps the historic about
the creation of processes and it gives this information to a user space
application if one is registered. Currently, only one application can
use it. If needed it could be extended to several applications.

Here is how it works:

  The module registers itself to the kernel via a LSM hook in order to
receive a signal when a fork occurs in the kernel. We are using the
"task_alloc_security" security hook. When a fork occurs, information is
following up to a registered application. When an application registers
itself, it gives to the fork historic driver a RT signal that will be
used to pass the information. The application registers to this driver
by using ioctl command on the /dev/fh interface.

  This driver is used by the daemon part of ELSA project. The daemon
manages groups of processes called jobs in order to do per-group of
processes accounting. I tested the module with kernel 2.6.9 and also
with 2.6.10-rc3-mm1 and I was able to manage jobs in user space by using
the job daemon which is a part of the Enhanced Linux System Accounting. 

  ELSA can be downloaded from http://elsa.sf.net

  Andrew, do you think that this module can be integrated in your
development tree? I hope that it can be useful for someone else.

Any comments and suggestions are welcome.

Guillaume


 drivers/char/Kconfig          |   23 ++++
 drivers/char/Makefile         |    2
 drivers/char/fork_historic.c  |  211 ++++++++++++++++++++++++++++...
 include/linux/fork_historic.h |   36 +++++++
 4 files changed, 272 insertions(+)


Signed-off-by: Guillaume Thouvenin <guillaume.thouvenin@bull.net>


diff -uprN -X dontdiff linux-2.6.10-rc3-mm1/drivers/char/fork_historic.c linux-2.6.10-rc3-mm1+fh/drivers/char/fork_historic.c
--- linux-2.6.10-rc3-mm1/drivers/char/fork_historic.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc3-mm1+fh/drivers/char/fork_historic.c	2004-12-17 14:03:46.147439208 +0100
@@ -0,0 +1,211 @@
+/*
+ * fork_historic.c - fork historic interface
+ *
+ * Author: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
+ *
+ * This driver allows to keep the historic about the creation of
+ * processes and it gives this information to a user space application.
+ * Currently, only one application can use it. If needed it could be 
+ * extended to several applications. 
+ *
+ * It registers itself to the kernel via a LSM hook in order to receive
+ * a signal when a fork occurs in the kernel. When a fork occurs, it
+ * follows up the information to an application if one is registered. When
+ * an application registers itself, it gives to the driver a RT signal 
+ * that will be used to pass the information. The application communicates to 
+ * this driver by using ioctl command on the /dev/fh interface. 
+ *
+ *
+ * 	This program is free software; you can redistribute it and/or
+ * 	modify it under the terms of the GNU General Public License as
+ * 	published by the Free Software Foundation, version 2.
+ *
+ *	This program is distributed in the hope that it would be useful, but
+ * 	WITHOUT ANY WARRANTY; without even the implied warranty of
+ * 	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+#include <linux/module.h>	/* for all modules      */
+#include <linux/kernel.h>	/* for KERN_ALERT       */
+#include <linux/init.h>		/* for the macros       */
+#include <linux/spinlock.h>	/* for spinlock         */
+#include <linux/sched.h>	/* for task_struct      */
+#include <linux/fs.h>		/* for register_chrdev  */
+#include <linux/security.h>	/* for LSM hook         */
+#include <linux/fork_historic.h>
+
+#include <asm/errno.h>		/* used to set ernno      */
+#include <asm/uaccess.h>	/* used to copy from user */
+
+static int fh_ioctl(struct inode *inode, struct file *file,
+		    unsigned int cmd, unsigned long arg);
+static int fh_task_alloc_security(struct task_struct *p);
+
+/* fh_lock protects fh_pid and fh_sig */
+static spinlock_t fh_lock = SPIN_LOCK_UNLOCKED;
+static int fh_pid;
+static int fh_sig;
+
+
+/* this is the major number dynamically got when registered */
+static int fh_major;
+
+struct security_operations fh_sops = {
+	.task_alloc_security = fh_task_alloc_security,
+};
+
+static struct file_operations fh_fops = {
+	.owner = THIS_MODULE,
+	.ioctl = fh_ioctl,
+};
+
+static int
+fh_ioctl(struct inode *inode, struct file *file,
+	 unsigned int cmd, unsigned long arg)
+{
+	struct fh_ioctl_parm iarg;
+	int retval = 0;
+
+	/* We can make some checks */
+	if (_IOC_TYPE(cmd) != FH_MAGIC)
+		return -ENOTTY;
+	if (_IOC_NR(cmd) > FH_MAXNR)
+		return -ENOTTY;
+	if ((cmd != FH_REGISTER) && (cmd != FH_UNREGISTER))
+		return -ENOTTY;
+
+	/* Recover ioctl parameters */
+	if (copy_from_user(&iarg, (void __user *) arg,
+			   sizeof(struct fh_ioctl_parm)))
+		return -EFAULT;
+
+	switch (cmd) {
+	case FH_REGISTER:
+		spin_lock_irq(&fh_lock);
+		if (fh_pid == 0) {
+			/* There is no application already registered */
+			fh_pid = iarg.pid;
+			fh_sig = iarg.sig;
+		} else
+			/* Someone uses this module */
+			retval = -EUSERS;
+		spin_unlock_irq(&fh_lock);
+		break;
+	case FH_UNREGISTER:
+		spin_lock_irq(&fh_lock);
+		fh_pid = 0;
+		fh_sig = 0;
+		spin_unlock_irq(&fh_lock);
+		break;
+	default:
+		/*
+		 * The POSIX standard, states that if an inappropriate ioctl 
+		 * command has been issued, then -ENOTTY should be returned.
+		 */
+		retval = -ENOTTY;
+	};
+
+	return retval;
+}
+
+/**
+ * fh_task_alloc_security - send SIGRTFORK signal to a register process
+ * @ppid: parent ID
+ * @cpid: child ID
+ *
+ * This routine send a SIGRTFORK to a register process if there is one. We use
+ * a real time signal because we don't want to loose information. With non real
+ * time signals, additional signals of that same type that arrive in the 
+ * meantime might be discarded.
+ * 
+ */
+static int fh_task_alloc_security(struct task_struct *p)
+{
+	struct siginfo sinfo;
+	struct task_struct *fh_p;
+
+	/* 
+	 * We need to be sure that fh_pid is not modified when sending 
+	 * fork information. As we check if the process still exists and 
+	 * if not, we change the global fh_pid, we protect this part.
+	 * A process can be killed and still registered...
+	 */
+	spin_lock_irq(&fh_lock);
+	if (fh_pid) {
+		read_lock(&tasklist_lock);
+		fh_p = find_task_by_pid(fh_pid);
+		if (fh_p) {
+			sinfo.si_signo = fh_sig;
+			sinfo.si_errno = 0;
+			sinfo.si_code = SI_ASYNCIO;
+			/* 
+			 * should be the sender ID but in our case, it is set
+			 * to the pid of the process that initiates the fork.
+			 */
+			sinfo.si_pid = current->pid;
+			/* 
+			 * process created during the fork. This information
+			 *  is needed to keep jobs coherent. 
+			 */
+			sinfo.si_value.sival_int = p->pid;
+
+			send_sig_info(fh_sig, &sinfo, fh_p);
+		} else {
+			/* 
+			 * process #fh_pid doesn't exist so we don't need to 
+			 * check that each time and we reset the values.
+			 */
+			fh_pid = 0;
+			fh_sig = 0;
+		}
+		read_unlock(&tasklist_lock);
+	}
+	spin_unlock_irq(&fh_lock);
+
+	return 0;
+}
+
+/**
+ * fh_init - called when module is loaded
+ *
+ * Register the character device. It aslo register an LSM hook
+ * in order to be inform by the creation of a new process.
+ */
+static int __init fh_init(void)
+{
+	fh_major = register_chrdev(0, "fh", &fh_fops);
+	if (!fh_major) {
+		printk(KERN_ERR "fh: failed to register fh device\n");
+		return -EIO;
+	}
+
+	if (register_security(&fh_sops)) {
+		printk(KERN_ERR "fh: failed to set the fork hook \n");
+		return -EIO;
+	}
+
+	printk(KERN_INFO "fh: fork historic started\n");
+	return 0;
+}
+
+/**
+ * fh_exit - called when module is unloaded
+ *
+ * Un-register the character device and the LSM hook.
+ */
+static void __exit fh_exit(void)
+{
+	if (unregister_security(&fh_sops))
+		printk(KERN_ERR "fh: Unable to register with kernel\n");
+
+	unregister_chrdev(fh_major, "fh");
+
+	printk(KERN_INFO "fh: fork historic ended\n");
+}
+
+module_init(fh_init);
+module_exit(fh_exit);
+
+MODULE_AUTHOR("Guillaume Thouvenin <guillaume.thouvenin@bull.net>");
+MODULE_DESCRIPTION("Fork Historic Module");
+MODULE_LICENSE("GPL");
diff -uprN -X dontdiff linux-2.6.10-rc3-mm1/drivers/char/Kconfig linux-2.6.10-rc3-mm1+fh/drivers/char/Kconfig
--- linux-2.6.10-rc3-mm1/drivers/char/Kconfig	2004-12-03 22:52:14.000000000 +0100
+++ linux-2.6.10-rc3-mm1+fh/drivers/char/Kconfig	2004-12-17 14:04:08.753002640 +0100
@@ -4,6 +4,29 @@
 
 menu "Character devices"
 
+config FORK_HISTORIC
+	tristate "Fork historic"
+	depends on SECURITY
+	default n
+	---help---
+	  This driver allows to keep the historic about the creation of
+	  processes and it gives this information to a user space 
+	  application. Currently, only one application can use it. If 
+	  needed it could be extended to several applications.
+
+ 	  It registers itself to the kernel via a LSM hook in order to 
+	  receive a signal when a fork occurs in the kernel. When a fork 
+	  occures, it follows up the information to an application if one 
+	  is registered. When an application registers itself, it gives to 
+	  the driver a RT signal that will be used to pass the information. 
+
+	  The application communicates to this driver by using ioctl command 
+	  on the "/dev/fh" interface. So, to be able to use it you need to
+	  create the "/dev/fh" character device with the correct major number
+	  that can be found by looking into the "/proc/devices".
+
+	  If unsure, say N.
+	
 config VT
 	bool "Virtual terminal" if EMBEDDED
 	select INPUT
diff -uprN -X dontdiff linux-2.6.10-rc3-mm1/drivers/char/Makefile linux-2.6.10-rc3-mm1+fh/drivers/char/Makefile
--- linux-2.6.10-rc3-mm1/drivers/char/Makefile	2004-12-03 22:54:50.000000000 +0100
+++ linux-2.6.10-rc3-mm1+fh/drivers/char/Makefile	2004-12-17 09:59:22.000000000 +0100
@@ -91,6 +91,8 @@ obj-$(CONFIG_IPMI_HANDLER) += ipmi/
 
 obj-$(CONFIG_HANGCHECK_TIMER) += hangcheck-timer.o
 
+obj-$(CONFIG_FORK_HISTORIC) += fork_historic.o
+
 # Files generated that shall be removed upon make clean
 clean-files := consolemap_deftbl.c defkeymap.c qtronixmap.c
 
diff -uprN -X dontdiff linux-2.6.10-rc3-mm1/include/linux/fork_historic.h linux-2.6.10-rc3-mm1+fh/include/linux/fork_historic.h
--- linux-2.6.10-rc3-mm1/include/linux/fork_historic.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc3-mm1+fh/include/linux/fork_historic.h	2004-12-17 09:58:21.000000000 +0100
@@ -0,0 +1,36 @@
+/*
+ * fork_historic.h - fork historic interface header file
+ *
+ * Author: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
+ *
+ * 	This program is free software; you can redistribute it and/or
+ * 	modify it under the terms of the GNU General Public License as
+ * 	published by the Free Software Foundation, version 2.
+ *
+ *	This program is distributed in the hope that it would be useful, but
+ * 	WITHOUT ANY WARRANTY; without even the implied warranty of
+ * 	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+#ifndef FORK_HISTORIC_H
+#define FORK_HISTORIC_H
+
+#include <linux/ioctl.h>
+
+/* Information given by the registered application */
+struct fh_ioctl_parm {
+	int pid;
+	int sig;
+};
+
+#define FH_ERRNO	38
+
+/* IOCTL numbers */
+/* If you add a new IOCTL number don't forget to update FH_MAXNR */
+#define FH_MAGIC	0x35
+#define FH_REGISTER	_IO(FH_MAGIC,0)
+#define FH_UNREGISTER	_IO(FH_MAGIC,1)
+
+#define FH_MAXNR 	1
+
+#endif				/* !(FORK_HISTORIC_H) */


