Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261984AbSJ2QSI>; Tue, 29 Oct 2002 11:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbSJ2QSI>; Tue, 29 Oct 2002 11:18:08 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:31904 "HELO atlrel9.hp.com")
	by vger.kernel.org with SMTP id <S261984AbSJ2QR7>;
	Tue, 29 Oct 2002 11:17:59 -0500
Subject: [PATCH 2.5] Retrieve configuration information from kernel
To: linux-kernel@vger.kernel.org
Date: Tue, 29 Oct 2002 09:24:16 -0700 (MST)
Cc: torvalds@transmeta.com
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E186ZA8-00086R-00@lyra.fc.hp.com>
From: Khalid Aziz <khalid@fc.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am including a revised patch that allows a user to embed kernel
configuration in the kernel and retrieve it later either from a running
kernel or from the kernel image file. This is an enhancement to Randy's
patch that was discussed on LKML before and is part of -ac series
kernels.

This patch provides three choices for embedding kernel configuration:

1. Include configuration in running kernel image. This adds to the
footprint of the running kernel but allows configuration to be retrieved
using "cat /proc/ikconfig/config".

2. Include configuration in kernel image file but not in the running
kernel. This adds to the kernel image file size but not the footprint of
running kernel. Configuration can be extracted from kernel image file
using scripts/extract-ikconfig. This script is in principle the same as
what Randy had written originally. I have made it little more robust and
structured it to accomodate more than just x86 architecture.

3. Not include kernel configuration in the running kernel or kernel
image file. 

With these three choices, users can make the appropriate tradeoff. This
feature is especially useful for support folks who need to know the
kernel configuration for a customer's kernel with fairly high degree of
confidence that they are getting the right configuration. This feature
is turned off in the default configuration.

Linus, please apply.

--
Khalid 

====================================================================
Khalid Aziz                                Linux and Open Source Lab
(970)898-9214                                        Hewlett-Packard
khalid@hp.com                                       Fort Collins, CO



---------CUT HERE-------------CUT HERE--------------CUT HERE-----------------
diff -urN --exclude-from=/linux/diff_exclude_file linux-2.5.44/arch/alpha/defconfig linux-2.5.44-ikconfig/arch/alpha/defconfig
--- linux-2.5.44/arch/alpha/defconfig	Fri Oct 18 22:01:54 2002
+++ linux-2.5.44-ikconfig/arch/alpha/defconfig	Mon Oct 28 11:07:18 2002
@@ -18,6 +18,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set
 
 #
 # Loadable module support
diff -urN --exclude-from=/linux/diff_exclude_file linux-2.5.44/arch/arm/defconfig linux-2.5.44-ikconfig/arch/arm/defconfig
--- linux-2.5.44/arch/arm/defconfig	Fri Oct 18 22:01:19 2002
+++ linux-2.5.44-ikconfig/arch/arm/defconfig	Mon Oct 28 11:07:18 2002
@@ -80,6 +80,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set
 CONFIG_NWFPE=y
 CONFIG_KCORE_ELF=y
 # CONFIG_KCORE_AOUT is not set
diff -urN --exclude-from=/linux/diff_exclude_file linux-2.5.44/arch/cris/defconfig linux-2.5.44-ikconfig/arch/cris/defconfig
--- linux-2.5.44/arch/cris/defconfig	Fri Oct 18 22:01:19 2002
+++ linux-2.5.44-ikconfig/arch/cris/defconfig	Mon Oct 28 11:07:18 2002
@@ -17,6 +17,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_SYSCTL is not set
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set
 CONFIG_BINFMT_ELF=y
 # CONFIG_ETRAX_KGDB is not set
 # CONFIG_ETRAX_WATCHDOG is not set
diff -urN --exclude-from=/linux/diff_exclude_file linux-2.5.44/arch/i386/defconfig linux-2.5.44-ikconfig/arch/i386/defconfig
--- linux-2.5.44/arch/i386/defconfig	Fri Oct 18 22:02:24 2002
+++ linux-2.5.44-ikconfig/arch/i386/defconfig	Mon Oct 28 11:07:18 2002
@@ -19,6 +19,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set
 
 #
 # Loadable module support
