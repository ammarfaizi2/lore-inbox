Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbWISOSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWISOSb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 10:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWISOSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 10:18:31 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:34053 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S964992AbWISOSb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 10:18:31 -0400
Date: Tue, 19 Sep 2006 10:18:30 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Jiri Kosina <jikos@jikos.cz>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] [PATCH] 2.6.18-rc6-mm2 - usb_resume_both() -
 fix suspend/resume
In-Reply-To: <Pine.LNX.4.64.0609190314470.9787@twin.jikos.cz>
Message-ID: <Pine.LNX.4.44L0.0609191015560.6555-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2006, Jiri Kosina wrote:

> With 2.6.18-rc6-mm2 it is possible on my IBM T42p to do suspend/resume 
> cycle only once. The second time, suspend fails with
> 
> 	usb_hcd_pci_suspend(): ehci_pci_suspend+0x0/0xd0 [ehci_hcd]() returns -22
> 	pci_device_suspend(): usb_hcd_pci_suspend+0x0/0x280() returns -22
> 	suspend_device(): pci_device_suspend+0x0/0x70() returns -22
> 
> or, when ehci is unloaded, uhci fails in a similar way:
> 
> 	usb_hcd_pci_suspend(): uhci_suspend+0x0/0xf0 [uhci_hcd]() returns -16
> 	pci_device_suspend(): usb_hcd_pci_suspend+0x0/0x1c0() returns -16
> 	suspend_device(): pci_device_suspend+0x0/0x70() returns -16
> 
> (by the way this looks to me like a mess, that the user could be presented 
> with either -EINVAL or -EBUSY, in case of the same error, depending on the 
> device driver which reports it. I will probably submit a consolidating 
> patch later this evening).
> 
> After some time I figured out that usb_resume_both() is not resuming 
> devices properly - it calls resume_device() only for those devices which 
> are USB_STATE_SUSPENDED (in which case we want to propagate the resume 
> recursively up the device tree), but other cases (most notably 
> USB_STATE_CONFIGURED) stay unhadled.
> 
> This patch fixes my issue, now the suspend/resume can be done arbitrary 
> number of times without any error.
> 
> Signed-off-by: Jiri Kosina <jikos@jikos.cz>
> 
> --- linux-2.6.18-rc6-mm2.orig/drivers/usb/core/driver.c	2006-09-14 16:20:48.000000000 +0200
> +++ linux-2.6.18-rc6-mm2/drivers/usb/core/driver.c	2006-09-19 03:03:12.000000000 +0200
> @@ -1083,6 +1083,8 @@ int usb_resume_both(struct usb_device *u
>  			status = resume_device(udev);
>  		if (parent)
>  			mutex_unlock(&parent->pm_mutex);
> +	} else {
> +		status = resume_device(udev);
>  	}
>  
>  	/* Now the parent won't suspend until we are finished */

Oddly enough, I identified exactly the same problem last week and 
submitted a nearly-identical patch just a few minutes ago.  The problem 
occurs only when CONFIG_USB_SUSPEND isn't set, and it stems from the fact 
that without this addition, the device's dev.power.power_state.event field 
doesn't get set properly during the resume.

Alan Stern

