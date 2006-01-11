Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbWAKPaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWAKPaL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 10:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWAKPaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 10:30:10 -0500
Received: from bay101-f36.bay101.hotmail.com ([64.4.56.46]:50352 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1751467AbWAKPaG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 10:30:06 -0500
Message-ID: <BAY101-F3655E91B89B01BBCEB0B7DDF240@phx.gbl>
X-Originating-IP: [70.150.153.162]
X-Originating-Email: [jtreubig@hotmail.com]
From: "John Treubig" <jtreubig@hotmail.com>
To: albertcc@tw.ibm.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, alan@lxorguk.ukuu.org.uk, dougg@torque.net,
       dwm@maxeymade.com
Subject: Re: Error handling in LibATA
Date: Wed, 11 Jan 2006 09:30:02 -0600
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_32fb_7ff8_23"
X-OriginalArrivalTime: 11 Jan 2006 15:30:04.0137 (UTC) FILETIME=[E4E64D90:01C616C3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_32fb_7ff8_23
Content-Type: text/plain; format=flowed

Thanks all for your recommendations.  I'm in the process of installing your 
patch.  Per your requests I've attached copies of lspci, dmesg and two 
excerpts from the messages file.  The messages from libata.msg are from a 
drive attached to the Promise adapter and ide.msg are from a drive attached 
to the motherboard secondary IDE.  In both cases power was removed during 
testing.

My system is built with 2.6.15 rc5 and I will let you know my results.

Thanks again,
John


From: Albert Lee <albertcc@tw.ibm.com>
To: John Treubig <jtreubig@hotmail.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,        
linux-scsi@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,        
Douglas Gilbert <dougg@torque.net>, Doug Maxey <dwm@maxeymade.com>
Subject: Re: Error handling in LibATA
Date: Wed, 11 Jan 2006 10:07:35 +0800

John Treubig wrote:
 > I've been working on a problem with Promise 20269 PATA adapter under
 > LibATA that if the drive has a write error or time-out, the application
 > that is accessing the drive using SG should see some sort of error.  My
 > first problem was my system hung.  After patching the IDE-IO.C, with a
 > recognized patch, I have been able to keep my system from hanging.  Now
 > the only problem is the application gets no notification that the drive
 > has been rendered inaccessible.  (Test case is to run a system with my
 > app going, and then pull the power from the drive.  System log shows the
 > errors, but nothing gets back to the app).  The app does get
 > notifications if I perform the same type of test on a drive attached to
 > the motherboard secondary IDE adapter, so we know the app is correctly
 > implemented.

As Alan commented, not sure you are using IDE or libata?
Could you send the boot dmesg?

 >
 > I've traced the errors down to the fact that the errors are caught in
 > libata-core.c (ata_qc_timeout).  I'd like to put a call in libata-core.c
 > that would cause an error to be reflected back to the application.  Can
 > you suggest the function or method that would do this?
 >

If you are using libata, maybe the following patch can help.
It checks more bits of drv_stat, so status like 0x00 are returned as error.

Albert

========

--- linux/drivers/scsi/libata-core.c	2006-01-11 09:47:25.000000000 +0800
+++ errmask/drivers/scsi/libata-core.c	2006-01-11 09:51:09.000000000 +0800
@@ -3418,8 +3418,14 @@ static void ata_qc_timeout(struct ata_qu
  		printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x host_stat 
0x%x\n",
  		       ap->id, qc->tf.command, drv_stat, host_stat);

+		/* If drv_stat looks ok (0x50 normally), we treat this
+		 * as lost interrupt and complete the qc as normal.
+		 * If drv_stat looks bad (0x00, 0xff, etc), err_mask is set.
+		 */
+		if (!ata_ok(drv_stat))
+			qc->err_mask |= __ac_err_mask(drv_stat);
+
  		/* complete taskfile transaction */
-		qc->err_mask |= ac_err_mask(drv_stat);
  		ata_qc_complete(qc);
  		break;
  	}


------=_NextPart_000_32fb_7ff8_23
Content-Type: text/plain; name="dmesg.lst"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="dmesg.lst"

2]
[   83.663258]   Vendor: QUANTUM   Model: ATLAS_V_36_SCA    Rev: 0230
[   83.693623]   Type:   Direct-Access                      ANSI SCSI 
revision: 03
[   83.723232] scsi0:A:6:0: Tagged Queuing enabled.  Depth 32
[   83.752504]  target0:0:6: Beginning Domain Validation
[   83.784146]  target0:0:6: wide asynchronous.
[   83.814990]  target0:0:6: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, 
offset 63)
[   83.850013]  target0:0:6: Ending Domain Validation
[   85.929044] QLogic Fibre Channel HBA Driver
[   85.959180] ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
[   85.989095] ACPI: PCI Interrupt 0000:01:09.0[A] -> Link [APC2] -> GSI 17 
(level, high) -> IRQ 18
[   86.019814] qla2100 0000:01:09.0: Found an ISP2100, irq 18, iobase 
0xd0812000
[   86.051618] qla2100 0000:01:09.0: Configuring PCI space...
[   86.082773] qla2100 0000:01:09.0: Configure NVRAM parameters...
[   86.198788] qla2100 0000:01:09.0: Verifying loaded RISC code...
[   86.389629] qla2100 0000:01:09.0: Waiting for LIP to complete...
[  106.824637] qla2100 0000:01:09.0: Cable is unplugged...
[  106.854180] scsi1 : qla2xxx
[  106.883174] qla2100 0000:01:09.0:
[  106.883176]  QLogic Fibre Channel HBA Driver: 8.01.03-k
[  106.883177]   QLogic QLA2100 -
[  106.883178]   ISP2100: PCI (33 MHz) @ 0000:01:09.0 hdma-, host#=1, 
fw=1.19.25 TP
[  106.995711] ide-scsi is deprecated for cd burning! Use ide-cd and give 
dev=/dev/hdX as device
[  107.025030] scsi2 : SCSI host adapter emulation for IDE ATAPI devices
[  107.054474]   Vendor: SONY      Model: DVD-ROM DDU1621   Rev: S3.5
[  107.085123]   Type:   CD-ROM                             ANSI SCSI 
revision: 00
[  107.115040] libata version 1.20 loaded.
[  107.115069] pata_pdc2027x 0000:01:08.0: version 0.73
[  107.115095] ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [APC1] -> GSI 16 
(level, high) -> IRQ 16
[  107.145712] pdc_read_counter: bccrh [7C0C] bccrl [4EAC]
[  107.176133] pdc_read_counter: bccrhv[7C0C] bccrlv[4EAC]
[  107.206009] pdc_detect_pll_input_clock: scr[40E20]
[  107.335896] pdc_read_counter: bccrh [7BD9] bccrl [4B29]
[  107.365986] pdc_read_counter: bccrhv[7BD9] bccrlv[4B03]
[  107.395555] pdc_detect_pll_input_clock: scr[44E20]
[  107.425430] pdc_detect_pll_input_clock: start[1040600748] end[1038928681]
[  107.455439] pdc_detect_pll_input_clock: PLL input clock[16720670]Hz
[  107.485030] pata_pdc2027x 0000:01:08.0: PLL input clock 16720 kHz
[  107.514313] pdc_adjust_pll: pout_required is 133333333
[  107.543769] pdc_adjust_pll: pll_ctl[D58]
[  107.572779] pdc_adjust_pll: F[117] R[13] ratio*1000[7974]
[  107.601584] pdc_adjust_pll: Writing pll_ctl[D75]
[  107.659622] pdc_adjust_pll: pll_ctl[D75]
[  107.687195] ata1: PATA max UDMA/133 cmd 0xD08197C0 ctl 0xD0819FDA bmdma 
0xD0819000 irq 16
[  107.715716] ata2: PATA max UDMA/133 cmd 0xD08195C0 ctl 0xD0819DDA bmdma 
0xD0819008 irq 16
[  107.743696] pdc2027x_cbl_detect: No cable or 80-conductor cable on port 0
[  107.925611] ata1: dev 0 cfg 49:2f00 82:7c6b 83:5908 84:4003 85:7c68 
86:1808 87:4003 88:203f
[  107.925616] ata1: dev 0 ATA-5, max UDMA/100, 78138047 sectors: LBA
[  107.953637] pdc2027x_set_piomode: adev->pio_mode[C]
[  107.981328] pdc2027x_set_piomode: Set pio regs...
[  108.008659] pdc2027x_set_piomode: Set pio regs done
[  108.035730] pdc2027x_set_piomode: Set to pio mode[4]
[  108.062383] pdc2027x_set_dmamode: Set udma regs...
[  108.088602] pdc2027x_set_dmamode: Set udma regs done
[  108.114390] pdc2027x_set_dmamode: Set to udma mode[5]
[  108.139914] ata1: dev 0 configured for UDMA/100
[  108.165065] pdc2027x_set_piomode: adev->pio_mode[C]
[  108.189727] pdc2027x_set_piomode: Set pio regs...
[  108.214078] pdc2027x_set_piomode: Set pio regs done
[  108.238252] pdc2027x_set_piomode: Set to pio mode[4]
[  108.262290] pdc2027x_set_dmamode: Set udma regs...
[  108.286127] pdc2027x_set_dmamode: Set udma regs done
[  108.309627] pdc2027x_set_dmamode: Set to udma mode[5]
[  108.332827] scsi3 : pata_pdc2027x
[  108.356034] pdc2027x_cbl_detect: No cable or 80-conductor cable on port 1
[  108.533714] ata2: dev 0 cfg 49:2f00 82:7c6b 83:5908 84:4003 85:7c68 
86:1808 87:4003 88:203f
[  108.533718] ata2: dev 0 ATA-5, max UDMA/100, 78138047 sectors: LBA
[  108.557857] pdc2027x_set_piomode: adev->pio_mode[C]
[  108.581737] pdc2027x_set_piomode: Set pio regs...
[  108.604756] pdc2027x_set_piomode: Set pio regs done
[  108.626812] pdc2027x_set_piomode: Set to pio mode[4]
[  108.648369] pdc2027x_set_dmamode: Set udma regs...
[  108.669440] pdc2027x_set_dmamode: Set udma regs done
[  108.689588] pdc2027x_set_dmamode: Set to udma mode[5]
[  108.709034] ata2: dev 0 configured for UDMA/100
[  108.728816] pdc2027x_set_piomode: adev->pio_mode[C]
[  108.748650] pdc2027x_set_piomode: Set pio regs...
[  108.768166] pdc2027x_set_piomode: Set pio regs done
[  108.787718] pdc2027x_set_piomode: Set to pio mode[4]
[  108.806971] pdc2027x_set_dmamode: Set udma regs...
[  108.826025] pdc2027x_set_dmamode: Set udma regs done
[  108.844753] pdc2027x_set_dmamode: Set to udma mode[5]
[  108.863292] scsi4 : pata_pdc2027x
[  108.881456]   Vendor: ATA       Model: TOSHIBA MK4019GA  Rev: FA00
[  108.901202]   Type:   Direct-Access                      ANSI SCSI 
revision: 05
[  108.920821]   Vendor: ATA       Model: TOSHIBA MK4019GA  Rev: FA00
[  108.941362]   Type:   Direct-Access                      ANSI SCSI 
revision: 05
[  108.961849] sata_sil 0000:01:0d.0: version 0.9
[  108.962127] ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
[  108.982044] ACPI: PCI Interrupt 0000:01:0d.0[A] -> Link [APC3] -> GSI 18 
(level, high) -> IRQ 19
[  109.003226] ata3: SATA max UDMA/100 cmd 0xD0814080 ctl 0xD081408A bmdma 
0xD0814000 irq 19
[  109.024300] ata4: SATA max UDMA/100 cmd 0xD08140C0 ctl 0xD08140CA bmdma 
0xD0814008 irq 19
[  109.245206] ata3: no device found (phy stat 00000000)
[  109.265239] scsi5 : sata_sil
[  109.485852] ata4: no device found (phy stat 00000000)
[  109.506541] scsi6 : sata_sil
[  109.527527] SCSI device sda: 71722776 512-byte hdwr sectors (36722 MB)
[  109.550870] SCSI device sda: drive cache: write back
[  109.573089] SCSI device sda: 71722776 512-byte hdwr sectors (36722 MB)
[  109.597148] SCSI device sda: drive cache: write back
[  109.619372]  sda: sda1
[  109.646249] sd 0:0:6:0: Attached scsi disk sda
[  109.668543] SCSI device sdb: 78138047 512-byte hdwr sectors (40007 MB)
[  109.691779] SCSI device sdb: drive cache: write back
[  109.715136] SCSI device sdb: 78138047 512-byte hdwr sectors (40007 MB)
[  109.739026] SCSI device sdb: drive cache: write back
[  109.763099]  sdb: unknown partition table
[  110.192913] sd 3:0:0:0: Attached scsi disk sdb
[  110.217257] SCSI device sdc: 78138047 512-byte hdwr sectors (40007 MB)
[  110.241917] SCSI device sdc: drive cache: write back
[  110.266095] SCSI device sdc: 78138047 512-byte hdwr sectors (40007 MB)
[  110.290320] SCSI device sdc: drive cache: write back
[  110.314615]  sdc: unknown partition table
[  110.735423] sd 4:0:0:0: Attached scsi disk sdc
[  110.761934] sr0: scsi-1 drive
[  110.786785] Uniform CD-ROM driver Revision: 3.20
[  110.812325] sr 2:0:0:0: Attached scsi CD-ROM sr0
[  110.812375] sd 0:0:6:0: Attached scsi generic sg0 type 0
[  110.838398] sr 2:0:0:0: Attached scsi generic sg1 type 5
[  110.863943] sd 3:0:0:0: Attached scsi generic sg2 type 0
[  110.889018] sd 4:0:0:0: Attached scsi generic sg3 type 0
[  110.913901] Fusion MPT base driver 3.03.04
[  110.939094] Copyright (c) 1999-2005 LSI Logic Corporation
[  110.964930] Fusion MPT SPI Host driver 3.03.04
[  110.990995] Fusion MPT FC Host driver 3.03.04
[  111.017272] Fusion MPT SAS Host driver 3.03.04
[  111.043721] Fusion MPT misc device (ioctl) driver 3.03.04
[  111.070265] mptctl: Registered with Fusion MPT base driver
[  111.096748] mptctl: /dev/mptctl @ (major,minor=10,220)
[  111.123378] ACPI: PCI Interrupt Link [APCL] enabled at IRQ 22
[  111.149497] ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [APCL] -> GSI 22 
(level, high) -> IRQ 20
[  111.176162] PCI: Setting latency timer of device 0000:00:02.2 to 64
[  111.176166] ehci_hcd 0000:00:02.2: EHCI Host Controller
[  111.202437] ehci_hcd 0000:00:02.2: debug port 1
[  111.228108] PCI: cache line size of 64 is not supported by device 
0000:00:02.2
[  111.228176] ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus 
number 1
[  111.253828] ehci_hcd 0000:00:02.2: irq 20, io mem 0xe0005000
[  111.279692] ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI 1.00, driver 10 
Dec 2004
[  111.305574] hub 1-0:1.0: USB hub found
[  111.331144] hub 1-0:1.0: 6 ports detected
[  111.457015] ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) 
Driver (PCI)
[  111.457385] ACPI: PCI Interrupt Link [APCF] enabled at IRQ 21
[  111.483036] ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 21 
(level, high) -> IRQ 21
[  111.509288] PCI: Setting latency timer of device 0000:00:02.0 to 64
[  111.509292] ohci_hcd 0000:00:02.0: OHCI Host Controller
[  111.535459] ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus 
number 2
[  111.561942] ohci_hcd 0000:00:02.0: irq 21, io mem 0xe0003000
[  111.640767] hub 2-0:1.0: USB hub found
[  111.666793] hub 2-0:1.0: 3 ports detected
[  111.793837] ACPI: PCI Interrupt Link [APCG] enabled at IRQ 20
[  111.819872] ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCG] -> GSI 20 
(level, high) -> IRQ 22
[  111.846675] PCI: Setting latency timer of device 0000:00:02.1 to 64
[  111.846679] ohci_hcd 0000:00:02.1: OHCI Host Controller
[  111.873370] ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus 
number 3
[  111.900363] ohci_hcd 0000:00:02.1: irq 22, io mem 0xe0004000
[  111.979275] hub 3-0:1.0: USB hub found
[  112.005868] hub 3-0:1.0: 3 ports detected
[  112.132012] USB Universal Host Controller Interface driver v2.3
[  112.158640] usbcore: registered new driver usblp
[  112.185112] drivers/usb/class/usblp.c: v0.13: USB Printer Device Class 
driver
[  112.212250] Initializing USB Mass Storage driver...
[  112.239366] usbcore: registered new driver usb-storage
[  112.266587] USB Mass Storage support registered.
[  112.293881] usbcore: registered new driver usbhid
[  112.321152] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[  112.348806] mice: PS/2 mouse device common for all mice
[  112.377304] NET: Registered protocol family 2
[  112.415600] IP route cache hash table entries: 4096 (order: 2, 16384 
bytes)
[  112.445300] TCP established hash table entries: 16384 (order: 4, 65536 
bytes)
[  112.475243] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
[  112.505240] TCP: Hash tables configured (established 16384 bind 16384)
[  112.535207] TCP reno registered
[  112.565063] ip_conntrack version 2.4 (2047 buckets, 16376 max) - 212 
bytes per conntrack
[  112.599075] input: AT Translated Set 2 keyboard as /class/input/input0
[  112.651226] ip_tables: (C) 2000-2002 Netfilter core team
[  112.724125] ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  
http://snowman.net/projects/ipt_recent/
[  112.757014] arp_tables: (C) 2002 David S. Miller
[  112.797983] TCP bic registered
[  112.830080] NET: Registered protocol family 1
[  112.861606] NET: Registered protocol family 17
[  112.893038] Using IPI Shortcut mode
[  113.142763] input: ImPS/2 Generic Wheel Mouse as /class/input/input1
[  113.357453] VFS: Mounted root (ext2 filesystem) readonly.
[  113.389424] Freeing unused kernel memory: 216k freed
[  118.126148] Adding 1188800k swap on /dev/hda3.  Priority:-1 extents:1 
across:1188800k
[  118.496429] radDIO: module license 'unspecified' taints kernel.
[  118.503675] RAD-DIO driver for NuDAQ PCI-7224 V1.0
[  118.503680] Developed for Miltope Corp. by Radical Systems, Inc.
[  118.503683] http://www.radicalsystems.com
[  118.503685] Copyright (c) 2004, Radical Systems, Inc.
[  118.503687] All rights reserved.
[  118.510418] Probing...
[  118.510438] ACPI: PCI Interrupt 0000:01:06.0[A] -> Link [APC3] -> GSI 18 
(level, high) -> IRQ 19
[  118.510449] Found Device:
[  118.510451] Name:     0000:01:06.0
[  118.510453] InitFlag: 0x7248
[  118.510454] BusNo:    0x1
[  118.510456] DevFunc:  0x30
[  118.510457] LCRBase:  0x7000
[  118.510459] BaseAddr: 0x7400
[  118.510460] IRQ No:   0x5
[  118.546317] sata_promise 0000:01:0a.0: version 1.03
[  118.546347] ACPI: PCI Interrupt 0000:01:0a.0[A] -> Link [APC3] -> GSI 18 
(level, high) -> IRQ 19
[  118.556548] ata5: SATA max UDMA/133 cmd 0xD086A200 ctl 0xD086A238 bmdma 
0x0 irq 19
[  118.556570] ata6: SATA max UDMA/133 cmd 0xD086A280 ctl 0xD086A2B8 bmdma 
0x0 irq 19
[  118.556592] ata7: SATA max UDMA/133 cmd 0xD086A300 ctl 0xD086A338 bmdma 
0x0 irq 19
[  118.556615] ata8: SATA max UDMA/133 cmd 0xD086A380 ctl 0xD086A3B8 bmdma 
0x0 irq 19
[  118.757215] ata5: no device found (phy stat 00000000)
[  118.757218] scsi7 : sata_promise
[  119.223900] ata6: dev 0 cfg 49:2f00 82:346b 83:5b01 84:4003 85:3469 
86:1801 87:4003 88:407f
[  119.223907] ata6: dev 0 ATA-6, max UDMA/133, 234441648 sectors: LBA
[  119.223910] ata6(0): applying bridge limits
[  119.224051] ata6: dev 0 configured for UDMA/100
[  119.224053] scsi8 : sata_promise
[  119.431226] ata7: no device found (phy stat 00000000)
[  119.431231] scsi9 : sata_promise
[  119.638920] ata8: no device found (phy stat 00000000)
[  119.638924] scsi10 : sata_promise
[  119.645749]   Vendor: ATA       Model: ST3120023AS       Rev: 3.01
[  119.645759]   Type:   Direct-Access                      ANSI SCSI 
revision: 05
[  119.652577] SCSI device sdd: 234441648 512-byte hdwr sectors (120034 MB)
[  119.652595] SCSI device sdd: drive cache: write back
[  119.659443] SCSI device sdd: 234441648 512-byte hdwr sectors (120034 MB)
[  119.659462] SCSI device sdd: drive cache: write back
[  119.659466]  sdd: unknown partition table
[  119.669510] sd 8:0:0:0: Attached scsi disk sdd
[  119.683412] sd 8:0:0:0: Attached scsi generic sg4 type 0
[  120.145106] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  120.145321] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  120.145640] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  120.145860] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  120.201181] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  120.201220] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  120.201257] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  120.201283] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  120.234792] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  120.234832] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  120.234872] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  120.234898] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  120.267531] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  120.267570] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  120.267609] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  120.267635] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  120.886329] kjournald starting.  Commit interval 5 seconds
[  120.886407] EXT3 FS on hda1, internal journal
[  120.886413] EXT3-fs: mounted filesystem with ordered data mode.
[  132.686372] r8169: eth0: link up


