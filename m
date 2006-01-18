Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWARNOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWARNOb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 08:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbWARNOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 08:14:31 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:48602 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932479AbWARNOa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 08:14:30 -0500
Subject: Re: [PATCH] hci_usb: implement suspend/resume
From: Marcel Holtmann <marcel@holtmann.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: maxk@qualcomm.com, linux-kernel@vger.kernel.org,
       bluez-devel@lists.sourceforge.net
In-Reply-To: <1137540084.4543.15.camel@localhost>
References: <1137540084.4543.15.camel@localhost>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 14:13:18 +0100
Message-Id: <1137589998.27515.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

> The attached patch implements suspend/resume for the hci_usb bluetooth
> driver by simply killing all outstanding urbs on suspend, and re-issuing
> them on resume.
> 
> This allows me to actually use the internal bluetooth "dongle" in my
> powerbook after suspend-to-ram without taking down all userland programs
> (sdpd, ...) and the hci device and reloading the module.

thanks for the patch. Due to the removed owner field it won't apply
cleanly to 2.6.16-rc1, but I can fix this easily by myself.

> +static int hci_usb_resume(struct usb_interface *intf)
> +{
> +	struct hci_usb *husb = usb_get_intfdata(intf);
> +	int i, err;
> +	unsigned long flags;
> +	if (!husb || intf == husb->isoc_iface)
> +		return 0;
> +	
> +	for (i = 0; i < 4; i++) {
> +		struct _urb_queue *q = &husb->pending_q[i];
> +		struct _urb *_urb;
> +		spin_lock_irqsave(&q->lock, flags);
> +		list_for_each_entry(_urb, &q->head, list) {
> +			err = usb_submit_urb(&_urb->urb, GFP_ATOMIC);
> +			if (err) break;
> +		}
> +		spin_unlock_irqrestore(&q->lock, flags);
> +		if (err)
> +			return -EIO;
> +	}
> +	return 0;
> +}

What happens if hci_usb_resume() really returns -EIO? Do we have to kill
the URBs again or does the USB subsystems disconnect the device in this
case?

Regards

Marcel


