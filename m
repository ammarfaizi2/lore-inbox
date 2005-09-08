Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbVIHOwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbVIHOwy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 10:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbVIHOwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 10:52:54 -0400
Received: from tim.rpsys.net ([194.106.48.114]:32922 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751378AbVIHOwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 10:52:53 -0400
Subject: Re: [-mm patch 5/5] SharpSL: Add new ARM PXA machines Spitz and
	Borzoi with partial Akita Support
From: Richard Purdie <rpurdie@rpsys.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050908132340.D31595@flint.arm.linux.org.uk>
References: <1126007632.8338.130.camel@localhost.localdomain>
	 <20050908132340.D31595@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Thu, 08 Sep 2005 15:52:37 +0100
Message-Id: <1126191158.8147.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-08 at 13:23 +0100, Russell King wrote:
> On Tue, Sep 06, 2005 at 12:53:52PM +0100, Richard Purdie wrote:
> > +/*
> > + * MMC/SD Device
> > + *
> > + * The card detect interrupt isn't debounced so we delay it by HZ/4
> > + * to give the card a chance to fully insert/eject.
> > + */
> > +static struct mmc_detect {
> > +	struct timer_list detect_timer;
> > +	void *devid;
> > +} mmc_detect;
> 
> This isn't necessary.  The "devid" is in timer_list already - in the "data"
> element.  This is passed to the callback function as its only argument.
> Sure, it means a couple of extra casts, but that's an mis-feature we
> all know about in the timer API.  It should've been a void *.

This was done because I didn't like to assume:

> +static irqreturn_t spitz_mmc_detect_int(int irq, void *devid, struct pt_regs *regs)
> > +{
> > +	mmc_detect.devid=devid;
> 
> Also you don't need to set it each time.  devid will be a constan

Although if we're happy with that assumption (which I am), the
simplification can be made. 

Alternatively, would you accept a patch to add an optional delay option
to mmc_detect_change()? Something like the patch below but with all the
callers updated and the pxa platform data amended to pass the optional
delay. As a case for this, the same debounce timer is needed for corgi,
poodle, hx2750, spitz and tosa.

This also highlights that schedule_delayed_work() with delay=0 isn't
special cased which perhaps it should be?

Index: linux-2.6.13/drivers/mmc/mmc.c
===================================================================
--- linux-2.6.13.orig/drivers/mmc/mmc.c	2005-09-07 22:23:01.000000000 +0100
+++ linux-2.6.13/drivers/mmc/mmc.c	2005-09-07 22:40:03.000000000 +0100
@@ -1067,13 +1067,17 @@
 /**
  *	mmc_detect_change - process change of state on a MMC socket
  *	@host: host which changed state.
+ *	@delay: optional delay to wait before detection (jiffies)
  *
  *	All we know is that card(s) have been inserted or removed
  *	from the socket(s).  We don't know which socket or cards.
  */
-void mmc_detect_change(struct mmc_host *host)
+void mmc_detect_change(struct mmc_host *host, unsigned long delay)
 {
-	schedule_work(&host->detect);
+	if (delay)
+		schedule_delayed_work(&host->detect, delay);
+	else
+		schedule_work(&host->detect);
 }



