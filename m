Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935292AbWK2G5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935292AbWK2G5d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 01:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935293AbWK2G5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 01:57:32 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:42195 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S935292AbWK2G5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 01:57:31 -0500
Date: Wed, 29 Nov 2006 07:54:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark Knecht <markknecht@gmail.com>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-rt5
Message-ID: <20061129065430.GA28258@elte.hu>
References: <20061120220230.GA30835@elte.hu> <5bdc1c8b0611220606m31c397d1ubafae3460d36db09@mail.gmail.com> <1164735207.1701.19.camel@mindpipe> <20061128201549.GC26934@elte.hu> <5bdc1c8b0611281452w49b6a3c3rb35ab055fc0b2660@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <5bdc1c8b0611281452w49b6a3c3rb35ab055fc0b2660@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Mark Knecht <markknecht@gmail.com> wrote:

> Forwarding it off list.
> 
> Thanks Ingo. I'm very interested if it works for you to do this.

i've integrated it into -rt (see the patch below), but i marked it 
obsolete and i might not be able to carry it for long - we'll see. The 
preferred solution is to use newer PAM and its rt-limits features. But 
to ease migration i'll keep the realtime-lsm for a while.

	Ingo

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="realtime-lsm.patch"

---
 security/Kconfig   |    9 +++
 security/Makefile  |    1 
 security/realcap.c |  147 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+)

Index: linux/security/Kconfig
===================================================================
--- linux.orig/security/Kconfig
+++ linux/security/Kconfig
@@ -80,6 +80,15 @@ config SECURITY_CAPABILITIES
 	  This enables the "default" Linux capabilities functionality.
 	  If you are unsure how to answer this question, answer Y.
 
+config REALTIME_CAPABILITIES
+	tristate "Real-Time LSM (Obsolete)"
+	depends on SECURITY && EXPERIMENTAL
+	help
+	  This is an obsolete LSM - use newer PAM and rt-limites
+	  to manage your real-time apps.
+
+	  If you are unsure how to answer this question, answer N.
+
 config SECURITY_ROOTPLUG
 	tristate "Root Plug Support"
 	depends on USB && SECURITY
Index: linux/security/Makefile
===================================================================
--- linux.orig/security/Makefile
+++ linux/security/Makefile
@@ -15,4 +15,5 @@ obj-$(CONFIG_SECURITY)			+= security.o d
 # Must precede capability.o in order to stack properly.
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/built-in.o
 obj-$(CONFIG_SECURITY_CAPABILITIES)	+= commoncap.o capability.o
+obj-$(COMMON_REALTIME_CAPABILITIES)	+= commoncap.o realcap.o
 obj-$(CONFIG_SECURITY_ROOTPLUG)		+= commoncap.o root_plug.o
Index: linux/security/realcap.c
===================================================================
--- /dev/null
+++ linux/security/realcap.c
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

--YZ5djTAD1cGYuMQK--
