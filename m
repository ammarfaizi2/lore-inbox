Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424026AbWKKQMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424026AbWKKQMR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 11:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424272AbWKKQMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 11:12:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:52929 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1424255AbWKKQMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 11:12:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=WPyd5SAHT0dc2uRoM2Z5HTH2mPB1qKkvRoB8huvfl8u3KrB5ysaGShwcvUwoEiJatpllC5GW0GIwDrXHQHpEryH6Inzg3zgWuNWbm46hGBGATMvtPwCwgW4qLXgyMpw3YtcJPvw8m52mPNXEVSz8zYc2DZqR+rjPl3zJMVoqziw=
Date: Sat, 11 Nov 2006 19:12:07 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Akinobu Mita <akinobu.mita@gmail.com>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] input: check whether serio dirver registration is completed
Message-ID: <20061111161207.GA4970@martell.zuzino.mipt.ru>
References: <20061107120605.GA13896@localhost> <d120d5000611070620l5a0731d8jd5778bc8c8b49b2b@mail.gmail.com> <20061108123636.GA14871@localhost> <20061108124010.GD14871@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108124010.GD14871@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 09:40:10PM +0900, Akinobu Mita wrote:
> This patch adds a flag to serio driver indicating whether registration is
> complete and check that flag in serio_unregister_driver.

> --- work-fault-inject.orig/include/linux/serio.h
> +++ work-fault-inject/include/linux/serio.h
> @@ -68,6 +68,7 @@ struct serio_driver {
>  	void (*cleanup)(struct serio *);
>
>  	struct device_driver driver;
> +	int registered;

bitfield please.

> --- work-fault-inject.orig/drivers/input/serio/serio.c
> +++ work-fault-inject/drivers/input/serio/serio.c
> @@ -804,6 +804,8 @@ static void serio_add_driver(struct seri
>  		printk(KERN_ERR
>  			"serio: driver_register() failed for %s, error: %d\n",
>  			drv->driver.name, error);
> +	else
> +		drv->registered = 1;
>  }
>
>  int __serio_register_driver(struct serio_driver *drv, struct module *owne
> @@ -830,7 +832,10 @@ start_over:
>  		}
>  	}
>
> -	driver_unregister(&drv->driver);
> +	if (drv->registered) {
> +		driver_unregister(&drv->driver);
> +		drv->registered = 0;
> +	}

