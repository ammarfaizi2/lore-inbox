Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbVCBGW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVCBGW2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 01:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbVCBGW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 01:22:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1477 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262196AbVCBGWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 01:22:23 -0500
Message-ID: <42255B8E.3010507@pobox.com>
Date: Wed, 02 Mar 2005 01:22:06 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: panagiotis.issaris@mech.kuleuven.ac.be
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Possible AMD8111e free irq issue
References: <20050228140742.A29902@lumumba.luc.ac.be>
In-Reply-To: <20050228140742.A29902@lumumba.luc.ac.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Panagiotis Issaris wrote:
> Hi,
> 
> It seems to me that if in the amd8111e_open() fuction dev->irq isn't
> zero and the irq request succeeds it might not get released anymore.
> 
> Specifically, on failure of the amd8111e_restart() call the function
> returns -ENOMEM without releasing the irq. The amd8111e_restart()
> function can fail because of various pci_alloc_consistent() and
> dev_alloc_skb() calls in amd8111e_init_ring() which is being
> called by amd8111e_restart.
> 
> 1374     if(dev->irq ==0 || request_irq(dev->irq, amd8111e_interrupt, SA_SHIRQ,
> 1375                      dev->name, dev))
> 1376         return -EAGAIN;
> 	
> The patch applies to 2.6.11-rc5-bk2. 
> 
> If I'm right about the above, I'm not I'm not sure if the free_irq() should
> happen before or after releasing the spinlock.
> 
> With friendly regards,
> Takis
> 
> diff -uprN linux-2.6.11-rc5-bk2/drivers/net/amd8111e.c linux-2.6.11-rc5-bk2-pi/drivers/net/amd8111e.c
> --- linux-2.6.11-rc5-bk2/drivers/net/amd8111e.c	2005-02-28 13:44:46.000000000 +0100
> +++ linux-2.6.11-rc5-bk2-pi/drivers/net/amd8111e.c	2005-02-28 13:45:09.000000000 +0100
> @@ -1381,6 +1381,8 @@ static int amd8111e_open(struct net_devi
>  
>  	if(amd8111e_restart(dev)){
>  		spin_unlock_irq(&lp->lock);
> +		if (dev->irq)
> +			free_irq(dev->irq, dev);
>  		return -ENOMEM;

Yes, this is a needed fix.  Thanks.

	Jeff



