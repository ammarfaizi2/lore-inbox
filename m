Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315430AbSGEF3w>; Fri, 5 Jul 2002 01:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315431AbSGEF3v>; Fri, 5 Jul 2002 01:29:51 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:52425 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315430AbSGEF3t>;
	Fri, 5 Jul 2002 01:29:49 -0400
Date: Fri, 5 Jul 2002 01:32:22 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ->i_dev switched to dev_t
Message-ID: <Pine.GSO.4.21.0207050126020.14718-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	* ->i_dev followed the example of ->s_dev - it's dev_t now.  All
remaining uses of ->i_dev either outright want dev_t (stat()) or couldn't
care less (printing major:minor in /proc/<pid>/maps, etc.)

	That's it for tonight - the rest needs massive changes due to
the driverfs/partition stuff ;-/

diff -urN C24-0/arch/sparc/kernel/signal.c C24-current/arch/sparc/kernel/signal.c
--- C24-0/arch/sparc/kernel/signal.c	Fri May  3 03:27:23 2002
+++ C24-current/arch/sparc/kernel/signal.c	Wed Jul  3 04:23:54 2002
@@ -1090,7 +1090,7 @@
 
 #ifdef DEBUG_SIGNALS_MAPS
 
-#define MAPS_LINE_FORMAT	  "%08lx-%08lx %s %08lx %s %lu "
+#define MAPS_LINE_FORMAT	  "%08lx-%08lx %s %08lx %02x:%02x %lu "
 
 static inline void read_maps (void)
 {
@@ -1107,7 +1107,7 @@
 		char *line;
 		char str[5], *cp = str;
 		int flags;
-		kdev_t dev;
+		dev_t dev;
 		unsigned long ino;
 
 		/*
@@ -1132,7 +1132,7 @@
 				      buffer, PAGE_SIZE);
 		}
 		printk(MAPS_LINE_FORMAT, map->vm_start, map->vm_end, str, map->vm_pgoff << PAGE_SHIFT,
-			      kdevname(dev), ino);
+			      MAJOR(dev), MINOR(dev), ino);
 		if (map->vm_file != NULL)
 			printk("%s\n", line);
 		else
diff -urN C24-0/arch/sparc64/kernel/signal.c C24-current/arch/sparc64/kernel/signal.c
--- C24-0/arch/sparc64/kernel/signal.c	Fri May 10 18:20:58 2002
+++ C24-current/arch/sparc64/kernel/signal.c	Wed Jul  3 04:24:29 2002
@@ -633,7 +633,7 @@
 
 #ifdef DEBUG_SIGNALS_MAPS
 
-#define MAPS_LINE_FORMAT	  "%016lx-%016lx %s %016lx %s %lu "
+#define MAPS_LINE_FORMAT	  "%016lx-%016lx %s %016lx %02x:%02x %lu "
 
 static inline void read_maps (void)
 {
@@ -650,7 +650,7 @@
 		char *line;
 		char str[5], *cp = str;
 		int flags;
-		kdev_t dev;
+		dev_t dev;
 		unsigned long ino;
 
 		/*
@@ -675,7 +675,7 @@
 				      buffer, PAGE_SIZE);
 		}
 		printk(MAPS_LINE_FORMAT, map->vm_start, map->vm_end, str, map->vm_pgoff << PAGE_SHIFT,
-			      kdevname(dev), ino);
+			      MAJOR(dev), MINOR(dev), ino);
 		if (map->vm_file != NULL)
 			printk("%s\n", line);
 		else
diff -urN C24-0/arch/sparc64/kernel/signal32.c C24-current/arch/sparc64/kernel/signal32.c
--- C24-0/arch/sparc64/kernel/signal32.c	Fri May 10 18:20:58 2002
+++ C24-current/arch/sparc64/kernel/signal32.c	Wed Jul  3 04:25:09 2002
@@ -1319,7 +1319,7 @@
 
 #ifdef DEBUG_SIGNALS_MAPS
 
-#define MAPS_LINE_FORMAT	  "%016lx-%016lx %s %016lx %s %lu "
+#define MAPS_LINE_FORMAT	  "%016lx-%016lx %s %016lx %02x:%02x %lu "
 
 static inline void read_maps (void)
 {
@@ -1336,7 +1336,7 @@
 		char *line;
 		char str[5], *cp = str;
 		int flags;
-		kdev_t dev;
+		dev_t dev;
 		unsigned long ino;
 
 		/*
@@ -1361,7 +1361,7 @@
 				      buffer, PAGE_SIZE);
 		}
 		printk(MAPS_LINE_FORMAT, map->vm_start, map->vm_end, str, map->vm_pgoff << PAGE_SHIFT,
-			      kdevname(dev), ino);
+			      MAJOR(dev), MINOR(dev), ino);
 		if (map->vm_file != NULL)
 			printk("%s\n", line);
 		else
diff -urN C24-0/fs/block_dev.c C24-current/fs/block_dev.c
--- C24-0/fs/block_dev.c	Thu Jun 20 13:37:04 2002
+++ C24-current/fs/block_dev.c	Wed Jul  3 04:19:27 2002
@@ -299,7 +299,6 @@
 			new_bdev->bd_inode = inode;
 			inode->i_mode = S_IFBLK;
 			inode->i_rdev = kdev;
-			inode->i_dev = kdev;
 			inode->i_bdev = new_bdev;
 			inode->i_data.a_ops = &def_blk_aops;
 			inode->i_data.gfp_mask = GFP_USER;
diff -urN C24-0/fs/inode.c C24-current/fs/inode.c
--- C24-0/fs/inode.c	Thu Jun 20 13:37:25 2002
+++ C24-current/fs/inode.c	Wed Jul  3 04:19:34 2002
@@ -101,7 +101,7 @@
 		struct address_space * const mapping = &inode->i_data;
 
 		inode->i_sb = sb;
-		inode->i_dev = to_kdev_t(sb->s_dev);
+		inode->i_dev = sb->s_dev;
 		inode->i_blkbits = sb->s_blocksize_bits;
 		inode->i_flags = 0;
 		atomic_set(&inode->i_count, 1);
diff -urN C24-0/fs/locks.c C24-current/fs/locks.c
--- C24-0/fs/locks.c	Thu Jun 20 13:37:25 2002
+++ C24-current/fs/locks.c	Wed Jul  3 04:26:31 2002
@@ -1751,9 +1751,12 @@
 			       ? (fl->fl_type & F_UNLCK) ? "UNLCK" : "READ "
 			       : (fl->fl_type & F_WRLCK) ? "WRITE" : "READ ");
 	}
+	/*
+	 *	NOTE: it should be inode->i_sb->s_id, not kdevname(...).
+	 */
 	out += sprintf(out, "%d %s:%ld ",
 		     fl->fl_pid,
-		     inode ? kdevname(inode->i_dev) : "<none>",
+		     inode ? kdevname(to_kdev_t(inode->i_dev)) : "<none>",
 		     inode ? inode->i_ino : 0);
 	out += sprintf(out, "%Ld ", fl->fl_start);
 	if (fl->fl_end == OFFSET_MAX)
diff -urN C24-0/fs/nfsd/nfs3xdr.c C24-current/fs/nfsd/nfs3xdr.c
--- C24-0/fs/nfsd/nfs3xdr.c	Thu Jun 20 13:37:05 2002
+++ C24-current/fs/nfsd/nfs3xdr.c	Wed Jul  3 04:19:54 2002
@@ -219,7 +219,7 @@
 	    && (fhp->fh_export->ex_flags & NFSEXP_FSID))
 		p = xdr_encode_hyper(p, (u64) fhp->fh_export->ex_fsid);
 	else
