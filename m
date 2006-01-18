Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbWARNZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbWARNZO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 08:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbWARNZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 08:25:14 -0500
Received: from mail1.kontent.de ([81.88.34.36]:4055 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S932544AbWARNZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 08:25:12 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Johannes Berg <johannes@sipsolutions.net>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] hci_usb: implement suspend/resume
Date: Wed, 18 Jan 2006 14:25:34 +0100
User-Agent: KMail/1.8
Cc: marcel@holtmann.org, maxk@qualcomm.com, linux-kernel@vger.kernel.org,
       bluez-devel@lists.sourceforge.net
References: <1137540084.4543.15.camel@localhost>
In-Reply-To: <1137540084.4543.15.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601181425.35524.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 18. Januar 2006 00:21 schrieb Johannes Berg:
> The attached patch implements suspend/resume for the hci_usb bluetooth
> driver by simply killing all outstanding urbs on suspend, and re-issuing
> them on resume.
> 
> This allows me to actually use the internal bluetooth "dongle" in my
> powerbook after suspend-to-ram without taking down all userland programs
> (sdpd, ...) and the hci device and reloading the module.
> 
> Signed-Off-By: Johannes Berg <johannes@sipsolutions.net>
> 
> --- linux-2.6.15.1.orig/drivers/bluetooth/hci_usb.c	2006-01-18 00:08:54.840000000 +0100
> +++ linux-2.6.15.1/drivers/bluetooth/hci_usb.c	2006-01-18 00:06:35.080000000 +0100
> @@ -1043,11 +1043,55 @@
>  	hci_free_dev(hdev);
>  }
>  
> +static int hci_usb_suspend(struct usb_interface *intf, pm_message_t message)
> +{
> +	struct hci_usb *husb = usb_get_intfdata(intf);
> +	int i;
> +	unsigned long flags;
> +	if (!husb || intf == husb->isoc_iface)
> +		return 0;
> +	
> +	for (i = 0; i < 4; i++) {
> +		struct _urb_queue *q = &husb->pending_q[i];
> +		struct _urb *_urb;
> +		spin_lock_irqsave(&q->lock, flags);
> +		list_for_each_entry(_urb, &q->head, list)
> +			usb_kill_urb(&_urb->urb);
> +		spin_unlock_irqrestore(&q->lock, flags);
> +	}
> +	return 0;

This patch is wrong. usb_kill_urb() will sleep. You must not use it under
a spinlock.

	Regards
		Oliver