diff -urN --exclude-from=/linux/diff_exclude_file linux-2.5.44/arch/ia64/defconfig linux-2.5.44-ikconfig/arch/ia64/defconfig
--- linux-2.5.44/arch/ia64/defconfig	Fri Oct 18 22:01:10 2002
+++ linux-2.5.44-ikconfig/arch/ia64/defconfig	Mon Oct 28 11:07:18 2002
@@ -14,6 +14,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set
 
 #
 # Loadable module support
diff -urN --exclude-from=/linux/diff_exclude_file linux-2.5.44/arch/m68k/defconfig linux-2.5.44-ikconfig/arch/m68k/defconfig
--- linux-2.5.44/arch/m68k/defconfig	Fri Oct 18 22:01:08 2002
+++ linux-2.5.44-ikconfig/arch/m68k/defconfig	Mon Oct 28 11:07:18 2002
@@ -42,6 +42,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set
 CONFIG_KCORE_ELF=y
 # CONFIG_KCORE_AOUT is not set
 CONFIG_BINFMT_AOUT=y
diff -urN --exclude-from=/linux/diff_exclude_file linux-2.5.44/arch/mips/defconfig linux-2.5.44-ikconfig/arch/mips/defconfig
--- linux-2.5.44/arch/mips/defconfig	Fri Oct 18 22:01:14 2002
+++ linux-2.5.44-ikconfig/arch/mips/defconfig	Mon Oct 28 11:07:18 2002
@@ -93,6 +93,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set
 
 #
 # Memory Technology Devices (MTD)
diff -urN --exclude-from=/linux/diff_exclude_file linux-2.5.44/arch/mips64/defconfig linux-2.5.44-ikconfig/arch/mips64/defconfig
--- linux-2.5.44/arch/mips64/defconfig	Fri Oct 18 22:01:17 2002
+++ linux-2.5.44-ikconfig/arch/mips64/defconfig	Mon Oct 28 11:07:18 2002
@@ -56,6 +56,9 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set
+
 CONFIG_BINFMT_ELF=y
 CONFIG_MIPS32_COMPAT=y
 CONFIG_BINFMT_ELF32=y
diff -urN --exclude-from=/linux/diff_exclude_file linux-2.5.44/arch/parisc/defconfig linux-2.5.44-ikconfig/arch/parisc/defconfig
--- linux-2.5.44/arch/parisc/defconfig	Fri Oct 18 22:01:09 2002
+++ linux-2.5.44-ikconfig/arch/parisc/defconfig	Mon Oct 28 11:07:18 2002
@@ -37,6 +37,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set
 CONFIG_BINFMT_SOM=y
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
diff -urN --exclude-from=/linux/diff_exclude_file linux-2.5.44/arch/ppc/defconfig linux-2.5.44-ikconfig/arch/ppc/defconfig
--- linux-2.5.44/arch/ppc/defconfig	Fri Oct 18 22:02:28 2002
+++ linux-2.5.44-ikconfig/arch/ppc/defconfig	Mon Oct 28 11:07:18 2002
@@ -64,6 +64,8 @@
 CONFIG_PCI=y
 CONFIG_NET=y
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_KCORE_ELF=y
diff -urN --exclude-from=/linux/diff_exclude_file linux-2.5.44/arch/ppc64/defconfig linux-2.5.44-ikconfig/arch/ppc64/defconfig
--- linux-2.5.44/arch/ppc64/defconfig	Fri Oct 18 22:01:19 2002
+++ linux-2.5.44-ikconfig/arch/ppc64/defconfig	Mon Oct 28 11:07:18 2002
@@ -20,6 +20,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set
 
 #
 # Loadable module support
