Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbUDLVwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 17:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbUDLVwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 17:52:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16315 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263129AbUDLVwN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 17:52:13 -0400
Message-ID: <407B0F7F.5030205@pobox.com>
Date: Mon, 12 Apr 2004 17:51:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>
Subject: Re: 2.6.2-rc3: irq#19 - nobody cared - with an au88xx
References: <BF1FE1855350A0479097B3A0D2A80EE002F7B775@hdsmsx402.hd.intel.com> <20040407145929.GA1247@nevyn.them.org> <20040412185147.GA7717@nevyn.them.org> <20040412212838.GA1613@nevyn.them.org>
In-Reply-To: <20040412212838.GA1613@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz wrote:
> On Mon, Apr 12, 2004 at 02:51:47PM -0400, Daniel Jacobowitz wrote:
> 
>>[Jeff, I'm sending this to you because your name is above the Via PCI
>>quirks.  It's in a followup comment, though, so there's probably
>>someone else I should be talking to about the original quirks - I just
>>haven't worked out who yet.]
>>
>>I'm trying to track down an interrupt routing problem on my Via-chipset
>>motherboard (it's an Abit VP6).  The symptoms are that the USB and
>>audio drivers eat each other; it appears that they are on the same
>>IRQ line, even though /proc/interrupts says:
>> 11:     300000          0   IO-APIC-level  uhci_hcd, uhci_hcd
>> 19:     299999          1   IO-APIC-level  au8830
>>
>>So eventually one of them gets wedged on, and the other panics because
>>it can't identify the incoming interrupts.
>>
>>At boot I see this, from drivers/pci/quirks.c:
>>
>>PCI: Via IRQ fixup for 0000:00:07.2, from 5 to 11
>>PCI: Via IRQ fixup for 0000:00:07.3, from 5 to 11
>>
>>Is it possible that the same problem, i.e. writes to the INTERRUPT_LINE
>>register causing connection to the PIC, could apply to devices in the PCI
>>slots?  The register still shows 5 for the au8830, which is the IRQ it
>>gets assigned to if I boot without ACPI.
>>
>>I know this hypothesis sounds a little weak.  I'm running out of ideas
>>:)
> 
> 
> I've worked out the part of the problem involving that quirk.  There's
> an entry in quirks.c which reads:
> 
> /*
>  *      VIA northbridges care about PCI_INTERRUPT_LINE
>  */
> 
> int interrupt_line_quirk;
> 
> static void __devinit quirk_via_bridge(struct pci_dev *pdev)
> {
>         if(pdev->devfn == 0)
>                 interrupt_line_quirk = 1;
> }
> 
> The i386 pirq_enable_irq honors this:
>         /* VIA bridges use interrupt line for apic/pci steering across
>            the V-Link */
>         else if (interrupt_line_quirk)
>                 pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
> 
> The matching function in ACPI does not honor this quirk, so we probably
> have routing troubles on a lot of affected VIA northbridges.  There's
> at least one thing which looks like an example of this in Bugzilla
> (which was "fixed" by twiddling the IRQ balancing code).  With this
> patch I get a little better (more predictable, at least) behavior.


You're certainly on the right track.  Len and I have discussed how to 
best handle this in ACPI, I'll let him comment further...

	Jeff



