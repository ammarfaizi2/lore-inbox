Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbRBTGAm>; Tue, 20 Feb 2001 01:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129104AbRBTGAd>; Tue, 20 Feb 2001 01:00:33 -0500
Received: from [202.102.24.27] ([202.102.24.27]:7868 "HELO mail.jlonline.com")
	by vger.kernel.org with SMTP id <S129069AbRBTGAY>;
	Tue, 20 Feb 2001 01:00:24 -0500
To: linux-kernel@vger.kernel.org
Subject: Newbie ask for help: cramfs port to isofs
From: zhaoway <zw@debian.org>
User-Agent: Header is long! Life is short!
X-Face: "P0SH::3nH$Qd<"HD?toC5[p@)2)<dOE)UX:p/`Lhzz%R-|Z6)0`[?kZ*#m3A2)%9?H$VwT
 (8f)`[M|:KJU3q8".)KqSMd+'L!=_5u|zNR:Yv{>CH{a+pKXDK@aL@|{DS?#e!-W$>0g0WG6kO&c?`
 +RWoX+bzZ6Vx0h2]]OY5&v4"VK<vjKMJ7,IIq]RDnTTCud;QQ''Dv`58q%J)N[_?LBxQ
Message-ID: <877l2lyk3j.fsf@debian.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Date: 20 Feb 2001 14:03:12 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

I've nearly no prior experience with kernel hacking (nor C if you have
to ask, haha), sorry in advance for the newbiesh looking. ;-)

See attach for a rough try to port cramfs to isofs which gave me lots
of oops and reboots and fscks this week. Please if you have some spare
time to give it a look with your experienced eyes to help me out of
this helpless state. Thanks alot!

I plan to automatically de-compressing ``*.cramed'' files made with
cramit.c (which is a simplified version of mkcramfs.c also attached
below) from within isofs.o. This indeed isn't a very clean idea I
agree. If you have better design, please let me know.

My problem is that when I after mount ``$ file somefile.not.cram.ed''
the kernel hangs. And my de-compression code surely has some thing
severely broken too. Please heeeeelp! ;-)


--=-=-=
Content-Disposition: attachment; filename=dir.c.diff

--- vanilla-2.4.1/fs/isofs/dir.c	Sat Dec 30 01:13:45 2000
+++ cisofs/fs/isofs/dir.c	Mon Feb 19 18:40:16 2001
@@ -5,8 +5,11 @@
  *
  *  (C) 1991  Linus Torvalds - minix filesystem
  *
- *  Steve Beynon		       : Missing last directory entries fixed
+ *  Steve Beynon                      : Missing last directory entries fixed
  *  (stephen@askone.demon.co.uk)      : 21st June 1996
+ *
+ *  zhaoway                           : Transparent *.cramed uncompressing
+ *  (zw@debian.org)                   : 15th February 2001
  * 
  *  isofs directory handling functions
  */
@@ -108,8 +111,7 @@
 	unsigned int block, offset;
 	int inode_number = 0;	/* Quiet GCC */
 	struct buffer_head *bh = NULL;
-	int len;
-	int map;
+	int len = 0;
 	int high_sierra;
 	int first_de = 1;
 	char *p = NULL;		/* Quiet GCC */
@@ -181,8 +183,6 @@
 			continue;
 		}
 
-		len = 0;
-
 		/* Handle the case of the '..' directory */
 		if (de->name_len[0] == 1 && de->name[0] == 1) {
 			inode_number = filp->f_dentry->d_parent->d_inode->i_ino;
@@ -202,32 +202,37 @@
 			}
 		}
 