------=_NextPart_000_32fb_7ff8_23
Content-Type: text/plain; name="pci.lst"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="pci.lst"

00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) 
(rev c1)
00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio 
Controler (MCP) (rev a1)
00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3)
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
01:06.0 DPIO module: Adlink Technology: Unknown device 7248 (rev 02)
01:07.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
01:08.0 Unknown mass storage controller: Promise Technology, Inc. 20269 (rev 
02)
01:09.0 SCSI storage controller: QLogic Corp. QLA2100 64-bit Fibre Channel 
Adapter (rev 03)
01:0a.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown 
device 3d17 (rev 02)
01:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 (rev 
10)
01:0d.0 Unknown mass storage controller: CMD Technology Inc: Unknown device 
3512 (rev 01)
02:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0185 
(rev a4)


------=_NextPart_000_32fb_7ff8_23
Content-Type: application/octet-stream; name="ide.msg"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ide.msg"

SmFuICA5IDExOjMzOjEzIGpkcmFkZXItMDAwNTcga2VybmVsOiBbICAyNjYu
MjY0NTAwXSBhdGFfc2NzaV9kdW1wX2NkYjogQ0RCICg2OjAsMCwwKSAxMiAw
MCAwMCAwMCA2MCAwMCAyMyBjZCAwMApKYW4gIDkgMTE6MzM6MTMgamRyYWRl
ci0wMDA1NyBrZXJuZWw6IFsgIDI2Ni4yNjQ1MDRdIGF0YV9zY3Npb3BfaW5x
X3N0ZDogRU5URVIKSmFuICA5IDExOjMzOjEzIGpkcmFkZXItMDAwNTcga2Vy
bmVsOiBbICAyNjYuMjY0NTYyXSBhdGFfc2NzaV9kdW1wX2NkYjogQ0RCICg2
OjAsMCwwKSAxMiAwMSAwMCAwMCBmYyAwMCAyMyBjZCA1OApKYW4gIDkgMTE6
MzM6MTMgamRyYWRlci0wMDA1NyBrZXJuZWw6IFsgIDI2Ni4yNjQ2ODBdIGF0
YV9zY3NpX2R1bXBfY2RiOiBDREIgKDY6MCwwLDApIDEyIDAxIDgwIDAwIGZj
IDAwIDIzIGNkIDU4CkphbiAgOSAxMTozMzoxMyBqZHJhZGVyLTAwMDU3IGtl
cm5lbDogWyAgMjY2LjI2NDcyNF0gYXRhX3Njc2lfZHVtcF9jZGI6IENEQiAo
NjowLDAsMCkgMjUgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKSmFuICA5IDEx
OjMzOjEzIGpkcmFkZXItMDAwNTcga2VybmVsOiBbICAyNjYuMjY0NzI4XSBh
dGFfc2NzaW9wX3JlYWRfY2FwOiBFTlRFUgpKYW4gIDkgMTE6MzM6MTMgamRy
YWRlci0wMDA1NyBrZXJuZWw6IFsgIDI2Ni4yODM1MzZdIGF0YV9zY3NpX2R1
bXBfY2RiOiBDREIgKDE6MCwwLDApIDEyIDAwIDAwIDAwIDYwIDAwIDIzIGNk
IDAwCkphbiAgOSAxMTozMzoxMyBqZHJhZGVyLTAwMDU3IGtlcm5lbDogWyAg
MjY2LjI4MzU0Ml0gYXRhX3Njc2lvcF9pbnFfc3RkOiBFTlRFUgpKYW4gIDkg
MTE6MzM6MTMgamRyYWRlci0wMDA1NyBrZXJuZWw6IFsgIDI2Ni4yODM3NTZd
IGF0YV9zY3NpX2R1bXBfY2RiOiBDREIgKDE6MCwwLDApIDEyIDAxIDAwIDAw
IGZjIDAwIDIzIGNkIDU4CkphbiAgOSAxMTozMzoxMyBqZHJhZGVyLTAwMDU3
IGtlcm5lbDogWyAgMjY2LjI4Mzg2OV0gYXRhX3Njc2lfZHVtcF9jZGI6IENE
QiAoMTowLDAsMCkgMTIgMDEgODAgMDAgZmMgMDAgMjMgY2QgNTgKSmFuICA5
IDExOjMzOjEzIGpkcmFkZXItMDAwNTcga2VybmVsOiBbICAyNjYuMjgzOTE1
XSBhdGFfc2NzaV9kdW1wX2NkYjogQ0RCICgxOjAsMCwwKSAyNSAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMApKYW4gIDkgMTE6MzM6MTMgamRyYWRlci0wMDA1
NyBrZXJuZWw6IFsgIDI2Ni4yODM5MTldIGF0YV9zY3Npb3BfcmVhZF9jYXA6
IEVOVEVSCkphbiAgOSAxMTozMzoxMyBqZHJhZGVyLTAwMDU3IGtlcm5lbDog
WyAgMjY2LjI4Mzk5MV0gYXRhX3Njc2lfZHVtcF9jZGI6IENEQiAoNjowLDAs
MCkgMTIgMDAgMDAgMDAgNjAgMDAgMjMgY2QgMDAKSmFuICA5IDExOjMzOjEz
IGpkcmFkZXItMDAwNTcga2VybmVsOiBbICAyNjYuMjgzOTk1XSBhdGFfc2Nz
aW9wX2lucV9zdGQ6IEVOVEVSCkphbiAgOSAxMTozMzoxMyBqZHJhZGVyLTAw
MDU3IGtlcm5lbDogWyAgMjY2LjI4NDA3NV0gYXRhX3Njc2lfZHVtcF9jZGI6
IENEQiAoNjowLDAsMCkgMTIgMDEgMDAgMDAgZmMgMDAgMjMgY2QgNTgKSmFu
ICA5IDExOjMzOjEzIGpkcmFkZXItMDAwNTcga2VybmVsOiBbICAyNjYuMjg0
MTUwXSBhdGFfc2NzaV9kdW1wX2NkYjogQ0RCICg2OjAsMCwwKSAxMiAwMSA4
MCAwMCBmYyAwMCAyMyBjZCA1OApKYW4gIDkgMTE6MzM6MTMgamRyYWRlci0w
MDA1NyBrZXJuZWw6IFsgIDI2Ni4yODQxOTRdIGF0YV9zY3NpX2R1bXBfY2Ri
OiBDREIgKDY6MCwwLDApIDI1IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwCkph
biAgOSAxMTozMzoxMyBqZHJhZGVyLTAwMDU3IGtlcm5lbDogWyAgMjY2LjI4
NDE5N10gYXRhX3Njc2lvcF9yZWFkX2NhcDogRU5URVIKSmFuICA5IDExOjMz
OjEzIGpkcmFkZXItMDAwNTcga2VybmVsOiBbICAyNjYuMzAzMDk0XSBhdGFf
c2NzaV9kdW1wX2NkYjogQ0RCICgxOjAsMCwwKSAxMiAwMCAwMCAwMCA2MCAw
MCAyNSBjZCAwMApKYW4gIDkgMTE6MzM6MTMgamRyYWRlci0wMDA1NyBrZXJu
ZWw6IFsgIDI2Ni4zMDMxMDFdIGF0YV9zY3Npb3BfaW5xX3N0ZDogRU5URVIK
SmFuICA5IDExOjMzOjEzIGpkcmFkZXItMDAwNTcga2VybmVsOiBbICAyNjYu
MzAzMzE4XSBhdGFfc2NzaV9kdW1wX2NkYjogQ0RCICgxOjAsMCwwKSAxMiAw
MSAwMCAwMCBmYyAwMCAyNSBjZCA1OApKYW4gIDkgMTE6MzM6MTMgamRyYWRl
ci0wMDA1NyBrZXJuZWw6IFsgIDI2Ni4zMDM0MzFdIGF0YV9zY3NpX2R1bXBf
Y2RiOiBDREIgKDE6MCwwLDApIDEyIDAxIDgwIDAwIGZjIDAwIDI1IGNkIDU4
CkphbiAgOSAxMTozMzoxMyBqZHJhZGVyLTAwMDU3IGtlcm5lbDogWyAgMjY2
LjMwMzQ3Nl0gYXRhX3Njc2lfZHVtcF9jZGI6IENEQiAoMTowLDAsMCkgMjUg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKSmFuICA5IDExOjMzOjEzIGpkcmFk
ZXItMDAwNTcga2VybmVsOiBbICAyNjYuMzAzNDgwXSBhdGFfc2NzaW9wX3Jl
YWRfY2FwOiBFTlRFUgpKYW4gIDkgMTE6MzM6MTMgamRyYWRlci0wMDA1NyBr
ZXJuZWw6IFsgIDI2Ni4zMDM1NzBdIGF0YV9zY3NpX2R1bXBfY2RiOiBDREIg
KDY6MCwwLDApIDEyIDAwIDAwIDAwIDYwIDAwIDI5IGNkIDAwCkphbiAgOSAx
MTozMzoxMyBqZHJhZGVyLTAwMDU3IGtlcm5lbDogWyAgMjY2LjMwMzU3NF0g
YXRhX3Njc2lvcF9pbnFfc3RkOiBFTlRFUgpKYW4gIDkgMTE6MzM6MTMgamRy
YWRlci0wMDA1NyBrZXJuZWw6IFsgIDI2Ni4zMDM2NTVdIGF0YV9zY3NpX2R1
bXBfY2RiOiBDREIgKDY6MCwwLDApIDEyIDAxIDAwIDAwIGZjIDAwIDI5IGNk
IDU4CkphbiAgOSAxMTozMzoxMyBqZHJhZGVyLTAwMDU3IGtlcm5lbDogWyAg
MjY2LjMwMzcyOV0gYXRhX3Njc2lfZHVtcF9jZGI6IENEQiAoNjowLDAsMCkg
MTIgMDEgODAgMDAgZmMgMDAgMjkgY2QgNTgKSmFuICA5IDExOjMzOjEzIGpk
cmFkZXItMDAwNTcga2VybmVsOiBbICAyNjYuMzAzNzczXSBhdGFfc2NzaV9k
dW1wX2NkYjogQ0RCICg2OjAsMCwwKSAyNSAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMApKYW4gIDkgMTE6MzM6MTMgamRyYWRlci0wMDA1NyBrZXJuZWw6IFsg
IDI2Ni4zMDM3NzZdIGF0YV9zY3Npb3BfcmVhZF9jYXA6IEVOVEVSCkphbiAg
OSAxMTozMzoxMyBqZHJhZGVyLTAwMDU3IGtlcm5lbDogWyAgMjY2LjMyMjU4
Ml0gYXRhX3Njc2lfZHVtcF9jZGI6IENEQiAoMTowLDAsMCkgMTIgMDAgMDAg
MDAgNjAgMDAgMjkgY2QgMDAKSmFuICA5IDExOjMzOjEzIGpkcmFkZXItMDAw
NTcga2VybmVsOiBbICAyNjYuMzIyNTg4XSBhdGFfc2NzaW9wX2lucV9zdGQ6
IEVOVEVSCkphbiAgOSAxMTozMzoxMyBqZHJhZGVyLTAwMDU3IGtlcm5lbDog
WyAgMjY2LjMyMjgwNl0gYXRhX3Njc2lfZHVtcF9jZGI6IENEQiAoMTowLDAs
MCkgMTIgMDEgMDAgMDAgZmMgMDAgMjkgY2QgNTgKSmFuICA5IDExOjMzOjEz
IGpkcmFkZXItMDAwNTcga2VybmVsOiBbICAyNjYuMzIyOTIwXSBhdGFfc2Nz
aV9kdW1wX2NkYjogQ0RCICgxOjAsMCwwKSAxMiAwMSA4MCAwMCBmYyAwMCAy
OSBjZCA1OApKYW4gIDkgMTE6MzM6MTMgamRyYWRlci0wMDA1NyBrZXJuZWw6
IFsgIDI2Ni4zMjI5NjVdIGF0YV9zY3NpX2R1bXBfY2RiOiBDREIgKDE6MCww
LDApIDI1IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwCkphbiAgOSAxMTozMzox
MyBqZHJhZGVyLTAwMDU3IGtlcm5lbDogWyAgMjY2LjMyMjk2OV0gYXRhX3Nj
c2lvcF9yZWFkX2NhcDogRU5URVIKSmFuICA5IDExOjMzOjEzIGpkcmFkZXIt
MDAwNTcga2VybmVsOiBbICAyNjYuMzIzMDQyXSBhdGFfc2NzaV9kdW1wX2Nk
YjogQ0RCICg2OjAsMCwwKSAxMiAwMCAwMCAwMCA2MCAwMCAxZiBjZCAwMApK
YW4gIDkgMTE6MzM6MTMgamRyYWRlci0wMDA1NyBrZXJuZWw6IFsgIDI2Ni4z
MjMwNDZdIGF0YV9zY3Npb3BfaW5xX3N0ZDogRU5URVIKSmFuICA5IDExOjMz
OjEzIGpkcmFkZXItMDAwNTcga2VybmVsOiBbICAyNjYuMzIzMDg0XSBhdGFf
c2NzaV9kdW1wX2NkYjogQ0RCICg2OjAsMCwwKSAxMiAwMSAwMCAwMCBmYyAw
MCAxZiBjZCA1OApKYW4gIDkgMTE6MzM6MTMgamRyYWRlci0wMDA1NyBrZXJu
ZWw6IFsgIDI2Ni4zMjMxNTZdIGF0YV9zY3NpX2R1bXBfY2RiOiBDREIgKDY6
MCwwLDApIDEyIDAxIDgwIDAwIGZjIDAwIDFmIGNkIDU4CkphbiAgOSAxMToz
MzoxMyBqZHJhZGVyLTAwMDU3IGtlcm5lbDogWyAgMjY2LjMyMzI0Nl0gYXRh
X3Njc2lfZHVtcF9jZGI6IENEQiAoNjowLDAsMCkgMjUgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAKSmFuICA5IDExOjMzOjEzIGpkcmFkZXItMDAwNTcga2Vy
bmVsOiBbICAyNjYuMzIzMjUwXSBhdGFfc2NzaW9wX3JlYWRfY2FwOiBFTlRF
UgpKYW4gIDkgMTE6MzM6MTQgamRyYWRlci0wMDA1NyBrZXJuZWw6IFsgIDI2
Ny40Nzc3NDldIHJhZGRpbzogcmFkZGlvX29wZW4oKSAtIGZpbGUtPmZfbW9k
ZT0xNQpKYW4gIDkgMTE6MzM6NDUgamRyYWRlci0wMDA1NyBrZXJuZWw6IFsg
IDI5OS4xMDcyNDFdIGhkYzogZG1hX3RpbWVyX2V4cGlyeTogZG1hIHN0YXR1
cyA9PSAweDYxCkphbiAgOSAxMTozMzo1NSBqZHJhZGVyLTAwMDU3IGtlcm5l
bDogWyAgMzA5LjA5MjU1Ml0gaGRjOiBETUEgdGltZW91dCBlcnJvcgpKYW4g
IDkgMTE6MzM6NTUgamRyYWRlci0wMDA1NyBrZXJuZWw6IFsgIDMwOS4wOTI1
NjJdIGhkYzogZG1hIHRpbWVvdXQgZXJyb3I6IHN0YXR1cz0weDdmIHsgRHJp
dmVSZWFkeSBEZXZpY2VGYXVsdCBTZWVrQ29tcGxldGUgRGF0YVJlcXVlc3Qg
Q29ycmVjdGVkRXJyb3IgSW5kZXggRXJyb3IgfQpKYW4gIDkgMTE6MzM6NTUg
amRyYWRlci0wMDA1NyBrZXJuZWw6IFsgIDMwOS4wOTI1NjldIGhkYzogZG1h
IHRpbWVvdXQgZXJyb3I6IGVycm9yPTB4N2YgeyBEcml2ZVN0YXR1c0Vycm9y
IFVuY29ycmVjdGFibGVFcnJvciBTZWN0b3JJZE5vdEZvdW5kIFRyYWNrWmVy
b05vdEZvdW5kIEFkZHJNYXJrTm90Rm91bmQgfSwgTEJBc2VjdD0yNjAwMTM5
NTEsIHNlY3Rvcj01ODQyMjkwNApKYW4gIDkgMTE6MzM6NTUgamRyYWRlci0w
MDA1NyBrZXJuZWw6IFsgIDMwOS4wOTI1ODBdIGlkZTogZmFpbGVkIG9wY29k
ZSB3YXM6IHVua25vd24KSmFuICA5IDExOjMzOjU1IGpkcmFkZXItMDAwNTcg
a2VybmVsOiBbICAzMDkuMDk0NTM3XSBoZGM6IERNQSBkaXNhYmxlZApKYW4g
IDkgMTE6MzM6NTYgamRyYWRlci0wMDA1NyBrZXJuZWw6IFsgIDMwOS4xNDI0
NzddIGlkZTE6IHJlc2V0OiBtYXN0ZXI6IGVycm9yICgweDBhPykKSmFuICA5
IDExOjM0OjI2IGpkcmFkZXItMDAwNTcga2VybmVsOiBbICAzMzkuMDk4NDE1
XSBoZGM6IGxvc3QgaW50ZXJydXB0CkphbiAgOSAxMTozNDoyNiBqZHJhZGVy
LTAwMDU3IGtlcm5lbDogWyAgMzM5LjA5ODQyM10gaGRjOiBzZXRfZ2VvbWV0
cnlfaW50cjogc3RhdHVzPTB4N2YgeyBEcml2ZVJlYWR5IERldmljZUZhdWx0
IFNlZWtDb21wbGV0ZSBEYXRhUmVxdWVzdCBDb3JyZWN0ZWRFcnJvciBJbmRl
eCBFcnJvciB9CkphbiAgOSAxMTozNDoyNiBqZHJhZGVyLTAwMDU3IGtlcm5l
bDogWyAgMzM5LjA5ODQzMF0gaGRjOiBzZXRfZ2VvbWV0cnlfaW50cjogZXJy
b3I9MHg3ZiB7IERyaXZlU3RhdHVzRXJyb3IgVW5jb3JyZWN0YWJsZUVycm9y
IFNlY3RvcklkTm90Rm91bmQgVHJhY2taZXJvTm90Rm91bmQgQWRkck1hcmtO
b3RGb3VuZCB9LCBMQkFzZWN0PTI2MDAxMzk1MSwgc2VjdG9yPTU4NDIyOTA0
CkphbiAgOSAxMTozNDoyNiBqZHJhZGVyLTAwMDU3IGtlcm5lbDogWyAgMzM5
LjA5ODQ0MF0gaWRlOiBmYWlsZWQgb3Bjb2RlIHdhczogdW5rbm93bgpKYW4g
IDkgMTE6MzQ6MjYgamRyYWRlci0wMDA1NyBrZXJuZWw6IFsgIDMzOS4xNDgz
NDZdIGlkZTE6IHJlc2V0OiBtYXN0ZXI6IGVycm9yICgweDBlPykKSmFuICA5
IDExOjM0OjI2IGpkcmFkZXItMDAwNTcga2VybmVsOiBbICAzMzkuMTQ4MzU5
XSBlbmRfcmVxdWVzdDogSS9PIGVycm9yLCBkZXYgaGRjLCBzZWN0b3IgNTg0
MjI5MDQKSmFuICA5IDExOjM0OjI2IGpkcmFkZXItMDAwNTcga2VybmVsOiBb
ICAzMzkuMjMxNzEyXSBlbmRfcmVxdWVzdDogSS9PIGVycm9yLCBkZXYgaGRj
LCBzZWN0b3IgMjI0Nzc4NDAKSmFuICA5IDExOjM0OjI2IGpkcmFkZXItMDAw
NTcga2VybmVsOiBbICAzMzkuMjMxOTk5XSBlbmRfcmVxdWVzdDogSS9PIGVy
cm9yLCBkZXYgaGRjLCBzZWN0b3IgNDQ3MjcyMjQKSmFuICA5IDExOjM0OjI2
IGpkcmFkZXItMDAwNTcga2VybmVsOiBbICAzMzkuMjMyMDA0XSBCdWZmZXIg
SS9PIGVycm9yIG9uIGRldmljZSBoZGMsIGxvZ2ljYWwgYmxvY2sgNTU5MDkw
MwpKYW4gIDkgMTE6MzQ6MjYgamRyYWRlci0wMDA1NyBrZXJuZWw6IFsgIDMz
OS4yMzIwMDddIGxvc3QgcGFnZSB3cml0ZSBkdWUgdG8gSS9PIGVycm9yIG9u
IGhkYwpKYW4gIDkgMTE6MzQ6MjYgamRyYWRlci0wMDA1NyBrZXJuZWw6IFsg
IDMzOS4yMzIxOTJdIGVuZF9yZXF1ZXN0OiBJL08gZXJyb3IsIGRldiBoZGMs
IHNlY3RvciA0MDgzODQ3MgpKYW4gIDkgMTE6MzQ6MjYgamRyYWRlci0wMDA1
NyBrZXJuZWw6IFsgIDMzOS4yMzIzODBdIGVuZF9yZXF1ZXN0OiBJL08gZXJy
b3IsIGRldiBoZGMsIHNlY3RvciAzMTE5NTYxNgpKYW4gIDkgMTE6MzQ6MjYg
amRyYWRlci0wMDA1NyBrZXJuZWw6IFsgIDMzOS4yMzI1NTRdIGVuZF9yZXF1
ZXN0OiBJL08gZXJyb3IsIGRldiBoZGMsIHNlY3RvciA0NTAxMTUyOApKYW4g
IDkgMTE6MzQ6MjYgamRyYWRlci0wMDA1NyBrZXJuZWw6IFsgIDMzOS4yMzI3
NDhdIGVuZF9yZXF1ZXN0OiBJL08gZXJyb3IsIGRldiBoZGMsIHNlY3RvciAz
MDMyNjI4MApKYW4gIDkgMTE6MzQ6MjYgamRyYWRlci0wMDA1NyBrZXJuZWw6
IFsgIDMzOS4yMzM1MDhdIGVuZF9yZXF1ZXN0OiBJL08gZXJyb3IsIGRldiBo
ZGMsIHNlY3RvciA0MzE1OTc0NApKYW4gIDkgMTE6MzQ6MjYgamRyYWRlci0w
MDA1NyBrZXJuZWw6IFsgIDMzOS4yMzM2NTZdIGVuZF9yZXF1ZXN0OiBJL08g
ZXJyb3IsIGRldiBoZGMsIHNlY3RvciAxMzgwMzk0NApKYW4gIDkgMTE6MzQ6
MjYgamRyYWRlci0wMDA1NyBrZXJuZWw6IFsgIDMzOS4yMzM4MDhdIGVuZF9y
ZXF1ZXN0OiBJL08gZXJyb3IsIGRldiBoZGMsIHNlY3RvciA1NzYwMjMzNgpK
YW4gIDkgMTE6MzQ6MjYgamRyYWRlci0wMDA1NyBrZXJuZWw6IFsgIDMzOS4y
MzM4MTJdIEJ1ZmZlciBJL08gZXJyb3Igb24gZGV2aWNlIGhkYywgbG9naWNh
bCBibG9jayA3MjAwMjkyCkphbiAgOSAxMTozNDoyNiBqZHJhZGVyLTAwMDU3
IGtlcm5lbDogWyAgMzM5LjIzMzgxNF0gbG9zdCBwYWdlIHdyaXRlIGR1ZSB0
byBJL08gZXJyb3Igb24gaGRjCkphbiAgOSAxMTozNDoyNiBqZHJhZGVyLTAw
MDU3IGtlcm5lbDogWyAgMzM5LjIzMzk1Nl0gZW5kX3JlcXVlc3Q6IEkvTyBl
cnJvciwgZGV2IGhkYywgc2VjdG9yIDI5NDg4MDMyCkphbiAgOSAxMTozNDoy
NiBqZHJhZGVyLTAwMDU3IGtlcm5lbDogWyAgMzM5LjIzNDA5Nl0gZW5kX3Jl
cXVlc3Q6IEkvTyBlcnJvciwgZGV2IGhkYywgc2VjdG9yIDk2MDg2ODgKSmFu
ICA5IDExOjM0OjI2IGpkcmFkZXItMDAwNTcga2VybmVsOiBbICAzMzkuMjM0
MjQ3XSBlbmRfcmVxdWVzdDogSS9PIGVycm9yLCBkZXYgaGRjLCBzZWN0b3Ig
NDgwMjIyMTYKSmFuICA5IDExOjM0OjI2IGpkcmFkZXItMDAwNTcga2VybmVs
OiBbICAzMzkuMjM0Mzk2XSBlbmRfcmVxdWVzdDogSS9PIGVycm9yLCBkZXYg
aGRjLCBzZWN0b3IgMjA4ODYyMTYKSmFuICA5IDExOjM0OjI2IGpkcmFkZXIt
MDAwNTcga2VybmVsOiBbICAzMzkuMjM0NTM5XSBlbmRfcmVxdWVzdDogSS9P
IGVycm9yLCBkZXYgaGRjLCBzZWN0b3IgMjA4MTgwNjQKSmFuICA5IDExOjM0
OjI2IGpkcmFkZXItMDAwNTcga2VybmVsOiBbICAzMzkuMjM0Njg0XSBlbmRf
cmVxdWVzdDogSS9PIGVycm9yLCBkZXYgaGRjLCBzZWN0b3IgNTk5MDQwMDAK
SmFuICA5IDExOjM0OjI2IGpkcmFkZXItMDAwNTcga2VybmVsOiBbICAzMzku
MjM0ODU4XSBlbmRfcmVxdWVzdDogSS9PIGVycm9yLCBkZXYgaGRjLCBzZWN0
b3IgNjEyMDMxMjAKSmFuICA5IDExOjM0OjI2IGpkcmFkZXItMDAwNTcga2Vy
bmVsOiBbICAzMzkuMjM1MDA2XSBlbmRfcmVxdWVzdDogSS9PIGVycm9yLCBk
ZXYgaGRjLCBzZWN0b3IgMjQ3MTk1MgpKYW4gIDkgMTE6MzQ6MjYgamRyYWRl
ci0wMDA1NyBrZXJuZWw6IFsgIDMzOS4yMzUxNDldIGVuZF9yZXF1ZXN0OiBJ
L08gZXJyb3IsIGRldiBoZGMsIHNlY3RvciA0MDAwMzI4CkphbiAgOSAxMToz
NDoyNiBqZHJhZGVyLTAwMDU3IGtlcm5lbDogWyAgMzM5LjIzNTI5OV0gZW5k
X3JlcXVlc3Q6IEkvTyBlcnJvciwgZGV2IGhkYywgc2VjdG9yIDQxNjU0MDgK
SmFuICA5IDExOjM0OjI2IGpkcmFkZXItMDAwNTcga2VybmVsOiBbICAzMzku
MjM1NDQ5XSBlbmRfcmVxdWVzdDogSS9PIGVycm9yLCBkZXYgaGRjLCBzZWN0
b3IgNjUxOTQwOApKYW4gIDkgMTE6MzQ6MjYgamRyYWRlci0wMDA1NyBrZXJu
ZWw6IFsgIDMzOS4yMzU1OTBdIGVuZF9yZXF1ZXN0OiBJL08gZXJyb3IsIGRl
diBoZGMsIHNlY3RvciA0MjIxNTI4OApKYW4gIDkgMTE6MzQ6MjYgamRyYWRl
ci0wMDA1NyBrZXJuZWw6IFsgIDMzOS4yMzU3NDVdIGVuZF9yZXF1ZXN0OiBJ
L08gZXJyb3IsIGRldiBoZGMsIHNlY3RvciA1NzM1NjgwCkphbiAgOSAxMToz
NDoyNiBqZHJhZGVyLTAwMDU3IGtlcm5lbDogWyAgMzM5LjIzNTg4OV0gZW5k
X3JlcXVlc3Q6IEkvTyBlcnJvciwgZGV2IGhkYywgc2VjdG9yIDU0MTk5NTYw
CkphbiAgOSAxMTozNDoyNiBqZHJhZGVyLTAwMDU3IGtlcm5lbDogWyAgMzM5
LjIzNjAzMF0gZW5kX3JlcXVlc3Q6IEkvTyBlcnJvciwgZGV2IGhkYywgc2Vj
dG9yIDI0Mzc4NTEyCkphbiAgOSAxMTozNDoyNiBqZHJhZGVyLTAwMDU3IGtl
cm5lbDogWyAgMzM5LjIzNjE3MF0gZW5kX3JlcXVlc3Q6IEkvTyBlcnJvciwg
ZGV2IGhkYywgc2VjdG9yIDI2MzM3NzI4CkphbiAgOSAxMTozNDoyNiBqZHJh
ZGVyLTAwMDU3IGtlcm5lbDogWyAgMzM5LjIzNjM1MF0gZW5kX3JlcXVlc3Q6
IEkvTyBlcnJvciwgZGV2IGhkYywgc2VjdG9yIDE4NzAwODAKSmFuICA5IDEx
OjM0OjI2IGpkcmFkZXItMDAwNTcga2VybmVsOiBbICAzMzkuMjM2NDk4XSBl
bmRfcmVxdWVzdDogSS9PIGVycm9yLCBkZXYgaGRjLCBzZWN0b3IgNDI5MzIy
OTYKSmFuICA5IDExOjM0OjI2IGpkcmFkZXItMDAwNTcga2VybmVsOiBbICAz
MzkuMjM2NjM4XSBlbmRfcmVxdWVzdDogSS9PIGVycm9yLCBkZXYgaGRjLCBz
ZWN0b3IgNDA5NTA1MTIKSmFuICA5IDExOjM0OjI2IGpkcmFkZXItMDAwNTcg
a2VybmVsOiBbICAzMzkuMjM2Nzg0XSBlbmRfcmVxdWVzdDogSS9PIGVycm9y
LCBkZXYgaGRjLCBzZWN0b3IgMzMyNTkyNTYKSmFuICA5IDExOjM0OjI2IGpk
cmFkZXItMDAwNTcga2VybmVsOiBbICAzMzkuMjM2OTI3XSBlbmRfcmVxdWVz
dDogSS9PIGVycm9yLCBkZXYgaGRjLCBzZWN0b3IgMjkzMzg3NzYKSmFuICA5
IDExOjM0OjI2IGpkcmFkZXItMDAwNTcga2VybmVsOiBbICAzMzkuMjM3MDY3
XSBlbmRfcmVxdWVzdDogSS9PIGVycm9yLCBkZXYgaGRjLCBzZWN0b3IgNjE2
MTcwMTYKSmFuICA5IDExOjM0OjI2IGpkcmFkZXItMDAwNTcga2VybmVsOiBb
ICAzMzkuMjM3MjE3XSBlbmRfcmVxdWVzdDogSS9PIGVycm9yLCBkZXYgaGRj
LCBzZWN0b3IgNTU3MzcxMDQKSmFuICA5IDExOjM0OjI2IGpkcmFkZXItMDAw
NTcga2VybmVsOiBbICAzMzkuMjM3MzU4XSBlbmRfcmVxdWVzdDogSS9PIGVy
cm9yLCBkZXYgaGRjLCBzZWN0b3IgMzYzMDk1OTIKSmFuICA5IDExOjM0OjI2
IGpkcmFkZXItMDAwNTcga2VybmVsOiBbICAzMzkuMjM3NTA3XSBlbmRfcmVx
dWVzdDogSS9PIGVycm9yLCBkZXYgaGRjLCBzZWN0b3IgMjQzMTc0NDgKSmFu
ICA5IDExOjM0OjI2IGpkcmFkZXItMDAwNTcga2VybmVsOiBbICAzMzkuMjM3
NjUwXSBlbmRfcmVxdWVzdDogSS9PIGVycm9yLCBkZXYgaGRjLCBzZWN0b3Ig
NDkxNzYzMjAKSmFuICA5IDExOjM0OjI2IGpkcmFkZXItMDAwNTcga2VybmVs
OiBbICAzMzkuMjM3ODI2XSBlbmRfcmVxdWVzdDogSS9PIGVycm9yLCBkZXYg
aGRjLCBzZWN0b3IgNDM1NjQ3MTIKSmFuICA5IDExOjM0OjI2IGpkcmFkZXIt
MDAwNTcga2VybmVsOiBbICAzMzkuMjM3OTczXSBlbmRfcmVxdWVzdDogSS9P
IGVycm9yLCBkZXYgaGRjLCBzZWN0b3IgMTY4ODczMjAKSmFuICA5IDExOjM0
OjI2IGpkcmFkZXItMDAwNTcga2VybmVsOiBbICAzMzkuMjM4MTE0XSBlbmRf
cmVxdWVzdDogSS9PIGVycm9yLCBkZXYgaGRjLCBzZWN0b3IgNTQ1Nzk2NTYK
SmFuICA5IDExOjM0OjI2IGpkcmFkZXItMDAwNTcga2VybmVsOiBbICAzMzku
MjM4NTY2XSBlbmRfcmVxdWVzdDogSS9PIGVycm9yLCBkZXYgaGRjLCBzZWN0
b3IgNTczNjg2NjQKSmFuICA5IDExOjM0OjI2IGpkcmFkZXItMDAwNTcga2Vy
bmVsOiBbICAzMzkuMjM5NDcxXSBlbmRfcmVxdWVzdDogSS9PIGVycm9yLCBk
ZXYgaGRjLCBzZWN0b3IgMAo=


