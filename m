Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266116AbUIPCcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbUIPCcR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 22:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbUIPCcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 22:32:17 -0400
Received: from [205.233.219.253] ([205.233.219.253]:63393 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S266116AbUIPCbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 22:31:49 -0400
Date: Wed, 15 Sep 2004 22:31:18 -0400
From: Jody McIntyre <realtime-lsm@modernduck.com>
To: "Jack O'Quin" <joq@io.com>
Cc: James Morris <jmorris@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de
Subject: Re: [PATCH] Realtime LSM
Message-ID: <20040916023118.GE2945@conscoop.ottawa.on.ca>
References: <Xine.LNX.4.44.0409120956150.16684-100000@thoron.boston.redhat.com> <871xh7thzx.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871xh7thzx.fsf@sulphur.joq.us>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 02:16:50PM -0500, Jack O'Quin wrote:

> I have not implemented that yet because (1) the current approach has
> proven adequate for the Linux audio user community, and (2) I haven't
> wanted to spend time mastering the internal kernel interfaces for
> accessing /proc from an LSM.  I know it's not difficult, but I had
> other things I'd rather do.  :-)

Here's a patch based on the one posted in
<1095117752.1360.5.camel@krustophenia.net> that adds a sysctl
(/proc/sys) interface.  These sysctls don't seem to fit into any of the
existing groups, so I added CTL_SECURITY (/proc/sys/security).

Example:

# modprobe realtime
# echo 29 > /proc/sys/security/realtime/gid

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>
Signed-off-by: Jody McIntyre <realtime-lsm@modernduck.com>


Index: linux/Documentation/realtime-lsm.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/Documentation/realtime-lsm.txt	2004-09-15 15:47:39.000000000 -0400
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
Index: linux/security/Makefile
===================================================================
--- linux.orig/security/Makefile	2004-09-15 15:47:11.000000000 -0400
+++ linux/security/Makefile	2004-09-15 15:47:39.000000000 -0400
@@ -15,3 +15,4 @@ obj-$(CONFIG_SECURITY)			+= security.o d
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/built-in.o
 obj-$(CONFIG_SECURITY_CAPABILITIES)	+= commoncap.o capability.o
 obj-$(CONFIG_SECURITY_ROOTPLUG)		+= commoncap.o root_plug.o
+obj-$(CONFIG_SECURITY_REALTIME)		+= commoncap.o realtime.o
Index: linux/security/realtime.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/security/realtime.c	2004-09-15 17:54:18.000000000 -0400
@@ -0,0 +1,283 @@
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
+
+			get_group_info(current->group_info);
+			for (i = 0; i < current->group_info->ngroups; ++i) {
+				if (gid == GROUP_AT(current->group_info, i)) {
+ 					rt_ok = 1;
+ 					break;
+ 				}
+ 			}
+			put_group_info(current->group_info);
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
+	{ .ctl_name	= 4,
+	  .procname	= "allcaps",
+	  .data		= &allcaps,
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
+/* flag to keep track of how we were registered */
+static int secondary;
+
+static void __exit exit_security(void)
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
+
+	sysctl_header = register_sysctl_table(security_root_table, 0);
+	if (!sysctl_header) {
+		exit_security();
+		return -ENOMEM;
+	}
+
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
+	exit_sysctl();
+	exit_security();
+}
+
+security_initcall(capability_init);
+module_exit(capability_exit);
+
+MODULE_DESCRIPTION("Realtime Capabilities Security Module");
+MODULE_LICENSE("GPL");
+
+#endif	/* CONFIG_SECURITY */
Index: linux/include/linux/sysctl.h
===================================================================
--- linux.orig/include/linux/sysctl.h	2004-09-15 11:59:54.000000000 -0400
+++ linux/include/linux/sysctl.h	2004-09-15 16:56:21.000000000 -0400
@@ -61,7 +61,14 @@ enum
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
Index: linux/security/Kconfig
===================================================================
--- linux.orig/security/Kconfig	2004-09-15 15:47:11.000000000 -0400
+++ linux/security/Kconfig	2004-09-15 15:47:39.000000000 -0400
@@ -44,6 +44,20 @@ config SECURITY_ROOTPLUG
 	  
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
