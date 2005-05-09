Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263074AbVEIIIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263074AbVEIIIL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 04:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263075AbVEIIIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 04:08:11 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:5830 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S263074AbVEIIHU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 04:07:20 -0400
Subject: [PATCH 2.6.12-rc3-mm3] connector: add a fork connector
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Jay Lan <jlan@engr.sgi.com>,
       aq <aquynh@gmail.com>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
Date: Mon, 09 May 2005 10:07:09 +0200
Message-Id: <1115626029.8548.24.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/05/2005 10:17:43,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/05/2005 10:17:44,
	Serialize complete at 09/05/2005 10:17:44
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  This patch adds a fork connector in the do_fork() routine. It sends a
netlink datagram when enabled. The message can be read by a user space
application. By this way, the user space application is alerted when a
fork occurs. Informations sent by the kernel are the processor ID where
the fork occurred, the pid of the parent and the pid of the child. 

  It uses the userspace <-> kernelspace connector that works on top of
the netlink protocol. The fork connector can be enable or disable by
sending a message to the connector.

  The fork connector is used by the Enhanced Linux System Accounting
project http://elsa.sourceforge.net

  This patch applies to 2.6.12-rc3-mm3

Best Regards,
Guillaume

Signed-off-by: Guillaume Thouvenin <guillaume.thouvenin@bull.net>

---

 drivers/connector/Kconfig   |   11 ++++
 drivers/connector/Makefile  |    1
 drivers/connector/cn_fork.c |  114 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/cn_fork.h     |   86 +++++++++++++++++++++++++++++++++
 include/linux/connector.h   |    2
 kernel/fork.c               |   11 ++++
 6 files changed, 225 insertions(+)


Index: linux-2.6.12-rc3-mm3/drivers/connector/Kconfig
===================================================================
--- linux-2.6.12-rc3-mm3.orig/drivers/connector/Kconfig	2005-05-09 07:45:52.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/connector/Kconfig	2005-05-09 08:03:15.000000000 +0200
@@ -10,4 +10,15 @@ config CONNECTOR
 	  Connector support can also be built as a module.  If so, the module
 	  will be called cn.ko.
 
+config FORK_CONNECTOR
+	bool "Enable fork connector"
+	select CONNECTOR
+	default y
+	---help---
+	  It adds a connector in kernel/fork.c:do_fork() function. When a fork
+	  occurs, netlink is used to transfer information about the parent and 
+	  its child. This information can be used by a user space application.
+	  The fork connector can be enable/disable by sending a message to the
+	  connector with the corresponding group id.
+	  
 endmenu
Index: linux-2.6.12-rc3-mm3/drivers/connector/Makefile
===================================================================
--- linux-2.6.12-rc3-mm3.orig/drivers/connector/Makefile	2005-05-09 07:45:52.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/connector/Makefile	2005-05-09 08:03:15.000000000 +0200
@@ -1,2 +1,3 @@
 obj-$(CONFIG_CONNECTOR)		+= cn.o
+obj-$(CONFIG_FORK_CONNECTOR)	+= cn_fork.o 
 cn-objs		:= cn_queue.o connector.o
