Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279505AbRKVNtg>; Thu, 22 Nov 2001 08:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279591AbRKVNt1>; Thu, 22 Nov 2001 08:49:27 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:29188 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S279581AbRKVNtH>; Thu, 22 Nov 2001 08:49:07 -0500
Message-ID: <3BFD023B.7030307@namesys.com>
Date: Thu, 22 Nov 2001 16:48:43 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Christian =?ISO-8859-1?Q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
CC: Andreas Dilger <adilger@turbolabs.com>, chaffee@cs.berkeley.edu,
        linux-kernel@vger.kernel.org, Eric M <ground12@jippii.fi>
Subject: Re: 2.4.15-pre1:  "bogus" message with reiserfs root and other weirdness
In-Reply-To: <6893478.1006329318464.JavaMail.ground12@jippii.fi> <20011121111811.P1308@lynx.no> <E166e8A-0000t2-00@mrvdom02.schlund.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Bornträger wrote:

>>>Machine booted ok and everything seemed to be ok, but i noticed a few
>>>weird messages in boot messages right before mounting the root-partition:
>>>FAT: bogus logical sector size 0
>>>FAT: bogus logical sector size 0
>>>
>>When the kernel is booting, it doesn't know the filesystem type of the
>>root fs, so it tries to mount the root device using all of the compiled-in
>>fs drivers, in the order they are listed in fs/Makefile.in.
>>It appears that the fat driver doesn't even check for a magic when it
>>starts trying to mount the filesystem, so it proceeds directly to
>>
>
>To be complete we should also apply this patch.
>
>diff -urN linux/fs/fat/inode.c linux-new/fs/fat/inode.c
>--- linux/fs/fat/inode.c        Thu Oct 25 09:02:26 2001
>+++ linux-new/fs/fat/inode.c    Wed Nov 21 21:28:49 2001
>@@ -609,7 +609,8 @@
>                CF_LE_W(get_unaligned((unsigned short *) &b->sector_size));
>        if (!logical_sector_size
>            || (logical_sector_size & (logical_sector_size - 1))) {
>-               printk("FAT: bogus logical sector size %d\n",
>+               if (!silent)
>+                   printk("FAT: bogus logical sector size %d\n",
>                       logical_sector_size);
>                brelse(bh);
>                goto out_invalid;
>@@ -618,7 +619,8 @@
>        sbi->cluster_size = b->cluster_size;
>        if (!sbi->cluster_size
>            || (sbi->cluster_size & (sbi->cluster_size - 1))) {
>-               printk("FAT: bogus cluster size %d\n", sbi->cluster_size);
>+               if (!silent)
>+                   printk("FAT: bogus cluster size %d\n", sbi->cluster_size);
>                brelse(bh);
>                goto out_invalid;
>        }
>
>
How about putting fat last in the list, and having it say something more 
like "FAT: bogus cluster size, perhaps XXX is not a FAT partition"


