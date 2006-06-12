Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWFMMrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWFMMrm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 08:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWFMMrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 08:47:42 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:785 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1750754AbWFMMrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 08:47:42 -0400
Date: Mon, 12 Jun 2006 08:12:45 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Adam Belay <abelay@novell.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 5/9] PCI PM: remove PCI_D3cold, PCI_UNKNOWN, and PCI_POWER_ERROR
Message-ID: <20060612081245.GB4950@ucw.cz>
References: <1149497169.7831.159.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149497169.7831.159.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> PCI_D3cold is not a software enter-able power state.  Rather, it's the
> state a card enters when Vcc is removed.  Moreover, PCI power management

Well, you admit it may be useful in future, still you do big
search&replace to remove it... I do not think we want that.

(Maybe removing D3cold is useful, but even if it is, please don't
rename D3hot).

> does not have any error reporting or failure states.  This patch removes

No, but we want something to return when error happens in
pci_choose_state.

> diff -urN a/drivers/pci/pm.c b/drivers/pci/pm.c
> --- a/drivers/pci/pm.c	2006-06-04 01:38:35.000000000 -0400
> +++ b/drivers/pci/pm.c	2006-06-04 01:38:10.000000000 -0400
> @@ -168,11 +163,6 @@
>  		pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
>  		pmcsr |= state;
>  		break;
> -	case PCI_UNKNOWN: /* Boot-up */
> -		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D3hot
> -		 && !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
> -			need_restore = 1;
> -		/* Fall-through: force to D0 */
>  	default:
>  		pmcsr = 0;
>  		break;

So how do you handle bootup?

> @@ -197,21 +187,6 @@
>  
>  	dev->current_state = state;
>  
> -	/* According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT
> -	 * INTERFACE SPECIFICATION, REV. 1.2", a device transitioning
> -	 * from D3hot to D0 _may_ perform an internal reset, thereby
> -	 * going to "D0 Uninitialized" rather than "D0 Initialized".
> -	 * For example, at least some versions of the 3c905B and the
> -	 * 3c556B exhibit this behaviour.
> -	 *
> -	 * At least some laptop BIOSen (e.g. the Thinkpad T21) leave
> -	 * devices in a D3hot state at boot.  Consequently, we need to
> -	 * restore at least the BARs so that the device will be
> -	 * accessible to its driver.
> -	 */
> -	if (need_restore)
> -		pci_restore_bars(dev);
> -
>  	return 0;
>  }
>  

This does not really belong to this patchset....?

						Pavel
-- 
Thanks for all the (sleeping) penguins.
