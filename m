Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263149AbTJPTJe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 15:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263161AbTJPTJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 15:09:33 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:10148 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263149AbTJPTJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 15:09:05 -0400
Message-ID: <3F8EECC7.2040103@comcast.net>
Date: Thu, 16 Oct 2003 14:08:55 -0500
From: Tom Zanussi <zanussi@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Sanil K <Sanil.K@lntinfotech.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Interrupt handling
References: <OF7678B59D.AD894507-ON65256DC1.0048458F@lntinfotech.com>
Content-Type: multipart/mixed;
 boundary="------------080808070004050305070505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080808070004050305070505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sanil K wrote:
> Hi all,
> 
> This may be a generic problem as far as a driver is concerned.
> 
> We need to handle an interrupt and inform the user space on the event and
> pass the data correspodning to the event.
> 
> The event can be informed through SIGNAL and the signal handler can be
> invoked in the user space. Then again for data, we need to have the
> "copy_to_user" mechanism .
> 
> Is there any other effective mechanism(s) to handle the interrupt. I mean
> we need to convey the event and or data to the user space(prefer -
> asynchronously).
> 
> Please share your views.
> 

Hi.

You could use relayfs to do this; it was designed with this type of 
thing in mind - basically you use it to create a kernel buffer that you 
can write into from your module and then access the data using a file in 
the relayfs file system.  You can use read() or mmap() to access the 
data, depending on your needs.

If you just need to do this for debugging purposes, then the following 
patch to the relayfs version I posted on this list a couple of weeks ago 
might be of use, or you can use it as an example and do something 
similar in your own code.  Here's a link to the relayfs posting this 
patch needs to be applied to:

http://marc.theaimsgroup.com/?l=linux-kernel&m=106556134715271&w=2

Apply the attached patch on top of that, and then use klog() or 
klog_raw() to write to the buffer and from user space read() from 
/mnt/relay/klog, or similar depending on where you mounted relayfs.

If you expect to generate a lot of data, then it might be better to use 
mmap() to get at it.  For an example of this, you can look at the most 
recent version of the Linux Trace Toolkit I posted to the ltt and 
ltt-dev mailing lists around the same time.

Hope this helps,

Tom

Note:  this patch is based on a patch kindly contributed by Hubertus 
Franke, but I've added and changed things - in any case all 
responsibility for any problems with this code are mine alone.  Please 
send all comments/questions to me.  Thanks.


> Sanil.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



--------------080808070004050305070505
Content-Type: text/plain;
 name="klog1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="klog1.patch"

diff -urpN -X dontdiff linux-2.6.0-test6.prev/fs/Kconfig linux-2.6.0-test6.cur/fs/Kconfig
--- linux-2.6.0-test6.prev/fs/Kconfig	Thu Oct 16 11:13:53 2003
+++ linux-2.6.0-test6.cur/fs/Kconfig	Thu Oct 16 11:17:20 2003
@@ -899,8 +899,8 @@ config RELAYFS_FS
 	  an efficient mechanism for tools and facilities to relay large
 	  amounts of data from kernel space to user space.  It's not useful
 	  on its own, and should only be enabled if other facilities that
-	  need it are enabled, such as for example dynamic printk or the
-	  Linux Trace Toolkit.
+	  need it are enabled, such as for example klog or the Linux Trace
+	  Toolkit.
 
 	  See <file:Documentation/filesystems/relayfs.txt> for further
 	  information.
@@ -911,6 +911,36 @@ config RELAYFS_FS
 	  module, say M here and read <file:Documentation/modules.txt>.
 
 	  If unsure, say N.
+
+config KLOG_CHANNEL
+	bool "Enable klog debugging support"
+	depends on RELAYFS_FS
+	help
+	  If you say Y to this, a relayfs channel named klog will be created
+	  in the root of the relayfs file system.  You can write to the klog
+	  channel using klog() or klog_raw() from within the kernel or
+	  kernel modules, and read from the klog channel by mounting relayfs
+	  and using read(2) to read from it (or using cat).  If you're not  
+	  sure, say N.
+
+config KLOG_CHANNEL_AUTOENABLE
+	bool "Enable klog logging on startup"
+	depends on KLOG_CHANNEL
+	default y
+	help
+	  If you say Y to this, the klog channel will be automatically enabled
+	  on startup.  Otherwise, to turn klog logging on, you need use
+	  sysctl (kernel.klog_enabled).  This option is used in cases where
+	  you don't actually want the channel to be written to until it's
+	  enabled.  If you're not sure, say Y.
+
+config KLOG_CHANNEL_SHIFT
+	depends on KLOG_CHANNEL
+	int "klog debugging channel size (16 => 64KB, 22 => 4MB)"
+	range 16 22
+	default 21
+	help
+	  Select klog debugging channel size as a power of 2.
 
 endmenu
 
