Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932594AbWFVRnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbWFVRnw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 13:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbWFVRnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 13:43:52 -0400
Received: from xenotime.net ([66.160.160.81]:22734 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932613AbWFVRnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 13:43:50 -0400
Date: Thu, 22 Jun 2006 10:46:31 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: mgross@linux.intel.com
Cc: linux-kernel@vger.kernel.org, mark.gross@intel.com
Subject: Re: [PATCH] riport LADAR driver
Message-Id: <20060622104631.996bcf5b.rdunlap@xenotime.net>
In-Reply-To: <20060622144120.GA5215@linux.intel.com>
References: <20060622144120.GA5215@linux.intel.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 07:41:20 -0700 mark gross wrote:

> The following patch is a driver for a laser scanning device that scans terrain
> and communicates with the system over the parallel port.  This deice is used
> on both the Red Team Racing DAPA Grand Challenge robot entrees.  
> 
> This driver is a port from the 2.4 kernel version that was used recently to the
> 2.6.17.1 kernel.  I am posting it for community review and input.
> 
> Thanks
> 
> --mgross
> 
> 
> Signed-off-by: Mark Gross <mark.gross@intel.com>
> 
> diff -urN -X linux-2.6.17.1/Documentation/dontdiff linux-2.6.17.1/drivers/char/Kconfig riport_current/linux-2.6.17.1/drivers/char/Kconfig
> --- linux-2.6.17.1/drivers/char/Kconfig	2006-06-20 02:31:55.000000000 -0700
> +++ riport_current/linux-2.6.17.1/drivers/char/Kconfig	2006-06-21 21:14:12.000000000 -0700
> @@ -1034,5 +1034,18 @@
>  	  sysfs directory, /sys/devices/platform/telco_clock, with a number of
>  	  files for controlling the behavior of this hardware.
>  
> +
> +config RIPORT
> +	tristate "Riport driver to Riegl systems LADAR terrain scanner"
> +	depends on EXPERIMENTAL
> +	default n
> +	help
> +	  The riport driver talks through the parallel port to a Riegl systems
> +	  LADAR terrain scanner http://www.riegl.com/.  This is the scanner
> +	  that was used by http://www.redteamracing.org/ H1ghlander and
> +	  Sandstorm robots.  Its the device in the big round thing on top of
> +	  the hummers. This driver is a 2.6 port of the driver used in those
> +	  robots.
> +
>  endmenu
>  

> diff -urN -X linux-2.6.17.1/Documentation/dontdiff linux-2.6.17.1/drivers/char/riport.c riport_current/linux-2.6.17.1/drivers/char/riport.c
> --- linux-2.6.17.1/drivers/char/riport.c	1969-12-31 16:00:00.000000000 -0800
> +++ riport_current/linux-2.6.17.1/drivers/char/riport.c	2006-06-21 21:23:48.000000000 -0700
> @@ -0,0 +1,678 @@
> +/*
> + *   riport.o 
> + *   Linux device driver to access Riegl LMS scanner units via the parallel port
> + *   
> + *   Copyright (C) 2000  Roland Schwarz
> + *
> + *   The author can be reached by email: roland.schwarz@riegl.com
> + */  
> +    
> +/*
> + * 10.07.2000 Tested for use with Kernel >= 2.2
> + * 14.03.2000 First working version
> + * 10.02.2000 Start of work
> + * 21.06.2006 port to 2.6 kernel mark.gross@intel.com.
> + */ 
> +    
> +#define MAX_RIPORT_DEVICES 2
> +    
> +// default settings

Use /*...*/ style comments, not //.  (multiple places)

> +#define RIPORT_IO 0x378
> +#define RIPORT_IRQ 7
> +#define RIPORT_SIZE 4000
> +    
> +// standard and ECP port offsets
> +#define ECP_OFFSET 0x400
> +#define ECR_EXT		2
> +#define DCR_BASE	2
> +#define FIFO_EXT	0
> +    
> +// bit definitions for registers
> +#define ECR_SPP_MODE			0x00
> +#define ECR_ERRINT_DISABLED		0x10
> +#define ECR_SERVICE_INTERRUPT	0x04
> +#define ECR_BYTE_MODE			0x20
> +#define ECR_ECP_MODE			0x60
> +#define DCR_NOT_REVERSE_REQUEST	0x04
> +#define DCR_NOT_1284_ACTIVE		0x08
> +#define DCR_DIRECTION			0x20
> +#define DCR_SELECT_IN			0x08
> +#define ECR_FIFO_EMPTY			0x01
> +    

Lots of trailing whitespace (multiple places).

> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/fs.h>
> +#include <linux/ioport.h>
> +#include <linux/errno.h>
> +#include <linux/slab.h>
> +#include <linux/poll.h>
> +#include <linux/wait.h>
> +#include <linux/time.h>
> +
> +#include <linux/spinlock.h>
> +#include <linux/interrupt.h>
> +#include <linux/device.h>
> +
> +#include <asm/uaccess.h>
> +#include <asm/io.h>
> +
> +#define RIPORT_DEBUG
> +
> +#undef PDEBUG
> +#ifdef RIPORT_DEBUG
> +#  define PDEBUG(fmt, args...) printk( KERN_DEBUG "riport: " fmt, ## args)
> +#else	/*  */
> +#  define PDEBUG(fmt, args...)
> +#endif	/*  */
> +    
> +/*----------------------------------------------------------------------------*/
> +    
> +#define RPINIT 0
> +#define RPREAD_HEADER 1
> +#define RPSYNC 2
> +#define RPREAD 3
> +#define RPDUMP_TIMESTAMP 4
> +struct devriport {
> +	int io;

May need to use unsigned long or some new resource_t (in -mm) for
IO addresses.

> +	int io_ext;
> +	int irq;
> +	int dma;
> +	int size;		/* buffer size */
> +	unsigned char *pbuf;	/* pointer to the start of the memory that
> +				stores scans from the riegl */
> +	unsigned char *pbuf_top;/* pointer to the end of pbuf (see above) */
> +	unsigned char *pin;	/* pointer to the end of new data */
> +	unsigned char *pout;	/* pointer to the start of new data (end of
> +				old/read data) */
> +	wait_queue_head_t qwait;
> +	struct inode *pinode;
> +	struct file *pfile;
> +	int usage;
> +	int irqinuse;
> +	int readState;
> +	short syncWord;
> +	int numBytesThisState;
> +	int bytesToRead;
> +	char buf[4];
> +	struct timeval timeStamp;

Don't use studlyCaps names.

> +	spinlock_t lock;
> +};
> +
> +struct devriport *devriport_init(int major, int minor, int io, int irq,
> +				   int dma, int size, int *presult);
> +void devriport_cleanup(struct devriport *this);
> +int devriport_open(struct devriport *this);
> +int devriport_release(struct devriport *this);
> +int devriport_read(struct devriport *this, char *pbuf, int length);
> +unsigned int devriport_poll(struct devriport *this,
> +			     struct poll_table_struct *ptable);
> +void devriport_irq(struct devriport *this, int irq, struct pt_regs *regs);
> +
> +irqreturn_t devriport_irq_wrap(int irq, void *pv, struct pt_regs *pr) 
> +{
> +	devriport_irq(pv, irq, pr);
> +	return IRQ_HANDLED;
> +} 
> +
> +void devriport_rx(struct devriport *this);

Lots of functions need to be made 'static'.

This function (below) can be __init, can't it?

> +struct devriport *devriport_init(int major, int minor, int io, int irq,
> +				   int dma, int size, int *presult) 
> +{
> +	struct devriport *this;
> +	
> +	*presult = 0;
> +	this = kmalloc(sizeof(struct devriport), GFP_KERNEL);
> +	if (!this) {
> +		*presult = -ENOMEM;
> +		goto fail_memory;
> +	}
> +
> +	if (!request_region(io, 3, "riport")) {
> +		PDEBUG("request_region 0x%X of 3 bytes fails \n", io);

Drop space before newline.

> +		*presult = -EBUSY;
> +		goto fail_io;
> +	}
> +	if (!request_region(io + ECP_OFFSET, 3, "riport")) {
> +		release_region(io,3);
> +
> +		PDEBUG("request_region 0x%X of 3 bytes fails \n", io + ECP_OFFSET );

Drop space before newline.

> +		*presult = -EBUSY;
> +		goto fail_io;
> +	}

Could use kzalloc() above and skip clearing individual fields here.

> +	this->io = io;
> +	this->io_ext = io + ECP_OFFSET;
> +	this->irq = irq;
> +	this->dma = dma;
> +	this->size = size;
> +	this->pinode = NULL;
> +	this->pfile = NULL;
> +	this->usage = 0;
> +	this->readState = RPINIT;
> +	this->syncWord = 0;
> +	this->bytesToRead = 0;
> +	this->numBytesThisState = 0;
> +	init_waitqueue_head(&this->qwait);
> +	
> +	this->irqinuse = 0;
> +	
> +	spin_lock_init(&this->lock);
> +
> +	/* test if ECP port (required) */
> +	outb(0x34, this->io_ext + ECR_EXT);
> +	if (0x35 != inb(this->io_ext + ECR_EXT)) {

May not be documented, but kernel style is (mostly)
	if (x != constant)
as opposed to
	if (constant != x)


> +		*presult = -ENXIO;
> +		goto fail_dev;
> +	}
> +	printk(KERN_NOTICE
> +		 "ecp: found at io=0x%x irq=%d major=%d minor=%d size=%d\n",
> +		 io, irq, major, minor, size);
> +	return this;
> +
> +fail_dev:
> +	PDEBUG("fail_dev \n");

Drop space before newline.

> +	release_region(io + ECP_OFFSET,3);
> +	release_region(io,3);
> +fail_io:
> +	PDEBUG("fail_io \n");

Ditto.

> +	kfree(this);
> +
> +fail_memory:
> +	return NULL;
> +
> +}
> +
> +
> +int devriport_open(struct devriport *this) 
> +{
> +	int result;
> +	
> +	if (this->usage)
> +		return -EBUSY;
> +	
> +	result =
> +	request_irq(this->irq, devriport_irq_wrap, SA_INTERRUPT, "riport",
> +			this);

indentation problem.

> +	if (result) {
> +		PDEBUG("request_irq returns %d \n", result);

no space before newline.

> +		goto fail_irq;
> +	}
> +	
> +	this->irqinuse = 1;
> +	
> +	this->pbuf = kmalloc(this->size, GFP_KERNEL);
> +	if (!this->pbuf)
> +		result = -ENOMEM;
> +	if (result)
> +		goto fail_memory;

Combine those 3 lines.

> +	
> +	this->pbuf_top = this->pbuf + this->size - 1;
> +	
> +	this->pin = this->pbuf;
> +	this->pout = this->pbuf;
> +	
> +	/* make the driver search for a sync byte.  Needs a valid header to find
> +	 * the sync */
> +	this->readState = RPINIT;
> +	this->syncWord = 0;
> +	this->bytesToRead = 0;
> +	this->numBytesThisState = 0;
> +	
> +	/* set up ECP port */
> +	    
> +	/* switch to compatibility mode */

If we had a parport maintainer and a well-documented parport client
interface, I would expect this driver to use the parport sharing
functions that are found in drivers/parport/share.c.
Well, the driver should probably use them anyway.

> +	outb(ECR_SPP_MODE | ECR_ERRINT_DISABLED | ECR_SERVICE_INTERRUPT,
> +		 this->io_ext + ECR_EXT);
> +	outb(DCR_NOT_REVERSE_REQUEST | DCR_NOT_1284_ACTIVE,
> +	      this->io + DCR_BASE);
> +	
> +	/* switch to reverse direction & disable IRQ'S */
> +	outb(ECR_BYTE_MODE | ECR_ERRINT_DISABLED | ECR_SERVICE_INTERRUPT,
> +		this->io_ext + ECR_EXT);
> +	outb(DCR_DIRECTION | DCR_NOT_REVERSE_REQUEST, this->io + DCR_BASE);
> +	outb(ECR_ECP_MODE | ECR_ERRINT_DISABLED | ECR_SERVICE_INTERRUPT,
> +	      this->io_ext + ECR_EXT);
> +	outb(DCR_DIRECTION, this->io + DCR_BASE);
> +	
> +	this->usage++;
> +	WARN_ON(this->usage > 1);
> +	PDEBUG("open\n");
> +	
> +	/* do an initial read from the riegl -- reads the header */
> +	devriport_rx(this);
> +	return 0;
> +fail_memory:
> +	this->irqinuse = 0;
> +	free_irq(this->irq, this);
> +fail_irq:
> +	return result;
> +}
> +
> +
> +int devriport_read(struct devriport *this, char *pbuf, int length) 
> +{
> +	DECLARE_WAITQUEUE(wait, current);
> +	int retval;
> +	int length0, length1;
> +	int count;
> +	
> +	add_wait_queue(&this->qwait, &wait);
> +	
> +	retval = 0;
> +	current->state = TASK_INTERRUPTIBLE;
> +	
> +	while (this->pin == this->pout) {
> +		
> +		/* if nonblocking, return with EAGAIN (to tell the caller to
> +		 * try again) */
> +		if (this->pfile->f_flags & O_NONBLOCK) {
> +			printk("EAGAIN Error\n");

Why the printk?  at least use PDEBUG() for it.

> +			retval = -EAGAIN;
> +			break;
> +		}
> +		
> +		schedule();
> +		
> +		if (signal_pending(current)) {
> +			retval = -ERESTARTSYS;
> +			break;
> +		}
> +	}
> +	
> +	current->state = TASK_RUNNING;
> +	remove_wait_queue(&this->qwait, &wait);
> +	
> +	if (retval) {
> +		return retval;
> +	}

Drop the braces on one-line "blocks."

> +	length0 = this->pin - this->pout;
> +
> +	/* the buffer is circular, so pin can be less than pout, if this is the
> +	 * case read from pout and wrap around */

I thought that we had some circular buffer helpers in
include/linux/, but I can't find them.

> +	if (length0 < 0) {
> +		length0 += this->size;
> +		length = (length0 < length) ? length0 : length;
> +
> +		/* length1 is the number of bytes from the current read
> +		 * position in the circular buffer to the end of the buffer */
> +		length1 = this->pbuf + this->size - this->pout;
> +		if (length < length1) {
> +			count = copy_to_user(pbuf, this->pout, length);
> +			WARN_ON(count != length);

Does this work?  copy_to_user() returns the number of bytes that
could *not* be copied, returns 0 on success.
(same for below)

> +		}
> +		
> +		else {
> +			/* we know that the buffer has wrapped, so read length
> +			 * bytes from the end of the buffer and the rest of the
> +			 * bytes from the start */
> +			count = copy_to_user(pbuf, this->pout, length1);
> +			WARN_ON(count != length1);
> +			count = copy_to_user(pbuf + length1, this->pbuf,
> +				length - length1);
> +			WARN_ON(count != length - length1);
> +		}
> +	}
> +	else {
> +		/* since the buffer hasn't wrapped yet, just dump bytes from
> +		 * the current  read position (this->pout) to the user */
> +		length = (length0 < length) ? length0 : length;
> +		count = copy_to_user(pbuf, this->pout, length);
> +		WARN_ON(count != length);
> +	}
> +	
> +	spin_lock_irq(&this->lock);
> +
> +	this->pout += length;
> +	if (this->pout > this->pbuf_top)
> +		this->pout -= this->size;
> +	
> +	devriport_rx(this);
> +	
> +	spin_unlock_irq(&this->lock);
> +
> +	return length;
> +}
> +
> +unsigned int devriport_poll(struct devriport *this,
> +			      struct poll_table_struct *ptable) 
> +{
> +	unsigned int mask = 0;
> +	poll_wait(this->pfile, &this->qwait, ptable);
> +	if (this->pin != this->pout)
> +		mask |= POLLIN | POLLRDNORM;
> +	return mask;
> +}
> +
> +void devriport_irq(struct devriport *this, int irq, struct pt_regs *regs) 
> +{
> +	if (this->irqinuse) {
> +		spin_lock_irq(&this->lock);
> +		devriport_rx(this);
> +		spin_unlock_irq(&this->lock);
> +		wake_up_interruptible(&this->qwait);
> +	}
> +}
> +
> +void devriport_rx(struct devriport *this) 
> +{
> +	int free;
> +
> +	free = this->pin - this->pout;
> +	
> +	/* absolute value of free... using twos complement*/
> +	if (free < 0)
> +		free = -(free + 1);
> +	else
> +		free = this->size - (free + 1);
> +	
> +	while (free && !(ECR_FIFO_EMPTY & inb(this->io_ext + ECR_EXT))) {
> +		
> +		if (this->readState != RPDUMP_TIMESTAMP)
> +				*(this->pin++) = inb(this->io_ext + FIFO_EXT);
> +		else
> +			*(this->pin++) = 
> +				((char *)&this->timeStamp)[this->numBytesThisState];
> +		
> +		if (this->pin > this->pbuf_top)
> +			this->pin -= this->size;
> +
> +		free--;
> +		switch (this->readState) {
> +			/* due to the magic of the ECP port, it seems that we are 
> +			 guaranteed to be fed a header from the riegl whenever we call
> +			 riport_open.  this code assumes that is true */
> +		case RPINIT:
> +			/* header length is the first 4 bytes in the header*/
> +			this->buf[(this->numBytesThisState)++] =
> +			*(this->pin - 1);

Funky indentation above.

> +			
> +			/* after 4 bytes, we know the size of the header
> +			   the next two bytes are the size of the header */
> +			if (this->numBytesThisState == 4) {
> +				this->bytesToRead =
> +				this->buf[0] + (this->buf[1] << 8) +
> +				(this->buf[2] << 16) +
> +				(this->buf[3] << 24) - 4;

Odd indentation.

> +				
> +				 /* reset variables for RPREAD_HEADER */
> +				this->numBytesThisState = 0;
> +				this->readState = RPREAD_HEADER;
> +			}
> +			break;
...

> +		}
> +	}
> +	
> +	/* if we there isn't any more space in the buffer, enable interrupts
> +	 * otherwise disable service interrupts in both cases, leave parallel
> +	 * port in ECP mode and disable error interrupt*/
> +	if (free)
> +		/* enable IRQ's */
> +		outb(ECR_ECP_MODE | ECR_ERRINT_DISABLED,
> +			this->io_ext + ECR_EXT);
> +	else
> +	    	/* disable IRQ's */
> +		outb(ECR_ECP_MODE | ECR_ERRINT_DISABLED |
> +			ECR_SERVICE_INTERRUPT, this->io_ext + ECR_EXT);
> +}
> +
> +
> +/*----------------------------------------------------------------------------*/
> +static struct drvriport {
> +	int major;
> +	int numdevs;
> +	struct devriport *rgpdev[MAX_RIPORT_DEVICES];
> +} riport;
> +
> +int drvriport_open(struct inode *pinode, struct file *pfile) 
> +{
> +	int result;
> +	struct devriport *pdev;
> +	
> +	PDEBUG("drvriport_open \n");

Drop space before newline.

> +	if (!(MINOR(pinode->i_rdev) < riport.numdevs))
> +		return -ENODEV;
> +	pdev = riport.rgpdev[MINOR(pinode->i_rdev)];
> +	pdev->pinode = pinode;
> +	pdev->pfile = pfile;
> +	pfile->private_data = pdev;
> +	result = devriport_open(pdev);
> +	
> +	return result;
> +}
> +
> +int drvriport_release(struct inode *pinode, struct file *pfile) 
> +{
> +	devriport_release(riport.rgpdev[MINOR(pinode->i_rdev)]);
> +	return 0;
> +}
> +
> +ssize_t drvriport_read(struct file * pfile, char *pbuf, size_t length,
> +			 loff_t * ppos)
> +{
> +	return devriport_read((struct devriport *)pfile->private_data, pbuf,
> +			       length);
> +}
> +
> +unsigned int drvriport_poll(struct file *pfile,
> +				 struct poll_table_struct *ptable) 

Is this function used?  where?

> +{
> +	return devriport_poll((struct devriport *)pfile->private_data, ptable);
> +}
> +
> +static struct file_operations drvriport_fops = { 
> +	owner: THIS_MODULE, 
> +	read : drvriport_read,
> +	open : drvriport_open, 
> +	release : drvriport_release, 
> +};

Use C99-style initializers.

> +
> +
> +static int io;
> +static int irq;
> +static int dma = 1;
> +static int size;
> +
> +/*declarations to enable udev device node creation*/
> +static struct class *riport_class;
> +
> +static int __init riport_init(void) 
> +{
> +	int major = 0;
> +	int result;
> +	struct devriport *pdev;
> +	int n;
> +	struct class_device *class_err;
> +	
> +	if (0 == io)
> +		io = RIPORT_IO;
> +	if (0 == irq)
> +		irq = RIPORT_IRQ;
> +	if (0 == size)

Reverse order inside parens.

> +		size = RIPORT_SIZE;
> +	if ((result = register_chrdev(major, "riport", &drvriport_fops)) < 0)
> +		goto fail_register_chrdev;
> +	
> +	/* TODO: here is the place to add more riport devices */
> +	riport.major = result;
> +	riport.numdevs = 0;
> +
> +	pdev =
> +	    devriport_init(riport.major, riport.numdevs, io, irq, dma, size,
> +			   &result);
> +	if (!pdev)
> +		goto init_fail_dev;
> +	
> +	riport.rgpdev[riport.numdevs++] = pdev;
> +
> +	riport_class = class_create(THIS_MODULE, "riport");
> +	if(IS_ERR(riport_class)) {

space between if and '('.

> +		result = PTR_ERR(riport_class);
> +		goto init_fail_dev;
> +	}
> +
> +	class_err = class_device_create(riport_class, NULL,
> +		MKDEV(riport.major, 0), NULL, "riport0");
> +
> +	if (IS_ERR(class_err)) {
> +		result = PTR_ERR(class_err);
> +		class_destroy(riport_class);
> +		goto init_fail_dev;
> +	}
> +
> +	return 0;
> +
> +init_fail_dev:
> +	PDEBUG("init_fail_dev\n");
> +	for (n = 0; n < riport.numdevs; n++)
> +		devriport_cleanup(riport.rgpdev[n]);
> +	unregister_chrdev(riport.major, "riport");
> +
> +fail_register_chrdev:
> +	PDEBUG("fail_register_chrdev\n");
> +	return result;
> +}
> +
> +static void __exit riport_exit(void) 
> +{
> +	int n;
> +
> +	class_device_destroy(riport_class, MKDEV(riport.major, 0));
> +	class_destroy(riport_class);
> +	for (n = 0; n < riport.numdevs; n++)
> +		devriport_cleanup(riport.rgpdev[n]);
> +	unregister_chrdev(riport.major, "riport");
> +}


---
~Randy
