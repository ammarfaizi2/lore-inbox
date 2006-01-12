Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030332AbWALIym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbWALIym (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 03:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbWALIyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 03:54:41 -0500
Received: from tornado.reub.net ([202.89.145.182]:61385 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1030329AbWALIyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 03:54:40 -0500
Message-ID: <43C6194C.1070107@reub.net>
Date: Thu, 12 Jan 2006 21:54:36 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060111)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, jgarzik@pobox.com, Greg KH <greg@kroah.com>,
       linux-usb-devel@lists.sourceforge.net,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-acpi@vger.kernel.org
Subject: Re: 2.6.15-mm3 [USB lost interrupt bug]
References: <20060111042135.24faf878.akpm@osdl.org>	<43C5D537.7020800@reub.net> <20060111203332.50c45031.akpm@osdl.org>
In-Reply-To: <20060111203332.50c45031.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/01/2006 5:33 p.m., Andrew Morton wrote:

>> hub 5-0:1.0: USB hub found
>> hub 5-0:1.0: 2 ports detected
>> Initializing USB Mass Storage driver...
>> irq 193: nobody cared (try booting with the "irqpoll" option)
>>   [<c01041d9>] dump_stack+0x17/0x19
>>   [<c0139f47>] __report_bad_irq+0x27/0x83
>>   [<c013a021>] note_interrupt+0x7e/0x21d
>>   [<c0139af4>] __do_IRQ+0xd3/0xef
>>   [<c0105038>] do_IRQ+0x3d/0x57
>>   =======================
>>   [<c0103686>] common_interrupt+0x1a/0x20
>>   [<c0101bc4>] cpu_idle+0x63/0x78
>>   [<c0100615>] rest_init+0x23/0x2e
>>   [<c03d070f>] start_kernel+0x2ca/0x34b
>>   [<c0100210>] 0xc0100210
>> handlers:
>> [<c027017e>] (usb_hcd_irq+0x0/0x56)
>> Disabling IRQ #193
> 
> USB lost its interrupt.  Could be USB, more likely ACPI.

I've seen this one happen nearly every boot since then including bootups that 
are otherwise OK (no oopses), so it's probably worth more looking into rather 
than being written off as a 'once off':

uhci_hcd 0000:00:1d.3: Unlink after no-IRQ?  Controller is probably using the 
wrong IRQ.

Details:

dmesg-

ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 169, io base 0x0000d800


lspci -vv

00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #4 (rev 03) (prog-if 00 [UHCI])
         Subsystem: Intel Corporation Unknown device 4356
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin D routed to IRQ 169
         Region 4: I/O ports at d800 [size=32]


It's a new regression to -mm3.

For the ACPI people - I can't test with ACPI off because the machine won't boot 
without ACPI :(  [see 
http://www.ussg.iu.edu/hypermail/linux/kernel/0601.1/0044.html for what happens 
with acpi=off].
I'm not even sure if inability to boot with acpi=off is a bug or not - would 
appreciate if someone can let me know.

reuben
