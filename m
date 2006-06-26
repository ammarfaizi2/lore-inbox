Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWFZUmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWFZUmu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWFZUmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:42:50 -0400
Received: from fmr18.intel.com ([134.134.136.17]:25325 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750788AbWFZUmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:42:49 -0400
Date: Mon, 26 Jun 2006 13:55:25 -0700
From: mark gross <mgross@linux.intel.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       mark.gross@intel.com
Subject: Re: [PATCH] riport LADAR driver
Message-ID: <20060626205525.GA13411@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20060622144120.GA5215@linux.intel.com> <1151000401.3120.55.camel@laptopd505.fenrus.org> <20060622231604.GA5208@linux.intel.com> <20060622225239.bf0ccab2.rdunlap@xenotime.net> <20060623224654.GA5204@linux.intel.com> <1151146820.3181.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151146820.3181.22.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2006 at 01:00:20PM +0200, Arjan van de Ven wrote:
> 
> since this is for a tutorial... double nitpick mode ;-)
> (since examples should be squeeky clean or people will turn the right
> thing into the not quite right thing later in their own code)
> 
> > +#undef PDEBUG
> > +#ifdef RIPORT_DEBUG
> > +#  define PDEBUG(fmt, args...) printk( KERN_DEBUG "riport: " fmt, ## args)
> > +#else	/*  */
> > +#  define PDEBUG(fmt, args...)
> > +#endif	/*  */
> 
> this is still there while it really shouldn't be; either use pr_debug()
> or dev_printk().
> 
done

> 
> > +struct devriport {
> > +	unsigned int io;
> > +	unsigned int io_ext;
> > +	int irq;
> > +	int dma;
> > +	int size;		/* buffer size */
> > +	unsigned char *pbuf;	/* pointer to the start of the memory that
> > +				stores scans from the riegl */
> > +	unsigned char *pbuf_top;/* pointer to the end of pbuf (see above) */
> > +	unsigned char *pin;	/* pointer to the end of new data */
> > +	unsigned char *pout;	/* pointer to the start of new data (end of
> > +				old/read data) */
> > +	wait_queue_head_t qwait;
> > +	struct inode *pinode;
> > +	struct file *pfile;
> > +	int usage;
> > +	int irqinuse;
> > +	int readstate;
> > +	short syncWord;
> > +	int numbytesthisstate;
> > +	int bytestoread;
> > +	char buf[4];
> > +	struct timeval timestamp;
> > +
> > +	spinlock_t lock;
> > +};
> 
> if this is for a tutorial.. might as well sort these fields in order of
> decreasing size so that you get minimal alignment packing by the
> compiler
>

done

> > +	if (!request_region(io + ECP_OFFSET, 3, "riport")) {
> > +		release_region(io,3);
> > +
> > +		PDEBUG("request_region 0x%X of 3 bytes fails\n", io + ECP_OFFSET );
> > +		*presult = -EBUSY;
> > +		goto fail_io;
> > +	}
> 
> might as well make another goto target and have that do the
> release_region...
> 

yes

