Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWJJPsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWJJPsY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 11:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWJJPsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 11:48:24 -0400
Received: from sccrmhc11.comcast.net ([63.240.77.81]:23513 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932178AbWJJPsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 11:48:22 -0400
Message-ID: <452BC148.3000802@acm.org>
Date: Tue, 10 Oct 2006 10:50:32 -0500
From: Corey Minyard <cminyard@acm.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ipmi: handle sysfs errors
References: <20061010070213.GA22049@havoc.gtf.org>
In-Reply-To: <20061010070213.GA22049@havoc.gtf.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tested this and it seems to work fine.  Thanks.

-Corey

Jeff Garzik wrote:
> Signed-off-by: Jeff Garzik <jeff@garzik.org>
>
> ---
>
>  drivers/char/ipmi/ipmi_msghandler.c |  122 +++++++++++++++++++++++++++---------
>  1 file changed, 93 insertions(+), 29 deletions(-)
>
> cf8f730ca9ec3636609ca08b357c615c689b86df
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 2455e8d..34a4fd1 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -1928,13 +1928,8 @@ static ssize_t guid_show(struct device *
>  			(long long) bmc->guid[8]);
>  }
>  
> -static void
> -cleanup_bmc_device(struct kref *ref)
> +static void remove_files(struct bmc_device *bmc)
>  {
> -	struct bmc_device *bmc;
> -
> -	bmc = container_of(ref, struct bmc_device, refcount);
> -
>  	device_remove_file(&bmc->dev->dev,
>  			   &bmc->device_id_attr);
>  	device_remove_file(&bmc->dev->dev,
> @@ -1951,12 +1946,23 @@ cleanup_bmc_device(struct kref *ref)
>  			   &bmc->manufacturer_id_attr);
>  	device_remove_file(&bmc->dev->dev,
>  			   &bmc->product_id_attr);
> +
>  	if (bmc->id.aux_firmware_revision_set)
>  		device_remove_file(&bmc->dev->dev,
>  				   &bmc->aux_firmware_rev_attr);
>  	if (bmc->guid_set)
>  		device_remove_file(&bmc->dev->dev,
>  				   &bmc->guid_attr);
> +}
> +
> +static void
> +cleanup_bmc_device(struct kref *ref)
> +{
> +	struct bmc_device *bmc;
> +
> +	bmc = container_of(ref, struct bmc_device, refcount);
> +
> +	remove_files(bmc);
>  	platform_device_unregister(bmc->dev);
>  	kfree(bmc);
>  }
> @@ -1977,6 +1983,79 @@ static void ipmi_bmc_unregister(ipmi_smi
>  	mutex_unlock(&ipmidriver_mutex);
>  }
>  
> +static int create_files(struct bmc_device *bmc)
> +{
> +	int err;
> +
> +	err = device_create_file(&bmc->dev->dev,
> +			   &bmc->device_id_attr);
> +	if (err) goto out;
> +	err = device_create_file(&bmc->dev->dev,
> +			   &bmc->provides_dev_sdrs_attr);
> +	if (err) goto out_devid;
> +	err = device_create_file(&bmc->dev->dev,
> +			   &bmc->revision_attr);
> +	if (err) goto out_sdrs;
> +	err = device_create_file(&bmc->dev->dev,
> +			   &bmc->firmware_rev_attr);
> +	if (err) goto out_rev;
> +	err = device_create_file(&bmc->dev->dev,
> +			   &bmc->version_attr);
> +	if (err) goto out_firm;
> +	err = device_create_file(&bmc->dev->dev,
> +			   &bmc->add_dev_support_attr);
> +	if (err) goto out_version;
> +	err = device_create_file(&bmc->dev->dev,
> +			   &bmc->manufacturer_id_attr);
> +	if (err) goto out_add_dev;
> +	err = device_create_file(&bmc->dev->dev,
> +			   &bmc->product_id_attr);
> +	if (err) goto out_manu;
> +	if (bmc->id.aux_firmware_revision_set) {
> +		err = device_create_file(&bmc->dev->dev,
> +				   &bmc->aux_firmware_rev_attr);
> +		if (err) goto out_prod_id;
> +	}
> +	if (bmc->guid_set) {
> +		err = device_create_file(&bmc->dev->dev,
> +				   &bmc->guid_attr);
> +		if (err) goto out_aux_firm;
> +	}
> +
> +	return 0;
> +
> +out_aux_firm:
> +	if (bmc->id.aux_firmware_revision_set)
> +		device_remove_file(&bmc->dev->dev,
> +				   &bmc->aux_firmware_rev_attr);
> +out_prod_id:
> +	device_remove_file(&bmc->dev->dev,
> +			   &bmc->product_id_attr);
> +out_manu:
> +	device_remove_file(&bmc->dev->dev,
> +			   &bmc->manufacturer_id_attr);
> +out_add_dev:
> +	device_remove_file(&bmc->dev->dev,
> +			   &bmc->add_dev_support_attr);
> +out_version:
> +	device_remove_file(&bmc->dev->dev,
> +			   &bmc->version_attr);
> +out_firm:
> +	device_remove_file(&bmc->dev->dev,
> +			   &bmc->firmware_rev_attr);
> +out_rev:
> +	device_remove_file(&bmc->dev->dev,
> +			   &bmc->revision_attr);
> +out_sdrs:
> +	device_remove_file(&bmc->dev->dev,
> +			   &bmc->provides_dev_sdrs_attr);
> +out_devid:
> +	device_remove_file(&bmc->dev->dev,
> +			   &bmc->device_id_attr);
> +out:
> +	return err;
> +}
> +
>  static int ipmi_bmc_register(ipmi_smi_t intf)
>  {
>  	int               rv;
> @@ -2051,7 +2130,6 @@ static int ipmi_bmc_register(ipmi_smi_t 
>  		bmc->provides_dev_sdrs_attr.attr.mode = S_IRUGO;
>  		bmc->provides_dev_sdrs_attr.show = provides_dev_sdrs_show;
>  
> -
>  		bmc->revision_attr.attr.name = "revision";
>  		bmc->revision_attr.attr.owner = THIS_MODULE;
>  		bmc->revision_attr.attr.mode = S_IRUGO;
> @@ -2093,28 +2171,14 @@ static int ipmi_bmc_register(ipmi_smi_t 
>  		bmc->aux_firmware_rev_attr.attr.mode = S_IRUGO;
>  		bmc->aux_firmware_rev_attr.show = aux_firmware_rev_show;
>  
> -		device_create_file(&bmc->dev->dev,
> -				   &bmc->device_id_attr);
> -		device_create_file(&bmc->dev->dev,
> -				   &bmc->provides_dev_sdrs_attr);
> -		device_create_file(&bmc->dev->dev,
> -				   &bmc->revision_attr);
> -		device_create_file(&bmc->dev->dev,
> -				   &bmc->firmware_rev_attr);
> -		device_create_file(&bmc->dev->dev,
> -				   &bmc->version_attr);
> -		device_create_file(&bmc->dev->dev,
> -				   &bmc->add_dev_support_attr);
> -		device_create_file(&bmc->dev->dev,
> -				   &bmc->manufacturer_id_attr);
> -		device_create_file(&bmc->dev->dev,
> -				   &bmc->product_id_attr);
> -		if (bmc->id.aux_firmware_revision_set)
> -			device_create_file(&bmc->dev->dev,
> -					   &bmc->aux_firmware_rev_attr);
> -		if (bmc->guid_set)
> -			device_create_file(&bmc->dev->dev,
> -					   &bmc->guid_attr);
> +		rv = create_files(bmc);
> +		if (rv) {
> +			mutex_lock(&ipmidriver_mutex);
> +			platform_device_unregister(bmc->dev);
> +			mutex_unlock(&ipmidriver_mutex);
> +
> +			return rv;
> +		}
>  
>  		printk(KERN_INFO
>  		       "ipmi: Found new BMC (man_id: 0x%6.6x, "
>   

