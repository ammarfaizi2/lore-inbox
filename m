Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282821AbRLKTpb>; Tue, 11 Dec 2001 14:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282815AbRLKTpU>; Tue, 11 Dec 2001 14:45:20 -0500
Received: from [208.46.240.239] ([208.46.240.239]:44191 "EHLO mail.empexis.com")
	by vger.kernel.org with ESMTP id <S282801AbRLKToy>;
	Tue, 11 Dec 2001 14:44:54 -0500
Message-ID: <3C165586.457A26F0@empexis.com>
Date: Tue, 11 Dec 2001 13:50:46 -0500
From: Joy Almacen <joy@empexis.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: wa@almesberger.net, linux-kernel@vger.kernel.org
CC: "Stephen C. Tweedie" <sct@redhat.com>
Subject: pivot_root and initrd kernel panic woes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner and the Kernel Gods,


 I have tried for the past 3 days fruitlessly to resolve my kernel
woes.  Spent  most of my working hours searching  google for any answers
but I got confused instead.  I am desperate for any info that would
point
me to the right direction.  Your assistance will be highly appreciated
and I know that I am not alone on this one.

Here's what I am trying to do.

I have successfully installed RH 7.1 with 2.4.2 kernel on a Compaq
Proliant 6000 (4 Processors) .  The SCSI driver that was loaded on
install is sym53c8xx .

cat /proc/scsi/scsi

Attached devices:
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: COMPAQ   Model: MAB3091SC        Rev: 0814
  Type:   Direct-Access                    ANSI SCSI revision: 02



[root@tinkerbell smpimg]# lsmod

Module                  Size  Used by
loop                    9120   2  (autoclean)
eepro100               16624   1  (autoclean)
sym53c8xx              62080   5
sd_mod                 11680   5
scsi_mod               95072   2  [sym53c8xx sd_mod]


[root@tinkerbell smpimg]# cat /proc/mounts

/dev/root / ext2 rw 0 0
/proc /proc proc rw 0 0
/dev/sda8 /home ext2 rw 0 0
/dev/sda6 /usr ext2 rw 0 0
/dev/sda5 /var ext2 rw 0 0
none /dev/pts devpts rw 0 0
/dev/loop0 /mnt/smpimg ext2 rw 0 0



Also,  /dev/ram0 is enabled:

fdisk /dev/ram0

Note: sector size is 1024 (not 512)
Device contains neither a valid DOS partition table, nor Sun, SGI or OSF
disklabel
Building a new DOS disklabel. Changes will remain in memory only,
until you decide to write them. After that, of course, the previous
content won't be recoverable.


Command (m for help): p

Disk /dev/ram0: 1 heads, 4096 sectors, 1 cylinders
Units = cylinders of 4096 * 1024 bytes

     Device Boot    Start       End    Blocks   Id  System



Since I wanted to have  EXT3 support ,   I upgraded my kernel to
2.4.9-12 from redhat.com together with the
required SysVinit, modutils, initscripts, filesystem and all.

Once I have the new kernel installed I created an initrd image. The
reason is that the SCSI drivers are modules and
not compiled in:

[root@tinkerbell scsi]# pwd

/lib/modules/2.4.9-12smp/kernel/drivers/scsi

[root@tinkerbell scsi]# ls

3w-xxxx.o   aha1740.o      cpqfc.o     fdomain.o    ips.o
pci2000.o   qlogicfas.o   sg.o         tmscsim.o
53c7,8xx.o  aic7xxx        dmx3191d.o  gdth.o       iscsi.o
pci2220i.o  qlogicfc.o    sim710.o     u14-34f.o
a100u2w.o   aic7xxx_mod.o  dpt_i2o.o   g_NCR5380.o  megaraid.o
pcmcia      qlogicisp.o   sr_mod.o     ultrastor.o
aacraid.o   aic7xxx.o      dtc.o       ide-scsi.o   NCR53c406a.o
ppa.o       scsi_debug.o  st.o         wd7000.o
advansys.o  AM53C974.o     eata_dma.o  imm.o        ncr53c8xx.o
psi240i.o   scsi_mod.o    sym53c416.o
aha152x.o   atp870u.o      eata.o      in2000.o     osst.o
qla1280.o   sd_mod.o      sym53c8xx.o
aha1542.o   BusLogic.o     eata_pio.o  initio.o     pas16.o
qla2x00.o   seagate.o     t128.o


Since I understand that I have to create an image for my booting
process, I created one with the following
command:

[root@tinkerbell scsi]# cd /boot/

mkinitrd  initrd-2.4.9-12smp.img  2.4.9-12smp  --preload scsi_mod
--with=sd_mod  --with=sym53c8xx -v

