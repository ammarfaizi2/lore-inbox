Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbSKTS33>; Wed, 20 Nov 2002 13:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262023AbSKTS33>; Wed, 20 Nov 2002 13:29:29 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:36882 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S261996AbSKTS30>; Wed, 20 Nov 2002 13:29:26 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB1969@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'Steven Timm'" <timm@fnal.gov>, Manish Lachwani <manish@Zambeel.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: AMD 760MPX dma_intr: error=0x40 { UncorrectableError }
Date: Wed, 20 Nov 2002 10:36:20 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

you should do this. For example, the drive is hda and the raw device is
rhda. Then, you could remap using:

dd if=/dev/zero of=/dev/rhda 

This will basically write accross the whole disk and is very time consuming.
However, you need to get the SMART data first from the drive using smartctl
and determine which sector needs to be remapped from SMART error log. Then
you could do :

dd if=/dev/zero of=/dev/rhda skip=<sectors obtained from above>

Send me the SMART data and I will tell you the sector number ...

Thanks
Manish



-----Original Message-----
From: Steven Timm [mailto:timm@fnal.gov]
Sent: Wednesday, November 20, 2002 6:23 AM
To: Manish Lachwani
Cc: linux-kernel@vger.kernel.org
Subject: RE: AMD 760MPX dma_intr: error=0x40 { UncorrectableError }


Our boxes are actually running pretty cool (45C, with drives at the
front) and the drives seem
to be well mounted.  The power supply, and the power itself should
be OK.

Thanks for the hint on remapping the sectors... what technique
would you use to do this?  Would zero-fill from the seagate
diagnostics work or should we use something else?

Steve Timm


------------------------------------------------------------------
Steven C. Timm (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~timm/
Fermilab Computing Division/Operating Systems Support
Scientific Computing Support Group--Computing Farms Operations

On Tue, 19 Nov 2002, Manish Lachwani wrote:

> I have seen this errors on Seagate ST380021A 80 GB drive on a large scale
in
> our storage systems that make use of 3ware controllers. Seagate claims the
> following reasons:
>
> 1. Weak Power supply
> 2. tempeature and heat
> 3. vibration
>
> Although, the maxtor 160 GB drives do not show such problems at all. Such
> problems can be eliminated though. From the SMART data, get the bad
sectors
> and remap them by writing to the raw device. Those pending sectors will
get
> remapped. However, the problems will persist with these drives. In our
> boxes, the operating temperature is abt 55 C ...
>
> -----Original Message-----
> From: Steven Timm [mailto:timm@fnal.gov]
> Sent: Tuesday, November 19, 2002 1:37 PM
> To: linux-kernel@vger.kernel.org
> Subject: AMD 760MPX dma_intr: error=0x40 { UncorrectableError }
>
>
>
> I have recently observed a large frequency of this error on
> a bunch of compute servers with brand new disks.
>
> Nov 15 01:42:52 fnd0172 kernel: hdb: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> Nov 15 01:42:52 fnd0172 kernel: hdb: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=44763517, sector=11235856
> Nov 15 01:42:52 fnd0172 kernel: end_request: I/O error, dev 03:42 (hdb),
> sector 11235856
>
> Configuration is the following:
> Tyan 2466 motherboard which has AMD760MPX chipset, dual Athlon MP2000+
> processors  (supports UltraATA100)
>
> hda=Seagate ST340016A 40 GB drive, ext2 FS
> hdb=Seagate ST380021A 80 GB drive, ext2 FS.
>
> There are many entries in this mailing list saying that
> the above error is a sign of a bad disk.  Seagate diagnostics
> say so too.. It is just hard to believe that 30 hard drives could
> go bad in less than a month.
>
> I know errors of this type were common on machines with Serverworks
> OSB4 chipsets.  Has anyone else heard of this error happening on
> non-serverworks chipsets such as VIA or AMD?  And is the drive
> really bad or will a low level format clear the bad blocks
> and let the drive operate again?
>
> Steve Timm
>
> ------------------------------------------------------------------
>
> SMART shows the following error structure:
>
> SMART Error Log:
> SMART Error Logging Version: 1
> Error Log Data Structure Pointer: 03
> ATA Error Count: 13
> Non-Fatal Count: 0
>
> Error Log Structure 1:
> DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
>  00   00   08   57   09   ab    f2   c8     40315
>  00   00   08   5f   09   ab    f2   c8     40315
>  00   00   08   67   09   ab    f2   c8     40315
>  00   00   08   6f   09   ab    f2   c8     40315
>  00   00   08   77   09   ab    f2   c8     40315
>  00   40   00   7d   09   ab    f2   51     922746
> Error condition:  33    Error State:       3
> Number of Hours in Drive Life: 1021 (life of the drive in hours)
>
> Error Log Structure 2:
> DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
>  00   00   08   07   d5   55    f1   ca     40320
>  00   00   08   3f   00   5c    f1   ca     40320
>  00   00   08   97   33   5d    f1   ca     40320
>  00   00   08   87   97   0f    f2   ca     40320
>  00   00   08   77   09   ab    f2   c8     40320
>  00   40   00   7d   09   ab    f2   51     922746
> Error condition:  33    Error State:       3
> Number of Hours in Drive Life: 1021 (life of the drive in hours)
>
> Error Log Structure 3:
> DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
>  00   00   28   bf   8f   52    f1   c8     23662
>  00   00   98   e7   8f   52    f1   c8     23662
>  00   00   68   ff   9a   52    f1   c8     23662
>  00   00   d8   67   9b   52    f1   c8     23662
>  00   00   28   07   a3   52    f1   c8     23662
>  00   40   00   25   a3   52    f1   51     1124073
> Error condition: 161    Error State:       3
> Number of Hours in Drive Life: 1040 (life of the drive in hours)
>
> Error Log Structure 4:
> DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
>  00   00   e0   4f   09   ab    f2   c8     40280
>  00   00   d8   57   09   ab    f2   c8     40285
>  00   00   d0   5f   09   ab    f2   c8     40290
>  00   00   c8   67   09   ab    f2   c8     40296
>  00   00   c0   6f   09   ab    f2   c8     40301
>  00   40   00   7d   09   ab    f2   51     922746
> Error condition:  33    Error State:       3
> Number of Hours in Drive Life: 1021 (life of the drive in hours)
>
> Error Log Structure 5:
> DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
>  00   00   d8   57   09   ab    f2   c8     40285
>  00   00   d0   5f   09   ab    f2   c8     40290
>  00   00   c8   67   09   ab    f2   c8     40296
>  00   00   c0   6f   09   ab    f2   c8     40301
>  00   00   b8   77   09   ab    f2   c8     40306
>  00   40   00   7d   09   ab    f2   51     922746
> Error condition:  33    Error State:       3
> Number of Hours in Drive Life: 1021 (life of the drive in hours)
>
>
>
> Steven C. Timm (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~timm/
> Fermilab Computing Division/Operating Systems Support
> Scientific Computing Support Group--Computing Farms Operations
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
