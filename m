Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932791AbWCVVbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932791AbWCVVbj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932793AbWCVVbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:31:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44687 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932791AbWCVVbi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:31:38 -0500
Date: Wed, 22 Mar 2006 13:28:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: wein@de.ibm.com, linux-kernel@vger.kernel.org, horst.hummel@de.ibm.com,
       hch@lst.de
Subject: Re: [patch 16/24] s390: dasd extended error reporting.
Message-Id: <20060322132808.0c5b9cbc.akpm@osdl.org>
In-Reply-To: <20060322152413.GP5801@skybase.boeblingen.de.ibm.com>
References: <20060322152413.GP5801@skybase.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>
> From: Stefan Weinhuber <wein@de.ibm.com>
> 
> [patch 16/24] s390: dasd extended error reporting.
> 
> The DASD extended error reporting is a facility that allows to
> get detailed information about certain problems in the DASD I/O.
> This information can be used to implement fail-over applications
> that can recover these problems.
> 
> ...
> 
> --- linux-2.6/drivers/s390/block/dasd_eer.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6-patched/drivers/s390/block/dasd_eer.c	2006-03-22 14:36:28.000000000 +0100
> @@ -0,0 +1,682 @@
> +/*
> + *  Character device driver for extended error reporting.

This is a lot of code.  Is it not possible to use relay files (used to be
called relayfs)?

> +static int eer_pages = 5;
> +module_param(eer_pages, int, S_IRUGO|S_IWUSR);

Might need a MODULE_LICENSE too...

> +struct eerbuffer {
> +	struct list_head list;
> +	char **buffer;
> +	int buffersize;
> +	int buffer_page_count;
> +	int head;
> +        int tail;
> +	int residual;
> +};

whitespace went wild.

> +static spinlock_t bufferlock = SPIN_LOCK_UNLOCKED;

DEFINE_SPINLOCK() is preferred, for reasons which I keep forgetting.

> +/*
> + * How many free bytes are available on the buffer.
> + * Needs to be called with bufferlock held.
> + */
> +static int dasd_eer_get_free_bytes(struct eerbuffer *eerb)
> +{
> +	if (eerb->head < eerb->tail)
> +		return eerb->tail - eerb->head - 1;
> +	return eerb->buffersize - eerb->head + eerb->tail -1;
> +}

Ick.

> +/*
> + * How many bytes of buffer space are used.
> + * Needs to be called with bufferlock held.
> + */
> +static int dasd_eer_get_filled_bytes(struct eerbuffer *eerb)
> +{
> +
> +	if (eerb->head >= eerb->tail)
> +		return eerb->head - eerb->tail;
> +	return eerb->buffersize - eerb->tail + eerb->head;
> +}

Ditto.  I really need to write a little doc on how-to-do-a-ringbuffer.

Shortform: let `head' and `tail' wrap all the way through 0xffffffff.  Only
mask them temporarily, when indexing the managed items.  That way, the
above becomes:

static int dasd_eer_get_filled_bytes(struct eerbuffer *eerb)
{
	return eerb->tail - eerb->head;
}

static int dasd_eer_get_free_bytes(struct eerbuffer *eerb)
{
	return eerb->buffersize - dasd_eer_get_filled_bytes(eerb);
}

> +/*
> + * The dasd_eer_write_buffer function just copies count bytes of data
> + * to the buffer. Make sure to call dasd_eer_start_record first, to
> + * make sure that enough free space is available.
> + * Needs to be called with bufferlock held.
> + */
> +static void dasd_eer_write_buffer(struct eerbuffer *eerb,
> +				  char *data, int count)
> +{
> +
> +	unsigned long headindex,localhead;
> +	unsigned long rest, len;
> +	char *nextdata;
> +
> +	nextdata = data;
> +	rest = count;
> +	while (rest > 0) {
> + 		headindex = eerb->head / PAGE_SIZE;
> + 		localhead = eerb->head % PAGE_SIZE;

And I think that remains unchanged.

> +		len = min(rest, PAGE_SIZE - localhead);
> +		memcpy(eerb->buffer[headindex]+localhead, nextdata, len);
> +		nextdata += len;
> +		rest -= len;
> +		eerb->head += len;
> +		if (eerb->head == eerb->buffersize)
> +			eerb->head = 0; /* wrap around */

Those two lines get deleted.

> +		BUG_ON(eerb->head > eerb->buffersize);
> +	}
> +}


