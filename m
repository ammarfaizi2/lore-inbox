Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVBWIwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVBWIwn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 03:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVBWIwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 03:52:43 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:13231 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261429AbVBWIwc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 03:52:32 -0500
Subject: Re: [PATCH 2.6.11-rc3-mm2] connector: Add a fork connector
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>, Erich Focht <efocht@hpce.nec.com>
In-Reply-To: <1108649153.8379.137.camel@frecb000711.frec.bull.fr>
References: <1108649153.8379.137.camel@frecb000711.frec.bull.fr>
Date: Wed, 23 Feb 2005 09:52:32 +0100
Message-Id: <1109148752.1738.105.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/02/2005 10:01:25,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/02/2005 10:01:27,
	Serialize complete at 23/02/2005 10:01:27
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  This patch replaces the relay_fork module and it implements a fork
connector in the kernel/fork.c:do_fork() routine. The connector sends
information about parent PID and child PID over a netlink interface. It
allows to several user space applications to be informed when a fork
occurs in the kernel. The main drawback is that even if nobody listens,
message is send. I don't know how to avoid that.
     
  It is used by ELSA to manage group of processes in user space.

  ChangeLog:

    - Add a "depends on CONNECTOR=y" in the Kconfig 
    - Remove the macro #if defined(CONFIG_CONNECTOR)
    - cn_netlink_send() sends messages to the correct group which is 
      CN_IDX_FORK


Thanks to Evgeniy and to everyone for the comments,
Guillaume

Signed-off-by: Guillaume Thouvenin <guillaume.thouvenin@bull.net>

---

 drivers/connector/Kconfig |    8 ++++++++
 include/linux/connector.h |    2 ++
 kernel/fork.c             |   41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff -uprN -X dontdiff linux-2.6.11-rc3-mm2/drivers/connector/Kconfig linux-2.6.11-rc3-mm2-cnfork/drivers/connector/Kconfig
--- linux-2.6.11-rc3-mm2/drivers/connector/Kconfig	2005-02-11 11:00:16.000000000 +0100
+++ linux-2.6.11-rc3-mm2-cnfork/drivers/connector/Kconfig	2005-02-21 09:52:22.000000000 +0100
@@ -10,4 +10,12 @@ config CONNECTOR
 	  Connector support can also be built as a module.  If so, the module
 	  will be called cn.ko.
 
+config FORK_CONNECTOR
+	bool "Enable fork connector"
+	depends on CONNECTOR=y
+	---help---
+	  It adds a connector in kernel/fork.c:do_fork() function. When a fork
+	  occurs, netlink is used to transfer information about the parent and 
+	  its child. This information can be used by a user space application. 
+	  
 endmenu
diff -uprN -X dontdiff linux-2.6.11-rc3-mm2/include/linux/connector.h linux-2.6.11-rc3-mm2-cnfork/include/linux/connector.h
--- linux-2.6.11-rc3-mm2/include/linux/connector.h	2005-02-11 11:00:18.000000000 +0100
+++ linux-2.6.11-rc3-mm2-cnfork/include/linux/connector.h	2005-02-16 15:07:46.000000000 +0100
@@ -28,6 +28,8 @@
 #define CN_VAL_KOBJECT_UEVENT		0x0000
 #define CN_IDX_SUPERIO			0xaabb  /* SuperIO subsystem */
 #define CN_VAL_SUPERIO			0xccdd
+#define CN_IDX_FORK			0xfeed  /* fork events */
+#define CN_VAL_FORK			0xbeef
 
 
 #define CONNECTOR_MAX_MSG_SIZE 	1024
diff -uprN -X dontdiff linux-2.6.11-rc3-mm2/kernel/fork.c linux-2.6.11-rc3-mm2-cnfork/kernel/fork.c
--- linux-2.6.11-rc3-mm2/kernel/fork.c	2005-02-11 11:00:18.000000000 +0100
+++ linux-2.6.11-rc3-mm2-cnfork/kernel/fork.c	2005-02-21 09:52:40.000000000 +0100
@@ -41,6 +41,7 @@
 #include <linux/profile.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
+#include <linux/connector.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -63,6 +64,44 @@ DEFINE_PER_CPU(unsigned long, process_co
 
 EXPORT_SYMBOL(tasklist_lock);
 
+#ifdef CONFIG_FORK_CONNECTOR
+#define FORK_CN_INFO_SIZE	64 
+static inline void fork_connector(pid_t parent, pid_t child)
+{
+	struct cb_id fork_id = {CN_IDX_FORK, CN_VAL_FORK};
+	static __u32 seq; /* used to test if we lost message */
+	
+	if (cn_already_initialized) {
+		struct cn_msg *msg;
+		size_t size;
+
+		size = sizeof(*msg) + FORK_CN_INFO_SIZE;
+		msg = kmalloc(size, GFP_KERNEL);
+		if (msg) {
+			memset(msg, '\0', size);
+			memcpy(&msg->id, &fork_id, sizeof(msg->id));
+			msg->seq = seq++;
+			msg->ack = 0; /* not used */
+			/* 
+			 * size of data is the number of characters 
+			 * printed plus one for the trailing '\0'
+			 */
+			msg->len = snprintf(msg->data, FORK_CN_INFO_SIZE-1, 
+					    "%i %i", parent, child) + 1;
+
+			cn_netlink_send(msg, CN_IDX_FORK);
+
+			kfree(msg);
+		}
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
@@ -1238,6 +1277,8 @@ long do_fork(unsigned long clone_flags,
 			if (unlikely (current->ptrace & PT_TRACE_VFORK_DONE))
 				ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);
 		}
+
+		fork_connector(current->pid, p->pid);
 	} else {
 		free_pidmap(pid);
 		pid = PTR_ERR(p);


