Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135362AbQL3Skq>; Sat, 30 Dec 2000 13:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135360AbQL3Ski>; Sat, 30 Dec 2000 13:40:38 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:4846 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S133087AbQL3SkU>;
	Sat, 30 Dec 2000 13:40:20 -0500
Date: Sat, 30 Dec 2000 13:09:45 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        "Peter J. Braam" <braam@cs.cmu.edu>, linux-fsdevel@vger.kernel.org
Subject: Re: test13-pre6
In-Reply-To: <Pine.LNX.4.10.10012291655530.869-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0012301249450.4082-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Dec 2000, Linus Torvalds wrote:

> > Oblock_super(): what the hell is wait_on_super() doing in fsync_file()?
> > It gives absolutely no warranties - ->write_super() can easily block, so
> > it looks very odd.
> 
> A lot of the superblock locking has been odd. It should probably be a
> lock_super() + unlock_super(). At least that's what sync_supers() does.

Yeah, that's what I've done, but I'm less than sure that we need anything
of that kind in the first place...

Anyway, under the "it works here" category: current state of sane-s_lock
patch. It will need further cleanup in fs/super.c, but IMO the current
form is already better than code in tree. Comments are more than welcome.

One note on the patch: sb->s_count is amount of extra references to superblock
(== not coming from vfsmounts) + 1 if there is a vfsmount over that superblock.
I.e. same scheme as we use for mm_struct. get_super() bumps the refcount,
put_super() decrements it and frees the superblock if counter hits zero.
add_vfsmnt() bumps refcount if we are adding the first vfsmount.
remove_vfsmnt() bumps refcount _unless_ we are removing the last vfsmount.
I.e. remove_vfsmnt() + put_super() always does the right thing.

List of superblocks contains only "active" ones. kill_super() takes the
superblock out of the list. get_empty_super() became simpler - it doesn't
bother searching the list for "reusable" ones. List is still BKL-protected;
I'll fix that.

We got _two_ sempaphores - one for get_super()/umount() synchronization
(->s_umount) and another for lock_super()/unlock_super() (->s_lock).
I would expect the latter to go into the per-fs part - all synchronization
that is interesting from VFS point of view is done by ->s_umount. The
reason why I've kept s_lock at all is simple - I don't want to mix
changes in fs-private synchronization with the fs-independent stuff.

Patch is against -pre6 and it seems to working here. Comments (and help
in testing) are welcome.

Peter, if you could remind me the uses of get_empty_super() and friends
in your code I would be very grateful - I seriously suspect that we
could use better interface in that area.
							Cheers,
								Al
Patch follows:

diff -urN rc13-pre6/arch/parisc/hpux/sys_hpux.c rc13-pre6-s_lock/arch/parisc/hpux/sys_hpux.c
--- rc13-pre6/arch/parisc/hpux/sys_hpux.c	Tue Dec 12 02:10:00 2000
+++ rc13-pre6-s_lock/arch/parisc/hpux/sys_hpux.c	Sat Dec 30 09:17:25 2000
@@ -109,9 +109,11 @@
 
 	lock_kernel();
 	s = get_super(to_kdev_t(dev));
+	unlock_kernel();
 	if (s == NULL)
 		goto out;
 	err = vfs_statfs(s, &sbuf);
+	put_super(s);
 	if (err)
 		goto out;
 
@@ -124,7 +126,6 @@
 	/* Changed to hpux_ustat:  */
 	err = copy_to_user(ubuf,&tmp,sizeof(struct hpux_ustat)) ? -EFAULT : 0;
 out:
-	unlock_kernel();
 	return err;
 }
 
diff -urN rc13-pre6/arch/sparc/kernel/sys_sunos.c rc13-pre6-s_lock/arch/sparc/kernel/sys_sunos.c
--- rc13-pre6/arch/sparc/kernel/sys_sunos.c	Sun Aug 13 16:56:28 2000
+++ rc13-pre6-s_lock/arch/sparc/kernel/sys_sunos.c	Sat Dec 30 09:17:25 2000
@@ -620,8 +620,6 @@
 };
 
 
-extern dev_t get_unnamed_dev(void);
-extern void put_unnamed_dev(dev_t);
 extern asmlinkage int sys_connect(int fd, struct sockaddr *uservaddr, int addrlen);
 extern asmlinkage int sys_socket(int family, int type, int protocol);
 extern asmlinkage int sys_bind(int fd, struct sockaddr *umyaddr, int addrlen);
diff -urN rc13-pre6/arch/sparc64/kernel/sys_sunos32.c rc13-pre6-s_lock/arch/sparc64/kernel/sys_sunos32.c
--- rc13-pre6/arch/sparc64/kernel/sys_sunos32.c	Tue Dec 12 02:10:04 2000
+++ rc13-pre6-s_lock/arch/sparc64/kernel/sys_sunos32.c	Sat Dec 30 09:17:25 2000
@@ -580,8 +580,6 @@
 	char       *netname;   /* server's netname */
 };
 
-extern dev_t get_unnamed_dev(void);
-extern void put_unnamed_dev(dev_t);
 extern asmlinkage int sys_mount(char *, char *, char *, unsigned long, void *);
 extern asmlinkage int sys_connect(int fd, struct sockaddr *uservaddr, int addrlen);
 extern asmlinkage int sys_socket(int family, int type, int protocol);
diff -urN rc13-pre6/drivers/acorn/block/mfmhd.c rc13-pre6-s_lock/drivers/acorn/block/mfmhd.c
--- rc13-pre6/drivers/acorn/block/mfmhd.c	Wed Nov 29 19:28:26 2000
+++ rc13-pre6-s_lock/drivers/acorn/block/mfmhd.c	Sat Dec 30 09:17:26 2000
@@ -1486,13 +1486,8 @@
 	for (i = maxp - 1; i >= 0; i--) {
 		int minor = start + i;
 		kdev_t devi = MKDEV(MAJOR_NR, minor);
-		struct super_block *sb = get_super(devi);
-
-		sync_dev (devi);
-		if (sb)
-			invalidate_inodes (sb);
-		invalidate_buffers (devi);
 
+		invalidate_dev(devi, 1);
 		mfm_gendisk.part[minor].start_sect = 0;
 		mfm_gendisk.part[minor].nr_sects = 0;
 	}
diff -urN rc13-pre6/drivers/block/DAC960.c rc13-pre6-s_lock/drivers/block/DAC960.c
--- rc13-pre6/drivers/block/DAC960.c	Tue Dec 12 02:10:05 2000
+++ rc13-pre6-s_lock/drivers/block/DAC960.c	Sat Dec 30 09:17:26 2000
@@ -4990,16 +4990,12 @@
 						      PartitionNumber);
 	  int MinorNumber = DAC960_MinorNumber(LogicalDriveNumber,
 					       PartitionNumber);
-	  SuperBlock_T *SuperBlock = get_super(Device);
 	  if (Controller->GenericDiskInfo.part[MinorNumber].nr_sects == 0)
 	    continue;
 	  /*
 	    Flush all changes and invalidate buffered state.
 	  */
-	  sync_dev(Device);
-	  if (SuperBlock != NULL)
-	    invalidate_inodes(SuperBlock);
-	  invalidate_buffers(Device);
+	  invalidate_dev(Device, 1);
 	  /*
 	    Clear existing partition sizes.
 	  */
