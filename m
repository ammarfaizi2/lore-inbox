Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261834AbSJNGVI>; Mon, 14 Oct 2002 02:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261843AbSJNGVI>; Mon, 14 Oct 2002 02:21:08 -0400
Received: from rj.sgi.com ([192.82.208.96]:22996 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S261834AbSJNGVH>;
	Mon, 14 Oct 2002 02:21:07 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: rgooch@atnf.csiro.au, viro@math.psu.edu
Subject: 2.4.19 breaks devfs mapping for root=
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 14 Oct 2002 16:26:07 +1000
Message-ID: <26708.1034576767@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A change from 2.4.18 to 2.4.19 has broken the way that devfs maps
root=.  2.4.18 init/main.c::mount_root() has

        devfs_make_root (root_device_name);
        handle = devfs_find_handle (NULL, ROOT_DEVICE_NAME,
                                    MAJOR (ROOT_DEV), MINOR (ROOT_DEV),
                                    DEVFS_SPECIAL_BLK, 1);

where ROOT_DEVICE_NAME maps to the value of root= for non-initrd.  This
allowed devfs to remap an entry such as sda3 to whatever driver was
implementing sda3, even if that driver used a different major number.
The correct major was returned in handle.

2.4.19 init/do_mounts.c::mount_root() has

        devfs_make_root(root_device_name);
        create_dev("/dev/root", ROOT_DEV, root_device_name);

create_dev() has

	handle = devfs_find_handle(NULL, dev ? NULL : devfs_name,
                    MAJOR(dev), MINOR(dev), DEVFS_SPECIAL_BLK, 1);

The difference in 2.4.19 is that if dev is already set from
root_dev_names[] then devfs does NOT get the value of root=, forcing
the use of major from root_dev_names[].  If a driver reimplements one
of the standard device names and uses a different major or minor number
then it no longer works in 2.4.19 because devfs is given incomplete
information.

Quick and dirty workaround

--- 2.4.19/init/do_mounts.c
+++ 2.4.19/init/do_mounts.c
@@ -368,7 +368,7 @@
 	if (!do_devfs)
 		return sys_mknod(name, S_IFBLK|0600, kdev_t_to_nr(dev));
 
-	handle = devfs_find_handle(NULL, dev ? NULL : devfs_name,
+	handle = devfs_find_handle(NULL, devfs_name,
 				MAJOR(dev), MINOR(dev), DEVFS_SPECIAL_BLK, 1);
 	if (!handle)
 		return -1;

But that probably breaks initrd.  What should that code be doing to
cope with both initrd and still allow devfs to remap root=?

