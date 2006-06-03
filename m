Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbWFCOYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbWFCOYa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 10:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbWFCOYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 10:24:30 -0400
Received: from mx1.mail.ru ([194.67.23.121]:17261 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S1751647AbWFCOY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 10:24:28 -0400
Date: Sat, 3 Jun 2006 18:28:43 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/5]: ufs: easy debug
Message-ID: <20060603142843.GA16008@rain.homenetwork>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently to turn on debug mode "user" has to edit
~10 files, to turn off he has to do it again.

This patch introduce such changes:
1)turn on(off) debug messages via ".config"
2)remove unnecessary duplication of code
3)make "UFSD" macros more similar to function
4)fix some compiler warnings

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

Index: linux-2.6.17-rc5-mm1/include/linux/ufs_fs.h
===================================================================
--- linux-2.6.17-rc5-mm1.orig/include/linux/ufs_fs.h
+++ linux-2.6.17-rc5-mm1/include/linux/ufs_fs.h
@@ -220,6 +220,19 @@ typedef __u16 __bitwise __fs16;
  */
 #define UFS_MINFREE         5
 #define UFS_DEFAULTOPT      UFS_OPTTIME
+
+/*
+ * Debug code
+ */
+#ifdef CONFIG_UFS_DEBUG
+#	define UFSD(f, a...)	{					\
+		printk ("UFSD (%s, %d): %s:",				\
+			__FILE__, __LINE__, __FUNCTION__);		\
+		printk (f, ## a);					\
+	}
+#else
+#	define UFSD(f, a...)	/**/
+#endif
             
 /*
  * Turn file system block numbers into disk block addresses.
Index: linux-2.6.17-rc5-mm1/fs/ufs/dir.c
===================================================================
--- linux-2.6.17-rc5-mm1.orig/fs/ufs/dir.c
+++ linux-2.6.17-rc5-mm1/fs/ufs/dir.c
@@ -25,14 +25,6 @@
 #include "swab.h"
 #include "util.h"
 
-#undef UFS_DIR_DEBUG
-
-#ifdef UFS_DIR_DEBUG
-#define UFSD(x) printk("(%s, %d), %s: ", __FILE__, __LINE__, __FUNCTION__); printk x;
-#else
-#define UFSD(x)
-#endif
-
 /*
  * NOTE! unlike strncmp, ufs_match returns 1 for success, 0 for failure.
  *
@@ -262,7 +254,7 @@ struct ufs_dir_entry *ufs_find_entry(str
 	struct page *page = NULL;
 	struct ufs_dir_entry *de;
 
-	UFSD(("ENTER, dir_ino %lu, name %s, namlen %u\n", dir->i_ino, name, namelen));
+	UFSD("ENTER, dir_ino %lu, name %s, namlen %u\n", dir->i_ino, name, namelen);
 
 	if (npages == 0 || namelen > UFS_MAXNAMLEN)
 		goto out;
@@ -326,7 +318,7 @@ int ufs_add_link(struct dentry *dentry, 
 	unsigned from, to;
 	int err;
 
-	UFSD(("ENTER, name %s, namelen %u\n", name, namelen));
+	UFSD("ENTER, name %s, namelen %u\n", name, namelen);
 
 	/*
 	 * We take care of directory expansion in the same loop.
@@ -442,7 +434,7 @@ ufs_readdir(struct file *filp, void *dir
 	int need_revalidate = filp->f_version != inode->i_version;
 	unsigned flags = UFS_SB(sb)->s_flags;
 
-	UFSD(("BEGIN"));
+	UFSD("BEGIN\n");
 
 	if (pos > inode->i_size - UFS_DIR_REC_LEN(1))
 		return 0;
@@ -484,9 +476,9 @@ ufs_readdir(struct file *filp, void *dir
 
 				offset = (char *)de - kaddr;
 
-				UFSD(("filldir(%s,%u)\n", de->d_name,
-				      fs32_to_cpu(sb, de->d_ino)));
-				UFSD(("namlen %u\n", ufs_get_de_namlen(sb, de)));
+				UFSD("filldir(%s,%u)\n", de->d_name,
+				      fs32_to_cpu(sb, de->d_ino));
+				UFSD("namlen %u\n", ufs_get_de_namlen(sb, de));
 
 				if ((flags & UFS_DE_MASK) == UFS_DE_44BSD)
 					d_type = de->d_u.d_44.d_type;
@@ -524,12 +516,12 @@ int ufs_delete_entry(struct inode *inode
 	struct ufs_dir_entry *de = (struct ufs_dir_entry *) (kaddr + from);
 	int err;
 
-	UFSD(("ENTER\n"));
+	UFSD("ENTER\n");
 
-	UFSD(("ino %u, reclen %u, namlen %u, name %s\n",
+	UFSD("ino %u, reclen %u, namlen %u, name %s\n",
 	      fs32_to_cpu(sb, de->d_ino),
 	      fs16_to_cpu(sb, de->d_reclen),
-	      ufs_get_de_namlen(sb, de), de->d_name));
+	      ufs_get_de_namlen(sb, de), de->d_name);
 
 	while ((char*)de < (char*)dir) {
 		if (de->d_reclen == 0) {
@@ -554,7 +546,7 @@ int ufs_delete_entry(struct inode *inode
 	mark_inode_dirty(inode);
 out:
 	ufs_put_page(page);
-	UFSD(("EXIT\n"));
+	UFSD("EXIT\n");
 	return err;
 }
 
Index: linux-2.6.17-rc5-mm1/fs/ufs/balloc.c
===================================================================
--- linux-2.6.17-rc5-mm1.orig/fs/ufs/balloc.c
+++ linux-2.6.17-rc5-mm1/fs/ufs/balloc.c
@@ -21,14 +21,6 @@
 #include "swab.h"
 #include "util.h"
 
-#undef UFS_BALLOC_DEBUG
-
-#ifdef UFS_BALLOC_DEBUG
-#define UFSD(x) printk("(%s, %d), %s:", __FILE__, __LINE__, __FUNCTION__); printk x;
-#else
-#define UFSD(x)
-#endif
-
 static unsigned ufs_add_fragments (struct inode *, unsigned, unsigned, unsigned, int *);
 static unsigned ufs_alloc_fragments (struct inode *, unsigned, unsigned, unsigned, int *);
 static unsigned ufs_alloccg_block (struct inode *, struct ufs_cg_private_info *, unsigned, int *);
@@ -52,7 +44,7 @@ void ufs_free_fragments(struct inode *in
 	uspi = UFS_SB(sb)->s_uspi;
 	usb1 = ubh_get_usb_first(uspi);
 	
-	UFSD(("ENTER, fragment %u, count %u\n", fragment, count))
+	UFSD("ENTER, fragment %u, count %u\n", fragment, count);
 	
 	if (ufs_fragnum(fragment) + count > uspi->s_fpg)
 		ufs_error (sb, "ufs_free_fragments", "internal error");
@@ -123,12 +115,12 @@ void ufs_free_fragments(struct inode *in
 	sb->s_dirt = 1;
 	
 	unlock_super (sb);
-	UFSD(("EXIT\n"))
+	UFSD("EXIT\n");
 	return;
 
 failed:
 	unlock_super (sb);
-	UFSD(("EXIT (FAILED)\n"))
+	UFSD("EXIT (FAILED)\n");
 	return;
 }
 
@@ -148,7 +140,7 @@ void ufs_free_blocks(struct inode *inode
 	uspi = UFS_SB(sb)->s_uspi;
 	usb1 = ubh_get_usb_first(uspi);
 
-	UFSD(("ENTER, fragment %u, count %u\n", fragment, count))
+	UFSD("ENTER, fragment %u, count %u\n", fragment, count);
 	
 	if ((fragment & uspi->s_fpbmask) || (count & uspi->s_fpbmask)) {
 		ufs_error (sb, "ufs_free_blocks", "internal error, "
@@ -215,12 +207,12 @@ do_more:
 
 	sb->s_dirt = 1;
 	unlock_super (sb);
-	UFSD(("EXIT\n"))
+	UFSD("EXIT\n");
 	return;
 
 failed:
 	unlock_super (sb);
-	UFSD(("EXIT (FAILED)\n"))
+	UFSD("EXIT (FAILED)\n");
 	return;
 }
 
@@ -290,8 +282,8 @@ static void ufs_change_blocknr(struct in
 
 	baseblk = ((i_size_read(inode) - 1) >> inode->i_blkbits) + 1 - count;
 
-	UFSD(("ENTER, ino %lu, count %u, oldb %u, newb %u\n",
-	      inode->i_ino, count, oldb, newb));
+	UFSD("ENTER, ino %lu, count %u, oldb %u, newb %u\n",
+	      inode->i_ino, count, oldb, newb);
 
 	BUG_ON(!PageLocked(locked_page));
 
@@ -326,7 +318,7 @@ static void ufs_change_blocknr(struct in
 			page_cache_release(page);
 		}
  	}
-	UFSD(("EXIT\n"));
+	UFSD("EXIT\n");
 }
 
 unsigned ufs_new_fragments(struct inode * inode, __fs32 * p, unsigned fragment,
@@ -337,7 +329,7 @@ unsigned ufs_new_fragments(struct inode 
 	struct ufs_super_block_first * usb1;
 	unsigned cgno, oldcount, newcount, tmp, request, result;
 	
-	UFSD(("ENTER, ino %lu, fragment %u, goal %u, count %u\n", inode->i_ino, fragment, goal, count))
+	UFSD("ENTER, ino %lu, fragment %u, goal %u, count %u\n", inode->i_ino, fragment, goal, count);
 	
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
@@ -366,14 +358,14 @@ unsigned ufs_new_fragments(struct inode 
 			return (unsigned)-1;
 		}
 		if (fragment < UFS_I(inode)->i_lastfrag) {
-			UFSD(("EXIT (ALREADY ALLOCATED)\n"))
+			UFSD("EXIT (ALREADY ALLOCATED)\n");
 			unlock_super (sb);
 			return 0;
 		}
 	}
 	else {
 		if (tmp) {
-			UFSD(("EXIT (ALREADY ALLOCATED)\n"))
+			UFSD("EXIT (ALREADY ALLOCATED)\n");
 			unlock_super(sb);
 			return 0;
 		}
@@ -384,7 +376,7 @@ unsigned ufs_new_fragments(struct inode 
 	 */
 	if (!capable(CAP_SYS_RESOURCE) && ufs_freespace(usb1, UFS_MINFREE) <= 0) {
 		unlock_super (sb);
-		UFSD(("EXIT (FAILED)\n"))
+		UFSD("EXIT (FAILED)\n");
 		return 0;
 	}
 
