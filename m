Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbUCJRVX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 12:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbUCJRVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 12:21:23 -0500
Received: from palrel13.hp.com ([156.153.255.238]:8641 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262729AbUCJRVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 12:21:18 -0500
Date: Wed, 10 Mar 2004 09:21:14 -0800
To: Christoph Hellwig <hch@infradead.org>, prism54-devel@prism54.org,
       "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       netdev@oss.sgi.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] Intersil Prism54 wireless driver
Message-ID: <20040310172114.GA8867@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040304023524.GA19453@bougret.hpl.hp.com> <20040310165548.A24693@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310165548.A24693@infradead.org>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 04:55:48PM +0000, Christoph Hellwig wrote:
> On Wed, Mar 03, 2004 at 06:35:24PM -0800, Jean Tourrilhes wrote:
> > 	Hi Dave & Jeff,
> > 
> > 	The attached .bz2 file is a patch for 2.6.3 adding the
> > Intersil Prism54 wireless driver. Sorry for the attachement, the file
> > is rather big, if you want inline+plaintext, I'll send that personal
> > to you.
> > 	I've been using this driver with great success on 2.6.3 and
> > 2.6.4-rc1 (SMP). This driver support various popular CardBus and PCI
> > 802.11g cards (54 Mb/s) based on the Intersil PrismGT/PrismDuette
> > chipset.
> > 	I would like this driver to go into 2.6.X. However, I
> > understand that it's lot's of code to review.
> 
> Here's a few things I found.

	I'm forwarding to prism54-devel where the real developpers can
answer your questions.

>  It's not exactly a full review, there's
> too much new snow to spend lots of time in front of a computer here :)

	Grrr... This year, no snow for me.

> diff -Naur -X /home/mcgrof/lib/dontdiff linux-2.6.3/drivers/net/wireless/prism54/Makefile linux-2.6.3-prism54/drivers/net/wireless/prism54/Makefile
> --- linux-2.6.3/drivers/net/wireless/prism54/Makefile	Thu Jan  1 00:00:00 1970
> +++ linux-2.6.3-prism54/drivers/net/wireless/prism54/Makefile	Thu Mar  4 02:00:01 2004
> @@ -0,0 +1,10 @@
> +# $Id: Makefile.k26,v 1.7 2004/01/30 16:24:00 ajfa Exp $
> +
> +prism54-objs := islpci_eth.o islpci_mgt.o \
> +                isl_38xx.o isl_ioctl.o islpci_dev.o \
> +		islpci_hotplug.o isl_wds.o oid_mgt.o
> 
> 	please use foo-y for new drivers.
> 
> +
> +obj-$(CONFIG_PRISM54) += prism54.o
> +
> +EXTRA_CFLAGS = -I$(PWD) #-DCONFIG_PRISM54_WDS
> 
> 	This is bogus, especially with srcdir != objdir.
> 	please fixup the includes instead
> 
> +#define __KERNEL_SYSCALLS__
> 
> 	this shouldn't be used anymore.
> 
> +
> +#include <linux/version.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/delay.h>
> +
> +#include "isl_38xx.h"
> +#include <linux/firmware.h>
> +
> +#include <asm/uaccess.h>
> +#include <asm/io.h>
> 
> 	Please include headers in the following order <linux/*.h>,
> 	<asm/*.h>, driver-specific.
> 
> +#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,75))
> +#include <linux/device.h>
> +# define _REQ_FW_DEV_T struct device *
> +#else
> +# define _REQ_FW_DEV_T char *
> +#endif
> 
> 	Eeek, why don't you simply pass the pci_dev down?
> 
> 
> +typedef struct isl38xx_cb isl38xx_control_block;
> 
> 	No useless typedefs please.
> 
> +MODULE_PARM(init_mode, "i");
> +MODULE_PARM_DESC(init_mode,
> +		 "Set card mode:\n0: Auto\n1: Ad-Hoc\n2: Managed Client (Default)\n3: Master / Access Point\n4: Repeater (Not supported yet)\n5: Secondary (Not supported yet)\n6: Monitor");
> 
> 	Please use module_param

	I would even say that this is useless because the driver
support WE, and WE scripts set the mode before the card is up.

> diff -Naur -X /home/mcgrof/lib/dontdiff linux-2.6.3/drivers/net/wireless/prism54/isl_wds.c linux-2.6.3-prism54/drivers/net/wireless/prism54/isl_wds.c
> --- linux-2.6.3/drivers/net/wireless/prism54/isl_wds.c	Thu Jan  1 00:00:00 1970
> +++ linux-2.6.3-prism54/drivers/net/wireless/prism54/isl_wds.c	Thu Mar  4 02:00:01 2004
> 
> 	WDS doesn't belong into a driver but in higher-level code.

	The big 802.11 reorg can only happen when HostAP is in the
kernel.

	Regards,

	Jean

