Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265266AbSLMS50>; Fri, 13 Dec 2002 13:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265275AbSLMS50>; Fri, 13 Dec 2002 13:57:26 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:61096 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S265266AbSLMS5L>; Fri, 13 Dec 2002 13:57:11 -0500
Message-ID: <3DFA2F5C.2020702@namesys.com>
Date: Fri, 13 Dec 2002 22:05:00 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BK][PATCH] ReiserFS additional inode attributes support for 2.5.51
Content-Type: multipart/mixed;
 boundary="------------060705020206090309020502"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060705020206090309020502
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This adds such things as the immutable attribute to reiserfs, thereby 
making ReiserFS more conformant to the Linux (or at least ext2) norm.

--------------060705020206090309020502
Content-Type: message/rfc822;
 name="reiserfs inode attributes support for 2.5.51"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reiserfs inode attributes support for 2.5.51"

Return-Path: <green@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 24651 invoked from network); 13 Dec 2002 17:05:15 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 13 Dec 2002 17:05:15 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 521)
	id 0052A3542CA; Fri, 13 Dec 2002 20:05:14 +0300 (MSK)
Date: Fri, 13 Dec 2002 20:05:14 +0300
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: reiserfs inode attributes support for 2.5.51
Message-ID: <20021213200514.A8892@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i

Hello!

   These two changesets implement ext2 compatible extended inode attributes
   in reiserfs (the ones visible to lsattr(1) and friends).
   Second changeset also allows for some mount options to take effect on
   remount.
   Both changesets are forwardports from 2.4. Original work was performed
   by Nikita Danilov.

   You can pull these from bk://thebsh.namesys.com/bk/reiser3-linux-2.5-iattrs 

ChangeSet@1.846, 2002-12-07 14:29:56+03:00, green@angband.namesys.com
  reiserfs: Allow for remount options to take effect.

ChangeSet@1.845, 2002-12-07 14:26:28+03:00, green@angband.namesys.com
  reiserfs: Extended inode attributes support

Diffstat:
 fs/reiserfs/dir.c              |    1
 fs/reiserfs/inode.c            |   73 ++++++++++++++++++++++++++++++++++++-----
 fs/reiserfs/ioctl.c            |   62 ++++++++++++++++++++++++++++++++--
 fs/reiserfs/procfs.c           |    6 +++
 fs/reiserfs/super.c            |   36 ++++++++++++++++++++
 include/linux/reiserfs_fs.h    |   43 +++++++++++++++++++++++-
 include/linux/reiserfs_fs_i.h  |    3 +
 include/linux/reiserfs_fs_sb.h |    5 ++
 8 files changed, 215 insertions(+), 14 deletions(-)

Plain text patch:
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.844   -> 1.846  
#	fs/reiserfs/procfs.c	1.14    -> 1.15   
#	 fs/reiserfs/inode.c	1.68    -> 1.69   
#	 fs/reiserfs/ioctl.c	1.10    -> 1.11   
#	 fs/reiserfs/super.c	1.54    -> 1.56   
#	include/linux/reiserfs_fs_sb.h	1.20    -> 1.21   
#	   fs/reiserfs/dir.c	1.17    -> 1.18   
#	include/linux/reiserfs_fs_i.h	1.7     -> 1.8    
#	include/linux/reiserfs_fs.h	1.45    -> 1.46   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/07	green@angband.namesys.com	1.845
# reiserfs: Extended inode attributes support
# --------------------------------------------
# 02/12/07	green@angband.namesys.com	1.846
# reiserfs: Allow for remount options to take effect.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/dir.c b/fs/reiserfs/dir.c
--- a/fs/reiserfs/dir.c	Sat Dec  7 14:30:33 2002
+++ b/fs/reiserfs/dir.c	Sat Dec  7 14:30:33 2002
@@ -21,6 +21,7 @@
     read:	generic_read_dir,
     readdir:	reiserfs_readdir,
     fsync:	reiserfs_dir_fsync,
