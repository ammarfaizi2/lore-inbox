Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965117AbWJJJII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117AbWJJJII (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 05:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965118AbWJJJII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 05:08:08 -0400
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:62217 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S965117AbWJJJIF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 05:08:05 -0400
Date: Tue, 10 Oct 2006 11:08:03 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Hans de Goede <j.w.r.degoede@hhs.nl>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon/abituguru: handle sysfs errors
Message-Id: <20061010110803.1a70b576.khali@linux-fr.org>
In-Reply-To: <452B4B59.1050606@hhs.nl>
References: <20061010065359.GA21576@havoc.gtf.org>
	<452B4B59.1050606@hhs.nl>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans, Jeff,

> You (Jean) already mailed me about this and it was on my todo list,
> but I'm currently rather busy with work. So it looks like Jeff beat
> me to it.
> 
> Jeff's patch looks fine, please apply. Thanks Jeff!

The patch isn't wrong per se, but it could be made more simple, and is
incomplete in comparison to what was done for all other hardware
monitoring drivers:

* We want to create all the files before registering with the hwmon
  class, this closes a race condition.
* We want to delete all the device files at regular cleanup time (after
  unregistering with the hwmon class).
* It's OK to call device_create_file() on a non-existent file, so the
  error path can be simplified.

I'd like the abituguru driver to behave the same as all other hardware
monitoring drivers to lower the maintenance effort. Can either you
or Jeff work up a compliant patch? 

Thanks.

>  drivers/hwmon/abituguru.c |   30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> 2b10f648c8ed965369976eb7925b922ee187ce21
> diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
> index e5cb0fd..3ded982 100644
> --- a/drivers/hwmon/abituguru.c
> +++ b/drivers/hwmon/abituguru.c
> @@ -1271,14 +1271,34 @@ static int __devinit abituguru_probe(str
>  		res = PTR_ERR(data->class_dev);
>  		goto abituguru_probe_error;
>  	}
> -	for (i = 0; i < sysfs_attr_i; i++)
> -		device_create_file(&pdev->dev, &data->sysfs_attr[i].dev_attr);
> -	for (i = 0; i < ARRAY_SIZE(abituguru_sysfs_attr); i++)
> -		device_create_file(&pdev->dev,
> -			&abituguru_sysfs_attr[i].dev_attr);
> +	for (i = 0; i < sysfs_attr_i; i++) {
> +		res = device_create_file(&pdev->dev,
> +					 &data->sysfs_attr[i].dev_attr);
> +		if (res) {
> +			for (j = 0; j < i; j++)
> +				device_remove_file(&pdev->dev,
> +					 	&data->sysfs_attr[j].dev_attr);
> +			goto err_devreg;
> +		}
> +	}
> +	for (i = 0; i < ARRAY_SIZE(abituguru_sysfs_attr); i++) {
> +		res = device_create_file(&pdev->dev,
> +					 &abituguru_sysfs_attr[i].dev_attr);
> +		if (res) {
> +			for (j = 0; j < i; j++)
> +				device_remove_file(&pdev->dev,
> +					 &abituguru_sysfs_attr[j].dev_attr);
> +			goto err_attr_i;
> +		}
> +	}
>  
>  	return 0;
>  
> +err_attr_i:
> +	for (i = 0; i < sysfs_attr_i; i++)
> +		device_remove_file(&pdev->dev, &data->sysfs_attr[i].dev_attr);
> +err_devreg:
> +	hwmon_device_unregister(data->class_dev);
>  abituguru_probe_error:
>  	kfree(data);
>  	return res;


-- 
Jean Delvare
