Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbVH3Qkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVH3Qkg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 12:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbVH3Qkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 12:40:36 -0400
Received: from fmr17.intel.com ([134.134.136.16]:60593 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932211AbVH3Qke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 12:40:34 -0400
Date: Tue, 30 Aug 2005 08:28:00 -0700
From: tony.luck@intel.com
Message-Id: <200508301528.j7UFS0J2009272@agluck-lia64.sc.intel.com>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: "Moore, Eric Dean" <Eric.Moore@lsil.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: RE: As of 2.6.13-rc1 Fusion-MPT very slow
In-Reply-To: <Pine.LNX.4.61.0508091126350.18591@praktifix.dwd.de>
References: <91888D455306F94EBD4D168954A9457C037B0557@nacos172.co.lsil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is alive and well in 2.6.13 (final) on ia64.  Excerpts from dmesg
when booting:

Fusion MPT base driver 3.03.02
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.03.02
GSI 28 (level, low) -> CPU 1 (0xc218) vector 49
ACPI: PCI Interrupt 0000:06:02.0[A] -> GSI 28 (level, low) -> IRQ 49
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
scsi0 : ioc0: LSI53C1030, FwRev=01030a00h, Ports=1, MaxQ=255, IRQ=49
  Vendor: QUANTUM   Model: ATLAS IV 9 SCA    Rev: 0B0B
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sda: 17942584 512-byte hdwr sectors (9187 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 17942584 512-byte hdwr sectors (9187 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: MAXTOR    Model: ATLAS10K4_73SCA   Rev: DFV0
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdb: 143666192 512-byte hdwr sectors (73557 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 143666192 512-byte hdwr sectors (73557 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
  Vendor: ESG-SHV   Model: SCA HSBP M17      Rev: 1.0D
  Type:   Processor                          ANSI SCSI revision: 02
GSI 29 (level, low) -> CPU 2 (0xc418) vector 50
ACPI: PCI Interrupt 0000:06:02.1[B] -> GSI 29 (level, low) -> IRQ 50
mptbase: Initiating ioc1 bringup
ioc1: 53C1030: Capabilities={Initiator}
scsi1 : ioc1: LSI53C1030, FwRev=01030a00h, Ports=1, MaxQ=255, IRQ=50
Fusion MPT FC Host driver 3.03.02
Fusion MPT misc device (ioctl) driver 3.03.02
mptctl: Registered with Fusion MPT base driver
mptctl: /dev/mptctl @ (major,minor=10,220)


When I'm up and running, measure the speed of sda and sdb:

# hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:   62 MB in  3.02 seconds =  20.56 MB/sec

[This is VERY consistent from run to run, 20.56 MB/s every time].

# hdparm -t /dev/sdb

/dev/sdb:
 Timing buffered disk reads:    2 MB in  4.04 seconds = 53.79 kB/sec

[Speed on sdb is very erratic ... 53.79 KB/s is the worst I saw in half
a dozen tests ... but first try after boot was 47.14 MB/s, and I see
intermediate rates all over the map: 545.42 KB/s, 5.13 MB/s, 32.61 MB/s]

dmesg shows some messages like this:
mptscsih: ioc0: >> Attempting task abort! (sc=e0000001fceb4c80)
mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
mptscsih: ioc0: >> Attempting task abort! (sc=e0000001fceb5080)
mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
mptscsih: ioc0: >> Attempting task abort! (sc=e0000001fceb6e80)
mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
mptscsih: ioc0: >> Attempting task abort! (sc=e0000001fceb7a80)
mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated

Sometimes there are floods of these, other times just a few ... e.g. I
saw just those 8 lines after ten iterations of "hdparm -t /dev/hdb".

-Tony