@@ -407,7 +399,7 @@ unsigned ufs_new_fragments(struct inode 
 			UFS_I(inode)->i_lastfrag = max_t(u32, UFS_I(inode)->i_lastfrag, fragment + count);
 		}
 		unlock_super(sb);
-		UFSD(("EXIT, result %u\n", result))
+		UFSD("EXIT, result %u\n", result);
 		return result;
 	}
 
@@ -420,7 +412,7 @@ unsigned ufs_new_fragments(struct inode 
 		inode->i_blocks += count << uspi->s_nspfshift;
 		UFS_I(inode)->i_lastfrag = max_t(u32, UFS_I(inode)->i_lastfrag, fragment + count);
 		unlock_super(sb);
-		UFSD(("EXIT, result %u\n", result))
+		UFSD("EXIT, result %u\n", result);
 		return result;
 	}
 
@@ -458,12 +450,12 @@ unsigned ufs_new_fragments(struct inode 
 		if (newcount < request)
 			ufs_free_fragments (inode, result + newcount, request - newcount);
 		ufs_free_fragments (inode, tmp, oldcount);
-		UFSD(("EXIT, result %u\n", result))
+		UFSD("EXIT, result %u\n", result);
 		return result;
 	}
 
 	unlock_super(sb);
-	UFSD(("EXIT (FAILED)\n"))
+	UFSD("EXIT (FAILED)\n");
 	return 0;
 }		
 
@@ -478,7 +470,7 @@ ufs_add_fragments (struct inode * inode,
 	struct ufs_cylinder_group * ucg;
 	unsigned cgno, fragno, fragoff, count, fragsize, i;
 	
-	UFSD(("ENTER, fragment %u, oldcount %u, newcount %u\n", fragment, oldcount, newcount))
+	UFSD("ENTER, fragment %u, oldcount %u, newcount %u\n", fragment, oldcount, newcount);
 	
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
@@ -538,7 +530,7 @@ ufs_add_fragments (struct inode * inode,
 	}
 	sb->s_dirt = 1;
 
-	UFSD(("EXIT, fragment %u\n", fragment))
+	UFSD("EXIT, fragment %u\n", fragment);
 	
 	return fragment;
 }
@@ -561,7 +553,7 @@ static unsigned ufs_alloc_fragments (str
 	struct ufs_cylinder_group * ucg;
 	unsigned oldcg, i, j, k, result, allocsize;
 	
-	UFSD(("ENTER, ino %lu, cgno %u, goal %u, count %u\n", inode->i_ino, cgno, goal, count))
+	UFSD("ENTER, ino %lu, cgno %u, goal %u, count %u\n", inode->i_ino, cgno, goal, count);
 
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
@@ -595,7 +587,7 @@ static unsigned ufs_alloc_fragments (str
 		UFS_TEST_FREE_SPACE_CG
 	}
 	
-	UFSD(("EXIT (FAILED)\n"))
+	UFSD("EXIT (FAILED)\n");
 	return 0;
 
 cg_found:
@@ -664,7 +656,7 @@ succed:
 	sb->s_dirt = 1;
 
 	result += cgno * uspi->s_fpg;
-	UFSD(("EXIT3, result %u\n", result))
+	UFSD("EXIT3, result %u\n", result);
 	return result;
 }
 
