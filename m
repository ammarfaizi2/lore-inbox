Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbUBWSOE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 13:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbUBWSOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 13:14:03 -0500
Received: from bay15-f6.bay15.hotmail.com ([65.54.185.6]:47620 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261979AbUBWSNJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 13:13:09 -0500
X-Originating-IP: [142.73.137.116]
X-Originating-Email: [jalyvr@hotmail.com]
From: "John Lloyd" <jalyvr@hotmail.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: NCR53c810 on 2.4.24 reset loops depend on Alpha processor selection
Date: Mon, 23 Feb 2004 10:13:07 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY15-F61RkIZ8eisXb00015828@hotmail.com>
X-OriginalArrivalTime: 23 Feb 2004 18:13:08.0176 (UTC) FILETIME=[B0702D00:01C3FA38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have seen a variety of reports in various archives (alpha linux, 
linux-scsi, etc) of reset loops but no solutions.  The following report 
shows a simple workaround.

If you comment or reply please cc me as well.

Stock kernel 2.4.24 on Alpha Avanti (Alphaserver 400 4/233) fails
to correctly configure SCSI disks on NCR53C810 (builtin SCSI) when
configured with CONFIG_ALPHA_AVANTI=y
but works OK with CONFIG_ALPHA_GENERIC=y.


Disks are completely standard Digital models (legacy, but not yet collector
items).

Base software platform is RH 7.2 Alpha  plus recent HP/Compaq patches.  The
kernel is a standard kernel.org file.  I tried numerous combinations of
ncr53c8xx, sym53c8xx_2, and rebuilds with various scsi parameters on, off,
and so forth.  Eventually someone gave me the hint to try a generic
Alpha kernel.  The following details show good and bad boot results.

$ gcc -v
Reading specs from /usr/lib/gcc-lib/alpha-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.2 2.96-112.7.2)
$ ld -v
GNU ld version 2.11.90.0.8 (with BFD 2.11.90.0.8)


$ /sbin/lspci
00:06.0 Non-VGA unclassified device: LSI Logic / Symbios Logic (formerly
NCR) 53c810 (rev 01)
00:07.0 Non-VGA unclassified device: Intel Corporation 82378IB [SIO ISA
Bridge] (rev 03)
00:0b.0 Ethernet controller: Digital Equipment Corporation DECchip 21040
[Tulip] (rev 23)
00:0c.0 FDDI network controller: Digital Equipment Corporation DEFPA
00:0d.0 SCSI storage controller: Digital Equipment Corporation KZPSA [KZPSA]

(nothing is connected to fddi card or KZPSA)

$ /sbin/lspci -vvv
00:06.0 Non-VGA unclassified device: LSI Logic / Symbios Logic (formerly
NCR) 53c810 (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 9000 [size=256]
        Region 1: Memory at 0000000001321000 (32-bit, non-prefetchable)
[size=256]

Bad boot is

....(snip)...
Freeing initrd memory: 671k freed
VFS: Mounted root (ext2 filesystem).
ncr53c8xx: at PCI bus 0, device 6, function 0
ncr53c8xx: 53c810 detected
ncr53c810-0: rev 0x1 on pci bus 0 device 6 function 0 irq 11
ncr53c810-0: ID 7, Fast-10, Parity Checking
scsi0 : ncr53c8xx-3.4.3b-20010512
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun
0 In
quiry 00 00 00 ff 00
ncr53c8xx_abort: pid=0 serial_number=1 serial_number_at_timeout=1
ncr53c810-0: abort ccb=fffffc0007b04000 (cancel)
SCSI host 0 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
ncr53c8xx_reset: pid=0 reset_flags=2 serial_number=1
serial_number_at_timeout=1
Red Hat nash verSCSI host 0 abort (pid 1) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
ncr53c8xx_reset: pid=1 reset_flags=2 serial_number=2
serial_number_at_timeout=2
sion 3.2.6 startSCSI host 0 abort (pid 2) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
ncr53c8xx_reset: pid=2 reset_flags=2 serial_number=3
serial_number_at_timeout=3
ing
Loading sd_SCSI host 0 abort (pid 3) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
ncr53c8xx_reset: pid=3 reset_flags=2 serial_number=4
serial_number_at_timeout=4
SCSI host 0 abort (pid 4) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
ncr53c8xx_reset: pid=4 reset_flags=2 serial_number=5
serial_number_at_timeout=5
mod module
LoadSCSI host 0 abort (pid 5) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
ncr53c8xx_reset: pid=5 reset_flags=2 serial_number=6
serial_number_at_timeout=6
ing ncr53c8xx mo


Good boot is

....(SNIP)...
Freeing initrd memory: 797k freed
VFS: Mounted root (ext2 filesystem).
Red Hat nash version 3.2.6 starting
Loading scsi_mod module
SCSI subsystem driver Revision: 1.00
Loading sd_mod module
Loading ncr53c8xx module
ncr53c8xx: at PCI bus 0, device 6, function 0
ncr53c8xx: 53c810 detected
ncr53c810-0: rev 0x1 on pci bus 0 device 6 function 0 irq 11
ncr53c810-0: ID 7, Fast-10, Parity Checking
scsi0 : ncr53c8xx-3.4.3b-20010512
  Vendor: DEC       Model: RZ29B    (C) DEC  Rev: 0014
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: DEC       Model: RZ29B    (C) DEC  Rev: 0016
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: DEC       Model: RZ29B    (C) DEC  Rev: 0016
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: DEC       Model: RZ28M    (C) DEC  Rev: 0568
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: DEC       Model: RRD45   (C) DEC   Rev: 1645
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: DEC       Model: RZ29B    (C) DEC  Rev: 0016
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: DEC       Model: RZ29B    (C) DEC  Rev: 0016
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
Attached scsi disk sdd at scsi0, channel 0, id 3, lun 0
Attached scsi disk sde at scsi0, channel 0, id 5, lun 0
Attached scsi disk sdf at scsi0, channel 0, id 6, lun 0
ncr53c810-0-<0,*>: FAST-10 SCSI 10.0 MB/s (100 ns, offset 8)
SCSI device sda: 8380080 512-byte hdwr sectors (4291 MB)
Partition check:
sda: sda1
ncr53c810-0-<1,*>: FAST-10 SCSI 10.0 MB/s (100 ns, offset 8)
SCSI device sdb: 8380080 512-byte hdwr sectors (4291 MB)
sdb: sdb1
ncr53c810-0-<2,*>: FAST-10 SCSI 10.0 MB/s (100 ns, offset 8)
SCSI device sdc: 8380080 512-byte hdwr sectors (4291 MB)
sdc: sdc1 sdc2
ncr53c810-0-<3,*>: FAST-10 SCSI 10.0 MB/s (100 ns, offset 8)
SCSI device sdd: 4110480 512-byte hdwr sectors (2105 MB)
sdd: sdd1 sdd2 sdd3 sdd7 sdd8
ncr53c810-0-<5,*>: FAST-10 SCSI 10.0 MB/s (100 ns, offset 8)
SCSI device sde: 8380080 512-byte hdwr sectors (4291 MB)
sde: unknown partition table
ncr53c810-0-<6,*>: FAST-10 SCSI 10.0 MB/s (100 ns, offset 8)
SCSI device sdf: 8380080 512-byte hdwr sectors (4291 MB)
sdf: sdf1 sdf2 sdf3
Loading sym53c8xx_2 module
sym.0.6.0: IO region 0x9000[0..127] is in use
/lib/sym53c8xx_2.o: init_module: No such device
Hint: insmod errors can be causJournalled Block Device driver loaded
ed by incorrect module parameters, including invalid IO or IRQ parameters.
      You may find more information kjournald starting.  Commit interval 5
secon
ds
in syslog or theEXT3-fs: mounted filesystem with ordered data mode.
output from dmesg
ERROR: /bin/insmod exited abnormally!
Loading jbd module
Loading ext3 module
....(SNIP)...

Actual differences between nonworking and working config files, mostly
due to debugging attempts and deleting unused modules is as follows:

$ diff k2424_1.config k2424_a.config
24c24
< # CONFIG_ALPHA_GENERIC is not set
---
>CONFIG_ALPHA_GENERIC=y
28c28
< CONFIG_ALPHA_AVANTI=y
---
># CONFIG_ALPHA_AVANTI is not set
61,63d60
< CONFIG_ALPHA_EV4=y
< CONFIG_ALPHA_APECS=y
< # CONFIG_ALPHA_SRM is not set
64a62,64
>CONFIG_ALPHA_BROKEN_IRQ_MASK=y
># CONFIG_SMP is not set
>CONFIG_EARLY_PRINTK=y
278c278
< CONFIG_SCSI=y
---
>CONFIG_SCSI=m
295,296c295,296
< # CONFIG_SCSI_DEBUG_QUEUES is not set
< # CONFIG_SCSI_MULTI_LUN is not set
---
>CONFIG_SCSI_DEBUG_QUEUES=y
>CONFIG_SCSI_MULTI_LUN=y
337c337
< # CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
---
>CONFIG_SCSI_SYM53C8XX_IOMAPPED=y
339c339
< CONFIG_SCSI_SYM53C8XX=m
---
># CONFIG_SCSI_SYM53C8XX is not set
342c342
< CONFIG_SCSI_NCR53C8XX_SYNC=40
---
>CONFIG_SCSI_NCR53C8XX_SYNC=20
345d344
< # CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
354c353
< CONFIG_SCSI_QLOGIC_1280=m
---
># CONFIG_SCSI_QLOGIC_1280 is not set
357,358c356
< CONFIG_SCSI_DC390T=m
< # CONFIG_SCSI_DC390T_NOGENSUPP is not set
---
># CONFIG_SCSI_DC390T is not set
564,573c562
< CONFIG_I2C=m
< CONFIG_I2C_ALGOBIT=m
< CONFIG_I2C_ELV=m
< CONFIG_I2C_VELLEMAN=m
< # CONFIG_SCx200_I2C is not set
< # CONFIG_SCx200_ACB is not set
< CONFIG_I2C_ALGOPCF=m
< CONFIG_I2C_ELEKTOR=m
< CONFIG_I2C_CHARDEV=m
< CONFIG_I2C_PROC=m
---
># CONFIG_I2C is not set
586c575
< CONFIG_MK712_MOUSE=m
---
># CONFIG_MK712_MOUSE is not set
612c601
< CONFIG_AMD_PM768=m
---
># CONFIG_AMD_PM768 is not set
615,616c604,605
< CONFIG_DTLK=m
< CONFIG_R3964=m
---
># CONFIG_DTLK is not set
># CONFIG_R3964 is not set
623,632c612
< CONFIG_AGP=m
< CONFIG_AGP_INTEL=y
< CONFIG_AGP_I810=y
< CONFIG_AGP_VIA=y
< CONFIG_AGP_AMD=y
< # CONFIG_AGP_AMD_K8 is not set
< CONFIG_AGP_SIS=y
< CONFIG_AGP_ALI=y
< CONFIG_AGP_SWORKS=y
< # CONFIG_AGP_ATI is not set
---
># CONFIG_AGP is not set
637,651c617
< CONFIG_DRM=y
< # CONFIG_DRM_OLD is not set
<
< #
< # DRM 4.1 drivers
< #
< CONFIG_DRM_NEW=y
< CONFIG_DRM_TDFX=m
< CONFIG_DRM_GAMMA=m
< CONFIG_DRM_R128=m
< CONFIG_DRM_RADEON=m
< # CONFIG_DRM_I810 is not set
< CONFIG_DRM_I830=m
< CONFIG_DRM_MGA=m
< # CONFIG_DRM_SIS is not set
---
># CONFIG_DRM is not set

_________________________________________________________________
Add photos to your e-mail with MSN 8. Get 2 months FREE*.  
http://join.msn.com/?page=features/photos&pgmarket=en-ca&RU=http%3a%2f%2fjoin.msn.com%2f%3fpage%3dmisc%2fspecialoffers%26pgmarket%3den-ca

