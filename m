Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbUDAQsz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 11:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbUDAQsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 11:48:54 -0500
Received: from holomorphy.com ([207.189.100.168]:22702 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262365AbUDAQsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 11:48:36 -0500
Date: Thu, 1 Apr 2004 08:48:25 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040401164825.GD791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
References: <20040401135920.GF18585@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401135920.GF18585@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 03:59:20PM +0200, Andrea Arcangeli wrote:
> Oracle needs this sysctl, I designed it and Ken Chen implemented it. I
> guess google also won't dislike it.
> This is a lot simpler than the mlock rlimit and this is people really
> need (not the rlimit). The rlimit thing can still be applied on top of
> this. This should be more efficient too (besides its simplicity).
> can you apply to mainline?
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.5-rc3-aa1/disable-cap-mlock-1

Something like this would have the minor advantage of zero core impact.
Testbooted only. vs. 2.6.5-rc3-mm4


-- wli

$ diffstat -p1 patches/capable_sysctl
 security/Kconfig          |    6 +
 security/Makefile         |    1 
 security/sysctl_capable.c |  205 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 212 insertions(+)

Index: mm4-2.6.5-rc3/security/sysctl_capable.c
===================================================================
--- mm4-2.6.5-rc3.orig/security/sysctl_capable.c	2004-02-07 18:26:35.000000000 -0800
+++ mm4-2.6.5-rc3/security/sysctl_capable.c	2004-04-01 08:41:08.000000000 -0800
@@ -0,0 +1,205 @@
+#include <linux/config.h>
+#include <linux/sysctl.h>
+#include <linux/capability.h>
+#include <linux/security.h>
+#include <linux/init.h>
+#include <linux/module.h>
+
+/*
+ * apparently only 0-28 are used
+ * states:
+ * 0: checks enabled
+ * 1: checks disabled
+ * 2: root-only
+ * 3: no access whatsoever
+ */
+#define CAP_SYSCTL_CHOWN		(1 + CAP_CHOWN)
+#define CAP_SYSCTL_DAC_OVERRIDE		(1 + CAP_DAC_OVERRIDE)
+#define CAP_SYSCTL_DAC_READ_SEARCH	(1 + CAP_DAC_READ_SEARCH)
+#define CAP_SYSCTL_FOWNER		(1 + CAP_FOWNER)
+#define CAP_SYSCTL_FSETID		(1 + CAP_FSETID)
+#define CAP_SYSCTL_KILL			(1 + CAP_KILL)
+#define CAP_SYSCTL_SETGID		(1 + CAP_SETGID)
+#define CAP_SYSCTL_SETUID		(1 + CAP_SETUID)
+#define CAP_SYSCTL_SETPCAP		(1 + CAP_SETPCAP)
+#define CAP_SYSCTL_LINUX_IMMUTABLE	(1 + CAP_LINUX_IMMUTABLE)
+#define CAP_SYSCTL_NET_BIND_SERVICE	(1 + CAP_NET_BIND_SERVICE)
+#define CAP_SYSCTL_NET_BROADCAST	(1 + CAP_NET_BROADCAST)
+#define CAP_SYSCTL_NET_ADMIN		(1 + CAP_NET_ADMIN)
+#define CAP_SYSCTL_NET_RAW		(1 + CAP_NET_RAW)
+#define CAP_SYSCTL_IPC_LOCK		(1 + CAP_IPC_LOCK)
+#define CAP_SYSCTL_IPC_OWNER		(1 + CAP_IPC_OWNER)
+#define CAP_SYSCTL_SYS_MODULE		(1 + CAP_SYS_MODULE)
+#define CAP_SYSCTL_SYS_RAWIO		(1 + CAP_SYS_RAWIO)
+#define CAP_SYSCTL_SYS_CHROOT		(1 + CAP_SYS_CHROOT)
+#define CAP_SYSCTL_SYS_PTRACE		(1 + CAP_SYS_PTRACE)
+#define CAP_SYSCTL_SYS_PACCT		(1 + CAP_SYS_PACCT)
+#define CAP_SYSCTL_SYS_ADMIN		(1 + CAP_SYS_ADMIN)
+#define CAP_SYSCTL_SYS_BOOT		(1 + CAP_SYS_BOOT)
+#define CAP_SYSCTL_SYS_NICE		(1 + CAP_SYS_NICE)
+#define CAP_SYSCTL_SYS_RESOURCE		(1 + CAP_SYS_RESOURCE)
+#define CAP_SYSCTL_SYS_TIME		(1 + CAP_SYS_TIME)
+#define CAP_SYSCTL_SYS_TTY_CONFIG	(1 + CAP_SYS_TTY_CONFIG)
+#define CAP_SYSCTL_MKNOD		(1 + CAP_MKNOD)
+#define CAP_SYSCTL_LEASE		(1 + CAP_LEASE)
+#define MAX_CAPABILITY			CAP_SYSCTL_LEASE
+
+#define CAPABILITY_SYSCTL_ENABLED	0
+#define CAPABILITY_SYSCTL_DISABLED	1
+#define CAPABILITY_SYSCTL_ROOT		2
+#define CAPABILITY_SYSCTL_NONE		3
+
+
+/* you've got to be kidding me */
+#define MKCTL(x, y)							\
+	{								\
+		.ctl_name	= CAP_SYSCTL_##x,			\
+		.procname	= #y ,					\
+		.extra1		= (void *)&capability_sysctl_zero,	\
+		.extra2		= (void *)&capability_sysctl_one,	\
+		.data		= &capability_sysctl_state[CAP_SYSCTL_##x],\
+		.mode		= 0644,					\
+		.strategy	= sysctl_intvec,			\
+		.proc_handler	= proc_dointvec_minmax,			\
+		.maxlen		= sizeof(int),				\
+	},
+
+static int capability_sysctl_state[MAX_CAPABILITY];
+static const int capability_sysctl_zero = 0;
+static const int capability_sysctl_one = 1;
+static int secondary;
+static struct ctl_table_header *capability_sysctl_table_header;
+
+static struct ctl_table capability_sysctl_table[] = {
+	MKCTL(CHOWN, chown)
+	MKCTL(DAC_OVERRIDE, dac_override)
+	MKCTL(DAC_READ_SEARCH, dac_read_search)
+	MKCTL(FOWNER, fowner)
+	MKCTL(FSETID, fsetid)
+	MKCTL(KILL, kill)
+	MKCTL(SETGID, setgid)
+	MKCTL(SETUID, setuid)
+	MKCTL(SETPCAP, setpcap)
+	MKCTL(LINUX_IMMUTABLE, immutable)
+	MKCTL(NET_BIND_SERVICE, bind)
+	MKCTL(NET_BROADCAST, broadcast)
+	MKCTL(NET_ADMIN, net_admin)
+	MKCTL(NET_RAW, net_raw)
+	MKCTL(IPC_LOCK, ipc_lock)
+	MKCTL(IPC_OWNER, ipc_owner)
+	MKCTL(SYS_MODULE, module)
+	MKCTL(SYS_RAWIO, rawio)
+	MKCTL(SYS_CHROOT, chroot)
+	MKCTL(SYS_PTRACE, ptrace)
+	MKCTL(SYS_PACCT, pacct)
+	MKCTL(SYS_ADMIN, sys_admin)
+	MKCTL(SYS_BOOT, boot)
+	MKCTL(SYS_NICE, nice)
+	MKCTL(SYS_RESOURCE, resource)
+	MKCTL(SYS_TIME, time)
+	MKCTL(SYS_TTY_CONFIG, tty_config)
+	MKCTL(MKNOD, mknod)
+	MKCTL(LEASE, lease)
+	{
+		.ctl_name	= 0,
+	},
+};
+
+static int capability_sysctl_capable(task_t *, int);
+
+static struct ctl_table capability_sysctl_root_table[] = {
+	{
+		.ctl_name	= CTL_KERN,
+		.procname	= "capability",
+		.mode		= 0644,
+		.child		= capability_sysctl_table,
+	},
+	{
+		.ctl_name	= 0,
+	},
+};
+
+static struct security_operations capability_sysctl_ops = {
+	.ptrace			=                       cap_ptrace,
+	.capget			=                       cap_capget,
+	.capset_check		=                 cap_capset_check,
+	.capset_set		=                   cap_capset_set,
+	.capable		=        capability_sysctl_capable,
+	.netlink_send		=                 cap_netlink_send,
+	.netlink_recv		=                 cap_netlink_recv,
+	.bprm_compute_creds	=           cap_bprm_compute_creds,
+	.bprm_set_security	=            cap_bprm_set_security,
+	.bprm_secureexec	=              cap_bprm_secureexec,
+	.inode_setxattr		=               cap_inode_setxattr,
+	.inode_removexattr	=            cap_inode_removexattr,
+	.task_post_setuid	=             cap_task_post_setuid,
+	.task_reparent_to_init	=        cap_task_reparent_to_init,
+	.syslog			=                       cap_syslog,
+	.vm_enough_memory	=             cap_vm_enough_memory,
+};
+
+
+static int capability_sysctl_capable(task_t *task, int cap)
+{
+	if (cap < 0 || cap >= MAX_CAPABILITY)
+		return -EINVAL;
+	switch (capability_sysctl_state[cap-1]) {
+		case CAPABILITY_SYSCTL_ROOT:
+			if (current->uid == 0)
+				return 0;
+			/* fall through */
+		case CAPABILITY_SYSCTL_ENABLED:
+			if (cap_raised(task->cap_effective, cap))
+				return 0;
+			else
+				return -EPERM;
+			break;
+		case CAPABILITY_SYSCTL_DISABLED:
+				return 0;
+			break;
+		case CAPABILITY_SYSCTL_NONE:
+				return -EPERM;
+			break;
+		default:
+			return -EINVAL;
+	}
+}
+
+static int capability_sysctl_proc_init(void)
+{
+	capability_sysctl_table_header =
+		register_sysctl_table(capability_sysctl_root_table, 0);
+	if (!capability_sysctl_table_header)
+		return -ENOMEM;
+	else
+		return 0;
+}
+
+static int __init capability_sysctl_init(void)
+{
+	if (!register_security(&capability_sysctl_ops)) {
+		secondary = 0;
+		return 0;
+	}
+	if (!mod_reg_security("capability_sysctl", &capability_sysctl_ops)) {
+		secondary = 1;
+		return 0;
+	}
+	printk(KERN_INFO "failure registering sysctl capability disablement\n");
+	return -EINVAL;
+}
+
+static void __exit capability_sysctl_fini(void)
+{
+	if (secondary)
+		mod_unreg_security("capability_sysctl", &capability_sysctl_ops);
+	else
+		unregister_security(&capability_sysctl_ops);
+	if (capability_sysctl_table_header)
+		unregister_sysctl_table(capability_sysctl_table_header);
+}
+security_initcall(capability_sysctl_init);
+module_init(capability_sysctl_proc_init);
+module_exit(capability_sysctl_fini);
+MODULE_DESCRIPTION("Sysctl-based capability check disablement");
+MODULE_LICENSE("GPL");
Index: mm4-2.6.5-rc3/security/Makefile
===================================================================
--- mm4-2.6.5-rc3.orig/security/Makefile	2004-03-29 19:26:54.000000000 -0800
+++ mm4-2.6.5-rc3/security/Makefile	2004-04-01 07:37:41.000000000 -0800
@@ -15,3 +15,4 @@
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/built-in.o
 obj-$(CONFIG_SECURITY_CAPABILITIES)	+= commoncap.o capability.o
 obj-$(CONFIG_SECURITY_ROOTPLUG)		+= commoncap.o root_plug.o
+obj-$(CONFIG_SECURITY_CAPABILITY_SYSCTL) += commoncap.o sysctl_capable.o
Index: mm4-2.6.5-rc3/security/Kconfig
===================================================================
--- mm4-2.6.5-rc3.orig/security/Kconfig	2004-03-29 19:26:47.000000000 -0800
+++ mm4-2.6.5-rc3/security/Kconfig	2004-04-01 07:38:49.000000000 -0800
@@ -44,6 +44,12 @@
 	  
 	  If you are unsure how to answer this question, answer N.
 
+config SECURITY_CAPABILITY_SYSCTL
+	bool "Disable capabilities via sysctl"
+	depends on SECURITY!=n
+	help
+	  This allows you to disable capabilities with sysctls.
+
 source security/selinux/Kconfig
 
 endmenu
