Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317540AbSHaPPD>; Sat, 31 Aug 2002 11:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317541AbSHaPPC>; Sat, 31 Aug 2002 11:15:02 -0400
Received: from pcp01386304pcs.walngs01.pa.comcast.net ([68.80.55.149]:61854
	"EHLO dysonwi.dyndns.org") by vger.kernel.org with ESMTP
	id <S317540AbSHaPOi>; Sat, 31 Aug 2002 11:14:38 -0400
Subject: [PATCH] 2.4.20-pre5 BeFS updates
From: Will Dyson <will_dyson@pobox.com>
To: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-r8W4wMCP5gO96AVjWDHa"
X-Mailer: Ximian Evolution 1.0.8 
Date: 31 Aug 2002 11:19:04 -0400
Message-Id: <1030807144.10613.731.camel@dysonwi.dyndns.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-r8W4wMCP5gO96AVjWDHa
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I have only been working on the BeFS filesystem occasionally for the
past couple of months. But now that it is going into 2.4.20, I figure it
would be a good time to post an update of what I have done.

This patch agains 2.4.20-pre5:

* Adds Configure.help entries for BeFS (present in the -ac kernels, but
apparently dropped in the merge with mainline)

* Updates the project URL in MAINTAINERS

* Fixes a bug that prevents BeFS from working on little-endian systems
(credits to Sergey S. Kostyliov <rathamahata@php4.ru> )

* Splits up a nasty monolithic header (befs_fs.h) into peices

* Changes all instances of __u16 and friends to corresponding u16
equivalents

