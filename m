Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVC1BZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVC1BZj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 20:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbVC1BZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 20:25:39 -0500
Received: from fmr17.intel.com ([134.134.136.16]:47241 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261646AbVC1BZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 20:25:24 -0500
Subject: Re: 2.6.12-rc1-mm3: box hangs solid on resume from disk while
	resuming device drivers
From: Li Shaohua <shaohua.li@intel.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
       lkml <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
In-Reply-To: <200503261923.52020.rjw@sisk.pl>
References: <16A54BF5D6E14E4D916CE26C9AD30575017EDC38@pdsmsx402.ccr.corp.intel.com>
	 <200503251519.22680.rjw@sisk.pl>  <200503261923.52020.rjw@sisk.pl>
Content-Type: text/plain
Message-Id: <1111972933.28620.7.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 28 Mar 2005 09:22:13 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-27 at 02:23, Rafael J. Wysocki wrote:
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
> 
> --- old/drivers/pci/pci.c	2005-03-26 19:10:09.000000000 +0100
> +++ linux-2.6.12-rc1-mm2/drivers/pci/pci.c	2005-03-26 19:10:54.000000000 +0100
> @@ -442,9 +442,9 @@ pci_enable_device_bars(struct pci_dev *d
>  {
>  	int err;
>  
> -	pci_set_power_state(dev, PCI_D0);
>  	if ((err = pcibios_enable_device(dev, bars)) < 0)
>  		return err;
> +	pci_set_power_state(dev, PCI_D0);
>  	return 0;
>  }
>  
> though I'm not sure if that's legal.
Hmm, no, pci_set_power_state should be called before
pcibios_enable_device, otherwise enable_device may fail. This is very
strange. In boot time, there also are uninitialized link devices, I'm
wonder why the call of pci_enable_device_bars doesn't fail in boot time.
Did you find the bug only in specific system?

Could you please file a bug in bugzilla? I don't want to lose the
context of thread. And please attach your acpidmp output in the bug.

Thanks,
Shaohua

