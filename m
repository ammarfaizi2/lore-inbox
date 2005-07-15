Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263241AbVGOIbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbVGOIbf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 04:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263240AbVGOIbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 04:31:34 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26632 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263241AbVGOIbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 04:31:24 -0400
Date: Fri, 15 Jul 2005 09:31:15 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MMC host class
Message-ID: <20050715093114.B25428@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>
References: <42D538D4.7050803@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42D538D4.7050803@drzeus.cx>; from drzeus-list@drzeus.cx on Wed, Jul 13, 2005 at 05:52:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 05:52:52PM +0200, Pierre Ossman wrote:
> Create a mmc_host class to allow enumeration of MMC host controllers
> even though they have no card(s) inserted.
> 
> Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
> 
> (This will also allow cards to be enumerated by being able to find the
> hosts.)

> +static void mmc_host_class_dev_release(struct class_device *dev)
> +{
> +}
> +
> +static struct class mmc_host_class = {
> +	.name =		"mmc_host",
> +	.release =	&mmc_host_class_dev_release,
> +};

No no no no no.  Repeat after me ten times.  Empty or non-existant release
functions are bad and cause oopsen.  I will not create code which does
this.

> Index: linux-wbsd/include/linux/mmc/host.h
> ===================================================================
> --- linux-wbsd/include/linux/mmc/host.h	(revision 153)
> +++ linux-wbsd/include/linux/mmc/host.h	(working copy)
> @@ -69,6 +69,7 @@
>  
>  struct mmc_host {
>  	struct device		*dev;
> +	struct class_device	class_dev;
>  	struct mmc_host_ops	*ops;
>  	unsigned int		f_min;
>  	unsigned int		f_max;

What this means is that mmc_host itself becomes a refcounted sysfs
object which needs to follow the lifetime rules associated therewith.

Luckily, I thought about this earlier on, so there's a core mmc function
to allocate the beast, register it, unregister it, and finally free it.

The allocation function should initialise class_dev as much as possible.
The registration function should add the class device with the class
model.  The unregistration should remove the class device from the class
model, but _not_ free it.  The free function should drop the last
reference to the class device, which results in the remove function
(eventually) being called.  Finally, the remove function can free the
mmc_host.

Also note that since we have a class_dev, the mmc_host 'dev' field can
be removed.  However, we'll probably have to update the host drivers
to do this, so it should be a separate patch.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
