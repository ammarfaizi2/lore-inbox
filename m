Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267870AbRGWM7d>; Mon, 23 Jul 2001 08:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268214AbRGWM7Y>; Mon, 23 Jul 2001 08:59:24 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:45147 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S267870AbRGWM7K>;
	Mon, 23 Jul 2001 08:59:10 -0400
Date: Mon, 23 Jul 2001 13:59:43 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [new merged patch] Re: [patch] rootfstype= and rootcd= boot options.
In-Reply-To: <3B5B8A2E.CFD6F118@uow.edu.au>
Message-ID: <Pine.LNX.4.21.0107231353020.1118-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 23 Jul 2001, Andrew Morton wrote:
> ext3 also need to ability to pass mount options to the
> root fs.  Any chance of munging these two things together?

Linus,

here is the patch with Andrew's suggested stuff added.

Regards,
Tigran

diff -urN -X dontdiff linux/Documentation/kernel-parameters.txt linux-b/Documentation/kernel-parameters.txt
--- linux/Documentation/kernel-parameters.txt	Wed Jun 20 19:21:33 2001
+++ linux-b/Documentation/kernel-parameters.txt	Mon Jul 23 13:54:07 2001
@@ -504,8 +504,15 @@
 
 	ro		[KNL] Mount root device read-only on boot.
 
-	root=		[KNL] root filesystem.
 
+	root=		[KNL] Where to mount root filesystem.
+
+	rootfstype=	[KNL] Only mount root filesystem of this type.
+
+	rootflags=	[KNL] Mount options for root filesystem
+
+	rootcd=		[KNL] Mount root on the first CD-ROM if != 0
+ 
 	rw		[KNL] Mount root device read-write on boot.
 
 	S		[KNL] run init in single mode.
diff -urN -X dontdiff linux/drivers/cdrom/cdrom.c linux-b/drivers/cdrom/cdrom.c
--- linux/drivers/cdrom/cdrom.c	Wed Jul 11 22:55:41 2001
+++ linux-b/drivers/cdrom/cdrom.c	Mon Jul 23 13:50:34 2001
@@ -2494,6 +2494,11 @@
         return proc_dostring(ctl, write, filp, buffer, lenp);
 }
 
+kdev_t get_cdrom_dev(void)
+{
+	return topCdromPtr ? topCdromPtr->dev : 0;
+}
+
 /* Unfortunately, per device settings are not implemented through
    procfs/sysctl yet. When they are, this will naturally disappear. For now
    just update all drives. Later this will become the template on which
diff -urN -X dontdiff linux/fs/super.c linux-b/fs/super.c
--- linux/fs/super.c	Thu Jun 14 22:16:58 2001
+++ linux-b/fs/super.c	Mon Jul 23 13:52:47 2001
@@ -18,6 +18,7 @@
  *    Torbjörn Lindh (torbjorn.lindh@gopta.se), April 14, 1996.
  *  Added devfs support: Richard Gooch <rgooch@atnf.csiro.au>, 13-JAN-1998
  *  Heavily rewritten for 'one fs - one tree' dcache architecture. AV, Mar 2000
+ *  Added rootfstype boot param. used by mount_root(): Tigran Aivazian. July 2001.
  */
 
 #include <linux/config.h>
@@ -59,6 +60,12 @@
 /* this is initialized in init/main.c */
 kdev_t ROOT_DEV;
 
+/* this can be set at boot time, e.g. rootfstype=umsdos
+ * if set to invalid value or if read_super() fails on the specified
+ * filesystem type then mount_root() will panic
+ */
+static char rootfstype[32] __initdata = "";
+
 int nr_super_blocks;
 int max_super_blocks = NR_SUPER;
 LIST_HEAD(super_blocks);
@@ -79,6 +86,18 @@
 static struct file_system_type *file_systems;
 static rwlock_t file_systems_lock = RW_LOCK_UNLOCKED;
 
+static int __init rootfstype_setup(char *line)
+{
+	int n = strlen(line) + 1;
+
+	if (n > 1 && n <= sizeof(rootfstype))
+		strncpy(rootfstype, line, n);
+	return 1;
+}
+
+__setup("rootfstype=", rootfstype_setup);
+
+
 /* WARNING: This can be used only if we _already_ own a reference */
 static void get_filesystem(struct file_system_type *fs)
 {
@@ -1467,6 +1486,18 @@
 	return retval;
 }
 
+static char *root_mount_data;
+
+static int __init root_data_setup(char *line)
+{
+	static char buffer[128];
+
+	strcpy(buffer, line);
+	root_mount_data = buffer;
+	return 1;
+}
+__setup("rootflags=", root_data_setup);
+
 void __init mount_root(void)
 {
 	struct file_system_type * fs_type;
@@ -1587,6 +1618,18 @@
 		goto mount_it;
 	}
 
+	if (*rootfstype) {
+		fs_type = get_fs_type(rootfstype);
+		if (fs_type) {
+  			sb = read_super(ROOT_DEV,bdev,fs_type,root_mountflags,
+				root_mount_data,1);
+			if (sb)
+				goto mount_it;
+		} 
+		/* don't try others if type given explicitly, same behaviour as mount(8) */
+		goto fail;
+	}
+
 	read_lock(&file_systems_lock);
 	for (fs_type = file_systems ; fs_type ; fs_type = fs_type->next) {
   		if (!(fs_type->fs_flags & FS_REQUIRES_DEV))
@@ -1594,14 +1637,17 @@
 		if (!try_inc_mod_count(fs_type->owner))
 			continue;
 		read_unlock(&file_systems_lock);
-  		sb = read_super(ROOT_DEV,bdev,fs_type,root_mountflags,NULL,1);
+  		sb = read_super(ROOT_DEV,bdev,fs_type,root_mountflags,
+				root_mount_data,1);
 		if (sb) 
 			goto mount_it;
 		read_lock(&file_systems_lock);
 		put_filesystem(fs_type);
 	}
 	read_unlock(&file_systems_lock);
-	panic("VFS: Unable to mount root fs on %s", kdevname(ROOT_DEV));
+fail:
+	panic("VFS: Unable to mount root %s on %s", 
+		*rootfstype ? rootfstype : "fs", kdevname(ROOT_DEV));
 
 mount_it:
 	printk ("VFS: Mounted root (%s filesystem)%s.\n",
diff -urN -X dontdiff linux/init/main.c linux-b/init/main.c
--- linux/init/main.c	Thu Jul  5 19:31:58 2001
+++ linux-b/init/main.c	Mon Jul 23 13:50:34 2001
@@ -304,6 +304,16 @@
 
 __setup("root=", root_dev_setup);
 
+static int rootcd_enable __initdata = 0;
+
+static int __init rootcd_setup(char *str)
+{
+	get_option(&str, &rootcd_enable);
+	return 1;
+}
+
+__setup("rootcd=", rootcd_setup);
+
 static int __init checksetup(char *line)
 {
 	struct kernel_param *p;
@@ -745,6 +755,11 @@
 #endif
 	rd_load();
 #endif
+
+	if (rootcd_enable) {
+		extern kdev_t get_cdrom_dev(void);
+		ROOT_DEV = get_cdrom_dev();
+	}
 
 	/* Mount the root filesystem.. */
 	mount_root();

