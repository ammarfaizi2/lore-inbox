Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbUJYCEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbUJYCEg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 22:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbUJYCEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 22:04:36 -0400
Received: from mail.joq.us ([67.65.12.105]:27008 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261663AbUJYCDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 22:03:53 -0400
To: Lee Revell <rlrevell@joe-job.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de
Subject: Re: [PATCH] Realtime LSM
References: <1097272140.1442.75.camel@krustophenia.net>
	<20041008145252.M2357@build.pdx.osdl.net>
	<1097273105.1442.78.camel@krustophenia.net>
	<20041008151911.Q2357@build.pdx.osdl.net>
	<20041008152430.R2357@build.pdx.osdl.net>
	<87zn2wbt7c.fsf@sulphur.joq.us>
	<20041008221635.V2357@build.pdx.osdl.net>
	<87is9jc1eb.fsf@sulphur.joq.us>
	<20041009121141.X2357@build.pdx.osdl.net>
	<878yafbpsj.fsf@sulphur.joq.us>
	<20041009155339.Y2357@build.pdx.osdl.net>
	<874qkmtibt.fsf@sulphur.joq.us> <87zn2erzvx.fsf@sulphur.joq.us>
	<1098494878.4731.1.camel@krustophenia.net>
	<87is92rphb.fsf@sulphur.joq.us> <871xfp1eqq.fsf@sulphur.joq.us>
From: "Jack O'Quin" <joq@io.com>
Date: 24 Oct 2004 21:03:24 -0500
In-Reply-To: <871xfp1eqq.fsf@sulphur.joq.us>
Message-ID: <87r7nny2oj.fsf@sulphur.joq.us>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack O'Quin <joq@io.com> writes:

> AFAICT it works with 2.6.9, but the realtime performance is terrible
> (2.6.8.1 was much better).  The appropriate threads are running
> SCHED_FIFO, but there are frequent xruns.  Could some change in the
> kernel be affecting this?
> 
> I'm going to to try 2.6.9-mm1, to see if that works better.

2.6.9-mm1 works fine.  I'm appending an updated complete version of
the patch for that kernel (the 2.6.9 patch did not apply cleanly).

As Lee already stated, this version is not final, because it still
exposes its parameters to sysctl via /proc/sys/security/realtime.

Chris Wright prefers to do that differently, using sysfs.  I defer to
his judgement about that, but don't understand what he has in mind
well enough to actually implement it myself.  Clearly, this LSM should
handle parameters however the others do or will.
-- 
  joq

diff -ruN -X /home/joq/bin/kdiff.exclude linux-2.6.9-mm1/Documentation/realtime-lsm.txt linux-2.6.9-mm1-rt1/Documentation/realtime-lsm.txt
--- linux-2.6.9-mm1/Documentation/realtime-lsm.txt	Wed Dec 31 18:00:00 1969
+++ linux-2.6.9-mm1-rt1/Documentation/realtime-lsm.txt	Sun Oct 24 13:29:22 2004
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
diff -ruN -X /home/joq/bin/kdiff.exclude linux-2.6.9-mm1/include/linux/sysctl.h linux-2.6.9-mm1-rt1/include/linux/sysctl.h
--- linux-2.6.9-mm1/include/linux/sysctl.h	Sun Oct 24 13:14:59 2004
+++ linux-2.6.9-mm1-rt1/include/linux/sysctl.h	Sun Oct 24 13:29:22 2004
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
diff -ruN -X /home/joq/bin/kdiff.exclude linux-2.6.9-mm1/security/Kconfig linux-2.6.9-mm1-rt1/security/Kconfig
--- linux-2.6.9-mm1/security/Kconfig	Sun Oct 24 13:15:02 2004
+++ linux-2.6.9-mm1-rt1/security/Kconfig	Sun Oct 24 13:29:22 2004
@@ -84,6 +84,17 @@
 
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
diff -ruN -X /home/joq/bin/kdiff.exclude linux-2.6.9-mm1/security/Makefile linux-2.6.9-mm1-rt1/security/Makefile
--- linux-2.6.9-mm1/security/Makefile	Sun Oct 24 13:15:02 2004
+++ linux-2.6.9-mm1-rt1/security/Makefile	Sun Oct 24 13:30:08 2004
@@ -17,3 +17,4 @@
 obj-$(CONFIG_SECURITY_CAPABILITIES)	+= commoncap.o capability.o
 obj-$(CONFIG_SECURITY_ROOTPLUG)		+= commoncap.o root_plug.o
 obj-$(CONFIG_SECURITY_SECLVL)		+= seclvl.o
+obj-$(CONFIG_SECURITY_REALTIME)		+= commoncap.o realtime.o
diff -ruN -X /home/joq/bin/kdiff.exclude linux-2.6.9-mm1/security/realtime.c linux-2.6.9-mm1-rt1/security/realtime.c
--- linux-2.6.9-mm1/security/realtime.c	Wed Dec 31 18:00:00 1969
+++ linux-2.6.9-mm1-rt1/security/realtime.c	Sun Oct 24 13:29:22 2004
@@ -0,0 +1,230 @@
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
+#include <linux/moduleparam.h>
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
+static ctl_table realtime_table[] =
+{
+	{ .ctl_name	= 1,
+	  .procname	= "any",
+	  .data		= &rt_any,
+	  .maxlen	= sizeof(int),
+	  .mode		= 0644,
+	  .proc_handler	= &proc_dointvec,
+	},
+	{ .ctl_name	= 2,
+	  .procname	= "gid",
+	  .data		= &rt_gid,
+	  .maxlen	= sizeof(int),
+	  .mode		= 0644,
+	  .proc_handler	= &proc_dointvec_minmax,
+	  .extra1	= &minuid,
+	  .extra2	= &maxuid
+	},
+	{ .ctl_name	= 3,
+	  .procname	= "mlock",
+	  .data		= &rt_mlock,
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
+static void exit_security(void)
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
