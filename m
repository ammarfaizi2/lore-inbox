Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283467AbRLTKMa>; Thu, 20 Dec 2001 05:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283718AbRLTKMV>; Thu, 20 Dec 2001 05:12:21 -0500
Received: from [195.66.192.167] ([195.66.192.167]:32019 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S283694AbRLTKMN>; Thu, 20 Dec 2001 05:12:13 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: [BUG] cramfs+initrd: BOOM! (Re: ramdisk corruption problems)
Date: Thu, 20 Dec 2001 12:11:05 -0200
X-Mailer: KMail [version 1.2]
Cc: Alexander Viro <viro@math.psu.edu>,
        Torrey Hoffman <torrey.hoffman@myrio.com>, <andersen@codepoet.org>
MIME-Version: 1.0
Message-Id: <01122012110506.01835@manta>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[fifth (!) attempt, previous mails did not show up on lkml]
[This msg definitely does not want to make it into the list :-)]

At last I have found one definite bug (maybe there are others).
I was unable to load a minix initrd on any 2.4.12+ kernel. 2.4.10 is fine.
Thanks to Mike Galbraith <mikeg@wen-online.de> who said that he can load 
minix initrds and sent me both .config and initrd. I found out that with his 
.config I indeed can load my initrd. After many recompilations and reboots 
(binary search :-) it turned out that compiled-in support for cramfs caused
initrds to be corrupted.

[update since 3rd attempt to reach lkml]
I did some debugging in fs/cramfs/inode.c:cramfs_read_super()
If I plant immediate "return 0;" there initrd loads.
If I place "return 0;" after "set_blocksize(sb->s_dev, PAGE_CACHE_SIZE);"
- BOOM! Kernel panic. Restoring blocksize to 1024 prior to return does NOT 
help.
[end update]

This is the diff between 'good' and 'bad' .config:

--- .config.good         Tue Dec 18 22:21:20 2001
+++ .config.bad  Tue Dec 18 22:21:10 2001
@@ -716,7 +716,7 @@
 CONFIG_EFS_FS=m
 # CONFIG_JFFS_FS is not set
 # CONFIG_JFFS2_FS is not set
-# CONFIG_CRAMFS is not set
+CONFIG_CRAMFS=y
 CONFIG_TMPFS=y
 CONFIG_RAMFS=y
 CONFIG_ISO9660_FS=y
@@ -767,7 +767,7 @@
 # CONFIG_NCPFS_NLS is not set
 # CONFIG_NCPFS_EXTRAS is not set
 # CONFIG_ZISOFS_FS is not set
-# CONFIG_ZLIB_FS_INFLATE is not set
+CONFIG_ZLIB_FS_INFLATE=y

 #
 # Partition Types

See?
Hope this info is useful.
--
vda
