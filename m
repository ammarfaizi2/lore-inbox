Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbUJ3SGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbUJ3SGq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 14:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbUJ3SGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 14:06:03 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38152 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261248AbUJ3SDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 14:03:36 -0400
Date: Sat, 30 Oct 2004 20:03:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: aia21@cantab.net
Cc: linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] some NTFS cleanups
Message-ID: <20041030180304.GR4374@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the following cleanups for the NTFS code:
- remove three currently unused global functions
- make several functions and variables static (yes, I've read the
  comment before ntfs_readpage before making it static - but I couldn't
  see it being actually true)

Is this patch OK or does it conflict with your future plans for the NTFS 
code?


diffstat output:
 fs/ntfs/aops.c   |    4 +---
 fs/ntfs/inode.c  |    4 ++--
 fs/ntfs/ntfs.h   |   14 --------------
 fs/ntfs/super.c  |   11 ++++++-----
 fs/ntfs/unistr.c |   39 +++++++--------------------------------
 5 files changed, 16 insertions(+), 56 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/fs/ntfs/aops.c.old	2004-10-30 14:06:06.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/ntfs/aops.c	2004-10-30 14:10:51.000000000 +0200
@@ -348,10 +348,8 @@
  * for it to be read in before we can do the copy.
  *
  * Return 0 on success and -errno on error.
- *
- * WARNING: Do not make this function static! It is used by mft.c!
  */
-int ntfs_readpage(struct file *file, struct page *page)
+static int ntfs_readpage(struct file *file, struct page *page)
 {
 	s64 attr_pos;
 	ntfs_inode *ni, *base_ni;
--- linux-2.6.10-rc1-mm2-full/fs/ntfs/inode.c.old	2004-10-30 14:13:06.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/ntfs/inode.c	2004-10-30 14:14:17.000000000 +0200
@@ -352,7 +352,7 @@
 	return NULL;
 }
 
-void ntfs_destroy_extent_inode(ntfs_inode *ni)
+static void ntfs_destroy_extent_inode(ntfs_inode *ni)
 {
 	ntfs_debug("Entering.");
 	BUG_ON(ni->page);
@@ -2133,7 +2133,7 @@
 	}
 }
 