@@ -677,7 +669,7 @@ static unsigned ufs_alloccg_block (struc
 	struct ufs_cylinder_group * ucg;
 	unsigned result, cylno, blkno;
 
-	UFSD(("ENTER, goal %u\n", goal))
+	UFSD("ENTER, goal %u\n", goal);
 
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
@@ -721,7 +713,7 @@ gotit:
 	fs16_sub(sb, &ubh_cg_blks(ucpi, cylno, ufs_cbtorpos(result)), 1);
 	fs32_sub(sb, &ubh_cg_blktot(ucpi, cylno), 1);
 	
-	UFSD(("EXIT, result %u\n", result))
+	UFSD("EXIT, result %u\n", result);
 
 	return result;
 }
@@ -781,7 +773,7 @@ static unsigned ufs_bitmap_search(struct
 	unsigned start, length, loc, result;
 	unsigned pos, want, blockmap, mask, end;
 
-	UFSD(("ENTER, cg %u, goal %u, count %u\n", ucpi->c_cgx, goal, count));
+	UFSD("ENTER, cg %u, goal %u, count %u\n", ucpi->c_cgx, goal, count);
 
 	usb1 = ubh_get_usb_first (uspi);
 	ucg = ubh_get_ucg(UCPI_UBH(ucpi));
@@ -825,7 +817,7 @@ static unsigned ufs_bitmap_search(struct
 		want = want_arr[count];
 		for (pos = 0; pos <= uspi->s_fpb - count; pos++) {
 			if ((blockmap & mask) == want) {
-				UFSD(("EXIT, result %u\n", result));
+				UFSD("EXIT, result %u\n", result);
 				return result + pos;
  			}
 			mask <<= 1;
@@ -835,7 +827,7 @@ static unsigned ufs_bitmap_search(struct
 
 	ufs_error(sb, "ufs_bitmap_search", "block not in map on cg %u\n",
 		  ucpi->c_cgx);
-	UFSD(("EXIT (FAILED)\n"));
+	UFSD("EXIT (FAILED)\n");
 	return (unsigned)-1;
 }
 
Index: linux-2.6.17-rc5-mm1/fs/ufs/cylinder.c
===================================================================
--- linux-2.6.17-rc5-mm1.orig/fs/ufs/cylinder.c
+++ linux-2.6.17-rc5-mm1/fs/ufs/cylinder.c
@@ -20,15 +20,6 @@
 #include "swab.h"
 #include "util.h"
 
-#undef UFS_CYLINDER_DEBUG
-
-#ifdef UFS_CYLINDER_DEBUG
-#define UFSD(x) printk("(%s, %d), %s:", __FILE__, __LINE__, __FUNCTION__); printk x;
-#else
-#define UFSD(x)
-#endif
-
-
 /*
  * Read cylinder group into cache. The memory space for ufs_cg_private_info
  * structure is already allocated during ufs_read_super.
@@ -42,7 +33,7 @@ static void ufs_read_cylinder (struct su
 	struct ufs_cylinder_group * ucg;
 	unsigned i, j;
 
-	UFSD(("ENTER, cgno %u, bitmap_nr %u\n", cgno, bitmap_nr))
+	UFSD("ENTER, cgno %u, bitmap_nr %u\n", cgno, bitmap_nr);
 	uspi = sbi->s_uspi;
 	ucpi = sbi->s_ucpi[bitmap_nr];
 	ucg = (struct ufs_cylinder_group *)sbi->s_ucg[cgno]->b_data;
@@ -73,7 +64,7 @@ static void ufs_read_cylinder (struct su
 	ucpi->c_clustersumoff = fs32_to_cpu(sb, ucg->cg_u.cg_44.cg_clustersumoff);
 	ucpi->c_clusteroff = fs32_to_cpu(sb, ucg->cg_u.cg_44.cg_clusteroff);
 	ucpi->c_nclusterblks = fs32_to_cpu(sb, ucg->cg_u.cg_44.cg_nclusterblks);
-	UFSD(("EXIT\n"))
+	UFSD("EXIT\n");
 	return;	
 	
 failed:
@@ -95,11 +86,11 @@ void ufs_put_cylinder (struct super_bloc
 	struct ufs_cylinder_group * ucg;
 	unsigned i;
 
-	UFSD(("ENTER, bitmap_nr %u\n", bitmap_nr))
+	UFSD("ENTER, bitmap_nr %u\n", bitmap_nr);
 
 	uspi = sbi->s_uspi;
 	if (sbi->s_cgno[bitmap_nr] == UFS_CGNO_EMPTY) {
-		UFSD(("EXIT\n"))
+		UFSD("EXIT\n");
 		return;
 	}
 	ucpi = sbi->s_ucpi[bitmap_nr];
@@ -122,7 +113,7 @@ void ufs_put_cylinder (struct super_bloc
 	}
 
 	sbi->s_cgno[bitmap_nr] = UFS_CGNO_EMPTY;
-	UFSD(("EXIT\n"))
+	UFSD("EXIT\n");
 }
 
 /*
@@ -139,7 +130,7 @@ struct ufs_cg_private_info * ufs_load_cy
 	struct ufs_cg_private_info * ucpi;
 	unsigned cg, i, j;
 
-	UFSD(("ENTER, cgno %u\n", cgno))
+	UFSD("ENTER, cgno %u\n", cgno);
 
 	uspi = sbi->s_uspi;
 	if (cgno >= uspi->s_ncg) {
@@ -150,7 +141,7 @@ struct ufs_cg_private_info * ufs_load_cy
 	 * Cylinder group number cg it in cache and it was last used
 	 */
 	if (sbi->s_cgno[0] == cgno) {
-		UFSD(("EXIT\n"))
+		UFSD("EXIT\n");
 		return sbi->s_ucpi[0];
 	}
 	/*
@@ -160,16 +151,16 @@ struct ufs_cg_private_info * ufs_load_cy
 		if (sbi->s_cgno[cgno] != UFS_CGNO_EMPTY) {
 			if (sbi->s_cgno[cgno] != cgno) {
 				ufs_panic (sb, "ufs_load_cylinder", "internal error, wrong number of cg in cache");
-				UFSD(("EXIT (FAILED)\n"))
+				UFSD("EXIT (FAILED)\n");
 				return NULL;
 			}
 			else {
-				UFSD(("EXIT\n"))
+				UFSD("EXIT\n");
 				return sbi->s_ucpi[cgno];
 			}
 		} else {
 			ufs_read_cylinder (sb, cgno, cgno);
-			UFSD(("EXIT\n"))
+			UFSD("EXIT\n");
 			return sbi->s_ucpi[cgno];
 		}
 	}
@@ -204,6 +195,6 @@ struct ufs_cg_private_info * ufs_load_cy
 		sbi->s_ucpi[0] = ucpi;
 		ufs_read_cylinder (sb, cgno, 0);
 	}
-	UFSD(("EXIT\n"))
+	UFSD("EXIT\n");
 	return sbi->s_ucpi[0];
 }
Index: linux-2.6.17-rc5-mm1/fs/ufs/ialloc.c
===================================================================
--- linux-2.6.17-rc5-mm1.orig/fs/ufs/ialloc.c
+++ linux-2.6.17-rc5-mm1/fs/ufs/ialloc.c
@@ -34,14 +34,6 @@
 #include "swab.h"
 #include "util.h"
 
-#undef UFS_IALLOC_DEBUG
-
-#ifdef UFS_IALLOC_DEBUG
-#define UFSD(x) printk("(%s, %d), %s: ", __FILE__, __LINE__, __FUNCTION__); printk x;
-#else
-#define UFSD(x)
-#endif
-
 /*
  * NOTE! When we get the inode, we're the only people
  * that have access to it, and as such there are no
@@ -68,7 +60,7 @@ void ufs_free_inode (struct inode * inod
 	int is_directory;
 	unsigned ino, cg, bit;
 	
-	UFSD(("ENTER, ino %lu\n", inode->i_ino))
+	UFSD("ENTER, ino %lu\n", inode->i_ino);
 
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
@@ -130,7 +122,7 @@ void ufs_free_inode (struct inode * inod
 	
 	sb->s_dirt = 1;
 	unlock_super (sb);
-	UFSD(("EXIT\n"))
+	UFSD("EXIT\n");
 }
 
 /*
@@ -155,7 +147,7 @@ struct inode * ufs_new_inode(struct inod
 	unsigned cg, bit, i, j, start;
 	struct ufs_inode_info *ufsi;
 
-	UFSD(("ENTER\n"))
+	UFSD("ENTER\n");
 	
 	/* Cannot create files in a deleted directory */
 	if (!dir || !dir->i_nlink)
@@ -227,7 +219,7 @@ cg_found:
 			goto failed;
 		}
 	}
-	UFSD(("start = %u, bit = %u, ipg = %u\n", start, bit, uspi->s_ipg))
+	UFSD("start = %u, bit = %u, ipg = %u\n", start, bit, uspi->s_ipg);
 	if (ubh_isclr (UCPI_UBH(ucpi), ucpi->c_iusedoff, bit))
 		ubh_setbit (UCPI_UBH(ucpi), ucpi->c_iusedoff, bit);
 	else {
@@ -287,14 +279,14 @@ cg_found:
 		return ERR_PTR(-EDQUOT);
 	}
 
-	UFSD(("allocating inode %lu\n", inode->i_ino))
-	UFSD(("EXIT\n"))
+	UFSD("allocating inode %lu\n", inode->i_ino);
+	UFSD("EXIT\n");
 	return inode;
 
 failed:
 	unlock_super (sb);
 	make_bad_inode(inode);
 	iput (inode);
-	UFSD(("EXIT (FAILED)\n"))
+	UFSD("EXIT (FAILED)\n");
 	return ERR_PTR(-ENOSPC);
 }
