Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWERLYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWERLYO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 07:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWERLYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 07:24:14 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:23724 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750713AbWERLYN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 07:24:13 -0400
Message-ID: <446C5957.9040404@tw.ibm.com>
Date: Thu, 18 May 2006 19:24:07 +0800
From: Albert Lee <albertcc@tw.ibm.com>
Reply-To: albertl@mail.com
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, jeff@garzik.org, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [RFT] major libata update
References: <20060515170006.GA29555@havoc.gtf.org>	<20060516190507.35c1260f.akpm@osdl.org>	<446AAB3C.6050303@gmail.com> <20060516215610.2b822c00.akpm@osdl.org> <446AB12C.10001@gmail.com> <446AC418.4070704@gmail.com>
In-Reply-To: <446AC418.4070704@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Tejun Heo wrote:
> 
>> Andrew Morton wrote:
>>
>>> No.  In fact, it doesn't even work with the 2.6.17-rc4-mm1 lineup
>>> plus the
>>> latest git-libata-all.  It needs this tweak:
>>>
>>> --- devel/drivers/scsi/ata_piix.c~2.6.17-rc4-mm1-ich8-fix   
>>> 2006-05-16 18:36:12.000000000 -0700
>>> +++ devel-akpm/drivers/scsi/ata_piix.c    2006-05-16
>>> 18:36:12.000000000 -0700
>>> @@ -542,6 +542,14 @@ static unsigned int piix_sata_probe (str
>>>          port = map[base + i];
>>>          if (port < 0)
>>>              continue;
>>> +        if (ap->flags & PIIX_FLAG_AHCI) {
>>> +            /* FIXME: Port status of AHCI controllers
>>> +             * should be accessed in AHCI memory space.  */
>>> +            if (pcs & 1 << port)
>>> +                present_mask |= 1 << i;
>>> +            else
>>> +                pcs &= ~(1 << port);
>>> +        }
>>>          if (ap->flags & PIIX_FLAG_IGNORE_PCS || pcs & 1 << (4 + port))
>>>              present_mask |= 1 << i;
>>>          else
> 
> 
> The above patch doesn't do anything.  The only effect it has is setting
> present_mask according to enabled bits instead of present bits.  I think
> this patch might have helped with probing before the MAP tables for
> ICH6/7 are fixed.
> 
> I've done further testing.
> 
> * Symptom
> 
> ata_piix tries to probe non-existing slave device resulting in timeouts
> during boot probing.  This problem is aggravated by new probing updates
> as it retries two more times before giving up.
> 
> * Test results
> 
> PATA never has any problem with device detection via signature.  Only
> SATA is affected and interestingly only ATAPI device.  The following is
> the test result on my machine (ICH7R + PX716SA).
> 
>   1. combined mode : MAP [IDE IDE P1 P3]
> 
>     P1        P3
>     -----------------------------
>     PX716-SA    empty        P3 ghosted as ATAPI device
>     empty        PX716-SA    okay
>     PX716-SA    HDD        okay
>     HDD        PX716-SA    okay
> 
>   2. SATA-only mode : MAP [P0 P2 P1 P3]
> 
>     P0        P2
>     -----------------------------
>     PX716-SA    empty        P2 ghosted as ATAPI device
>     empty        PX716-SA    okay
>     PX716-SA    HDD        okay
>     HDD        PX716-SA    okay
> 
>     P1        P3
>     -----------------------------
>     Identical to #1.
> 
> To sum up, it happens when the master slot is occupied by an ATAPI
> device and the corresponding slave slot is empty.  The slave slot
> reports ATAPI signature (probably duplicated from the master) and passes
> all legacy presence test thus resulting in timeout on IDENTIFY.
> 

This problem was seen with PATA Promise 20275 adapter + IBM DVD-RAM drive.
Single master device configuration, no slave device.
The master device acts as slave and creates a phantom slave device.
(http://marc.theaimsgroup.com/?l=linux-ide&m=113151315602979&w=2)

The problem was later fixed by Tejun's ata_exec_internal() patch:
(http://marc.theaimsgroup.com/?l=linux-ide&m=113455450809405&w=2)
After the patch, the phantom device is finally detected by ata_dev_identify().

Libata uses polling PIO for IDENTIFY DEVICE before this major update.
The polling PIO finds something wrong when it reads a 0x00 device status.
So, the phantom device is detected quite quickly.

With irq-driven PIO, maybe the phantom device is only detected after time-out.
So it takes longer (30 secs) to detect the phantom device.

No good idea how to fix this. Maybe read more registers to see whether the
phantom device can be detected early before the IDENTIFY DEVICE.

--
albert


> In all above cases, the PCS register reported correct presence masks.
> 
> * Proposed solution
> 
> It seems that the only solution is to make use of the PCS presence bits
> somehow.  It is know that 6300ESB family of controllers have flaky
> presence bits (ata_piix marks them with PIIX_FLAG_IGNORE_PCS), but I
> couldn't find any document/errata for PCS bits for any other
> controllers.  So, we can use PCS for all !PIIX_FLAG_IGNORE_PCS
> controllers or take a conservative approach and make use of it only on
> cases where ghosting problem is reported (ICH7 and 8, I guess.  Can
> anyone test 6?).
> 
> Please note that we already use some use of the PCS value when probing
> SATA port.  If its value is zero, we skip the port.  It's done this way
> mainly due to historical reasons - until recently ata_piix didn't have
> MAP tables to map PM/PS/SM/SS to specific ports thus used the PCS values
> in rougher form.
> 
> Jeff, what do you think?
> 


