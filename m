Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265082AbTFUHS1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 03:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265084AbTFUHS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 03:18:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5052 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265082AbTFUHSW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 03:18:22 -0400
Date: Sat, 21 Jun 2003 08:32:24 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Lou Langholtz <ldl@aros.net>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       Steven Whitehouse <steve@chygwyn.com>
Subject: Re: [RFC][PATCH] nbd driver for 2.5.72
Message-ID: <20030621073224.GJ6754@parcelfarce.linux.theplanet.co.uk>
References: <3EF3F08B.5060305@aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF3F08B.5060305@aros.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 11:43:39PM -0600, Lou Langholtz wrote:

In addition to comments from Andrew:

> +#define MAJOR_NR NBD_MAJOR

What for?  We used to have very sick macros that depended on MAJOR_NR;
they are gone.  Lose it.

> +#define NBD_DEBUG_OPEN    0x0001
> +#define NBD_DEBUG_RELEASE 0x0002
> +#define NBD_DEBUG_IOCTL   0x0004
> +#define NBD_DEBUG_MEDIA   0x0008
> +#define NBD_DEBUG_THREADS 0x0010
> +#define NBD_DEBUG_SESSION 0x0020
> +#define NBD_DEBUG_INIT    0x0040
> +#define NBD_DEBUG_EXIT    0x0080
> +#define NBD_DEBUG_RX      0x0100
> +#define NBD_DEBUG_TX      0x0200
> +#define NBD_DEBUG_BLKDEV  0x0400

enum

> +#define DEVICE_TO_MINOR(lo) ((int)((lo)-nbd_devs))

lo->disk->disk_name would cover all uses of that animal (you always use
it in printk, AFAICS, and always in the same way).

> +#  define REQUEST_QUEUE(req) (&(req)->queuelist)
> +#  define REQUEST_QUEUE_NEXT_REQUEST(q) (elv_next_request(q))
> +#  define REQUEST_CMD(req) ((req)->cmd[0])
> +#  define DAEMONIZE(fmt...) daemonize(fmt)
> +#  define NBD_BYTESIZE(lo) ((lo)->bytesize)
> +#  define NBD_BLKSIZE(lo) ((lo)->blksize)
> +#  define INODE_TO_NBD(i) ((i)->i_bdev->bd_disk->private_data)
> +#  define DEVICE_NAME "nbd"
> +#  define request_queue_lock(q) spin_lock_irq((q)->queue_lock)
> +#  define request_queue_unlock(q) spin_unlock_irq((q)->queue_lock)
> +#  define request_queue_lock_save(q,flags) \
> +	spin_lock_irqsave((q)->queue_lock, (flags))
> +#  define request_queue_unlock_restore(q,flags) \
> +	spin_unlock_irqrestore((q)->queue_lock, (flags))

Lose them, they only obfuscate the code.  inode_to_nbd() might make sense
as static inline; the rest is definitely noise.
  
> +static nbd_device_t nbd_devs[MAX_NBD];
> +static struct request_queue nbd_queue[MAX_NBD];
> +static spinlock_t nbd_lock[MAX_NBD];

Why not put these into nbd_device?

> +static uint32_t request_magic;

???  htonl(NBD_REQUEST_MAGIC) is perfectly OK in the place where you
use it and more likely than not will give better code.

> +static uint32_t reply_magic;

Ditto.

> +static struct block_device_operations nbd_fops =
> +{
> +	owner:			THIS_MODULE,
> +	open:			nbd_open,
> +	release:		nbd_release,
> +	ioctl:			nbd_ioctl,
> +};

C99 syntax, please.

> +static int nbd_debug_write_proc(struct file *file, const char *buffer,
> +		unsigned long count, void *data)
> +{
> +	unsigned int newflags;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EACCES;
> +	if (sscanf(buffer, "%x", &newflags) != 1)
> +		return -EINVAL;

*ahem*

	First of all, "buffer" is userland pointer.  At the very lease,
copy_from_user() (and sanity checks on 'count') are missing.  What's
more, you are using sscanf() on something that doesn't have to be
NUL-terminated.  Limit count, copy into buffer, put '\0' into the last
byte of said buffer and *then* use sscanf().

> +static void __init mk_debug_proc_entry(void)
> +{
> +	proc_debug = create_proc_entry("debugflags", S_IFREG|S_IRUSR|S_IWUSR,
> +			proc_array);
> +	if (!proc_debug)
> +		return;
> +	proc_debug->nlink = 1;
> +	proc_debug->data = NULL;

	???

> +	proc_debug->read_proc = nbd_debug_read_proc;
> +	proc_debug->write_proc = nbd_debug_write_proc;
> +}

	->owner is missing.

> +static void __init init_nbd_dev(nbd_device_t *dev)
> +{
> +#ifdef PARANOIA
> +	dev->magic = LO_MAGIC;
> +#endif
> +	atomic_set(&dev->refcnt, 0);
> +	dev->flags = 0;
> +	spin_lock_init(&dev->lock);
> +	dev->harderror = 0;
> +	nbd_qsys_init(&dev->tx_queue);
> +	nbd_qsys_init(&dev->rx_queue);
> +	dev->file = NULL;
> +	dev->sock = NULL;
> +	memset(&dev->sin, 0, sizeof(dev->sin));
> +	dev->errcnt = 0;
> +	dev->lasterr = ENOTCONN;
> +	dev->closed = (RCV_SHUTDOWN|SEND_SHUTDOWN);
> +	dev->ss_thread.task = NULL;
> +	dev->tx_thread.task = NULL;
> +	dev->rx_thread.task = NULL;
> +	atomic_set(&dev->num_io_threads, 0);

*Ugh*.  These suckers are already zero-filled.

> +	init_waitqueue_head(&dev->no_io_waiters);
> +	init_MUTEX(&dev->semalock);
> +	dev->blksize = 1 << initial_blksize_bits;
> +	dev->bytesize = initial_bytesize;
> +	dev->disk = nbd_alloc_disk(dev);
> +	if (dev->disk)
> +		add_disk(dev->disk);
> +}

> +static inline void parse_sin(char *str, struct sockaddr_in *sin)
> +{
> +	char *s = str;
> +	u16 port = default_port;
> +
> +	/* parse format like: "10.0.0.5[:30666]" */
> +	while (*s && *s != ':')
> +		s++;

man strchr

> +	requests_out = 0;
> +	qhandler_loops = 0;

Static variables that do not have explicit initializer are initialized with 0.

> +/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> + *
> + * End of definitions shared with user space.
> + * From here on out, these definitions are only for kernel (driver).
> + */
> +
> +#ifdef MAJOR_NR

a) that's ifdef __KERNEL__
b) use separate headers.