Using modules:  ./kernel/drivers/scsi/scsi_mod.o
./kernel/drivers/scsi/sd_mod.o ./kernel/drivers/scsi/sym53c8xx.o
Using loopback device /dev/loop1
/sbin/nash -> /tmp/initrd.QCmw3a/bin/nash
/sbin/insmod.static -> /tmp/initrd.QCmw3a/bin/insmod
`/lib/modules/2.4.9-12smp/./kernel/drivers/scsi/scsi_mod.o' ->
`/tmp/initrd.QCmw3a/lib/scsi_mod.o'
`/lib/modules/2.4.9-12smp/./kernel/drivers/scsi/sd_mod.o' ->
`/tmp/initrd.QCmw3a/lib/sd_mod.o'
`/lib/modules/2.4.9-12smp/./kernel/drivers/scsi/sym53c8xx.o' ->
`/tmp/initrd.QCmw3a/lib/sym53c8xx.o'
Loading module scsi_mod with options
Loading module sd_mod with options
Loading module sym53c8xx with options



Here's my /etc/modules.conf

[root@tinkerbell /boot]# cat /etc/modules.conf

alias eth0 eepro100
alias eth1 eepro100
alias scsi_hostadapter1 sym53c8xx
alias parport_lowlevel parport_pc
alias scsi_hostadapter2 sym53c8xx
alias scsi_hostadapter3 sym53c8xx
alias scsi_hostadapter4 sym53c8xx

After creating the initrd image, I wanted to make sure that it will
mount the correct device:

[root@tinkerbell /boot]# zcat initrd-2.4.9-12smp.img  > /tmp/smp

[root@tinkerbell /boot]# mount /tmp/smp -t ext2 /mnt/smpimg/ -o loop

[root@tinkerbell /boot]# cd /mnt/smpimg/

[root@tinkerbell smpimg]# vi linuxrc


Here's the content of mkinitrd generated  /linuxrc

#!/bin/nash

echo "Loading scsi_mod module"
insmod /lib/scsi_mod.o
echo "Loading sd_mod module"
insmod /lib/sd_mod.o
echo "Loading sym53c8xx module"
insmod /lib/sym53c8xx.o
mount -t proc /proc /proc
echo Mounting /proc filesystem
echo Creating root device
mkrootdev /dev/root
echo 0x0100 > /proc/sys/kernel/real-root-dev
umount /proc
echo Mounting root filesystem
mount --ro -t ext2 /dev/root /sysroot
pivot_root /sysroot /sysroot/initrd


I saw a posting on the net saying that I should have this edited as
follows:

#!/bin/nash

echo "Loading scsi_mod module"
insmod /lib/scsi_mod.o
echo "Loading sd_mod module"
insmod /lib/sd_mod.o
echo "Loading sym53c8xx module"
insmod /lib/sym53c8xx.o
mount -t proc /proc /proc
echo Mounting /proc filesystem
echo Creating root device
mkrootdev /dev/root
echo 0x0100 > /proc/sys/kernel/real-root-dev
umount /proc
echo Mounting root filesystem
mount --ro -t ext2  /dev/root  /sysroot
cd /sysroot                                                 ## CD to
/sysroot first
pivot_root /sysroot /sysroot/initrd       ## Do pivot_root
exec /sbin/init "$@"                                ## Execute
/sbin/init


After which I added this line  my  /etc/lilo.conf file:

image=/boot/vmlinuz-2.4.9-12smp
        label=2.4.9smp
        append="initrd=/boot/initrd-2.4.9-12smp.img root=/dev/ram0
init=/linuxrc rw"

Reran lilo

[root@tinkerbell /root]# lilo -v

LILO version 21.4-4, Copyright (C) 1992-1998 Werner Almesberger
'lba32' extensions Copyright (C) 1999,2000 John Coffman

Reading boot sector from /dev/sda
Merging with /boot/boot.b
Mapping message file /boot/message
Boot image: /boot/vmlinuz-2.4.2-2smp
Mapping RAM disk /boot/initrd-2.4.2-2smp.img
Added linux
Boot image: /boot/vmlinuz-2.4.2-2
Mapping RAM disk /boot/initrd-2.4.2-2.img
Added linux-up *
Boot image: /boot/vmlinuz-2.4.9-12smp    ## Entry for SMP kernel
Added 2.4.9smp
Boot image: /boot/vmlinuz-2.4.9-12-smp-4th
Added custom
/boot/boot.0800 exists - no backup copy made.
Writing boot sector.


Now for the real fun part, when I reboot I get the following error:

"VFS: Cannot open root device "ram0" or 01:00
Please append a correct "root=" boot option
Kernel panic: VFS:  unable to mount root fs on 01:00 "

I have tried other approaches but to no avail. I decided that I seek
assistance from you
hoping that you will be kind and patient enough to help me.

Thanks in advance,
Joy









