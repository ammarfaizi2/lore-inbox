Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423059AbWBBC7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423059AbWBBC7A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 21:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423066AbWBBC7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 21:59:00 -0500
Received: from pop-altamira.atl.sa.earthlink.net ([207.69.195.62]:42980 "EHLO
	pop-altamira.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1423059AbWBBC7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 21:59:00 -0500
Date: Wed, 1 Feb 2006 21:58:23 -0500 (EST)
From: kenneth topp <caught@prodigy.net>
X-X-Sender: toppk@static
To: linux-kernel@vger.kernel.org
cc: Tejun Heo <htejun@gmail.com>
Subject: Re: Broken sata (VIA) on Asus A8V (kernel 2.6.14+)
Message-ID: <Pine.LNX.4.64.0602012105110.30257@static>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm pretty close to finding irqbalance to be the reason for my similar 
timeouts.  still narrowing down with git bisect, but it's the only 
substantial thing left, which is the smp_affinity fix..

it's a 2.6.14.7 and ~2.6.15-rc4 change.

my timeouts don't occur immediately either.  So what do I look for when 
IRQ get misrouted?  Would it be a driver/device issue?  It seems like I 
have to go back to the point my kernel went MSI and patch it, then bisect 
all over again..

  As well as the ata timeouts leading to permanently D stated pdflushs, the 
other symptom I see is my usb mouse/keyboard occationally types really 
slowly, like 2400bps slow.


the patch that made this issue appear for me:

--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -1937,7 +1937,7 @@ static void ack_edge_ioapic_vector(unsig
{
int irq = vector_to_irq(vector);
- move_irq(vector);
+ move_native_irq(vector);
ack_edge_ioapic_irq(irq);
}
@@ -1952,7 +1952,7 @@ static void end_level_ioapic_vector (uns
{
int irq = vector_to_irq(vector);
- move_irq(vector);
+ move_native_irq(vector);
end_level_ioapic_irq(irq);
}

-

-my /proc/interrupts
   0:       3487    1817855    IO-APIC-edge  timer
   1:          0         60    IO-APIC-edge  i8042
   8:          0          1    IO-APIC-edge  rtc
   9:          0          0   IO-APIC-level  acpi
  14:        534     177341    IO-APIC-edge  ide0
  15:         96      64627    IO-APIC-edge  ide1
169:         16       9846   IO-APIC-level  libata
177:        877     643023   IO-APIC-level  libata, eth0, 
radeon@pci:0000:01:00.0
185:       1146     532391   IO-APIC-level  eth1
193:         16       8392   IO-APIC-level  eth2
201:        173     104730   IO-APIC-level  VIA8237
209:        177     103680   IO-APIC-level  uhci_hcd:usb1, uhci_hcd:usb2, 
uhci_hcd:usb3, ehci_hcd:usb4


Kenneth Topp


------

Vladimir B. Savkin wrote:
> On Thu, Feb 02, 2006 at 08:08:07AM +0900, Tejun Heo wrote:
>
>>Vladimir B. Savkin wrote:
>>
>>>Hello!
>>>
>>>My system based on Asus A8V (VIA chipset) works fine with 2.6.13.3,
>>>but after upgrading (kernels 2.6.14.7 and 2.6.15.1 tried) it
>>>gaves error messages some minutes after boot.
>>>
>>>The messages are as following:
>>> ata2: command 0xXX timeout, stat 0x50 host_stat 0x4
>>>where XX gets different values from time to time, 0x25 mostly.
>>>I/O to this controller halts after that.
>>>
>>>Attached are boot dmesg log and lspci output.
>>>
>>
>>How reproducible is the problem?  With how much certainty can you say
>>the problem is introduced by newer kernels?  e.g. If the problem occurs
>>most of the time with 2.5.15.1 but it stops happending after switching
>>back to 2.6.13.3, you can be pretty sure.
>
>
> Highly reproducible: months vs. minutes of uptime.
>
>

Your BMDMA controller is reporting raised interrupt (0x4) and your drive
is saying that it's ready for the next command, yet interrupt handler of
sata_via hasn't run and thus the timeout.  It looks like some kind of
IRQ routing problem to me although I have no idea how the problem
doesn't affect the boot process.

Can you try to boot with boot parameter pci=noacpi?

-- 
tejun