Index: linux-2.6.12-rc3-mm3/drivers/connector/cn_fork.c
===================================================================
--- linux-2.6.12-rc3-mm3.orig/drivers/connector/cn_fork.c	2003-01-30 11:24:37.000000000 +0100
+++ linux-2.6.12-rc3-mm3/drivers/connector/cn_fork.c	2005-05-09 08:03:15.000000000 +0200
@@ -0,0 +1,114 @@
+/*
+ * cn_fork.c - Fork connector
+ *
+ * Copyright (C) 2005 BULL SA.
+ * Written by Guillaume Thouvenin <guillaume.thouvenin@bull.net>
+ * 
+ * This module implements the fork connector. It allows to send a
+ * netlink datagram, when enabled, from the do_fork() routine. The 
+ * message can be read by a user space application. By this way, 
+ * the user space application is alerted when a fork occurs.
+ *
+ * It uses the userspace <-> kernelspace connector that works on top of
+ * the netlink protocol. The fork connector is enabled or disabled by
+ * sending a message to the connector. The unique sequence number of
+ * messages can be used to check if a message is lost.  
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include <linux/cn_fork.h>
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Guillaume Thouvenin <guillaume.thouvenin@bull.net>");
+MODULE_DESCRIPTION("Enable or disable the usage of the fork connector");
+
+int cn_fork_enable = 0;
+struct cb_id cb_fork_id = { CN_IDX_FORK, CN_VAL_FORK };
+
+static inline void cn_fork_send_status(void)
+{
+	/*  TODO: An informational line in log is maybe not enough... */
+	printk(KERN_INFO "cn_fork_enable == %d\n", cn_fork_enable);
+}
+
+/**
+ * cn_fork_callback - enable or disable the fork connector
+ * @data: message send by the connector 
+ *
+ * The callback allows to enable or disable the sending of information
+ * about fork in the do_fork() routine. To enable the fork, the user 
+ * space application must send the integer 1 in the data part of the 
+ * message. To disable the fork connector, it must send the integer 0.
+ */
+static void cn_fork_callback(void *data) 
+{
+	struct cn_msg *msg = data;
+	int action;
+
+	if (cn_already_initialized && (msg->len == sizeof(cn_fork_enable))) {
+		memcpy(&action, msg->data, sizeof(cn_fork_enable));
+		switch(action) {
+			case FORK_CN_START:
+				cn_fork_enable = 1;
+				break;
+			case FORK_CN_STOP:
+				cn_fork_enable = 0;
+				break;
+			case FORK_CN_STATUS:
+				cn_fork_send_status();
+				break;
+		}
+	}
+}
+
+/**
+ * cn_fork_init - initialization entry point
+ *
+ * This routine will be run at kernel boot time because this driver is
+ * built in the kernel. It adds the connector callback to the connector 
+ * driver.
+ */
+static int cn_fork_init(void)
+{
+	int err;
+	
+	err = cn_add_callback(&cb_fork_id, "cn_fork", &cn_fork_callback);
+	if (err) {
+		printk(KERN_WARNING "Failed to register cn_fork\n");
+		return -EINVAL;
+	}	
+		
+	printk(KERN_NOTICE "cn_fork is registered\n");
+	return 0;
+}
+
+/**
+ * cn_fork_exit - exit entry point
+ *
+ * As this driver is always statically compiled into the kernel the
+ * cn_fork_exit has no effect.
+ */
+static void cn_fork_exit(void)
+{
+	cn_del_callback(&cb_fork_id);
+}
+
+module_init(cn_fork_init);
+module_exit(cn_fork_exit);
Index: linux-2.6.12-rc3-mm3/include/linux/cn_fork.h
===================================================================
--- linux-2.6.12-rc3-mm3.orig/include/linux/cn_fork.h	2003-01-30 11:24:37.000000000 +0100
+++ linux-2.6.12-rc3-mm3/include/linux/cn_fork.h	2005-05-09 09:50:28.000000000 +0200
@@ -0,0 +1,86 @@
+/*
+ * cn_fork.h - Fork connector
+ *
+ * Copyright (C) 2005 Nguyen Anh Quynh <aquynh@gmail.com>
+ * Copyright (C) 2005 Guillaume Thouvenin <guillaume.thouvenin@bull.net>
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef CN_FORK_H
+#define CN_FORK_H
+
+#include <linux/connector.h>
+
+#define FORK_CN_STOP	0
+#define FORK_CN_START	1
+#define FORK_CN_STATUS	2
+
+struct cn_fork_msg
+{
+	int cpu;	/* ID of the cpu where the fork occured */
+	pid_t ppid;	/* the parent PID */
+	pid_t cpid;	/* the child PID  */
+};
+
+/* Code above is only inside the kernel */
+#ifdef __KERNEL__
+
+extern int cn_already_initialized;
+
+#ifdef CONFIG_FORK_CONNECTOR
+
+#define CN_FORK_INFO_SIZE	sizeof(struct cn_fork_msg)
+#define CN_FORK_MSG_SIZE 	(sizeof(struct cn_msg) + CN_FORK_INFO_SIZE)
+
+extern int cn_fork_enable;
+extern struct cb_id cb_fork_id;
+
+DECLARE_PER_CPU(unsigned long, fork_counts);
+
+static inline void fork_connector(pid_t parent, pid_t child)
+{
+	if (cn_fork_enable) {
+		struct cn_msg *msg;
+		struct cn_fork_msg *forkmsg;
+		__u8 buffer[CN_FORK_MSG_SIZE];	
+
+		msg = (struct cn_msg *)buffer;
+			
+		memcpy(&msg->id, &cb_fork_id, sizeof(msg->id));
+		
+		msg->ack = 0; /* not used */
+		msg->seq = get_cpu_var(fork_counts)++;
+
+		msg->len = CN_FORK_INFO_SIZE;
+		forkmsg = (struct cn_fork_msg *)msg->data;
+		forkmsg->cpu = smp_processor_id();
+		forkmsg->ppid = parent;
+		forkmsg->cpid = child;
+
+		put_cpu_var(fork_counts);
+
+		cn_netlink_send(msg, CN_IDX_FORK, GFP_ATOMIC);
+	}
+}
+#else
+static inline void fork_connector(pid_t parent, pid_t child) 
+{
+	return; 
+}
+#endif /* CONFIG_FORK_CONNECTOR */
+#endif /* __KERNEL__ */
+
+#endif /* CN_FORK_H */
Index: linux-2.6.12-rc3-mm3/include/linux/connector.h
===================================================================
--- linux-2.6.12-rc3-mm3.orig/include/linux/connector.h	2005-05-09 07:45:56.000000000 +0200
+++ linux-2.6.12-rc3-mm3/include/linux/connector.h	2005-05-09 09:50:01.000000000 +0200
@@ -26,6 +26,8 @@
 
 #define CN_IDX_CONNECTOR		0xffffffff
 #define CN_VAL_CONNECTOR		0xffffffff
