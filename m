Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbTD2EBY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 00:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTD2EBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 00:01:24 -0400
Received: from granite.he.net ([216.218.226.66]:14352 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S261938AbTD2EBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 00:01:22 -0400
Date: Mon, 28 Apr 2003 21:15:35 -0700
From: Greg KH <greg@kroah.com>
To: maxk@qualcomm.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [Bluetooth] HCI USB driver update. Support for SCO over HCI USB.
Message-ID: <20030429041535.GA2093@kroah.com>
References: <200304290317.h3T3HOdA027579@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304290317.h3T3HOdA027579@hera.kernel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 09:03:28PM +0000, Linux Kernel Mailing List wrote:
> ChangeSet 1.971.22.2, 2003/03/24 13:03:28-08:00, maxk@qualcomm.com
> 
> 	[Bluetooth] HCI USB driver update. Support for SCO over HCI USB.
> 	URB and buffer managment rewrite.

Max, you need to be very careful with this:

> -static void hci_usb_interrupt(struct urb *urb, struct pt_regs *regs);
> +struct _urb *_urb_alloc(int isoc, int gfp)
> +{
> +	struct _urb *_urb = kmalloc(sizeof(struct _urb) +
> +				sizeof(struct usb_iso_packet_descriptor) * isoc, gfp);
> +	if (_urb) {
> +		memset(_urb, 0, sizeof(*_urb));
> +		_urb->urb.count = (atomic_t)ATOMIC_INIT(1);
> +		spin_lock_init(&_urb->urb.lock);
> +	}
> +	return _urb;
> +}

You aren't calling usb_alloc_urb() and:

> +struct _urb *_urb_dequeue(struct _urb_queue *q)
> +{
> +	struct _urb *_urb = NULL;
> +        unsigned long flags;
> +        spin_lock_irqsave(&q->lock, flags);
> +	{
> +		struct list_head *head = &q->head;
> +		struct list_head *next = head->next;
> +		if (next != head) {
> +			_urb = list_entry(next, struct _urb, list);
> +			list_del(next); _urb->queue = NULL;
> +		}
> +	}
> +	spin_unlock_irqrestore(&q->lock, flags);
> +	return _urb;
> +}

You aren't calling usb_free_urb() as you are embedding a struct urb
within your struct _urb structure.  Any reason you can't use a struct
urb * instead and call the usb core's functions to create and return a
urb?

Otherwise any changes to the internal urb structures, and the
usb_alloc_urb() and usb_free_urb() functions will have to be mirrored
here in your functions, and I know I will forget to do that :)

Other than that, it's nice to see Bluetooth SCO support for Linux, very
nice job.

thaks,

greg k-h
