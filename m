Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267928AbUGaJzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267928AbUGaJzm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 05:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267929AbUGaJzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 05:55:42 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:25097 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267928AbUGaJzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 05:55:22 -0400
Date: Sat, 31 Jul 2004 10:55:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg Howard <ghoward@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Altix system controller communication driver
Message-ID: <20040731105513.A17256@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg Howard <ghoward@sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <Pine.SGI.4.58.0407271457240.1364@gallifrey.americas.sgi.com> <20040728085737.26e0bfd2.akpm@osdl.org> <Pine.SGI.4.58.0407301640510.4902@gallifrey.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.SGI.4.58.0407301640510.4902@gallifrey.americas.sgi.com>; from ghoward@sgi.com on Fri, Jul 30, 2004 at 04:44:58PM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +config SGI_SNSC
> +	bool "SGI Altix system controller communication support"

this won't compile for non-ia64, so you need a depency here.

> +#include "snsc.h"
> +#include <linux/interrupt.h>
> +#include <linux/sched.h>
> +#include <linux/device.h>
> +#include <linux/poll.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <asm/sn/sn_sal.h>
> +#include <asm/sn/nodepda.h>

please include your private header after system headers.  But I don't
thing you need snsc.h at all, just move it's contents into snsc.c

> +
> +
> +#define SYSCTL_BASENAME	"snsc"
> +
> +#define SCDRV_BUFSZ	2048
> +
> +#ifdef SCDRV_DEBUG
> +#define DPRINTF(x...)	printk(x)
> +#else
> +#define DPRINTF(x...)	do {} while(0)
> +#endif

please use the existing pr_debug, or even dev_dbg where you have a struct
device.

> +static int scdrv_open(struct inode *, struct file *);
> +static int scdrv_release(struct inode *, struct file *);
> +static ssize_t scdrv_read(struct file *, char __user *, size_t, loff_t *);
> +static ssize_t scdrv_write(struct file *, const char __user *,
> +			   size_t, loff_t *);
> +static unsigned int scdrv_poll(struct file *, struct poll_table_struct *);
> +static irqreturn_t scdrv_interrupt(int, void *, struct pt_regs *);
> +
> +static struct file_operations scdrv_fops = {
> +	.owner =	THIS_MODULE,
> +	.read =		scdrv_read,
> +	.write =	scdrv_write,
> +	.poll =		scdrv_poll,
> +	.open =		scdrv_open,
> +	.release =	scdrv_release,
> +};

the driver would become more readable by having struct file_operations
after the actual function bodies, thus eliminating the need for additional
prototypes.

> +/*
> + * scdrv_wait
> + *
> + * Call this function to wait on one of the queues associated with an
> + * open subchannel.  Avoid races by entering this function with a held
> + * lock that protects the wait queue; don't release the lock until after
> + * we've added ourselves to the queue.
> + */
> +static inline int
> +scdrv_wait(wait_queue_head_t *waitq_head, spinlock_t *waitq_lock,
> +	   unsigned long flags, unsigned long timeout)
> +{
> +	DECLARE_WAITQUEUE(wait, current);
> +	int ret;
> +
> +	add_wait_queue(waitq_head, &wait);
> +	set_current_state(TASK_INTERRUPTIBLE);
> +	spin_unlock_irqrestore(waitq_lock, flags);
> +
> +	if (timeout) {
> +		ret = schedule_timeout(timeout);
> +	} else {
> +		schedule();
> +	}

You're always calling this with a timeout set.  Also I think the code
would be much more readable by opencoding this in the two callers.  That'd
also give you a chance to switch to prepare_wait & co.

> +static int
> +scdrv_open(struct inode *inode, struct file *file)
> +{
> +	struct sysctl_data_s *scd;
> +	struct subch_data_s *sd;
> +	int rv;
> +
> +	/* look up device info for this device file */
> +	scd = container_of(inode->i_cdev, struct sysctl_data_s, scd_cdev);
> +
> +	if (!scd) {
> +		printk("%s: no such device\n", __FUNCTION__);
> +		return -ENODEV;
> +	}

Can't ever be NULL.

> +		len = min((int) count, len);
> +		if (copy_to_user(buf, sd->sd_rb, len))
> +			return -EFAULT;

Don't you have sd->sd_rbs held here?

> +static inline void
> +scdrv_lock_all(struct subch_data_s *sd, unsigned long *flags)
> +{
> +	spin_lock_irqsave(&sd->sd_rlock, *flags);
> +	spin_lock(&sd->sd_wlock);
> +}
> +
> +static inline void
> +scdrv_unlock_all(struct subch_data_s *sd, unsigned long flags)
> +{
> +	spin_unlock(&sd->sd_wlock);
> +	spin_unlock_irqrestore(&sd->sd_rlock, flags);
> +}

It would probably be more readable without these wrappers.

