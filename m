Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312420AbSD2Oq0>; Mon, 29 Apr 2002 10:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312426AbSD2OqZ>; Mon, 29 Apr 2002 10:46:25 -0400
Received: from krynn.axis.se ([193.13.178.10]:49562 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S312420AbSD2OqV>;
	Mon, 29 Apr 2002 10:46:21 -0400
Date: Mon, 29 Apr 2002 16:42:47 +0200 (CEST)
From: Johan Adolfsson <johan.adolfsson@axis.com>
X-X-Sender: <johana@ado-2.axis.se>
To: <linux-kernel@vger.kernel.org>
cc: Johan Adolfsson <johan.adolfsson@axis.com>
Subject: [RFC/FYI] cramfs 6/6 - boot/root stuff
Message-ID: <Pine.LNX.4.33.0204291553570.25892-100000@ado-2.axis.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


<ugly hack warning>
6. (RFC/FYI) In our tree we have a hack that allows us
   to append the cramfs image to the kernel image and use it to boot from.
   We support both booting from flash where the kernel image is compressed
   and the cramfs image is in flash and booting directly from RAM using
   the image downloaded through the network interface - in that case the
   kernel is not compressed and the cramfs image is in RAM after the kernel.
   A "romfs_in_flash" variable is used to determine which mode is
   used and if we're booting from RAM, the cramfs is not read through a
   real device.

Here is the diff for your amusement and I welcome any feedback
slightly more constructive then "Don't do that!" ;-)
An alternative approach could be to use a mtd-ram device but I don't
know how yet.

