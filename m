Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751787AbWCECJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbWCECJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 21:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbWCECJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 21:09:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22664 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751787AbWCECJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 21:09:56 -0500
Date: Sat, 4 Mar 2006 18:08:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] bsg, block layer sg
Message-Id: <20060304180814.11f459b9.akpm@osdl.org>
In-Reply-To: <20060302111945.GG4329@suse.de>
References: <20060302111945.GG4329@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> After all that SG_IO and cdrecord talk, I decided to brush off the bsg
> driver I wrote some time ago. Basically this is a full (aims to be at
> least, probably still some minor bits missing) SG v3 interface. It
> supports both SG_IO (which we just pass through for now), as well as
> read/write and readv/writev of sg_io_hdr structures.
> 
> What's new in this area is that the bsg character device is closely tied
> to the block device. This relationsship is depicted in sysfs. bsg
> devices will show up in /sys/class/bsg/<devname>, and there is a link
> from /sys/block/<devname>/queue/bsg to that directory. With some
> udev/hotplug magic, it should create device nodes for you automatically.
> 
> +static struct bsg_command *__bsg_alloc_command(struct bsg_device *bd)
> +{
> +	struct bsg_command *bc = NULL;
> +	unsigned long *map;
> +	int free_nr;
> +
> +	spin_lock_irq(&bd->lock);
> +
> +	if (bd->queued_cmds >= bd->max_queue)
> +		goto out;
> +
> +	for (free_nr = 0, map = bd->cmd_bitmap; *map == ~0UL; map++)
> +		free_nr += BSG_CMDS_PER_LONG;
> +
> +	BUG_ON(*map == ~0UL);

It would be strange for this assertion to trigger.

> +			

Three free tabs!

> +	bd->queued_cmds++;
> +	free_nr += ffz(*map);

Can't find_first_bit() be used here?

> +	__set_bit(free_nr, bd->cmd_bitmap);

I'm suspecting that the whole cmd_bitmap thing could use the bitmap API?

> +static inline int bsg_io_schedule(struct bsg_device *bd, int state)

This large function has four callers...

Needs a comment block, please.

> +	DEFINE_WAIT(wait);
> +	int ret = 0;
> +
> +	spin_lock_irq(&bd->lock);
> +
> +	BUG_ON(bd->done_cmds > bd->queued_cmds);
> +
> +	/*
> +	 * -ENOSPC or -ENODATA?  I'm going for -ENODATA, meaning "I have no
> +	 * work to do", even though we return -ENOSPC after this same test
> +	 * during bsg_write() -- there, it means our buffer can't have more
> +	 * bsg_commands added to it, thus has no space left.
> +	 */
> +	if (bd->done_cmds == bd->queued_cmds) {
> +		ret = -ENODATA;
> +		goto unlock;
> +	}
> +
> +	if (!test_bit(BSG_F_BLOCK, &bd->flags)) {
> +		ret = -EAGAIN;
> +		goto unlock;
> +	}
> +
> +	spin_unlock_irq(&bd->lock);
> +	prepare_to_wait(&bd->wq_done, &wait, state);
> +	io_schedule();
> +	finish_wait(&bd->wq_done, &wait);
> +
> +	if ((state == TASK_INTERRUPTIBLE) && signal_pending(current))
> +		ret = -ERESTARTSYS;

Racy?  Should the the prepare_to_wait() happen before the lock is dropped?

> +/*
> + * get a new free command, blocking if needed and specified
> + */
> +static struct bsg_command *bsg_get_command(struct bsg_device *bd)
> +{
> +	struct bsg_command *bc;
> +	int ret;
> +
> +	do {
> +		bc = __bsg_alloc_command(bd);
> +		if (bc)
> +			break;
> +			
> +		ret = bsg_io_schedule(bd, TASK_INTERRUPTIBLE);

OK.  I trust you've tested that this all does the right thing when it's sent a
signal?

> +/*
> + * Check if sg_io_hdr from user is allowed and valid
> + */
> +static int
> +bsg_validate_sghdr(request_queue_t *q, struct sg_io_hdr *hdr, int *rw)
> +{
> +	if (hdr->interface_id != 'S')
> +		return -EINVAL;

'S'?  What does that mean?

> +/*
> + * map sg_io_hdr to a request. for scatter-gather sg_io_hdr, we map
> + * each segment to a bio and string multiple bio's to the request
> + */
> +static struct request *
> +bsg_map_hdr(request_queue_t *q, int rw, struct sg_io_hdr *hdr)
> +{
> +	struct sg_iovec iov;
> +	struct sg_iovec __user *u_iov;
> +	struct request *rq;
> +	struct bio *bio;
> +	int ret, i = 0;
> +
> +	dprintk("map hdr %p/%d/%d\n", hdr->dxferp, hdr->dxfer_len,
> +					hdr->iovec_count);
> +
> +	ret = bsg_validate_sghdr(q, hdr, &rw);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	/*
> +	 * map scatter-gather elements seperately and string them to request
> +	 */
> +	rq = blk_get_request(q, rw, __GFP_WAIT);

GFP_NOIO would be more meaningful.

> +	if (!hdr->iovec_count) {
> +		ret = blk_rq_map_user(q, rq, hdr->dxferp, hdr->dxfer_len);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	u_iov = hdr->dxferp;
> +	for (ret = 0, i = 0; i < hdr->iovec_count; i++, u_iov++) {
> +		int to_vm = rw == READ;
> +		unsigned long uaddr;
> +
> +		if (copy_from_user(&iov, u_iov, sizeof(iov))) {

If we can do copy_from_user() here then that blk_get_request() could have used
GFP_KERNEL.

> +			ret = -EFAULT;
> +			break;
> +		}
> +
> +		if (!iov.iov_len || !iov.iov_base) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		uaddr = (unsigned long) iov.iov_base;
> +		if (!(uaddr & queue_dma_alignment(q))
> +		    && !(iov.iov_len & queue_dma_alignment(q)))

hm, queue_dma_alignment() is an ugly thing.  queue_dma_aligned(q, addr) would
be nicer.

> +/*
> + * do final setup of a 'bc' and submit the matching 'rq' to the block
> + * layer for io
> + */
> +static void bsg_add_command(struct bsg_device *bd, request_queue_t *q,
> +			    struct bsg_command *bc, struct request *rq)
> +{
> +	rq->sense = bc->sense;
> +	rq->sense_len = 0;
> +
> +	rq->rq_disk = bd->disk;
> +	rq->end_io_data = bc;
> +	rq->end_io = bsg_rq_end_io;
> +
> +	/*
> +	 * add bc command to busy queue and submit rq for io
> +	 */
> +	bc->rq = rq;
> +	bc->bio = rq->bio;
> +	bc->hdr.duration = jiffies;
> +	spin_lock_irq(&bd->lock);
> +	list_add_tail(&bc->list, &bd->busy_list);
> +	spin_unlock_irq(&bd->lock);
> +
> +	dprintk("%s: queueing rq %p, bc %p\n", bd->name, rq, bc);
> +
> +	elv_add_request(q, rq, ELEVATOR_INSERT_BACK, 1);
> +	generic_unplug_device(q);

If you expand the two above statements you get:

	spin_lock_irqsave(q->queue_lock, flags);
	__elv_add_request(q, rq, where, plug);
	spin_unlock_irqrestore(q->queue_lock, flags);
	spin_lock_irq(q->queue_lock);
	__generic_unplug_device(q);
	spin_unlock_irq(q->queue_lock);

which is a bit sad.

> +static int bsg_complete_all_commands(struct bsg_device *bd)
> +{
> +	struct bsg_command *bc;
> +	int ret, tret;
> +
> +	dprintk("%s: entered\n", bd->name);
> +
> +	set_bit(BSG_F_BLOCK, &bd->flags);
> +
> +	/*
> +	 * wait for all commands to complete
> +	 */
> +	ret = 0;
> +	do {
> +		ret = bsg_io_schedule(bd, TASK_UNINTERRUPTIBLE);
> +		/*
> +		 * look for -ENODATA specifically -- we'll sometimes get
> +		 * -ERESTARTSYS when we've taken a signal, but we can't
> +		 * return until we're done freeing the queue, so ignore
> +		 * it.  The signal will get handled when we're done freeing
> +		 * the bsg_device.
> +		 */
> +	} while (ret != -ENODATA);
> +
> +	/*
> +	 * discard done commands
> +	 */

Would it be useful to reap the completed commands earlier?  While their
predecessors are still in flight?

> +	ret = 0;
> +	do {
> +		bc = bsg_get_done_cmd_nosignals(bd);
> +
> +		/*
> +		 * we _must_ complete before restarting, because
> +		 * bsg_release can't handle this failing.
> +		 */
> +		if (PTR_ERR(bc) == -ERESTARTSYS)
> +			continue;
> +		if (PTR_ERR(bc)) {

You wanted IS_ERR(), I think.

> +			ret = PTR_ERR(bc);
> +			break;
> +		}
> +
> +		/*
> +		 * If we get any other error, bd->queued_cmds is wrong.
> +		 */
> +		BUG_ON(IS_ERR(bc));

If so, that can't trigger.

> +
> +static ssize_t
> +__bsg_read(char __user *buf, size_t count, bsg_command_callback get_bc,
> +	   struct bsg_device *bd, const struct iovec *iov, ssize_t *bytes_read)
> +{
> +	struct bsg_command *bc;
> +	int nr_commands, ret;
> +
> +	if (count % sizeof(struct sg_io_hdr))
> +		return -EINVAL;
> +
> +	ret = 0;
> +	nr_commands = count / sizeof(struct sg_io_hdr);
> +	while (nr_commands) {
> +		bc = get_bc(bd, iov);
> +		if (IS_ERR(bc)) {
> +			ret = PTR_ERR(bc);
> +			break;
> +		}
> +
> +		/*
> +		 * this is the only case where we need to copy data back
> +		 * after completing the request. so do that here,
> +		 * bsg_complete_work() cannot do that for us
> +		 */
> +		ret = blk_complete_sghdr_rq(bc->rq, &bc->hdr, bc->bio);
> +	
> +		if (copy_to_user(buf, (char *) &bc->hdr, sizeof(bc->hdr)))
> +			ret = -EFAULT;
> +
> +		bsg_free_command(bc);
> +
> +		if (ret)
> +			break;
> +
> +		buf += sizeof(struct sg_io_hdr);

yowch, this sg_io_hdr thing is cast in stone, isn't it?

> +
> +#define err_block_err(ret)	\
> +	((ret) && (ret) != -ENOSPC && (ret) != -ENODATA && (ret) != -EAGAIN)

Make this a function?

> +static ssize_t
> +bsg_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct bsg_device *bd = file->private_data;
> +	int ret;
> +	ssize_t bytes_read;
> +
> +	if (unlikely(!bd))
> +		return -ENXIO;

Is that possible?

> +static ssize_t
> +bsg_readv(struct file *file, const struct iovec *iov, unsigned long nr_segs,
> +	  loff_t *ppos)
> +{
> +	struct bsg_device *bd = file->private_data;
> +	int ret = 0;
> +	ssize_t bytes_read = 0;
> +
> +	if (unlikely(!bd))
> +		return -ENXIO;

No, looking at bsg_open() I don't think it is.

> +static int bsg_writev_validate_iovec(const struct iovec *iov)
> +{
> +	struct sg_io_hdr hdr;
> +
> +	dprintk("iov[0] = {%p, %Zu}, sizeof(struct sg_io_hdr) = %Zu\n",
> +		iov[0].iov_base, iov[0].iov_len, sizeof(struct sg_io_hdr));
> +	if (iov[0].iov_len != sizeof(struct sg_io_hdr))
> +		return -EINVAL;
> +
> +	/*
> +	 * I really don't like doing this copy twice, but I don't see a good
> +	 * way around it...
> +	 */
> +	if (copy_from_user(&hdr, iov[0].iov_base, sizeof(struct sg_io_hdr)))
> +		return -EFAULT;

Is this function temporary?  If not, you might want to optimise out the
double copy_from_user().

> +static void bsg_free_device(struct bsg_device *bd)
> +{
> +	if (bd->cmd_map)
> +		free_pages((unsigned long) bd->cmd_map, BSG_CMDS_PAGE_ORDER);
> +
> +	kfree(bd->cmd_bitmap);
> +	bd->cmd_bitmap = NULL;
> +	bd->disk = NULL;
> +	bd->queue = NULL;
> +	bd->cmd_map = NULL;
> +	kfree(bd);
> +}

Those assignments-to-NULL are a bit unnecessary - CONFIG_DEBUG_SLAB will catch
use-after-frees (and setting them to NULL might actively hide bugs).

> +static struct bsg_device *bsg_alloc_device(void)
> +{
> +	struct bsg_device *bd = kmalloc(sizeof(struct bsg_device), GFP_KERNEL);
> +	struct bsg_command *cmd_map;
> +	unsigned long *cmd_bitmap;
> +	int bits;
> +
> +	if (unlikely(!bd))
> +		return NULL;
> +
> +	memset(bd, 0, sizeof(struct bsg_device));

kzalloc().

> +	spin_lock_init(&bd->lock);
> +
> +	bd->max_queue = BSG_CMDS;
> +
> +	bits = (BSG_CMDS / BSG_CMDS_PER_LONG) + 1;
> +	cmd_bitmap = kmalloc(bits * sizeof(unsigned long), GFP_KERNEL);

kzalloc().

> +	if (!cmd_bitmap)
> +		goto out_free_bd;
> +	bd->cmd_bitmap = cmd_bitmap;
> +
> +	cmd_map = (struct bsg_command *) __get_free_pages(GFP_KERNEL,
> +							  BSG_CMDS_PAGE_ORDER);

__GFP_ZERO, perhaps.

> +static int bsg_put_device(struct bsg_device *bd)
> +{
> +	int ret;
> +
> +	if (!atomic_dec_and_test(&bd->ref_count))
> +		return 0;
> +
> +	mutex_lock(&bsg_mutex);

Isn't this racy?  Someone can still find this device on bsg_device_list[]

> +	dprintk("%s: tearing down\n", bd->name);
> +
> +	/*
> +	 * close can always block
> +	 */
> +	set_bit(BSG_F_BLOCK, &bd->flags);
> +
> +	/*
> +	 * correct error detection baddies here again. it's the responsibility
> +	 * of the app to properly reap commands before close() if it wants
> +	 * fool-proof error detection
> +	 */
> +	ret = bsg_complete_all_commands(bd);
> +
> +	blk_cleanup_queue(bd->queue);
> +	hlist_del(&bd->dev_list);
> +	bsg_free_device(bd);
> +	mutex_unlock(&bsg_mutex);
> +	return ret;
> +}
> +
> +static struct bsg_device *bsg_add_device(struct inode *inode,
> +					 struct gendisk *disk,
> +					 struct file *file)
> +{
> +	struct bsg_device *bd = NULL;
> +#ifdef BSG_DEBUG
> +	unsigned char buf[32];
> +#endif
> +	int ret;
> +
> +	mutex_lock(&bsg_mutex);
> +
> +	ret = -ENOMEM;
> +	bd = bsg_alloc_device();

This can be called outside the lock.

Can this driver be used for pagecache or swap I/O?  If so, doing GFP_KERNEL
allocations while holding the lock might be a problem.  (OK, probably it's not
deadlocky, but still - do it outside the lock).

> +	if (!bd)
> +		goto out;
> +
> +	bd->disk = disk;
> +	bd->queue = disk->queue;
> +	atomic_inc(&disk->queue->refcnt);
> +	bsg_set_block(bd, file);
> +
> +	atomic_set(&bd->ref_count, 1);
> +	bd->minor = iminor(inode);
> +	hlist_add_head(&bd->dev_list,&bsg_device_list[bsg_list_idx(bd->minor)]);
> +
> +	strncpy(bd->name, disk->disk_name, sizeof(bd->name));

This might not null-terminate bd->name.

> +static int
> +bsg_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
> +	  unsigned long arg)
> +{
> +	struct bsg_device *bd = file->private_data;
> +	int __user *uarg = (int __user *) arg;
> +
> +	if (!bd)
> +		return -ENXIO;
> +
> +	switch (cmd) {
> +		/*
> +		 * our own ioctls
> +		 */
> +		case SG_GET_COMMAND_Q:

The switch's body could be moved a tabstop to the left.

> +int bsg_register_disk(struct gendisk *disk)
> +{
> +	request_queue_t *q = disk->queue;
> +	struct bsg_class_device *bcd;
> +	dev_t dev;
> +
> +	/*
> +	 * we need a proper transport to send commands, not a stacked device
> +	 */
> +	if (!q->request_fn)
> +		return 0;
> +
> +	bcd = &disk->bsg_dev;
> +	memset(bcd, 0, sizeof(*bcd));
> +	INIT_LIST_HEAD(&bcd->list);
> +
> +	mutex_lock(&bsg_mutex);
> +	dev = MKDEV(BSG_MAJOR, bsg_device_nr);
> +	bcd->minor = bsg_device_nr;
> +	bsg_device_nr++;
> +	bcd->disk = disk;
> +	bcd->class_dev = class_device_create(bsg_class, NULL, dev, bcd->dev, "%s", disk->disk_name);
> +	list_add_tail(&bcd->list, &bsg_class_list);
> +	sysfs_create_link(&q->kobj, &bcd->class_dev->kobj, "bsg");
> +	mutex_unlock(&bsg_mutex);

Again, we're probably doing GFP_KERNEL allocations with bsg_mutex held. 
Please check.

> +EXPORT_SYMBOL(blk_fill_sghdr_rq);

GPL?

> +
> +/*
> + * unmap a request that was previously mapped to this sg_io_hdr. handles
> + * both sg and non-sg sg_io_hdr.
> + */
> +int blk_unmap_sghdr_rq(struct request *rq, struct sg_io_hdr *hdr)
> +{
> +	struct bio *bio = rq->bio;
> +
> +	/*
> +	 * also releases request
> +	 */
> +	if (!hdr->iovec_count)
> +		return blk_rq_unmap_user(bio, hdr->dxfer_len);
> +
> +	while ((bio = rq->bio)) {
> +		rq->bio = bio->bi_next;
> +		bio->bi_next = NULL;
> +
> +		bio_unmap_user(bio);
> +	}

rq_for_each_bio()?

> +
> +int blk_complete_sghdr_rq(struct request *rq, struct sg_io_hdr *hdr,
> +			  struct bio *bio)
> +{
> +	/*
> +	 * fill in all the output members
> +	 */
> +	hdr->status = rq->errors & 0xff;
> +	hdr->masked_status = status_byte(rq->errors);
> +	hdr->msg_status = msg_byte(rq->errors);
> +	hdr->host_status = host_byte(rq->errors);
> +	hdr->driver_status = driver_byte(rq->errors);
> +	hdr->info = 0;
> +	if (hdr->masked_status || hdr->host_status || hdr->driver_status)
> +		hdr->info |= SG_INFO_CHECK;
> +	hdr->resid = rq->data_len;
> +	hdr->sb_len_wr = 0;
> +
> +	if (rq->sense_len && hdr->sbp) {
> +		int len = min((unsigned int) hdr->mx_sb_len, rq->sense_len);
> +
> +		if (!copy_to_user(hdr->sbp, rq->sense, len))
> +			hdr->sb_len_wr = len;

No -EFAULT?



