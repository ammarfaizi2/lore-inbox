Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263008AbVF3QyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263008AbVF3QyU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 12:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbVF3QyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 12:54:19 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:34043 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263006AbVF3Qw7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 12:52:59 -0400
Subject: exit notifier for 2.6.12-mm2
From: Badari Pulavarty <pbadari@us.ibm.com>
To: guillaume.thouvenin@bull.net, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-Wu9tkTbW18FFDDukHxZz"
Date: Thu, 30 Jun 2005 09:52:52 -0700
Message-Id: <1120150372.13376.136.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Wu9tkTbW18FFDDukHxZz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Here is the patch to add exit-notifier to the current connector
infrastructure in -mm tree. Its directly derived from Guillaume's 
fork notifier.

BTW, I have no direct need for it, heard that few people wanted it.

Thanks,
Badari 



--=-Wu9tkTbW18FFDDukHxZz
Content-Disposition: attachment; filename=exit-notifier.patch
Content-Type: text/x-patch; name=exit-notifier.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Narup -X /usr/src/dontdiff linux-2.6.12/drivers/connector/Kconfig linux-2.6.12.exit/drivers/connector/Kconfig
--- linux-2.6.12/drivers/connector/Kconfig	2005-06-29 16:29:03.000000000 -0700
+++ linux-2.6.12.exit/drivers/connector/Kconfig	2005-06-29 15:44:39.000000000 -0700
@@ -21,4 +21,14 @@ config FORK_CONNECTOR
 	  The fork connector can be enable/disable by sending a message to the
 	  connector with the corresponding group id.
 
+config EXIT_CONNECTOR
+	bool "Enable exit connector"
+	select CONNECTOR
+	default y
+	---help---
+	  It adds a connector in kernel/exit.c:do_exit() function. When a exit
+	  occurs, netlink is used to transfer information about the process and
+	  its parent. This information can be used by a user space application.
+	  The exit connector can be enable/disable by sending a message to the
+	  connector with the corresponding group id.
 endmenu
diff -Narup -X /usr/src/dontdiff linux-2.6.12/drivers/connector/Makefile linux-2.6.12.exit/drivers/connector/Makefile
--- linux-2.6.12/drivers/connector/Makefile	2005-06-29 16:29:03.000000000 -0700
+++ linux-2.6.12.exit/drivers/connector/Makefile	2005-06-29 15:44:59.000000000 -0700
@@ -1,3 +1,4 @@
 obj-$(CONFIG_CONNECTOR)		+= cn.o
 obj-$(CONFIG_FORK_CONNECTOR)	+= cn_fork.o
+obj-$(CONFIG_EXIT_CONNECTOR)	+= cn_exit.o
 cn-objs		:= cn_queue.o connector.o
