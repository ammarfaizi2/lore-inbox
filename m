Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276814AbRJPWqK>; Tue, 16 Oct 2001 18:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276829AbRJPWqA>; Tue, 16 Oct 2001 18:46:00 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:59913 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S276814AbRJPWpx>; Tue, 16 Oct 2001 18:45:53 -0400
Message-Id: <200110162246.f9GMkMY76251@aslan.scsiguy.com>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx conflicting reports of bus speed 
In-Reply-To: Your message of "Tue, 16 Oct 2001 15:20:27 PDT."
             <Pine.LNX.4.33.0110161510050.32663-100000@windmill.gghcwest.com> 
Date: Tue, 16 Oct 2001 16:46:22 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>i have two SCSI host adapters in a system:
>
>scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
>        <Adaptec aic7892 Ultra160 SCSI adapter>
>        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/255 SCBs
>
>scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
>        <Adaptec 29160 Ultra160 SCSI adapter>
>        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/255 SCBs
>
>scsi0 runs Adaptec BIOS version 3.00, scsi1 uses 3.10.  When scsi1
>reports, it shows itself running at 40MHz instead of the desired 80MHz:
>
>(scsi1:A:0): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
>  Vendor: SEAGATE   Model: ST336705LC        Rev: 5063
>  Type:   Direct-Access                      ANSI SCSI revision: 03

...

>Later though, the bus speed is shown as 80MHz:
>
>(scsi1:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
>SCSI device sdc: 71687370 512-byte hdwr sectors (36704 MB)

...

>There is a mismatch here.  I believe the first report is false.

Actually, both are correct.  The driver will not negotiate 160 unless
it has seen sufficient inquiry data to verify that the target is capable
of such speeds.  This bit of protection avoids problems with broken
devices that mess up in rejecting the new message type required
to negotiate 160.  I have not gone looking through the scanning code
recently to verify, but my guess is that Linux now does a "minimal"
inquiry (36 bytes of data) first, determines the amount of inquiry data
the target really has and then issues another inquiry to fetch the rest.
After the first inquiry is sent, we have enough information to safely
negotiate to 40MHz, so we do.  After the second inquiry, we see that
double transition clocking is supported by the target and we re-negotiate
to 80MHz-DT.

>Further,
>the reporting of the tag queue depth is conflicting.  At boot time, I see
>this:
>
>scsi1:0:0:0: Tagged Queuing enabled.  Depth 8
>scsi1:0:1:0: Tagged Queuing enabled.  Depth 8
>scsi1:0:2:0: Tagged Queuing enabled.  Depth 8
>scsi1:0:3:0: Tagged Queuing enabled.  Depth 8
>
>But /proc/scsi/aic7xxx/1 shows this:
>
>Channel A Target 0 Negotiation Settings
>        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
>        Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
>        Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
>        Channel A Target 0 Lun 0 Settings
>                Commands Queued 320416
>                Commands Active 0
>                Command Openings 253
>                Max Tagged Openings 253
>                Device Queue Frozen Count 0
>
>So it looks like the depth is 253.

The SCSI layer has the depth set to 8.  Internally, the driver will accept
up to 253, but only 8 are ever queued concurrently.  Its just a cosmetic
bug, but I'll fix it in the next drop.

--
Justin
