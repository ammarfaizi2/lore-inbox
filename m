Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318599AbSIFNuJ>; Fri, 6 Sep 2002 09:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318601AbSIFNuJ>; Fri, 6 Sep 2002 09:50:09 -0400
Received: from angband.namesys.com ([212.16.7.85]:52665 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S318599AbSIFNuG>; Fri, 6 Sep 2002 09:50:06 -0400
Date: Fri, 6 Sep 2002 17:54:39 +0400
From: Oleg Drokin <green@namesys.com>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: "David S. Miller" <davem@redhat.com>, szepe@pinerecords.com,
       mason@suse.com, linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       linuxjfs@us.ibm.com
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
Message-ID: <20020906175439.A21036@namesys.com>
References: <3D76A6FF.509@namesys.com> <200209051109.12291.shaggy@austin.ibm.com> <20020905201337.A4698@namesys.com> <200209051258.27366.shaggy@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200209051258.27366.shaggy@austin.ibm.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Sep 05, 2002 at 12:58:27PM -0500, Dave Kleikamp wrote:
> Here's the JFS patch.  When I first saw this thread I didn't expect that
> the result would be increasing the max. number of links.  :^)
> Note that I made JFS_LINK_MAX the maximum supported by JFS,
> and VFS_LINK_MAX as the number limited by the size of nlink_t.
> VFS_LINK_MAX could be moved to fs.h if other file systems are
> to use it in the same way.
> I borrowed reiserfs's *_INODE_NLINK macros, but made them inline functions.
> (I don't usually send patches from kmail.  I hope it doesn't screw up the formatting.)

Actually Linus' suggestion to change type of struct inode.i_nlink field is
better because otherwise everybody will implement that "real nlink" stuff.
I hope Marcello will accept such a patch.
Here is it (both reiserfs and jfs bits).

Hm. jfs patch became really small ;)

Note I do not play this "if directory, then set nlink to 1" games.
As it was already explained it will only lead to find(1) and others still
count only (nlink_t) -1 links, so not all of the links will be counted, but
exactly the same amount as we present in st_nlink field on arches
that have unsigned nlink_t and probably none on those with signed nlink_t.

Patch is against 2.4.20-pre5.

Bye,
    Oleg

===== fs/stat.c 1.4 vs edited =====
--- 1.4/fs/stat.c	Tue Feb  5 10:45:18 2002
+++ edited/fs/stat.c	Fri Sep  6 17:35:02 2002
@@ -49,7 +49,7 @@
 	tmp.st_dev = kdev_t_to_nr(inode->i_dev);
 	tmp.st_ino = inode->i_ino;
 	tmp.st_mode = inode->i_mode;
-	tmp.st_nlink = inode->i_nlink;
+	tmp.st_nlink = min_t(unsigned int, MAX_NLINK_T, inode->i_nlink);
 	SET_OLDSTAT_UID(tmp, inode->i_uid);
 	SET_OLDSTAT_GID(tmp, inode->i_gid);
 	tmp.st_rdev = kdev_t_to_nr(inode->i_rdev);
@@ -75,7 +75,7 @@
 	tmp.st_dev = kdev_t_to_nr(inode->i_dev);
 	tmp.st_ino = inode->i_ino;
 	tmp.st_mode = inode->i_mode;
-	tmp.st_nlink = inode->i_nlink;
+	tmp.st_nlink = min_t(unsigned int, MAX_NLINK_T, inode->i_nlink);
 	SET_STAT_UID(tmp, inode->i_uid);
 	SET_STAT_GID(tmp, inode->i_gid);
 	tmp.st_rdev = kdev_t_to_nr(inode->i_rdev);
@@ -282,7 +282,7 @@
 	tmp.__st_ino = inode->i_ino;
 #endif
 	tmp.st_mode = inode->i_mode;
-	tmp.st_nlink = inode->i_nlink;
+	tmp.st_nlink = min_t(unsigned int, MAX_NLINK_T, inode->i_nlink);
 	tmp.st_uid = inode->i_uid;
 	tmp.st_gid = inode->i_gid;
 	tmp.st_rdev = kdev_t_to_nr(inode->i_rdev);
===== fs/jfs/jfs_filsys.h 1.1 vs edited =====
--- 1.1/fs/jfs/jfs_filsys.h	Fri May 31 17:19:24 2002
+++ edited/fs/jfs/jfs_filsys.h	Fri Sep  6 17:33:32 2002
@@ -125,7 +125,11 @@
 #define MAXBLOCKSIZE		4096
 #define	MAXFILESIZE		((s64)1 << 52)
 
-#define JFS_LINK_MAX		65535	/* nlink_t is unsigned short */
+/*
+ * The max link count in struct inode is limited to the size of nlink_t.
+ * The JFS inode uses an unsigned 32-bit int, so we can really go higher
+ */
+#define JFS_LINK_MAX	0xffffffff	/* real limit */
 
 /* Minimum number of bytes supported for a JFS partition */
 #define MINJFS			(0x1000000)
