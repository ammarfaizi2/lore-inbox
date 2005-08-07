Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbVHGF7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVHGF7t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 01:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbVHGF7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 01:59:49 -0400
Received: from dwdmx4.dwd.de ([141.38.3.230]:18087 "EHLO dwdmx4.dwd.de")
	by vger.kernel.org with ESMTP id S1751102AbVHGF7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 01:59:48 -0400
Date: Sun, 7 Aug 2005 05:59:04 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@praktifix.dwd.de
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: "Moore, Eric Dean" <Eric.Moore@lsil.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: RE: As of 2.6.13-rc1 Fusion-MPT very slow
In-Reply-To: <1123366064.5102.3.camel@mulgrave>
Message-ID: <Pine.LNX.4.61.0508070540560.12234@praktifix.dwd.de>
References: <91888D455306F94EBD4D168954A9457C035CB64A@nacos172.co.lsil.com>
  <Pine.LNX.4.61.0508011537250.23481@praktifix.dwd.de>  <1123350790.5092.2.camel@mulgrave>
  <Pine.LNX.4.61.0508062058200.27998@praktifix.dwd.de> <1123366064.5102.3.camel@mulgrave>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="646811178-289543494-1123394344=:12234"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--646811178-289543494-1123394344=:12234
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 6 Aug 2005, James Bottomley wrote:

