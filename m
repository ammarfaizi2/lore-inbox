Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263120AbUDLV2o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 17:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263121AbUDLV2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 17:28:44 -0400
Received: from nevyn.them.org ([66.93.172.17]:44160 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S263120AbUDLV2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 17:28:40 -0400
Date: Mon, 12 Apr 2004 17:28:38 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Cc: "Brown, Len" <len.brown@intel.com>
Subject: Re: 2.6.2-rc3: irq#19 - nobody cared - with an au88xx
Message-ID: <20040412212838.GA1613@nevyn.them.org>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE002F7B775@hdsmsx402.hd.intel.com> <20040407145929.GA1247@nevyn.them.org> <20040412185147.GA7717@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040412185147.GA7717@nevyn.them.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2004 at 02:51:47PM -0400, Daniel Jacobowitz wrote:
> [Jeff, I'm sending this to you because your name is above the Via PCI
> quirks.  It's in a followup comment, though, so there's probably
> someone else I should be talking to about the original quirks - I just
> haven't worked out who yet.]
> 
> I'm trying to track down an interrupt routing problem on my Via-chipset
> motherboard (it's an Abit VP6).  The symptoms are that the USB and
> audio drivers eat each other; it appears that they are on the same
> IRQ line, even though /proc/interrupts says:
>  11:     300000          0   IO-APIC-level  uhci_hcd, uhci_hcd
>  19:     299999          1   IO-APIC-level  au8830
> 
> So eventually one of them gets wedged on, and the other panics because
> it can't identify the incoming interrupts.
> 
> At boot I see this, from drivers/pci/quirks.c:
> 
> PCI: Via IRQ fixup for 0000:00:07.2, from 5 to 11
> PCI: Via IRQ fixup for 0000:00:07.3, from 5 to 11
> 
> Is it possible that the same problem, i.e. writes to the INTERRUPT_LINE
> register causing connection to the PIC, could apply to devices in the PCI
> slots?  The register still shows 5 for the au8830, which is the IRQ it
> gets assigned to if I boot without ACPI.
> 
> I know this hypothesis sounds a little weak.  I'm running out of ideas
> :)

I've worked out the part of the problem involving that quirk.  There's
an entry in quirks.c which reads:

/*
 *      VIA northbridges care about PCI_INTERRUPT_LINE
 */

int interrupt_line_quirk;

static void __devinit quirk_via_bridge(struct pci_dev *pdev)
{
        if(pdev->devfn == 0)
                interrupt_line_quirk = 1;
}

The i386 pirq_enable_irq honors this:
        /* VIA bridges use interrupt line for apic/pci steering across
           the V-Link */
        else if (interrupt_line_quirk)
                pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);

The matching function in ACPI does not honor this quirk, so we probably
have routing troubles on a lot of affected VIA northbridges.  There's
at least one thing which looks like an example of this in Bugzilla
(which was "fixed" by twiddling the IRQ balancing code).  With this
patch I get a little better (more predictable, at least) behavior.

===== drivers/acpi/pci_irq.c 1.26 vs edited =====
--- 1.26/drivers/acpi/pci_irq.c	Thu Apr  1 04:03:21 2004
+++ edited/drivers/acpi/pci_irq.c	Mon Apr 12 16:42:17 2004
@@ -328,6 +328,7 @@
 acpi_pci_irq_enable (
 	struct pci_dev		*dev)
 {
+	extern int interrupt_line_quirk;
 	int			irq = 0;
 	u8			pin = 0;
 
@@ -379,6 +380,11 @@
  	}
 
 	dev->irq = irq;
+
+	/* VIA bridges use interrupt line for apic/pci steering across
+	   the V-Link.  */
+	if (interrupt_line_quirk)
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device %s using IRQ %d\n", pci_name(dev), dev->irq));
 



On the down side, this doesn't fix everything.  I can observe that with
XMMS paused and my USB trackball untouched, I get no interrupts to
either the au88xx's IRQ or the UHCI's IRQ.  But with the sound playing,
I get about 1.8 times as many IRQs reported to the USB controller as I
do to the sound card!  I assume vice versa is true also, though I can't
check right now (both are wedged again).

Something else is still cross-connecting the USB IRQ (11) and the
au88xx IRQ (19).  I had hoped it was the above problem, but it appears
not.  I hand-verified that PCI_INTERRUPT_LINE now agrees with
/proc/interrupts for everything - except for the bridge itself; Jeff
Garzik's comment in quirks.c suggests that this is expected.

Any ideas on what could cause this are much appreciated.  Should I use
bugzilla to track this problem?

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
