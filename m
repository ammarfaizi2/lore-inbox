Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267353AbTACApl>; Thu, 2 Jan 2003 19:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267361AbTACApl>; Thu, 2 Jan 2003 19:45:41 -0500
Received: from air-2.osdl.org ([65.172.181.6]:46553 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267353AbTACApW>;
	Thu, 2 Jan 2003 19:45:22 -0500
Date: Thu, 2 Jan 2003 16:51:01 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: kernel .config support?
In-Reply-To: <Pine.LNX.4.33L2.0301020741110.22868-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33L2.0301021649400.22868-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 2003, Randy.Dunlap wrote:

| On Thu, 2 Jan 2003, Robert P. J. Day wrote:
|
| |   whatever happened to that funky option from 2.4 --
| | for kernel .config support, which allegedly buried the
| | config file inside the kernel itself.  (it never worked --
| | the alleged extraction script scripts/extract-ikconfig
| | depended on a program called "binoffset" that didn't
| | exist in that distribution.)
| |
| |   any plans to resurrect this, or something like it?
|
| Khalid Aziz et al (HP) have updated it to 2.5.
| It's also part of the OSDL 2.5 DCL and CGL trees.
| See http://developer.osdl.org/ for info on them.
|
| I'll check to make sure there is a separate patch available for it
| and repost it.


I have updated Khalid's 2.5.50 patch for 2.5.54 for comments or use.
It is below.
Here is Khalid's 2.5.50 email also.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I am including a patch for 2.5.50 that allows a user to embed kernel
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

[Linus, please apply.]

====================================================================
patch_name:     ikconfig-2554.patch
patch_version:  2003.01.02
author:         Randy Dunlap <rddunlap@osdl.org>
description:    add in-kernel and /proc config options
product:        linux
product_versions: 2.5.54
changelog:      (a) add 2 options in General Setup
URL:            http://www.osdl.org/archive/rddunlap/patches/
requires:
conflicts:
diffstat:
 linux-2554-ikconfig/arch/alpha/defconfig     |    2
 linux-2554-ikconfig/arch/arm/defconfig       |    2
 linux-2554-ikconfig/arch/cris/defconfig      |    2
 linux-2554-ikconfig/arch/i386/defconfig      |    2
 linux-2554-ikconfig/arch/ia64/defconfig      |    2
 linux-2554-ikconfig/arch/m68k/defconfig      |    2
 linux-2554-ikconfig/arch/mips/defconfig      |    2
 linux-2554-ikconfig/arch/mips64/defconfig    |    3
 linux-2554-ikconfig/arch/ppc/defconfig       |    2
 linux-2554-ikconfig/arch/ppc64/defconfig     |    2
 linux-2554-ikconfig/arch/s390/defconfig      |    2
 linux-2554-ikconfig/arch/s390x/defconfig     |    2
 linux-2554-ikconfig/arch/sh/defconfig        |    2
 linux-2554-ikconfig/arch/sparc/defconfig     |    2
 linux-2554-ikconfig/arch/sparc64/defconfig   |    2
 linux-2554-ikconfig/arch/um/defconfig        |    2
 linux-2554-ikconfig/arch/x86_64/defconfig    |    2
 linux-2554-ikconfig/init/Kconfig             |   25 +++
 linux-2554-ikconfig/kernel/configs.c         |  206 +++++++++++++++++++++++++++
 linux-2554-ikconfig/scripts/extract-ikconfig |  101 +++++++++++++
 linux-2554-ikconfig/scripts/mkconfigs        |   81 ++++++++++
 linux-2554/kernel/Makefile                   |   11 +
 22 files changed, 459 insertions(+)


diff -urN --exclude-from=diff_exclude_file linux-2554/arch/alpha/defconfig linux-2554-ikconfig/arch/alpha/defconfig
--- linux-2554/arch/alpha/defconfig	Wed Nov 27 15:36:00 2002
+++ linux-2554-ikconfig/arch/alpha/defconfig	Mon Dec  2 12:50:12 2002
@@ -19,6 +19,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set

 #
 # Loadable module support
diff -urN --exclude-from=diff_exclude_file linux-2554/arch/arm/defconfig linux-2554-ikconfig/arch/arm/defconfig
--- linux-2554/arch/arm/defconfig	Wed Nov 27 15:35:54 2002
+++ linux-2554-ikconfig/arch/arm/defconfig	Mon Dec  2 12:50:12 2002
@@ -80,6 +80,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set
 CONFIG_NWFPE=y
 CONFIG_KCORE_ELF=y
 # CONFIG_KCORE_AOUT is not set
diff -urN --exclude-from=diff_exclude_file linux-2554/arch/cris/defconfig linux-2554-ikconfig/arch/cris/defconfig
--- linux-2554/arch/cris/defconfig	Wed Nov 27 15:35:55 2002
+++ linux-2554-ikconfig/arch/cris/defconfig	Mon Dec  2 12:50:12 2002
@@ -17,6 +17,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_SYSCTL is not set
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set
 CONFIG_BINFMT_ELF=y
 # CONFIG_ETRAX_KGDB is not set
 # CONFIG_ETRAX_WATCHDOG is not set
diff -urN --exclude-from=diff_exclude_file linux-2554/arch/i386/defconfig linux-2554-ikconfig/arch/i386/defconfig
--- linux-2554/arch/i386/defconfig	Wed Nov 27 15:36:15 2002
+++ linux-2554-ikconfig/arch/i386/defconfig	Mon Dec  2 12:50:12 2002
@@ -19,6 +19,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set

 #
 # Loadable module support
diff -urN --exclude-from=diff_exclude_file linux-2554/arch/ia64/defconfig linux-2554-ikconfig/arch/ia64/defconfig
--- linux-2554/arch/ia64/defconfig	Wed Nov 27 15:35:49 2002
+++ linux-2554-ikconfig/arch/ia64/defconfig	Mon Dec  2 12:50:12 2002
@@ -14,6 +14,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set

 #
 # Loadable module support
diff -urN --exclude-from=diff_exclude_file linux-2554/arch/m68k/defconfig linux-2554-ikconfig/arch/m68k/defconfig
--- linux-2554/arch/m68k/defconfig	Wed Nov 27 15:35:48 2002
+++ linux-2554-ikconfig/arch/m68k/defconfig	Mon Dec  2 12:50:12 2002
@@ -42,6 +42,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set
 CONFIG_KCORE_ELF=y
 # CONFIG_KCORE_AOUT is not set
 CONFIG_BINFMT_AOUT=y
diff -urN --exclude-from=diff_exclude_file linux-2554/arch/mips/defconfig linux-2554-ikconfig/arch/mips/defconfig
--- linux-2554/arch/mips/defconfig	Wed Nov 27 15:35:50 2002
+++ linux-2554-ikconfig/arch/mips/defconfig	Mon Dec  2 12:50:12 2002
@@ -93,6 +93,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set

 #
 # Memory Technology Devices (MTD)
diff -urN --exclude-from=diff_exclude_file linux-2554/arch/mips64/defconfig linux-2554-ikconfig/arch/mips64/defconfig
--- linux-2554/arch/mips64/defconfig	Wed Nov 27 15:36:16 2002
+++ linux-2554-ikconfig/arch/mips64/defconfig	Mon Dec  2 12:50:12 2002
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
diff -urN --exclude-from=diff_exclude_file linux-2554/arch/ppc/defconfig linux-2554-ikconfig/arch/ppc/defconfig
--- linux-2554/arch/ppc/defconfig	Wed Nov 27 15:36:17 2002
+++ linux-2554-ikconfig/arch/ppc/defconfig	Mon Dec  2 12:50:12 2002
@@ -64,6 +64,8 @@
 CONFIG_PCI=y
 CONFIG_NET=y
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_KCORE_ELF=y
diff -urN --exclude-from=diff_exclude_file linux-2554/arch/ppc64/defconfig linux-2554-ikconfig/arch/ppc64/defconfig
--- linux-2554/arch/ppc64/defconfig	Wed Nov 27 15:35:53 2002
+++ linux-2554-ikconfig/arch/ppc64/defconfig	Mon Dec  2 12:50:12 2002
@@ -20,6 +20,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set

 #
 # Loadable module support
diff -urN --exclude-from=diff_exclude_file linux-2554/arch/s390/defconfig linux-2554-ikconfig/arch/s390/defconfig
--- linux-2554/arch/s390/defconfig	Wed Nov 27 15:36:18 2002
+++ linux-2554-ikconfig/arch/s390/defconfig	Mon Dec  2 12:50:12 2002
@@ -19,6 +19,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set

 #
 # Loadable module support
diff -urN --exclude-from=diff_exclude_file linux-2554/arch/s390x/defconfig linux-2554-ikconfig/arch/s390x/defconfig
--- linux-2554/arch/s390x/defconfig	Wed Nov 27 15:35:46 2002
+++ linux-2554-ikconfig/arch/s390x/defconfig	Mon Dec  2 12:50:12 2002
@@ -19,6 +19,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set

 #
 # Loadable module support
diff -urN --exclude-from=diff_exclude_file linux-2554/arch/sh/defconfig linux-2554-ikconfig/arch/sh/defconfig
--- linux-2554/arch/sh/defconfig	Wed Nov 27 15:36:01 2002
+++ linux-2554-ikconfig/arch/sh/defconfig	Mon Dec  2 12:50:12 2002
@@ -45,6 +45,8 @@
 # CONFIG_SYSVIPC is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_SYSCTL is not set
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set
 CONFIG_KCORE_ELF=y
 # CONFIG_KCORE_AOUT is not set
 CONFIG_BINFMT_ELF=y
diff -urN --exclude-from=diff_exclude_file linux-2554/arch/sparc/defconfig linux-2554-ikconfig/arch/sparc/defconfig
--- linux-2554/arch/sparc/defconfig	Wed Nov 27 15:36:16 2002
+++ linux-2554-ikconfig/arch/sparc/defconfig	Mon Dec  2 12:50:12 2002
@@ -19,6 +19,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set

 #
 # Loadable module support
diff -urN --exclude-from=diff_exclude_file linux-2554/arch/sparc64/defconfig linux-2554-ikconfig/arch/sparc64/defconfig
--- linux-2554/arch/sparc64/defconfig	Wed Nov 27 15:35:56 2002
+++ linux-2554-ikconfig/arch/sparc64/defconfig	Mon Dec  2 12:50:12 2002
@@ -16,6 +16,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set

 #
 # Loadable module support
diff -urN --exclude-from=diff_exclude_file linux-2554/arch/um/defconfig linux-2554-ikconfig/arch/um/defconfig
--- linux-2554/arch/um/defconfig	Wed Nov 27 15:36:15 2002
+++ linux-2554-ikconfig/arch/um/defconfig	Mon Dec  2 12:50:12 2002
@@ -20,6 +20,8 @@
 CONFIG_SYSVIPC=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set
 CONFIG_BINFMT_AOUT=y
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=y
diff -urN --exclude-from=diff_exclude_file linux-2554/arch/x86_64/defconfig linux-2554-ikconfig/arch/x86_64/defconfig
--- linux-2554/arch/x86_64/defconfig	Wed Nov 27 15:36:15 2002
+++ linux-2554-ikconfig/arch/x86_64/defconfig	Mon Dec  2 12:50:12 2002
@@ -23,6 +23,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_IKCONFIG_PROC is not set

 #
 # Loadable module support
diff -urN --exclude-from=diff_exclude_file linux-2554/init/Kconfig linux-2554-ikconfig/init/Kconfig
--- linux-2554/init/Kconfig	Wed Nov 27 15:36:17 2002
+++ linux-2554-ikconfig/init/Kconfig	Mon Dec  2 13:42:50 2002
@@ -98,6 +98,31 @@
 	  building a kernel for install/rescue disks or your system is very
 	  limited in memory.

+config IKCONFIG
+	bool "Kernel .config support"
+	---help---
+	  This option enables the complete Linux kernel ".config" file
+	  contents, information on compiler used to build the kernel,
+	  kernel running when this kernel was built and kernel version
+	  from Makefile to be saved in kernel. It provides documentation
+	  of which kernel options are used in a running kernel or in an
+	  on-disk kernel.  This information can be extracted from the kernel
+	  image file with the script scripts/extract-ikconfig and used as
+	  input to rebuild the current kernel or to build another kernel.
+	  It can also be extracted from a running kernel by reading
+	  /proc/ikconfig/config and /proc/ikconfig/built_with, if enabled.
+	  /proc/ikconfig/config will list the configuration that was used
+	  to build the kernel and /proc/ikconfig/built_with will list
+	  information on the compiler and host machine that was used to
+	  build the kernel.
+
+config IKCONFIG_PROC
+	bool "Enable access to .config through /proc/ikconfig"
+	depends on IKCONFIG
+	---help---
+	  This option enables access to kernel configuration file and build
+	  information through /proc/ikconfig.
+
 endmenu


diff -urN --exclude-from=diff_exclude_file linux-2554/kernel/configs.c linux-2554-ikconfig/kernel/configs.c
--- linux-2554/kernel/configs.c	Wed Dec 31 17:00:00 1969
+++ linux-2554-ikconfig/kernel/configs.c	Mon Dec  2 12:50:12 2002
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
+static char *IKCONFIG_VERSION = "0.5";
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
diff -urN --exclude-from=diff_exclude_file linux-2554/scripts/extract-ikconfig linux-2554-ikconfig/scripts/extract-ikconfig
--- linux-2554/scripts/extract-ikconfig	Wed Dec 31 17:00:00 1969
+++ linux-2554-ikconfig/scripts/extract-ikconfig	Mon Dec  2 12:50:12 2002
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
diff -urN --exclude-from=diff_exclude_file linux-2554/scripts/mkconfigs linux-2554-ikconfig/scripts/mkconfigs
--- linux-2554/scripts/mkconfigs	Wed Dec 31 17:00:00 1969
+++ linux-2554-ikconfig/scripts/mkconfigs	Mon Dec  2 12:50:12 2002
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
--- linux-2554/kernel/Makefile%IKC	Wed Jan  1 19:21:14 2003
+++ linux-2554/kernel/Makefile	Thu Jan  2 15:31:38 2003
@@ -22,6 +22,10 @@
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
 obj-$(CONFIG_COMPAT) += compat.o
+obj-$(CONFIG_IKCONFIG) += configs.o
+
+# files to be removed upon make clean
+clean-files := ikconfig.h

 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
@@ -31,3 +35,10 @@
 # to get a correct value for the wait-channel (WCHAN in ps). --davidm
 CFLAGS_sched.o := $(PROFILING) -fno-omit-frame-pointer
 endif
+
+$(obj)/ikconfig.h: $(TOPDIR)/scripts/mkconfigs $(TOPDIR)/.config $(TOPDIR)/Makefile
+	$(CONFIG_SHELL) $(TOPDIR)/scripts/mkconfigs $(TOPDIR)/.config $(TOPDIR)/Makefile > $(obj)/ikconfig.h
+
+$(obj)/configs.o: $(obj)/ikconfig.h $(obj)/configs.c \
+		$(TOPDIR)/include/linux/version.h \
+		$(TOPDIR)/include/linux/compile.h