diff -urpN -X dontdiff linux-2.6.0-test6.prev/fs/relayfs/Makefile linux-2.6.0-test6.cur/fs/relayfs/Makefile
--- linux-2.6.0-test6.prev/fs/relayfs/Makefile	Thu Oct 16 11:13:53 2003
+++ linux-2.6.0-test6.cur/fs/relayfs/Makefile	Thu Oct 16 11:17:20 2003
@@ -3,5 +3,6 @@
 #
 
 obj-$(CONFIG_RELAYFS_FS) += relayfs.o
+obj-$(CONFIG_KLOG_CHANNEL) += klog.o
 
 relayfs-objs := relay.o relay_lockless.o relay_locking.o inode.o
diff -urpN -X dontdiff linux-2.6.0-test6.prev/fs/relayfs/inode.c linux-2.6.0-test6.cur/fs/relayfs/inode.c
--- linux-2.6.0-test6.prev/fs/relayfs/inode.c	Thu Oct 16 11:13:53 2003
+++ linux-2.6.0-test6.cur/fs/relayfs/inode.c	Thu Oct 16 11:17:20 2003
@@ -551,10 +551,17 @@ static struct file_system_type relayfs_f
 	.kill_sb	= kill_litter_super,
 };
 
+extern int create_klog_channel(void);
+
 static int __init 
 init_relayfs_fs(void)
 {
-	return register_filesystem(&relayfs_fs_type);
+	int err = register_filesystem(&relayfs_fs_type);
+#ifdef CONFIG_KLOG_CHANNEL
+	if (!err)
+		create_klog_channel();
+#endif
+	return err;
 }
 
 static void __exit 