* Removes some #defines that were only there so that the driver would
work in older kernels (compatibility.h

-- 
Will Dyson
"Back off man, I'm a scientist!" -Dr. Peter Venkman

--=-r8W4wMCP5gO96AVjWDHa
Content-Disposition: attachment; filename=befs-head-update.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=befs-head-update.patch; charset=ISO-8859-1

Index: linux/MAINTAINERS
diff -u linux/MAINTAINERS:1.1.1.6 linux/MAINTAINERS:1.10
--- linux/MAINTAINERS:1.1.1.6	Fri Aug 30 16:45:56 2002
+++ linux/MAINTAINERS	Fri Aug 30 19:42:40 2002
@@ -245,7 +245,7 @@
 BEFS FILE SYSTEM
 P:	Will Dyson
 M:	will@cs.earlham.edu
-W:	http://cs.earlham.edu/~will/software/linux/kernel/BeFS.html
+W:	http://befs-driver.sourceforge.net/
 S:	Maintained
=20
 BERKSHIRE PRODUCTS PC WATCHDOG DRIVER
Index: linux/Documentation/Configure.help
diff -u linux/Documentation/Configure.help:1.1.1.6 linux/Documentation/Conf=
igure.help:1.7
--- linux/Documentation/Configure.help:1.1.1.6	Fri Aug 30 16:46:17 2002
+++ linux/Documentation/Configure.help	Fri Aug 30 19:52:48 2002
@@ -14812,6 +14812,35 @@
   Because this option adds considerably to the size of each buffer,
   most people will want to say N here.
=20
+BeOS filesystem support (BeFS) (read only)
+CONFIG_BEFS_FS
+  The BeOS File System (BeFS) is the native file system of Be, Inc's
+  BeOS. Notable features include support for arbitrary attributes
+  on files and directories, and database-like indices on selected
+  attributes. (Also note that this driver doesn't make those features
+  available at this time). It is a 64 bit filesystem, so it supports
+  extreemly large volumes and files.
+
+  If you use this filesystem, you should also say Y to at least one
+  of the NLS (native language support) options below.
+
+  If you don't know what this is about, say N.
+
+  If you want to compile this as a module ( =3D code which can be
+  inserted in and removed from the running kernel whenever you want),
+  say M here and read Documentation/modules.txt. The module will be
+  called befs.o.
+
+Debug BeFS
+CONFIG_BEFS_DEBUG
+  If you say Y here, you can use the 'debug' mount option to enable
+  debugging output from the driver. This is unlike previous versions
+  of the driver, where enableing this option would turn on debugging
+  output automaticly.
+ =20
+  Example:
+  mount -t befs /dev/hda2 /mnt -o debug
+
 BFS file system support
 CONFIG_BFS_FS
   Boot File System (BFS) is a file system used under SCO UnixWare to
Index: linux/fs/befs/TODO
diff -u linux/fs/befs/TODO:1.1.1.1 linux/fs/befs/TODO:1.16
--- linux/fs/befs/TODO:1.1.1.1	Wed Aug 28 01:29:00 2002
+++ linux/fs/befs/TODO	Fri Aug 30 19:52:48 2002
@@ -3,14 +3,9 @@
=20
 * Convert comments to the Kernel-Doc format.
=20
-* Befs_fs.h has gotten big and messy. No reason not to break it up into=20
-	smaller peices.
-
 * See if Alexander Viro's option parser made it into the kernel tree.=20
 	Use that if we can. (include/linux/parser.h)
=20
 * See if we really need separate types for on-disk and in-memory=20
 	representations of the superblock and inode.
=20
-* We need a wrapper around the kernel's disk cache stuff. Then it would be=
=20
-	easy to slip in stuff like using the pagecache.
Index: linux/fs/befs/attribute.c
diff -u linux/fs/befs/attribute.c:1.1.1.1 linux/fs/befs/attribute.c:1.5
--- linux/fs/befs/attribute.c:1.1.1.1	Wed Aug 28 01:29:00 2002
+++ linux/fs/befs/attribute.c	Fri Aug 30 20:41:04 2002
@@ -12,7 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
=20
-#include "befs_fs.h"
+#include "befs.h"
 #include "endian.h"
=20
 #define SD_DATA(sd)\
@@ -27,7 +27,6 @@
=20
 befs_small_data *find_small_data(struct super_block *sb, befs_inode * inod=
e,
 				 const char *name);
-
 int
  read_small_data(struct super_block *sb, befs_inode * inode,
 		 befs_small_data * sdata, void *buf, size_t bufsize);
Index: linux/fs/befs/befs.h
diff -u /dev/null linux/fs/befs/befs.h:1.2
--- /dev/null	Fri Aug 30 20:41:31 2002
+++ linux/fs/befs/befs.h	Fri Aug 30 20:41:04 2002
@@ -0,0 +1,152 @@
+/*
+ * befs_fs.h
+ *
+ * Copyright (C) 2001-2002 Will Dyson <will_dyson@pobox.com>
+ * Copyright (C) 1999 Makoto Kato (m_kato@ga2.so-net.ne.jp)
+ */
+
+#ifndef _LINUX_BEFS_H
+#define _LINUX_BEFS_H
+
+#include "befs_fs_types.h"
+
+/* used in debug.c */
+#define BEFS_VERSION "0.9.3"
+
+typedef u64 befs_blocknr_t;
+typedef u32 vfs_blocknr_t;
+
+/*
+ * BeFS in memory structures
+ */
+
+typedef struct befs_mount_options {
+	gid_t gid;
+	uid_t uid;
+	int use_gid;
+	int use_uid;
+	int debug;
+	char *iocharset;
+} befs_mount_options;
+
+typedef struct befs_sb_info {
+	u32 magic1;
+	u32 block_size;
+	u32 block_shift;
+	int byte_order;
+	befs_off_t num_blocks;
+	befs_off_t used_blocks;
+	u32 inode_size;
+	u32 magic2;
+
+	/* Allocation group information */
+	u32 blocks_per_ag;
+	u32 ag_shift;
+	u32 num_ags;
+
+	/* jornal log entry */
+	befs_block_run log_blocks;
+	befs_off_t log_start;
+	befs_off_t log_end;
+
+	befs_inode_addr root_dir;
+	befs_inode_addr indices;
+	u32 magic3;
+
+	befs_mount_options mount_opts;
+	struct nls_table *nls;
+
+} befs_sb_info;
+
+typedef struct befs_inode_info {
+	u32 i_flags;
+	u32 i_type;
+
+	befs_inode_addr i_inode_num;
+	befs_inode_addr i_parent;
+	befs_inode_addr i_attribute;
+
+	union {
+		befs_data_stream ds;
+		char symlink[BEFS_SYMLINK_LEN];
+	} i_data;
+
+} befs_inode_info;
+
+enum befs_err {
+	BEFS_OK,
+	BEFS_ERR,
+	BEFS_BAD_INODE,
+	BEFS_BT_END,
+	BEFS_BT_EMPTY,
+	BEFS_BT_MATCH,
+	BEFS_BT_PARMATCH,
+	BEFS_BT_NOT_FOUND
+};
+
+/****************************/
+/* debug.c */
+void befs_error(const struct super_block *sb, const char *fmt, ...);
+void befs_warning(const struct super_block *sb, const char *fmt, ...);
+void befs_debug(const struct super_block *sb, const char *fmt, ...);
+
+void befs_dump_super_block(const struct super_block *sb, befs_super_block =
*);
+void befs_dump_inode(const struct super_block *sb, befs_inode *);
+void befs_dump_index_entry(const struct super_block *sb, befs_btree_super =
*);
+void befs_dump_index_node(const struct super_block *sb, befs_btree_nodehea=
d *);
+void befs_dump_inode_addr(const struct super_block *sb, befs_inode_addr);
+/****************************/
+
+/* Gets a pointer to the private portion of the super_block
+ * structure from the public part
+ */
+static inline befs_sb_info *
+BEFS_SB(const struct super_block *super)
+{
+	return (befs_sb_info *) super->u.generic_sbp;
+}
+
+static inline befs_inode_info *
+BEFS_I(const struct inode *inode)
+{
+	return (befs_inode_info *) inode->u.generic_ip;
+}
+
+static inline befs_blocknr_t
+iaddr2blockno(struct super_block *sb, befs_inode_addr * iaddr)
+{
+	return ((iaddr->allocation_group << BEFS_SB(sb)->ag_shift) +
+		iaddr->start);
+}
+
+static inline befs_inode_addr
+blockno2iaddr(struct super_block *sb, befs_blocknr_t blockno)
+{
+	befs_inode_addr iaddr;
+	iaddr.allocation_group =3D blockno >> BEFS_SB(sb)->ag_shift;
+	iaddr.start =3D
+	    blockno - (iaddr.allocation_group << BEFS_SB(sb)->ag_shift);
+	iaddr.len =3D 1;
+
+	return iaddr;
+}
+
+static inline unsigned int
+befs_iaddrs_per_block(struct super_block *sb)
+{
+	return BEFS_SB(sb)->block_size / sizeof (befs_inode_addr);
+}
+
+static inline int
+befs_iaddr_is_empty(befs_inode_addr * iaddr)
+{
+	return (!iaddr->allocation_group) && (!iaddr->start) && (!iaddr->len);
+}
+
+static inline size_t
+befs_brun_size(struct super_block *sb, befs_block_run run)
+{
+	return BEFS_SB(sb)->block_size * run.len;
+}
+
+#endif				/* _LINUX_BEFS_H */
Index: linux/fs/befs/befs_fs.h
diff -u linux/fs/befs/befs_fs.h:1.1.1.2 linux/fs/befs/befs_fs.h:removed
--- linux/fs/befs/befs_fs.h:1.1.1.2	Wed Aug 28 01:29:00 2002
+++ linux/fs/befs/befs_fs.h	Fri Aug 30 20:41:31 2002
@@ -1,200 +0,0 @@
-/*
- * befs_fs.h
- *
- * Copyright (C) 2001-2002 Will Dyson <will_dyson@pobox.com>
- * Copyright (C) 1999 Makoto Kato (m_kato@ga2.so-net.ne.jp)
- */
-
-#ifndef _LINUX_BEFS_FS
-#define _LINUX_BEFS_FS
-
-#include "befs_fs_types.h"
-#include "compatibility.h"
-
-/* used in debug.c */
-#define BEFS_VERSION "0.9.2"
-
-typedef __u64 befs_blocknr_t;
-typedef __u32 vfs_blocknr_t;
-
-/*
- * BeFS in memory structures
- */
-
-typedef struct befs_mount_options {
-	gid_t gid;
-	uid_t uid;
-	int use_gid;
-	int use_uid;
-	int debug;
-	char *iocharset;
-} befs_mount_options;
-
-typedef struct befs_sb_info {
-	__u32 magic1;
-	__u32 block_size;
-	__u32 block_shift;
-	__u32 byte_order;
-	befs_off_t num_blocks;
-	befs_off_t used_blocks;
-	__u32 inode_size;
-	__u32 magic2;
-
-	/* Allocation group information */
-	__u32 blocks_per_ag;
-	__u32 ag_shift;
-	__u32 num_ags;
-
-	/* jornal log entry */
-	befs_block_run log_blocks;
-	befs_off_t log_start;
-	befs_off_t log_end;
-
-	befs_inode_addr root_dir;
-	befs_inode_addr indices;
-	__u32 magic3;
-
-	befs_mount_options mount_opts;
-	struct nls_table *nls;
-
-} befs_sb_info;
-
-typedef struct befs_inode_info {
-	__u32 i_flags;
-	__u32 i_type;
-
-	befs_inode_addr i_inode_num;
-	befs_inode_addr i_parent;
-	befs_inode_addr i_attribute;
-
-	union {
-		befs_data_stream ds;
-		char symlink[BEFS_SYMLINK_LEN];
-	} i_data;
-
-} befs_inode_info;
-
-enum befs_err {
-	BEFS_OK,
-	BEFS_ERR,
-	BEFS_BAD_INODE,
-	BEFS_BT_END,
-	BEFS_BT_EMPTY,
-	BEFS_BT_MATCH,
-	BEFS_BT_PARMATCH,
-	BEFS_BT_NOT_FOUND
-};
-
-/****************************/
-/* io.c */
-struct buffer_head *befs_bread_iaddr(struct super_block *sb,
-				     befs_inode_addr iaddr);
-
-struct buffer_head *befs_bread(struct super_block *sb, befs_blocknr_t bloc=
k);
-/****************************/
-
-/****************************/
-/* datastream.c */
-struct buffer_head *befs_read_datastream(struct super_block *sb,
-					 befs_data_stream * ds, befs_off_t pos,
-					 uint * off);
-
-int befs_fblock2brun(struct super_block *sb, befs_data_stream * data,
-		     befs_blocknr_t fblock, befs_block_run * run);
-
-size_t befs_read_lsymlink(struct super_block *sb, befs_data_stream * data,
-			  void *buff, befs_off_t len);
-
-befs_blocknr_t befs_count_blocks(struct super_block *sb, befs_data_stream =
* ds);
-
-extern const befs_inode_addr BAD_IADDR;
-/****************************/
-
-/****************************/
-/* debug.c */
-void befs_error(const struct super_block *sb, const char *fmt, ...);
-void befs_warning(const struct super_block *sb, const char *fmt, ...);
-void befs_debug(const struct super_block *sb, const char *fmt, ...);
-
-void befs_dump_super_block(const struct super_block *sb, befs_super_block =
*);
-void befs_dump_inode(const struct super_block *sb, befs_inode *);
-void befs_dump_index_entry(const struct super_block *sb, befs_btree_super =
*);
-void befs_dump_index_node(const struct super_block *sb, befs_btree_nodehea=
d *);
-void befs_dump_inode_addr(const struct super_block *sb, befs_inode_addr);
-/****************************/
-
-/****************************/
-/* btree.c */
-int befs_btree_find(struct super_block *sb, befs_data_stream * ds,
-		    const char *key, befs_off_t * value);
-
-int befs_btree_read(struct super_block *sb, befs_data_stream * ds,
-		    loff_t key_no, size_t bufsize, char *keybuf,
-		    size_t * keysize, befs_off_t * value);
-/****************************/
-
-/****************************/
-/* super.c */
-int befs_load_sb(struct super_block *sb, befs_super_block * disk_sb);
-int befs_check_sb(struct super_block *sb);
-/****************************/
-
-/****************************/
-/* inode.c */
-int befs_check_inode(struct super_block *sb, befs_inode * raw_inode,
-		     befs_blocknr_t inode);
-/****************************/
-
-/* Gets a pointer to the private portion of the super_block
- * structure from the public part
- */
-static inline befs_sb_info *
-BEFS_SB(const struct super_block *super)
-{
-	return (befs_sb_info *) super->u.generic_sbp;
-}
-
-static inline befs_inode_info *
-BEFS_I(const struct inode *inode)
-{
-	return (befs_inode_info *) inode->u.generic_ip;
-}
-
-static inline befs_blocknr_t
-iaddr2blockno(struct super_block *sb, befs_inode_addr * iaddr)
-{
-	return ((iaddr->allocation_group << BEFS_SB(sb)->ag_shift) +
-		iaddr->start);
-}
-
-static inline befs_inode_addr
-blockno2iaddr(struct super_block *sb, befs_blocknr_t blockno)
-{
-	befs_inode_addr iaddr;
-	iaddr.allocation_group =3D blockno >> BEFS_SB(sb)->ag_shift;
-	iaddr.start =3D
-	    blockno - (iaddr.allocation_group << BEFS_SB(sb)->ag_shift);
-	iaddr.len =3D 1;
-
-	return iaddr;
-}
-
-static inline unsigned int
-befs_iaddrs_per_block(struct super_block *sb)
-{
-	return BEFS_SB(sb)->block_size / sizeof (befs_inode_addr);
-}
-
-static inline int
-befs_iaddr_is_empty(befs_inode_addr * iaddr)
-{
-	return (!iaddr->allocation_group) && (!iaddr->start) && (!iaddr->len);
-}
-
-static inline size_t
-befs_brun_size(struct super_block *sb, befs_block_run run)
-{
-	return BEFS_SB(sb)->block_size * run.len;
-}
-
-#endif				/* _LINUX_BEFS_FS */
Index: linux/fs/befs/befs_fs_types.h
diff -u linux/fs/befs/befs_fs_types.h:1.1.1.2 linux/fs/befs/befs_fs_types.h=
:1.10
--- linux/fs/befs/befs_fs_types.h:1.1.1.2	Wed Aug 28 01:29:00 2002
+++ linux/fs/befs/befs_fs_types.h	Mon Jul 22 12:54:32 2002
@@ -45,15 +45,17 @@
  */
=20
 enum super_flags {
+	BEFS_BYTESEX_BE,
+	BEFS_BYTESEX_LE,
 	BEFS_CLEAN =3D 0x434c454e,
 	BEFS_DIRTY =3D 0x44495254,
-	BEFS_BYTESEX_BE =3D 0x45474942,
-	BEFS_BYTESEX_LE =3D 0x42494745,
 	BEFS_SUPER_MAGIC1 =3D 0x42465331,	/* BFS1 */
 	BEFS_SUPER_MAGIC2 =3D 0xdd121031,
 	BEFS_SUPER_MAGIC3 =3D 0x15b6830e,
 };
=20
+#define BEFS_BYTEORDER_NATIVE 0x42494745
+
 #define BEFS_SUPER_MAGIC BEFS_SUPER_MAGIC1
=20
 /*
@@ -77,15 +79,15 @@
  * On-Disk datastructures of BeFS
  */
=20
-typedef __u64 befs_off_t;
-typedef __u64 befs_time_t;
+typedef u64 befs_off_t;
+typedef u64 befs_time_t;
 typedef void befs_binode_etc;
=20
 /* Block runs */
 typedef struct {
-	__u32 allocation_group;
-	__u16 start;
-	__u16 len;
+	u32 allocation_group;
+	u16 start;
+	u16 len;
 } PACKED befs_block_run;
=20
 typedef befs_block_run befs_inode_addr;
@@ -95,29 +97,29 @@
  */
 typedef struct {
 	char name[B_OS_NAME_LENGTH];
-	__u32 magic1;
-	__u32 fs_byte_order;
+	u32 magic1;
+	u32 fs_byte_order;
=20
-	__u32 block_size;
-	__u32 block_shift;
+	u32 block_size;
+	u32 block_shift;
=20
 	befs_off_t num_blocks;
 	befs_off_t used_blocks;
=20
-	__u32 inode_size;
+	u32 inode_size;
=20
-	__u32 magic2;
-	__u32 blocks_per_ag;
-	__u32 ag_shift;
-	__u32 num_ags;
+	u32 magic2;
+	u32 blocks_per_ag;
+	u32 ag_shift;
+	u32 num_ags;
=20
-	__u32 flags;
+	u32 flags;
=20
 	befs_block_run log_blocks;
 	befs_off_t log_start;
 	befs_off_t log_end;
=20
-	__u32 magic3;
+	u32 magic3;
 	befs_inode_addr root_dir;
 	befs_inode_addr indices;
=20
@@ -139,35 +141,35 @@
=20
 /* Attribute */
 typedef struct {
-	__u32 type;
-	__u16 name_size;
-	__u16 data_size;
+	u32 type;
+	u16 name_size;
+	u16 data_size;
 	char name[1];
 } PACKED befs_small_data;
=20
 /* Inode structure */
 typedef struct {
-	__u32 magic1;
+	u32 magic1;
 	befs_inode_addr inode_num;
-	__u32 uid;
-	__u32 gid;
-	__u32 mode;
-	__u32 flags;
+	u32 uid;
+	u32 gid;
+	u32 mode;
+	u32 flags;
 	befs_time_t create_time;
 	befs_time_t last_modified_time;
 	befs_inode_addr parent;
 	befs_inode_addr attributes;
-	__u32 type;
+	u32 type;
=20
-	__u32 inode_size;
-	__u32 etc;		/* not use */
+	u32 inode_size;
+	u32 etc;		/* not use */
=20
 	union {
 		befs_data_stream datastream;
 		char symlink[BEFS_SYMLINK_LEN];
 	} data;
=20
-	__u32 pad[4];		/* not use */
+	u32 pad[4];		/* not use */
 	befs_small_data small_data[1];
 } PACKED befs_inode;
=20
@@ -188,10 +190,10 @@
 };
=20
 typedef struct {
-	__u32 magic;
-	__u32 node_size;
-	__u32 max_depth;
-	__u32 data_type;
+	u32 magic;
+	u32 node_size;
+	u32 max_depth;
+	u32 data_type;
 	befs_off_t root_node_ptr;
 	befs_off_t free_node_ptr;
 	befs_off_t max_size;
@@ -204,8 +206,8 @@
 	befs_off_t left;
 	befs_off_t right;
 	befs_off_t overflow;
-	__u16 all_key_count;
-	__u16 all_key_length;
+	u16 all_key_count;
+	u16 all_key_length;
 } PACKED befs_btree_nodehead;
=20
 #endif				/* _LINUX_BEFS_FS_TYPES */
Index: linux/fs/befs/btree.c
diff -u linux/fs/befs/btree.c:1.1.1.2 linux/fs/befs/btree.c:1.23
--- linux/fs/befs/btree.c:1.1.1.2	Wed Aug 28 01:29:00 2002
+++ linux/fs/befs/btree.c	Mon Aug 12 01:06:17 2002
@@ -26,7 +26,9 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
=20
-#include "befs_fs.h"
+#include "befs.h"
+#include "btree.h"
+#include "datastream.h"
 #include "endian.h"
=20
 /*
Index: linux/fs/befs/btree.h
diff -u /dev/null linux/fs/befs/btree.h:1.2
--- /dev/null	Fri Aug 30 20:41:31 2002
+++ linux/fs/befs/btree.h	Fri Aug 30 20:41:04 2002
@@ -0,0 +1,11 @@
+/*
+ * btree.h
+ *=20
+ */
+
+int befs_btree_find(struct super_block *sb, befs_data_stream * ds,
+		    const char *key, befs_off_t * value);
+
+int befs_btree_read(struct super_block *sb, befs_data_stream * ds,
+		    loff_t key_no, size_t bufsize, char *keybuf,
+		    size_t * keysize, befs_off_t * value);
Index: linux/fs/befs/compatibility.h
diff -u linux/fs/befs/compatibility.h:1.1.1.2 linux/fs/befs/compatibility.h=
:removed
--- linux/fs/befs/compatibility.h:1.1.1.2	Wed Aug 28 01:29:00 2002
+++ linux/fs/befs/compatibility.h	Fri Aug 30 20:41:31 2002
@@ -1,26 +0,0 @@
-/*
- * linux/fs/befs/compatiblity.h
- *
- * Copyright (C) 2001 Will Dyson <will_dyson@pobox.com>
- *   AKA <will@cs.earlham.edu>
- *
- * This file trys to take care of differences between
- * kernel versions
- */
-
-#include <linux/version.h>
-
-/* New interfaces in 2.4.10 */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,10)
-
-#define min_t(type,x,y) \
-({ type __x =3D (x); type __y =3D (y); __x < __y ? __x: __y; })
-
-#define max_t(type,x,y) \
-({ type __x =3D (x); type __y =3D (y); __x > __y ? __x: __y; })
-
-#define vsnprintf(buf, n, fmt, args) vsprintf(buf, fmt, args)
-
-#define MODULE_LICENSE(x)
-
-#endif				/* LINUX_VERSION_CODE */
Index: linux/fs/befs/datastream.c
diff -u linux/fs/befs/datastream.c:1.1.1.2 linux/fs/befs/datastream.c:1.23
--- linux/fs/befs/datastream.c:1.1.1.2	Wed Aug 28 01:28:59 2002
+++ linux/fs/befs/datastream.c	Mon Aug 12 01:06:17 2002
@@ -15,7 +15,9 @@
 #include <linux/string.h>
 #include <linux/slab.h>
