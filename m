Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262214AbSKRLON>; Mon, 18 Nov 2002 06:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbSKRLON>; Mon, 18 Nov 2002 06:14:13 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25816 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262214AbSKRLOM>; Mon, 18 Nov 2002 06:14:12 -0500
Date: Mon, 18 Nov 2002 12:21:09 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] fix compile breakage in fs/ after nanosecond stat timefields patch
Message-ID: <20021118112108.GA5420@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

the patch below fixes the following compile errors in 2.5.48:

<--  snip  -->

..
  gcc -Wp,-MD,fs/adfs/.inode.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=inode -DKBUILD_MODNAME=adfs   -c -o fs/adfs/inode.o fs/adfs/inode.c
fs/adfs/inode.c: In function `adfs_adfs2unix_time':
fs/adfs/inode.c:188: incompatible types in return
make[2]: *** [fs/adfs/inode.o] Error 1
...
  gcc -Wp,-MD,fs/afs/.vlclient.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=vlclient -DKBUILD_MODNAME=kafs   -c -o fs/afs/vlclient.o fs/afs/vlclient.c
fs/afs/vlclient.c: In function `afs_rxvl_get_entry_by_id_async2':
fs/afs/vlclient.c:587: incompatible types in assignment
make[2]: *** [fs/afs/vlclient.o] Error 1
...
  gcc -Wp,-MD,fs/jffs2/.fs.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=fs -DKBUILD_MODNAME=jffs2   -c -o fs/jffs2/fs.o fs/jffs2/fs.c
fs/jffs2/fs.c: In function `jffs2_new_inode':
fs/jffs2/fs.c:257: incompatible types in assignment
make[2]: *** [fs/jffs2/fs.o] Error 1

<--  snip  -->


Please check whether the patch is correct.

TIA
Adrian


--- linux-2.5.48/fs/adfs/inode.c.old	2002-11-18 11:29:15.000000000 +0100
+++ linux-2.5.48/fs/adfs/inode.c	2002-11-18 11:30:43.000000000 +0100
@@ -185,7 +185,7 @@
 	unsigned int high, low;
 
 	if (ADFS_I(inode)->stamped == 0)
-		return CURRENT_TIME;
+		return get_seconds();
 
 	high = ADFS_I(inode)->loadaddr << 24;
 	low  = ADFS_I(inode)->execaddr;
--- linux-2.5.48/fs/afs/vlclient.c.old	2002-11-18 11:36:13.000000000 +0100
+++ linux-2.5.48/fs/afs/vlclient.c	2002-11-18 11:37:41.000000000 +0100
@@ -584,7 +584,7 @@
 #endif
 
 		/* success */
-		entry->ctime = CURRENT_TIME;
+		entry->ctime = get_seconds();
 		ret = 0;
 		goto done;
 	}
--- linux-2.5.48/fs/jffs2/fs.c.old	2002-11-18 11:49:23.000000000 +0100
+++ linux-2.5.48/fs/jffs2/fs.c	2002-11-18 11:55:43.000000000 +0100
@@ -253,7 +253,8 @@
 	inode->i_mode = ri->mode;
 	inode->i_gid = ri->gid;
 	inode->i_uid = ri->uid;
-	inode->i_atime = inode->i_ctime = inode->i_mtime = 
+	inode->i_atime.tv_sec = inode->i_ctime.tv_sec =
+		inode->i_mtime.tv_sec = 
 		ri->atime = ri->mtime = ri->ctime = get_seconds();
 	inode->i_blksize = PAGE_SIZE;
 	inode->i_blocks = 0;
