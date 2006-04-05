Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWDEBfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWDEBfn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 21:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWDEBfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 21:35:43 -0400
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:14482 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751058AbWDEBfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 21:35:42 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <gregkh@suse.de>
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch added to gregkh-2.6 tree
Date: Tue, 4 Apr 2006 21:35:40 -0400
User-Agent: KMail/1.9.1
Cc: rene.herman@keyaccess.nl, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de
References: <44238489.8090402@keyaccess.nl> <d120d5000604041428h65931eb6qffe1af04d91e7f31@mail.gmail.com> <20060404214522.GA20390@suse.de>
In-Reply-To: <20060404214522.GA20390@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604042135.41371.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 April 2006 17:45, Greg KH wrote:
> On Tue, Apr 04, 2006 at 05:28:48PM -0400, Dmitry Torokhov wrote:
> > On 4/4/06, Greg KH <gregkh@suse.de> wrote:
> > >
> > > Hm, no, I unwound this mess, and found the following:
> > >
> > >  - bus_add_device() calls device_attach()
> > >  - device_attach() calls bus_for_each_drv() for every driver on the bus
> > >  - bus_for_each_drv() walks all drivers on the bus and calls
> > >   __device_attach() for every individual driver
> > >  - __device_attach() calls driver_probe_device() for that driver and device
> > >  - driver_probe_device() calls down to the probe() function for the
> > >   driver, passing it that driver, if match() for the bus matches this
> > >   device.
> > >  - if that probe() function returns -ENODEV or -ENXIO[1] then the error
> > >   is ignored and 0 is returned, causing the loop to continue to try
> > >   more drivers
> > >  - if the probe() function returns any other error code, it is
> > >   propagated up, all the way back to bus_add_device.
> > 
> > But why do we do that? probe() failing is driver's problem. The device
> > is still there and should still be presented in sysfs. I don't think
> > that we should stop if probe() fails - maybe next driver manages to
> > bind itself.
> 
> The device is still there.
> 
> Ah, I see what you are saying now.  Yeah, we should still add the
> default attributes for the bus and create the bus link even if some
> random driver had problems.  But then, we should still propagate the
> error back up, right?
> 

I don't think so because device creation did not fail. Otherwise how
would you as a caller of device_register() distinguish between the
following 2 scenarios:

 - you got -ENOMEM (or other error code) because device creation
   indeed failed;
 - you got -ENOMEM because some odd driver could not allocate 4MB
   of memory.

IOW you trying to propagate driver error to device creation code...

Also result of device_register() should not depend on whether
driver_register() was called earlier or not.

-- 
Dmitry
