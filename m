Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVCHH3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVCHH3u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 02:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVCHH3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 02:29:50 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:9701 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261411AbVCHH3b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 02:29:31 -0500
Subject: Re: [PATCH 2.6.11-rc4-mm1] connector: Add a fork connector
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Jay Lan <jlan@engr.sgi.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Erich Focht <efocht@hpce.nec.com>, Kaigai Kohei <kaigai@ak.jp.nec.com>
In-Reply-To: <1109240677.1738.196.camel@frecb000711.frec.bull.fr>
References: <1109240677.1738.196.camel@frecb000711.frec.bull.fr>
Date: Tue, 08 Mar 2005 08:29:32 +0100
Message-Id: <1110266972.10433.27.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/03/2005 08:38:39,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/03/2005 08:38:42,
	Serialize complete at 08/03/2005 08:38:42
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

    This patch cannot be apply on a 2.6.11-mm1 because connector is
missing in this release. The connector module should be back in the next
kernel release. That's why it applies on a 2.6.11-rc4-mm1 tree. 

Also, there is a problem with the drivers/connector/connector.c file. 

The test 
    if (msg->len != nlh->nlmsg_len - sizeof(*msg) - sizeof(*nlh))
must be replaced by 
    if (NLMSG_SPACE(msg->len + sizeof(*msg)) != nlh->nlmsg_len)

 Without this change, there is a problem with the size of messages. It
should be fix in future version of the connector module.

  ChangeLog:
    - Add parenthesis around sizeof(struct cn_msg) + CN_FORK_INFO_SIZE
      in the CN_FORK_MSG_SIZE macro
    - fork_cn_lock is declared with DEFINE_SPINLOCK()
    - fork_cn_lock is defined as static and local to fork_connector()
    - Create a specific module cn_fork.c in drivers/connector to 
      register the callback
    - Improve the callback that turns on/off the fork connector. Now
      to enable the fork connector you need to send a message with 
      the length of the data equal to sizeof(int) and data is '1' to
      enable (or '0' to disable).

  TODO:
    - Run the lmbench with the user space application that manages
      group of processus. if fork connector is not used the only 
      overhead is a test in the do_fork() routine.


Thank you everyone for your comments,
Best regards,
Guillaume

Signed-off by: Guillaume Thouvenin <guillaume.thouvenin@bull.net>

---

 drivers/connector/Kconfig   |   11 +++++
 drivers/connector/Makefile  |    1
 drivers/connector/cn_fork.c |   85 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/connector.h   |    4 ++
 kernel/fork.c               |   44 ++++++++++++++++++++++
 5 files changed, 145 insertions(+)

diff -uprN -X dontdiff linux-2.6.11-rc4-mm1/drivers/connector/cn_fork.c linux-2.6.11-rc4-mm1-cnfork/drivers/connector/cn_fork.c
--- linux-2.6.11-rc4-mm1/drivers/connector/cn_fork.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-rc4-mm1-cnfork/drivers/connector/cn_fork.c	2005-03-01 13:13:05.000000000 +0100
@@ -0,0 +1,85 @@
+/*
+ * 	cn_fork.c
+ * 
+ * 2005 Copyright (c) Guillaume Thouvenin <guillaume.thouvenin@bull.net>
+ * All rights reserved.
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include <linux/connector.h>
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Guillaume Thouvenin <guillaume.thouvenin@bull.net>");
+MODULE_DESCRIPTION("Enable or disable the usage of the fork connector");
+
+int cn_fork_enable = 0;
+struct cb_id cb_fork_id = { CN_IDX_FORK, CN_VAL_FORK };
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
+	struct cn_msg *msg = (struct cn_msg *)data;
+
+	if (cn_already_initialized && (msg->len == sizeof(cn_fork_enable)))
+		memcpy(&cn_fork_enable, msg->data, sizeof(cn_fork_enable));
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
diff -uprN -X dontdiff linux-2.6.11-rc4-mm1/drivers/connector/Kconfig linux-2.6.11-rc4-mm1-cnfork/drivers/connector/Kconfig
--- linux-2.6.11-rc4-mm1/drivers/connector/Kconfig	2005-02-23 11:12:15.000000000 +0100
+++ linux-2.6.11-rc4-mm1-cnfork/drivers/connector/Kconfig	2005-02-24 10:29:11.000000000 +0100
@@ -10,4 +10,15 @@ config CONNECTOR
 	  Connector support can also be built as a module.  If so, the module
 	  will be called cn.ko.
 
+config FORK_CONNECTOR
+	bool "Enable fork connector"
+	depends on CONNECTOR=y
+	default y
+	---help---
+	  It adds a connector in kernel/fork.c:do_fork() function. When a fork
+	  occurs, netlink is used to transfer information about the parent and 
+	  its child. This information can be used by a user space application.
+	  The fork connector can be enable/disable by sending a message to the
+	  connector with the corresponding group id.
+	  
 endmenu
diff -uprN -X dontdiff linux-2.6.11-rc4-mm1/drivers/connector/Makefile linux-2.6.11-rc4-mm1-cnfork/drivers/connector/Makefile
--- linux-2.6.11-rc4-mm1/drivers/connector/Makefile	2005-02-23 11:12:15.000000000 +0100
+++ linux-2.6.11-rc4-mm1-cnfork/drivers/connector/Makefile	2005-02-25 13:49:57.000000000 +0100
@@ -1,2 +1,3 @@
 obj-$(CONFIG_CONNECTOR)		+= cn.o
+obj-$(CONFIG_FORK_CONNECTOR)	+= cn_fork.o 
 cn-objs		:= cn_queue.o connector.o
diff -uprN -X dontdiff linux-2.6.11-rc4-mm1/include/linux/connector.h linux-2.6.11-rc4-mm1-cnfork/include/linux/connector.h
--- linux-2.6.11-rc4-mm1/include/linux/connector.h	2005-02-23 11:12:17.000000000 +0100
+++ linux-2.6.11-rc4-mm1-cnfork/include/linux/connector.h	2005-03-01 12:44:50.000000000 +0100
@@ -28,6 +28,8 @@
 #define CN_VAL_KOBJECT_UEVENT		0x0000
 #define CN_IDX_SUPERIO			0xaabb  /* SuperIO subsystem */
 #define CN_VAL_SUPERIO			0xccdd
