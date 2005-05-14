Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVENVSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVENVSr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 17:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVENVSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 17:18:46 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62736 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261494AbVENVSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 17:18:43 -0400
Date: Sat, 14 May 2005 22:18:38 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Yani Ioannou <yani.ioannou@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc4 1/12] (dynamic sysfs callbacks) update device attribute callbacks
Message-ID: <20050514221838.A15061@flint.arm.linux.org.uk>
Mail-Followup-To: Yani Ioannou <yani.ioannou@gmail.com>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <2538186705051402237a79225@mail.gmail.com> <20050514112242.A24975@flint.arm.linux.org.uk> <2538186705051412462d6db2d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <2538186705051412462d6db2d2@mail.gmail.com>; from yani.ioannou@gmail.com on Sat, May 14, 2005 at 03:46:31PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2005 at 03:46:31PM -0400, Yani Ioannou wrote:
> My first post to LKML on the patch:
> http://lkml.org/lkml/2005/5/7/60
> 
> The idea originated in the lm_sensors mailing list, so you might want
> to take a look at the lm_sensors archive is you are interested, in
> particular the following thread:
> ...
> 
> This isn't changing, although there are cases where it is
> necessary/preferable to dynamically create the attributes (again see
> previous discussion). This patch helps both static and dynamically
> created attributes. The adm1026 example I posted to the mailing list
> earlier uses entirely static attributes still (and hence the need for
> the new macros my latest patch adds), and I expect most attributes
> will remain static.

Ok.  I do wonder if the better solution would be to encapsulate
"device_attribute" where this extra information is required, and
pass a pointer to device_attribute to its methods, in much the
same way as "sysfs_ops" works.

This means your attributes in adm1016 become:

struct adm1016_attr {
	struct device_attribute	dev_attr;
	int			nr;
};

#define ADM1016_ATTR(_name,_mode,_show,_store,_nr)		\
	struct adm1016_attr adm_attr_##_name = {		\
		.dev_attr = __ATTR(_name,_mode,_show,_store),	\
		.nr = _nr,					\
	}

static ssize_t show_temp_max(struct device *dev, struct device_attribute *attr, char *buf)
{
	struct adm1016_attr *adm_attr = to_adm_attr(attr);
	struct adm1026_data *data = adm1026_update_device(dev);
	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_max[adm_attr->nr]));
}

#define temp_reg(offset)					\
...
static ADM1016_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR,	\
	show_temp_max, set_temp_max, offset)

There are two advantages to this way:

1. you're not having to impose the extra void * pointer in the
   attribute on everyone.
2. you allow people to add whatever data they please to the attribute
   in whatever format they wish - whether it be a void pointer, integer,
   or whatever.

This seems far more flexible to me, at least.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
