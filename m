Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265213AbUFHOhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265213AbUFHOhh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 10:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbUFHOhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 10:37:37 -0400
Received: from pop.gmx.de ([213.165.64.20]:45240 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265213AbUFHOha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 10:37:30 -0400
X-Authenticated: #4512188
Message-ID: <40C5CF26.2080801@gmx.de>
Date: Tue, 08 Jun 2004 16:37:26 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040604)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: udev, dbus, hal and ide-floppy & unmount stuff
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am currently playing around with dbus and hal from cvs and have made 
follwing observations in conjunction with my ATAPI ZIP 100 drive:

1) Using dbus and hal, at last it creates the partition nodes when a zip 
drive is inserted. udev alone doesn't do it and I didn't understand how 
it is supposed to work. Nevertheless I am a bit irriated by the 
processes hald(?) calls: I can see

  5035 ?        S<     0:00 udev block
  5044 ?        S<     0:00 udev block
  5045 ?        S<     0:00 /bin/sh /sbin/hotplug block
  5050 ?        S<     0:00 /etc/hotplug.d/default/hal.hotplug block
  5051 ?        S<     0:00 /bin/sh /sbin/hotplug block
  5056 ?        S<     0:00 /etc/hotplug.d/default/hal.hotplug block

FIrst I wonder why it is called twice and then doing a ps -ax severel 
times in a row, one can see the hotlpug stuff coming mulitple times and 
going again. Is this normal?

2) What probably isn't normal, but o far only cosmetic: As soon as hal 
has been started I regurlarly get this in my log every second or so:

ide-floppy: hdd: I/O error, pc =  0, key =  2, asc = 3a, ascq =  0
ide-floppy: hdd: I/O error, pc = 1b, key =  2, asc = 3a, ascq =  0
hdd: No disk in drive

When a disk is inserted I get:
ide-floppy: hdd: I/O error, pc =  0, key =  2, asc =  4, ascq =  1
ide-floppy: hdd: I/O error, pc = 1b, key =  6, asc = 28, ascq =  0
  hdd: hdd4
  hdd: hdd4
  hdd: hdd4
  hdd: hdd4
  hdd: hdd4
  hdd: hdd4

and the last message gets repeated till I pull out the disk, then it 
goes like this:

ide-floppy: hdd: I/O error, pc =  0, key =  2, asc =  4, ascq =  0
ide-floppy: hdd: I/O error, pc = 1b, key =  2, asc = 3a, ascq =  0
hdd: No disk in drive
ide-floppy: hdd: I/O error, pc =  0, key =  2, asc = 3a, ascq =  0
ide-floppy: hdd: I/O error, pc = 1b, key =  2, asc = 3a, ascq =  0
hdd: No disk in drive

and we are again at the first case repeating.

Probably it is just some minor patching in ide-floppy.c. I could just 
comment out the functions printing that stuff out, but I am not sure 
whether it is sufficient, so I reported it here.


2) I've also been playing around with ivman (ivman.sourceforge.net) 
which uses dbus and hal to automatically mount and unmount disks, esp 
unmount by pressing eject button, which is a very handy feature. And 
here is the problem I encountered: kde is not aware of this daemon and 
as such when you press eject, ivman will thor out the disc, even though 
the mount point is still in use. I was told that the event button 
doesn't generate an event so that it could be checked whether the mount 
point is still being used and thus prevent ejecting.
My idea was that the kernel (or whoever is repsonsible) generetes events 
via dbus (or whatever) when a mount point gets used and when it gets 
unused again. So ivman could lock and unlock the drive according to 
those events.
How can this be accomplished? What do you think?

bye,

Prakash
