Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264637AbTEQAqi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 20:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264640AbTEQAqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 20:46:38 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:51857 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S264637AbTEQAqV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 20:46:21 -0400
Date: Sat, 17 May 2003 02:59:10 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, Greg KH <greg@kroah.com>,
       jt@hpl.hp.com, Pavel Roskin <proski@gnu.org>
Subject: Re: request_firmware() hotplug interface, third round.
Message-ID: <20030517005910.GA3808@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <20030515200324.GB12949@ranty.ddts.net> <200305161753.17198.oliver@neukum.org> <20030516183152.GB18732@ranty.ddts.net> <200305170022.29824.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305170022.29824.oliver@neukum.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 17, 2003 at 12:22:29AM +0200, Oliver Neukum wrote:
> 
> > > How and what is the benefit? If you go low on battery you have to
> > > suspend, there's no choice. This means that you have to have it in RAM
> > > always.
> >
> >  If the device losses the firmware upon suspend, the driver will have to
> >  reinitialize it as if it just got plugged, which somehow makes all
> >  devices hotplugable.
> 
> So all firmware has to be permanently in RAM anyway?

 If you really can't access the filesystem on wakeup, you could pull the
 required firmware into ram upon suspend and remove it after wakeup.
 Then while the system is running it will not use kernel memory.

> >  If the driver uses request_firmware(), it doesn't need to handle any
> >  special case, just initialize as usual and it will get the firmware
> >  when it needs it.
> 
> How or precisely, how do you know that it gets it when it needs
> it? Are you planning to have a gray area where the kernel generates
> a special user space before everything else gets woken?

 For this I proposed fwfs (a kernel friendly filesystem on top of
 ramfs), but it didn't get a good acceptance. And after reading Greg's
 recent post initramfs should be able to fill that gap.
 
> >  If the device is needed to access the filesystem, some kind of
> >  persistence will be needed, so the required firmware is already in
> >  kernel space. But the driver doesn't need to care, it will just ask for
> >  the firmware as usual.
> >
> >  Which brings me to another issue, the same device can be required to
> >  access the filesystem or not:
> > 	- In a diskless client, it is the network card
> > 	- In a live-cd it is the cdrom drive
> > 	- In a multi disk system just one of them will be holding
> > 	  required firmware.
> >  So you can not decide at coding time, the latest at compile time, and
> >  ideally at runtime (which is what I am trying to do).
> 
> How? You cannot page out memory during resumption.
> You must not cause any access to disk during resumption.

 You will have to make sure that the firmware is copied into RAM before
 suspension, either via fwfs, initramfs or whatever persistence method
 gets implemented.

> >  OK, how about:
> >
> >   int request_firmware_nowait (
> >   		struct module *module,
> >  		const char *name, const char *device, void *context,
> >  		void (*cont)(const struct firmware *fw, void context)
> >   );
> >
> >   request_firmware code will try_module_get/module_put as needed.
> >
> >   Would that fix the issue?
> 
> No, still no good. It means that you get a memory leak if you unload
> a driver before firmware is provided. You need the ability to explicitely
> cancel a request for firmware.

 The driver will not unload if request_firmware_nowait() has called
 try_module_get() on it.

 But the device could get disconnected and in that case the firmware
 load should be canceled. I'll add request_firmware_cancel().
 
> > > >  Would a patch to wait for hotplug termination and provide termination
> > > >  status be accepted?
> > >
> > > No, you must not wait for user space.
> >
> >  And to get notified when userspace is done?
> 
> Not with that interface.
> You'd need drivers to register both with their subsystem and
> a firmware subsystem.

 Why?, the current interface already provides termination notification.

> But you cannot make device discovery wait for user space.

 Why not?
 
 And anyway, request_firmware_nowait() could be used if that is an
 issue.

> You'd have to rewrite the probe method of all drivers that need
> firmware.

 Keep in mind that the "firmware in a header" method is not allowed
 any more. Drivers needing firmware will have to get their probe method
 modified to get the firmware from userspace anyway.

 Using request_firmware() if they can sleep (USB probe callbacks can
 sleep) is trivial, and using request_firmware_nowait() if they can't
 sleep is just a matter of splitting probe in two pieces.

 So, what alternative are you proposing to get the firmware?
 
 If your proposal is just keeping the firmware in a header so you just
 have it there all the time, you should discuss it with Alan, Greg,
 Jeff, et all, not me.

 Thanks

 	Manuel
 

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
