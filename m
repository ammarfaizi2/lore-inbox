Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbUL3Coc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbUL3Coc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 21:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbUL3Coc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 21:44:32 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:63716 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261522AbUL3Cn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 21:43:26 -0500
Subject: [PATCH] [request for inclusion] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       "Jack O'Quin" <joq@io.com>
Content-Type: text/plain
Date: Wed, 29 Dec 2004 21:43:22 -0500
Message-Id: <1104374603.9732.32.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The realtime LSM has been previously explained on this list.  Its
function is to allow selected nonroot users to run RT tasks.  The most
common application is low latency audio with JACK, http://jackit.sf.net.

Several people have reported that 2.6.10 is the best kernel yet for
audio latency, see
http://ccrma-mail.stanford.edu/pipermail/planetccrma/2004-December/007341.html.    If the realtime LSM were merged, then this would be the last step to making low latency audio work well with the stock kernel.

We (the authors and the Linux audio community) would like to request its
inclusion in the next -mm release, with the eventual goal of having it
in mainline.

This is identical to the last version Jack O'Quin posted (but didn't cc:
Andrew, or make clear that we would like this added to -mm), so I
preserved his Signed-Off-By.

http://lkml.org/lkml/2004/11/24/242

Signed-Off-By: Jack O'Quin <joq@joq.us>

