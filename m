Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262730AbSKROns>; Mon, 18 Nov 2002 09:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbSKROns>; Mon, 18 Nov 2002 09:43:48 -0500
Received: from chambertin.convergence.de ([212.84.236.2]:57615 "EHLO
	chambertin.convergence.de") by vger.kernel.org with ESMTP
	id <S262730AbSKROnp>; Mon, 18 Nov 2002 09:43:45 -0500
Message-ID: <3DD8FE44.4080607@convergence.de>
Date: Mon, 18 Nov 2002 15:50:44 +0100
From: Holger Waechtler <holger@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] fix compile breakage in fs/ after nanosecond stat
 timefields patch
References: <20021118112108.GA5420@fs.tum.de>
Content-Type: multipart/mixed;
 boundary="------------070209070806080206040402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070209070806080206040402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

below a patch for fs/devfs/base.c in order to follow the time convention 
changes.

Holger




Adrian Bunk wrote:
> Hi Andi,
> 
> the patch below fixes the following compile errors in 2.5.48:
> 
> <--  snip  -->
> 
> ..
>   gcc -Wp,-MD,fs/adfs/.inode.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=inode -DKBUILD_MODNAME=adfs   -c -o fs/adfs/inode.o fs/adfs/inode.c
> fs/adfs/inode.c: In function `adfs_adfs2unix_time':
> fs/adfs/inode.c:188: incompatible types in return
> make[2]: *** [fs/adfs/inode.o] Error 1
> ...
>   gcc -Wp,-MD,fs/afs/.vlclient.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=vlclient -DKBUILD_MODNAME=kafs   -c -o fs/afs/vlclient.o fs/afs/vlclient.c
> fs/afs/vlclient.c: In function `afs_rxvl_get_entry_by_id_async2':
> fs/afs/vlclient.c:587: incompatible types in assignment
> make[2]: *** [fs/afs/vlclient.o] Error 1
> ...
>   gcc -Wp,-MD,fs/jffs2/.fs.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=fs -DKBUILD_MODNAME=jffs2   -c -o fs/jffs2/fs.o fs/jffs2/fs.c
> fs/jffs2/fs.c: In function `jffs2_new_inode':
> fs/jffs2/fs.c:257: incompatible types in assignment
> make[2]: *** [fs/jffs2/fs.o] Error 1
> 
> <--  snip  -->
> 
> 
> Please check whether the patch is correct.
> 
> TIA
> Adrian
> 
> 
> --- linux-2.5.48/fs/adfs/inode.c.old	2002-11-18 11:29:15.000000000 +0100
> +++ linux-2.5.48/fs/adfs/inode.c	2002-11-18 11:30:43.000000000 +0100
> @@ -185,7 +185,7 @@
>  	unsigned int high, low;
>  
>  	if (ADFS_I(inode)->stamped == 0)
> -		return CURRENT_TIME;
> +		return get_seconds();
>  
>  	high = ADFS_I(inode)->loadaddr << 24;
>  	low  = ADFS_I(inode)->execaddr;
> --- linux-2.5.48/fs/afs/vlclient.c.old	2002-11-18 11:36:13.000000000 +0100
> +++ linux-2.5.48/fs/afs/vlclient.c	2002-11-18 11:37:41.000000000 +0100
> @@ -584,7 +584,7 @@
>  #endif
>  
>  		/* success */
> -		entry->ctime = CURRENT_TIME;
> +		entry->ctime = get_seconds();
>  		ret = 0;
>  		goto done;
>  	}
> --- linux-2.5.48/fs/jffs2/fs.c.old	2002-11-18 11:49:23.000000000 +0100
> +++ linux-2.5.48/fs/jffs2/fs.c	2002-11-18 11:55:43.000000000 +0100
> @@ -253,7 +253,8 @@
>  	inode->i_mode = ri->mode;
>  	inode->i_gid = ri->gid;
>  	inode->i_uid = ri->uid;
> -	inode->i_atime = inode->i_ctime = inode->i_mtime = 
> +	inode->i_atime.tv_sec = inode->i_ctime.tv_sec =
> +		inode->i_mtime.tv_sec = 
>  		ri->atime = ri->mtime = ri->ctime = get_seconds();
>  	inode->i_blksize = PAGE_SIZE;
>  	inode->i_blocks = 0;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--------------070209070806080206040402
Content-Type: text/plain;
 name="devfs-timepatch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="devfs-timepatch.diff"

--- fs/devfs/base.c-orig	2002-11-18 05:29:26.000000000 +0100
+++ fs/devfs/base.c	2002-11-18 15:35:45.000000000 +0100
@@ -799,9 +799,9 @@ struct symlink_type
 struct devfs_inode     /*  This structure is for "persistent" inode storage  */
 {
     struct dentry *dentry;
-    time_t atime;
-    time_t mtime;
-    time_t ctime;
+    struct timespec atime;
+    struct timespec mtime;
+    struct timespec ctime;
     unsigned int ino;            /*  Inode number as seen in the VFS         */
     uid_t uid;
     gid_t gid;
@@ -2509,9 +2509,12 @@ static int devfs_notify_change (struct d
     de->mode = inode->i_mode;
     de->inode.uid = inode->i_uid;
     de->inode.gid = inode->i_gid;
-    de->inode.atime = inode->i_atime.tv_sec;
-    de->inode.mtime = inode->i_mtime.tv_sec;
-    de->inode.ctime = inode->i_ctime.tv_sec;
+    de->inode.atime.tv_sec = inode->i_atime.tv_sec;
+    de->inode.atime.tv_nsec = inode->i_atime.tv_nsec;
+    de->inode.mtime.tv_sec = inode->i_mtime.tv_sec;
+    de->inode.mtime.tv_nsec = inode->i_mtime.tv_nsec;
+    de->inode.ctime.tv_sec = inode->i_ctime.tv_sec;
+    de->inode.ctime.tv_nsec = inode->i_ctime.tv_nsec;
     if ( ( iattr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID) ) &&
 	 !is_devfsd_or_child (fs_info) )
 	devfsd_notify_de (de, DEVFSD_NOTIFY_CHANGE, inode->i_mode,
@@ -2610,12 +2613,12 @@ static struct inode *_devfs_get_vfs_inod
     inode->i_mode = de->mode;
     inode->i_uid = de->inode.uid;
     inode->i_gid = de->inode.gid;
-    inode->i_atime.tv_sec = de->inode.atime;
-    inode->i_mtime.tv_sec = de->inode.mtime;
-    inode->i_ctime.tv_sec = de->inode.ctime;
-    inode->i_atime.tv_nsec = 0;
-    inode->i_mtime.tv_nsec = 0;
-    inode->i_ctime.tv_nsec = 0;
+    inode->i_atime.tv_sec = de->inode.atime.tv_sec;
+    inode->i_atime.tv_nsec = de->inode.atime.tv_nsec;
+    inode->i_mtime.tv_sec = de->inode.mtime.tv_sec;
+    inode->i_mtime.tv_nsec = de->inode.mtime.tv_nsec;
+    inode->i_ctime.tv_sec = de->inode.ctime.tv_sec;
+    inode->i_ctime.tv_nsec = de->inode.ctime.tv_nsec;
     DPRINTK (DEBUG_I_GET, "():   mode: 0%o  uid: %d  gid: %d\n",
 	     (int) inode->i_mode, (int) inode->i_uid, (int) inode->i_gid);
     return inode;

--------------070209070806080206040402--

