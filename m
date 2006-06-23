Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751905AbWFWVBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbWFWVBp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 17:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752052AbWFWVBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 17:01:45 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:56241 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751905AbWFWVBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 17:01:44 -0400
Date: Fri, 23 Jun 2006 17:01:21 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       Linux SCSI Mailing list <linux-scsi@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Morton Andrew Morton <akpm@osdl.org>, mike.miller@hp.com
Subject: [RFC] [PATCH 1/2] introduce crashboot kernel command line parameter
Message-ID: <20060623210121.GA18384@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


o Add kernel command line option "crashboot"

o This option is an indication to the kernel that kernel is booting in an
  unreliable environment where possibly BIOS execution has been skipped
  and devices are left operational or in unknown state.

o Kernel, especially device drivers can use this option to take special
  actions like soft-resetting the device, relaxing some of the rules
  to make sure kernel can boot/device driver can initiliaze in this
  environment.

o As of today this option is useful to Kdump. Kdump will pass this option
  to second kernel to improve the reliability of successful kenrel boot/
  device driver initializatoin. 

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.17-1M-vivek/Documentation/kernel-parameters.txt |    9 ++++++
 linux-2.6.17-1M-vivek/include/linux/init.h                |    1 
 linux-2.6.17-1M-vivek/init/main.c                         |   19 ++++++++++++++
 3 files changed, 29 insertions(+)

diff -puN Documentation/kernel-parameters.txt~introduce-crash-boot-command-line-parameter Documentation/kernel-parameters.txt
--- linux-2.6.17-1M/Documentation/kernel-parameters.txt~introduce-crash-boot-command-line-parameter	2006-06-23 10:54:39.000000000 -0400
+++ linux-2.6.17-1M-vivek/Documentation/kernel-parameters.txt	2006-06-23 13:47:28.000000000 -0400
@@ -405,6 +405,15 @@ running once the system is up.
 			[KNL] Reserve a chunk of physical memory to
 			hold a kernel to switch to with kexec on panic.
 
+	crashboot	[KNL] Use this if kernel is booting in a potentially
+			unreliable environement. For ex. kdump, where new
+			kernel is booting after the first kernel crash and
+			BIOS has been skipped and devices are in unknown
+			state.
+
+			Device drivers might soft reset the devices before
+			doing further device initialization.
+
 	cs4232=		[HW,OSS]
 			Format: <io>,<irq>,<dma>,<dma2>,<mpuio>,<mpuirq>
 
diff -puN init/main.c~introduce-crash-boot-command-line-parameter init/main.c
--- linux-2.6.17-1M/init/main.c~introduce-crash-boot-command-line-parameter	2006-06-23 13:14:49.000000000 -0400
+++ linux-2.6.17-1M-vivek/init/main.c	2006-06-23 13:34:34.000000000 -0400
@@ -121,6 +121,17 @@ char saved_command_line[COMMAND_LINE_SIZ
 static char *execute_command;
 static char *ramdisk_execute_command;
 
+/*
+ * If set, indicates that kernel is booting in an unreliable environment.
+ * For ex. kdump situaiton where previous kernel has crashed, BIOS has been
+ * skipped and devices will be in unknown state.
+ *
+ * Device drivers can use it to know that underlying device is in unknown
+ * state and might even be finishing commands issued from previous kernel's
+ * context.
+ */
+unsigned int crash_boot;
+
 /* Setup configured maximum number of CPUs to activate */
 static unsigned int max_cpus = NR_CPUS;
 
@@ -150,6 +161,14 @@ static int __init maxcpus(char *str)
 
 __setup("maxcpus=", maxcpus);
 
+static int __init set_crash_boot(char *str)
+{
+	crash_boot = 1;
+	return 1;
+}
+
+__setup("crashboot", set_crash_boot);
+
 static char * argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
 char * envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
 static const char *panic_later, *panic_param;
diff -puN include/linux/init.h~introduce-crash-boot-command-line-parameter include/linux/init.h
--- linux-2.6.17-1M/include/linux/init.h~introduce-crash-boot-command-line-parameter	2006-06-23 15:00:25.000000000 -0400
+++ linux-2.6.17-1M-vivek/include/linux/init.h	2006-06-23 15:00:41.000000000 -0400
@@ -69,6 +69,7 @@ extern initcall_t __security_initcall_st
 
 /* Defined in init/main.c */
 extern char saved_command_line[];
+extern unsigned int crash_boot;
 
 /* used by init/main.c */
 extern void setup_arch(char **);
_
