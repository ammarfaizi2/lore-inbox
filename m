Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWAPD27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWAPD27 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 22:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWAPD27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 22:28:59 -0500
Received: from tornado.reub.net ([202.89.145.182]:54473 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932196AbWAPD26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 22:28:58 -0500
Message-ID: <43CB12EA.3040309@reub.net>
Date: Mon, 16 Jan 2006 16:28:42 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060115)
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, Greg KH <greg@kroah.com>,
       linux-usb-devel@lists.sourceforge.net,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-acpi@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: 2.6.15-mm3 [USB lost interrupt bug]
References: <Pine.LNX.4.44L0.0601152212340.1929-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0601152212340.1929-100000@netrider.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2006 4:22 p.m., Alan Stern wrote:
> On Mon, 16 Jan 2006, Reuben Farrelly wrote:
> 
>> On 13/01/2006 4:53 a.m., Alan Stern wrote:
>>> On Thu, 12 Jan 2006, Reuben Farrelly wrote:
>>>
>>>>>> Initializing USB Mass Storage driver...
>>>>>> irq 193: nobody cared (try booting with the "irqpoll" option)
>>>>>> handlers:
>>>>>> [<c027017e>] (usb_hcd_irq+0x0/0x56)
>>>>>> Disabling IRQ #193
>>>>> USB lost its interrupt.  Could be USB, more likely ACPI.
>>>> I've seen this one happen nearly every boot since then including bootups that 
>>>> are otherwise OK (no oopses), so it's probably worth more looking into rather 
>>>> than being written off as a 'once off':
>>>>
>>>> uhci_hcd 0000:00:1d.3: Unlink after no-IRQ?  Controller is probably using the 
>>>> wrong IRQ.
> 
> Note the PCI ID is 1d.3 and the IRQ is 193.
> 
>> Hi Alan,
>>
>> If it's any use, here's some simply and easy-to-get information which may even 
>> be what you are looking for:
>>
>> [root@tornado dovecot]# uname -a
>> Linux tornado.reub.net 2.6.15-mm1 #1 SMP Sun Jan 8 03:42:25 NZDT 2006 i686 i686 
>> i386 GNU/Linux
>> [root@tornado ~]# cat /proc/interrupts
>>             CPU0       CPU1
>>    0:   21638510          0    IO-APIC-edge  timer
>>    4:        356          0    IO-APIC-edge  serial
>>    8:          1          0    IO-APIC-edge  rtc
>>    9:          0          0   IO-APIC-level  acpi
>>   14:          1          0    IO-APIC-edge  ide0
>>   50:          3          0   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb2
>> 169:        120          0   IO-APIC-level  uhci_hcd:usb5
>> 177:    2837992          0   IO-APIC-level  sky2
>> 185:      61450          0   IO-APIC-level  uhci_hcd:usb4, serial
>> 193:    4722447          0   IO-APIC-level  libata, uhci_hcd:usb3
> 
> Note that in the earlier kernel, IRQ 193 is assigned to usb3.  That's the 
> second UHCI controller, since usb1 is EHCI.
> 
>> [root@tornado ~]# lspci
> 
>> 00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
>> USB UHCI #1 (rev 03)
>> 00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
>> USB UHCI #2 (rev 03)
>> 00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
>> USB UHCI #3 (rev 03)
>> 00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
>> USB UHCI #4 (rev 03)
>> 00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
>> USB2 EHCI Controller (rev 03)
> 
> Note that 1d.3 is the fourth UHCI controller; the second is 1d.1.
> 
>> I guess this looks like it was assigned the same IRQ ?
> 
> I don't think so.  To be certain you'd have to check the boot-up log and
> verify that 1d.1 is usb3 and 1d.3 is usb5.
> 
> From the information presented here, it looks like -mm1 correctly routes
> the 1d.1 controller to IRQ 193 and the 1d.3 controller to IRQ 169, whereas
> -mm3 incorrectly routes the 1d.3 controller to IRQ 193.  That would make 
> it an ACPI problem.

Is this likely to be the same or similar issue to the IRQ 0 problem I see quite 
frequently on the SATA ports on later -mm releases?
(see http://www.ussg.iu.edu/hypermail/linux/kernel/0601.1/1851.html)

Reuben

