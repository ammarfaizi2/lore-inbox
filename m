Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271153AbTHRAsg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 20:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271183AbTHRAsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 20:48:36 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:40320 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S271153AbTHRArP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 20:47:15 -0400
Date: Mon, 18 Aug 2003 01:46:49 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: [PATCH] make NFS lockd port numbers assignable at run time
Message-ID: <20030818004649.GA5105@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When writing firewall rules, and you are serving NFS, it's really
useful to know the port numbers of the various NFS services.  nfsd has
a standard value; mountd and statd are userspace daemons, and those
ports are settable on the command line.

The fiddly one is lockd.  nlm_udpport and nlm_tcpport can be set on
the kernel command line or at module load time, but after that it's a
bit awkward (particularly as the lockd module can't be unloaded safely
- "rmmod -f lockd" sometimes panics).

This patch allows the port numbers and the other lockd parameters to
be set through files in /proc/sys/fs/nfs/nlm_*.  The port numbers take
effect when lockd is next started or restarted.

In order to install the sysctl table even when compiled into the
kernel, it was necessary to update the initialisation code to the
current methods, using module_init() et al.  This patch does that and
in so doing updates the module/kernel parameters to use the 2.6
module_param() method, as well as making the numeric range changes
consistent between the two.

Enjoy,
-- Jamie



--- orig-2.5.75/fs/lockd/svc.c	2003-07-08 21:55:24.000000000 +0100
+++ laptop-2.5.75/fs/lockd/svc.c	2003-08-17 04:06:38.000000000 +0100
@@ -16,6 +16,8 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/sysctl.h>
+#include <linux/moduleparam.h>
 
 #include <linux/sched.h>
 #include <linux/errno.h>
@@ -51,12 +53,23 @@
 static DECLARE_WAIT_QUEUE_HEAD(lockd_exit);
 
 /*
- * Currently the following can be set only at insmod time.
- * Ideally, they would be accessible through the sysctl interface.
+ * These can be set at insmod time (useful for NFS as root filesystem),
+ * and also changed through the sysctl interface.  -- Jamie Lokier, Aug 2003
  */
-unsigned long			nlm_grace_period;
-unsigned long			nlm_timeout = LOCKD_DFLT_TIMEO;
-unsigned long			nlm_udpport, nlm_tcpport;
+static unsigned long		nlm_grace_period;
+static unsigned long		nlm_timeout = LOCKD_DFLT_TIMEO;
+static int			nlm_udpport, nlm_tcpport;
+
+/*
+ * Constants needed for the sysctl interface.
+ */
+static const unsigned long	nlm_grace_period_min = 0;
+static const unsigned long	nlm_grace_period_max = 240;
+static const unsigned long	nlm_timeout_min = 3;
+static const unsigned long	nlm_timeout_max = 20;
+static const int		nlm_port_min = 0, nlm_port_max = 65535;
+
+static struct ctl_table_header * nlm_sysctl_table;
 
 static unsigned long set_grace_period(void)
 {
@@ -298,52 +311,130 @@
 	up(&nlmsvc_sema);
 }
 