Index: linux-2.6.17-rc5-mm1/fs/ufs/truncate.c
===================================================================
--- linux-2.6.17-rc5-mm1.orig/fs/ufs/truncate.c
+++ linux-2.6.17-rc5-mm1/fs/ufs/truncate.c
@@ -49,14 +49,6 @@
 #include "swab.h"
 #include "util.h"
 
-#undef UFS_TRUNCATE_DEBUG
-
-#ifdef UFS_TRUNCATE_DEBUG
-#define UFSD(x) printk("(%s, %d), %s: ", __FILE__, __LINE__, __FUNCTION__); printk x;
-#else
-#define UFSD(x)
-#endif
- 
 /*
  * Secure deletion currently doesn't work. It interacts very badly
  * with buffers shared with memory mappings, and for that reason
@@ -82,7 +74,7 @@ static int ufs_trunc_direct (struct inod
 	unsigned i, tmp;
 	int retry;
 	
-	UFSD(("ENTER\n"))
+	UFSD("ENTER\n");
 
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
@@ -105,7 +97,7 @@ static int ufs_trunc_direct (struct inod
 		block2 = ufs_fragstoblks (frag3);
 	}
 
-	UFSD(("frag1 %u, frag2 %u, block1 %u, block2 %u, frag3 %u, frag4 %u\n", frag1, frag2, block1, block2, frag3, frag4))
+	UFSD("frag1 %u, frag2 %u, block1 %u, block2 %u, frag3 %u, frag4 %u\n", frag1, frag2, block1, block2, frag3, frag4);
 
 	if (frag1 >= frag2)
 		goto next1;		
@@ -171,7 +163,7 @@ next1:
 	ufs_free_fragments (inode, tmp, frag4);
  next3:
 
-	UFSD(("EXIT\n"))
+	UFSD("EXIT\n");
 	return retry;
 }
 
@@ -186,7 +178,7 @@ static int ufs_trunc_indirect (struct in
 	unsigned frag_to_free, free_count;
 	int retry;
 
-	UFSD(("ENTER\n"))
+	UFSD("ENTER\n");
 		
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
@@ -252,7 +244,7 @@ static int ufs_trunc_indirect (struct in
 	}
 	ubh_brelse (ind_ubh);
 	
-	UFSD(("EXIT\n"))
+	UFSD("EXIT\n");
 	
 	return retry;
 }
@@ -266,7 +258,7 @@ static int ufs_trunc_dindirect (struct i
 	__fs32 * dind;
 	int retry = 0;
 	
-	UFSD(("ENTER\n"))
+	UFSD("ENTER\n");
 	
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
@@ -315,7 +307,7 @@ static int ufs_trunc_dindirect (struct i
 	}
 	ubh_brelse (dind_bh);
 	
-	UFSD(("EXIT\n"))
+	UFSD("EXIT\n");
 	
 	return retry;
 }
@@ -330,7 +322,7 @@ static int ufs_trunc_tindirect (struct i
 	__fs32 * tind, * p;
 	int retry;
 	
-	UFSD(("ENTER\n"))
+	UFSD("ENTER\n");
 
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
@@ -375,7 +367,7 @@ static int ufs_trunc_tindirect (struct i
 	}
 	ubh_brelse (tind_bh);
 	
-	UFSD(("EXIT\n"))
+	UFSD("EXIT\n");
 	return retry;
 }
 		
@@ -386,7 +378,7 @@ void ufs_truncate (struct inode * inode)
 	struct ufs_sb_private_info * uspi;
 	int retry;
 	
-	UFSD(("ENTER\n"))
+	UFSD("ENTER\n");
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
 
@@ -417,5 +409,5 @@ void ufs_truncate (struct inode * inode)
 	ufsi->i_lastfrag = DIRECT_FRAGMENT;
 	unlock_kernel();
 	mark_inode_dirty(inode);
-	UFSD(("EXIT\n"))
+	UFSD("EXIT\n");
 }
Index: linux-2.6.17-rc5-mm1/fs/ufs/super.c
===================================================================
--- linux-2.6.17-rc5-mm1.orig/fs/ufs/super.c
+++ linux-2.6.17-rc5-mm1/fs/ufs/super.c
@@ -90,18 +90,7 @@
 #include "swab.h"
 #include "util.h"
 
-#undef UFS_SUPER_DEBUG
-#undef UFS_SUPER_DEBUG_MORE
-
-
-#undef UFS_SUPER_DEBUG_MORE
-#ifdef UFS_SUPER_DEBUG
-#define UFSD(x) printk("(%s, %d), %s: ", __FILE__, __LINE__, __FUNCTION__); printk x;
-#else
-#define UFSD(x)
-#endif
-
-#ifdef UFS_SUPER_DEBUG_MORE
+#ifdef CONFIG_UFS_DEBUG
 /*
  * Print contents of ufs_super_block, useful for debugging
  */
