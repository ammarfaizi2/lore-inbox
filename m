Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135636AbREBQqL>; Wed, 2 May 2001 12:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135641AbREBQqC>; Wed, 2 May 2001 12:46:02 -0400
Received: from woods.iki.fi ([194.100.26.178]:47247 "EHLO woods.iki.fi")
	by vger.kernel.org with ESMTP id <S135636AbREBQpq>;
	Wed, 2 May 2001 12:45:46 -0400
Date: Wed, 2 May 2001 19:46:21 +0300
From: =?iso-8859-1?Q?Samuli_K=E4rkk=E4inen?= <skarkkai@woods.iki.fi>
To: linux-kernel@vger.kernel.org
Subject: Wrong free inodes count in kernels 2.0 and 2.2
Message-ID: <20010502194621.D22433@woods.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get repeatably both in 2.0 and 2.2 serieses of kernels the following kind
of errors:

2.0 kernels (at least 2.0.39):
  EXT2-fs error (device 03:04): ext2_check_inodes_bitmap: Wrong free inodes count in group 576, stored = 1956, counted = 1942
  EXT2-fs error (device 03:04): ext2_check_inodes_bitmap: Wrong free inodes count in group 577, stored = 1951, counted = 1942
  EXT2-fs error (device 03:04): ext2_check_inodes_bitmap: Wrong free inodes count in group 94, stored = 1921, counted = 1919
  [ many similar lines deleted ]

2.2 kernels (several, including 2.2.18):
  EXT2-fs error (device ide1(22,6)): ext2_check_inodes_bitmap: Wrong free inodes count in group 768, stored = 984, counted = 717
  EXT2-fs error (device ide1(22,6)): ext2_check_inodes_bitmap: Wrong free inodes count in group 769, stored = 1005, counted = 717
  EXT2-fs error (device ide1(22,6)): ext2_check_inodes_bitmap: Wrong free inodes count in group 777, stored = 998, counted = 901
  [ many similar lines deleted ]

and sometimes with 2.2 kernel, soon after the errors above:
  EXT2-fs error (device ide1(22,1)): ext2_new_inode: Free inodes count corrupted in group 414 
  last message repeated 795 times

The hosts running 2.0 and 2.2 kernels are completely separate. Also, all
hardware in the 2.2 box have been changed at least once, most components
more than that, and that hasn't affected the situation. There has been both
P2 and Athlon CPU's.

These errors start appearing when I have run my backup script about 10
times. They never show up before the script has been ran for about that many
times, and they always show up eventually. I have recreated the filesystem
several times, when trying different things to fix the problem, and the
problem always comes back. The backup script is essentially like this:

initial run:
  cp -ax / /backup/backup1
  
next night first differential:
  cp -al /backup/backup1 /backup/backup2
  rsync --archive --hard-links --whole-file --sparse --one-file-system --delete --force / /backup/backup2

following night second differential:
  cp -al /backup/backup2 /backup/backup3
  rsync --archive --hard-links --whole-file --sparse --one-file-system --delete --force / /backup/backup3

And so on. The result is that directories /backup/backupX each contain a
snapshot of the filesystem to be backed up, in this case the root
filesystem, with unchanged files hardlinked to the previous backups.

The hosts where this occurs have only one thing in common, namely that the
backups are made on IDE disks with ext2 filesystem. I also run this on a
third box, which has 2.0 kernel and SCSI disks, and the problem doesn't
occur there. Both boxes where the errors occur have otherwise no problems.

dumpe2fs says about the 2.0 box:
Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          c98e333c-0dbd-11d5-8297-00e02909a9a6
Filesystem magic number:  0xEF53
Filesystem revision #:    0 (original)
Filesystem features:      (none)
Filesystem state:         clean with errors
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              10733568
Block count:              42933712
Reserved block count:     2146685
Free blocks:              23202851
Free inodes:              10052554
First block:              1
Block size:               1024
Fragment size:            1024
Blocks per group:         8192
Fragments per group:      8192
Inodes per group:         2048
Inode blocks per group:   256
Last mount time:          Wed May  2 00:00:02 2001
Last write time:          Wed May  2 00:41:50 2001
Mount count:              18
Maximum mount count:      180
Last checked:             Wed Apr 18 07:53:30 2001
Check interval:           15552000 (6 months)
Next check after:         Mon Oct 15 07:53:30 2001
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)

and about the 2.2 box:
Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          e74e4331-4057-40a2-a62c-a4d195918c3a
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      filetype sparse_super
Filesystem state:         clean with errors
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              2009088
Block count:              16064968
Reserved block count:     803248
Free blocks:              2213966
Free inodes:              1094493
First block:              1
Block size:               1024
Fragment size:            1024
Blocks per group:         8192
Fragments per group:      8192
Inodes per group:         1024
Inode blocks per group:   128
Last mount time:          Wed May  2 00:00:00 2001
Last write time:          Wed May  2 00:42:32 2001
Mount count:              31
Maximum mount count:      20
Last checked:             Tue Apr  3 08:25:35 2001
Check interval:           15552000 (6 months)
Next check after:         Sun Sep 30 08:25:35 2001
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:		  128

More sample errors at http://www.woods.iki.fi/t/ext2-error/.

Anything else you need to know? I'd like to emphasis that this is highly
repeatable and occurs with a lot of different hardware.

-- 
  Samuli Kärkkäinen                   |\      _,,,---,,_
 skarkkai@woods.iki.fi----------ZZZzz /,`.-'`'    -.  ;-;;,_------
http://www.woods.iki.fi              |,4-  ) )-,_. ,\ (  `'-'
                                     '---''(_/--'  `-'\_)
