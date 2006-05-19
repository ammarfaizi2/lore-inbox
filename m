Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWESCQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWESCQo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 22:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWESCQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 22:16:43 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:16454 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932177AbWESCQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 22:16:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=RYMHBhv1tHp2hK6BXCFXDi0lvoJ+Rd/RCnMmxg9thTxo8pVpa1T7VuN19KA1P7C+CU/hFW6TBwtHmkBVLPPDRSqbiPEuzeNJR+SD/aR1vaimy2XzoSIA/mClOhF+56MQCKrjxgmGvu/+8rR0l8nHOjSP4vuaFAztl4Yz26STPIs=
Message-ID: <446D2A82.8060706@gmail.com>
Date: Fri, 19 May 2006 11:16:34 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [RFT] major libata update
References: <20060515170006.GA29555@havoc.gtf.org> <20060516190507.35c1260f.akpm@osdl.org> <446AAB3C.6050303@gmail.com> <20060516215610.2b822c00.akpm@osdl.org> <446AB12C.10001@gmail.com> <446AC418.4070704@gmail.com> <20060518160758.5911e4b7.akpm@osdl.org> <20060519011400.GA10058@htj.dyndns.org> <446D281B.2060605@garzik.org>
In-Reply-To: <446D281B.2060605@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> On Thu, May 18, 2006 at 04:07:58PM -0700, Andrew Morton wrote:
>>> Yes it does.  I dropped it and got
>>>
>>> SCSI subsystem initialized
>>> ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
>>> ACPI (acpi_bus-0191): Device is not power manageable [20060310]
>>> ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 19 (level, low) -> IRQ 19
>>> ata1: SATA max UDMA/133 cmd 0x2148 ctl 0x217E bmdma 0x2110 irq 19
>>> ata2: SATA max UDMA/133 cmd 0x2140 ctl 0x217A bmdma 0x2118 irq 19
>>> ata1: SATA port has no device.
>>>
>>> Then I undropped it and got
>>>
>>> SCSI subsystem initialized
>>> ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
>>> ACPI (acpi_bus-0191): Device is not power manageable [20060310]
>>> ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 19 (level, low) -> IRQ 19
>>> ata1: SATA max UDMA/133 cmd 0x2148 ctl 0x217E bmdma 0x2110 irq 19
>>> ata2: SATA max UDMA/133 cmd 0x2140 ctl 0x217A bmdma 0x2118 irq 19
>>> ata1.00: ATA-7, max UDMA/133, 321672960 sectors: LBA48 NCQ (depth 0/32)
>>> ata1.00: configured for UDMA/133
>>> scsi0 : ata_piix
>>>
>>> and a computer which boots.
>>>
>>> Look closer, please ;)
>>
>> Hello, Andrew.
>>
>> I see.  It seems that you're reporting two separate problems - your
>> PCS register doesn't report presence properly && the TF registers
>> report ghost device if the first device is ATAPI.  I can reproduce the
>> second here, but AFAIK the only controller which had problem with PCS
>> persence bits was ESB6300 until now.
>>
>> Can you post the result of 'lspci -n' and ata_piix boot probing
>> messages with the following patch applied?  It would be helpful if you
>> tell us how devices are actually connected.  Also, where did the patch
>> come from?  With what comment?
> 
> At this point it may be relevant to note that Intel tells me that PCS 
> has changed on -every- chip.  So, ICH8 PCS register behaves differently 
> from ICH7 and prior.

Yeah, the PCS bit is sad to look at.  From ICH6, the docs say that the 
AHCI SStatus should be used for presence detection but that cannot be 
done without AHCI BAR mapped.

ICH7 (or 6 was it?) added a window register into AHCI area, which 
weirdly cannot be used without actually enabling AHCI BAR - what's the 
point?  My suspicion is that they designed it to work without AHCI BAR 
enabled but maybe some revisions screwed up and ICH7 still had PCS 
presence bits working, so the weird result.

I don't have ICH8 docs but, again, my guess is that they've got the 
window register correct this time and determined to screw PCS presence 
bits.  All these suspicions and guesses need verification, but if my 
guesses are right, the solution would be...

* leave anything order than ICH6 as it is now
* trust PCS presence bits for ICH6/7
* use AHCI window register to access SStatus on ICH8

-- 
tejun