diff -urN --exclude-from=/linux/diff_exclude_file linux-2.5.44/arch/s390/defconfig linux-2.5.44-ikconfig/arch/s390/defconfig
--- linux-2.5.44/arch/s390/defconfig	Fri Oct 18 22:02:29 2002
+++ linux-2.5.44-ikconfig/arch/s390/defconfig	Mon Oct 28 11:07:18 2002
@@ -22,6 +22,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set
 
 #
 # Loadable module support
diff -urN --exclude-from=/linux/diff_exclude_file linux-2.5.44/arch/s390x/defconfig linux-2.5.44-ikconfig/arch/s390x/defconfig
--- linux-2.5.44/arch/s390x/defconfig	Fri Oct 18 22:00:42 2002
+++ linux-2.5.44-ikconfig/arch/s390x/defconfig	Mon Oct 28 11:07:18 2002
@@ -22,6 +22,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set
 
 #
 # Loadable module support
diff -urN --exclude-from=/linux/diff_exclude_file linux-2.5.44/arch/sh/defconfig linux-2.5.44-ikconfig/arch/sh/defconfig
--- linux-2.5.44/arch/sh/defconfig	Fri Oct 18 22:01:56 2002
+++ linux-2.5.44-ikconfig/arch/sh/defconfig	Mon Oct 28 11:07:18 2002
@@ -45,6 +45,8 @@
 # CONFIG_SYSVIPC is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_SYSCTL is not set
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set
 CONFIG_KCORE_ELF=y
 # CONFIG_KCORE_AOUT is not set
 CONFIG_BINFMT_ELF=y
diff -urN --exclude-from=/linux/diff_exclude_file linux-2.5.44/arch/sparc/defconfig linux-2.5.44-ikconfig/arch/sparc/defconfig
--- linux-2.5.44/arch/sparc/defconfig	Fri Oct 18 22:02:27 2002
+++ linux-2.5.44-ikconfig/arch/sparc/defconfig	Mon Oct 28 11:07:18 2002
@@ -17,6 +17,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set
 
 #
 # Loadable module support
diff -urN --exclude-from=/linux/diff_exclude_file linux-2.5.44/arch/sparc64/defconfig linux-2.5.44-ikconfig/arch/sparc64/defconfig
--- linux-2.5.44/arch/sparc64/defconfig	Fri Oct 18 22:01:22 2002
+++ linux-2.5.44-ikconfig/arch/sparc64/defconfig	Mon Oct 28 11:07:18 2002
@@ -14,6 +14,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set
 
 #
 # Loadable module support
diff -urN --exclude-from=/linux/diff_exclude_file linux-2.5.44/arch/um/defconfig linux-2.5.44-ikconfig/arch/um/defconfig
--- linux-2.5.44/arch/um/defconfig	Fri Oct 18 22:02:01 2002
+++ linux-2.5.44-ikconfig/arch/um/defconfig	Mon Oct 28 11:07:18 2002
@@ -20,6 +20,8 @@
 CONFIG_SYSVIPC=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set
 CONFIG_BINFMT_AOUT=y
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=y
diff -urN --exclude-from=/linux/diff_exclude_file linux-2.5.44/arch/x86_64/defconfig linux-2.5.44-ikconfig/arch/x86_64/defconfig
--- linux-2.5.44/arch/x86_64/defconfig	Fri Oct 18 22:02:26 2002
+++ linux-2.5.44-ikconfig/arch/x86_64/defconfig	Mon Oct 28 11:07:18 2002
@@ -24,6 +24,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set
 
 #
 # Loadable module support
diff -urN --exclude-from=/linux/diff_exclude_file linux-2.5.44/init/Config.help linux-2.5.44-ikconfig/init/Config.help
--- linux-2.5.44/init/Config.help	Fri Oct 18 22:02:00 2002
+++ linux-2.5.44-ikconfig/init/Config.help	Mon Oct 28 11:07:18 2002
@@ -80,6 +80,25 @@
   building a kernel for install/rescue disks or your system is very
   limited in memory.
 
