Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932617AbWJFUlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbWJFUlO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422943AbWJFUlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:41:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19400 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422939AbWJFUlM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:41:12 -0400
Date: Fri, 6 Oct 2006 13:41:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Amol Lad <amol@verismonetworks.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>,
       Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 5/5] ioremap balanced with iounmap for
 drivers/char/watchdog/s3c2410_wdt.c
Message-Id: <20061006134104.9bd4dcf1.akpm@osdl.org>
In-Reply-To: <1160110627.19143.88.camel@amol.verismonetworks.com>
References: <1160110627.19143.88.camel@amol.verismonetworks.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Oct 2006 10:27:07 +0530
Amol Lad <amol@verismonetworks.com> wrote:

> Signed-off-by: Amol Lad <amol@verismonetworks.com>
> ---
>  s3c2410_wdt.c |    5 +++++
>  1 files changed, 5 insertions(+)
> ---
> diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/drivers/char/watchdog/s3c2410_wdt.c linux-2.6.19-rc1/drivers/char/watchdog/s3c2410_wdt.c
> --- linux-2.6.19-rc1-orig/drivers/char/watchdog/s3c2410_wdt.c	2006-10-05 14:00:43.000000000 +0530
> +++ linux-2.6.19-rc1/drivers/char/watchdog/s3c2410_wdt.c	2006-10-05 14:50:00.000000000 +0530
> @@ -381,18 +381,21 @@ static int s3c2410wdt_probe(struct platf
>  	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>  	if (res == NULL) {
>  		printk(KERN_INFO PFX "failed to get irq resource\n");
> +		iounmap(wdt_base);
>  		return -ENOENT;
>  	}
>  
>  	ret = request_irq(res->start, s3c2410wdt_irq, 0, pdev->name, pdev);
>  	if (ret != 0) {
>  		printk(KERN_INFO PFX "failed to install irq (%d)\n", ret);
> +		iounmap(wdt_base);
>  		return ret;
>  	}
>  
>  	wdt_clock = clk_get(&pdev->dev, "watchdog");
>  	if (wdt_clock == NULL) {
>  		printk(KERN_INFO PFX "failed to find watchdog clock source\n");
> +		iounmap(wdt_base);
>  		return -ENOENT;
>  	}
>  
> @@ -416,6 +419,7 @@ static int s3c2410wdt_probe(struct platf
>  	if (ret) {
>  		printk (KERN_ERR PFX "cannot register miscdev on minor=%d (%d)\n",
>  			WATCHDOG_MINOR, ret);
> +		iounmap(wdt_base);
>  		return ret;
>  	}
>  

barf.  That function has to set the record for the
number-of-return-statements-per-line.  There are good reasons why we prefer
to have a single return point at which to handle all the error unwinding,
and the above patch illustrates one of them.

Sigh.  Oh well, patch looks correct - I'll start spamming Wim with it,
thanks.

(Not that Wim - this Wim).

