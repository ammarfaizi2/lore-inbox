Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268179AbUIWRWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268179AbUIWRWp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 13:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268177AbUIWRVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 13:21:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:64469 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266457AbUIWRVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 13:21:12 -0400
Date: Thu, 23 Sep 2004 10:20:38 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       parisc-linux@parisc-linux.org
Subject: Re: [PATCH] Sort generic PCI fixups after specific ones
Message-ID: <20040923172038.GA8812@kroah.com>
References: <20040922214304.GS16153@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040922214304.GS16153@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2004 at 10:43:04PM +0100, Matthew Wilcox wrote:
> 
> The recent change that allowed PCI fixups to be declared everywhere
> broke IDE on PA-RISC by making the generic IDE fixup be applied before
> the PA-RISC specific one.  This patch fixes that by sorting generic fixups
> after the specific ones.  It also obeys the 80-column limit and reduces
> the amount of grotty macro code.
> 
> I'd like to thank Joel Soete for his work tracking down the source of
> this problem.
> 
> Index: linux-2.6/drivers/pci/quirks.c
> ===================================================================
> RCS file: /var/cvs/linux-2.6/drivers/pci/quirks.c,v
> retrieving revision 1.16
> diff -u -p -r1.16 quirks.c
> --- linux-2.6/drivers/pci/quirks.c	13 Sep 2004 15:23:21 -0000	1.16
> +++ linux-2.6/drivers/pci/quirks.c	22 Sep 2004 21:38:17 -0000
> @@ -543,7 +543,7 @@ static void __devinit quirk_cardbus_lega
>  		return;
>  	pci_write_config_dword(dev, PCI_CB_LEGACY_MODE_BASE, 0);
>  }
> -DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID,		PCI_ANY_ID,			quirk_cardbus_legacy );
> +DECLARE_PCI_FIXUP_FINAL_ALL(quirk_cardbus_legacy);

It looks like you are doing 2 different things here with this new macro.
Having it run last, and leting the user not type the PCI_ANY_ID macro
twice.  How about if you want to do a final final type pass, you mark it
as such, and not try to hide it in this manner.

And do we really want to call it "final final"?  What if we determine
that we need a "final final final" pass?  Can't you fix this with the
link order like was previously done?  I'd really prefer to not add
another level.

Oh, and cc:ing the pci maintainer might be nice next time :)

thanks,

greg k-h
