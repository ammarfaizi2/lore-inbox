Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965088AbWADBIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965088AbWADBIv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 20:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965089AbWADBIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 20:08:51 -0500
Received: from c-24-22-115-24.hsd1.or.comcast.net ([24.22.115.24]:34537 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S965088AbWADBIv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 20:08:51 -0500
Date: Tue, 3 Jan 2006 17:08:41 -0800
From: Greg KH <greg@kroah.com>
To: Jason Dravet <dravet@hotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-parport@lists.infradead.org
Subject: Re: [RFC]: add sysfs support to parport_pc, v3
Message-ID: <20060104010841.GA19541@kroah.com>
References: <BAY103-F835CFFD193D6F76C5527FDF2D0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY103-F835CFFD193D6F76C5527FDF2D0@phx.gbl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2006 at 09:39:50AM -0600, Jason Dravet wrote:
> Here is a new patch to parport_pc that adds sysfs and thus udev support to 
> parport_pc.  I fixed my earilier problem of the kernel oops (I forgot the 
> class_destory) and I can insmod and rmmod this module all day long with no 
> side effects.  I do have one question why do both lp and parport nodes have 
> to be created?
> 
> What do you think of this patch?  What would be the next step to get this 
> into the kernel?
> 
> Thanks,
> Jason Dravet
> 
> signed-off-by: Jason Dravet <dravet@hotmail.com>

"Signed-off-by:"

> 
> --- /usr/src/linux-2.6.14/drivers/parport/parport_pc.c.orig	2005-12-30 
> 13:52:48.000000000 -0600
> +++ /usr/src/linux-2.6.14/drivers/parport/parport_pc.c	2006-01-01 
> 11:29:05.000000000 -0600

Line wrapped so it can't be applied :(

> @@ -14,6 +14,7 @@
>  * More PCI support now conditional on CONFIG_PCI, 03/2001, Paul G.
>  * Various hacks, Fred Barnes, 04/2001
>  * Updated probing logic - Adam Belay <ambx1@neo.rr.com>
> + * Added sysfs and udev - Jason Dravet <dravet@hotmail.com>
>  */

Doesn't belong here, this goes in the change log.

> 
> /* This driver should work with any hardware that is broadly compatible
> @@ -55,6 +56,7 @@
> #include <linux/pci.h>
> #include <linux/pnp.h>
> #include <linux/sysctl.h>
> +#include <linux/sysfs.h>

Your email client also ate the leading spaces :(

> 
> #include <asm/io.h>
> #include <asm/dma.h>
> @@ -99,6 +101,9 @@ static struct superio_struct {	/* For Su
> 	int dma;
> } superios[NR_SUPERIOS] __devinitdata = { {0,},};
> 
> +static struct class *parallel_class;
> +int countports = 0;
> +
> static int user_specified;
> #if defined(CONFIG_PARPORT_PC_SUPERIO) || \
>        (defined(CONFIG_PARPORT_1284) && defined(CONFIG_PARPORT_PC_FIFO))
> @@ -2232,6 +2237,11 @@ struct parport *parport_pc_probe_port (u
>                                            is mandatory (see above) */
> 		p->dma = PARPORT_DMA_NONE;
> 
> +	parallel_class = class_create(THIS_MODULE, "lp");
> +	class_device_create(parallel_class, NULL, MKDEV(6, countports), 
> NULL, "lp%i", countports);
> +	class_device_create(parallel_class, NULL, MKDEV(99, countports), 
> NULL, "parport%i", countports);
> +	countports++;

What does the 6 and 99 come from?  Aren't these #defined in a header
file somewhere?

thanks,

greg k-h
