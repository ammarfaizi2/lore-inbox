Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbUJ3WL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbUJ3WL2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 18:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbUJ3WL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 18:11:28 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:61957 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261355AbUJ3WKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:10:13 -0400
Date: Sun, 31 Oct 2004 00:09:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] some NTFS cleanups
Message-ID: <20041030220940.GF4374@stusta.de>
References: <20041030180304.GR4374@stusta.de> <Pine.LNX.4.60.0410301933300.3786@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0410301933300.3786@hermes-1.csi.cam.ac.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 07:57:27PM +0100, Anton Altaparmakov wrote:

> Hi Adrian,

Hi Anton,

> >From a quick read of your patch:
> 
> On Sat, 30 Oct 2004, Adrian Bunk wrote:
> > The patch below does the following cleanups for the NTFS code:
> > - remove three currently unused global functions
> 
> Assuming these are the functions in unistr.c then they need to stay.  We 
> are not using them yet but we will when we start creating/deleting files 
> and things like that.

OK.

> > - make several functions and variables static (yes, I've read the
> 
> Most of those look good, again except the entirety of unistr.c where we 
> will be using those functions later on.  Admittedly we can make them 
> static for now and undo each as it gets a user outside of unistr.c.
>...
> Mostly it is fine; great in fact.  I will apply it to the ntfs-2.6-devel 
> tree on Monday but I will leave the three functions you have taken out in.  
> If you want send me a new patch with the three functions left in before 
> Monday and I can apply it as is.  (-:
>...

Below is the patch without the unistr.c parts.


diffstat output:
 fs/ntfs/aops.c  |    4 +---
 fs/ntfs/inode.c |    4 ++--
 fs/ntfs/ntfs.h  |    3 ---
 fs/ntfs/super.c |   11 +++++-----
 4 files changed, 8 insertions(+), 13 deletions(-)


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

