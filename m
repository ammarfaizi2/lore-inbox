Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263433AbSIQAMX>; Mon, 16 Sep 2002 20:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263435AbSIQAMX>; Mon, 16 Sep 2002 20:12:23 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:23182 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263433AbSIQAMW> convert rfc822-to-8bit;
	Mon, 16 Sep 2002 20:12:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: "Mark Knecht" <mknecht@controlnet.com>, <linux-kernel@vger.kernel.org>
Subject: Re: APIC IRQs
Date: Mon, 16 Sep 2002 17:17:02 -0700
User-Agent: KMail/1.4.1
References: <000301c25da9$38b92870$b50aa8c0@mknecht>
In-Reply-To: <000301c25da9$38b92870$b50aa8c0@mknecht>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209161717.02057.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 September 2002 10:48 am, Mark Knecht wrote:
> Hi,
>    Sorry for the intrusion. I'm working in the Linux audio areas and am
> looking for information on how IRQ priorities are handled when using APIC
> under Linux. Google searches have not yielded much for me. I'm a hardware
> guy, so code stubs are probably not the best answer, but I'm interested in
> most anything on the subject.
>
>    Can someone point me towards any non-developer information on this
> subject? HOWTOs, explanations, whatever? Mostly just looking for how to
> best configure audio cards and disk controllers to get the lowest latencies
> in this specific application. I understand the traditional model quite
> well, so even a doc that talked about the differences would be very
> helpful.
>
>    Thanks in advance!
>
> With best regards,
> Mark
>

Mark,

The current Linux kernel does not use the Task Priority Register (TPR) to set 
interrupt priority levels in the classic Unix splX() fashion.  Instead, the 
TPR is set to zero at boot and left there for the life of the kernel.  (I 
have a patch out to change this.)

Linux interrupt routines are expected to be fast and return quickly, so the OS 
does do not use the priority hardware or enable interrupts during their 
execution.  One notable exception is the IDE interrupt handler when operating 
in port I/O mode.  It will re-enable interrupts while it is servicing an IDE 
device.

For APICs, when two interrupts are present when interrupts are enabled, the 
one with the highest interrupt vector number will be taken first.  Vectors 
are statically assigned to the PCI slots, starting at 0x40 or 0x41.  So, the 
last PCI interrupt source in the MPS table will be the highest priority.  
However, I don't think that the MPS table spec specifies any kind of order.  
The interrupt source records are sorted however the BIOS wishes.  Usually, 
they will be sorted by slot number, but that is not guaranteed.

ACPI's ordering is more predictable.  The last pin of the last I/O APIC 
mentioned in the PCI Routing Table (PRT) will have the highest vector number.

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