> +/*
> + * Whenever you want to write a blob of data to the internal buffer you
> + * have to start by using this function first. It will write the number
> + * of bytes that will be written to the buffer. If necessary it will remove
> + * old records to make room for the new one.
> + * Needs to be called with bufferlock held.
> + */
> +static int dasd_eer_start_record(struct eerbuffer *eerb, int count)
> +{
> +	int tailcount;
> +
> +	if (count + sizeof(count) > eerb->buffersize)
> +		return -ENOMEM;
> +	while (dasd_eer_get_free_bytes(eerb) < count + sizeof(count)) {
> +		if (eerb->residual > 0) {
> +			eerb->tail += eerb->residual;
> +			if (eerb->tail >= eerb->buffersize)
> +				eerb->tail -= eerb->buffersize;
> +			eerb->residual = -1;
> +		}
> +		dasd_eer_read_buffer(eerb, (char *) &tailcount,
> +				     sizeof(tailcount));
> +		eerb->tail += tailcount;
> +		if (eerb->tail >= eerb->buffersize)
> +			eerb->tail -= eerb->buffersize;
> +	}
> +	dasd_eer_write_buffer(eerb, (char*) &count, sizeof(count));
> +
> +	return 0;
> +};

Some of that goes away too.

> +/*
> + * Release pages that are not used anymore.
> + */
> +static void dasd_eer_free_buffer_pages(char **buf, int no_pages)
> +{
> +	int i;
> +
> +	for (i = 0; i < no_pages; i++)
> +		free_page((unsigned long) buf[i]);
> +}
> +
> +/*
> + * Allocate a new set of memory pages.
> + */
> +static int dasd_eer_allocate_buffer_pages(char **buf, int no_pages)
> +{
> +	int i;
> +
> +	for (i = 0; i < no_pages; i++) {
> +		buf[i] = (char *) get_zeroed_page(GFP_KERNEL);
> +		if (!buf[i]) {
> +			dasd_eer_free_buffer_pages(buf, i);

OK, but only because free_page(0) is legal.

> +			return -ENOMEM;
> +		}
> +	}
> +	return 0;
> +}
> +
> ...
> +#define SNSS_DATA_SIZE 44
> +
> +#define DASD_EER_BUSID_SIZE 10
> +struct dasd_eer_header {
> +	__u32 total_size;
> +	__u32 trigger;
> +	__u64 tv_sec;
> +	__u64 tv_usec;
> +	char busid[DASD_EER_BUSID_SIZE];
> +};

Personally I prefer

	char busid[10];

then just use ARRAY_SIZE(busid) everywhere.  Mainly because reviewers don't
need to refer to the definition all the time to make sure that the correct
identifier is being used.  Minor thing.

> +/*
> + * The following function can be used for those triggers that have
> + * all necessary data available when the function is called.
> + * If the parameter cqr is not NULL, the chain of requests will be searched
> + * for valid sense data, and all valid sense data sets will be added to
> + * the triggers data.
> + */
> +static void dasd_eer_write_standard_trigger(struct dasd_device *device,
> +					    struct dasd_ccw_req *cqr,
> +					    int trigger)
> +{
> +	struct dasd_ccw_req *temp_cqr;
> +	int data_size;
> +	struct timeval tv;
> +	struct dasd_eer_header header;
> +	unsigned long flags;
> +	struct eerbuffer *eerb;
> +
> +	/* go through cqr chain and count the valid sense data sets */
> +	data_size = 0;
> +	for (temp_cqr = cqr; temp_cqr; temp_cqr = temp_cqr->refers)
> +		if (temp_cqr->irb.esw.esw0.erw.cons)
> +			data_size += 32;
> +
> +	header.total_size = sizeof(header) + data_size + 4; /* "EOR" */
> +	header.trigger = trigger;
> +	do_gettimeofday(&tv);
> +	header.tv_sec = tv.tv_sec;
> +	header.tv_usec = tv.tv_usec;
> +	strncpy(header.busid, device->cdev->dev.bus_id, DASD_EER_BUSID_SIZE);
> +
> +	spin_lock_irqsave(&bufferlock, flags);
> +	list_for_each_entry(eerb, &bufferlist, list) {
> +		dasd_eer_start_record(eerb, header.total_size);
> +		dasd_eer_write_buffer(eerb, (char *) &header, sizeof(header));
> +		for (temp_cqr = cqr; temp_cqr; temp_cqr = temp_cqr->refers)
> +			if (temp_cqr->irb.esw.esw0.erw.cons)
> +				dasd_eer_write_buffer(eerb, cqr->irb.ecw, 32);
> +		dasd_eer_write_buffer(eerb, "EOR", 4);
> +	}
> +	spin_unlock_irqrestore(&bufferlock, flags);
> +	wake_up_interruptible(&dasd_eer_read_wait_queue);
> +}

