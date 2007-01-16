Return-Path: <linux-kernel-owner+w=401wt.eu-S1750999AbXAPTG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbXAPTG2 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 14:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbXAPTG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 14:06:27 -0500
Received: from tim.rpsys.net ([194.106.48.114]:46767 "EHLO tim.rpsys.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750914AbXAPTG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 14:06:27 -0500
Subject: Re: LEDS: S3C24XX generate name if none given
From: Richard Purdie <rpurdie@rpsys.net>
To: Ben Dooks <ben@trinity.fluff.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20070115154221.GH11889@trinity.fluff.org>
References: <20070115122654.GA25047@home.fluff.org>
	 <1168868669.5860.49.camel@localhost.localdomain>
	 <20070115154221.GH11889@trinity.fluff.org>
Content-Type: text/plain
Date: Tue, 16 Jan 2007 19:06:11 +0000
Message-Id: <1168974371.5841.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-15 at 15:42 +0000, Ben Dooks wrote:
> On Mon, Jan 15, 2007 at 01:44:28PM +0000, Richard Purdie wrote:
> > On Mon, 2007-01-15 at 12:26 +0000, Ben Dooks wrote:
> > > Generate a name if none is passed to the S3C24XX GPIO LED driver.
> > > 
> > > Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> > > 
>
> Ok, how about using kstrdup() on the name, like this:

Much better, thanks.

Acked-by: Richard Purdie <rpurdie@rpsys.net>

Creating a git tree to handle the LED patches properly is on my todo
list...

> diff -urpN -X ../dontdiff linux-2.6.19/drivers/leds/leds-s3c24xx.c linux-2.6.19-simtec1p22/drivers/leds/leds-s3c24xx.c
> --- linux-2.6.19/drivers/leds/leds-s3c24xx.c	2006-11-29 21:57:37.000000000 +0000
> +++ linux-2.6.19-simtec1p22/drivers/leds/leds-s3c24xx.c	2007-01-15 15:26:05.000000000 +0000
> @@ -59,6 +59,9 @@ static int s3c24xx_led_remove(struct pla
>  {
>  	struct s3c24xx_gpio_led *led = pdev_to_gpio(dev);
>  
> +	if (led->cdev.name != led->pdata.name)
> +		kfree(led->cdev.name);
> +
>  	led_classdev_unregister(&led->cdev);
>  	kfree(led);
>  
> @@ -85,6 +88,15 @@ static int s3c24xx_led_probe(struct plat
>  
>  	led->pdata = pdata;
>  
> +	/* create name if we were not passed one */
> +
> +	if (led->cdev.name == NULL) {
> +		char name[64];
> +
> +		snprintf(name, sizeof(name), "%s.%d",  dev->name, dev->id);
> +		led->cdev.name = kstrdup(name);
> +	}
> +
>  	/* no point in having a pull-up if we are always driving */
>  
>  	if (pdata->flags & S3C24XX_LEDF_TRISTATE) {
> 
> 

