Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262829AbUKXUDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262829AbUKXUDk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 15:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbUKXUD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 15:03:28 -0500
Received: from [216.168.132.121] ([216.168.132.121]:29093 "EHLO
	dix1.speechdesk.com") by vger.kernel.org with ESMTP id S262823AbUKXUAS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 15:00:18 -0500
Message-ID: <41A4E4A2.30708@rcn.com>
Date: Wed, 24 Nov 2004 19:44:34 +0000
From: Tribhuvan <loka@rcn.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SOLUTION: Problems with DMA on IDE ServerWorks
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The original post was regarding the inability to
use DMA on drives connected to the IDE interface
on a ServerWorks mainboard under linux (kernel=any)

The problem is that the standard PCI driver has been
attached to the IDE before the serverworks driver
which causes the latter not to be used:

relavant boot-console output:

[ ... too early ...  built-in ide driver loads ... ]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 66MHz system bus speed for PIO modes         
hdd: HL-DT-ST CD-ROM GCR-8480B, ATAPI CD/DVD-ROM drive

[ ... too late  ...  ServerWorks IDE driver fails ... ]
SvrWks CSB5: port 0x0170 already claimed by ide1

DMA will not work.

SOLUTION:

Build all of the PCI/IDE drivers as _modules_ and re-install
the kernel. The mkinitrd script should insert the insmod
calls into the linuxrc script in initrd, but you may want to
check.

1) reconfigure the kernel:
   all PCI/IDE drivers selected as modules (including serverworks.ko)
2) Re-install kernel: make; make modules_install; make install
3) Check linuxrc:

   ("xyz" below is a fake name for your initrd file - will differ
    on each machine - mine is "initrd-2.6.9")

   # cp /boot/initrd-xyz /tmp/tmp/initrd-xyz.gz  #(added .gz extension)
   # gunzip /tmp/initrd-xyz.gz
   # mkdir -p /mnt/initrd && mount -o loop /tmp/initrd-xyz /mnt/initrd
   # cd /mnt/initrd
   # vi linuxrc

About half way down in the linuxrc script you should see something
similar to the following:

# echo "Starting udev"
# echo "/sbin/udev" > /proc/sys/kernel/hotplug
# echo "Creating devices"
# UDEVSTART_ON_BOOT=1
# export UDEVSTART_ON_BOOT
# /sbin/udevstart

# echo "Loading kernel/drivers/ide/pci/serverworks.ko"
# insmod /lib/modules/2.6.9/kernel/drivers/ide/pci/serverworks.ko

# echo "Loading kernel/drivers/ide/ide-disk.ko"
# insmod /lib/modules/2.6.9/kernel/drivers/ide/ide-disk.ko

# echo "Loading kernel/drivers/cdrom/cdrom.ko"
# insmod /lib/modules/2.6.9/kernel/drivers/cdrom/cdrom.ko

# echo "Loading kernel/drivers/ide/ide-cd.ko"
# insmod /lib/modules/2.6.9/kernel/drivers/ide/ide-cd.ko

If it looks OK, just reboot and do:

 # hdparm -d1 /dev/hdX

 and you should see something like:

/dev/hdc:
 setting using_dma to 1 (on)
 using_dma    =  1 (on)

DONE

If not, add the `insmod` lines to linuxrc and save it, then:

install the new initrd file:

# cd /tmp && umount /mnt/initrd
# gzip -9 initrd-xyz
# cp initrd-xyz.gz /boot/initrd-xyz  #(removed .gz extension)

REBOOT and # hdparm -d1 /dev/hdX

DONE

The console messages shoule indicate proper loading of the
serverworks driver - at which time the hdX messages will
appear.

Since I saw the problem didn't have a solution posted, I thought
I'd send it - even though original post was a few months back...

Tribh

