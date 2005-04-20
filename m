Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVDTRfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVDTRfX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 13:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVDTRfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 13:35:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:3464 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261697AbVDTRcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 13:32:53 -0400
Date: Wed, 20 Apr 2005 10:32:35 -0700
From: Greg KH <gregkh@suse.de>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [RFC/PATCH] unregister_node() for hotplug use
Message-ID: <20050420173235.GA17775@kroah.com>
References: <20050420210744.4013b3f8.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050420210744.4013b3f8.tokunaga.keiich@jp.fujitsu.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2005 at 09:07:44PM +0900, Keiichiro Tokunaga wrote:
>   This is to add a generic function 'unregister_node()'.
> It is used to remove objects of a node going away for
> hotplug.  If CONFIG_HOTPLUG=y, it becomes available.
> This is against 2.6.12-rc2-mm3.

Please CC: this kind of stuff to the driver core maintainer, otherwise
it can get dropped...

Anyway, comments below:

> diff -puN drivers/base/node.c~numa_hp_base drivers/base/node.c
> --- linux-2.6.12-rc2-mm3/drivers/base/node.c~numa_hp_base	2005-04-14 20:49:37.000000000 +0900
> +++ linux-2.6.12-rc2-mm3-kei/drivers/base/node.c	2005-04-14 20:49:37.000000000 +0900
> @@ -136,7 +136,7 @@ static SYSDEV_ATTR(distance, S_IRUGO, no
>   *
>   * Initialize and register the node device.
>   */
> -int __init register_node(struct node *node, int num, struct node *parent)
> +int __devinit register_node(struct node *node, int num, struct node *parent)
>  {
>  	int error;
>  
> @@ -145,6 +145,9 @@ int __init register_node(struct node *no
>  	error = sysdev_register(&node->sysdev);
>  
>  	if (!error){
> +		/*
> +		 * If you add new object here, delete it when unregistering.
> +		 */

Comment really isn't needed.

> +/*
> + * unregister_node - Remove objects of a node going away from sysfs.
> + * @node - node going away
> + *
> + * This is used only for hotplug.
> + */

If you are going to create function comments, at least use the proper
kerneldoc format.

> +#ifdef CONFIG_HOTPLUG

You don't provide function prototype for when CONFIG_HOTPLUG is not
enabled.

> +void unregister_node(struct node *node)
> +{
> +	if (node == NULL)
> +		return;

How can this happen?

> +
> +	sysdev_remove_file(&node->sysdev, &attr_cpumap);
> +	sysdev_remove_file(&node->sysdev, &attr_meminfo);
> +	sysdev_remove_file(&node->sysdev, &attr_numastat);
> +	sysdev_remove_file(&node->sysdev, &attr_distance);
> +
> +	sysdev_unregister(&node->sysdev);
> +}
> +EXPORT_SYMBOL(register_node);
> +EXPORT_SYMBOL(unregister_node);

All of sysfs and the driver core are EXPORT_SYMBOL_GPL().  Please follow
that convention.

> +#endif /* CONFIG_HOTPLUG */
>  
> -int __init register_node_type(void)
> +static int __init register_node_type(void)

Are you sure no one calls this?

>  {
>  	return sysdev_class_register(&node_class);
>  }
> diff -puN include/linux/node.h~numa_hp_base include/linux/node.h
> --- linux-2.6.12-rc2-mm3/include/linux/node.h~numa_hp_base	2005-04-14 20:49:37.000000000 +0900
> +++ linux-2.6.12-rc2-mm3-kei/include/linux/node.h	2005-04-14 20:49:37.000000000 +0900
> @@ -21,12 +21,16 @@
>  
>  #include <linux/sysdev.h>
>  #include <linux/cpumask.h>
> +#include <linux/module.h>

Why?

>  
>  struct node {
>  	struct sys_device	sysdev;
>  };
>  
> -extern int register_node(struct node *, int, struct node *);
> +extern int __devinit register_node(struct node *, int, struct node *);

__devinit is not needed on a function prototype.

> +#ifdef CONFIG_HOTPLUG
> +extern void unregister_node(struct node *node);
> +#endif

Not needed for a function prototype.

thanks,

greg k-h
