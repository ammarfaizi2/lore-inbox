Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264849AbSJOVMg>; Tue, 15 Oct 2002 17:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264862AbSJOVL0>; Tue, 15 Oct 2002 17:11:26 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:26377 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264849AbSJOVKx>;
	Tue, 15 Oct 2002 17:10:53 -0400
Date: Tue, 15 Oct 2002 14:16:51 -0700
From: Greg KH <greg@kroah.com>
To: Steven Dake <sdake@mvista.com>
Cc: Michael Clark <michael@metaparadigm.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] [PATCHES] Advanced TCA Hotswap Support in Linux Kernel
Message-ID: <20021015211651.GM15864@kroah.com>
References: <3DAB1007.6040400@mvista.com> <20021015052916.GA11190@kroah.com> <3DAC52A7.907@mvista.com> <3DAC685B.9070102@metaparadigm.com> <3DAC6C7B.1080205@mvista.com> <20021015203423.GI15864@kroah.com> <3DAC7EAA.5020408@mvista.com> <20021015205402.GL15864@kroah.com> <3DAC839F.7060301@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAC839F.7060301@mvista.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 02:07:43PM -0700, Steven Dake wrote:
> 
> 
> Greg KH wrote:
> 
> >On Tue, Oct 15, 2002 at 01:46:34PM -0700, Steven Dake wrote:
> > 
> >
> >>The data/telecoms I've talked to require disk hotswap times of less then 
> >>20 msec from notification of hotwap to blue led (a light used to 
> >>indicate the device can be removed).  They would like 10 msec if it 
> >>could be done.  This is because of how long it takes on a surprise 
> >>extraction for the hardware to send the signal vs the user to disconnect 
> >>the hardware.
> >>   
> >>
> >
> >But what starts the "notification of hotswap"?  Is this driven by the
> >user somehow, or is it a hardware event that happens out of the blue?
> > 
> >
> In the case of Advanced TCA, an IPMI message is sent to the CPU blade 
> indicating the hotswap button is pressed on the front panel of a disk 
> blade.  The hotswap manager software unmaps the GA address, removes the 
> device from the linux kernel via the scsi-hotswap-main stuff, and sends 
> another IPMI message to the disk node telling it to light its "blue 
> led".  The user removes the disk.  Insertion is easier.

So if userspace gets the event that a button was pressed, it can decide
to light up the led after is spins the disk down, right?

> In this case, the hotswap button on the front panel is used to indicate 
> a hotswap event.  There is talk of making the removal of the board 
> indicate a hotswap event (surprise extraction) because the technicians 
> don't wait for the blue led to remove the boards occasionally and the 
> system should be able to handle this use case.

Hotplug PCI works much the same way.  A user could just walk up, pop the
slot, and pull out the card without waiting for the LED to go out.  We
don't care about that, as the user was obviously stupid in doing such a
thing.  The spec even states something like this :)

> >>For legacy systems such as SAFTE hotswap, polling through sg at 10 msec 
> >>intervals would be extremely painful because of all the context 
> >>switches.  A timer scheduled every 10 msec to send out a SCSI message 
> >>and handle a response if there is a hotswap event is a much better course.
> >>   
> >>
> >
> >What generates the hotswap event?
> > 
> >
> In the case of SAFTE, a SCSI processor (ASIC) is polled by some polling 
> interval about the state of the SAFTE (SCSI) backplane.  When the state 
> changes, software generates a hotswap event and removes the device.

So polling can be done within the kernel, right?  Then notify userspace
of the event, which can decide what to do.  Sound ok?

Or do you think this should be like the pci hotplug code, in that when a
slot is opened (or button pressed, depending on the hardware), the
kernel should scramble as fast as possible to unload the driver, and
shut down the power to the card?  Then when it is finished, notify
userspace of what just happened.

thanks,

greg k-h
