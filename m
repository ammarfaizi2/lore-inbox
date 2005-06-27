Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbVF0UzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbVF0UzS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 16:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVF0Uyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 16:54:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:59589 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261689AbVF0UwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 16:52:02 -0400
Date: Mon, 27 Jun 2005 13:51:52 -0700
From: Greg KH <greg@kroah.com>
To: Doug Warzecha <Douglas_Warzecha@dell.com>
Cc: linux-kernel@vger.kernel.org, abhay_salunke@dell.com, matt_domsch@dell.com
Subject: Re: [PATCH][RFC 2] char: Add Dell Systems Management Base driver
Message-ID: <20050627205152.GA22094@kroah.com>
References: <20050626230544.GA6121@sysman-doug.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050626230544.GA6121@sysman-doug.us.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2005 at 06:05:44PM -0500, Doug Warzecha wrote:
> This patch adds the Dell Systems Management Base driver.
> 
> The Dell Systems Management Base driver is a character driver that
> implements ioctls for Dell systems management software to use to
> communicate with the driver.

Ugh.  Why new ioctls?  Can't most of these be done other ways?  Like
sysfs or open/write/read/close?

Adding new ioctls is generally frowned apon greatly.

> +static struct pci_dev tvm_dev;

Woah, you are creating your own pci_dev?  No.  Only the pci core can do
that.  Lots of bad things happen if you are doing this.  I'm amazed that
your code even works this way, please fix it.

> +	pr_debug("%s: phys: %x size: %u\n",
> +		__FUNCTION__, tvm_dma_buf_phys_addr, tvm_dma_buf_size);

Use dev_dbg() and friends instead of pr_debug().  Also, use dev_err()
and dev_warn() for your other calls to printk().

> +	case ESM_TVM_READ_MEM:
> +		if (down_interruptible(&tvm_lock))
> +			return -ERESTARTSYS;
> +		ireq->hdr.status = tvm_read_dma_buf(&ireq->data.tvm_mem_read);
> +		up(&tvm_lock);
> +		break;
> +
> +	case ESM_TVM_WRITE_MEM:
> +		if (down_interruptible(&tvm_lock))
> +			return -ERESTARTSYS;
> +		ireq->hdr.status = tvm_write_dma_buf(&ireq->data.tvm_mem_write);
> +		up(&tvm_lock);
> +		break;

Can't these two calls be done by lookin in the existing /proc/iomem
file?  Or, if not that one, some other /proc/*mem file?  Not sure
exactly what you are doing with this read/write stuff...

> +	case ESM_TVM_ALLOC_MEM:
> +		if (down_interruptible(&tvm_lock))
> +			return -ERESTARTSYS;

Why use down_interruptible() everywhere?  Can this stuff be called from
an interrupt somehow?

> +static int dcdbas_do_ioctl(struct file *filp, unsigned int cmd,
> +			   unsigned long arg)
> +{
> +	struct dcdbas_ioctl_req *ubuf = (struct dcdbas_ioctl_req *)arg;
> +	struct dcdbas_ioctl_req *kbuf = NULL;
> +	struct dcdbas_ioctl_hdr hdr;
> +	unsigned long size;
> +	int ret;

So, any user can do any of these ioctl calls?  Isn't that a little bit
insecure?

Also, please run this through sparse and fix the warnings it give you.

thanks,

greg k-h