------=_NextPart_000_32fb_7ff8_23
Content-Type: application/octet-stream; name="libata.msg"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="libata.msg"

SmFuICA5IDEyOjA1OjMwIGpkcmFkZXItMDAwNTcgc3NoZDogIHN1Y2NlZWRl
ZApKYW4gIDkgMTI6MDU6MzAgamRyYWRlci0wMDA1NyB4aW5ldGQ6IHhpbmV0
ZCBzdGFydHVwIHN1Y2NlZWRlZApKYW4gIDkgMTI6MDU6MzEgamRyYWRlci0w
MDA1NyBtb2Rwcm9iZTogRkFUQUw6IEVycm9yIHJ1bm5pbmcgaW5zdGFsbCBj
b21tYW5kIGZvciBuZXRfcGZfMTAgCkphbiAgOSAxMjowNTozMiBqZHJhZGVy
LTAwMDU3IG1vZHByb2JlOiBGQVRBTDogRXJyb3IgcnVubmluZyBpbnN0YWxs
IGNvbW1hbmQgZm9yIG5ldF9wZl8xMCAKSmFuICA5IDEyOjA1OjMyIGpkcmFk
ZXItMDAwNTcgeGluZXRkWzI2MjhdOiB4aW5ldGQgVmVyc2lvbiAyLjMuMTIg
c3RhcnRlZCB3aXRoIGxpYndyYXAgbG9hZGF2ZyBvcHRpb25zIGNvbXBpbGVk
IGluLgpKYW4gIDkgMTI6MDU6MzIgamRyYWRlci0wMDA1NyB4aW5ldGRbMjYy
OF06IFN0YXJ0ZWQgd29ya2luZzogMSBhdmFpbGFibGUgc2VydmljZQpKYW4g
IDkgMTI6MDU6MzIgamRyYWRlci0wMDA1NyBzZW5kbWFpbDogc2VuZG1haWwg
c3RhcnR1cCBzdWNjZWVkZWQKSmFuICA5IDEyOjA1OjMyIGpkcmFkZXItMDAw
NTcgbW9kcHJvYmU6IEZBVEFMOiBFcnJvciBydW5uaW5nIGluc3RhbGwgY29t
bWFuZCBmb3IgbmV0X3BmXzEwIApKYW4gIDkgMTI6MDU6MzIgamRyYWRlci0w
MDA1NyBzZW5kbWFpbDogc20tY2xpZW50IHN0YXJ0dXAgc3VjY2VlZGVkCkph
biAgOSAxMjowNTozMiBqZHJhZGVyLTAwMDU3IGdwbTogZ3BtIHN0YXJ0dXAg
c3VjY2VlZGVkCkphbiAgOSAxMjowNTozMyBqZHJhZGVyLTAwMDU3IGNyb25k
OiBjcm9uZCBzdGFydHVwIHN1Y2NlZWRlZApKYW4gIDkgMTI6MDU6MzQgamRy
YWRlci0wMDA1NyB4ZnM6IHhmcyBzdGFydHVwIHN1Y2NlZWRlZApKYW4gIDkg
MTI6MDU6MzQgamRyYWRlci0wMDA1NyBhdGQ6IGF0ZCBzdGFydHVwIHN1Y2Nl
ZWRlZApKYW4gIDkgMTI6MDU6MzQgamRyYWRlci0wMDA1NyB4ZnM6IGlnbm9y
aW5nIGZvbnQgcGF0aCBlbGVtZW50IC91c3IvWDExUjYvbGliL1gxMS9mb250
cy9jeXJpbGxpYyAodW5yZWFkYWJsZSkgCkphbiAgOSAxMjowNTozNSBqZHJh
ZGVyLTAwMDU3IC9zYmluL2hvdHBsdWc6IG5vIHJ1bm5hYmxlIC9ldGMvaG90
cGx1Zy92Yy5hZ2VudCBpcyBpbnN0YWxsZWQKSmFuICA5IDEyOjA1OjM1IGpk
cmFkZXItMDAwNTcgbGFzdCBtZXNzYWdlIHJlcGVhdGVkIDI5IHRpbWVzCkph
biAgOSAxMjoxMzozMyBqZHJhZGVyLTAwMDU3IGxvZ2luKHBhbV91bml4KVsy
NzQ0XTogc2Vzc2lvbiBvcGVuZWQgZm9yIHVzZXIgcm9vdCBieSBMT0dJTih1
aWQ9MCkKSmFuICA5IDEyOjEzOjMzIGpkcmFkZXItMDAwNTcgIC0tIHJvb3Rb
Mjc0NF06IFJPT1QgTE9HSU4gT04gdHR5MQpKYW4gIDkgMTI6MTM6MzggamRy
YWRlci0wMDA1NyAvc2Jpbi9ob3RwbHVnOiBubyBydW5uYWJsZSAvZXRjL2hv
dHBsdWcvdmMuYWdlbnQgaXMgaW5zdGFsbGVkCkphbiAgOSAxMjoxMzozOCBq
ZHJhZGVyLTAwMDU3IC9zYmluL2hvdHBsdWc6IG5vIHJ1bm5hYmxlIC9ldGMv
aG90cGx1Zy92Yy5hZ2VudCBpcyBpbnN0YWxsZWQKSmFuICA5IDEyOjE0OjAx
IGpkcmFkZXItMDAwNTcga2VybmVsOiBbICA2NjIuMTE2ODk5XSByYWRkaW86
IHJhZGRpb19vcGVuKCkgLSBmaWxlLT5mX21vZGU9MTUKSmFuICA5IDEyOjE0
OjUyIGpkcmFkZXItMDAwNTcga2VybmVsOiBbICA3MTMuMDA0Mzc3XSByYWRk
aW86IHJhZGRpb19vcGVuKCkgLSBmaWxlLT5mX21vZGU9MTUKSmFuICA5IDEy
OjE1OjM1IGpkcmFkZXItMDAwNTcga2VybmVsOiBbICA3NTYuMzM1OTYxXSBh
dGEyOiBjb21tYW5kIDB4Y2EgdGltZW91dCwgc3RhdCAweDAgaG9zdF9zdGF0
IDB4MQpKYW4gIDkgMTI6MTU6NTUgamRyYWRlci0wMDA1NyBrZXJuZWw6IFsg
IDc3Ni4zMDY1ODVdIGF0YTI6IGNvbW1hbmQgMHhjOCB0aW1lb3V0LCBzdGF0
IDB4NDggaG9zdF9zdGF0IDB4MQpKYW4gIDkgMTI6MTU6NTUgamRyYWRlci0w
MDA1NyBrZXJuZWw6IFsgIDc3Ni4zMzcxMDhdIEFUQTogYWJub3JtYWwgc3Rh
dHVzIDB4NDggb24gcG9ydCAweEQwODE5NURGCkphbiAgOSAxMjoxNjoxNSBq
ZHJhZGVyLTAwMDU3IGtlcm5lbDogWyAgNzk2LjI5NzE4MV0gYXRhMjogY29t
bWFuZCAweGNhIHRpbWVvdXQsIHN0YXQgMHg0YSBob3N0X3N0YXQgMHgxCkph
biAgOSAxMjoxNjoxNSBqZHJhZGVyLTAwMDU3IGtlcm5lbDogWyAgNzk2LjMw
NzMzNV0gQVRBOiBhYm5vcm1hbCBzdGF0dXMgMHg0QSBvbiBwb3J0IDB4RDA4
MTk1REYKSmFuICA5IDEyOjE2OjM1IGpkcmFkZXItMDAwNTcga2VybmVsOiBb
ICA4MTYuMjY3ODA0XSBhdGEyOiBjb21tYW5kIDB4YzggdGltZW91dCwgc3Rh
dCAweDQ4IGhvc3Rfc3RhdCAweDEKSmFuICA5IDEyOjE2OjM1IGpkcmFkZXIt
MDAwNTcga2VybmVsOiBbICA4MTYuMjk4NDExXSBBVEE6IGFibm9ybWFsIHN0
YXR1cyAweDQ4IG9uIHBvcnQgMHhEMDgxOTVERgpKYW4gIDkgMTI6MTY6NTUg
amRyYWRlci0wMDA1NyBrZXJuZWw6IFsgIDgzNi4yNTg0MDBdIGF0YTI6IGNv
bW1hbmQgMHhjYSB0aW1lb3V0LCBzdGF0IDB4NGEgaG9zdF9zdGF0IDB4MQpK
YW4gIDkgMTI6MTY6NTUgamRyYWRlci0wMDA1NyBrZXJuZWw6IFsgIDgzNi4y
Njg1NTRdIEFUQTogYWJub3JtYWwgc3RhdHVzIDB4NEEgb24gcG9ydCAweEQw
ODE5NURGCkphbiAgOSAxMjoxNzoxNSBqZHJhZGVyLTAwMDU3IGtlcm5lbDog
WyAgODU2LjIyOTAyNF0gYXRhMjogY29tbWFuZCAweGM4IHRpbWVvdXQsIHN0
YXQgMHg0OCBob3N0X3N0YXQgMHgxCkphbiAgOSAxMjoxNzoxNSBqZHJhZGVy
LTAwMDU3IGtlcm5lbDogWyAgODU2LjI1OTcxNF0gQVRBOiBhYm5vcm1hbCBz
dGF0dXMgMHg0OCBvbiBwb3J0IDB4RDA4MTk1REYKSmFuICA5IDEyOjE3OjM1
IGpkcmFkZXItMDAwNTcga2VybmVsOiBbICA4NzYuMjE5NjIwXSBhdGEyOiBj
b21tYW5kIDB4Y2EgdGltZW91dCwgc3RhdCAweDRhIGhvc3Rfc3RhdCAweDEK
SmFuICA5IDEyOjE3OjM1IGpkcmFkZXItMDAwNTcga2VybmVsOiBbICA4NzYu
MjI5NzY5XSBBVEE6IGFibm9ybWFsIHN0YXR1cyAweDRBIG9uIHBvcnQgMHhE
MDgxOTVERgpKYW4gIDkgMTI6MTc6NTUgamRyYWRlci0wMDA1NyBrZXJuZWw6
IFsgIDg5Ni4xOTAyNDNdIGF0YTI6IGNvbW1hbmQgMHhjOCB0aW1lb3V0LCBz
dGF0IDB4NDggaG9zdF9zdGF0IDB4MQpKYW4gIDkgMTI6MTc6NTUgamRyYWRl
ci0wMDA1NyBrZXJuZWw6IFsgIDg5Ni4yMjEwMTddIEFUQTogYWJub3JtYWwg
c3RhdHVzIDB4NDggb24gcG9ydCAweEQwODE5NURGCkphbiAgOSAxMjoxODox
NSBqZHJhZGVyLTAwMDU3IGtlcm5lbDogWyAgOTE2LjE4MDg0MF0gYXRhMjog
Y29tbWFuZCAweGNhIHRpbWVvdXQsIHN0YXQgMHg0YSBob3N0X3N0YXQgMHgx
CkphbiAgOSAxMjoxODoxNSBqZHJhZGVyLTAwMDU3IGtlcm5lbDogWyAgOTE2
LjE5MDk4N10gQVRBOiBhYm5vcm1hbCBzdGF0dXMgMHg0QSBvbiBwb3J0IDB4
RDA4MTk1REYKSmFuICA5IDEyOjE4OjM1IGpkcmFkZXItMDAwNTcga2VybmVs
OiBbICA5MzYuMTUxNDY0XSBhdGEyOiBjb21tYW5kIDB4YzggdGltZW91dCwg
c3RhdCAweDQ4IGhvc3Rfc3RhdCAweDEKSmFuICA5IDEyOjE4OjM1IGpkcmFk
ZXItMDAwNTcga2VybmVsOiBbICA5MzYuMTgyMzE4XSBBVEE6IGFibm9ybWFs
IHN0YXR1cyAweDQ4IG9uIHBvcnQgMHhEMDgxOTVERgpKYW4gIDkgMTI6MTg6
NTUgamRyYWRlci0wMDA1NyBrZXJuZWw6IFsgIDk1Ni4xNDIwNjBdIGF0YTI6
IGNvbW1hbmQgMHhjYSB0aW1lb3V0LCBzdGF0IDB4NGEgaG9zdF9zdGF0IDB4
MQpKYW4gIDkgMTI6MTg6NTUgamRyYWRlci0wMDA1NyBrZXJuZWw6IFsgIDk1
Ni4xNTIyMDddIEFUQTogYWJub3JtYWwgc3RhdHVzIDB4NEEgb24gcG9ydCAw
eEQwODE5NURGCkphbiAgOSAxMjoxOToxNSBqZHJhZGVyLTAwMDU3IGtlcm5l
bDogWyAgOTc2LjExMjY4NF0gYXRhMjogY29tbWFuZCAweGM4IHRpbWVvdXQs
IHN0YXQgMHg0OCBob3N0X3N0YXQgMHgxCkphbiAgOSAxMjoxOToxNSBqZHJh
ZGVyLTAwMDU3IGtlcm5lbDogWyAgOTc2LjE0MzYyMl0gQVRBOiBhYm5vcm1h
bCBzdGF0dXMgMHg0OCBvbiBwb3J0IDB4RDA4MTk1REYKSmFuICA5IDEyOjE5
OjM1IGpkcmFkZXItMDAwNTcga2VybmVsOiBbICA5OTYuMTAzMjgwXSBhdGEy
OiBjb21tYW5kIDB4Y2EgdGltZW91dCwgc3RhdCAweDRhIGhvc3Rfc3RhdCAw
eDEKSmFuICA5IDEyOjE5OjM1IGpkcmFkZXItMDAwNTcga2VybmVsOiBbICA5
OTYuMTEzNDM0XSBBVEE6IGFibm9ybWFsIHN0YXR1cyAweDRBIG9uIHBvcnQg
MHhEMDgxOTVERgpKYW4gIDkgMTI6MTk6NTUgamRyYWRlci0wMDA1NyBrZXJu
ZWw6IFsgMTAxNi4wNzM5MDRdIGF0YTI6IGNvbW1hbmQgMHhjOCB0aW1lb3V0
LCBzdGF0IDB4NDggaG9zdF9zdGF0IDB4MQpKYW4gIDkgMTI6MTk6NTUgamRy
YWRlci0wMDA1NyBrZXJuZWw6IFsgMTAxNi4wODQxNTJdIEFUQTogYWJub3Jt
YWwgc3RhdHVzIDB4NDggb24gcG9ydCAweEQwODE5NURGCkphbiAgOSAxMjoy
MDoxNSBqZHJhZGVyLTAwMDU3IGtlcm5lbDogWyAxMDM2LjE0NDM4Ml0gYXRh
MjogY29tbWFuZCAweGNhIHRpbWVvdXQsIHN0YXQgMHg0YSBob3N0X3N0YXQg
MHgxCg==


------=_NextPart_000_32fb_7ff8_23--