+    ioctl:	reiserfs_ioctl,
 };
 
 int reiserfs_dir_fsync(struct file *filp, struct dentry *dentry, int datasync) {
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Sat Dec  7 14:30:33 2002
+++ b/fs/reiserfs/inode.c	Sat Dec  7 14:30:33 2002
@@ -871,8 +871,6 @@
     REISERFS_I(inode)->i_prealloc_count = 0;
     REISERFS_I(inode)->i_trans_id = 0;
     REISERFS_I(inode)->i_trans_index = 0;
-    /* nopack = 0, by default */
-    REISERFS_I(inode)->i_flags &= ~i_nopack_mask;
 
     if (stat_data_v1 (ih)) {
 	struct stat_data_v1 * sd = (struct stat_data_v1 *)B_I_PITEM (bh, ih);
@@ -907,6 +905,9 @@
 
         rdev = sd_v1_rdev(sd);
 	REISERFS_I(inode)->i_first_direct_byte = sd_v1_first_direct_byte(sd);
+	/* nopack is initially zero for v1 objects. For v2 objects,
+	   nopack is initialised from sd_attrs */
+	REISERFS_I(inode)->i_flags &= ~i_nopack_mask;
     } else {
 	// new stat data found, but object may have old items
 	// (directories and symlinks)
@@ -936,6 +937,10 @@
 	    set_inode_item_key_version (inode, KEY_FORMAT_3_6);
 	REISERFS_I(inode)->i_first_direct_byte = 0;
 	set_inode_sd_version (inode, STAT_DATA_V2);
+	/* read persistent inode attributes from sd and initalise
+	   generic inode flags from them */
+	REISERFS_I(inode)->i_attrs = sd_v2_attrs( sd );
+	sd_attrs_to_i_attrs( sd_v2_attrs( sd ), inode );
     }
 
     pathrelse (path);
@@ -960,6 +965,7 @@
 static void inode2sd (void * sd, struct inode * inode)
 {
     struct stat_data * sd_v2 = (struct stat_data *)sd;
+    __u16 flags;
 
     set_sd_v2_mode(sd_v2, inode->i_mode );
     set_sd_v2_nlink(sd_v2, inode->i_nlink );
@@ -970,13 +976,13 @@
     set_sd_v2_atime(sd_v2, inode->i_atime.tv_sec );
     set_sd_v2_ctime(sd_v2, inode->i_ctime.tv_sec );
     set_sd_v2_blocks(sd_v2, inode->i_blocks );
-    if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
-        set_sd_v2_rdev(sd_v2, kdev_t_to_nr(inode->i_rdev) );
-}
+    if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
+	set_sd_v2_rdev(sd_v2, kdev_t_to_nr(inode->i_rdev) );
     else
-    {
-        set_sd_v2_generation(sd_v2, inode->i_generation);
-    }
+	set_sd_v2_generation(sd_v2, inode->i_generation);
+    flags = REISERFS_I(inode)->i_attrs;
+    i_attrs_to_sd_attrs( inode, &flags );
+    set_sd_v2_attrs( sd_v2, flags );
 }
 
 
@@ -1507,6 +1513,10 @@
 
     /* uid and gid must already be set by the caller for quota init */
 
+    /* symlink cannot be immutable or append only, right? */
+    if( S_ISLNK( inode -> i_mode ) )
+	    inode -> i_flags &= ~ ( S_IMMUTABLE | S_APPEND );
+
     inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
     inode->i_size = i_size;
     inode->i_blocks = (inode->i_size + 511) >> 9;
@@ -1519,6 +1529,9 @@
     REISERFS_I(inode)->i_prealloc_count = 0;
     REISERFS_I(inode)->i_trans_id = 0;
     REISERFS_I(inode)->i_trans_index = 0;
+    REISERFS_I(inode)->i_attrs =
+	REISERFS_I(dir)->i_attrs & REISERFS_INHERIT_MASK;
+    sd_attrs_to_i_attrs( REISERFS_I(inode) -> i_attrs, inode );
 
     if (old_format_only (sb))
 	make_le_item_head (&ih, 0, KEY_FORMAT_3_5, SD_OFFSET, TYPE_STAT_DATA, SD_V1_SIZE, MAX_US_INT);
@@ -2073,6 +2086,50 @@
 	reiserfs_write_unlock(inode->i_sb);
     }
     return ret ;