+CONFIG_IKCONFIG
+  This option enables the complete Linux kernel ".config" file contents,
+  information on compiler used to build the kernel, kernel running when
+  this kernel was built and kernel version from Makefile to be saved in
+  kernel. It provides documentation of which kernel options are used in
+  a running kernel or in an on-disk kernel.  This information can be
+  extracted from the kernel image file with the script
+  scripts/extract-ikconfig and used as input to rebuild the current
+  kernel or to build another kernel. It can also be extracted from a
+  running kernel by reading /proc/ikconfig/config and
+  /proc/ikconfig/built_with, if enabled. /proc/ikconfig/config will list the
+  configuration that was used to build the kernel and
+  /proc/ikconfig/built_with will list information on the compiler and
+  host machine that was used to build the kernel.
+
+CONFIG_IKCONFIG_PROC
+  This option enables access to kernel configuration file and build
+  information through /proc/ikconfig.
+
 CONFIG_MODULES
   Kernel modules are small pieces of compiled code which can be
   inserted in or removed from the running kernel, using the programs
diff -urN --exclude-from=/linux/diff_exclude_file linux-2.5.44/init/Config.in linux-2.5.44-ikconfig/init/Config.in
--- linux-2.5.44/init/Config.in	Fri Oct 18 22:01:13 2002
+++ linux-2.5.44-ikconfig/init/Config.in	Mon Oct 28 11:07:18 2002
@@ -9,6 +9,8 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
+bool 'Kernel .config support' CONFIG_IKCONFIG
+dep_bool '   Enable access to .config through /proc/ikconfig' CONFIG_IKCONFIG_PROC $CONFIG_IKCONFIG
 endmenu
 
 mainmenu_option next_comment
diff -urN --exclude-from=/linux/diff_exclude_file linux-2.5.44/kernel/Makefile linux-2.5.44-ikconfig/kernel/Makefile
--- linux-2.5.44/kernel/Makefile	Fri Oct 18 22:01:17 2002
+++ linux-2.5.44-ikconfig/kernel/Makefile	Mon Oct 28 11:07:48 2002
@@ -21,6 +21,11 @@
 obj-$(CONFIG_CPU_FREQ) += cpufreq.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
+obj-$(CONFIG_IKCONFIG) += configs.o
+
+# files to be removed upon make clean
+clean-files := ikconfig.h
+
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
@@ -32,3 +37,10 @@
 endif
 
 include $(TOPDIR)/Rules.make
