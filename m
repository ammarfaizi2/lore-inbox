Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbUCKQZo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 11:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbUCKQZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 11:25:44 -0500
Received: from web60709.mail.yahoo.com ([216.109.117.232]:55726 "HELO
	web60709.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261477AbUCKQZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 11:25:38 -0500
Message-ID: <20040311162534.48316.qmail@web60709.mail.yahoo.com>
Date: Thu, 11 Mar 2004 11:25:34 -0500 (EST)
From: Jonathan Filiatrault <lintuxicated@yahoo.ca>
Subject: Weirdness with romfs automatic filesystem detection
To: linux-kernel@vger.kernel.org
Cc: viro@math.psu.edu
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to you all,
	Recently(yesterday), I had trouble getting the
kernel(2.6.3) to mount my romfs initrd. After hours of
tinkering, I found out that I HAD to specify
rootfstype in order to make it work(ext2 worked w/o
rootfstype).
	So, I did a little investigating(see patch below), I
found out that when the romfs driver is the first to
try to mount the initrd, it does allright, but when it
tries after all the other drivers, it fails with code
-22(EINVAL I think)

Conclusions:
-This is expected behaviour (hope not).
-The filesystem drivers modify the initrd or its
state.
-The romfs driver has something nasty in it.
-Im only a n00b and I dont know what im talking about.

It would be great if I could get help solving this
mistery, as my hacking skills are lacking...

Sincerly, Joe

Below is my kernel output:

By leaving the kernel determine the filesystem type
(copied by hand):

(next line when using compressed ramdisk)
RAMDISK: Compressed image found at block 0
(next two lines w/o compression)
RAMDISK: romfs filesystem found at block 0
RAMDISK: Loading 1093 blocks [1 disk] into ram disk...
done.
Trying to mount root as type reiserfs: got -22
Trying to mount root as type minix: got -22
Trying to mount root as type vfat: got -22
Trying to mount root as type iso9660: got -22
Trying to mount root as type ntfs: got -22
Trying to mount root as type romfs: VFS: Can't find a
romfs filesystem on dev ram0.
got -22
...
Panic, could not mount root fs, etc


By specifiyng rootfstype=romfs:

(next line when using compressed ramdisk)
RAMDISK: Compressed image found at block 0
(next two lines w/o compression)
RAMDISK: romfs filesystem found at block 0
RAMDISK: Loading 1093 blocks [1 disk] into ram disk...
done.
Trying to mount root as type romfs: VFS: Mounted root
(romfs filesystem) readonly.
got 0
...
success, initrd mounts system, etc...

This patch show the code returned by the different fs
drivers.

diff -uprN linux-2.6.3/fs/romfs/inode.c
linux-modded/fs/romfs/inode.c
--- linux-2.6.3/fs/romfs/inode.c	2004-02-17
22:58:40.000000000 -0500
+++ linux-modded/fs/romfs/inode.c	2004-03-10
21:54:41.000000000 -0500
@@ -116,6 +116,7 @@ static int romfs_fill_super(struct
super
 	struct buffer_head *bh;
 	struct romfs_super_block *rsb;
 	int sz;
+	silent = 0;
 
 	/* I would parse the options here, but there are
none.. :) */
 
diff -uprN linux-2.6.3/init/do_mounts.c
linux-modded/init/do_mounts.c
--- linux-2.6.3/init/do_mounts.c	2004-02-17
22:57:28.000000000 -0500
+++ linux-modded/init/do_mounts.c	2004-03-10
21:44:32.000000000 -0500
@@ -274,7 +274,10 @@ void __init mount_block_root(char
*name,
 	get_fs_names(fs_names);
 retry:
 	for (p = fs_names; *p; p += strlen(p)+1) {
-		int err = do_mount_root(name, p, flags,
root_mount_data);
+		int err;
+		printk("Trying to mount root as type %s: ", p);
+		err = do_mount_root(name, p, flags,
root_mount_data);
+		printk("got %d\n", err);
 		switch (err) {
 			case 0:
 				goto out;


______________________________________________________________________ 
Post your free ad now! http://personals.yahoo.ca
