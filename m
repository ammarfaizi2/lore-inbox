Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261502AbTCZINn>; Wed, 26 Mar 2003 03:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261504AbTCZINn>; Wed, 26 Mar 2003 03:13:43 -0500
Received: from manta.univ.gda.pl ([153.19.7.200]:63246 "EHLO manta.univ.gda.pl")
	by vger.kernel.org with ESMTP id <S261502AbTCZINm>;
	Wed, 26 Mar 2003 03:13:42 -0500
Date: Wed, 26 Mar 2003 09:26:32 +0100
From: Michal Grzedzicki <lazy@manta.univ.gda.pl>
To: Daniel Quinlan <quinlan@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Cramfs compilation errors under 2.5.66.
Message-ID: <20030326082632.GA23497@manta.univ.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently encountered some errors during the build of
cramfs for Linux kernel 2.5.66.

gcc -Wp,-MD,fs/cramfs/.inode.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=inode -DKBUILD_MODNAME=cramfs -c -o fs/cramfs/inode.o fs/cramfs/inode.c
fs/cramfs/inode.c: In function `get_cramfs_inode':
fs/cramfs/inode.c:54: incompatible types in assignment
make[2]: *** [fs/cramfs/inode.o] Error 1
make[1]: *** [fs/cramfs] Error 2
make: *** [fs] Error 2


The problem is that i_mtime and i_atime members of struct inode are of
type 'struct timespec' so you must initialize its elements explicitly.
from fs/cramfs/inode.c:

...
get_cramfs_inode(struct super_block *sb, struct cramfs_inode * cramfs_inode) {
        struct inode * inode = new_inode(sb);
        if (inode) {
                inode->i_mode = cramfs_inode->mode;
                inode->i_uid = cramfs_inode->uid;
                inode->i_size = cramfs_inode->size;
                inode->i_blocks = (cramfs_inode->size - 1) / 512 + 1;
                inode->i_blksize = PAGE_CACHE_SIZE;
                inode->i_gid = cramfs_inode->gid;
                inode->i_mtime = inode->i_atime = inode->i_ctime = 0;   
		...

taken from include/linux/fs.h:

struct inode {
...
        kdev_t                  i_rdev;
        loff_t                  i_size;
        struct timespec         i_atime;
        struct timespec         i_mtime;
        struct timespec         i_ctime;
        unsigned int            i_blkbits;
...

taken from include/linux/time.h:

struct timespec {
        time_t  tv_sec;         /* seconds */
        long    tv_nsec;        /* nanoseconds */
}; 


a trivial patch is available below and 
at http://manta.univ.gda.pl/~lazy/cramfs_2.5.66_xtime.patch


Michal Grzedzicki <lazy@manta.univ.gda.pl>



file cramfs_2.5.66_xtime.patch
________CUT BELOW________
--- linux-2.5.66_org/fs/cramfs/inode.c  Mon Mar 24 22:59:55 2003
+++ linux-2.5.66/fs/cramfs/inode.c      Tue Mar 25 22:15:49 2003
@@ -51,7 +51,8 @@
                inode->i_blocks = (cramfs_inode->size - 1) / 512 + 1;
                inode->i_blksize = PAGE_CACHE_SIZE;
                inode->i_gid = cramfs_inode->gid;
-               inode->i_mtime = inode->i_atime = inode->i_ctime = 0;
+               inode->i_mtime.tv_sec = inode->i_atime.tv_sec = inode->i_ctime.tv_sec = 0;
+               inode->i_mtime.tv_nsec = inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec = 0;
                inode->i_ino = CRAMINO(cramfs_inode);
                /* inode->i_nlink is left 1 - arguably wrong for directories,
                   but it's the best we can do without reading the directory