That spinlocked loop looks expensive.

> +EXPORT_SYMBOL(dasd_eer_write);

_GPL?

> +/*
> + * Callback function for use with sense subsystem status request.
> + */
> +static void dasd_eer_snss_cb(struct dasd_ccw_req *cqr, void *data)
> +{
> +        struct dasd_device *device = cqr->device;
> +	unsigned long flags;

Whitespace went wild.

> +
> +/*
> + * On the one side we need a lock to access our internal buffer, on the
> + * other side a copy_to_user can sleep. So we need to copy the data we have
> + * to transfer in a readbuffer, which is protected by the readbuffer_mutex.
> + */
> +static char readbuffer[PAGE_SIZE];
> +static DECLARE_MUTEX(readbuffer_mutex);

semaphores are deprecated except when really used in counting mode.  Please
use a mutex here.

> +static int dasd_eer_open(struct inode *inp, struct file *filp)
> +{
> +	struct eerbuffer *eerb;
> +	unsigned long flags;
> +
> +	eerb = kzalloc(sizeof(struct eerbuffer), GFP_KERNEL);

Unchecked allocation.

> +	eerb->buffer_page_count = eer_pages;
> +	if (eerb->buffer_page_count < 1 ||
> +	    eerb->buffer_page_count > INT_MAX / PAGE_SIZE) {
> +		kfree(eerb);
> +		MESSAGE(KERN_WARNING, "can't open device since module "
> +			"parameter eer_pages is smaller then 1 or"
> +			" bigger then %d", (int)(INT_MAX / PAGE_SIZE));
> +		return -EINVAL;
> +	}
> +	eerb->buffersize = eerb->buffer_page_count * PAGE_SIZE;
> +	eerb->buffer = kmalloc(eerb->buffer_page_count * sizeof(char *),
> +			       GFP_KERNEL);
> +        if (!eerb->buffer) {

whitespace went wild.

> +		kfree(eerb);
> +                return -ENOMEM;
> +	}
> +	if (dasd_eer_allocate_buffer_pages(eerb->buffer,
> +					   eerb->buffer_page_count)) {
> +		kfree(eerb->buffer);
> +		kfree(eerb);
> +		return -ENOMEM;
> +	}
> +	filp->private_data = eerb;
> +	spin_lock_irqsave(&bufferlock, flags);
> +	list_add(&eerb->list, &bufferlist);
> +	spin_unlock_irqrestore(&bufferlock, flags);
> +
> +	return nonseekable_open(inp,filp);

I think if this open fails, we leak all the above memory?

> +}
> +
> +static int dasd_eer_close(struct inode *inp, struct file *filp)
> +{
> +	struct eerbuffer *eerb;
> +	unsigned long flags;
> +
> +	eerb = (struct eerbuffer *) filp->private_data;

Unneeded typecast.

> +	spin_lock_irqsave(&bufferlock, flags);
> +	list_del(&eerb->list);
> +	spin_unlock_irqrestore(&bufferlock, flags);
> +	dasd_eer_free_buffer_pages(eerb->buffer, eerb->buffer_page_count);
> +	kfree(eerb->buffer);
> +	kfree(eerb);
> +
> +	return 0;
> +}
> +
> +static ssize_t dasd_eer_read(struct file *filp, char __user *buf,
> +			     size_t count, loff_t *ppos)
> +{
> +	int tc,rc;
> +	int tailcount,effective_count;
> +        unsigned long flags;
> +	struct eerbuffer *eerb;

wildness.

> +	eerb = (struct eerbuffer *) filp->private_data;

unneeded cast

> +	if (down_interruptible(&readbuffer_mutex))
> +		return -ERESTARTSYS;
> +
> +	spin_lock_irqsave(&bufferlock, flags);
> +
> +	if (eerb->residual < 0) { /* the remainder of this record */
> +		                  /* has been deleted             */
> +		eerb->residual = 0;
> +		spin_unlock_irqrestore(&bufferlock, flags);
> +		up(&readbuffer_mutex);
> +		return -EIO;
> +	} else if (eerb->residual > 0) {
> +		/* OK we still have a second half of a record to deliver */
> +		effective_count = min(eerb->residual, (int) count);
> +		eerb->residual -= effective_count;
> +	} else {
> +		tc = 0;
> +		while (!tc) {
> +			tc = dasd_eer_read_buffer(eerb, (char *) &tailcount,
> +						  sizeof(tailcount));
> +			if (!tc) {
> +				/* no data available */
> +				spin_unlock_irqrestore(&bufferlock, flags);
> +				up(&readbuffer_mutex);
> +				if (filp->f_flags & O_NONBLOCK)
> +					return -EAGAIN;
> +				rc = wait_event_interruptible(
> +					dasd_eer_read_wait_queue,
> +					eerb->head != eerb->tail);
> +				if (rc)
> +					return rc;
> +				if (down_interruptible(&readbuffer_mutex))
> +					return -ERESTARTSYS;
> +				spin_lock_irqsave(&bufferlock, flags);
> +			}
> +		}
> +		WARN_ON(tc != sizeof(tailcount));
> +		effective_count = min(tailcount,(int)count);

min_t is the preferred way.

> +		eerb->residual = tailcount - effective_count;
> +	}
> +
> +	tc = dasd_eer_read_buffer(eerb, readbuffer, effective_count);
> +	WARN_ON(tc != effective_count);
> +
> +	spin_unlock_irqrestore(&bufferlock, flags);
> +
> +	if (copy_to_user(buf, readbuffer, effective_count)) {
> +		up(&readbuffer_mutex);
> +		return -EFAULT;
> +	}
> +
> +	up(&readbuffer_mutex);
> +	return effective_count;
> +}
> +
> +static unsigned int dasd_eer_poll(struct file *filp, poll_table *ptable)
> +{
> +	unsigned int mask;
> +	unsigned long flags;
> +	struct eerbuffer *eerb;
> +
> +	eerb = (struct eerbuffer *) filp->private_data;

cast

> +	poll_wait(filp, &dasd_eer_read_wait_queue, ptable);
> +	spin_lock_irqsave(&bufferlock, flags);
> +	if (eerb->head != eerb->tail)
> +		mask = POLLIN | POLLRDNORM ;

stray space.

> +	else
> +		mask = 0;
> +	spin_unlock_irqrestore(&bufferlock, flags);
> +	return mask;
> +}
> +
> +static struct file_operations dasd_eer_fops = {
> +	.open		= &dasd_eer_open,
> +	.release	= &dasd_eer_close,
> +	.read		= &dasd_eer_read,
> +	.poll		= &dasd_eer_poll,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static struct miscdevice dasd_eer_dev = {
> +	.minor	    = MISC_DYNAMIC_MINOR,
> +	.name	    = "dasd_eer",
> +	.fops	    = &dasd_eer_fops,
> +};
> +
> +int __init dasd_eer_init(void)
> +{
> +	int rc;
> +
> +	rc = misc_register(&dasd_eer_dev);
> +	if (rc) {
> +		MESSAGE(KERN_ERR, "%s", "dasd_eer_init could not "
> +		       "register misc device");
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +void __exit dasd_eer_exit(void)
> +{
> +	WARN_ON(misc_deregister(&dasd_eer_dev) != 0);
> +}

hm.  If some smarty makes WARN_ON a no-op the drver won't work any more.  I
guess that's unlikely to happen..

> +ifdef CONFIG_DASD_EER
> +dasd_mod-objs      += dasd_eer.o
> +endif

obj-$(CONFIG_DASD_EER) doesn't work?

