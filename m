Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbVEXOvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbVEXOvc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 10:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVEXOvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 10:51:32 -0400
Received: from alog0263.analogic.com ([208.224.222.39]:53900 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262047AbVEXOvN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 10:51:13 -0400
Date: Tue, 24 May 2005 10:50:35 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Paul Rolland <rol@as2917.net>
cc: linux-kernel@vger.kernel.org, rol@witbe.net
Subject: Re: Linux and Initrd used to access disk : how does it work ?
In-Reply-To: <200505241356.j4ODuaR07145@tag.witbe.net>
Message-ID: <Pine.LNX.4.61.0505241032250.16158@chaos.analogic.com>
References: <200505241356.j4ODuaR07145@tag.witbe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 May 2005, Paul Rolland wrote:

> Hello,
>
> I've been fighting for a few days with binary modules from some manufacturer
> for hardware support of disk controler, and I'm at a point where I need
> some more understanding.
>
> 1 - My machine contains an Adaptec SATA Raid based on Marvel 88SX60xx
>    so I need to used the aar81xxx binary module,
>
> 2 - This module is presented as required to access the disk (when
>    installing a RH kernel, it says that no disk is present unless the
>    module is loaded),
>
> 3 - When booting the kernel from disk after installation, the module is
>    loaded so the machine can access the disk...
>
> ... BUT ... how can the machine /
> - boot the kernel,
> - access the initrd image and uncompress it,
> - read the binary module inside and load it
> BEFORE loading the module itself, if it is mandatory to access the disk.
>
> And if it is not, then how can I do the installation ?
>
> I suspect this should be fairly trivial, but I've been thinking about
> for long, and it looks like chicken and egg to me...
>
> Any help ?
>
> Regards,
> Paul

initrd means Initial RAM disk.

The boot image is put onto your Hard disk. The hard disk needs
to be accessible from the BIOS to boot from it. Most controllers
have a BIOS module that lets it be accessed during boot so you
don't need a chicken before the egg to start the boot.
Then, when booting, LILO or grub starts linux which uncompresses
a RAM disk and mounts it instead of your hard disk. A special
version of `init` (called nash) gets started which reads a script
called linuxrc. It contains commands like:

#!/bin/nash
mount -t proc /proc /proc
setquiet
echo Mounted /proc filesystem
echo Mounting sysfs
mount -t sysfs none /sys
echo "Loading scsi_mod.ko module"
insmod /lib/scsi_mod.ko 
echo "Loading sd_mod.ko module"
insmod /lib/sd_mod.ko 
echo "Loading aic7xxx.ko module"
insmod /lib/aic7xxx.ko 
echo "Loading libata.ko module"
insmod /lib/libata.ko 
echo "Loading ata_piix.ko module"
insmod /lib/ata_piix.ko 
echo "Loading jbd.ko module"
insmod /lib/jbd.ko 
echo "Loading ext3.ko module"
insmod /lib/ext3.ko 
echo Creating block devices
mkdevices /dev
echo Creating root device
mkrootdev /dev/root
umount /sys
echo 0x0100 > /proc/sys/kernel/real-root-dev
echo Mounting root filesystem
mount -o defaults --ro -t ext3 /dev/root /sysroot
pivot_root /sysroot /sysroot/initrd
umount /initrd/proc

In this case, it loads my SCSI disk (aic7xxx) module and other
stuff necessary to access the disk and its filesystem.

The module(s) are in the /lib directory of the RAM disk.
They are put there by a build-script that installs initrd.
This script gets executed when you do 'make install' in
the kernel directory. If you have private modules, you
can copy them to the appropriate /lib/modules/`uname -r`/kernel/drivers
directory. You put the module(s) name(s) you need to boot
in /etc/modprobe.conf or /etc/modules.conf (depends upon the
module tools version) as:

alias scsi_hostadapter aic7xxx
alias scsi_hostadapter1 ata_piix

... any scsi_hostadapter stuff will be put into initrd when
you execute the script, /sbin/mkinitrd.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