+}
+
+void sd_attrs_to_i_attrs( __u16 sd_attrs, struct inode *inode )
+{
+	if( reiserfs_attrs( inode -> i_sb ) ) {
+		if( sd_attrs & REISERFS_SYNC_FL )
+			inode -> i_flags |= S_SYNC;
+		else
+			inode -> i_flags &= ~S_SYNC;
+		if( sd_attrs & REISERFS_IMMUTABLE_FL )
+			inode -> i_flags |= S_IMMUTABLE;
+		else
+			inode -> i_flags &= ~S_IMMUTABLE;
+		if( sd_attrs & REISERFS_NOATIME_FL )
+			inode -> i_flags |= S_NOATIME;
+		else
+			inode -> i_flags &= ~S_NOATIME;
+		if( sd_attrs & REISERFS_NOTAIL_FL )
+			REISERFS_I(inode)->i_flags |= i_nopack_mask;
+		else
+			REISERFS_I(inode)->i_flags &= ~i_nopack_mask;
+	}
+}
+
+void i_attrs_to_sd_attrs( struct inode *inode, __u16 *sd_attrs )
+{
+	if( reiserfs_attrs( inode -> i_sb ) ) {
+		if( inode -> i_flags & S_IMMUTABLE )
+			*sd_attrs |= REISERFS_IMMUTABLE_FL;
+		else
+			*sd_attrs &= ~REISERFS_IMMUTABLE_FL;
+		if( inode -> i_flags & S_SYNC )
+			*sd_attrs |= REISERFS_SYNC_FL;
+		else
+			*sd_attrs &= ~REISERFS_SYNC_FL;
+		if( inode -> i_flags & S_NOATIME )
+			*sd_attrs |= REISERFS_NOATIME_FL;
+		else
+			*sd_attrs &= ~REISERFS_NOATIME_FL;
+		if( REISERFS_I(inode)->i_flags & i_nopack_mask )
+			*sd_attrs |= REISERFS_NOTAIL_FL;
+		else
+			*sd_attrs &= ~REISERFS_NOTAIL_FL;
+	}
 }
 
 /*
diff -Nru a/fs/reiserfs/ioctl.c b/fs/reiserfs/ioctl.c
--- a/fs/reiserfs/ioctl.c	Sat Dec  7 14:30:33 2002
+++ b/fs/reiserfs/ioctl.c	Sat Dec  7 14:30:33 2002
@@ -14,17 +14,70 @@
 ** supported commands:
 **  1) REISERFS_IOC_UNPACK - try to unpack tail from direct item into indirect
 **                           and prevent packing file (argument arg has to be non-zero)
-**  2) That's all for a while ...
+**  2) REISERFS_IOC_[GS]ETFLAGS, REISERFS_IOC_[GS]ETVERSION
+**  3) That's all for a while ...
 */
 int reiserfs_ioctl (struct inode * inode, struct file * filp, unsigned int cmd,
 		unsigned long arg)
 {
+	unsigned int flags;
+
 	switch (cmd) {
 	    case REISERFS_IOC_UNPACK:
+		if( S_ISREG( inode -> i_mode ) ) {
 		if (arg)
 		    return reiserfs_unpack (inode, filp);
+			else
+				return 0;
+		} else
+			return -ENOTTY;
+	/* following two cases are taken from fs/ext2/ioctl.c by Remy
+	   Card (card@masi.ibp.fr) */
+	case REISERFS_IOC_GETFLAGS:
+		flags = REISERFS_I(inode) -> i_attrs;
+		i_attrs_to_sd_attrs( inode, ( __u16 * ) &flags );
+		return put_user(flags, (int *) arg);
+	case REISERFS_IOC_SETFLAGS: {
+		if (IS_RDONLY(inode))
+			return -EROFS;
+
+		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
+			return -EPERM;
+
+		if (get_user(flags, (int *) arg))
+			return -EFAULT;
+
+		if ( ( flags & REISERFS_IMMUTABLE_FL ) && 
+		     !capable( CAP_LINUX_IMMUTABLE ) )
+			return -EPERM;
 			
-	    default:
+		if( ( flags & REISERFS_NOTAIL_FL ) &&
+		    S_ISREG( inode -> i_mode ) ) {
+				int result;
+
+				result = reiserfs_unpack( inode, filp );
+				if( result )
+					return result;
+		}
+		sd_attrs_to_i_attrs( flags, inode );
+		REISERFS_I(inode) -> i_attrs = flags;
+		inode->i_ctime = CURRENT_TIME;
+		mark_inode_dirty(inode);
+		return 0;
+	}
+	case REISERFS_IOC_GETVERSION:
+		return put_user(inode->i_generation, (int *) arg);
+	case REISERFS_IOC_SETVERSION:
+		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
+			return -EPERM;
+		if (IS_RDONLY(inode))
+			return -EROFS;
+		if (get_user(inode->i_generation, (int *) arg))
+			return -EFAULT;	
+		inode->i_ctime = CURRENT_TIME;
+		mark_inode_dirty(inode);
+		return 0;
+	default:
 		return -ENOTTY;
 	}
 }