-#ifdef MODULE
-/* New module support in 2.1.18 */
+/*
+ * Sysctl parameters (same as module parameters, different interface).
+ */
+
+/* Something that isn't CTL_ANY, CTL_NONE or a value that may clash. */
+#define CTL_UNNUMBERED		-2
+
+static ctl_table nlm_sysctls[] = {
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "nlm_grace_period",
+		.data		= &nlm_grace_period,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_doulongvec_minmax,
+		.extra1		= (unsigned long *) &nlm_grace_period_min,
+		.extra2		= (unsigned long *) &nlm_grace_period_max,
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "nlm_timeout",
+		.data		= &nlm_timeout,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_doulongvec_minmax,
+		.extra1		= (unsigned long *) &nlm_timeout_min,
+		.extra2		= (unsigned long *) &nlm_timeout_max,
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "nlm_udpport",
+		.data		= &nlm_udpport,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.extra1		= (int *) &nlm_port_min,
+		.extra2		= (int *) &nlm_port_max,
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "nlm_tcpport",
+		.data		= &nlm_tcpport,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.extra1		= (int *) &nlm_port_min,
+		.extra2		= (int *) &nlm_port_max,
+	},
+	{ .ctl_name = 0 }
+};
+
+static ctl_table nlm_sysctl_dir[] = {
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "nfs",
+		.mode		= 0555,
+		.child		= nlm_sysctls,
+	},
+	{ .ctl_name = 0 }
+};
+
+static ctl_table nlm_sysctl_root[] = {
+	{
+		.ctl_name	= CTL_FS,
+		.procname	= "fs",
+		.mode		= 0555,
+		.child		= nlm_sysctl_dir,
+	},
+	{ .ctl_name = 0 }
+};
+
+/*
+ * Module (and driverfs) parameters.
+ */
+
+#define param_set_min_max(name, type, which_strtol, min, max)		\
+static int param_set_##name(const char *val, struct kernel_param *kp)	\
+{									\
+	char *endp;							\
+	__typeof__(type) num = which_strtol(val, &endp, 0);		\
+	if (endp == val || *endp || num < (min) || num > (max))		\
+		return -EINVAL;						\
+	*((int *) kp->arg) = num;					\
+	return 0;							\
+}
+
+param_set_min_max(port, int, simple_strtol, 0, 65535)
+param_set_min_max(grace_period, unsigned long, simple_strtoul,
+		  nlm_grace_period_min, nlm_grace_period_max)
+param_set_min_max(timeout, unsigned long, simple_strtoul,
+		  nlm_timeout_min, nlm_timeout_max)
 
 MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
 MODULE_DESCRIPTION("NFS file locking service version " LOCKD_VERSION ".");
 MODULE_LICENSE("GPL");
-MODULE_PARM(nlm_grace_period, "10-240l");
-MODULE_PARM(nlm_timeout, "3-20l");
-MODULE_PARM(nlm_udpport, "0-65535l");
-MODULE_PARM(nlm_tcpport, "0-65535l");
 
-int
-init_module(void)
-{
-	/* Init the static variables */
-	init_MUTEX(&nlmsvc_sema);
-	nlmsvc_users = 0;
-	nlmsvc_pid = 0;
-	return 0;
-}
+module_param_call(nlm_grace_period, param_set_grace_period, param_get_ulong,
+		  &nlm_grace_period, 644);
+module_param_call(nlm_timeout, param_set_timeout, param_get_ulong,
+		  &nlm_timeout, 644);
+module_param_call(nlm_udpport, param_set_port, param_get_int,
+		  &nlm_udpport, 644);
+module_param_call(nlm_tcpport, param_set_port, param_get_int,
+		  &nlm_tcpport, 644);
 
-void
-cleanup_module(void)
-{
-	/* FIXME: delete all NLM clients */
-	nlm_shutdown_hosts();
-}
-#else
-/* not a module, so process bootargs
- * lockd.udpport and lockd.tcpport
+/*
+ * Initialising and terminating the module.
  */
 
-static int __init udpport_set(char *str)
+static int __init init_nlm(void)
 {
-	nlm_udpport = simple_strtoul(str, NULL, 0);
-	return 1;
+	nlm_sysctl_table = register_sysctl_table(nlm_sysctl_root, 0);
+	return nlm_sysctl_table ? 0 : -ENOMEM;
 }
-static int __init tcpport_set(char *str)
+
+static void __exit exit_nlm(void)
 {
-	nlm_tcpport = simple_strtoul(str, NULL, 0);
-	return 1;
+	/* FIXME: delete all NLM clients */
+	nlm_shutdown_hosts();
+	unregister_sysctl_table(nlm_sysctl_table);
 }
-__setup("lockd.udpport=", udpport_set);
-__setup("lockd.tcpport=", tcpport_set);
 
-#endif
+module_init(init_nlm);
+module_exit(exit_nlm);
 
 /*
  * Define NLM program and procedures
--- orig-2.5.75/include/linux/lockd/lockd.h	2003-08-18 01:20:51.776331547 +0100
+++ laptop-2.5.75/include/linux/lockd/lockd.h	2003-08-18 01:21:15.618457723 +0100
@@ -26,7 +26,7 @@
 /*
  * Version string
  */
-#define LOCKD_VERSION		"0.4"
+#define LOCKD_VERSION		"0.5"
 
 /*
  * Default timeout for RPC calls (seconds)
