Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVFFTYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVFFTYO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 15:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVFFTYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 15:24:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:59543 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261639AbVFFTWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 15:22:35 -0400
Date: Mon, 6 Jun 2005 12:22:26 -0700
From: Greg KH <greg@kroah.com>
To: Abhay_Salunke@Dell.com
Cc: marcel@holtmann.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Matt_Domsch@Dell.com
Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new DellBIOS update driver
Message-ID: <20050606192226.GA12138@kroah.com>
References: <367215741E167A4CA813C8F12CE0143B3ED3AC@ausx2kmpc115.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367215741E167A4CA813C8F12CE0143B3ED3AC@ausx2kmpc115.aus.amer.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 01:54:56PM -0500, Abhay_Salunke@Dell.com wrote:
> > On Mon, Jun 06, 2005 at 11:27:53AM -0500, Abhay_Salunke@Dell.com
> wrote:
> > > > The firmware class creates a sysfs file.  That is what I am
> referring
> > > to
> > > > here.
> > > >
> > > By doing a copy of the image to the sysfs file are we trying to do
> the
> > > automatic actions done by the hotplug scripts manually?
> > 
> > Ok, it seems everyone is way confused here.  This is what I was
> thinking
> > of when I suggested using the firmware code:
> > 	- module loads and registers with firmware core doing the
> > 	  "request_firmware_nowait" call.
> > 	- a hotplug event gets generated that everyone just ignores
> > 	  (because it isn't really a big deal.)
> 
> At this instance the function returns and no entry is seen in
> /sys/class/firmware/

Hm, the entry should be there if you have set up the device structures
properly.

But that's not the main problem here...

> > 	- At some point, the user copies the firmware to the sysfs file
> > 	  because they want to update their bios.
> > 	- the module is then told that firmware is present and it does
> > 	  something with it.
> > 
> > Note, that between step 2 and 3, it could be _days_ or _months_.  No
> > need to touch any hotplug scripts at all.
> > 
> > Does this make more sense now?  It seems pretty simple to me...
> 
> But the code still fails; here's the code snippet tired...

<snip>

Ok, in re-reading the firmware code, you are correct, it will still
timeout in 10 seconds and call your callback.  

Which, in my opinion, is wrong.  We should have some way to say "wait
forever".  Care to change the firmware_class.c code to support this?

I was assuming that this would wait forever, and is why I pointed you in
this direction.  Sorry about the confusion here.

> struct device *new_device;
> void callbackfn(const struct firmware *fw, void *context)
> {
>         printk("callbackfn: entry\n");
> 
>         if (!fw)
>                 printk("Got invalid fw entry \n");
> 
>         printk("callbackfn: exit\n");
> }
> 
> static int __init dcdrbu_init(void)
> {
>         int rc = 0;
>         
>         init_packet_head();
> 
>         new_device = kmalloc(sizeof (struct device), GFP_KERNEL);
> 
>         if (!new_device) {
>                 printk("dcdrbu_init: kmalloc failed \n");
>                 return -ENOMEM;
>         }
> 
>         device_initialize(new_device);
>         strcpy(new_device->bus_id, "dell_rbu");

You need to register your device with the driver core, right?

And why not just point to the cpu device instead?  Or some other
platform device...

> In this case the fw pointer returned in the callback is NULL, it also
> happens without any delay and I also see a message as below in
> /var/log/messages.
> hald[2888]: Timed out waiting for hotplug event 305. Rebasing to 306.

You can ignore hald messages, they do not come from the kernel :)

thanks,

greg k-h
