Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266263AbUJEWmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266263AbUJEWmh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 18:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266250AbUJEWmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 18:42:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:19606 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266271AbUJEWkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 18:40:10 -0400
Date: Tue, 5 Oct 2004 15:43:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, markus.lidel@shadowconnect.com,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] add missing checks of __copy_to_user return value in
 i2o_config.c
Message-Id: <20041005154351.4776d3c4.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0410060025370.2913@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0410052317350.2913@dragon.hygekrogen.localhost>
	<20041005152126.6de415dc.akpm@osdl.org>
	<Pine.LNX.4.61.0410060025370.2913@dragon.hygekrogen.localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:
>
> -	__copy_to_user(kxfer.buf, buffer.virt, fragsize);
> +	if (__copy_to_user(kxfer.buf, buffer.virt, fragsize)) {
> +		i2o_dma_free(&c->pdev->dev, &buffer);
> +		return -EFAULT;
> +	}
> +
>  	i2o_dma_free(&c->pdev->dev, &buffer);

Please try to avoid more than a single return statement per function.

Also, please try to avoid duplicating code such as the above - it's a
maintainance problem is nothing else.

Like this:

--- 25/drivers/message/i2o/i2o_config.c~add-missing-checks-of-__copy_to_user-return-value-in	Tue Oct  5 15:41:04 2004
+++ 25-akpm/drivers/message/i2o/i2o_config.c	Tue Oct  5 15:42:17 2004
@@ -187,7 +187,8 @@ static int i2o_cfg_getiops(unsigned long
 	list_for_each_entry(c, &i2o_controllers, list)
 	    tmp[c->unit] = 1;
 
-	__copy_to_user(user_iop_table, tmp, MAX_I2O_CONTROLLERS);
+	if (__copy_to_user(user_iop_table, tmp, MAX_I2O_CONTROLLERS))
+		return -EFAULT;
 
 	return 0;
 };
@@ -416,6 +417,7 @@ static int i2o_cfg_swul(unsigned long ar
 	u32 m;
 	unsigned int status = 0, swlen = 0, fragsize = 8192;
 	struct i2o_controller *c;
+	int ret;
 
 	if (copy_from_user(&kxfer, pxfer, sizeof(struct i2o_sw_xfer)))
 		return -EFAULT;
@@ -474,10 +476,11 @@ static int i2o_cfg_swul(unsigned long ar
 		return status;
 	}
 
-	__copy_to_user(kxfer.buf, buffer.virt, fragsize);
+	ret = 0;
+	if (__copy_to_user(kxfer.buf, buffer.virt, fragsize))
+		ret = -EFAULT;
 	i2o_dma_free(&c->pdev->dev, &buffer);
-
-	return 0;
+	return ret;
 };
 
 static int i2o_cfg_swdel(unsigned long arg)
_

