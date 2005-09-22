Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965240AbVIVGJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965240AbVIVGJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 02:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965238AbVIVGJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 02:09:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28864 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965237AbVIVGJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 02:09:56 -0400
Date: Wed, 21 Sep 2005 23:09:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove check_region from PnPWakeUp routine of Eepro ISA
 driver
Message-Id: <20050921230915.364f0ac9.akpm@osdl.org>
In-Reply-To: <20050922060030.GB19049@gollum.tnic>
References: <20050922060030.GB19049@gollum.tnic>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <petkov@uni-muenster.de> wrote:
>
>  Hi,
> 
>  The following patch removes the check_region call in the PnPWakeUp
>  path in the Eepro /10 ISA driver. Instead, now it calls request_region
>  for the PnP wake up routine and, after succeeding, it calls release_region
>  for the actual reservation of I/O ports takes place in the eepro_probe1() 
>  function straight afterwards.
> 
>  Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>
> 
> 
> --- drivers/net/eepro.c.orig	2005-09-22 06:20:28.000000000 +0200
> +++ drivers/net/eepro.c	2005-09-22 07:20:16.000000000 +0200
> @@ -552,7 +552,7 @@ static int __init do_eepro_probe(struct 
>  	{
>  		unsigned short int WS[32]=WakeupSeq;
>  
> -		if (check_region(WakeupPort, 2)==0) {
> +		if (request_region(WakeupPort, 2, DRV_NAME)) {
>  
>  			if (net_debug>5)
>  				printk(KERN_DEBUG "Waking UP\n");
> @@ -563,6 +563,8 @@ static int __init do_eepro_probe(struct 
>  				outb_p(WS[i],WakeupPort);
>  				if (net_debug>5) printk(KERN_DEBUG ": %#x ",WS[i]);
>  			}
> +			release_region(WakeupPort, 2);
> +
>  		} else printk(KERN_WARNING "Checkregion Failed!\n");
>  	}
>  #endif

hm, that's all a bit strange.  It would be better to do the
request_region() just once and if that works, retain the reservation rather
than releasing and reacquiring it.

That being said, the code you've modified is disabled due to
!defined(PnPWakeup), and the chances of anyone ever changing that are close
to zero.
