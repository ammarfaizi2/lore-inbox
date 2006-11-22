Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757174AbWKVXgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757174AbWKVXgY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 18:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757170AbWKVXgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 18:36:24 -0500
Received: from smtp.osdl.org ([65.172.181.25]:45545 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1757175AbWKVXgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 18:36:23 -0500
Date: Wed, 22 Nov 2006 15:36:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Wendy Cheng <wcheng@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] prune_icache_sb
Message-Id: <20061122153603.33c2c24d.akpm@osdl.org>
In-Reply-To: <4564C28B.30604@redhat.com>
References: <4564C28B.30604@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2006 16:35:07 -0500
Wendy Cheng <wcheng@redhat.com> wrote:

> There seems to have a need to prune inode cache entries for specific 
> mount points (per vfs superblock) due to performance issues found after 
> some io intensive commands ("rsyn" for example).  The problem is 
> particularly serious for one of our kernel modules where it caches its 
> (cluster) locks based on vfs inode implementation. These locks are 
> created by inode creation call and get purged when s_op->clear_inode() 
> is invoked. With larger servers that equipped with plenty of memory, the 
> page dirty ratio may not pass the threshold to trigger VM reclaim logic 
> but the accumulated inode counts (and its associated cluster locks) 
> could causes unacceptable performance degradation for latency sensitive 
> applications.
> 
> After adding the uploaded inode trimming patch, together with 
> shrink_dcache_sb(), we are able to keep the latency for one real world 
> application within a satisfactory bound (consistently stayed within 5 
> seconds, compared to the original fluctuation between 5 to 16 seconds). 
> The calls are placed in one of our kernel daemons that wakes up in a 
> tunable interval to do the trimming work as shown in the following code 
> segment. Would appreciate if this patch can get accepted into mainline 
> kernel.
> 
>                   i_percent = sdp->sd_tune.gt_inoded_purge;
>                   if (i_percent) {
>                           if (i_percent > 100) i_percent = 100;
>                           a_count = atomic_read(&sdp->sd_inode_count);
>                           i_count = a_count * i_percent / 100;
>                           (void) shrink_dcache_sb(sdp->sd_vfs);
>                           (void) prune_icache_sb(i_count, sdp->sd_vfs);
>                    }
> 
>...
>
> --- linux-2.6.18/include/linux/fs.h	2006-09-19 23:42:06.000000000 -0400
> +++ ups-kernel/include/linux/fs.h	2006-11-22 13:55:55.000000000 -0500
> @@ -1625,7 +1625,8 @@ extern void remove_inode_hash(struct ino
>  static inline void insert_inode_hash(struct inode *inode) {
>  	__insert_inode_hash(inode, inode->i_ino);
>  }
> -
> +extern void prune_icache_sb(int nr_to_scan, struct super_block *sb);
> + 
>  extern struct file * get_empty_filp(void);
>  extern void file_move(struct file *f, struct list_head *list);
>  extern void file_kill(struct file *f);
> --- linux-2.6.18/fs/inode.c	2006-09-19 23:42:06.000000000 -0400
> +++ ups-kernel/fs/inode.c	2006-11-22 14:12:28.000000000 -0500
> @@ -411,7 +411,7 @@ static int can_unuse(struct inode *inode
>   * If the inode has metadata buffers attached to mapping->private_list then
>   * try to remove them.
>   */
> -static void prune_icache(int nr_to_scan)
> +static void __prune_icache(int nr_to_scan, struct super_block *sb)
>  {
>  	LIST_HEAD(freeable);
>  	int nr_pruned = 0;
> @@ -428,7 +428,8 @@ static void prune_icache(int nr_to_scan)
>  
>  		inode = list_entry(inode_unused.prev, struct inode, i_list);
>  
> -		if (inode->i_state || atomic_read(&inode->i_count)) {
> +		if (inode->i_state || atomic_read(&inode->i_count) 
> +			|| (sb && (inode->i_sb != sb))) {
>  			list_move(&inode->i_list, &inode_unused);
>  			continue;

This search is potentially inefficient.  It would be better walk
sb->s_inodes.

