Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267936AbUHKEs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267936AbUHKEs5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 00:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267937AbUHKEs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 00:48:57 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:39872 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S267936AbUHKEsu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 00:48:50 -0400
From: David Brownell <david-b@pacbell.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: uhci-hcd oops with 2.4.27/ intel D845GLVA
Date: Tue, 10 Aug 2004 21:37:26 -0700
User-Agent: KMail/1.6.2
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, spam99@2thebatcave.com, <km@westend.com>
References: <1092142777.1042.30.camel@bart.intern> <mailman.1092163681.21436.linux-kernel2news@redhat.com> <20040810135409.44d31d1e@lembas.zaitcev.lan>
In-Reply-To: <20040810135409.44d31d1e@lembas.zaitcev.lan>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408102137.26004.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 August 2004 1:54 pm, Pete Zaitcev wrote:
> 
> The attached ought to fix Nick up (no way to tell about Kai because his
> report had no data). It consists of two things. First, it fixes the
> oops in the scan_async.

That's a NOP, ehci->async must never be null.

What oops?  The original post didn't include a stack...


> Second, it prevents the oops from happening by 
> ignoring the handoff failure (as the old code did, in effect). Either
> one should be sufficient, but this is why I use both. The if around
> scan_async is the right fix, so it's there on merit.

Erm, no that's a NOP.


> However, it yields 
> a non-working EHCI if your BIOS is buggy.

Depends on the particular bug you're hypothesizing is in
the BIOS ... the original bug was fixed by Dell's patch on at
least two different  motherboards.  So you seem to want
a slightly different BIOS bug to be worked around ...

 
> I know that David Brownlee disagrees with writing zero into the
> configuration space, but it looks safer to me, because old code
> did write that zero.

Dave who?  :)

Actually, I don't recall anyone providing a patch that addressing
that second type of BIOS bug before.  Makes sense to me to fall
back to that old Linux bug; why not!

- Dave


> 
> -- Pete
> 
> --- linux-2.4.27/drivers/usb/host/ehci-hcd.c	2004-08-10 13:43:36.691040600 
-0700
> +++ linux-2.4.21-17.EL-usb1/drivers/usb/host/ehci-hcd.c	2004-07-30 
16:21:12.000000000 -0700
> @@ -303,7 +302,8 @@
>  		if (cap & (1 << 16)) {
>  			ehci_err (ehci, "BIOS handoff failed (%d, %04x)\n",
>  				where, cap);
> -			return 1;
> +			pci_write_config_dword (ehci->hcd.pdev, where, 0);
> +			return 0;
>  		} 
>  		ehci_dbg (ehci, "BIOS handoff succeeded\n");
>  	}
> @@ -547,7 +547,8 @@
>  
>  	/* root hub is shut down separately (first, when possible) */
>  	spin_lock_irq (&ehci->lock);
> -	ehci_work (ehci, NULL);
> +	if (ehci->async)
> +		ehci_work (ehci, NULL);
>  	spin_unlock_irq (&ehci->lock);
>  	ehci_mem_cleanup (ehci);
>  
> 
