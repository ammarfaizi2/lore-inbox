Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268480AbUILFq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268480AbUILFq3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 01:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268482AbUILFq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 01:46:29 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:31897 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268480AbUILFqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 01:46:14 -0400
Subject: [PATCH] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: joq@io.com, torbenh@gmx.de
Content-Type: text/plain
Message-Id: <1094967978.1306.401.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 12 Sep 2004 01:46:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The realtime-lsm Linux Security Module, written by Torben Hohn and Jack
O'Quin, selectively grants realtime capabilities to specific user groups
or applications.  The typical use for this is low latency audio, and the
patch has been extensively field tested by Linux audio users.  The
realtime LSM is a major improvement in security over the 2.4 capablities
patch and other workarounds like jackstart, which rely on CAP_SETPCAP.

Lee

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

diff -ruN -X /home/joq/bin/kdiff.exclude linux-2.6.8.1/Documentation/realtime-lsm.txt linux-2.6.8.1-rt/Documentation/realtime-lsm.txt
--- linux-2.6.8.1/Documentation/realtime-lsm.txt	Wed Dec 31 18:00:00 1969
+++ linux-2.6.8.1-rt/Documentation/realtime-lsm.txt	Fri Sep 10 20:38:42 2004
@@ -0,0 +1,47 @@
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
+  group have realtime privileges.  Use any group number you like.
+
+  # modprobe realtime mlock=0
+
+  Grants realtime scheduling privileges without the ability to lock
+  memory using mlock() or mlockall() system calls.  This option can be
+  used in conjunction with any of the other options.
+
+  # modprobe realtime allcaps=1
+
+  Enables all capabilities, including CAP_SETPCAP.  This is equivalent
+  to the 2.4 kernel capabilities patch.  It is needed for root
+  programs to assign realtime capabilities to other processes.  This
+  option can be used in conjunction with any of the other options.
+
+  The JACK Audio Connection Kit (jackit.sourceforge.net) includes a
+  `jackstart' program which uses CAP_SETPCAP to run the JACK daemon
+  and its clients with realtime capabilities.
+
+  There are serious security exposures with CAP_SETPCAP.  If an
+  attacker manages to subvert some system daemon running with root
+  privileges, it can use this capability to deny needed privileges to
+  other root processes.
+
+Jack O'Quin, joq@joq.us
diff -ruN -X /home/joq/bin/kdiff.exclude linux-2.6.8.1/security/Kconfig linux-2.6.8.1-rt/security/Kconfig
--- linux-2.6.8.1/security/Kconfig	Sat Aug 14 05:55:47 2004
+++ linux-2.6.8.1-rt/security/Kconfig	Fri Sep 10 11:03:40 2004
@@ -44,6 +44,20 @@
 	  
 	  If you are unsure how to answer this question, answer N.
 
+config SECURITY_REALTIME
+	tristate "Realtime Capabilities"
+	depends on SECURITY && SECURITY_CAPABILITIES!=y
+	default n
+	help
+	  Answer M to build realtime support as a Linux Security
+	  Module.  Answering Y to build realtime capabilities into the
+	  kernel makes no sense.
+
+	  This module selectively grants realtime privileges
+	  controlled by load-time parameters.
+
+	  If you are unsure how to answer this question, answer N.
+
 source security/selinux/Kconfig
 
 endmenu
diff -ruN -X /home/joq/bin/kdiff.exclude linux-2.6.8.1/security/Makefile linux-2.6.8.1-rt/security/Makefile
--- linux-2.6.8.1/security/Makefile	Sat Aug 14 05:55:48 2004
+++ linux-2.6.8.1-rt/security/Makefile	Fri Sep 10 19:00:31 2004
@@ -15,3 +15,4 @@
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/built-in.o
 obj-$(CONFIG_SECURITY_CAPABILITIES)	+= commoncap.o capability.o
 obj-$(CONFIG_SECURITY_ROOTPLUG)		+= commoncap.o root_plug.o
+obj-$(CONFIG_SECURITY_REALTIME)		+= commoncap.o realtime.o
diff -ruN -X /home/joq/bin/kdiff.exclude linux-2.6.8.1/security/realtime.c linux-2.6.8.1-rt/security/realtime.c
--- linux-2.6.8.1/security/realtime.c	Wed Dec 31 18:00:00 1969
+++ linux-2.6.8.1-rt/security/realtime.c	Fri Sep 10 11:09:09 2004
@@ -0,0 +1,226 @@
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
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/security.h>
+#include <linux/file.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/pagemap.h>
+#include <linux/swap.h>
+#include <linux/smp_lock.h>
+#include <linux/skbuff.h>
+#include <linux/netlink.h>
+#include <linux/ptrace.h>
+
+#ifdef CONFIG_SECURITY
+
+#define RT_LSM "Realtime LSM "		/* syslog module name prefix */
+#define RT_ERR "Realtime: "		/* syslog error message prefix */
+
+#include <linux/vermagic.h>
+MODULE_INFO(vermagic,VERMAGIC_STRING);
+
+/* module parameters */
+static int any = 0;			/* if TRUE, any process is realtime */
+MODULE_PARM(any, "i");
+MODULE_PARM_DESC(any, " grant realtime privileges to any process.");
+
+static int gid = -1;			/* realtime group id, or NO_GROUP */
+MODULE_PARM(gid, "i");
+MODULE_PARM_DESC(gid, " the group ID with access to realtime privileges.");
+
+static int mlock = 1;			/* enable mlock() privileges */
+MODULE_PARM(mlock, "i");
+MODULE_PARM_DESC(mlock, " enable memory locking privileges.");
+
+static int allcaps = 0;			/* enable all capabilities */
+MODULE_PARM(allcaps, "i");
+MODULE_PARM_DESC(allcaps, " enable all capabilities, including CAP_SETPCAP.");
+
+static int debug = 0;			/* verbose debug output */
+MODULE_PARM(debug, "i");
+MODULE_PARM_DESC(debug, " print verbose debug messages in syslog.");
+
+static kernel_cap_t cap_bset_save;	/* place to save cap-bound */
+
+int realtime_bprm_set_security(struct linux_binprm *bprm)
+{
+	/* Copied from security/commoncap.c: cap_bprm_set_security()... */
+	/* Copied from fs/exec.c:prepare_binprm. */
+	/* We don't have VFS support for capabilities yet */
+	cap_clear(bprm->cap_inheritable);
+	cap_clear(bprm->cap_permitted);
+	cap_clear(bprm->cap_effective);
+
+	/*  If a non-zero `any' parameter was specified, we grant
+	 *  realtime privileges to every process.  If the `gid'
+	 *  parameter was specified and it matches the group id of the
+	 *  executable, of the current process or any supplementary
+	 *  groups, we grant realtime capabilites.
+	 */
+
+	if (any || (gid != -1)) {
+
+		int rt_ok = 1;
+
+		/* check group permissions */
+		if ((gid != -1) &&
+		    (gid != bprm->e_gid) &&
+		    (gid != current->gid)) {
+			int i;
+			rt_ok = 0;
+#ifdef NGROUPS_SMALL			/* using new groups struct? */
+			get_group_info(current->group_info);
+			for (i = 0; i < current->group_info->ngroups; ++i) {
+				if (gid == GROUP_AT(current->group_info, i)) {
+ 					rt_ok = 1;
+ 					break;
+ 				}
+ 			}
+			put_group_info(current->group_info);
+#else  /* old task struct */
+			for (i = 0; i < NGROUPS; ++i) {
+				if (gid == current->groups[i]) {
+					rt_ok = 1;
+					break;
+				}
+			}
+#endif /* NGROUPS_SMALL */
+		}
+
+		if (rt_ok)  {
+			cap_raise(bprm->cap_effective, CAP_SYS_NICE);
+			cap_raise(bprm->cap_permitted, CAP_SYS_NICE);
+			if (mlock) {
+				cap_raise(bprm->cap_effective, CAP_IPC_LOCK);
+				cap_raise(bprm->cap_permitted, CAP_IPC_LOCK);
+				cap_raise(bprm->cap_effective,
+					  CAP_SYS_RESOURCE);
+				cap_raise(bprm->cap_permitted,
+					  CAP_SYS_RESOURCE);
+			}
+		}
+	}
+
+	/*  To support inheritance of root-permissions and suid-root
+	 *  executables under compatibility mode, we raise all three
+	 *  capability sets for the file.
+	 *
+	 *  If only the real uid is 0, we only raise the inheritable
+	 *  and permitted sets of the executable file.
+	 */
+
+	if (bprm->e_uid == 0 || current->uid == 0) {
+		cap_set_full (bprm->cap_inheritable);
+		cap_set_full (bprm->cap_permitted);
+	}
+	if (bprm->e_uid == 0)
+		cap_set_full (bprm->cap_effective);
+
+	return 0;
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
+
+#ifdef LSM_UNSAFE_SHARE			/* version >= 2.6.6 */
+	.bprm_apply_creds =		cap_bprm_apply_creds,
+#else
+	.bprm_compute_creds =		cap_bprm_compute_creds,
+#endif
+	.bprm_set_security =		realtime_bprm_set_security,
+	.bprm_secureexec =		cap_bprm_secureexec,
+
+	.task_post_setuid =		cap_task_post_setuid,
+	.task_reparent_to_init =	cap_task_reparent_to_init,
+
+	.syslog =                       cap_syslog,
+
+	.vm_enough_memory =             cap_vm_enough_memory,
+};
+
+#define MY_NAME THIS_MODULE->name
+
+/* flag to keep track of how we were registered */
+static int secondary;
+
+
+static int __init capability_init(void)
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
+	cap_bset_save = cap_bset;	/* save cap-bound */
+	if (allcaps) {
+		cap_bset = to_cap_t(~0);
+		printk(KERN_INFO RT_LSM "enabling all capabilities\n");
+	}
+
+	if (any)
+		printk(KERN_INFO RT_LSM
+		       "initialized (all groups, mlock=%d)\n", mlock);
+	else if (gid == -1)
+		printk(KERN_INFO RT_LSM
+		       "initialized (no groups, mlock=%d)\n", mlock);
+	else
+		printk(KERN_INFO RT_LSM
+		       "initialized (group %d, mlock=%d)\n", gid, mlock);
+		
+	return 0;
+}
+
+static void __exit capability_exit(void)
+{
+	cap_bset = cap_bset_save;	/* restore cap-bound */
+
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
+security_initcall(capability_init);
+module_exit(capability_exit);
+
+MODULE_DESCRIPTION("Realtime Capabilities Security Module");
+MODULE_LICENSE("GPL");
+
+#endif	/* CONFIG_SECURITY */


