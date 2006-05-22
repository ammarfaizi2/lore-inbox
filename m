Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWEVDcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWEVDcr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 23:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWEVDcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 23:32:46 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:43395 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750829AbWEVDcp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 23:32:45 -0400
Message-ID: <447130D4.1020008@tw.ibm.com>
Date: Mon, 22 May 2006 11:32:36 +0800
From: Albert Lee <albertcc@tw.ibm.com>
Reply-To: albertl@mail.com
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
CC: albertl@mail.com, Tejun Heo <htejun@gmail.com>, Andi Kleen <ak@suse.de>,
       Marko Macek <Marko.Macek@gmx.net>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       =?ISO-8859-1?Q?Reinhard_Brandst=E4dter?= <r.brandstaedter@gmx.at>
Subject: Re: TR: ASUS A8V Deluxe, x86_64
References: <8E8F647D7835334B985D069AE964A4F7028FDC29@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
In-Reply-To: <8E8F647D7835334B985D069AE964A4F7028FDC29@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fortier,Vincent [Montreal] wrote:
>>Tejun Heo wrote:
>>
>>>Fortier,Vincent [Montreal] wrote:
>>>
>>>>scsi0 : sata_via
>>>>ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>>ata2.00: cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 
>>>>87:0000 88:001f
>>>>ata2.00: ATAPI, max UDMA/66
>>>>ata2.00: applying bridge limits
>>>>ata2.00: configured for UDMA/66
>>>
>>>[--snip--]
>>>
>>>
>>>>sd 0:0:0:0: Attached scsi disk sda
>>>>  Vendor: PLEXTOR   Model: DVDR   PX-716A    Rev: 1.09
>>>>  Type:   CD-ROM                             ANSI SCSI revision: 05
>>>
>>>Above and the detailed log too indicate that everything went smooth 
>>>the first time around.  Albert, do you have any ideas?  Could it be 
>>>something related to irq-pio?
> 
> 
>>I've checked Vincent't dmesg for 2.6.17-rc0 again.
>>(http://bugzilla.kernel.org/show_bug.cgi?id=5533)
>>(http://bugzilla.kernel.org/attachment.cgi?id=7700&action=view)
> 
> 
>>It seems DMA commands are also affected by this problem, not PIO unique.
> 
> 
>>ata2: command 0xa0 timeout, stat 0xd0 host_stat 0x1  <==== Device 
>>busy. DMA on going. ata2: translated ATA stat/err 0xd0/00 to SCSI 
>>SK/ASC/ASCQ 0xb/47/00 sr0: scsi-1 drive sr 1:0:0:0: Attached scsi 
>>CD-ROM sr0
>>ata2 is slow to respond, please be patient
>>ata2 failed to respond (30 secs)
>>BUG: warning at drivers/scsi/libata-core.c:3303/ata_pio_complete()
>>
>>Call Trace: <ffffffff88031bd0>{:libata:ata_pio_task+1398}
>>
>>=> It looks like the device is waiting for something.
>>
>>After comparing the code of 2.6.17-rc4 and current libata upstream, 
>>maybe "flush" is the fix: The CDB was sent to the ATAPI device by PIO, 
>>but not flushed to device. So, the device was busy waiting for the CDB to arrive.
>>
>>Hi Vincent,
>>  Could you please try 2.6.17-rc4, both with and without the attached 
>>patch, to see if the flush works. Thanks.
> 
> 
> You where absolutely right on it Albert..  I've attached all the logs.
> 
> Maybie this patch should be sent to the 2.6.17 tree?
> 
> The only thing I've found curious is when using cdrecord -scanbus... With the patch or with the main patchset it only shows my plextor and stop showing my dvd reader and my yamaha cdr?  Although they both get discovered by k3b?  It probably has nothing to do with this.
> 
> If you'd like me to test anything else just ask!
> 
> - vin
> 

Thanks for the test. Will submit the pio flush patch to Jeff for review.

For the cdrecord -scanbus problem, I saw similar problem before
when fiber channel device added/removed. Don't know why. Looks more
like cdrecord problem.

--
albert

