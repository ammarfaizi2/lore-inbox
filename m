Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbVISWnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbVISWnt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 18:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbVISWnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 18:43:49 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:46737 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964774AbVISWnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 18:43:49 -0400
Message-ID: <432F3F11.69973A36@sgi.com>
Date: Mon, 19 Sep 2005 17:43:29 -0500
From: Mike Habeck <habeck@sgi.com>
Organization: SGI
X-Mailer: Mozilla 4.8C-SGI [en] (X11; U; IRIX64 6.5 IP35)
X-Accept-Language: en
MIME-Version: 1.0
To: Jack Steiner <steiner@sgi.com>, linux-kernel@vger.kernel.org
CC: tony.luck@gmail.com, linville@tuxdriver.com
Subject: Re: 2.6.14-rc1 breaks tg3 on ia64
References: <20050919204523.GD15838@sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack Steiner wrote:
> On Sat, Sep 17, 2005 at 09:16:17AM -0700, Greg KH wrote:
> > On Sat, Sep 17, 2005 at 11:59:14AM -0400, John W. Linville wrote:
> > > On Sat, Sep 17, 2005 at 08:47:03AM -0700, Tony Luck wrote:
> > > > > >So does reverting this patch solve the problem?
> > > > >
> > > > > I reversing
> > > > > http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=064b53dbcc977dbf2753a67c2b8fc1c061d74f21,
> > > > > which appears to be the latest version of this patch.  There was a
> > > > > patch reject in sparc64, but the common code was reverted.  IA64 (SGI
> > > > > Altix) with that patch reverted now boots 2.6.14-rc1.
> > > >
> > > > Anyone know anything more about this problem?  I'm not seeing it
> > > > on any of my systems ... so perhaps it only affects cards with a
> > > > PCI bridge on them, or cards that haven't already been initialized
> > > > by EFI.
> > >
> > > I posted a patch on Wednesday:
> > >
> > >     http://www.ussg.iu.edu/hypermail/linux/kernel/0509.1/2193.html
> > >
> > > The original reporter (Keith Owens <kaos@sgi.com>) confirmed this
> > > patch to fix the problem.
> >
> > Yes, and a number of people objected to that patch.  Care to respond to
> > them?
> 
> We are working on an SN-only workaround. No guarantee, but the person
> working on it is optimistic that we can fix the problem in SN code
> w/o making any generic changes. I should know more on Monday.
> 
> Long term, we are making SN ACPI compliant - or at leeast a lot closer.


As Jack stated above, the issue is that sgi isn't fully ACPI 
compliant yet.  On a SN platform the pci_controller->pci_window's 
are not initialized...so routines like pcibios_resource_to_bus() 
and pcibios_bus_to_resource() will not work.  It is this reason 
why the pci_restore_bars() call, added to pci_set_power_state(), 
is causing a problem on SN platforms. 

SGIs long term goal is to become ACPI compliant, but until that 
happens sgi need to somehow prevent things that rely on the 
pci_controller->pci_window's from being called.  John Linville 
latest patch, the one that "restricts calling pci_restore_bars 
unless the current state is PCI_UNKNOWN and the actual state of 
the device is PCI_D3hot..." does that.  I don't understand why 
this is wrong (why is checking the physical/actual state of the 
device unattractive?  Why restore the BARs if it's unnecessary)?  
Anyhow, if this patch gets pulled then sgi will needs to do 
something quick and dirty in the SN specific code to prevent 
pci_restore_bars() from getting called.  Like hack 
sn_pci_fixup_slot() to set the current_state to PCI_D0:

--- arch/ia64/sn/kernel/io_init.c       2005-09-19 17:11:11 -05:00
+++ arch/ia64/sn/kernel/io_init.c.org   2005-09-19 17:10:40 -05:00
@@ -329,8 +329,6 @@
                SN_PCIDEV_INFO(dev)->pdi_sn_irq_info = NULL;
                kfree(sn_irq_info);
        }
-
-       dev->current_state = PCI_D0;

And yes, I understand this is just putting a Band-Aid on the 
current problem... until the ACPI support is in place to init
the controller's pci_windows we're just asking for future
problems.

So is hacking the SN specific code to initialize the device's 
state to PCI_DO more attractive than keeping John Linville current 
patch?  As I said, I personally see nothing wrong with John 
Linville current patch to check the actual state of the device.

-mike habeck
