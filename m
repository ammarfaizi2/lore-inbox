Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265682AbUGDNFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265682AbUGDNFw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 09:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265689AbUGDNFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 09:05:51 -0400
Received: from [213.146.154.40] ([213.146.154.40]:40912 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265682AbUGDNFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 09:05:45 -0400
Date: Sun, 4 Jul 2004 14:05:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] CDRW packet writing support for 2.6.7-bk13
Message-ID: <20040704130544.GA3825@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>
References: <m2lli36ec9.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2lli36ec9.fsf@telia.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> + * - Generic interface for UDF to submit large packets for variable length
> + *   packet writing

Huh, what's bad about bios?

> +#include <linux/buffer_head.h>

Where do you need buffer_head.h?

> +#define SCSI_IOCTL_SEND_COMMAND	1

Please include scsi_ioctl.h instead of duplicating it.

> +static struct gendisk *disks[MAX_WRITERS];

Please add a pointer to the gendisk to struct pktcdvd_device instead
of a global array

> +
> +static struct pktcdvd_device *pkt_find_dev(request_queue_t *q)
> +{
> +	int i;
> +
> +	for (i = 0; i < MAX_WRITERS; i++)
> +		if (pkt_devs[i].bdev && bdev_get_queue(pkt_devs[i].bdev) == q)
> +			return &pkt_devs[i];
> +
> +	return NULL;
> +}

Please just store the pktcdvd_device * in q->queuedata.

> +	sprintf(current->comm, pd->name);

not needed, saemonize does it for you.

> +static int pkt_get_minor(struct pktcdvd_device *pd)
> +{
> +	int minor;
> +	for (minor = 0; minor < MAX_WRITERS; minor++)
> +		if (pd == &pkt_devs[minor])
> +			break;
> +	BUG_ON(minor == MAX_WRITERS);
> +	return minor;
> +}

Shouldn't be needed at all.  Use an idr allocator to get a free minor in
the setup, the actual I/O code shouldn't care about minors at all (if you
follow my suggestions in the begining of this mail that should be taken
care of)
and the actual code should never

> +	pd->cdrw.elv_merge_fn = q->elevator.elevator_merge_fn;
> +	pd->cdrw.elv_completed_req_fn = q->elevator.elevator_completed_req_fn;
> +	pd->cdrw.merge_requests_fn = q->merge_requests_fn;
> +	q->elevator.elevator_merge_fn = pkt_lowlevel_elv_merge_fn;
> +	q->elevator.elevator_completed_req_fn = pkt_lowlevel_elv_completed_req_fn;

This looks really really fishy.  Playing with other drivers' elevator settings
can't be safe.  I'd say wait for the runtime selectable I/O scheduler that's
planned for a while and add a special packetwriting scheduler that you switch
to.

> +/*
> + * called when the device is closed. makes sure that the device flushes
> + * the internal cache before we close.
> + */
> +static void pkt_release_dev(struct pktcdvd_device *pd, int flush)
> +{
> +	struct block_device *bdev;
> +
> +	atomic_dec(&pd->refcnt);
> +	if (atomic_read(&pd->refcnt) > 0)
> +		return;
> +
> +	bdev = bdget(pd->pkt_dev);
> +	if (bdev) {

You reallu should keep a reference to the underlying bdev as long as you use
it, aka bdev_get + blkdev_get in ->open, blkdev_put in ->release

> +		fsync_bdev(bdev);

fs/block_dev.c already does a sync_blockdev() on last close, that should
be enough.

> +static int pkt_proc_device(struct pktcdvd_device *pd, char *buf)
> +{

seq_file interface please, or even better a one value per file sysfs
interface.

> +	pd->cdrw.pid = kernel_thread(kcdrwd, pd, CLONE_FS | CLONE_FILES | CLONE_SIGHAND);

please use the kernel/ktread.c infastructure.

> +static int pkt_setup_dev(struct pktcdvd_device *pd, unsigned int arg)
> +{
> +	struct inode *inode;
> +	struct file *file;
> +	int ret;
> +
> +	if ((file = fget(arg)) == NULL) {
> +		printk("pktcdvd: bad file descriptor passed\n");
> +		return -EBADF;
> +	}
> +
> +	ret = -EINVAL;
> +	if ((inode = file->f_dentry->d_inode) == NULL) {
> +		printk("pktcdvd: huh? file descriptor contains no inode?\n");
> +		goto out;
> +	}

If fget is successfull file->f_dentry->d_inode can't be NULL.

> +	case BLKROSET:
> +		if (capable(CAP_SYS_ADMIN))
> +			clear_bit(PACKET_WRITABLE, &pd->flags);
> +	case BLKROGET:
> +	case BLKSSZGET:
> +	case BLKFLSBUF:
> +		if (!pd->bdev)
> +			return -ENXIO;
> +		return -EINVAL;		    /* Handled by blkdev layer */
> +

These aren't handled by drivers anyore in 2.6

> +	for (i = 0; i < MAX_WRITERS; i++) {
> +		disks[i] = alloc_disk(1);
> +		if (!disks[i])
> +			goto out_mem2;
> +	}
> +
> +	for (i = 0; i < MAX_WRITERS; i++) {
> +		struct pktcdvd_device *pd = &pkt_devs[i];
> +		struct gendisk *disk = disks[i];
> +		disk->major = PACKET_MAJOR;
> +		disk->first_minor = i;
> +		disk->fops = &pktcdvd_ops;
> +		disk->flags = GENHD_FL_REMOVABLE;
> +		sprintf(disk->disk_name, "pktcdvd%d", i);
> +		sprintf(disk->devfs_name, "pktcdvd/%d", i);
> +		disk->private_data = pd;
> +		disk->queue = blk_alloc_queue(GFP_KERNEL);
> +		if (!disk->queue)
> +			goto out_mem3;
> +		add_disk(disk);
> +	}

Please allocate all these on demand only when you actually attach
a device.


All in all I really wonder whether a separate driver is really that a good
fit for the functionality or whether it should be more integrated with the
block layer, ala drivers/block/scsi_ioctl.c
