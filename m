Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268864AbUJKMIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268864AbUJKMIz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 08:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268681AbUJKMIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 08:08:54 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:48365 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S268856AbUJKMHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 08:07:02 -0400
Date: Mon, 11 Oct 2004 14:07:01 +0200
From: bert hubert <ahu@ds9a.nl>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6.9-rc4] USB && mass-storage && disconnect broken semantics
Message-ID: <20041011120701.GA824@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok,

This is about stupid users (including me) unplugging USB devices whilst
still mounted, and expecting sane semantics.

This has generally not been the 'Unix' or even 'Linux' way, but people
expect it to work. I also see no clear automated and robust solution from
userspace. "Don't do that then" is a pretty weak answer, especially since we
want to work on the desktop.

The expected behaviour is that on forceably unplugging an USB memory stick,
the created SCSI device should vanish, along with the mounts based on it.

When the user plugs in the device again, people expect to see it get the
first available name, and be available for remount, possible automated.

What actually happens with 2.6.9-rc4 is this:

[plug in the memory stick]
usb 1-2: new high speed USB device using address 9
scsi7 : SCSI emulation for USB Mass Storage devices
  Vendor: M-Sys     Model: DiskOnKey         Rev: 4.20
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi7, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi7, channel 0, id 0, lun 0,  type 0

Note that the numbers 7 and 9 increase which each unplug/replug event, even
when no mount was attempted. This may be a bad thing in and of itself.

Now we mount:

# mount /dev/sda1 /keychain
# grep /keychain /proc/mounts 
/dev/sda1 /keychain vfat rw,nodiratime,fmask=0033,dmask=0033 0 0

dmesg reports:
USB Mass Storage device found at 8
SCSI device sda: 499712 512-byte hdwr sectors (256 MB)
sda: Write Protect is off
sda: Mode Sense: 45 00 00 08
sda: assuming drive cache: write through
SCSI device sda: 499712 512-byte hdwr sectors (256 MB)
sda: Write Protect is off
sda: Mode Sense: 45 00 00 08
sda: assuming drive cache: write through
 sda: sda1

Note the duplication.

Now we unplug the memory stick:

usb 1-2: USB disconnect, address 9
# grep /keychain /proc/mounts 
/dev/sda1 /keychain vfat rw,nodiratime,fmask=0033,dmask=0033 0 0

# ls /keychain
# 

No errors reported by ls, dmesg is filled with:
scsi7 (0:0): rejecting I/O to dead device
FAT: Directory bread(block 517) failed
scsi7 (0:0): rejecting I/O to dead device
FAT: Directory bread(block 518) failed
scsi7 (0:0): rejecting I/O to dead device
FAT: Directory bread(block 519) failed
scsi7 (0:0): rejecting I/O to dead device
FAT: Directory bread(block 520) failed

We can unmount /keychain, this reports in dmesg:
SCSI error: host 7 id 0 lun 0 return code = 4000000
	Sense class 0, sense error 0, extended sense 0

# grep /keychain /proc/mounts
#

On reinsert, we can mount again:
usb 1-2: new high speed USB device using address 10
scsi8 : SCSI emulation for USB Mass Storage devices
  Vendor: M-Sys     Model: DiskOnKey         Rev: 4.20
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi8, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi8, channel 0, id 0, lun 0,  type 0

Sometimes however, sda appears to be still 'occupied', and higher names are
used.

Now - the perhaps intended behaviour where the user can replug the USB
device when it was disconnected by accident also does not work. When we do
this, things get really out of whack, /dev/sda1 has now become invalid.

Unmounting and unplugging and replugging saves us.

Greg, others, I hope you agree this needs work. I hope we have the
infrastructure to umount based on USB disconnect events, or, alternatively,
will support 'replugging' which at least does part of what people expect.

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
