Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVGTUPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVGTUPD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 16:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVGTUPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 16:15:03 -0400
Received: from [216.129.110.2] ([216.129.110.2]:21684 "EHLO
	beigebox.liquidev.com") by vger.kernel.org with ESMTP
	id S261499AbVGTUPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 16:15:01 -0400
Date: Wed, 20 Jul 2005 16:08:35 -0400 (EDT)
From: Mark Whittington <markc@liquidev.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12] printk: add sysctl to control printk_time
Message-ID: <Pine.LNX.4.63.0507201551310.727@beigebox.liquidev.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added a sysctl (KERN_PRINTK_TIME) and by proxy an entry in 
/proc/sys/kernel to enable and disable printk interval information when 
CONFIG_PRINTK_TIME is compiled in.

Signed-off-by: Mark Whittington <markc@liquidev.com>

diff -ruN linux-2.6.12/Documentation/sysctl/kernel.txt linux-2.6.12-work/Documentation/sysctl/kernel.txt
--- linux-2.6.12/Documentation/sysctl/kernel.txt	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.12-work/Documentation/sysctl/kernel.txt	2005-07-20 14:58:15.000000000 -0400
@@ -39,6 +39,7 @@
  - pid_max
  - powersave-nap               [ PPC only ]
  - printk
+- printk_time                 [ CONFIG_PRINTK_TIME=y ]
  - real-root-dev               ==> Documentation/initrd.txt
  - reboot-cmd                  [ SPARC only ]
  - rtsig-max
@@ -260,6 +261,14 @@

  ==============================================================

+printk_time:
+
+If CONFIG_PRINTK_TIME is on at compile time, you can enable
+and disable time printing by echoing 1 or 0 to this file.  You
+can also read the current value from this file.
+
+==============================================================
+
  reboot-cmd: (Sparc only)

  ??? This seems to be a way to give an argument to the Sparc
diff -ruN linux-2.6.12/include/linux/sysctl.h linux-2.6.12-work/include/linux/sysctl.h
--- linux-2.6.12/include/linux/sysctl.h	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.12-work/include/linux/sysctl.h	2005-07-20 14:54:29.000000000 -0400
@@ -136,6 +136,9 @@
  	KERN_UNKNOWN_NMI_PANIC=66, /* int: unknown nmi panic flag */
  	KERN_BOOTLOADER_TYPE=67, /* int: boot loader type */
  	KERN_RANDOMIZE=68, /* int: randomize virtual address space */
+#if defined(CONFIG_PRINTK_TIME)
+	KERN_PRINTK_TIME=69, /* int: printk times enabled */
+#endif
  };


diff -ruN linux-2.6.12/kernel/printk.c linux-2.6.12-work/kernel/printk.c
--- linux-2.6.12/kernel/printk.c	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.12-work/kernel/printk.c	2005-07-20 15:32:03.000000000 -0400
@@ -473,7 +473,8 @@
  }

  #if defined(CONFIG_PRINTK_TIME)
-static int printk_time = 1;
+int printk_time = 1;
+EXPORT_SYMBOL(printk_time);
  #else
  static int printk_time = 0;
  #endif
diff -ruN linux-2.6.12/kernel/sysctl.c linux-2.6.12-work/kernel/sysctl.c
--- linux-2.6.12/kernel/sysctl.c	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.12-work/kernel/sysctl.c	2005-07-20 14:53:54.000000000 -0400
@@ -63,6 +63,7 @@
  extern int pid_max;
  extern int min_free_kbytes;
  extern int printk_ratelimit_jiffies;
+extern int printk_time;
  extern int printk_ratelimit_burst;
  extern int pid_max_min, pid_max_max;

@@ -589,6 +590,16 @@
  		.mode		= 0644,
  		.proc_handler	= &proc_dointvec,
  	},
+#if defined(CONFIG_PRINTK_TIME)
+	{
+		.ctl_name	= KERN_PRINTK_TIME,
+		.procname	= "printk_time",
+		.data		= &printk_time,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+#endif
  	{
  		.ctl_name	= KERN_PRINTK_RATELIMIT,
  		.procname	= "printk_ratelimit",
diff -ruN linux-2.6.12/lib/Kconfig.debug linux-2.6.12-work/lib/Kconfig.debug
--- linux-2.6.12/lib/Kconfig.debug	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.12-work/lib/Kconfig.debug	2005-07-20 15:09:07.000000000 -0400
@@ -6,7 +6,9 @@
  	  included in printk output.  This allows you to measure
  	  the interval between kernel operations, including bootup
  	  operations.  This is useful for identifying long delays
-	  in kernel startup.
+	  in kernel startup.  If this option is enabled, you can turn
+          off and on the timing information by echoing a 1 or 0 to
+          /proc/kernel/sys/printk_time.


  config DEBUG_KERNEL
