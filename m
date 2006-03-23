Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWCWFzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWCWFzF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 00:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWCWFzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 00:55:05 -0500
Received: from mail.kroah.org ([69.55.234.183]:14570 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751121AbWCWFzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 00:55:02 -0500
Date: Wed, 22 Mar 2006 21:49:05 -0800
From: Greg KH <greg@kroah.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, rdreier@cisco.com, openib-general@openib.org
Subject: Re: [PATCH 8 of 18] ipath - sysfs and ipathfs support for core driver
Message-ID: <20060323054905.GB20672@kroah.com>
References: <patchbomb.1143072293@eng-12.pathscale.com> <03375633b9c13068de17.1143072301@eng-12.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03375633b9c13068de17.1143072301@eng-12.pathscale.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 04:05:01PM -0800, Bryan O'Sullivan wrote:
> +int ipath_driver_create_group(struct device_driver *drv)
> +{
> +	int ret;
> +
> +	if (!drv->kobj.dentry) {
> +		ret = -ENODEV;
> +		goto bail;
> +	}
> +
> +	ret = sysfs_create_group(&drv->kobj, &driver_attr_group);
> +	if (ret)
> +		goto bail;
> +
> +	ret = sysfs_create_group(&drv->kobj, &driver_stat_attr_group);
> +	if (ret)
> +		sysfs_remove_group(&drv->kobj, &driver_attr_group);
> +
> +bail:
> +	return ret;
> +}
> +
> +void ipath_driver_remove_group(struct device_driver *drv)
> +{
> +	if (drv->kobj.dentry) {
> +		sysfs_remove_group(&drv->kobj, &driver_stat_attr_group);
> +		sysfs_remove_group(&drv->kobj, &driver_attr_group);
> +	}
> +}

Why are you testing kobj.dentry in these functions?  That test would not
have been valid in the mainline kernel until a day or so ago, so you
couldn't have ever hit that path (dentry being NULL that is.)

Or did you do that because of something odd you saw in sysfs?

Unless you did, I don't think you need these tests.

Oh, and I like your new filesystem, but where do you propose that it be
mounted?

> +int ipath_device_create_group(struct device *dev, struct ipath_devdata *dd)
> +{
> +	int ret;
> +	char unit[5];
> +
> +	ret = sysfs_create_group(&dev->kobj, &dev_attr_group);
> +	if (ret)
> +		goto bail;
> +
> +	ret = sysfs_create_group(&dev->kobj, &dev_counter_attr_group);
> +	if (ret)
> +		goto bail;
> +
> +	snprintf(unit, sizeof(unit), "%02d", dd->ipath_unit);
> +	ret = sysfs_create_link(&dev->driver->kobj, &dev->kobj, unit);
> +bail:
> +	return ret;
> +}

You leak a group if the second call to sysfs_create_group() fails for
some reason.

thanks,

greg k-h
