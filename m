Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264460AbTEPPkD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 11:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264461AbTEPPkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 11:40:03 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:16076 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264460AbTEPPkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 11:40:01 -0400
From: Oliver Neukum <oliver@neukum.org>
To: ranty@debian.org
Subject: Re: request_firmware() hotplug interface, third round.
Date: Fri, 16 May 2003 17:53:17 +0200
User-Agent: KMail/1.5.1
Cc: LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, Greg KH <greg@kroah.com>,
       jt@hpl.hp.com, Pavel Roskin <proski@gnu.org>
References: <20030515200324.GB12949@ranty.ddts.net> <200305161007.31335.oliver@neukum.org> <20030516095624.GA30397@ranty.ddts.net>
In-Reply-To: <20030516095624.GA30397@ranty.ddts.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305161753.17198.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 16. Mai 2003 11:56 schrieb Manuel Estrada Sainz:
> On Fri, May 16, 2003 at 10:07:31AM +0200, Oliver Neukum wrote:
> > >  How it works:
> > > 	- Driver calls request_firmware()
> > > 	- 'hotplug firmware' gets called with ACCTION=add
> > > 	- /sysfs/class/firmware/dev_name/{data,loading} show up.
> > >
> > > 	- echo 1 > /sysfs/class/firmware/dev_name/loading
> > > 	- cat whatever_fw > /sysfs/class/firmware/dev_name/data
> > > 	- echo 0 > /sysfs/class/firmware/dev_name/loading
> > >
> > > 	- The call to request_firmware() returns with the firmware in a
> > > 	  memory buffer and the driver can finish loading.
> > > 	- Driver loads the firmware.
> > > 	- Driver calls release_firmware().
> >
> > So, if I understand you correctly, RAM is only saved if a device
> > is hotpluggable and needs firmware only upon intial connection.
> > Which, if you do suspend to disk correctly, is no device.
>
>  Hotpluggability is not required, it is the same for any module, which
>  gets loaded while the system is running. Drivers don't even need to be
>  aware of hotplug.

In that case they can contain the firmware and mark it __init.
They need no RAM. They can even mark the code needed to put
firmware into the device as __init.

>  And adding some kind of persistence in the mixture so firmware can be
>  included in the kernel image and later discarded/reconsidered even
>  in-kernel drivers (meaning non modules) can benefit. Coordinating with
>  initramfs as Pavel suggested should bring best results in this case.
>
>  Also, the hotplug event happens every time you call request_firmware(),
>  not just on device load or upon initial connection. It is not the
>  regular "device plug event" it is an special 'firmware' event. For
>  example, on usb devices you would get two invocations of hotplug, one
>  'hotplug usb' and one 'hotplug firmware'.
>
>  In the case of suspending to disk, you would have to make sure that the
>  firmware for the device that holds the rest of the firmware is already
>  in fwfs or whatever persistence method gets finally implemented.

How and what is the benefit? If you go low on battery you have to suspend,
there's no choice. This means that you have to have it in RAM always.

> > And do I understand you correctly, you propose that request_firmware()
> > wait for the hotplug script to write the firmware to sysfs?
>
>  Yes.
>
> > That means that request_firmware() is unusuable from the usual
> > probe() methods.
>
>  At least usb's probe() can sleep, but that is a good point. How about:
>
>  int request_firmware_nowait (
> 		const char *name, const char *device, void *context,
> 		void (*cont)(const struct firmware *fw, void context)
>  );
>
>  Then you can call request_firmware_nowait providing an appropriate
>  'cont' callback and 'context' pointer. Then when your callback gets
>  called with the firmware you finish device setup.

In this form unworkable. Removing a module could kill the machine.
That scheme requires that drivers formally register and unregister
with fwfs and provide module pointers.
An awful lot of overhead.

> > You cannot kill a part of the kernel if a script fails to perform
> > correctly for some reason.
>
>  Good point. Since it is easily solvable by hand:
>
>  echo 1 > /sysfs/class/firmware/dev_name/loading
>  echo 0 > /sysfs/class/firmware/dev_name/loading
>
>  I thought that it was OK. (I'll do the timeout)

No, it isn't. These writes must require CAP_HARDWARE, thus
is no good.

> > Even worse, you cannot detect the script terminating abnormally in
> > that design.
>
>  Well, the device model doesn't provide that information :(
>
>  It would be great if it did.
>
>  Would a patch to wait for hotplug termination and provide termination
>  status be accepted?

No, you must not wait for user space.

>  Adding an 'struct completion' and 'int status' to the right place
>  should be just about it.
>
> > You'd have to introduce some arbitrary timeout.
>
>  OK, I'll do that for now.
>
> > It seems to me that you introduce three new problems to get rid of
> > one old problem.
>
>  This is the kind of feedback I wanted, thanks a lot.

Sorry.

	Regards
		Oliver

