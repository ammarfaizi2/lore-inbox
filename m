Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWDDV3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWDDV3A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 17:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWDDV3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 17:29:00 -0400
Received: from wproxy.gmail.com ([64.233.184.228]:61348 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750899AbWDDV27 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 17:28:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A68WWj/0HtA3fOGiHBBdswMkHJLYPOi47o71VVVEH9vQcXEDjjeZwxbG7p5lN5R5yADaJKlfYaiZcvc5n3z8hVk2OgU0sMY5nTUHDg7Ytx8PNWG3aAMdLMK7KBEQDC9lxAVZZ5gZiGhqNWxg1iuJzPv/hxW0d8QrItdKiRRTtAg=
Message-ID: <d120d5000604041428h65931eb6qffe1af04d91e7f31@mail.gmail.com>
Date: Tue, 4 Apr 2006 17:28:48 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Greg KH" <gregkh@suse.de>
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch added to gregkh-2.6 tree
Cc: rene.herman@keyaccess.nl, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de
In-Reply-To: <20060404210048.GA5694@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <44238489.8090402@keyaccess.nl> <1FQquz-2CO-00@press.kroah.org>
	 <d120d5000604041323h448c1ccfi7e9dcedd82c385ba@mail.gmail.com>
	 <20060404210048.GA5694@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/06, Greg KH <gregkh@suse.de> wrote:
>
> Hm, no, I unwound this mess, and found the following:
>
>  - bus_add_device() calls device_attach()
>  - device_attach() calls bus_for_each_drv() for every driver on the bus
>  - bus_for_each_drv() walks all drivers on the bus and calls
>   __device_attach() for every individual driver
>  - __device_attach() calls driver_probe_device() for that driver and device
>  - driver_probe_device() calls down to the probe() function for the
>   driver, passing it that driver, if match() for the bus matches this
>   device.
>  - if that probe() function returns -ENODEV or -ENXIO[1] then the error
>   is ignored and 0 is returned, causing the loop to continue to try
>   more drivers
>  - if the probe() function returns any other error code, it is
>   propagated up, all the way back to bus_add_device.

But why do we do that? probe() failing is driver's problem. The device
is still there and should still be presented in sysfs. I don't think
that we should stop if probe() fails - maybe next driver manages to
bind itself.

>  - if the probe() function returns 0, the device is bound to the driver,
>   and it returns 0.  Hm, looks like we continue to loop here too, we
>   could probably stop now that we have bound a driver to the device.
>

Could it be that logic is simply reversed?

> So, I'm pretty sure that this is safe and should work just fine.  To be
> sure, let me go reboot my box with this change on it after I finish this
> email :)
>
> Does that help?
>
> thanks,
>
> greg k-h
>
> [1] - stupid agp drivers (or some other video drivers) require this.  I
>    need to go fix them up so they don't do this, if they haven't been
>    fixed already...
>


--
Dmitry
