Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269191AbUJFKmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269191AbUJFKmB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 06:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269192AbUJFKmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 06:42:01 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:5896 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269191AbUJFKl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 06:41:58 -0400
Date: Wed, 6 Oct 2004 11:41:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Markus Lidel <markus.lidel@shadowconnect.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] add missing checks of __copy_to_user return value in i2o_config.c
Message-ID: <20041006114154.A29243@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jesper Juhl <juhl-lkml@dif.dk>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Markus Lidel <markus.lidel@shadowconnect.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.61.0410052317350.2913@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.61.0410052317350.2913@dragon.hygekrogen.localhost>; from juhl-lkml@dif.dk on Tue, Oct 05, 2004 at 11:43:54PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 11:43:54PM +0200, Jesper Juhl wrote:
> 
> This patch fixes up the following :
> 
>   CC      drivers/message/i2o/i2o_config.o
> include/asm/uaccess.h: In function `i2o_cfg_getiops':
> drivers/message/i2o/i2o_config.c:190: warning: ignoring return value of `__copy_to_user', declared with attribute warn_unused_result
> include/asm/uaccess.h: In function `i2o_cfg_swul':
> drivers/message/i2o/i2o_config.c:477: warning: ignoring return value of `__copy_to_user', declared with attribute warn_unused_result
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
> diff -up linux-2.6.9-rc3-bk5-orig/drivers/message/i2o/i2o_config.c linux-2.6.9-rc3-bk5/drivers/message/i2o/i2o_config.c
> --- linux-2.6.9-rc3-bk5-orig/drivers/message/i2o/i2o_config.c	2004-09-30 05:05:40.000000000 +0200
> +++ linux-2.6.9-rc3-bk5/drivers/message/i2o/i2o_config.c	2004-10-05 23:32:43.000000000 +0200
> @@ -187,7 +187,8 @@ static int i2o_cfg_getiops(unsigned long
>  	list_for_each_entry(c, &i2o_controllers, list)
>  	    tmp[c->unit] = 1;
>  
> -	__copy_to_user(user_iop_table, tmp, MAX_I2O_CONTROLLERS);
> +	if (__copy_to_user(user_iop_table, tmp, MAX_I2O_CONTROLLERS))
> +		return -EFAULT;

should be copy_to_user (with return value checked) and the
access_ok above should be removed.

>  	return 0;
>  };
> @@ -474,7 +475,9 @@ static int i2o_cfg_swul(unsigned long ar
>  		return status;
>  	}
>  
> -	__copy_to_user(kxfer.buf, buffer.virt, fragsize);
> +	if (__copy_to_user(kxfer.buf, buffer.virt, fragsize))
> +		return -EFAULT;
> +
>  	i2o_dma_free(&c->pdev->dev, &buffer);

you're adding a leak here,and again please use copy_to_user and remove
the access_ok abov

