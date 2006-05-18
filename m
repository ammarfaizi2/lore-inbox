Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWERF2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWERF2l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 01:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWERF2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 01:28:40 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:64223 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750778AbWERF2j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 01:28:39 -0400
Message-ID: <446C05FA.5020106@tw.ibm.com>
Date: Thu, 18 May 2006 13:28:26 +0800
From: Albert Lee <albertcc@tw.ibm.com>
Reply-To: albertl@mail.com
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>,
       "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
CC: albertl@mail.com, Andi Kleen <ak@suse.de>,
       Marko Macek <Marko.Macek@gmx.net>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       =?ISO-8859-1?Q?Reinhard_Brandst=E4dter?= <r.brandstaedter@gmx.at>
Subject: Re: ASUS A8V Deluxe, x86_64
References: <8E8F647D7835334B985D069AE964A4F7028FDC15@ECQCMTLMAIL1.quebec.int.ec.gc.ca> <446BEA2E.3030100@gmail.com>
In-Reply-To: <446BEA2E.3030100@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Fortier,Vincent [Montreal] wrote:
> 
>> scsi0 : sata_via
>> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> ata2.00: cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000
>> 88:001f
>> ata2.00: ATAPI, max UDMA/66
>> ata2.00: applying bridge limits
>> ata2.00: configured for UDMA/66
> 
> [--snip--]
> 
>> sd 0:0:0:0: Attached scsi disk sda
>>   Vendor: PLEXTOR   Model: DVDR   PX-716A    Rev: 1.09
>>   Type:   CD-ROM                             ANSI SCSI revision: 05
> 
> 
> Above and the detailed log too indicate that everything went smooth the
> first time around.  Albert, do you have any ideas?  Could it be
> something related to irq-pio?
> 

I've checked Vincent't dmesg for 2.6.17-rc0 again.
(http://bugzilla.kernel.org/show_bug.cgi?id=5533)
(http://bugzilla.kernel.org/attachment.cgi?id=7700&action=view)

It seems DMA commands are also affected by this problem, not PIO unique.

ata2: command 0xa0 timeout, stat 0xd0 host_stat 0x1  <==== Device busy. DMA on going.
ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
sr0: scsi-1 drive
sr 1:0:0:0: Attached scsi CD-ROM sr0
ata2 is slow to respond, please be patient
ata2 failed to respond (30 secs)
BUG: warning at drivers/scsi/libata-core.c:3303/ata_pio_complete()

Call Trace: <ffffffff88031bd0>{:libata:ata_pio_task+1398}
       <ffffffff810298cf>{__wake_up+56} <ffffffff81219b3a>{_spin_unlock_irqrestore+11}
       <ffffffff8803165a>{:libata:ata_pio_task+0} <ffffffff8103f2ed>{run_workqueue+159}
       <ffffffff8103fcd0>{worker_thread+0} <ffffffff8104265f>{keventd_create_kthread+0}
       <ffffffff8103fdd9>{worker_thread+265} <ffffffff8102880b>{default_wake_function+0}
       <ffffffff8104265f>{keventd_create_kthread+0} <ffffffff8104265f>{keventd_create_kthread+0}
       <ffffffff81042964>{kthread+212} <ffffffff8100a7a6>{child_rip+8}
       <ffffffff8104265f>{keventd_create_kthread+0} <ffffffff81218504>{thread_return+0}
       <ffffffff81042890>{kthread+0} <ffffffff8100a79e>{child_rip+0}
ata2: command 0xa0 timeout, stat 0xd0 host_stat 0x0       <==== Device busy, PIO.
ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00

=> It looks like the device is waiting for something.

After comparing the code of 2.6.17-rc4 and current libata upstream, maybe "flush" is the fix:
The CDB was sent to the ATAPI device by PIO, but not flushed to device.
So, the device was busy waiting for the CDB to arrive.

Hi Vincent,
  Could you please try 2.6.17-rc4, both with and without the attached patch,
to see if the flush works. Thanks.

--
albert

--- linux-2.6.17-rc4/drivers/scsi/libata-core.c	2006-05-18 12:59:23.000000000 +0800
+++ linux-2.6.17-rc4-mod/drivers/scsi/libata-core.c	2006-05-18 13:04:11.000000000 +0800
@@ -3638,6 +3638,8 @@ static void ata_pio_block(struct ata_por
 
 		ata_pio_sector(qc);
 	}
+
+	ata_altstatus(ap); /* flush */
 }
 
 static void ata_pio_error(struct ata_port *ap)
@@ -3754,11 +3756,14 @@ static void atapi_packet_task(void *_dat
 		spin_lock_irqsave(&ap->host_set->lock, flags);
 		ap->flags &= ~ATA_FLAG_NOINTR;
 		ata_data_xfer(ap, qc->cdb, qc->dev->cdb_len, 1);
+		ata_altstatus(ap); /* flush */
+
 		if (qc->tf.protocol == ATA_PROT_ATAPI_DMA)
 			ap->ops->bmdma_start(qc);	/* initiate bmdma */
 		spin_unlock_irqrestore(&ap->host_set->lock, flags);
 	} else {
 		ata_data_xfer(ap, qc->cdb, qc->dev->cdb_len, 1);
+		ata_altstatus(ap); /* flush */
 
 		/* PIO commands are handled by polling */
 		ap->hsm_task_state = HSM_ST;



