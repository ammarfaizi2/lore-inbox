Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751589AbWHRX1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbWHRX1v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 19:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbWHRX1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 19:27:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62187 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751290AbWHRX1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 19:27:51 -0400
Date: Fri, 18 Aug 2006 16:27:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-kernel@vger.kernel.org, "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [PATCH][CHAR] Return better error codes if drivers/char/raw.c
 module init fails
Message-Id: <20060818162743.f97ff431.akpm@osdl.org>
In-Reply-To: <200608180918.30483.eike-kernel@sf-tec.de>
References: <200608180918.30483.eike-kernel@sf-tec.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2006 09:18:30 +0200
Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:

> Currently this module just returns 1 if anything on module init fails. Store
> the error code of the different function calls and return their error on
> problems.
> 
> I'm not sure if this doesn't need even more cleanup, for example kobj_put() 
> is called only in one error case.
> 

You seem to be using kmail in funky-confuse-sylpheed mode.  Inlined patches
in plain-text emails are preferred, please.  

> 
> diff --git a/drivers/char/raw.c b/drivers/char/raw.c
> index 579868a..5938e6b 100644
> --- a/drivers/char/raw.c
> +++ b/drivers/char/raw.c
> @@ -288,31 +288,35 @@ static struct cdev raw_cdev = {
>  static int __init raw_init(void)
>  {
>  	dev_t dev = MKDEV(RAW_MAJOR, 0);
> +	int ret;
>  
> -	if (register_chrdev_region(dev, MAX_RAW_MINORS, "raw"))
> +	ret = register_chrdev_region(dev, MAX_RAW_MINORS, "raw");
> +	if (ret)
>  		goto error;
>  
>  	cdev_init(&raw_cdev, &raw_fops);
> -	if (cdev_add(&raw_cdev, dev, MAX_RAW_MINORS)) {
> +	ret = cdev_add(&raw_cdev, dev, MAX_RAW_MINORS); 
> +	if (ret) {
> +		printk(KERN_ERR "error register raw device\n");
>  		kobject_put(&raw_cdev.kobj);
> -		unregister_chrdev_region(dev, MAX_RAW_MINORS);
> -		goto error;
> +		goto error_region;
>  	}
>  
>  	raw_class = class_create(THIS_MODULE, "raw");
>  	if (IS_ERR(raw_class)) {
>  		printk(KERN_ERR "Error creating raw class.\n");
>  		cdev_del(&raw_cdev);
> -		unregister_chrdev_region(dev, MAX_RAW_MINORS);
> -		goto error;
> +		ret = PTR_ERR(raw_class);
> +		goto error_region;
>  	}
>  	class_device_create(raw_class, NULL, MKDEV(RAW_MAJOR, 0), NULL, "rawctl");
>  
>  	return 0;
>  
> +error_region:
> +	unregister_chrdev_region(dev, MAX_RAW_MINORS);
>  error:
> -	printk(KERN_ERR "error register raw device\n");
> -	return 1;
> +	return ret;
>  }

No, it's not obvious what that stray kobject_put() is doing in there.

<hunt, hunt>

http://kernel.org/git/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git;a=commitdiff;h=b8ff72d28c349bdb7ff5246e83aba384f45d8078


