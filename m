Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269452AbUJFULr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269452AbUJFULr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 16:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269448AbUJFUJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:09:20 -0400
Received: from mail.dif.dk ([193.138.115.101]:21468 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S269439AbUJFUDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:03:42 -0400
Date: Wed, 6 Oct 2004 22:11:08 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Markus Lidel <markus.lidel@shadowconnect.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] add missing checks of __copy_to_user return value in
 i2o_config.c
In-Reply-To: <20041006114154.A29243@infradead.org>
Message-ID: <Pine.LNX.4.61.0410062159590.2975@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0410052317350.2913@dragon.hygekrogen.localhost>
 <20041006114154.A29243@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Updated patch at the end (fourth edition).


On Wed, 6 Oct 2004, Christoph Hellwig wrote:

> On Tue, Oct 05, 2004 at 11:43:54PM +0200, Jesper Juhl wrote:
> > 
> > diff -up linux-2.6.9-rc3-bk5-orig/drivers/message/i2o/i2o_config.c linux-2.6.9-rc3-bk5/drivers/message/i2o/i2o_config.c
> > --- linux-2.6.9-rc3-bk5-orig/drivers/message/i2o/i2o_config.c	2004-09-30 05:05:40.000000000 +0200
> > +++ linux-2.6.9-rc3-bk5/drivers/message/i2o/i2o_config.c	2004-10-05 23:32:43.000000000 +0200
> > @@ -187,7 +187,8 @@ static int i2o_cfg_getiops(unsigned long
> >  	list_for_each_entry(c, &i2o_controllers, list)
> >  	    tmp[c->unit] = 1;
> >  
> > -	__copy_to_user(user_iop_table, tmp, MAX_I2O_CONTROLLERS);
> > +	if (__copy_to_user(user_iop_table, tmp, MAX_I2O_CONTROLLERS))
> > +		return -EFAULT;
> 
> should be copy_to_user (with return value checked) and the
> access_ok above should be removed.
> 
Makes sense to me. No need to explicitly check when copy_to_user() will do 
so for us.


> >  	return 0;
> >  };
> > @@ -474,7 +475,9 @@ static int i2o_cfg_swul(unsigned long ar
> >  		return status;
> >  	}
> >  
> > -	__copy_to_user(kxfer.buf, buffer.virt, fragsize);
> > +	if (__copy_to_user(kxfer.buf, buffer.virt, fragsize))
> > +		return -EFAULT;
> > +
> >  	i2o_dma_free(&c->pdev->dev, &buffer);
> 
> you're adding a leak here,and again please use copy_to_user and remove
> the access_ok abov

Yeah, I goofed, Andrew already spotted that one and I send him an updated 
patch (it's in this thread). Unfortunately my second patch also left 
something to be desired, so I send off a third (didn't get any comment on 
that one yet). After reading your comments I guess a fourth attempt at 
this is required - how about something like the following ?

It does the following:

- gets rid of access_ok 
- replaces __copy_to_user with copy_to_user that calls access_ok itself
- makes sure copy_to_user return value is checked and acted upon
- gets a bit closer to the goal of having only one exit point pr function
- doesn't leak resources and doesn't duplicate code

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.9-rc3-bk5-orig/drivers/message/i2o/i2o_config.c linux-2.6.9-rc3-bk5/drivers/message/i2o/i2o_config.c
--- linux-2.6.9-rc3-bk5-orig/drivers/message/i2o/i2o_config.c	2004-09-30 05:05:40.000000000 +0200
+++ linux-2.6.9-rc3-bk5/drivers/message/i2o/i2o_config.c	2004-10-06 21:58:01.000000000 +0200
@@ -178,18 +178,17 @@ static int i2o_cfg_getiops(unsigned long
 	struct i2o_controller *c;
 	u8 __user *user_iop_table = (void __user *)arg;
 	u8 tmp[MAX_I2O_CONTROLLERS];
+	int ret = 0;
 
 	memset(tmp, 0, MAX_I2O_CONTROLLERS);
 
-	if (!access_ok(VERIFY_WRITE, user_iop_table, MAX_I2O_CONTROLLERS))
-		return -EFAULT;
-
 	list_for_each_entry(c, &i2o_controllers, list)
 	    tmp[c->unit] = 1;
 
-	__copy_to_user(user_iop_table, tmp, MAX_I2O_CONTROLLERS);
+	if (copy_to_user(user_iop_table, tmp, MAX_I2O_CONTROLLERS))
+		ret = -EFAULT;
 
-	return 0;
+	return ret;
 };
 
 static int i2o_cfg_gethrt(unsigned long arg)
@@ -416,24 +415,25 @@ static int i2o_cfg_swul(unsigned long ar
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
 
-	if (!kxfer.buf || !access_ok(VERIFY_WRITE, kxfer.buf, fragsize))
-		return -EFAULT;
+	if (!kxfer.buf)
+		goto return_fault;
 
 	c = i2o_find_iop(kxfer.iop);
 	if (!c)
@@ -474,10 +474,16 @@ static int i2o_cfg_swul(unsigned long ar
 		return status;
 	}
 
-	__copy_to_user(kxfer.buf, buffer.virt, fragsize);
+	if (copy_to_user(kxfer.buf, buffer.virt, fragsize))
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


