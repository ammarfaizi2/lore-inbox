Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269219AbTGVVCx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 17:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269392AbTGVVCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 17:02:53 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:38100 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S269219AbTGVVCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 17:02:41 -0400
Subject: [RFC] File backed target for device-mapper
From: Christophe Saout <christophe@saout.de>
To: dm-devel@sistina.com
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-OKv/SNDwpyrn0cHB919M"
Message-Id: <1058908659.17049.9.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 22 Jul 2003 23:17:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OKv/SNDwpyrn0cHB919M
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi!

I just wrote a dm target uses a file as backend instead of another block
device.

It's heavily based on the linux 2.5 loop device (so it uses the inode
operation sendfile for read operations and the address space operations
prepare_write and commit_write for write operations).

A dm device can be created with the target options "filename offset"
where offset is given in bytes.

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

--=-OKv/SNDwpyrn0cHB919M
Content-Disposition: attachment; filename=dm-file.c
Content-Type: text/x-c; name=dm-file.c; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

/*
 * Copyright (C) 2001 Sistina Software (UK) Limited.
 *
 * This file is released under the GPL.
 */

#include "dm.h"

#include <linux/module.h>
#include <linux/init.h>
#include <linux/file.h>
#include <linux/stat.h>
#include <linux/dcache.h>
#include <linux/bio.h>
#include <linux/ctype.h>
#include <linux/slab.h>
#include <linux/spinlock.h>

/*
 * FIXME: Shouldn't this better be with the
 * definition of loff_t in posix_types.h
 */
#define OFFSET_FORMAT "%Ld"

/*
 * File: maps a linear range of a file.
 */
struct file_c {
	struct file *file;
	loff_t offset;

	/*
	 * a workqueue would have been nice but unfortunatly
	 * this needs additional memory to be allocated per
	 * request hence mempools again and so on, but since
	 * bios already have concatenation pointers use these
	 * and do the worker thread management ourself
	 */
	spinlock_t lock;
	struct bio *bio_head;
	struct bio *bio_tail;
	struct semaphore bh_mutex;
	struct semaphore sem;
};

/*
 * Fetch next bio from work queue
 */
static struct bio *fileio_next_bio(struct file_c *fc)
{
	struct bio *bio;

	spin_lock_irq(&fc->lock);
	bio = fc->bio_head;
	if (bio) {
		if (bio == fc->bio_tail)
			fc->bio_tail = NULL;
		fc->bio_head = bio->bi_next;
		bio->bi_next = NULL;
	}
	spin_unlock_irq(&fc->lock);

	return bio;
}

/*
 * Append bio to work queue
 */
static void fileio_queue_bio(struct file_c *fc, struct bio *bio)
{
	unsigned long flags;

	spin_lock_irqsave(&fc->lock, flags);
	if (fc->bio_tail)
		fc->bio_tail->bi_next = bio;
	else
		fc->bio_head = bio;
	fc->bio_tail = bio;
	spin_unlock_irqrestore(&fc->lock, flags);
}

/*
 * Callback for f_op->sendfile
 */
static int fileio_read_actor(read_descriptor_t *desc, struct page *page,
                             unsigned long offset, unsigned long size)
{
	char *src;
	char *dst = (char *)desc->buf;
	unsigned long count = desc->count;

	if (size > count)
		size = count;

	src = kmap(page) + offset;
	if (src != dst)	/* FIXME: is src == dst possible? */
		memcpy(dst, src, size);
	kunmap(page);

	desc->count = count - size;
	desc->written += size;
	(char *)desc->buf += size;

	return size;
}

/*
 * Handles a bio as a file read operation
 */
static int fileio_read(struct file_c *fc, struct bio *bio, loff_t pos)
{
	struct bio_vec *bv;
	int i;

	bio_for_each_segment(bv, bio, i) {
		char *data;
		int r;

		/*
		 * No need do use that handy bio_kmap_irq macro since we are always
		 * alled in a non-irq context (from our worker thread actually)
		 */
		data = kmap(bv->bv_page) + bv->bv_offset,
		r = fc->file->f_op->sendfile(fc->file, &pos, bv->bv_len,
		                                 fileio_read_actor, data);
		kunmap(bv->bv_page);

		if (r < 0)
			break;

		pos += bv->bv_len;
	}

	return 0;
}

/*
 * Handles a bio_vec as a file write operation
 */
