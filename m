Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262411AbVAPCnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262411AbVAPCnI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 21:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbVAPCnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 21:43:01 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:22146 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262408AbVAPCl4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 21:41:56 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16873.57171.814571.591186@tut.ibm.com>
Date: Sat, 15 Jan 2005 21:28:19 -0600
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, ltt-dev@shafik.org, karim@opersys.com
Subject: [PATCH][2.6.11-rc1-mm1] relayfs - remove klog debugging channel
X-Mailer: VM 7.18 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch removes from relayfs the 'klog debugging channel', which is
a relayfs 'application' that doesn't belong in the main code.  Please
apply.

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

diff -urpN -X dontdiff linux-2.6.11-rc1-mm1-vanilla/fs/Kconfig linux-2.6.11-rc1-mm1-cur/fs/Kconfig
--- linux-2.6.11-rc1-mm1-vanilla/fs/Kconfig	Fri Jan 14 06:13:12 2005
+++ linux-2.6.11-rc1-mm1-cur/fs/Kconfig	Fri Jan 14 09:28:25 2005
@@ -923,8 +923,7 @@ config RELAYFS_FS
 	  an efficient mechanism for tools and facilities to relay large
 	  amounts of data from kernel space to user space.  It's not useful
 	  on its own, and should only be enabled if other facilities that
-	  need it are enabled, such as for example klog or the Linux Trace
-	  Toolkit.
+	  need it are enabled, such as for example the Linux Trace Toolkit.
 
 	  See <file:Documentation/filesystems/relayfs.txt> for further
 	  information.
@@ -935,37 +934,6 @@ config RELAYFS_FS
 	  module, say M here and read <file:Documentation/modules.txt>.
 
 	  If unsure, say N.
-
-config KLOG_CHANNEL
-	bool "Enable klog debugging support"
-	depends on RELAYFS_FS
-	default n
-	help
-	  If you say Y to this, a relayfs channel named klog will be created
-	  in the root of the relayfs file system.  You can write to the klog
-	  channel using klog() or klog_raw() from within the kernel or
-	  kernel modules, and read from the klog channel by mounting relayfs
-	  and using read(2) to read from it (or using cat).  If you're not
-	  sure, say N.
-
-config KLOG_CHANNEL_AUTOENABLE
-	bool "Enable klog logging on startup"
-	depends on KLOG_CHANNEL
-	default y
-	help
-	  If you say Y to this, the klog channel will be automatically enabled
-	  on startup.  Otherwise, to turn klog logging on, you need use
-	  sysctl (fs.relayfs.klog_enabled).  This option is used in cases where
-	  you don't actually want the channel to be written to until it's
-	  enabled.  If you're not sure, say Y.
-
-config KLOG_CHANNEL_SHIFT
-	depends on KLOG_CHANNEL
-	int "klog debugging channel size (14 => 16KB, 22 => 4MB)"
-	range 14 22
-	default 21
-	help
-	  Select klog debugging channel size as a power of 2.
 
 endmenu
 
diff -urpN -X dontdiff linux-2.6.11-rc1-mm1-vanilla/fs/relayfs/Makefile linux-2.6.11-rc1-mm1-cur/fs/relayfs/Makefile
--- linux-2.6.11-rc1-mm1-vanilla/fs/relayfs/Makefile	Fri Jan 14 06:13:13 2005
+++ linux-2.6.11-rc1-mm1-cur/fs/relayfs/Makefile	Fri Jan 14 09:30:25 2005
@@ -5,4 +5,4 @@
 obj-$(CONFIG_RELAYFS_FS) += relayfs.o
 
 relayfs-y := relay.o relay_lockless.o relay_locking.o inode.o resize.o
