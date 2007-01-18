Return-Path: <linux-kernel-owner+w=401wt.eu-S932158AbXARLBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbXARLBH (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 06:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbXARLBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 06:01:00 -0500
Received: from smtp-out.google.com ([216.239.45.13]:15673 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbXARLA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 06:00:59 -0500
X-Greylist: delayed 607 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jan 2007 06:00:59 EST
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:to:subject:message-id:from:date;
	b=fFJ92RIEWZpJajn3fDjmo3CxviXlIIc+7YjjXAV9sFAyVMzetSHRDvjSgA56WTk/M
	zt0boN7pzq3NT79jj4Suw==
To: linux-kernel@vger.kernel.org
Subject: Re: kernel cmdline: root=/dev/sdb1,/dev/sda1 "fallback"?
Message-Id: <E1H7Uqx-0003X0-0u@llonio.corp.google.com>
From: Al Borchers <alb@google.com>
Date: Thu, 18 Jan 2007 02:50:43 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Thomas Chmielewski wrote:
> These all unpleasant tasks could be avoided if it was possible to have a 
> "fallback" device. For example, consider this hypothetical command line:
> 
> root=/dev/sdb1,/dev/sda1

Here is a patch to do this, though it sounds like you might have other
solutions.

This patch is for 2.6.18.1--thanks to Ed Falk for updating my original
2.6.11 patch.  If people are interested I can update and test this on
the current kernel.  It was tested on 2.6.11.

Please CC me with any comments.

-- Al


diff -uprN linux-2.6.18.1/init/do_mounts.c comma_root/init/do_mounts.c
--- linux-2.6.18.1/init/do_mounts.c	2006-10-13 20:34:03.000000000 -0700
+++ comma_root/init/do_mounts.c	2006-11-17 16:22:14.000000000 -0800
@@ -280,8 +280,9 @@ static int __init do_mount_root(char *na
 	return 0;
 }
 
-void __init mount_block_root(char *name, int flags)
+static int __init mount_block_root_try(char *name, int flags)
 {
+	int err;
 	char *fs_names = __getname();
 	char *p;
 	char b[BDEVNAME_SIZE];
@@ -289,7 +290,7 @@ void __init mount_block_root(char *name,
 	get_fs_names(fs_names);
 retry:
 	for (p = fs_names; *p; p += strlen(p)+1) {
-		int err = do_mount_root(name, p, flags, root_mount_data);
+		err = do_mount_root(name, p, flags, root_mount_data);
 		switch (err) {
 			case 0:
 				goto out;
@@ -307,19 +308,33 @@ retry:
 		printk("VFS: Cannot open root device \"%s\" or %s\n",
 				root_device_name, b);
 		printk("Please append a correct \"root=\" boot option\n");
-
-		panic("VFS: Unable to mount root fs on %s", b);
 	}
 
 	printk("No filesystem could mount root, tried: ");
 	for (p = fs_names; *p; p += strlen(p)+1)
 		printk(" %s", p);
 	printk("\n");
-	panic("VFS: Unable to mount root fs on %s", __bdevname(ROOT_DEV, b));
+
+	err = -1;
 out:
 	putname(fs_names);
+	return err;
 }
- 
+
+static inline void __init mount_block_root_fail(void)
+{
+	char b[BDEVNAME_SIZE];
+
+	panic("VFS: Unable to mount root fs on %s", __bdevname(ROOT_DEV, b));
+}
+
+void __init mount_block_root(char *name, int flags)
+{
+	if (mount_block_root_try(name, flags) != 0)
+		mount_block_root_fail();
+}
+
+
 #ifdef CONFIG_ROOT_NFS
 static int __init mount_nfs_root(void)
 {
@@ -363,12 +378,12 @@ void __init change_floppy(char *fmt, ...
 }
 #endif
 
-void __init mount_root(void)
+static int __init mount_root_try(void)
 {
 #ifdef CONFIG_ROOT_NFS
 	if (MAJOR(ROOT_DEV) == UNNAMED_MAJOR) {
 		if (mount_nfs_root())
-			return;
+			return 0;
 
 		printk(KERN_ERR "VFS: Unable to mount root fs via NFS, trying floppy.\n");
 		ROOT_DEV = Root_FD0;
@@ -387,7 +402,18 @@ void __init mount_root(void)
 	}
 #endif
 	create_dev("/dev/root", ROOT_DEV);
-	mount_block_root("/dev/root", root_mountflags);
+	return mount_block_root_try("/dev/root", root_mountflags);
+}
+
+static inline void __init mount_root_fail(void)
+{
+	mount_block_root_fail();
+}
+
+void __init mount_root(void)
+{
+	if (mount_root_try() != 0)
+		mount_root_fail();
 }
 
 /*
@@ -396,6 +422,7 @@ void __init mount_root(void)
 void __init prepare_namespace(void)
 {
 	int is_floppy;
+	char *p,*pnext;
 
 	if (root_delay) {
 		printk(KERN_INFO "Waiting %dsec before mounting root device...\n",
@@ -405,27 +432,36 @@ void __init prepare_namespace(void)
 
 	md_run_setup();
 
-	if (saved_root_name[0]) {
-		root_device_name = saved_root_name;
+	for (p=saved_root_name; p && *p; p=pnext) {
+		pnext = strchr(p, ',');
+		if (pnext)
+			*pnext++ = '\0';
+		root_device_name = p;
 		if (!strncmp(root_device_name, "mtd", 3)) {
 			mount_block_root(root_device_name, root_mountflags);
 			goto out;
 		}
 		ROOT_DEV = name_to_dev_t(root_device_name);
+		if (ROOT_DEV == (dev_t)0)
+			continue;
 		if (strncmp(root_device_name, "/dev/", 5) == 0)
 			root_device_name += 5;
-	}
 
-	is_floppy = MAJOR(ROOT_DEV) == FLOPPY_MAJOR;
+		is_floppy = MAJOR(ROOT_DEV) == FLOPPY_MAJOR;
 
-	if (initrd_load())
-		goto out;
+		if (initrd_load())
+			goto out;
 
-	if (is_floppy && rd_doload && rd_load_disk(0))
-		ROOT_DEV = Root_RAM0;
+		if (is_floppy && rd_doload && rd_load_disk(0))
+			ROOT_DEV = Root_RAM0;
 
-	mount_root();
+		if (mount_root_try() == 0)
+			goto out;
+
+	}
+	mount_root_fail();
 out:
+	sys_unlink("/initrd.image");
 	sys_mount(".", "/", NULL, MS_MOVE, NULL);
 	sys_chroot(".");
 	security_sb_post_mountroot();
diff -uprN linux-2.6.18.1/init/do_mounts_initrd.c comma_root/init/do_mounts_initrd.c
--- linux-2.6.18.1/init/do_mounts_initrd.c	2006-10-13 20:34:03.000000000 -0700
+++ comma_root/init/do_mounts_initrd.c	2006-11-17 15:45:18.000000000 -0800
@@ -113,11 +113,9 @@ int __init initrd_load(void)
 		 * mounted in the normal path.
 		 */
 		if (rd_load_image("/initrd.image") && ROOT_DEV != Root_RAM0) {
-			sys_unlink("/initrd.image");
 			handle_initrd();
 			return 1;
 		}
 	}
-	sys_unlink("/initrd.image");
 	return 0;
 }
