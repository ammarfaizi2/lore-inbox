Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262281AbVCVDSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbVCVDSw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 22:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVCVDSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 22:18:45 -0500
Received: from fmr20.intel.com ([134.134.136.19]:30157 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262281AbVCVDRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 22:17:12 -0500
Subject: Re: 2.6.12-rc1-mm1: Kernel BUG at pci:389
From: Li Shaohua <shaohua.li@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, rjw@sisk.pl,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
In-Reply-To: <20050322013535.GA1421@elf.ucw.cz>
References: <20050322013535.GA1421@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1111461253.18927.15.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 22 Mar 2005 11:14:13 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-22 at 09:35, Pavel Machek wrote:
> Hi!
> 
> > > and that says:
> > > 
> > > #define PMSG_FREEZE     ((__force pm_message_t) 3)
> > > 
> > > ... I certainly have _FREEZE defined as 1 in my local tree, but I
> do
> > > not see that change in -mm yet.
> > 
> > Both 2.6.12-rc1-mm1 and 2.6.12-rc1 have:
> > 
> > #define PMSG_FREEZE     ((__force pm_message_t) 3)
> > #define PMSG_SUSPEND    ((__force pm_message_t) 3)
> > #define PMSG_ON         ((__force pm_message_t) 0)
> > 
> > which looks odd.
> 
> Yes, but it is needed. There are many drivers, and they look at
> numerical value of PMSG_*. I'm proceeding in steps. I hopefully killed
> all direct accesses to the constants, and will switch constants to
> something else... But that is going to be tommorow (need some sleep).
The patches are going to acquire correct PCI device sleep state for
suspend/resume. We discussed the issue several months ago. My plan is we
first introduce 'platform_pci_set_power_state', then merge the
'platform_pci_choose_state' patch after Pavel's pm_message_t conversion
finished. Maybe Len mislead my comments. 

Anyway for the callback, my intend is platform_pci_choose_state accept
the pm_message_t parameter, and it return an 'int', since platform
method possibly failed and then pci_choose_state translate the return
value to pci_power_t.

> > > I reproduced it here.. I do not know who introduced
> > > platform_pci_choose_state, but it is *very* wrong. It returns
> > > it. Should it return pci_power_t? It probably should to match
> > > pci_choose_state, but that int is retyped to pm_message_t. Oops.
> > 
> > That change came from Len.  I've appended the two relevant patches
> below.
> > 
> > So hm.  We have incompatible changes in flight.  That doesn't happen
> very
> > often.
> > 
> > Could I suggest that you prepare a fixup against 2.6.12-rc1-mm1 and
> send
> > that to Len and myself?  If that fixup is not suitable for a
> 2.6.12-rc1
> > based tree then I can look after it until things get flushed out.
> 
> Could you just revert those two patches? First one is very
> wrong. Second one might be fixed, but... See comments below.
I think the platform_pci_set_power_state should be ok, did you see it
causes oops?

> 
> And they are both "dangerous" -- they introduce new and untested
> functionality while I'm trying to transition from int to
> pm_message_t. They also affect all the drivers.
> 
> Len, please Cc me on patches that affect suspend.
> 
> > @@ -17,6 +17,7 @@
> >  #include <acpi/acpi_bus.h>
> >  
> >  #include <linux/pci-acpi.h>
> > +#include "pci.h"
> 
> 
> Should be <linux/pci.h>?
I suppose it's not exported out side of PCI, so I used 'pci.h' 

> 
> > +static int acpi_pci_choose_state(struct pci_dev *pdev, pm_message_t
> state)
> > +{
> 
> Should return pci_power_t, probably.
Should return int as I said above.

> 
> > +     char dstate_str[] = "_S0D";
> > +     acpi_status status;
> > +     unsigned long val;
> > +     struct device *dev = &pdev->dev;
> > +
> > +     /* Fixme: the check is wrong after pm_message_t is a struct */
> 
> Exactly.
> 
> > +     if ((state >= PM_SUSPEND_MAX) || !DEVICE_ACPI_HANDLE(dev))
> 
> PM_SUSPEND_MAX and friends is going to disappear.
Yep, this should be fixed. 

> 
> > +             return -EINVAL;
> > +     dstate_str[2] += state; /* _S1D, _S2D, _S3D, _S4D */
> 
> Ugh, assumes numerical values of states actually meaning anything. It
> definitely should not. Should be switch(state.event), but that code
> is not merged, yet.... => I'll send code that switches pm_message_t to
> struct, tommorow. But it may compile-time break some obscure
> drivers...
> 
> > diff -Nru a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > --- a/drivers/pci/pci-acpi.c  2005-03-21 17:02:38 -08:00
> > +++ b/drivers/pci/pci-acpi.c  2005-03-21 17:02:38 -08:00
> > @@ -253,6 +253,24 @@
> >       return -ENODEV;
> >  }
> >  
> > +static int acpi_pci_set_power_state(struct pci_dev *dev,
> pci_power_t state)
> > +{
> > +     acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
> > +     static int state_conv[] = {
> > +             [0] = 0,
> > +             [1] = 1,
> > +             [2] = 2,
> > +             [3] = 3,
> > +             [4] = 3
> > +     };
> > +     int acpi_state = state_conv[(int __force) state];
> 
> The table should be
>                 [PCI_D0] = 0,
> ...
Ok, please revert the 'platform_pci_choose_pci' patch, I will add it
after Pavel's conversion is finished. Or after Pavel's is done, I can
send a quick fix.

Thanks,
Shaohua

