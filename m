Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264543AbTEPSTe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 14:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbTEPSTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 14:19:34 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:32398 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S264543AbTEPSTX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 14:19:23 -0400
Date: Fri, 16 May 2003 20:31:52 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, Greg KH <greg@kroah.com>,
       jt@hpl.hp.com, Pavel Roskin <proski@gnu.org>
Subject: Re: request_firmware() hotplug interface, third round.
Message-ID: <20030516183152.GB18732@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <20030515200324.GB12949@ranty.ddts.net> <200305161007.31335.oliver@neukum.org> <20030516095624.GA30397@ranty.ddts.net> <200305161753.17198.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305161753.17198.oliver@neukum.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 16, 2003 at 05:53:17PM +0200, Oliver Neukum wrote:
> Am Freitag, 16. Mai 2003 11:56 schrieb Manuel Estrada Sainz:
> > On Fri, May 16, 2003 at 10:07:31AM +0200, Oliver Neukum wrote:
> > > >  How it works:
> > > > 	- Driver calls request_firmware()
> > > > 	- 'hotplug firmware' gets called with ACCTION=add
> > > > 	- /sysfs/class/firmware/dev_name/{data,loading} show up.
> > > >
> > > > 	- echo 1 > /sysfs/class/firmware/dev_name/loading
> > > > 	- cat whatever_fw > /sysfs/class/firmware/dev_name/data
> > > > 	- echo 0 > /sysfs/class/firmware/dev_name/loading
> > > >
> > > > 	- The call to request_firmware() returns with the firmware in a
> > > > 	  memory buffer and the driver can finish loading.
> > > > 	- Driver loads the firmware.
> > > > 	- Driver calls release_firmware().
> > >
> > > So, if I understand you correctly, RAM is only saved if a device
> > > is hotpluggable and needs firmware only upon intial connection.
> > > Which, if you do suspend to disk correctly, is no device.
> >
> >  Hotpluggability is not required, it is the same for any module, which
> >  gets loaded while the system is running. Drivers don't even need to be
> >  aware of hotplug.
> 
> In that case they can contain the firmware and mark it __init.
> They need no RAM. They can even mark the code needed to put
> firmware into the device as __init.

 There are issues with that approach:

 - Code with firmware will not be accepted in the kernel, there are
   already two drivers that are being hold back for that reason.
   	- Licensing issues.
	- Memory consumption.
	- "new" kernel policy.
 - A device may need to reload firmware upon reset. And if you mark it
   __init, it will not be there.
 - If you include the firmware in the code you have to recompile the
   kernel to update the firmware. Pavel, back me up on this one with the
   ACPI tables issue.
 
> >  And adding some kind of persistence in the mixture so firmware can be
> >  included in the kernel image and later discarded/reconsidered even
> >  in-kernel drivers (meaning non modules) can benefit. Coordinating with
> >  initramfs as Pavel suggested should bring best results in this case.
> >
> >  Also, the hotplug event happens every time you call request_firmware(),
> >  not just on device load or upon initial connection. It is not the
> >  regular "device plug event" it is an special 'firmware' event. For
> >  example, on usb devices you would get two invocations of hotplug, one
> >  'hotplug usb' and one 'hotplug firmware'.
> >
> >  In the case of suspending to disk, you would have to make sure that the
> >  firmware for the device that holds the rest of the firmware is already
> >  in fwfs or whatever persistence method gets finally implemented.
> 
> How and what is the benefit? If you go low on battery you have to suspend,
> there's no choice. This means that you have to have it in RAM always.

 If the device losses the firmware upon suspend, the driver will have to
 reinitialize it as if it just got plugged, which somehow makes all
 devices hotplugable.

 If the driver uses request_firmware(), it doesn't need to handle any
 special case, just initialize as usual and it will get the firmware
 when it needs it.
 
 If the device is needed to access the filesystem, some kind of
 persistence will be needed, so the required firmware is already in
 kernel space. But the driver doesn't need to care, it will just ask for
 the firmware as usual.
 
 Which brings me to another issue, the same device can be required to
 access the filesystem or not:
	- In a diskless client, it is the network card
	- In a live-cd it is the cdrom drive
	- In a multi disk system just one of them will be holding
	  required firmware.
 So you can not decide at coding time, the latest at compile time, and
 ideally at runtime (which is what I am trying to do).
 
> >  At least usb's probe() can sleep, but that is a good point. How about:
> >
> >  int request_firmware_nowait (
> > 		const char *name, const char *device, void *context,
> > 		void (*cont)(const struct firmware *fw, void context)
> >  );
> >
> >  Then you can call request_firmware_nowait providing an appropriate
> >  'cont' callback and 'context' pointer. Then when your callback gets
> >  called with the firmware you finish device setup.
> 
> In this form unworkable. Removing a module could kill the machine.
> That scheme requires that drivers formally register and unregister
> with fwfs and provide module pointers.
> An awful lot of overhead.

 OK, how about:

  int request_firmware_nowait (
  		struct module *module,
 		const char *name, const char *device, void *context,
 		void (*cont)(const struct firmware *fw, void context)
  );

  request_firmware code will try_module_get/module_put as needed.

  Would that fix the issue?
 
> > > You cannot kill a part of the kernel if a script fails to perform
> > > correctly for some reason.
> >
> >  Good point. Since it is easily solvable by hand:
> >
> >  echo 1 > /sysfs/class/firmware/dev_name/loading
> >  echo 0 > /sysfs/class/firmware/dev_name/loading
> >
> >  I thought that it was OK. (I'll do the timeout)
> 
> No, it isn't. These writes must require CAP_HARDWARE, thus
> is no good.

 I'll do the timeout anyway, and make it configurable just in case.

> > > Even worse, you cannot detect the script terminating abnormally in
> > > that design.
> >
> >  Well, the device model doesn't provide that information :(
> >
> >  It would be great if it did.
> >
> >  Would a patch to wait for hotplug termination and provide termination
> >  status be accepted?
> 
> No, you must not wait for user space.

 And to get notified when userspace is done?

> >  Adding an 'struct completion' and 'int status' to the right place
> >  should be just about it.
> >
> > > You'd have to introduce some arbitrary timeout.
> >
> >  OK, I'll do that for now.
> >
> > > It seems to me that you introduce three new problems to get rid of
> > > one old problem.
> >
> >  This is the kind of feedback I wanted, thanks a lot.
> 
> Sorry.

 Don't be, this is still the kind of feedback I want. Weather I manage
 or not, I get the chance to fix the issues.

 Thanks

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
