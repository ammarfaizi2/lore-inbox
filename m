Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268315AbUJJP3C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268315AbUJJP3C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 11:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268316AbUJJP3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 11:29:02 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:3727 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S268315AbUJJP23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 11:28:29 -0400
Message-ID: <4169551D.A884778D@tv-sign.ru>
Date: Sun, 10 Oct 2004 19:28:29 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Matt Mackall <mpm@selenic.com>
Subject: [RFC] __initdata strings
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

This patch is not intended for inclusion, just for illustration.

__init functions leaves strings (mainly printk's arguments) in
.data section. It make sense to move them in .init.data.

Is there anyone else who would consider this useful?

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

diff -rup 2.6.9-rc3-clean/include/linux/init.h 2.6.9-rc3-i_str/include/linux/init.h
--- 2.6.9-rc3-clean/include/linux/init.h	Sun Oct 10 11:48:46 2004
+++ 2.6.9-rc3-i_str/include/linux/init.h	Sun Oct 10 11:55:07 2004
@@ -61,6 +61,31 @@
 /*
  * Used for initialization calls..
  */
+
+#define I_STRING(str)	\
+({						\
+	static char data[] __initdata = (str);	\
+	data;					\
+})
+
+#if	defined(__GNUC__) && (__GNUC__ >= 3)
+#define CK_FMTSTR(expr)	do if (0) { expr; } while (0)
+#else
+#define CK_FMTSTR(expr)	do ; while (0)
+#endif
+
+#define i_printk(fmt, args...)	\
+({						\
+	CK_FMTSTR(printk(fmt , ##args));	\
+	printk(I_STRING(fmt) , ##args);		\
+})
+
+#define i_panic(fmt, args...)	\
+({						\
+	CK_FMTSTR(panic(fmt , ##args));		\
+	panic(I_STRING(fmt) , ##args);		\
+})
+
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
diff -rup 2.6.9-rc3-clean/init/do_mounts.c 2.6.9-rc3-i_str/init/do_mounts.c
--- 2.6.9-rc3-clean/init/do_mounts.c	Sun Oct 10 11:48:57 2004
+++ 2.6.9-rc3-i_str/init/do_mounts.c	Sat Oct  9 18:18:30 2004
@@ -265,10 +265,10 @@ static int __init do_mount_root(char *na
 
 	sys_chdir("/root");
 	ROOT_DEV = current->fs->pwdmnt->mnt_sb->s_dev;
-	printk("VFS: Mounted root (%s filesystem)%s.\n",
+	i_printk("VFS: Mounted root (%s filesystem)%s.\n",
 	       current->fs->pwdmnt->mnt_sb->s_type->name,
 	       current->fs->pwdmnt->mnt_sb->s_flags & MS_RDONLY ? 
-	       " readonly" : "");
+	       I_STRING(" readonly") : "");
 	return 0;
 }
 
@@ -296,13 +296,13 @@ retry:
 		 * and bad superblock on root device.
 		 */
 		__bdevname(ROOT_DEV, b);
-		printk("VFS: Cannot open root device \"%s\" or %s\n",
+		i_printk("VFS: Cannot open root device \"%s\" or %s\n",
 				root_device_name, b);
-		printk("Please append a correct \"root=\" boot option\n");
+		i_printk("Please append a correct \"root=\" boot option\n");
 
-		panic("VFS: Unable to mount root fs on %s", b);
+		i_panic("VFS: Unable to mount root fs on %s", b);
 	}
-	panic("VFS: Unable to mount root fs on %s", __bdevname(ROOT_DEV, b));
+	i_panic("VFS: Unable to mount root fs on %s", __bdevname(ROOT_DEV, b));
 out:
 	putname(fs_names);
 }
@@ -336,7 +336,7 @@ void __init change_floppy(char *fmt, ...
 		sys_ioctl(fd, FDEJECT, 0);
 		sys_close(fd);
 	}
-	printk(KERN_NOTICE "VFS: Insert %s and press ENTER\n", buf);
+	i_printk(KERN_NOTICE "VFS: Insert %s and press ENTER\n", buf);
 	fd = sys_open("/dev/console", O_RDWR, 0);
 	if (fd >= 0) {
 		sys_ioctl(fd, TCGETS, (long)&termios);
@@ -357,7 +357,7 @@ void __init mount_root(void)
 		if (mount_nfs_root())
 			return;
 
-		printk(KERN_ERR "VFS: Unable to mount root fs via NFS, trying floppy.\n");
+		i_printk(KERN_ERR "VFS: Unable to mount root fs via NFS, trying floppy.\n");
 		ROOT_DEV = Root_FD0;
 	}
 #endif
