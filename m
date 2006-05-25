Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965156AbWEYM4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965156AbWEYM4v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 08:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965157AbWEYM4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 08:56:50 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:62640 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S965156AbWEYM4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 08:56:50 -0400
To: adilger@clusterfs.com, cmm@us.ibm.com, jitendra@linsyssoft.com
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][19/24]large files and filesystem support
Message-Id: <20060525215641sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 25 May 2006 21:56:41 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [19/24] large files and filesystem support
          - This fixes what remains unmodified.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr e2fsprogs-1.39/debugfs/logdump.c e2fsprogs-1.39.tmp/debugfs/logdump.c
--- e2fsprogs-1.39/debugfs/logdump.c	2006-05-25 19:42:12.691989253 +0900
+++ e2fsprogs-1.39.tmp/debugfs/logdump.c	2006-05-25 19:43:29.902925807 +0900
@@ -339,7 +339,7 @@ static void dump_journal(char *cmdname, 
 	journal_header_t	*header;
 	
 	tid_t			transaction;
-	unsigned int		blocknr = 0;
+	blk_t			blocknr = 0;
 	
 	/* First, check to see if there's an ext2 superblock header */
 	retval = read_journal_block(cmdname, source, 0, 
diff -upNr e2fsprogs-1.39/e2fsck/e2fsck.h e2fsprogs-1.39.tmp/e2fsck/e2fsck.h
--- e2fsprogs-1.39/e2fsck/e2fsck.h	2006-03-19 11:33:55.000000000 +0900
+++ e2fsprogs-1.39.tmp/e2fsck/e2fsck.h	2006-05-25 19:43:29.903902369 +0900
@@ -94,7 +94,7 @@ struct dir_info {
  */
 struct dx_dir_info {
 	ext2_ino_t		ino; 		/* Inode number */
-	int			numblocks;	/* number of blocks */
+	blk_t			numblocks;	/* number of blocks */
 	int			hashversion;
 	short			depth;		/* depth of tree */
 	struct dx_dirblock_info	*dx_block; 	/* Array of size numblocks */
diff -upNr e2fsprogs-1.39/e2fsck/emptydir.c e2fsprogs-1.39.tmp/e2fsck/emptydir.c
--- e2fsprogs-1.39/e2fsck/emptydir.c	2006-05-25 19:43:18.326754074 +0900
+++ e2fsprogs-1.39.tmp/e2fsck/emptydir.c	2006-05-25 19:43:29.903902369 +0900
@@ -167,9 +167,10 @@ static int fix_directory(ext2_filsys fs,
 		return 0;
 
 	if (edi->freed_blocks) {
-		edi->inode.i_size -= edi->freed_blocks * fs->blocksize;
-		edi->inode.i_blocks -= edi->freed_blocks *
-			(fs->blocksize / i_blocks_base(fs, &edi->inode));
+		edi->inode.i_size -= (unsigned long long)edi->freed_blocks *
+				     fs->blocksize;
+		edi->inode.i_blocks -= (unsigned long long)edi->freed_blocks *
+				       (fs->blocksize / i_blocks_base(fs, &edi->inode));
 		(void) ext2fs_write_inode(fs, db->ino, &edi->inode);
 	}
 	return 0;
diff -upNr e2fsprogs-1.39/e2fsck/extend.c e2fsprogs-1.39.tmp/e2fsck/extend.c
--- e2fsprogs-1.39/e2fsck/extend.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/e2fsck/extend.c	2006-05-25 19:43:29.904878932 +0900
@@ -57,7 +57,7 @@ int main(int argc, char **argv)
 		perror(filename);
 		exit(1);
 	}
-	ret = lseek(fd, nblocks*blocksize, SEEK_SET);
+	ret = ext2fs_llseek(fd, (off_t)nblocks*blocksize, SEEK_SET);
 	if (ret < 0) {
 		perror("lseek");
 		exit(1);
@@ -67,7 +67,7 @@ int main(int argc, char **argv)
 		perror("read");
 		exit(1);
 	}
-	ret = lseek(fd, nblocks*blocksize, SEEK_SET);
+	ret = ext2fs_llseek(fd, (off_t)nblocks*blocksize, SEEK_SET);
 	if (ret < 0) {
 		perror("lseek #2");
 		exit(1);
diff -upNr e2fsprogs-1.39/e2fsck/pass2.c e2fsprogs-1.39.tmp/e2fsck/pass2.c
--- e2fsprogs-1.39/e2fsck/pass2.c	2006-05-25 19:43:18.328707199 +0900
+++ e2fsprogs-1.39.tmp/e2fsck/pass2.c	2006-05-25 19:43:29.905855494 +0900
@@ -97,7 +97,7 @@ void e2fsck_pass2(e2fsck_t ctx)
 	struct check_dir_struct cd;
 	struct dx_dir_info	*dx_dir;
 	struct dx_dirblock_info	*dx_db, *dx_parent;
-	int			b;
+	blk_t			b;
 	int			i, depth;
 	problem_t		code;
 	int			bad_dir;
diff -upNr e2fsprogs-1.39/lib/ext2fs/bmap.c e2fsprogs-1.39.tmp/lib/ext2fs/bmap.c
--- e2fsprogs-1.39/lib/ext2fs/bmap.c	2006-05-25 19:43:18.332613448 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/bmap.c	2006-05-25 19:43:29.905855494 +0900
@@ -260,7 +260,8 @@ done:
 	if (buf)
 		ext2fs_free_mem(&buf);
 	if ((retval == 0) && (blocks_alloc || inode_dirty)) {
-		inode->i_blocks += (blocks_alloc * fs->blocksize) / i_blocks_base(fs, inode);
+		inode->i_blocks += ((e2_blkcnt_t)blocks_alloc * 
+				    fs->blocksize) / i_blocks_base(fs, inode);
 		retval = ext2fs_write_inode(fs, ino, inode);
 	}
 	return retval;
diff -upNr e2fsprogs-1.39/lib/ext2fs/ext2_io.h e2fsprogs-1.39.tmp/lib/ext2fs/ext2_io.h
--- e2fsprogs-1.39/lib/ext2fs/ext2_io.h	2006-03-18 12:48:25.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/ext2_io.h	2006-05-25 19:43:29.906832057 +0900
@@ -90,7 +90,7 @@ struct struct_io_manager {
 extern errcode_t io_channel_set_options(io_channel channel, 
 					const char *options);
 extern errcode_t io_channel_write_byte(io_channel channel, 
-				       unsigned long offset,
+				       ext2_loff_t offset,
 				       int count, const void *data);
 
 /* unix_io.c */
diff -upNr e2fsprogs-1.39/lib/ext2fs/inode.c e2fsprogs-1.39.tmp/lib/ext2fs/inode.c
--- e2fsprogs-1.39/lib/ext2fs/inode.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/inode.c	2006-05-25 19:43:29.906832057 +0900
@@ -495,7 +495,8 @@ errcode_t ext2fs_get_next_inode(ext2_ino
 errcode_t ext2fs_read_inode_full(ext2_filsys fs, ext2_ino_t ino,
 				 struct ext2_inode * inode, int bufsize)
 {
-	unsigned long 	group, block, block_nr, offset;
+	unsigned long 	group, offset;
+	e2_blkcnt_t	block, block_nr;
 	char 		*ptr;
 	errcode_t	retval;
 	int 		clen, i, inodes_per_block, length;
diff -upNr e2fsprogs-1.39/lib/ext2fs/inode_io.c e2fsprogs-1.39.tmp/lib/ext2fs/inode_io.c
--- e2fsprogs-1.39/lib/ext2fs/inode_io.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/inode_io.c	2006-05-25 19:43:29.907808619 +0900
@@ -207,9 +207,9 @@ static errcode_t inode_read_blk(io_chann
 	data = (struct inode_private_data *) channel->private_data;
 	EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_INODE_IO_CHANNEL);
 
-	if ((retval = ext2fs_file_lseek(data->file,
-					block * channel->block_size,
-					EXT2_SEEK_SET, 0)))
+	if ((retval = ext2fs_file_llseek(data->file,
+					(unsigned long long)block *
+					channel->block_size,EXT2_SEEK_SET, 0)))
 		return retval;
 
 	count = (count < 0) ? -count : (count * channel->block_size);
@@ -227,9 +227,9 @@ static errcode_t inode_write_blk(io_chan
 	data = (struct inode_private_data *) channel->private_data;
 	EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_INODE_IO_CHANNEL);
 
-	if ((retval = ext2fs_file_lseek(data->file,
-					block * channel->block_size,
-					EXT2_SEEK_SET, 0)))
+	if ((retval = ext2fs_file_llseek(data->file,
+					(unsigned long long)block *
+					channel->block_size,EXT2_SEEK_SET, 0)))
 		return retval;
 
 	count = (count < 0) ? -count : (count * channel->block_size);
diff -upNr e2fsprogs-1.39/lib/ext2fs/io_manager.c e2fsprogs-1.39.tmp/lib/ext2fs/io_manager.c
--- e2fsprogs-1.39/lib/ext2fs/io_manager.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/io_manager.c	2006-05-25 19:43:29.907808619 +0900
@@ -56,7 +56,7 @@ errcode_t io_channel_set_options(io_chan
 	return retval;
 }
 
-errcode_t io_channel_write_byte(io_channel channel, unsigned long offset,
+errcode_t io_channel_write_byte(io_channel channel, ext2_loff_t offset,
 				int count, const void *data)
 {
 	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
diff -upNr e2fsprogs-1.39/lib/ext2fs/tst_getsectsize.c e2fsprogs-1.39.tmp/lib/ext2fs/tst_getsectsize.c
--- e2fsprogs-1.39/lib/ext2fs/tst_getsectsize.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/tst_getsectsize.c	2006-05-25 19:43:29.907808619 +0900
@@ -27,8 +27,8 @@
 
 int main(int argc, char **argv)
 {
-	int	sectsize;
-	int	retval;
+	unsigned sectsize;
+	int	 retval;
 	
 	if (argc < 2) {
 		fprintf(stderr, "Usage: %s device\n", argv[0]);
diff -upNr e2fsprogs-1.39/lib/ext2fs/tst_getsize.c e2fsprogs-1.39.tmp/lib/ext2fs/tst_getsize.c
--- e2fsprogs-1.39/lib/ext2fs/tst_getsize.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/tst_getsize.c	2006-05-25 19:43:29.908785182 +0900
@@ -39,6 +39,6 @@ int main(int argc, const char *argv[])
 		com_err(argv[0], retval, "while getting device size");
 		exit(1);
 	}
-	printf("%s is device has %d blocks.\n", argv[1], blocks);
+	printf("%s is device has %u blocks.\n", argv[1], blocks);
 	return 0;
 }
diff -upNr e2fsprogs-1.39/misc/e2image.c e2fsprogs-1.39.tmp/misc/e2image.c
--- e2fsprogs-1.39/misc/e2image.c	2006-05-25 19:42:12.708590815 +0900
+++ e2fsprogs-1.39.tmp/misc/e2image.c	2006-05-25 19:43:29.909761744 +0900
@@ -63,8 +63,8 @@ static void write_header(int fd, struct 
 		exit(1);
 	}
 
-	if (lseek(fd, 0, SEEK_SET) < 0) {
-		perror("lseek while writing header");
+	if (ext2fs_llseek(fd, 0, SEEK_SET) < 0) {
+		perror("ext2fs_llseek while writing header");
 		exit(1);
 	}
 	memset(header_buf, 0, blocksize);
@@ -94,14 +94,14 @@ static void write_image_file(ext2_filsys
 	write_header(fd, NULL, fs->blocksize);
 	memset(&hdr, 0, sizeof(struct ext2_image_hdr));
 
-	hdr.offset_super = lseek(fd, 0, SEEK_CUR);
+	hdr.offset_super = ext2fs_llseek(fd, 0, SEEK_CUR);
 	retval = ext2fs_image_super_write(fs, fd, 0);
 	if (retval) {
 		com_err(program_name, retval, _("while writing superblock"));
 		exit(1);
 	}
 	
-	hdr.offset_inode = lseek(fd, 0, SEEK_CUR);
+	hdr.offset_inode = ext2fs_llseek(fd, 0, SEEK_CUR);
 	retval = ext2fs_image_inode_write(fs, fd,
 				  (fd != 1) ? IMAGER_FLAG_SPARSEWRITE : 0);
 	if (retval) {
@@ -109,14 +109,14 @@ static void write_image_file(ext2_filsys
 		exit(1);
 	}
 	
-	hdr.offset_blockmap = lseek(fd, 0, SEEK_CUR);
+	hdr.offset_blockmap = ext2fs_llseek(fd, 0, SEEK_CUR);
 	retval = ext2fs_image_bitmap_write(fs, fd, 0);
 	if (retval) {
 		com_err(program_name, retval, _("while writing block bitmap"));
 		exit(1);
 	}
 
-	hdr.offset_inodemap = lseek(fd, 0, SEEK_CUR);
+	hdr.offset_inodemap = ext2fs_llseek(fd, 0, SEEK_CUR);
 	retval = ext2fs_image_bitmap_write(fs, fd, IMAGER_FLAG_INODEMAP);
 	if (retval) {
 		com_err(program_name, retval, _("while writing inode bitmap"));
@@ -307,7 +307,7 @@ static int check_zero_block(char *buf, i
 	return 1;
 }
 
-static void write_block(int fd, char *buf, int sparse_offset,
+static void write_block(int fd, char *buf, ext2_loff_t sparse_offset,
 			int blocksize, blk_t block)
 {
 	int		count;
@@ -316,7 +316,7 @@ static void write_block(int fd, char *bu
 	if (sparse_offset) {
 #ifdef HAVE_LSEEK64
 		if (lseek64(fd, sparse_offset, SEEK_CUR) < 0)
-			perror("lseek");
+			perror("lseek64");
 #else
 		if (lseek(fd, sparse_offset, SEEK_CUR) < 0)
 			perror("lseek");
@@ -575,8 +575,11 @@ static void install_image(char *device, 
 		exit(1);
 	}
 
-
+#ifdef HAVE_OPEN64
+	fd = open64(image_fn, O_RDONLY);
+#else
 	fd = open(image_fn, O_RDONLY);
+#endif
 	if (fd < 0) {
 		perror(image_fn);
 		exit(1);
@@ -592,8 +595,8 @@ static void install_image(char *device, 
 
 	ext2fs_rewrite_to_io(fs, io);
 
-	if (lseek(fd, fs->image_header->offset_inode, SEEK_SET) < 0) {
-		perror("lseek");
+	if (ext2fs_llseek(fd, fs->image_header->offset_inode, SEEK_SET) < 0) {
+		perror("lseek64");
 		exit(1);
 	}
 
diff -upNr e2fsprogs-1.39/misc/filefrag.c e2fsprogs-1.39.tmp/misc/filefrag.c
--- e2fsprogs-1.39/misc/filefrag.c	2005-12-11 09:18:45.000000000 +0900
+++ e2fsprogs-1.39.tmp/misc/filefrag.c	2006-05-25 19:43:29.909761744 +0900
@@ -38,6 +38,7 @@ extern int optind;
 #include <sys/vfs.h>
 #include <sys/ioctl.h>
 #include <linux/fd.h>
+#include <ext2fs/ext2fs.h>
 
 int verbose = 0;
 
@@ -96,7 +97,8 @@ static void frag_report(const char *file
 	if (verbose) {
 		printf("Filesystem type is: %x\n", fsinfo.f_type);
 	}
-	cylgroups = (fsinfo.f_blocks + fsinfo.f_bsize*8-1) / fsinfo.f_bsize*8;
+	cylgroups = ((long long)fsinfo.f_blocks + fsinfo.f_bsize*8-1) /
+		    fsinfo.f_bsize*8;
 	if (verbose) {
 		printf("Filesystem cylinder groups is approximately %ld\n", 
 		       cylgroups);


