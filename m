Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbVLOAOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbVLOAOT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 19:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbVLOAOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 19:14:19 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17936 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932480AbVLOAOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 19:14:19 -0500
Date: Thu, 15 Dec 2005 01:14:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/hfsplus/: remove the hfsplus_inode_check() debug function
Message-ID: <20051215001419.GL23349@stusta.de>
References: <20051213170137.GL23349@stusta.de> <Pine.LNX.4.61.0512142319170.1609@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512142319170.1609@scrub.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 11:24:19PM +0100, Roman Zippel wrote:

> Hi,

Hi Roman,

> On Tue, 13 Dec 2005, Adrian Bunk wrote:
> 
> > --- linux-2.6.15-rc2-mm1-full/fs/hfsplus/inode.c.old	2005-11-23 16:37:34.000000000 +0100
> > +++ linux-2.6.15-rc2-mm1-full/fs/hfsplus/inode.c	2005-11-23 16:37:48.000000000 +0100
> > @@ -183,7 +183,6 @@
> >  	hlist_add_head(&inode->i_hash, &HFSPLUS_SB(sb).rsrc_inodes);
> >  	mark_inode_dirty(inode);
> >  	{
> > -	void hfsplus_inode_check(struct super_block *sb);
> >  	atomic_inc(&HFSPLUS_SB(sb).inode_cnt);
> >  	hfsplus_inode_check(sb);
> >  	}
> > @@ -322,7 +321,6 @@
> >  		return NULL;
> >  
> >  	{
> > -	void hfsplus_inode_check(struct super_block *sb);
> >  	atomic_inc(&HFSPLUS_SB(sb).inode_cnt);
> >  	hfsplus_inode_check(sb);
> >  	}
> 
> As this is only a debug function I don't see much point in cleaning it up.
> I'd rather remove it completely (including all references to 
> last_inode_cnt and inode_cnt).

patch below.

> bye, Roman

cu
Adrian


<--  snip  -->


This patch removes the hfsplus_inode_check() debug function.

It also removes the now obsolete last_inode_cnt and inode_cnt from 
struct hfsplus_sb_info.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/hfsplus/hfsplus_fs.h |    3 ---
 fs/hfsplus/inode.c      |   10 ----------
 fs/hfsplus/super.c      |   19 -------------------
 3 files changed, 32 deletions(-)

--- linux-2.6.15-rc5-mm2-full/fs/hfsplus/hfsplus_fs.h.old	2005-12-14 23:34:45.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/fs/hfsplus/hfsplus_fs.h	2005-12-14 23:34:55.000000000 +0100
@@ -143,9 +143,6 @@
 
 	unsigned long flags;
 
-	atomic_t inode_cnt;
-	u32 last_inode_cnt;
-
 	struct hlist_head rsrc_inodes;
 };
 
--- linux-2.6.15-rc5-mm2-full/fs/hfsplus/inode.c.old	2005-12-14 23:33:29.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/fs/hfsplus/inode.c	2005-12-14 23:35:18.000000000 +0100
@@ -182,11 +182,6 @@
 	igrab(dir);
 	hlist_add_head(&inode->i_hash, &HFSPLUS_SB(sb).rsrc_inodes);
 	mark_inode_dirty(inode);
-	{
-	void hfsplus_inode_check(struct super_block *sb);
-	atomic_inc(&HFSPLUS_SB(sb).inode_cnt);
-	hfsplus_inode_check(sb);
-	}
 out:
 	d_add(dentry, inode);
 	return NULL;
@@ -321,11 +316,6 @@
 	if (!inode)
 		return NULL;
 
-	{
-	void hfsplus_inode_check(struct super_block *sb);
-	atomic_inc(&HFSPLUS_SB(sb).inode_cnt);
-	hfsplus_inode_check(sb);
-	}
 	inode->i_ino = HFSPLUS_SB(sb).next_cnid++;
 	inode->i_mode = mode;
 	inode->i_uid = current->fsuid;
--- linux-2.6.15-rc5-mm2-full/fs/hfsplus/super.c.old	2005-12-14 23:33:57.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/fs/hfsplus/super.c	2005-12-14 23:35:26.000000000 +0100
@@ -22,29 +22,12 @@
 
 #include "hfsplus_fs.h"
 
-void hfsplus_inode_check(struct super_block *sb)
-{
-#if 0
-	u32 cnt = atomic_read(&HFSPLUS_SB(sb).inode_cnt);
-	u32 last_cnt = HFSPLUS_SB(sb).last_inode_cnt;
-
-	if (cnt <= (last_cnt / 2) ||
-	    cnt >= (last_cnt * 2)) {
-		HFSPLUS_SB(sb).last_inode_cnt = cnt;
-		printk("inode_check: %u,%u,%u\n", cnt, last_cnt,
-			HFSPLUS_SB(sb).cat_tree ? HFSPLUS_SB(sb).cat_tree->node_hash_cnt : 0);
-	}
-#endif
-}
-
 static void hfsplus_read_inode(struct inode *inode)
 {
 	struct hfs_find_data fd;
 	struct hfsplus_vh *vhdr;
 	int err;
 
-	atomic_inc(&HFSPLUS_SB(inode->i_sb).inode_cnt);
-	hfsplus_inode_check(inode->i_sb);
 	INIT_LIST_HEAD(&HFSPLUS_I(inode).open_dir_list);
 	init_MUTEX(&HFSPLUS_I(inode).extents_lock);
 	HFSPLUS_I(inode).flags = 0;
@@ -155,12 +138,10 @@
 static void hfsplus_clear_inode(struct inode *inode)
 {
 	dprint(DBG_INODE, "hfsplus_clear_inode: %lu\n", inode->i_ino);
-	atomic_dec(&HFSPLUS_SB(inode->i_sb).inode_cnt);
 	if (HFSPLUS_IS_RSRC(inode)) {
 		HFSPLUS_I(HFSPLUS_I(inode).rsrc_inode).rsrc_inode = NULL;
 		iput(HFSPLUS_I(inode).rsrc_inode);
 	}
-	hfsplus_inode_check(inode->i_sb);
 }
 
 static void hfsplus_write_super(struct super_block *sb)

