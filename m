Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbTEPWJO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 18:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbTEPWJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 18:09:14 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:11500 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262119AbTEPWJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 18:09:12 -0400
From: Oliver Neukum <oliver@neukum.org>
To: ranty@debian.org
Subject: Re: request_firmware() hotplug interface, third round.
Date: Sat, 17 May 2003 00:22:29 +0200
User-Agent: KMail/1.5.1
Cc: LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, Greg KH <greg@kroah.com>,
       jt@hpl.hp.com, Pavel Roskin <proski@gnu.org>
References: <20030515200324.GB12949@ranty.ddts.net> <200305161753.17198.oliver@neukum.org> <20030516183152.GB18732@ranty.ddts.net>
In-Reply-To: <20030516183152.GB18732@ranty.ddts.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305170022.29824.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > How and what is the benefit? If you go low on battery you have to
> > suspend, there's no choice. This means that you have to have it in RAM
> > always.
>
>  If the device losses the firmware upon suspend, the driver will have to
>  reinitialize it as if it just got plugged, which somehow makes all
>  devices hotplugable.

So all firmware has to be permanently in RAM anyway?

>  If the driver uses request_firmware(), it doesn't need to handle any
>  special case, just initialize as usual and it will get the firmware
>  when it needs it.

How or precisely, how do you know that it gets it when it needs
it? Are you planning to have a gray area where the kernel generates
a special user space before everything else gets woken?

>  If the device is needed to access the filesystem, some kind of
>  persistence will be needed, so the required firmware is already in
>  kernel space. But the driver doesn't need to care, it will just ask for
>  the firmware as usual.
>
>  Which brings me to another issue, the same device can be required to
>  access the filesystem or not:
> 	- In a diskless client, it is the network card
> 	- In a live-cd it is the cdrom drive
> 	- In a multi disk system just one of them will be holding
> 	  required firmware.
>  So you can not decide at coding time, the latest at compile time, and
>  ideally at runtime (which is what I am trying to do).

How? You cannot page out memory during resumption.
You must not cause any access to disk during resumption.

> > >  At least usb's probe() can sleep, but that is a good point. How about:
> > >
> > >  int request_firmware_nowait (
> > > 		const char *name, const char *device, void *context,
> > > 		void (*cont)(const struct firmware *fw, void context)
> > >  );
> > >
> > >  Then you can call request_firmware_nowait providing an appropriate
> > >  'cont' callback and 'context' pointer. Then when your callback gets
> > >  called with the firmware you finish device setup.
> >
> > In this form unworkable. Removing a module could kill the machine.
> > That scheme requires that drivers formally register and unregister
> > with fwfs and provide module pointers.
> > An awful lot of overhead.
>
>  OK, how about:
>
>   int request_firmware_nowait (
>   		struct module *module,
>  		const char *name, const char *device, void *context,
>  		void (*cont)(const struct firmware *fw, void context)
>   );
>
>   request_firmware code will try_module_get/module_put as needed.
>
>   Would that fix the issue?

No, still no good. It means that you get a memory leak if you unload
a driver before firmware is provided. You need the ability to explicitely
cancel a request for firmware.

> > > > You cannot kill a part of the kernel if a script fails to perform
> > > > correctly for some reason.
> > >
> > >  Good point. Since it is easily solvable by hand:
> > >
> > >  echo 1 > /sysfs/class/firmware/dev_name/loading
> > >  echo 0 > /sysfs/class/firmware/dev_name/loading
> > >
> > >  I thought that it was OK. (I'll do the timeout)
> >
> > No, it isn't. These writes must require CAP_HARDWARE, thus
> > is no good.
>
>  I'll do the timeout anyway, and make it configurable just in case.
>
> > > > Even worse, you cannot detect the script terminating abnormally in
> > > > that design.
> > >
> > >  Well, the device model doesn't provide that information :(
> > >
> > >  It would be great if it did.
> > >
> > >  Would a patch to wait for hotplug termination and provide termination
> > >  status be accepted?
> >
> > No, you must not wait for user space.
>
>  And to get notified when userspace is done?

Not with that interface.
You'd need drivers to register both with their subsystem and
a firmware subsystem. But you cannot make device discovery
wait for user space.
You'd have to rewrite the probe method of all drivers that need
firmware.

	Regards
		Oliver

