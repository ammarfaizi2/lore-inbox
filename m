Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262783AbVCJTb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbVCJTb0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 14:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbVCJT1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 14:27:30 -0500
Received: from fire.osdl.org ([65.172.181.4]:3744 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262769AbVCJTW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 14:22:58 -0500
Message-ID: <42309D8F.4080904@osdl.org>
Date: Thu, 10 Mar 2005 11:18:39 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: linux-kernel@vger.kernel.org, Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [9/many] acrypto: crypto_lb.c
References: <1110227854957@2ka.mipt.ru>
In-Reply-To: <1110227854957@2ka.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> --- /tmp/empty/crypto_lb.c	1970-01-01 03:00:00.000000000 +0300
> +++ ./acrypto/crypto_lb.c	2005-03-07 20:35:36.000000000 +0300
> @@ -0,0 +1,634 @@
> +/*
> + * 	crypto_lb.c
> + *
> + * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> + */
> +
> +
> +static LIST_HEAD(crypto_lb_list);
> +static spinlock_t crypto_lb_lock = SPIN_LOCK_UNLOCKED;

use DEFINE_SPINLOCK()

> +static int lb_num = 0;

statics don't need init to 0.

> +static int lb_is_current(struct crypto_lb *l)
> +{
> +	return (l->crypto_device_list != NULL && l->crypto_device_lock != NULL);
> +}
> +
> +static int lb_is_default(struct crypto_lb *l)
> +{
> +	return (l == default_lb);
> +}

Is there a (or several) good reason(s) why several of these short
functions are not inline?
(unless some struct.fields need to point to them, of course)

> +static void __lb_set_default(struct crypto_lb *l)
> +{
> +	default_lb = l;
> +}
> +
> +static int crypto_lb_match(struct device *dev, struct device_driver *drv)
> +{
> +	return 1;
> +}
> +
> +static int crypto_lb_probe(struct device *dev)
> +{
> +	return -ENODEV;
> +}
> +
> +static int crypto_lb_remove(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static void crypto_lb_release(struct device *dev)
> +{
> +	struct crypto_lb *d = container_of(dev, struct crypto_lb, device);
> +
> +	complete(&d->dev_released);
> +}
> +
> +static void crypto_lb_class_release(struct class *class)
> +{
> +}
> +
> +static void crypto_lb_class_release_device(struct class_device *class_dev)
> +{
> +}

> +static ssize_t current_show(struct class_device *dev, char *buf)
> +{
> +	struct crypto_lb *lb;
> +	int off = 0;
> +
> +	spin_lock_irq(&crypto_lb_lock);
> +
> +	list_for_each_entry(lb, &crypto_lb_list, lb_entry) {
> +		if (lb_is_current(lb))
> +			off += sprintf(buf + off, "[");
> +		if (lb_is_default(lb))
> +			off += sprintf(buf + off, "(");
> +		off += sprintf(buf + off, "%s", lb->name);
> +		if (lb_is_default(lb))
> +			off += sprintf(buf + off, ")");
> +		if (lb_is_current(lb))
> +			off += sprintf(buf + off, "]");
> +	}
> +
> +	spin_unlock_irq(&crypto_lb_lock);
> +
> +	if (!off)
> +		off = sprintf(buf, "No load balancers regitered yet.");
                                                      registered
> +
> +	off += sprintf(buf + off, "\n");
> +
> +	return off;
> +}

> +struct crypto_device *crypto_lb_find_device(struct crypto_session_initializer *ci, struct crypto_data *data)
> +{
> +	struct crypto_device *dev;
> +
> +	if (!current_lb)
> +		return NULL;
> +
> +	if (sci_binded(ci)) {
> +		int found = 0;
> +
> +		spin_lock_irq(crypto_device_lock);
> +
> +		list_for_each_entry(dev, crypto_device_list, cdev_entry) {
> +			if (dev->id == ci->bdev) {
> +				found = 1;
> +				break;
> +			}
> +		}
> +
> +		spin_unlock_irq(crypto_device_lock);
> +
> +		return (found) ? dev : NULL;
Don't need those parens.


-- 
~Randy
