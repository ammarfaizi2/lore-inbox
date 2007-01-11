Return-Path: <linux-kernel-owner+w=401wt.eu-S1751489AbXAKU2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbXAKU2Z (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 15:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbXAKU2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 15:28:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46405 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371AbXAKU2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 15:28:24 -0500
Message-ID: <45A69DDE.2020208@redhat.com>
Date: Thu, 11 Jan 2007 14:28:14 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext4 development <linux-ext4@vger.kernel.org>
Subject: [PATCH] [UPDATED] ext3: refuse ro to rw remount of fs with orphan
 inodes
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a followup to the patch which skipped orphan inode processing 
on a filesystem residing on a readonly bdev (think snapshot taken
with open, unlinked files).  That avoided an oops.

Stephen had concerns about what happens if the bdev later goes readwrite,
and the filesystem is subsequently mounted remount,rw - if the orphan
list isn't processed then, things will be in bad shape.

The patch I sent earlier to process the orphan inode list on remount
was met with silence and/or slight suspicion (from akpm) so how
about this: just to plug the hole on what I think is a pretty rare
condition, simply disallow the ro->rw transition if we have unprocessed
orphan inodes.

Then we get this:

[root@magnesium ~]# mount -o remount,rw /mnt/test
mount: /mnt/test not mounted already, or bad option
[root@magnesium ~]# dmesg | tail -n 1
EXT3-fs: hda7: couldn't remount RDWR because of unprocessed orphan inode list.  Please umount/remount instead.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Index: linux-2.6.19/fs/ext3/super.c
===================================================================
--- linux-2.6.19.orig/fs/ext3/super.c
+++ linux-2.6.19/fs/ext3/super.c
@@ -2350,6 +2350,22 @@ static int ext3_remount (struct super_bl
 				err = -EROFS;
 				goto restore_opts;
 			}
+
+			/*
+			 * If we have an unprocessed orphan list hanging
+			 * around from a previously readonly bdev mount,
+			 * require a full umount/remount for now.
+			 */
+			if (es->s_last_orphan) {
+				printk(KERN_WARNING "EXT3-fs: %s: couldn't "
+				       "remount RDWR because of unprocessed "
+				       "orphan inode list.  Please "
+				       "umount/remount instead.\n",
+				       sb->s_id);
+				err = -EINVAL;
+				goto restore_opts;
+			}
+
 			/*
 			 * Mounting a RDONLY partition read-write, so reread
 			 * and store the current valid flag.  (It may have


