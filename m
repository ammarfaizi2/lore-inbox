Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbWIRXiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWIRXiU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 19:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbWIRXiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 19:38:20 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:49334 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030260AbWIRXiT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 19:38:19 -0400
Subject: Re: [PATCH] EXT2: Remove superblock lock contention in ext2_statfs
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Valerie Henson <val_henson@linux.intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext4 development <linux-ext4@vger.kernel.org>
In-Reply-To: <1158611794.11940.40.camel@kleikamp.austin.ibm.com>
References: <1158611794.11940.40.camel@kleikamp.austin.ibm.com>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 18:38:05 -0500
Message-Id: <1158622685.11940.52.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-18 at 15:36 -0500, Dave Kleikamp wrote:
> EXT2: Remove superblock lock contention in ext2_statfs
> 
> Fix a performance degradation introduced in 2.6.17.  (30% degradation running
> dbench with 16 threads)
> 
> Patch 21730eed11de42f22afcbd43f450a1872a0b5ea1, which claims to make
> EXT2_DEBUG work again, moves the taking of the kernel lock out of debug-only
> code in ext2_count_free_inodes and ext2_count_free_blocks and into
> ext2_statfs.  This patch reverses that part of the patch.
> 
> Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

Eric Sandeen pointed out to me that taking the superblock lock in
ext2_count_free_* will cause a deadlock when EXT2FS_DEBUG is enabled,
since the superblock is locked in write_super().

We found that the same problem was fixed in ext3 with this patch
(forgive the long link):
http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=5b11687924e40790deb0d5f959247ade82196665;hp=2384f55f8aa520172c995965bd2f8a9740d53095

The patch below just removes the use of the superblock lock in the debug
code.

> diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
> index d487043..fddefff 100644
> --- a/fs/ext2/balloc.c
> +++ b/fs/ext2/balloc.c
> @@ -539,7 +539,6 @@ unsigned long ext2_count_free (struct bu
>  
>  #endif  /*  EXT2FS_DEBUG  */
>  
> -/* Superblock must be locked */
>  unsigned long ext2_count_free_blocks (struct super_block * sb)
>  {
>  	struct ext2_group_desc * desc;
> @@ -549,6 +548,7 @@ #ifdef EXT2FS_DEBUG
>  	unsigned long bitmap_count, x;
>  	struct ext2_super_block *es;
>  
> +	lock_super(sb);
>  	es = EXT2_SB(sb)->s_es;
>  	desc_count = 0;
>  	bitmap_count = 0;
> @@ -572,6 +572,7 @@ #ifdef EXT2FS_DEBUG
>  	printk("ext2_count_free_blocks: stored = %lu, computed = %lu, %lu\n",
>  		(long)le32_to_cpu(es->s_free_blocks_count),
>  		desc_count, bitmap_count);
> +	unlock_super(sb);
>  	return bitmap_count;
>  #else
>          for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
> diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
> index de85c61..5d1d1c9 100644
> --- a/fs/ext2/ialloc.c
> +++ b/fs/ext2/ialloc.c
> @@ -637,7 +637,6 @@ fail:
>  	return ERR_PTR(err);
>  }
>  
> -/* Superblock must be locked */
>  unsigned long ext2_count_free_inodes (struct super_block * sb)
>  {
>  	struct ext2_group_desc *desc;
> @@ -649,6 +648,7 @@ #ifdef EXT2FS_DEBUG
>  	unsigned long bitmap_count = 0;
>  	struct buffer_head *bitmap_bh = NULL;
>  
> +	lock_super(sb);
>  	es = EXT2_SB(sb)->s_es;
>  	for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
>  		unsigned x;
> @@ -671,6 +671,7 @@ #ifdef EXT2FS_DEBUG
>  	printk("ext2_count_free_inodes: stored = %lu, computed = %lu, %lu\n",
>  		percpu_counter_read(&EXT2_SB(sb)->s_freeinodes_counter),
>  		desc_count, bitmap_count);
> +	unlock_super(sb);
>  	return desc_count;
>  #else
>  	for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index ca5bfb6..4286ff6 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -1083,7 +1083,6 @@ static int ext2_statfs (struct dentry * 
>  	unsigned long overhead;
>  	int i;
>  
> -	lock_super(sb);
>  	if (test_opt (sb, MINIX_DF))
>  		overhead = 0;
>  	else {
> @@ -1124,7 +1123,6 @@ static int ext2_statfs (struct dentry * 
>  	buf->f_files = le32_to_cpu(sbi->s_es->s_inodes_count);
>  	buf->f_ffree = ext2_count_free_inodes (sb);
>  	buf->f_namelen = EXT2_NAME_LEN;
> -	unlock_super(sb);
>  	return 0;
>  }
>  
EXT2: Remove superblock lock contention in ext2_statfs

Fix a performance degradation introduced in 2.6.17.  (30% degradation
running
dbench with 16 threads)

Patch 21730eed11de42f22afcbd43f450a1872a0b5ea1, which claims to make
EXT2_DEBUG work again, moves the taking of the kernel lock out of
debug-only
code in ext2_count_free_inodes and ext2_count_free_blocks and into
ext2_statfs.

The same problem was fixed in ext3 by removing the lock completely
(patch 5b11687924e40790deb0d5f959247ade82196665)

Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index d487043..b1981d0 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -539,7 +539,6 @@ unsigned long ext2_count_free (struct bu
 
 #endif  /*  EXT2FS_DEBUG  */
 
-/* Superblock must be locked */
 unsigned long ext2_count_free_blocks (struct super_block * sb)
 {
 	struct ext2_group_desc * desc;
diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
index de85c61..695f69c 100644
--- a/fs/ext2/ialloc.c
+++ b/fs/ext2/ialloc.c
@@ -637,7 +637,6 @@ fail:
 	return ERR_PTR(err);
 }
 
-/* Superblock must be locked */
 unsigned long ext2_count_free_inodes (struct super_block * sb)
 {
 	struct ext2_group_desc *desc;
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index ca5bfb6..4286ff6 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1083,7 +1083,6 @@ static int ext2_statfs (struct dentry * 
 	unsigned long overhead;
 	int i;
 
-	lock_super(sb);
 	if (test_opt (sb, MINIX_DF))
 		overhead = 0;
 	else {
@@ -1124,7 +1123,6 @@ static int ext2_statfs (struct dentry * 
 	buf->f_files = le32_to_cpu(sbi->s_es->s_inodes_count);
 	buf->f_ffree = ext2_count_free_inodes (sb);
 	buf->f_namelen = EXT2_NAME_LEN;
-	unlock_super(sb);
 	return 0;
 }
 

-- 
David Kleikamp
IBM Linux Technology Center