> On Sat, 2005-08-06 at 21:12 +0000, Holger Kiehl wrote:
>>     drivers/message/fusion/mptspi.c:505: error: unknown field â..get_hold_mcsâ.. specified in initializer
>>     drivers/message/fusion/mptspi.c:505: warning: excess elements in struct initializer
>>     drivers/message/fusion/mptspi.c:505: warning: (near initialization for â..mptspi_transport_functionsâ..)
>>     drivers/message/fusion/mptspi.c:506: error: unknown field â..set_hold_mcsâ.. specified in initializer
>>     drivers/message/fusion/mptspi.c:506: warning: excess elements in struct initializer
>>     drivers/message/fusion/mptspi.c:506: warning: (near initialization for â..mptspi_transport_functionsâ..)
>>     drivers/message/fusion/mptspi.c:507: error: unknown field â..show_hold_mcsâ.. specified in initializer
>>     drivers/message/fusion/mptspi.c:507: warning: excess elements in struct initializer
>>     drivers/message/fusion/mptspi.c:507: warning: (near initialization for â..mptspi_transport_functionsâ..)
>
> This is actually because -mm is slightly behind the scsi-misc tree.  It
> looks like the hold_mcs parameters haven't propagated into the -mm tree
> yet.  You should be able to correct this by cutting these three lines:
>
> 	.get_hold_mcs	= mptspi_read_parameters,
> 	.set_hold_mcs	= mptspi_write_hold_mcs,
> 	.show_hold_mcs	= 1,
>
> Out of the code at lines 505-507.  You'll get a warning about
> mptspi_write_hold_mcs() being defined but not used which you can ignore.
>
Thanks, removing those it compiles fine. This patch also solves my problem,
here the output of dmesg:

    Fusion MPT base driver 3.03.02
    Copyright (c) 1999-2005 LSI Logic Corporation
    Fusion MPT SPI Host driver 3.03.02
    ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 24 (level, low) -> IRQ 217
    mptbase: Initiating ioc0 bringup
    ioc0: 53C1030: Capabilities={Initiator,Target}
    scsi4 : ioc0: LSI53C1030, FwRev=01032700h, Ports=1, MaxQ=255, IRQ=217
      Vendor: FUJITSU   Model: MAS3735NP         Rev: 0104
      Type:   Direct-Access                      ANSI SCSI revision: 03
     target4:0:0: Beginning Domain Validation
     target4:0:0: Ending Domain Validation
     target4:0:0: FAST-160 WIDE SCSI 320.0 MB/s DT IU (6.25 ns, offset 127)
    SCSI device sdc: 143552136 512-byte hdwr sectors (73499 MB)
    SCSI device sdc: drive cache: write back
    SCSI device sdc: 143552136 512-byte hdwr sectors (73499 MB)
    SCSI device sdc: drive cache: write back
     sdc: sdc1
    Attached scsi disk sdc at scsi4, channel 0, id 0, lun 0
      Vendor: FUJITSU   Model: MAS3735NP         Rev: 0104
      Type:   Direct-Access                      ANSI SCSI revision: 03
     target4:0:1: Beginning Domain Validation
     target4:0:1: Ending Domain Validation
     target4:0:1: FAST-160 WIDE SCSI 320.0 MB/s DT IU (6.25 ns, offset 127)
    SCSI device sdd: 143552136 512-byte hdwr sectors (73499 MB)
    SCSI device sdd: drive cache: write back
    SCSI device sdd: 143552136 512-byte hdwr sectors (73499 MB)
    SCSI device sdd: drive cache: write back
     sdd: sdd1
    Attached scsi disk sdd at scsi4, channel 0, id 1, lun 0
      Vendor: FUJITSU   Model: MAS3735NP         Rev: 0104
      Type:   Direct-Access                      ANSI SCSI revision: 03
     target4:0:2: Beginning Domain Validation
     target4:0:2: Ending Domain Validation
     target4:0:2: FAST-160 WIDE SCSI 320.0 MB/s DT IU (6.25 ns, offset 127)
    SCSI device sde: 143552136 512-byte hdwr sectors (73499 MB)
    SCSI device sde: drive cache: write back
    SCSI device sde: 143552136 512-byte hdwr sectors (73499 MB)
    SCSI device sde: drive cache: write back
     sde: sde1
    Attached scsi disk sde at scsi4, channel 0, id 2, lun 0
      Vendor: FUJITSU   Model: MAS3735NP         Rev: 0104
      Type:   Direct-Access                      ANSI SCSI revision: 03
     target4:0:3: Beginning Domain Validation
     target4:0:3: Ending Domain Validation
     target4:0:3: FAST-160 WIDE SCSI 320.0 MB/s DT IU (6.25 ns, offset 127)
    SCSI device sdf: 143552136 512-byte hdwr sectors (73499 MB)
    SCSI device sdf: drive cache: write back
    SCSI device sdf: 143552136 512-byte hdwr sectors (73499 MB)
    SCSI device sdf: drive cache: write back
     sdf: sdf1
    Attached scsi disk sdf at scsi4, channel 0, id 3, lun 0
    ACPI: PCI Interrupt 0000:02:04.1[B] -> GSI 25 (level, low) -> IRQ 225
    mptbase: Initiating ioc1 bringup
    ioc1: 53C1030: Capabilities={Initiator,Target}
    scsi5 : ioc1: LSI53C1030, FwRev=01032700h, Ports=1, MaxQ=255, IRQ=225
      Vendor: FUJITSU   Model: MAS3735NP         Rev: 0104
      Type:   Direct-Access                      ANSI SCSI revision: 03
     target5:0:0: Beginning Domain Validation
     target5:0:0: Ending Domain Validation
     target5:0:0: FAST-160 WIDE SCSI 320.0 MB/s DT IU (6.25 ns, offset 127)
    SCSI device sdg: 143552136 512-byte hdwr sectors (73499 MB)
    SCSI device sdg: drive cache: write back
    SCSI device sdg: 143552136 512-byte hdwr sectors (73499 MB)
    SCSI device sdg: drive cache: write back
     sdg: sdg1
    Attached scsi disk sdg at scsi5, channel 0, id 0, lun 0
      Vendor: FUJITSU   Model: MAS3735NP         Rev: 0104
      Type:   Direct-Access                      ANSI SCSI revision: 03
     target5:0:1: Beginning Domain Validation
     target5:0:1: Ending Domain Validation
     target5:0:1: FAST-160 WIDE SCSI 320.0 MB/s DT IU (6.25 ns, offset 127)
    SCSI device sdh: 143552136 512-byte hdwr sectors (73499 MB)
    SCSI device sdh: drive cache: write back
    SCSI device sdh: 143552136 512-byte hdwr sectors (73499 MB)
    SCSI device sdh: drive cache: write back
     sdh: sdh1
    Attached scsi disk sdh at scsi5, channel 0, id 1, lun 0
      Vendor: FUJITSU   Model: MAS3735NP         Rev: 0104
      Type:   Direct-Access                      ANSI SCSI revision: 03
     target5:0:2: Beginning Domain Validation
     target5:0:2: Ending Domain Validation
     target5:0:2: FAST-160 WIDE SCSI 320.0 MB/s DT IU (6.25 ns, offset 127)
    SCSI device sdi: 143552136 512-byte hdwr sectors (73499 MB)
    SCSI device sdi: drive cache: write back
    SCSI device sdi: 143552136 512-byte hdwr sectors (73499 MB)
    SCSI device sdi: drive cache: write back
     sdi: sdi1
    Attached scsi disk sdi at scsi5, channel 0, id 2, lun 0
      Vendor: FUJITSU   Model: MAS3735NP         Rev: 0104
      Type:   Direct-Access                      ANSI SCSI revision: 03
     target5:0:3: Beginning Domain Validation
     target5:0:3: Ending Domain Validation
     target5:0:3: FAST-160 WIDE SCSI 320.0 MB/s DT IU (6.25 ns, offset 127)
    SCSI device sdj: 143552136 512-byte hdwr sectors (73499 MB)
    SCSI device sdj: drive cache: write back
    SCSI device sdj: 143552136 512-byte hdwr sectors (73499 MB)
    SCSI device sdj: drive cache: write back
     sdj: sdj1
    Attached scsi disk sdj at scsi5, channel 0, id 3, lun 0

