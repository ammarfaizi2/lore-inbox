Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262824AbSLAXAj>; Sun, 1 Dec 2002 18:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262828AbSLAXAi>; Sun, 1 Dec 2002 18:00:38 -0500
Received: from hermes.domdv.de ([193.102.202.1]:59397 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S262824AbSLAXAh>;
	Sun, 1 Dec 2002 18:00:37 -0500
Message-ID: <3DEA97B1.4080002@domdv.de>
Date: Mon, 02 Dec 2002 00:13:53 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sct@redhat.com,
       akpm@zip.com.au, adilger@clusterfs.com
Subject: 2.4.20: ext3: Assertion failure in journal_forget() - filesystem
 destroyed
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This started to happen during larger (10MB-420MB) rsync based writes to
a striped ext3 partition (/dev/md11) residing on 4 scsi disks which is
mounted with defaults, i.e. data=ordered (rsync over 100Mbps link):

Dec  1 12:25:43 pollux kernel: EXT3-fs error (device md(9,11)):
ext3_new_block:
Allocating block in system zone - block = 114696
Dec  1 12:25:43 pollux kernel: EXT3-fs error (device md(9,11)):
ext3_new_block:
Allocating block in system zone - block = 114697
Dec  1 12:25:43 pollux kernel: EXT3-fs error (device md(9,11)):
ext3_new_block:
Allocating block in system zone - block = 114700
Dec  1 12:25:43 pollux kernel: EXT3-fs error (device md(9,11)):
ext3_new_block:
Allocating block in system zone - block = 114701
Dec  1 12:25:43 pollux kernel: EXT3-fs error (device md(9,11)):
ext3_new_block:
Allocating block in system zone - block = 114702
Dec  1 12:25:43 pollux kernel: EXT3-fs error (device md(9,11)):
ext3_new_block:
Allocating block in system zone - block = 114706

<snip>

Dec  1 22:17:55 pollux kernel: EXT3-fs error (device md(9,11)):
ext3_free_blocks
: Freeing blocks in system zones - Block = 573501, count = 2
Dec  1 22:17:55 pollux kernel: EXT3-fs error (device md(9,11)):
ext3_free_blocks
: Freeing blocks in system zones - Block = 573552, count = 14
Dec  1 22:17:55 pollux kernel: Assertion failure in journal_forget() at
transaction.c:1225: "!jh->b_committed_data"



Trying to access the partition resulted in processes hanging in D state:

5336 pts/0    D      0:00 ls -a -N --color=tty -T 0 -l /mnt/data8

e2fstools version is 1.32 and the partition was created with this
version using 'mke2fs -j -b 2048 -i 4096 -R stride=16 /dev/md11'.

An earlier dump of the partition data using tune2fs -l gave:

tune2fs 1.32 (09-Nov-2002)
Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          7c8d7827-4b25-40ab-a3b8-1c4c6e286868
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal filetype needs_recovery sparse_super
Default mount options:    (none)
Filesystem state:         clean with errors
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              2621440
Block count:              5236992
Reserved block count:     261849
Free blocks:              4855697
Free inodes:              2621416
First block:              0
Block size:               2048
Fragment size:            2048
Blocks per group:         16384
Fragments per group:      16384
Inodes per group:         8192
Inode blocks per group:   512
Last mount time:          Sat Nov 30 11:23:59 2002
Last write time:          Sun Dec  1 14:09:55 2002
Mount count:              2
Maximum mount count:      -1
Last checked:             Fri Dec  1 19:18:16 2000
Check interval:           0 (<none>)
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               128
Journal UUID:             <none>
Journal inode:            8
Journal device:           0x0000
First orphan inode:       0


Trying 'e2fsck -y /dev/md11' after a reboot showed so many errors and
continued to run for minutes that I aborted e2fsck and do assume that
the file system was completely destroyed.

After recreation of the filesystem on /dev/md11 a rsync run completed
without errors.

As a side note: the system having the rsync sources has an identical
formatted partition (the systems are hardware twins) and doesn't show
any errors.

Some final information about the raid configuration of /dev/md11:

raiddev /dev/md11
          raid-level              0
          nr-raid-disks           4
          nr-spare-disks          0
          chunk-size              32
          persistent-superblock   1
          device                  /dev/sda13
          raid-disk               0
          device                  /dev/sdb13
          raid-disk               1
          device                  /dev/sdc15
          raid-disk               2
          device                  /dev/sdd15
          raid-disk               3
-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH


