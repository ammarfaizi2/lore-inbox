Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbVBXK2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbVBXK2M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 05:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVBXK1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 05:27:18 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:41092 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262164AbVBXKYo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 05:24:44 -0500
Subject: [PATCH 2.6.11-rc4-mm1] connector: Add a fork connector
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Jay Lan <jlan@engr.sgi.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Erich Focht <efocht@hpce.nec.com>
Date: Thu, 24 Feb 2005 11:24:37 +0100
Message-Id: <1109240677.1738.196.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 24/02/2005 11:33:31,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 24/02/2005 11:33:35,
	Serialize complete at 24/02/2005 11:33:35
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This patch replaces the relay_fork module and it implements a fork
connector in the kernel/fork.c:do_fork() routine. It applies on a kernel
2.6.11-rc4-mm1. The connector sends information about parent PID and
child PID over a netlink interface. It allows to several user space
applications to be informed when a fork occurs in the kernel. The main
drawback is that even if nobody listens, message is send. I don't know
how to avoid that.
     
  It is used by ELSA to manage group of processes in user space and can
be used by any other user space application that needs this kind of
information.

  I add a callback that turns on/off the fork connector. It's a very
simple mechanism and, as Evgeniy suggested, it may need a more complex
protocol.  

  ChangeLog:

    - "fork_id" is now declared as a static const
    - Replace snprintf() by scnprintf()
    - Protect "seq" by a spin lock because the seq number can be
      used by the daemon to check if all forks are intercepted 
    - "msg" send is now local
    - Add a callback that turns on/off the fork connector.
    - memset is only used to clear the msg->data part instead of all
      message. 

  Todo:

    - Test the performance impact with lmbench
    - Improve the callback that turns on/off the fork connector
    - Create a specific module to register the callback.

Thanks to Andrew, Evgeniy and everyone for the comments,
Guillaume

Signed-off-by: Guillaume Thouvenin <guillaume.thouvenin@bull.net>

---

 drivers/connector/Kconfig     |   11 ++++++++++
 drivers/connector/connector.c |   20 ++++++++++++++++++
 include/linux/connector.h     |    3 ++
 kernel/fork.c                 |   45 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+)

diff -uprN -X dontdiff linux-2.6.11-rc4-mm1/drivers/connector/connector.c linux-2.6.11-rc4-mm1-cnfork/drivers/connector/connector.c
--- linux-2.6.11-rc4-mm1/drivers/connector/connector.c	2005-02-23 11:12:15.000000000 +0100
+++ linux-2.6.11-rc4-mm1-cnfork/drivers/connector/connector.c	2005-02-24 10:21:59.000000000 +0100
@@ -45,8 +45,10 @@ static DEFINE_SPINLOCK(notify_lock);
 static LIST_HEAD(notify_list);
 
 static struct cn_dev cdev;
+static struct cb_id cn_fork_id = { CN_IDX_FORK, CN_VAL_FORK };
 
 int cn_already_initialized = 0;
+int cn_fork_enable = 0;
 
 /*
  * msg->seq and msg->ack are used to determine message genealogy.
@@ -467,6 +469,14 @@ static void cn_callback(void * data)
 	}
 }
 
+static void cn_fork_callback(void *data) 
+{
+	if (cn_already_initialized)
+		cn_fork_enable = cn_fork_enable ? 0 : 1;
+		
+	printk(KERN_NOTICE "cn_fork_enable is set to %i\n", cn_fork_enable);
+}
+
 static int cn_init(void)
 {
 	struct cn_dev *dev = &cdev;
@@ -498,6 +508,15 @@ static int cn_init(void)
 		return -EINVAL;
 	}
 
+	err = cn_add_callback(&cn_fork_id, "cn_fork", &cn_fork_callback);
+	if (err) {
+		cn_del_callback(&dev->id);
+		cn_queue_free_dev(dev->cbdev);
+		if (dev->nls->sk_socket)
+			sock_release(dev->nls->sk_socket);
+		return -EINVAL;
+	}
+	
 	cn_already_initialized = 1;
 
 	return 0;
@@ -507,6 +526,7 @@ static void cn_fini(void)
 {
 	struct cn_dev *dev = &cdev;
 
+	cn_del_callback(&cn_fork_id);
 	cn_del_callback(&dev->id);
 	cn_queue_free_dev(dev->cbdev);
 	if (dev->nls->sk_socket)
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
diff -uprN -X dontdiff linux-2.6.11-rc4-mm1/include/linux/connector.h linux-2.6.11-rc4-mm1-cnfork/include/linux/connector.h
--- linux-2.6.11-rc4-mm1/include/linux/connector.h	2005-02-23 11:12:17.000000000 +0100
+++ linux-2.6.11-rc4-mm1-cnfork/include/linux/connector.h	2005-02-24 10:25:22.000000000 +0100
@@ -28,6 +28,8 @@
 #define CN_VAL_KOBJECT_UEVENT		0x0000
 #define CN_IDX_SUPERIO			0xaabb  /* SuperIO subsystem */
 #define CN_VAL_SUPERIO			0xccdd
+#define CN_IDX_FORK			0xfeed  /* fork events */
+#define CN_VAL_FORK			0xbeef
 
 
 #define CONNECTOR_MAX_MSG_SIZE 	1024
@@ -133,6 +135,7 @@ struct cn_dev
 };
 
 extern int cn_already_initialized;
+extern int cn_fork_enable;
 
 int cn_add_callback(struct cb_id *, char *, void (* callback)(void *));
 void cn_del_callback(struct cb_id *);
diff -uprN -X dontdiff linux-2.6.11-rc4-mm1/kernel/fork.c linux-2.6.11-rc4-mm1-cnfork/kernel/fork.c
--- linux-2.6.11-rc4-mm1/kernel/fork.c	2005-02-23 11:12:17.000000000 +0100
+++ linux-2.6.11-rc4-mm1-cnfork/kernel/fork.c	2005-02-24 10:27:02.000000000 +0100
@@ -41,6 +41,7 @@
 #include <linux/profile.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
+#include <linux/connector.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -63,6 +64,48 @@ DEFINE_PER_CPU(unsigned long, process_co
 
 EXPORT_SYMBOL(tasklist_lock);
 
+#ifdef CONFIG_FORK_CONNECTOR
+
+#define CN_FORK_INFO_SIZE	64
+#define CN_FORK_MSG_SIZE 	sizeof(struct cn_msg) + CN_FORK_INFO_SIZE
+
+spinlock_t fork_cn_lock = SPIN_LOCK_UNLOCKED;
+
+static inline void fork_connector(pid_t parent, pid_t child)
+{
+	static const struct cb_id fork_id = { CN_IDX_FORK, CN_VAL_FORK };
+	static __u32 seq;   /* used to test if message is lost */
+
+	if (cn_fork_enable) {
+		struct cn_msg *msg;
+		__u8 buffer[CN_FORK_MSG_SIZE];	
+
+		msg = (struct cn_msg *)buffer;
+			
+		memcpy(&msg->id, &fork_id, sizeof(msg->id));
+		spin_lock(&fork_cn_lock);
+		msg->seq = seq++;
+		spin_unlock(&fork_cn_lock);
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
@@ -1238,6 +1281,8 @@ long do_fork(unsigned long clone_flags,
 			if (unlikely (current->ptrace & PT_TRACE_VFORK_DONE))
 				ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);
 		}
+
+		fork_connector(current->pid, p->pid);
 	} else {
 		free_pidmap(pid);
 		pid = PTR_ERR(p);