@@ -157,18 +146,23 @@ void ufs2_print_super_stuff(
 	printk("ufs_print_super_stuff\n");
 	printk("size of usb:     %u\n", sizeof(struct ufs_super_block));
 	printk("  magic:         0x%x\n", fs32_to_cpu(sb, usb->fs_magic));
-	printk("  fs_size:   %u\n",fs64_to_cpu(sb, usb->fs_u11.fs_u2.fs_size));
-	printk("  fs_dsize:  %u\n",fs64_to_cpu(sb, usb->fs_u11.fs_u2.fs_dsize));
-	printk("  bsize:         %u\n", fs32_to_cpu(usb, usb->fs_bsize));
-	printk("  fsize:         %u\n", fs32_to_cpu(usb, usb->fs_fsize));
+	printk("  fs_size:   %llu\n",
+	       (unsigned long long)fs64_to_cpu(sb, usb->fs_u11.fs_u2.fs_size));
+	printk("  fs_dsize:  %llu\n",
+	       (unsigned long long)fs64_to_cpu(sb, usb->fs_u11.fs_u2.fs_dsize));
+	printk("  bsize:         %u\n", fs32_to_cpu(sb, usb->fs_bsize));
+	printk("  fsize:         %u\n", fs32_to_cpu(sb, usb->fs_fsize));
 	printk("  fs_volname:  %s\n", usb->fs_u11.fs_u2.fs_volname);
 	printk("  fs_fsmnt:  %s\n", usb->fs_u11.fs_u2.fs_fsmnt);
-	printk("  fs_sblockloc: %u\n",fs64_to_cpu(sb,
-			usb->fs_u11.fs_u2.fs_sblockloc));
-	printk("  cs_ndir(No of dirs):  %u\n",fs64_to_cpu(sb,
-			usb->fs_u11.fs_u2.fs_cstotal.cs_ndir));
-	printk("  cs_nbfree(No of free blocks):  %u\n",fs64_to_cpu(sb,
-			usb->fs_u11.fs_u2.fs_cstotal.cs_nbfree));
+	printk("  fs_sblockloc: %llu\n",
+	       (unsigned long long)fs64_to_cpu(sb,
+					       usb->fs_u11.fs_u2.fs_sblockloc));
+	printk("  cs_ndir(No of dirs):  %llu\n",
+	       (unsigned long long)fs64_to_cpu(sb,
+				         usb->fs_u11.fs_u2.fs_cstotal.cs_ndir));
+	printk("  cs_nbfree(No of free blocks):  %llu\n",
+	       (unsigned long long)fs64_to_cpu(sb,
+				       usb->fs_u11.fs_u2.fs_cstotal.cs_nbfree));
 	printk("\n");
 }
 
@@ -207,7 +201,7 @@ void ufs_print_cylinder_stuff(struct sup
 	printk("  nclusterblks  %u\n", fs32_to_cpu(sb, cg->cg_u.cg_44.cg_nclusterblks));
 	printk("\n");
 }
-#endif /* UFS_SUPER_DEBUG_MORE */
+#endif /* CONFIG_UFS_DEBUG */
 
 static struct super_operations ufs_super_ops;
 
@@ -309,7 +303,7 @@ static int ufs_parse_options (char * opt
 {
 	char * p;
 	
-	UFSD(("ENTER\n"))
+	UFSD("ENTER\n");
 	
 	if (!options)
 		return 1;
@@ -398,7 +392,7 @@ static int ufs_read_cylinder_structures 
 	unsigned size, blks, i;
 	unsigned flags = 0;
 	
-	UFSD(("ENTER\n"))
+	UFSD("ENTER\n");
 	
 	uspi = sbi->s_uspi;
 
@@ -451,12 +445,12 @@ static int ufs_read_cylinder_structures 
 		sbi->s_cgno[i] = UFS_CGNO_EMPTY;
 	}
 	for (i = 0; i < uspi->s_ncg; i++) {
-		UFSD(("read cg %u\n", i))
+		UFSD("read cg %u\n", i);
 		if (!(sbi->s_ucg[i] = sb_bread(sb, ufs_cgcmin(i))))
 			goto failed;
 		if (!ufs_cg_chkmagic (sb, (struct ufs_cylinder_group *) sbi->s_ucg[i]->b_data))
 			goto failed;
-#ifdef UFS_SUPER_DEBUG_MORE
+#ifdef CONFIG_UFS_DEBUG
 		ufs_print_cylinder_stuff(sb, (struct ufs_cylinder_group *) sbi->s_ucg[i]->b_data);
 #endif
 	}
@@ -466,7 +460,7 @@ static int ufs_read_cylinder_structures 
 		sbi->s_cgno[i] = UFS_CGNO_EMPTY;
 	}
 	sbi->s_cg_loaded = 0;
-	UFSD(("EXIT\n"))
+	UFSD("EXIT\n");
 	return 1;
 
 failed:
@@ -479,7 +473,7 @@ failed:
 		for (i = 0; i < UFS_MAX_GROUP_LOADED; i++)
 			kfree (sbi->s_ucpi[i]);
 	}
-	UFSD(("EXIT (FAILED)\n"))
+	UFSD("EXIT (FAILED)\n");
 	return 0;
 }
 
@@ -495,7 +489,7 @@ static void ufs_put_cylinder_structures 
 	unsigned char * base, * space;
 	unsigned blks, size, i;
 	
-	UFSD(("ENTER\n"))
+	UFSD("ENTER\n");
 	
 	uspi = sbi->s_uspi;
 
@@ -523,7 +517,7 @@ static void ufs_put_cylinder_structures 
 		brelse (sbi->s_ucg[i]);
 	kfree (sbi->s_ucg);
 	kfree (base);
-	UFSD(("EXIT\n"))
+	UFSD("EXIT\n");
 }
 
 static int ufs_fill_super(struct super_block *sb, void *data, int silent)
