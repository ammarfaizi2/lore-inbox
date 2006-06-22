Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWFVXYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWFVXYH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 19:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWFVXYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 19:24:06 -0400
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:54611 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751208AbWFVXYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 19:24:05 -0400
From: David Brownell <david-b@pacbell.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] get USB suspend to work again on 2.6.17-mm1
Date: Thu, 22 Jun 2006 16:24:02 -0700
User-Agent: KMail/1.7.1
Cc: Mattia Dongili <malattia@linux.it>, Jiri Slaby <jirislaby@gmail.com>,
       Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       linux-pm@osdl.org, pavel@suse.cz
References: <20060622202952.GA14135@kroah.com>
In-Reply-To: <20060622202952.GA14135@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606221624.03182.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 June 2006 1:29 pm, Greg KH wrote:
> 
> David, we really should not be caring about what the children of a USB
> device is doing here, as who knows what type of "device" might hang off
> of a struct usb_device. 

Should be _only_ interfaces; everything else descends from an interface.

There was previously an invariant that the interfaces were marked
as quiescent unless the interface (a) had a driver, and (b) that
driver was not suspended.  Evidently that has been lost.  This patch
may be insufficient; ISTR other places relying on that invariant.

And yes, we _should_ care about whether or not any interface is
still active, until the pm core code starts to pay attention to
the driver model tree at all times ... even outside of system-wide
suspend transitions.  Today, the pm core code doesn't even use
that tree directly, and all runtime state changes (like selective
suspend with USB) completely bypass that pm tree.

- Dave



> --- gregkh-2.6.orig/drivers/usb/core/usb.c
> +++ gregkh-2.6/drivers/usb/core/usb.c
> @@ -991,6 +991,8 @@ void usb_buffer_unmap_sg (struct usb_dev
>  
>  static int verify_suspended(struct device *dev, void *unused)
>  {
> +	if (dev->driver == NULL)
> +		return 0;
>  	return (dev->power.power_state.event == PM_EVENT_ON) ? -EBUSY : 0;
>  }
>  
> 
