Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266883AbUBEVlz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 16:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266818AbUBEVjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 16:39:35 -0500
Received: from gprs146-127.eurotel.cz ([160.218.146.127]:21633 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S266785AbUBEVjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 16:39:00 -0500
Date: Thu, 5 Feb 2004 22:38:37 +0100
From: Pavel Machek <pavel@suse.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: [PATCH] powernow-k8 max speed sanity check
Message-ID: <20040205213837.GF1541@elf.ucw.cz>
References: <20040131203512.GA21909@atomide.com> <20040203131432.GE550@openzaurus.ucw.cz> <20040205181704.GC7658@atomide.com> <20040205184841.GB590@elf.ucw.cz> <20040205213303.GA9757@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205213303.GA9757@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here's some comments after trying out your 2 patches. 
> 
> First, the PCMCIA patch worked great, I can now plug/unplug power cord with
> yenta_socket loaded :) Maybe now I can _haul_ this laptop to a cafe and use 
> the WLAN, hehe. In case anybody else needs them, I'll put the
> patches 

Good.

> The powernow-k8.c patch did not work, as my numpst is 8, not 3. So why not
> just ignore the numpst, as it is not used?

What are the BIOS people smoking? I thought they have left some old
tables there, but they keep updating them...


> Maybe replace this
> 
>  		if (psb->numpst != 1) {
>  			printk(KERN_ERR BFX "numpst must be 1\n");
> -			return -ENODEV;
> +			if (psb->numpst == 3) {
> +				printk(KERN_INFO PFX "assuming arima notebug\n");
> +				arima = 1;
> +			} else
> +				return -ENODEV;
>  		}
> 
> With this instead:
>  
>  		dprintk(KERN_DEBUG PFX "numpst: 0x%x\n", psb->numpst);
>  		if (psb->numpst != 1) {
> -			printk(KERN_ERR BFX "numpst must be 1\n");
> -			return -ENODEV;
> +			printk(KERN_WARNING BFX "numpst listed as %i "
> +			       "should be 1. Using 1.\n", psb->numpst);
>  		}

Well, I wanted some way to detect exactly this broken machine. You
might want to simply put == 8 there.. but proper solution is DMI blacklist. 

> I see a little problem with hardcoding the values:
> 
> +		if (arima) {
> +			ppst[1].fid = 0x8;
> +			ppst[1].vid = 0x6;
> +#ifdef THREE
> +			ppst[2].fid = 0xa;
> +			ppst[2].vid = 0x2;
> +#endif
>  		}
> 
> This would fail if I upgraded my CPU, right? 

Yes.

> What do you think about using module options maxfid and maxvid?

Well, the original BIOS has not only maximum values wrong, but also
1600MHz wrong, as far as I can tell...

Something like /proc/frequencies file would be needed where you could

echo "0 0xa; 0x8 0x6; 0xa 0x2" > /proc/frequencies to override. You
need to override all of them, not just top one.
							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