+
+$(obj)/ikconfig.h: $(TOPDIR)/scripts/mkconfigs $(TOPDIR)/.config $(TOPDIR)/Makefile
+	$(CONFIG_SHELL) $(TOPDIR)/scripts/mkconfigs $(TOPDIR)/.config $(TOPDIR)/Makefile > $(obj)/ikconfig.h
+
+$(obj)/configs.o: $(obj)/ikconfig.h $(obj)/configs.c \
+		$(TOPDIR)/include/linux/version.h \
+		$(TOPDIR)/include/linux/compile.h
diff -urN --exclude-from=/linux/diff_exclude_file linux-2.5.44/kernel/configs.c linux-2.5.44-ikconfig/kernel/configs.c
--- linux-2.5.44/kernel/configs.c	Wed Dec 31 17:00:00 1969
+++ linux-2.5.44-ikconfig/kernel/configs.c	Mon Oct 28 11:07:18 2002
@@ -0,0 +1,206 @@
+/*
+ * kernel/configs.c
+ *
+ * Copyright (C) 2002 Khalid Aziz <khalid_aziz@hp.com>
+ * Copyright (C) 2002 Randy Dunlap <rddunlap@osdl.org>
+ * Copyright (C) 2002 Al Stone <ahs3@fc.hp.com>
+ * Copyright (C) 2002 Hewlett-Packard Company
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ * Echo the kernel .config file used to build the kernel
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/init.h>
+#include <linux/compile.h>
+#include <linux/version.h>
+#include <asm/uaccess.h>
+
+/**************************************************/
+/* globals and useful constants                   */
+
+static char *IKCONFIG_NAME = "ikconfig";
+static char *IKCONFIG_VERSION = "0.4";
+
+static int ikconfig_current_size = 0;
+
+static struct proc_dir_entry *ikconfig_dir, *current_config, *built_with;
+
+/**************************************************/
+/* the actual current config file                 */
+
+#include "ikconfig.h"
+
+static int
+ikconfig_permission_current(struct inode *inode, int op)
+{
+	/* anyone can read the device, no one can write to it */
+	if (op == MAY_READ)
+		return 0;
+	else
+		return -EACCES;
+}
+
+static ssize_t
+ikconfig_output_current(struct file *file, char *buf,
+			 size_t len, loff_t * offset)
+{
+	int i, limit;
+	int cnt;
+
+	limit = (ikconfig_current_size > len) ? len : ikconfig_current_size;
+	for (i = file->f_pos, cnt = 0;
+	     i < ikconfig_current_size && cnt < limit; i++, cnt++) {
+		put_user(ikconfig_config[i], buf + cnt);
+	}
+	file->f_pos = i;
+	return cnt;
+}
+
+static int
+ikconfig_open_current(struct inode *inode, struct file *file)
+{
+	if (file->f_mode & FMODE_READ) {
+		inode->i_size = ikconfig_current_size;
+		file->f_pos = 0;
+	}
+	MOD_INC_USE_COUNT;
+	return 0;
+}
+
+static int
+ikconfig_close_current(struct inode *inode, struct file *file)
+{
+	MOD_DEC_USE_COUNT;
+	return 0;
+}
+
+static struct file_operations ikconfig_file_ops = {
+	read:ikconfig_output_current,
+	write:NULL,		/* file is not writable at all */
+	open:ikconfig_open_current,
+	release:ikconfig_close_current
+};
+
+static struct inode_operations ikconfig_inode_ops = {
+	permission:ikconfig_permission_current
+};
+
+/***************************************************/
+/* proc_read_built_with: let people read the info  */
+/* we have on the tools used to build this kernel  */
+
+static int
+proc_read_built_with(char *page, char **start,
+		     off_t off, int count, int *eof, void *data)
+{
+	MOD_INC_USE_COUNT;
+
+	sprintf(page, "Kernel:    %s\nCompiler:  %s\nVersion_in_Makefile: %s\n",
+		ikconfig_built_with, LINUX_COMPILER, UTS_RELEASE);
+	*eof = 1;
+
+	MOD_DEC_USE_COUNT;
+	return strlen(page);
+}
+
+/***************************************************/
+/* ikconfig_init: start up everything we need to */
+
+int __init
+ikconfig_init(void)
+{
+	int result = 0;
+
+#ifdef CONFIG_IKCONFIG_PROC
+	printk(KERN_INFO "ikconfig %s with /proc/ikconfig\n",
+	       IKCONFIG_VERSION);
+#else
+	printk(KERN_INFO "ikconfig %s without /proc/ikconfig\n",
+	       IKCONFIG_VERSION);
+	return result;
+#endif
+
+	/* create the ikconfig directory */
+	ikconfig_dir = proc_mkdir(IKCONFIG_NAME, NULL);
+	if (ikconfig_dir == NULL) {
+		result = -ENOMEM;
+		goto leave;
+	}
+	ikconfig_dir->owner = THIS_MODULE;
+
+	/* create the current config file */
+	current_config = create_proc_entry("config", S_IFREG | S_IRUGO,
+					   ikconfig_dir);
+	if (current_config == NULL) {
+		result = -ENOMEM;
+		goto leave2;
+	}
+	current_config->proc_iops = &ikconfig_inode_ops;
+	current_config->proc_fops = &ikconfig_file_ops;
+	current_config->owner = THIS_MODULE;
+	ikconfig_current_size = strlen(ikconfig_config);
+	current_config->size = ikconfig_current_size;
+
+	/* create the "built with" file */
+	built_with = create_proc_read_entry("built_with", 0444, ikconfig_dir,
+					    proc_read_built_with, NULL);
+	if (built_with == NULL) {
+		result = -ENOMEM;
+		goto leave3;
+	}
+	built_with->owner = THIS_MODULE;
+	goto leave;
+
+leave3:
+	/* remove the file from proc */
+	remove_proc_entry("config", ikconfig_dir);
+
+leave2:
+	/* remove the ikconfig directory */
+	remove_proc_entry(IKCONFIG_NAME, NULL);
+
+leave:
+	return result;
+}
+
+/***************************************************/
+/* cleanup_ikconfig: clean up our mess           */
+
+static void
+cleanup_ikconfig(void)
+{
+	/* remove the files */
+	remove_proc_entry("config", ikconfig_dir);
+	remove_proc_entry("built_with", ikconfig_dir);
+
+	/* remove the ikconfig directory */
+	remove_proc_entry(IKCONFIG_NAME, NULL);
+
+	printk(KERN_INFO "ikconfig unloaded\n");
+
+	return;
+}
+
+module_init(ikconfig_init);
+module_exit(cleanup_ikconfig);
+
+MODULE_LICENSE("GPL");
diff -urN --exclude-from=/linux/diff_exclude_file linux-2.5.44/scripts/extract-ikconfig linux-2.5.44-ikconfig/scripts/extract-ikconfig
--- linux-2.5.44/scripts/extract-ikconfig	Wed Dec 31 17:00:00 1969
+++ linux-2.5.44-ikconfig/scripts/extract-ikconfig	Mon Oct 28 11:07:18 2002
@@ -0,0 +1,101 @@
+#! /bin/bash 
+# extracts .config info from a [b]zImage file
+# uses: binoffset (new), dd, zcat, strings, grep
+# $arg1 is [b]zImage filename
+
+HDR=0
+TMPFILE=""
+
+usage()
+{
+	echo "  usage: extract-ikconfig [b]zImage_filename [architecture]"
+	echo "         where architecture is one of i386, ia64"
+}
+
+clean_up()
+{
+	if [ $HDR -ne 0 ]
+	then
+		rm -f $TMPFILE
+	fi
+}
+
+if [ $# -lt 1 ]
+then
+	usage
+	exit
+fi
+
+image=$1
+arch=$2
+
+if [ "$arch" = "" ]
+then
+	arch=`uname -m`
+fi
+arch=`echo $arch | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/`
+
+case $arch in
+i386)
+	HDR=`binoffset $image 0x1f 0x8b 0x08 0x0 2> /dev/null`
+	if [ "$HDR" = "" ]
+	then
+		echo "ERROR: Failed to find the start of kernel in kernel image file."
+		echo "       Please verify if binoffset is present on your system."
+		exit 1
+	fi
+	# If the kernel is uncompressed, binoffset will fail to find 
+	# gzip signature
+	if [ $HDR -eq -1 ]
+	then
+		HDR=0
+	fi
+	;;
+ia64)
+	HDR=0
+	;;
+*)
+	# We do not know where the kernel image might start in this file,
+	# but we may be able to extract configuration information 
+	# nevertheless if the kernel image is not compressed.
+	echo "WARNING: This script has not been ported to architecture $arch"
+	echo "         Unless you passed in an uncompressed kernel image file,"
+	echo "         this script may not produce correct result."
+	echo
+	HDR=0
+	;;
+esac
+
+PID=$$
+
+# Extract the kernel image if necessary
+if [ $HDR -ne 0 ]
+then
+	TMPFILE="/tmp/`basename $image`.vmlin.$PID"
+	dd if=$image bs=1 skip=$HDR 2> /dev/null > $TMPFILE
+else
+	TMPFILE=$image
+fi
+
+# Check if the kernel image is compressed. If it is, uncompress it before
+# looking for strings.
+file $TMPFILE | grep "gzip compressed" > /dev/null
+if [ $? -eq 0 ]
+then
+	zcat $TMPFILE | strings | awk "/CONFIG_BEGIN=n/,/CONFIG_END=n/" > $image.oldconfig.$PID
+else
+	strings $TMPFILE | grep "CONFIG_BEGIN=n" > /dev/null
+	if [ $? -eq 0 ]
+	then
+		strings $TMPFILE | awk "/CONFIG_BEGIN=n/,/CONFIG_END=n/" > $image.oldconfig.$PID
+	else
+		echo "ERROR: Unable to extract kernel configuration information."
+		echo "       This kernel image may not have the config info."
+		clean_up
+		exit 1
+	fi
+fi
+
+echo "Kernel configuration written to $image.oldconfig.$PID"
+clean_up
+exit 0
diff -urN --exclude-from=/linux/diff_exclude_file linux-2.5.44/scripts/mkconfigs linux-2.5.44-ikconfig/scripts/mkconfigs
--- linux-2.5.44/scripts/mkconfigs	Wed Dec 31 17:00:00 1969
+++ linux-2.5.44-ikconfig/scripts/mkconfigs	Mon Oct 28 17:00:47 2002
@@ -0,0 +1,81 @@
+#!/bin/sh
+#
+# Copyright (C) 2002 Khalid Aziz <khalid_aziz@hp.com>
+# Copyright (C) 2002 Randy Dunlap <rddunlap@osdl.org>
+# Copyright (C) 2002 Al Stone <ahs3@fc.hp.com>
+# Copyright (C) 2002 Hewlett-Packard Company
+#
+#   This program is free software; you can redistribute it and/or modify
+#   it under the terms of the GNU General Public License as published by
+#   the Free Software Foundation; either version 2 of the License, or
+#   (at your option) any later version.
+#
+#   This program is distributed in the hope that it will be useful,
+#   but WITHOUT ANY WARRANTY; without even the implied warranty of
+#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#   GNU General Public License for more details.
+#
+#   You should have received a copy of the GNU General Public License
+#   along with this program; if not, write to the Free Software
+#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+#
+# 
+# Rules to generate ikconfig.h from linux/.config:
+#	- Retain lines that begin with "CONFIG_"
+#	- Retain lines that begin with "# CONFIG_"
+#	- lines that use double-quotes must \\-escape-quote them
+
+
+kernel_version()
+{
+	KERNVER="`grep VERSION $1 | head -1 | cut -f3 -d' '`.`grep PATCHLEVEL $1 | head -1 | cut -f3 -d' '`.`grep SUBLEVEL $1 | head -1 | cut -f3 -d' '``grep EXTRAVERSION $1 | head -1 | cut -f3 -d' '`"
+}
+
+if [ $# -lt 2 ]
+then
+	echo "Usage: `basename $0` <configuration_file> <Makefile>"
+	exit 1
+fi
+
+config=$1
+makefile=$2
+
+echo "#ifndef _IKCONFIG_H"
+echo "#define _IKCONFIG_H"
+echo \
+"/*
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ * 
+ * This file is generated automatically by scripts/mkconfigs. Do not edit.
+ *
+ */"
+
+echo "static char *ikconfig_built_with ="
+echo "    \"`uname -s` `uname -r` `uname -v` `uname -m`\";"
+echo
+kernel_version $makefile
+echo "#ifdef CONFIG_IKCONFIG_PROC"
+echo "static char *ikconfig_config = "
+echo "#else"
+echo "static char *ikconfig_config __initdata __attribute__((unused)) = "
+echo "#endif"
+echo "\"CONFIG_BEGIN=n\\n\\"
+echo "`cat $config | sed 's/\"/\\\\\"/g' | grep "^#\? \?CONFIG_" | awk '{ print $0, "\\\\n\\\\" }' `"
+echo "CONFIG_END=n\";"
+echo "#endif /* _IKCONFIG_H */"
