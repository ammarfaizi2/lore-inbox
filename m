Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263346AbUCNL5y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 06:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263347AbUCNL5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 06:57:54 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:45330 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S263346AbUCNL5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 06:57:48 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Olaf Hering <olh@suse.de>
Subject: Re: Does sysfs really provides persistent hardware path to devices?
Date: Sun, 14 Mar 2004 14:53:56 +0300
User-Agent: KMail/1.6.1
Cc: Greg KH <greg@kroah.com>, jw schultz <jw@pegasys.ws>,
       linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
References: <E19odOM-000NwL-00.arvidjaar-mail-ru@f22.mail.ru> <200401172334.13561.arvidjaar@mail.ru> <20040119130817.GA27953@suse.de>
In-Reply-To: <20040119130817.GA27953@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200403141453.59145.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 January 2004 16:08, Olaf Hering wrote:
>  On Sat, Jan 17, Andrey Borzenkov wrote:
> > > > Well, we did not move a tiny bit since the beginning of this thread
> > > > :) You still did not show me namedev configuration that implements
> > > > persistent name for a device based on its physical location :)))
> > >
> > > Ok, do you have any other ideas of how to do this?
> >
> > given current sysfs implementation - using wildcards remains the only
> > solution. I for now am using this trivial script:
> >
> > pts/0}% cat /etc/udev/scripts/removables
> > #!/usr/bin/perl
> >
> > my $devpath, $base;
> >
> > $base = $1 if ($ARGV[0] =~ /(.*\D)\d*$/);
> > $devpath = readlink "/sys/block/$base/device";
> >
> > if ($devpath =~
> > m|/devices/pci0000:00/0000:00:1f.4/usb2/2-2/2-2.4/2-2.4:1.0/host\d+/\d+:0
> >:0:0|) {
> >         print "flash0";
> > } elsif ($devpath =~
> > m|/devices/pci0000:00/0000:00:1f.4/usb2/2-2/2-2.1/2-2.1:1.0/host\d+/\d+:0
> >:0:0|) {
> >         print "flash1";
> > } elsif ($devpath =~ m|/devices/legacy/host\d+/\d+:0:4:0|) {
> >         print "jaz";
> > } else {
> >         exit(1);
> > }
>
> I'm not sure what you are trying to do.

I am trying to assign name for a USB slot on my PCs front so that when I plug 
in USB stick or USB drive or whatever I get the same name. Always.

> Working with the 'physical 
> location' of removeable devices will probably fail.

why? The 'physical location' is the only thing that is unlikely to change 
unless you physically change you hardware.

Anyway - it appears that udev (as of 022 now) still does not support doing it. 
Once more - I want to make sure that SCSI disk plugged in specific USB slot 
(that does not ever change) always gets the same name. So that I always know 
how to access it.

naive user would think that something like

KERNEL="sd*" BUS="usb" PLACE="2.4:1.0" SYMLINK="flash0/sd%n"

would work. Surely it does not. When udev sees "sd*" it does not see bus USB. 
When udev sees bus USB it does not see "sd*". It does (probably) see sd* on 
bus SCSI but it does not help me in any way because I have no way to 
associate SCSI ID with USB port. While kernel does know that "sda" is a child 
of USB port 2.4:0.1 I do not see any way to express it in udev.

Could somebody explain what am I doing wrong. Thank you. 

> The usb-storage 
> devices here have a serial field, I really hope it is unique, use it.

Sigh ... let me quote:

> I have 6 different firewire hard drives, and an iPod, a usb stick, a usb
> stick/camera combo, and a bunch of flash memory products (CF, SM, SD) so
> such a thing would be incredibly useful to me.  I'm always modifying my
> fstab to keep things in order.

so you suggest him to add every device separately? And if he has half a dozen 
friends having half a dozen devices each - do you suggest adding yet another 
40 lines for all of them? And keep it in sync with all updates and upgrades?

On the contrary he likely has just a couple of USB ports and one firewire and 
he just needs three lines for *any* device which is ever going to be plugged 
in. Or he would need if it was supported.

thank you

-andrey