-		p = xdr_encode_hyper(p, (u64) kdev_t_to_nr(inode->i_dev));
+		p = xdr_encode_hyper(p, (u64) inode->i_dev);
 	p = xdr_encode_hyper(p, (u64) inode->i_ino);
 	p = encode_time3(p, fhp->fh_post_atime);
 	p = encode_time3(p, fhp->fh_post_mtime);
diff -urN C24-0/fs/nfsd/vfs.c C24-current/fs/nfsd/vfs.c
--- C24-0/fs/nfsd/vfs.c	Sat May 25 01:41:04 2002
+++ C24-current/fs/nfsd/vfs.c	Wed Jul  3 04:21:41 2002
@@ -66,7 +66,7 @@
 	struct raparms		*p_next;
 	unsigned int		p_count;
 	ino_t			p_ino;
-	kdev_t			p_dev;
+	dev_t			p_dev;
 	struct file_ra_state	p_ra;
 };
 
@@ -527,14 +527,14 @@
 static spinlock_t ra_lock = SPIN_LOCK_UNLOCKED;
 
 static inline struct raparms *
-nfsd_get_raparms(kdev_t dev, ino_t ino)
+nfsd_get_raparms(dev_t dev, ino_t ino)
 {
 	struct raparms	*ra, **rap, **frap = NULL;
 	int depth = 0;
 
 	spin_lock(&ra_lock);
 	for (rap = &raparm_cache; (ra = *rap); rap = &ra->p_next) {
-		if (ra->p_ino == ino && kdev_same(ra->p_dev, dev))
+		if (ra->p_ino == ino && ra->p_dev == dev)
 			goto found;
 		depth++;
 		if (ra->p_count == 0)
@@ -691,8 +691,8 @@
 	}
 
 	if (err >= 0 && stable) {
-		static unsigned long	last_ino;
-		static kdev_t		last_dev = NODEV;
+		static ino_t	last_ino;
+		static dev_t	last_dev = 0;
 
 		/*
 		 * Gathered writes: If another process is currently
@@ -708,7 +708,7 @@
 		 */
 		if (EX_WGATHER(exp)) {
 			if (atomic_read(&inode->i_writecount) > 1
-			    || (last_ino == inode->i_ino && kdev_same(last_dev, inode->i_dev))) {
+			    || (last_ino == inode->i_ino && last_dev == inode->i_dev)) {
 				dprintk("nfsd: write defer %d\n", current->pid);
 				set_current_state(TASK_UNINTERRUPTIBLE);
 				schedule_timeout((HZ+99)/100);
diff -urN C24-0/fs/proc/array.c C24-current/fs/proc/array.c
--- C24-0/fs/proc/array.c	Thu Jun 20 13:37:25 2002
+++ C24-current/fs/proc/array.c	Wed Jul  3 04:23:05 2002
@@ -538,11 +538,11 @@
  *         + (index into the line)
  */
 /* for systems with sizeof(void*) == 4: */
-#define MAPS_LINE_FORMAT4	  "%08lx-%08lx %s %08lx %s %lu"
+#define MAPS_LINE_FORMAT4	  "%08lx-%08lx %s %08lx %02x:%02x %lu"
 #define MAPS_LINE_MAX4	49 /* sum of 8  1  8  1 4 1 8 1 5 1 10 1 */
 
 /* for systems with sizeof(void*) == 8: */
-#define MAPS_LINE_FORMAT8	  "%016lx-%016lx %s %016lx %s %lu"
+#define MAPS_LINE_FORMAT8	  "%016lx-%016lx %s %016lx %02x:%02x %lu"
 #define MAPS_LINE_MAX8	73 /* sum of 16  1  16  1 4 1 16 1 5 1 10 1 */
 
 #define MAPS_LINE_FORMAT	(sizeof(void*) == 4 ? MAPS_LINE_FORMAT4 : MAPS_LINE_FORMAT8)
@@ -554,7 +554,7 @@
 	char *line;
 	char str[5];
 	int flags;
-	kdev_t dev;
+	dev_t dev;
 	unsigned long ino;
 	int len;
 
@@ -566,7 +566,7 @@
 	str[3] = flags & VM_MAYSHARE ? 's' : 'p';
 	str[4] = 0;
 
-	dev = NODEV;
+	dev = 0;
 	ino = 0;
 	if (map->vm_file != NULL) {
 		dev = map->vm_file->f_dentry->d_inode->i_dev;
@@ -584,7 +584,7 @@
 	len = sprintf(line,
 		      MAPS_LINE_FORMAT,
 		      map->vm_start, map->vm_end, str, map->vm_pgoff << PAGE_SHIFT,
-		      kdevname(dev), ino);
+		      MAJOR(dev), MINOR(dev), ino);
 
 	if(map->vm_file) {
 		int i;
diff -urN C24-0/fs/stat.c C24-current/fs/stat.c
--- C24-0/fs/stat.c	Thu Jun 20 13:37:05 2002
+++ C24-current/fs/stat.c	Wed Jul  3 04:19:44 2002
@@ -17,7 +17,7 @@
 
 void generic_fillattr(struct inode *inode, struct kstat *stat)
 {
-	stat->dev = kdev_t_to_nr(inode->i_dev);
+	stat->dev = inode->i_dev;
 	stat->ino = inode->i_ino;
 	stat->mode = inode->i_mode;
 	stat->nlink = inode->i_nlink;
diff -urN C24-0/include/linux/fs.h C24-current/include/linux/fs.h
--- C24-0/include/linux/fs.h	Mon Jun 24 19:05:12 2002
+++ C24-current/include/linux/fs.h	Wed Jul  3 04:20:11 2002
@@ -359,7 +359,7 @@
 	struct list_head	i_dentry;
 	unsigned long		i_ino;
 	atomic_t		i_count;
-	kdev_t			i_dev;
+	dev_t			i_dev;
 	umode_t			i_mode;
 	nlink_t			i_nlink;
 	uid_t			i_uid;
diff -urN C24-0/include/linux/kdev_t.h C24-current/include/linux/kdev_t.h
--- C24-0/include/linux/kdev_t.h	Thu Jun 20 13:37:05 2002
+++ C24-current/include/linux/kdev_t.h	Wed Jul  3 04:27:14 2002
@@ -36,8 +36,7 @@
 Admissible operations on an object of type kdev_t:
 - passing it along
 - comparing it for equality with another such object
-- storing it in inode->i_dev, inode->i_rdev, req->rq_dev, de->dc_dev,
-- tty->device
+- storing it in inode->i_rdev, req->rq_dev, de->dc_dev, tty->device
 - using its bit pattern as argument in a hash function
 - finding its major and minor
 - complaining about it
diff -urN C24-0/net/socket.c C24-current/net/socket.c
--- C24-0/net/socket.c	Thu Jun 20 13:37:26 2002
+++ C24-current/net/socket.c	Wed Jul  3 04:20:15 2002
@@ -465,7 +465,7 @@
 	if (!inode)
 		return NULL;
 
-	inode->i_dev = NODEV;
+	inode->i_dev = 0;
 	sock = SOCKET_I(inode);
 
 	inode->i_mode = S_IFSOCK|S_IRWXUGO;

