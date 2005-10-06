Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbVJFSVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbVJFSVH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 14:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbVJFSVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 14:21:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:54722 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751286AbVJFSVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 14:21:04 -0400
Date: Thu, 6 Oct 2005 11:20:22 -0700
From: Greg KH <greg@kroah.com>
To: Mark Gross <mgross@linux.intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Sebastien.Bouchard@ca.kontron.com, mark.gross@intel.com
Subject: Re: Fwd: Telecom Clock Driver for MPCBL0010 ATCA computer blade
Message-ID: <20051006182022.GA14414@kroah.com>
References: <200510060803.21470.mgross@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510060803.21470.mgross@linux.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 08:03:21AM -0700, Mark Gross wrote:
> +#if CONFIG_DEBUG_KERNEL 
> +#define debug_printk( args... ) printk( args)
> +#else
> +#define debug_printk( args... )
> +#endif

Please just use the existing dev_dbg() and friend functions instead of
creating your own.

> +DEFINE_SPINLOCK(event_lock);

This should be static, right?

> +irqreturn_t tlclk_interrupt(int irq, void *dev_id, struct pt_regs *regs);

static?

> +DECLARE_WAIT_QUEUE_HEAD(wq);

static?

> +#ifdef TLCLK_IOCTL

Please just delete this whole section, no new ioctls for 2.6 please.

> +ssize_t
> +tlclk_read(struct file * filp, char __user * buf, size_t count, loff_t * f_pos)

Return type on the same line as the function name please.

> +{
> +	int count0 = sizeof(struct tlclk_alarms);
> +
> +	wait_event_interruptible(wq, got_event);
> +	if (copy_to_user(buf, alarm_events, sizeof(struct tlclk_alarms)))
> +		return -EFAULT;
> +
> +	memset(alarm_events, 0, sizeof(struct tlclk_alarms));
> +	got_event = 0;
> +
> +	return count0;

count0 doesn't really need to be here, does it?

What if you get passed less than that size of data?  You will be reading
in off of the end of the buffer (which is not a nice thing to do...)

> +#ifdef CONFIG_SYSFS

Not needed, just drop this #ifdef please.

> +static ssize_t show_current_ref(struct class_device *d, char * buf)
> +{
> +	unsigned long ret_val;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&event_lock, flags);
> +		ret_val = ((inb(TLCLK_REG1) & 0x08) >> 3);
> +	spin_unlock_irqrestore(&event_lock, flags);

Odd indentation here.  You do this a lot, please fix them all.

> +static int __init tlclk_init(void)
> +{
> +	int ret;
> +#ifdef  CONFIG_SYSFS
> +	struct class_device *class;
> +#endif

Again, please drop all of the #ifdefs from this file, they are not
needed.

> +	alarm_events = kcalloc(1, sizeof(struct tlclk_alarms), GFP_KERNEL);

We have kzalloc() now.

> +
> +	if (!alarm_events)
> +		goto out1;
> +
> +/* Read telecom clock IRQ number (Set by BIOS) */

Indentation is wrong.

> +	if( 0 > (ret = misc_register(&tlclk_miscdev )) ) {

Try this instead:
	ret = misc_register(&tlclk_miscdev);
	if (ret) {

> +		printk(KERN_ERR" misc_register retruns %d \n", ret);
> +		ret =  -EBUSY;
> +		goto out3;
> +	}
> +	class = tlclk_miscdev.class;
> +	class_device_create_file(class, &class_device_attr_current_ref);

Try registering a whole attribute group instead.  It's much nicer than
the 20 lines you have to register and unregister your devices (and you
don't handle the error condition properly if something goes wrong half
way through.)

> diff -urN -X dontdiff linux-2.6.14-rc2-mm2/drivers/char/tlclk.h linux-2.6.14-rc2-mm2-tlclk/drivers/char/tlclk.h

Why not just put this stuff into the tlclk.c file itself, as it isn't
needed anywhere else?

thanks,

greg k-h