diff -ruN -X /home/joq/bin/kdiff.exclude linux-2.6.10-rc2-mm3/Documentation/realtime-lsm.txt linux-2.6.10-rc2-mm3-rt2/Documentation/realtime-lsm.txt
--- linux-2.6.10-rc2-mm3/Documentation/realtime-lsm.txt	Wed Dec 31 18:00:00 1969
+++ linux-2.6.10-rc2-mm3-rt2/Documentation/realtime-lsm.txt	Wed Nov 24 09:58:29 2004
@@ -0,0 +1,39 @@
+
+		    Realtime Linux Security Module
+
+
+This Linux Security Module (LSM) enables realtime capabilities.  It
+was written by Torben Hohn and Jack O'Quin, under the provisions of
+the GPL (see the COPYING file).  We make no warranty concerning the
+safety, security or even stability of your system when using it.  But,
+we will fix problems if you report them.
+
+Once the LSM has been installed and the kernel for which it was built
+is running, the root user can load it and pass parameters as follows:
+
+  # modprobe realtime any=1
+
+  Any program can request realtime privileges.  This allows any local
+  user to crash the system by hogging the CPU in a tight loop or
+  locking down too much memory.  But, it is simple to administer.  :-)
+
+  # modprobe realtime gid=29
+
+  All users belonging to group 29 and programs that are setgid to that
+  group have realtime privileges.  Use any group number you like.  A
+  `gid' of -1 disables group access.
+
+  # modprobe realtime mlock=0
+
+  Grants realtime scheduling privileges without the ability to lock
+  memory using mlock() or mlockall() system calls.  This option can be
+  used in conjunction with any of the other options.
+
+After the module is loaded, its parameters can be changed dynamically
+via sysfs.
+
+  # echo 1  > /sys/module/realtime/parameters/any
+  # echo 29 > /sys/module/realtime/parameters/gid
+  # echo 1  > /sys/module/realtime/parameters/mlock
+
+Jack O'Quin, joq@joq.us
diff -ruN -X /home/joq/bin/kdiff.exclude linux-2.6.10-rc2-mm3/security/Kconfig linux-2.6.10-rc2-mm3-rt2/security/Kconfig
--- linux-2.6.10-rc2-mm3/security/Kconfig	Wed Nov 24 09:35:44 2004
+++ linux-2.6.10-rc2-mm3-rt2/security/Kconfig	Wed Nov 24 09:58:29 2004
@@ -84,6 +84,17 @@
 
 	  If you are unsure how to answer this question, answer N.
 
+config SECURITY_REALTIME
+	tristate "Realtime Capabilities"
+	depends on SECURITY && SECURITY_CAPABILITIES!=y
+	default n
+	help
+	  This module selectively grants realtime privileges
+	  controlled by parameters set at load time or via files in
+	  /sys/module/realtime/parameters.
+
+	  If you are unsure how to answer this question, answer N.
+
 source security/selinux/Kconfig
 
 endmenu
diff -ruN -X /home/joq/bin/kdiff.exclude linux-2.6.10-rc2-mm3/security/Makefile linux-2.6.10-rc2-mm3-rt2/security/Makefile
--- linux-2.6.10-rc2-mm3/security/Makefile	Wed Nov 24 09:35:44 2004
+++ linux-2.6.10-rc2-mm3-rt2/security/Makefile	Wed Nov 24 09:58:29 2004
@@ -17,3 +17,4 @@
 obj-$(CONFIG_SECURITY_CAPABILITIES)	+= commoncap.o capability.o
 obj-$(CONFIG_SECURITY_ROOTPLUG)		+= commoncap.o root_plug.o
 obj-$(CONFIG_SECURITY_SECLVL)		+= seclvl.o
+obj-$(CONFIG_SECURITY_REALTIME)		+= commoncap.o realtime.o
diff -ruN -X /home/joq/bin/kdiff.exclude linux-2.6.10-rc2-mm3/security/realtime.c linux-2.6.10-rc2-mm3-rt2/security/realtime.c
--- linux-2.6.10-rc2-mm3/security/realtime.c	Wed Dec 31 18:00:00 1969
+++ linux-2.6.10-rc2-mm3-rt2/security/realtime.c	Wed Nov 24 09:59:01 2004
@@ -0,0 +1,147 @@
+/*
+ * Realtime Capabilities Linux Security Module
+ *
+ *  Copyright (C) 2003 Torben Hohn
+ *  Copyright (C) 2003, 2004 Jack O'Quin
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation; either version 2 of the License, or
+ *	(at your option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/security.h>
+
+#define RT_LSM "Realtime LSM "		/* syslog module name prefix */
+#define RT_ERR "Realtime: "		/* syslog error message prefix */
+
+#include <linux/vermagic.h>
+MODULE_INFO(vermagic,VERMAGIC_STRING);
+
+/* module parameters
+ *
+ *  These values could change at any time due to some process writing
+ *  a new value in /sys/module/realtime/parameters.  This is OK,
+ *  because each is referenced only once in each function call.
+ *  Nothing depends on parameters having the same value every time.
+ */
+
+/* if TRUE, any process is realtime */
+static int rt_any;
+module_param_named(any, rt_any, int, 0644);
+MODULE_PARM_DESC(any, " grant realtime privileges to any process.");
+
+/* realtime group id, or NO_GROUP */
+static int rt_gid = -1;
+module_param_named(gid, rt_gid, int, 0644);
+MODULE_PARM_DESC(gid, " the group ID with access to realtime privileges.");
+
+/* enable mlock() privileges */
+static int rt_mlock = 1;
+module_param_named(mlock, rt_mlock, int, 0644);
+MODULE_PARM_DESC(mlock, " enable memory locking privileges.");
+
+/* helper function for testing group membership */
+static inline int gid_ok(int gid)
+{
+	if (gid == -1)
+		return 0;
+
+	if (gid == current->gid)
+		return 1;
+
+	return in_egroup_p(gid);
+}
+
+static void realtime_bprm_apply_creds(struct linux_binprm *bprm, int unsafe)
+{
+	cap_bprm_apply_creds(bprm, unsafe);
+
+	/*  If a non-zero `any' parameter was specified, we grant
+	 *  realtime privileges to every process.  If the `gid'
+	 *  parameter was specified and it matches the group id of the
+	 *  executable, of the current process or any supplementary
+	 *  groups, we grant realtime capabilites.
+	 */
+
+	if (rt_any || gid_ok(rt_gid)) {
+		cap_raise(current->cap_effective, CAP_SYS_NICE);
+		if (rt_mlock) {
+			cap_raise(current->cap_effective, CAP_IPC_LOCK);
+			cap_raise(current->cap_effective, CAP_SYS_RESOURCE);
+		}
+	}
+}
+
+static struct security_operations capability_ops = {
+	.ptrace =			cap_ptrace,
+	.capget =			cap_capget,
+	.capset_check =			cap_capset_check,
+	.capset_set =			cap_capset_set,
+	.capable =			cap_capable,
+	.netlink_send =			cap_netlink_send,
+	.netlink_recv =			cap_netlink_recv,
+	.bprm_apply_creds =		realtime_bprm_apply_creds,
+	.bprm_set_security =		cap_bprm_set_security,
+	.bprm_secureexec =		cap_bprm_secureexec,
+	.task_post_setuid =		cap_task_post_setuid,
+	.task_reparent_to_init =	cap_task_reparent_to_init,
+	.syslog =                       cap_syslog,
+	.vm_enough_memory =             cap_vm_enough_memory,
+};
+
+#define MY_NAME __stringify(KBUILD_MODNAME)
+
+static int secondary;	/* flag to keep track of how we were registered */
+
+static int __init realtime_init(void)
+{
+	/* register ourselves with the security framework */
+	if (register_security(&capability_ops)) {
+
+		/* try registering with primary module */
+		if (mod_reg_security(MY_NAME, &capability_ops)) {
+			printk(KERN_INFO RT_ERR "Failure registering "
+			       "capabilities with primary security module.\n");
+			printk(KERN_INFO RT_ERR "Is kernel configured "
+			       "with CONFIG_SECURITY_CAPABILITIES=m?\n");
+			return -EINVAL;
+		}
+		secondary = 1;
+	}
+
+	if (rt_any)
+		printk(KERN_INFO RT_LSM
+		       "initialized (all groups, mlock=%d)\n", rt_mlock);
+	else if (rt_gid == -1)
+		printk(KERN_INFO RT_LSM
+		       "initialized (no groups, mlock=%d)\n", rt_mlock);
+	else
+		printk(KERN_INFO RT_LSM
+		       "initialized (group %d, mlock=%d)\n", rt_gid, rt_mlock);
+		
+	return 0;
+}
+
+static void __exit realtime_exit(void)
+{
+	/* remove ourselves from the security framework */
+	if (secondary) {
+		if (mod_unreg_security(MY_NAME, &capability_ops))
+			printk(KERN_INFO RT_ERR "Failure unregistering "
+				"capabilities with primary module.\n");
+
+	} else if (unregister_security(&capability_ops)) {
+		printk(KERN_INFO RT_ERR
+		       "Failure unregistering capabilities with the kernel\n");
+	}
+	printk(KERN_INFO "Realtime Capability LSM exiting\n");
+}
+
+late_initcall(realtime_init);
+module_exit(realtime_exit);
+
+MODULE_DESCRIPTION("Realtime Capabilities Security Module");
+MODULE_LICENSE("GPL");

-- 
  joq



