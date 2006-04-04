Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWDDVqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWDDVqH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 17:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWDDVqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 17:46:07 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:40102
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750711AbWDDVqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 17:46:06 -0400
Date: Tue, 4 Apr 2006 14:45:22 -0700
From: Greg KH <gregkh@suse.de>
To: dtor_core@ameritech.net
Cc: rene.herman@keyaccess.nl, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch added to gregkh-2.6 tree
Message-ID: <20060404214522.GA20390@suse.de>
References: <44238489.8090402@keyaccess.nl> <1FQquz-2CO-00@press.kroah.org> <d120d5000604041323h448c1ccfi7e9dcedd82c385ba@mail.gmail.com> <20060404210048.GA5694@suse.de> <d120d5000604041428h65931eb6qffe1af04d91e7f31@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000604041428h65931eb6qffe1af04d91e7f31@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 05:28:48PM -0400, Dmitry Torokhov wrote:
> On 4/4/06, Greg KH <gregkh@suse.de> wrote:
> >
> > Hm, no, I unwound this mess, and found the following:
> >
> >  - bus_add_device() calls device_attach()
> >  - device_attach() calls bus_for_each_drv() for every driver on the bus
> >  - bus_for_each_drv() walks all drivers on the bus and calls
> >   __device_attach() for every individual driver
> >  - __device_attach() calls driver_probe_device() for that driver and device
> >  - driver_probe_device() calls down to the probe() function for the
> >   driver, passing it that driver, if match() for the bus matches this
> >   device.
> >  - if that probe() function returns -ENODEV or -ENXIO[1] then the error
> >   is ignored and 0 is returned, causing the loop to continue to try
> >   more drivers
> >  - if the probe() function returns any other error code, it is
> >   propagated up, all the way back to bus_add_device.
> 
> But why do we do that? probe() failing is driver's problem. The device
> is still there and should still be presented in sysfs. I don't think
> that we should stop if probe() fails - maybe next driver manages to
> bind itself.

The device is still there.

Ah, I see what you are saying now.  Yeah, we should still add the
default attributes for the bus and create the bus link even if some
random driver had problems.  But then, we should still propagate the
error back up, right?

If I changed the patch to do that, would it be acceptable to you?

thanks,

greg k-h