@@ -32,7 +85,7 @@
 /*
 ** reiserfs_unpack
 ** Function try to convert tail from direct item into indirect.
-** It set up nopack attribute in the inode.u.reiserfs_i.nopack
+** It set up nopack attribute in the REISERFS_I(inode)->nopack
 */
 int reiserfs_unpack (struct inode * inode, struct file * filp)
 {
@@ -43,7 +96,8 @@
     unsigned long blocksize = inode->i_sb->s_blocksize ;
     	
     if (inode->i_size == 0) {
-        return -EINVAL ;
+        REISERFS_I(inode)->i_flags |= i_nopack_mask;
+        return 0 ;
     }
     /* ioctl already done */
     if (REISERFS_I(inode)->i_flags & i_nopack_mask) {
diff -Nru a/fs/reiserfs/procfs.c b/fs/reiserfs/procfs.c
--- a/fs/reiserfs/procfs.c	Sat Dec  7 14:30:32 2002
+++ b/fs/reiserfs/procfs.c	Sat Dec  7 14:30:32 2002
@@ -350,6 +350,7 @@
 	struct reiserfs_sb_info *sb_info;
 	struct reiserfs_super_block *rs;
 	int hash_code;
+	__u32 flags;
 	int len = 0;
     
 	sb = procinfo_prologue((dev_t)data);
@@ -358,6 +359,7 @@
 	sb_info = REISERFS_SB(sb);
 	rs = sb_info -> s_rs;
 	hash_code = DFL( s_hash_function_code );
+	flags = DJF( s_flags );
 
 	len += sprintf( &buffer[ len ], 
 			"block_count: \t%i\n"
@@ -373,6 +375,7 @@
 			"tree_height: \t%i\n"
 			"bmap_nr: \t%i\n"
 			"version: \t%i\n"
+			"flags: \t%x[%s]\n"
 			"reserved_for_journal: \t%i\n",
 
 			DFL( s_block_count ),
@@ -391,6 +394,9 @@
 			DF( s_tree_height ),
 			DF( s_bmap_nr ),
 			DF( s_version ),
+			flags,
+			( flags & reiserfs_attrs_cleared )
+			? "attrs_cleared" : "",
 			DF (s_reserved_for_journal));
 
 	procinfo_epilogue( sb );
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Sat Dec  7 14:30:33 2002
+++ b/fs/reiserfs/super.c	Sat Dec  7 14:30:33 2002
@@ -697,6 +697,24 @@
     return 1;
 }
 
+static void handle_attrs( struct super_block *s )
+{
+	struct reiserfs_super_block * rs;
+
+	if( reiserfs_attrs( s ) ) {
+		rs = SB_DISK_SUPER_BLOCK (s);
+		if( old_format_only(s) ) {
+			reiserfs_warning( "reiserfs: cannot support attributes on 3.5.x disk format\n" );
+			REISERFS_SB(s) -> s_mount_opt &= ~ ( 1 << REISERFS_ATTRS );
+			return;
+		}
+		if( !( le32_to_cpu( rs -> s_flags ) & reiserfs_attrs_cleared ) ) {
+				reiserfs_warning( "reiserfs: cannot support attributes until flag is set in super-block\n" );
+				REISERFS_SB(s) -> s_mount_opt &= ~ ( 1 << REISERFS_ATTRS );
+		}
+	}
+}
+
 static int reiserfs_remount (struct super_block * s, int * mount_flags, char * arg)
 {
   struct reiserfs_super_block * rs;
@@ -708,7 +726,23 @@
 
   if (!reiserfs_parse_options(s, arg, &mount_options, &blocks, NULL))
     return -EINVAL;
+
+#define SET_OPT( opt, bits, super )                                     \
+    if( ( bits ) & ( 1 << ( opt ) ) )                                   \
+            REISERFS_SB( super ) -> s_mount_opt |= ( 1 << ( opt ) )
+
+  /* set options in the super-block bitmask */
+  SET_OPT( REISERFS_LARGETAIL, mount_options, s );
+  SET_OPT( REISERFS_SMALLTAIL, mount_options, s );
+  SET_OPT( REISERFS_NO_BORDER, mount_options, s );
+  SET_OPT( REISERFS_NO_UNHASHED_RELOCATION, mount_options, s );
+  SET_OPT( REISERFS_HASHED_RELOCATION, mount_options, s );
+  SET_OPT( REISERFS_TEST4, mount_options, s );
+  SET_OPT( REISERFS_ATTRS, mount_options, s );
+#undef SET_OPT
   
+  handle_attrs( s );
+
   if(blocks) {
     int rc = reiserfs_resize(s, blocks);
     if (rc != 0)
@@ -1303,6 +1337,8 @@
     }
     // mark hash in super block: it could be unset. overwrite should be ok
     set_sb_hash_function_code( rs, function2code(sbi->s_hash_function ) );
+
+    handle_attrs( s );
 
     reiserfs_proc_info_init( s );
     reiserfs_proc_register( s, "version", reiserfs_version_in_proc );
diff -Nru a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
--- a/include/linux/reiserfs_fs.h	Sat Dec  7 14:30:33 2002
+++ b/include/linux/reiserfs_fs.h	Sat Dec  7 14:30:33 2002
@@ -872,11 +872,41 @@
 #define set_sd_v1_first_direct_byte(sdp,v) \
                                 ((sdp)->sd_first_direct_byte = cpu_to_le32(v))
 
+#include <linux/ext2_fs.h>
+
+/* inode flags stored in sd_attrs (nee sd_reserved) */
+
+/* we want common flags to have the same values as in ext2,
+   so chattr(1) will work without problems */
+#define REISERFS_IMMUTABLE_FL EXT2_IMMUTABLE_FL
+#define REISERFS_SYNC_FL      EXT2_SYNC_FL
+#define REISERFS_NOATIME_FL   EXT2_NOATIME_FL
+#define REISERFS_NODUMP_FL    EXT2_NODUMP_FL
+#define REISERFS_SECRM_FL     EXT2_SECRM_FL
+#define REISERFS_UNRM_FL      EXT2_UNRM_FL
+#define REISERFS_COMPR_FL     EXT2_COMPR_FL
+/* persistent flag to disable tails on per-file basic.
+   Note, that is inheritable: mark directory with this and
+   all new files inside will not have tails. 
+
+   Teodore Tso allocated EXT2_NODUMP_FL (0x00008000) for this. Change
+   numeric constant to ext2 macro when available. */
+#define REISERFS_NOTAIL_FL    (0x00008000) /* EXT2_NOTAIL_FL */
+
+/* persistent flags that file inherits from the parent directory */
+#define REISERFS_INHERIT_MASK ( REISERFS_IMMUTABLE_FL |	\
+				REISERFS_SYNC_FL |	\
+				REISERFS_NOATIME_FL |	\
+				REISERFS_NODUMP_FL |	\
+				REISERFS_SECRM_FL |	\
+				REISERFS_COMPR_FL |	\
+				REISERFS_NOTAIL_FL )
+
 /* Stat Data on disk (reiserfs version of UFS disk inode minus the
    address blocks) */
 struct stat_data {
     __u16 sd_mode;	/* file type, permissions */
-    __u16 sd_reserved;
+    __u16 sd_attrs;     /* persistent inode flags */
     __u32 sd_nlink;	/* number of hard links */
     __u64 sd_size;	/* file size */
     __u32 sd_uid;		/* owner */
@@ -929,6 +959,8 @@
 #define set_sd_v2_rdev(sdp,v)   ((sdp)->u.sd_rdev = cpu_to_le32(v))
 #define sd_v2_generation(sdp)   (le32_to_cpu((sdp)->u.sd_generation))
 #define set_sd_v2_generation(sdp,v) ((sdp)->u.sd_generation = cpu_to_le32(v))
+#define sd_v2_attrs(sdp)         (le16_to_cpu((sdp)->sd_attrs))
+#define set_sd_v2_attrs(sdp,v)   ((sdp)->sd_attrs = cpu_to_le16(v))
 
 
 /***************************************************************************/
@@ -1870,6 +1902,9 @@
 int reiserfs_sync_inode (struct reiserfs_transaction_handle *th, struct inode * inode);
 void reiserfs_update_sd (struct reiserfs_transaction_handle *th, struct inode * inode);
 
+void sd_attrs_to_i_attrs( __u16 sd_attrs, struct inode *inode );
+void i_attrs_to_sd_attrs( struct inode *inode, __u16 *sd_attrs );
+
 /* namei.c */
 inline void set_de_name_and_namelen (struct reiserfs_dir_entry * de);
 int search_by_entry_key (struct super_block * sb, const struct cpu_key * key, 
@@ -2142,6 +2177,12 @@
  
 /* ioctl's command */
 #define REISERFS_IOC_UNPACK		_IOW(0xCD,1,long)
+/* define following flags to be the same as in ext2, so that chattr(1),
+   lsattr(1) will work with us. */
+#define REISERFS_IOC_GETFLAGS		EXT2_IOC_GETFLAGS
+#define REISERFS_IOC_SETFLAGS		EXT2_IOC_SETFLAGS
+#define REISERFS_IOC_GETVERSION		EXT2_IOC_GETVERSION
+#define REISERFS_IOC_SETVERSION		EXT2_IOC_SETVERSION
 
 /* Locking primitives */
 /* Right now we are still falling back to (un)lock_kernel, but eventually that
diff -Nru a/include/linux/reiserfs_fs_i.h b/include/linux/reiserfs_fs_i.h
--- a/include/linux/reiserfs_fs_i.h	Sat Dec  7 14:30:33 2002
+++ b/include/linux/reiserfs_fs_i.h	Sat Dec  7 14:30:33 2002
@@ -32,6 +32,9 @@
 
     __u32 i_first_direct_byte; // offset of first byte stored in direct item.
 
+    /* copy of persistent inode flags read from sd_attrs. */
+    __u32 i_attrs;
+
     int i_prealloc_block; /* first unused block of a sequence of unused blocks */
     int i_prealloc_count; /* length of that sequence */
     struct list_head i_prealloc_list; /* per-transaction list of inodes which
diff -Nru a/include/linux/reiserfs_fs_sb.h b/include/linux/reiserfs_fs_sb.h
--- a/include/linux/reiserfs_fs_sb.h	Sat Dec  7 14:30:33 2002
+++ b/include/linux/reiserfs_fs_sb.h	Sat Dec  7 14:30:33 2002
@@ -8,6 +8,9 @@
 #include <linux/workqueue.h>
 #endif
 
+typedef enum {
+  reiserfs_attrs_cleared	= 0x00000001,
+} reiserfs_super_block_flags;
 
 /* struct reiserfs_super_block accessors/mutators
  * since this is a disk structure, it will always be in 
@@ -435,7 +438,6 @@
 #define REISERFS_NO_BORDER 11
 #define REISERFS_NO_UNHASHED_RELOCATION 12
 #define REISERFS_HASHED_RELOCATION 13
-#define REISERFS_TEST4 14 
 
 #define REISERFS_ATTRS 15
 
@@ -457,6 +459,7 @@
 #define have_small_tails(s) (REISERFS_SB(s)->s_mount_opt & (1 << REISERFS_SMALLTAIL))
 #define replay_only(s) (REISERFS_SB(s)->s_mount_opt & (1 << REPLAYONLY))
 #define reiserfs_dont_log(s) (REISERFS_SB(s)->s_mount_opt & (1 << REISERFS_NOLOG))
+#define reiserfs_attrs(s) (REISERFS_SB(s)->s_mount_opt & (1 << REISERFS_ATTRS))
 #define old_format_only(s) (REISERFS_SB(s)->s_properties & (1 << REISERFS_3_5))
 #define convert_reiserfs(s) (REISERFS_SB(s)->s_mount_opt & (1 << REISERFS_CONVERT))
 



--------------060705020206090309020502--

