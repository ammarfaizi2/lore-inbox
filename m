Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269641AbUIRVcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269641AbUIRVcF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 17:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269647AbUIRVcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 17:32:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:41186 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269641AbUIRVbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 17:31:18 -0400
Date: Sat, 18 Sep 2004 14:24:18 -0700
From: Greg KH <greg@kroah.com>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: udev is too slow creating devices
Message-ID: <20040918212418.GA1901@kroah.com>
References: <414C8BC4.30303@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414C8BC4.30303@softhome.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2004 at 09:25:56PM +0200, Ihar 'Philips' Filipau wrote:
> >The fact that a static /dev keeps these race conditions from showing up
> >as often as they really are there is no reason to keep trying to rely on
> >old, undefined behaviour :)
> 
>   [ I'm late to discussion, and do not have much time at all.
>   Just observation from aside by driver writer and OS builder. ]
> 
>   You really do not solve problem - problem as I see it - but just move 
> it around.

No, we solve it with the /etc/dev.d system.  How is that not a solution?

>   When I did first release of device driver for some obscure device, I 
> used to wait in init script for "touch /dev/whatever" to be Ok. My 
> device was ok with dumb open()/close() sequence.
> 
>   What I was really missing - is a way to tell user space that not only 
> driver loaded Ok, but that device was found, diagnosed and upped Ok. 
> Diagnostics was taking time - that's why I tryed to do it async. While 
> device does some inernal spinning, I can load up other drivers.

That's exactly what /etc/dev.d is there for.

>   I haven't found any reasonable solution. module_init() is locking 
> everything - I cannot load any other module, while one module is 
> loading. But from user space point of view this is the only way to 
> return error from device driver.

No it isn't.  A modprobe error means that the module couldn't load for
some reason.  It doesn't mean that a device was not found, or that an
error happened when probing the device.  And if you object otherwise,
think about what happens if you have more than 1 device controlled by a
module, how would you report an error that way?  :)

>   IOW, mapping my experience to this discussion, we need to have a way 
> for user space to wait for discover process to end. After all user space 
> knows better than enyone in kernel what to expect from loaded driver.

No it doesn't at all.  userspace doesn't know that I really have 6
usb-storage devices plugged into my system, and that it needs to "wait"
after I run 'modprobe usb-storage'

However my system _does_ know that if it sees a specific type of
usb-storage device it should name it a specific unique name no matter
where it is plugged into the system, and that it needs to mount that
device at a specific mount point.  That's what userspace is supposed to
know about, and do.

>   We are not talking about hot-plug and preloading of modules. We are 
> talking more about the case where system cannot go on without requested 
> device & its device node.

Then just exit, and resume your "system startup" from the /etc/dev.d
notifier.  That works properly.

> We need a way for modprobe to be able to wait 
> for driver initialization phases (we do not have them - make it sense to 
> have them?): driver initialization, device discovery, device 
> initialization, device node ready.

Please explain how that will work for a device on a bus that is probed
quite slowly (like USB) when we do not know ahead of time how many
devices there are, and what type of driver will bind to them (think
scsi-generic or scsi-tape or scsi-disk...)

> So then user space will be able to 
> wait for driver to reach any of given phases. If init script needs 
> /dev/sda1 and after all phases completed Ok we failed to locate it - it 
> can mean only one thing - /dev/sda1 is not here. Since modprobe will 
> wait - it will mean that we will be able to return error, if any. IMHO 
> that what need to be implemented. Polling is crappy solution: we do not 
> need to poll for something we can reliably find out.

I agree polling is not the proper way.  That's why /etc/dev.d exists.

>   We have all info in kernel in drivers - we need a way to give it back 
> to user space for both play nice with each other.

What information is in drivers that is not known by userspace?
userspace knows what kind of devices that are supported by all drivers,
and so userspace loads the proper driver when it is told by the kernel a
specific device has shown up.  That works just fine and keeps users from
having to figure out what driver is needed for their new device.

thanks,

greg k-h