-relayfs-$(CONFIG_KLOG_CHANNEL) += klog.o
+
diff -urpN -X dontdiff linux-2.6.11-rc1-mm1-vanilla/fs/relayfs/inode.c linux-2.6.11-rc1-mm1-cur/fs/relayfs/inode.c
--- linux-2.6.11-rc1-mm1-vanilla/fs/relayfs/inode.c	Fri Jan 14 06:13:13 2005
+++ linux-2.6.11-rc1-mm1-cur/fs/relayfs/inode.c	Fri Jan 14 09:29:17 2005
@@ -604,19 +604,12 @@ static int __init
 init_relayfs_fs(void)
 {
 	int err = register_filesystem(&relayfs_fs_type);
-#ifdef CONFIG_KLOG_CHANNEL
-	if (!err)
-		create_klog_channel();
-#endif
 	return err;
 }
 
 static void __exit
 exit_relayfs_fs(void)
 {
-#ifdef CONFIG_KLOG_CHANNEL
-	remove_klog_channel();
-#endif
 	unregister_filesystem(&relayfs_fs_type);
 }
 
diff -urpN -X dontdiff linux-2.6.11-rc1-mm1-vanilla/fs/relayfs/klog.c linux-2.6.11-rc1-mm1-cur/fs/relayfs/klog.c
--- linux-2.6.11-rc1-mm1-vanilla/fs/relayfs/klog.c	Fri Jan 14 06:13:13 2005
+++ linux-2.6.11-rc1-mm1-cur/fs/relayfs/klog.c	Wed Dec 31 18:00:00 1969
@@ -1,206 +0,0 @@
-/*
- * KLOG		Generic Logging facility built upon the relayfs infrastructure
- *
- * Authors:	Hubertus Franke  (frankeh@us.ibm.com)
- *		Tom Zanussi  (zanussi@us.ibm.com)
- *
- *		Please direct all questions/comments to zanussi@us.ibm.com
- *
- *		Copyright (C) 2003, IBM Corp
- *
- *		This program is free software; you can redistribute it and/or
- *		modify it under the terms of the GNU General Public License
- *		as published by the Free Software Foundation; either version
- *		2 of the License, or (at your option) any later version.
- */
-
-#include <linux/kernel.h>
-#include <linux/smp_lock.h>
-#include <linux/console.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/config.h>
-#include <linux/delay.h>
-#include <linux/smp.h>
-#include <linux/sysctl.h>
-#include <linux/relayfs_fs.h>
-#include <linux/klog.h>
-
-/* klog channel id */
-static int klog_channel = -1;
-
-/* maximum size of klog formatting buffer beyond which truncation will occur */
-#define KLOG_BUF_SIZE (512)
-/* per-cpu klog formatting buffer */
-static char buf[NR_CPUS][KLOG_BUF_SIZE];
-
-/*
- *	klog_enabled determines whether klog()/klog_raw() actually do write
- *	to the klog channel at any given time. If klog_enabled == 1 they do,
- *	otherwise they don't.  Settable using sysctl fs.relayfs.klog_enabled.
- */
-#ifdef CONFIG_KLOG_CHANNEL_AUTOENABLE
-static int klog_enabled = 1;
-#else
-static int klog_enabled = 0;
-#endif
-
-/**
- *	klog - write a formatted string into the klog channel
- *	@fmt: format string
- *
- *	Returns number of bytes written, negative number on failure.
- */
-int klog(const char *fmt, ...)
-{
-	va_list args;
-	int len, err;
-	char *cbuf;
-	unsigned long flags;
-
-	if (!klog_enabled || klog_channel < 0)
-		return 0;
-
-	local_irq_save(flags);
-	cbuf = buf[smp_processor_id()];
-
-	va_start(args, fmt);
-	len = vsnprintf(cbuf, KLOG_BUF_SIZE, fmt, args);
-	va_end(args);
-
-	err = relay_write(klog_channel, cbuf, len, -1, NULL);
-	local_irq_restore(flags);
-
-	return err;
-}
-
-/**
- *	klog_raw - directly write into the klog channel
- *	@buf: buffer containing data to write
- *	@len: # bytes to write
- *
- *	Returns number of bytes written, negative number on failure.
- */
-int klog_raw(const char *buf,int len)
-{
-	int err = 0;
-
-	if (klog_enabled && klog_channel >= 0)
-		err = relay_write(klog_channel, buf, len, -1, NULL);
-
-	return err;
-}
-
-/**
- *	relayfs sysctl data
- *
- *	Only sys/fs/relayfs/klog_enabled for now.
- */
-#define CTL_ENABLE_KLOG		100
-#define CTL_RELAYFS		100
-
-static struct ctl_table_header *relayfs_ctl_table_header;
-
-static struct ctl_table relayfs_table[] =
-{
-	{
-		.ctl_name	= CTL_ENABLE_KLOG,
-		.procname	= "klog_enabled",
-		.data		= &klog_enabled,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
-	},
-	{
-		0
-	}
-};
-
-static struct ctl_table relayfs_dir_table[] =
-{
-	{
-		.ctl_name	= CTL_RELAYFS,
-		.procname	= "relayfs",
-		.data		= NULL,
-		.maxlen		= 0,
-		.mode		= 0555,
-		.child		= relayfs_table,
-	},
-	{
-		0
-	}
-};
-
-static struct ctl_table relayfs_root_table[] =
-{
-	{
-		.ctl_name	= CTL_FS,
-		.procname	= "fs",
-		.data		= NULL,
-		.maxlen		= 0,
-		.mode		= 0555,
-		.child		= relayfs_dir_table,
-	},
-	{
-		0
-	}
-};
-
-/**
- *	create_klog_channel - creates channel /mnt/relay/klog
- *
- *	Returns channel id on success, negative otherwise.
- */
-int
-create_klog_channel(void)
-{
-	u32 bufsize, nbufs;
-	u32 channel_flags;
-
-	channel_flags = RELAY_DELIVERY_PACKET | RELAY_USAGE_GLOBAL;
-	channel_flags |= RELAY_SCHEME_ANY | RELAY_TIMESTAMP_ANY;
-
-	bufsize = 1 << (CONFIG_KLOG_CHANNEL_SHIFT - 2);
-	nbufs = 4;
-
-	klog_channel = relay_open("klog",
-				  bufsize,
-				  nbufs,
-				  channel_flags,
-				  NULL,
-				  0,
-				  0,
-				  0,
-				  0,
-				  0,
-				  0,
-				  NULL,
-				  0);
-
-	if (klog_channel < 0)
-		printk("klog channel creation failed, errcode: %d\n", klog_channel);
-	else {
-		printk("klog channel created (%u bytes)\n", 1 << CONFIG_KLOG_CHANNEL_SHIFT);
-		relayfs_ctl_table_header = register_sysctl_table(relayfs_root_table, 1);
-	}
-
-	return klog_channel;
-}
-
-/**
- *	remove_klog_channel - destroys channel /mnt/relay/klog
- *
- *	Returns 0, negative otherwise.
- */
-int
-remove_klog_channel(void)
-{
-	if (relayfs_ctl_table_header)
-		unregister_sysctl_table(relayfs_ctl_table_header);
-
-	return relay_close(klog_channel);
-}
-
-EXPORT_SYMBOL(klog);
-EXPORT_SYMBOL(klog_raw);
-
diff -urpN -X dontdiff linux-2.6.11-rc1-mm1-vanilla/include/linux/klog.h linux-2.6.11-rc1-mm1-cur/include/linux/klog.h
--- linux-2.6.11-rc1-mm1-vanilla/include/linux/klog.h	Fri Jan 14 06:13:16 2005
+++ linux-2.6.11-rc1-mm1-cur/include/linux/klog.h	Wed Dec 31 18:00:00 1969
@@ -1,24 +0,0 @@
-/*
- * KLOG		Generic Logging facility built upon the relayfs infrastructure
- *
- * Authors:	Hubertus Frankeh  (frankeh@us.ibm.com)
- *		Tom Zanussi  (zanussi@us.ibm.com)
- *
- *		Please direct all questions/comments to zanussi@us.ibm.com
- *
- *		Copyright (C) 2003, IBM Corp
- *
- *
- *		This program is free software; you can redistribute it and/or
- *		modify it under the terms of the GNU General Public License
- *		as published by the Free Software Foundation; either version
- *		2 of the License, or (at your option) any later version.
- */
-
-#ifndef _LINUX_KLOG_H
-#define _LINUX_KLOG_H
-
-extern int klog(const char *fmt, ...);
-extern int klog_raw(const char *buf,int len);
-
-#endif	/* _LINUX_KLOG_H */

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

