Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272385AbTGYW5N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 18:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272386AbTGYW5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 18:57:13 -0400
Received: from meter.eng.uci.edu ([128.200.85.3]:62659 "EHLO meter.eng.uci.edu")
	by vger.kernel.org with ESMTP id S272385AbTGYW5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 18:57:05 -0400
Date: Fri, 25 Jul 2003 16:12:14 -0700 (PDT)
From: Song Wang <wsong@ece.uci.edu>
To: linux-kernel@vger.kernel.org
Subject: [Mini-HOWTO]How to bring up kernel 2.6.0-test1 on Redhat 9.0
Message-ID: <Pine.GSO.4.50.0307251608040.29317-100000@newport.ece.uci.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

                           Mini HOWTO

        How to build and bring up 2.6.0-test1 on Redhat 9.0

        (http://www.ags.uci.edu/~songw/kernel2.6-rh90-howto.txt)

(Hardware: Dell Dimension 8200 - Pentium 4 2.53GHZ, 1GB DDR memory,
120G EIDE harddrive, and nVidia Geforce4 video card. PS2 mouse
and keyboard connected a IOGEAR Miniview SE KVM switch. There
is a Philips DVD+RW drive.

Software: new Redhat 9.0 with everything installed.)

I run into several problems when I was trying to bring up
2.6.0-test1 kernel on Redhat 9.0. I think they're common and I'd like
to put them together and share with other people who are
willing to help test and improve 2.6.0-test1 kernel.

1. Problems and Solutions
After I downloaded 2.6.0-test1 kernel tarball, I used
'make menuconfig' to create my own configuration file.
After adding several configuration items. I successully
built the kernel and modules using 'make bzImage;make modules'.
(It turns out single 'make' will do the same thing.) Note
'make dep' is not necessary anymore.
Then I used 'make modules_install;make install' to install
modules and the kernel itself. Problems showed up from
this point...

(1) A lot of unresolved symbol when installing kernel modules.

Solution: Kernel moduler loader has to be updated.
Use the new module-init-tools-0.9.12.tar.bz2
from http://www.kernel.org/pub/linux/kernel/people/rusty/modules

After updating the tool, 'make modules_install' worked fine.
Now it's the time to boot the new kernel!

(2) The second problem kicked in. The kernel doesn't boot!
It hangs there after printing "OK. booting the kernel..."

Solution: By default, the display is not enabled. (Weird!!!)
So use 'make menuconfig' to enable them.

Go to 'Character devices', enable 'Virtual Terminal'
and 'Support for console on virtual terminal', then
go to 'Graphics support', at the bottom, you'll see
'Console display driver support  --->', enter into it
and enable 'VGA text console'. Because of the dependency,
you have to enable 'Virtual Terminal' first in order
to see 'Console display driver support  --->'.

As a result

CONFIG_VGA_CONSOLE=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y

Rebuild the kernel, then boot, aha! The kernel is booting
and printing out messages!

(3) The third problem arrived then
The kernel cannot mount the root file system!

My root partition is formated as ext3 and I did enable
Ext3 file system support. I checked /etc/lilo.conf,

image=/boot/vmlinuz-2.6.0-test1
        label=2.6.0-test1
        initrd=/boot/initrd-2.6.0-test1.img
        read-only
        append="hdc=ide-scsi root=LABEL=/1"

Solution: I found that the kernel has not enabled IDE-SCSI emulation.
Go to "ATA/ATAPI/MFM/RLL support", then
"IDE, ATA and ATAPI Block devices", enable
<*> Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support
    <*> Include IDE/ATAPI CDROM support
    <*> Include IDE/ATAPI FLOPPY support
    <M> SCSI emulation support

Rebuild the kernel and reboot, now we're finally up and running
and got into the X-Window!

(4) However, here is the fourth problem: No keyboard and mouse!

Solution: I found under "Input device support", by default,

Input devices (needed for keyboard, mouse, ...) is shown as module <M>
also "AT keyboard support" is shown as module <M>.
I changed the two options to be statically linked with the kernel <*>

After rebooting the machine, I still got no keyboard and mouse.
Then I consulted the post-halloween document
(http://www.codemonkey.org.uk/post-halloween-2.5.txt),
and found that since I'm using a KVM switch, I need to add
"psmouse_noext" option to the kernel, so I added it to /etc/lilo.conf as

append="hdc=ide-scsi root=LABEL=/1 psmouse_noext"

After rebooting, I got the mouse showing up, although it moves
too fast. However, the keyboard still does not work.

So I took out the KVM switch and connected my keyboard and mouse
directly to the PC, all right, everything worked fine!

This ends my try to bring up 2.6.0-test1 on Redhat 9.0. In summary,
it's still not quite streightforward. I suggest

(1) In kernel config, it is better to set up the basic stuff like
display, keyboard and mouse with the correct settings so that
testers can get on track without these unnessary troubles.

(2) KVM switch support needs more work.

Hope this could help other guys get started more quickly.

-Song

(http://www.ags.uci.edu/~songw/kernel2.6-rh90-howto.txt)



