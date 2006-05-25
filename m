Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030377AbWEYT6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030377AbWEYT6h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 15:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030379AbWEYT6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 15:58:37 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:23757 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030378AbWEYT6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 15:58:36 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: kronos@kronoz.cjb.net
Subject: Re: swsusp in 2.6.16: works fine w/o PSE...
Date: Thu, 25 May 2006 21:58:43 +0200
User-Agent: KMail/1.9.1
Cc: Michael Tokarev <mjt@tls.msk.ru>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@suse.cz>
References: <20060524230538.GA616@dreamland.darkstar.lan>
In-Reply-To: <20060524230538.GA616@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605252158.45407.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 25 May 2006 01:05, Luca wrote:
> Hu Michael,
> I'm CC-ing the two swsusp gurus ;)
> 
> Michael Tokarev <mjt@tls.msk.ru> ha scritto:
> > I was just feeling lucky and tried suspend-to-disk cycle
> > on my VIA C3 machine, which lacks PSE which is marked as
> > being required for swsusp to work.  After commenting out
> > the PSE check in include/asm-i386/suspend.h and rebooting,
> > I tried the whole cycle, several times, with real load
> > (while running 3 kernel compile in parallel) and while
> > IDLE... And surprizingly, it all worked flawlessly for
> > me, without a single glitch...
> > 
> > So the question is: is PSE really needed nowadays?
> 
> Can't comment on this one, but this message may answer your question:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0410.3/2144.html

Unfortunately I can't add anything here.

> > Ok, "w/o a single glitch"...  Actually there are several
> > of them so far, but I guess they're unrelated to PSE/C3:

No, they aren't.

> > o Suspend after clean boot is sloooow, it takes quite
> >   alot of time to write all the stuff to the disk (the
> >   percents are increasing by 1..2 in a sec).  After
> >   resume, if I suspend again the whole process takes
> >   only several secs.
> 
> Are you using the in-kernel image writer or the userspace one?
> The userspace suspend tends to be faster than the kernel and you may
> limit the image size in order to speed up the process (at the cost of
> losing part of the page cache).
> See http://suspend.sf.net/

Well, the userspace suspend will not work with the 2.6.16.x kernels.
Still you can control the image size using the /sys/power/image_size
attribute (0 for the minimal image).

> > o There's a single 'failed' message, while *suspending*:
> > 
> > Stopping tasks: ===============================================|
> > Shrinking memory... done (0 pages freed)
> > pnp: Device 01:01.00 disabled.
> > pnp: Device 00:09 disabled.
> > pnp: Device 00:08 disabled.
> > ACPI: PCI interrupt for device 0000:00:07.5 disabled
> > ACPI: PCI interrupt for device 0000:00:07.3 disabled
> > ACPI: PCI interrupt for device 0000:00:07.2 disabled
> > swsusp: Need to copy 19322 pages
> > PCI: Setting latency timer of device 0000:00:01.0 to 64
> > PCI: VIA IRQ fixup for 0000:00:07.1, from 255 to 0
> > ACPI: PCI Interrupt 0000:00:07.2[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
> > PCI: VIA IRQ fixup for 0000:00:07.2, from 9 to 11
> > usb usb1: root hub lost power or was reset
> > ACPI: PCI Interrupt 0000:00:07.3[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
> > PCI: VIA IRQ fixup for 0000:00:07.3, from 9 to 11
> > usb usb2: root hub lost power or was reset
> > ACPI: PCI Interrupt 0000:00:07.5[C] -> Link [LNKC] -> GSI 12 (level, low) -> IRQ 12
> > ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 12 (level, low) -> IRQ 12
> > eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
> > pnp: Device 00:08 activated.
> > pnp: Device 00:09 activated.
> > pnp: Failed to activate device 00:0b.   <========= this one
> > pnp: Device 01:01.00 activated.
> > 
> >   This is all shown while *suspending*, so it looks like
> >   the kernel is shutting down all the devices and brings
> >   them up again for some reason.  PNP device 00:0b is my
> >   keyboard.
> 
> This is expected. swsusp is carried on in 4 steps:
> 
> - stops the tasks 
> - shutdown the devices in order to put the system into a quiescent
>   state; this is done to prevent DMA to overwrite memory while we are
>   copying
> - take a snapshot of the memory
> - resume the devices, now it's safe to do it because we have a "safe"
>   copy of the memory; we need to reactivate the devices in order to
>   write out the image

Yes, and the activation of the device (keybard) fails here.  It probably is a
good idea to let the respective driver maintainer know about this.

> - actually write the image to disk  

> 
> > o There's the following sequence of messages in my dmesg:
> > 
> > Restarting tasks...<6>usb 1-1: USB disconnect, address 2
> > done
> > usb 1-1: new low speed USB device using uhci_hcd and address 3
> > 
> >   It looks like either the formatting is wrong (missing \n in some
> >   printk() or something), or USB device(s) aren't shutting down/
> >   powered up at the appropriate time, or the connect/powerup
> >   event interferes with the stuff happening during "Restarting
> >   tasks...done" time.

Probably the devices _are_ woken up at the proper time, but it takes time
for them to get ready and the messages they produce in the process interfere
with the swsusp's messages.  You can try to disable the USB's verbose debug
messages (if they are enabled) and see if that helps or to decrease the
console loglevel before suspend.

> >   For the end-user this is just a cosmetic 
> >   glitch (improper formatting), but it as well may be some
> >   more serious prob.
> 
> It's caused by one of the usb related threads that has been un-frozen;
> the thread does the printk() asynchronously, so it's not easy (nor
> desiderable) to stop it from writing its stuff.
> I think that it's only cosmetic, though IIRC usb used to have problems
> with swsusp (and preemption? note to self: try with preempt enabled).

Works for me. :-)

> Userspace swsusp supports splash screens, so you may want to look at
> a nice progress bar instead of those usb messages ;)

But requires a newer kernel.

Greetings,
Rafael
