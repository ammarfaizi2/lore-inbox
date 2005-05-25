Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVEYRaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVEYRaj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 13:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVEYRaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 13:30:39 -0400
Received: from imap.gmx.net ([213.165.64.20]:34435 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261505AbVEYRaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 13:30:30 -0400
X-Authenticated: #2813124
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Chris Wright <chrisw@osdl.org>
Subject: Re: [patch 02/16] 3c59x: only put the device into D3 when we're actually using WOL
Date: Wed, 25 May 2005 19:30:15 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
References: <20050523231529.GL27549@shell0.pdx.osdl.net> <20050523231813.GN27549@shell0.pdx.osdl.net>
In-Reply-To: <20050523231813.GN27549@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505251930.16089.daniel.ritz@gmx.ch>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

adding what i missed in the first place :)
Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>


On Tuesday 24 May 2005 01.18, Chris Wright wrote:
> During a warm boot the device is in D3 and has troubles coming out of it.
>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
>
> ---
>  drivers/net/3c59x.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
>
> --- linux-2.6.11.10.orig/drivers/net/3c59x.c	2005-05-20 09:34:18.788560304
> -0700 +++ linux-2.6.11.10/drivers/net/3c59x.c	2005-05-20 09:34:22.644974040
> -0700 @@ -1581,7 +1581,8 @@
>
>  	if (VORTEX_PCI(vp)) {
>  		pci_set_power_state(VORTEX_PCI(vp), PCI_D0);	/* Go active */
> -		pci_restore_state(VORTEX_PCI(vp));
> +		if (vp->pm_state_valid)
> +			pci_restore_state(VORTEX_PCI(vp));
>  		pci_enable_device(VORTEX_PCI(vp));
>  	}
>
> @@ -2741,6 +2742,7 @@
>  		outl(0, ioaddr + DownListPtr);
>
>  	if (final_down && VORTEX_PCI(vp)) {
> +		vp->pm_state_valid = 1;
>  		pci_save_state(VORTEX_PCI(vp));
>  		acpi_set_WOL(dev);
>  	}
> @@ -3243,9 +3245,10 @@
>  		outw(RxEnable, ioaddr + EL3_CMD);
>
>  		pci_enable_wake(VORTEX_PCI(vp), 0, 1);
> +
> +		/* Change the power state to D3; RxEnable doesn't take effect. */
> +		pci_set_power_state(VORTEX_PCI(vp), PCI_D3hot);
>  	}
> -	/* Change the power state to D3; RxEnable doesn't take effect. */
> -	pci_set_power_state(VORTEX_PCI(vp), PCI_D3hot);
>  }