> > +
> > +static int devriport_release(struct devriport *this)
> > +{
> > +	this->irqinuse = 0;
> > +
> > +	/* switch to compatibility mode */
> > +	outb(ECR_SPP_MODE | ECR_ERRINT_DISABLED | ECR_SERVICE_INTERRUPT,
> > +		this->io_ext + ECR_EXT);
> > +	outb(DCR_NOT_REVERSE_REQUEST | DCR_SELECT_IN, this->io + DCR_BASE);
> > +
> > +	free_irq(this->irq, this);
> > +	kfree(this->pbuf);
> > +
> > +	this->usage--;
> > +	WARN_ON(this->usage < 0);
> > +	PDEBUG("release\n");
> > +	return 0;
> > +}
> > +
> > +
> ...
> 
> > +
> > +
> > +static int devriport_open(struct devriport *this)
> > +{
> > +	int result;
> > +
> > +	if (this->usage)
> > +		return -EBUSY;
> 
> this "usage count" thing is probably buggy and racy; what is it for? 
> 

its just to keep the device a one user-at-a-time.  It is racy.


In addition to these updates I ran space on the driver to find some missing
__user declarations that are now fixed up.



Signed-off-by: Mark Gross <mark.gross@intel.com>


diff -urN -X ../linux-2.6.17.1/Documentation/dontdiff ../linux-2.6.17.1/drivers/char/Kconfig linux-2.6.17.1/drivers/char/Kconfig
--- ../linux-2.6.17.1/drivers/char/Kconfig	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/drivers/char/Kconfig	2006-06-22 07:13:56.000000000 -0700
@@ -1034,5 +1034,18 @@
 	  sysfs directory, /sys/devices/platform/telco_clock, with a number of
 	  files for controlling the behavior of this hardware.
 
+
+config RIPORT
+	tristate "Riport driver to Riegl systems LADAR terrain scanner"
+	depends on EXPERIMENTAL
+	default n
+	help
+	  The riport driver talks through the parallel port to a Riegl systems
+	  LADAR terrain scanner http://www.riegl.com/.  This is the scanner
+	  that was used by http://www.redteamracing.org/ H1ghlander and
+	  Sandstorm robots.  Its the device in the big round thing on top of
+	  the hummers. This driver is a 2.6 port of the driver used in those
+	  robots.
+
 endmenu
 
diff -urN -X ../linux-2.6.17.1/Documentation/dontdiff ../linux-2.6.17.1/drivers/char/Makefile linux-2.6.17.1/drivers/char/Makefile
--- ../linux-2.6.17.1/drivers/char/Makefile	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/drivers/char/Makefile	2006-06-22 07:13:56.000000000 -0700
@@ -86,6 +86,7 @@
 obj-$(CONFIG_GPIO_VR41XX)	+= vr41xx_giu.o
 obj-$(CONFIG_TANBAC_TB0219)	+= tb0219.o
 obj-$(CONFIG_TELCLOCK)		+= tlclk.o
+obj-$(CONFIG_RIPORT)		+= riport.o
 
 obj-$(CONFIG_WATCHDOG)		+= watchdog/
 obj-$(CONFIG_MWAVE)		+= mwave/
diff -urN -X ../linux-2.6.17.1/Documentation/dontdiff ../linux-2.6.17.1/drivers/char/riport.c linux-2.6.17.1/drivers/char/riport.c
--- ../linux-2.6.17.1/drivers/char/riport.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.1/drivers/char/riport.c	2006-06-26 13:24:22.000000000 -0700
@@ -0,0 +1,661 @@
+/*
+ *   riport.o
+ *   Linux device driver to access Riegl LMS scanner units via the parallel port
+ *
+ *   Copyright (C) 2000  Roland Schwarz
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ *   The author can be reached by email: roland.schwarz@riegl.com
+ */
+
+/*
+ * 10.07.2000 Tested for use with Kernel >= 2.2
+ * 14.03.2000 First working version
+ * 10.02.2000 Start of work
+ * 21.06.2006 port to 2.6 kernel mark.gross@intel.com.
+ */
+
+#define MAX_RIPORT_DEVICES 2
+
+/* default settings*/
+#define RIPORT_IO 0x378
+#define RIPORT_IRQ 7
+#define RIPORT_SIZE 4000
+
+/* standard and ECP port offsets*/
+#define ECP_OFFSET 0x400
+#define ECR_EXT		2
+#define DCR_BASE	2
+#define FIFO_EXT	0
+
+/* bit definitions for registers*/
+#define ECR_SPP_MODE			0x00
+#define ECR_ERRINT_DISABLED		0x10
+#define ECR_SERVICE_INTERRUPT	0x04
+#define ECR_BYTE_MODE			0x20
+#define ECR_ECP_MODE			0x60
+#define DCR_NOT_REVERSE_REQUEST	0x04
+#define DCR_NOT_1284_ACTIVE		0x08
+#define DCR_DIRECTION			0x20
+#define DCR_SELECT_IN			0x08
+#define ECR_FIFO_EMPTY			0x01
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/ioport.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/poll.h>
+#include <linux/wait.h>
+#include <linux/time.h>
+
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+#define RIPORT_DEBUG
+
+#undef pr_debug
+#ifdef RIPORT_DEBUG
+#  define pr_debug(fmt, args...) printk( KERN_DEBUG "riport: " fmt, ## args)
+#else	/*  */
+#  define pr_debug(fmt, args...)
+#endif	/*  */
+
+/*----------------------------------------------------------------------------*/
+
+#define RPINIT 0
+#define RPREAD_HEADER 1
+#define RPSYNC 2
+#define RPREAD 3
+#define RPDUMP_TIMESTAMP 4
+struct devriport {
+	struct timeval timestamp;
+	char buf[4];
+	spinlock_t lock;
+	unsigned char *pbuf;	/* pointer to the start of the memory that
+				stores scans from the riegl */
+	unsigned char *pbuf_top;/* pointer to the end of pbuf (see above) */
+	unsigned char *pin;	/* pointer to the end of new data */
+	unsigned char *pout;	/* pointer to the start of new data (end of
+				old/read data) */
+	wait_queue_head_t qwait;
+	struct inode *pinode;
+	struct file *pfile;
+	unsigned int io;
+	unsigned int io_ext;
+	int irq;
+	int dma;
+	int size;		/* buffer size */
+	int irqinuse;
+	int readstate;
+	int numbytesthisstate;
+	int bytestoread;
+
+	short syncWord;
+};
+
+
+static struct devriport __init *devriport_init(int major, int minor, unsigned int io, int irq,
+				   int dma, int size, int *presult)
+{
+	struct devriport *this;
+
+	*presult = 0;
+	this = kzalloc(sizeof(struct devriport), GFP_KERNEL);
+	if (!this) {
+		*presult = -ENOMEM;
+		goto fail_memory;
+	}
+
+	if (!request_region(io, 3, "riport")) {
+		pr_debug("request_region 0x%X of 3 bytes fails\n", io);
+		*presult = -EBUSY;
+		goto fail_io1;
+	}
+	if (!request_region(io + ECP_OFFSET, 3, "riport")) {
+		release_region(io,3);
+
+		pr_debug("request_region 0x%X of 3 bytes fails\n", io + ECP_OFFSET );
+		*presult = -EBUSY;
+		goto fail_io2;
+	}
+	this->io = io;
+	this->io_ext = io + ECP_OFFSET;
+	this->irq = irq;
+	this->dma = dma;
+	this->size = size;
+	this->pinode = NULL;
+	this->pfile = NULL;
+	this->readstate = RPINIT;
+	init_waitqueue_head(&this->qwait);
+
+	spin_lock_init(&this->lock);
+
+	/* test if ECP port (required) */
+	outb(0x34, this->io_ext + ECR_EXT);
+	if (inb(this->io_ext + ECR_EXT) != 0x35) {
+		*presult = -ENXIO;
+		goto fail_dev;
+	}
+	printk(KERN_NOTICE
+		 "ecp: found at io=0x%x irq=%d major=%d minor=%d size=%d\n",
+		 io, irq, major, minor, size);
+	return this;
+
+fail_dev:
+	release_region(io + ECP_OFFSET,3);
+fail_io2:
+	release_region(io,3);
+fail_io1:
+	kfree(this);
+
+fail_memory:
+	return NULL;
+
+}
+
+static void devriport_cleanup(struct devriport *this)
+{
+	release_region(this->io + ECP_OFFSET, 3);
+	release_region(this->io, 3);
+
+	kfree(this);
+}
+
+
+static atomic_t riport_available = ATOMIC_INIT(1);
+static int devriport_release(struct devriport *this)
+{
+	this->irqinuse = 0;
+
+	/* switch to compatibility mode */
+	outb(ECR_SPP_MODE | ECR_ERRINT_DISABLED | ECR_SERVICE_INTERRUPT,
+		this->io_ext + ECR_EXT);
+	outb(DCR_NOT_REVERSE_REQUEST | DCR_SELECT_IN, this->io + DCR_BASE);
+
+	free_irq(this->irq, this);
+	kfree(this->pbuf);
+
+	atomic_inc(&riport_available); /* release the device */
+	pr_debug("release\n");
+	return 0;
+}
+
+
+static void devriport_rx(struct devriport *this)
+{
+	int free;
+
+	free = this->pin - this->pout;
+
+	/* absolute value of free... using twos complement*/
+	if (free < 0)
+		free = -(free + 1);
+	else
+		free = this->size - (free + 1);
+
+	while (free && !(ECR_FIFO_EMPTY & inb(this->io_ext + ECR_EXT))) {
+
+		if (this->readstate != RPDUMP_TIMESTAMP)
+				*(this->pin++) = inb(this->io_ext + FIFO_EXT);
+		else
+			*(this->pin++) =
+				((char *)&this->timestamp)[this->numbytesthisstate];
+
+		if (this->pin > this->pbuf_top)
+			this->pin -= this->size;
+
+		free--;
+		switch (this->readstate) {
+			/*
+			 * due to the magic of the ECP port, it seems that we
+			 * are guaranteed to be fed a header from the riegl
+			 * whenever we call riport_open.  this code assumes
+			 * that is true
+			 */
+		case RPINIT:
+			/* header length is the first 4 bytes in the header*/
+			this->buf[(this->numbytesthisstate)++] =
+				*(this->pin - 1);
+
+			/*
+			 * after 4 bytes, we know the size of the header
+			 * the next two bytes are the size of the header
+			 */
+			if (this->numbytesthisstate == 4) {
+				this->bytestoread =
+					this->buf[0] + (this->buf[1] << 8) +
+					(this->buf[2] << 16) +
+					(this->buf[3] << 24) - 4;
+
+				 /* reset variables for RPREAD_HEADER */
+				this->numbytesthisstate = 0;
+				this->readstate = RPREAD_HEADER;
+			}
+			break;
+		case RPREAD_HEADER:
+			/* the first two bytes describe the number of bytes per read */
+			if (this->numbytesthisstate < 2)
+				this->buf[this->numbytesthisstate++] =
+				    *(this->pin - 1);
+
+			else {
+				this->numbytesthisstate++;
+			}
+			/* after two byte reads, record the syncWord */
+			if (this->numbytesthisstate == 2) {
+				this->syncWord =
+					this->buf[0] + (this->buf[1] << 8);
+			}
+
+			/* read to the end of the header and then go to READ state */
+			if (this->numbytesthisstate == this->bytestoread) {
+				do_gettimeofday(&this->timestamp);
+				this->numbytesthisstate = 0;
+				this->bytestoread = 0;
+				this->readstate = RPSYNC;
+			}
+			break;
+		case RPREAD:
+			/* ignore all the bytes in the data packet*/
+			this->numbytesthisstate++;
+			if (this->numbytesthisstate == this->bytestoread) {
+				this->bytestoread = 0;
+				this->numbytesthisstate = 0;
+				this->readstate = RPSYNC;
+			}
+			break;
+		case RPSYNC:
+			/*
+			 * look for the two sync bytes  record the first byte,
+			 * since we need two bytes to  get the sync
+			 */
+			if (this->numbytesthisstate == 0) {
+				this->numbytesthisstate++;
+				this->buf[1] = *(this->pin - 1);
+			}
+
+			else {
+
+				/* push the next byte into the 2 byte queue */
+				this->buf[0] = this->buf[1];
+				this->buf[1] = *(this->pin - 1);
+				this->numbytesthisstate++;
+
+				/*
+				 * if the sync word matches the two bytes in
+				 * storage, change the state so that timestamp
+				 * is entered into the data stream
+				 */
+				if (this->syncWord ==
+					this->buf[0] + (this->buf[1] << 8)) {
+					do_gettimeofday(&this->timestamp);
+
+					this->numbytesthisstate = 0;
+					this->bytestoread = this->syncWord;
+					this->readstate = RPDUMP_TIMESTAMP;
+				}
+			}
+			break;
+		case RPDUMP_TIMESTAMP:
+			/*
+			 * increment numbytesthisstate to record the number of
+			 * bytes passed into the data stream.  once a full
+			 * timeval has been passed, move on to reading the data
+			 * from the riegl
+			 */
+			this->numbytesthisstate++;
+
+			if (this->numbytesthisstate >=
+				sizeof(struct timeval)) {
+				this->numbytesthisstate = 0;
+				this->bytestoread = this->syncWord;
+				this->readstate = RPREAD;
+			}
+			break;
+		default:
+			this->readstate = RPINIT;
+			break;
+		}
+	}
+
+	/*
+	 * if we there isn't any more space in the buffer, enable interrupts
+	 * otherwise disable service interrupts in both cases, leave parallel
+	 * port in ECP mode and disable error interrupt
+	 */
+	if (free)
+		/* enable IRQ's */
+		outb(ECR_ECP_MODE | ECR_ERRINT_DISABLED,
+			this->io_ext + ECR_EXT);
+	else
+	    	/* disable IRQ's */
+		outb(ECR_ECP_MODE | ECR_ERRINT_DISABLED |
+			ECR_SERVICE_INTERRUPT, this->io_ext + ECR_EXT);
+}
+
+static int devriport_read(struct file * pfile, __user char *pbuf, int length)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	int retval;
+	int length0, length1;
+	int count;
+	struct devriport *this;
+	unsigned long flags;
+
+	this = (struct devriport *)pfile->private_data;
+	add_wait_queue(&this->qwait, &wait);
+	retval = 0;
+
+	/* wait for the buffer to fill*/
+	while (this->pin == this->pout) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule();
+		if (signal_pending(current)) {
+			retval = -ERESTARTSYS;
+			break;
+		}
+	}
+
+	current->state = TASK_RUNNING;
+	remove_wait_queue(&this->qwait, &wait);
+
+	if (retval)
+		return retval;
+	length0 = this->pin - this->pout;
+
+	/*
+	 * the buffer is circular, so pin can be less than pout, if this is the
+	 * case read from pout and wrap around
+	 */
+	if (length0 < 0) {
+		length0 += this->size;
+		length = (length0 < length) ? length0 : length;
+
+		/*
+		 * length1 is the number of bytes from the current read
+		 * position in the circular buffer to the end of the buffer
+		 */
+		length1 = this->pbuf + this->size - this->pout;
+		if (length < length1) {
+			count = copy_to_user(pbuf, this->pout, length);
+			WARN_ON(count);
+		}
+		else {
+			/*
+			 * we know that the buffer has wrapped, so read length
+			 * bytes from the end of the buffer and the rest of the
+			 * bytes from the start
+			 */
+			count = copy_to_user(pbuf, this->pout, length1);
+			WARN_ON(count);
+			count = copy_to_user(pbuf + length1, this->pbuf,
+				length - length1);
+			WARN_ON(count);
+		}
+	}
+	else {
+		/*
+		 * since the buffer hasn't wrapped yet, just dump bytes from
+		 * the current  read position (this->pout) to the user
+		 */
+		length = (length0 < length) ? length0 : length;
+		count = copy_to_user(pbuf, this->pout, length);
+		WARN_ON(count);
+	}
+
+	spin_lock_irqsave(&this->lock, flags);
+	this->pout += length;
+	if (this->pout > this->pbuf_top)
+		this->pout -= this->size;
+	devriport_rx(this);
+	spin_unlock_irqrestore(&this->lock,flags);
+
+	return length;
+}
+
+
+static void devriport_irq(struct devriport *this, int irq, struct pt_regs *regs)
+{
+	unsigned long flags;
+
+	if (this->irqinuse) {
+		spin_lock_irqsave(&this->lock, flags);
+		devriport_rx(this);
+		spin_unlock_irqrestore(&this->lock, flags);
+		wake_up_interruptible(&this->qwait);
+	}
+}
+
+static irqreturn_t devriport_irq_wrap(int irq, void *pv, struct pt_regs *pr)
+{
+	devriport_irq(pv, irq, pr);
+	return IRQ_HANDLED;
+	/* this does look bad.  This driver cannot share IRQ's safely*/
+}
+
+
+static int devriport_open(struct devriport *this)
+{
+	int result;
+
+	this->pbuf = kzalloc(this->size, GFP_KERNEL);
+	if (!this->pbuf) {
+		result = -ENOMEM;
+		goto fail_memory;
+	}
+
+	this->pbuf_top = this->pbuf + this->size - 1;
+	this->pin = this->pbuf;
+	this->pout = this->pbuf;
+
+	/*
+	 * make the driver search for a sync byte.  Needs a valid header to find
+	 * the sync
+	 */
+	this->readstate = RPINIT;
+
+	/* set up ECP port */
+
+	/* switch to compatibility mode */
+	outb(ECR_SPP_MODE | ECR_ERRINT_DISABLED | ECR_SERVICE_INTERRUPT,
+		 this->io_ext + ECR_EXT);
+	outb(DCR_NOT_REVERSE_REQUEST | DCR_NOT_1284_ACTIVE,
+	      this->io + DCR_BASE);
+
+	/* switch to reverse direction & disable IRQ'S */
+	outb(ECR_BYTE_MODE | ECR_ERRINT_DISABLED | ECR_SERVICE_INTERRUPT,
+		this->io_ext + ECR_EXT);
+	outb(DCR_DIRECTION | DCR_NOT_REVERSE_REQUEST, this->io + DCR_BASE);
+	outb(ECR_ECP_MODE | ECR_ERRINT_DISABLED | ECR_SERVICE_INTERRUPT,
+	      this->io_ext + ECR_EXT);
+	outb(DCR_DIRECTION, this->io + DCR_BASE);
+
+	result = request_irq(this->irq, devriport_irq_wrap, SA_INTERRUPT,
+			"riport", this);
+	if (result) {
+		pr_debug("request_irq returns %d\n", result);
+		goto fail_irq;
+	}
+
+	this->irqinuse = 1;
+
+	pr_debug("open\n");
+
+	/* do an initial read from the riegl -- reads the header */
+	devriport_rx(this);
+	return 0;
+fail_irq:
+	this->pbuf_top = this->pbuf = this->pin = this->pout = NULL;
+	kfree(this->pbuf);
+fail_memory:
+	return result;
+}
+
+/*----------------------------------------------------------------------------*/
+static struct drvriport {
+	int major;
+	int numdevs;
+	struct devriport *rgpdev[MAX_RIPORT_DEVICES];
+} riport;
+
+static int drvriport_open(struct inode *pinode, struct file *pfile)
+{
+	int result;
+	struct devriport *pdev;
+
+	if (! atomic_dec_and_test (&riport_available)) {
+		atomic_inc(&riport_available);
+		return -EBUSY; /* already open */
+	}
+
+	pr_debug("drvriport_open\n");
+	if (!(MINOR(pinode->i_rdev) < riport.numdevs))
+		return -ENODEV;
+	pdev = riport.rgpdev[MINOR(pinode->i_rdev)];
+	pdev->pinode = pinode;
+	pdev->pfile = pfile;
+	pfile->private_data = pdev;
+	result = devriport_open(pdev);
+
+	return result;
+}
+
+static int drvriport_release(struct inode *pinode, struct file *pfile)
+{
+	devriport_release(riport.rgpdev[MINOR(pinode->i_rdev)]);
+	return 0;
+}
+
+static ssize_t drvriport_read(struct file * pfile, char __user *pbuf, size_t length,
+			 loff_t * ppos)
+{
+	/*
+	 * if nonblocking, return with EAGAIN (to tell the caller to
+	 * try again)
+	 */
+	if (pfile->f_flags & O_NONBLOCK) {
+		pr_debug("EAGAIN Error\n");
+		return  -EAGAIN;
+	}
+
+	return devriport_read(pfile, pbuf, length);
+}
+
+static const struct file_operations drvriport_fops = {
+	.owner = THIS_MODULE,
+	.read = drvriport_read,
+	.open = drvriport_open,
+	.release = drvriport_release,
+};
+
+
+static int io;
+static int irq;
+static int dma = 1;
+static int size;
+
+/*declarations to enable udev device node creation*/
+static struct class *riport_class;
+
+static int __init riport_init(void)
+{
+	int major = 0;
+	int result;
+	struct devriport *pdev;
+	int n;
+	struct class_device *class_err;
+
+	if (io == 0)
+		io = RIPORT_IO;
+	if (irq == 0)
+		irq = RIPORT_IRQ;
+	if (size == 0)
+		size = RIPORT_SIZE;
+	if ((result = register_chrdev(major, "riport", &drvriport_fops)) < 0)
+		goto fail_register_chrdev;
+
+	/* TODO: here is the place to add more riport devices */
+	riport.major = result;
+	riport.numdevs = 0;
+
+	pdev = devriport_init(riport.major, riport.numdevs, io, irq, dma,
+		size, &result);
+	if (!pdev)
+		goto init_fail_dev;
+
+	riport.rgpdev[riport.numdevs++] = pdev;
+
+	riport_class = class_create(THIS_MODULE, "riport");
+	if (IS_ERR(riport_class)) {
+		result = PTR_ERR(riport_class);
+		goto init_fail_dev;
+	}
+
+	class_err = class_device_create(riport_class, NULL,
+		MKDEV(riport.major, 0), NULL, "riport0");
+
+	if (IS_ERR(class_err)) {
+		result = PTR_ERR(class_err);
+		class_destroy(riport_class);
+		goto init_fail_dev;
+	}
+
+	return 0;
+
+init_fail_dev:
+	pr_debug("init_fail_dev\n");
+	for (n = 0; n < riport.numdevs; n++)
+		devriport_cleanup(riport.rgpdev[n]);
+	unregister_chrdev(riport.major, "riport");
+
+fail_register_chrdev:
+	pr_debug("fail_register_chrdev\n");
+	return result;
+}
+
+static void __exit riport_exit(void)
+{
+	int n;
+
+	class_device_destroy(riport_class, MKDEV(riport.major, 0));
+	class_destroy(riport_class);
+	for (n = 0; n < riport.numdevs; n++)
+		devriport_cleanup(riport.rgpdev[n]);
+	unregister_chrdev(riport.major, "riport");
+}
+
+module_init(riport_init);
+module_exit(riport_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("driver for parallel port laser terrain scanner");
+
+module_param(io, int, 0444);
+MODULE_PARM_DESC(io, "if non-zero then overrides IO port address");
+
+module_param(irq, int, 0444);
+MODULE_PARM_DESC(irq, "if non-zero then overrides IRQ number");
+
+module_param(size, int, 0444);
+MODULE_PARM_DESC(size, "if non-zero then overrides buffer size");
+
+
