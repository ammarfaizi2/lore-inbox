Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263444AbVGATrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbVGATrT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 15:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263443AbVGATrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 15:47:18 -0400
Received: from iron.pdx.net ([207.149.241.18]:58572 "EHLO iron.pdx.net")
	by vger.kernel.org with ESMTP id S263459AbVGATmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 15:42:10 -0400
Subject: Re: ASUS K8N-DL Beta BIOS
From: Sean Bruno <sean.bruno@dsl-only.net>
To: "Hodle, Brian" <BHodle@harcroschem.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'ipsoa@posiden.hopto.org'" <ipsoa@posiden.hopto.org>
In-Reply-To: <D9A1161581BD7541BC59D143B4A06294021FAAAF@KCDC1>
References: <D9A1161581BD7541BC59D143B4A06294021FAAAF@KCDC1>
Content-Type: text/plain
Date: Fri, 01 Jul 2005 12:42:06 -0700
Message-Id: <1120246927.2764.26.camel@home-lap>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2005-07-01 at 14:19 -0500, Hodle, Brian wrote:
> Sean,
>    You might get a laugh out of this! It's a reply from ASUS about the
> motherboard (this was 2 days b4 they released the 1004.7 BETA BIOS.
> 
> Pretty sad when ASUS tells you to "Clear your CMOS". I thought I asked a
> pretty straightforward tech question... Makes me wonder if they even read
> it, or they had a PERL script do it!
> 
> Ps. New BIOS didn't change a thing. The PCI Device names in the ACPI table
> are not entered in a fashion that the kernel recognizes. Maybe ASUS decided
> to 'optimize' routing by making a more efficient table?' nah..
> 
> Cheers,
> 
> -Brian
> 
This is pretty much the reaction that I am getting from calling ASUS
tech support.  They have told me on several occasions that they will
"call me back" and never do.  I am fairly certain that there is a
problem with the BIOS, but the kernel could be modified to ignore the
issue as a backup plan.

I received some insight from an individual at Nvidia that looks
something like this:

There are several issues immediately apparent with the BIOS.

It has an ACPI interrupt override for IRQ0 to Global System Interrupt 2
(GSI 2) that is incorrect -

ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)

and is the root cause of the later warnings to do with the timer:

..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
timer doesn't work through the IO-APIC - disabling NMI Watchdog!
...trying to set up timer as Virtual Wire IRQ...Uhhuh. NMI received for
unknown reason 3d.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
 failed.
...trying to set up timer as ExtINT IRQ... works.

The Linux kernel (2.6.9 onwards) contains code to specifically detect
this interrupt redirect on NVIDIA hardware, and ignore it, but for some
reason it isn't kicking in on your setup. Not sure why that is.

Also, the ACPI PCI Interrupt Routing Table (PRT) contains references to
entries that don't exist elsewhere in the ACPI tables:

ACPI: Subsystem revision 20050309
    ACPI-0352: *** Error: Looking up [\_SB_.PCI0.LNK0] in namespace,
AE_NOT_FOUND
search_node ffff81013ffca240 start_node ffff81013ffca240 return_node
0000000000000000
    ACPI-0352: *** Error: Looking up [\_SB_.PCI0.APC0] in namespace,
AE_NOT_FOUND
search_node ffff81013ffca140 start_node ffff81013ffca140 return_node
0000000000000000

Linux unfortunately appears to give up on parsing the PRT when this
happens, unlike Windows, which will parse the table despite these
errors. Without parsing the PRT, Linux cannot know how to route
interrupts for various PCI devices, which results in the later errors:

...
ACPI: PCI Interrupt 0000:02:00.0[A]: no GSI - using IRQ 3
...
ACPI: PCI Interrupt 0000:00:04.0[A]: no GSI - using IRQ 11

I'm guessing that your Broadcom networking, AC97 sound and USB 1.1
controller may not be working correctly as a result of this.

The Linux kernel could be modified to continue parsing PRTs when errors
are encountered. However, it is the BIOS that is at fault here.

Sean

