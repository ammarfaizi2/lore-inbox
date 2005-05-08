Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbVEHA05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbVEHA05 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 20:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbVEHA04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 20:26:56 -0400
Received: from orb.pobox.com ([207.8.226.5]:59299 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262766AbVEHA0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 20:26:53 -0400
Date: Sat, 7 May 2005 19:26:48 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [RFC/PATCH] unregister_node() for hotplug use
Message-ID: <20050508002648.GD3614@otto>
References: <20050420210744.4013b3f8.tokunaga.keiich@jp.fujitsu.com> <20050420173235.GA17775@kroah.com> <20050422003009.1b96f09c.tokunaga.keiich@jp.fujitsu.com> <20050422003920.GD6829@kroah.com> <20050422113211.509005f1.tokunaga.keiich@jp.fujitsu.com> <20050425230333.6b8dfb33.tokunaga.keiich@jp.fujitsu.com> <20050426065431.GB5889@suse.de> <20050507211141.4829d4c0.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050507211141.4829d4c0.tokunaga.keiich@jp.fujitsu.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This adds a generic function 'unregister_node()'.
> It is used to remove objects of a node going away
> for hotplug.
> 
> Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
> ---
> 
>  linux-2.6.12-rc3-mm3-kei/drivers/base/node.c  |   15 +++++++++++++--
>  linux-2.6.12-rc3-mm3-kei/include/linux/node.h |    1 +
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff -puN drivers/base/node.c~numa_hp_base drivers/base/node.c
> --- linux-2.6.12-rc3-mm3/drivers/base/node.c~numa_hp_base	2005-05-07 19:58:15.000000000 +0900
> +++ linux-2.6.12-rc3-mm3-kei/drivers/base/node.c	2005-05-07 19:58:15.000000000 +0900
> @@ -136,7 +136,7 @@ static SYSDEV_ATTR(distance, S_IRUGO, no
>   *
>   * Initialize and register the node device.
>   */
> -int __init register_node(struct node *node, int num, struct node *parent)
> +int register_node(struct node *node, int num, struct node *parent)
>  {
>  	int error;
>  
> @@ -153,8 +153,19 @@ int __init register_node(struct node *no
>  	return error;
>  }
>  
> +void unregister_node(struct node *node)
> +{
> +	sysdev_remove_file(&node->sysdev, &attr_cpumap);
> +	sysdev_remove_file(&node->sysdev, &attr_meminfo);
> +	sysdev_remove_file(&node->sysdev, &attr_numastat);
> +	sysdev_remove_file(&node->sysdev, &attr_distance);
> +
> +	sysdev_unregister(&node->sysdev);
> +}

Is it a bug to call unregister_node() if there are still cpus or
memory present in the node?  Note that register_cpu() creates a
symlink under the node directory to the cpu -- are you assuming that
all the node's cpu sysdevs will have been unregistered by the time
unregister_node is called?  If so, is it possible to enforce that, or
at least document it?

> +EXPORT_SYMBOL_GPL(register_node);
> +EXPORT_SYMBOL_GPL(unregister_node);

What module code needs to call these?  ACPI?


Nathan
