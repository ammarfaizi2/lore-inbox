Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbVCOAzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbVCOAzl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 19:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbVCOAzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 19:55:41 -0500
Received: from fire.osdl.org ([65.172.181.4]:60141 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262160AbVCOAvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 19:51:18 -0500
Date: Mon, 14 Mar 2005 16:51:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH][1/2] SquashFS
Message-Id: <20050314165117.1c5068b7.akpm@osdl.org>
In-Reply-To: <4235BAC0.6020001@lougher.demon.co.uk>
References: <4235BAC0.6020001@lougher.demon.co.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Lougher <phillip@lougher.demon.co.uk> wrote:
>
> Please apply the following two patches which adds SquashFS to the
> kernel.

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
> +

We normally put aam includes after linux includes:

#include <linux/a.h>
#include <linux/b.h>

#include <asm/a.h>
#Include <asm/b.h>

> +
> +DECLARE_MUTEX(read_data_mutex);
> +

Does this need to have global scope?  If so, it needs a less generic name. 
`squashfs_read_data_mutex' would suit.

> +static struct file_system_type squashfs_fs_type = {
> +	.owner = THIS_MODULE,
> +	.name = "squashfs",
> +	.get_sb = squashfs_get_sb,
> +	.kill_sb = kill_block_super,
> +	.fs_flags = FS_REQUIRES_DEV
> +	};
> +

The final brace should go in column 1.

> +
> +static struct buffer_head *get_block_length(struct super_block *s,
> +				int *cur_index, int *offset, int *c_byte)
> +{
> +	squashfs_sb_info *msBlk = (squashfs_sb_info *)s->s_fs_info;

s_fs_info has type void*.  Hence there is no need to typecast when
assigning pointers to or from it.  In fact it is a little harmful to do so.

Please search both your patches for all occurrences of s_fs_info and remove
the typecasts.  There are many.


> +	unsigned short temp;
> +	struct buffer_head *bh;
> +
> +	if (!(bh = sb_bread(s, *cur_index)))
> +		return NULL;
> +
> +	if (msBlk->devblksize - *offset == 1) {
> +		if (msBlk->swap)
> +			((unsigned char *) &temp)[1] = *((unsigned char *)
> +				(bh->b_data + *offset));
> +		else
> +			((unsigned char *) &temp)[0] = *((unsigned char *)
> +				(bh->b_data + *offset));

All this typecasting looks nasty.  Is there a nicer way?  Perhaps using a
temporary variable?

Is this code endian-safe?

> +		if (msBlk->swap)
> +			((unsigned char *) &temp)[0] = *((unsigned char *)
> +				bh->b_data); 
> +		else
> +			((unsigned char *) &temp)[1] = *((unsigned char *)
> +				bh->b_data); 
> +		*c_byte = temp;
> +		*offset = 1;
> +	} else {
> +		if (msBlk->swap) {
> +			((unsigned char *) &temp)[1] = *((unsigned char *)
> +				(bh->b_data + *offset));
> +			((unsigned char *) &temp)[0] = *((unsigned char *)
> +				(bh->b_data + *offset + 1)); 
> +		} else {
> +			((unsigned char *) &temp)[0] = *((unsigned char *)
> +				(bh->b_data + *offset));
> +			((unsigned char *) &temp)[1] = *((unsigned char *)
> +				(bh->b_data + *offset + 1)); 
> +		}

Ditto.

> +
> +	if (SQUASHFS_CHECK_DATA(msBlk->sBlk.flags)) {
> +		if (*offset == msBlk->devblksize) {
> +			brelse(bh);
> +			if (!(bh = sb_bread(s, ++(*cur_index))))
> +				return NULL;
> +			*offset = 0;
> +		}
> +		if (*((unsigned char *) (bh->b_data + *offset)) !=
> +						SQUASHFS_MARKER_BYTE) {
> +			ERROR("Metadata block marker corrupt @ %x\n",
> +						*cur_index);
> +			brelse(bh);
> +			return NULL;

Multiple return statements per function are a maintainability problem,
especially if some of them are deep inside that function's logic.  The old
`goto out' is preferred.

(Imagine what would happen if you later wanted to change this function to
kmalloc a bit of temp storage and you don't want it to leak).

> +		}
> +		(*offset) ++;

whitespace.

> +unsigned int squashfs_read_data(struct super_block *s, char *buffer,
> +			unsigned int index, unsigned int length,
> +			unsigned int *next_index)
> +{
> +	squashfs_sb_info *msBlk = (squashfs_sb_info *)s->s_fs_info;
> +	struct buffer_head *bh[((SQUASHFS_FILE_MAX_SIZE - 1) >>
> +			msBlk->devblksize_log2) + 2];

Dynamically sized local storage.  Deliberate?  What is the upper bound on
its size?

> +block_release:
> +	while (--b >= 0) brelse(bh[b]);

	while (--b >= 0)
		brelse(bh[b]);

please.

> +
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
> +				continue;
> +			}