+#define CN_IDX_FORK			0xfeed  /* fork events */
+#define CN_VAL_FORK			0xbeef
 
 
 #define CONNECTOR_MAX_MSG_SIZE 	1024
@@ -133,6 +135,8 @@ struct cn_dev
 };
 
 extern int cn_already_initialized;
+extern int cn_fork_enable;
+extern struct cb_id cb_fork_id;
 
 int cn_add_callback(struct cb_id *, char *, void (* callback)(void *));
 void cn_del_callback(struct cb_id *);
diff -uprN -X dontdiff linux-2.6.11-rc4-mm1/kernel/fork.c linux-2.6.11-rc4-mm1-cnfork/kernel/fork.c
--- linux-2.6.11-rc4-mm1/kernel/fork.c	2005-02-23 11:12:17.000000000 +0100
+++ linux-2.6.11-rc4-mm1-cnfork/kernel/fork.c	2005-03-01 08:39:13.000000000 +0100
@@ -41,6 +41,7 @@
 #include <linux/profile.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
+#include <linux/connector.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -63,6 +64,47 @@ DEFINE_PER_CPU(unsigned long, process_co
 
 EXPORT_SYMBOL(tasklist_lock);
 
+#ifdef CONFIG_FORK_CONNECTOR
+
+#define CN_FORK_INFO_SIZE	64
+#define CN_FORK_MSG_SIZE 	(sizeof(struct cn_msg) + CN_FORK_INFO_SIZE)
+
+static inline void fork_connector(pid_t parent, pid_t child)
+{
+	static DEFINE_SPINLOCK(cn_fork_lock);
+	static __u32 seq;   /* used to test if message is lost */
+
+	if (cn_fork_enable) {
+		struct cn_msg *msg;
+
+		__u8 buffer[CN_FORK_MSG_SIZE];	
+
+		msg = (struct cn_msg *)buffer;
+			
+		memcpy(&msg->id, &cb_fork_id, sizeof(msg->id));
+		spin_lock(&cn_fork_lock);
+		msg->seq = seq++;
+		spin_unlock(&cn_fork_lock);
+		msg->ack = 0; /* not used */
+		/* 
+		 * size of data is the number of characters 
+		 * printed plus one for the trailing '\0'
+		 */
+		/* just fill the data part with '\0' */
+		memset(msg->data, '\0', CN_FORK_INFO_SIZE);
+		msg->len = scnprintf(msg->data, CN_FORK_INFO_SIZE-1, 
+				    "%i %i", parent, child) + 1;
+
+		cn_netlink_send(msg, CN_IDX_FORK);
+	}
+}
+#else
+static inline void fork_connector(pid_t parent, pid_t child) 
+{
+	return; 
+}
+#endif
+
 int nr_processes(void)
 {
 	int cpu;
@@ -1238,6 +1280,8 @@ long do_fork(unsigned long clone_flags,
 			if (unlikely (current->ptrace & PT_TRACE_VFORK_DONE))
 				ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);
 		}
+
+		fork_connector(current->pid, p->pid);
 	} else {
 		free_pidmap(pid);
 		pid = PTR_ERR(p);




