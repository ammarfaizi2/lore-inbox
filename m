Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbTIFFsQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 01:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbTIFFsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 01:48:16 -0400
Received: from mail.kroah.org ([65.200.24.183]:59609 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263402AbTIFFsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 01:48:06 -0400
Date: Fri, 5 Sep 2003 22:48:13 -0700
From: Greg KH <greg@kroah.com>
To: Michael Frank <mhf@linuxmail.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6.0-test4 - PL2303 OOPS - see also 2.4.22: OOPS on disconnect PL2303 adapter
Message-ID: <20030906054813.GC20197@kroah.com>
References: <200309020139.08248.mhf@linuxmail.org> <200309031432.17209.mhf@linuxmail.org> <20030905230852.GA18196@kroah.com> <200309060932.47136.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309060932.47136.mhf@linuxmail.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 06, 2003 at 10:31:19AM +0800, Michael Frank wrote:
> On Saturday 06 September 2003 07:08, Greg KH wrote:
> > On Wed, Sep 03, 2003 at 02:32:16PM +0800, Michael Frank wrote:
> > > On Wednesday 03 September 2003 07:52, Greg KH wrote:
> > > > Try the patch below and let me know if this solves it for you or not.
> > >
> > > If it is meant to reset the buffers, it has _no_ effect.
> > >
> > > Some more observations:
> > >
> > > Besides it just stopping without obvious reason:
> > >
> > > 1) It does not like when something is typed on cu and not received by the
> > > serial port side connected to PL2303 (CTS low). It tends to hang and the
> > > trouble starts....
> > >
> > > Sep  3 12:52:15 mhfl2 kernel: ttyUSB0: 1 input overrun(s)
> > > Sep  3 12:54:30 mhfl2 last message repeated 2 times
> >
> > Hm, what is causing this?
> >
> 
> I don't understand why it get's Input overruns when it sends a single key.
> "Input" seems not to have any problem.
> 
> Could there be an event meant for output misrouted to input - messing things
> up?

In the tty core?  possibly, but I doubt it.

> > That is probably why cu is getting confused, right?
> 
> I think so. Once this message shows up, it is essentially unusable.

Hm, not nice.

> > > plug in
> > > Sep  3 12:55:47 mhfl2 kernel: hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
> > > Sep  3 12:55:48 mhfl2 kernel: hub 1-0:0: new USB device on port 2, assigned address 3
> > > Sep  3 12:55:48 mhfl2 kernel: usb 1-2: device not accepting address 3, error -110
> 
> > That's showing either you don't have good pci interrupt routing going
> > on, or a messed up device.
> 
> Interrupts - no, I copied gigabytes to/from USB hard disk, 
> eth0 and yenta on PCI are fine too.
> 
> Device - how to verify?

You said if you disconnect the serial cable from the device it works,
right?  That's a device issue :)

> Could it be a "misunderstanding" between device and driver?
>  - driver (seing new device) want's  to assign address to device
>  - device (plugged in, reset), sees a line status changed and 
>    want's to send respective event to driver

Possibly, but again, that's a messed up device if it does that.

The pl2303 devices are usually quite cheap, so I would believe yours has
such a problem.

> > > _disconnect_ serial port side of PL2303
> > >
> > > plug in - OK
> > > Sep  3 12:56:07 mhfl2 kernel: usbserial 1-2:0: PL-2303 converter detected
> > > Sep  3 12:56:07 mhfl2 kernel: usb 1-2: PL-2303 converter now attached to
> > > ttyUSB0 (or usb/tts/0 for devfs)
> >
> > Heh, ok, it looks like you have a wierd device.
> 
> Could it be that - device (plugged in, reset), sees _no_ line status changed
> and has nothing to send. 
> 
> Perhaps there is a sequencing problem somewhere, and it works by chance.
> 
> >> After a while it hang again, this time unloaded USB _without_ exit cu
> 
> > Hm, how can you do this?  There should be a reference on the pl2303
> > driver as you have the port open.  Or are you just removing the host
> > controller driver here?
> 
> It's not loaded on boot, but only when needed. The scripts:
> 
> usb1)
>   if [ ! -e /proc/bus/usb ]; then
>     echo Loading USB
>     modprobe usbcore
>     mount -t usbdevfs usbdevfs /proc/bus/usb
>     modprobe ohci_hcd
>     modprobe sd_mod
>     modprobe pl2303 
>     modprobe lp
>   fi
>   ;;
> 
> usb0)
>   echo Unloading USB
>   rmmod  usb-storage sd_mod scsi-mod
>   rmmod pl2303 usbserial
>   rmmod  lp parport
>   rmmod  ohci_hcd 
>   umount usbdevfs
>   rmmod  usbcore
>   ;;
> 
> Perhaps this is too dumb and I should do some checking along the way,
> however joe user should be unable to oops things up...

I agree.  Can you add that oops to a new bug at bugzilla.kernel.org?

thanks,

greg k-h
