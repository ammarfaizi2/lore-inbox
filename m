Return-Path: <linux-kernel-owner+w=401wt.eu-S1750814AbXAOPm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbXAOPm2 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 10:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbXAOPm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 10:42:28 -0500
Received: from trinity.fluff.org ([217.147.94.151]:1080 "EHLO
	trinity.fluff.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbXAOPm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 10:42:27 -0500
Date: Mon, 15 Jan 2007 15:42:21 +0000
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org
Subject: Re: LEDS: S3C24XX generate name if none given
Message-ID: <20070115154221.GH11889@trinity.fluff.org>
References: <20070115122654.GA25047@home.fluff.org> <1168868669.5860.49.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168868669.5860.49.camel@localhost.localdomain>
X-Disclaimer: These are my views alone.
X-URL: http://www.fluff.org/
User-Agent: Mutt/1.5.9i
From: Ben Dooks <ben@trinity.fluff.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2007 at 01:44:28PM +0000, Richard Purdie wrote:
> On Mon, 2007-01-15 at 12:26 +0000, Ben Dooks wrote:
> > Generate a name if none is passed to the S3C24XX GPIO LED driver.
> > 
> > Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> > 
> > diff -urpN -X ../dontdiff linux-2.6.19/drivers/leds/leds-s3c24xx.c linux-2.6.19-simtec1p22/drivers/leds/leds-s3c24xx.c
> > --- linux-2.6.19/drivers/leds/leds-s3c24xx.c	2006-11-29 21:57:37.000000000 +0000
> > +++ linux-2.6.19-simtec1p22/drivers/leds/leds-s3c24xx.c	2007-01-04 10:22:58.000000000 +0000
> > @@ -23,6 +23,8 @@
> >  /* our context */
> >  
> >  struct s3c24xx_gpio_led {
> > +	char				 name[32];
> > +
> >  	struct led_classdev		 cdev;
> 
> I'm not that keen on this since it wastes 32 bytes per LED when the
> platform code does declare the names. If you're happy with that, its up
> to you as the platform maintainer I guess but is there no nicer way to
> handle this? I'm mainly concerned about people copying this code into
> other drivers as then they'll all end up doing it...

Ok, how about using kstrdup() on the name, like this:

diff -urpN -X ../dontdiff linux-2.6.19/drivers/leds/leds-s3c24xx.c linux-2.6.19-simtec1p22/drivers/leds/leds-s3c24xx.c
--- linux-2.6.19/drivers/leds/leds-s3c24xx.c	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.19-simtec1p22/drivers/leds/leds-s3c24xx.c	2007-01-15 15:26:05.000000000 +0000
@@ -59,6 +59,9 @@ static int s3c24xx_led_remove(struct pla
 {
 	struct s3c24xx_gpio_led *led = pdev_to_gpio(dev);
 
+	if (led->cdev.name != led->pdata.name)
+		kfree(led->cdev.name);
+
 	led_classdev_unregister(&led->cdev);
 	kfree(led);
 
@@ -85,6 +88,15 @@ static int s3c24xx_led_probe(struct plat
 
 	led->pdata = pdata;
 
+	/* create name if we were not passed one */
+
+	if (led->cdev.name == NULL) {
+		char name[64];
+
+		snprintf(name, sizeof(name), "%s.%d",  dev->name, dev->id);
+		led->cdev.name = kstrdup(name);
+	}
+
 	/* no point in having a pull-up if we are always driving */
 
 	if (pdata->flags & S3C24XX_LEDF_TRISTATE) {


-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

