Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVEUXWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVEUXWi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 19:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVEUXWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 19:22:37 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:65054 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261669AbVEUXWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 19:22:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:from;
        b=hJEqqPxpnmKOVyAl5NO6LuLQj+rTXQAYEHMXesgqEocDSosXsck6E/bXh/XWe60DKKNi8Z3I4lepJ9cVHNyGewF+At6cSRmnw74OX5Ekf20dlhds3dzGKgKNVd20n2nS/RXzT2KJX4fOlsvFCrYekpp2a/McRVS2BIX8dca1C84=
Date: Sun, 22 May 2005 01:22:20 +0200
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
Message-ID: <20050521232220.GD28654@gmail.com>
References: <20050516085832.GA9558@gmail.com> <20050517071307.GA4794@in.ibm.com> <20050517002908.005a9ba7.akpm@osdl.org> <1116340465.4989.2.camel@mulgrave> <20050517170824.GA3931@in.ibm.com> <1116354894.4989.42.camel@mulgrave> <20050517192636.GB9121@gmail.com> <1116359432.4989.48.camel@mulgrave> <20050517195650.GC9121@gmail.com> <1116363971.4989.51.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1116363971.4989.51.camel@mulgrave>
User-Agent: Mutt/1.5.6i
From: =?iso-8859-1?Q?Gr=E9goire?= Favre <gregoire.favre@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 04:06:11PM -0500, James Bottomley wrote:

> Well, the attached is what I'd like you to try, capturing the
> information from the initial inquiry on ... it will be quite a bit.
> 
> Hopefully it will give me a clearer idea of what's going on.

I have found a way to fetch the console :-)

Against which kernel revision is your patch made for ?

Thank you very much :-)

> Thanks,
> 
> James
> 
> --- a/drivers/scsi/scsi_transport_spi.c
> +++ b/drivers/scsi/scsi_transport_spi.c
> @@ -669,14 +669,23 @@ spi_dv_retrain(struct scsi_request *sreq
>  {
>  	struct spi_internal *i = to_spi_internal(sreq->sr_host->transportt);
>  	struct scsi_device *sdev = sreq->sr_device;
> +	struct scsi_target *starget = sdev->sdev_target;
>  	int period = 0, prevperiod = 0; 
>  	enum spi_compare_returns retval;
>  
>  
>  	for (;;) {
>  		int newperiod;
> +
>  		retval = compare_fn(sreq, buffer, ptr, DV_LOOPS);
>  
> +		if(i->f->get_period)
> +			i->f->get_period(starget);
> +		if (i->f->get_offset)
> +			i->f->get_offset(starget);
> +
> +		spi_display_xfer_agreement(starget);
> +
>  		if (retval == SPI_COMPARE_SUCCESS
>  		    || retval == SPI_COMPARE_SKIP_TEST)
>  			break;
> @@ -765,6 +774,8 @@ spi_dv_device_internal(struct scsi_reque
>  	/* first set us up for narrow async */
>  	DV_SET(offset, 0);
>  	DV_SET(width, 0);
> +
> +	printk("BEGINNING ASYNC, inq len = %d\n", sdev->inquiry_len);
>  	
>  	if (spi_dv_device_compare_inquiry(sreq, buffer, buffer, DV_LOOPS)
>  	    != SPI_COMPARE_SUCCESS) {
> @@ -773,11 +784,13 @@ spi_dv_device_internal(struct scsi_reque
>  		return;
>  	}
>  
> +	printk("ASYNC INQUIRY SUCCEEDED\n");
> +
>  	/* test width */
>  	if (i->f->set_width && spi_max_width(starget) && sdev->wdtr) {
>  		i->f->set_width(sdev->sdev_target, 1);
>  
> -		printk("WIDTH IS %d\n", spi_max_width(starget));
> +		printk("TRYING WIDE ASYNC INQUIRY\n");
>  
>  		if (spi_dv_device_compare_inquiry(sreq, buffer,
>  						   buffer + len,
> @@ -802,12 +815,17 @@ spi_dv_device_internal(struct scsi_reque
>  	if (sdev->ppr)
>  		len = spi_dv_device_get_echo_buffer(sreq, buffer);
>  
> +	printk("ECHO BUFFER HAS LEN %d\n", len);
> +
>   retry:
>  
>  	/* now set up to the maximum */
>  	DV_SET(offset, spi_max_offset(starget));
>  	DV_SET(period, spi_min_period(starget));
>  
> +	printk("DV SETTING TO period %d, offset %d\n", spi_min_period(starget),
> +	       spi_max_offset(starget));
> +
>  	if (len == 0) {
>  		SPI_PRINTK(sdev->sdev_target, KERN_INFO, "Domain Validation skipping write tests\n");
>  		spi_dv_retrain(sreq, buffer, buffer + len,
> 

-- 
	Grégoire Favre
