Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266498AbUJEXDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUJEXDy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 19:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266519AbUJEXDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 19:03:54 -0400
Received: from mail.dif.dk ([193.138.115.101]:28380 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266498AbUJEXDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 19:03:38 -0400
Date: Wed, 6 Oct 2004 01:11:01 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, markus.lidel@shadowconnect.com,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] add missing checks of __copy_to_user return value in
 i2o_config.c
In-Reply-To: <20041005154351.4776d3c4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0410060050310.2913@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0410052317350.2913@dragon.hygekrogen.localhost>
 <20041005152126.6de415dc.akpm@osdl.org> <Pine.LNX.4.61.0410060025370.2913@dragon.hygekrogen.localhost>
 <20041005154351.4776d3c4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2004, Andrew Morton wrote:

> Jesper Juhl <juhl-lkml@dif.dk> wrote:
> >
> > -	__copy_to_user(kxfer.buf, buffer.virt, fragsize);
> > +	if (__copy_to_user(kxfer.buf, buffer.virt, fragsize)) {
> > +		i2o_dma_free(&c->pdev->dev, &buffer);
> > +		return -EFAULT;
> > +	}
> > +
> >  	i2o_dma_free(&c->pdev->dev, &buffer);
> 
> Please try to avoid more than a single return statement per function.
> 
Will do. But this function already had a ton of return statements so I 
assumed one more wouldn't make any real difference - I'll be sure to give 
that more thought in the future.

> Also, please try to avoid duplicating code such as the above - it's a
> maintainance problem is nothing else.
> 
> Like this:
> 
> -       __copy_to_user(kxfer.buf, buffer.virt, fragsize);
> +       ret = 0;
> +       if (__copy_to_user(kxfer.buf, buffer.virt, fragsize))
> +               ret = -EFAULT;
>         i2o_dma_free(&c->pdev->dev, &buffer);
> -
> -       return 0;
> +       return ret;
>  };

Yes, that's what I had in mind when I noted a prettier version could be 
made with a retval variable, the goto's I hinted at where intended to get 
rid of the many return statements and create a single exit point for the 
function. Your point about maintainability is noted.

How about just doing it all as in this patch below ?
I considered adding

return_nomem:
	ret = -ENOMEM;
	goto return_ret;

etc at the bottom as well, for the other return statements to use, but 
that would be a lot of labels and gotos at the end, seems cleaner not to - 
comments?

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.9-rc3-bk5-orig/drivers/message/i2o/i2o_config.c linux-2.6.9-rc3-bk5/drivers/message/i2o/i2o_config.c
--- linux-2.6.9-rc3-bk5-orig/drivers/message/i2o/i2o_config.c	2004-09-30 05:05:40.000000000 +0200
+++ linux-2.6.9-rc3-bk5/drivers/message/i2o/i2o_config.c	2004-10-06 01:05:04.000000000 +0200
@@ -187,7 +187,8 @@ static int i2o_cfg_getiops(unsigned long
 	list_for_each_entry(c, &i2o_controllers, list)
 	    tmp[c->unit] = 1;
 
-	__copy_to_user(user_iop_table, tmp, MAX_I2O_CONTROLLERS);
+	if (__copy_to_user(user_iop_table, tmp, MAX_I2O_CONTROLLERS))
+		return -EFAULT;
 
 	return 0;
 };
@@ -416,24 +417,25 @@ static int i2o_cfg_swul(unsigned long ar
 	u32 m;
 	unsigned int status = 0, swlen = 0, fragsize = 8192;
 	struct i2o_controller *c;
+	int ret = 0;
 
 	if (copy_from_user(&kxfer, pxfer, sizeof(struct i2o_sw_xfer)))
-		return -EFAULT;
+		goto return_fault;
 
 	if (get_user(swlen, kxfer.swlen) < 0)
-		return -EFAULT;
+		goto return_fault;
 
 	if (get_user(maxfrag, kxfer.maxfrag) < 0)
-		return -EFAULT;
+		goto return_fault;
 
 	if (get_user(curfrag, kxfer.curfrag) < 0)
-		return -EFAULT;
+		goto return_fault;
 
 	if (curfrag == maxfrag)
 		fragsize = swlen - (maxfrag - 1) * 8192;
 
 	if (!kxfer.buf || !access_ok(VERIFY_WRITE, kxfer.buf, fragsize))
-		return -EFAULT;
+		goto return_fault;
 
 	c = i2o_find_iop(kxfer.iop);
 	if (!c)
@@ -474,10 +476,16 @@ static int i2o_cfg_swul(unsigned long ar
 		return status;
 	}
 
-	__copy_to_user(kxfer.buf, buffer.virt, fragsize);
+	if (__copy_to_user(kxfer.buf, buffer.virt, fragsize))
+		ret = -EFAULT;
+
 	i2o_dma_free(&c->pdev->dev, &buffer);
 
-	return 0;
+return_ret:
+	return ret;
+return_fault:
+	ret = -EFAULT;
+	goto return_ret;
 };
 
 static int i2o_cfg_swdel(unsigned long arg)


