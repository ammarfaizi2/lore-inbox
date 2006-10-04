Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWJDXb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWJDXb4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 19:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWJDXb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 19:31:56 -0400
Received: from cantor2.suse.de ([195.135.220.15]:34004 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751232AbWJDXbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 19:31:55 -0400
Date: Wed, 4 Oct 2006 16:31:59 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: ecashin@coraid.com, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/block/aoe: handle sysfs errors
Message-ID: <20061004233159.GB16204@kroah.com>
References: <20061004135819.GA29526@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004135819.GA29526@havoc.gtf.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 09:58:19AM -0400, Jeff Garzik wrote:
> 
> Signed-off-by: Jeff Garzik <jeff@garzik.org>
> 
> ---
> 
>  drivers/block/aoe/aoeblk.c |   64 +++++++++++++++++++++++++++++++++------------
>  1 files changed, 47 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
> index 393b86a..04f9b03 100644
> --- a/drivers/block/aoe/aoeblk.c
> +++ b/drivers/block/aoe/aoeblk.c
> @@ -64,13 +64,36 @@ static struct disk_attribute disk_attr_f
>  	.show = aoedisk_show_fwver
>  };
>  
> -static void
> +static int
>  aoedisk_add_sysfs(struct aoedev *d)
>  {
> -	sysfs_create_file(&d->gd->kobj, &disk_attr_state.attr);
> -	sysfs_create_file(&d->gd->kobj, &disk_attr_mac.attr);
> -	sysfs_create_file(&d->gd->kobj, &disk_attr_netif.attr);
> -	sysfs_create_file(&d->gd->kobj, &disk_attr_fwver.attr);
> +	int err;
> +
> +	err = sysfs_create_file(&d->gd->kobj, &disk_attr_state.attr);
> +	if (err)
> +		return err;
> +
> +	err = sysfs_create_file(&d->gd->kobj, &disk_attr_mac.attr);
> +	if (err)
> +		goto err_out_state;
> +
> +	err = sysfs_create_file(&d->gd->kobj, &disk_attr_netif.attr);
> +	if (err)
> +		goto err_out_mac;
> +
> +	err = sysfs_create_file(&d->gd->kobj, &disk_attr_fwver.attr);
> +	if (err)
> +		goto err_out_netif;

Oh, and in the future, it's easier to use an attribute group for this
kind of thing than backing out each and every attribute that is added.
The function to add all files in the attribute group properly tears
things down if there is an error along the way.

thanks,

greg k-h
