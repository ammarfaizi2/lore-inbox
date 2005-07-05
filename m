Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbVGEVdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVGEVdF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 17:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVGEVdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 17:33:04 -0400
Received: from mta206-rme.xtra.co.nz ([210.86.15.58]:53161 "EHLO
	mta206-rme.xtra.co.nz") by vger.kernel.org with ESMTP
	id S261957AbVGEV1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 17:27:17 -0400
Message-ID: <40BC5D4C2DD333449FBDE8AE961E0C334F9366@psexc03.nbnz.co.nz>
From: "Roberts-Thomson, James" <James.Roberts-Thomson@NBNZ.CO.NZ>
To: "'Alan Stern'" <stern@rowland.harvard.edu>
Cc: Stefano Rivoir <s.rivoir@gts.it>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: RE: [linux-usb-devel] Kernel unable to read partition table on US
	B Memory Key
Date: Wed, 6 Jul 2005 09:19:30 +1200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

Thanks very much for the input.

> > I'm trying to diagnose an issue with a USB "Memory Key" 
> (128Mb Flash 
> > drive) on my workstation (i386 Linux 2.6.12 kernel, using udev 058).
> > 
> > When connecting the key, the kernel fails to read the 
> partition table, 
> > and therefore the block device /dev/sda1 isn't created, so I can't 
> > mount the volume.  Calling "fdisk" manually, however, makes 
> it all work.
> 
> You don't even have to call fdisk.  Probably "touch /dev/sda" 
> would be enough.

Yes, indeed that does make it work.

> The device is not supposed to send the "Unit Attention, Not 
> ready to ready change" message more than once.  It's 
> violating the SCSI protocol by doing so.  (In fact it's not 
> supposed to send that message at all; it's supposed to send 
> "Power on or reset".)

Oh well, so much for the "Linux Compatible" markings on the box... :-)

> Replacing 
> the device won't help, because the device is behaving as 
> designed and the design is broken.

Yes, I'd imagine so, but I just wanted to make sure that it wasn't a bad
chip etc - generally speaking QA isn't what it used to be for most products
on the market these days.....

> What might help would be a direct comparison of the commands 
> being sent by Linux and by Windows.  If you turn on USB Mass 
> Storage verbose debugging
> (CONFIG_USB_STORAGE_DEBUG) in the kernel configuration then 
> the system debugging log will contain the commands sent by 
> usb-storage.  You can use a USB sniffer program like USB 
> Snoop (available from Sourceforge) to record the commands 
> sent by Windows.  Perhaps looking over the two logs will 
> reveal what magic command the device is waiting for.

OK, I'll try and do that today, and if I get anything meaningful, I'll send
it to the list(s).

One more additional note is that the key came with some s/w that allows you
to partition the key into "private" and "public" areas, where the private
area is accessed by a password.  Naturally, this s/w (Ustorage) is Windows
only; but looking at how it works under Windows it would appear that the key
has some firmware inside that is controlling access etc - could it be that
this firmware hasn't finished initialising by the time Linux tries to read
block 0, which is why the messages occur?

If this is the case, then a subtle delay somewhere in the initialisation
chain may help.  I'm not a Kernel Guru by any stretch, but I imagine the
sequence is something like this:

<key insert>
<usb subsystem identifies device>
<usb-storage driver takes device control> (existing specifiable delay in
here, via "delay_use")
<usb-storage drivers creates /dev/sdX> (via some form of udev interaction, I
guess...)
<sd_mod informed that new SCSI disk exists>
*
<sd_mod tries to read partition table etc>
<sd_mod creates /dev/sdXn entries> (also via udev)
...etc....

Perhaps the ability to create an additional "settle" delay at the "*" above
may help - presumably, I'd need to hack the sd_mod driver, so I'll have a
look there, too.

Thanks,

James Roberts-Thomson
----------
f u cn rd ths, u cn gt a gd jb n cmptr prgrmmng.

Mailing list Readers:  Please ignore the following disclaimer - this email
is explicitly declared to be non confidential and does not contain
privileged information.

This communication is confidential and may contain privileged material.
If you are not the intended recipient you must not use, disclose, copy or retain it.
If you have received it in error please immediately notify me by return email
and delete the emails.
Thank you.
