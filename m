Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932627AbWBTFUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbWBTFUp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 00:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbWBTFUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 00:20:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11173 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932627AbWBTFUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 00:20:44 -0500
Date: Sun, 19 Feb 2006 21:18:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alex Riesen <fork0@users.sourceforge.net>
Cc: acpi-devel@lists.sourceforge.net, torvalds@osdl.org, mail@hboeck.de,
       len.brown@intel.com, Greek0@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Work around asus_acpi driver oopses on Samsung P30s and
 the like due to the ACPI implicit return
Message-Id: <20060219211852.05d08f55.akpm@osdl.org>
In-Reply-To: <20060219125258.GB6041@steel.home>
References: <F7DC2337C7631D4386A2DF6E8FB22B300580F140@hdsmsx401.amr.corp.intel.com>
	<20051222174226.GB20051@hell.org.pl>
	<20060219125258.GB6041@steel.home>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen <fork0@users.sourceforge.net> wrote:
>
> FWIW, I need the patch below to stop ACPI freezing at boot on Asus S1300N.
> There is a BIOS update from Asus, but no mention of any fixes in ACPI,
> so as I have no means to backup the BIOS in case something goes wrong
> I didn't do the update.

I think it'd be worth trying the update anyway please.  Normally those
updating programs are pretty careful to not give you a dead box.

> I found out (by putting printks in the initialization code) that a
> call to INI (whatever it is) of VGA_ (whatever this is) immediately
> freezes the notebook and the fan goes on shortly afterwards.
> 

Is this a recent problem, or did earlier 2.6.x kernels also fail?


> diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
> index f4c8775..d415b30 100644
> --- a/drivers/acpi/asus_acpi.c
> +++ b/drivers/acpi/asus_acpi.c
> @@ -352,8 +352,8 @@ static struct model_data model_conf[END_
>  	 .lcd_status = "\\BKLT",
>  	 .brightness_set = "SPLV",
>  	 .brightness_get = "GPLV",
> -	 .display_set = "SDSP",
> -	 .display_get = "\\ADVG"}
> +	 /* .display_set = "SDSP",
> +	 .display_get = "\\ADVG" */}
>  };
>  
>  /* procdir we use */
> diff --git a/drivers/acpi/namespace/nsinit.c b/drivers/acpi/namespace/nsinit.c
> index 9f929e4..79fa2ec 100644
> --- a/drivers/acpi/namespace/nsinit.c
> +++ b/drivers/acpi/namespace/nsinit.c
> @@ -384,7 +384,12 @@ acpi_ns_init_one_device(acpi_handle obj_
>  	pinfo.parameters = NULL;
>  	pinfo.parameter_type = ACPI_PARAM_ARGS;
>  
> -	status = acpi_ut_execute_STA(pinfo.node, &flags);
> +	/* workaround Asus S1300N freeze at INI */
> +	if ( memcmp(pinfo.node->name.ascii, "VGA_",4)==0 ) {
> +	    printk(KERN_ERR "acpi: VGA_ ignored\n");
> +	    status = AE_NOT_FOUND;
> +	} else
> +	    status = acpi_ut_execute_STA(pinfo.node, &flags);
>  	if (ACPI_FAILURE(status)) {
>  		/* Ignore error and move on to next device */
>  
