Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281973AbRKUUit>; Wed, 21 Nov 2001 15:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281974AbRKUUij>; Wed, 21 Nov 2001 15:38:39 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:27689 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S281973AbRKUUi0> convert rfc822-to-8bit; Wed, 21 Nov 2001 15:38:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: Andreas Dilger <adilger@turbolabs.com>, Hans Reiser <reiser@namesys.com>,
        chaffee@cs.berkeley.edu
Subject: Re: 2.4.15-pre1:  "bogus" message with reiserfs root and other weirdness
Date: Wed, 21 Nov 2001 21:37:34 +0100
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, Eric M <ground12@jippii.fi>
In-Reply-To: <6893478.1006329318464.JavaMail.ground12@jippii.fi> <20011121111811.P1308@lynx.no>
In-Reply-To: <20011121111811.P1308@lynx.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E166e8A-0000t2-00@mrvdom02.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Machine booted ok and everything seemed to be ok, but i noticed a few
> > weird messages in boot messages right before mounting the root-partition:
> > FAT: bogus logical sector size 0
> > FAT: bogus logical sector size 0
> When the kernel is booting, it doesn't know the filesystem type of the
> root fs, so it tries to mount the root device using all of the compiled-in
> fs drivers, in the order they are listed in fs/Makefile.in.
> It appears that the fat driver doesn't even check for a magic when it
> starts trying to mount the filesystem, so it proceeds directly to

To be complete we should also apply this patch.

diff -urN linux/fs/fat/inode.c linux-new/fs/fat/inode.c
--- linux/fs/fat/inode.c        Thu Oct 25 09:02:26 2001
+++ linux-new/fs/fat/inode.c    Wed Nov 21 21:28:49 2001
@@ -609,7 +609,8 @@
                CF_LE_W(get_unaligned((unsigned short *) &b->sector_size));
        if (!logical_sector_size
            || (logical_sector_size & (logical_sector_size - 1))) {
-               printk("FAT: bogus logical sector size %d\n",
+               if (!silent)
+                   printk("FAT: bogus logical sector size %d\n",
                       logical_sector_size);
                brelse(bh);
                goto out_invalid;
@@ -618,7 +619,8 @@
        sbi->cluster_size = b->cluster_size;
        if (!sbi->cluster_size
            || (sbi->cluster_size & (sbi->cluster_size - 1))) {
-               printk("FAT: bogus cluster size %d\n", sbi->cluster_size);
+               if (!silent)
+                   printk("FAT: bogus cluster size %d\n", sbi->cluster_size);
                brelse(bh);
                goto out_invalid;
        }
