Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbVLTVNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbVLTVNq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 16:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbVLTVNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 16:13:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:12674 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932113AbVLTVNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 16:13:45 -0500
Date: Tue, 20 Dec 2005 21:13:45 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/6] RTC subsystem, class
Message-ID: <20051220211344.GA14403@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	linux-kernel@vger.kernel.org
References: <20051220214511.12bbb69c@inspiron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051220214511.12bbb69c@inspiron>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 09:45:11PM +0100, Alessandro Zummo wrote:
> This patch adds the basic RTC subsytem infrastructure
> to the kernel.

Whee, very cool.  We've needed something like that for a long time.

> rtc/class.c - registration facilities for RTC drivers
> rtc/intf.c - kernel/rtc interface functions 
> rtc/utils.c - misc rtc-related utility functions
> 
> Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
> --
>  drivers/Kconfig      |    2 
>  drivers/Makefile     |    2 
>  drivers/rtc/Kconfig  |   25 +++++++++++
>  drivers/rtc/Makefile |    8 +++
>  drivers/rtc/class.c  |  110 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/rtc/intf.c   |   67 +++++++++++++++++++++++++++++++
>  drivers/rtc/utils.c  |   99 +++++++++++++++++++++++++++++++++++++++++++++


Given that the files are really tiny I'd suggest to put everything into
a single file (driver/char/rtc.c) instead of some arbitrary split.

> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-nslu2/drivers/rtc/class.c	2005-12-15 10:22:20.000000000 +0100
> @@ -0,0 +1,110 @@
> +/*
> + * rtc-class.c - rtc subsystem, base class

no need to put the file name into a comment.  it gets out of date far
too easily (it already is in this case ;-))


> +#define RTC_ID_PREFIX "rtc"
> +#define RTC_ID_FORMAT RTC_ID_PREFIX "%d"

Having a format specifier hidden in a macro makes reading code very
difficult, please just remove this.

> +
> +static struct class *rtc_class;
> +
> +static DEFINE_IDR(rtc_idr);
> +
> +/**
> + * rtc_device_register - register w/ hwmon sysfs class
> + * @dev: the device to register
> + *
> + * rtc_device_unregister() must be called when the class device is no
> + * longer needed.
> + *
> + * Returns the pointer to the new struct class device.
> + */
> +struct class_device *rtc_device_register(struct device *dev,
> +					struct rtc_class_ops *ops)
> +{
> +	struct class_device *cdev;
> +	int id;
> +
> +	if (idr_pre_get(&rtc_idr, GFP_KERNEL) == 0)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (idr_get_new(&rtc_idr, NULL, &id) < 0)
> +		return ERR_PTR(-ENOMEM);
> +
> +	id = id & MAX_ID_MASK;
> +	cdev = class_device_create(rtc_class, NULL, MKDEV(0,0), dev,
> +					RTC_ID_FORMAT, id);
> +
> +	if (IS_ERR(cdev))
> +		idr_remove(&rtc_idr, id);
> +	else
> +		dev_info(dev, "rtc core: registered\n");
> +
> +	class_set_devdata(cdev, ops);
> +
> +	return cdev;
> +}

> +void rtc_device_unregister(struct class_device *cdev)
> +{
> +	int id;
> +
> +	if (sscanf(cdev->class_id, RTC_ID_FORMAT, &id) == 1) {
> +		class_device_unregister(cdev);
> +		idr_remove(&rtc_idr, id);
> +	} else
> +		dev_dbg(cdev->dev,
> +			"rtc_device_unregister() failed: bad class ID!\n");
> +}

The scanf looks really fragile.  Can't you just have a rtc_device structure
that the cdev and id are embedded into that can be passed to the
unregistration function?

> +
> +int rtc_interface_register(struct class_interface *intf)
> +{
> +	intf->class = rtc_class;
> +        return class_interface_register(intf);

spaces instead of a tab for indentation here.

> +int rtc_read_time(struct class_device *class_dev, struct rtc_time *tm)
> +{
> +	int err = -EINVAL;
> +	struct rtc_class_ops *ops = class_get_devdata(class_dev);
> +
> +	if (ops->read_time) {
> +		memset(tm, 0, sizeof(struct rtc_time));

do we really need the memset?

> +#
> +# Makefile for RTC class/drivers.
> +#
> +
> +obj-y				+= utils.o

why is this always built?
> +obj-$(CONFIG_RTC_CLASS)		+= rtc-core.o
> +rtc-core-y			:= class.o intf.o
> +rtc-core-objs			:= $(rtc-core-y)

no need for this last line

> +struct rtc_class_ops {

What about just rtc_ops?

> +	int (*proc)(struct device *, char *buf);

this should be seq_file based.

> +static const unsigned char rtc_days_in_month[] = {
> +	31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
> +};
> +EXPORT_SYMBOL(rtc_days_in_month);

exporting static symbols is pretty wrong.  Exporting tables is pretty
bad style aswell.

