Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293429AbSBYTWy>; Mon, 25 Feb 2002 14:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293432AbSBYTWl>; Mon, 25 Feb 2002 14:22:41 -0500
Received: from montreal.eicon.com ([192.219.17.120]:63497 "EHLO
	mtl_exchange.eicon.com") by vger.kernel.org with ESMTP
	id <S293429AbSBYTWY>; Mon, 25 Feb 2002 14:22:24 -0500
Message-ID: <D8E12241B029D411A3A300805FE6A2B9025761A5@montreal.eicon.com>
From: Daniel Shane <daniel.shane@eicon.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Block devices, writing when inside a read request
Date: Mon, 25 Feb 2002 14:26:49 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.0.1460.8)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I am currently writing a driver that acts like a ramdisk except that when a
read takes place, I would like the driver to take the data from another
block device. My guess is that by doing this, all writes will stay in memory
(which is exactly what I would like) while reads are taken from another
block device. 

I have written a driver for 2.4.7 by using the buffer cache only. Although
not perfect, it seems to work. 

For 2.4.10 though many things have changed and I do not now really how to do
it best. I know that the page cache and the buffer cache have been merged,
but I'm at a total loss as to how to do the read/write in the
blkdev_pagecache_IO routine.

Here is what I tried to do (I only changed blkdev_pagecache and left
readpage, prepare_write, commit_write the same):

static int stackfs_blkdev_pagecache_IO(int rw, struct buffer_head * sbh, int
minor)
{
	struct address_space * mapping;
	unsigned long index;
	int offset, size, err;

	err = -EIO;
	err = 0;
	mapping = stackfs_bdev[minor]->bd_inode->i_mapping;

	index = sbh->b_rsector >> (PAGE_CACHE_SHIFT - 9);
	offset = (sbh->b_rsector << 9) & ~PAGE_CACHE_MASK;
	size = sbh->b_size;

	do {
		int count;
		struct page ** hash;
		struct page * page;
		char * src, * dst;
		int unlock = 0;

		count = PAGE_CACHE_SIZE - offset;
		if (count > size)
			count = size;
		size -= count;

		hash = page_hash(mapping, index);
		page = __find_get_page(mapping, index, hash);
		if (!page) {
			page = grab_cache_page(mapping, index);
			err = -ENOMEM;
			if (!page)
				goto out;
			err = 0;

			if (!Page_Uptodate(page)) {
				memset(kmap(page), 0, PAGE_CACHE_SIZE);
				kunmap(page);
				SetPageUptodate(page);
			}

			unlock = 1;
		}

		index++;

		if (rw == READ) {
			struct file *file;
			mm_segment_t fs;

			file = stackfs_file[minor];

			if (! file ) {
			  printk("STACKFS: file structure is empty.\n");
			  goto out;
			}

			if (! file->f_op ) {
			  printk("STACKFS: file->f_op is empty.\n");
			  goto out;
			}

			if (! file->f_op->read ) {
				printk("STACKFS: file->f_op->read is
empty.\n");
				goto out;
			}
			
			src = kmap(page);
			src += offset;

			file->f_pos = offset;

			fs = get_fs(); set_fs(get_ds());
			err = file->f_op->read(file, src, size,
&file->f_pos);
			set_fs(fs);

			if (err < 0) {
				printk("STACKFS: Read failed, error %d\n",
err);
				kunmap(page);
			  goto out;
			}

			dst = bh_kmap(sbh);
		} 
		else {
			printk("STACKFS: write command, nothing to be
done\n");
			dst = kmap(page);
			dst += offset;
			src = bh_kmap(sbh);
		}
		offset = 0;

		memcpy(dst, src, count);

		kunmap(page);
		bh_kunmap(sbh);

		if (rw == READ) {
			printk("STACKFS: read command done, flushing the
page\n");
			flush_dcache_page(page);
		} else {
			printk("STACKFS: write command done, setting the
page dirty\n");
			SetPageDirty(page);
		}
		if (unlock)
			printk("STACKFS: unlocking the page???\n");
			UnlockPage(page);
		__free_page(page);
	} while (size);

 out:
	return err;
}

Although this oops pretty bad when a read takes place (guess the kmap in
f_op->read() is not correct??). Is the approach bad in general?

Thanks!
Daniel Shane	