=20
-#include "befs_fs.h"
+#include "befs.h"
+#include "datastream.h"
+#include "io.h"
 #include "endian.h"
=20
 const befs_inode_addr BAD_IADDR =3D { 0, 0, 0 };
@@ -466,8 +468,7 @@
 	}
=20
 	dbl_indir_block =3D befs_bread(sb,
-				     iaddr2blockno(sb,
-						   &data->double_indirect) +
+				     iaddr2blockno(sb, &data->double_indirect) +
 				     dbl_which_block);
 	if (dbl_indir_block =3D=3D NULL) {
 		befs_error(sb, "befs_read_brun_dblindirect() couldn't read the "
Index: linux/fs/befs/datastream.h
diff -u /dev/null linux/fs/befs/datastream.h:1.2
--- /dev/null	Fri Aug 30 20:41:31 2002
+++ linux/fs/befs/datastream.h	Fri Aug 30 20:41:04 2002
@@ -0,0 +1,18 @@
+/*
+ * datastream.h
+ *
+ */
+
+struct buffer_head *befs_read_datastream(struct super_block *sb,
+					 befs_data_stream * ds, befs_off_t pos,
+					 uint * off);
+
+int befs_fblock2brun(struct super_block *sb, befs_data_stream * data,
+		     befs_blocknr_t fblock, befs_block_run * run);
+
+size_t befs_read_lsymlink(struct super_block *sb, befs_data_stream * data,
+			  void *buff, befs_off_t len);
+
+befs_blocknr_t befs_count_blocks(struct super_block *sb, befs_data_stream =
* ds);
+
+extern const befs_inode_addr BAD_IADDR;
Index: linux/fs/befs/debug.c
diff -u linux/fs/befs/debug.c:1.1.1.2 linux/fs/befs/debug.c:1.13
--- linux/fs/befs/debug.c:1.1.1.2	Wed Aug 28 01:28:59 2002
+++ linux/fs/befs/debug.c	Mon Aug 12 01:06:17 2002
@@ -20,7 +20,7 @@
=20
 #endif				/* __KERNEL__ */
=20
-#include "befs_fs.h"
+#include "befs.h"
 #include "endian.h"
=20
 #define ERRBUFSIZE 1024
Index: linux/fs/befs/endian.h
diff -u linux/fs/befs/endian.h:1.1.1.1 linux/fs/befs/endian.h:1.5
--- linux/fs/befs/endian.h:1.1.1.1	Wed Aug 28 01:28:59 2002
+++ linux/fs/befs/endian.h	Mon Aug 12 01:06:18 2002
@@ -10,7 +10,6 @@
 #define LINUX_BEFS_ENDIAN
=20
 #include <linux/byteorder/generic.h>
-#include "befs_fs.h"
=20
 static inline u64
 fs64_to_cpu(const struct super_block *sb, u64 n)
Index: linux/fs/befs/inode.c
diff -u linux/fs/befs/inode.c:1.1.1.2 linux/fs/befs/inode.c:1.21
--- linux/fs/befs/inode.c:1.1.1.2	Wed Aug 28 01:28:59 2002
+++ linux/fs/befs/inode.c	Mon Aug 12 01:06:18 2002
@@ -6,7 +6,8 @@
=20
 #include <linux/fs.h>
=20
-#include "befs_fs.h"
+#include "befs.h"
+#include "inode.h"
 #include "endian.h"
=20
 /*
@@ -18,9 +19,9 @@
 befs_check_inode(struct super_block *sb, befs_inode * raw_inode,
 		 befs_blocknr_t inode)
 {
-	__u32 magic1 =3D fs32_to_cpu(sb, raw_inode->magic1);
+	u32 magic1 =3D fs32_to_cpu(sb, raw_inode->magic1);
 	befs_inode_addr ino_num =3D fsrun_to_cpu(sb, raw_inode->inode_num);
-	__u32 flags =3D fs32_to_cpu(sb, raw_inode->flags);
+	u32 flags =3D fs32_to_cpu(sb, raw_inode->flags);
=20
 	/* check magic header. */
 	if (magic1 !=3D BEFS_INODE_MAGIC1) {
Index: linux/fs/befs/inode.h
diff -u /dev/null linux/fs/befs/inode.h:1.2
--- /dev/null	Fri Aug 30 20:41:31 2002
+++ linux/fs/befs/inode.h	Fri Aug 30 20:41:04 2002
@@ -0,0 +1,7 @@
+/*
+ * inode.h
+ *=20
+ */
+
+int befs_check_inode(struct super_block *sb, befs_inode * raw_inode,
+		     befs_blocknr_t inode);
Index: linux/fs/befs/io.c
diff -u linux/fs/befs/io.c:1.1.1.2 linux/fs/befs/io.c:1.15
--- linux/fs/befs/io.c:1.1.1.2	Wed Aug 28 01:28:59 2002
+++ linux/fs/befs/io.c	Fri Aug 30 20:41:04 2002
@@ -13,7 +13,8 @@
=20
 #include <linux/fs.h>
=20
-#include "befs_fs.h"
+#include "befs.h"
+#include "io.h"
=20
 /*
  * Converts befs notion of disk addr to a disk offset and uses
Index: linux/fs/befs/io.h
diff -u /dev/null linux/fs/befs/io.h:1.2
--- /dev/null	Fri Aug 30 20:41:31 2002
+++ linux/fs/befs/io.h	Fri Aug 30 20:41:04 2002
@@ -0,0 +1,8 @@
+/*
+ * io.h
+ */
+
+struct buffer_head *befs_bread_iaddr(struct super_block *sb,
+				     befs_inode_addr iaddr);
+
+struct buffer_head *befs_bread(struct super_block *sb, befs_blocknr_t bloc=
k);
Index: linux/fs/befs/linuxvfs.c
diff -u linux/fs/befs/linuxvfs.c:1.1.1.1 linux/fs/befs/linuxvfs.c:1.9
--- linux/fs/befs/linuxvfs.c:1.1.1.1	Wed Aug 28 01:28:59 2002
+++ linux/fs/befs/linuxvfs.c	Fri Aug 30 20:41:04 2002
@@ -15,7 +15,12 @@
 #include <linux/string.h>
 #include <linux/nls.h>
=20
-#include "befs_fs.h"
+#include "befs.h"
+#include "btree.h"
+#include "inode.h"
+#include "datastream.h"
+#include "super.h"
+#include "io.h"
 #include "endian.h"
=20
 EXPORT_NO_SYMBOLS;
@@ -35,42 +40,55 @@
 static void befs_clear_inode(struct inode *ino);
 static int befs_init_inodecache(void);
 static void befs_destroy_inodecache(void);
+
 static int befs_readlink(struct dentry *, char *, int);
 static int befs_follow_link(struct dentry *, struct nameidata *nd);
+
 static int befs_utf2nls(struct super_block *sb, const char *in, int in_len=
,
 			char **out, int *out_len);
 static int befs_nls2utf(struct super_block *sb, const char *in, int in_len=
,
 			char **out, int *out_len);
+
 static void befs_put_super(struct super_block *);
 static struct super_block *befs_read_super(struct super_block *, void *, i=
nt);
 static int befs_remount(struct super_block *, int *, char *);
 static int befs_statfs(struct super_block *, struct statfs *);
 static int parse_options(char *, befs_mount_options *);
=20
+static ssize_t befs_listxattr(struct dentry *dentry, char *buffer, size_t =
size);
+static ssize_t befs_getxattr(struct dentry *dentry, const char *name,
+			     void *buffer, size_t size);
+static int befs_setxattr(struct dentry *dentry, const char *name, void *va=
lue,
+			 size_t size, int flags);
+static int befs_removexattr(struct dentry *dentry, const char *name);
+
+/* slab cache for befs_inode_info objects */
+static kmem_cache_t *befs_inode_cachep;
+
 static const struct super_operations befs_sops =3D {
 	read_inode:befs_read_inode,	/* initialize & read inode */
 	clear_inode:befs_clear_inode,	/* uninit inode */
 	put_super:befs_put_super,	/* uninit super */
 	statfs:befs_statfs,	/* statfs */
-	remount_fs:befs_remount	/* remount_fs */
+	remount_fs:befs_remount,
 };
=20
-/* slab cache for befs_inode_info objects */
-static kmem_cache_t *befs_inode_cachep;
-
 struct file_operations befs_dir_operations =3D {
-	read:generic_read_dir,	/* read */
-	readdir:befs_readdir,	/* readdir */
+	read:generic_read_dir,
+	readdir:befs_readdir,
 };
=20
 struct inode_operations befs_dir_inode_operations =3D {
-	lookup:befs_lookup,	/* lookup */
+	lookup:befs_lookup,
 };
=20
 struct file_operations befs_file_operations =3D {
 	llseek:default_llseek,
-	read:generic_file_read,	/* read */
-	mmap:generic_file_mmap,	/* mmap */
+	read:generic_file_read,
+	mmap:generic_file_mmap,
+};
+
+struct inode_operations befs_file_inode_operations =3D {
 };
=20
 struct address_space_operations befs_aops =3D {
@@ -80,8 +98,8 @@
 };
=20
 static struct inode_operations befs_symlink_inode_operations =3D {
-	readlink:befs_readlink,	/* readlink */
-	follow_link:befs_follow_link	/* follow_link */
+	readlink:befs_readlink,
+	follow_link:befs_follow_link,
 };
=20
 /*=20
@@ -353,12 +371,7 @@
 	    (time_t) (fs64_to_cpu(sb, raw_inode->last_modified_time) >> 16);
 	inode->i_ctime =3D inode->i_mtime;
 	inode->i_atime =3D inode->i_mtime;
-
-/* Bloody hell, Linus. Why add this in a stable series? */
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,4,9)
 	inode->i_blkbits =3D befs_sb->block_shift;
-#endif
-
 	inode->i_blksize =3D befs_sb->block_size;
=20
 	befs_ino->i_inode_num =3D fsrun_to_cpu(sb, raw_inode->inode_num);
@@ -387,6 +400,7 @@
=20
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_fop =3D &befs_file_operations;
+		inode->i_op =3D &befs_file_inode_operations;
 	} else if (S_ISDIR(inode->i_mode)) {
 		inode->i_op =3D &befs_dir_inode_operations;
 		inode->i_fop =3D &befs_dir_operations;
@@ -539,7 +553,7 @@
 	wchar_t uni;
 	int unilen, utflen;
 	char *result;
-	int maxlen =3D in_len; /* The utf8->nls conversion cant make more chars *=
/
+	int maxlen =3D in_len;	/* The utf8->nls conversion cant make more chars *=
/
=20
 	befs_debug(sb, "---> utf2nls()");
=20
@@ -660,6 +674,37 @@
 	kfree(result);
 	return -EILSEQ;
 }
+
+/****Xattr****/
+
+static ssize_t
+befs_listxattr(struct dentry *dentry, char *buffer, size_t size)
+{
+	printk(KERN_ERR "befs_listxattr called\n");
+	return 0;
+}
+
+static ssize_t
+befs_getxattr(struct dentry *dentry, const char *name,
+	      void *buffer, size_t size)
+{
+	return 0;
+}
+
+static int
+befs_setxattr(struct dentry *dentry, const char *name,
+	      void *value, size_t size, int flags)
+{
+	return 0;
+}
+
+static int
+befs_removexattr(struct dentry *dentry, const char *name)
+{
+	return 0;
+}
+
+/****Superblock****/
=20
 static int
 parse_options(char *options, befs_mount_options * opts)
Index: linux/fs/befs/super.c
diff -u linux/fs/befs/super.c:1.1.1.2 linux/fs/befs/super.c:1.21
--- linux/fs/befs/super.c:1.1.1.2	Wed Aug 28 01:28:59 2002
+++ linux/fs/befs/super.c	Fri Aug 30 20:41:04 2002
@@ -9,7 +9,8 @@
=20
 #include <linux/fs.h>
=20
-#include "befs_fs.h"
+#include "befs.h"
+#include "super.h"
 #include "endian.h"
=20
 /**
@@ -25,8 +26,11 @@
 {
 	befs_sb_info *befs_sb =3D BEFS_SB(sb);
=20
-	/* byte_order is special, no byte-swap */
-	befs_sb->byte_order =3D disk_sb->fs_byte_order;
+	/* Check the byte order of the filesystem */
+	if (le32_to_cpu(disk_sb->fs_byte_order) =3D=3D BEFS_BYTEORDER_NATIVE)
+		befs_sb->byte_order =3D BEFS_BYTESEX_LE;
+	else if (be32_to_cpu(disk_sb->fs_byte_order) =3D=3D BEFS_BYTEORDER_NATIVE=
)
+		befs_sb->byte_order =3D BEFS_BYTESEX_BE;
=20
 	befs_sb->magic1 =3D fs32_to_cpu(sb, disk_sb->magic1);
 	befs_sb->magic2 =3D fs32_to_cpu(sb, disk_sb->magic2);
Index: linux/fs/befs/super.h
diff -u /dev/null linux/fs/befs/super.h:1.2
--- /dev/null	Fri Aug 30 20:41:31 2002
+++ linux/fs/befs/super.h	Fri Aug 30 20:41:04 2002
@@ -0,0 +1,7 @@
+/*
+ * super.h
+ */
+
+int befs_load_sb(struct super_block *sb, befs_super_block * disk_sb);
+
+int befs_check_sb(struct super_block *sb);

--=-r8W4wMCP5gO96AVjWDHa--

