Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266812AbUHCTeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266812AbUHCTeA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 15:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266813AbUHCTeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 15:34:00 -0400
Received: from smtp-1.hut.fi ([130.233.228.91]:4782 "EHLO smtp-1.hut.fi")
	by vger.kernel.org with ESMTP id S266812AbUHCTdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 15:33:18 -0400
Date: Tue, 3 Aug 2004 22:33:04 +0300 (EEST)
From: Heikki Linnakangas <hlinnaka@iki.fi>
X-X-Sender: hlinnaka@kosh.hut.fi
To: linux-kernel@vger.kernel.org
cc: wewright@verizonmail.com, rddunlap@osdl.org
Subject: [PATCH] Retrying root mounting for booting off USB
Message-ID: <Pine.OSF.4.60.0408032154400.205783@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (smtp-1.hut.fi)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, booting off USB devices doesn't work in all environments. The 
root fs mounting code in init/do_mounts.c decides that the root filesystem 
is not available and gives up before the USB mass storage driver gets 
fully initialized.

There has been many quick & dirty patches floating around for 2.4 kernels 
to add a small delay to the boot process or to retry the mount if it 
doesn't succeed the first time. None of these old patches seem to work 
correctly on the latest kernels.

This patch implements the "retry until succeeds" approach. It applies at 
least to 2.6.7 and 2.6.8-rc2-mm1. BTW: The trivial implementation of just 
doing a "goto retry" in mount_block_root doesn't work, because create_dev 
is called outside mount_block_root and it needs to see the new device.

I've tested it on my laptop and my desktop. More testing is welcome!

Please CC replies directly to me, I'm not subscribed.

- Heikki


diff -ru linux-2.6.8-rc2-mm1.orig/init/do_mounts.c linux-2.6.8-rc2-mm1/init/do_mounts.c
--- linux-2.6.8-rc2-mm1.orig/init/do_mounts.c	2004-06-16 08:19:13.000000000 +0300
+++ linux-2.6.8-rc2-mm1/init/do_mounts.c	2004-08-03 18:59:59.000000000 +0300
@@ -272,11 +272,14 @@
  	return 0;
  }

-void __init mount_block_root(char *name, int flags)
+static int first_try = 1;
+
+int __init mount_block_root(char *name, int flags)
  {
  	char *fs_names = __getname();
  	char *p;
  	char b[BDEVNAME_SIZE];
+	int success;

  	get_fs_names(fs_names);
  retry:
@@ -284,6 +287,7 @@
  		int err = do_mount_root(name, p, flags, root_mount_data);
  		switch (err) {
  			case 0:
+				success = 1;
  				goto out;
  			case -EACCES:
  				flags |= MS_RDONLY;
@@ -291,20 +295,26 @@
  			case -EINVAL:
  				continue;
  		}
-	        /*
-		 * Allow the user to distinguish between failed sys_open
-		 * and bad superblock on root device.
-		 */
-		__bdevname(ROOT_DEV, b);
-		printk("VFS: Cannot open root device \"%s\" or %s\n",
-				root_device_name, b);
-		printk("Please append a correct \"root=\" boot option\n");
+		/* Print out a warning on the first attempt */
+		if(first_try) {
+			first_try = 0;
+			/*
+			 * Allow the user to distinguish between failed sys_open
+			 * and bad superblock on root device.
+			 */
+			__bdevname(ROOT_DEV, b);

-		panic("VFS: Unable to mount root fs on %s", b);
+			printk("VFS: Cannot open root device \"%s\" or %s\n",
+				root_device_name, b);
+			printk("Retrying. Please verify the \"root=\" boot option.\n");
+		}
+		success = 0;
+		goto out;
  	}
  	panic("VFS: Unable to mount root fs on %s", __bdevname(ROOT_DEV, b));
  out:
  	putname(fs_names);
+	return success;
  }

  #ifdef CONFIG_ROOT_NFS
@@ -350,7 +360,7 @@
  }
  #endif

-void __init mount_root(void)
+int __init mount_root(void)
  {
  #ifdef CONFIG_ROOT_NFS
  	if (MAJOR(ROOT_DEV) == UNNAMED_MAJOR) {
@@ -374,7 +384,7 @@
  	}
  #endif
  	create_dev("/dev/root", ROOT_DEV, root_device_name);
-	mount_block_root("/dev/root", root_mountflags);
+	return mount_block_root("/dev/root", root_mountflags);
  }

  /*
@@ -388,23 +398,30 @@

  	md_run_setup();

-	if (saved_root_name[0]) {
-		root_device_name = saved_root_name;
-		ROOT_DEV = name_to_dev_t(root_device_name);
-		if (strncmp(root_device_name, "/dev/", 5) == 0)
-			root_device_name += 5;
-	}
+	do {
+		if (saved_root_name[0]) {
+			root_device_name = saved_root_name;
+			ROOT_DEV = name_to_dev_t(root_device_name);
+			if (strncmp(root_device_name, "/dev/", 5) == 0)
+				root_device_name += 5;
+		}

-	is_floppy = MAJOR(ROOT_DEV) == FLOPPY_MAJOR;
+		is_floppy = MAJOR(ROOT_DEV) == FLOPPY_MAJOR;

-	if (initrd_load())
-		goto out;
+		if (initrd_load())
+			break;

-	if (is_floppy && rd_doload && rd_load_disk(0))
-		ROOT_DEV = Root_RAM0;
+		if (is_floppy && rd_doload && rd_load_disk(0))
+			ROOT_DEV = Root_RAM0;
+
+		if(mount_root())
+			break;
+
+		/* Mounting root failed. Retry after a small delay */
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(1*HZ);
+	} while(1);

-	mount_root();
-out:
  	umount_devfs("/dev");
  	sys_mount(".", "/", NULL, MS_MOVE, NULL);
  	sys_chroot(".");
diff -ru linux-2.6.8-rc2-mm1.orig/init/do_mounts.h linux-2.6.8-rc2-mm1/init/do_mounts.h
--- linux-2.6.8-rc2-mm1.orig/init/do_mounts.h	2004-06-16 08:19:37.000000000 +0300
+++ linux-2.6.8-rc2-mm1/init/do_mounts.h	2004-08-02 23:28:35.000000000 +0300
@@ -11,8 +11,8 @@

  dev_t name_to_dev_t(char *name);
  void  change_floppy(char *fmt, ...);
-void  mount_block_root(char *name, int flags);
-void  mount_root(void);
+int  mount_block_root(char *name, int flags);
+int  mount_root(void);
  extern int root_mountflags;
  extern char *root_device_name;

