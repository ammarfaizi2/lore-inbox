Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262252AbVBVJTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbVBVJTv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 04:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbVBVJTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 04:19:38 -0500
Received: from zigzag.lvk.cs.msu.su ([158.250.17.23]:56499 "EHLO
	zigzag.lvk.cs.msu.su") by vger.kernel.org with ESMTP
	id S262252AbVBVJTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 04:19:23 -0500
From: stas@lvk.cs.msu.su
To: linux-kernel@vger.kernel.org
Subject: kbuild problems
Date: Tue, 22 Feb 2005 12:18:38 +0300
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502221218.38581.stas@lvk.cs.msu.su>
X-Scanner: exiscan *1D3WBi-0006J1-00*nUWK1I6tZzc*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1) I've found out that kbuild works sometimes incorrectly when building 
external modules.

2) When I used the following Makefile:
---------------------------------------------------------------------------------
MDIR = rtms
EXTRA_CFLAGS = -DEXPORT_SYMTAB
CURRENT = $(shell uname -r)
KDIR = /lib/modules/$(CURRENT)/build
PWD = $(shell pwd)
DEST = /lib/modules/$(CURRENT)/kernel/$(MDIR)

obj-m := rtms_core.o
rtms_core-objs := rtms_core_shm.o rtms_core_syscall.o 
rtms_core_task_migration.o rtms_core_schedule.o
rtms_core-objs += rtms_core_console.o rtms_core_lapic.o rtms_core_module.o

default:
 make -C $(KDIR) SUBDIRS=$(PWD) modules

ifneq (,$(findstring 2.4.,$(CURRENT)))
install:
 su -c "cp -v $(TARGET).o $(DEST) && /sbin/depmod -a"
else
install:
 su -c "cp -v $(TARGET).ko $(DEST) && /sbin/depmod -a"
endif

clean:
 -rm -f *.o *.ko .*.cmd .*.flags *.mod.c

-include $(KDIR)/Rules.make
---------------------------------------------------------------------------------
3) The problem: as a result the make tries to LD following .ko files: 
rtms_core.ko, rtms_core_task_migration.ko, rtms_core_module.ko

When I renamed rtms_core_module.c to rtms_core_mod.c and changed 
rtms_core_module.o to rtms_core_mod.o in rtms_core-objs make tries to LD 
following .ko files: rtms_core.ko, rtms_core_task_migration.ko. One problem 
stays.
Renamed rtms_core_task_migration.c to rtms_core_tasks.c & changed 
rtms_core_task_migration.o to rtms_core_tasks.o in rtms_core-objs. Now make 
do LD only rtms_core.ko (as I wished).
So, as I see, kbuild incorrectly works with long file names and with files 
with "module" substring in their name. 
May be it is correct and depends on make utility, but then why thereis no 
description of these problem in Documents/kbuild ???
---------------------------------------------------------------------------------
4) cat /proc/version == Linux version 2.6.9-adeos (stas@zigzag) (gcc version 
3.3.5 (Debian 1:3.3.5-5)) #4 Wed Feb 9 11:32:26 MSK 2005
5) script/ver_linux:
Linux zigzag 2.6.10-1-686-smp #1 SMP Fri Feb 18 17:18:48 MSK 2005 i686 
GNU/Linux

Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15
util-linux             2.12
mount                  2.12
module-init-tools      3.2-pre1
e2fsprogs              1.35
reiserfsprogs          3.6.19
reiser4progs           line
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         usb_storage appletalk ax25 ipx nls_cp866 nls_koi8_r 
smbfs usbnet vmnet vmmon iptable_nat ip_conntrack nfsd exportfs lockd sunrpc 
ipt_REJECT iptable_filter ip_tables ipv6 dc395x usblp uhci_hcd shpchp 
pci_hotplug parport_pc parport floppy pcspkr ehci_hcd usbcore snd_ens1371 
snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm_oss snd_mixer_oss 
snd_pcmsnd_timer snd soundcore snd_page_alloc gameport tg3 firmware_class 
capability commoncap w83627hf eeprom i2c_sensor i2c_isa i2c_i801 i2c_core 
e100 mii 3c59x sg scsi_mod loop ide_cd cdrom ppp_generic slhc mousedev evdev 
rtc tsdev psmouse raid1 md udf reiserfs isofs vfat fat ext2 ext3 jbd mbcache 
ide_generic siimage aec62xx trm290 alim15x3 hpt34x hpt366 ide_disk cmd64x 
piix rz1000 slc90e66 generic cs5530 cs5520 sc1200 triflex atiixp pdc202xx_old 
pdc202xx_new opti621 ns87415 cy82c693 amd74xx sis5513 via82cxxx serverworks 
ide_core unix fbcon font bitblit vesafb cfbcopyarea cfbimgblt cfbfillrect

  With best regards, Stas.
