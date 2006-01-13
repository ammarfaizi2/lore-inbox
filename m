Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422767AbWAMSFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422767AbWAMSFs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 13:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422766AbWAMSFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 13:05:48 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:7057 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422764AbWAMSFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 13:05:47 -0500
Date: Fri, 13 Jan 2006 18:05:43 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ashutosh Naik <ashutosh.naik@gmail.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       James.Bottomley@steeleye.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] scsi/aha1740.c Handle scsi_add_host failure
Message-ID: <20060113180543.GA20718@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ashutosh Naik <ashutosh.naik@gmail.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, James.Bottomley@steeleye.com,
	Andrew Morton <akpm@osdl.org>
References: <81083a450601100421t5f8fcc4am2c0ec666feccc4ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81083a450601100421t5f8fcc4am2c0ec666feccc4ca@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 05:51:15PM +0530, Ashutosh Naik wrote:
> Add scsi_add_host() failure handling for Adaptec aha1740 driver.
> 
> Signed-off-by: Ashutosh Naik <ashutosh.naik@gmail.com>

> diff -Naurp linux-2.6.15-git5-vanilla/drivers/scsi/aha1740.c linux-2.6.15-git5/drivers/scsi/aha1740.c
> --- linux-2.6.15-git5-vanilla/drivers/scsi/aha1740.c	2006-01-03 08:51:10.000000000 +0530
> +++ linux-2.6.15-git5/drivers/scsi/aha1740.c	2006-01-10 16:22:13.000000000 +0530
> @@ -587,7 +587,7 @@ static struct scsi_host_template aha1740
>  
>  static int aha1740_probe (struct device *dev)
>  {
> -	int slotbase;
> +	int slotbase, retval;
>  	unsigned int irq_level, irq_type, translation;
>  	struct Scsi_Host *shpnt;
>  	struct aha1740_hostdata *host;
> @@ -642,7 +642,13 @@ static int aha1740_probe (struct device 
>  	}
>  
>  	eisa_set_drvdata (edev, shpnt);
> -	scsi_add_host (shpnt, dev); /* XXX handle failure */
> +	retval = scsi_add_host (shpnt, dev);
> +	if (retval) {
> +		printk(KERN_WARNING "aha1740: scsi_add_host failed\n");
> +		scsi_host_put (shpnt);
> +		return retval;
> +	}
> +		

this is wrong.  you need to add a new err_free_irq label that frees
the allocated irq and then falls through to the existing error handling
code, starting at the err_unmap label.

