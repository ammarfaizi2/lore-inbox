Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268667AbUHTTnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268667AbUHTTnJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 15:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268688AbUHTTnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 15:43:09 -0400
Received: from pegasus.allegientsystems.com ([208.251.178.236]:38926 "EHLO
	pegasus.lawaudit.com") by vger.kernel.org with ESMTP
	id S268667AbUHTTnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 15:43:00 -0400
Message-ID: <41265443.9050800@optonline.net>
Date: Fri, 20 Aug 2004 15:42:59 -0400
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040806
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
CC: stefandoesinger@gmx.at, acpi-devel@lists.sourceforge.net,
       "Brown, Len" <len.brown@intel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: [ACPI] [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
References: <88056F38E9E48644A0F562A38C64FB6002A934AC@scsmsx403.amr.corp.intel.com>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6002A934AC@scsmsx403.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pallipadi, Venkatesh wrote:

> The current theory I have for this issue is we resume pci_link driver
> A bit too late, which is causing this problem.
> 
> Say a particular device doesn't do anything for suspend and resume.
> So, as soon as we resume this particular device can start  
> generating interrupts. Once we have PIC enabled, it starts sending 
> interrupts and no one handles that original IRQ. As pci_link that 
> resumes later is reprogramming the device to different IRQ, where the 
> driver is handling the device.
> 
> That's probably the reason why it works with acpi=noirq or 
> modified DSDT. Does it make sense?

Yes. Sometimes acpi=noirq is gentler than ACPI irq mode, because the 
ACPI bios may not report the current active IRQ (which was assiged by 
the BIOS during boot) as a "possible" IRQ, even though the south bridge 
really supports just about any routing.

The result is that the kernel changes the routing when drivers are 
initialized during boot, and the kernel chooses one of the IRQ's from 
the possible list. However, during resume from S3, the BIOS will put the 
routing back the way it was at boot and the kernel has to change the 
routing again.

acpi=noirq mode doesn't change the hardware's current routing settings 
if an IRQ is already enabled, so there is less opportunity for things to 
get out of sync with what the device drivers are expecting.

Something else to watch out for on ICH2 and similar chipsets is that, as 
long as the IRQ router is steering a PCI link onto a certain IRQ, LPC 
ISA device are blocked from triggering that IRQ via the SERIRQ protocol. 
But if we move the all the PCI links elsewhere, the SERIRQ is no longer 
blocked, and if some ISA LPC device is holding a high level, which 
normally wouldn't trigger IRQ's under ISA, then the IRQ line will get 
disabled because the PIC is probably set to level-trigger because it was 
PCI at one point. I've seen this happen with IRQ 12 when the BIOS 
decided there was no PS/2 mouse present so it could re-use the IRQ. The 
real cause is that the i850 has  a register that allows IRQ1 and IRQ12 
to be disabled on the LPC bus, and this register isn't restored on 
resume. This probably doesn't apply to IRQ11 on Stefan's system, though...

> 
> I think we have to resume pci_link device before PIC. 

That's probably a good idea. If your theory is correct, then waiting 
until the PCI device drivers call pci_enable_device() may be too late, 
and we might have to do this early in boot. Ideally it wouldn't be a 
problem, because device drivers would all disable their devices on 
suspend, but there are driverless devices to worry about, and maybe also 
badly-behaved hardware that doesn't shut up?

Maybe it's time to look at the suspend/resume callbacks on the ipw2100 
driver, anyway.

Nathan

> We should be able to achieve this my changing the makefile orders.
> 
> Thanks,
> Venki
>  
> 

