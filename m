Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262675AbTCUBgA>; Thu, 20 Mar 2003 20:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262695AbTCUBf7>; Thu, 20 Mar 2003 20:35:59 -0500
Received: from air-2.osdl.org ([65.172.181.6]:5260 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262675AbTCUBfs>;
	Thu, 20 Mar 2003 20:35:48 -0500
Date: Thu, 20 Mar 2003 17:43:22 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] in-kernel config for 2.5.65
Message-Id: <20030320174322.04150f30.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've updated my in-kernel config (ikconfig) patch for 2.5.65.
I've tried to collect and apply input from several people,
so thanks if you've offered suggestions and/or code on this.
(e.g., Khalid Aziz, Tom Rini, Steve Hemminger, Andrew Bray,
Adrian Bunk, Sam Ravnborg; if I omitted someone, I apologize)


ikconfig patches are also available at
  http://www.osdl.org/archive/rddunlap/patches/ikconfig/

--
~Randy


patch_name:	ikconfig-2565-v3.patch
patch_version:	2003-03-20.10:38:44
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	config option to save .config in kernel image or
		expose it in /proc/ikconfig/config
product:	Linux
product_versions: 2.5.65
changelog:	add CONFIG_IKCONFIG option;
		optionally save .config in kernel image;
		another option to expose .config in /proc/ikconfig;
		add scripts and programs to extract .config on demand;
URL:		http://www.osdl.org/archive/rddunlap/patches/ikconfig/
maintainer:	<rddunlap@osdl.org>
diffstat:	=
 init/Kconfig             |   25 ++++++
 kernel/Makefile          |   10 ++
 kernel/configs.c         |  188 +++++++++++++++++++++++++++++++++++++++++++++++
 scripts/binoffset.c      |  163 ++++++++++++++++++++++++++++++++++++++++
 scripts/extract-ikconfig |   66 ++++++++++++++++
 scripts/mkconfigs        |   81 ++++++++++++++++++++
 6 files changed, 533 insertions(+)


