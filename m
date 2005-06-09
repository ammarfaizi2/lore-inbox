Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVFIH6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVFIH6Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 03:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbVFIH6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 03:58:24 -0400
Received: from zone4.gcu-squad.org ([213.91.10.50]:19435 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S261288AbVFIH6Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 03:58:16 -0400
Date: Thu, 9 Jun 2005 09:47:23 +0200 (CEST)
To: akpm@osdl.org,
       ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com
Subject: Re: BUG in i2c_detach_client
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <JctXv2LZ.1118303243.5186830.khali@localhost>
In-Reply-To: <20050608142631.7e956792.akpm@osdl.org>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: linux-kernel@vger.kernel.org, "Greg KH" <greg@kroah.com>,
       "Mark M. Hoffman" <mhoffman@lightlink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew, Andrew, all,

[Adding Mark M. Hoffman in the loop, as the author and recent modifier of
the asb100 driver.]

> From: Andrew Morton <akpm@osdl.org>
>
> Fix error backing-out code in asb100.c
>
> Cc: Greg KH <greg@kroah.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> (...)
> --- 25/drivers/i2c/chips/asb100.c~asb100-fix
> +++ 25-akpm/drivers/i2c/chips/asb100.c
> @@ -690,18 +690,20 @@ static int asb100_detect_subclients(stru
>  	if ((err = i2c_attach_client(data->lm75[0]))) {
>  		dev_err(&new_client->dev, "subclient %d registration "
>  			"at address 0x%x failed.\n", i, data->lm75[0]->addr);
> -		goto ERROR_SC_2;
> +		goto ERROR_SC_3;
>  	}
> 
>  	if ((err = i2c_attach_client(data->lm75[1]))) {
>  		dev_err(&new_client->dev, "subclient %d registration "
>  			"at address 0x%x failed.\n", i, data->lm75[1]->addr);
> -		goto ERROR_SC_3;
> +		goto ERROR_SC_4;
>  	}
> 
>  	return 0;
>
>  /* Undo inits in case of errors */
> +ERROR_SC_4:
> +	i2c_detach_client(data->lm75[1]);
>  ERROR_SC_3:
>  	i2c_detach_client(data->lm75[0]);
>  ERROR_SC_2:

This patch looks broken to me, please discard it. You do not want to call
i2c_detach_client when the corresponding i2c_attach_client failed. The
original code was fine in that respect. I don't think there is any
problem in the asb100_detect_subclients() function.

I do however think that there is a problem in the asb100_detect()
function, where a call to i2c_detach client() is missing:

ERROR3:
	i2c_detach_client(data->lm75[1]); <-- HERE
	i2c_detach_client(data->lm75[0]);
	kfree(data->lm75[1]);
	kfree(data->lm75[0]);

If we take that error path, it means that both subclients have been
successfully attached, thus need proper detach.

The reason why the bug triggered on Andrew (James Wade) is probably that
hwmon_device_register() failed, due to an order problem in a Makefile.
See http://lkml.org/lkml/2005/6/8/338, which has an explanation and a
patch fixing it (I think).

This still doesn't explain why the error path triggers the BUG(), and
although applying the aforementioned patch will probably get the driver
working, I'd really like to understand what's going on there.

Thanks,
--
Jean Delvare
