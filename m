Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVBAHmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVBAHmc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 02:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVBAHlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 02:41:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:46236 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261716AbVBAHkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 02:40:53 -0500
Date: Mon, 31 Jan 2005 23:10:01 -0800
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch to add usbmon
Message-ID: <20050201071000.GF20783@kroah.com>
References: <20050131212903.6e3a35e5@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050131212903.6e3a35e5@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 09:29:03PM -0800, Pete Zaitcev wrote:
> This patch adds so-called "usbmon", or USB monitoring framework, similar
> to what tcpdump provides for Ethernet. This is an initial version, but
> it should be safe and useful. It adds an overhead of an if () statement
> into submission and giveback paths even when not monitoring, but this
> was deemed a lesser evil than stealth manipulation of function pointers.

Few minor comments on the code:

First off, why make usbmon a module?  You aren't allowing it to happen,
so just take out the parts of the patch that allow it.

>  
>  /* host controllers we manage */
>  LIST_HEAD (usb_bus_list);
> +EXPORT_SYMBOL_GPL (usb_bus_list);

Not needed if not a module.

>  /* used when allocating bus numbers */
>  #define USB_MAXBUS		64
> @@ -96,6 +97,7 @@ static struct usb_busmap busmap;
>  
>  /* used when updating list of hcds */
>  DECLARE_MUTEX (usb_bus_list_lock);	/* exported only for usbfs */
> +EXPORT_SYMBOL_GPL (usb_bus_list_lock);

Not needed if not a module.

>  
>  /* used when updating hcd data */
>  static DEFINE_SPINLOCK(hcd_data_lock);
> @@ -103,6 +105,10 @@ static DEFINE_SPINLOCK(hcd_data_lock);
>  /* wait queue for synchronous unlinks */
>  DECLARE_WAIT_QUEUE_HEAD(usb_kill_urb_queue);
>  
> +#if defined(CONFIG_USB_MON) || defined(CONFIG_USB_MON_MODULE)
> +struct usb_mon_operations *mon_ops;
> +#endif /* CONFIG_USB_MON */

Not needed at all, as you create it down below.  Ah, the .h files, no
wait, you refer to it there too, so removing it here should be fine.

> @@ -1103,8 +1110,6 @@ static int hcd_submit_urb (struct urb *u
>  		 * valid and usb_buffer_{sync,unmap}() not be needed, since
>  		 * they could clobber root hub response data.
>  		 */
> -		urb->transfer_flags |= (URB_NO_TRANSFER_DMA_MAP
> -					| URB_NO_SETUP_DMA_MAP);
>  		status = rh_urb_enqueue (hcd, urb);
>  		goto done;
>  	}

Why remove that statment?  What does that have to do with usbmon?

>  void usb_hcd_giveback_urb (struct usb_hcd *hcd, struct urb *urb, struct pt_regs *regs)
>  {
> -	urb_unlink (urb);
> +	int at_root_hub;
>  
> -	// NOTE:  a generic device/urb monitoring hook would go here.
> -	// hcd_monitor_hook(MONITOR_URB_FINISH, urb, dev)
> -	// It would catch exit/unlink paths for all urbs.
> +	at_root_hub = (urb->dev == hcd->self.root_hub);
> +	urb_unlink (urb);
>  
>  	/* lower level hcd code should use *_dma exclusively */
> -	if (hcd->self.controller->dma_mask) {
> +	if (hcd->self.controller->dma_mask && !at_root_hub) {
>  		if (usb_pipecontrol (urb->pipe)
>  			&& !(urb->transfer_flags & URB_NO_SETUP_DMA_MAP))
>  			dma_unmap_single (hcd->self.controller, urb->setup_dma,

You change the logic here a bit too.  Why?


> diff -urpN -X dontdiff linux-2.6.11-rc2/drivers/usb/core/hcd.h linux-2.6.11-rc2-lem/drivers/usb/core/hcd.h
> --- linux-2.6.11-rc2/drivers/usb/core/hcd.h	2005-01-22 14:54:24.000000000 -0800
> +++ linux-2.6.11-rc2-lem/drivers/usb/core/hcd.h	2005-01-23 17:19:43.000000000 -0800
> @@ -411,6 +411,63 @@ static inline void usbfs_cleanup(void) {
>  
>  /*-------------------------------------------------------------------------*/
>  
> +#if defined(CONFIG_USB_MON) || defined(CONFIG_USB_MON_MODULE)
> +
> +struct usb_mon_operations {
> +	void (*urb_submit)(struct usb_bus *bus, struct urb *urb);
> +	void (*urb_submit_error)(struct usb_bus *bus, struct urb *urb, int err);
> +	void (*urb_complete)(struct usb_bus *bus, struct urb *urb);
> +	/* void (*urb_unlink)(struct usb_bus *bus, struct urb *urb); */
> +	void (*bus_add)(struct usb_bus *bus);
> +	void (*bus_remove)(struct usb_bus *bus);
> +};
> +
> +extern struct usb_mon_operations *mon_ops;
> +
> +#define usbmon_urb_submit(bus, urb)				\

Can you make these inlines?  That makes the code nicer as we get
typechecking and everything :)

> +#else
> +
> +#define usbmon_urb_submit(bus, urb)		/* */
> +#define usbmon_urb_submit(bus, urb, error)	/* */
> +#define usbmon_urb_complete(bus, urb)		/* */
> +#define usbmon_notify_bus_add(bus)		/* */
> +#define usbmon_notify_bus_remove(bus)		/* */

static inlines for these too if you can.

thanks,

greg k-h
