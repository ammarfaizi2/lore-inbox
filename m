Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288543AbSADId1>; Fri, 4 Jan 2002 03:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288544AbSADIdS>; Fri, 4 Jan 2002 03:33:18 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:41406 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S288543AbSADIdF>; Fri, 4 Jan 2002 03:33:05 -0500
Date: Fri, 4 Jan 2002 00:33:01 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
Subject: Patch: linux-2.5.2-pre7/fs/devfs kdev_t fixes
Message-ID: <20020104003301.A13301@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The following patch fixes some kdev_t compilation errors in
linux-2.5.2-pre7/fs/devfs/{base,util}.c.

	Note that my fs/devfs/base.c lacks the code that, as of the
last time I checked, prevented compactflash card partitions from
being used with devfs (and was completely unnecessary, and introduced
semantic differences with non-devfs systems).  So, I made the diffs
again my old version, which means that patch will probably make you
apply at least one of the stanzas by hand.  Also, this means that
the code that prevents compactflash partitions from being used may
not have been ported to kdev_t.  However, these changes will at
least be a start for anyone who wants to port the rest.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="devfs.diff"

--- linux-2.5.2-pre7/fs/devfs/util.c	Thu Jan  3 19:52:02 2002
+++ linux/fs/devfs/util.c	Thu Jan  3 23:58:41 2002
@@ -267,7 +267,7 @@
 	if (minor >= 256) continue;
 	__set_bit (minor, entry->bits);
 	up (semaphore);
-	return MKDEV (entry->major, minor);
+	return mk_kdev (entry->major, minor);
     }
     /*  Need to allocate a new major  */
     if ( ( entry = kmalloc (sizeof *entry, GFP_KERNEL) ) == NULL )
@@ -289,7 +289,7 @@
     else list->last->next = entry;
     list->last = entry;
     up (semaphore);
-    return MKDEV (entry->major, 0);
+    return mk_kdev (entry->major, 0);
 }   /*  End Function devfs_alloc_devnum  */
 EXPORT_SYMBOL(devfs_alloc_devnum);
 
@@ -309,7 +309,7 @@
     struct device_list *list;
     struct minor_list *entry;
 
-    if (devnum == NODEV) return;
+    if (kdev_none(devnum)) return;
     if (type == DEVFS_SPECIAL_CHR)
     {
 	semaphore = &char_semaphore;
--- linux/fs/devfs/base.c	2002/01/04 04:11:36	1.37
+++ linux/fs/devfs/base.c	2002/01/04 08:18:41	1.38
@@ -911,8 +911,8 @@
     {
 	devfs_dealloc_devnum ( S_ISCHR (de->mode) ? DEVFS_SPECIAL_CHR :
 			       DEVFS_SPECIAL_BLK,
-			       MKDEV (de->u.fcb.u.device.major,
-				      de->u.fcb.u.device.minor) );
+			       mk_kdev (de->u.fcb.u.device.major,
+					de->u.fcb.u.device.minor) );
     }
     WRITE_ENTRY_MAGIC (de, 0);
 #ifdef CONFIG_DEVFS_DEBUG
@@ -1397,7 +1397,9 @@
 
 static int is_devfsd_or_child (struct fs_info *fs_info)
 {
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,1)
     struct task_struct *p;
+#endif
 
     if (current == fs_info->devfsd_task) return (TRUE);
     if (current->pgrp == fs_info->devfsd_pgrp) return (TRUE);
@@ -1568,7 +1570,8 @@
     if ( ( S_ISCHR (mode) || S_ISBLK (mode) ) &&
 	 (flags & DEVFS_FL_AUTO_DEVNUM) )
     {
-	if ( ( devnum = devfs_alloc_devnum (devtype) ) == NODEV )
+	devnum = devfs_alloc_devnum (devtype);
+	if ( kdev_none(devnum) )
 	{
 	    PRINTK ("(%s): exhausted %s device numbers\n",
 		    name, S_ISCHR (mode) ? "char" : "block");
@@ -1580,14 +1583,14 @@
     if ( ( de = _devfs_prepare_leaf (&dir, name, mode) ) == NULL )
     {
 	PRINTK ("(%s): could not prepare leaf\n", name);
-	if (devnum != NODEV) devfs_dealloc_devnum (devtype, devnum);
+	if ( !kdev_none(devnum) ) devfs_dealloc_devnum (devtype, devnum);
 	return NULL;
     }
     if ( S_ISCHR (mode) || S_ISBLK (mode) )
     {
 	de->u.fcb.u.device.major = major;
 	de->u.fcb.u.device.minor = minor;
-	de->u.fcb.autogen = (devnum == NODEV) ? FALSE : TRUE;
+	de->u.fcb.autogen = kdev_none(devnum) ? FALSE : TRUE;
     }
     else if ( !S_ISREG (mode) )
     {
@@ -1616,7 +1619,7 @@
     {
 	PRINTK ("(%s): could not append to parent, err: %d\n", name, err);
 	devfs_put (dir);
-	if (devnum != NODEV) devfs_dealloc_devnum (devtype, devnum);
+	if ( !kdev_none(devnum) ) devfs_dealloc_devnum (devtype, devnum);
 	return NULL;
     }
     DPRINTK (DEBUG_REGISTER, "(%s): de: %p dir: %p \"%s\"  pp: %p\n",
@@ -2527,15 +2530,15 @@
     inode->i_rdev = NODEV;
     if ( S_ISCHR (de->mode) )
     {
-	inode->i_rdev = MKDEV (de->u.fcb.u.device.major,
-			       de->u.fcb.u.device.minor);
+	inode->i_rdev = mk_kdev (de->u.fcb.u.device.major,
+				 de->u.fcb.u.device.minor);
 	inode->i_cdev = cdget ( kdev_t_to_nr (inode->i_rdev) );
 	is_fcb = TRUE;
     }
     else if ( S_ISBLK (de->mode) )
     {
-	inode->i_rdev = MKDEV (de->u.fcb.u.device.major,
-			       de->u.fcb.u.device.minor);
+	inode->i_rdev = mk_kdev (de->u.fcb.u.device.major,
+				 de->u.fcb.u.device.minor);
 	if (bd_acquire (inode) == 0)
 	{
 	    if (!inode->i_bdev->bd_op && de->u.fcb.ops)

--AqsLC8rIMeq19msA--
