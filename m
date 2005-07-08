Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262826AbVGHVxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262826AbVGHVxl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 17:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbVGHVvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 17:51:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53171 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262580AbVGHVtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 17:49:06 -0400
Date: Fri, 8 Jul 2005 14:50:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: nboyle@tampabay.rr.com
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [BUG] Oops: EIP is at sysfs_release+0x34/0x80
Message-Id: <20050708145001.34b9f8f2.akpm@osdl.org>
In-Reply-To: <42CEB851.1000004@tampabay.rr.com>
References: <42CEB851.1000004@tampabay.rr.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Boyle <nboyle@tampabay.rr.com> wrote:
>
> EIP is at sysfs_release+0x34/0x80
> eax: 00000001   ebx: dc7c2000   ecx: d1979860   edx: 00000001
> esi: 762f7373   edi: d5ba26a0   ebp: d9368544   esp: dc7c3f80
> ds: 007b   es: 007b   ss: 0068
> Process udev (pid: 31802, threadinfo=dc7c2000 task=c7c19040)
> Stack: df468c40 df798140 dffe4140 c0153c08 d5a9edbc df468c40 df798140
> 00000000
>         dc7c2000 c01523d3 00000000 00000003 080ac568 00000003 c0103101
> 00000003
>         080ac568 00000004 080ac568 00000003 08057198 00000006 0000007b
> 0000007b
> Call Trace:
>   [<c0153c08>] __fput+0xf8/0x110
>   [<c01523d3>] filp_close+0x43/0x70
>   [<c0103101>] syscall_call+0x7/0xb
> Code: 8b 41 0c 8b 40 48 8b 58 14 8b 41 48 8b 40 14 85 db 8b 70 04 74 07
> 89 d8 e8 9a 11 02 00 85 f6 74 1f bb 00 e0 ff ff 21 e3 ff 43 14 <ff> 8e
> 00 01 00 00 83 3e 02 74 32 8b 43 08 ff 4b 14 a8 08 75 21
>   <6>note: udev[31802] exited with preempt_count 1

Gee we get a lot of these, and no idea which sysfs file caused it.

How about we record the most-recently-opened sysfs file and display that at
oops time?  (-mm only)

--- 25/fs/sysfs/file.c~sysfs-crash-debugging	Fri Jul  8 14:33:11 2005
+++ 25-akpm/fs/sysfs/file.c	Fri Jul  8 14:47:38 2005
@@ -6,6 +6,8 @@
 #include <linux/dnotify.h>
 #include <linux/kobject.h>
 #include <linux/namei.h>
+#include <linux/limits.h>
+
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 
@@ -324,8 +326,13 @@ static int check_perm(struct inode * ino
 	return error;
 }
 
+char last_sysfs_file[PATH_MAX];
+
 static int sysfs_open_file(struct inode * inode, struct file * filp)
 {
+	d_path(filp->f_dentry, sysfs_mount, last_sysfs_file,
+			sizeof(last_sysfs_file));
+
 	return check_perm(inode,filp);
 }
 
diff -puN arch/i386/kernel/traps.c~sysfs-crash-debugging arch/i386/kernel/traps.c
--- 25/arch/i386/kernel/traps.c~sysfs-crash-debugging	Fri Jul  8 14:36:15 2005
+++ 25-akpm/arch/i386/kernel/traps.c	Fri Jul  8 14:37:01 2005
@@ -337,6 +337,12 @@ void die(const char * str, struct pt_reg
 #endif
 		if (nl)
 			printk("\n");
+		{
+			extern char last_sysfs_name[];
+
+			printk(KERN_ALERT "last sysfs file: %s\n",
+					last_sysfs_name);
+		}
 	notify_die(DIE_OOPS, (char *)str, regs, err, 255, SIGSEGV);
 		show_registers(regs);
   	} else
_

