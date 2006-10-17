Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWJQQEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWJQQEa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 12:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWJQQEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 12:04:30 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:57349 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751163AbWJQQE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 12:04:29 -0400
Date: Tue, 17 Oct 2006 12:04:28 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
cc: Greg K-H <greg@kroah.com>, Duncan Sands <duncan.sands@math.u-psud.fr>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 4/4] Driver core: Don't fail attaching the device if it
 cannot be bound.
In-Reply-To: <20061017130602.5ae67a15@gondolin.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0610171158390.6016-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2006, Cornelia Huck wrote:

> From: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> Don't fail bus_attach_device(), even if the device cannot be bound.
> 
> If dev->driver has been specified, reset it to NULL if device_bind_driver()
> failed and add the device as an unbound device. As a result, bus_attach_device()
> now cannot fail, and we can remove some checking from device_add().
> 
> Also remove an unneeded check in bus_rescan_devices_helper().

The other patches look good, and so does this one except for one small
thing:

> -int bus_attach_device(struct device * dev)
> +void bus_attach_device(struct device * dev)
>  {
>  	struct bus_type *bus = dev->bus;
> -	int ret = 0;
> +	int ret;
>  
>  	if (bus) {
>  		dev->is_registered = 1;
>  		ret = device_attach(dev);
> -		if (ret >= 0) {
> +		BUG_ON(ret < 0);
> +		if (ret >= 0)
>  			klist_add_tail(&dev->knode_bus, &bus->klist_devices);
> -			ret = 0;
> -		} else
> +		else
>  			dev->is_registered = 0;

It looks odd to test the value of ret when you've just crashed the system 
if ret < 0.  You probably should change the BUG_ON to a WARN_ON or 
something similar.

Alan Stern

