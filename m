Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266193AbUJEW1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUJEW1I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 18:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUJEW1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 18:27:07 -0400
Received: from mail.dif.dk ([193.138.115.101]:20954 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266193AbUJEW07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 18:26:59 -0400
Date: Wed, 6 Oct 2004 00:34:25 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, markus.lidel@shadowconnect.com,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] add missing checks of __copy_to_user return value in
 i2o_config.c
In-Reply-To: <20041005152126.6de415dc.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0410060025370.2913@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0410052317350.2913@dragon.hygekrogen.localhost>
 <20041005152126.6de415dc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2004, Andrew Morton wrote:

> Jesper Juhl <juhl-lkml@dif.dk> wrote:
> >
> > -	__copy_to_user(kxfer.buf, buffer.virt, fragsize);
> > +	if (__copy_to_user(kxfer.buf, buffer.virt, fragsize))
> > +		return -EFAULT;
> > +
> >  	i2o_dma_free(&c->pdev->dev, &buffer);
> >  
> 
> Obvious leak.
> 
Whoops, so sorry about that, I must be sleeping. Thank you for your 
vigilance :)

Here's a better patch.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.9-rc3-bk5-orig/drivers/message/i2o/i2o_config.c linux-2.6.9-rc3-bk5/drivers/message/i2o/i2o_config.c
--- linux-2.6.9-rc3-bk5-orig/drivers/message/i2o/i2o_config.c	2004-09-30 05:05:40.000000000 +0200
+++ linux-2.6.9-rc3-bk5/drivers/message/i2o/i2o_config.c	2004-10-06 00:29:30.000000000 +0200
@@ -187,7 +187,8 @@ static int i2o_cfg_getiops(unsigned long
 	list_for_each_entry(c, &i2o_controllers, list)
 	    tmp[c->unit] = 1;
 
-	__copy_to_user(user_iop_table, tmp, MAX_I2O_CONTROLLERS);
+	if (__copy_to_user(user_iop_table, tmp, MAX_I2O_CONTROLLERS))
+		return -EFAULT;
 
 	return 0;
 };
@@ -474,7 +475,11 @@ static int i2o_cfg_swul(unsigned long ar
 		return status;
 	}
 
-	__copy_to_user(kxfer.buf, buffer.virt, fragsize);
+	if (__copy_to_user(kxfer.buf, buffer.virt, fragsize)) {
+		i2o_dma_free(&c->pdev->dev, &buffer);
+		return -EFAULT;
+	}
+
 	i2o_dma_free(&c->pdev->dev, &buffer);
 
 	return 0;



Could probably be done a little nicer for the entire function with a 
"retval" variable and some goto's here and there, but I opted for the 
simple solution.