-void __ntfs_clear_inode(ntfs_inode *ni)
+static void __ntfs_clear_inode(ntfs_inode *ni)
 {
 	/* Free all alocated memory. */
 	down_write(&ni->runlist.lock);
--- linux-2.6.10-rc1-mm2-full/fs/ntfs/super.c.old	2004-10-30 14:19:10.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/ntfs/super.c	2004-10-30 14:24:39.000000000 +0200
@@ -44,6 +44,10 @@
 /* Number of mounted file systems which have compression enabled. */
 static unsigned long ntfs_nr_compression_users;
 
+/* A global default upcase table and a corresponding reference count. */
+static ntfschar *default_upcase = NULL;
+static unsigned long ntfs_nr_upcase_users = 0;
+
 /* Error constants/strings used in inode.c::ntfs_show_options(). */
 typedef enum {
 	/* One of these must be present, default is ON_ERRORS_CONTINUE. */
@@ -62,6 +66,7 @@
 	{ 0,			NULL }
 };
 
+
 /**
  * simple_getbool -
  *
@@ -2175,7 +2180,7 @@
 /**
  * The complete super operations.
  */
-struct super_operations ntfs_sops = {
+static struct super_operations ntfs_sops = {
 	.alloc_inode	= ntfs_alloc_big_inode,	  /* VFS: Allocate new inode. */
 	.destroy_inode	= ntfs_destroy_big_inode, /* VFS: Deallocate inode. */
 	.put_inode	= ntfs_put_inode,	  /* VFS: Called just before
@@ -2593,10 +2598,6 @@
 kmem_cache_t *ntfs_attr_ctx_cache;
 kmem_cache_t *ntfs_index_ctx_cache;
 
-/* A global default upcase table and a corresponding reference count. */
-ntfschar *default_upcase = NULL;
-unsigned long ntfs_nr_upcase_users = 0;
-
 /* Driver wide semaphore. */
 DECLARE_MUTEX(ntfs_lock);
 
--- linux-2.6.10-rc1-mm2-full/fs/ntfs/unistr.c.old	2004-10-30 14:25:40.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/ntfs/unistr.c	2004-10-30 14:29:49.000000000 +0200
@@ -49,6 +49,11 @@
 	0x17, 0x17, 0x04, 0x16, 0x18, 0x16, 0x18, 0x18,
 };
 
+static int ntfs_ucsncmp(const ntfschar *s1, const ntfschar *s2, size_t n);
+static int ntfs_ucsncasecmp(const ntfschar *s1, const ntfschar *s2, size_t n,
+			const ntfschar *upcase, const u32 upcase_size);
+
+
 /**
  * ntfs_are_names_equal - compare two Unicode names for equality
  * @s1:			name to compare to @s2
@@ -144,7 +149,7 @@
  * if @s1 (or the first @n Unicode characters thereof) is found, respectively,
  * to be less than, to match, or be greater than @s2.
  */
-int ntfs_ucsncmp(const ntfschar *s1, const ntfschar *s2, size_t n)
+static int ntfs_ucsncmp(const ntfschar *s1, const ntfschar *s2, size_t n)
 {
 	u16 c1, c2;
 	size_t i;
@@ -180,7 +185,7 @@
  * if @s1 (or the first @n Unicode characters thereof) is found, respectively,
  * to be less than, to match, or be greater than @s2.
  */
-int ntfs_ucsncasecmp(const ntfschar *s1, const ntfschar *s2, size_t n,
+static int ntfs_ucsncasecmp(const ntfschar *s1, const ntfschar *s2, size_t n,
 		const ntfschar *upcase, const u32 upcase_size)
 {
 	size_t i;
@@ -201,36 +206,6 @@
 	return 0;
 }
 
-void ntfs_upcase_name(ntfschar *name, u32 name_len, const ntfschar *upcase,
-		const u32 upcase_len)
-{
-	u32 i;
-	u16 u;
-
-	for (i = 0; i < name_len; i++)
-		if ((u = le16_to_cpu(name[i])) < upcase_len)
-			name[i] = upcase[u];
-}
-
-void ntfs_file_upcase_value(FILE_NAME_ATTR *file_name_attr,
-		const ntfschar *upcase, const u32 upcase_len)
-{
-	ntfs_upcase_name((ntfschar*)&file_name_attr->file_name,
-			file_name_attr->file_name_length, upcase, upcase_len);
-}
-
-int ntfs_file_compare_values(FILE_NAME_ATTR *file_name_attr1,
-		FILE_NAME_ATTR *file_name_attr2,
-		const int err_val, const IGNORE_CASE_BOOL ic,
-		const ntfschar *upcase, const u32 upcase_len)
-{
-	return ntfs_collate_names((ntfschar*)&file_name_attr1->file_name,
-			file_name_attr1->file_name_length,
-			(ntfschar*)&file_name_attr2->file_name,
-			file_name_attr2->file_name_length,
-			err_val, ic, upcase, upcase_len);
-}
-
 /**
  * ntfs_nlstoucs - convert NLS string to little endian Unicode string
  * @vol:	ntfs volume which we are working with
--- linux-2.6.10-rc1-mm2-full/fs/ntfs/ntfs.h.old	2004-10-30 14:20:31.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/ntfs/ntfs.h	2004-10-30 14:29:06.000000000 +0200
@@ -53,7 +53,6 @@
 extern kmem_cache_t *ntfs_index_ctx_cache;
 
 /* The various operations structs defined throughout the driver files. */
-extern struct super_operations ntfs_sops;
 extern struct address_space_operations ntfs_aops;
 extern struct address_space_operations ntfs_mst_aops;
 
@@ -86,8 +85,6 @@
 
 /* From fs/ntfs/super.c */
 #define default_upcase_len 0x10000
-extern ntfschar *default_upcase;
-extern unsigned long ntfs_nr_upcase_users;
 extern struct semaphore ntfs_lock;
 
 typedef struct {
@@ -110,17 +107,6 @@
 		const ntfschar *name2, const u32 name2_len,
 		const int err_val, const IGNORE_CASE_BOOL ic,
 		const ntfschar *upcase, const u32 upcase_len);
-extern int ntfs_ucsncmp(const ntfschar *s1, const ntfschar *s2, size_t n);
-extern int ntfs_ucsncasecmp(const ntfschar *s1, const ntfschar *s2, size_t n,
-		const ntfschar *upcase, const u32 upcase_size);
-extern void ntfs_upcase_name(ntfschar *name, u32 name_len,
-		const ntfschar *upcase, const u32 upcase_len);
-extern void ntfs_file_upcase_value(FILE_NAME_ATTR *file_name_attr,
-		const ntfschar *upcase, const u32 upcase_len);
-extern int ntfs_file_compare_values(FILE_NAME_ATTR *file_name_attr1,
-		FILE_NAME_ATTR *file_name_attr2,
-		const int err_val, const IGNORE_CASE_BOOL ic,
-		const ntfschar *upcase, const u32 upcase_len);
 extern int ntfs_nlstoucs(const ntfs_volume *vol, const char *ins,
 		const int ins_len, ntfschar **outs);
 extern int ntfs_ucstonls(const ntfs_volume *vol, const ntfschar *ins,

