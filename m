Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262278AbVCVCBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbVCVCBp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVCVB5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 20:57:41 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43657 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262284AbVCVBfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:35:50 -0500
Date: Tue, 22 Mar 2005 02:35:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: 2.6.12-rc1-mm1: Kernel BUG at pci:389
Message-ID: <20050322013535.GA1421@elf.ucw.cz>
References: <20050321025159.1cabd62e.akpm@osdl.org> <200503212343.31665.rjw@sisk.pl> <20050321160306.2f7221ec.akpm@osdl.org> <20050322004456.GB1372@elf.ucw.cz> <20050321170623.4eabc7f8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321170623.4eabc7f8.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > and that says:
> > 
> > #define PMSG_FREEZE     ((__force pm_message_t) 3)
> > 
> > ... I certainly have _FREEZE defined as 1 in my local tree, but I do
> > not see that change in -mm yet.
> 
> Both 2.6.12-rc1-mm1 and 2.6.12-rc1 have:
> 
> #define PMSG_FREEZE     ((__force pm_message_t) 3)
> #define PMSG_SUSPEND    ((__force pm_message_t) 3)
> #define PMSG_ON         ((__force pm_message_t) 0)
> 
> which looks odd.

Yes, but it is needed. There are many drivers, and they look at
numerical value of PMSG_*. I'm proceeding in steps. I hopefully killed
all direct accesses to the constants, and will switch constants to
something else... But that is going to be tommorow (need some sleep).

> > I reproduced it here.. I do not know who introduced
> > platform_pci_choose_state, but it is *very* wrong. It returns
> > it. Should it return pci_power_t? It probably should to match
> > pci_choose_state, but that int is retyped to pm_message_t. Oops.
> 
> That change came from Len.  I've appended the two relevant patches below.
> 
> So hm.  We have incompatible changes in flight.  That doesn't happen very
> often.
> 
> Could I suggest that you prepare a fixup against 2.6.12-rc1-mm1 and send
> that to Len and myself?  If that fixup is not suitable for a 2.6.12-rc1
> based tree then I can look after it until things get flushed out.

Could you just revert those two patches? First one is very
wrong. Second one might be fixed, but... See comments below.

And they are both "dangerous" -- they introduce new and untested
functionality while I'm trying to transition from int to
pm_message_t. They also affect all the drivers.

Len, please Cc me on patches that affect suspend.

> @@ -17,6 +17,7 @@
>  #include <acpi/acpi_bus.h>
>  
>  #include <linux/pci-acpi.h>
> +#include "pci.h"


Should be <linux/pci.h>?

> +static int acpi_pci_choose_state(struct pci_dev *pdev, pm_message_t state)
> +{

Should return pci_power_t, probably.

> +	char dstate_str[] = "_S0D";
> +	acpi_status status;
> +	unsigned long val;
> +	struct device *dev = &pdev->dev;
> +
> +	/* Fixme: the check is wrong after pm_message_t is a struct */

Exactly.

> +	if ((state >= PM_SUSPEND_MAX) || !DEVICE_ACPI_HANDLE(dev))

PM_SUSPEND_MAX and friends is going to disappear.

> +		return -EINVAL;
> +	dstate_str[2] += state;	/* _S1D, _S2D, _S3D, _S4D */

Ugh, assumes numerical values of states actually meaning anything. It
definitely should not. Should be switch(state.event), but that code
is not merged, yet.... => I'll send code that switches pm_message_t to
struct, tommorow. But it may compile-time break some obscure drivers...

> diff -Nru a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> --- a/drivers/pci/pci-acpi.c	2005-03-21 17:02:38 -08:00
> +++ b/drivers/pci/pci-acpi.c	2005-03-21 17:02:38 -08:00
> @@ -253,6 +253,24 @@
>  	return -ENODEV;
>  }
>  
> +static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
> +{
> +	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
> +	static int state_conv[] = {
> +		[0] = 0,
> +		[1] = 1,
> +		[2] = 2,
> +		[3] = 3,
> +		[4] = 3
> +	};
> +	int acpi_state = state_conv[(int __force) state];

The table should be
		[PCI_D0] = 0,
...

and then it should not need __force.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
