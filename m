Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVCZTHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVCZTHO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 14:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVCZTHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 14:07:13 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:20928 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261230AbVCZTGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 14:06:54 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: 2.6.12-rc1-mm3: box hangs solid on resume from disk while resuming device drivers
Date: Sat, 26 Mar 2005 20:07:02 +0100
User-Agent: KMail/1.7.1
Cc: "Andrew Morton" <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>,
       linux-kernel@vger.kernel.org, "Pavel Machek" <pavel@suse.cz>
References: <16A54BF5D6E14E4D916CE26C9AD30575017EDC38@pdsmsx402.ccr.corp.intel.com> <200503251519.22680.rjw@sisk.pl> <200503261923.52020.rjw@sisk.pl>
In-Reply-To: <200503261923.52020.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503262007.03441.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 26 of March 2005 19:23, Rafael J. Wysocki wrote:
> Hi,
> 
> On Friday, 25 of March 2005 15:19, Rafael J. Wysocki wrote: 
> > On Friday, 25 of March 2005 13:54, you wrote:
> > ]--snip--[
> > > >My box is still hanged solid on resume (swsusp) by the drivers:
> > > >
> > > >ohci_hcd
> > > >ehci_hcd
> > > >yenta_socket
> > > >
> > > >possibly others, too.  To avoid this, I had to revert the following
> > > patch from the Len's tree:
> > > >
> > > >diff -Naru a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> > > >--- a/drivers/acpi/pci_link.c	2005-03-24 04:57:27 -08:00
> > > >+++ b/drivers/acpi/pci_link.c	2005-03-24 04:57:27 -08:00
> > > >@@ -72,10 +72,12 @@
> > > > 	u8			active;			/* Current IRQ
> > > */
> > > > 	u8			edge_level;		/* All IRQs */
> > > > 	u8			active_high_low;	/* All IRQs */
> > > >-	u8			initialized;
> > > > 	u8			resource_type;
> > > > 	u8			possible_count;
> > > > 	u8			possible[ACPI_PCI_LINK_MAX_POSSIBLE];
> > > >+	u8			initialized:1;
> > > >+	u8			suspend_resume:1;
> > > >+	u8			reserved:6;
> > > > };
> > > >
> > > > struct acpi_pci_link {
> > > >@@ -530,6 +532,10 @@
> > > >
> > > > 	ACPI_FUNCTION_TRACE("acpi_pci_link_allocate");
> > > >
> > > >+	if (link->irq.suspend_resume) {
> > > >+		acpi_pci_link_set(link, link->irq.active);
> > > >+		link->irq.suspend_resume = 0;
> > > >+	}
> > > > 	if (link->irq.initialized)
> > > > 		return_VALUE(0);
> > > 
> > > How about just remove below line:
> > > >+		acpi_pci_link_set(link, link->irq.active);
> > 
> > You mean apply the patch again and remove just the single
> > line?  No effect (ie hangs).
> 
> It looks like removing this line couldn't help.
> 
> Apparently, acpi_pci_link_set(link, link->irq.active) must be called
> _before_ the call to pci_write_config_word() in
> drivers/pci/pci.c:pci_set_power_state(), because the box hangs
> otherwise.  However, with the patch applied,
> acpi_pci_link_set(link, link->irq.active) is only called through
> pcibios_enable_irq() in pcibios_enable_device(), which is _after_
> the call to pci_set_power_state() in pci_enable_device_bars(),
> so it's too late.
> 
> Hence, it seems, if you really want to get rid of the
> irqrouter_resume(), whatever the reason, the simplest fix
> seems to be to change the order of calls to pci_set_power_state()
> and pcibios_enable_device() in pci_enable_device_bars():

Sorry, forget it.  It was a good theory that didn't work.

It seems that we have to set all of the PCI links or at least some
of them before we start calling pci_set_power_state().

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
