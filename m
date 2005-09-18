Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbVIRLpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbVIRLpN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 07:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbVIRLpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 07:45:13 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:62901 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751179AbVIRLpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 07:45:11 -0400
Date: Sun, 18 Sep 2005 06:44:49 -0500
From: Jack Steiner <steiner@sgi.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: linville@tuxdriver.com, tony.luck@gmail.com, kaos@sgi.com, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: 2.6.14-rc1 breaks tg3 on ia64
Message-ID: <20050918114449.GA6733@sgi.com>
References: <25288.1126596450@kao2.melbourne.sgi.com> <12c511ca05091708476aa136cd@mail.gmail.com> <20050917155911.GB19854@tuxdriver.com> <20050917.232304.31192760.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050917.232304.31192760.davem@davemloft.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2005 at 11:23:04PM -0700, David S. Miller wrote:
> From: "John W. Linville" <linville@tuxdriver.com>
> Date: Sat, 17 Sep 2005 11:59:14 -0400
> 
> > I posted a patch on Wednesday:
> > 
> > 	http://www.ussg.iu.edu/hypermail/linux/kernel/0509.1/2193.html
> > 
> > The original reporter (Keith Owens <kaos@sgi.com>) confirmed this
> > patch to fix the problem.
> 
> It fixes the problem, but it's a hack, and I, perhaps like Tony,
> personally would like to know why the these IA64 systems break for
> such a simple operation such as writing some base registers with
> values we've probed already.

Here is the mail from Mike Habeck (sgi) - he understands the problem
muck better than I do:

(from Mike....)
The problem is we (sgi) don't support the ACPI pci_window stuff that
is setup via ACPI (see: add_window() code).  And as a result when
pci_restore_bars() is called to restore the BARs, instead of the BARs
getting "restored" they get wiped out.  (pci_restore_bars() calls
pci_update_resource() which calls pcibios_resource_to_bus()... it
is that routine that is expecting the pci_window stuff being set up
from the ACPI path... I think... (I don't know much about how the ACPI
stuff works, John or Aaron could probably prove me right or wrong)...
So John (or Aaron) is it ACPI that is suppose to setup this pci_window
stuff?

I still question why this code path is taken... I don't know anything
about the PCI Power Management stuff, but we shouldn't be in any power
state that results in us needing our BARs restored.  But I guess that
really isn't the issue since sooner or later something else will end
up using this pci_window stuff and we'll get burned them.

I suppose for a quick fix (to workaround this power management patch)
could be to set the PCI_PM_CTRL_NO_SOFT_RESET in the cards PM capability
down in PROM thus bypassing this "need_restore" code.

I suppose for a quick fix (to workaround this power management patch)
could be to set the PCI_PM_CTRL_NO_SOFT_RESET in the cards PM capability
down in PROM thus bypassing this "need_restore" code.

        /* If we're in D3, force entire word to 0.
         * This doesn't affect PME_Status, disables PME_En, and
         * sets PowerState to 0.
         */
        if (dev->current_state >= PCI_D3hot) {
                if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
                        need_restore = 1;
                pmcsr = 0;
        } else {
                pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
                pmcsr |= state;
        }

Or in the kernel sgi device fixup code change the current_state to D0?
It looks like it get's init'd to PCI_UNKNOWN (which is > PCI_D3hot)
I don't know... will investigate more tomorrow

-mike

-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


