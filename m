Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290768AbSBOUTm>; Fri, 15 Feb 2002 15:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290769AbSBOUTc>; Fri, 15 Feb 2002 15:19:32 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:3087 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S290768AbSBOUTT>; Fri, 15 Feb 2002 15:19:19 -0500
To: Jos Hulzink <josh@stack.nl>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.5-pre1: mounting NTFS partitions -t VFAT
In-Reply-To: <20020215112031.S68580-100000@toad.stack.nl>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 16 Feb 2002 05:18:54 +0900
In-Reply-To: <20020215112031.S68580-100000@toad.stack.nl>
Message-ID: <87aduamrbl.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jos Hulzink <josh@stack.nl> writes:

> Hi,
> 
> Due to a recent change of filesystems, I found the following: 2.5.5-pre1
> mounts my NTFS (win2k) partition as VFAT partition, if told to do so. The
> kernel returns errors, but the mount is there. One write to the partition
> was enough to destroy the entire NTFS partition.
> 
> Due to filesystem damage, I didn't test the behaviour of the VFAT driver
> on other filesystems yet.
> 
> Kernel 2.4.17 also returns errors, but there the mount fails.
> 
> Will try to debug the problem myself this afternoon. Sounds like the VFAT
> procedure ignores some errors.

Sorry, my fault.

The following patch should fix this bug. I'll submit it after test.

--- fat_bug-2.5.5-pre1/fs/fat/inode.c.orig	Thu Feb 14 13:47:54 2002
+++ fat_bug-2.5.5-pre1/fs/fat/inode.c	Sat Feb 16 05:06:58 2002
@@ -624,6 +624,18 @@
 	}
 
 	b = (struct fat_boot_sector *) bh->b_data;
+	if (!b->fats) {
+		if (!silent)
+			printk("FAT: bogus number of FAT structure\n");
+		brelse(bh);
+		goto out_invalid;
+	}
+	if (!b->reserved) {
+		if (!silent)
+			printk("FAT: bogus number of reserved sectors\n");
+		brelse(bh);
+		goto out_invalid;
+	}
 	if (!b->secs_track) {
 		if (!silent)
 			printk("FAT: bogus sectors-per-track value\n");
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
