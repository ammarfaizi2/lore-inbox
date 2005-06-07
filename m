Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVFGWRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVFGWRW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 18:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVFGWRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 18:17:22 -0400
Received: from mail.dvmed.net ([216.237.124.58]:39887 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262013AbVFGWRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 18:17:14 -0400
Message-ID: <42A61CDE.6090906@pobox.com>
Date: Tue, 07 Jun 2005 18:17:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       roland@topspin.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi()
 for drivers - take 2
References: <20050607002045.GA12849@suse.de> <20050607202129.GB18039@kroah.com>
In-Reply-To: <20050607202129.GB18039@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> @@ -6047,7 +6046,7 @@
>  		if (!(tp->tg3_flags & TG3_FLAG_TAGGED_STATUS)) {
>  			printk(KERN_WARNING PFX "%s: MSI without TAGGED? "
>  			       "Not using MSI.\n", tp->dev->name);
> -		} else if (pci_enable_msi(tp->pdev) == 0) {
> +		} else if (pci_in_msi_mode(tp->pdev)) {
>  			u32 msi_mode;
>  
>  			msi_mode = tr32(MSGINT_MODE);
> @@ -6063,15 +6062,12 @@
>  		if (tp->tg3_flags & TG3_FLAG_TAGGED_STATUS)
>  			fn = tg3_interrupt_tagged;
>  
> +		pci_disable_msi(tp->pdev);
>  		err = request_irq(tp->pdev->irq, fn,
>  				  SA_SHIRQ | SA_SAMPLE_RANDOM, dev->name, dev);
>  	}
>  
>  	if (err) {
> -		if (tp->tg3_flags2 & TG3_FLG2_USING_MSI) {
> -			pci_disable_msi(tp->pdev);
> -			tp->tg3_flags2 &= ~TG3_FLG2_USING_MSI;
> -		}
>  		tg3_free_consistent(tp);
>  		return err;
>  	}


If the driver has to _undo_ something that it did not do, that's pretty 
lame.  Non-orthogonal.

Also, it looks like all the PCI MSI drivers need touching for this 
scheme -- which defeats the original intention.  At this rate, the best 
API is the one we've already got.

	Jeff


