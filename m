Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947114AbWKKGna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947114AbWKKGna (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 01:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947115AbWKKGna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 01:43:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:36581 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1947114AbWKKGn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 01:43:29 -0500
X-Authenticated: #14349625
Subject: [patch] [trivial] Re: 2.6.19-rc5 breaks klogd 1.4.1
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: John Wendel <jwendel10@comcast.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1163085926.6087.17.camel@Homer.simpson.net>
References: <4552BB55.9090400@comcast.net>
	 <20061108224153.4ed2e581.akpm@osdl.org> <4552D4B4.5020505@comcast.net>
	 <20061108233517.7cc1db12.akpm@osdl.org>
	 <1163067064.6145.4.camel@Homer.simpson.net>
	 <1163085926.6087.17.camel@Homer.simpson.net>
Content-Type: text/plain
Date: Sat, 11 Nov 2006 07:44:20 +0100
Message-Id: <1163227460.6226.26.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-09 at 16:25 +0100, Mike Galbraith wrote:

> The correct answer seems to be "fix klogd, or don't disable printk".

I don't like that answer one bit.  I think it's much better to remove
the syslog interface when printk is disabled rather than leave it in
place for userland to trip over.

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.19-rc5/fs/proc/Makefile.org	2006-11-09 13:08:17.000000000 +0100
+++ linux-2.6.19-rc5/fs/proc/Makefile	2006-11-09 13:09:06.000000000 +0100
@@ -8,8 +8,9 @@ proc-y			:= nommu.o task_nommu.o
 proc-$(CONFIG_MMU)	:= mmu.o task_mmu.o
 
 proc-y       += inode.o root.o base.o generic.o array.o \
-		kmsg.o proc_tty.o proc_misc.o
+		proc_tty.o proc_misc.o
 
 proc-$(CONFIG_PROC_KCORE)	+= kcore.o
 proc-$(CONFIG_PROC_VMCORE)	+= vmcore.o
 proc-$(CONFIG_PROC_DEVICETREE)	+= proc_devtree.o
+proc-$(CONFIG_PRINTK)	+= kmsg.o
--- linux-2.6.19-rc5/fs/proc/proc_misc.c.org	2006-11-09 13:04:50.000000000 +0100
+++ linux-2.6.19-rc5/fs/proc/proc_misc.c	2006-11-09 13:06:29.000000000 +0100
@@ -696,9 +696,11 @@ void __init proc_misc_init(void)
 	proc_symlink("mounts", NULL, "self/mounts");
 
 	/* And now for trickier ones */
+#ifdef CONFIG_PRINTK
 	entry = create_proc_entry("kmsg", S_IRUSR, &proc_root);
 	if (entry)
 		entry->proc_fops = &proc_kmsg_operations;
+#endif
 	create_seq_entry("devices", 0, &proc_devinfo_operations);
 	create_seq_entry("cpuinfo", 0, &proc_cpuinfo_operations);
 #ifdef CONFIG_BLOCK
--- linux-2.6.19-rc5/kernel/printk.c.org	2006-11-08 07:44:27.000000000 +0100
+++ linux-2.6.19-rc5/kernel/printk.c	2006-11-11 06:44:59.000000000 +0100
@@ -631,12 +631,7 @@ EXPORT_SYMBOL(vprintk);
 
 asmlinkage long sys_syslog(int type, char __user *buf, int len)
 {
-	return 0;
-}
-
-int do_syslog(int type, char __user *buf, int len)
-{
-	return 0;
+	return -ENOSYS;
 }
 
 static void call_console_drivers(unsigned long start, unsigned long end)


