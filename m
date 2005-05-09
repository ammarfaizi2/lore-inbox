Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVEIWoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVEIWoQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 18:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVEIWoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 18:44:15 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:20137 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261158AbVEIWoJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 18:44:09 -0400
Message-ID: <427FE7B3.8080200@us.ibm.com>
Date: Mon, 09 May 2005 15:44:03 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
CC: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [RFC/PATCH] unregister_node() for hotplug use
References: <20050420210744.4013b3f8.tokunaga.keiich@jp.fujitsu.com> <20050420173235.GA17775@kroah.com> <20050422003009.1b96f09c.tokunaga.keiich@jp.fujitsu.com> <20050422003920.GD6829@kroah.com> <20050422113211.509005f1.tokunaga.keiich@jp.fujitsu.com> <20050425230333.6b8dfb33.tokunaga.keiich@jp.fujitsu.com> <20050426065431.GB5889@suse.de> <20050507211141.4829d4c0.tokunaga.keiich@jp.fujitsu.com>
In-Reply-To: <20050507211141.4829d4c0.tokunaga.keiich@jp.fujitsu.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keiichiro Tokunaga wrote:
>   I updated the patch for 2.6.12-rc3-mm3 based on my
> previous comments.  Please apply.
> 
> Thanks,
> Keiichiro Tokunaga
> 
> 
> 
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

Is there a reason to not make both register_node() and unregister_node()
__devinit?  If a user has CONFIG_HOTPLUG=y then they want these functions,
otherwise there is no point, as they promised they won't be hotplugging
anything, right?


-Matt
