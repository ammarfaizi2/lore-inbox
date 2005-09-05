Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbVIETGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbVIETGl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 15:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVIETGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 15:06:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15250 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932405AbVIETGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 15:06:41 -0400
Date: Mon, 5 Sep 2005 20:06:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Harald Welte <laforge@gnumonks.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Omnikey Cardman 4040 driver
Message-ID: <20050905190635.GA18315@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Harald Welte <laforge@gnumonks.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <20050905195404.GA16056@rama.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905195404.GA16056@rama.de.gnumonks.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#include <linux/version.h>

I don't think you need this one.

> +#include <pcmcia/version.h>

you shouldn't need this one.

> +static atomic_t cm4040_num_devices_open;
> +
> +#ifdef PCMCIA_DEBUG
> +static int pc_debug = PCMCIA_DEBUG;
> +module_param(pc_debug, int, 0600);
> +#define DEBUG(n, x, args...) do { if (pc_debug >= (n)) 			    \
> +				  printk(KERN_DEBUG "%s:%s:" x, MODULE_NAME, \
> +					 __FUNCTION__, ##args); } while (0)
> +#else
> +#define DEBUG(n, args...)
> +#endif

What about just using pr_debug (or dev_dbg where you have a struct device
handy)

> +/* poll the device fifo status register.  not to be confused with
> + * the poll syscall. */
> +static void cm4040_do_poll(unsigned long dummy)
> +{
> +	unsigned int i;
> +	/* walk through all devices */	
> +	for (i = 0; dev_table[i]; i++) {

Please make the poll timer per device.  We generally try to avoid
global state, and this allows to get rid of the opencount tracking aswell.

> +static ssize_t cm4040_read(struct file *filp, char __user *buf,
> +			size_t count, loff_t *ppos)
> +{
> +	struct reader_dev *dev = (struct reader_dev *) filp->private_data;

no need to case a void pointer.

> +	if (count < 10)
> +		return -EFAULT;
> +
> +	if (filp->f_flags & O_NONBLOCK) { 
> +		DEBUG(4, "filep->f_flags O_NONBLOCK set\n");
> +		DEBUG(2, "<- cm4040_read (failure)\n");
> +		return -EAGAIN;
> +	}

this sounds rather pointless.  letting an O_NONBLOCK open fail all
the time doesn't sound like a good idea.

> +static int cm4040_open(struct inode *inode, struct file *filp)
> +{
> +	struct reader_dev *dev;
> +	dev_link_t *link;
> +	int i;
> +
> +	DEBUG(2, "-> cm4040_open(device=%d.%d process=%s,%d)\n",
> +		MAJOR(inode->i_rdev), MINOR(inode->i_rdev),
> +		current->comm, current->pid);
> +
> +	i = MINOR(inode->i_rdev);

please use iminor.

> +	if (filp->f_flags & O_NONBLOCK) { 
> +		DEBUG(4, "filep->f_flags O_NONBLOCK set\n");
> +		DEBUG(4, "<- cm4040_open (failure)\n");
> +		return -EAGAIN;
> +	}

given that you fail O_NONLOCK in open already the code above makes even
less sense.

> +
> +	dev->owner = current;

this doesn't make a lot of sense and seems to be only used in
debug code, I'd suggest killing it.

> +static int cm4040_close(struct inode *inode,struct file *filp)
> +{
> +	struct reader_dev *dev;
> +	dev_link_t *link;
> +	int i;
> +
> +	DEBUG(2, "-> cm4040_close(maj/min=%d.%d)\n",
> +		MAJOR(inode->i_rdev), MINOR(inode->i_rdev));
> +
> +	i = MINOR(inode->i_rdev);
> +	if (i >= CM_MAX_DEV)
> +		return -ENODEV;
> +
> +	link = dev_table[MINOR(inode->i_rdev)];
> +	if (link == NULL)
> +		return -ENODEV;
> +
> +	dev = (struct reader_dev *) link->priv;

you should be able to use file->private_data here.

> +		case CS_EVENT_CARD_REMOVAL:
> +			DEBUG(5, "CS_EVENT_CARD_REMOVAL\n");
> +			link->state &= ~DEV_PRESENT;
> +			break;
> +		case CS_EVENT_PM_SUSPEND:
> +			DEBUG(5, "CS_EVENT_PM_SUSPEND "
> +			      "(fall-through to CS_EVENT_RESET_PHYSICAL)\n");
> +			link->state |= DEV_SUSPEND;
> +		
> +		case CS_EVENT_RESET_PHYSICAL:
> +			DEBUG(5, "CS_EVENT_RESET_PHYSICAL\n");
> +			if (link->state & DEV_CONFIG) {
> +		  		DEBUG(5, "ReleaseConfiguration\n");
> +		  		pcmcia_release_configuration(link->handle);
> +			}
> +			break;
> +		case CS_EVENT_PM_RESUME:
> +			DEBUG(5, "CS_EVENT_PM_RESUME "
> +			      "(fall-through to CS_EVENT_CARD_RESET)\n");
> +			link->state &= ~DEV_SUSPEND;

I think these events became methods of their own recently, not sure
if it hit -mm or mainline yet.

