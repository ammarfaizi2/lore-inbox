Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbVHOVyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbVHOVyu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 17:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbVHOVyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 17:54:50 -0400
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:62213 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S964998AbVHOVyt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 17:54:49 -0400
Date: Mon, 15 Aug 2005 23:55:31 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Nathan Lutchansky <lutchann@litech.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/5] call i2c_probe from i2c core
Message-Id: <20050815235531.2a7d2bb6.khali@linux-fr.org>
In-Reply-To: <20050815175257.GB24959@litech.org>
References: <20050815175106.GA24959@litech.org>
	<20050815175257.GB24959@litech.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

> Index: linux-2.6.13-rc6+gregkh/include/linux/i2c.h
> ===================================================================

You should probably be using the --no-index option of quilt 0.42 (if you
are using quilt as I presumed), as I heard Linus doesn't like these
index lines in the patches he receives.

> --- linux-2.6.13-rc6+gregkh.orig/drivers/i2c/i2c-core.c
> +++ linux-2.6.13-rc6+gregkh/drivers/i2c/i2c-core.c
> @@ -193,9 +193,16 @@ int i2c_add_adapter(struct i2c_adapter *
>  	/* inform drivers of new adapters */
>  	list_for_each(item,&drivers) {
>  		driver = list_entry(item, struct i2c_driver, list);
> -		if (driver->flags & I2C_DF_NOTIFY)
> -			/* We ignore the return code; if it fails, too bad */
> -			driver->attach_adapter(adap);
> +		if (driver->flags & I2C_DF_NOTIFY) {
> +			/* We ignore the return codes; if it fails, too bad */
> +			if (driver->attach_adapter)
> +				driver->attach_adapter(adap);
> +			if (driver->detect_client && driver->address_data &&
> +					((driver->class & adap->class) ||
> +						driver->class == 0))
> +				i2c_probe(adap, driver->address_data,
> +						driver->detect_client);
> +		}
>  	}
>  
>  out_unlock:
> @@ -307,7 +314,13 @@ int i2c_add_driver(struct i2c_driver *dr
>  	if (driver->flags & I2C_DF_NOTIFY) {
>  		list_for_each(item,&adapters) {
>  			adapter = list_entry(item, struct i2c_adapter, list);
> -			driver->attach_adapter(adapter);
> +			if (driver->attach_adapter)
> +				driver->attach_adapter(adapter);
> +			if (driver->detect_client && driver->address_data &&
> +					((driver->class & adapter->class) ||
> +						driver->class == 0))
> +				i2c_probe(adapter, driver->address_data,
> +						driver->detect_client);
>  		}
>  	}

Couldn't we check for the return value of driver->attach_adapter()? That
way this function could conditionally prevent i2c_probe() from being
run. This is just a random proposal, I don't know if some drivers would
have an interest in doing that.

Also, maybe we can put this new code in a separate function to be called
from both i2c_add_adapter and i2c_add_driver, so as to not duplicate
code? Or would this be too much overhead? It could be made inline then.
Again, just a random thought.

> --- linux-2.6.13-rc6+gregkh.orig/Documentation/i2c/writing-clients
> +++ linux-2.6.13-rc6+gregkh/Documentation/i2c/writing-clients

Thanks for the documentation update. However, you didn't update
i2c/porting-clients accordingly. Could you please?

Thanks,
-- 
Jean Delvare
