Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268664AbUJEEBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268664AbUJEEBM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 00:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268681AbUJEEBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 00:01:11 -0400
Received: from mail.joq.us ([67.65.12.105]:45444 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S268664AbUJEEAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 00:00:48 -0400
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Jody McIntyre <realtime-lsm@modernduck.com>, torbenh@gmx.de
Subject: Re: [PATCH] Realtime LSM
References: <1094967978.1306.401.camel@krustophenia.net>
	<20040920202349.GI4273@conscoop.ottawa.on.ca>
	<20040930211408.GE4273@conscoop.ottawa.on.ca>
From: "Jack O'Quin" <joq@io.com>
Date: 04 Oct 2004 23:00:24 -0500
In-Reply-To: <20040930211408.GE4273@conscoop.ottawa.on.ca>
Message-ID: <87brfhvmp3.fsf@sulphur.joq.us>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jody McIntyre <realtime-lsm@modernduck.com> writes:

> This patch still includes allcaps, which should be removed before it is
> merged.

The `allcaps' option is removed in this version, documentation
updated, plus some minor comment changes.

> The patch is now against 2.6.9-pre2-mm4.

This patch was diff'ed against 2.6.8.1.  Some of the offsets in
2.6.9-pre2-mm4 were slightly different, but the patch applied
correctly anyway.  I think it will work fine either way.

> The realtime-lsm Linux Security Module, written by Torben Hohn and Jack
> O'Quin, selectively grants realtime capabilities to specific user groups
> or applications.  The typical use for this is low latency audio, and the
> patch has been extensively field tested by Linux audio users.  The
> realtime LSM is a major improvement in security over the 2.4 capablities
> patch and other workarounds like jackstart, which rely on CAP_SETPCAP.
> 
> Signed-Off-By: Lee Revell <rlrevell@joe-job.com>
> Signed-off-by: Jody McIntyre <realtime-lsm@modernduck.com>

  Signed-off-by: Jack O'Quin <joq@joq.us>

diff -ruN -X /home/joq/bin/kdiff.exclude linux-2.6.8.1/Documentation/realtime-lsm.txt linux-2.6.8.1-rt02/Documentation/realtime-lsm.txt
--- linux-2.6.8.1/Documentation/realtime-lsm.txt	Wed Dec 31 18:00:00 1969
+++ linux-2.6.8.1-rt02/Documentation/realtime-lsm.txt	Mon Oct  4 21:38:26 2004
@@ -0,0 +1,38 @@
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
+Parameters can be changed dynamically via /proc/sys/security/realtime:
+
+  # sysctl -w security/realtime/any=0
+  # sysctl -w security/realtime/gid=29
+  # sysctl -w security/realtime/mlock=1
+
+Jack O'Quin, joq@joq.us
diff -ruN -X /home/joq/bin/kdiff.exclude linux-2.6.8.1/include/linux/sysctl.h linux-2.6.8.1-rt02/include/linux/sysctl.h
--- linux-2.6.8.1/include/linux/sysctl.h	Sat Aug 14 05:55:33 2004
+++ linux-2.6.8.1-rt02/include/linux/sysctl.h	Sun Oct  3 10:56:16 2004
@@ -61,7 +61,14 @@
 	CTL_DEV=7,		/* Devices */
 	CTL_BUS=8,		/* Busses */
 	CTL_ABI=9,		/* Binary emulation */
-	CTL_CPU=10		/* CPU stuff (speed scaling, etc) */
+	CTL_CPU=10,		/* CPU stuff (speed scaling, etc) */
+	CTL_SECURITY=11         /* Security modules */
+};
+
+/* CTL_SECURITY names: */
+enum
+{
+	SECURITY_REALTIME=1	/* Realtime LSM */
 };
 
 /* CTL_BUS names: */
diff -ruN -X /home/joq/bin/kdiff.exclude linux-2.6.8.1/security/Kconfig linux-2.6.8.1-rt02/security/Kconfig
--- linux-2.6.8.1/security/Kconfig	Sat Aug 14 05:55:47 2004
+++ linux-2.6.8.1-rt02/security/Kconfig	Sun Oct  3 10:56:17 2004
@@ -44,6 +44,17 @@
 	  
 	  If you are unsure how to answer this question, answer N.
 
+config SECURITY_REALTIME
+	tristate "Realtime Capabilities"
+	depends on SECURITY && SECURITY_CAPABILITIES!=y
+	default n
+	help
+	  This module selectively grants realtime privileges
+	  controlled by load-time parameters and
+	  /proc/sys/security/realtime.
+
+	  If you are unsure how to answer this question, answer N.
+
 source security/selinux/Kconfig
 
 endmenu
diff -ruN -X /home/joq/bin/kdiff.exclude linux-2.6.8.1/security/Makefile linux-2.6.8.1-rt02/security/Makefile
--- linux-2.6.8.1/security/Makefile	Sat Aug 14 05:55:48 2004
+++ linux-2.6.8.1-rt02/security/Makefile	Sun Oct  3 10:56:16 2004
@@ -15,3 +15,4 @@
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/built-in.o
 obj-$(CONFIG_SECURITY_CAPABILITIES)	+= commoncap.o capability.o
 obj-$(CONFIG_SECURITY_ROOTPLUG)		+= commoncap.o root_plug.o
+obj-$(CONFIG_SECURITY_REALTIME)		+= commoncap.o realtime.o
diff -ruN -X /home/joq/bin/kdiff.exclude linux-2.6.8.1/security/realtime.c linux-2.6.8.1-rt02/security/realtime.c
--- linux-2.6.8.1/security/realtime.c	Wed Dec 31 18:00:00 1969
+++ linux-2.6.8.1-rt02/security/realtime.c	Mon Oct  4 21:35:41 2004
@@ -0,0 +1,267 @@
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
+#include <linux/sysctl.h>
+
+#ifdef CONFIG_SECURITY
+
+#define RT_LSM "Realtime LSM "		/* syslog module name prefix */
+#define RT_ERR "Realtime: "		/* syslog error message prefix */
+
+#include <linux/vermagic.h>
+MODULE_INFO(vermagic,VERMAGIC_STRING);
+
+/* this is needed for the proc_dointvec_minmax for allowed GID */
+static int maxuid = 65535;
+static int minuid = -1;
+
+/* module parameters
+ *
+ *  These values could change at any time due to some process writing
+ *  a new value to /proc/sys/security/realtime.  This is OK, because
+ *  each is referenced only once in each function call.  Nothing
+ *  depends on parameters having the same value every time.
+ */
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
+/* helper function for testing group membership */
+static inline int gid_ok(int gid, int e_gid) {
+	int i;
+	int rt_ok = 0;
+
+	if (gid == -1)
+		return 0;
+
+	if ((gid == e_gid) || (gid == current->gid))
+		return 1;
+
+	get_group_info(current->group_info);
+	for (i = 0; i < current->group_info->ngroups; ++i) {
+		if (gid == GROUP_AT(current->group_info, i)) {
+			rt_ok = 1;
+			break;
+		}
+	}
+	put_group_info(current->group_info);
+
+	return rt_ok;
+}
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
+	if (any || gid_ok(gid, bprm->e_gid)) {
+		cap_raise(bprm->cap_effective, CAP_SYS_NICE);
+		cap_raise(bprm->cap_permitted, CAP_SYS_NICE);
+		if (mlock) {
+			cap_raise(bprm->cap_effective, CAP_IPC_LOCK);
+			cap_raise(bprm->cap_permitted, CAP_IPC_LOCK);
+			cap_raise(bprm->cap_effective,
+				  CAP_SYS_RESOURCE);
+			cap_raise(bprm->cap_permitted,
+				  CAP_SYS_RESOURCE);
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
+		cap_set_full(bprm->cap_inheritable);
+		cap_set_full(bprm->cap_permitted);
+	}
+	if (bprm->e_uid == 0)
+		cap_set_full(bprm->cap_effective);
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
+	.bprm_apply_creds =		cap_bprm_apply_creds,
+	.bprm_set_security =		realtime_bprm_set_security,
+	.bprm_secureexec =		cap_bprm_secureexec,
+	.task_post_setuid =		cap_task_post_setuid,
+	.task_reparent_to_init =	cap_task_reparent_to_init,
+	.syslog =                       cap_syslog,
+	.vm_enough_memory =             cap_vm_enough_memory,
+};
+
+#define MY_NAME __stringify(KBUILD_MODNAME)
+
+static ctl_table realtime_table[] =
+{
+	{ .ctl_name	= 1,
+	  .procname	= "any",
+	  .data		= &any,
+	  .maxlen	= sizeof(int),
+	  .mode		= 0644,
+	  .proc_handler	= &proc_dointvec,
+	},
+	{ .ctl_name	= 2,
+	  .procname	= "gid",
+	  .data		= &gid,
+	  .maxlen	= sizeof(int),
+	  .mode		= 0644,
+	  .proc_handler	= &proc_dointvec_minmax,
+	  .extra1	= &minuid,
+	  .extra2	= &maxuid
+	},
+	{ .ctl_name	= 3,
+	  .procname	= "mlock",
+	  .data		= &mlock,
+	  .maxlen	= sizeof(int),
+	  .mode		= 0644,
+	  .proc_handler	= &proc_dointvec,
+	},
+	{ }
+};
+
+static ctl_table realtime_root_table[] =
+{
+	{ .ctl_name	= SECURITY_REALTIME,
+	  .procname	= "realtime",
+	  .mode		= 0555,
+	  .child	= realtime_table },
+	{ }
+};
+
+static ctl_table security_root_table[] =
+{
+	{ .ctl_name	= CTL_SECURITY,
+	  .procname	= "security",
+	  .mode		= 0555,
+	  .child	= realtime_root_table },
+	{ }
+};
+
+static struct ctl_table_header *sysctl_header;
+
+static void __exit exit_sysctl(void)
+{
+	unregister_sysctl_table(sysctl_header);
+}
+
+static int secondary;	/* flag to keep track of how we were registered */
+
+static void __exit exit_security(void)
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
+	sysctl_header = register_sysctl_table(security_root_table, 0);
+	if (!sysctl_header) {
+		exit_security();
+		return -ENOMEM;
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
+	exit_sysctl();
+	exit_security();
+}
+
+late_initcall(capability_init);
+module_exit(capability_exit);
+
+MODULE_DESCRIPTION("Realtime Capabilities Security Module");
+MODULE_LICENSE("GPL");
+
+#endif	/* CONFIG_SECURITY */

-- 
  joq
