Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262033AbREPR4R>; Wed, 16 May 2001 13:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbREPR4I>; Wed, 16 May 2001 13:56:08 -0400
Received: from fandango.cs.unitn.it ([193.205.199.228]:17683 "EHLO
	fandango.cs.unitn.it") by vger.kernel.org with ESMTP
	id <S262027AbREPRz4>; Wed, 16 May 2001 13:55:56 -0400
From: Massimo Dal Zotto <dz@cs.unitn.it>
Message-Id: <200105161138.NAA11330@nikita.dz.net>
Subject: wrong /dev/sd... order with multiple adapters in kernel 2.4.4
To: alan@redhat.com
Date: Wed, 16 May 2001 13:38:37 +0200 (MEST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have recently upgraded the kernel from 2.2.19 to 2.4.4 and discovered
that it assigns the /dev/sd... devices in the wrong order with respect both
to the behavior of kernel 2.2.19 and to the `scsihosts' boot option which I
specified at the boot prompt.

I have a scsi-only machine with an Adaptec 7890 and an old Symbios 53c875.
The Adaptec mounts an LVD disk with the root and home partitions while the
Symbios mounts two additional disks used for other purposes:

# cat /proc/pci
  Bus  0, device   6, function  0:
    SCSI storage controller: Adaptec AHA-2940U2/W / 7890 (rev 0).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=39.Max Lat=25.
      I/O at 0xd000 [0xd0ff].
      Non-prefetchable 64 bit memory at 0xe0800000 [0xe0800fff].
  Bus  0, device   9, function  0:
    SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 3).
      IRQ 11.
      Master Capable.  Latency=144.  Min Gnt=17.Max Lat=64.
      I/O at 0xb800 [0xb8ff].
      Non-prefetchable 32 bit memory at 0xe0000000 [0xe00000ff].
      Non-prefetchable 32 bit memory at 0xdf800000 [0xdf800fff].

# cat /proc/scsi/scsi
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: FUJITSU  Model: MAE3091LP        Rev: 0112
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: WDIGTL   Model: ENTERPRISE       Rev: 1.91
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 04 Lun: 00
  Vendor: FUJITSU  Model: MAE3091LP        Rev: 0112
  Type:   Direct-Access                    ANSI SCSI revision: 02

Since I want to use the kernel also in rescue diks I have compiled the needed
scsi divers statically:

CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_SCSI_SYM53C8XX=y

With kernel 2.2.19 the Adaptec is initialized first and it assigns /dev/sda
to its only disk. With kernel 2.4.4 the Symbios is initialized first,
/dev/sda is assigned to the wrong (for my purposes) disk and I'm not able
to boot the system, unless I fix the fstab, which I don't want to do because
I need to use it also with the old kernel 2.2.19.
This is the relevant output from dmesg:

Linux version 2.4.4 (root@nikita) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #1 Tue May 15 10:12:38 MEST 2001
PCI: PCI BIOS revision 2.10 entry at 0xf0720, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
SCSI subsystem driver Revision: 1.00
scsi: host order: aic7xxx
PCI: Found IRQ 11 for device 00:09.0
PCI: The same IRQ used for device 00:04.2
PCI: The same IRQ used for device 00:06.0
sym53c8xx: at PCI bus 0, device 9, function 0
scsi1 : sym53c8xx-1.7.3a-20010304
  Vendor: WDIGTL    Model: ENTERPRISE        Rev: 1.91
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: FUJITSU   Model: MAE3091LP         Rev: 0112
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi1, channel 0, id 0, lun 0
Detected scsi disk sdb at scsi1, channel 0, id 4, lun 0
SCSI device sda: 8515173 512-byte hdwr sectors (4360 MB)
 /dev/scsi/host1/bus0/target0/lun0: p1 p2
SCSI device sdb: 17826240 512-byte hdwr sectors (9127 MB)
 /dev/scsi/host1/bus0/target4/lun0: p1
PCI: Found IRQ 11 for device 00:06.0
PCI: The same IRQ used for device 00:04.2
PCI: The same IRQ used for device 00:09.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.5
        <Adaptec aic7890/91 Ultra2 SCSI adapter>
        aic7890/91: Wide Channel A, SCSI Id=7, 32/255 SCBs
  Vendor: FUJITSU   Model: MAE3091LP         Rev: 0112
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdc at scsi0, channel 0, id 0, lun 0
SCSI device sdc: 17826240 512-byte hdwr sectors (9127 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4

There is nothing wrong in this, the kernel must choose some ordering when
initializing the devices and Symbios first is not worse than Adaptec first.

The problem is that the new kernel accepts a boot option (scsihosts) to
force the order in which the scsi devices are detected, but this option is
completely ignored while detecting the /dev/sd... devices. Even specifying
the boot option "scsihosts=aic7xxx" I get the following scsi assignments: 

    /dev/scsi/host0/bus0/target0/lun0   /dev/sdc
    /dev/scsi/host1/bus0/target0/lun0	/dev/sda
    /dev/scsi/host1/bus0/target4/lun0   /dev/sdb

which seems illogical to me because the device order is inconsistent between
the two device naming schemes. This is also incompatible with the behavior of
kernel-2.2.x.

Also trying the `pci=bios' option doesn't help because the initialization
order is determined not by the pci bus scan order but only by the ld order
of the drivers when the kernel was compiled.

The only way to solve my problem was to modify the makefiles and link the
aic7xxx driver before the sym53c8xx, but this is a solution only for my
specific case. With my patch the Adaptec is initialized first and I get
a more consistent order of the scsi devices: 

    /dev/scsi/host0/bus0/target0/lun0   /dev/sda
    /dev/scsi/host1/bus0/target0/lun0	/dev/sdb
    /dev/scsi/host1/bus0/target4/lun0   /dev/sdc

I suggest that the scsi device detection is done in the order specified by
the `scsihosts' boot option or, if not specified, in the pci bus scan order
as reported by /proc/pci.

-- 
Massimo Dal Zotto

+----------------------------------------------------------------------+
|  Massimo Dal Zotto               email: dz@cs.unitn.it               |
|  Via Marconi, 141                phone: ++39-0461534251              |
|  38057 Pergine Valsugana (TN)      www: http://www.cs.unitn.it/~dz/  |
|  Italy                             pgp: see my www home page         |
+----------------------------------------------------------------------+
