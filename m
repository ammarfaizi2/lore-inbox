Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbVCOAnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVCOAnt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 19:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVCOAkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 19:40:32 -0500
Received: from waste.org ([216.27.176.166]:15846 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262169AbVCOAiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 19:38:14 -0500
Date: Mon, 14 Mar 2005 16:38:02 -0800
From: Matt Mackall <mpm@selenic.com>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH][1/2] SquashFS
Message-ID: <20050315003802.GH3163@waste.org>
References: <4235BAC0.6020001@lougher.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4235BAC0.6020001@lougher.demon.co.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A quick skim...

> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> + *
> + * inode.c
> + */
> +
> +#include <linux/types.h>
> +#include <linux/squashfs_fs.h>
> +#include <linux/module.h>
> +#include <linux/errno.h>
> +#include <linux/slab.h>
> +#include <linux/fs.h>
> +#include <linux/smp_lock.h>
> +#include <linux/slab.h>
> +#include <linux/squashfs_fs_sb.h>
> +#include <linux/squashfs_fs_i.h>
> +#include <linux/buffer_head.h>
> +#include <linux/vfs.h>
> +#include <linux/init.h>
> +#include <linux/dcache.h>
> +#include <asm/uaccess.h>
> +#include <linux/wait.h>
> +#include <asm/semaphore.h>
> +#include <linux/zlib.h>
> +#include <linux/blkdev.h>
> +#include <linux/vmalloc.h>
> +#include "squashfs.h"

Please put all the asm/ bits after all the linux/ bits.
> +
> +static void squashfs_put_super(struct super_block *);
> +static int squashfs_statfs(struct super_block *, struct kstatfs *);
> +static int squashfs_symlink_readpage(struct file *file, struct page *page);
> +static int squashfs_readpage(struct file *file, struct page *page);
> +static int squashfs_readpage4K(struct file *file, struct page *page);
> +static int squashfs_readdir(struct file *, void *, filldir_t);
> +static void squashfs_put_super(struct super_block *s);
> +static struct inode *squashfs_alloc_inode(struct super_block *sb);
> +static void squashfs_destroy_inode(struct inode *inode);
> +static int init_inodecache(void);
> +static void destroy_inodecache(void);
> +static struct dentry *squashfs_lookup(struct inode *, struct dentry *,
> +				struct nameidata *);
> +static struct inode *squashfs_iget(struct super_block *s, squashfs_inode inode);
> +static unsigned int read_blocklist(struct inode *inode, int index,
> +				int readahead_blks, char *block_list,
> +				unsigned short **block_p, unsigned int *bsize);
> +static struct super_block *squashfs_get_sb(struct file_system_type *, int,
> +				const char *, void *);

Would be nice to reorder things so that fewer forward declarations
were needed.

> +static z_stream stream;
> +
> +static struct file_system_type squashfs_fs_type = {
> +	.owner = THIS_MODULE,
> +	.name = "squashfs",
> +	.get_sb = squashfs_get_sb,
> +	.kill_sb = kill_block_super,
> +	.fs_flags = FS_REQUIRES_DEV
> +	};
    ^^^^
Weird whitespace.

> +static struct buffer_head *get_block_length(struct super_block *s,
> +				int *cur_index, int *offset, int *c_byte)
> +{
> +	squashfs_sb_info *msBlk = (squashfs_sb_info *)s->s_fs_info;

Needless cast from void *. Mixed case identifiers are discouraged.

> +	if (!(bh = sb_bread(s, *cur_index)))
> +		return NULL;

Please don't do assignment inside if().

> +	if (msBlk->devblksize - *offset == 1) {
> +		if (msBlk->swap)
> +			((unsigned char *) &temp)[1] = *((unsigned char *)
> +				(bh->b_data + *offset));
> +		else
> +			((unsigned char *) &temp)[0] = *((unsigned char *)
> +				(bh->b_data + *offset));

That's rather ugly, what's going on here? There seems to be a lot of
this swapping going on. At the very least, let's use u8.

> +block_release:
> +	while (--b >= 0) brelse(bh[b]);

Linebreak.

> +			for (i = msBlk->next_cache, n = SQUASHFS_CACHED_BLKS;
> +					n ; n --, i = (i + 1) %
> +					SQUASHFS_CACHED_BLKS)

Messy. Do n-- (no space), handle i outside the for control structures.
Perhaps break this piece out into a separate function, the indenting
is making things cramped.

> +			if (n == 0) {
> +				wait_queue_t wait;
> +
> +				init_waitqueue_entry(&wait, current);
> +				add_wait_queue(&msBlk->waitq, &wait);
> +				set_current_state(TASK_UNINTERRUPTIBLE);
> + 				up(&msBlk->block_cache_mutex);
> +				schedule();
> +				set_current_state(TASK_RUNNING);
> +				remove_wait_queue(&msBlk->waitq, &wait);

I suspect you'll find there's a much cleaner way to do whatever it is you're
trying to do here.

> +				if (!(msBlk->block_cache[i].data =
> +						(unsigned char *)
> +						kmalloc(SQUASHFS_METADATA_SIZE,
> +						GFP_KERNEL))) {

Another class of unnecessary cast.

> +		msBlk->fragment_index[SQUASHFS_FRAGMENT_INDEX(fragment)];
> +	int offset = SQUASHFS_FRAGMENT_INDEX_OFFSET(fragment);

Feel free to make these defines a little less unwieldy. So long as
they're internal to Squashfs.

> +	for (;;) {

while (1)

> +		for (i = 0; i < SQUASHFS_CACHED_FRAGMENTS &&
> +				msBlk->fragment[i].block != start_block; i++);

';' on its own line. Better is 

		for (i = 0; i < SQUASHFS_CACHED_FRAGMENTS; i++)
			if (msBlk->fragment[i].block != start_block)
				break;

> +			WARNING("Mounting a different endian SQUASHFS "
> +				"filesystem on %s\n", bdevname(s->s_bdev, b));

Can't we just use printk for this stuff?

> +	bytes = (inode->i_size - length) > PAGE_CACHE_SIZE ? PAGE_CACHE_SIZE :
> +					inode->i_size - length;

min()

> +	if (page->index >= ((inode->i_size + PAGE_CACHE_SIZE - 1) >>
> +					PAGE_CACHE_SHIFT)) {
> +		goto skip_read;
> +	}

Skip braces for single statements.

> +		block = (msBlk->read_blocklist)(inode, page->index, 1,
> +					block_list, NULL, &bsize);

Unnecessary parens around the function pointer.

...

This file could use quite a bit of work in terms of reducing nesting
depth and the like.

-- 
Mathematics is the supreme nostalgia of our time.