static int fileio_write_bvec(struct file_c *fc, struct bio_vec *bv,
                             int blocksize, loff_t pos)
{
	struct file *file = fc->file;
	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
	struct address_space_operations *aops = mapping->a_ops;
	struct page *page;
	char *src = kmap(bv->bv_page) + bv->bv_offset;
	char *dst;
	pgoff_t index;
	unsigned int size, offset;
	int len = bv->bv_len;

	index = pos >> PAGE_CACHE_SHIFT;
	offset = pos & ((pgoff_t)PAGE_CACHE_SIZE - 1);

	down(&mapping->host->i_sem);
	while(len > 0) {
		size = PAGE_CACHE_SIZE - offset;
		if (size > len)
			size = len;

		page = grab_cache_page(mapping, index);
		if (!page)
			goto fail;

		if (aops->prepare_write(file, page, offset, offset+size))
			goto unlock;

		dst = kmap(page);
		memcpy(dst, src, size);
		flush_dcache_page(page);
		kunmap(page);

		if (aops->commit_write(file, page, offset, offset+size))
			goto unlock;

		src += size;
		len -= size;
		offset = 0;
		index++;
		pos += size;
		unlock_page(page);
		page_cache_release(page);
	}
	up(&mapping->host->i_sem);

	kunmap(bv->bv_page);
	return 0;

      unlock:
	unlock_page(page);
	page_cache_release(page);
      fail:
	up(&mapping->host->i_sem);
	kunmap(bv->bv_page);
	return -EIO;
}

/*
 * Handles a bio as a file write operation
 */
static int fileio_write(struct file_c *fc, struct bio *bio, loff_t pos)
{
	struct bio_vec *bv;
	int blocksize = fc->file->f_dentry->d_inode->i_blksize;
	int i;

	bio_for_each_segment(bv, bio, i) {
		char *data;
		int r;

		/*
		 * No need do use that handy bio_kmap_irq macro since we are always
		 * alled in a non-irq context (from our worker thread actually)
		 */
		data = kmap(bv->bv_page) + bv->bv_offset,
		r = fileio_write_bvec(fc, bv, blocksize, pos);
		kunmap(bv->bv_page);

		if (r < 0)
			break;

		pos += bv->bv_len;
	}

	return 0;
}

/*
 * Worker thread
 */
static int fileio_thread(void *data)
{
	struct file_c *fc = data;
	struct bio *bio;
	loff_t pos;
	int r;

	daemonize("dm-file");

	current->flags |= PF_IOTHREAD;
	set_user_nice(current, -20);

	up(&fc->sem);

	while (1) {
		down_interruptible(&fc->bh_mutex);

		bio = fileio_next_bio(fc);

		/* woken up but no data: termination signal */
		if (!bio)
			 break;

		pos = ((loff_t)bio->bi_sector << SECTOR_SHIFT) + fc->offset;

		if (bio_rw(bio) == WRITE)
			r = fileio_write(fc, bio, pos);
		else
			r = fileio_read(fc, bio, pos);

		bio_endio(bio, bio->bi_size, r);
	}

	up(&fc->sem);
	return 0;
}

/*
 * Returns the minimum that is _not_ zero, unless both are zero.
 */
#define min_not_zero(l, r) (l == 0) ? r : ((r == 0) ? l : min(l, r))

/*
 * Combine the io_restrictions with the default restrictions
 */
static void combine_default_restrictions(struct io_restrictions *rs)
{
	rs->max_sectors =
		min_not_zero(rs->max_sectors, (unsigned short)MAX_SECTORS);

	rs->max_phys_segments =
		min_not_zero(rs->max_phys_segments, (unsigned short)MAX_PHYS_SEGMENTS);

	rs->max_hw_segments =
		min_not_zero(rs->max_hw_segments, (unsigned short)MAX_HW_SEGMENTS);

	rs->hardsect_size =
		max(rs->hardsect_size, (unsigned short)(1 << SECTOR_SHIFT));

	rs->max_segment_size =
		min_not_zero(rs->max_segment_size, (unsigned int)MAX_SEGMENT_SIZE);

	rs->seg_boundary_mask =
		min_not_zero(rs->seg_boundary_mask, (unsigned long)0xffffffff);
}

/*
 * Construct a file backed mapping: <file_path> <offset>
 */