diff -Narup -X /usr/src/dontdiff linux-2.6.12/drivers/connector/cn_exit.c linux-2.6.12.exit/drivers/connector/cn_exit.c
--- linux-2.6.12/drivers/connector/cn_exit.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.12.exit/drivers/connector/cn_exit.c	2005-06-29 16:23:05.000000000 -0700
@@ -0,0 +1,166 @@
+/*
+ * cn_exit.c - Exit connector
+ *
+ * Copyright (C) 2005 IBM Corporation
+ * Author: Badari Pulavarty <pbadari@us.ibm.com>
+ *
+ * derived from connector/cn_fork.c - Copyright (C) 2005 BULL SA.
+ *
+ * This module implements the exit connector. It allows to send a
+ * netlink datagram, when enabled, from the do_exit() routine. The
+ * message can be read by a user space application. By this way,
+ * the user space application is alerted when a exit occurs.
+ *
+ * It uses the userspace <-> kernelspace connector that works on top of
+ * the netlink protocol. The exit connector is enabled or disabled by
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
+#include <linux/cn_exit.h>
+
+#define CN_EXIT_INFO_SIZE	sizeof(struct cn_exit_msg)
+#define CN_EXIT_MSG_SIZE 	(sizeof(struct cn_msg) + CN_EXIT_INFO_SIZE)
+
+static int cn_exit_enable = 0;
+struct cb_id cb_exit_id = { CN_IDX_EXIT, CN_VAL_EXIT };
+
+/* exit_counts is used as the sequence number of the netlink message */
+static DEFINE_PER_CPU(unsigned long, exit_counts);
+
+/**
+ * exit_connector - send information about exit through a connector
+ * @pid: Process ID
+ * @ptid: Process thread ID
+ * @code: Process exit code
+ *
+ * It sends information to a user space application through the
+ * connector when a new process is created.
+ */
+void exit_connector(pid_t pid, pid_t ptid, long code)
+{
+	if (cn_exit_enable) {
+		struct cn_msg *msg;
+		struct cn_exit_msg *exitmsg;
+		__u8 buffer[CN_EXIT_MSG_SIZE];
+
+		msg = (struct cn_msg *)buffer;
+
+		memcpy(&msg->id, &cb_exit_id, sizeof(msg->id));
+
+		msg->ack = 0;	/* not used */
+		msg->seq = get_cpu_var(exit_counts)++;
+
+		msg->len = CN_EXIT_INFO_SIZE;
+		exitmsg = (struct cn_exit_msg *)msg->data;
+		exitmsg->type = EXIT_CN_MSG_P;
+		exitmsg->cpu = smp_processor_id();
+		exitmsg->u.s.pid = pid;
+		exitmsg->u.s.ptid = ptid;
+		exitmsg->u.s.code = code;
+
+		put_cpu_var(exit_counts);
+
+		/*  If cn_netlink_send() failed, the data is not send */
+		cn_netlink_send(msg, CN_IDX_EXIT, GFP_KERNEL);
+	}
+}
+
+/**
+ * cn_exit_send_status - send a message with the status
+ *
+ * It sends information about the status of the exit connector
+ * to a user space application through the connector. The status
+ * is stored in the global variable "cn_exit_enable".
+ */
+static inline void cn_exit_send_status(void)
+{
+	struct cn_msg *msg;
+	struct cn_exit_msg *exitmsg;
+	__u8 buffer[CN_EXIT_MSG_SIZE];
+
+	msg = (struct cn_msg *)buffer;
+
+	memcpy(&msg->id, &cb_exit_id, sizeof(msg->id));
+
+	msg->ack = 0;	/* not used */
+	msg->seq = 0;	/* not used */
+
+	msg->len = CN_EXIT_INFO_SIZE;
+	exitmsg = (struct cn_exit_msg *)msg->data;
+	exitmsg->type = EXIT_CN_MSG_S;
+	exitmsg->u.status = cn_exit_enable;
+
+	cn_netlink_send(msg, CN_IDX_EXIT, GFP_KERNEL);
+}
+
+/**
+ * cn_exit_callback - enable or disable the exit connector
+ * @data: message send by the connector
+ *
+ * The callback allows to enable or disable the sending of information
+ * about exit in the do_exit() routine. To enable the exit, the user
+ * space application must send the integer 1 in the data part of the
+ * message. To disable the exit connector, it must send the integer 0.
+ */
+static void cn_exit_callback(void *data)
+{
+	struct cn_msg *msg = data;
+	int action;
+
+	if (cn_already_initialized && (msg->len == sizeof(cn_exit_enable))) {
+		memcpy(&action, msg->data, sizeof(cn_exit_enable));
+		switch (action) {
+		case EXIT_CN_START:
+			cn_exit_enable = 1;
+			break;
+		case EXIT_CN_STOP:
+			cn_exit_enable = 0;
+			break;
+		case EXIT_CN_STATUS:
+			cn_exit_send_status();
+			break;
+		}
+	}
+}
+
+/**
+ * cn_exit_init - initialization entry point
+ *
+ * This routine will be run at kernel boot time because this driver is
+ * built in the kernel. It adds the connector callback to the connector
+ * driver.
+ */
+int __init cn_exit_init(void)
+{
+	int err;
+
+	err = cn_add_callback(&cb_exit_id, "cn_exit", &cn_exit_callback);
+	if (err) {
+		printk(KERN_WARNING "Failed to register cn_exit\n");
+		return -EINVAL;
+	}
+
+	printk(KERN_NOTICE "cn_exit is registered\n");
+	return 0;
+}
+
+__initcall(cn_exit_init);
diff -Narup -X /usr/src/dontdiff linux-2.6.12/include/linux/cn_exit.h linux-2.6.12.exit/include/linux/cn_exit.h
--- linux-2.6.12/include/linux/cn_exit.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.12.exit/include/linux/cn_exit.h	2005-06-29 16:30:46.000000000 -0700
@@ -0,0 +1,65 @@
+/*
+ * cn_exit.h - Exit connector
+ *
+ * Copyright (C) 2005 IBM Corporation
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
+#ifndef CN_EXIT_H
+#define CN_EXIT_H
+
+#include <linux/types.h>
+#include <linux/connector.h>
+
+#define EXIT_CN_STOP	0
+#define EXIT_CN_START	1
+#define EXIT_CN_STATUS	2
+
+#define EXIT_CN_MSG_P   0  /* Message about processes */
+#define EXIT_CN_MSG_S   1  /* Message about exit connector's state */
+
+/*
+ * The exit connector sends information to a user-space
+ * application. From the user's point of view, the process
+ * ID is the thread group ID and thread ID is the internal
+ * kernel "pid". So, fields are assigned as follow:
+ */
+struct cn_exit_msg {
+	int type;	/* 0: information about processes
+			   1: exit connector's state      */
+	int cpu;	/* ID of the cpu where the exit occurred */
+	union {
+		struct {
+			pid_t pid;	/* process ID */
+			pid_t ptid;	/* process thread ID  */
+			pid_t code;	/* process exit code */
+		} s;
+		int status;
+	} u;
+};
+
+/* Code above is only inside the kernel */
+#ifdef __KERNEL__
+#ifdef CONFIG_EXIT_CONNECTOR
+extern void exit_connector(pid_t pid, pid_t ptid, long code);
+#else
+static inline void exit_connector(pid_t ppid, pid_t ptid, long code)
+{
+	return;
+}
+#endif				/* CONFIG_EXIT_CONNECTOR */
+#endif				/* __KERNEL__ */
+#endif				/* CN_EXIT_H */
diff -Narup -X /usr/src/dontdiff linux-2.6.12/include/linux/connector.h linux-2.6.12.exit/include/linux/connector.h
--- linux-2.6.12/include/linux/connector.h	2005-06-29 16:29:07.000000000 -0700
+++ linux-2.6.12.exit/include/linux/connector.h	2005-06-29 16:03:19.000000000 -0700
@@ -29,6 +29,9 @@
 #define CN_IDX_FORK			0xfeed  /* fork events */
 #define CN_VAL_FORK			0xbeef
 
+#define CN_IDX_EXIT			0xfeec  /* exit events */
+#define CN_VAL_EXIT			0xceef
+
 /*
  * Maximum connector's message size.
  */
diff -Narup -X /usr/src/dontdiff linux-2.6.12/kernel/exit.c linux-2.6.12.exit/kernel/exit.c
--- linux-2.6.12/kernel/exit.c	2005-06-29 16:29:07.000000000 -0700
+++ linux-2.6.12.exit/kernel/exit.c	2005-06-29 16:07:50.000000000 -0700
@@ -803,6 +803,7 @@ fastcall NORET_TYPE void do_exit(long co
 	if (tsk->io_context)
 		exit_io_context();
 
+	exit_connector(tsk->tgid, tsk->pid, code);
 	if (unlikely(current->ptrace & PT_TRACE_EXIT)) {
 		current->ptrace_message = code;
 		ptrace_notify((PTRACE_EVENT_EXIT << 8) | SIGTRAP);

--=-Wu9tkTbW18FFDDukHxZz--

