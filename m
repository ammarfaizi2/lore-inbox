Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWCODRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWCODRz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 22:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbWCODRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 22:17:55 -0500
Received: from mail2.genealogia.fi ([194.100.116.229]:34952 "EHLO
	mail2.genealogia.fi") by vger.kernel.org with ESMTP
	id S1751965AbWCODRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 22:17:54 -0500
Date: Tue, 14 Mar 2006 19:14:22 -0800
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Eugene Teo <eugene.teo@eugeneteo.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fix hostap_cs double kfree
Message-ID: <20060315031422.GD9384@jm.kir.nu>
References: <20060315023900.GA8179@eugeneteo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060315023900.GA8179@eugeneteo.net>
User-Agent: Mutt/1.5.11
X-Spam-Score: -2.6 (--)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 10:39:00AM +0800, Eugene Teo wrote:
> prism2_config() kfree's twice if kmalloc fails.
> 
> Coverity bug #930

Thanks. I'm going through the issues related to Host AP driver in
Coverity database and send a set of patches after some testing.

> --- linux-2.6/drivers/net/wireless/hostap/hostap_cs.c~	2006-03-15 10:05:36.000000000 +0800
> +++ linux-2.6/drivers/net/wireless/hostap/hostap_cs.c	2006-03-15 10:24:53.000000000 +0800
> @@ -585,8 +585,6 @@
>  	parse = kmalloc(sizeof(cisparse_t), GFP_KERNEL);
>  	hw_priv = kmalloc(sizeof(*hw_priv), GFP_KERNEL);
>  	if (parse == NULL || hw_priv == NULL) {
> -		kfree(parse);
> -		kfree(hw_priv);
>  		ret = -ENOMEM;
>  		goto failed;
>  	}

This is a valid fix..

> @@ -783,8 +781,10 @@
>  	cs_error(link->handle, last_fn, last_ret);
>  
>   failed:
> -	kfree(parse);
> -	kfree(hw_priv);
> +	if (parse)
> +		kfree(parse);
> +	if (hw_priv)
> +		kfree(hw_priv);
>  	prism2_release((u_long)link);
>  	return ret;

.. but this is not.

-- 
Jouni Malinen                                            PGP id EFC895FA
