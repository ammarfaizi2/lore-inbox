Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268949AbTCARxm>; Sat, 1 Mar 2003 12:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268958AbTCARxm>; Sat, 1 Mar 2003 12:53:42 -0500
Received: from verein.lst.de ([212.34.181.86]:61451 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S268949AbTCARxk>;
	Sat, 1 Mar 2003 12:53:40 -0500
Date: Sat, 1 Mar 2003 19:03:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] die kdevname(), die!
Message-ID: <20030301190355.A1900@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the three remaining uses of kdevname():

fs/locks.c:
	use MAJOR/MINOR directly as userspace is stupid, this part of the
	patch is from the maintainer of that piece of code, Matthew Wilcox.
fs/intermezzo/sysctl.c:
	printk removed as suggested by you, surrunding code is far from
	beeing compilable anyway.
fs/partitions/check.c:
	replace with __bdevname

and the function plus it's two prototypes in the headers.


--- 1.14/fs/libfs.c	Tue Dec 31 20:18:35 2002
+++ edited/fs/libfs.c	Sat Mar  1 11:23:49 2003
@@ -332,14 +332,3 @@
 	set_page_dirty(page);
 	return 0;
 }
-
-/*
- * Print device name (in decimal, hexadecimal or symbolic)
- * Note: returns pointer to static data!
- */
-const char * kdevname(kdev_t dev)
-{
-	static char buffer[32];
-	sprintf(buffer, "%02x:%02x", major(dev), minor(dev));
-	return buffer;
-}
--- 1.37/fs/locks.c	Thu Feb 13 12:25:01 2003
+++ edited/fs/locks.c	Sat Mar  1 11:22:36 2003
@@ -1785,19 +1785,20 @@
 			       ? (fl->fl_type & F_UNLCK) ? "UNLCK" : "READ "
 			       : (fl->fl_type & F_WRLCK) ? "WRITE" : "READ ");
 	}
-#if WE_CAN_BREAK_LSLK_NOW
 	if (inode) {
+#if WE_CAN_BREAK_LSLK_NOW
 		out += sprintf(out, "%d %s:%ld ", fl->fl_pid,
 				inode->i_sb->s_id, inode->i_ino);
+#else
+		/* userspace relies on this representation of dev_t ;-( */
+		out += sprintf(out, "%d %02x:%02x:%ld ", fl->fl_pid,
+				MAJOR(inode->i_sb->s_dev),
+				MINOR(inode->i_sb->s_dev), inode->i_ino);
+#endif
 	} else {
 		out += sprintf(out, "%d <none>:0 ", fl->fl_pid);
 	}
-#else
-	/* kdevname is a broken interface.  but we expose it to userspace */
-	out += sprintf(out, "%d %s:%ld ", fl->fl_pid,
-			inode ? kdevname(to_kdev_t(inode->i_sb->s_dev)) : "<none>",
-			inode ? inode->i_ino : 0);
-#endif
+
 	if (IS_POSIX(fl)) {
 		if (fl->fl_end == OFFSET_MAX)
 			out += sprintf(out, "%Ld EOF\n", fl->fl_start);
--- 1.7/fs/intermezzo/sysctl.c	Fri Dec 13 20:27:19 2002
+++ edited/fs/intermezzo/sysctl.c	Sat Mar  1 11:22:55 2003
@@ -175,9 +175,6 @@
 		if (errorval < 0) {
 			if (newval == 0)
 				set_device_ro(-errorval, 0);
-			else
-				CERROR("device %s already read only\n",
-				       kdevname(-errorval));
 		} else {
 			if (newval < 0)
 				set_device_ro(-newval, 1);
--- 1.95/fs/partitions/check.c	Tue Feb 11 02:22:51 2003
+++ edited/fs/partitions/check.c	Sat Mar  1 11:23:32 2003
@@ -544,7 +544,6 @@
 	}
 
 	dname = kmalloc(sizeof(*dname), GFP_KERNEL);
-
 	if (!dname)
 		return nomem;
 	/*
@@ -558,7 +557,7 @@
 		put_disk(hd);
 	}
 	if (!dname->name) {
-		sprintf(dname->namebuf, "[dev %s]", kdevname(to_kdev_t(dev)));
+		sprintf(dname->namebuf, "[dev %s]", __bdevname(dev));
 		dname->name = dname->namebuf;
 	}
 
--- 1.221/include/linux/fs.h	Tue Feb 25 11:21:08 2003
+++ edited/include/linux/fs.h	Sat Mar  1 11:24:06 2003
@@ -1069,7 +1069,6 @@
 extern void close_bdev_excl(struct block_device *, int);
 
 extern const char * cdevname(kdev_t);
-extern const char * kdevname(kdev_t);
 extern void init_special_inode(struct inode *, umode_t, dev_t);
 
 /* Invalid inode operations -- fs/bad_inode.c */
--- 1.7/include/linux/kdev_t.h	Fri Nov  1 07:28:19 2002
+++ edited/include/linux/kdev_t.h	Sat Mar  1 11:24:02 2003
@@ -101,8 +101,6 @@
 #define NODEV		(mk_kdev(0,0))
 #define B_FREE		(mk_kdev(0xff,0xff))
 
-extern const char * kdevname(kdev_t);	/* note: returns pointer to static data! */
-
 static inline int kdev_same(kdev_t dev1, kdev_t dev2)
 {
 	return dev1.value == dev2.value;
--- 1.184/kernel/ksyms.c	Tue Feb 18 21:58:45 2003
+++ edited/kernel/ksyms.c	Sat Mar  1 11:23:54 2003
@@ -517,7 +517,6 @@
 EXPORT_SYMBOL(vsprintf);
 EXPORT_SYMBOL(vsnprintf);
 EXPORT_SYMBOL(vsscanf);
-EXPORT_SYMBOL(kdevname);
 EXPORT_SYMBOL(__bdevname);
 EXPORT_SYMBOL(cdevname);
 EXPORT_SYMBOL(simple_strtoull);
	