diff -urpN -X dontdiff linux-2.6.0-test6.prev/fs/relayfs/klog.c linux-2.6.0-test6.cur/fs/relayfs/klog.c
--- linux-2.6.0-test6.prev/fs/relayfs/klog.c	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test6.cur/fs/relayfs/klog.c	Thu Oct 16 11:52:47 2003
@@ -0,0 +1,116 @@
+/*
+ * KLOG		Generic Logging facility built upon the relayfs infrastructure
+ *
+ * Authors:	Hubertus Franke  (frankeh@us.ibm.com)
+ *		Tom Zanussi  (zanussi@us.ibm.com)
+ *
+ *		Please direct all questions/comments to zanussi@us.ibm.com
+ *
+ *		Copyright (C) 2003, IBM Corp
+ *
+ *		This program is free software; you can redistribute it and/or
+ *		modify it under the terms of the GNU General Public License
+ *		as published by the Free Software Foundation; either version
+ *		2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/smp_lock.h>
+#include <linux/console.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/delay.h>
+#include <linux/smp.h>
+#include <linux/relayfs_fs.h>
+#include <linux/klog.h>
+
+#ifdef KLOG_CHANNEL_AUTOENABLE
+int klog_enabled = 1;
+#else
+int klog_enabled = 0;
+#endif
+EXPORT_SYMBOL(klog_enabled);
+
+int klog_channel = -1;
+
+static char buf[NR_CPUS][KLOG_BUF_SIZE];
+
+/**
+ *	klog - write a formatted string into the klog channel
+ *	@fmt: format string
+ *
+ *	Returns number of bytes written, negative number on failure.
+ */
+int klog(const char *fmt, ...)
+{
+	va_list args;
+	int len, err;
+	char *cbuf;
+	unsigned long flags;
+	
+	if (!klog_enabled || klog_channel < 0) 
+		return 0;
+
+	local_irq_save(flags);
+	cbuf = buf[smp_processor_id()];
+
+	va_start(args, fmt);
+	len = vsnprintf(cbuf, KLOG_BUF_SIZE, fmt, args);
+	va_end(args);
+	
+	err = relay_write(klog_channel, cbuf, len, -1);
+	local_irq_restore(flags);
+
+	return err;
+}
+
+/**
+ *	klog_raw - directly write into the klog channel
+ *	@buf: buffer containing data to write
+ *	@len: # bytes to write
+ *
+ *	Returns number of bytes written, negative number on failure.
+ */
+int klog_raw(const char *buf,int len)
+{
+	int err = 0;
+	
+	if (klog_enabled && klog_channel >= 0)
+		err = relay_write(klog_channel, buf, len, -1);
+
+	return err;
+}
+
+/* internal - creates channel file /mnt/relay/klog */
+int create_klog_channel(void)
+{
+	u32 bufsize, nbufs;
+
+	u32 channel_flags = RELAY_DELIVERY_PACKET | RELAY_USAGE_GLOBAL;
+	channel_flags |= RELAY_SCHEME_ANY | RELAY_TIMESTAMP_ANY;
+	
+	bufsize = 1 << (CONFIG_KLOG_CHANNEL_SHIFT - 2); /* size of sub-buffers */
+	nbufs = 4;
+
+	klog_channel = relay_open("klog",
+				  bufsize,
+				  nbufs,
+				  channel_flags,
+				  NULL,
+				  0,
+				  0,
+				  0,
+				  0,
+				  0);
+
+	if (klog_channel < 0)
+		printk("klog channel creation failed, errcode: %d\n", klog_channel);
+	else
+		printk("klog channel created (%u bytes)\n", 1 << CONFIG_KLOG_CHANNEL_SHIFT);
+
+	return klog_channel;
+}
+
+EXPORT_SYMBOL(klog);
+EXPORT_SYMBOL(klog_raw);
diff -urpN -X dontdiff linux-2.6.0-test6.prev/include/linux/klog.h linux-2.6.0-test6.cur/include/linux/klog.h
--- linux-2.6.0-test6.prev/include/linux/klog.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test6.cur/include/linux/klog.h	Thu Oct 16 11:41:01 2003
@@ -0,0 +1,29 @@
+/*
+ * KLOG		Generic Logging facility built upon the relayfs infrastructure
+ *
+ * Authors:	Hubertus Frankeh  (frankeh@us.ibm.com)
+ *		Tom Zanussi  (zanussi@us.ibm.com)
+ *
+ *		Please direct all questions/comments to zanussi@us.ibm.com
+ *
+ *		Copyright (C) 2003, IBM Corp
+ *
+ *
+ *		This program is free software; you can redistribute it and/or
+ *		modify it under the terms of the GNU General Public License
+ *		as published by the Free Software Foundation; either version
+ *		2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _LINUX_KLOG_H
+#define _LINUX_KLOG_H
+
+extern int klog_channel;
+
+#define KLOG_BUF_SIZE (512)     /* maximum size of formatting buffer for klog
+				 * beyond which truncation will take place */
+
+int klog(const char *fmt, ...);
+int klog_raw(const char *buf,int len); 
+
+#endif	/* _LINUX_KLOG_H */
diff -urpN -X dontdiff linux-2.6.0-test6.prev/kernel/sysctl.c linux-2.6.0-test6.cur/kernel/sysctl.c
--- linux-2.6.0-test6.prev/kernel/sysctl.c	Sat Sep 27 19:50:09 2003
+++ linux-2.6.0-test6.cur/kernel/sysctl.c	Thu Oct 16 11:17:20 2003
@@ -93,6 +93,7 @@ extern int pwrsw_enabled;
 extern int unaligned_enabled;
 #endif
 
+extern int klog_enabled;
 #ifdef CONFIG_ARCH_S390
 #ifdef CONFIG_MATHEMU
 extern int sysctl_ieee_emulation_warnings;
@@ -577,6 +578,14 @@ static ctl_table kern_table[] = {
 		.ctl_name	= KERN_PANIC_ON_OOPS,
 		.procname	= "panic_on_oops",
 		.data		= &panic_on_oops,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= 100, // just make up a number
+		.procname	= "klog_enabled",
+		.data		= &klog_enabled,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,

--------------080808070004050305070505--

