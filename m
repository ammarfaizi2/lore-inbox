Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751781AbWEEVQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbWEEVQe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 17:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWEEVQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 17:16:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:43420 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751781AbWEEVQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 17:16:33 -0400
Date: Fri, 5 May 2006 14:14:47 -0700
From: Greg KH <greg@kroah.com>
To: Michael Holzheu <holzheu@de.ibm.com>
Cc: akpm@osdl.org, ioe-lkml@rameria.de, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com,
       penberg@cs.helsinki.fi
Subject: Re: [PATCH] s390: Hypervisor File System
Message-ID: <20060505211447.GA7539@kroah.com>
References: <20060505152249.520144f9.holzheu@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060505152249.520144f9.holzheu@de.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2006 at 03:22:49PM +0200, Michael Holzheu wrote:
> Greg KH <greg@kroah.com> wrote on 05/04/2006 05:34:11 PM:
> > > So you want a new config option CONFIG_HYPERVISOR?
> > 
> > Sure.  But don't make it a user selectable config option, but rather,
> > one your S390 option sets.
> > 
> > That way the Xen and other groups can also set it when they need it.
> > 
> 
> [snip]
> > 
> > The Xen people need it too.  Now who knows when their code will ever hit
> > mainline...
> 
> I added a invisible config option CONFIG_SYS_HYPERVISOR. If this
> option is enabled, /sys/hypervisor is created. CONFIG_S390_HYPFS
> enables this option automatically using "select".
> 
> This the following patch acceptable for you?
> 
> ---
> 
>  drivers/base/Kconfig      |    4 ++++
>  drivers/base/Makefile     |    2 +-
>  drivers/base/hypervisor.c |   30 ++++++++++++++++++++++++++++++
>  drivers/base/init.c       |    1 +
>  include/linux/kobject.h   |    4 ++++
>  5 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff -urpN linux-2.6.16/drivers/base/Kconfig linux-2.6.16-hypervisor/drivers/base/Kconfig
> --- linux-2.6.16/drivers/base/Kconfig	2006-03-20 06:53:29.000000000 +0100
> +++ linux-2.6.16-hypervisor/drivers/base/Kconfig	2006-05-05 15:13:10.000000000 +0200
> @@ -38,3 +38,7 @@ config DEBUG_DRIVER
>  	  If you are unsure about this, say N here.
>  
>  endmenu
> +
> +config SYS_HYPERVISOR
> +	bool
> +	default n
> diff -urpN linux-2.6.16/drivers/base/Makefile linux-2.6.16-hypervisor/drivers/base/Makefile
> --- linux-2.6.16/drivers/base/Makefile	2006-03-20 06:53:29.000000000 +0100
> +++ linux-2.6.16-hypervisor/drivers/base/Makefile	2006-05-05 15:12:48.000000000 +0200
> @@ -3,7 +3,7 @@
>  obj-y			:= core.o sys.o bus.o dd.o \
>  			   driver.o class.o platform.o \
>  			   cpu.o firmware.o init.o map.o dmapool.o \
> -			   attribute_container.o transport_class.o
> +			   attribute_container.o transport_class.o hypervisor.o
>  obj-y			+= power/
>  obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
>  obj-$(CONFIG_NUMA)	+= node.o

This should be:
  obj-$(CONFIG_HYPERVISOR) += hypervisor.o
don't always load it in.

> diff -urpN linux-2.6.16/drivers/base/hypervisor.c linux-2.6.16-hypervisor/drivers/base/hypervisor.c
> --- linux-2.6.16/drivers/base/hypervisor.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.16-hypervisor/drivers/base/hypervisor.c	2006-05-05 15:12:57.000000000 +0200
> @@ -0,0 +1,30 @@
> +/*
> + * hypervisor.c - /sys/hypervisor subsystem.
> + *
> + * This file is released under the GPLv2
> + *
> + */
> +
> +#include <linux/kobject.h>
> +#include <linux/device.h>
> +
> +#include "base.h"
> +
> +#ifdef CONFIG_SYS_HYPERVISOR
> +
> +decl_subsys(hypervisor, NULL, NULL);
> +EXPORT_SYMBOL_GPL(hypervisor_subsys);
> +
> +int __init hypervisor_init(void)
> +{
> +	return subsystem_register(&hypervisor_subsys);
> +}
> +
> +#else
> +
> +int __init hypervisor_init(void)
> +{
> +	return -1;
> +}
> +
> +#endif /* CONFIG_SYS_HYPERVISOR */

No ifdef needed here then.

> diff -urpN linux-2.6.16/drivers/base/init.c linux-2.6.16-hypervisor/drivers/base/init.c
> --- linux-2.6.16/drivers/base/init.c	2006-03-20 06:53:29.000000000 +0100
> +++ linux-2.6.16-hypervisor/drivers/base/init.c	2006-05-05 15:12:40.000000000 +0200
> @@ -27,6 +27,7 @@ void __init driver_init(void)
>  	buses_init();
>  	classes_init();
>  	firmware_init();
> +	hypervisor_init();

But we need the ifdef in a header file to make this compile properly.

>  
>  	/* These are also core pieces, but must come after the
>  	 * core core pieces.
> diff -urpN linux-2.6.16/include/linux/kobject.h linux-2.6.16-hypervisor/include/linux/kobject.h
> --- linux-2.6.16/include/linux/kobject.h	2006-03-20 06:53:29.000000000 +0100
> +++ linux-2.6.16-hypervisor/include/linux/kobject.h	2006-05-05 15:13:35.000000000 +0200
> @@ -186,6 +186,10 @@ struct subsystem _varname##_subsys = { \
>  
>  /* The global /sys/kernel/ subsystem for people to chain off of */
>  extern struct subsystem kernel_subsys;
> +#ifdef CONFIG_SYS_HYPERVISOR
> +/* The global /sys/hypervisor/ subsystem  */
> +extern struct subsystem hypervisor_subsys;
> +#endif /* CONFIG_SYS_HYPERVISOR */

No ifdef here should be needed, a link error will happen if you try to
access it and it's not linked in properly.

So, it's almost there :)

thanks,

greg k-h
