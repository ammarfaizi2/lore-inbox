Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbTBTH6w>; Thu, 20 Feb 2003 02:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264939AbTBTH6w>; Thu, 20 Feb 2003 02:58:52 -0500
Received: from angband.namesys.com ([212.16.7.85]:46986 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S264938AbTBTH6v>; Thu, 20 Feb 2003 02:58:51 -0500
Date: Thu, 20 Feb 2003 11:08:51 +0300
From: Oleg Drokin <green@namesys.com>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: uml-patch-2.5.62-1
Message-ID: <20030220110851.A1069@namesys.com>
References: <200302192008.h1JK88P16444@uml.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302192008.h1JK88P16444@uml.karaya.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Feb 19, 2003 at 03:08:08PM -0500, Jeff Dike wrote:

> 	ubd driver cleanups and fixes

Ah, great. Except it introduced new breakage.
That hunk below from your diff adds add_disk() call.
Notice how a bit down we have another  call to add_disk(),
that is not removed. So we end up woth two add_disk() calls.
Of course sysfs gets upset immediately (probably not only it).

diff -Naur a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
--- a/arch/um/drivers/ubd_kern.c        Wed Feb 19 11:24:39 2003
+++ b/arch/um/drivers/ubd_kern.c        Wed Feb 19 11:29:49 2003
@@ -499,17 +516,22 @@
        disk->major = major;
        disk->first_minor = minor;
        disk->fops = &ubd_blops;
+       disk->private_data = dev;
+       disk->queue = &ubd_queue;
        set_capacity(disk, size / 512);
-       /* needs to be ubd -> /dev/ubd/discX/disc */
-       sprintf(disk->disk_name, "ubd");
+       sprintf(disk->disk_name, name);
        *disk_out = disk;
+       add_disk(disk);

-       /* /dev/ubd/N style names */
-       sprintf(devfs_name, "%d", unit);
-       *handle_out = devfs_register(dir_handle, devfs_name,
-                                    DEVFS_FL_REMOVABLE, major, minor,
-                                    S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP |
-                                    S_IWGRP, &ubd_blops, NULL);
+       if(handle_out != NULL){
+               /* /dev/ubd/N style names */
+               sprintf(devfs_name, "%d", unit);
+               *handle_out = devfs_register(dir_handle, devfs_name,
+                                            DEVFS_FL_DEFAULT, major, minor,
+                                            S_IFBLK | S_IRUSR | S_IWUSR |
+                                            S_IRGRP | S_IWGRP, &ubd_blops,
+                                            NULL);
+       }
        disk->private_data = &ubd_dev[unit];
        disk->queue = &ubd_queue;
        add_disk(disk);


Bye,
    Oleg