diff -Naur ./scripts/mkconfigs%IKC ./scripts/mkconfigs
--- ./scripts/mkconfigs%IKC	Wed Mar 19 11:03:51 2003
+++ ./scripts/mkconfigs	Tue Mar 18 23:01:16 2003
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
diff -Naur ./scripts/extract-ikconfig%IKC ./scripts/extract-ikconfig
--- ./scripts/extract-ikconfig%IKC	Wed Mar 19 11:22:52 2003
+++ ./scripts/extract-ikconfig	Wed Mar 19 13:56:13 2003
@@ -0,0 +1,66 @@
+#! /bin/bash 
+# extracts .config info from a [b]zImage file
+# uses: binoffset (new), dd, zcat, strings, grep
+# $arg1 is [b]zImage filename
+
+TMPFILE=""
+
+usage()
+{
+	echo "  usage: extract-ikconfig [b]zImage_filename"
+}
+
+clean_up()
+{
+	if [ -z $ISCOMP ]
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
+
+# There are two gzip headers, as well as arches which don't compress their
+# kernel.
+GZHDR="0x1f 0x8b 0x08 0x00"
+if [ `binoffset $image $GZHDR >/dev/null 2>&1 ; echo $?` -ne 0 ]
+then
+	GZHDR="0x1f 0x8b 0x08 0x08"
+	if [ `binoffset $image $GZHDR >/dev/null 2>&1 ; echo $?` -ne 0 ]
+	then
+		ISCOMP=0
+	fi
+fi
+
+PID=$$
+
+# Extract and uncompress the kernel image if necessary
+if [ -z $ISCOMP ]
+then
+	TMPFILE="/tmp/`basename $image`.vmlin.$PID"
+	dd if=$image bs=1 skip=`binoffset $image $GZHDR` 2> /dev/null | zcat > $TMPFILE
+else
+	TMPFILE=$image
+fi
+
+# Look for strings.
+strings $TMPFILE | grep "CONFIG_BEGIN=n" > /dev/null
+if [ $? -eq 0 ]
+then
+	strings $TMPFILE | awk "/CONFIG_BEGIN=n/,/CONFIG_END=n/" > $image.oldconfig.$PID
+else
+	echo "ERROR: Unable to extract kernel configuration information."
+	echo "       This kernel image may not have the config info."
+	clean_up
+	exit 1
+fi
+
+echo "Kernel configuration written to $image.oldconfig.$PID"
+clean_up
+exit 0
diff -Naur ./scripts/binoffset.c%IKC ./scripts/binoffset.c
--- ./scripts/binoffset.c%IKC	Wed Mar 19 14:54:09 2003
+++ ./scripts/binoffset.c	Thu Feb 14 15:57:06 2002
@@ -0,0 +1,163 @@
+/***************************************************************************
+ * binoffset.c
+ * (C) 2002 Randy Dunlap <rddunlap@osdl.org>
+
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
+
+# binoffset.c:
+# - searches a (binary) file for a specified (binary) pattern
+# - returns the offset of the located pattern or ~0 if not found
+# - exits with exit status 0 normally or non-0 if pattern is not found
+#   or any other error occurs.
+
+****************************************************************/
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+
+#define VERSION		"0.1"
+#define BUF_SIZE	(16 * 1024)
+#define PAT_SIZE	100
+
+char		*progname;
+char		*inputname;
+int		inputfd;
+int		bix;			/* buf index */
+unsigned char	patterns [PAT_SIZE] = {0}; /* byte-sized pattern array */
+int		pat_len;		/* actual number of pattern bytes */
+unsigned char	*madr;			/* mmap address */
+size_t		filesize;
+int		num_matches = 0;
+off_t		firstloc = 0;
+
+void usage (void)
+{
+	fprintf (stderr, "%s ver. %s\n", progname, VERSION);
+	fprintf (stderr, "usage:  %s filename pattern_bytes\n",
+			progname);
+	fprintf (stderr, "        [prints location of pattern_bytes in file]\n");
+	exit (1);
+}
+
+int get_pattern (int pat_count, char *pats [])
+{
+	int ix, err, tmp;
+
+#ifdef DEBUG
+	fprintf (stderr,"get_pattern: count = %d\n", pat_count);
+	for (ix = 0; ix < pat_count; ix++)
+		fprintf (stderr, "  pat # %d:  [%s]\n", ix, pats[ix]);
+#endif
+
+	for (ix = 0; ix < pat_count; ix++) {
+		tmp = 0;
+		err = sscanf (pats[ix], "%5i", &tmp);
+		if (err != 1 || tmp > 0xff) {
+			fprintf (stderr, "pattern or value error in pattern # %d [%s]\n",
+					ix, pats[ix]);
+			usage ();
+		}
+		patterns [ix] = tmp;
+	}
+	pat_len = pat_count;
+}
+
+int search_pattern (void)
+{
+	for (bix = 0; bix < filesize; bix++) {
+		if (madr[bix] == patterns[0]) {
+			if (memcmp (&madr[bix], patterns, pat_len) == 0) {
+				if (num_matches == 0)
+					firstloc = bix;
+				num_matches++;
+			}
+		}
+	}
+}
+
+#ifdef NOTDEF
+size_t get_filesize (int fd)
+{
+	off_t end_off = lseek (fd, 0, SEEK_END);
+	lseek (fd, 0, SEEK_SET);
+	return (size_t) end_off;
+}
+#endif
+
+size_t get_filesize (int fd)
+{
+	int err;
+	struct stat stat;
+
+	err = fstat (fd, &stat);
+	fprintf (stderr, "filesize: %d\n", err < 0 ? err : stat.st_size);
+	if (err < 0)
+		return err;
+	return (size_t) stat.st_size;
+}
+
+int main (int argc, char *argv [])
+{
+	progname = argv[0];
+
+	if (argc < 3)
+		usage ();
+
+	get_pattern (argc - 2, argv + 2);
+
+	inputname = argv[1];
+
+	inputfd = open (inputname, O_RDONLY);
+	if (inputfd == -1) {
+		fprintf (stderr, "%s: cannot open '%s'\n",
+				progname, inputname);
+		exit (3);
+	}
+
+	filesize = get_filesize (inputfd);
+
+	madr = mmap (0, filesize, PROT_READ, MAP_PRIVATE, inputfd, 0);
+	if (madr == MAP_FAILED) {
+		fprintf (stderr, "mmap error = %d\n", errno);
+		close (inputfd);
+		exit (4);
+	}
+
+	search_pattern ();
+
+	if (munmap (madr, filesize))
+		fprintf (stderr, "munmap error = %d\n", errno);
+
+	if (close (inputfd))
+		fprintf (stderr, "%s: error %d closing '%s'\n",
+				progname, errno, inputname);
+
+	fprintf (stderr, "number of pattern matches = %d\n", num_matches);
+	if (num_matches == 0)
+		firstloc = ~0;
+	printf ("%d\n", firstloc);
+	fprintf (stderr, "%d\n", firstloc);
+
+	exit (num_matches ? 0 : 2);
+}
+
+/* end binoffset.c */
diff -Naur ./kernel/configs.c%IKC ./kernel/configs.c
--- ./kernel/configs.c%IKC	Wed Mar 19 11:08:03 2003
+++ ./kernel/configs.c	Thu Mar 20 09:32:13 2003
@@ -0,0 +1,188 @@
+/*
+ * kernel/configs.c
+ * Echo the kernel .config file used to build the kernel
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
+/* the actual current config file                 */
+
+#include "ikconfig.h"
+
+#ifdef CONFIG_IKCONFIG_PROC
+
+/**************************************************/
+/* globals and useful constants                   */
+
+static char *IKCONFIG_NAME = "ikconfig";
+static char *IKCONFIG_VERSION = "0.5";
+
+static int ikconfig_current_size = 0;
+static struct proc_dir_entry *ikconfig_dir, *current_config, *built_with;
+
+static int
+ikconfig_permission_current(struct inode *inode, int op)
+{
+	/* anyone can read the device, no one can write to it */
+	return (op == MAY_READ) ? 0 : -EACCES;
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
+	return 0;
+}
+
+static int
+ikconfig_close_current(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static struct file_operations ikconfig_file_ops = {
+	.read = ikconfig_output_current,
+	.open = ikconfig_open_current,
+	.release = ikconfig_close_current,
+};
+
+static struct inode_operations ikconfig_inode_ops = {
+	.permission = ikconfig_permission_current,
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
+	*eof = 1;
+	return sprintf(page,
+			"Kernel:    %s\nCompiler:  %s\nVersion_in_Makefile: %s\n",
+			ikconfig_built_with, LINUX_COMPILER, UTS_RELEASE);
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
+	printk(KERN_INFO "ikconfig %s with /proc/ikconfig\n",
+	       IKCONFIG_VERSION);
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
+}
+
+module_init(ikconfig_init);
+module_exit(cleanup_ikconfig);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Randy Dunlap");
+MODULE_DESCRIPTION("Echo the kernel .config file used to build the kernel");
+
+#endif /* CONFIG_IKCONFIG_PROC */
diff -Naur ./kernel/Makefile%IKC ./kernel/Makefile
--- ./kernel/Makefile%IKC	Mon Mar 17 13:43:46 2003
+++ ./kernel/Makefile	Wed Mar 19 16:02:59 2003
@@ -18,6 +18,10 @@
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
 obj-$(CONFIG_COMPAT) += compat.o
+obj-$(CONFIG_IKCONFIG) += configs.o
+
+# files to be removed upon make clean
+clean-files := ikconfig.h
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
@@ -27,3 +31,9 @@
 # to get a correct value for the wait-channel (WCHAN in ps). --davidm
 CFLAGS_sched.o := $(PROFILING) -fno-omit-frame-pointer
 endif
+
+$(obj)/ikconfig.h: scripts/mkconfigs .config Makefile
+	$(CONFIG_SHELL) scripts/mkconfigs .config Makefile > $(obj)/ikconfig.h
+
+$(obj)/configs.o: $(obj)/ikconfig.h $(obj)/configs.c \
+		include/linux/version.h include/linux/compile.h
diff -Naur ./init/Kconfig%IKC ./init/Kconfig
--- ./init/Kconfig%IKC	Mon Mar 17 13:44:40 2003
+++ ./init/Kconfig	Wed Mar 19 11:11:59 2003
@@ -108,6 +108,31 @@
 		     13 =>  8 KB
 		     12 =>  4 KB
 
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
 
 
