Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030391AbVIBDcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbVIBDcK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 23:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030664AbVIBDcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 23:32:10 -0400
Received: from xenotime.net ([66.160.160.81]:15575 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030391AbVIBDcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 23:32:09 -0400
Date: Thu, 1 Sep 2005 20:32:07 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: dwalker@mvista.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13] Unhandled error condition in aic7xxx
Message-Id: <20050901203207.719e1828.rdunlap@xenotime.net>
In-Reply-To: <1125603504.4867.22.camel@dhcp153.mvista.com>
References: <1125603504.4867.22.camel@dhcp153.mvista.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Sep 2005 12:38:24 -0700 Daniel Walker wrote:

> 
> This patch should handle the case when scsi_add_host() fails.
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> 
> Index: linux-2.6.13/drivers/scsi/aic7xxx/aic7xxx_osm.c
> ===================================================================
> --- linux-2.6.13.orig/drivers/scsi/aic7xxx/aic7xxx_osm.c	2005-08-28 23:41:01.000000000 +0000
> +++ linux-2.6.13/drivers/scsi/aic7xxx/aic7xxx_osm.c	2005-08-31 18:45:20.000000000 +0000
> @@ -996,6 +996,7 @@ ahc_linux_register_host(struct ahc_softc
>  	struct	 Scsi_Host *host;
>  	char	*new_name;
>  	u_long	 s;
> +	int error = 0;
>  
>  	template->name = ahc->description;
>  	host = scsi_host_alloc(template, sizeof(struct ahc_softc *));
> @@ -1029,8 +1030,16 @@ ahc_linux_register_host(struct ahc_softc
>  
>  	host->transportt = ahc_linux_transport_template;
>  
> -	scsi_add_host(host, (ahc->dev_softc ? &ahc->dev_softc->dev : NULL)); /* XXX handle failure */
> -	scsi_scan_host(host);
> +	error = scsi_add_host(host, (ahc->dev_softc ? &ahc->dev_softc->dev : NULL));
> +	if (error) {
> +		/* 
> +		 * Discard host variable on error.
> +		 */
> +		scsi_host_put(host);
> +		return (error);

no parens on return, just: return error;

> +	} 
> + 	scsi_scan_host(host);
> +	
>  	return (0);
>  }



---
~Randy
