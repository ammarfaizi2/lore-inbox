Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVGBKEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVGBKEu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 06:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVGBKEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 06:04:49 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:12557 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261851AbVGBKEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 06:04:07 -0400
Date: Sat, 2 Jul 2005 12:03:49 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Eric Valette <eric.valette@free.fr>
Cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: updating kernel to 2.6.13-rc1 from 2.6.12 + CONFIG_DEVFS_FS + empty /dev
Message-ID: <20050702100349.GA25749@alpha.home.local>
References: <42C30CBC.5030704@free.fr> <20050629224040.GB18462@kroah.com> <1120137161.42c3efc93b36c@imp1-q.free.fr> <20050630155453.GA6828@kroah.com> <42C455C1.30503@free.fr> <20050702053711.GA5635@kroah.com> <42C640AC.1020602@free.fr> <20050702082218.GM8907@alpha.home.local> <42C659B2.8010002@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C659B2.8010002@free.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2005 at 11:09:06AM +0200, Eric Valette wrote:
> Willy Tarreau wrote:
> > Well, although I've never used udev because I've been using sort of an
> > equivalent called "preinit" for 4 years now, I don't totally agree with
> > you about the firmware upgrade : when you package your systems to allow
> > the customer to perform "firmware" upgrades, your image is already very
> > specific to a hardware model, and I don't see why you would need to
> > create /dev entries independantly from the kernel or rootfs. 
> 
> I beg to disagree. More and more devices have generic connectivity plug
> (USB, 1394, ...) and you may update your firmware because you support a
> new device connected to this plug that is not a generic device (specific
> driver needed) but you may also have provisionned generic devices
> drivers for the plug and want devices created only when device is
> plugged (usb mass storage comes in mind). If I make a static /dev
> provision for a USB disk how many useless partition will I need to
> create,

They cost almost nothing, and in all cases, far less than the required code
to autodetect them. You just need to create /dev/sda{,0-15} for an USB disk,
and you may need to to this for sdb and/or sdc if you plan to support multiple
USB storage devices simultaneously plugged. And if your embedded system already
carries SCSI disks (which is very rare, except for example external arrays),
then you're in trouble already. Maybe sysfs can help you, I don't know.

> and how will I mount the correct number of partition without
> hotplug like feature and analysing by hand the partition table?

"analysing by hand" is a bit excessive. I don't think the difference between

   for part in /dev/sda*; do
     mkdir -p /mnt/${part#/dev/}
     mount $part /mnt/${part#/dev/}
   done

and :
 
   while read maj min blo part; do
     case $part in sda[1-9]*)
       mkdir -p /mnt/$part
       mount /dev/$part /mnt/$part
     esac
   done </proc/partitions

is so important.

Now I agree that devfs might have made it easier to find the sd* devices
associated to the usb-storage device, but it is totally independant on
your problem of creating lots of /dev entries in advance.

Regards,
Willy

