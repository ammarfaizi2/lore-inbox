Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUJWNRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUJWNRc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 09:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbUJWNRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 09:17:32 -0400
Received: from server133-han.de-nserver.de ([81.3.17.173]:38860 "EHLO
	server133-han.de-nserver.de") by vger.kernel.org with ESMTP
	id S261169AbUJWNRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 09:17:21 -0400
Date: Sat, 23 Oct 2004 15:18:19 +0000
From: markus reichelt <ml@bitfalle.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
Message-ID: <20041023151819.GB2540@dantooine>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
Organization: still stuck in reorganization mode
X-Request-PGP: http://bitfalle.org/keys/pubkey.mr.lists.asc
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus Torvalds <torvalds@osdl.org> wrote:
> (*) In other words, I had a beer and watched TV. Mmm... Donuts.

seems to be a good opportunity even though I'm a bit late, but could
you please include this patch, written by Heikki Linnakangas?

http://mareichelt.de/pub/boot-off-usb/boot-off-usb-2.patch

applies cleanly to 2.6.7 vanilla, thus making boot off usb devices
possible

-- 
Bastard Administrator in $hell


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="boot-off-usb-2.patch"

diff -c init/do_mounts.c init.orig/do_mounts.c
*** init/do_mounts.c	Tue Oct  5 22:16:54 2004
--- init.orig/do_mounts.c	Wed Jun 16 08:19:13 2004
***************
*** 272,285 ****
  	return 0;
  }
  
! static int first_try = 1;
! 
! int __init mount_block_root(char *name, int flags)
  {
  	char *fs_names = __getname();
  	char *p;
  	char b[BDEVNAME_SIZE];
- 	int success;
  
  	get_fs_names(fs_names);
  retry:
--- 272,282 ----
  	return 0;
  }
  
! void __init mount_block_root(char *name, int flags)
  {
  	char *fs_names = __getname();
  	char *p;
  	char b[BDEVNAME_SIZE];
  
  	get_fs_names(fs_names);
  retry:
***************
*** 287,293 ****
  		int err = do_mount_root(name, p, flags, root_mount_data);
  		switch (err) {
  			case 0:
- 				success = 1;
  				goto out;
  			case -EACCES:
  				flags |= MS_RDONLY;
--- 284,289 ----
***************
*** 295,320 ****
  			case -EINVAL:
  				continue;
  		}
! 		/* Print out a warning on the first attempt */
! 		if(first_try) {
! 			first_try = 0;
! 			/*
! 			 * Allow the user to distinguish between failed sys_open
! 			 * and bad superblock on root device.
! 			 */
! 			__bdevname(ROOT_DEV, b);
!   
! 			printk("VFS: Cannot open root device \"%s\" or %s\n",
  				root_device_name, b);
! 			printk("Retrying. Please verify the \"root=\" boot option.\n");
! 		}
! 		success = 0;
! 		goto out;
  	}
  	panic("VFS: Unable to mount root fs on %s", __bdevname(ROOT_DEV, b));
  out:
  	putname(fs_names);
- 	return success;
  }
   
  #ifdef CONFIG_ROOT_NFS
--- 291,310 ----
  			case -EINVAL:
  				continue;
  		}
! 	        /*
! 		 * Allow the user to distinguish between failed sys_open
! 		 * and bad superblock on root device.
! 		 */
! 		__bdevname(ROOT_DEV, b);
! 		printk("VFS: Cannot open root device \"%s\" or %s\n",
  				root_device_name, b);
! 		printk("Please append a correct \"root=\" boot option\n");
! 
! 		panic("VFS: Unable to mount root fs on %s", b);
  	}
  	panic("VFS: Unable to mount root fs on %s", __bdevname(ROOT_DEV, b));
  out:
  	putname(fs_names);
  }
   
  #ifdef CONFIG_ROOT_NFS
***************
*** 360,366 ****
  }
  #endif
  
! int __init mount_root(void)
  {
  #ifdef CONFIG_ROOT_NFS
  	if (MAJOR(ROOT_DEV) == UNNAMED_MAJOR) {
--- 350,356 ----
  }
  #endif
  
! void __init mount_root(void)
  {
  #ifdef CONFIG_ROOT_NFS
  	if (MAJOR(ROOT_DEV) == UNNAMED_MAJOR) {
***************
*** 384,390 ****
  	}
  #endif
  	create_dev("/dev/root", ROOT_DEV, root_device_name);
! 	return mount_block_root("/dev/root", root_mountflags);
  }
  
  /*
--- 374,380 ----
  	}
  #endif
  	create_dev("/dev/root", ROOT_DEV, root_device_name);
! 	mount_block_root("/dev/root", root_mountflags);
  }
  
  /*
***************
*** 398,427 ****
  
  	md_run_setup();
  
! 	do {
! 		if (saved_root_name[0]) {
! 			root_device_name = saved_root_name;
! 			ROOT_DEV = name_to_dev_t(root_device_name);
! 			if (strncmp(root_device_name, "/dev/", 5) == 0)
! 				root_device_name += 5;
! 		}
! 
! 		is_floppy = MAJOR(ROOT_DEV) == FLOPPY_MAJOR;
! 
! 		if (initrd_load())
! 			break;
  
! 		if (is_floppy && rd_doload && rd_load_disk(0))
! 			ROOT_DEV = Root_RAM0;
  
! 		if(mount_root())
! 			break;
  
! 		/* Mounting root failed. Retry after a small delay */
! 		set_current_state(TASK_INTERRUPTIBLE);
! 		schedule_timeout(1*HZ);
! 	} while(1);
  
  	umount_devfs("/dev");
  	sys_mount(".", "/", NULL, MS_MOVE, NULL);
  	sys_chroot(".");
--- 388,410 ----
  
  	md_run_setup();
  
! 	if (saved_root_name[0]) {
! 		root_device_name = saved_root_name;
! 		ROOT_DEV = name_to_dev_t(root_device_name);
! 		if (strncmp(root_device_name, "/dev/", 5) == 0)
! 			root_device_name += 5;
! 	}
  
! 	is_floppy = MAJOR(ROOT_DEV) == FLOPPY_MAJOR;
  
! 	if (initrd_load())
! 		goto out;
  
! 	if (is_floppy && rd_doload && rd_load_disk(0))
! 		ROOT_DEV = Root_RAM0;
  
+ 	mount_root();
+ out:
  	umount_devfs("/dev");
  	sys_mount(".", "/", NULL, MS_MOVE, NULL);
  	sys_chroot(".");
diff -c init/do_mounts.h init.orig/do_mounts.h
*** init/do_mounts.h	Tue Oct  5 22:10:30 2004
--- init.orig/do_mounts.h	Wed Jun 16 08:19:37 2004
***************
*** 11,18 ****
  
  dev_t name_to_dev_t(char *name);
  void  change_floppy(char *fmt, ...);
! int  mount_block_root(char *name, int flags);
! int  mount_root(void);
  extern int root_mountflags;
  extern char *root_device_name;
  
--- 11,18 ----
  
  dev_t name_to_dev_t(char *name);
  void  change_floppy(char *fmt, ...);
! void  mount_block_root(char *name, int flags);
! void  mount_root(void);
  extern int root_mountflags;
  extern char *root_device_name;

--4Ckj6UjgE2iN1+kY--