What I like a lot is that I now can see what speed disk has been selected
for each disk. Great!

I tested all eight disks and they all now have approx. 74MB/s with hdparm.

This is what getspeed reports that Eric Moore has send me:

    ./getspeed.x86_64 0


    Compiled with Fusion-MPT 2.05.03 Driver Header Files

    Data Transfer Rate on IOC 0:
    Id 0x0: Wide, Synchronous: Offset=0x7f, Factor=0x8 (Ultra320)
            Special Features Enabled: IU DT RTI PCOMP_EN
    Id 0x1: Wide, Synchronous: Offset=0x7f, Factor=0x8 (Ultra320)
            Special Features Enabled: IU DT RTI PCOMP_EN
    Id 0x2: Wide, Synchronous: Offset=0x7f, Factor=0x8 (Ultra320)
            Special Features Enabled: IU DT RTI PCOMP_EN
    Id 0x3: Wide, Synchronous: Offset=0x7f, Factor=0x8 (Ultra320)
            Special Features Enabled: IU DT RTI PCOMP_EN
    Id 0x4: Narrow, Asynchronous.
    Id 0x5: Narrow, Asynchronous.
    Id 0x6: Narrow, Asynchronous.
    Id 0x7: Narrow, Asynchronous.
    Id 0x8: Narrow, Asynchronous.
    Id 0x9: Narrow, Asynchronous.
    Id 0xa: Narrow, Asynchronous.
    Id 0xb: Narrow, Asynchronous.
    Id 0xc: Narrow, Asynchronous.
    Id 0xd: Narrow, Asynchronous.
    Id 0xe: Narrow, Asynchronous.
    Id 0xf: Narrow, Asynchronous

    ./getspeed.x86_64 1


    Compiled with Fusion-MPT 2.05.03 Driver Header Files

    Data Transfer Rate on IOC 1:
    Id 0x0: Wide, Synchronous: Offset=0x7f, Factor=0x8 (Ultra320)
            Special Features Enabled: IU DT RTI PCOMP_EN
    Id 0x1: Wide, Synchronous: Offset=0x7f, Factor=0x8 (Ultra320)
            Special Features Enabled: IU DT RTI PCOMP_EN
    Id 0x2: Wide, Synchronous: Offset=0x7f, Factor=0x8 (Ultra320)
            Special Features Enabled: IU DT RTI PCOMP_EN
    Id 0x3: Wide, Synchronous: Offset=0x7f, Factor=0x8 (Ultra320)
            Special Features Enabled: IU DT RTI PCOMP_EN
    Id 0x4: Narrow, Asynchronous.
    Id 0x5: Narrow, Asynchronous.
    Id 0x6: Narrow, Asynchronous.
    Id 0x7: Narrow, Asynchronous.
    Id 0x8: Narrow, Asynchronous.
    Id 0x9: Narrow, Asynchronous.
    Id 0xa: Narrow, Asynchronous.
    Id 0xb: Narrow, Asynchronous.
    Id 0xc: Narrow, Asynchronous.
    Id 0xd: Narrow, Asynchronous.
    Id 0xe: Narrow, Asynchronous.
    Id 0xf: Narrow, Asynchronous.

If there is anything else I can provide or test please tell me.

Thanks,
Holger
--646811178-289543494-1123394344=:12234--

