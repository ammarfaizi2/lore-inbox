Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423807AbWLHB7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423807AbWLHB7p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423798AbWLHB7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:59:45 -0500
Received: from mga06.intel.com ([134.134.136.21]:32753 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423750AbWLHB7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:59:44 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,511,1157353200"; 
   d="scan'208"; a="171959861:sNHT23297960"
Date: Thu, 7 Dec 2006 17:58:27 -0800
From: Valerie Henson <val_henson@linux.intel.com>
To: Guido Classen <classeng@clagi.de>
Cc: jgarzik@pobox.com, tulip-users@lists.sourceforge.net,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/tulip/: fix for Lite-On 82c168 PNIC (2.6.11)
Message-ID: <20061208015827.GA8515@goober>
References: <45056015.1050205@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45056015.1050205@garzik.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there, Guido,

Jeff resurrected this patch from the misty depths of the past.  I
double-checked the docs and the first bug fix is definitely correct.
The second part isn't in the docs, but seems reasonable.  Is this
still the patch you are using?  Any comments you want to add?

-VAL

> From: Guido Classen <classeng@clagi.de>
> To: jgarzik@pobox.com, tulip-users@lists.sourceforge.net,
> 	linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
> Date: Fri, 01 Apr 2005 22:21:44 +0200
> Subject: [PATCH] drivers/net/tulip/: fix for Lite-On 82c168 PNIC (2.6.11)
> 
> Hi,
> 
> this small patch fixes two issues with the Lite-On 82c168 PNIC adapters.
> I've tested it with two cards in different machines both chip rev 17
> 
> The first is the wrong register address CSR6 for writing the MII register
> which instead is 0xB8 (this may get a symbol too?) (see similar exisiting 
> code
> at line 437) in tulip_core.c
> 
> At least by my cards, the the bit 31 from the MII register seems to be
> somewhat unstable. This results in reading wrong values from the 
> Phy-Registers
> und prevents the card from correct initialization. I've added a litte delay
> and an second test of the bit. If the bit is stil cleared the read/write
> process has definitely finished.
> 
> Cheers
>   Guido
> 
> Signed-off-by: Guido Classen <classeng@clagi.de>
> 
> diff -ru linux-2.6.11-org/drivers/net/tulip/tulip_core.c 
> linux-2.6.11.2-pentium/drivers/net/tulip/tulip_core.c
> --- linux-2.6.11-org/drivers/net/tulip/tulip_core.c	2005-04-01 
> 22:10:03.000000000 +0200
> +++ linux-2.6.11.2-pentium/drivers/net/tulip/tulip_core.c	2005-03-31 
> 23:14:11.000000000 +0200
> @@ -1701,8 +1701,8 @@
>  			tp->nwayset = 0;
>  			iowrite32(csr6_ttm | csr6_ca, ioaddr + CSR6);
>  			iowrite32(0x30, ioaddr + CSR12);
> -			iowrite32(0x0001F078, ioaddr + CSR6);
> -			iowrite32(0x0201F078, ioaddr + CSR6); /* Turn on 
> autonegotiation. */
> +			iowrite32(0x0001F078, ioaddr + 0xB8);
> +			iowrite32(0x0201F078, ioaddr + 0xB8); /* Turn on 
> autonegotiation. */
>  		}
>  		break;
>  	case MX98713:
> diff -ru linux-2.6.11-org/drivers/net/tulip/media.c 
> linux-2.6.11.2-pentium/drivers/net/tulip/media.c
> --- linux-2.6.11-org/drivers/net/tulip/media.c	2005-04-01 
> 22:10:03.000000000 +0200
> +++ linux-2.6.11.2-pentium/drivers/net/tulip/media.c	2005-04-01 
> 22:05:31.000000000 +0200
> @@ -74,8 +74,17 @@
>  		ioread32(ioaddr + 0xA0);
>  		while (--i > 0) {
>  			barrier();
> -			if ( ! ((retval = ioread32(ioaddr + 0xA0)) & 
> 0x80000000))
> -				break;
> +			if ( ! ((retval = ioread32(ioaddr + 0xA0))
> +                                & 0x80000000)) {
> +                                /* bug in 82c168 rev 17?
> +                                 * wait a little while and check if
> +                                 * bit 31 is still cleared */
> +                                udelay(10);
> +                                if ( ! ((retval = ioread32(ioaddr + 0xA0))
> +                                        & 0x80000000)) {
> +                                        break;
> +                                }
> +                        }
>  		}
>  		spin_unlock_irqrestore(&tp->mii_lock, flags);
>  		return retval & 0xffff;
> @@ -153,8 +162,16 @@
>  		iowrite32(cmd, ioaddr + 0xA0);
>  		do {
>  			barrier();
> -			if ( ! (ioread32(ioaddr + 0xA0) & 0x80000000))
> -				break;
> +			if ( ! (ioread32(ioaddr + 0xA0) & 0x80000000)) {
> +                                /* bug in 82c168 rev 17?
> +                                 * wait a little while and check if
> +                                 * bit 31 is still cleared */
> +                                udelay(10);
> +                                if ( ! (ioread32(ioaddr + 0xA0)
> +                                        & 0x80000000)) {
> +                                        break;
> +                                }
> +                        }
>  		} while (--i > 0);
>  		spin_unlock_irqrestore(&tp->mii_lock, flags);
>  		return;
> 
