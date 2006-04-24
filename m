Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWDXXqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWDXXqn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 19:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWDXXqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 19:46:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3536 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932119AbWDXXqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 19:46:42 -0400
Date: Mon, 24 Apr 2006 16:49:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, horst.hummel@de.ibm.com
Subject: Re: [patch 13/13] s390: dasd device identifiers.
Message-Id: <20060424164907.7888c685.akpm@osdl.org>
In-Reply-To: <20060424150620.GN15613@skybase>
References: <20060424150620.GN15613@skybase>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>
> @@ -45,6 +45,7 @@ struct dasd_devmap {
>          unsigned int devindex;
>          unsigned short features;
>  	struct dasd_device *device;
> +	struct dasd_uid uid;
>  };

Someone's missing a TAB key.

> +static ssize_t
> +dasd_alias_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct dasd_devmap *devmap;
> +	int alias;
> +
> +	devmap = dasd_find_busid(dev->bus_id);
> +	spin_lock(&dasd_devmap_lock);
> +	if (!IS_ERR(devmap))
> +		alias = devmap->uid.alias;
> +	else
> +		alias = 0;
> +	spin_unlock(&dasd_devmap_lock);
> +
> +	return sprintf(buf, alias ? "1\n" : "0\n");
> +}

The locking is suspicious.  We take a spinlock just for a single read?

> +/*
> + * Return copy of the device unique identifier.
> + */
> +int
> +dasd_get_uid(struct ccw_device *cdev, struct dasd_uid *uid)
> +{
> +	struct dasd_devmap *devmap;
> +
> +	devmap = dasd_find_busid(cdev->dev.bus_id);
> +	if (IS_ERR(devmap))
> +		return PTR_ERR(devmap);
> +	spin_lock(&dasd_devmap_lock);
> +	*uid = devmap->uid;
> +	spin_unlock(&dasd_devmap_lock);
> +	return 0;
> +}

And for a single write?


