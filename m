Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWEWHbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWEWHbd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 03:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWEWHbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 03:31:33 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:20861 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932087AbWEWHbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 03:31:32 -0400
Date: Tue, 23 May 2006 15:31:29 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Jens Axboe <axboe@suse.de>, "Theodore Ts'o" <tytso@mit.edu>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [PATCH] loop: online resize support
Message-ID: <20060523073129.GA6507@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces new ioctl command LOOP_UPDATE_SIZE
which enables to resize online mounted loop device.

EXAMPLE
=======
# Make 10MB disk image
# dd if=/dev/zero of=image bs=1k count=10k
# mkfs.ext3 -j -F image

# Mount
# mkdir loop
# mount -o loop=/dev/loop/0,debug -t ext3 image loop

# Check disk size
# df -h loop
Filesystem            Size  Used Avail Use% Mounted on
/home/mita/looback-test/image
                      9.7M  1.1M  8.2M  12% /home/mita/looback-test/loop

# Extend disk image to 20MB
# dd if=/dev/zero of=appendix bs=1k count=10k
# cat appendix >> image

# Resize
# gcc -o loop-update loop-update.c
# ./loop-update /dev/loop/0
# ext2online -d -v image

# Check disk size again
# df -h loop
Filesystem            Size  Used Avail Use% Mounted on
/home/mita/looback-test/image
                       20M  1.1M   18M   6% /home/mita/looback-test/loop

loop-update.c
=============
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#define LOOP_UPDATE_SIZE	0x4C07

int main(int argc, char **argv)
{
	int fd;
	int err;

	if (argc < 2) {
		fprintf(stderr, "usage: loop-update loop_device\n");
		exit(1);
	}

	fd = open(argv[1], O_RDWR);
	if (fd < 0) {
		perror(argv[1]);
		exit(1);
	}

	err = ioctl(fd, LOOP_UPDATE_SIZE, NULL);
	if (err) {
		perror(argv[1]);
		exit(1);
	}
}


CC: Jens Axboe <axboe@suse.de>
CC: "Theodore Ts'o" <tytso@mit.edu>
Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

--- 2.6-mm/include/linux/loop.h.orig	2006-05-23 12:52:54.000000000 +0800
+++ 2.6-mm/include/linux/loop.h	2006-05-23 12:59:14.000000000 +0800
@@ -158,5 +158,6 @@ int loop_unregister_transfer(int number)
 #define LOOP_SET_STATUS64	0x4C04
 #define LOOP_GET_STATUS64	0x4C05
 #define LOOP_CHANGE_FD		0x4C06
+#define LOOP_UPDATE_SIZE	0x4C07
 
 #endif
--- 2.6-mm/drivers/block/loop.c.orig	2006-05-23 12:51:11.000000000 +0800
+++ 2.6-mm/drivers/block/loop.c	2006-05-23 13:50:58.000000000 +0800
@@ -1108,7 +1108,8 @@ loop_set_status64(struct loop_device *lo
 }
 
 static int
-loop_get_status_old(struct loop_device *lo, struct loop_info __user *arg) {
+loop_get_status_old(struct loop_device *lo, struct loop_info __user *arg)
+{
 	struct loop_info info;
 	struct loop_info64 info64;
 	int err = 0;
@@ -1126,7 +1127,8 @@ loop_get_status_old(struct loop_device *
 }
 
 static int
-loop_get_status64(struct loop_device *lo, struct loop_info64 __user *arg) {
+loop_get_status64(struct loop_device *lo, struct loop_info64 __user *arg)
+{
 	struct loop_info64 info64;
 	int err = 0;
 
@@ -1140,6 +1142,17 @@ loop_get_status64(struct loop_device *lo
 	return err;
 }
 
+static int loop_update_size(struct loop_device *lo)
+{
+	int err = figure_loop_size(lo);
+
+	if (!err)
+		i_size_write(lo->lo_device->bd_inode,
+			     (loff_t) get_capacity(disks[lo->lo_number]) << 9);
+
+	return err;
+}
+
 static int lo_ioctl(struct inode * inode, struct file * file,
 	unsigned int cmd, unsigned long arg)
 {
@@ -1169,6 +1182,9 @@ static int lo_ioctl(struct inode * inode
 	case LOOP_GET_STATUS64:
 		err = loop_get_status64(lo, (struct loop_info64 __user *) arg);
 		break;
+	case LOOP_UPDATE_SIZE:
+		err = loop_update_size(lo);
+		break;
 	default:
 		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
 	}