===== fs/reiserfs/namei.c 1.24 vs edited =====
--- 1.24/fs/reiserfs/namei.c	Fri Aug  9 19:22:33 2002
+++ edited/fs/reiserfs/namei.c	Fri Sep  6 17:23:34 2002
@@ -8,8 +8,13 @@
 #include <linux/reiserfs_fs.h>
 #include <linux/smp_lock.h>
 
-#define INC_DIR_INODE_NLINK(i) if (i->i_nlink != 1) { i->i_nlink++; if (i->i_nlink >= REISERFS_LINK_MAX) i->i_nlink=1; }
-#define DEC_DIR_INODE_NLINK(i) if (i->i_nlink != 1) i->i_nlink--;
+// v3.5 files have 16bit nlink_t, v3.6 files have 32bit nlink_t.
+#define CAN_INCREASE_NLINK(i) ( i->i_nlink < ((get_inode_sd_version (i) != KEY_FORMAT_3_5)?MAX_UL_INT:MAX_US_INT)) 
+
+// Compatibility stuff with old trick that allowed to have lots of subdirs in
+// one dir. Such dirs had 1 as their nlink count.
+#define INC_DIR_INODE_NLINK(i) { if (i->i_nlink != 1) i->i_nlink++;}
+#define DEC_DIR_INODE_NLINK(i) { if (i->i_nlink != 1) i->i_nlink--;}
 
 // directory item contains array of entry headers. This performs
 // binary search through that array
@@ -592,6 +597,9 @@
     struct reiserfs_transaction_handle th ;
     int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3; 
 
+    if ( !CAN_INCREASE_NLINK(dir) )
+	return -EMLINK;
+
     if (!(inode = new_inode(dir->i_sb))) {
 	return -ENOMEM ;
     }
@@ -613,7 +621,7 @@
 				dentry, inode, &retval);
     if (!inode) {
 	pop_journal_writer(windex) ;
-	dir->i_nlink-- ;
+	DEC_DIR_INODE_NLINK(dir);
 	journal_end(&th, dir->i_sb, jbegin_count) ;
 	return retval;
     }
@@ -896,8 +904,7 @@
     if (S_ISDIR(inode->i_mode))
 	return -EPERM;
   
-    if (inode->i_nlink >= REISERFS_LINK_MAX) {
-	//FIXME: sd_nlink is 32 bit for new files
+    if (!CAN_INCREASE_NLINK(inode)) {
 	return -EMLINK;
     }
 
@@ -1021,6 +1028,8 @@
 	// and that its new parent directory has not too many links
 	// already
 
+	if ( !CAN_INCREASE_NLINK(new_dir) )
+	    return -EMLINK;
 	if (new_dentry_inode) {
 	    if (!reiserfs_empty_dir(new_dentry_inode)) {
 		return -ENOTEMPTY;
===== include/linux/fs.h 1.68 vs edited =====
--- 1.68/include/linux/fs.h	Fri Aug 23 17:27:33 2002
+++ edited/include/linux/fs.h	Fri Sep  6 17:43:02 2002
@@ -442,7 +442,7 @@
 	atomic_t		i_count;
 	kdev_t			i_dev;
 	umode_t			i_mode;
-	nlink_t			i_nlink;
+	unsigned int		i_nlink;
 	uid_t			i_uid;
 	gid_t			i_gid;
 	kdev_t			i_rdev;
@@ -513,6 +513,11 @@
 		void				*generic_ip;
 	} u;
 };
+
+/* maximal nlink_t value possible. Used insead of very high i_nlink values
+   that some filesystems might allow to prevent user visible negative
+   nlink counts. */
+#define MAX_NLINK_T (nlink_t)((((nlink_t) -1) > 0)?~0:((1u<<(sizeof(nlink_t)*8-1))-1))
 
 struct fown_struct {
 	int pid;		/* pid or -pgrp where SIGIO should be sent */
===== include/linux/reiserfs_fs.h 1.22 vs edited =====
--- 1.22/include/linux/reiserfs_fs.h	Tue Aug 20 13:40:53 2002
+++ edited/include/linux/reiserfs_fs.h	Fri Sep  6 17:44:53 2002
@@ -1163,7 +1163,6 @@
 #define INODE_PKEY(inode) ((struct key *)((inode)->u.reiserfs_i.i_key))
 
 #define MAX_UL_INT 0xffffffff
-#define MAX_INT    0x7ffffff
 #define MAX_US_INT 0xffff
 
 // reiserfs version 2 has max offset 60 bits. Version 1 - 32 bit offset
@@ -1184,10 +1183,6 @@
 
 #define MAX_B_NUM  MAX_UL_INT
 #define MAX_FC_NUM MAX_US_INT
-
-
-/* the purpose is to detect overflow of an unsigned short */
-#define REISERFS_LINK_MAX (MAX_US_INT - 1000)
 
 
 /* The following defines are used in reiserfs_insert_item and reiserfs_append_item  */
