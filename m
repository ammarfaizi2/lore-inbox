Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbUCYOom (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 09:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbUCYOol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 09:44:41 -0500
Received: from ida.rowland.org ([192.131.102.52]:2052 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S263158AbUCYOoj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 09:44:39 -0500
Date: Thu, 25 Mar 2004 09:44:38 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Colin Leroy <colin@colino.net>
cc: linux-kernel@vger.kernel.org, <linux-usb-devel@lists.sf.net>
Subject: Re: [linux-usb-devel] Re: [OOPS] reproducible oops with 2.6.5-rc2-bk3
In-Reply-To: <136101c4126d$c0bc5600$3cc8a8c0@epro.dom>
Message-ID: <Pine.LNX.4.44L0.0403250936480.1023-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2004, Colin Leroy wrote:

> > > usb 3-1: new full speed USB device using address 3
> > > Oops: kernel access of bad area, sig: 11 [#1]
> > For info: reverting this change fixes it. Didn't find out why, yet.
> >
> >
> http://linux.bkbits.net:8080/linux-2.5/diffs/drivers/usb/class/cdc-acm.c@1.54?nav=index.html|src/|src/drivers|src/drivers/usb|src/drivers/usb/class|hist/drivers/usb/class/cdc-acm.c
> 
> Maybe that's due to this change in drivers/usb/core/message.c:
> @@ -1056,8 +1055,20 @@
>   /* re-init hc/hcd interface/endpoint state */
>   for (i = 0; i < config->desc.bNumInterfaces; i++) {
>    struct usb_interface *intf = config->interface[i];
> +  struct usb_host_interface *alt;
> +
> +  alt = usb_altnum_to_altsetting(intf, 0);
> +
> +  /* No altsetting 0?  We'll assume the first altsetting.
> +   * We could use a GetInterface call, but if a device is
> +   * so non-compliant that it doesn't have altsetting 0
> +   * then I wouldn't trust its reply anyway.
> +   */
> +  if (!alt)
> +   alt = &intf->altsetting[0];
> 
> -  intf->act_altsetting = 0;
> +  intf->cur_altsetting = alt;
> +  intf->act_altsetting = alt - intf->altsetting;
>    usb_enable_interface(dev, intf);
>   }
>   return 0;
> If I understand it well, this changes the previous default behaviour;
> intf->cur_altsetting will be intf->altsetting[0], like before, only if
> there's no intf->altsetting[i].desc.bAlternateSetting == 0.

That's right.  However, the oops you saw shouldn't happen so long as
intf->cur_altsetting points to something valid.  I got the impression that
in the cdc-acm probe routine maybe it was a null pointer.  Can you insert
a statement in the cdc-acm probe function to print out the values of ifcom
and ifdata, to check that they aren't NULL?  While you're at it also try
printing out the value of ifcom->desc.bNumEndpoints; if that is 0 it will
cause an oops.

> I'm not sure the change in cdc-acm (which no longer uses index 0
> altsetting) is correct. Or is this another bug in my phone (motorola C350)
> which should be handled differently than other cdc-acm devices ?

It's hard to say without more information.  The contents of 
/proc/bus/usb/devices or the output of lsusb with the phone plugged in 
would help.

Alan Stern

