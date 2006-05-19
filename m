Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWESKhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWESKhL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 06:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWESKhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 06:37:11 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:14499 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932256AbWESKhJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 06:37:09 -0400
Message-ID: <446D9FCD.5050907@tw.ibm.com>
Date: Fri, 19 May 2006 18:37:01 +0800
From: Albert Lee <albertcc@tw.ibm.com>
Reply-To: albertl@mail.com
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: albertl@mail.com, Andrew Morton <akpm@osdl.org>, jeff@garzik.org,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, Doug Maxey <dwm@maxeymade.com>
Subject: Re: [RFT] major libata update
References: <20060515170006.GA29555@havoc.gtf.org>	<20060516190507.35c1260f.akpm@osdl.org>	<446AAB3C.6050303@gmail.com> <20060516215610.2b822c00.akpm@osdl.org> <446AB12C.10001@gmail.com> <446AC418.4070704@gmail.com> <446C5957.9040404@tw.ibm.com> <446C5B83.9000305@gmail.com>
In-Reply-To: <446C5B83.9000305@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Albert Lee wrote:
> 
>>> To sum up, it happens when the master slot is occupied by an ATAPI
>>> device and the corresponding slave slot is empty.  The slave slot
>>> reports ATAPI signature (probably duplicated from the master) and passes
>>> all legacy presence test thus resulting in timeout on IDENTIFY.
>>>
>>
>> This problem was seen with PATA Promise 20275 adapter + IBM DVD-RAM
>> drive.
>> Single master device configuration, no slave device.
>> The master device acts as slave and creates a phantom slave device.
>> (http://marc.theaimsgroup.com/?l=linux-ide&m=113151315602979&w=2)
>>
>> The problem was later fixed by Tejun's ata_exec_internal() patch:
>> (http://marc.theaimsgroup.com/?l=linux-ide&m=113455450809405&w=2)
>> After the patch, the phantom device is finally detected by
>> ata_dev_identify().
>>
>> Libata uses polling PIO for IDENTIFY DEVICE before this major update.
>> The polling PIO finds something wrong when it reads a 0x00 device status.
>> So, the phantom device is detected quite quickly.
>>
>> With irq-driven PIO, maybe the phantom device is only detected after
>> time-out.
>> So it takes longer (30 secs) to detect the phantom device.
>>
>> No good idea how to fix this. Maybe read more registers to see whether
>> the
>> phantom device can be detected early before the IDENTIFY DEVICE.
>>
> 
> Does the Promise controller show the ghosting problem again with the
> recent updates?  ata_piix can be fixed by using PCS present bits.  I
> don't know about Promise though.
> 

Checked the Promise 20275 manual, no device present bits.

It seems we still need IDENTIFY DEVICE to identify the phantom slave.
The IDE code uses polling for IDENTIFY DEVICE. (libata did the same.)
Maybe we can also use polling for IDENTIFY DEVICE?

Could you try the attached patch to see if polling helps
to reduce the boot time? Thanks.

--
albert
(Need some time to find the specific IBM DVD-RAM drive for bug verification...)

--- upstream0/drivers/scsi/libata-core.c	2006-05-16 11:08:49.000000000 +0800
+++ 300_phantom_device/drivers/scsi/libata-core.c	2006-05-19 17:37:23.000000000 +0800
@@ -1194,6 +1194,9 @@ static int ata_dev_read_id(struct ata_de
 
 	tf.protocol = ATA_PROT_PIO;
 
+	/* Use polling for early detection of phantom device 1 */
+	tf.flags |= ATA_TFLAG_POLLING;
+
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_FROM_DEVICE,
 				     id, sizeof(id[0]) * ATA_ID_WORDS);
 	if (err_mask) {