- Use DECLARE_WAITQUEUE (or DEFINE_WAIT)

- schedule() always returns in state TASK_RUNNING.

> +			msBlk->next_cache = (i + 1) % SQUASHFS_CACHED_BLKS;
> +
> +			if (msBlk->block_cache[i].block ==
> +							SQUASHFS_INVALID_BLK) {
> +				if (!(msBlk->block_cache[i].data =
> +						(unsigned char *)
> +						kmalloc(SQUASHFS_METADATA_SIZE,
> +						GFP_KERNEL))) {

kmalloc() returns void*, hence no cast is needed.  Please search both
patches for all instances of kmalloc(), remove the typecasts.

> +			if (n == 0) {
> +				wait_queue_t wait;
> +
> +				init_waitqueue_entry(&wait, current);
> +				add_wait_queue(&msBlk->fragment_wait_queue,
> +									&wait);
> +				set_current_state(TASK_UNINTERRUPTIBLE);
> +				up(&msBlk->fragment_mutex);
> +				schedule();
> +				set_current_state(TASK_RUNNING);
> +				remove_wait_queue(&msBlk->fragment_wait_queue,
> +									&wait);
> +				continue;
> +			}

See above.

> +
> +static struct inode *squashfs_iget(struct super_block *s, squashfs_inode inode)
> +{
> +	struct inode *i;
> +	squashfs_sb_info *msBlk = (squashfs_sb_info *)s->s_fs_info;
> +	squashfs_super_block *sBlk = &msBlk->sBlk;
> +	unsigned int block = SQUASHFS_INODE_BLK(inode) +
> +		sBlk->inode_table_start;
> +	unsigned int offset = SQUASHFS_INODE_OFFSET(inode);
> +	unsigned int ino = SQUASHFS_MK_VFS_INODE(block
> +		- sBlk->inode_table_start, offset);
> +	unsigned int next_block, next_offset;
> +	squashfs_base_inode_header inodeb;

How much stack space is being used here?  Perhaps you should run
scripts/checkstack.pl across the whole thing.

> +	TRACE("Entered squashfs_iget\n");
> +
> +	if (msBlk->swap) {
> +		squashfs_base_inode_header sinodeb;
> +

More stack

> +
> +	switch(inodeb.inode_type) {
> +		case SQUASHFS_FILE_TYPE: {
> +			squashfs_reg_inode_header inodep;
> +			unsigned int frag_blk, frag_size;

And more

> +		case SQUASHFS_DIR_TYPE: {
> +			squashfs_dir_inode_header inodep;

And more!

> +			if (msBlk->swap) {
> +				squashfs_dir_inode_header sinodep;

> +		}
> +		case SQUASHFS_LDIR_TYPE: {
> +			squashfs_ldir_inode_header inodep;

> +		}
> +		case SQUASHFS_SYMLINK_TYPE: {
> +			squashfs_symlink_inode_header inodep;

> +		 case SQUASHFS_BLKDEV_TYPE:
> +		 case SQUASHFS_CHRDEV_TYPE: {
> +			squashfs_dev_inode_header inodep;

More.

> +static int squashfs_symlink_readpage(struct file *file, struct page *page)
> +{
> +	struct inode *inode = page->mapping->host;
> +	int index = page->index << PAGE_CACHE_SHIFT, length, bytes;
> +	unsigned int block = SQUASHFS_I(inode)->start_block;
> +	int offset = SQUASHFS_I(inode)->offset;
> +	void *pageaddr = kmap(page);
> +
> +	TRACE("Entered squashfs_symlink_readpage, page index %d, start block "
> +				"%x, offset %x\n", page->index,
> +				SQUASHFS_I(inode)->start_block,
> +				SQUASHFS_I(inode)->offset);
> +
> +	for (length = 0; length < index; length += bytes) {
> +		if (!(bytes = squashfs_get_cached_block(inode->i_sb, NULL,
> +				block, offset, PAGE_CACHE_SIZE, &block,
> +				&offset))) {
> +			ERROR("Unable to read symbolic link [%x:%x]\n", block,
> +					offset);
> +			goto skip_read;
> +		}
> +	}
> +
> +	if (length != index) {
> +		ERROR("(squashfs_symlink_readpage) length != index\n");
> +		bytes = 0;
> +		goto skip_read;
> +	}
> +
> +	bytes = (inode->i_size - length) > PAGE_CACHE_SIZE ? PAGE_CACHE_SIZE :
> +					inode->i_size - length;

One should normally use i_size_read(), but I guess thi is OK on symlinks.

> +skip_read:
> +	memset(pageaddr + bytes, 0, PAGE_CACHE_SIZE - bytes);
> +	kunmap(page);
> +	flush_dcache_page(page);
> +	SetPageUptodate(page);
> +	unlock_page(page);
> +
> +	return 0;
> +}

There's no need to run flush_dcache_page() against a symlink - they cannot
be mmapped.

See if you can use kmap_atomic() here - kmap() is slow, theoretically
deadlocky and is deprecated.

> +static unsigned int read_blocklist(struct inode *inode, int index,
> +				int readahead_blks, char *block_list,
> +				unsigned short **block_p, unsigned int *bsize)
> +{
> ...
> +
> +		if (msBlk->swap) {
> +			unsigned char sblock_list[SIZE];

How large is `SIZE'?

That seems to be a risky choice of identifier.  I guess it's so generic
that nobody else used it, so you're safe ;)

> +
> +static int squashfs_readpage(struct file *file, struct page *page)
> +{
> +	struct inode *inode = page->mapping->host;
> +	squashfs_sb_info *msBlk = (squashfs_sb_info *)inode->i_sb->s_fs_info;
> +	squashfs_super_block *sBlk = &msBlk->sBlk;
> +	unsigned char block_list[SIZE];
> +	unsigned int bsize, block, i = 0, bytes = 0, byte_offset = 0;
> +	int index = page->index >> (sBlk->block_log - PAGE_CACHE_SHIFT);
> + 	void *pageaddr = kmap(page);
> +	struct squashfs_fragment_cache *fragment = NULL;
> +	char *data_ptr = msBlk->read_page;
> +	
> +	int mask = (1 << (sBlk->block_log - PAGE_CACHE_SHIFT)) - 1;
> +	int start_index = page->index & ~mask;
> +	int end_index = start_index | mask;
> +
> +	TRACE("Entered squashfs_readpage, page index %x, start block %x\n",
> +					(unsigned int) page->index,
> +					SQUASHFS_I(inode)->start_block);
> +
> +	if (page->index >= ((inode->i_size + PAGE_CACHE_SIZE - 1) >>
> +					PAGE_CACHE_SHIFT)) {
> +		goto skip_read;
> +	}

This should use i_size_read().  Please review the patches for all instances
of open-coded i_size reads and writes.

> +
> +		if (i == page->index)  {
> +			memcpy(pageaddr, data_ptr + byte_offset,
> +					available_bytes);
> +			memset(pageaddr + available_bytes, 0,
> +					PAGE_CACHE_SIZE - available_bytes);
> +			kunmap(page);
> +			flush_dcache_page(page);
> +			SetPageUptodate(page);
> +			unlock_page(page);
> +		} else if ((push_page =
> +				grab_cache_page_nowait(page->mapping, i))) {
> + 			void *pageaddr = kmap(push_page);
> +
> +			memcpy(pageaddr, data_ptr + byte_offset,
> +					available_bytes);
> +			memset(pageaddr + available_bytes, 0,
> +					PAGE_CACHE_SIZE - available_bytes);
> +			kunmap(push_page);
> +			flush_dcache_page(push_page);
> +			SetPageUptodate(push_page);
> +			unlock_page(push_page);
> +			page_cache_release(push_page);

kmap_atomic() can be used here.

> +static int squashfs_readpage4K(struct file *file, struct page *page)
> +{
> +	struct inode *inode = page->mapping->host;
> +	squashfs_sb_info *msBlk = (squashfs_sb_info *)inode->i_sb->s_fs_info;
> +	squashfs_super_block *sBlk = &msBlk->sBlk;
> +	unsigned char block_list[SIZE];
> +	unsigned int bsize, block, bytes = 0;
> + 	void *pageaddr = kmap(page);

Stack space?

> +
> +
> +static int get_dir_index_using_name(struct super_block *s, unsigned int
> +				*next_block, unsigned int *next_offset,
> +				unsigned int index_start,
> +				unsigned int index_offset, int i_count,
> +				const char *name, int size)
> +{
> +	squashfs_sb_info *msBlk = (squashfs_sb_info *)s->s_fs_info;
> +	squashfs_super_block *sBlk = &msBlk->sBlk;
> +	int i, length = 0;
> +	char buffer[sizeof(squashfs_dir_index) + SQUASHFS_NAME_LEN + 1];
> +	squashfs_dir_index *index = (squashfs_dir_index *) buffer;
> +	char str[SQUASHFS_NAME_LEN + 1];
> +
> +	TRACE("Entered get_dir_index_using_name, i_count %d\n", i_count);
> +
> +	strncpy(str, name, size);
> +	str[size] = '\0';

Are you sure that this strncpy() is always safe?

> +			dirs_read ++;

We don't put a space before the `++'.  Please review both patches for this.

> +static struct inode *squashfs_alloc_inode(struct super_block *sb)
> +{
> +	struct squashfs_inode_info *ei;
> +	ei = (struct squashfs_inode_info *)
> +		kmem_cache_alloc(squashfs_inode_cachep, SLAB_KERNEL);

kmem_cache_alloc() returns void*.

> +static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
> +{
> +	struct squashfs_inode_info *ei = (struct squashfs_inode_info *) foo;

Unneeded typecast.

> +static int init_inodecache(void)

This can be __init.

