Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267650AbUHRUsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267650AbUHRUsQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 16:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267646AbUHRUsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 16:48:16 -0400
Received: from gprs214-253.eurotel.cz ([160.218.214.253]:52608 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S267690AbUHRUsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 16:48:03 -0400
Date: Wed, 18 Aug 2004 22:47:35 +0200
From: Pavel Machek <pavel@suse.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [patch] enums to clear suspend-state confusion
Message-ID: <20040818204735.GE5395@elf.ucw.cz>
References: <20040812120220.GA30816@elf.ucw.cz> <20040818061227.GA7854@elf.ucw.cz> <1092812149.9932.180.camel@gaston> <200408180817.17822.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408180817.17822.david-b@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The advantage of switching _now_ to enums is that it can be done
> without actually changing drivers ... however, there are actually
> two different suspend-state confusions.  That patch just affects
> the first of them, whereas it's the second which actively breaks
> things today:
> 
>  - Confusion #1 ... "generic" PM framework uses a u32, and the
>    meaning of that u32 has never been formally defined.
> 
>    In practice, most kernel code (except swsusp) passes an
>    enum there already ... PM_SUSPEND_* values, which are
>    unfortunately in an anonymous enum so there's no way
>    even a smartened "sparse" could report errors.
> 
>  - Confusion #2 ... PCI suspend calls use a u32, which has since
>    at least 2.4 meant a PCI power state.   Those values are not
>    the same as PM_SUSPEND_* values.
> 
>    PCI drivers that use that u32 are currently getting burnt by the
>    way PM_SUSPEND_* values get passed in when the drivers
>    expect a PCI power state.  Example, passing PM_SUSPEND_MEM
>    when the intention is PCI_D3hot (2 rather than 3).
> 
> I happen to think the _right_ fix involves switching from a scalar to
> something that recognizes {bus,device,driver}-specific PM states.

That would not provide enough info for the driver. 

> Such a switch would be extremely disruptive; it'd mean changing
> every driver.   So it's something I'd not rush into ... it'd be worth
> doing as part of fixing multiple holes in the PM framework.
> 
> Which leaves me thinking that the desirable near-term fix involves
> cleanup for #1, and minor sleight-of-hand to fix #2.  Something
> like the attached patch (untested) ... which would let us answer
> Andrew's "why?" question by pointing to some bugtraq IDs.

I believe correct fix for #2 is what I've done. Pass enum system_state
down to driver, and make them use to_pci_state() helper. Fix of driver
then looks like:

--- clean/drivers/net/e100.c	2004-06-22 12:36:10.000000000 +0200
+++ linux/drivers/net/e100.c	2004-08-18 08:21:23.000000000 +0200
@@ -2269,7 +2269,7 @@
 }
 
 #ifdef CONFIG_PM
-static int e100_suspend(struct pci_dev *pdev, u32 state)
+static int e100_suspend(struct pci_dev *pdev, enum system_state state)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct nic *nic = netdev_priv(netdev);
@@ -2282,7 +2282,7 @@
 	pci_save_state(pdev, nic->pm_state);
 	pci_enable_wake(pdev, state, nic->flags & (wol_magic | e100_asf(nic)));
 	pci_disable_device(pdev);
-	pci_set_power_state(pdev, state);
+	pci_set_power_state(pdev, to_pci_state(state));
 
 	return 0;
 }

> +enum system_state {
> +	PM_SUSPEND_ON = 0,
> +	PM_SUSPEND_STANDBY = 1,
> +	/* HACK ALERT:  PM_SUSPEND_MEM == PCI_D3cold */
> +	PM_SUSPEND_MEM = 3,
> +	PM_SUSPEND_DISK = 4,
>  	PM_SUSPEND_MAX,
>  };

Okay, I did not do this one. I'll probably just fix those drivers that
care, instead. The rest of patch was pretty much same as mine patch,
except:

> --- 1.86/kernel/power/swsusp.c	Thu Jul  1 22:23:48 2004
> +++ edited/kernel/power/swsusp.c	Wed Aug 18 07:48:04 2004
> @@ -699,7 +699,7 @@
>  	else
>  #endif
>  	{
> -		device_suspend(3);
> +		device_suspend(PM_SUSPEND_DISK);
>  		device_shutdown();
>  		machine_power_off();
>  	}

this is no longer neccessary. -mm swsusp already uses right constants.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