static int file_ctr(struct dm_target *ti, unsigned int argc, char **argv)
{
	struct file_c *fc;
	struct inode *inode;
	loff_t file_size;
	int write_access = (dm_table_get_mode(ti->table) & FMODE_WRITE);
	int fopen_flags;

	if (argc != 2) {
		ti->error = "dm-file: Not enough arguments";
		return -EINVAL;
	}

	fc = kmalloc(sizeof(*fc), GFP_KERNEL);
	if (fc == NULL) {
		ti->error = "dm-file: Cannot allocate file backed context";
		return -ENOMEM;
	}

	if (sscanf(argv[1], OFFSET_FORMAT, &fc->offset) != 1 || fc->offset < 0) {
		ti->error = "dm-file: Invalid file offset";
		goto bad1;
	}

	fopen_flags = write_access ? 2 : 0;
#if BITS_PER_LONG != 32
	fopen_flags |= O_LARGEFILE;
#endif
	fc->file = filp_open(argv[0], fopen_flags, 0);
	if (IS_ERR(fc->file)) {
		ti->error = "dm-file: File open failed";
		DMWARN("file: fopen failed %d", (int)PTR_ERR(fc->file));
		goto bad1;
	}

	inode = fc->file->f_dentry->d_inode;
	if (!S_ISREG(inode->i_mode)) {
		ti->error = "dm-file: Not a regular file";
		goto bad2;
	}

	if (!inode->i_fop->sendfile) {
		ti->error = "dm-file: Need sendfile support";
		goto bad2;
	}
	if (write_access) {
		struct address_space_operations *aops = inode->i_mapping->a_ops;
		if (!aops->prepare_write || !aops->commit_write) {
			ti->error = "dm-file: Need prepare_write and commit_write support";
			goto bad2;
		}
	}

	file_size = i_size_read(inode->i_mapping->host);
	if (fc->offset > file_size) {
		ti->error = "dm-file: Offset beyond end of file";
		goto bad2;
	}

	file_size -= fc->offset;
	file_size >>= SECTOR_SHIFT;
	if (file_size < (loff_t)ti->len) {
		ti->error = "dm-file: File too small";
		goto bad2;
	}

	/*
	 * FIXME: Since we don't call dm_get_device, we
	 * have to combine the device limits ourself
	 */
	combine_default_restrictions(&ti->limits);

	inode->i_mapping->gfp_mask &= ~(__GFP_IO|__GFP_FS);

	spin_lock_init(&fc->lock);
	fc->bio_head = NULL;
	fc->bio_tail = NULL;
	init_MUTEX_LOCKED(&fc->sem);
	init_MUTEX_LOCKED(&fc->bh_mutex);

	kernel_thread(fileio_thread, fc, CLONE_FS | CLONE_FILES | CLONE_SIGHAND);

	ti->private = fc;
	return 0;

      bad2:
	fput(fc->file);

      bad1:
	kfree(fc);
	return -EINVAL;
}

static void file_dtr(struct dm_target *ti)
{
	struct file_c *fc = (struct file_c *) ti->private;

	/*
	 * device-mapper invokes us when there are no bios left
	 * this is the termination signal for the worker thread
	 */
	up(&fc->bh_mutex);

	/* wait for worker thread to terminate */
	down(&fc->sem);

	fput(fc->file);

	kfree(fc);
}

/*
 * Queue io operation to worker thread
 */
static int file_map(struct dm_target *ti, struct bio *bio,
		      union map_info *map_context)
{
	struct file_c *fc = (struct file_c *) ti->private;

	/* queue bio */
	fileio_queue_bio(fc, bio);

	/* wake up worker thread */
	up(&fc->bh_mutex);

	/* accepted bio, don't make new request */
	return 0;
}

/*
 * FIXME: Should this function be moved to dm-table.c?
 */
static int quote_spaces(char *out, const char *in, int maxlen)
{
	char *end = out + (maxlen - 1);

	while (out < end) {
		if (!*in)
			break;

		if (isspace(*in) || *in == '\\') {
			*out++ = '\\';
			if (out >= end)
				break;
		}

		*out++ = *in++;
	} 

	*out = '\0';

	return (maxlen - 1) - (end - out);
}

static int file_status(struct dm_target *ti, status_type_t type,
                       char *result, unsigned int maxlen)
{
	struct file_c *fc = (struct file_c *) ti->private;
	char *tmp, *path;
	int offset = 0;

	switch (type) {
	case STATUSTYPE_INFO:
		result[0] = '\0';
		break;

	case STATUSTYPE_TABLE:
		tmp = kmalloc(PATH_MAX, GFP_KERNEL);
		if (tmp) {
			path = d_path(fc->file->f_dentry, fc->file->f_vfsmnt,
			              tmp, PATH_MAX);

			if (IS_ERR(path))
				DMWARN("dm-file: d_path failed %d", (int)PTR_ERR(path));
			else
				offset = quote_spaces(result, path, maxlen);

			kfree(tmp);
		} else
			DMWARN("dm-file: Cannot allocate temporary path buffer");

		if (!offset) {
			*result = '?';
			offset = 1;
		}

		snprintf(result + offset, maxlen - offset, " " OFFSET_FORMAT,
		         fc->offset);
		break;
	}
	return 0;
}

static struct target_type file_target = {
	.name   = "file",
	.module = THIS_MODULE,
	.ctr    = file_ctr,
	.dtr    = file_dtr,
	.map    = file_map,
	.status = file_status,
};

int __init dm_file_init(void)
{
	int r = dm_register_target(&file_target);

	if (r < 0)
		DMERR("file: register failed %d", r);

	return r;
}

void dm_file_exit(void)
{
	int r = dm_unregister_target(&file_target);

	if (r < 0)
		DMERR("file: unregister failed %d", r);
}

/*
 * module hooks
 */
module_init(dm_file_init)
module_exit(dm_file_exit)

MODULE_AUTHOR("Christophe Saout <christophe@saout.de>");
MODULE_DESCRIPTION(DM_NAME " target for file backed mapping");
MODULE_LICENSE("GPL");

--=-OKv/SNDwpyrn0cHB919M--