Any chance at all of anything like this getting into the official kernel?
(after putting it within a CONFIG_CRAMFS_AS_IMAGE or similar)
(don't bash me to hard please :-)

Any hints of other approaches?

/Johan

Index: linux/fs/cramfs/inode.c
===================================================================
RCS file: /n/cvsroot/os/linux/fs/cramfs/inode.c,v
retrieving revision 1.1.1.10
retrieving revision 1.19
diff -u -p -r1.1.1.10 -r1.19
--- linux/fs/cramfs/inode.c	23 Apr 2002 13:18:36 -0000	1.1.1.10
+++ linux/fs/cramfs/inode.c	29 Apr 2002 12:37:59 -0000	1.19
@@ -28,6 +28,9 @@
 #define CRAMFS_SB_BLOCKS u.cramfs_sb.blocks
 #define CRAMFS_SB_FILES u.cramfs_sb.files
 #define CRAMFS_SB_FLAGS u.cramfs_sb.flags
+#define CRAMFS_SB_FSTIME u.cramfs_sb.fstime
+
+#define CRAMFS_AS_IMAGE

 static struct super_operations cramfs_ops;
 static struct inode_operations cramfs_dir_inode_operations;
@@ -54,6 +57,8 @@ static struct inode *get_cramfs_inode(st
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_gid = cramfs_inode->gid;
 		inode->i_ino = CRAMINO(cramfs_inode);
+		inode->i_mtime = sb->CRAMFS_SB_FSTIME;
+		inode->i_ctime = sb->CRAMFS_SB_FSTIME;
 		/* inode->i_nlink is left 1 - arguably wrong for directories,
 		   but it's the best we can do without reading the directory
 	           contents.  1 yields the right result in GNU find, even
@@ -109,7 +114,32 @@ static int next_buffer;
  * Returns a pointer to a buffer containing at least LEN bytes of
  * filesystem starting at byte offset OFFSET into the filesystem.
  */
+
+#ifdef CRAMFS_AS_IMAGE
+
+/* Normally, cramfs_read reads from offset and len bytes on a block device.
+ * But if we have an attached image piggybacked on the end of the kernel
+ * (a la krom/romfs) we can use this trivial routine.
+ */
+
+extern unsigned char *romfs_start;  /* set in head.S during boot */
+extern unsigned int romfs_length;   /* dito */
+void *(*cramfs_read)(struct super_block *, unsigned int, unsigned int);
+
+/*
+ * Returns a pointer to a buffer containing at least LEN bytes of
+ * filesystem starting at byte offset OFFSET into the filesystem.
+ */
+inline void *mem_cramfs_read(struct super_block *sb, unsigned int offset, unsigned int len)
+{
+	//printk("cramfs_read start 0x%x, offset %d, len %d\n", romfs_start, offset, len);
+	return romfs_start + offset;
+}
+
+void *blk_cramfs_read(struct super_block *sb, unsigned int offset, unsigned int len)
+#else /* CRAMFS_AS_IMAGE */
 static void *cramfs_read(struct super_block *sb, unsigned int offset, unsigned int len)
+#endif
 {
 	struct buffer_head * bh_array[BLKS_PER_BUF];
 	struct buffer_head * read_array[BLKS_PER_BUF];
@@ -144,7 +174,7 @@ static void *cramfs_read(struct super_bl
 	minor = MINOR(sb->s_dev);

 	if (blk_size[major])
-		devsize = blk_size[major][minor] >> 2;
+		devsize = blk_size[major][minor] / (PAGE_CACHE_SIZE / 1024);

 	/* Ok, read in BLKS_PER_BUF pages completely first. */
 	unread = 0;
@@ -187,7 +217,6 @@ static void *cramfs_read(struct super_bl
 	return read_buffers[buffer] + offset;
 }

-
 static struct super_block * cramfs_read_super(struct super_block *sb, void *data, int silent)
 {
 	int i;
@@ -230,10 +259,13 @@ static struct super_block * cramfs_read_
 		goto out;
 	}
 	root_offset = super.root.offset << 2;
+	sb->CRAMFS_SB_FSTIME = 0;
 	if (super.flags & CRAMFS_FLAG_FSID_VERSION_2) {
 		sb->CRAMFS_SB_SIZE=super.size;
 		sb->CRAMFS_SB_BLOCKS=super.fsid.blocks;
 		sb->CRAMFS_SB_FILES=super.fsid.files;
+		if (super.flags & CRAMFS_FLAG_EDITION_TIMESTAMP)
+			sb->CRAMFS_SB_FSTIME=super.fsid.edition;
 	} else {
 		sb->CRAMFS_SB_SIZE=1<<28;
 		sb->CRAMFS_SB_BLOCKS=0;
@@ -444,7 +476,10 @@ static struct super_operations cramfs_op
 	statfs:		cramfs_statfs,
 };

-static DECLARE_FSTYPE_DEV(cramfs_fs_type, "cramfs", cramfs_read_super);
+/* Don't have this static, init/do_mounts.c removes FS_REQUIRES_DEV if we are
+ * booting from memory with a cramfs image appended to the kernel image /johana
+ */
+DECLARE_FSTYPE_DEV(cramfs_fs_type, "cramfs", cramfs_read_super);

 static int __init init_cramfs_fs(void)
 {
Index: linux/init/do_mounts.c
===================================================================
RCS file: /n/cvsroot/os/linux/init/do_mounts.c,v
retrieving revision 1.1.1.1
retrieving revision 1.3
diff -u -p -r1.1.1.1 -r1.3
--- linux/init/do_mounts.c	23 Apr 2002 13:18:37 -0000	1.1.1.1
+++ linux/init/do_mounts.c	24 Apr 2002 15:20:01 -0000	1.3
@@ -709,6 +709,38 @@ static void __init devfs_make_root(char

 static void __init mount_root(void)
 {
+#if defined(CONFIG_CRAMFS)
+	{
+		extern void *(*cramfs_read)(struct super_block *, unsigned int,
+				     unsigned int);
+		extern void *mem_cramfs_read(struct super_block *sb,
+				      unsigned int offset, unsigned int len);
+		extern void *blk_cramfs_read(struct super_block *sb,
+				      unsigned int offset, unsigned int len);
+		extern unsigned long romfs_in_flash; /* From head.S */
+		extern struct file_system_type cramfs_fs_type; /* fs/cramfs/inode.c */
+
+		if (!romfs_in_flash) {
+			cramfs_read = mem_cramfs_read;
+			/* When booting from memory we don't require a device
+			 * and can't have the FS_REQUIRES_DEV flag set:
+			 */
+			cramfs_fs_type.fs_flags &= ~FS_REQUIRES_DEV;
+
+			if(sys_mount("/dev/root", "/root", "cramfs", root_mountflags, 0)) {
+				printk(KERN_ERR "VFS: Unable to mount cramfs filesystem.\n");
+				/* Panic here ? */
+			}
+			sys_chdir("/root");
+			ROOT_DEV = current->fs->pwdmnt->mnt_sb->s_dev;
+			printk("VFS: Mounted root (cramfs filesystem).\n");
+			return;
+		} else {
+			cramfs_read = blk_cramfs_read;
+		}
+	}
+#endif
+
 #ifdef CONFIG_ROOT_NFS
 	if (MAJOR(ROOT_DEV) == UNNAMED_MAJOR) {
 		if (mount_nfs_root()) {



