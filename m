Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbVKPJdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbVKPJdy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 04:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbVKPJdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 04:33:54 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:21712 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1030254AbVKPJdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 04:33:53 -0500
Date: Wed, 16 Nov 2005 11:33:44 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Zilvinas Valinskas <zilvinas@gemtek.lt>
cc: Andrew Morton <akpm@osdl.org>,
       Alexandre Buisse <alexandre.buisse@ens-lyon.fr>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, yi.zhu@intel.com,
       jketreno@linux.intel.com
Subject: Re: Linuv 2.6.15-rc1
In-Reply-To: <20051115140023.GB9910@gemtek.lt>
Message-ID: <Pine.LNX.4.58.0511161130350.30203@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <4378980C.7060901@ens-lyon.fr>
 <20051114162942.5b163558.akpm@osdl.org> <20051115100519.GA5567@gemtek.lt>
 <20051115115657.GA30489@gemtek.lt> <84144f020511150451l6ef30420g5a83a147c61f34a8@mail.gmail.com>
 <20051115140023.GB9910@gemtek.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zilvinas,

I think your device could be firing interrupts while we're taking 
the error path in ipw_pci_probe().

Please back out the patch below:

On Tue, Nov 15, 2005 at 02:51:16PM +0200, Pekka Enberg wrote:
> > Index: 2.6/arch/i386/kernel/traps.c
> > ===================================================================
> > --- 2.6.orig/arch/i386/kernel/traps.c
> > +++ 2.6/arch/i386/kernel/traps.c
> > @@ -185,8 +185,10 @@ void show_stack(struct task_struct *task
> >  			printk("\n       ");
> >  		printk("%08lx ", *stack++);
> >  	}
> > +#if 0
> >  	printk("\nCall Trace:\n");
> >  	show_trace(task, esp);
> > +#endif
> >  }
> > 

And see if you can trigger the oops with the included patch applied. 
Please leave the page and slab debugging config options on.

Thank you for testing!

			Pekka

Index: 2.6/drivers/net/wireless/ipw2200.c
===================================================================
--- 2.6.orig/drivers/net/wireless/ipw2200.c
+++ 2.6/drivers/net/wireless/ipw2200.c
@@ -11065,6 +11065,7 @@ static int ipw_pci_probe(struct pci_dev 
 	return 0;
 
       out_remove_sysfs:
+	ipw_disable_interrupts(priv);
 	sysfs_remove_group(&pdev->dev.kobj, &ipw_attribute_group);
       out_release_irq:
 	free_irq(pdev->irq, priv);