diff -urN rc13-pre6/drivers/block/acsi.c rc13-pre6-s_lock/drivers/block/acsi.c
--- rc13-pre6/drivers/block/acsi.c	Tue Dec 12 02:10:05 2000
+++ rc13-pre6-s_lock/drivers/block/acsi.c	Sat Dec 30 09:17:26 2000
@@ -1887,12 +1887,7 @@
 	for( i = max_p - 1; i >= 0 ; i-- ) {
 		if (gdev->part[start + i].nr_sects != 0) {
 			kdev_t devp = MKDEV(MAJOR_NR, start + i);
-			struct super_block *sb = get_super(devp);
-
-			fsync_dev(devp);
-			if (sb)
-				invalidate_inodes(sb);
-			invalidate_buffers(devp);
+			invalidate_dev(devp, 2);
 			gdev->part[start + i].nr_sects = 0;
 		}
 		gdev->part[start+i].start_sect = 0;
diff -urN rc13-pre6/drivers/block/amiflop.c rc13-pre6-s_lock/drivers/block/amiflop.c
--- rc13-pre6/drivers/block/amiflop.c	Wed Nov 29 19:28:35 2000
+++ rc13-pre6-s_lock/drivers/block/amiflop.c	Sat Dec 30 09:17:26 2000
@@ -1490,7 +1490,6 @@
 {
 	int drive = inode->i_rdev & 3;
 	static struct floppy_struct getprm;
-	struct super_block * sb;
 
 	switch(cmd){
 	case HDIO_GETGEO:
@@ -1540,10 +1539,7 @@
 		break;
 	case FDFMTEND:
 		floppy_off(drive);
-		sb = get_super(inode->i_rdev);
-		if (sb)
-			invalidate_inodes(sb);
-		invalidate_buffers(inode->i_rdev);
+		invalidate_dev(inode->i_rdev, 0);
 		break;
 	case FDGETPRM:
 		memset((void *)&getprm, 0, sizeof (getprm));
@@ -1677,9 +1673,6 @@
 
 static int floppy_release(struct inode * inode, struct file * filp)
 {
-#ifdef DEBUG
-	struct super_block * sb;
-#endif
 	int drive = MINOR(inode->i_rdev) & 3;
 
 	if (unit[drive].dirty == 1) {
diff -urN rc13-pre6/drivers/block/blkpg.c rc13-pre6-s_lock/drivers/block/blkpg.c
--- rc13-pre6/drivers/block/blkpg.c	Mon Mar 20 01:36:47 2000
+++ rc13-pre6-s_lock/drivers/block/blkpg.c	Sat Dec 30 09:17:26 2000
@@ -157,8 +157,7 @@
 
 	/* partition in use? Incomplete check for now. */
 	devp = MKDEV(MAJOR(dev), minor);
-	if (get_super(devp) ||		/* mounted? */
-	    is_swap_partition(devp))
+	if (is_mounted(devp) || is_swap_partition(devp))
 		return -EBUSY;
 
 	/* all seems OK */
diff -urN rc13-pre6/drivers/block/cciss.c rc13-pre6-s_lock/drivers/block/cciss.c
--- rc13-pre6/drivers/block/cciss.c	Wed Nov 29 21:36:25 2000
+++ rc13-pre6-s_lock/drivers/block/cciss.c	Sat Dec 30 09:17:26 2000
@@ -707,10 +707,7 @@
         for(i=max_p; i>=0; i--) {
                 int minor = start+i;
                 kdev_t devi = MKDEV(MAJOR_NR + ctlr, minor);
-                struct super_block *sb = get_super(devi);
-                sync_dev(devi);
-                if (sb) invalidate_inodes(sb);
-                invalidate_buffers(devi);
+		invalidate_dev(devi, 1);
                 gdev->part[minor].start_sect = 0;
                 gdev->part[minor].nr_sects = 0;
 
diff -urN rc13-pre6/drivers/block/cpqarray.c rc13-pre6-s_lock/drivers/block/cpqarray.c
--- rc13-pre6/drivers/block/cpqarray.c	Wed Nov 29 21:42:57 2000
+++ rc13-pre6-s_lock/drivers/block/cpqarray.c	Sat Dec 30 09:17:26 2000
@@ -1571,10 +1571,7 @@
 	for(i=max_p; i>=0; i--) {
 		int minor = start+i;
 		kdev_t devi = MKDEV(MAJOR_NR + ctlr, minor);
-		struct super_block *sb = get_super(devi);
-		sync_dev(devi);
-		if (sb) invalidate_inodes(sb);
-		invalidate_buffers(devi);
+		invalidate_dev(devi, 1);
 		gdev->part[minor].start_sect = 0;	
 		gdev->part[minor].nr_sects = 0;	
 
diff -urN rc13-pre6/drivers/block/paride/pd.c rc13-pre6-s_lock/drivers/block/paride/pd.c
--- rc13-pre6/drivers/block/paride/pd.c	Tue Jul 25 09:23:16 2000
+++ rc13-pre6-s_lock/drivers/block/paride/pd.c	Sat Dec 30 09:17:26 2000
@@ -593,8 +593,6 @@
         long flags;
         kdev_t devp;
 
-	struct super_block *sb;
-
         unit = DEVICE_NR(dev);
         if ((unit >= PD_UNITS) || (!PD.present)) return -ENODEV;
 
@@ -610,12 +608,7 @@
         for (p=(PD_PARTNS-1);p>=0;p--) {
 		minor = p + unit*PD_PARTNS;
                 devp = MKDEV(MAJOR_NR, minor);
-                fsync_dev(devp);
-
-                sb = get_super(devp);
-                if (sb) invalidate_inodes(sb);
-
-                invalidate_buffers(devp);
+		invalidate_dev(devp, 2);
                 pd_hd[minor].start_sect = 0;
                 pd_hd[minor].nr_sects = 0;
         }
diff -urN rc13-pre6/drivers/block/ps2esdi.c rc13-pre6-s_lock/drivers/block/ps2esdi.c
--- rc13-pre6/drivers/block/ps2esdi.c	Mon Jul 31 16:33:53 2000
+++ rc13-pre6-s_lock/drivers/block/ps2esdi.c	Sat Dec 30 09:17:26 2000
@@ -1180,12 +1180,7 @@
 	     partition >= 0; partition--) {
 		int minor = (start | partition);
 		kdev_t devp = MKDEV(MAJOR_NR, minor);
-		struct super_block * sb = get_super(devp);
-		
-		sync_dev(devp);
-		if (sb)
-			invalidate_inodes(sb);
-		invalidate_buffers(devp);
+		invalidate_dev(devp, 1);
 		ps2esdi_gendisk.part[start + partition].start_sect = 0;
 		ps2esdi_gendisk.part[start + partition].nr_sects = 0;
 	}
diff -urN rc13-pre6/drivers/block/xd.c rc13-pre6-s_lock/drivers/block/xd.c
--- rc13-pre6/drivers/block/xd.c	Wed Nov 29 21:36:26 2000
+++ rc13-pre6-s_lock/drivers/block/xd.c	Sat Dec 30 09:17:26 2000
@@ -394,12 +394,7 @@
 	for (partition = xd_gendisk.max_p - 1; partition >= 0; partition--) {
 		int minor = (start | partition);
 		kdev_t devp = MKDEV(MAJOR_NR, minor);
-		struct super_block * sb = get_super(devp);
-		
-		sync_dev(devp);
-		if (sb)
-			invalidate_inodes(sb);
-		invalidate_buffers(devp);
+		invalidate_dev(devp, 1);
 		xd_gendisk.part[minor].start_sect = 0;
 		xd_gendisk.part[minor].nr_sects = 0;
 	};
diff -urN rc13-pre6/drivers/char/raw.c rc13-pre6-s_lock/drivers/char/raw.c
--- rc13-pre6/drivers/char/raw.c	Wed Nov 29 19:28:41 2000
+++ rc13-pre6-s_lock/drivers/char/raw.c	Sat Dec 30 09:17:26 2000
@@ -103,7 +103,7 @@
 	 */
 	
 	sector_size = 512;
-	if (get_super(rdev) != NULL) {
+	if (is_mounted(rdev)) {
 		if (blksize_size[MAJOR(rdev)])
 			sector_size = blksize_size[MAJOR(rdev)][MINOR(rdev)];
 	} else {
diff -urN rc13-pre6/drivers/i2o/i2o_block.c rc13-pre6-s_lock/drivers/i2o/i2o_block.c
--- rc13-pre6/drivers/i2o/i2o_block.c	Wed Nov 29 21:43:05 2000
+++ rc13-pre6-s_lock/drivers/i2o/i2o_block.c	Sat Dec 30 09:17:27 2000
@@ -900,12 +900,7 @@
 	{
 		int m = minor+i;
 		kdev_t d = MKDEV(MAJOR_NR, m);
-		struct super_block *sb = get_super(d);
-		
-		sync_dev(d);
-		if(sb)
-			invalidate_inodes(sb);
-		invalidate_buffers(d);
+		invalidate_dev(d, 1);
 		i2ob_gendisk.part[m].start_sect = 0;
 		i2ob_gendisk.part[m].nr_sects = 0;
 	}
diff -urN rc13-pre6/drivers/ide/hd.c rc13-pre6-s_lock/drivers/ide/hd.c
--- rc13-pre6/drivers/ide/hd.c	Wed Nov 29 21:43:06 2000
+++ rc13-pre6-s_lock/drivers/ide/hd.c	Sat Dec 30 09:17:27 2000
@@ -881,12 +881,7 @@
 	for (i=max_p - 1; i >=0 ; i--) {
 		int minor = start + i;
 		kdev_t devi = MKDEV(MAJOR_NR, minor);
-		struct super_block *sb = get_super(devi); 
-
-		sync_dev(devi);
-		if (sb)
-			invalidate_inodes(sb);
-		invalidate_buffers(devi);
+		invalidate_dev(devi, 1);
 		gdev->part[minor].start_sect = 0;
 		gdev->part[minor].nr_sects = 0;
 	}
diff -urN rc13-pre6/drivers/ide/ide.c rc13-pre6-s_lock/drivers/ide/ide.c
--- rc13-pre6/drivers/ide/ide.c	Tue Dec 12 02:10:10 2000
+++ rc13-pre6-s_lock/drivers/ide/ide.c	Sat Dec 30 09:17:27 2000
@@ -1761,11 +1761,7 @@
 	for (p = 0; p < (1<<PARTN_BITS); ++p) {
 		if (drive->part[p].nr_sects > 0) {
 			kdev_t devp = MKDEV(major, minor+p);
-			struct super_block * sb = get_super(devp);
-			fsync_dev          (devp);
-			if (sb)
-				invalidate_inodes(sb);
-			invalidate_buffers (devp);
+			invalidate_dev(devp, 2);
 			set_blocksize(devp, 1024);
 		}
 		drive->part[p].start_sect = 0;
@@ -1982,9 +1978,7 @@
 		for (p = 0; p < (1<<PARTN_BITS); ++p) {
 			if (drive->part[p].nr_sects > 0) {
 				kdev_t devp = MKDEV(hwif->major, minor+p);
-				struct super_block * sb = get_super(devp);
-				if (sb) invalidate_inodes(sb);
-				invalidate_buffers (devp);
+				invalidate_dev(devp, 0);
 			}
 		}
 #ifdef CONFIG_PROC_FS
diff -urN rc13-pre6/drivers/md/md.c rc13-pre6-s_lock/drivers/md/md.c
--- rc13-pre6/drivers/md/md.c	Tue Dec 12 02:10:15 2000
+++ rc13-pre6-s_lock/drivers/md/md.c	Sat Dec 30 09:17:27 2000
@@ -1088,7 +1088,7 @@
 	}
 	memset(rdev, 0, sizeof(*rdev));
 
-	if (get_super(newdev)) {
+	if (is_mounted(newdev)) {
 		printk("md: can not import %s, has active inodes!\n",
 			partition_name(newdev));
 		err = -EBUSY;
@@ -1726,7 +1726,7 @@
  	}
  
  	/* this shouldn't be needed as above would have fired */
-	if (!ro && get_super(dev)) {
+	if (!ro && is_mounted(dev)) {
 		printk (STILL_MOUNTED, mdidx(mddev));
 		OUT(-EBUSY);
 	}
diff -urN rc13-pre6/drivers/mtd/ftl.c rc13-pre6-s_lock/drivers/mtd/ftl.c
--- rc13-pre6/drivers/mtd/ftl.c	Tue Dec 12 02:10:19 2000
+++ rc13-pre6-s_lock/drivers/mtd/ftl.c	Sat Dec 30 09:17:27 2000
@@ -915,9 +915,6 @@
 
 static release_t ftl_close(struct inode *inode, struct file *file)
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
-    struct super_block *sb = get_super(inode->i_rdev);
-#endif
     int minor = MINOR(inode->i_rdev);
     partition_t *part = myparts[minor >> 4];
     int i;
@@ -925,11 +922,7 @@
     DEBUG(0, "ftl_cs: ftl_close(%d)\n", minor);
 
     /* Flush all writes */
-    fsync_dev(inode->i_rdev);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
-    if (sb) invalidate_inodes(sb);
-#endif
-    invalidate_buffers(inode->i_rdev);
+    invalidate_dev(inode->i_rdev, 2);
 
     /* Wait for any pending erase operations to complete */
     if (part->mtd->sync)
diff -urN rc13-pre6/drivers/mtd/mtdblock.c rc13-pre6-s_lock/drivers/mtd/mtdblock.c
--- rc13-pre6/drivers/mtd/mtdblock.c	Sat Dec 30 07:37:35 2000
+++ rc13-pre6-s_lock/drivers/mtd/mtdblock.c	Sat Dec 30 09:17:27 2000
@@ -355,19 +355,12 @@
 {
 	int dev;
 	struct mtdblk_dev *mtdblk;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
-	struct super_block * sb = get_super(inode->i_rdev);
-#endif
    	DEBUG(MTD_DEBUG_LEVEL1, "mtdblock_release\n");
 
 	if (inode == NULL)
 		release_return(-ENODEV);
    
-	fsync_dev(inode->i_rdev);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
-	if (sb) invalidate_inodes(sb);
-#endif
-	invalidate_buffers(inode->i_rdev);
+	invalidate_dev(inode->i_rdev, 2);
 
 	dev = MINOR(inode->i_rdev);
 	mtdblk = mtdblks[dev];
diff -urN rc13-pre6/drivers/mtd/nftl.c rc13-pre6-s_lock/drivers/mtd/nftl.c
--- rc13-pre6/drivers/mtd/nftl.c	Tue Dec 12 02:10:19 2000
+++ rc13-pre6-s_lock/drivers/mtd/nftl.c	Sat Dec 30 09:17:28 2000
@@ -997,17 +997,13 @@
 
 static int nftl_release(struct inode *inode, struct file *fp)
 {
-	struct super_block *sb = get_super(inode->i_rdev);
 	struct NFTLrecord *thisNFTL;
 
 	thisNFTL = NFTLs[MINOR(inode->i_rdev) / 16];
 
 	DEBUG(MTD_DEBUG_LEVEL2, "NFTL_release\n");
 
-	fsync_dev(inode->i_rdev);
-	if (sb)
-		invalidate_inodes(sb);
-	invalidate_buffers(inode->i_rdev);
+	invalidate_dev(inode->i_rdev, 2);
 
 	if (thisNFTL->mtd->sync)
 		thisNFTL->mtd->sync(thisNFTL->mtd);
diff -urN rc13-pre6/drivers/scsi/sd.c rc13-pre6-s_lock/drivers/scsi/sd.c
--- rc13-pre6/drivers/scsi/sd.c	Wed Nov 29 19:29:16 2000
+++ rc13-pre6-s_lock/drivers/scsi/sd.c	Sat Dec 30 09:17:28 2000
@@ -1262,11 +1262,7 @@
 	for (i = max_p - 1; i >= 0; i--) {
 		int index = start + i;
 		kdev_t devi = MKDEV_SD_PARTITION(index);
-		struct super_block *sb = get_super(devi);
-		sync_dev(devi);
-		if (sb)
-			invalidate_inodes(sb);
-		invalidate_buffers(devi);
+		invalidate_dev(devi, 1);
 		sd_gendisks->part[index].start_sect = 0;
 		sd_gendisks->part[index].nr_sects = 0;
 		/*
@@ -1315,11 +1311,7 @@
 			for (j = max_p - 1; j >= 0; j--) {
 				int index = start + j;
 				kdev_t devi = MKDEV_SD_PARTITION(index);
-				struct super_block *sb = get_super(devi);
-				sync_dev(devi);
-				if (sb)
-					invalidate_inodes(sb);
-				invalidate_buffers(devi);
+				invalidate_dev(devi, 1);
 				sd_gendisks->part[index].start_sect = 0;
 				sd_gendisks->part[index].nr_sects = 0;
 				sd_sizes[index] = 0;
diff -urN rc13-pre6/drivers/scsi/sr.c rc13-pre6-s_lock/drivers/scsi/sr.c
--- rc13-pre6/drivers/scsi/sr.c	Sat Dec 30 07:37:41 2000
+++ rc13-pre6-s_lock/drivers/scsi/sr.c	Sat Dec 30 09:17:28 2000
@@ -874,15 +874,11 @@
 	for (cpnt = scsi_CDs, i = 0; i < sr_template.dev_max; i++, cpnt++)
 		if (cpnt->device == SDp) {
 			kdev_t devi = MKDEV(MAJOR_NR, i);
-			struct super_block *sb = get_super(devi);
-
 			/*
 			 * Since the cdrom is read-only, no need to sync the device.
 			 * We should be kind to our buffer cache, however.
 			 */
-			if (sb)
-				invalidate_inodes(sb);
-			invalidate_buffers(devi);
+			invalidate_dev(devi, 0);
 
 			/*
 			 * Reset things back to a sane state so that one can re-load a new
diff -urN rc13-pre6/drivers/sound/via82cxxx_audio.c rc13-pre6-s_lock/drivers/sound/via82cxxx_audio.c
--- rc13-pre6/drivers/sound/via82cxxx_audio.c	Wed Nov 29 21:37:13 2000
+++ rc13-pre6-s_lock/drivers/sound/via82cxxx_audio.c	Sat Dec 30 09:17:28 2000
@@ -1727,20 +1727,8 @@
 }
 
 
-#ifndef VM_RESERVE
-static int via_mm_swapout (struct page *page, struct file *filp)
-{
-	return 0;
-}
-#endif /* VM_RESERVE */
-
-
 struct vm_operations_struct via_mm_ops = {
 	nopage:		via_mm_nopage,
-
-#ifndef VM_RESERVE
-	swapout:	via_mm_swapout,
-#endif
 };
 
 
@@ -1789,9 +1777,7 @@
 	vma->vm_ops = &via_mm_ops;
 	vma->vm_private_data = card;
 
-#ifdef VM_RESERVE
-	vma->vm_flags |= VM_RESERVE;
-#endif
+	vma->vm_flags |= VM_RESERVED;
 
 	if (rd)
 		card->ch_in.is_mapped = 1;
diff -urN rc13-pre6/fs/block_dev.c rc13-pre6-s_lock/fs/block_dev.c
--- rc13-pre6/fs/block_dev.c	Wed Nov 29 19:29:31 2000
+++ rc13-pre6-s_lock/fs/block_dev.c	Sat Dec 30 09:17:28 2000
@@ -576,8 +576,11 @@
 		bdevname(dev));
 
 	sb = get_super(dev);
-	if (sb && invalidate_inodes(sb))
-		printk("VFS: busy inodes on changed media.\n");
+	if (sb) {
+		if (invalidate_inodes(sb))
+			printk("VFS: busy inodes on changed media.\n");
+		put_super(sb);
+	}
 
 	destroy_buffers(dev);
 
diff -urN rc13-pre6/fs/buffer.c rc13-pre6-s_lock/fs/buffer.c
--- rc13-pre6/fs/buffer.c	Sat Dec 30 07:37:45 2000
+++ rc13-pre6-s_lock/fs/buffer.c	Sat Dec 30 09:17:28 2000
@@ -337,9 +337,10 @@
 
 	/* sync the superblock to buffers */
 	sb = inode->i_sb;
-	wait_on_super(sb);
+	lock_super(sb);
 	if (sb->s_op && sb->s_op->write_super)
 		sb->s_op->write_super(sb);
+	unlock_super(sb);
 
 	/* .. finally sync the buffers to disk */
 	dev = inode->i_dev;
@@ -677,6 +678,19 @@
 	spin_unlock(&lru_list_lock);
 	if (slept)
 		goto retry;
+}
+
+void invalidate_dev(kdev_t dev, int sync_flag)
+{
+	struct super_block *sb = get_super(dev);
+	if (sync_flag == 1)
+		sync_dev(dev);
+	else if (sync_flag == 2)
+		fsync_dev(dev);
+	if (sb)
+		invalidate_inodes(sb);
+	put_super(sb);
+	invalidate_buffers(dev);
 }
 
 void set_blocksize(kdev_t dev, int size)
diff -urN rc13-pre6/fs/coda/dir.c rc13-pre6-s_lock/fs/coda/dir.c
--- rc13-pre6/fs/coda/dir.c	Sat Dec 30 07:37:45 2000
+++ rc13-pre6-s_lock/fs/coda/dir.c	Sat Dec 30 09:17:28 2000
@@ -557,8 +557,8 @@
                 return -ENXIO;
         }
                 
-        *ind = NULL;
         *ind = iget(sbptr, ino);
+	put_super(sbptr);
 
         if ( *ind == NULL ) {
 		printk("coda_inode_grab: iget(dev: %d, ino: %ld) "
diff -urN rc13-pre6/fs/coda/inode.c rc13-pre6-s_lock/fs/coda/inode.c
--- rc13-pre6/fs/coda/inode.c	Sat Dec 30 07:37:45 2000
+++ rc13-pre6-s_lock/fs/coda/inode.c	Sat Dec 30 09:17:28 2000
@@ -97,7 +97,6 @@
 	struct coda_sb_info *sbi = NULL;
 	struct venus_comm *vc = NULL;
         ViceFid fid;
-	kdev_t dev = sb->s_dev;
         int error;
 	int idx;
 	ENTRY;
@@ -139,7 +138,6 @@
         sb->s_blocksize = 1024;	/* XXXXX  what do we put here?? */
         sb->s_blocksize_bits = 10;
         sb->s_magic = CODA_SUPER_MAGIC;
-        sb->s_dev = dev;
         sb->s_op = &coda_super_operations;
 
 	/* get root fid from Venus: this needs the root inode */
diff -urN rc13-pre6/fs/devfs/base.c rc13-pre6-s_lock/fs/devfs/base.c
--- rc13-pre6/fs/devfs/base.c	Wed Nov 29 21:44:16 2000
+++ rc13-pre6-s_lock/fs/devfs/base.c	Sat Dec 30 09:17:28 2000
@@ -2166,8 +2166,11 @@
     printk ( KERN_DEBUG "VFS: Disk change detected on device %s\n",
 	     kdevname (dev) );
     sb = get_super (dev);
-    if ( sb && invalidate_inodes (sb) )
-	printk("VFS: busy inodes on changed media..\n");
+    if (sb) {
+	if (invalidate_inodes (sb))
+		printk("VFS: busy inodes on changed media..\n");
+	put_super(sb);
+    }
     invalidate_buffers (dev);
     /*  Ugly hack to disable messages about unable to read partition table  */
     tmp = warn_no_part;
diff -urN rc13-pre6/fs/dquot.c rc13-pre6-s_lock/fs/dquot.c
--- rc13-pre6/fs/dquot.c	Tue Dec 12 02:10:42 2000
+++ rc13-pre6-s_lock/fs/dquot.c	Sat Dec 30 09:17:29 2000
@@ -326,7 +326,7 @@
         memset(&dquot->dq_dqb, 0, sizeof(struct dqblk));
 }
 
-void invalidate_dquots(kdev_t dev, short type)
+static void invalidate_dquots(struct super_block *sb, short type)
 {
 	struct dquot *dquot, *next;
 	int need_restart;
@@ -336,12 +336,10 @@
 	need_restart = 0;
 	while ((dquot = next) != NULL) {
 		next = dquot->dq_next;
-		if (dquot->dq_dev != dev)
+		if (dquot->dq_sb != sb)
 			continue;
 		if (dquot->dq_type != type)
 			continue;
-		if (!dquot->dq_sb)	/* Already invalidated entry? */
-			continue;
 		if (dquot->dq_flags & DQ_LOCKED) {
 			__wait_on_dquot(dquot);
 
@@ -350,12 +348,10 @@
 			/*
 			 * Make sure it's still the same dquot.
 			 */
-			if (dquot->dq_dev != dev)
+			if (dquot->dq_sb != sb)
 				continue;
 			if (dquot->dq_type != type)
 				continue;
-			if (!dquot->dq_sb)
-				continue;
 		}
 		/*
 		 *  Because inodes needn't to be the only holders of dquot
@@ -1390,7 +1386,7 @@
 }
 
 /* Function in inode.c - remove pointers to dquots in icache */
-extern void remove_dquot_ref(kdev_t, short);
+extern void remove_dquot_ref(struct super_block *, short);
 
 /*
  * Turn quota off on a device. type == -1 ==> quotaoff for all types (umount)
@@ -1415,8 +1411,8 @@
 		reset_enable_flags(dqopt, cnt);
 
 		/* Note: these are blocking operations */
-		remove_dquot_ref(sb->s_dev, cnt);
-		invalidate_dquots(sb->s_dev, cnt);
+		remove_dquot_ref(sb, cnt);
+		invalidate_dquots(sb, cnt);
 
 		/* Wait for any pending IO - remove me as soon as invalidate is more polite */
 		down(&dqopt->dqio_sem);
@@ -1604,6 +1600,8 @@
 	if (sb && sb_has_quota_enabled(sb, type))
 		ret = set_dqblk(sb, id, type, flags, (struct dqblk *) addr);
 out:
+	if (sb)
+		put_super(sb);
 	unlock_kernel();
 	return ret;
 }
diff -urN rc13-pre6/fs/ext2/super.c rc13-pre6-s_lock/fs/ext2/super.c
--- rc13-pre6/fs/ext2/super.c	Sat Dec 30 07:37:46 2000
+++ rc13-pre6-s_lock/fs/ext2/super.c	Sat Dec 30 09:17:29 2000
@@ -75,9 +75,6 @@
 	va_start (args, fmt);
 	vsprintf (error_buf, fmt, args);
 	va_end (args);
-	/* this is to prevent panic from syncing this filesystem */
-	if (sb->s_lock)
-		sb->s_lock=0;
 	sb->s_flags |= MS_RDONLY;
 	panic ("EXT2-fs panic (device %s): %s: %s\n",
 	       bdevname(sb->s_dev), function, error_buf);
diff -urN rc13-pre6/fs/inode.c rc13-pre6-s_lock/fs/inode.c
--- rc13-pre6/fs/inode.c	Sat Dec 30 07:37:47 2000
+++ rc13-pre6-s_lock/fs/inode.c	Sat Dec 30 09:17:29 2000
@@ -1002,14 +1002,13 @@
 void put_dquot_list(struct list_head *);
 int remove_inode_dquot_ref(struct inode *, short, struct list_head *);
 
-void remove_dquot_ref(kdev_t dev, short type)
+void remove_dquot_ref(struct super_block *sb, short type)
 {
-	struct super_block *sb = get_super(dev);
 	struct inode *inode;
 	struct list_head *act_head;
 	LIST_HEAD(tofree_head);
 
-	if (!sb || !sb->dq_op)
+	if (!sb->dq_op)
 		return;	/* nothing to do */
 
 	/* We have to be protected against other CPUs */
diff -urN rc13-pre6/fs/jffs/inode-v23.c rc13-pre6-s_lock/fs/jffs/inode-v23.c
--- rc13-pre6/fs/jffs/inode-v23.c	Sat Dec 30 07:37:48 2000
+++ rc13-pre6-s_lock/fs/jffs/inode-v23.c	Sat Dec 30 09:17:29 2000
@@ -159,7 +159,6 @@
 
 	D1(printk (KERN_NOTICE "jffs_put_super(): Successfully waited on thread.\n"));
 
-	sb->s_dev = 0;
 	jffs_cleanup_control((struct jffs_control *)sb->u.generic_sbp);
 	D1(printk(KERN_NOTICE "JFFS: Successfully unmounted device %s.\n",
 	       kdevname(dev)));
diff -urN rc13-pre6/fs/super.c rc13-pre6-s_lock/fs/super.c
--- rc13-pre6/fs/super.c	Tue Dec 12 02:10:46 2000
+++ rc13-pre6-s_lock/fs/super.c	Sat Dec 30 12:03:30 2000
@@ -41,14 +41,6 @@
 #define __NO_VERSION__
 #include <linux/module.h>
 
-/*
- * We use a semaphore to synchronize all mount/umount
- * activity - imagine the mess if we have a race between
- * unmounting a filesystem and re-mounting it (or something
- * else).
- */
-static DECLARE_MUTEX(mount_sem);
-
 extern void wait_for_keypress(void);
 
 extern int root_mountflags;
@@ -346,6 +338,8 @@
 		INIT_LIST_HEAD(&mnt->mnt_clash);
 	}
 	INIT_LIST_HEAD(&mnt->mnt_mounts);
+	if (list_empty(&sb->s_mounts))
+		atomic_inc(&sb->s_count);
 	list_add(&mnt->mnt_instances, &sb->s_mounts);
 	list_add(&mnt->mnt_list, vfsmntlist.prev);
 	spin_unlock(&dcache_lock);
@@ -411,6 +405,8 @@
 static void remove_vfsmnt(struct vfsmount *mnt)
 {
 	/* First of all, remove it from all lists */
+	if (mnt->mnt_instances.next != mnt->mnt_instances.prev)
+		atomic_inc(&mnt->mnt_sb->s_count);
 	list_del(&mnt->mnt_instances);
 	list_del(&mnt->mnt_clash);
 	list_del(&mnt->mnt_list);
@@ -579,27 +575,11 @@
 #undef FREEROOM
 }
 
-/**
- *	__wait_on_super	- wait on a superblock
- *	@sb: superblock to wait on
- *
- *	Waits for a superblock to become unlocked and then returns. It does
- *	not take the lock. This is an internal function. See wait_on_super().
- */
- 
-void __wait_on_super(struct super_block * sb)
+void put_super(struct super_block *sb)
 {
-	DECLARE_WAITQUEUE(wait, current);
-
-	add_wait_queue(&sb->s_wait, &wait);
-repeat:
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	if (sb->s_lock) {
-		schedule();
-		goto repeat;
-	}
-	remove_wait_queue(&sb->s_wait, &wait);
-	current->state = TASK_RUNNING;
+	up(&sb->s_umount);
+	if (atomic_dec_and_test(&sb->s_count))
+		kfree(sb);
 }
 
 /*
@@ -611,20 +591,23 @@
 {
 	struct super_block * sb;
 
+restart:
 	for (sb = sb_entry(super_blocks.next);
 	     sb != sb_entry(&super_blocks); 
 	     sb = sb_entry(sb->s_list.next)) {
-		if (!sb->s_dev)
-			continue;
 		if (dev && sb->s_dev != dev)
 			continue;
 		if (!sb->s_dirt)
 			continue;
+		atomic_inc(&sb->s_count);
+		down(&sb->s_umount);
 		lock_super(sb);
-		if (sb->s_dev && sb->s_dirt && (!dev || dev == sb->s_dev))
+		if (sb->s_root && sb->s_dirt)
 			if (sb->s_op && sb->s_op->write_super)
 				sb->s_op->write_super(sb);
 		unlock_super(sb);
+		put_super(sb);
+		goto restart;
 	}
 }
 
@@ -646,9 +629,11 @@
 	s = sb_entry(super_blocks.next);
 	while (s != sb_entry(&super_blocks))
 		if (s->s_dev == dev) {
-			wait_on_super(s);
-			if (s->s_dev == dev)
+			atomic_inc(&s->s_count);
+			down(&s->s_umount);
+			if (s->s_root)
 				return s;
+			put_super(s);
 			goto restart;
 		} else
 			s = sb_entry(s->s_list.next);
@@ -668,6 +653,7 @@
         if (s == NULL)
                 goto out;
 	err = vfs_statfs(s, &sbuf);
+	put_super(s);
 	if (err)
 		goto out;
 
@@ -691,42 +677,61 @@
  
 struct super_block *get_empty_super(void)
 {
-	struct super_block *s;
-
-	for (s  = sb_entry(super_blocks.next);
-	     s != sb_entry(&super_blocks); 
-	     s  = sb_entry(s->s_list.next)) {
-		if (s->s_dev)
-			continue;
-		if (!s->s_lock)
-			return s;
-		printk("VFS: empty superblock %p locked!\n", s);
-	}
-	/* Need a new one... */
-	if (nr_super_blocks >= max_super_blocks)
-		return NULL;
-	s = kmalloc(sizeof(struct super_block),  GFP_USER);
+	struct super_block *s = kmalloc(sizeof(struct super_block),  GFP_USER);
 	if (s) {
 		nr_super_blocks++;
 		memset(s, 0, sizeof(struct super_block));
 		INIT_LIST_HEAD(&s->s_dirty);
-		list_add (&s->s_list, super_blocks.prev);
-		init_waitqueue_head(&s->s_wait);
 		INIT_LIST_HEAD(&s->s_files);
 		INIT_LIST_HEAD(&s->s_mounts);
+		sema_init(&s->s_umount, 0);
+		sema_init(&s->s_lock, 1);
+		atomic_set(&s->s_count, 1);
+		list_add (&s->s_list, super_blocks.prev);
 	}
 	return s;
 }
 
+/*
+ * Unnamed block devices are dummy devices used by virtual
+ * filesystems which don't use real block-devices.  -- jrs
+ */
+
+static unsigned int unnamed_dev_in_use[256/(8*sizeof(unsigned int))];
+
+static kdev_t get_unnamed_dev(void)
+{
+	int i;
+
+	for (i = 1; i < 256; i++) {
+		if (!test_and_set_bit(i,unnamed_dev_in_use))
+			return MKDEV(UNNAMED_MAJOR, i);
+	}
+	return 0;
+}
+
+static void put_unnamed_dev(kdev_t dev)
+{
+	if (!dev || MAJOR(dev) != UNNAMED_MAJOR)
+		return;
+	if (test_and_clear_bit(MINOR(dev), unnamed_dev_in_use))
+		return;
+	printk("VFS: put_unnamed_dev: freeing unused device %s\n",
+			kdevname(dev));
+}
+
 static struct super_block * read_super(kdev_t dev, struct block_device *bdev,
 				       struct file_system_type *type, int flags,
 				       void *data, int silent)
 {
 	struct super_block * s;
+	kdev_t rdev = dev ? dev : get_unnamed_dev();
+	if (!rdev)
+		goto fail;
 	s = get_empty_super();
 	if (!s)
-		goto out;
-	s->s_dev = dev;
+		goto fail;
+	s->s_dev = rdev;
 	s->s_bdev = bdev;
 	s->s_flags = flags;
 	s->s_dirt = 0;
@@ -743,48 +748,24 @@
 	/* tell bdcache that we are going to keep this one */
 	if (bdev)
 		atomic_inc(&bdev->bd_count);
-out:
 	return s;
 
 out_fail:
 	s->s_dev = 0;
-	s->s_bdev = 0;
+	if (!dev)
+		put_unnamed_dev(rdev);
+	s->s_bdev = NULL;
 	s->s_type = NULL;
 	unlock_super(s);
+	put_super(s);
+fail:
 	return NULL;
 }
 
-/*
- * Unnamed block devices are dummy devices used by virtual
- * filesystems which don't use real block-devices.  -- jrs
- */
-
-static unsigned int unnamed_dev_in_use[256/(8*sizeof(unsigned int))];
-
-kdev_t get_unnamed_dev(void)
-{
-	int i;
-
-	for (i = 1; i < 256; i++) {
-		if (!test_and_set_bit(i,unnamed_dev_in_use))
-			return MKDEV(UNNAMED_MAJOR, i);
-	}
-	return 0;
-}
-
-void put_unnamed_dev(kdev_t dev)
-{
-	if (!dev || MAJOR(dev) != UNNAMED_MAJOR)
-		return;
-	if (test_and_clear_bit(MINOR(dev), unnamed_dev_in_use))
-		return;
-	printk("VFS: put_unnamed_dev: freeing unused device %s\n",
-			kdevname(dev));
-}
-
 static struct super_block *get_sb_bdev(struct file_system_type *fs_type,
 	char *dev_name, int flags, void * data)
 {
+	DECLARE_MUTEX(mount_sem);
 	struct inode *inode;
 	struct block_device *bdev;
 	struct block_device_operations *bdops;
@@ -809,16 +790,18 @@
 	bdev = inode->i_bdev;
 	bdops = devfs_get_ops ( devfs_get_handle_from_inode (inode) );
 	if (bdops) bdev->bd_op = bdops;
+	dev = to_kdev_t(bdev->bd_dev);
 	/* Done with lookups, semaphore down */
 	down(&mount_sem);
-	dev = to_kdev_t(bdev->bd_dev);
 	sb = get_super(dev);
 	if (sb) {
 		if (fs_type == sb->s_type &&
 		    ((flags ^ sb->s_flags) & MS_RDONLY) == 0) {
+			up(&mount_sem);
 			path_release(&nd);
 			return sb;
 		}
+		put_super(sb);
 	} else {
 		mode_t mode = FMODE_READ; /* we always need it ;-) */
 		if (!(flags & MS_RDONLY))
@@ -833,6 +816,7 @@
 		error = -EINVAL;
 		sb = read_super(dev, bdev, fs_type, flags, data, 0);
 		if (sb) {
+			up(&mount_sem);
 			get_filesystem(fs_type);
 			path_release(&nd);
 			return sb;
@@ -841,29 +825,21 @@
 		blkdev_put(bdev, BDEV_FS);
 	}
 out:
-	path_release(&nd);
 	up(&mount_sem);
+	path_release(&nd);
 	return ERR_PTR(error);
 }
 
 static struct super_block *get_sb_nodev(struct file_system_type *fs_type,
 	int flags, void * data)
 {
-	kdev_t dev;
-	int error = -EMFILE;
-	down(&mount_sem);
-	dev = get_unnamed_dev();
-	if (dev) {
-		struct super_block * sb;
-		error = -EINVAL;
-		sb = read_super(dev, NULL, fs_type, flags, data, 0);
-		if (sb) {
-			get_filesystem(fs_type);
-			return sb;
-		}
-		put_unnamed_dev(dev);
+	struct super_block * sb;
+	int error = -EINVAL;
+	sb = read_super(0, NULL, fs_type, flags, data, 0);
+	if (sb) {
+		get_filesystem(fs_type);
+		return sb;
 	}
-	up(&mount_sem);
 	return ERR_PTR(error);
 }
 
@@ -875,10 +851,11 @@
 	 * Get the superblock of kernel-wide instance, but
 	 * keep the reference to fs_type.
 	 */
-	down(&mount_sem);
 	sb = fs_type->kern_mnt->mnt_sb;
 	if (!sb)
 		BUG();
+	atomic_inc(&sb->s_count);
+	down(&sb->s_umount);
 	get_filesystem(fs_type);
 	do_remount_sb(sb, flags, data);
 	return sb;
@@ -913,6 +890,7 @@
 			"Self-destruct in 5 seconds.  Have a nice day...\n");
 	}
 
+	list_del(&sb->s_list);
 	dev = sb->s_dev;
 	sb->s_dev = 0;		/* Free the superblock */
 	bdev = sb->s_bdev;
@@ -969,21 +947,18 @@
 
 struct vfsmount *kern_mount(struct file_system_type *type)
 {
-	kdev_t dev = get_unnamed_dev();
 	struct super_block *sb;
 	struct vfsmount *mnt;
-	if (!dev)
-		return ERR_PTR(-EMFILE);
-	sb = read_super(dev, NULL, type, 0, NULL, 0);
-	if (!sb) {
-		put_unnamed_dev(dev);
+	sb = read_super(0, NULL, type, 0, NULL, 0);
+	if (!sb)
 		return ERR_PTR(-EINVAL);
-	}
 	mnt = add_vfsmnt(NULL, sb->s_root, NULL);
 	if (!mnt) {
 		kill_super(sb, 0);
+		put_super(sb);
 		return ERR_PTR(-ENOMEM);
 	}
+	put_super(sb);
 	type->kern_mnt = mnt;
 	return mnt;
 }
@@ -993,9 +968,11 @@
 void kern_umount(struct vfsmount *mnt)
 {
 	struct super_block *sb = mnt->mnt_sb;
+	down(&sb->s_umount);
 	spin_lock(&dcache_lock);
 	remove_vfsmnt(mnt);
 	kill_super(sb, 0);
+	put_super(sb);
 }
 
 /*
@@ -1014,6 +991,8 @@
 {
 	struct super_block * sb = mnt->mnt_sb;
 
+	down(&sb->s_umount);
+
 	/*
 	 * No sense to grab the lock for this test, but test itself looks
 	 * somewhat bogus. Suggestions for better replacement?
@@ -1033,6 +1012,7 @@
 		mntput(mnt);
 		if (!(sb->s_flags & MS_RDONLY))
 			retval = do_remount_sb(sb, MS_RDONLY, 0);
+		up(&sb->s_umount);
 		return retval;
 	}
 
@@ -1041,14 +1021,14 @@
 	if (mnt->mnt_instances.next != mnt->mnt_instances.prev) {
 		if (atomic_read(&mnt->mnt_count) > 2) {
 			spin_unlock(&dcache_lock);
-			mntput(mnt);
-			return -EBUSY;
+			goto busy;
 		}
 		if (sb->s_type->fs_flags & FS_SINGLE)
 			put_filesystem(sb->s_type);
 		/* We hold two references, so mntput() is safe */
 		mntput(mnt);
 		remove_vfsmnt(mnt);
+		put_super(sb);
 		return 0;
 	}
 	spin_unlock(&dcache_lock);
@@ -1084,18 +1064,15 @@
 	shrink_dcache_sb(sb);
 	fsync_dev(sb->s_dev);
 
-	if (sb->s_root->d_inode->i_state) {
-		mntput(mnt);
-		return -EBUSY;
-	}
+	if (sb->s_root->d_inode->i_state)
+		goto busy;
 
 	/* Something might grab it again - redo checks */
 
 	spin_lock(&dcache_lock);
 	if (atomic_read(&mnt->mnt_count) > 2) {
 		spin_unlock(&dcache_lock);
-		mntput(mnt);
-		return -EBUSY;
+		goto busy;
 	}
 
 	/* OK, that's the point of no return */
@@ -1103,7 +1080,12 @@
 	remove_vfsmnt(mnt);
 
 	kill_super(sb, umount_root);
+	put_super(sb);
 	return 0;
+busy:
+	mntput(mnt);
+	up(&sb->s_umount);
+	return -EBUSY;
 }
 
 /*
@@ -1141,9 +1123,7 @@
 
 	dput(nd.dentry);
 	/* puts nd.mnt */
-	down(&mount_sem);
 	retval = do_umount(nd.mnt, 0, flags);
-	up(&mount_sem);
 	goto out;
 dput_and_out:
 	path_release(&nd);
@@ -1208,7 +1188,6 @@
 	if (old_nd.mnt->mnt_sb->s_type->fs_flags & FS_SINGLE)
 		get_filesystem(old_nd.mnt->mnt_sb->s_type);
 		
-	down(&mount_sem);
 	/* there we go */
 	down(&new_nd.dentry->d_inode->i_zombie);
 	if (IS_DEADDIR(new_nd.dentry->d_inode))
@@ -1216,7 +1195,6 @@
 	else if (add_vfsmnt(&new_nd, old_nd.dentry, old_nd.mnt->mnt_devname))
 		err = 0;
 	up(&new_nd.dentry->d_inode->i_zombie);
-	up(&mount_sem);
 	if (err && old_nd.mnt->mnt_sb->s_type->fs_flags & FS_SINGLE)
 		put_filesystem(old_nd.mnt->mnt_sb->s_type);
 out2:
@@ -1346,12 +1324,6 @@
 	if (!type_page || !memchr(type_page, 0, PAGE_SIZE))
 		return -EINVAL;
 
-#if 0	/* Can be deleted again. Introduced in patch-2.3.99-pre6 */
-	/* loopback mount? This is special - requires fewer capabilities */
-	if (strcmp(type_page, "bind")==0)
-		return do_loopback(dev_name, dir_name);
-#endif
-
 	/* for the rest we _really_ need capabilities... */
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -1368,7 +1340,7 @@
 	if (retval)
 		goto fs_out;
 
-	/* get superblock, locks mount_sem on success */
+	/* get superblock, locks ->s_umount on success */
 	if (fstype->fs_flags & FS_NOMOUNT)
 		sb = ERR_PTR(-EINVAL);
 	else if (fstype->fs_flags & FS_REQUIRES_DEV)
@@ -1405,7 +1377,7 @@
 		goto fail;
 	retval = 0;
 unlock_out:
-	up(&mount_sem);
+	put_super(sb);
 dput_out:
 	path_release(&nd);
 fs_out:
@@ -1478,26 +1450,19 @@
 	fs_type = get_fs_type("nfs");
 	if (!fs_type)
 		goto no_nfs;
-	ROOT_DEV = get_unnamed_dev();
-	if (!ROOT_DEV)
-		/*
-		 * Your /linuxrc sucks worse than MSExchange - that's the
-		 * only way you could run out of anon devices at that point.
-		 */
-		goto no_anon;
 	data = nfs_root_data();
 	if (!data)
-		goto no_server;
-	sb = read_super(ROOT_DEV, NULL, fs_type, root_mountflags, data, 1);
-	if (sb)
+		goto no_anon;
+	sb = read_super(0, NULL, fs_type, root_mountflags, data, 1);
+	if (sb) {
 		/*
 		 * We _can_ fail there, but if that will happen we have no
 		 * chance anyway (no memory for vfsmnt and we _will_ need it,
 		 * no matter which fs we try to mount).
 		 */
+		ROOT_DEV = sb->s_dev;
 		goto mount_it;
-no_server:
-	put_unnamed_dev(ROOT_DEV);
+	}
 no_anon:
 	put_filesystem(fs_type);
 no_nfs:
@@ -1607,12 +1572,12 @@
 	}
 	else
 		vfsmnt = add_vfsmnt(NULL, sb->s_root, "/dev/root");
-	/* FIXME: if something will try to umount us right now... */
 	if (vfsmnt) {
 		set_fs_root(current->fs, vfsmnt, sb->s_root);
 		set_fs_pwd(current->fs, vfsmnt, sb->s_root);
 		if (bdev)
 			bdput(bdev); /* sb holds a reference */
+		put_super(sb);
 		return;
 	}
 	panic("VFS: add_vfsmnt failed for root fs");
@@ -1697,7 +1662,6 @@
 	root_mnt = mntget(current->fs->rootmnt);
 	root = dget(current->fs->root);
 	read_unlock(&current->fs->lock);
-	down(&mount_sem);
 	down(&old_nd.dentry->d_inode->i_zombie);
 	error = -ENOENT;
 	if (IS_DEADDIR(new_nd.dentry->d_inode))
@@ -1732,7 +1696,6 @@
 	error = 0;
 out2:
 	up(&old_nd.dentry->d_inode->i_zombie);
-	up(&mount_sem);
 	dput(root);
 	mntput(root_mnt);
 	path_release(&old_nd);
@@ -1765,10 +1728,8 @@
 		if (devfs_nd.mnt->mnt_sb->s_magic == DEVFS_SUPER_MAGIC &&
 		    devfs_nd.dentry == devfs_nd.mnt->mnt_root) {
 			dput(devfs_nd.dentry);
-			down(&mount_sem);
 			/* puts devfs_nd.mnt */
 			do_umount(devfs_nd.mnt, 0, 0);
-			up(&mount_sem);
 		} else 
 			path_release(&devfs_nd);
 	}
diff -urN rc13-pre6/fs/udf/inode.c rc13-pre6-s_lock/fs/udf/inode.c
--- rc13-pre6/fs/udf/inode.c	Tue Dec 12 02:10:46 2000
+++ rc13-pre6-s_lock/fs/udf/inode.c	Sat Dec 30 09:17:29 2000
@@ -203,7 +203,6 @@
 	udf_release_data(bh);
 
 	inode->i_data.a_ops->writepage(page);
-	UnlockPage(page);
 	page_cache_release(page);
 
 	mark_inode_dirty(inode);
diff -urN rc13-pre6/fs/ufs/super.c rc13-pre6-s_lock/fs/ufs/super.c
--- rc13-pre6/fs/ufs/super.c	Sun Sep 17 12:15:20 2000
+++ rc13-pre6-s_lock/fs/ufs/super.c	Sat Dec 30 09:17:29 2000
@@ -230,9 +230,6 @@
 	va_start (args, fmt);
 	vsprintf (error_buf, fmt, args);
 	va_end (args);
-	/* this is to prevent panic from syncing this filesystem */
-	if (sb->s_lock)
-		sb->s_lock = 0;
 	sb->s_flags |= MS_RDONLY;
 	printk (KERN_CRIT "UFS-fs panic (device %s): %s: %s\n",
 		kdevname(sb->s_dev), function, error_buf);
diff -urN rc13-pre6/include/linux/fs.h rc13-pre6-s_lock/include/linux/fs.h
--- rc13-pre6/include/linux/fs.h	Sat Dec 30 07:37:54 2000
+++ rc13-pre6-s_lock/include/linux/fs.h	Sat Dec 30 09:44:34 2000
@@ -667,7 +667,6 @@
 	kdev_t			s_dev;
 	unsigned long		s_blocksize;
 	unsigned char		s_blocksize_bits;
-	unsigned char		s_lock;
 	unsigned char		s_dirt;
 	struct file_system_type	*s_type;
 	struct super_operations	*s_op;
@@ -675,7 +674,9 @@
 	unsigned long		s_flags;
 	unsigned long		s_magic;
 	struct dentry		*s_root;
-	wait_queue_head_t	s_wait;
+	struct semaphore	s_umount;
+	struct semaphore	s_lock;		/* probably goner */
+	atomic_t		s_count;
 
 	struct list_head	s_dirty;	/* dirty inodes */
 	struct list_head	s_files;
@@ -1070,6 +1071,7 @@
 extern void write_inode_now(struct inode *, int);
 extern void sync_dev(kdev_t);
 extern int fsync_dev(kdev_t);
+extern void invalidate_dev(kdev_t, int);
 extern int fsync_inode_buffers(struct inode *);
 extern int osync_inode_buffers(struct inode *);
 extern int inode_has_buffers(struct inode *);
@@ -1265,7 +1267,16 @@
 extern struct file_system_type *get_fs_type(const char *name);
 extern struct super_block *get_super(kdev_t);
 struct super_block *get_empty_super(void);
-extern void put_super(kdev_t);
+extern void put_super(struct super_block *sb);
+static inline int is_mounted(kdev_t dev)
+{
+	struct super_block *sb = get_super(dev);
+	if (sb) {
+		put_super(sb);
+		return 1;
+	}
+	return 0;
+}
 unsigned long generate_cluster(kdev_t, int b[], int);
 unsigned long generate_cluster_swab32(kdev_t, int b[], int);
 extern kdev_t ROOT_DEV;
diff -urN rc13-pre6/include/linux/locks.h rc13-pre6-s_lock/include/linux/locks.h
--- rc13-pre6/include/linux/locks.h	Sat Dec 16 12:30:30 2000
+++ rc13-pre6-s_lock/include/linux/locks.h	Sat Dec 30 09:44:35 2000
@@ -39,30 +39,15 @@
  * a super-block (although even this isn't done right now.
  * nfs may need it).
  */
-extern void __wait_on_super(struct super_block *);
-
-extern inline void wait_on_super(struct super_block * sb)
-{
-	if (sb->s_lock)
-		__wait_on_super(sb);
-}
 
 extern inline void lock_super(struct super_block * sb)
 {
-	if (sb->s_lock)
-		__wait_on_super(sb);
-	sb->s_lock = 1;
+	down(&sb->s_lock);
 }
 
 extern inline void unlock_super(struct super_block * sb)
 {
-	sb->s_lock = 0;
-	/*
-	 * No need of any barrier, we're protected by
-	 * the big kernel lock here... unfortunately :)
-	 */
-	if (waitqueue_active(&sb->s_wait))
-		wake_up(&sb->s_wait);
+	up(&sb->s_lock);
 }
 
 #endif /* _LINUX_LOCKS_H */
diff -urN rc13-pre6/include/linux/quotaops.h rc13-pre6-s_lock/include/linux/quotaops.h
--- rc13-pre6/include/linux/quotaops.h	Sat Dec 16 12:52:02 2000
+++ rc13-pre6-s_lock/include/linux/quotaops.h	Sat Dec 30 09:58:07 2000
@@ -21,7 +21,6 @@
  */
 extern void dquot_initialize(struct inode *inode, short type);
 extern void dquot_drop(struct inode *inode);
-extern void invalidate_dquots(kdev_t dev, short type);
 extern int  quota_off(struct super_block *sb, short type);
 extern int  sync_dquots(kdev_t dev, short type);
 
diff -urN rc13-pre6/kernel/ksyms.c rc13-pre6-s_lock/kernel/ksyms.c
--- rc13-pre6/kernel/ksyms.c	Sat Dec 30 07:37:55 2000
+++ rc13-pre6-s_lock/kernel/ksyms.c	Sat Dec 30 09:17:30 2000
@@ -127,6 +127,8 @@
 EXPORT_SYMBOL(update_atime);
 EXPORT_SYMBOL(get_fs_type);
 EXPORT_SYMBOL(get_super);
+EXPORT_SYMBOL(put_super);
+EXPORT_SYMBOL(invalidate_dev);
 EXPORT_SYMBOL(get_empty_super);
 EXPORT_SYMBOL(getname);
 EXPORT_SYMBOL(names_cachep);
@@ -472,7 +474,6 @@
 
 /* Added to make file system as module */
 EXPORT_SYMBOL(sys_tz);
-EXPORT_SYMBOL(__wait_on_super);
 EXPORT_SYMBOL(file_fsync);
 EXPORT_SYMBOL(fsync_inode_buffers);
 EXPORT_SYMBOL(clear_inode);


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
