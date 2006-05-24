Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWEXXJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWEXXJW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 19:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWEXXJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 19:09:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:57675 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932168AbWEXXJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 19:09:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:reply-to:mime-version:content-type:content-disposition:user-agent;
        b=NSjY4UnCrjnaCbTe4b+abrb1E3Ap/txpzFI0pihDYujw8TElai8VofN2/W52bQzBBm8uw+45nhrDmboYc0DGA0Ww0Fw3IaBc4jX0DaoVjoBkfsnJZ7OucC4xhR8cgCNAItJQ0f2XbiVuGk82ZQEwinUQQcFLgALtI7LFMKdSmAI=
Date: Thu, 25 May 2006 01:05:38 +0200
From: Luca <kronos.it@gmail.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: swsusp in 2.6.16: works fine w/o PSE...
Message-ID: <20060524230538.GA616@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hu Michael,
I'm CC-ing the two swsusp gurus ;)

Michael Tokarev <mjt@tls.msk.ru> ha scritto:
> I was just feeling lucky and tried suspend-to-disk cycle
> on my VIA C3 machine, which lacks PSE which is marked as
> being required for swsusp to work.  After commenting out
> the PSE check in include/asm-i386/suspend.h and rebooting,
> I tried the whole cycle, several times, with real load
> (while running 3 kernel compile in parallel) and while
> IDLE... And surprizingly, it all worked flawlessly for
> me, without a single glitch...
> 
> So the question is: is PSE really needed nowadays?

Can't comment on this one, but this message may answer your question:
http://www.ussg.iu.edu/hypermail/linux/kernel/0410.3/2144.html

> Ok, "w/o a single glitch"...  Actually there are several
> of them so far, but I guess they're unrelated to PSE/C3:
> 
> o Suspend after clean boot is sloooow, it takes quite
>   alot of time to write all the stuff to the disk (the
>   percents are increasing by 1..2 in a sec).  After
>   resume, if I suspend again the whole process takes
>   only several secs.

Are you using the in-kernel image writer or the userspace one?
The userspace suspend tends to be faster than the kernel and you may
limit the image size in order to speed up the process (at the cost of
losing part of the page cache).
See http://suspend.sf.net/
 
> o There's a single 'failed' message, while *suspending*:
> 
> Stopping tasks: ===============================================|
> Shrinking memory... done (0 pages freed)
> pnp: Device 01:01.00 disabled.
> pnp: Device 00:09 disabled.
> pnp: Device 00:08 disabled.
> ACPI: PCI interrupt for device 0000:00:07.5 disabled
> ACPI: PCI interrupt for device 0000:00:07.3 disabled
> ACPI: PCI interrupt for device 0000:00:07.2 disabled
> swsusp: Need to copy 19322 pages
> PCI: Setting latency timer of device 0000:00:01.0 to 64
> PCI: VIA IRQ fixup for 0000:00:07.1, from 255 to 0
> ACPI: PCI Interrupt 0000:00:07.2[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
> PCI: VIA IRQ fixup for 0000:00:07.2, from 9 to 11
> usb usb1: root hub lost power or was reset
> ACPI: PCI Interrupt 0000:00:07.3[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
> PCI: VIA IRQ fixup for 0000:00:07.3, from 9 to 11
> usb usb2: root hub lost power or was reset
> ACPI: PCI Interrupt 0000:00:07.5[C] -> Link [LNKC] -> GSI 12 (level, low) -> IRQ 12
> ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 12 (level, low) -> IRQ 12
> eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
> pnp: Device 00:08 activated.
> pnp: Device 00:09 activated.
> pnp: Failed to activate device 00:0b.   <========= this one
> pnp: Device 01:01.00 activated.
> 
>   This is all shown while *suspending*, so it looks like
>   the kernel is shutting down all the devices and brings
>   them up again for some reason.  PNP device 00:0b is my
>   keyboard.

This is expected. swsusp is carried on in 4 steps:

- stops the tasks 
- shutdown the devices in order to put the system into a quiescent
  state; this is done to prevent DMA to overwrite memory while we are
  copying
- take a snapshot of the memory
- resume the devices, now it's safe to do it because we have a "safe"
  copy of the memory; we need to reactivate the devices in order to
  write out the image
- actually write the image to disk  

> o There's the following sequence of messages in my dmesg:
> 
> Restarting tasks...<6>usb 1-1: USB disconnect, address 2
> done
> usb 1-1: new low speed USB device using uhci_hcd and address 3
> 
>   It looks like either the formatting is wrong (missing \n in some
>   printk() or something), or USB device(s) aren't shutting down/
>   powered up at the appropriate time, or the connect/powerup
>   event interferes with the stuff happening during "Restarting
>   tasks...done" time.  For the end-user this is just a cosmetic
>   glitch (improper formatting), but it as well may be some
>   more serious prob.

It's caused by one of the usb related threads that has been un-frozen;
the thread does the printk() asynchronously, so it's not easy (nor
desiderable) to stop it from writing its stuff.
I think that it's only cosmetic, though IIRC usb used to have problems
with swsusp (and preemption? note to self: try with preempt enabled).

Userspace swsusp supports splash screens, so you may want to look at
a nice progress bar instead of those usb messages ;)

> Note I never tried swsusp before, so I've no idea how it usually
> looks like, or should look like.  We've servers which never suspend,
> we've X terminals (no need to suspend, and it will not work anyway
> as the network connections will not be restored anyway), and this
> my VIA-C3-based machine, which never worked due to the PSE check.


Luca
-- 
Home: http://kronoz.cjb.net
Una donna sposa un uomo sperando che cambi, e lui non cambiera`. Un
uomo sposa una donna sperando che non cambi, e lei cambiera`.
