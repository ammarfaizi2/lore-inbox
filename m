Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbVKPMXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbVKPMXo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 07:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbVKPMXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 07:23:44 -0500
Received: from barclay.balt.net ([195.14.162.78]:36530 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S1030302AbVKPMXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 07:23:43 -0500
Date: Wed, 16 Nov 2005 14:22:10 +0200
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Andrew Morton <akpm@osdl.org>,
       Alexandre Buisse <alexandre.buisse@ens-lyon.fr>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, yi.zhu@intel.com,
       jketreno@linux.intel.com
Subject: Re: Linuv 2.6.15-rc1
Message-ID: <20051116122210.GA31362@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <4378980C.7060901@ens-lyon.fr> <20051114162942.5b163558.akpm@osdl.org> <20051115100519.GA5567@gemtek.lt> <20051115115657.GA30489@gemtek.lt> <84144f020511150451l6ef30420g5a83a147c61f34a8@mail.gmail.com> <20051115140023.GB9910@gemtek.lt> <Pine.LNX.4.58.0511161130350.30203@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0511161130350.30203@sbz-30.cs.Helsinki.FI>
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pekka, 

recompiled kernel with a patch below. The same story, f/w loading errors
not found (somehow I was able to trigger that yesterday), saw several
f/w restarts and then everything is freezing. Just before freezing the
usual messages :

ipw2200: Unknown notification: subtype=40,flags=0xa0,size=40
ipw2200: Unknown notification: subtype=40,flags=0xa0,size=40 
ipw2200: Unknown notification: subtype=40,flags=0xa0,size=40
ipw2200: Firmware error detected.  Restarting.
ipw2200: Sysfs 'error' log already exists.

and freeeze ... :\ Sys-rq -T is at:
http://www.gemtek.lt/~zilvinas/dumps/trace.3

ipw2200 is stuck in ipw_request_direct_scan() in wpa_supplicant context.

ps.

Yesterday I've tried to reproduce the same problem at home (where I live
there are no access points at all). No crashes or freezes whatsoever.
Tortures had been like rmmod/insmod, run shell scripts forcing card to
scan constantly, running wpa_supplicant & kill -9 ... No luck too. No
slab or any other memory corruption related problems, rock stable. Then,
at work - it is here rather hostile environment , 18 APs are visible
through scanning:

$ /sbin/iwlist ath0 scan | grep ESSID | wc -l
18

Half of them are open (no encryption), other half WPA-PSK/WPA-RADIUS
enabled (WPA/WPA2 ... quite a mess really ...). Perhaps I should have
mentioned this earlier too. Well still quite a testing environment ...
:)


On Wed, Nov 16, 2005 at 11:33:44AM +0200, Pekka J Enberg wrote:
> Hi Zilvinas,
> 
> I think your device could be firing interrupts while we're taking 
> the error path in ipw_pci_probe().
> 
> Please back out the patch below:
> 
> On Tue, Nov 15, 2005 at 02:51:16PM +0200, Pekka Enberg wrote:
> > > Index: 2.6/arch/i386/kernel/traps.c
> > > ===================================================================
> > > --- 2.6.orig/arch/i386/kernel/traps.c
> > > +++ 2.6/arch/i386/kernel/traps.c
> > > @@ -185,8 +185,10 @@ void show_stack(struct task_struct *task
> > >  			printk("\n       ");
> > >  		printk("%08lx ", *stack++);
> > >  	}
> > > +#if 0
> > >  	printk("\nCall Trace:\n");
> > >  	show_trace(task, esp);
> > > +#endif
> > >  }
> > > 
> 
> And see if you can trigger the oops with the included patch applied. 
> Please leave the page and slab debugging config options on.
> 
> Thank you for testing!
> 
> 			Pekka
> 
> Index: 2.6/drivers/net/wireless/ipw2200.c
> ===================================================================
> --- 2.6.orig/drivers/net/wireless/ipw2200.c
> +++ 2.6/drivers/net/wireless/ipw2200.c
> @@ -11065,6 +11065,7 @@ static int ipw_pci_probe(struct pci_dev 
>  	return 0;
>  
>        out_remove_sysfs:
> +	ipw_disable_interrupts(priv);
>  	sysfs_remove_group(&pdev->dev.kobj, &ipw_attribute_group);
>        out_release_irq:
>  	free_irq(pdev->irq, priv);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