+#define CN_IDX_FORK			0xfeed  /* fork events */
+#define CN_VAL_FORK			0xbeef
 
 /*
  * Maximum connector's message size.
Index: linux-2.6.12-rc3-mm3/kernel/fork.c
===================================================================
--- linux-2.6.12-rc3-mm3.orig/kernel/fork.c	2005-05-09 07:45:56.000000000 +0200
+++ linux-2.6.12-rc3-mm3/kernel/fork.c	2005-05-09 08:03:15.000000000 +0200
@@ -41,6 +41,7 @@
 #include <linux/profile.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
+#include <linux/cn_fork.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -63,6 +64,14 @@ DEFINE_PER_CPU(unsigned long, process_co
 
 EXPORT_SYMBOL(tasklist_lock);
 
+#ifdef CONFIG_FORK_CONNECTOR
+/* 
+ * fork_counts is used by the fork_connector() inline routine as 
+ * the sequence number of the netlink message.
+ */
+static DEFINE_PER_CPU(unsigned long, fork_counts); 
+#endif /* CONFIG_FORK_CONNECTOR */
+
 int nr_processes(void)
 {
 	int cpu;
@@ -1252,6 +1261,8 @@ long do_fork(unsigned long clone_flags,
 			if (unlikely (current->ptrace & PT_TRACE_VFORK_DONE))
 				ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);
 		}
+		
+		fork_connector(current->pid, p->pid);
 	} else {
 		free_pidmap(pid);
 		pid = PTR_ERR(p);


