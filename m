Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbVG3Ja7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbVG3Ja7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 05:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263026AbVG3Ja7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 05:30:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65499 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263024AbVG3Ja6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 05:30:58 -0400
Date: Sat, 30 Jul 2005 02:29:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Keith Owens <kaos@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4 use after free in class_device_attr_show
Message-Id: <20050730022955.6c7dd2e8.akpm@osdl.org>
In-Reply-To: <18189.1122702459@ocs3.ocs.com.au>
References: <18189.1122702459@ocs3.ocs.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@sgi.com> wrote:
>
> 2.6.13-rc4 + kdb, with lots of CONFIG_DEBUG options.  There is an
>  intermittent use after free in class_device_attr_show.  Reboot with no
>  changes and the problem does not always recur.
> ...
>  ip is at class_device_attr_show+0x50/0xa0
> ...
> 
>  Call Trace:
>   [<a000000100011f80>] show_stack+0x80/0xa0
>                                  sp=e000003076ce79c0 bsp=e000003076ce10d8
>   [<a0000001000127f0>] show_regs+0x850/0x880
>                                  sp=e000003076ce7b90 bsp=e000003076ce1078
>   [<a00000010003c000>] die+0x280/0x4a0
>                                  sp=e000003076ce7ba0 bsp=e000003076ce1028
>   [<a000000100060ad0>] ia64_do_page_fault+0x650/0xba0
>                                  sp=e000003076ce7ba0 bsp=e000003076ce0fb8
>   [<a00000010000b6c0>] ia64_leave_kernel+0x0/0x290
>                                  sp=e000003076ce7c50 bsp=e000003076ce0fb8
>   [<a0000001005807b0>] class_device_attr_show+0x50/0xa0
>                                  sp=e000003076ce7e20 bsp=e000003076ce0f78
>   [<a00000010025def0>] sysfs_read_file+0x2b0/0x360
>                                  sp=e000003076ce7e20 bsp=e000003076ce0f08
>   [<a000000100198a40>] vfs_read+0x1c0/0x360
>                                  sp=e000003076ce7e20 bsp=e000003076ce0eb0
>   [<a000000100198d80>] sys_read+0x80/0xe0
>                                  sp=e000003076ce7e20 bsp=e000003076ce0e38
>   [<a00000010000b520>] ia64_ret_from_syscall+0x0/0x20
>                                  sp=e000003076ce7e30 bsp=e000003076ce0e38

It might help to know which file is being read from here.

The below patch will record the name of the most-recently-opened sysfs
file.  You can print last_sysfs_file[] in the debugger or add the
appropriate printk to the ia64 code?

--- devel/fs/sysfs/file.c~sysfs-crash-debugging	2005-07-30 01:32:10.000000000 -0700
+++ devel-akpm/fs/sysfs/file.c	2005-07-30 02:09:01.000000000 -0700
@@ -6,6 +6,8 @@
 #include <linux/fsnotify.h>
 #include <linux/kobject.h>
 #include <linux/namei.h>
+#include <linux/limits.h>
+
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 
@@ -324,8 +326,14 @@ static int check_perm(struct inode * ino
 	return error;
 }
 
+char last_sysfs_file[PATH_MAX];
+
 static int sysfs_open_file(struct inode * inode, struct file * filp)
 {
+	char *p = d_path(filp->f_dentry, sysfs_mount, last_sysfs_file,
+			sizeof(last_sysfs_file));
+	if (p)
+		memmove(last_sysfs_file, p, strlen(p));
 	return check_perm(inode,filp);
 }
 
diff -puN arch/i386/kernel/traps.c~sysfs-crash-debugging arch/i386/kernel/traps.c
--- devel/arch/i386/kernel/traps.c~sysfs-crash-debugging	2005-07-30 01:32:10.000000000 -0700
+++ devel-akpm/arch/i386/kernel/traps.c	2005-07-30 01:32:10.000000000 -0700
@@ -96,6 +96,8 @@ static int kstack_depth_to_print = 24;
 struct notifier_block *i386die_chain;
 static DEFINE_SPINLOCK(die_notifier_lock);
 
+extern char last_sysfs_file[];
+
 int register_die_notifier(struct notifier_block *nb)
 {
 	int err = 0;
@@ -370,6 +372,7 @@ void die(const char * str, struct pt_reg
 #endif
 		if (nl)
 			printk("\n");
+		printk(KERN_ALERT "last sysfs file: %s\n", last_sysfs_file);
 #ifdef CONFIG_KGDB
 	/* This is about the only place we want to go to kgdb even if in
 	 * user mode.  But we must go in via a trap so within kgdb we will
_