@@ -544,7 +538,7 @@ static int ufs_fill_super(struct super_b
 	ubh = NULL;
 	flags = 0;
 	
-	UFSD(("ENTER\n"))
+	UFSD("ENTER\n");
 		
 	sbi = kmalloc(sizeof(struct ufs_sb_info), GFP_KERNEL);
 	if (!sbi)
@@ -552,7 +546,7 @@ static int ufs_fill_super(struct super_b
 	sb->s_fs_info = sbi;
 	memset(sbi, 0, sizeof(struct ufs_sb_info));
 
-	UFSD(("flag %u\n", (int)(sb->s_flags & MS_RDONLY)))
+	UFSD("flag %u\n", (int)(sb->s_flags & MS_RDONLY));
 	
 #ifndef CONFIG_UFS_FS_WRITE
 	if (!(sb->s_flags & MS_RDONLY)) {
@@ -593,7 +587,7 @@ static int ufs_fill_super(struct super_b
 	   the rules */
 	switch (sbi->s_mount_opt & UFS_MOUNT_UFSTYPE) {
 	case UFS_MOUNT_UFSTYPE_44BSD:
-		UFSD(("ufstype=44bsd\n"))
+		UFSD("ufstype=44bsd\n");
 		uspi->s_fsize = block_size = 512;
 		uspi->s_fmask = ~(512 - 1);
 		uspi->s_fshift = 9;
@@ -602,7 +596,7 @@ static int ufs_fill_super(struct super_b
 		flags |= UFS_DE_44BSD | UFS_UID_44BSD | UFS_ST_44BSD | UFS_CG_44BSD;
 		break;
 	case UFS_MOUNT_UFSTYPE_UFS2:
-		UFSD(("ufstype=ufs2\n"));
+		UFSD("ufstype=ufs2\n");
 		super_block_offset=SBLOCK_UFS2;
 		uspi->s_fsize = block_size = 512;
 		uspi->s_fmask = ~(512 - 1);
@@ -617,7 +611,7 @@ static int ufs_fill_super(struct super_b
 		break;
 		
 	case UFS_MOUNT_UFSTYPE_SUN:
-		UFSD(("ufstype=sun\n"))
+		UFSD("ufstype=sun\n");
 		uspi->s_fsize = block_size = 1024;
 		uspi->s_fmask = ~(1024 - 1);
 		uspi->s_fshift = 10;
@@ -628,7 +622,7 @@ static int ufs_fill_super(struct super_b
 		break;
 
 	case UFS_MOUNT_UFSTYPE_SUNx86:
-		UFSD(("ufstype=sunx86\n"))
+		UFSD("ufstype=sunx86\n");
 		uspi->s_fsize = block_size = 1024;
 		uspi->s_fmask = ~(1024 - 1);
 		uspi->s_fshift = 10;
@@ -639,7 +633,7 @@ static int ufs_fill_super(struct super_b
 		break;
 
 	case UFS_MOUNT_UFSTYPE_OLD:
-		UFSD(("ufstype=old\n"))
+		UFSD("ufstype=old\n");
 		uspi->s_fsize = block_size = 1024;
 		uspi->s_fmask = ~(1024 - 1);
 		uspi->s_fshift = 10;
@@ -654,7 +648,7 @@ static int ufs_fill_super(struct super_b
 		break;
 	
 	case UFS_MOUNT_UFSTYPE_NEXTSTEP:
-		UFSD(("ufstype=nextstep\n"))
+		UFSD("ufstype=nextstep\n");
 		uspi->s_fsize = block_size = 1024;
 		uspi->s_fmask = ~(1024 - 1);
 		uspi->s_fshift = 10;
@@ -669,7 +663,7 @@ static int ufs_fill_super(struct super_b
 		break;
 	
 	case UFS_MOUNT_UFSTYPE_NEXTSTEP_CD:
-		UFSD(("ufstype=nextstep-cd\n"))
+		UFSD("ufstype=nextstep-cd\n");
 		uspi->s_fsize = block_size = 2048;
 		uspi->s_fmask = ~(2048 - 1);
 		uspi->s_fshift = 11;
@@ -684,7 +678,7 @@ static int ufs_fill_super(struct super_b
 		break;
 	
 	case UFS_MOUNT_UFSTYPE_OPENSTEP:
-		UFSD(("ufstype=openstep\n"))
+		UFSD("ufstype=openstep\n");
 		uspi->s_fsize = block_size = 1024;
 		uspi->s_fmask = ~(1024 - 1);
 		uspi->s_fshift = 10;
@@ -699,7 +693,7 @@ static int ufs_fill_super(struct super_b
 		break;
 	
 	case UFS_MOUNT_UFSTYPE_HP:
-		UFSD(("ufstype=hp\n"))
+		UFSD("ufstype=hp\n");
 		uspi->s_fsize = block_size = 1024;
 		uspi->s_fmask = ~(1024 - 1);
 		uspi->s_fshift = 10;
@@ -820,11 +814,11 @@ magic_found:
 		ubh = NULL;
 		block_size = uspi->s_fsize;
 		super_block_size = uspi->s_sbsize;
-		UFSD(("another value of block_size or super_block_size %u, %u\n", block_size, super_block_size))
+		UFSD("another value of block_size or super_block_size %u, %u\n", block_size, super_block_size);
 		goto again;
 	}
 
-#ifdef UFS_SUPER_DEBUG_MORE
+#ifdef CONFIG_UFS_DEBUG
         if ((flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2)
 		ufs2_print_super_stuff(sb,usb);
         else
@@ -842,13 +836,13 @@ magic_found:
 	  (ufs_get_fs_state(sb, usb1, usb3) == (UFS_FSOK - fs32_to_cpu(sb, usb1->fs_time))))) {
 		switch(usb1->fs_clean) {
 		case UFS_FSCLEAN:
-			UFSD(("fs is clean\n"))
+			UFSD("fs is clean\n");
 			break;
 		case UFS_FSSTABLE:
-			UFSD(("fs is stable\n"))
+			UFSD("fs is stable\n");
 			break;
 		case UFS_FSOSF1:
-			UFSD(("fs is DEC OSF/1\n"))
+			UFSD("fs is DEC OSF/1\n");
 			break;
 		case UFS_FSACTIVE:
 			printk("ufs_read_super: fs is active\n");
@@ -901,8 +895,8 @@ magic_found:
 	uspi->s_fmask = fs32_to_cpu(sb, usb1->fs_fmask);
 	uspi->s_bshift = fs32_to_cpu(sb, usb1->fs_bshift);
 	uspi->s_fshift = fs32_to_cpu(sb, usb1->fs_fshift);
-	UFSD(("uspi->s_bshift = %d,uspi->s_fshift = %d", uspi->s_bshift,
-		uspi->s_fshift));
+	UFSD("uspi->s_bshift = %d,uspi->s_fshift = %d", uspi->s_bshift,
+		uspi->s_fshift);
 	uspi->s_fpbshift = fs32_to_cpu(sb, usb1->fs_fragshift);
 	uspi->s_fsbtodb = fs32_to_cpu(sb, usb1->fs_fsbtodb);
 	/* s_sbsize already set */
@@ -935,12 +929,11 @@ magic_found:
 	 * Compute another frequently used values
 	 */
 	uspi->s_fpbmask = uspi->s_fpb - 1;
-	if ((flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2) {
+	if ((flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2)
 		uspi->s_apbshift = uspi->s_bshift - 3;
-	}
-	else {
+	else
 		uspi->s_apbshift = uspi->s_bshift - 2;
-	}
+
 	uspi->s_2apbshift = uspi->s_apbshift * 2;
 	uspi->s_3apbshift = uspi->s_apbshift * 3;
 	uspi->s_apb = 1 << uspi->s_apbshift;
@@ -975,7 +968,7 @@ magic_found:
 		if (!ufs_read_cylinder_structures(sb))
 			goto failed;
 
-	UFSD(("EXIT\n"))
+	UFSD("EXIT\n");
 	return 0;
 
 dalloc_failed:
@@ -986,11 +979,11 @@ failed:
 	kfree (uspi);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
-	UFSD(("EXIT (FAILED)\n"))
+	UFSD("EXIT (FAILED)\n");
 	return -EINVAL;
 
 failed_nomem:
-	UFSD(("EXIT (NOMEM)\n"))
+	UFSD("EXIT (NOMEM)\n");
 	return -ENOMEM;
 }
 
@@ -1002,7 +995,7 @@ static void ufs_write_super (struct supe
 
 	lock_kernel();
 
-	UFSD(("ENTER\n"))
+	UFSD("ENTER\n");
 	flags = UFS_SB(sb)->s_flags;
 	uspi = UFS_SB(sb)->s_uspi;
 	usb1 = ubh_get_usb_first(uspi);
@@ -1017,15 +1010,15 @@ static void ufs_write_super (struct supe
 		ubh_mark_buffer_dirty (USPI_UBH(uspi));
 	}
 	sb->s_dirt = 0;
-	UFSD(("EXIT\n"))
+	UFSD("EXIT\n");
 	unlock_kernel();
 }
 
-static void ufs_put_super (struct super_block *sb)
+static void ufs_put_super(struct super_block *sb)
 {
 	struct ufs_sb_info * sbi = UFS_SB(sb);
 		
-	UFSD(("ENTER\n"))
+	UFSD("ENTER\n");
 
 	if (!(sb->s_flags & MS_RDONLY))
 		ufs_put_cylinder_structures (sb);
@@ -1034,6 +1027,7 @@ static void ufs_put_super (struct super_
 	kfree (sbi->s_uspi);
 	kfree (sbi);
 	sb->s_fs_info = NULL;
+UFSD("EXIT\n");
 	return;
 }
 
Index: linux-2.6.17-rc5-mm1/fs/ufs/inode.c
===================================================================
--- linux-2.6.17-rc5-mm1.orig/fs/ufs/inode.c
+++ linux-2.6.17-rc5-mm1/fs/ufs/inode.c
@@ -41,15 +41,6 @@
 #include "swab.h"
 #include "util.h"
 
-#undef UFS_INODE_DEBUG
-#undef UFS_INODE_DEBUG_MORE
-
-#ifdef UFS_INODE_DEBUG
-#define UFSD(x) printk("(%s, %d), %s: ", __FILE__, __LINE__, __FUNCTION__); printk x;
-#else
-#define UFSD(x)
-#endif
-
 static int ufs_block_to_path(struct inode *inode, sector_t i_block, sector_t offsets[4])
 {
 	struct ufs_sb_private_info *uspi = UFS_SB(inode->i_sb)->s_uspi;
@@ -61,7 +52,7 @@ static int ufs_block_to_path(struct inod
 	int n = 0;
 
 
-	UFSD(("ptrs=uspi->s_apb = %d,double_blocks=%ld \n",ptrs,double_blocks));
+	UFSD("ptrs=uspi->s_apb = %d,double_blocks=%ld \n",ptrs,double_blocks);
 	if (i_block < 0) {
 		ufs_warning(inode->i_sb, "ufs_block_to_path", "block < 0");
 	} else if (i_block < direct_blocks) {
@@ -104,8 +95,8 @@ u64  ufs_frag_map(struct inode *inode, s
 	unsigned flags = UFS_SB(sb)->s_flags;
 	u64 temp = 0L;
 
-	UFSD((": frag = %llu  depth = %d\n", (unsigned long long)frag, depth));
-	UFSD((": uspi->s_fpbshift = %d ,uspi->s_apbmask = %x, mask=%llx\n",uspi->s_fpbshift,uspi->s_apbmask,mask));
+	UFSD(": frag = %llu  depth = %d\n", (unsigned long long)frag, depth);
+	UFSD(": uspi->s_fpbshift = %d ,uspi->s_apbmask = %x, mask=%llx\n",uspi->s_fpbshift,uspi->s_apbmask,mask);
 
 	if (depth == 0)
 		return 0;
@@ -186,8 +177,8 @@ static struct buffer_head *ufs_inode_get
 	__fs32 * p, * p2;
 	unsigned flags = 0;
 
-	UFSD(("ENTER, ino %lu, fragment %u, new_fragment %u, required %u\n",
-		inode->i_ino, fragment, new_fragment, required))         
+	UFSD("ENTER, ino %lu, fragment %u, new_fragment %u, required %u\n",
+		inode->i_ino, fragment, new_fragment, required);
 
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
@@ -210,7 +201,7 @@ repeat:
 		if (metadata) {
 			result = sb_getblk(sb, uspi->s_sbbase + tmp + blockoff);
 			if (tmp == fs32_to_cpu(sb, *p)) {
-				UFSD(("EXIT, result %u\n", tmp + blockoff))
+				UFSD("EXIT, result %u\n", tmp + blockoff);
 				return result;
 			}
 			brelse (result);
@@ -288,7 +279,7 @@ repeat:
 	if (IS_SYNC(inode))
 		ufs_sync_inode (inode);
 	mark_inode_dirty(inode);
-	UFSD(("EXIT, result %u\n", tmp + blockoff))
+	UFSD("EXIT, result %u\n", tmp + blockoff);
 	return result;
 
      /* This part : To be implemented ....
@@ -323,7 +314,7 @@ static struct buffer_head *ufs_block_get
 	block = ufs_fragstoblks (fragment);
 	blockoff = ufs_fragnum (fragment);
 
-	UFSD(("ENTER, ino %lu, fragment %u, new_fragment %u\n", inode->i_ino, fragment, new_fragment))	
+	UFSD("ENTER, ino %lu, fragment %u, new_fragment %u\n", inode->i_ino, fragment, new_fragment);
 
 	result = NULL;
 	if (!bh)
@@ -377,10 +368,10 @@ repeat:
 		sync_dirty_buffer(bh);
 	inode->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
-	UFSD(("result %u\n", tmp + blockoff));
+	UFSD("result %u\n", tmp + blockoff);
 out:
 	brelse (bh);
-	UFSD(("EXIT\n"));
+	UFSD("EXIT\n");
 	return result;
 }
 
@@ -399,7 +390,7 @@ int ufs_getfrag_block (struct inode *ino
 	
 	if (!create) {
 		phys64 = ufs_frag_map(inode, fragment);
-		UFSD(("phys64 = %llu \n",phys64));
+		UFSD("phys64 = %llu \n",phys64);
 		if (phys64)
 			map_bh(bh_result, sb, phys64);
 		return 0;
@@ -414,7 +405,7 @@ int ufs_getfrag_block (struct inode *ino
 
 	lock_kernel();
 
-	UFSD(("ENTER, ino %lu, fragment %llu\n", inode->i_ino, (unsigned long long)fragment))
+	UFSD("ENTER, ino %lu, fragment %llu\n", inode->i_ino, (unsigned long long)fragment);
 	if (fragment < 0)
 		goto abort_negative;
 	if (fragment >
@@ -514,7 +505,7 @@ struct buffer_head * ufs_bread (struct i
 {
 	struct buffer_head * bh;
 
-	UFSD(("ENTER, ino %lu, fragment %u\n", inode->i_ino, fragment))
+	UFSD("ENTER, ino %lu, fragment %u\n", inode->i_ino, fragment);
 	bh = ufs_getfrag (inode, fragment, create, err);
 	if (!bh || buffer_uptodate(bh)) 		
 		return bh;
@@ -586,7 +577,7 @@ void ufs_read_inode (struct inode * inod
 	unsigned i;
 	unsigned flags;
 	
-	UFSD(("ENTER, ino %lu\n", inode->i_ino))
+	UFSD("ENTER, ino %lu\n", inode->i_ino);
 	
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
@@ -652,7 +643,7 @@ void ufs_read_inode (struct inode * inod
 
 	brelse (bh);
 
-	UFSD(("EXIT\n"))
+	UFSD("EXIT\n");
 	return;
 
 bad_inode:
@@ -660,7 +651,7 @@ bad_inode:
 	return;
 
 ufs2_inode :
-	UFSD(("Reading ufs2 inode, ino %lu\n", inode->i_ino))
+	UFSD("Reading ufs2 inode, ino %lu\n", inode->i_ino);
 
 	ufs2_inode = (struct ufs2_inode *)(bh->b_data + sizeof(struct ufs2_inode) * ufs_inotofsbo(inode->i_ino));
 
@@ -712,7 +703,7 @@ ufs2_inode :
 
 	brelse(bh);
 
-	UFSD(("EXIT\n"))
+	UFSD("EXIT\n");
 	return;
 }
 
@@ -726,7 +717,7 @@ static int ufs_update_inode(struct inode
 	unsigned i;
 	unsigned flags;
 
-	UFSD(("ENTER, ino %lu\n", inode->i_ino))
+	UFSD("ENTER, ino %lu\n", inode->i_ino);
 
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
@@ -787,7 +778,7 @@ static int ufs_update_inode(struct inode
 		sync_dirty_buffer(bh);
 	brelse (bh);
 	
-	UFSD(("EXIT\n"))
+	UFSD("EXIT\n");
 	return 0;
 }
 
Index: linux-2.6.17-rc5-mm1/fs/ufs/namei.c
===================================================================
--- linux-2.6.17-rc5-mm1.orig/fs/ufs/namei.c
+++ linux-2.6.17-rc5-mm1/fs/ufs/namei.c
@@ -34,17 +34,6 @@
 #include "swab.h"	/* will go away - see comment in mknod() */
 #include "util.h"
 
-/*
-#undef UFS_NAMEI_DEBUG
-*/
-#define UFS_NAMEI_DEBUG
-
-#ifdef UFS_NAMEI_DEBUG
-#define UFSD(x) printk("(%s, %d), %s: ", __FILE__, __LINE__, __FUNCTION__); printk x;
-#else
-#define UFSD(x)
-#endif
-
 static inline int ufs_add_nondir(struct dentry *dentry, struct inode *inode)
 {
 	int err = ufs_add_link(dentry, inode);
@@ -90,8 +79,13 @@ static struct dentry *ufs_lookup(struct 
 static int ufs_create (struct inode * dir, struct dentry * dentry, int mode,
 		struct nameidata *nd)
 {
-	struct inode * inode = ufs_new_inode(dir, mode);
-	int err = PTR_ERR(inode);
+	struct inode *inode;
+	int err;
+
+	UFSD("BEGIN\n");
+	inode = ufs_new_inode(dir, mode);
+	err = PTR_ERR(inode);
+
 	if (!IS_ERR(inode)) {
 		inode->i_op = &ufs_file_inode_operations;
 		inode->i_fop = &ufs_file_operations;
@@ -101,6 +95,7 @@ static int ufs_create (struct inode * di
 		err = ufs_add_nondir(dentry, inode);
 		unlock_kernel();
 	}
+	UFSD("END: err=%d\n", err);
 	return err;
 }
 
Index: linux-2.6.17-rc5-mm1/fs/ufs/util.c
===================================================================
--- linux-2.6.17-rc5-mm1.orig/fs/ufs/util.c
+++ linux-2.6.17-rc5-mm1/fs/ufs/util.c
@@ -14,15 +14,6 @@
 #include "swab.h"
 #include "util.h"
 
-#undef UFS_UTILS_DEBUG
-
-#ifdef UFS_UTILS_DEBUG
-#define UFSD(x) printk("(%s, %d), %s: ", __FILE__, __LINE__, __FUNCTION__); printk x;
-#else
-#define UFSD(x)
-#endif
-
-
 struct ufs_buffer_head * _ubh_bread_ (struct ufs_sb_private_info * uspi,
 	struct super_block *sb, u64 fragment, u64 size)
 {
Index: linux-2.6.17-rc5-mm1/fs/Kconfig
===================================================================
--- linux-2.6.17-rc5-mm1.orig/fs/Kconfig
+++ linux-2.6.17-rc5-mm1/fs/Kconfig
@@ -1389,6 +1389,14 @@ config UFS_FS_WRITE
 	  Say Y here if you want to try writing to UFS partitions. This is
 	  experimental, so you should back up your UFS partitions beforehand.
 
+config UFS_DEBUG
+	bool "UFS debugging"
+	depends on UFS_FS
+	help
+	  If you are experiencing any problems with the UFS filesystem, say
+	  Y here.  This will result in _many_ additional debugging messages to be
+	  written to the system log.
+
 endmenu
 
 menu "Network File Systems"

-- 
/Evgeniy

