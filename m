Return-Path: <linux-kernel-owner+w=401wt.eu-S1750956AbXANBHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbXANBHu (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 20:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbXANBHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 20:07:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41969 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbXANBHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 20:07:49 -0500
Subject: Re: [patch 20/20] XEN-paravirt: Add Xen virtual block device
	driver.
From: Arjan van de Ven <arjan@infradead.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>
In-Reply-To: <20070113014649.256179743@goop.org>
References: <20070113014539.408244126@goop.org>
	 <20070113014649.256179743@goop.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 13 Jan 2007 17:07:28 -0800
Message-Id: <1168736848.3123.352.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#include "../../../arch/i386/paravirt-xen/events.h"
> +#include "../../../arch/i386/paravirt-xen/xen-page.h"

this shows the headers are clearly in the wrong place...
> +
> +	err = xenbus_printf(xbt, dev->nodename,
> +			    "ring-ref","%u", info->ring_ref);

why do you need your own printf?

> +static inline int GET_ID_FROM_FREELIST(

does this really need screaming?


> +
> +int blkif_ioctl(struct inode *inode, struct file *filep,
> +		unsigned command, unsigned long argument)
> +{
> +	int i;
> +
> +	DPRINTK_IOCTL("command: 0x%x, argument: 0x%lx, dev: 0x%04x\n",
> +		      command, (long)argument, inode->i_rdev);
> +
> +	switch (command) {
> +	case CDROMMULTISESSION:
> +		DPRINTK("FIXME: support multisession CDs later\n");
> +		for (i = 0; i < sizeof(struct cdrom_multisession); i++)
> +			if (put_user(0, (char __user *)(argument + i)))
> +				return -EFAULT;
> +		return 0;
> +
> +	default:
> +		/*printk(KERN_ALERT "ioctl %08x not supported by Xen blkdev\n",
> +		  command);*/
> +		return -EINVAL; /* same return as native Linux */
> +	}

eh so you implement no ioctls.. why then implement the ioctl method at
all?


> +static struct xenbus_driver blkfront = {
> +	.name = "vbd",
> +	.owner = THIS_MODULE,
> +	.ids = blkfront_ids,
> +	.probe = blkfront_probe,
> +	.remove = blkfront_remove,
> +	.resume = blkfront_resume,
> +	.otherend_changed = backend_changed,
> +};

this can be const

> +
> +#define DPRINTK(_f, _a...) pr_debug(_f, ## _a)

why this silly abstraction? Just use pr_debug in the code directly