-		map = 1;
-		if (inode->i_sb->u.isofs_sb.s_rock) {
-			len = get_rock_ridge_filename(de, tmpname, inode);
-			if (len != 0) {		/* may be -1 */
-				p = tmpname;
-				map = 0;
+		if (inode->i_sb->u.isofs_sb.s_rock &&
+		    (len = get_rock_ridge_filename(de, tmpname, inode))) { /* may be -1 */
+#ifdef CONFIG_CISOFS
+			/* Drop trailing '.cramed' */
+			if (len > 7 && (! strncmp(&tmpname[len - 7], ".cramed", 7))) {
+				len -= 7;
+				tmpname[len] = '\0';
 			}
-		}
-		if (map) {
-#ifdef CONFIG_JOLIET
-			if (inode->i_sb->u.isofs_sb.s_joliet_level) {
-				len = get_joliet_filename(de, tmpname, inode);
-				p = tmpname;
-			} else
 #endif
-			if (inode->i_sb->u.isofs_sb.s_mapping == 'a') {
-				len = get_acorn_filename(de, tmpname, inode);
-				p = tmpname;
-			} else
-			if (inode->i_sb->u.isofs_sb.s_mapping == 'n') {
-				len = isofs_name_translate(de, tmpname, inode);
-				p = tmpname;
-			} else {
-				p = de->name;
-				len = de->name_len[0];
+			p = tmpname;
+#ifdef CONFIG_JOLIET
+		} else if (inode->i_sb->u.isofs_sb.s_joliet_level) {
+			len = get_joliet_filename(de, tmpname, inode);
+# ifdef CONFIG_CISOFS
+			/* Drop trailing '.cramed' */
+			if (len > 7 && (! strncmp(&tmpname[len - 7], ".cramed", 7))) {
+				len -= 7;
+				tmpname[len] = '\0';
 			}
+# endif
+			p = tmpname;
+#endif
+		} else if (inode->i_sb->u.isofs_sb.s_mapping == 'a') {
+			len = get_acorn_filename(de, tmpname, inode);
+			p = tmpname;
+		} else if (inode->i_sb->u.isofs_sb.s_mapping == 'n') {
+			len = isofs_name_translate(de, tmpname, inode);
+			p = tmpname;
+		} else {
+			p = de->name;
+			len = de->name_len[0];
 		}
 		if (len > 0) {
 			if (filldir(dirent, p, len, filp->f_pos, inode_number, DT_UNKNOWN) < 0)

--=-=-=
Content-Disposition: attachment; filename=namei.c.diff

--- vanilla-2.4.1/fs/isofs/namei.c	Sat Dec 30 01:13:46 2000
+++ cisofs/fs/isofs/namei.c	Mon Feb 19 18:42:05 2001
@@ -1,9 +1,9 @@
 /*
  *  linux/fs/isofs/namei.c
  *
- *  (C) 1992  Eric Youngdale Modified for ISO 9660 filesystem.
- *
  *  (C) 1991  Linus Torvalds - minix filesystem
+ *  (C) 1992  Eric Youngdale - Modified for ISO 9660 filesystem.
+ *  (C) 2001  zhaoway <zw@debian.org> - Transparent *.cramed uncompressing
  */
 
 #include <linux/sched.h>
@@ -57,7 +57,8 @@
  */
 static unsigned long
 isofs_find_entry(struct inode *dir, struct dentry *dentry,
-	char * tmpname, struct iso_directory_record * tmpde)
+		 char *tmpname, struct iso_directory_record *tmpde,
+		 unsigned char *i_compr)
 {
 	unsigned long inode_number;
 	unsigned long bufsize = ISOFS_BUFFER_SIZE(dir);
@@ -74,7 +75,7 @@
 
 	while (f_pos < dir->i_size) {
 		struct iso_directory_record * de;
-		int de_len, match, i, dlen;
+		int de_len, match, dlen;
 		char *dpnt;
 
 		if (!bh) {
@@ -116,16 +117,26 @@
 			de = tmpde;
 		}
 
-		dlen = de->name_len[0];
-		dpnt = de->name;
-
 		if (dir->i_sb->u.isofs_sb.s_rock &&
-		    ((i = get_rock_ridge_filename(de, tmpname, dir)))) {
-			dlen = i; 	/* possibly -1 */
+		    (dlen = get_rock_ridge_filename(de, tmpname, dir))) { /* may be -1 */
+#ifdef CONFIG_CISOFS
+			/* Drop trailing '.cramed' */
+			if (dlen > 7 && (! strncmp(&tmpname[dlen - 7], ".cramed", 7))) {
+				dlen -= 7;
+				tmpname[dlen] = '\0';
+			}
+#endif
 			dpnt = tmpname;
 #ifdef CONFIG_JOLIET
 		} else if (dir->i_sb->u.isofs_sb.s_joliet_level) {
 			dlen = get_joliet_filename(de, tmpname, dir);
+# ifdef CONFIG_CISOFS
+			/* Drop trailing '.cramed' */
+			if (dlen > 7 && (! strncmp(&tmpname[dlen - 7], ".cramed", 7))) {
+				dlen -= 7;
+				tmpname[dlen] = '\0';
+			}
+# endif
 			dpnt = tmpname;
 #endif
 		} else if (dir->i_sb->u.isofs_sb.s_mapping == 'a') {
@@ -134,6 +145,9 @@
 		} else if (dir->i_sb->u.isofs_sb.s_mapping == 'n') {
 			dlen = isofs_name_translate(de, tmpname, dir);
 			dpnt = tmpname;
+		} else {
+			dlen = de->name_len[0];
+			dpnt = de->name;
 		}
 
 		/*
@@ -160,6 +174,7 @@
 	unsigned long ino;
 	struct inode *inode;
 	struct page *page;
+	unsigned char i_compr = 0;
 
 	dentry->d_op = dir->i_sb->s_root->d_op;
 
@@ -168,7 +183,7 @@
 		return ERR_PTR(-ENOMEM);
 
 	ino = isofs_find_entry(dir, dentry, page_address(page),
-			       1024 + page_address(page));
+			       1024 + page_address(page), &i_compr);
 	__free_page(page);
 
 	inode = NULL;
@@ -177,6 +192,9 @@
 		if (!inode)
 			return ERR_PTR(-EACCES);
 	}
+#ifdef CONFIG_CISOFS
+	inode->u.isofs_i.i_compr = i_compr;
+#endif
 	d_add(dentry, inode);
 	return NULL;
 }

--=-=-=
Content-Disposition: attachment; filename=inode.c.diff

--- vanilla-2.4.1/fs/isofs/inode.c	Tue Feb  6 02:17:08 2001
+++ cisofs/fs/isofs/inode.c	Mon Feb 19 19:45:15 2001
@@ -7,6 +7,7 @@
  *      1995  Mark Dobie - allow mounting of some weird VideoCDs and PhotoCDs.
  *	1997  Gordon Chaffee - Joliet CDs
  *	1998  Eric Lammerts - ISO 9660 Level 3
+ *      2001  zhaoway <zw@debian.org> - Transparent *.cramed uncompressing
  */
 
 #include <linux/config.h>
@@ -55,6 +56,12 @@
 static int isofs_dentry_cmp_ms(struct dentry *dentry, struct qstr *a, struct qstr *b);
 #endif
 
+#ifdef CONFIG_CISOFS
+int cisofs_uncompress_block(void *dst, int dstlen, void *src, int srclen);
+int cisofs_uncompress_init(void);
+int cisofs_uncompress_exit(void);
+#endif
+
 static void isofs_put_super(struct super_block *sb)
 {
 #ifdef CONFIG_JOLIET
@@ -981,7 +988,97 @@
 
 static int isofs_readpage(struct file *file, struct page *page)
 {
-	return block_read_full_page(page,isofs_get_block);
+#ifdef CONFIG_CISOFS
+	struct inode *inode = page->mapping->host;
+	
+	if (! inode->u.isofs_i.i_compr)
+#endif
+		return block_read_full_page(page,isofs_get_block);
+#ifdef CONFIG_CISOFS
+	else {
+		u32 bytes_filled, pageptr_offset, pageptr_blk_offset;
+		u32 start_offset, end_offset, iblk_offset, compr_len;
+		unsigned long iblk, end_blk;
+		struct buffer_head *bh = NULL;
+		char compr[PAGE_CACHE_SIZE * 2];
+		
+		unsigned long bufsize = ISOFS_BUFFER_SIZE(inode);
+		unsigned char bufbits = ISOFS_BUFFER_BITS(inode);
+		
+		bytes_filled = 0;
+		if (page->index > ((inode->i_size + PAGE_CACHE_SIZE - 1) >>
+				   PAGE_CACHE_SHIFT)) {
+			printk("cisofs: page->index > maxpage\n");
+			goto out;
+		}
+		
+#if 1
+		printk("cisofs: yow! before pageptr bread!\n");
+#endif
+		pageptr_offset = page->index * 8;
+		pageptr_blk_offset = pageptr_offset & (bufsize - 1);
+		iblk = pageptr_offset >> bufbits;
+		if (! (bh = isofs_bread(inode, bufsize, iblk))) {
+			printk("cisofs: bad pageptr bread: %ld\n", iblk);
+			goto out;
+		}
+#if 1
+		printk("cisofs: yow! after pageptr bread!\n");
+#endif
+		start_offset = (u32) bh->b_data[pageptr_blk_offset];
+		end_offset = (u32) bh->b_data[pageptr_blk_offset + 4];
+		brelse(bh);
+		bh = NULL;
+
+		end_blk = end_offset >> bufbits;
+		iblk = start_offset >> bufbits;
+		iblk_offset = start_offset & (bufsize - 1);
+
+		compr_len = end_offset - start_offset;
+		if (compr_len == 0)
+			; /* hole */
+		else {
+			char *curr = compr;
+
+			while (iblk <= end_blk) {
+				u32 size;
+
+				if (! (bh = isofs_bread(inode, bufsize, iblk))) {
+					printk("cisofs: bad bread: %ld\n", iblk);
+					goto out;
+				}
+#if 1
+				printk("cisofs: yow! good bread!\n");
+#endif
+				if (iblk++ < end_blk)
+					size = bufsize - iblk_offset;
+				else
+					size = (end_offset & (bufsize - 1)) - iblk_offset;
+				memcpy(curr, bh->b_data + iblk_offset, size);
+				brelse(bh);
+				bh = NULL;
+				curr += size;
+				iblk_offset = 0;
+			}
+
+			if ((curr - compr) != compr_len) {
+				printk("cisofs: curr - compr != compr_len\n");
+				goto out;
+			}
+			bytes_filled = cisofs_uncompress_block(page_address(page),
+							       PAGE_CACHE_SIZE,
+							       compr, compr_len);
+		}
+
+	out:		
+		memset(page_address(page) + bytes_filled, 0,
+		       PAGE_CACHE_SIZE - bytes_filled);
+		flush_dcache_page(page);
+		SetPageUptodate(page);
+		UnlockPage(page);
+		return 0;
+	}
+#endif /* CONFIG_CISOFS */
 }
 
 static int _isofs_bmap(struct address_space *mapping, long block)
@@ -1328,11 +1425,17 @@
 
 static int __init init_iso9660_fs(void)
 {
+#ifdef CONFIG_CISOFS
+	cisofs_uncompress_init();
+#endif
         return register_filesystem(&iso9660_fs_type);
 }
 
 static void __exit exit_iso9660_fs(void)
 {
+#ifdef CONFIG_CISOFS
+	cisofs_uncompress_exit();
+#endif
         unregister_filesystem(&iso9660_fs_type);
 }
 

--=-=-=
Content-Disposition: attachment; filename=cramit.c

/*
 * cramit -- compress a file one page a time, allow random page access.
 *
 * Copyright (C) 2001  zhaoway <zw@debian.org>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/* Shamelessly stolen from Linus' mkcramfs.c */

#include <sys/types.h>
#include <stdio.h>
#include <sys/stat.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/fcntl.h>
#include <dirent.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <zlib.h>

typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;

static const char *progname = "cramit";

static void usage(void)
{
	fprintf(stderr, "Usage: %s infile outfile\n", progname);
	exit(1);
}

/*
 * If DO_HOLES is defined, then cramit can create explicit holes in the
 * data, which saves 26 bytes per hole (which is a lot smaller a
 * saving than most filesystems).
 */

/* #define DO_HOLES 1 */

#define PAGE_CACHE_SIZE (4096)
/* Assumes PAGE_CACHE_SIZE as block size. */
static unsigned int blksize = PAGE_CACHE_SIZE;

struct entry {
	unsigned int size;
	void *uncompressed;
};

#ifdef DO_HOLES
/*
 * Returns non-zero iff the first LEN bytes from BEGIN are all NULs.
 */
static int
is_zero(char const *begin, unsigned len)
{
	return (len-- == 0 ||
		(begin[0] == '\0' &&
		 (len-- == 0 ||
		  (begin[1] == '\0' &&
		   (len-- == 0 ||
		    (begin[2] == '\0' &&
		     (len-- == 0 ||
		      (begin[3] == '\0' &&
		       memcmp(begin, begin + 4, len) == 0))))))));
}
#else /* !DO_HOLES */
# define is_zero(_begin,_len) (0)  /* Never create holes. */
#endif /* !DO_HOLES */

static unsigned int do_compress(char *base, char *uncompressed,	unsigned int size)
{
	unsigned long original_size = size;
	unsigned long new_size;
	unsigned long blocks = (size - 1) / blksize + 1;
	unsigned long curr = 4 * blocks;
	unsigned int offset = 0;
	int change;

	do {
		unsigned long len = 2 * blksize;
		unsigned int input = size;

		*(u32 *) (base + offset) = curr;
		offset += 4;

		if (input > blksize)
			input = blksize;
		size -= input;
		if (!is_zero (uncompressed, input)) {
			compress(base + curr, &len, uncompressed, input);
			curr += len;
		}
		uncompressed += input;

		if (len > blksize*2) {
			/* (I don't think this can happen with zlib.) */
			printf("AIEEE: block \"compressed\" to > 2*blocklength (%ld)\n",
			       len);
			exit(1);
		}

		*(u32 *) (base + offset) = curr;
		offset += 4;
	} while (size);

	curr = (curr + 3) & ~3;
	new_size = curr;
	/* TODO: Arguably, original_size in these 2 lines should be
	   st_blocks * 512.  But if you say that then perhaps
	   administrative data should also be included in both. */
	change = new_size - original_size;
	printf("%6.2f%% (%+d bytes)\n",
	       (change * 100) / (double) original_size, change);

	return curr;
}

/*
 * Traverse the entry tree, writing data for every item that has
 * non-null entry->compressed (i.e. every symlink and non-empty
 * regfile).
 */
static unsigned int write_data(struct entry *entry, char *base)
{
	return do_compress(base, entry->uncompressed, entry->size);
}

/*
 * Usage:
 *      cramit infile outfile
 */
int main(int argc, char **argv)
{
	struct stat st;
	struct entry *entry;
	char *outfile;
	unsigned int offset;
	ssize_t written;
	int infd, outfd;
	char const *dirname;

	if (argc)
		progname = argv[0];
	if (argc != 3)
		usage();

	if (stat(dirname = argv[1], &st) < 0) {
		perror(argv[1]);
		exit(1);
	}
	outfd = open(argv[2], O_WRONLY | O_CREAT | O_TRUNC, 0666);

	entry = calloc(1, sizeof(struct entry));
	if (!entry) {
		perror(NULL);
		exit(5);
	}
	entry->size = st.st_size;

	infd = open(argv[1], O_RDONLY);
	if (infd < 0) {
		perror("open");
	}
	entry->uncompressed = mmap(NULL, entry->size, PROT_READ, MAP_PRIVATE, infd, 0);
	if (-1 == (int) (long) entry->uncompressed) {
		perror("mmap");
		exit(5);
	}
	
	/* TODO: Why do we use a private/anonymous mapping here
           followed by a write below, instead of just a shared mapping
           and a couple of ftruncate calls?  Is it just to save us
           having to deal with removing the file afterwards?  If we
           really need this huge anonymous mapping, we ought to mmap
           in smaller chunks, so that the user doesn't need nn MB of
           RAM free.  If the reason is to be able to write to
           un-mmappable block devices, then we could try shared mmap
           and revert to anonymous mmap if the shared mmap fails. */
	outfile = mmap(NULL, entry->size, PROT_READ | PROT_WRITE,
			       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	if (-1 == (int) (long) outfile) {
		perror("Compressed file map");
		exit(1);
	}

	offset = write_data(entry, outfile);

	/* We always write a multiple of blksize bytes, so that
           losetup works. */
	offset = ((offset - 1) | (blksize - 1)) + 1;
	printf("Everything: %d kilobytes\n", offset >> 10);

	written = write(outfd, outfile, offset);
	if (written < 0) {
		perror("Compressed file");
		exit(1);
	}
	if (offset != written) {
		fprintf(stderr, "Compressed file write failed (%d %d)\n",
			written, offset);
		exit(1);
	}

	return 0;
}

--=-=-=
Content-Type: text/plain; charset=cn-gb-2312
Content-Transfer-Encoding: 8bit


-- 
утн╣ <http://www.zhaoway.com/>

--=-=-=--
