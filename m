Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264889AbTIDJ2S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 05:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbTIDJ2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 05:28:17 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:4073 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264889AbTIDJ2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 05:28:07 -0400
Subject: Re: [ACPI] RE: ACPI kernel crash with 2.4.22-pre7 on ASUS L3800C
From: Nils Faerber <nils@kernelconcepts.de>
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: "Brown, Len" <len.brown@intel.com>,
       Martin Mokrejs <mmokrejs@natur.cuni.cz>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
In-Reply-To: <20030904085315.GA29773@hell.org.pl>
References: <BF1FE1855350A0479097B3A0D2A80EE009FCFB@hdsmsx402.hd.intel.com>
	 <20030904085315.GA29773@hell.org.pl>
Content-Type: multipart/mixed; boundary="=-Ga7ah+o3jiFhdSyXU3oS"
Organization: kernel concepts
Message-Id: <1062667556.13465.37.camel@idoru.kc.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 04 Sep 2003 11:25:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ga7ah+o3jiFhdSyXU3oS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Am Do, 2003-09-04 um 10.53 schrieb Karol Kozimor:
> Thus wrote Brown, Len:
> > Martin,
> > Does this still happen with 2.4.22?
> > If yes, can I trouble you to drop the info into bugzilla so we can put
> > it in the queue?
> FYI, I just had it *after* boot, i.e. some 30 seconds after the swsusp 
> resume (trace below), and _again_ _after_ I warm-rebooted the machine using
> SysRq+B. The subsequent warm-reboot went OK.
> 
> Linux 2.4.21 + ACPI 20030619
[...]

Just FYI...
I have kernel 2.4.22 + swsusp 1.1-rc7 running without problems on the
very same machine (Asus L3800C, BIOS 121a).
I fiddled a little with a home grown suspend script until I got swsusp
reliably working with older versions (0.9-pre and before) and it still
works perfectly for me; the suspend script from the swsusp project was
too generic and complicated for me ;) I have attached my version in case
someone's interested in it.

One point that proofs to be a good idea is to remove any unnecessary
drivers before suspending, like USB, Firewire and ethernet and to
re-insert them afterwards. The attached script does this.

> Best regards,
CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--

--=-Ga7ah+o3jiFhdSyXU3oS
Content-Disposition: attachment; filename=suspend
Content-Type: text/x-sh; name=suspend; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

#!/bin/sh

#
# swsusp suspend helper script
# for Asus L3800C and maybe other notebooks
# by Nils Faerber <nils@kernelconcepts.de>
#
# Comments and suggestions welcome!
#
# It assumes that XFree is running on VT7 and that VT12 is more
# or less unallocated for debugging output.
# It will remove safe-to-remove drivers before suspend and re-insert them
# afterwards (USB, Firewire, Ethernet, etc.) as well as ejecting a built-in
# WLAN card (mini-PCI).
#

# Prepare for suspend
chvt 12
ifdown eth0 > /dev/tty12 2>&1
ifdown eth1 > /dev/tty12 2>&1
cardctl eject 2 > /dev/tty12 2>&1
rmmod 8139too > /dev/tty12 2>&1

#rmmod usb-uhci > /dev/tty12 2>&1
#rmmod usbmouse > /dev/tty12 2>&1
#rmmod usbnet > /dev/tty12 2>&1
#rmmod usb-storage > /dev/tty12 2>&1
/etc/hotplug/usb.rc stop
rmmod ohci1394 > /dev/tty12 2>&1

# Do it
rmmod -a
sync
rmmod -a
sync
echo "waiting a second..." > /dev/tty12 2>&1
sleep 1
#echo "1 0 2" > /proc/sys/kernel/swsusp
#echo "4" > /proc/acpi/sleep
echo > /proc/swsusp/activate

# Come back
sync
echo "waiting a second..." > /dev/tty12 2>&1
sleep 1

#modprobe usb-uhci > /dev/tty12 2>&1
/etc/hotplug/usb.rc start
modprobe 8139too > /dev/tty12 2>&1
hwclock --hctosys
ifup eth0 > /dev/tty12 2>&1

cardctl insert 2 > /dev/tty12 2>&1

chvt 7 > /dev/tty12 2>&1
modprobe ohci1394 > /dev/tty12 2>&1

--=-Ga7ah+o3jiFhdSyXU3oS--

